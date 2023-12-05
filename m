Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00860C4167B
	for <kexec@archiver.kernel.org>; Tue,  5 Dec 2023 23:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8VjzpuwAwylJeEe0uGpSm+M5cNu7CLIhuw9r/9qsJ9E=; b=xL9kKL3a6HkSye
	W2wQflqSY/aCheJmROP/uylaCVRoD0/VGMwYReDTItkYGRRJlrLFvSJuYxBYda1sHZ1Ftbvs4cJ2K
	LPPlI+bz/L43gfu8+woRyeYnqlrMN50DlIaAA9CubO1fx/73QQC7cSsEg2yO+jPpn2DzMG+gufE6V
	2zLovGaRFSKe20KDSoEhwYIe1hmoONXeTw1HX0pM6HVAkruNKOMLGhCPOrjDVuBI2/uS59djr/DO9
	yHgRTfO2QNrdbabiHI1g2RosiOZqVV3mkRNcYC8eO3EL8QalC7WZAQqjXFbK/aRewKzN5r1j8uhcS
	OohzkO01a9QdhVo3Fb+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAeyP-008dxk-1m;
	Tue, 05 Dec 2023 23:37:05 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAeyK-008dwn-2h
	for kexec@lists.infradead.org;
	Tue, 05 Dec 2023 23:37:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701819421; x=1733355421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K3h0JpJsw/P9CcIlBhk88qo1dFlkdlocvXXo2/hFKi4=;
  b=NZrUWpGXVRrVShHCWKpFU0ymk89Vg21KW3EUzJZmdkAlbex6Cr3f6ULe
   yxIfUT8vE9AMkPkv453kj8luEAlAu9Mz6735m6snxk5eSofGmoG2XTqoT
   QGgbxX5QUu9D+yGM244/H0ZGMuj0dJzVNXYzqHE0KCvss/DG4vEt3sIwK
   729u0VlIcjEaFhq9biSBzIn2h2LW0FqOpqcSD8Vgd9MCGN/WHgYZtcqNF
   7Ua/t0fOllymrbQcVb+t7+q4pMGJKIwJJAWiT94T6voH3GZJhvrX8zJI0
   +fpR4G0Z7CQ2XOQCgkBgXP8eUf7YV07hu9OUMs9pNuyQJ6TkGTVaPNa/o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="7273091"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="7273091"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 15:36:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="771095713"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="771095713"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 15:36:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 15:36:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 15:36:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 15:36:57 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 15:36:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRZL1k7fxQHKSKstHcakLG6Wbd73sY80K+QSPDsWzyvdYRS22m1SGPQpHdiXJW0M9759IMnWPsU/reZ2Nyhh2BMIl+mszhwhLFGYjwZhkSlrdeDLJTK0zvrUZE64FuZnYzLy1VagFp13mfTwqvzoDLp6H6YCUUzM45j+OEbH0wjDxtkmIP/D2Y/9f8gpxrE+DWfzx7zeo6p6NC5DFKIFf7vsq3OOrke8KIvGo4z136Gx2jA0V5TBiOA3fepC6jVvPmpKQo3RNWSyF2ad7+ZSuEoXmP2XuyzzZ5gyx1alAWjeU7XVvc8Jz1dM849Gw8PM57j1DhTeEQdCi2+0YcA8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3h0JpJsw/P9CcIlBhk88qo1dFlkdlocvXXo2/hFKi4=;
 b=RDRXAygEvQWs5QAE/IHoaOKmyMkWKVzzBsPPAaPszkRHd0JuzIDzfyNY1wM/uTSGTQHEFPs5f338q3RjPSNClDtnf6r2apKf1yyXlojwuErTmecx3TEV6L+I318oWHJLroVi2tYI72/zSniyzkNy/KFR7W3tJ4M2yktm4GdqPEh9y9gKKDhS8N6zhlt7HLlJ19bWRMB3zgHtBYVW18vQATE/OqKzSVhBtAAFxyY/z56WOravg96ULhDYhl+k0nfH6zMh5IGkzQGoJALTARSwxPnzOhhMCRPyLN01hIza35Y07TZGWYNJ2vgTXNnAckZ7u9BQI5fN4telZClQKtYoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 23:36:55 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7068.025; Tue, 5 Dec 2023
 23:36:55 +0000
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
Subject: Re: [PATCHv4 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Topic: [PATCHv4 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Index: AQHaJxRg2LJJnT2of0eK3PTgcDCh0LCbWa0A
Date: Tue, 5 Dec 2023 23:36:55 +0000
Message-ID: <3a080962fea97efbb8e102c1de34bc766d7a53b6.camel@intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
	 <20231205004510.27164-15-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231205004510.27164-15-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA2PR11MB5145:EE_
x-ms-office365-filtering-correlation-id: ef44d994-b718-4a8b-4fb7-08dbf5eb10c6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZP9bbKwm7E7rsl1NWK69oKj4LUDeJyGJ3b0VWKrCNPSgBuSXx+RlC80u5/Zl4L/HvnXnlibhOCkJQPshTQxmX8LXBk3vAOnN/HlSjRGp+0LW/PMxqD1RmSjG76CRRuf4A5xCNgd91opEVv1NlqxpXp9f/NoZsSihVxtnW0V0F4ZT8rxTcZsk5vv3HTsyCT8nr3wI1eqofiOZSq8jslLjJzMYwOZAsfTgSVsEQMYsHs7sbOBZZZeYoWr9crTOW9bheFdfpFSxiDeFnNmX8U23IuNnQtxWi4CVKeK2sJZwi5603jrNAsjwVczo8nBsvPflzXQOLIfzCAkRpRxaGkxpYCwD3PZXr3Lv9oUpXaARsyy5rWS7YXrBPMhbE3CXk5Es2Fdu2Rv07Mp+6HNz4X6IT1kSgSRx6BYLkg15Vj8o6AAJKruyRuFjlpHNgFeLRLrgO7zzvdgJLTKSpUlsQb5qLqc4K7skj579RlWzakFIjeAWPF+9AW2xfxuC/nU3dAoPJZnf95EkmzaeoFmLIPLbDCJP1BroEn1TCYqqcoWrtkBhhDgzos8ov70QYAZLsDogq4qYW4575Ll7FOTjPd9h429qjhk5e+rDSyc/7q4TMmOFA47fPGGT2Ipk2L2aa4m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6486002)(83380400001)(478600001)(6512007)(2616005)(6506007)(26005)(71200400001)(110136005)(316002)(66476007)(91956017)(66446008)(64756008)(54906003)(66556008)(86362001)(36756003)(41300700001)(8936002)(66946007)(76116006)(38070700009)(8676002)(4326008)(7416002)(2906002)(122000001)(5660300002)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG43U3FXMFhUaVZqRFhWV1VMbXE5T1ZwMTd0dnRUUVVSYjdNczNicFNnVmgx?=
 =?utf-8?B?Tm43SXl5dDU3YlMwbVBRZ0tEcC80QWFQK0hhRGtxVHpvWmxsYlhXOVVmbUZo?=
 =?utf-8?B?TXhLYWdQTms5WTFCS3RlWklWY0picVA3eDFrMjZxMWdCZUdDUWF5bXpPRkRj?=
 =?utf-8?B?OGp4YnpvWWhrSTk0TnlDeVFBdUVkVEtKTXgwRU80VXZRSFhwa1FtSXR4SXZM?=
 =?utf-8?B?bm1ja1hGaHpvK0ExbE9VOGJqekRjM095QVUxQUppOFNSTmdIWVkzT1hvWEZQ?=
 =?utf-8?B?elVxSGVpT2tWSithOW9uQ1cwTDVFckc3OURUMVM4cjJLL29TeUNrQytsVTVH?=
 =?utf-8?B?czgrK2MwdDNTNFpBdmo4ZndyUTd4L2NhcFNYMnNrODRna1NPU3hHN2ptWWty?=
 =?utf-8?B?Ym1mUDZFcnZhN1c0SjZyVzhmVlpGVEFMQWNaRWJYMGgybXIxWERUVFFrMW5O?=
 =?utf-8?B?NUdPU1pUSU94ZzVtQzRtWXE3TnQ1ZUZ4c205cVp3L1h4aW83UWR3WjdUMU80?=
 =?utf-8?B?OGFRNWZIRUYxMVFTWkJvTklVZ2RBNGlGVmRlK2ZFRDhSUnBNK1EyL1B6K0Nz?=
 =?utf-8?B?bHd6VkM5djd6bzg2RVRielk1VHVYamVsSUdsZ01ha2gwVWdJYjlkb1RiTjA2?=
 =?utf-8?B?Zk9ZNXUwYUdLUTFPYnFvQk5HRDJuRVovMlJQaE9CSTNnbWtuQkx5S1g5VUk5?=
 =?utf-8?B?WUZPUHhWZVg0cmNDM2diMk92aDhnSG9HdXZwczBKSzA4eHF3cHBwQ3pmeHZx?=
 =?utf-8?B?cGpDY3g0ZVJ1ZGY2b2FSRGc2Z0tCV3J2S2M1eHBaNTNMaXlMaFpvcHJNVXlP?=
 =?utf-8?B?QlJ1VjduMUNoaUxGT3l2S1VXZUlsRnZZNktzSUFiMUVndWx1T2pHQnhjN3hl?=
 =?utf-8?B?WWpUa1QvZ2ZBZTdQaHRyUm5KbURjMjdvMTFRR0Q1UUVQcTdpZzgvVThRUmk3?=
 =?utf-8?B?Q0Z2OHl6bUw0MGt5b2VxN3FYWC9HMjR2ODNURzc3MkNDRDZCTU82dEswbTlL?=
 =?utf-8?B?OXNyZjhpdy9taFRRREJNUmNwOVFWVVErM3ZGQ011cFBoRTlzWVBjOXdWUkZp?=
 =?utf-8?B?UHBUc1Q3S05ZSmZEMXYxQk0wbWVObVJ2NWQ1N2tQY29tR0R2QkM1YzVkb1pU?=
 =?utf-8?B?ZDNkRXRuUjh1OXhyb3lIbk1hY1JXQ2E4d2hlZ0p3cWk0cERsZVZKV3FsMlYw?=
 =?utf-8?B?Yi9RWlBDa2FiUXhYNGJ6K2dmaXFzZXlCNkFuN2NOR055UVBSTVMwcDV2MUpQ?=
 =?utf-8?B?UmVtSkNkWUhCK3ZDMlA5ZzZ2bFY4SHozNXNTUkxUME00OVhJSnFtazBPRkNl?=
 =?utf-8?B?elh0czFqYWlIa21SeGpwdWpPNG9mUHZUdlpDY2ErUTFTU3JQSWJuazE3Y3dT?=
 =?utf-8?B?ZzQ3RS9CTSs3MjBnZXE5L1FjTGJLeGJ5eUpSZ2pkRENpTHpTeFZVSXNicTFL?=
 =?utf-8?B?NG5tdHZJcHVYR1c3N3prZmRidEdXVTU3bzV6Y3E0a2VUeGV1VG5zb2lSUVB2?=
 =?utf-8?B?T0VnZUpPaE1scEFXNXhrWGtqQnA1c3FhL3hBaHR2Zk1VY0ZmNlZJb0JldU91?=
 =?utf-8?B?ci9RencwdC9Sanh3dlZrbmJYYll5Y04vcEROZGExbko1eGlTaS9xaWl3WWda?=
 =?utf-8?B?cDdBK0tBSWVyOGVpYVdYRnhqQnJueDRuT0Vib3FXYWUwL0RpYWlsZmtJMUNq?=
 =?utf-8?B?K0FKUWJ5RFFEVXJic3N3SGx5SVpjQVhCNmVFUnFHWUtvRkdzTVVMNTBLQzd2?=
 =?utf-8?B?Ri9PL0ZlQU95Y0tRdjZmS3o2MzdHWlcrcVBkSzQ2V05TTWhEaWc0cjBBNXV6?=
 =?utf-8?B?d1V6Q1RsY3VHOHFKQ1ZyNkgxY0hZYXlvSTJFTjl1NGc2Z1NXT0JEZVVxZHNj?=
 =?utf-8?B?eVFJTVZLS0NMUHBWN2VnNUJZK3hEOGt2c21vanp4aHhYb3pvSmR6UWZ3U21T?=
 =?utf-8?B?NEw2MCtrMWZud3dBL0tuOTZobHRSbjRSYWZEOXVJNGsyakNBK2tKV2xVUFM5?=
 =?utf-8?B?ZHVxUE1Fb3pWbmN4cUZWMnhpT3ZXNUt3bFRPb05lcTRsQkkyYUVZa1h6ejA5?=
 =?utf-8?B?OFNOMWZ0dFZiWWxYWE5wRDZBTk8yaWp2RldqWTJRWkdtaG9pQ2VudkxwZUhs?=
 =?utf-8?B?ZEROVEMxN1hCUjFmaEdlS1BQU0k4VktYMXh3MFpPTWNsZUx6d1g4ZnVqd1ZO?=
 =?utf-8?B?Qnc9PQ==?=
Content-ID: <73A22C34411FC142BCDD48E0FE9CB279@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef44d994-b718-4a8b-4fb7-08dbf5eb10c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 23:36:55.0415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dw3fE99DUC9oYbZmNMPuBnum2d5blnDW6ptTBjijrnidNRtdaZXGLOMiP+6B/UmHlbPAjPzX5atVlHoSabJ5jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5145
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_153701_168931_585D369C 
X-CRM114-Status: GOOD (  19.71  )
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


> +
> +static void acpi_mp_stop_other_cpus(int wait)
> +{
> +	smp_shutdown_nonboot_cpus(smp_processor_id());
> +}

Is this and ...

+	smp_ops.stop_other_cpus = acpi_mp_stop_other_cpus;

... this below still needed?

I think the current native_stop_other_cpus() should just work given you have set
up ...

+	smp_ops.crash_play_dead = crash_acpi_mp_play_dead;

... for TDX guest?

> +
> +/* The argument is required to match type of x86_mapping_info::alloc_pgt_page */
> +static void __init *alloc_pgt_page(void *dummy)
> +{
> +	return memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +}
> +
> +/*
> + * Make sure asm_acpi_mp_play_dead() is present in the identity mapping at
> + * the same place as in the kernel page tables. asm_acpi_mp_play_dead() switches
> + * to the identity mapping and the function has be present at the same spot in
> + * the virtual address space before and after switching page tables.
> + */
> +static int __init init_transition_pgtable(pgd_t *pgd)
> +{
> +	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
> +	unsigned long vaddr, paddr;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +
> +	vaddr = (unsigned long)asm_acpi_mp_play_dead;
> +	pgd += pgd_index(vaddr);
> +	if (!pgd_present(*pgd)) {
> +		p4d = (p4d_t *)alloc_pgt_page(NULL);
> +		if (!p4d)
> +			return -ENOMEM;
> +		set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
> +	}
> +	p4d = p4d_offset(pgd, vaddr);
> +	if (!p4d_present(*p4d)) {
> +		pud = (pud_t *)alloc_pgt_page(NULL);
> +		if (!pud)
> +			return -ENOMEM;
> +		set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
> +	}
> +	pud = pud_offset(p4d, vaddr);
> +	if (!pud_present(*pud)) {
> +		pmd = (pmd_t *)alloc_pgt_page(NULL);
> +		if (!pmd)
> +			return -ENOMEM;
> +		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
> +	}
> +	pmd = pmd_offset(pud, vaddr);
> +	if (!pmd_present(*pmd)) {
> +		pte = (pte_t *)alloc_pgt_page(NULL);
> +		if (!pte)
> +			return -ENOMEM;
> +		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
> +	}
> +	pte = pte_offset_kernel(pmd, vaddr);
> +
> +	paddr = __pa(vaddr);
> +	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
> +
> +	return 0;
> +}

Sorry for saying this late.  I think we can also use kernel_ident_mapping_init()
to do the init_transition_pgtable()?  We can set struct x86_mapping_info::offset
to __PAGE_OFFSET to do that?

Looks set_up_temporary_mappings() in arch/x86/power/hibernate_64.c uses the same
trick.

Anyway I am not sure how many LoC (assuming can do) can be saved so up to you.

> +
> +static void __init free_pte(pmd_t *pmd)
> +{
> +	pte_t *pte = pte_offset_kernel(pmd, 0);
> +
> +	memblock_free(pte, PAGE_SIZE);
> +}
> +
> +static void __init free_pmd(pud_t *pud)
> +{
> +	pmd_t *pmd = pmd_offset(pud, 0);
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PMD; i++) {
> +		if (!pmd_present(pmd[i]))
> +		    continue;
> +
> +		if (pmd_leaf(pmd[i]))
> +		    continue;
> +
> +		free_pte(&pmd[i]);
> +	}
> +
> +	memblock_free(pmd, PAGE_SIZE);
> +}
> +
> +static void __init free_pud(p4d_t *p4d)
> +{
> +	pud_t *pud = pud_offset(p4d, 0);
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PUD; i++) {
> +		if (!pud_present(pud[i]))
> +			continue;
> +
> +		if (pud_leaf(pud[i]))
> +		    continue;
> +
> +		free_pmd(&pud[i]);
> +	}
> +
> +	memblock_free(pud, PAGE_SIZE);
> +}
> +
> +static void __init free_p4d(pgd_t *pgd)
> +{
> +	p4d_t *p4d = p4d_offset(pgd, 0);
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_P4D; i++) {
> +		if (!p4d_present(p4d[i]))
> +			continue;
> +
> +		free_pud(&p4d[i]);
> +	}
> +
> +	if (pgtable_l5_enabled())
> +		memblock_free(p4d, PAGE_SIZE);
> +}
> +
> +static void __init free_pgd(pgd_t *pgd)
> +{
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PGD; i++) {
> +		if (!pgd_present(pgd[i]))
> +			continue;
> +
> +		free_p4d(&pgd[i]);
> +	}
> +
> +	memblock_free(pgd, PAGE_SIZE);
> +}

It's a little bit sad such cleanup code isn't in common code, e.g., with a 

	void (*free_pgt_page)(void *);

to allow the user to specify how to free the page table.

But this can be future job if needed.


[...]

>  int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>  			      const unsigned long end)
>  {
>  	struct acpi_madt_multiproc_wakeup *mp_wake;
>  
>  	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
> -	if (BAD_MADT_ENTRY(mp_wake, end))
> +
> +        /*
> +         * Cannot use the standard BAD_MADT_ENTRY() to sanity check the @mp_wake
> +         * entry.  'sizeof (struct acpi_madt_multiproc_wakeup)' can be larger
> +         * than the actual size of the MP wakeup entry in ACPI table because the
> +	 * 'reset_vector' is only available in the V1 MP wakeup structure.
> +         */

Space/tab issue.

> +	if (!mp_wake)
> +		return -EINVAL;
> +	if (end - (unsigned long)mp_wake < ACPI_MADT_MP_WAKEUP_SIZE_V0)
> +		return -EINVAL;
> +	if (mp_wake->header.length < ACPI_MADT_MP_WAKEUP_SIZE_V0)
>  		return -EINVAL;
>  

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
