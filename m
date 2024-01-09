Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C06C3DA6E
	for <kexec@archiver.kernel.org>; Tue,  9 Jan 2024 03:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EuzxMFgz1rzPcuCNe3pcwlffEuntMpUu0F3+dZBlE30=; b=vWiDwzDqJa8gOO
	D22B3aKTFjr/qf8P6QpU0V0fSSxbu7k7JRNF7yiZihtpVcSUTrPpfh84b50B37VVbkCchU1cqNGw5
	ALef490Szomwl+BZpnPnTsVXMsZzQKUTkjIcuQVJuw7WXZI1UyDXlsoGxcTjEs+h007ELxR9mFWuf
	uLuZ1J8apNUMp64UsrPSxvZdUVucckJBVePjzYgkaHmGfQhBiGtQ8WRwkPceAdixM0tVka+yG+3cl
	tgAaAS4v02kfQa6E10//ooInqpVRqsh+rYabLMdxEvbSYaFG6X40/aVyGQkpuNQaWIKcXPk8YL57A
	HKEnevmXHdIHFem1l81w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rN2Ph-006kus-2E;
	Tue, 09 Jan 2024 03:04:25 +0000
Received: from mgamail.intel.com ([198.175.65.12])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rN2Pe-006ktp-1F
	for kexec@lists.infradead.org;
	Tue, 09 Jan 2024 03:04:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704769463; x=1736305463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6B6eqkbyU3CR/PUtQdNcJ/yhENBEPEzPw4B9TDwI2uQ=;
  b=FPR/e/PAhDmk7IBOjCSCo5S2Hjy2gz4cJktaw5pQGo14NYaG0bsgAzgK
   CUteg2+T2TyborSVIfqDGRVTRPMxoH4MUiwpMqglJ6UvG1eBbhi4H8DEk
   G7foLxAU4ZeSf2L3+sFeEA90uhxx62SF1kZqpdWnokXiQ55sFX4XsTXkM
   x0u0p0GqjLcftXJUnYKrgYpr9ZX2pxPliB136ElffoMjLGSzEL92jtQ3c
   JxKaRcYJ9k3dz0C9kcjamj0rqZfX3pmF2i1E5Fth/psOXuFXZ8cDX+Rsp
   RAv7mW3WqHVTzqncB7sTgMOKDz4CfpiLaJVHZlXbIBk8o+e8uaaxh3ukN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5415028"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="5415028"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 19:04:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="757825076"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="757825076"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 19:04:19 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 19:04:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 19:04:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 19:04:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9ifqsAsmRmc4rmMxLJ1/GWmVEbW4phfoxyg5MsMq4ScQHTxf/Nmogc974A2NyNn8EZ4wnIn9HD/E9InSIQEKrCvTjPcbmm9GxUmLSb09BJ4YQGs5y5MvIkJtkU3HyVi1AjW1+mzMZ+kE8c5NrxNxM4FsuwK/ohZp1tua6s80OfVkzOZ7XLY1AaWKesKSHZ/3t3+md4i83YP6jYnUM2NSZ9ZKhCkaBopRtteIdkQsQRyxnnlPiAlqvlLsBy3+TtylDFfQFGCHV9xM41m9s8binv36CHY/4bwq1aVGotZ5VG9H7wbmv9sxXD/pcuRm4btIgUxmyY0uaEJnjUQ5tID9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B6eqkbyU3CR/PUtQdNcJ/yhENBEPEzPw4B9TDwI2uQ=;
 b=oFx+rIHLCDCynGP4I37GDy4z6qDAd0RW+u2jeWscYNInYVT1AMXHRumgC/nu2UIegmhdIAXTUun8qDefSeuYeb9Y7K2yTjCmJFjEprrKXmjPhiRQN8stUOjluhhENsn0eqBViTvR4nUXdbvbjV7bn88narWf2ntm6p4wymsrBznFCtX53YD4ohjYHSOzAOBvBsKqcTRpVJoZEMtA4c5aQ6ieSaOFoFUWd1q1nFTq504wKtSPoI36nw+KHg93iQiP1HB9sUZCudYqGREdD0mOils6dtp9zG+aUwx3t6zNNDlvtMTx7aTSmWt+N2zjN7V9kDvoiiUHMMCGkgrKnGwN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW3PR11MB4618.namprd11.prod.outlook.com (2603:10b6:303:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 03:04:16 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 03:04:15 +0000
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
Thread-Index: AQHaNwlbb6SzZl77y0qzncigU+XbULDPULYAgAB4iYCAARm3gA==
Date: Tue, 9 Jan 2024 03:04:15 +0000
Message-ID: <aca16663465ff579da076bb66f851ff71072ef8d.camel@intel.com>
References: <20231222235209.32143-15-kirill.shutemov@linux.intel.com>
	 <20231225080524.4240-1-kirill.shutemov@linux.intel.com>
	 <d23475c878ce1bc899a6b9f613252e985d97d094.camel@intel.com>
	 <20240108101553.4zgji5emlw7cjlik@box.shutemov.name>
In-Reply-To: <20240108101553.4zgji5emlw7cjlik@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW3PR11MB4618:EE_
x-ms-office365-filtering-correlation-id: dbe58d3a-cdef-4c28-324a-08dc10bfaa2b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U4DMRozBYoTyq+lwRjL37ohDEcJewykXBtmtfg9G32RVCXNw3HF3vXGtjiVWVCP6VhcfziJ2b9ZikucZsRbiTNTgP7H5uTe2BbzRrOr3jq5llcbqZcCiZocOjUY4o8KOCFFt0e2jFy2c6caie/Lm+SfsbiFlc/xBH5ZrYrN8swANeGqeVKSM2JghSM5zP80H6MK4gEoWX+73K8mebAx9KrH3x4SPfXQ5/UaQELfnYIKJnLN8Z9Laj2d2JL2tvN3HhUyHrqiYVueXEblek+9eG6QJZCrdcM5+3JatCCFwaPtroNoi02KctobooefkS/SZwQhbema5dceA/m4PMdTg+2FL9VIQc4q5+x/8PS3S3maZlPtChHs9X81QqFOgDADm2fwGCw4vMznTWY3Kpq2dp3wm/U9iEwOVvYYZGjT+2cfrGofdnEvJE+pBUgDL8Jz/R779FYLqmLNBQjVJWQrafuVaeo9V6nf96df2NzqrDtvzf+rIILpR0eX78VUfo55T7j6HqqLNKwnZ0AwJW3vzXXsoPyvVaVagstctAkPv/6TM4JYsCepOnYYYOcRDLUoGT7CRkOvV5wkj9FI97ep02osnCa1DJCuoM9uQUNTuLltK/nj1mGCPI3Zys9wYrMaM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(5660300002)(36756003)(8676002)(4744005)(8936002)(4326008)(7416002)(66476007)(316002)(76116006)(66446008)(91956017)(66946007)(2906002)(64756008)(54906003)(6916009)(122000001)(38070700009)(66556008)(82960400001)(6486002)(86362001)(26005)(38100700002)(6512007)(478600001)(2616005)(71200400001)(41300700001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnRxeHNmZkdDeXdKNEt0RkR2WGZWU3FtdTNmRU16QmZ1N082L3dMUGhFcUI0?=
 =?utf-8?B?S2hWcUVFeWpWS3NTRkZ1VzRpMnh5Sks0QkYzTllRTmxDM1BUSDBDTnREdTVz?=
 =?utf-8?B?Q3ZoODVtYkpPMFlybTNIbDNmcEJjTmJyWE4xM0ViVyttNTdGaCtSNHVHa29m?=
 =?utf-8?B?QWJpamtZMzNNUUlLRjJMYWVyTUtqMjdmWHM5SzJ2RHFySWRKL05LR1VFa0Za?=
 =?utf-8?B?cmYyQVNwd2JhbG1WT2RpQTREbFNzRFVaN2tRUEQycUJRVjV5RWpMZHN1akNt?=
 =?utf-8?B?S2cydmlSUm9CNWV5OU56TzhTcnptc0JabzkwcnlJb2NXZjdFYTRiWUR0ZnVH?=
 =?utf-8?B?MDFuZ2dNT2RjZUh0SjRNVGdjY3A2SEhoSkRxemdDbUx6TnpJcDJuZjhCK2My?=
 =?utf-8?B?alZ6bzJ5Y3ZIUlZpL1VGYW1ZYlVNcThGNERaN3lTTzkyQzgwaXZFWURXZUpF?=
 =?utf-8?B?eWRYNTl5KzlwOGxvYm94OGY2Q2hheVdyMzJMQlBxNkJ6VVRZdkNVcU5rRU9V?=
 =?utf-8?B?NHZQNmlhR085c3FRN2ZpT1k2QnM4OXR3VlNTQjBpNGp3MDhEcHZnLzI1dnpY?=
 =?utf-8?B?WmZUSGVKUWswK1o3MndvYThkL09PSitnVGtQYzRTbDBrQnJ5cXk5aU85V2tQ?=
 =?utf-8?B?QWtkZE02SzdNSHliQTM2VnVQZmZ1VXl6RFNJbitqSVdQSXQ3NEsxcjZMais2?=
 =?utf-8?B?V0t6c1BmdDlxTGdLbjAyU0dWaTk3YWN4SnQ0a3JCakJMcUgzNWVZUVROT1hE?=
 =?utf-8?B?M2x6UnJTY0lhU3Rab0lVNGM1cE5FaDFVS3o1aFNTQmlWZGJ6N0pGMmo4Mlpu?=
 =?utf-8?B?ZExoYUd4L3NiTm1LdHJ6SkkxN0o1OFd0SlU5SmJIT28vNTA2ZkJEc3QvOW1q?=
 =?utf-8?B?TUs5d0h5T0FYbTBUVG9tTGRJdGtKV1hQcnMzVWJtY3Z6SzZucVNUUnRuYkM3?=
 =?utf-8?B?b3BycXZtaWNoQytwRHN0MUZlNE1xTzhGY2hJZ041Qnpza2REMDFZaDNJVlhT?=
 =?utf-8?B?TE5ITWZpaFlzeHZiSlkrd0pLVU5CaG5vUHRpM0MvL21LamxOekFUTUozdk5o?=
 =?utf-8?B?RmlxYmw5SUQzOWZPRnM1TmQrRndZc1BYbG5Pdm1nVnY1RmgrQWFGLzRvbW8w?=
 =?utf-8?B?d1NtaWVVcGM4Z0s5TE0wSktRQVRxdUdxdVdPb2tpTlNEUjI2KzZCUGN2L1Ft?=
 =?utf-8?B?SFRiOGxRdmdUNUxTRUlaUlpLRW9oa3dTano1ZzNHQzNkemhGcVBtZndjL0xw?=
 =?utf-8?B?QU1md29HSWl3MmplY2ZhVUtHSnVPVmRNbzhmU0NNNHNxWVRqUkZLQk9ic05J?=
 =?utf-8?B?cFFROWlWZ1MwWVZGekFYZGYyM1hrQzIwOUFpdGZxZi9PMGZzZXlvZDBMd0ZG?=
 =?utf-8?B?d0QwUzRGcll4eSs2c1drZk9oQ1pOV3Fwa3E3YUNLODNKUjk2WXhoQU03dlVx?=
 =?utf-8?B?M2F2bmZISVVENGg4L2FGY3VoVVpyYnkwV3RORTd2eDNySUNEOGRUTVJlTmVr?=
 =?utf-8?B?L1JTb01iYTJWQjdadW9mVjBxUVRKZ1VMT3kycVBuRS82cWFxeklQNlFJTDVi?=
 =?utf-8?B?WkY1UlE4RFpZcWo2U0FFbXNRZVA1ZUZtNTcrUDJaVWUwaVJqNDRxVUVCR05X?=
 =?utf-8?B?SGU2ODlDZEdtSzlBQXl1Q3VjeUIrWm55cUxWUER1RDFvVjBockR2bEFQSWpK?=
 =?utf-8?B?cmxxNkxDRmdKbk5iYnl5SEZFaHFUeTQ1RUNiR2tDV3E5NDBNSVZSNjhZa0t0?=
 =?utf-8?B?R0dRNDhyWklRTVJtZUFrRi93ZVpnUHdaNHEwNGh0VXlSQTgwdU1RNXBkcHM4?=
 =?utf-8?B?YlM2Y3gxUUI0L2FRaTdvTjA5dHNKZHg3SFlIYk9uSnNKSVQxcVRXRld0emdm?=
 =?utf-8?B?VEZQSnB6Tkg0SjhEdGljRXVHSDJ4dG1OTlJvRVVQVXJObTZ6Yk1xS24vakFK?=
 =?utf-8?B?L2JybnBQajNRdytmRlFwUXVMZENvVi85MDBKb2NCdFBUYWExVHhXdWkxcTFX?=
 =?utf-8?B?ck9ya0hMUG9pdU1DalplbWJtVlkwNUgxOU1OSytDMXRvRGlYWWZRT1ZIWHFt?=
 =?utf-8?B?dDA2Y2FsbzVPNWd1dXNDOE5rK0FaY0Q0ZTJpUTNQWFU1NGpsU1RPTUJwSmI3?=
 =?utf-8?B?WnM1RFE4N2Vsd004Z1NSUlJKSHlwSHpvSTBKaStaWXd2RUJzQVZGSS9vZG9E?=
 =?utf-8?B?V2c9PQ==?=
Content-ID: <0E739312BF965C479FFFE75E68203354@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe58d3a-cdef-4c28-324a-08dc10bfaa2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 03:04:15.9040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SXccaLpZouikn6712Br25Nsry3nNd/EU2wgL9KVu2bRCXhbOWf0AHToAu0mAcScC3SUWvvS0xf0eaFC6G5Jhwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4618
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_190422_484765_32294093 
X-CRM114-Status: GOOD (  12.92  )
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


> > > @@ -835,6 +835,13 @@ void __noreturn stop_this_cpu(void *dummy)
> > >  	 */
> > >  	cpumask_clear_cpu(cpu, &cpus_stop_mask);
> > >  
> > > +#ifdef CONFIG_SMP
> > > +	if (smp_ops.stop_this_cpu) {
> > > +		smp_ops.stop_this_cpu();
> > > +		unreachable();
> > > +	}
> > > +#endif
> > 
> > If I read correctly this will result in stop_this_cpu() having different
> > behaviour for SMP and !SMP build for TDX guest.  For example, AFAICT
> > machine_halt() also calls stop_this_cpu() on local cpu after it stops other
> > cpus.  So for the local cpu, in SMP build it will calls into BIOS's reset vector
> > but in !SMP it will call native_halt().
> 
> It doesn't make a difference in practice: both halt and giving CPU to
> BIOS will be unrecoverable operation. Both are equally acceptable for
> machine_halt().
> 

OK fair enough. :-)
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
