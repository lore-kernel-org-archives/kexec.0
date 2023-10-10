Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AEDCD80A0
	for <kexec@archiver.kernel.org>; Tue, 10 Oct 2023 10:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6pDj06QIDv2nU/Y+lpLM15TRCplR/wxDiVwjmSdElEo=; b=4uPqxfwDCltEaZ
	T7J/Wh04DKC+UeDW7IWgipuMpQs35oDXoPX32+Au71e7HfSqqsxtSM60hTmKfbZ1z85dcHdKKD9KA
	nIxCq6D/vk4CCJ6dj1zJoon93vQoDd0qS+r/JXYJetQfXbHy1X/7zyPlRgxWmQ9gaRXdmE0cvM/NX
	UNjTO2caksMhycl2EOeQeAIxwY8Q3j+ZYIkERjWJXzm5xqT/bGQ2e7zFg7fjXsDxrpnDOTWWNsJ7j
	kRdbDlNRo7K93P28OITtIC2v1LT/39IR4rnkMmihbGXhGUQkR4LWVnmhFvy7HWRDjS1yZS4LsepCt
	QKU4Xc2+d83BMB9C8SOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qq9uo-00D12v-1x;
	Tue, 10 Oct 2023 10:24:38 +0000
Received: from mgamail.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qq9um-00D123-0I
	for kexec@lists.infradead.org;
	Tue, 10 Oct 2023 10:24:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696933476; x=1728469476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WiMeKgIhUSzthUOvZ7OWSBI/4l04cOYRCFAKrWxFOMk=;
  b=io1QvrYZR5Ryt5wA3FlwRtZFQxqnc4irSSMCkUTvCbbIfmuYIF/SPmrX
   JjxqNES1jN4PFP8PyLVkRlqwJjyf6XQ6toE8gjSIyp3uf5VilEgkjsiYn
   IhOJXiCgDMjgD9tBovecCNwFXKwKMni34zL9f2ro1Rs7jnP9Gy6EM3szc
   KQrgPMz5oymixvueKx0iOvPTWYCXPDGtP+3AvHmAWHGJNByaL1fvEnuNK
   gwkXOCFiE7kctxhyw0vqreQQfn8VbJLCkWdTqRlQ5JWM+FSr9/aiaH/HU
   0qi6AYHeum3ZuwWwBStPyzFjoGFC1p+/WJ1p1UagZbUpqmXbTclf0tvgl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="369422445"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="369422445"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1084719728"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="1084719728"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 03:24:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 03:24:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 03:24:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 03:24:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 03:24:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnLNf3WEF2anAleL3G3Kv4haJL6nDGnFnnKFIPnkuZWlol8lg+osM+/V+2DWXWz50Zx4culrpEakZGFj4ZDaKj3ffCyJhUee1LAf77TYEpl/Ueb/nXRZtjB8bdf54ts19e+kLh0CTNGCIacFeTTg+/OCQ8Q1/eligPieCOYl4DJA1oeff8wD6dNZpzb4616zpKndIs3/kQSiJDK7UU1LuiP3tlspr56v8xn4/pNNmZotS/Zmn6heqHTPfHSYQI5R2NNoy4HgFpVuiIoLqih/yvKKwp7rVDW+WDgDmkVUHz/aPYSKuz/zgptXfTSEFspKCLLENp3SMzi2sVckEpeLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiMeKgIhUSzthUOvZ7OWSBI/4l04cOYRCFAKrWxFOMk=;
 b=DmZPmIbdJ143cn1htFcyIWbR/LUl7iaSZXE+v1u9RrYgMZ+/20SZaSzQTgY1dW6v0kWFALK5kHDjzh2PNtJurfbS1+h8dke5sxvoe/q1fFmj4lUfhddvY6PwjV1Dh+rtgkouKvfxhyBvEIk6EL3TRxo7KemvmRLaZYlNoSKY/HqCUhGwmjZkjcjovyuCRF+EJaN1UuNK27ImAj1eHstugIWuKSPVkDUaKuB0EmUmNneAQIzbT/ZRch7+E6PXO3a4+8TlJYbLYy0rmWrgNY6Zm4cP4Kko/QrJbx4FPCBcGfhJDF4cc9cSD2dI3+epV7I3O/zWWifZJD9Ivba6o4tU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH0PR11MB5361.namprd11.prod.outlook.com (2603:10b6:610:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 10:24:30 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Tue, 10 Oct 2023
 10:24:30 +0000
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
Subject: Re: [PATCH 03/13] cpu/hotplug, x86/acpi: Disable CPU hotplug for ACPI
 MADT wakeup
Thread-Topic: [PATCH 03/13] cpu/hotplug, x86/acpi: Disable CPU hotplug for
 ACPI MADT wakeup
Thread-Index: AQHZ95EyP1ClwZ3KGUST35mBv7+5VbBC2L+A
Date: Tue, 10 Oct 2023 10:24:30 +0000
Message-ID: <9f9fef1eb387e6098ca762d10e9c2002296c89f6.camel@intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
	 <20231005131402.14611-4-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231005131402.14611-4-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH0PR11MB5361:EE_
x-ms-office365-filtering-correlation-id: d8870cde-98af-4251-13a6-08dbc97b16c8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1U0WncaRae3umvEAAxmrMpCWHewsNEfkixyQp60Q2+npmjeKa9SKqJhek4oIl/aiiTFa6rhxHYqaM92biCA0mhbTxbQdFBB4FtS5NbRVfmzJS5g/r7fRKrrvI8dBEET9qcn7SRROYHJL82EUrs+ftWmyisfEwvTN5sfzdXKNYYmEM3Q2DNAYu9draOnKHJdUOr3tCFEVNQSLsEXQU64UZlxzCzbc+OwfFLzbt9Y60orbfeoNGaSSRSwu353YUEFmemoiY+Uq6HYAaffB8Jocs41SNODChAnadRyq/UVU6eKAZIAyKQyNCyP6lxQeX7Cl1/QgJBbSwQG6h2+XtIpZyIhBC8rtHC9StsPLiH7208uXb+FIeatXceCbN2tH2QIR7jTtw5vs2XhV1pitOnf6H6F20hUy/fYKh7Lfd6I/qnXxhjbkjHEL2EFVXvNgGR9hO5OphPNFXMmK0J1lea7h8aej7WGs54lBLjpWCaVs5sfu8U4ym0dTK4/uwBrjyZ+N0lgphsw2GH6eQUTwCRMrotCPr35JuM8gVkyM8MrPhKXg/b03rhQdLlKVsaYGrqTMi0QMLoMuW7W2ectF/0NM+rH+5sKm8M8ORflR8WEd4ETriycU7O85Wc8kFb1UmYuu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(478600001)(26005)(6486002)(71200400001)(38100700002)(122000001)(316002)(66556008)(76116006)(66946007)(6512007)(66476007)(110136005)(6506007)(64756008)(54906003)(91956017)(66446008)(8936002)(5660300002)(83380400001)(4326008)(8676002)(36756003)(41300700001)(86362001)(7416002)(2906002)(82960400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3QvbFRaT2x4QXgwM2FUaG0wdjJWMTlRMWVobWtwYjlwUzJVMmczWVFyWTZ1?=
 =?utf-8?B?MUpPUjNOcmtWTXd3bGovaHpxeGFjdGFKYmVybTVxT3lrSVZPNXNYZmY1ZHEy?=
 =?utf-8?B?a0ZkRVJjM2ZoRTIxYjRJdWh3NWF3Ny9HR3gxV2lyeXJITXlrVnV1VmlFUWFF?=
 =?utf-8?B?b3NDU0JpZ3VqYUhNM3hLWGVjWTE2alNHeVJoZWRqbjlOaDl3OXJsM1VWNE9X?=
 =?utf-8?B?allHRk9NcHFpWExuU3ZCc0VVRFNyWVVveWZQdUphbUtOWlBFTGhZYW1JODht?=
 =?utf-8?B?bGsrQzg2ZDlJQ0hIVnVPcUUzU29YZ3RqaXVsSFFKbjNkSjc0b04xLzZCV0pv?=
 =?utf-8?B?dTB1Qm9BNU9yUXRRbEpENndrVXBFcTU4ZnVuckttWGFHeERlZFo5OXZuSnVL?=
 =?utf-8?B?QkJwd0xVT1FvUi95QVhSQjN4bTJaZEZPM2dwdVMvRExxODl4OWJSREdia2pZ?=
 =?utf-8?B?QXNxdDVjYTFRSmdNQUJMdGJHT0hxaGdSNnZ2RlVraVZWOVFacmVaQmcybmFy?=
 =?utf-8?B?eDBZSncyTnJmRVBscXFDQVN5MzlweTExdnpFM0o1RUpHVTNGcWl2WFIwaFJF?=
 =?utf-8?B?blhGQ1h1WjBrQTU4S1grWEZwZjhCZDhOZmVHRW9JaWgxSWpMcW41MTBhMmht?=
 =?utf-8?B?QWlnZ1REeGlDREQyU1pGVlJxd09wdXZ3dk5FNitZS0hUTklieUMyRlplZEpT?=
 =?utf-8?B?NDBFRzRnNTlQeWMrY1BnaERWSmpjay9WRmVqcGQveHF3Vm5oait2VTU5V2xT?=
 =?utf-8?B?UmFMdEFsbnNSa2tXdnFWMFRWcEFpT3hwUTk2dnFlbFVVWWdTSWhvN21ucmFQ?=
 =?utf-8?B?ZmVacWtSSFBaa1JFcFM2N0tDeWg2anQ1NEozcFQ3a2hQWDlVT0Q4WmJTMnI0?=
 =?utf-8?B?T2tvWmJEcmR5VUVVOGwyeWVWYzA3SFJoREtLTEpESTNvRnU1YjZYWW5PZ2x3?=
 =?utf-8?B?T1RiLzlCQ3BFeEVvZnllUWRmalU2Y1BwWUgwbFFMdzBiRE5KeGlDNE5VeDNG?=
 =?utf-8?B?TkdKZXBXVitTaUIyaDRiZTl1OGtKSHNjdlZYVlk3OEtzUk5iKzB4SE5iaTgy?=
 =?utf-8?B?ZkR1YUFDUXhTK1gwazdHZm11VThTZWVGNjJ4YXZVUlRHVFFFa1FTci9paEdH?=
 =?utf-8?B?cW9HSCtEN3lhRytJWGlQK1VMTlRJdXkrL2pJR3crRGhBSFRmYVBIaE5pL3Fl?=
 =?utf-8?B?bUd0VVVHdjlNdnNWb3JTSExCNDgzUnowSVVCRGY0eXh2clpDRTd0SGdreGQy?=
 =?utf-8?B?WTBkQVRIM0tVRldadE5VWnhyK3ppTHZMUSthaW42d1ZWZXJhd2haWXVNUzln?=
 =?utf-8?B?N3o3ZHlMWEF5WWV4WVV2NGIybEZhdGVyWG1lQXVPYmRncEc2Q2kvUnR5Vm9S?=
 =?utf-8?B?OGV3UWwxVVVVR2kyY0hDZ3RVRVllQzlpL1FtNWhnNDc3N1pCWnkvZEZRZFVm?=
 =?utf-8?B?UEtCb1NYMTJNSWhjUzZRbSt1WEQzUnpmV1IrUkVwUEMvZFFWRVBBNkh6YmNW?=
 =?utf-8?B?Zm9YSWd2YzQ1K1B6QlNJK0xvbVhhSyttSEE3MUxyZ2VjMk0ybGZ6YVZ1Y0p5?=
 =?utf-8?B?YmZ3NDAxeWo4SGRxSUxlWC9aVWRFc1B4VVcyWmF1eXhrUmxFN0VxUDlmTkEr?=
 =?utf-8?B?Y1A4US9QUi9LcURzdXNlY1NSY1ZyMkVhRFQ4aWJ6eDArTUd5NncyUHoyUm9n?=
 =?utf-8?B?RmNZZUtITVp3VEd5UjlxbjMzYTJ1MUNmUHcyWjhvRmcvNjFpQXU0dXgxWDdP?=
 =?utf-8?B?VkhnaExDT2FqUVltMXZnblBhRFhZT2FhNVJaZkxLOGxqL0diN3pSSTFCNzZD?=
 =?utf-8?B?cFk5R2RsYlRMRXdjeUIxWEc1K2xEN2wraW1zc1ZPb3J1VllVdlI3Nkc0YUVE?=
 =?utf-8?B?UlFTYkNPTy9xdFZGWmZWWHN4VGR2TzhTc3NjdllDSittcStxRjZ3YzFFNUZI?=
 =?utf-8?B?QjdNelQ5VTFGeEpNM29qaXplV0M3aGxCM0hWZWNBQjlMNkljMHQ0cDFIUElB?=
 =?utf-8?B?NDlscDVvajc3cVhoZHZ3NDdJVVJBSzBFYUhISW9vdGoxd2FFUld5UFE2djh4?=
 =?utf-8?B?OU5GcmoxUERDbnVlbEJVZ0w5cjBBMlJLaWV0NVdCQ2xVczFlRDArcldvaVlM?=
 =?utf-8?B?R0c2YzdxSXZNdCtNVWFKVVBmbFN2bENNR0ppYm5VUlpJc25pSzBneTBDNnR2?=
 =?utf-8?B?UGc9PQ==?=
Content-ID: <2266786367E7B24EA7A38ABD3B378631@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8870cde-98af-4251-13a6-08dbc97b16c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 10:24:30.3351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xV1r5FAvk6mN5IYSFa+2IwCDy2t7e8Q03CtmoDarWpN0B659AZ0rzCw+b/mpufCOPmuXd4gAAyW6LtEPw3Ielg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5361
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_032436_196005_B3D5D507 
X-CRM114-Status: GOOD (  15.96  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

DQo+ICAvKiBQaHlzaWNhbCBhZGRyZXNzIG9mIHRoZSBNdWx0aXByb2Nlc3NvciBXYWtldXAgU3Ry
dWN0dXJlIG1haWxib3ggKi8NCj4gQEAgLTc0LDYgKzc1LDkgQEAgaW50IF9faW5pdCBhY3BpX3Bh
cnNlX21wX3dha2UodW5pb24gYWNwaV9zdWJ0YWJsZV9oZWFkZXJzICpoZWFkZXIsDQo+ICANCj4g
IAlhY3BpX21wX3dha2VfbWFpbGJveF9wYWRkciA9IG1wX3dha2UtPmJhc2VfYWRkcmVzczsNCj4g
IA0KPiArCS8qIERpc2FibGUgQ1BVIG9ubGluaW5nL29mZmxpbmluZyAqLw0KPiArCWNwdV9ob3Rw
bHVnX25vdF9zdXBwb3J0ZWQoKTsNCj4gKw0KDQpCb3RoIG9ubGluaW5nL29mZmxpbmluZyBhcmUg
cHJldmVudGVkLCBvciBqdXN0IG9mZmxpbmluZz8NCg0KVGhlIHByZXZpb3VzIHBhdGNoIHNheXM6
DQoNCglJdCBkb2VzIG5vdCBwcmV2ZW50IHRoZSBpbml0aWFsIGJyaW5nIHVwIG9mIHRoZSBDUFUs
IGJ1dCBpdCBzdG9wc8KgDQoJc3Vic2VxdWVudCBvZmZsaW5pbmcuDQoNCkFuZCAuLi4NCg0KWy4u
Ll0NCg0KDQo+IC0tLSBhL2tlcm5lbC9jcHUuYw0KPiArKysgYi9rZXJuZWwvY3B1LmMNCj4gQEAg
LTE1MjIsNyArMTUyMiw3IEBAIHN0YXRpYyBpbnQgY3B1X2Rvd25fbWFwc19sb2NrZWQodW5zaWdu
ZWQgaW50IGNwdSwgZW51bSBjcHVocF9zdGF0ZSB0YXJnZXQpDQo+ICAJICogSWYgdGhlIHBsYXRm
b3JtIGRvZXMgbm90IHN1cHBvcnQgaG90cGx1ZywgcmVwb3J0IGl0IGV4cGxpY2l0bHkgdG8NCj4g
IAkgKiBkaWZmZXJlbnRpYXRlIGl0IGZyb20gYSB0cmFuc2llbnQgb2ZmbGluaW5nIGZhaWx1cmUu
DQo+ICAJICovDQo+IC0JaWYgKGNjX3BsYXRmb3JtX2hhcyhDQ19BVFRSX0hPVFBMVUdfRElTQUJM
RUQpIHx8ICFjcHVfaG90cGx1Z19zdXBwb3J0ZWQpDQo+ICsJaWYgKCFjcHVfaG90cGx1Z19zdXBw
b3J0ZWQpDQo+ICAJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gIAlpZiAoY3B1X2hvdHBsdWdfZGlz
YWJsZWQpDQo+ICAJCXJldHVybiAtRUJVU1k7DQoNCi4uLiBoZXJlIGNwdV9kb3duX21hcHNfbG9j
a2VkKCkgb25seSBwcmV2ZW50cyBvZmZsaW5pbmcgaWYgSSBhbSByZWFkaW5nDQpjb3JyZWN0bHku
DQoNCkFsc28sIGNhbiB3ZSByZW5hbWUgY3B1X2hvdHBsdWdfc3VwcG9ydGVkIHRvIGNwdV9vZmZs
aW5lX3N1cHBvcnRlZCB0byBtYXRjaCB0aGUNCmJlaGF2aW91ciBiZXR0ZXI/DQoNCkFueXdheSwg
aXNuJ3QgaXQgYSBsaXR0bGUgYml0IG9kZCB0byBoYXZlOg0KDQoJaWYgKCFjcHVfaG90cGx1Z19z
dXBwb3J0ZWQpDQogCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQogCWlmIChjcHVfaG90cGx1Z19kaXNh
YmxlZCkNCiAJCXJldHVybiAtRUJVU1k7DQoNCj8NCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
