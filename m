Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD457C47073
	for <kexec@archiver.kernel.org>; Mon,  8 Jan 2024 03:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=974qZ6dfjbttEoJ6QNfKZ3nU3590ciixEbnXUXHMCyQ=; b=a84Mugx+XlZ+ez
	QY6i1ckQeHIVzn6O2utGAFKXh2VRO/yzJ0j0LpKVmXDrhR80h+NVU+fmrZvFxK7CXRT9NnTt+cEvw
	4GQiVOHbr/jXTRLYnt0FnbRyRqyy6wvumJMh8i0tSiiSF4HocBj100DNtwPPdxU40onOz0JOF+V8D
	XknLR0RfpysUGZbv7PHpF1A5GoCoH0fJKFeXxxVtTNzhr7OszNyZI4p+sF9mjrTrjdCKdmvqRvp7b
	M8REwEpIesh+kuAkKc+lWcLnVGsWQODO5B8vXgpFVCBhMNMvV6NadfwoCDK6o4yuWUbp704WJEuwj
	Y83DDn8V5K8axSDiNbrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMfwU-003sac-0k;
	Mon, 08 Jan 2024 03:04:46 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMfwR-003sZl-1M
	for kexec@lists.infradead.org;
	Mon, 08 Jan 2024 03:04:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704683083; x=1736219083;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vfi6p3l2hPvrsKn6u3wp4uxBxGCZfWf0ElucQpI+cmY=;
  b=LCcd1EKIPtiL4Bhk16t/ZgaoCrW+NWQnH94v+/JaSehOk2tmB0DKRrm0
   81fECuFKW4G1vniAFMjT+CR1SCFSUW7DTtlzbM2ilph2xSVaybuK6w7Xy
   OHwuayJDkUyMIs/f2C7ks4NxW3JUHhTSa2s9vQ0kFKzebKg0PaN1snLTf
   6FVQEPLGufkTUygNPJmlS0Q/gzjDujhiW683FEkqceaa5VO1xz2B9lzEn
   6WvmxGcycmjHnrhb3NzxqUywsP6WVbnTTdUG4+Qab5RX27IEhPoyOjO/e
   yKSN8OCXuDBWROxBfLbYv+sY3jz3Jf/TjBARAeQfsIRbbD/W4hhDRbBjQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="464183345"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="464183345"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 19:04:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="954509346"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="954509346"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2024 19:04:34 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 19:04:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 19:04:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Jan 2024 19:04:33 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Jan 2024 19:04:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilgevlVZuckEESHWjjI3eRhkS1iulS2wEKIB8aN8UGtljHXvABWeo+QxTH7cXNE6bgPBzjwT0+F1ETnovlzwu5KkgUqrRLPRsOVf9qWt1kGGqSvqhjuD6nlExp+rxFYX9RhbNoy2ds71ZIbNH+IWD/ysXBEyu+iUZ334HWJDKu5e3i1MK9kJ/VnonN6qeNM8ghEPzhYJsT+kwYfcmTIFQqtFcoQHWa9bngJZ9Q85lL4ykmspon/gBNMvkuBSiooupC2Zu/VSwrzp1wVsIHRE2Fch57ZyaVnUlW+nrkLDxrQ95eA2R4Tb5Zx1bT2W8NgNFct0q5LqHr4fhtqi2bTpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfi6p3l2hPvrsKn6u3wp4uxBxGCZfWf0ElucQpI+cmY=;
 b=hCAbBVNusAfAYY9OjOc2x0ke5q8uABwQE+SDf/DaklJIiabpuCeLlrujFBofVaP6OuKM2uSuEBYxsUEmQNnJsLtzAXjn9Co0Khi95RD4VDGA9slHKUbmfzlgMJtqSVknYCob6GFXeeO+Kd0MH5cYezm6FgN1/eSLAfhhqUpp5lXuAhUOsNwdi1Ok0Pnow28y1F7M74EvKrZU46cE+nQyIootshTyAmMlp2cZxqJaTHNsYg1OaDk4Argmc4RB0ojLLIhw1NW546cb4eNd15a5YvHA7fXm56GfQHwe/fSZYK3peGJjb82ZuL2nsLlE8tZEGDhWrkFphkjhyBDtdPqI/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 03:04:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 03:04:31 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCHv5.1 14/16] x86/smp: Add smp_ops.stop_this_cpu() callback
