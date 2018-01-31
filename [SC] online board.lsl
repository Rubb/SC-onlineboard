string online="36edbd51-d701-0887-1a2c-52cc45dc5ad2";
string offline="ec0c465f-6ccb-dec1-809b-ef0c3d122a11";      
key user_key;                                   
key blank = TEXTURE_BLANK;
string name;
string status;
intheger face =3;


default
{
   state_entry()
    {
        llSetText("loading....", <1,0,0>, 1.0);
        user_key =llGetOwner();
        llRequestAgentData( user_key, DATA_NAME);   
    }
    
    on_rez(integer start_param)
    {
      llResetScript();
    } 
    
     changed(integer change)
    {
        if (change & CHANGED_OWNER) 
        {
         llResetScript();   
        }
    }
    
    dataserver(key queryid, string data)
    {
        name = data;
        state show;
    }
}

state show
{   
    state_entry()
    {
        llSetText("", <1,0,0>, 1.0);
        llSetTimerEvent(10);
    } 
    
    timer()
    {
        llRequestAgentData( user_key, DATA_ONLINE);   
    } 
    on_rez(integer start_param)
    {
        llSetText("", <1,0,0>, 1.0);
        llSetTexture(blank, ALL_SIDES);
    } 

    dataserver(key queryid, string data)
    {
        if ( data == "1" ) 
        {
            status = " is online";
            llSetTexture(online, face);
        }
        else if (data == "0")
        {
            status = " is offline";
            llSetTexture(offline, face);
        }
 
    }
}
