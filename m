Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43B1C001DF
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 03:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JAUpUcBvF0jW/BpGjtReB2kr8byk9PUC/BIA42fPJyY=; b=wkBajW4h6i3yav
	dE4oF+CoTTmTjbjQUtB9Ze/EVRPt0gfji/L6vM7Ee7ISUPSFsonFknPBnbFtb08iDEYAlILbSwsDd
	BV+e26l/FeEPwghBrzZoZ6mH4zsQibuRbSOkGg79AdHXFNnHI+UeqsZd7Pryfozil2vZM060QGRSN
	ZG4s1W1IjT8fHfmgseZV9VPib3ITPmHwmq/H8xbGWa3siFgko25lH1f504VT78+bYlHJRIjfkojwV
	u/5WOIX1O1ajWA6+TBZycfOc6Ble5CxA7A+MzDsVEoAwFylETAzX1Gcf8UWnn4sF+0e6IE3iCXvUg
	vgIMzJUJGW8r3sOFoHgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtgCh-0015Sa-1Q;
	Fri, 20 Oct 2023 03:29:39 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtgCd-0015R7-1u
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 03:29:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697772575; x=1729308575;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hrLa69LdgTwkBBjglahf/CjwCToIyOEE7R4Uvu6OY/8=;
  b=HPLaZBNbEychi6aQ0DokVBzLCgcYxEvIMlFyyOyTscIlNhaB5llFbDpC
   0+KCAYjGA+27qKDc+NkD0vjgIFCOhWIe3HmnwWANQxmBUlfiU2wcUps63
   Hc88/AlxkvmBOmORdKa4goVYNF9DRgupWvCTfdswry0kRHspiZK/LP777
   fF+ksiKcaCPacyBs+w3UC7izzKHS9e7rEFZ1dVgdZyduAfMuCg0ByJLGD
   meBLjE+m0TK3cgSALGdCpH0r6uSjEOlaSi4QURslAS6BeUgbLPG0gPejf
   XxxcHV3OQgc0obA+CWu/JKCT65iJgNJ/2m1SgWUTVR3Zj7MzV/bOtylbW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="385299278"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="385299278"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 20:29:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707105738"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707105738"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 20:29:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 20:29:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 20:29:33 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 20:29:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYLmukH5p/YjHm7s35QeAx+ZQ3HHj2fWebJb108ZWngkf52u0dN5jB/rCU4iPEVzxZP5J1S8CvflhY2yXXW22DAX9GdLQyvkC6rW64NW1yV430HQyV90n8f8GJTX1l86UfIPAKTJHyVxtAUGBn3uBPGPYudOb+auURW/jZV4MyP8A0Xfz8TAHuenhj3DeBNTK06ezFm1Et2dUSI7vaeAMvxj1iez3grJLlfYFdd06Cb7SJ2j84o23mnCt1xQb8uLUWDb999Lc6476va6dkiHhrRhcAKZHLPSkskb7uW1OS/xfae7UILLy95ZwLHvkriLYtsYky6spmDZ0LVUlf3lDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrLa69LdgTwkBBjglahf/CjwCToIyOEE7R4Uvu6OY/8=;
 b=cCusv41zHRhFycpfWPIL1ZySIckIrdgSEe006E91LS6tNeM43T5ywH+2gXCySZLqYI3eok9Zp/7UF3ztanhZXWDV3eS+BbaXxRjFEB7qXqgDPnUBB39FYuYAbhwixekDt/5fNvoDiKY9B6aMj1k10xRZh/VO6VLH6/45mDnow8TNoWkmA73ytclWXq3vN2usW/R8eVU7xEzfgrwrvEYP+Hko8mMepccU4x6L0nFDweQtQsQTZJrrP/hPO8DMciltyqG+IEgsTwHfj6rkPQ07IqlHdyTZViAMo/AL5dmvii1ibULy8dqelQ4aatUMa4KP70AmzamuSvccNAQbNKSelg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB6699.namprd11.prod.outlook.com (2603:10b6:510:1ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Fri, 20 Oct
 2023 03:29:25 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%7]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 03:29:25 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH 12/13] x86/acpi: Do not attempt to bring up secondary CPUs
 in kexec case
