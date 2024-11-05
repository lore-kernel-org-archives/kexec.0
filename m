Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED56DD12676
	for <kexec@archiver.kernel.org>; Tue,  5 Nov 2024 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L8xZj73mVzJEQureMtpee/NwVYIVSEb3ZaDEzVhWvz8=; b=C2hPB5jt/bZaIP
	SujSbNURo334WCqnklSQr+qUhlFhY5WRFoCtTdriYkhFlEwKWXDgBolXU7/5lS2HGwMnz6MZKynfr
	H1uQzlimnJyxuAWfVBk+Eztknu81E72oP+VF4RlcnP2BOGO3ZL//Sbx3xDxEwjvrLJTwGrskg7vac
	MgGb40Nu/U7kmqCw77npUuMo2Q6A+tsu8wpd9xNci/vAxuIK54pEjTTbImevXPuryZ6Wm3cxJAPkM
	55H+KasyxBIDvD2PVppTD9xpOQPv7hYgp//LC+bbZNSxzjyGWe5vX2RnzIzg28QyURPE6RlX3KdaH
	WaKAFVy1anm/sRkOQ8kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8GRX-0000000GcbC-01sA;
	Tue, 05 Nov 2024 10:05:47 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8GMu-0000000Gbqf-0Dq7
	for kexec@lists.infradead.org;
	Tue, 05 Nov 2024 10:01:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730800860; x=1762336860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aWatiM/UaQBp2iCQT2Oc+grpQxw7bOZjhmNbubKpEGk=;
  b=nhNWHddDfTpx/qaZI8rJ/FXV1RELHOuZcLCNlcNgf6TUF4SQ6et+6vvP
   f32y0U5nUwhcwCJ13fDjSY+NQ/RQqkXsJ8mQC0UxOtFWjPpe4ULtgzMVl
   fDgIiyG/DHZgpdAWAgUiCoF0uQMH4/DsVGPIih4ZdXmyi8f4QpPFbO4vO
   ZkG2EDBAODdnGOUSzzc79MKKCBCX5eONLguxfWPttudj+MRSZmBCa3lCl
   07xDTXrjKcrE77IW5FBUZhnra3Y44B2kEepMx2x6Qx1lxWnOce0DwPG/R
   uLrS2gvG05zYGA1o3P03GCk01cXDoRKMnFFG6e6p+AUpU6SHXeJnYMZ5h
   A==;
