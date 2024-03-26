Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0122DCD1280
	for <kexec@archiver.kernel.org>; Tue, 26 Mar 2024 10:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rIH7QZtIggEsb8xdcpJEEYhS1UQwkZj8vuQ1YmHtgaY=; b=q6pH+qWag1+8Mh
	OKBkLGXYEs/iQxIlCl0PpMAasGzHV/9VyKwN3EQVE4BopKdpwmOEY7Ds3zSEAYqaq34Za1rRUiq7m
	xC+0l8svJu71sV47h1VVLxIXTgJCOO5oJiK36kV6NW8zBILQf9F/5jLegol/Z9snrWt1+DTFIE5qR
	AhyVCa4JpPycHtygycQ8GcX7qRISpHKBXEyJ5KnBTIxzRXA67uwqUW1FuUKDZXahc0xOHg+SxhADi
	O3qGnkvJv2Ny6onyUhZOeC5r9u8OcsGTTZKfKG5IcrD53DxPxm77CqswH0GAd3CXfY02sorgtglaH
	wQKfw7hD0QND0o8o/Ukw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp44l-000000043p3-0x0I;
	Tue, 26 Mar 2024 10:30:41 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp44c-000000043m2-3ymn
	for kexec@lists.infradead.org;
	Tue, 26 Mar 2024 10:30:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711449031; x=1742985031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fr6pay0+hUTzJDFc8DHbr2Ciz7p4NcQtjsZGsV1UkQk=;
  b=JWi33lWzCus1o8xq1BsFhk97ZTN4cWmFECgZmdrWHwTdKjD97l+AkpMa
   kjUfyqnDwDvj4J16/FNFE76j9AObk1EvXi6YQ96TNfYWFdOf681AreNBK
   GDODuXbH7R0eMzanzGUKAI9esOAOcDoJDYreRc6ZFKg7nUGdOJr86hKab
   FgUxddGebuTavMEEbxv7EOjwmpkr7q7l9VADThEoEQ7XtPOu8BEn6y0TT
   wifLkQo8QtJo6zPqOjsGKWCLYuf180/90/RGMFK4PNjpcBab1dXPIPtN+
   MLhZhJENGARpPJ4MK1YYKdWlV/u1j4tBiZeSPDa38FCT8r3COKTXoGXoP
   w==;
