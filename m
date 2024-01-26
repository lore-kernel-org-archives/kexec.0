Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D854C47DDF
	for <kexec@archiver.kernel.org>; Fri, 26 Jan 2024 14:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LOc3ZrWTGbZHhV7VcWANNTZ6UAsJlClxxD8v0GGBhaw=; b=PV+AtSIWQFLiqV
	/JT/6d9aLqRHG1GDYwcrs04DcGFNQjufjeC+fO41coHJuqwshks7DrFH+0JorT60zE7vOZ8bAEp2H
	g3MOtdwtH7BUrVrkV8WbhugsSMbU8FxV1I3+2058B7AihcY4wJK/QM5CJxERX91w2/0VyemGjRQl3
	8l7mW4Q/7/vSA6raQA27EXMa7zK9NwbO7dhodu9nHLhmlQdQs//sCGLbuGUUnyf1uPitmJw6jM8qD
	lgBpt73vhiDD15lu/xdAgbuBpjLJ2a9GS8hfKZJKA1S/TXC6xLz8utgsuCqku2gwpeN3/Sy/Yzyzt
	2A52lIjWcpMVGGfPfapg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTN5T-00000004JAf-2kq7;
	Fri, 26 Jan 2024 14:21:43 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTN5O-00000004J7E-2bsS
	for kexec@lists.infradead.org;
	Fri, 26 Jan 2024 14:21:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706278898; x=1737814898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Wyyg59AUjNrInBL7i4KyKiX0Gthw29pZn5bdcxMsi7g=;
  b=kK/jSZU3+GXsGl8H7RrH262fHtjySIzm/Eq+terb9sZ2HjgfCM18A5kd
   mw4FuVeWWPyxKkBtmtIrTWXbmV7asrtTrb0xjC8COqqLYrp/aL4Fkg3bQ
   lJw8VqKRYLoVPqIIhgWH6nUjoe1y37PIrcNdS1HGg5K+1vClHCvlZVbSl
   93PcnbO8acIRpv5bcLDQP0U00bQGQiYg7MnkPhJbGos/MJD0K+/W6zzUH
   xH7ij8g/pMRnBmqk6nbJc2W/Pp1cUD2axaJ5XaTu/ZnAh5yHzT6tvJUwB
   a3eToVvvE75ryg3K0kUV2YYSdbvwp0/6JnjWJtQyag4G6ONdYRJliayL9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15836806"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15836806"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 06:21:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="787114813"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="787114813"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 06:21:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 06:21:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 06:21:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 06:21:33 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 06:21:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX6UH5Chz0V7lLcQCPT6SCorZwgQyxp1KJS/5GEyawifwURK66mygJUz16ZUTc2VnwUM47txcAFPI6rmNwfQil+BNgqvt5goQUTrhgJc/uWF0ZnZbOSd4fkObLDUf7tNrh4lSoj0pCjGbwEfLFFVWL7LupvDHq3hsqFDCldNnmwNWNq27ATSG+j+dAUr5fQ4QdMEEB0tOzMtYBuXnm6UTAohzvj49D98rXYkuUsGmP32ylRupy4W8z/WaV88IegWIRJobgGqUTfqMEU1bU7JX2k/33n58Qqemc/TR8W68eWvu5YFImlfnSh90PoFksrVcrMD0mI+39guAkvA7JMvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wyyg59AUjNrInBL7i4KyKiX0Gthw29pZn5bdcxMsi7g=;
 b=Y2w80h2ECduHvzxUftoYAH2yYX9dCvwPxSKcOuF0TaAWZt1awYNtFmqTrsc50zZPYXfQFE4Exmov1KKizJ0MdwOXpxHJjItP/1qZQJWVs3aYwLbXPX3UY3iCjZeLbla2GzHXpNP1WGObIWDmnwfrAtAwdoI6lrW393AQ9uQSoyYe0ZJszhkCuivBic8AoGL/NW0sZSoTLgAj79PLUJfURMd1WeIPWe9t41AOfNERw6K+6jYNk/qPsr1049cpFmluI39LEPS3d5f7caPUylmlnExAMuQw4UnNdAmJZ2AHAqXA3upqXV+hAQgWYdlwkRsfUXoVclVKTELMfwGMlhQQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA0PR11MB7936.namprd11.prod.outlook.com (2603:10b6:208:3dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 14:21:30 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec%4]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 14:21:30 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, "seanjc@google.com"
	<seanjc@google.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv6 16/16] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Topic: [PATCHv6 16/16] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Index: AQHaTsTQgPMKbbXaMkadtTZSS8tncbDsKFuA