Thread-Topic: [PATCHv5.1 14/16] x86/smp: Add smp_ops.stop_this_cpu() callback
Thread-Index: AQHaNwlbb6SzZl77y0qzncigU+XbULDPULYA
Date: Mon, 8 Jan 2024 03:04:31 +0000
Message-ID: <d23475c878ce1bc899a6b9f613252e985d97d094.camel@intel.com>
References: <20231222235209.32143-15-kirill.shutemov@linux.intel.com>
	 <20231225080524.4240-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231225080524.4240-1-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|LV2PR11MB6048:EE_
x-ms-office365-filtering-correlation-id: 6f0171c0-66c7-44d8-c3a9-08dc0ff68939
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GhBcX31gujzJf1Se3KSYu/wI3mDPgmMJPn8WuogsKMxvfS7XSt7nwA2ctssKs3EW13VekBYzdP875baRYMqfk8FuSZdMeGmcMymB3dHCrv5tlSKP3/L8VA7T09TAcDM1N+xhbiQWDw9xTm+hZkbB75RWJeG0yypD8s/r5P0hrYpuD1MCUEi6hA/MfZ+DeDclZBlufTIKiEPXb2KWxJdyQ7IY0jTAExyqphDDNyI2yDmf30/cY8HFqCK7tvUaEwdQGShDE3fl7SI7B9NZL0PNvDbl67kXar4FwvM3B3baV3eqzbyZ8dwWmNfHGteMDRTWjyQgoExQEQswg5IUV3G7SppQcTARuZ3erECdbX9BldhuE755WPPTKAbwtbqa2G8ua4Ds9zPKi80X2eevC0YzEYAIblKetpW8+Pv9MNHRV4+/YQS/P7G+J6tvRDnCig12ksptqEUHQ60pPC/r1jP1JAVpwlp4dGq3VfZP/hFmk4weTO3XV884rCokM6il5V6NmMoxWLcgd7GJsozXSpbOiqaiRWuVwYCCLPvqPktSNTDkBp9h4j9JGnqG+t1ZQFMcx97cvAZ2rcoy9/Vv9baDXY+o3pcKyTxu25dYpzNnfF4eollElaMmUGKztb3GnnTD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82960400001)(36756003)(8676002)(8936002)(54906003)(316002)(6916009)(5660300002)(4326008)(83380400001)(478600001)(6506007)(6512007)(71200400001)(26005)(38070700009)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(6486002)(2616005)(122000001)(41300700001)(38100700002)(4001150100001)(7416002)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHFHR3VQdjFnN0FESU9Va0xaWmNwQVlyemt3ak9Kd1hwWDhZbjZSSjNYWjhj?=
 =?utf-8?B?SjQva0dNZG1hVzh0VVVCcjQ0eEh1TlpxcXhUOHdVaDFHZXhEY3R1eVVNMFU5?=
 =?utf-8?B?SmRBYUluU3J5c3ZRSFkrbXpIZ2VUemgvV0phTTZxSWhDNXZyZGZEcFN0eVBP?=
 =?utf-8?B?aTVYeG8vRk02Z0cybDVkTVhkMzI3dGxoYS9yV3Jnd2JpdS8wYTNXcnJCZzRr?=
 =?utf-8?B?bHQ1Kzl5djU1UzV6T1daZ01wNlQyQ3BMSWRQV1M2MWhlc0dZcHNobS82SG43?=
 =?utf-8?B?eUFVTVpObEJsU1VsM21KOFNhYnpDdmNBZVVwbnhTQ1ZpeWZEaUVKM3JHc0NU?=
 =?utf-8?B?K29zTlNHY1YwNVV4UVdSUlBhaG0wVE5YdFlodjVOSUljcnRZbXdNaENqVVN3?=
 =?utf-8?B?RTRwTjMwdDhxSU9Ba0ExTXpILytPZktITVovd3YxbG1MRHUxVk1ZSjZNQjVL?=
 =?utf-8?B?OGJvN1NjZ3JEbEY0VG11Zm1obU5LQU5aOGFPRGZIeXdtWTlMak5MNXR3K0lC?=
 =?utf-8?B?NFVreStUQTlTc253eklWR0NYSlhLUEtVc081alRUQjV6cUEvWU1ZRS9mcUVq?=
 =?utf-8?B?U2hEYUxzdnpjWTcxV25Fb2ZBSUxDTmMyQXdHa3h4cVhWakVlTEVadkdSbGIy?=
 =?utf-8?B?S1A4TG52cUNSZFU3bWxmNG44Z3YrU0s2WkkyM0NtZG0zOVFvMW1ma1hOL1hF?=
 =?utf-8?B?Ukxib3RaZjBibElRTy9uQ29PcEdoQzd1MVpralVSS25kUHNaTEZWR2dLaTRo?=
 =?utf-8?B?Y3BQbk11b3JzZTdnczB6Q1NsbzdBeE9yNGhSbW1tNjFxLzl0c1ZuckRZQ3ZU?=
 =?utf-8?B?QVV0aEdaL0FneE5SbEdkS2M0UEJEWlhLS0RQUjNESmpUZTJVVTUyQ0MwVjZJ?=
 =?utf-8?B?c3dRT2xhSmJaSVYyTnhIcUtLMHR1Vkw2YjQvY3dNenN2ZVZOMU9xRHZpN2tM?=
 =?utf-8?B?NXlNQXlubTdDL01XSHUzTjVuUldGZGszSXpjR0tVVk1ISFdpL2VxZlhtQnlr?=
 =?utf-8?B?RXVYOVdaa1lBUmpYdklkcHU3ZkNwSUFUQnVxQ2hlMjlKZW8yNVhtWmV6YnZT?=
 =?utf-8?B?QkhxeGVDN3A1bFhLTXVBVk9jMjJZSW1DWTFXQU9HQW5YVUk5OWd5MEplMTV0?=
 =?utf-8?B?dXppVHRwTzBSYlZoREEveTRNb0drUEJHUk80b0ZLTm9sZnl2OUNQUThQZzRl?=
 =?utf-8?B?TDMzN1paMUUvRGE1aTFWU1o1M3U2SlAxYythcGNiWTdDY0Fwa05sTXgwcExl?=
 =?utf-8?B?N1picGZLaFhSeGtsMGoxWUo1QW1VY0VvRzRpVXNJU2o2dHhsY3JGcVoyUnF5?=
 =?utf-8?B?ZVdvelg4ZmNhb1FkbmFOcVVib3p4ZjlKek1QemNlTXBBUUs2VDdyU08wMGFi?=
 =?utf-8?B?eWZwZG9FY2U0eWx2b244dWZaYno0cTNLSGlaREhqWnl5QnZKdHNaMEp0K05D?=
 =?utf-8?B?NE9iVytoZlFMMU5GWkp1d3RNaUJ5c3Y4K0VRd1pxUjc0RGtNbEFvUHc4WVFl?=
 =?utf-8?B?MDVPRVFZRGRBT2JOOGxQMGY4Y3VKNS9RR3FEaDZHcStjOTF6OGJtbmpYeUF2?=
 =?utf-8?B?dWFnUnUrdUhUa1hnditiclN5UnBIZUxCZ01KbTZJa2o2SFdHVi94dDB5V2FJ?=
 =?utf-8?B?WGUxVnYyMjNSQk1YNWZkV2tNWTYxdVRIRDFFODFTUWlpMWhPbzROMUM0RlB1?=
 =?utf-8?B?bk4zRG1VZlRJMzkrS2VxR1JIajVmR3ZkNWFBYWRGZHptemc2SVRCVkQyZ1Ez?=
 =?utf-8?B?Yk0xUzcyZThqcmlJbmE3VjdOU3cySkNPSFNCVDNteHhYaWRXdU8xdjkwRlEz?=
 =?utf-8?B?QVRyWTg4V2hTRE1QbkhKNmFwUTNad2E0d2o4UDB3WnRlVEMyK201L0dPeVda?=
 =?utf-8?B?R01GUGRoV2xUbzFCR0hzYmxJSWJtcjBZVVY2Q20xYjNtdSt6SEhXZHd1S1RC?=
 =?utf-8?B?bEJmUG94cHNlQmVvWHp3UFJEeGN1cHZ4YS90L014cDdSMnN1eGIyaE5oWU1D?=
 =?utf-8?B?bVhPSC9NaWhhWlZ3WnVBa3dIL0xRMlFlU0ZTR2dqZFI0QmRSSmJIckt1bWVJ?=
 =?utf-8?B?cmdicmNpejRVRWZ5blRJcHovcFgyUHF2SEFHaUlFVnJwTUE0eng2U24rUnRP?=
 =?utf-8?B?MFprS3dmZGJrQkVFNGI0Nkt6bkZQOGZtdVR1KzE1VDltVzZrczl3YWpSZmo1?=
 =?utf-8?B?U3c9PQ==?=
