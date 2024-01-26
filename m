Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6B3C47422
	for <kexec@archiver.kernel.org>; Fri, 26 Jan 2024 14:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dn+xpf+5r+ax4FMmixcZhzozLzm0Y0LUf5adncXoqFM=; b=PrIF85+gKOz9o8
	mqTNi4iAMe/h4Ekj7H76eAD8qYP64yD4cnSuolYgg/gB0fmckgyIDWHjzAaUHMCuri1UthsIrIZb7
	aNQVahDoRywJA20Ytd65tAEIFxKRl/vXnZ9ADFE3Soi4zmc3ya2kdqm1VVJCEGCH6+Iu+Zk1vmnTl
	TE21BJPoa+F40kwD4KU0SF4OiviXWQzXP8xtcOldV5kAz28Ahb2KM8yDFFdLj+sBkrGYCzOoVLah1
	L4bICGCYwjRLI/qB/W4wYIq1HpLQwZ0LMmP9kMWTOVtBgKas2fT2N2EkHrOKCByEtsWmzcZ3vns/S
	DRhcuUwWlOc5X9YMUVEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTMur-00000004I4v-0zXR;
	Fri, 26 Jan 2024 14:10:45 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTMuo-00000004I3Z-2okO
	for kexec@lists.infradead.org;
	Fri, 26 Jan 2024 14:10:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706278242; x=1737814242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w2xNabLH+9NMKBHy6FPG3DGT06PO0EFnNX0vz/2PWho=;
  b=UK9OLub+Wk7armsh/qMMftSwolipCA1stcqhPJROvjmzxACQunUzrXAY
   ZCDa5UsZKu1IxH+cn53O8ghfVBXqacGPrwpq9Xx0ghiREC/ljEA3V8/zr
   6VSuhhgrku/WO2OplguSgZrL0knCKnIDusu3fRBu1K3WBHuAUF6/rzMZj
   c9Ds9dCDjmoTg00SqGCzzm2M5t7+ng0GBRy/RcBSeVEX2TzJvyZRYQwVL
   NVGzjIQ1ygK1yWO7ZlheGbxomf+CMbRBRra/cp+8wW6k2PD7b7og1WWN6
   B3Mlwfo/dIkMu1s5HVMFIGguxORAZ8jaDciFZhmqfbSivui3K5z9kODeX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="406210602"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="406210602"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 06:10:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930378244"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930378244"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 06:10:41 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 06:10:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 06:10:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 06:10:40 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 06:10:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvBbAPSIkEeoYZ0FMR8MYu4hocECGIIucI7FO4P0qOhBiqcmlJj0L2f22V7+l1Ulx5U2en7e9nw/TA34OjeJ8YgpvmD3xMiHC4ChnN1mwfuOub2RyVXFQEvmS5IgtK0/i8DzCLohYyQXbqHMEKjLYIOvk7j7K+7oONbcYLBcIK5a6Ah4JyoOQ05Y3b8si6hT4d2hg9p6hxYHzuFFI3EhSkKYnkO3U/dUh8o3Hf2fJVJkXKBhpnQBq61uxJmOK+//84+3j0PL63QVN0FEuEBAFFJUeKzBGRDtkTrYw4hJCraISeOptrMcY22LdnOOQUDhG2GQnQ+e1MjsBmpKfnRPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2xNabLH+9NMKBHy6FPG3DGT06PO0EFnNX0vz/2PWho=;
 b=P2z8MugGHHf0kWDcq3MRvbr6iYQugQM4SzRXLyXjdPKWkDvJqAWQZGn17ZGVl6rmM7GsjDfe9GMmwXwFa9sh4HaasXepPlDi03juMBuzql2sknEPE29W2DjmgDGpkvT1GwhO/4xL+bW0yl0Ry1pUHj3PwAxOFsJ/z3ruC3Y7aoPPOq+cdQcKAAZR03BuRTH8dm+/vcimVOBlW1JuZG50jjx60pZS3M1t26xvtadZG5tpn7v3YA72bqXQAd699w15FPPgWdRgl1JKpJuOLz3plh1tgoe4+gKkEux3qM7C0E8vUC8ljGmk8thyLk3QgTNr+iWOWbYV0n3izfFP3xtJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 14:10:37 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec%4]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 14:10:37 +0000
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
Subject: Re: [PATCHv6 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Thread-Topic: [PATCHv6 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Thread-Index: AQHaTsTx74MyFSJEiEuU67rhNLvRArDsJVKA
Date: Fri, 26 Jan 2024 14:10:37 +0000
Message-ID: <f57921c8de497c36aaf0235679efea3f9844d471.camel@intel.com>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
	 <20240124125557.493675-16-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240124125557.493675-16-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5262:EE_
x-ms-office365-filtering-correlation-id: 61dd24a2-d5cc-4ec9-83ff-08dc1e78921f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0V2J6JCyo3qq0oTfpaAlQD87Oec0u8rW/jLnZLO9KDiFRg/hLDhFh542RxaZwN31uzsA/KsoIvwhaslvrFW/CJbKx8i7fO/yM5FuaxFkvSwR7tM1iUz+5hUjhLdqxff1pasW340OaTIvv2ndyhT+pLJxt3KDTub7ivaxVoSjKz+NtEeClVf+Li6gAust0+gWTbcVIl/X3O0CDIFnHzvS5b0eMh6Fr8OYGW89VKUl3Ab26UacvzPeKPvgcT/EtJ6slkEwVK6lYWtuWA9VvEI0cJMzSDkXamhtblu70suXsBPazJRKT5i/8MZObhovGa2aHahHLaqIzxEUGfpUlno9S4kUz4olm9IDhVlHOp3bJ5VU6hxE5fXu1hnZygavysLg7TwEuo+r7hnY1xPuGG07oWWppiAWbx68p8+HEc6qiDFLlvSR+x41piFlLspS9SYUU3PGBG/dhox5J93Rhn824yIfbsSta7zfJKYP5A4BXQVgrvGSX5hPYieDWBYdpp6XYBa8TyGXjYcm0kGSNZiU2edBOa54ocCFWyq1zaPGe8rzhLrNv2mbzAnzayeI0vwnqojGo/sCG3rHKemdrG5Azt+8MIioFY+L8ExGBOvVhG7rpVRsGIMOUb2VJavgDVPu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(7416002)(38100700002)(2906002)(122000001)(82960400001)(41300700001)(36756003)(5660300002)(38070700009)(86362001)(6486002)(26005)(478600001)(6512007)(6506007)(2616005)(71200400001)(4326008)(8936002)(8676002)(316002)(66946007)(54906003)(66556008)(66476007)(76116006)(66446008)(110136005)(91956017)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXlRN0cveU8rV0RtRThxQzV4RUp3c3N3Uk0wa1dyQ21jK2IyUjU5S2drVnpO?=
 =?utf-8?B?bFNtVktHRllyTTY0NEp2NlhRNEN3Sk5HTmlLYVV2M0s1SkNWMzNyY04vaEtC?=
 =?utf-8?B?dGdsdmRSSEFLTnVkdFZyOTAzK2dibndUZHc3SHgyQk9sMzQ0QnVkMnM2YlZ4?=
 =?utf-8?B?ZHBGL25CR0x3YWJDd2VUSFQxbzZMLzU2ZGNCOTcyUTdkU0xsclFhbDU0aWND?=
 =?utf-8?B?MUJDeEdiN2pHRmtHK2Q1aitvS1JaZVF0RG5ja0E5S1BNQktJRVhXZWhQSTQw?=
 =?utf-8?B?dVphTmorRno5Mk5PbUs3WWFWbGx6eUUvRmVGUTdTcWhsUENVSWJhL1gycUtR?=
 =?utf-8?B?SmlvSHFoV1Fva09hWjFneHNzUVNVKzFQTlQzU3VqM0RWVjdGR2U1bDR1RlZ6?=
 =?utf-8?B?cC9lMmJnY01EeGVrZm9uaytBUnY1U2NmOW5KaEFzSDh0WG9qZXFqUC9jemZ6?=
 =?utf-8?B?WWFhVEpmRXNPc0xqZEM2TUlDeDU4Y0tYWlVxT04rcmkwekNqbFp2WGVvc1Ew?=
 =?utf-8?B?amZJZitQYWFlR0VRYkFEazRrTXZlQWxSN1pLdU9OKzV1UnR6aGJYbHMvZy9H?=
 =?utf-8?B?ZndoSUtZN3o0Mnk1UzZxSWFpWHd1dFN0S2xWME5sRm14TFBlekFybnY2bFN4?=
 =?utf-8?B?RGhmMlQ4ZUtCNUx1QkttZnFFZEhLZU00S3hWbU9EbWthbHcxNjhpTEs1WVh5?=
 =?utf-8?B?TUNtNmZMc0IvM3BNVmMzWFg4dkdwR2VmY3kwOEF0VkgyM1NuOE1aUFBQTFND?=
 =?utf-8?B?MzlEbzQ0Zk1BWjhOMGMrdlRqZ3BvY25yQ2VYZEh6Z1F6bnJhSGNCanR4Tk5V?=
 =?utf-8?B?VGhwK1Jtc09ZeEQ4NHgyV0ZieXk1SzREUTZBNldMSTZmVURtcnZkcmhJMXVv?=
 =?utf-8?B?bmROZnVWQU5mekQ5NFdBVTZpSm9DV2VzdXY2MktEUTJ4bXQzbnBqeWRBanFs?=
 =?utf-8?B?eFlTTE1nbDcvQ3MyWS9pc2Uyeng3bzRhTzFpdzg0aXFIZGNZUDhWVE4vckdD?=
 =?utf-8?B?eXAzbFlPcGZYWG9MWE8xZm5UaUptTUhnZXRGaWhiNUlNTXRWK28yNEJJS1Bw?=
 =?utf-8?B?TkVXNVVqZDA3VDdOelhWNFRrOFlzVVZwVnUvd09ubkZ4OHhDcHBoMmFVL2Vv?=
 =?utf-8?B?ZHZxb2VaU1plTEZiaGJkRHBrS2NtcEpmL09mVk55U2JUMzI4c2lVQXhjc1lG?=
 =?utf-8?B?MWVJSDFhN1hLcmlLVWZkYWVMdm9yT0t1Z1E5ZG1uNjREVWgycmE0QXMwQlRt?=
 =?utf-8?B?eWJ5MzM0Y2lqV2JQRTRjOFdmb1hTR1hUcnFPcUxtNUxGRW1FR1AvbW9jQWNw?=
 =?utf-8?B?MDh3OXc3bHBLUlFzdHZTSW9YVG13bitEVXdsLzBDWXJqNEdXa1JBdSsvZGFr?=
 =?utf-8?B?MDBqNm43YkZXeEcxSXRrZ01vcEZZcmxwenBxY1AvUHBUQUd2S2NLTFg3YmVl?=
 =?utf-8?B?QVhRV09lbVRFY3YvMjZPVHBCMnB2cFpMazBqaEo3SXY1b01JMktXNStMRFkr?=
 =?utf-8?B?ekdqcHVEb3htaWpkMGtHOXJTZkp1bWMrUTZMNnFFeHJ4M2FSdytGQnVxZ2NT?=
 =?utf-8?B?Q1hZdHJvTXdYeWZ0ZzMzZTdjcHd3ZXpINFVWOW03eUpHVW5paXlLcTdBRFZZ?=
 =?utf-8?B?Q3BSTThGT0NlVkhDbW1waHdnbEJkMlphOS9za2o1djBwS1F4VGtWZWdyVWdO?=
 =?utf-8?B?a2JXQ3hiVEVTazdQeGlkSXlYVzZueHFmanQxMm9ERnhTVVpQRkRuUlIzTGwx?=
 =?utf-8?B?Z1dSYUFydForNDAzWlNSTUp6NHZBOGpkVXlGMmRDNGdkV1dseHU2eENaKzAw?=
 =?utf-8?B?RW96eXRrYWt0ZUVEQjJmTEFNK1hpbUpWTW00MkUwVURlSzNiZDRFcHFCb3VU?=
 =?utf-8?B?VE5mdVVlWG1ia0tFdjh6YzlPTUhUeHJFQWtHTHFBUnBhdFFUbUhSWDlJTm0y?=
 =?utf-8?B?NWJnZ09RMitCOG1SQjlzNkRYWWQzbnBXUFpDVy82Q0kwNENES2lSdXJESFNE?=
 =?utf-8?B?MEhZTHJoT2FKenh0aHVtVGRSVlV3K1hmMFRHczMyUk15NFpXZVpRN2pzRThC?=
 =?utf-8?B?SzBVRVhDSlQyQWxIUmg2Unc2dHRDQmdmUys4ekxiOEpRV0R4M1NBbFFJejdK?=
 =?utf-8?B?bmtKUUlwYU9XZGczYm9EWWErcHNCZkJaK2NoWlhhRkFDaEpVRGIvZmR5Zk5F?=
 =?utf-8?B?ckE9PQ==?=
Content-ID: <E155BA1184E51941A8041FBFBA6A8F37@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dd24a2-d5cc-4ec9-83ff-08dc1e78921f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 14:10:37.6119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h9hk8UWvf7AWx0/PLKUFhTYCMLiZXJsKxTzjVjED6pX96Jgb3r7zFDWGox1aFFnXYcOAY9vWu/3QQ0TqG9gqQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_061042_807937_9D176B47 
X-CRM114-Status: GOOD (  23.82  )
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
> The helper complements kernel_ident_mapping_init(): it frees the
> identity mapping that was previously allocated. It will be used in the
> error path to free a partially allocated mapping or if the mapping is no
> longer needed.
> 
> The caller provides a struct x86_mapping_info with the free_pgd_page()
> callback hooked up and the pgd_t to free.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

FWIW:

Acked-by: Kai Huang <kai.huang@intel.com>

> ---
>  arch/x86/include/asm/init.h |  3 ++
>  arch/x86/mm/ident_map.c     | 73 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> index cc9ccf61b6bd..14d72727d7ee 100644
> --- a/arch/x86/include/asm/init.h
> +++ b/arch/x86/include/asm/init.h
> @@ -6,6 +6,7 @@
>  
>  struct x86_mapping_info {
>  	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
> +	void (*free_pgt_page)(void *, void *); /* free buf for page table */
>  	void *context;			 /* context for alloc_pgt_page */
>  	unsigned long page_flag;	 /* page flag for PMD or PUD entry */
>  	unsigned long offset;		 /* ident mapping offset */
> @@ -16,4 +17,6 @@ struct x86_mapping_info {
>  int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
>  				unsigned long pstart, unsigned long pend);
>  
> +void kernel_ident_mapping_free(struct x86_mapping_info *info, pgd_t *pgd);
> +
>  #endif /* _ASM_X86_INIT_H */
> diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
> index 968d7005f4a7..3996af7b4abf 100644
> --- a/arch/x86/mm/ident_map.c
> +++ b/arch/x86/mm/ident_map.c
> @@ -4,6 +4,79 @@
>   * included by both the compressed kernel and the regular kernel.
>   */
>  
> +static void free_pte(struct x86_mapping_info *info, pmd_t *pmd)
> +{
> +	pte_t *pte = pte_offset_kernel(pmd, 0);
> +
> +	info->free_pgt_page(pte, info->context);
> +}
> +
> +static void free_pmd(struct x86_mapping_info *info, pud_t *pud)
> +{
> +	pmd_t *pmd = pmd_offset(pud, 0);
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PMD; i++) {
> +		if (!pmd_present(pmd[i]))
> +			continue;
> +
> +		if (pmd_leaf(pmd[i]))
> +			continue;
> +
> +		free_pte(info, &pmd[i]);
> +	}
> +
> +	info->free_pgt_page(pmd, info->context);
> +}
> +
> +static void free_pud(struct x86_mapping_info *info, p4d_t *p4d)
> +{
> +	pud_t *pud = pud_offset(p4d, 0);
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PUD; i++) {
> +		if (!pud_present(pud[i]))
> +			continue;
> +
> +		if (pud_leaf(pud[i]))
> +			continue;
> +
> +		free_pmd(info, &pud[i]);
> +	}
> +
> +	info->free_pgt_page(pud, info->context);
> +}
> +
> +static void free_p4d(struct x86_mapping_info *info, pgd_t *pgd)
> +{
> +	p4d_t *p4d = p4d_offset(pgd, 0);
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_P4D; i++) {
> +		if (!p4d_present(p4d[i]))
> +			continue;
> +
> +		free_pud(info, &p4d[i]);
> +	}
> +
> +	if (pgtable_l5_enabled())
> +		info->free_pgt_page(pgd, info->context);
> +}
> +
> +void kernel_ident_mapping_free(struct x86_mapping_info *info, pgd_t *pgd)
> +{
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PGD; i++) {
> +		if (!pgd_present(pgd[i]))
> +			continue;
> +
> +		free_p4d(info, &pgd[i]);
> +	}
> +
> +	info->free_pgt_page(pgd, info->context);
> +}
> +
>  static void ident_pmd_init(struct x86_mapping_info *info, pmd_t *pmd_page,
>  			   unsigned long addr, unsigned long end)
>  {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
