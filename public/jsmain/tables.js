
async function runthat(){
    const response1 = await fetch("/lalaloc");
    var json1 = await response1.json();

    const response2 = await fetch("/lalaname");
    var json2 = await response2.json();

    let loc = await json1.loc
    let name = await json2.name

    let li = await `<tr><th>Name</th><th>Click To Help</th><th>Map</th></tr>`;

    source = await "https://www.google.com/maps?saddr=My+Location&daddr="+loc.Latitude+","+loc.Longitude

    source2 = await "https://maps.google.com/maps?q="+loc.Latitude+"%2C"+loc.Longitude+"&t=&z=7&ie=UTF8&iwloc=&output=embed"

    li +=  await `<tr> 
                <td>${name} </td> 
                <td><a href=${source}>Help Her</a></td>
                <td><div class="mapouter"><div class="gmap_canvas"><iframe width="200" height="200" id="gmap_canvas" src=${source2} frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe><a href="https://yggtorrent-fr.com">hides</a></div><style>.mapouter{position:relative;text-align:right;height:200px;width:200px;}.gmap_canvas {overflow:hidden;background:none!important;height:200px;width:200px;}</style></div></td>
            </tr>`; 


            document.getElementById("people").innerHTML = li; 

    }

    runthat();