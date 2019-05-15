'use strict';

module.exports.handler = (event, context, callback) => {
    console.log(event);

    if (event.httpMethod === 'POST' && event.body) {
        var body = JSON.parse(event.body);

        if (body.repository && body.push_data) {
            var namespace = body.repository.namespace;
            var name = body.repository.name;
            var tag = body.push_data.tag;

            console.log('namespace : ' + namespace);
            console.log('name : ' + name);
            console.log('tag : ' + tag);
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
