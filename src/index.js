'use strict';

const url = require('url');
const https = require('https');

const CIRCLECI_API = process.env.CIRCLECI_API;
const CIRCLECI_TOKEN = process.env.CIRCLECI_TOKEN;

module.exports.handler = (event, context, callback) => {
    console.log(event);

    if (event.httpMethod === 'POST' && event.body) {
        const json = JSON.parse(event.body);

        if (json.repository && json.push_data) {
            const username = json.repository.namespace;
            const project = json.repository.name;
            const tag = json.push_data.tag;

            console.log(`${username}/${project}:${tag}`);

            const circleci_url = `${CIRCLECI_API}?circle-token=${CIRCLECI_TOKEN}`;

            const message = {
                build_parameters: {
                    TG_USERNAME: username,
                    TG_PROJECT: project,
                    TG_VERSION: tag,
                }
            }

            const body = JSON.stringify(message);
            const options = url.parse(circleci_url);
            options.method = 'POST';
            options.headers = {
                'Content-Type': 'application/json',
                'Content-Length': Buffer.byteLength(body),
            };

            const req = https.request(options, (res) => {
                const chunks = [];
                res.setEncoding('utf8');
                res.on('data', (chunk) => chunks.push(chunk));
                res.on('end', () => {
                    if (callback) {
                        console.log(`${res.statusCode} ${res.statusMessage}`);
                        callback({
                            body: chunks.join(''),
                            statusCode: res.statusCode,
                            statusMessage: res.statusMessage,
                        });
                    }
                });
                return res;
            });
            req.write(body);
            req.end();
        }
    }

    const res = {
        statusCode: 200,
        headers: {
            'Access-Control-Allow-Origin': '*', // Required for CORS support to work
        },
        body: {
            state: 'success',
        }
    };
    callback(null, res);
};
