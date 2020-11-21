fetch("/lala")
            .then(response => response.json())
            .then(json => {
                // console.log("json",json.maindata)

                let data = json.maindata
                let li = `<tr><th>Name</th><th>Click To Help</th></tr>`;
                // let li = `<tr><th>Name</th><th>Click To Help</th><th>Map</th></tr>`;

                for(i=0;i<1;i++){
                    for(j=0;j<3;j++){
                        source = "https://www.google.com/maps?saddr=My+Location&daddr="+data[i+1][j]+","+data[i+2][j]
                        li +=   `<tr> 
                                    <td>${data[i][j]} </td> 
                                    <td><a href=${source}>Help Her</a></td>
                                </tr>`; 
                        // li +=   `<tr> 
                        //         <td>${data[i][j]} </td> 
                        //         <td><a href=${source}>Help Her</a></td>
                        //         <td><a href=${source}>Help Her</a></td>
                        //     </tr>`; 
                                
                    }
                }

                document.getElementById("people").innerHTML = li; 
            });