Content-ID: <49EDB7409C153644AB3F036E06C7EA0C@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0171c0-66c7-44d8-c3a9-08dc0ff68939
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 03:04:31.8383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Tg2BnrJ7DsWirrlUYsvaR1GYCP5ao4AWEvnGcZ71pXXxR+x5m5p4WHayc2s1j6rQtRYzoCwBRkZvs1EGbo7XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240107_190443_547530_3A1B57C5 
X-CRM114-Status: GOOD (  23.28  )
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

On Mon, 2023-12-25 at 11:05 +0300, Kirill A. Shutemov wrote:
> If the helper is defined, it is called instead of halt() to stop the CPU
> at the end of stop_this_cpu() and on crash CPU shutdown.
> 
> ACPI MADT will use it to hand over the CPU to BIOS in order to be able
> to wake it up again after kexec.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
> 
>  v5.1:
>    - Fix build for !SMP;
> 
> ---
>  arch/x86/include/asm/smp.h |  1 +
>  arch/x86/kernel/process.c  |  7 +++++++
>  arch/x86/kernel/reboot.c   | 12 ++++++++----
>  3 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 4fab2ed454f3..390d53fd34f9 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -38,6 +38,7 @@ struct smp_ops {
>  	int (*cpu_disable)(void);
>  	void (*cpu_die)(unsigned int cpu);
>  	void (*play_dead)(void);
> +	void (*stop_this_cpu)(void);
>  
>  	void (*send_call_func_ipi)(const struct cpumask *mask);
>  	void (*send_call_func_single_ipi)(int cpu);
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index b6f4e8399fca..ea4c812c7bf3 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -835,6 +835,13 @@ void __noreturn stop_this_cpu(void *dummy)
>  	 */
>  	cpumask_clear_cpu(cpu, &cpus_stop_mask);
>  
> +#ifdef CONFIG_SMP
> +	if (smp_ops.stop_this_cpu) {
> +		smp_ops.stop_this_cpu();
> +		unreachable();
> +	}
> +#endif

If I read correctly this will result in stop_this_cpu() having different
behaviour for SMP and !SMP build for TDX guest.  For example, AFAICT
machine_halt() also calls stop_this_cpu() on local cpu after it stops other
cpus.  So for the local cpu, in SMP build it will calls into BIOS's reset vector
but in !SMP it will call native_halt().

> +
>  	for (;;) {
>  		/*
>  		 * Use native_halt() so that memory contents don't change
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 16dde83df49a..738b3e810196 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -881,10 +881,14 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
>  	cpu_emergency_disable_virtualization();
>  
>  	atomic_dec(&waiting_for_crash_ipi);
> -	/* Assume hlt works */
> -	halt();
> -	for (;;)
> -		cpu_relax();
> +
> +	if (smp_ops.stop_this_cpu) {
> +		smp_ops.stop_this_cpu();

Could you explain why unreachable() is called in stop_this_cpu() but not here?

> +	} else {
> +		halt();
> +		for (;;)
> +			cpu_relax();
> +	}

Similar to stop_this_cpu(), if you also call unreachable() here, then I think
you can remove the 'else' here but directly calls halt() + cpu_relax() loop.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
