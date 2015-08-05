///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NSString+FontAwesome.h
//
//  Created by Dalton Cherry on 4/24/13.
//  Copyright 2013 Vluxe. All rights reserved.
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//font awesome license:
//The Font Awesome font is licensed under the SIL Open Font License
//Font Awesome CSS, LESS, and SASS files are licensed under the MIT License
//The Font Awesome pictograms are licensed under the CC BY 3.0 License
//Attribution is no longer required in Font Awesome 3.0, but much appreciated:
//"Font Awesome by Dave Gandy - http://fortawesome.github.com/Font-Awesome"

//font awesome icon enum - 369 icons in all!
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FaIcon) {
    FaGlass = 0xf000,
    FaMusic = 0xf001,
    FaSearch = 0xf002,
    FaEnvelopeO = 0xf003,
    FaHeart = 0xf004,
    FaStar = 0xf005,
    FaStarO = 0xf006,
    FaUser = 0xf007,
    FaFilm = 0xf008,
    FaThLarge = 0xf009,
    FaTh = 0xf00a,
    FaThList = 0xf00b,
    FaCheck = 0xf00c,
    FaTimes = 0xf00d,
    FaSearchPlus = 0xf00e,
    FaSearchMinus = 0xf010,
    FaPowerOff = 0xf011,
    FaSignal = 0xf012,
    FaCog = 0xf013,
    FaTrashO = 0xf014,
    FaHome = 0xf015,
    FaFileO = 0xf016,
    FaClockO = 0xf017,
    FaRoad = 0xf018,
    FaDownload = 0xf019,
    FaArrowCircleODown = 0xf01a,
    FaArrowCircleOUp = 0xf01b,
    FaInboxf = 0xf01c,
    FaPlayCircleO = 0xf01d,
    FaRepeat = 0xf01e,
    FaRefresh = 0xf021,
    FaListAlt = 0xf022,
    FaLock = 0xf023,
    FaFlag = 0xf024,
    FaHeadphones = 0xf025,
    FaVolumeOff = 0xf026,
    FaVolumeDown = 0xf027,
    FaVolumeUp = 0xf028,
    FaQrcode = 0xf029,
    FaBarcode = 0xf02a,
    FaTag = 0xf02b,
    FaTags = 0xf02c,
    FaBook = 0xf02d,
    FaBookmark = 0xf02e,
    FaPrint = 0xf02f,
    FaCamera = 0xf030,
    FaFont = 0xf031,
    FaBold = 0xf032,
    FaItalic = 0xf033,
    FaTexftHeight = 0xf034,
    FaTexftWidth = 0xf035,
    FaAlignLeft = 0xf036,
    FaAlignCenter = 0xf037,
    FaAlignRight = 0xf038,
    FaAlignJustify = 0xf039,
    FaList = 0xf03a,
    FaOutdent = 0xf03b,
    FaIndent = 0xf03c,
    FaVideoCamera = 0xf03d,
    FaPictureO = 0xf03e,
    FaPencil = 0xf040,
    FaMapMarker = 0xf041,
    FaAdjust = 0xf042,
    FaTint = 0xf043,
    FaPencilSquareO = 0xf044,
    FaShareSquareO = 0xf045,
    FaCheckSquareO = 0xf046,
    FaArrows = 0xf047,
    FaStepBackward = 0xf048,
    FaFastBackward = 0xf049,
    FaBackward = 0xf04a,
    FaPlay = 0xf04b,
    FaPause = 0xf04c,
    FaStop = 0xf04d,
    FaForward = 0xf04e,
    FaFastForward = 0xf050,
    FaStepForward = 0xf051,
    FaEject = 0xf052,
    FaChevronLeft = 0xf053,
    FaChevronRight = 0xf054,
    FaPlusCircle = 0xf055,
    FaMinusCircle = 0xf056,
    FaTimesCircle = 0xf057,
    FaCheckCircle = 0xf058,
    FaQuestionCircle = 0xf059,
    FaInfoCircle = 0xf05a,
    FaCrosshairs = 0xf05b,
    FaTimesCircleO = 0xf05c,
    FaCheckCircleO = 0xf05d,
    FaBan = 0xf05e,
    FaArrowLeft = 0xf060,
    FaArrowRight = 0xf061,
    FaArrowUp = 0xf062,
    FaArrowDown = 0xf063,
    FaShare = 0xf064,
    FaExfpand = 0xf065,
    FaCompress = 0xf066,
    FaPlus = 0xf067,
    FaMinus = 0xf068,
    FaAsterisk = 0xf069,
    FaExfclamationCircle = 0xf06a,
    FaGift = 0xf06b,
    FaLeaf = 0xf06c,
    FaFire = 0xf06d,
    FaEye = 0xf06e,
    FaEyeSlash = 0xf070,
    FaExfclamationTriangle = 0xf071,
    FaPlane = 0xf072,
    FaCalendar = 0xf073,
    FaRandom = 0xf074,
    FaComment = 0xf075,
    FaMagnet = 0xf076,
    FaChevronUp = 0xf077,
    FaChevronDown = 0xf078,
    FaRetweet = 0xf079,
    FaShoppingCart = 0xf07a,
    FaFolder = 0xf07b,
    FaFolderOpen = 0xf07c,
    FaArrowsV = 0xf07d,
    FaArrowsH = 0xf07e,
    FaBarChartO = 0xf080,
    FaTwitterSquare = 0xf081,
    FaFacebookSquare = 0xf082,
    FaCameraRetro = 0xf083,
    FaKey = 0xf084,
    FaCogs = 0xf085,
    FaComments = 0xf086,
    FaThumbsOUp = 0xf087,
    FaThumbsODown = 0xf088,
    FaStarHalf = 0xf089,
    FaHeartO = 0xf08a,
    FaSignOut = 0xf08b,
    FaLinkedinSquare = 0xf08c,
    FaThumbTack = 0xf08d,
    FaExfternalLink = 0xf08e,
    FaSignIn = 0xf090,
    FaTrophy = 0xf091,
    FaGithubSquare = 0xf092,
    FaUpload = 0xf093,
    FaLemonO = 0xf094,
    FaPhone = 0xf095,
    FaSquareO = 0xf096,
    FaBookmarkO = 0xf097,
    FaPhoneSquare = 0xf098,
    FaTwitter = 0xf099,
    FaFacebook = 0xf09a,
    FaGithub = 0xf09b,
    FaUnlock = 0xf09c,
    FaCreditCard = 0xf09d,
    FaRss = 0xf09e,
    FaHddO = 0xf0a0,
    FaBullhorn = 0xf0a1,
    FaBell = 0xf0f3,
    FaCertificate = 0xf0a3,
    FaHandORight = 0xf0a4,
    FaHandOLeft = 0xf0a5,
    FaHandOUp = 0xf0a6,
    FaHandODown = 0xf0a7,
    FaArrowCircleLeft = 0xf0a8,
    FaArrowCircleRight = 0xf0a9,
    FaArrowCircleUp = 0xf0aa,
    FaArrowCircleDown = 0xf0ab,
    FaGlobe = 0xf0ac,
    FaWrench = 0xf0ad,
    FaTasks = 0xf0ae,
    FaFilter = 0xf0b0,
    FaBriefcase = 0xf0b1,
    FaArrowsAlt = 0xf0b2,
    FaUsers = 0xf0c0,
    FaLink = 0xf0c1,
    FaCloud = 0xf0c2,
    FaFlask = 0xf0c3,
    FaScissors = 0xf0c4,
    FaFilesO = 0xf0c5,
    FaPaperclip = 0xf0c6,
    FaFloppyO = 0xf0c7,
    FaSquare = 0xf0c8,
    FaBars = 0xf0c9,
    FaListUl = 0xf0ca,
    FaListOl = 0xf0cb,
    FaStrikethrough = 0xf0cc,
    FaUnderline = 0xf0cd,
    FaTable = 0xf0ce,
    FaMagic = 0xf0d0,
    FaTruck = 0xf0d1,
    FaPinterest = 0xf0d2,
    FaPinterestSquare = 0xf0d3,
    FaGooglePlusSquare = 0xf0d4,
    FaGooglePlus = 0xf0d5,
    FaMoney = 0xf0d6,
    FaCaretDown = 0xf0d7,
    FaCaretUp = 0xf0d8,
    FaCaretLeft = 0xf0d9,
    FaCaretRight = 0xf0da,
    FaColumns = 0xf0db,
    FaSort = 0xf0dc,
    FaSortAsc = 0xf0dd,
    FaSortDesc = 0xf0de,
    FaEnvelope = 0xf0e0,
    FaLinkedin = 0xf0e1,
    FaUndo = 0xf0e2,
    FaGavel = 0xf0e3,
    FaTachometer = 0xf0e4,
    FaCommentO = 0xf0e5,
    FaCommentsO = 0xf0e6,
    FaBolt = 0xf0e7,
    FaSitemap = 0xf0e8,
    FaUmbrella = 0xf0e9,
    FaClipboard = 0xf0ea,
    FaLightbulbO = 0xf0eb,
    FaExfchange = 0xf0ec,
    FaCloudDownload = 0xf0ed,
    FaCloudUpload = 0xf0ee,
    FaUserMd = 0xf0f0,
    FaStethoscope = 0xf0f1,
    FaSuitcase = 0xf0f2,
    FaBellO = 0xf0a2,
    FaCoffee = 0xf0f4,
    FaCutlery = 0xf0f5,
    FaFileTexftO = 0xf0f6,
    FaBuildingO = 0xf0f7,
    FaHospitalO = 0xf0f8,
    FaAmbulance = 0xf0f9,
    FaMedkit = 0xf0fa,
    FaFighterJet = 0xf0fb,
    FaBeer = 0xf0fc,
    FaHSquare = 0xf0fd,
    FaPlusSquare = 0xf0fe,
    FaAngleDoubleLeft = 0xf100,
    FaAngleDoubleRight = 0xf101,
    FaAngleDoubleUp = 0xf102,
    FaAngleDoubleDown = 0xf103,
    FaAngleLeft = 0xf104,
    FaAngleRight = 0xf105,
    FaAngleUp = 0xf106,
    FaAngleDown = 0xf107,
    FaDesktop = 0xf108,
    FaLaptop = 0xf109,
    FaTablet = 0xf10a,
    FaMobile = 0xf10b,
    FaCircleO = 0xf10c,
    FaQuoteLeft = 0xf10d,
    FaQuoteRight = 0xf10e,
    FaSpinner = 0xf110,
    FaCircle = 0xf111,
    FaReply = 0xf112,
    FaGithubAlt = 0xf113,
    FaFolderO = 0xf114,
    FaFolderOpenO = 0xf115,
    FaSmileO = 0xf118,
    FaFrownO = 0xf119,
    FaMehO = 0xf11a,
    FaGamepad = 0xf11b,
    FaKeyboardO = 0xf11c,
    FaFlagO = 0xf11d,
    FaFlagCheckered = 0xf11e,
    FaTerminal = 0xf120,
    FaCode = 0xf121,
    FaReplyAll = 0xf122,
    FaMailReplyAll = 0xf122,
    FaStarHalfO = 0xf123,
    FaLocationArrow = 0xf124,
    FaCrop = 0xf125,
    FaCodeFork = 0xf126,
    FaChainBroken = 0xf127,
    FaQuestion = 0xf128,
    FaInfo = 0xf129,
    FaExfclamation = 0xf12a,
    FaSuperscript = 0xf12b,
    FaSubscript = 0xf12c,
    FaEraser = 0xf12d,
    FaPuzzlePiece = 0xf12e,
    FaMicrophone = 0xf130,
    FaMicrophoneSlash = 0xf131,
    FaShield = 0xf132,
    FaCalendarO = 0xf133,
    FaFireExftinguisher = 0xf134,
    FaRocket = 0xf135,
    FaMaxfcdn = 0xf136,
    FaChevronCircleLeft = 0xf137,
    FaChevronCircleRight = 0xf138,
    FaChevronCircleUp = 0xf139,
    FaChevronCircleDown = 0xf13a,
    FaHtml5 = 0xf13b,
    FaCss3 = 0xf13c,
    FaAnchor = 0xf13d,
    FaUnlockAlt = 0xf13e,
    FaBullseye = 0xf140,
    FaEllipsisH = 0xf141,
    FaEllipsisV = 0xf142,
    FaRssSquare = 0xf143,
    FaPlayCircle = 0xf144,
    FaTicket = 0xf145,
    FaMinusSquare = 0xf146,
    FaMinusSquareO = 0xf147,
    FaLevelUp = 0xf148,
    FaLevelDown = 0xf149,
    FaCheckSquare = 0xf14a,
    FaPencilSquare = 0xf14b,
    FaExfternalLinkSquare = 0xf14c,
    FaShareSquare = 0xf14d,
    FaCompass = 0xf14e,
    FaCaretSquareODown = 0xf150,
    FaCaretSquareOUp = 0xf151,
    FaCaretSquareORight = 0xf152,
    FaEur = 0xf153,
    FaGbp = 0xf154,
    FaUsd = 0xf155,
    FaInr = 0xf156,
    FaJpy = 0xf157,
    FaRub = 0xf158,
    FaKrw = 0xf159,
    FaBtc = 0xf15a,
    FaFile = 0xf15b,
    FaFileTexft = 0xf15c,
    FaSortAlphaAsc = 0xf15d,
    FaSortAlphaDesc = 0xf15e,
    FaSortAmountAsc = 0xf160,
    FaSortAmountDesc = 0xf161,
    FaSortNumericAsc = 0xf162,
    FaSortNumericDesc = 0xf163,
    FaThumbsUp = 0xf164,
    FaThumbsDown = 0xf165,
    FaYoutubeSquare = 0xf166,
    FaYoutube = 0xf167,
    FaXfing = 0xf168,
    FaXfingSquare = 0xf169,
    FaYoutubePlay = 0xf16a,
    FaDropboxf = 0xf16b,
    FaStackOverflow = 0xf16c,
    FaInstagram = 0xf16d,
    FaFlickr = 0xf16e,
    FaAdn = 0xf170,
    FaBitbucket = 0xf171,
    FaBitbucketSquare = 0xf172,
    FaTumblr = 0xf173,
    FaTumblrSquare = 0xf174,
    FaLongArrowDown = 0xf175,
    FaLongArrowUp = 0xf176,
    FaLongArrowLeft = 0xf177,
    FaLongArrowRight = 0xf178,
    FaApple = 0xf179,
    FaWindows = 0xf17a,
    FaAndroid = 0xf17b,
    FaLinuxf = 0xf17c,
    FaDribbble = 0xf17d,
    FaSkype = 0xf17e,
    FaFoursquare = 0xf180,
    FaTrello = 0xf181,
    FaFemale = 0xf182,
    FaMale = 0xf183,
    FaGittip = 0xf184,
    FaSunO = 0xf185,
    FaMoonO = 0xf186,
    FaArchive = 0xf187,
    FaBug = 0xf188,
    FaVk = 0xf189,
    FaWeibo = 0xf18a,
    FaRenren = 0xf18b,
    FaPagelines = 0xf18c,
    FaStackExfchange = 0xf18d,
    FaArrowCircleORight = 0xf18e,
    FaArrowCircleOLeft = 0xf190,
    FaCaretSquareOLeft = 0xf191,
    FaDotCircleO = 0xf192,
    FaWheelchair = 0xf193,
    FaVimeoSquare = 0xf194,
    FaTry = 0xf195,
    FaPlusSquareO = 0xf196
};

@interface NSString (AwesomeString)

//creates a string with the font awesome character
+(NSString*)awesomeIcon:(FaIcon)index;

@end
