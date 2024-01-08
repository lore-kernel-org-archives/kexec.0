Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16608C47073
	for <kexec@archiver.kernel.org>; Mon,  8 Jan 2024 03:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uj5mESUurE37GuUuVqIvSzzA0uOb6mrBhM12u9AQisc=; b=lUH20jtcLgnBT9
	hNsWldR1gqi+rMj6R6ofN27Lhtqu9Bye3TuAqF6C7HwXGh4RkF1Pr3T0Q2V1pEpAFENr0uWhV+mPP
	IYkMAmd7lum6lIUJjd1u6VMAILHPh7uXdLB1pcq6SAwVUCc/KSg3XR0C/C/0OoEqkWNKWNMtMi/Ea
	uARxYCb+ah8zPtKu1CXmyf5gKKgGaUFv3MWs/XTLzlBvmh+gPclbyzBhrBO5y/Tkm7RdlVMiRoTbr
	MIxwBcItOqY54lgQ60WF7mbazI2WpiisgW2c/34IXCt5xh3/9X/EH0WNLwkfXvOAmLxFZYW/ck2Eq
	CPHk5ndbLxolUC0ccV9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMgLO-003uT7-0j;
	Mon, 08 Jan 2024 03:30:30 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMgLL-003uSP-0T
	for kexec@lists.infradead.org;
	Mon, 08 Jan 2024 03:30:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704684627; x=1736220627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l48qRn8HLlnFNXg9ef3Df+z2ZWLQZ3r6kxxpOgoWxts=;
  b=hljPaYLAt7ELnFsIeH7GjhK2SIfN3rZYA9Is8twx71ehJmWYGpggg4e+
   cr9KUhVGh3L6cN/+JdXMgjWAH1pAavMA5QsfSv9IOSVYlZLNbudJKWihd
   vp7KRMmfR3oSMOSEDLJhXikfVCUPGqkNr4YnG5KTBwkuqd4Afnd1+Zx+r
   XubWgXsVZfoR3JkYhcN2awO2foLSd7FWWnmej5CD/gXfiBTXY4YVRJBNN
   alO0VMWtlG3RNRzNGR+iv5svjcAyCVm8mJg/ZVCBG87+3mdmEmdR/q/hc
   3T6vnD5851LzvuOxO3gfSziorPt3VeI9l9PRzf23tHI6tqy8+EAnj96jf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="396668218"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="396668218"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 19:30:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="23038695"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2024 19:30:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 19:30:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Jan 2024 19:30:24 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Jan 2024 19:30:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAcfjh9VdrBU6G3GzglKvlc9lwBvweCb9vdEjFIhN3y/5nGABfQe48zrN98sx+orSbDkth7OkdIhj0mP166jRnKmBH8n/KNUmmJ70n/dfWMe0docgs6HwS95WXtNUbBu4Hsl9kQeMxbONB7vp3abK18Xt4xqubAg78jmfnxtlFngsa3RIFMbtg8eat0HHxIFkCLK1E5or4ldGRmaWkFP/pUEuBrJExwRSmQFhijgfB6lEyW+6qXkIgUVv7IvB+PjeOyx4jrz2IP4kixEAqi7WAIB5zXFGE2eFFhNwpAVMSq7DhL5io5KADYdf3Ri34/HOWPgzo6CrY1GHJZeYXw3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l48qRn8HLlnFNXg9ef3Df+z2ZWLQZ3r6kxxpOgoWxts=;
 b=cGYlKekFInDbEEgp71HeHnJnWrQAz2NEverOl+Hpc8QD6BL+HAIcxuCgp5no9Jm/dgtQ7UbIJxWdrGWhwKobyC/uqkYFZdcFnX83Mk+taOGtKv4GF8f6ewGSz9Ao1d3o+NeIouk5qORuwNmH6b7gjbG9eAWRlRJPfqPX4sYWClw6gwolxf43bNjtxRhbhSHQ7hmjMyXb/N6q0jhvWtmqNIUPw3js4at5NwxThwxH316ODMgO4MA+Qtmfwhi3e+wMdZTSZjAxunD5VhsKYiH4YeXD+D7RdyIO2EqjFYBP8dGJkM2CfpykU2rcC4MHiepzATRc5PuN5fpQQlNr8hCJGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB7937.namprd11.prod.outlook.com (2603:10b6:610:12c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 03:30:21 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 03:30:21 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Edgecombe, Rick
 P" <rick.p.edgecombe@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"Nakajima, Jun" <jun.nakajima@intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ashish.kalra@amd.com"
	<ashish.kalra@amd.com>, "seanjc@google.com" <seanjc@google.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCHv5 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Thread-Topic: [PATCHv5 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Thread-Index: AQHaNTH0QWBZ51600E6mdH8oHBHhWbDPVskAgAAE0wA=
Date: Mon, 8 Jan 2024 03:30:21 +0000
Message-ID: <3bddc0a0d69b6b18ce3fd568e6a7e6d7be8a1a11.camel@intel.com>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
	 <20231222235209.32143-16-kirill.shutemov@linux.intel.com>
	 <ba8265977a4b30f48b6b33fb135b714d5ada2a52.camel@intel.com>
In-Reply-To: <ba8265977a4b30f48b6b33fb135b714d5ada2a52.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB7937:EE_
x-ms-office365-filtering-correlation-id: bc43043c-4764-4c1b-d079-08dc0ffa24ee
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: owWU2ao9neSXpJCONX8KgaxxVOcPQie0H/awAA1DlmBtL57dW8k+JKz3toy7Ir8bsVJ9P8nOR8+u4LS8/1pMU/xz+q1mU2hvhljR1qHZIlo6ItYJcakP4wYGYArPHYQXKx4y28GJy0siVhYJN8hsdulj/4VdLpv+HD46h4k4+g8KOixKYxnkH2geb2SWi+R0svSpBnIPS/VAG4HJdUWdtwLiusGCTfgRD1bDWVzT9EvhdA2DCZVTCw0l2cuX+1seyPUk0Uyd31ag5TsFXuOP5JTlVv2Xg3NGASt7ujcWGu1S7M9/crTH1dJgQtNYjX7F2B5L6us4VhTDfNcziTezvjU9KLYZfZ49UWNWpjdEHxiIprMvNxTnM0LJwtKNWfHU4Jo6SKfJjoYxZiWsYC5dHOz8YhFj800HnUW0rleVpQ+fZnVqJwbn1bCygGogy3/wcYapOW9k7XUWsDkPo/cYJmjOe/mBsyZYXFGAg6Zdk40PR6wgBU8fzykxBx1YhxbASNS9RKHvUnmeRMaGmdTLRaF1SKLef4/THdFGT7iLVmjlj8DL7EH1FUwNPu9HbcmPqddFIFqlQk/JywKGDhK7wwnkuutsGcVJo4jIyPqmu7OqSPxUSWWw+rnIlzZtjAcX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(5660300002)(4326008)(6506007)(6512007)(38100700002)(2616005)(122000001)(82960400001)(6486002)(478600001)(71200400001)(110136005)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(76116006)(91956017)(8936002)(8676002)(36756003)(4001150100001)(38070700009)(41300700001)(86362001)(7416002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFV1Q0pvK1QvWWIzZGxUenNlTE84YmNGZGo3a1N3ako1MzZuTi9KMDBqQzVY?=
 =?utf-8?B?RUxBVWVUUFYxZFNaUzk2SFhpbHcxU3F6VTJ3NThzZFJtZklkOGRyZ0V6RmYv?=
 =?utf-8?B?REtyalZGdnZ3V2xwWndjMGJPbTBCM2hUR2JIakJMSnJkaWVHdGNpdHY2ei90?=
 =?utf-8?B?WGN2K3hBdzJpUnNSWlhUMHhXT3VFT0dzQ3QyWXMzMjZRUFZEYXV5aW9vN0ls?=
 =?utf-8?B?TVlZZ0hqWVRyaStVMnplSWtjbTZOY3Z3SHJ6MlE2L3BVUURrcXhZZk90VTdQ?=
 =?utf-8?B?WDVWWVo1NVNETjVBUVhxRVpkQjl2NkV2VVZmRkg2YXkxdUZQb2UxR3NRckxH?=
 =?utf-8?B?SWxNZnFHcmx1YkFDK0dXbmdnbzVSR2dZaGVVeFMvMnNKQmFUTjlMRFgrdTI2?=
 =?utf-8?B?Z2RjRFBZRUFHOWpZUlVLQWtQam9IVXY2dVZoVXZXYmxCVHB2T2JYNUk0ZmJ3?=
 =?utf-8?B?bm5BS3BrNHRrRWQvNC8zSWxSajhFOG9VVEpkNDBFTWc4djFVMjVIVHYzdE80?=
 =?utf-8?B?dDhyUjZIYmwrM2ZsVC9sWEZXTXh1b1NRWUo4TWtnaTlLYnhUMGViR21FdjQ2?=
 =?utf-8?B?R0J5VmJyd3U4c2d4aGZpVXhIeWs4UzJ0S0pSQ1d2RThPdldqQzZjTys5VkQ2?=
 =?utf-8?B?ZXFOa1d6L2lCN0R1ODlyVDk2eU5hSitoUjRhRkppZ0g1ZTgzWTNsRThVY2Vw?=
 =?utf-8?B?YVJjVHpSYVpNc29zSHg2cmxERDZGVkl3djMzRk4xazRQaG14MEsyZXI0d1dt?=
 =?utf-8?B?QU93b0t6NnVSZTR5RGw0eUNHNmxjSXBLOXJ0UklmbURVbUMwY09mb0FWRGdl?=
 =?utf-8?B?UGJJQjJ3cTQxRWZrNndlOVJxNGh6RHA4RE9GVGY4bytFdUgxVDZrOUJFNEpD?=
 =?utf-8?B?RnlTVzlwUXhRUmxUaXIyMVJMR0g0ODdUY2NuRTl5NHk2WDVCOU91RjEvenh5?=
 =?utf-8?B?SE1sY2hrZ2lYaTM0MFdRdWpMUUJnTENiZFlrZGhEYWQ2K3h1OGFrdkxiMkpk?=
 =?utf-8?B?L2dVMjQyWXhzL3pBMkxXcnE5NERYcmo0U2JnOWxjVS9RRHdveWlTRUtFdVhO?=
 =?utf-8?B?R2s1QmllQnpmSTVtZUtIbjJDaDVtVHVxQlFoZ3R3Y0oyZU9PV3gzNFhNWnRI?=
 =?utf-8?B?YloySzEyZkh0TmZHZkpnY25LM1FHTDkrcW1mdnJSdUYyMk1XMi8reitySnEr?=
 =?utf-8?B?ZmdPZWVZck9zNlpWbWNmT2J4OVYzNEhPR1NydWNqMkpYOVpjUWxxVzRSZldr?=
 =?utf-8?B?djFhbEdhZmxmZTNkN0NCcFB3ZGV2Y0hKZ01wNzBpRGRKR2lTbkpyMzdKYlN2?=
 =?utf-8?B?SmcrYXlvVVB6a2pIblhmK295YTR6MW9kbFVCczZXUDlXMHUzYTQ4MjBUYVRx?=
 =?utf-8?B?MitBT2hpdExsbndaZGhsdVVQWnM3eGdZbStHc2JFdkNRZ2pUL0tZNlJWaEVD?=
 =?utf-8?B?ZHE2RlJ2amdQaUxSeFdvbHFFMUFTVGY5M0hUV0pqVnE0TmMxNkRDQ0NCemly?=
 =?utf-8?B?QWpDSVZLM2I1Zk5BUTNqVUtKekExbkQzbEI1L3phSzZrR2MzODg3VkIxcTQ1?=
 =?utf-8?B?ZTZ4QW5OVUpPM3FGS2lvRzkrbkprZXhJVm9yeXhxdGY3cE9vUjNwVytBOGdM?=
 =?utf-8?B?bmNaQkZGSFp0bjhIb2hlVWg3STdyL3JCc2VncHd4UlZZN25GUWRkR01lVnNB?=
 =?utf-8?B?NmhCbm8xRlFlZG9ZNzY2dlBzR05rL1hudW10UnVlSkRZdVlqbG5ORUtxY29Q?=
 =?utf-8?B?Z0YwM2h1TEFyTzYwWFpnWm9aVHRUclBvSmZicmRzeUcvSHg4U0xMZ2FCVlRs?=
 =?utf-8?B?QVlmZ2FjS0FaRnM1eU5ERG0wc1A0Z2JKS1U3dDI1S2dtd1hkNVd4NVp0RWhM?=
 =?utf-8?B?Vm9YYzJFdWR4VDBnUnBEYWVFd043V1NkaVhmZHFTdTAvbkNOeU5GOTB4ZmRh?=
 =?utf-8?B?SjBnTXhSQ3pJMkJHM1RvZWh0M3doYS9KQXJQMjlZZ3RlcHhhKzNkbGt6czln?=
 =?utf-8?B?OUt2Y29CWllROVRTdzZYVGRjVjgrNnpNQjVtMld1OEZmb2t5YlcrOEFyUTVZ?=
 =?utf-8?B?bDBZbXNTSGJraVQ1Qkc2T3FvL015TXVkb3VyWTNQOGV5Q1YrL3hESW9NMHhG?=
 =?utf-8?B?Z3d1RndQOFdyNVVtYk16YUUzQzF1RC9rbGZZdnhmQzk1WngwMEJJQ3dydkE1?=
 =?utf-8?B?Qmc9PQ==?=
Content-ID: <9CEAC940AF27F142882065C7EB5950B5@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc43043c-4764-4c1b-d079-08dc0ffa24ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 03:30:21.5069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcgpQ+e2b/wQKtZXXQwPImPDCGzNSYqwk9T8WEDtzq7tZgZGoAQMGmaBKcMGH6ZOEjdgn8yn7LfQD0J51AxHqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7937
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240107_193027_256760_50094D21 
X-CRM114-Status: GOOD (  23.60  )
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

On Mon, 2024-01-08 at 03:13 +0000, Huang, Kai wrote:
> On Sat, 2023-12-23 at 02:52 +0300, Kirill A. Shutemov wrote:
> > The helper complements kernel_ident_mapping_init(): it frees the
> > identity mapping that was previously allocated. It will be used in the
> > error path to free a partially allocated mapping or if the mapping is no
> > longer needed.
> > 
> > The caller provides a struct x86_mapping_info with the free_pgd_page()
> > callback hooked up and the pgd_t to free.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/include/asm/init.h |  3 ++
> >  arch/x86/mm/ident_map.c     | 73 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 76 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> > index cc9ccf61b6bd..14d72727d7ee 100644
> > --- a/arch/x86/include/asm/init.h
> > +++ b/arch/x86/include/asm/init.h
> > @@ -6,6 +6,7 @@
> >  
> >  struct x86_mapping_info {
> >  	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
> > +	void (*free_pgt_page)(void *, void *); /* free buf for page table */
> >  	void *context;			 /* context for alloc_pgt_page */
> >  	unsigned long page_flag;	 /* page flag for PMD or PUD entry */
> >  	unsigned long offset;		 /* ident mapping offset */
> > @@ -16,4 +17,6 @@ struct x86_mapping_info {
> >  int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
> >  				unsigned long pstart, unsigned long pend);
> >  
> > +void kernel_ident_mapping_free(struct x86_mapping_info *info, pgd_t *pgd);
> 
> Maybe range-based free function can provide more flexibility (e.g., you can
> directly call the free function to cleanup in kernel_ident_mapping_init()
> internally when something goes wrong), but I guess this is sufficient for
> current use case (and perhaps the majority use cases).
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> 

Another argument of range-based free function is, theoretically you can build
the identical mapping table using different x86_mapping_info on different
ranges, thus it makes less sense to use one 'struct x86_mapping_info *info' to
free the entire page table, albeit in this implementation only the
'free_pgt_page()' callback is used. 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