Thread-Topic: [PATCH 12/13] x86/acpi: Do not attempt to bring up secondary
 CPUs in kexec case
Thread-Index: AQHZ94+CVtYaY4+0s0KVDjRWXxnMZ7BSHBuA
Date: Fri, 20 Oct 2023 03:29:24 +0000
Message-ID: <100c567d4ba2e6f25dd6c51ceaf2995049d12c78.camel@intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
	 <20231005131402.14611-13-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231005131402.14611-13-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB6699:EE_
x-ms-office365-filtering-correlation-id: 842b25f7-8284-4a7c-5569-08dbd11cc1fa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JhntaT57OjHQbv/m2VO+9CNs07t4y3/5gaDWITGDqcWuaxrmcFx/ZCJ6Fzt+dq+SkLsVFISNzDmdTNDxUEiaM8hqQ/J3gHvCvvS9rou4gpYZphYzlYQQ7GmFuvsLFGWO3+l3dnObuiZ1JbpG/T5+DoBOEcW/t7kl+yS4h0SD7+oXQcUy5CucacvgYEOHCTIHAAUR56GmhGAc5dGo2s2yGLu4WFqh2Bic3T7cDp9eWbw5vBP8Igj69SFhOPYicpwgqMT5kuvlLWWLku0ZEOTVHly1Zlg7OMPoOhCFgmm1gQfrwICyv5N4enOwMt5YhkW+FZBI3Dw2rY9M7Qan1O9DolbjAHE+4YIWqqUiPvEPuscmg2sRvXZIRcPLQk/JQTLjHhwikmlxNhUyNfJ5UqmEsw3hO7BWEt6wau6YSiO7jAF9LHa2YborU4lUHVh62Ucq/WLswE4KLKiq5z+GemqFKY8zsF57b42/uZIxlIm+f9jzw5teIrXOc/9vgmb39ajlVW5Z6oMYAT+NIrNs476nZrloTKV/54lyWY8m0IYgXCplcDa7Ebbk21FmjKneznelUOjAkhQtIIcLDdcvZP7nmAffw7q1zofC+Xff75w/Dltd2sv9U70pc1/RR2OHgxs2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38070700009)(86362001)(4326008)(2906002)(82960400001)(38100700002)(6506007)(6512007)(5660300002)(7416002)(41300700001)(83380400001)(26005)(122000001)(36756003)(2616005)(8676002)(66446008)(8936002)(478600001)(66476007)(6486002)(71200400001)(66946007)(76116006)(91956017)(66556008)(316002)(64756008)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q00wcVozdzZ4a2srQVFFalZNKzdtbmEzUXNsQm1EZFpnSE1qVldQTGF0azlE?=
 =?utf-8?B?V2tlQTJwUWMyNVF6L2VwZDJ6RzMxMnUyZ1c1dURwZTlpanlWVHhKVlFnVmVH?=
 =?utf-8?B?SW1XaHIxRDBRL3NwOXoxL2kydGdaVlErNGpGMXczV1JUdjJIZ3o3N2M0UnYy?=
 =?utf-8?B?K3dCL0R6K3JWQ1lGRWNHN2pqZTdkM1FGa1NRalJiVDF2bDdpcXdpcFNXaFAx?=
 =?utf-8?B?Mk5iN2s1aER6VHh6QWU2ZEtPTXZWRCtKU3UxK2lrNlZxM245ZTRQMnhFVXN5?=
 =?utf-8?B?ZTFaNjd3dnFWY0pTd1htRzg0RWVFS1luNFdrMnF2VXhRT1hwYmtqNDI3cFdz?=
 =?utf-8?B?YjNLa2dmMG85alZqZXI4U3lJclRreHlUd3ZFVDFUU2NHK1lFc1NSekhLWVpX?=
 =?utf-8?B?bC81ZVZXZk95YVJYL0t4ZzQyRzQyRXZIN0FTSHZHYXdLYkQ0dG4yYm5pNlln?=
 =?utf-8?B?OVRzcjhRZHpUQTR3Ky9ob09US0Q2eGMxbG9ZdVFRZnZBSS9rZUNGc3N6ZEJU?=
 =?utf-8?B?WWNvbnVQQ1M0clVnd3JkaHhZQ3hxVjVBc05KcGMzTFFZUnN3djNnYy81akx5?=
 =?utf-8?B?U1dnYTQzNWVmalZSN2VJcTRlZFNxK0NZOHlNNm43UXN6M1l6eWJRcC9SMmQr?=
 =?utf-8?B?N05zWGFtUFRGdXRSM01mVmd2UXNIdmc5ZmpzSHZrbTRkN3FCMzlGMjJRV3Za?=
 =?utf-8?B?N3dROE94ME9manQwMHVpdzVraDRraWFJL1QxL0JWTFVlUDFGRzduV1pHVjM4?=
 =?utf-8?B?NWhXQVpsdXZsMTdiK0RTVVNpbjhMS2J6SnNTTnpCeFhGQ2h2VHZVS041VFhx?=
 =?utf-8?B?SkR0MG9PQTB1bWVxbDExK2FqR0UzVjlVNzhsM1lNSDdXTE1wakQvakI2QTU3?=
 =?utf-8?B?Z1FVUWRYblFuK055RlZHN1pGeEp2V3FOVDBZa2cyK243T3VWbXBTT0xtai90?=
 =?utf-8?B?cFI0TEliR1lXWlVJelhJS0o4Tkp0eXVCY0tTVk92UGRsdk11NW9udVBzSVRi?=
 =?utf-8?B?MEs5WTFIbzJoWDFxdlBEczRlRkd4dm5aWXJKOUdLZEltRHd3a1p6M1hHQ0VJ?=
 =?utf-8?B?NDd4NnY2MTQ3R3hqeVBoY3hrYzkxWXZsQXo2QUxXU2x1eGlRSkVJckxSSXVz?=
 =?utf-8?B?Mzk3c3BTQXJKWE5zRjh1L0xQK1FoV0g1N3JrTDYwRVZWWHRaU1JpR3A3eUcz?=
 =?utf-8?B?ejNZN1RmUitwS3U1NkI2OXh1dCtWODJCaVJqY0FXN2V0dmhEYS90dGpraW9O?=
 =?utf-8?B?VkIra0Y1cTZIOEZYQ2FCcEFLL3VoaFRDZVJuTUlOem83WEtVSjJXUW5oR3Iz?=
 =?utf-8?B?b1VpM0w2Y3ZIZTBteDdrN2RQQ1dydVpHczZYMkdvQ0lsNkhjOCtpK0RyMTFI?=
 =?utf-8?B?bDJxRGRzK1FWcGlyWXlETWRtM2d5Q0J4ZklkUkVQc1F5M0YyOUNGMzVaankv?=
 =?utf-8?B?eUJZNjVNK1IzYVNxQ3ZhNWlycE9sUTd5c2RjWGxnekJjMWRIcS9CWkNGcVY0?=
 =?utf-8?B?MUk3SFNHZDU2VmpRNjNUcVF5WitRNUU3dFl4TEtHZGRqTVEwcTg2Zkt2YTFk?=
 =?utf-8?B?RlI5ZkcxRElzekxieGpzTW9mODNiN3ZlN1M1N2RBbkxCMFdndlM0dG1NY0JY?=
 =?utf-8?B?Unh3eUJHL0N3SEQvZnl1QUZPQW5vWTdMZjBoby9CVFVpRU4wNk1rZ2V1QkVB?=
 =?utf-8?B?bWpwWWRYcElIenduZmJZYi84cm9YUlgyOUZqM2o4Z1RnZXVRTmNuNGpSL2JC?=
 =?utf-8?B?R1RCRVFyWGNxZ05HelhYWitUWW5yL25nYm4xU3p2Q25NNTE2L3dpdTJ5ZHd6?=
 =?utf-8?B?bDR4WXpEd1daVlBSbEd5TjBUT0pCd3ZtWHNtRWpwSkxUbzdQb1JxZ0Q2bXE2?=
 =?utf-8?B?N2lOekJjZTZVS0VzcWZsS1BkNUEyam1odzRXK0hzTVhyTWxpQzQwU2d1WHBn?=
 =?utf-8?B?T1VTcGlGOW5mWlBqalgySTRmNks2RUJOeVRSaHdmUGZOT2NFVGVvMC9ubVp1?=
 =?utf-8?B?MDFVNVM3aHl0VDlrZXFEWjdjKzAxNkxRTGkzRjBpZVBPV2x3U0ovS0xSd2pZ?=
 =?utf-8?B?OGFTMDlZditqMHM1RHpoemhqTy8wTnArOElZd3FLdy9zdzlSRWl6UENRa2ZQ?=
 =?utf-8?B?Q0hobURUSVN4aFhDaGQ1WEdmMVlZTHVaRkIxWkdOeEJ6NWloSnV6UnJSMFJI?=
 =?utf-8?B?Snc9PQ==?=