Date: Fri, 26 Jan 2024 14:21:30 +0000
Message-ID: <075348cdf2b4d3361db5c7d420f09a1c8935328e.camel@intel.com>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
	 <20240124125557.493675-17-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240124125557.493675-17-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA0PR11MB7936:EE_
x-ms-office365-filtering-correlation-id: aa701ade-8b82-4419-48a3-08dc1e7a1775
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Va5f0fYrXVr6Z7Dpgc2IaMM4c3AUEoz3lMc+TFKz203ZsHMFIYT/aTsZJ3l6JHKSvlGwCa+5rmy4fFA1Cz4XgUAVJEHBvo3+5qxHzj/JP4PayXek4AVu2yKJKI9/vBzjSpYYyl4FNLJqqjFTCrVZkBUaDD6tFldIvNXat9KpTl+kdeWnGQJbPIrk9tPgLeduC+KEIH2moRIOFUW+ue1tLQr3lDad98UBDX3a4p4lLPk9sgIna+eMxfBbP/3eWEglKR2FLKuG2MfEjx8XLc9saDGEXRuRABMej934OugYVAhGFSaaCWfvh7gZznyEVXF4HHoJpgUYkOuLQfRGmgcOHXJU2a0nQWwlCGM3YWA4omHjlv/Misc+W/t4xRM9ObX+qIyrHTEBM5yqJG4Enc+tUWQVNxpon40TKXNBP3sbRAsOGdPSlnjtDrfeKI3LY/Al+CaA2kpV0a3Tovci4IfeSLwdIVh68oY+Pwl9d01fvSJxfT0zbpTAz1OzYjQ1sEM6QHByIN1z087gGlU3ITQ3QiKuVPzf9B3vIBAMAGQ+gw9hBXFz3vRRNjSxvqiuPznf0O+ZjMeeUDnbpb1U3eCOPyBftIlCkRexNNp1/5RJ+5E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(38070700009)(91956017)(54906003)(66946007)(66446008)(66476007)(66556008)(316002)(76116006)(64756008)(110136005)(83380400001)(7416002)(5660300002)(2906002)(122000001)(6512007)(8676002)(8936002)(4326008)(2616005)(6506007)(41300700001)(71200400001)(38100700002)(478600001)(966005)(6486002)(26005)(86362001)(36756003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlNCcS9HYjZFRDV1STJsV0xxUkJHWnRwTmNZYXBtL3p5MHBiSG1IRGZNbHZz?=
 =?utf-8?B?bU9GWXVReGRrODFDWVgyemcrK29vbW1CTCtaTjY1YUdiNHZRV3Z4OTUydHhj?=
 =?utf-8?B?REdVVEFXbnByNHUzakxTVjhvMk9Odm1OM1J1a21UZVVaOUd0RTdVRkxWUGJn?=
 =?utf-8?B?cnRSSmd0ZXg4dmh1SUZDQ3Z6SWN2TXp3bW9vUk9GcFNudlF6Tm5TWk12UHBM?=
 =?utf-8?B?NWVaNGcrOW5FS3gwWFFuR2tqSnl6RVZwUEh3bWIvTnU3YnNneGpkSUhmRjU0?=
 =?utf-8?B?cU51OC83eUgyUFNmMnVWRFgwZmY1anQrSTVDZVpxU1k0Y0FDY3hPa096TjRP?=
 =?utf-8?B?V0d4dks5MnA5VWJZcGdpUGwzb2Q5U3VCT2ZPOHo1S3Vjd3BVSlVLREJKY2tj?=
 =?utf-8?B?clZaSHhLeEZGR2Zob21kSW1ZQm85V044T3dPZWpjeDRJRk83RnhjM3ZnK3U4?=
 =?utf-8?B?MHRqcFE0WjVDOHVwM0F2QTRjUXdEQnVPcFVoTzFTN3B6NzB1bFk5ZmtWWVBL?=
 =?utf-8?B?ZldkY3hTaUFsTGd0YVFLWng0Tk1HMDN6Mkh6UnI0aHZMMFpiSm9ESU9MZ1Rs?=
 =?utf-8?B?R1kwY3hJMlFiMmovbmdqamljRnlXNlBKZkxVNEs5WnliMmhyUzgvQmpMaGJp?=
 =?utf-8?B?cUZERTJsa1hOZGFndFNhZjdzQ0lseVJLYW9kcmFBa0ZBeGw4NTMvODYyaGpC?=
 =?utf-8?B?b1lmOE5RVzFpZ3V3RVVWMm1WcEZwWXBoamRKSDlySExPSnRsUDFiNzRiVjZJ?=
 =?utf-8?B?WVFTa2V1SyttdW9qUTVLY2NiL1V5d09MT2txYnYvaW1JL2NvNWpkL2VXZWk0?=
 =?utf-8?B?cXhKakFFcXE1bG5SY0ZkR3JickxLQXJYenFXTVptdUFGbE9wblV4dG1hd1hp?=
 =?utf-8?B?L3l2aCtYczJWbUxpU1FqMjJGcnJ2VXRnazFMYk0wUVM1aWZRcTNjaTFCV0Iv?=
 =?utf-8?B?YmpQbEdhY0NZcVFEOEFjR2QxcVMyNitIdkJPKzFDZmFQYko5Q08vRUw2SW8r?=
 =?utf-8?B?cjZPeEMyN0JtNDhIUldGeHZTeFpZbmx1L24xelVDRWc0R05wVUlxZkFFbVNR?=
 =?utf-8?B?c01iTnVBdVkyU1BDS2hHbmtTdXNRNlZET1JEbTRRMTlqOXRWaytLRzh3M3VK?=
 =?utf-8?B?eE5tcGNhcDdzbTZPN1o0WVNaczNLMVpQajRqSnhRZWRoYldlMEFzRXNNMld0?=
 =?utf-8?B?dFpiem5Wa2hvbkRKS0k3WWxzbEhpUllMV2Q5TkJlTS8rQ3EvbHNaR2t4Zm53?=
 =?utf-8?B?ai9PaUVRNlpweSt0R3VydkI0Z2JNajdPTEZqWmpabWowQkZuODV6ODhkWnN2?=
 =?utf-8?B?WUgvb2dGMmwxUVU1Zmx2eDFTbnY5dkpmTHdJUE5Uc09UVlpFN1crSVBWblhM?=
 =?utf-8?B?bzkxMXgrNFlkRlZoeTdqcGdJQ2dWRUZTeEc0MjhXV1FGVzAvTHNqZlN0bWs3?=
 =?utf-8?B?OUlmM0MzbGJTTXU4M3ZxdHc3bGxncU1SaGtIaEN2UFIvRzZaeGlNNSsxZGJN?=
 =?utf-8?B?MzhEMFVqeEo1NjZwSmNhMEdpaU0vZ0Job0llSDJ1ZU0yMHp5ODFYYVFFbS9C?=
 =?utf-8?B?NDhERU1qaS93SHFFTDJPeFVNL2lnRW5NYm9qbUE2dGFnWVp4NVZNbGxyc2Ru?=
 =?utf-8?B?MDkxeUNwRGdaaGxLcnJYNEttRHgrQk0yci9wT0NGQkdrVG0rc21OVUhWVGxv?=
 =?utf-8?B?NkVYMlM5NmNjTHV2SWEvNU1FZno4dXZZOGp4TUFleCtWRTVibEMyTzBud00x?=
 =?utf-8?B?amp2YW5yWStiWVZibFVNZElHWU1tbTIrUkV0aUI3dmtqY2JXRjBla3RWc3Zp?=
 =?utf-8?B?Q2pDNCtEOE9sVmpqdmhBU25kMTY1a3JrenBJblUxOHBoZFozZ3VrRUI4V1Aw?=
 =?utf-8?B?VDRFcXJBdHh0WFhsSHRPQlBtL2pYdnlCcEpyZFJiS2xNeXN0dmNBcm9kNDBm?=
 =?utf-8?B?MGF5S2RYeGlOazgrblY2VlBBOHMwelhFQ0xKTEM2MG5XYjJyYzdJaXlKRFMz?=
 =?utf-8?B?NklhYzVudzJ2dGJOU3ZTZEkwemhGaXc0NDgvT0UzRmNzcS9ETnk3QmZkZ3lO?=
 =?utf-8?B?Q2wvQzJoNGpaVU16dUQ2VkIvZTArV3hBRGNPMnM3S25LRXV3a0FGc1V3d2E3?=
 =?utf-8?B?NjVweURXcXMxNnpzMXBpZU02UXdFdDQvNUxSa29FbmpIcSticmp0SVA0aHhw?=
 =?utf-8?B?MlE9PQ==?=
Content-ID: <0AA25C5A16DA2245AF995D0D4950251D@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa701ade-8b82-4419-48a3-08dc1e7a1775
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 14:21:30.7836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNCKktwvwDX+WguiiteesYpq+ouWey0Pu8mXwRYjcWnx3yiF8UNSk+ORNI7iMHoIrvzJZYnsLhmS91ArF8TmVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7936
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_062138_893550_336D3257 
X-CRM114-Status: GOOD (  17.45  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, 2024-01-24 at 14:55 +0200, Kirill A. Shutemov wrote:
> MADT Multiprocessor Wakeup structure version 1 brings support of CPU
> offlining: BIOS provides a reset vector where the CPU has to jump to
> for offlining itself. The new TEST mailbox command can be used to test
> whether the CPU offlined itself which means the BIOS has control over
> the CPU and can online it again via the ACPI MADT wakeup method.
> 
> Add CPU offling support for the ACPI MADT wakeup method by implementing
> custom cpu_die(), play_dead() and stop_this_cpu() SMP operations.
> 
> CPU offlining makes is possible to hand over secondary CPUs over kexec,
> not limiting the second kernel to a single CPU.
> 
> The change conforms to the approved ACPI spec change proposal. See the
> Link.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Link: https://lore.kernel.org/all/13356251.uLZWGnKmhe@kreacher

FWIW:

Acked-by: Kai Huang <kai.huang@intel.com>

[...]

> +
> +static int __init acpi_mp_setup_reset(u64 reset_vector)
> +{
> +	pgd_t *pgd;
> +	struct x86_mapping_info info = {
> +		.alloc_pgt_page = alloc_pgt_page,
> +		.free_pgt_page	= free_pgt_page,
> +		.page_flag      = __PAGE_KERNEL_LARGE_EXEC,
> +		.kernpg_flag    = _KERNPG_TABLE_NOENC,
> +	};

Nit: Reverse Christmas-tree style

[...]

>  
> -#define ACPI_MP_WAKE_COMMAND_WAKEUP    1
> +#define ACPI_MP_WAKE_COMMAND_WAKEUP	1

Nit: Is this change intended?

> +#define ACPI_MP_WAKE_COMMAND_TEST	2
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
