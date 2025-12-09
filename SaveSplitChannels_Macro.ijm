// run("8-bit");
// run("Split Channels");
dir = getDirectory("Choose input Directory");
outputDir = getDirectory("Choose output Directory");
files = getFileList(dir);

debugVal = true;


//files.length
for (i =0; i<files.length; i++) {
	imageFile = files[i];
	imageName = File.getName(imageFile);
	
	if (endsWith(imageFile, ".lsm")){
	
		print("Processing", imageFile);
		processImage(imageFile, outputDir);

	}
}

function processImage(inputPath, outputDir) { 
// function description
 imageFile = inputPath;
 imageName = File.getName(imageFile);
 imageNameNoExt = File.getNameWithoutExtension(imageFile);
 tiffBaseName = imageNameNoExt+".tif";
 print("Image Name", File.getName(imageFile));
 open(imageFile);
 imageTitle = getTitle();
 setOption("ScaleConversions", true);
 run("8-bit");
 run("Split Channels");
 
 images = getList("image.titles");

 channelCount = 0;
 for( i =0; i < images.length; i++){
 	if (startsWith(images[i], "C") && endsWith(images[i], imageTitle)){
 		print("CHECKING Image Channel", images[i]);
 		//Array.append(images[i], channels);
 		channelCount++;
	}
 }
 
 channels = newArray(channelCount);
 
 idx = 0;
 for( i =0; i < images.length; i++){
 	if (startsWith(images[i], "C") && endsWith(images[i], imageTitle)){
 		print("Image Channel", images[i]);
 		channels[idx] = images[i];
 		idx++;
	}
 }
 
 
 print("Processing Channel Windows");
 for( i =0; i < channels.length; i++){
 	channelImage = channels[i];
 	channelTag = "C" + i + 1 + "-";
 	outFile = channelTag + tiffBaseName;
 	outTiff = outputDir + outFile;
 	print(" " + channelImage);
 	print(outTiff);
 	selectImage(channelImage);
 	saveAs("Tiff", outTiff);
 	//wait(2);
 	close();
 	
 }
 
 /*
 channelImage = "C1-" + imageTitle;
 outFile = "C1-" + tiffBaseName;
 outTiff = outputDir+ "/" + outFile;
 
 print("Selecting Channel Image", channelImage);
 print("TIFF FILE", outFile);
 selectImage(channelImage);
 saveAs("Tiff", outTiff);
 wait(5);
 //close();
 
 //selectImage( "C1-" + imageTitle);close();
 selectImage( "C2-" + imageTitle);//close();
 selectImage( "C3-" + imageTitle);//close();*/

}
