Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE97C3DA6E
	for <kexec@archiver.kernel.org>; Mon,  8 Jan 2024 13:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SaOjWptnIvLm0UzoafdtC1l03fYM9F31qTVA6ULo9lg=; b=ewgLVtPk6vNQsL
	3+DyTwB3GTImuW9TTwg4F8G4Un9toACpX0rAX3H1aXLOwIUbXiQO176zCTG0y6hbbXpb2oMw+an5j
	Bw69CSLaBqc9wgFZJ9N6QlVCZvMsDCb/XnI8lcMnrOKcBHojoaefQKs1OCqe/lVwapR82RFN/Ke1u
	xn4IxJpzdWbqlfv5kAAUYANEqnpx9VneoHr+/Nqg5SJ+rkU2NDAL5EFE/tj4Ew2mYR9nZsam0I2lV
	sdOQfXNChPF0pxaHSO8O8iczCsviU1dNg8nZ8Ru4B00IpMLLnJjkKwVn6Cn9AAQTua62o6hPBIbTi
	2uy0avMVwYSFqaUOkmxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMpRb-005BCK-2R;
	Mon, 08 Jan 2024 13:13:31 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMpRZ-005BBF-0L
	for kexec@lists.infradead.org;
	Mon, 08 Jan 2024 13:13:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704719609; x=1736255609;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LRY/+RTlVs9q5aDeVvVsbxeGiXv8oALAqjAtxh69h0E=;
  b=dzB42INo60BLm8g/QTwa7WA1fJgJ6qXwVoDZn0WQSCCGramc5D6qQtuo
   7kvYh3hSLvz8Rg8ggt3oE/PvHPY9JUItXiiwZ+lcUrMaFJmDinj0SAeeC
   YHDryAlMJPDWQ8+gmbom6+WMy/lsdK1IzTJi5dn8XX9/FfksN78fDvfpc
   uBYutN9MdCzbbAVtCIacBxyepz6aNo0lhFZFzhY6zzVQTja2dlogXYq30
   ZKclmnd+UkjlE/Gv1WsMWQsBT7PclaYDqEzTSzbnks0lhnUwL12WKd8Yl
   sHf58ilOrX9t3Ebxl2SB/iIJhCqLqFpPAatPya1BYpyyFfsR8RDOd4nca
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="4631634"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="4631634"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 05:13:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="1028396968"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="1028396968"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 05:13:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 05:13:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 05:13:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 05:13:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7MTi9olwB7DKjYSaQB7Q3S0cW95f9AW5QBzYuByREjNt7VA7wZudW1ZBIQJUtmWSeAcrEupiRDSPTH3Y5Lxw1Pa58aQxrtSoPpG5odxe7zCo7mMjPGrxDMORxjNjL8PBn1erN99czk5/llBn6lWEhgLkyYJtjkcnzBzmpVGngAdscUIT3CZdzKNIpcvLODTuwG6amCuRnb+wmNP1fIMfjfv33znx+bxwwc8WeN9PHnG9OUA64O1tFQUhgTJCLIbH5US4XyR7TOIYSQ2E3rjXfEw26FdCFxPCa8fVHOIMocgJ56m36G2SInq8Rve4oEXAZRez4UvJEGgiH1A4gvSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRY/+RTlVs9q5aDeVvVsbxeGiXv8oALAqjAtxh69h0E=;
 b=HjrnTZtLt5QQ+AQWyZT77Px5+tnsph9dWChl/fZTMjiiEP9uZjW+0SSR93ufeazdaLyU6xwq7cRt7HLeowi+mH/g0doedLb7IyZwiH3ZRt4nhdl5IVBRlfiZZDmHEX80iafX6Vr2CJoGrE4er9GNKjT6ctPmocCiQp5UF5f3VOEhUoNY64sYujV7x43ZKXJfb18gYNXnvBFkD5WP2OHa+j6viHkg4JxiFmUv1sNh+9BTBW/zsXz0pZSLKvPcWc86XV/42dc9/UaoF2JpbQm+X/zdnImUB16fLAnl3LB9WaG336D/GCZSg1XrnNnlHn2wg9rELiuv8Gube+zUDE6NPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH0PR11MB5458.namprd11.prod.outlook.com (2603:10b6:610:d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 13:13:18 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 13:13:18 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bhe@redhat.com" <bhe@redhat.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCHv5 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Thread-Topic: [PATCHv5 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Thread-Index: AQHaNTH0QWBZ51600E6mdH8oHBHhWbDPVskAgAAE0wCAAHG0gIAAMS0A
Date: Mon, 8 Jan 2024 13:13:18 +0000
Message-ID: <b0dcc7016e6810791fa0aedbe7728a5deab29f5b.camel@intel.com>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
	 <20231222235209.32143-16-kirill.shutemov@linux.intel.com>
	 <ba8265977a4b30f48b6b33fb135b714d5ada2a52.camel@intel.com>
	 <3bddc0a0d69b6b18ce3fd568e6a7e6d7be8a1a11.camel@intel.com>
	 <20240108101715.7hxn3wj6njemsf2x@box.shutemov.name>
In-Reply-To: <20240108101715.7hxn3wj6njemsf2x@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH0PR11MB5458:EE_
x-ms-office365-filtering-correlation-id: bbd00fbf-f1f2-431a-e1df-08dc104b94f6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qZ2/LC28kaNKNcOtfgEdKTIPtJmgLe4evHRknn8SDLMLVgC5DIkCpnTKLKNPvSbQnb0ZGVfOpd9ZQ4QCjBtsYfSvWe9FkqZLE0G8RIGGYuvfSQqN8k9XP3btFrNamjbqaGvfy3+d3E3rpnhi5cMlLLQXUPncYxHONjPoPVbBtNrfv6QTWxl6XJNIh8S1IdI42l3/6aavopLN8948j92NaNeBi3EUhEQwu0E0ALSnQtKZV0RF/vDhYt3wxd897rShBlFlMUcza+9hCopcFpTv5Asxf2AcMEuXltRIgYSewtFIY11sldAjZa4Z1d4yx4QUIBGMnSCsy3BOPOa8TBWNdYUIwIYyWpgzfNev7EVTPGxNdQtmsKLqWExkYISuLdCnA6WbYElY9AdiRkOfIv7rRexPNuUeK+x7MDoPmZRWfySi1sNimUGXAYU7kL7cyg6anVd3r+qhdfK7r1OzvXS7UDgUuXKm+RocmJI/E0JffZ6mmuv+yjroxjOgwmRNeWFRI/Vja91NSYXSirMr38L9wYeNDWAusn7oM+DLdcfU+QduXygrNTXKNblSZ4s+hv1YfEy+tkk1hAdE6XvMs8rtuOmjERsZVDQK+k0Kwu88mZxT7CHxBfRXbFekvlIKRfV7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(54906003)(8936002)(8676002)(36756003)(71200400001)(6506007)(4326008)(66946007)(66556008)(91956017)(76116006)(6512007)(2616005)(6486002)(478600001)(64756008)(6916009)(66476007)(26005)(66446008)(122000001)(4001150100001)(7416002)(38100700002)(2906002)(38070700009)(5660300002)(41300700001)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cklQejVFd0orMUtMTk5wR3RxMnRYdGQrTG5CTVplNjJTTzZlUEhZcVU0TU8x?=
 =?utf-8?B?dWtVanZ6KzJuT0h6Q0JwblA0dkl3Vm5GdnNaMkk5ekplanBhYnJtekxWTWFL?=
 =?utf-8?B?TXpDZGtFRC90VkJ3ODdoZWUveUtXU1Vpamd5R2taZ2dpa2E5OTdBa0tSa3Rw?=
 =?utf-8?B?Tlk1ZWNiMWl3bk5tK2dVSHN5eGtaVlpNTm95ZDRmME1WelhpN2Yyd0l4RTc3?=
 =?utf-8?B?K0w0dnRZTUMvYlpBcmtScnVXaCtRUnltcGllRm5lcnlUMFBGMkxQc3IrN0Qr?=
 =?utf-8?B?UGtWWndNZkdUa3RVNmRTN2h5TTQ2VU9LWEtSOXBOSDIwelNUUTNxQlZHbXZv?=
 =?utf-8?B?bXo1Q0RuMWFSd1lIaWxBUVIxWVptbzNmZTkrSDlsN2pkRUhxME1oL2RYb3ZL?=
 =?utf-8?B?V1ZjVWl6U0V4N3RwTi84bjMxVitjVnlpSDNrYjlvcjVjTTNNYkNiZDhHdFBL?=
 =?utf-8?B?YmRTTURwaitqOE1LNHRtd1YwLytyQ0lTNmljdytUSGp5OXZ5N2lFSVlwK3Rw?=
 =?utf-8?B?bHVaWDlXOFArVDVFRUVSamlzU0loTjBoR0VkOUgzNjZVKzVsU0hoUjhhMGk0?=
 =?utf-8?B?ejdpUGh3YXNPczBpejVmeklEUExSNEY0SVJHcitrQzFZSnMyVUNoVCtXN0ZN?=
 =?utf-8?B?VHloUHNlUlJ0T1Z1cDJONitqSnpzZ251cW1EdG5kVWZvQkkwcXRnZGtBQUpJ?=
 =?utf-8?B?d0IzOUxKdGhpciswY0ViRVdOYUJVQmlScy9HQkNxdEowbjJBNVZKa1UxOXdW?=
 =?utf-8?B?Z2h2dXFUSElQeGdUOFFxZk0ySHdEMS9talJKZ0hRTjB0Q0JkNWRld24vbzAr?=
 =?utf-8?B?ajdLY3hPUmlwTVV5cHRhUTRnRTZaWWhKL2ZPYUIvdFEwb1dYdS9GUmZBRm9z?=
 =?utf-8?B?c3BPQ3F0ZUpKMjE4S3lkQWJPR1I0NjJhRkUxNklibHpUeDNQdVVMblByM1pD?=
 =?utf-8?B?R0pKZmFtYkFpd0ZyTTh1VGMwZjFPNThGOTZZQW9IVTJUVDVQV216dkJkNEdG?=
 =?utf-8?B?SlpXWmYxSVk5V1FOdkh1VXRDdW9IL2xQeE5TUkVaZVNBaXN6WDRaWWxza2xD?=
 =?utf-8?B?Rm1WOWRyVHd6WGQyQVdNRlIyb2pjWUt0Rkcvb2QrRTI0aGNvYVZobWlqc2pV?=
 =?utf-8?B?TDN5bCtOWmwrQU5qNW5uSDZGUHI3bjIwQm1kVEVpcldYQkhCMUlWODBnTjhL?=
 =?utf-8?B?dEJ1RWZkRy9xWmJBYVVOeHRTZElBUHZacnVPYk9XMWI3dzg0WVJQbUkwemha?=
 =?utf-8?B?NVF4b1Iwbk1LdFErQ1NqeU9YNTVnVGlra2tOU2ZqK2M5bzVpZ01hZ2JRMmxm?=
 =?utf-8?B?VDRpWmJIZVlyT0xzWGNqaFU0NTVTcWVvRWpPTDVScTJqQUxhK2pwUlZyQXg4?=
 =?utf-8?B?c0paeTdHUjBmZ2xYSEVnNk9kcGx5TmNyVGF1bWFGQ2FyV2k3Rk5hQ1NCWWJK?=
 =?utf-8?B?TDhEMEdnK0FsUVY3UEV5NWsxWGZnR2lsNXFjZ29xakE5VVZScmVEdWc3WFRa?=
 =?utf-8?B?eUtubUx4WEhsK01tZ21GYnBiSHYzY2h2K1dUQytyRDY2cWZzTE03YnVmRXV4?=
 =?utf-8?B?R1QyTk9qYXRTMXR4eEdSYjU2Y0NveFJyeTQ3aFNMejNRdS9oVEFKVEI3WDhS?=
 =?utf-8?B?RkVHUjZlS3NMRWtyNGVUcy8zalArTm9ZamNZakpVS3lFZ29CalQzZVUvVXlC?=
 =?utf-8?B?NWlseFZuQlNQaThhWVhSYWp6aTBHcWpDWnlma1lmenhRUFhxSUJGb0dweEhl?=
 =?utf-8?B?b1JxSERnaTZxcjBPdXoyQ1dLWHVneUl3TnFQWk8zb1h0OWluNXlua3dUTDR6?=
 =?utf-8?B?ZUl0bjlHSWdiU0JwblBjTFlTTElsVFllakN2bmlYdEhMKzNGU3RheVFqQUNF?=
 =?utf-8?B?bVFWOTBjSVVPU1dxSHdlRDJGT09wNjljUW54a2ZqbzJTalVUQVh0U2xUYk13?=
 =?utf-8?B?Uk5yNmZSOWl4ZHZ1Z09PM1pxdmtERTNzY09SWlYzc1J6ZjFjWi9NYVN6U2V3?=
 =?utf-8?B?OWhCdmF1RnozejZrNE95V2dCUTFuZ01JMWxXWUt2VUhYZjVONlYxdVBRWGFn?=
 =?utf-8?B?Ny9pbXdFT1VJQUxGOUJsL2hLV0NqcURZLzBPTXhVSDVHTm5VN0ZCSjNwNUVv?=
 =?utf-8?B?T1l0NHIzeFNma2NNSHUvM29FcWNUQ0JTSTJIbjZ4aXJBN3NxcnhkTjNtWWpR?=
 =?utf-8?B?Z3c9PQ==?=
Content-ID: <938BAC25DCEE564DBD1A12264E39ED06@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd00fbf-f1f2-431a-e1df-08dc104b94f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 13:13:18.7417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9M0cCQHozmHEf0CuuUhrufeQXmpXfg4pAuurxKIyTJTzIBdKsCYAN8e0IVVFOsYXtHkoMDUrmeL0kHoBMCnNrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5458
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_051329_182946_C37F987E 
X-CRM114-Status: GOOD (  29.16  )
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

On Mon, 2024-01-08 at 13:17 +0300, kirill.shutemov@linux.intel.com wrote:
> On Mon, Jan 08, 2024 at 03:30:21AM +0000, Huang, Kai wrote:
> > On Mon, 2024-01-08 at 03:13 +0000, Huang, Kai wrote:
> > > On Sat, 2023-12-23 at 02:52 +0300, Kirill A. Shutemov wrote:
> > > > The helper complements kernel_ident_mapping_init(): it frees the
> > > > identity mapping that was previously allocated. It will be used in the
> > > > error path to free a partially allocated mapping or if the mapping is no
> > > > longer needed.
> > > > 
> > > > The caller provides a struct x86_mapping_info with the free_pgd_page()
> > > > callback hooked up and the pgd_t to free.
> > > > 
> > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > ---
> > > >  arch/x86/include/asm/init.h |  3 ++
> > > >  arch/x86/mm/ident_map.c     | 73 +++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 76 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> > > > index cc9ccf61b6bd..14d72727d7ee 100644
> > > > --- a/arch/x86/include/asm/init.h
> > > > +++ b/arch/x86/include/asm/init.h
> > > > @@ -6,6 +6,7 @@
> > > >  
> > > >  struct x86_mapping_info {
> > > >  	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
> > > > +	void (*free_pgt_page)(void *, void *); /* free buf for page table */
> > > >  	void *context;			 /* context for alloc_pgt_page */
> > > >  	unsigned long page_flag;	 /* page flag for PMD or PUD entry */
> > > >  	unsigned long offset;		 /* ident mapping offset */
> > > > @@ -16,4 +17,6 @@ struct x86_mapping_info {
> > > >  int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
> > > >  				unsigned long pstart, unsigned long pend);
> > > >  
> > > > +void kernel_ident_mapping_free(struct x86_mapping_info *info, pgd_t *pgd);
> > > 
> > > Maybe range-based free function can provide more flexibility (e.g., you can
> > > directly call the free function to cleanup in kernel_ident_mapping_init()
> > > internally when something goes wrong), but I guess this is sufficient for
> > > current use case (and perhaps the majority use cases).
> > > 
> > > Reviewed-by: Kai Huang <kai.huang@intel.com>
> > > 
> > 
> > Another argument of range-based free function is, theoretically you can build
> > the identical mapping table using different x86_mapping_info on different
> > ranges, thus it makes less sense to use one 'struct x86_mapping_info *info' to
> > free the entire page table, albeit in this implementation only the
> > 'free_pgt_page()' callback is used. 
> 
> The interface can be changed if there will be need for such behaviour.
> This kind of future-proofing rarely helpful.
> 

Do you want to just pass the 'free_pgt_page' function pointer to
kernel_ident_mapping_free(), instead of 'struct x86_mapping_info *info'?  As
mentioned above conceptually the page table can be built from multiple
x86_mapping_info for multiple ranges.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
