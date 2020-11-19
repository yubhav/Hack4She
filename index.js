const express = require("express");
const bodyParser = require("body-parser");
app = express();
app.use(bodyParser.json());

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Server started at port ${port}`));