X-CSE-ConnectionGUID: apfQfX5VRoSytyUWtHV57g==
X-CSE-MsgGUID: LHI/qp33SL+BvTlTI9yJDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53104609"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53104609"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 02:00:59 -0800
X-CSE-ConnectionGUID: jtA1Pqf8R/2nHE6SrNk2Aw==
X-CSE-MsgGUID: 7yDRWZBORrqS6+ao66JH7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="84059938"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2024 02:00:58 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 02:00:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 5 Nov 2024 02:00:57 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 02:00:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYrWYXU89K4mzzeHIwdYNDQw89Xq3B/L6BZl/UFXmvxy4mEmUxpBrytD7YFqOtfxXoO2Po9doWwwwau6nqeQkOYycRwRl5jyw3CoweDMrYvwk5s8ulwODQQolMYDLctterRs+APHgI5hi+sw/8o5h/Kx4xNnOC7ZtkG4qKRke/L2ceBnJsCSQ9shdzONhbMR8WPGlwBzhlvAtRY3sm4t4K+jp6c0aBSpAxSz5mQqRhNowA3cauLQEeryNpA4Heizy3ETTOCHudHPL2E2ho4eaq2gLxBsXV/7QGgKf/heJP9nouXh3TdCPqNT+JFAuKxAYtZjqyScKSWZw5ZRjGlQTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWatiM/UaQBp2iCQT2Oc+grpQxw7bOZjhmNbubKpEGk=;
 b=lv8PPN78VCBqmVnss4TklpWzH73GV+I8nre1Iv5c94GTEhidGm5iRPDH/aQIEu4a6Pgz2AjiFxGxZNOGnekdvPKBQqZuRDfPOixgoGXwuPdP2ws1K/GUjtdc2k1jBFnRucjgy7LAX8c5rM68JLobrvT1aG8oTisbtvmtecI1Azn7OcLSBKzdkl0YRu0h37KjbH5r41UYoFaJZsgFy15hOqMDv4x3FdfBprGPh1WfCZ/vdOa1StI0wt+TnnS7M6DBAla+scbSsQaPhk2qrp3gt02g6a7jdCxvIos4e/lW57R4pK5S+MMS8ANNu9ZDt7V+0CA7wyKk5sSC5rRoCt1OmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB6121.namprd11.prod.outlook.com (2603:10b6:208:3ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Tue, 5 Nov
 2024 10:00:55 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 10:00:55 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>
CC: "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [RFC PATCH 1/7] x86/kexec: Clean up and document register use in
 relocate_kernel_64.S
Thread-Topic: [RFC PATCH 1/7] x86/kexec: Clean up and document register use in
 relocate_kernel_64.S
Thread-Index: AQHbLbL4YouOxajXUEGNhWd+ldKSc7Kod8yA
Date: Tue, 5 Nov 2024 10:00:55 +0000
Message-ID: <b7282cfd3cf15462cfbc89bab9c09bcb8791b33c.camel@intel.com>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
	 <20241103054019.3795299-2-dwmw2@infradead.org>
In-Reply-To: <20241103054019.3795299-2-dwmw2@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB6121:EE_
x-ms-office365-filtering-correlation-id: 66e75bdc-32ec-4e96-c4a4-08dcfd80bd52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VzZDcm9JYWNJdXVQSjdHVXozV1ZQL0lUckNOcFVJc0dqREhRS3B2bUlDdXps?=
 =?utf-8?B?enk3VlJha2FocERxU0dUWSsxc0s5NzVtOGlpbWxhbmVrNDBTSHhTdi9NRUdX?=
 =?utf-8?B?R092bkN1ODdqOEZGeUxON2s2Q2pPWnp2Ny9VNnQ1QkxreGdGMUlQSGFBL1J4?=
 =?utf-8?B?NXl3TVpwVUFYS3Z2VGo1NFF6bU50OW9SQ0F4eDdVQ0I5dmZmRkZpZUJta3JR?=
 =?utf-8?B?dUxlMVFrNW9zbFBEbkxONjN4ZWNiMHFRSDJXUUFWb1pQemQxMVNnS2ZXTUJU?=
 =?utf-8?B?d3hSaXBNWU5iOEFxZHVmN2dRYnJXRHJWNzllZFlQM0gvV3A5TzlWaVVMUHRP?=
 =?utf-8?B?TGlZOWlZMVRyZG1ocmp4RjZGaFlIb0xsZnlMcHpQQnprR2pQcVpYdUdxQzlW?=
 =?utf-8?B?ZXc3ZjAwR1c1eXZDUEUza1JBaXF6dklobG9qTXhmQXNzR0xrNE8yMzVZQThm?=
 =?utf-8?B?SUEwWURLaHk2MDdxdlZOVEg0UUlaMFg0dWUxRmdWWXhxL2UwQjQ1SzRCZFhq?=
 =?utf-8?B?V28wMGcwYjFLbENmcFI1RTlXUlo3NkNWelJsN2luMnJZdFBNeDNERmdQUk1L?=
 =?utf-8?B?NENKV0l1R0hlTWpUNHlGL0owTUgwUmZVbHVyckIrbzRQWi9DcW5qQlF3Vy9W?=
 =?utf-8?B?V3ZxWGhNSTgxWDJla3VUcGJ2MzE2YnVBV2J3Z2dqVWg2VCtaUWY5aWNVZnhF?=
 =?utf-8?B?NU9iMytzc3dQRzNYNklHUkt3Z09vc0IwM2RoUnJIYVpiakFpZGVHMTBzNUhG?=
 =?utf-8?B?OWp0UlRFejVrdUZHRlViM1FwYkUvWU5lM3gyOUNGTXlTNk1tWUhvMGt6YWdE?=
 =?utf-8?B?KzZ0ZU9yVUFDUGVUQjdlWEFZeVUrakNMUGxqVEZMTzhUV0IwRG5HQ1U5dlBY?=
 =?utf-8?B?M05xbnpUQkFBR2hKZDdwelJ2cDl2S1NjalR6TnpYVUl5N1JTR29uaTNhdi92?=
 =?utf-8?B?ODNYZkFqemxpY3FPaGxHMHF1QjNpWllZa053RlRWTGFuVVQ2SlVSTUJndUpB?=
 =?utf-8?B?RmZRQ2Q4cnFac0NwWlFxOTV6dWNxbFVLblNXYWEzNW1KZGs0d1ljWkFBUXdF?=
 =?utf-8?B?RkM2VnpIbDl2akt0ZzJubTNLOEFWanRIenJYOExuNFJyY255MWhwRHl1NFlh?=
 =?utf-8?B?Z1JnUUt0VEJYaDZkb1Bld25iNG9tWm5vekFxeDZ3dysvbnQ0VVhHWTNTTTI2?=
 =?utf-8?B?a29SWHpMS3RrK1VkZFJ3ZWZ6dVNmM25ETVpjeVUwYlc3aTdDM2JBbC9jcW1L?=
 =?utf-8?B?Y3R5OWRaYlJmdjF2NGtOLzI2aFdvdTFRVXUrelNSbVNuQzlUVnZUUVRRbVhq?=
 =?utf-8?B?MHZ2N3hveUhBK1BNOSsvU1Q2cnFScm1VWG5LTW9TNDcyY1VSOHlBZGhZSkF3?=
 =?utf-8?B?bk9MOXVTSHRpYkZUOG5VWXJvYnd0QXJ3bW1lKzBMNzhib0ExZXdKR2dSL0Fl?=
 =?utf-8?B?U2R6eWJSbG52cTMwT1V3K0JOTkl0ZmQ3MzNITUFxdi8vcHdCV0ZQTXV3Zzcr?=
 =?utf-8?B?KzlxamVWTW9odGJ3VnNGTWpIOHd0Nlc1UjhlWGtLRU9XLzBYdUhRaE96MG5v?=
 =?utf-8?B?SzIydVQ2dFRwZzN6Ynl2RjZjcjVzeWVSQnpkdGgxVG5QT0tsR1JpVVBFK211?=
 =?utf-8?B?eSt4ODkzdTVJSkU5OU9CNXZ3N1Qwd092d2h0RGZabmRIbDRZRlNkbmEraUlE?=
 =?utf-8?B?OTdBNGhuck1LVXhDTnlnNFNzaW1QOWRZYUhmditvSFVyNTdCbWVLM2lKSEdr?=
 =?utf-8?B?NFlHUmlxejY1NkMvWmd3bG4vM2NacWtZanF6d3lkaXhqL2x4Sm1tTWxaUHVV?=
 =?utf-8?Q?FlR0UFh5a2eZz4dK+TMtOENSjAW9LV54lEl8U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnJJTk1OYzN1Qm9OK0pZUk5pR1p2bzJjaE9OS01xYjh2QnQwYTlxZSs3WWhS?=
 =?utf-8?B?Q3Exdkh6djlyTHk0R0tlUzBBMngzNnNEa3pSc3graVVuaEhYRFBvTndxM21H?=
 =?utf-8?B?c1NtR01JK25IZURmWFBMZUlBSG80dzR0akJGdWphdDRLbzRvTGxDNktndmt3?=
 =?utf-8?B?NlU1dkJoQ25QMjRFeDZteUw0NWJHUWRGeWhOSlhoMEpMbXp1bjkvS1psV3B1?=
 =?utf-8?B?VFZ6NTFYTTB5dTBrUHNtcXFUdFUxOHRQRHRXazJ0S3RBdjErTGFFZG9FL250?=
 =?utf-8?B?ZUpySXJrdFRlRzcxQlZCQ2lNYUg4WFQ4RWpLcEs4dDZsUjRvbzZOMlU5TDFH?=
 =?utf-8?B?NzJWQVRtWUtJbEZleS92SG9hSkp2VjB0M2lnYnh0ZXR0NmVaRmxhbjlYS1RM?=
 =?utf-8?B?UG5DM0lqTHBlbmlyY2dZc1l5dGhLMktycCt3Z0VGdVdjbDdRR21FN2tFcktZ?=
 =?utf-8?B?NXE3TGM4OGFwVm1ZU0tZaldTUXJtcjhaUEhwMW85TCs2enJLNXlvT2J2UEpy?=
 =?utf-8?B?d2hWcWpOTlJzKzhGVmdZN3E4YUF0OUt3NXJFWlJRNFZ5T016TnJPV2l4TVEy?=
 =?utf-8?B?bjU1V04xWFhrM0N6T1VXR1hqRld2ajN3VmsybzlyamNDVEdISEJtUFp2R3ds?=
 =?utf-8?B?T1FzZ2prdXkvUHRZblVTdXdpeWFManVqa1JTVGMzU0Q1QlQ2ZUNZV2xKdWNB?=
 =?utf-8?B?TFpkak5HTjBWdzFvOVR3WEVpNXhBZ1Znb05lZ2EwM0tlYWZIRzFtWDByTndw?=
 =?utf-8?B?YnMvcmtMUTBNbXJBcC9NL2dhL2FuRW5LVFhFTnhlVUpITmV1N3JPYjVJaWJy?=
 =?utf-8?B?MnlkS3hZVFJDTlFaSjBCZUtPazJZVmlWUCtBUTB4aDF5VURFd3plaElNTlo4?=
 =?utf-8?B?QmxvdUJ3eFJZNHFZWVVVUjMwTDZ4UjBLQVA4NldZWWdUc2dDcFB0enR3dStZ?=
 =?utf-8?B?cWNROVM1aVVDQUk1MlhJNUFoMFBPUHJERGFxSTE1VVlYc0UxNnkyWU1VWkRG?=
 =?utf-8?B?NUE3UDErRlhXaUd6SU5LVXJPa1JIZzJpRE54ZnlMLzlIeDdZaXN6YlFwcFRm?=
 =?utf-8?B?eDBIeSt0a01SYVNLaHFZZUFFZTd6WHNvQVlzM1JSLzVLYWl3SmlMelpCQ3pE?=
 =?utf-8?B?WndPaVpsOC9wWk9rOFlIZWRLVHplZXprRHVIdVVmcUhwaXVsU1FlVE1GZDZr?=
 =?utf-8?B?RnJxRjZJWnJiSEJoRzQrM2JEc0NTRXVnakZtU2RQUngyYkQ1VWJUTG5xYlN2?=
 =?utf-8?B?VmUwdGxXVlhFQlJiUTE3cVR0STZTekgzN1BsemFKZUkweHhoczZ2clNuVE84?=
 =?utf-8?B?b0NIcWd4RFJweDVpQ2xoSUhxekNENDlVK1NXbHM3V1NyczJUTEk1UUlCazY0?=
 =?utf-8?B?dkRvcmhVZnBaTEU5VmkvUmtYOUthRkxaWnhtWFY5bnJMRU5WWEJTRUdRaVZ0?=
 =?utf-8?B?Y3I1ZUhvSDRYQnJ6WElYb0RpQnNmeVI3Y2QvMkNVa3lQaXJFSTFrRVlQbEwr?=
 =?utf-8?B?VXQwZUUzZ1VoTkRXdm9xalZkbG5QRXZWOWliRVgwVzhHc0VQKzBCcUNjSWxo?=
 =?utf-8?B?NmErNlhWSDdMMHhxWmVGZ2I1S0w4YU05SDVEVU5sN3g0TTYxd2VlTStabUh4?=
 =?utf-8?B?LzlVMldQYjlVbDJLeEQvUXIycE8rWnFTWmNNcWsyc2FzZnVXb3ZaaS9zZ3RT?=
 =?utf-8?B?dlVHRG9FcUUrOVFMV2llbFZqbWEya2J2c0d4dUNZSGVKY1FJaStmR2xQVVlX?=
 =?utf-8?B?c3VkRjk5RFJBd2ZsVEFaU2pCc24wajJmTkM4cXA0UHdUeUVJQjY1STFyckJy?=
 =?utf-8?B?N3JvWUNPb09rOHVnaDJZUm82c05oWjA5OUNiRXdyQUdwbitTZHNnSHJHTVJi?=
 =?utf-8?B?SUt6YXRuYXJOb2pZOStUeld2Rjl1ZlNOVE9nQmVuSFEwQ3lkTjVBUkpILy90?=
 =?utf-8?B?U0lTS3lNMjdZU2pGUzB1OEwvT1dobkx6cnU5QmUyTDQyWnVScWE0dXV0RlNJ?=
 =?utf-8?B?TmkydXlkWHpwMkUrUDlGbFZ6Mmtjdjdxd2hnZEtQMmpMeVhsK0QrRzJFRTRp?=
 =?utf-8?B?ZitsY0Z4WkIwQWlGdEVHUmZlMXhVM1RFUGtNandTY1BURkUyUUZaRXY3KzBE?=
 =?utf-8?Q?QfwPaK8omh6qccmKDWLGk4sMr?=
Content-ID: <28C933F35D6C1C469A9D5AFD7B88334A@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e75bdc-32ec-4e96-c4a4-08dcfd80bd52
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 10:00:55.3305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IsGX3ZuANWQRVzq/6xEmsA9/ib6EqNqC46iMLW7t2dbKk/l102fGnGG/yqzJQheJCZwBzBy45aruZAK44wgDMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6121
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_020100_193531_B8C96BB5 
X-CRM114-Status: GOOD (  19.40  )
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

On Sun, 2024-11-03 at 05:35 +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Add more comments explaining what each register contains, and save the
> preserve_context flag to a non-clobbered register sooner, to keep things
> simpler.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kernel/relocate_kernel_64.S | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index e9e88c342f75..c065806884f8 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -100,6 +100,9 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>  	movq	%r10, CP_PA_SWAP_PAGE(%r11)
>  	movq	%rdi, CP_PA_BACKUP_PAGES_MAP(%r11)
>  
> +	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
> +	movq	%rcx, %r11
> +

Seems moving this here won't break anything.  From functionality's perspective
there's no need move this here, but fine to me since the move is needed for the
sake of adding the comment (below) to identity_mapped.

>  	/* Switch to the identity mapped page tables */
>  	movq	%r9, %cr3
>  
> @@ -116,6 +119,13 @@ SYM_CODE_END(relocate_kernel)
>  
>  SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	UNWIND_HINT_END_OF_STACK
> +	/*
> +	 * %rdi	indirection page
> +	 * %rdx start address
> +	 * %r11 preserve_context
> +	 * %r12 host_mem_enc_active
> +	 */
> +

I think adding this comment is the main purpose of this patch.  Since we have
listed 4 regs in the comment, how about also add an entry for %r13?

Something like:

	%r13 original CR4 when relocate_kernel() is invoked

Yeah this is kinda mentioned in later code but it seems it's more complete if we
also mention %r13 here.

Anyway, I suppose adding this comment is kinda helpful, so:

Acked-by: Kai Huang <kai.huang@intel.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