X-CSE-ConnectionGUID: UnGDfg6kQwWCpJA0VuvMBg==
X-CSE-MsgGUID: cnSJkCqoQ9+ocwn/Hbi9NQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6355944"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6355944"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15893845"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 03:30:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 03:30:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 03:30:29 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 03:30:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8P7dfb1Qv6KMbOvtMjbxcacYpHVXBKfGOAteMCsxoPvzKYPasCaqA/Uk0bub63vM1APuSHYLKX9Sy9Yq/9F1gkkYUaJ5q0ybv5kXlJbp+15NED+ohRStTJvGssstpfAgmiuE3LAC3zvHmzzEyWLaeF2UTZU6mCsobUXmwkBXFU0cLqRmPIVd/DMgFyZgZhxosSEdkcBfpthKs8RJ+oH16s7s2mRhQGIx5QO2L4/qAJTvM0VT6zSiVbqgh0/GLtl3cKd0hBs6ekYoJm2JUfM0Q9Xzo6QLDroWB/Cuh3H8a5WXXZySu2dx+rPoolb9t+GK1d0mlo8thSqinSQoH92Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr6pay0+hUTzJDFc8DHbr2Ciz7p4NcQtjsZGsV1UkQk=;
 b=Rj47aRNdWEk3otxxqZKRSYQz7UHN2N3hXgfT1DwCBZ8r4KpYS6NH908HtZHKu1ZtqJvHtmnqr5hsIjnJXDb8y4MmLrOa+HXSzTyPsDaDtFmX2Ny4NRulcJm/XbqyEMQV/C/0JUnyx0lsWDTxLdGGww60ZRTeVaLtBq4xHS9yv4GktXmHIEltIGq5y3/guE3C/7zuhWAGQ9xtaOrdek7kX1U03cpvhE4WYL/QK77fPuW9D2Liv87N2D/+NrYu5iYZC3HW6MY3e+ejYKqJZMtP/xQxHcbJq5vdigZ4yFcUt08BK7NGxqQNLDtaFavKj6FgemN+h3o99Rm6NrrsFCMk6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5279.namprd11.prod.outlook.com (2603:10b6:5:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 10:30:27 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 10:30:27 +0000
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
Subject: Re: [PATCHv9 08/17] x86/tdx: Account shared memory
Thread-Topic: [PATCHv9 08/17] x86/tdx: Account shared memory
Thread-Index: AQHafqDhyTVBuVGp6US8Ih8vYTctVbFJ0/cA
Date: Tue, 26 Mar 2024 10:30:27 +0000
Message-ID: <9e30828eaf9e4254d2d994cd11e469cca43314c9.camel@intel.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
	 <20240325103911.2651793-9-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240325103911.2651793-9-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5279:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /BOwGrMuC1/4hFNMulu4PosT44AOlK6c7xOfSQjdfN1dbuQ5TwOa+8w1NMPQeV+TxaX49kjXwkjk3o7dzi0zSg/b885ZvWy6AqDOCLabFMgNLhDlNdsKA4SI9TQ7RzPrju8vSa5f7o41cnbA6qDLj84Ol/gUQ6p2rWTGFcnYH022aKNxTt5O46PRgSQ4nFqeNTNku/qSMAOsRC8h7qGOSiaU81N8UKCNKjFZAwnfSumjeTlJmNg4gbwF06IpxX2zftYh6WWmQ+Z2H99XpRytf2XOiYoVYvz/opu/FZgjI0E5SrpDUw+dxtVQ70DxhqS37UYbXoR2u70XwDbcmnd/32Ec9uVJx7sqRG/vURNvuptZXP/iIZ0fPnM3unPmcj3Hxz6wBMXqYdjWNlGzYLiG8v1G6qH2i2qqUodfg/xBg6Rf1bJus7/McdVrESQt00XKNETPkKXeGsr3Cz95KUwINnRnlk4x37r+CJMVo/3pP3PUYWfC4GW5eP9vPPVo8I5pNEh6Uja9338Gz+y7lHeWU9QHxkeSULOqCwPZMR1GNhZxesI0oR6W6KfWDZdLHsSbC1pNf+CaYNC6BCG+apWqXK35t8UQJ604ANdRy0Iqn9F2tWmYe+vetK3ZcrPfkGtbRHgZiifqhf5RAx1jvIZX7ggDeEBSvHXtEF9KHHvQcu0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2ZHcHFjOTFzYk5aVk9Fa1F0RmlnWUwrTW9OSUlJVDN6SGdqL0hGRFNOb1dr?=
 =?utf-8?B?UUV6ekNwY2x5QVNVa21WNm5nY2pEbGd3Ulp5MFpBZkUwSTIybGRqZ3Nka21s?=
 =?utf-8?B?bG4zNS9hWEFPZ1UyN1RRSDVPMlJKUURDMDN1aWV2Qys3V2hzNDVoWW5FczB2?=
 =?utf-8?B?ay9WY2FsV29WeThTOHFPd2RWSldlWDcycitHVUo2NnNNSnJiVkJoRnFVS3VY?=
 =?utf-8?B?VVU4OC9NbVhwNU9NbVZDZmRYSTY2WmdDOGtjNTlEOGtieWxVSVI0KzlPVG5R?=
 =?utf-8?B?TWV3Q3BocHpNYThEVmMrb2hla1RRekk4K1JrNlg5V3NFaFRrUWxVdDBPdWdH?=
 =?utf-8?B?dDJkMnBzYWNaMGh5anNGOXNwTmtLcWRrZGZwbldKdXpBemdZVjhzYWtuSmxr?=
 =?utf-8?B?TUN4ZU1mSndCUzNrTnlsREd1MW1HbnpnSFhBeFNSSWVNbHpIS3pYWjZnMXFM?=
 =?utf-8?B?Q1FzZkFJVHBvYXdPOVFXUnFqLzJLVEI2U3ZORUJjN3hOWlZ5bndRcWROcG9r?=
 =?utf-8?B?WWhCSC9PWW9YM3Z5T05EK0NYY1paM1V5dnVocHlOL3BTaFp4dmplQmdLSURZ?=
 =?utf-8?B?N013TXgrN09aaVgvcDdsaG5ZVGlFU2U1R1prLy81V2pqRTRGL0xIQUVhbUg5?=
 =?utf-8?B?MzZZRGdDUFhHTXVuQlM5TFFxcEVJWmkvZmJxeHlpVi9ZNEhWNFQ4WVZlNG94?=
 =?utf-8?B?ZE1reU5KeVMvVldQNGhPakpZMGFBT1YvcXRKMUMyZXVMYmJnMXlyTjdYRElC?=
 =?utf-8?B?dG1yV1k5RUtPbDgvcEpva1B4MFRxNGVCSUZxV1RjZ245RDZnc3IxRTRVZTky?=
 =?utf-8?B?Z1A0MnBUWVpvSzdtRDdYS2lNVVAySGFEQUhaOUJkYmxWRUg5VFNxaytCWXpI?=
 =?utf-8?B?a1pQaGorODhQVnJsSS9YSU1sYkNIZHVyZVhrSjNwQTBNNDFwUUsrTWtocUxX?=
 =?utf-8?B?T1IrTXVTdUpTczFIQ3R3Ti8vS1BiVU01NDNzUDhzNWFXc1I2eER6cnVPSjhl?=
 =?utf-8?B?TE05QVN1M0FOL2VQUlczRVQ5NjJBSFVBZk9sVXRzeDdUT2RPcUd6UWk0M21K?=
 =?utf-8?B?SnZjV2k3ekh2YWdlM2Era1JlUHYvNWJseFNIS0F3dzF0YndVNGJqMHVYbTJO?=
 =?utf-8?B?RzFGdUpKU1RNQ2k4WUYzT1RJZ09JSWt0K3JaVDRTcEVTR0xtQ0xRVENCc0F4?=
 =?utf-8?B?UERvTFJqcDF5TisyVVB0MXQwcnBpMzFDbzJDOENqa3ErK0d0STZPcWVGMncz?=
 =?utf-8?B?aDZUUW5teldVOTFtZUFCc2o4OTZCamFlZUZneVo5ZU9pYzJDeXVrVmR2SFlj?=
 =?utf-8?B?MVp3VTVJdEFSZmpqQm9qSUt1QTl4R3NuNGRmU05KVUN6bTRMQUFEWnVWSEF6?=
 =?utf-8?B?RVUzOVFaOVI1U2NlN3pDVXMvcGZzUE5oVDQrQUxNQ3UyNWRZWnBxQjVjKzdL?=
 =?utf-8?B?dklvRzJjWUF6K05XU0JSbGpOTm82QXZhOE5PTzl0dUlDTi9tNnNJNCs3c1du?=
 =?utf-8?B?WXhBcDE3T3VZWjFQSmtSZmNNMzdYU3B1QlluN2FrTUtWYjMza05YUk9kV2Zk?=
 =?utf-8?B?Ym1WNkQvUVp4VGJJVEhDL2lXN1ZWdnUrc2JrNzhUdGJ6MHRtY2xpOERuSEsv?=
 =?utf-8?B?RUtiVG8zbHZwdU14bnIxWXdTWGxZc01udXJ6am4wNWxVR3MyV2NMK3pVNjRW?=
 =?utf-8?B?ZUpzNDZqaVA0UlBIUFcrTkIrNnZ2TFBYV3NzVTRHc2cxZGpJZ0UzbWlxU0o3?=
 =?utf-8?B?NGVIMDBXOHB0dzlJa1VnVVB1emFTbCtUR0hkM1ByNU0vSFA2L0FVN2JhSlJv?=
 =?utf-8?B?c3RCeGFHK2hPRDBiQmhSVXJxc3FDUmhVZGZYWnNwaVdXeEwxVUI4Rit2SlFG?=
 =?utf-8?B?YldIcm91NWl2VUYwU1drMHpRdkVZQmdCT0V4NlZaYTdSL1hraGNRM091dmV3?=
 =?utf-8?B?dnFldDNqaGQvUFZtU0RmTUQwMnhZcXR0dHNMSndVTC9zVWh3OEdXWjBUb2Vm?=
 =?utf-8?B?QWxsV2J3dExCcHFuLzZDYkFDMFdubUVjLzNnbUNhSG5lVmlWeDEvYlVPeWNR?=
 =?utf-8?B?RUUzc21NemY2SVgwUmhoOE1vQVpScEhLTEp4VFV0SjRVeDIxd0FNL3RqRXRv?=
 =?utf-8?B?THBZdnVPL3ZFcTNYZWJ5ZElZd216UWhBMUZRcVFXckdqMElnYUZjN3lScnBs?=
 =?utf-8?B?YkE9PQ==?=
Content-ID: <C9345AD76E84F94387E85F4B9C74CBFA@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d493ae1-900a-4caf-2509-08dc4d7fc110
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 10:30:27.4548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJ7YWIuq5KK63RW+XguJWdv79fQ0JwFDAT1v7qneSdk+Gu9lUVvEhb4vCZxzRgSjuv7PZl7qwhT3IgA/GE+8AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5279
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_033031_092454_C043556A 
X-CRM114-Status: GOOD (  12.64  )
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

On Mon, 2024-03-25 at 12:39 +0200, Kirill A. Shutemov wrote:
> The kernel will convert all shared memory back to private during kexec.
> The direct mapping page tables will provide information on which memory
> is shared.
> 
> It is extremely important to convert all shared memory. If a page is
> missed, it will cause the second kernel to crash when it accesses it.
> 
> Keep track of the number of shared pages. This will allow for
> cross-checking against the shared information in the direct mapping and
> reporting if the shared bit is lost.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
> 

Reviewed-by: Kai Huang <kai.huang@intel.com>
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