Content-ID: <F94AA4D6A8AC7542880F72292DFCA5C2@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842b25f7-8284-4a7c-5569-08dbd11cc1fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 03:29:24.6574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mw6TILQbexQkSUXL8lR2PhSAeZTQJu8fM9rBqyofxV5VeJLOyyEndchSFw5xnhBcvIHZ1xaNnvcXilaJ80Al+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6699
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_202935_646825_DFAFBC13 
X-CRM114-Status: GOOD (  26.36  )
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

On Thu, 2023-10-05 at 16:14 +0300, Kirill A. Shutemov wrote:
> ACPI MADT doesn't allow to offline CPU after it got woke up. It limits
> kexec: target kernel won't be able to use more than one CPU.
> 
> Zero out mailbox address in the ACPI MADT wakeup structure to indicate
> that the mailbox is not usable.
> 
> This is Linux-specific protocol and not reflected in ACPI spec.
> 
> Booting the target kernel with signle CPU is enough to cover the most
> common case for kexec -- kdump.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/acpi/madt_wakeup.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> index 15bdf10b1393..4e92d1d4a5fa 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -9,6 +9,11 @@ static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
>  
>  static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
>  {
> +	if (!acpi_mp_wake_mailbox_paddr) {
> +		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	/*
>  	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
>  	 *
> @@ -78,6 +83,18 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>  	/* Disable CPU onlining/offlining */
>  	cpu_hotplug_not_supported();
>  
> +	/*
> +	 * ACPI MADT doesn't allow to offline CPU after it got woke up.
> +	 * It limits kexec: target kernel won't be able to use more than
> +	 * one CPU.
> +	 *
> +	 * Zero out mailbox address in the ACPI MADT wakeup structure to
> +	 * indicate that the mailbox is not usable.

Nit:

It is better to explicitly say that this will only impact the second kernel
because the current kernel has already detected the  mailbox address?

	Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
	The acpi_wakeup_cpu() will use it to bring up secondary cpus.

	Zero out mailbox address in the ACPI MADT wakeup structure to
	indicate that the mailbox is not usable.  This prevents the
	kexec()-ed kernel from reading a vaild mailbox, which in turn
	makes the kexec()-ed kernel only be able to use the boot CPU. 

> +	 *
> +	 * This is Linux-specific protocol and not reflected in ACPI spec.
> +	 */
> +	mp_wake->base_address = 0;
> + 
>  	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
>  
>  	return 0;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
