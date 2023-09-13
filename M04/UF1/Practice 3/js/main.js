//Image and index dictionary
dicImages = {1: "https://cdn.domestika.org/c_limit,dpr_auto,f_auto,q_auto,w_820/v1566929491/content-items/003/224/112/Boss_Frog-original.png?1566929491",
             2: "https://crehana-blog.imgix.net/media/filer_public/f5/0c/f50c0560-9506-4e79-9fdc-981eb287b8e1/ejemplo-low-poly_1.jpg?auto=format&q=50",
             3: "https://static.vecteezy.com/system/resources/previews/000/210/848/original/abstract-border-collie-dog-portrait-in-low-poly-vector-design.jpg",
             4: "https://estaciondiseno.es/wp-content/uploads/2020/11/juan-manuel-gamez.jpg",
             5: "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/d02d1f60553913.5a5149d7a7a81.png",
             6: "https://estaciondiseno.es/wp-content/uploads/2020/11/carlos-martos.jpg",
             7: "https://www.techtitute.com/techtitute/cursos/020241628/recursos/banner/estudiar-modelado-low-poly-3d-studio-max-.jpg",
             8: "https://www.foro3d.com/attachments/229175d1567448393-preguntas-novatas-de-modelado-003.jpg",
             9: "https://miro.medium.com/max/300/0*6UhLfOwN5wnejNMq.jpg",
             10: "https://i.pinimg.com/originals/42/bc/2e/42bc2effb71daf534269446e0ff25a19.png",
             11: "https://cdn.pixabay.com/photo/2018/04/06/13/46/poly-3295856__340.png",
             12: "https://cdn.dribbble.com/users/15687/screenshots/15295303/media/143eaaae4fd1be2b90cb2e54c3140bd1.png?compress=1&resize=400x300",
             13: "https://mir-s3-cdn-cf.behance.net/project_modules/1400/c203b554558117.5ca13f54395de.png",
             14: "https://estaciondiseno.es/wp-content/uploads/2020/11/juan-manuel-gamez.jpg",
             15: "https://www.designyourway.net/blog/wp-content/uploads/2019/03/fishing-village.jpg",
             16: "https://mir-s3-cdn-cf.behance.net/project_modules/1400/a1757889934319.5e11eb052c804.png"}
 

// Disable the scroll
function disable_scroll(){
    var x = window.scrollX;
    var y = window.scrollY;
    window.onscroll = function(){window.scrollTo(x, y)};
}

// Enable the scroll
function enable_scroll(){

    window.onscroll = null;
}

//Var (i) for image index counter
var i = 0;

// Function for opening the image preview action
function open_image(){

    disable_scroll();

    window.onclick = e => {

        console.log(e.target.src);

        let imgURL = e.target.src;

        if(i == 0){

            //Background cover div
            i = parseInt(e.target.id);

            let newCoverDiv = document.createElement("div");
            newCoverDiv.setAttribute("class", "coverDiv");
            //newCoverDiv.setAttribute("onclick", "close_image()")
            newCoverDiv.setAttribute("id", "main-frame")

            //Left and Rigth buttons
            let leftArrowButtonText = document.createTextNode("arrow_back_ios");

            let leftArrowButton = document.createElement("div");
            leftArrowButton.setAttribute("class", "material-symbols-outlined changeArrow");
            leftArrowButton.setAttribute("onclick", "changeImagesBackward()")
            leftArrowButton.appendChild(leftArrowButtonText);

            let rigthArrowButtonText = document.createTextNode("arrow_forward_ios");

            let rigthArrowButton = document.createElement("div");
            rigthArrowButton.setAttribute("class", "material-symbols-outlined changeArrow");
            rigthArrowButton.setAttribute("onclick", "changeImagesForward()")

            rigthArrowButton.appendChild(rigthArrowButtonText);

            //Text Instructions
            let instructionsText = document.createTextNode("close");
            let textInstructions = document.createElement("h1");
            textInstructions.setAttribute("class", "material-symbols-outlined instructions-exit");
            textInstructions.setAttribute("id", "instructions-exit-id");
            textInstructions.setAttribute("onclick", "close_image()")
            textInstructions.appendChild(instructionsText);



            //Image and buttons container
            let imgContainer = document.createElement("div");
            imgContainer.setAttribute("class", "elementContainer");
            imgContainer.setAttribute("id", "elementContainer");

            //Image container
            let newImgDiv = document.createElement("img");
            newImgDiv.setAttribute("class", "previewImageDiv");
            newImgDiv.setAttribute("id", "previewImageDiv");
            newImgDiv.setAttribute("src", imgURL);
            

            //Append the elements to the DOM
            imgContainer.appendChild(leftArrowButton);
            imgContainer.appendChild(newImgDiv);
            imgContainer.appendChild(rigthArrowButton);
            document.body.appendChild(textInstructions);
    
            document.body.appendChild(newCoverDiv);

            document.body.appendChild(imgContainer)
        }
    }
}

//Function for switching between images Forward and Backward----------

//Forward
function changeImagesForward(){

    if(i >= 16){

        i = 1;
        document.getElementById("previewImageDiv").src = dicImages[i];

    }else{

        i = i + 1;
        document.getElementById("previewImageDiv").src = dicImages[i];
    
        //console.log(i)
    }
}

//Backward
function changeImagesBackward(){

    if(i <= 1){

        i = 16;
        document.getElementById("previewImageDiv").src = dicImages[i];

    }else{

        i = i - 1;
        document.getElementById("previewImageDiv").src = dicImages[i];
    
        //console.log(i)
    }
}

//Function for closing the image preview----------
function close_image(){

    enable_scroll();

    window.onclick = e => {

        let imgID = e.target.id;

        document.getElementById("main-frame").remove();
        i = 0

        document.getElementById("elementContainer").remove();
        document.getElementById("instructions-exit-id").remove();
        console.log("close")
    }
}

//Return up Button----------

function returnUp(){

    window.scroll(0, 0);
}


