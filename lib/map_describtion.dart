//! intial camera position بتشوف انت عاوز تعرض اي اول ما جوجل ماب تفتح(تفتح علي اي )
  //? zoom بيحدد درجه الزوم اللي انت محتاجها
  /* 
  world view 0 -> 3
  country view 4 -> 6
  city view 10 -> 12
  street view 13 -> 17
  building view 18 -> 20
  */
  //! bounds بتحدد الحدود بتاعتي في كاميرا مينفعش اتخطاها (مينفعش يعمل زووم اللي علي المكان اللي انا حديته)
  /*
  latLongBounds -
   southWest -> محدد مكان جنوب غرب
   northeast -> محدد مكان شمال شرق
  */

  //? Google map controller لو انا عاوز اتحكم في جوجل ماب محتاج اعمل كونترولر
  /*
  بس هنا مش هعمل هنشيلايز للكونترولر دا في انيت استست هيكون عندي فانكشن اسمها 
  on map create 
  دي اقدر استقبل منها كونترولر واسويها بالكونترولر اللي انا عملته 
  وبكدا اقدر اتحكم في 
  google map
  */
  //! controller.animatedCamera لو انا عاوز اعمل انيميت للكميرا
  /*
  اقدر اعمل انيميت لاكتر من حاجه زي
   camera 
   latlong
   latlongzoom
   علي حسب انا محتاج اعمل ابديت ل اي بالظبط
  */

  //? markers اننا احدد مركر او علامه علي الخريطه
  /*
   بيكون كم نوع set
   عشان مينفعش اكرر مكان 
   - كل مكان بيكون له مركر واحد مش شرط اكتر من مركر يشاور علي نفس المكان
  */
  //! infoWindow لو انا عاوز اضيف بيانات للمركر بتاعي
  //? size of marker لو انا عاوز اغير حجم الماركر
  /*
لو انا عاوز اغير حجم الماركر قدامي طريقتين 
١ -> ان احنا نكتب كود زي الميثود (getImageFormRawData)
٢ -> ان احنا نستخدم تول من علي النت زي مثلا (image resize)
ودي بحدد فيها الطول والعرض اللي انا عاوزه
  */