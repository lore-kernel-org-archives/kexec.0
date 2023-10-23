Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB88CDB474
	for <kexec@archiver.kernel.org>; Mon, 23 Oct 2023 09:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WZ+aaGVz7MzirF4vsshzDi8zVnsersMSkrUDhHfyjBc=; b=NzTlwlZeiOLHhY
	OjaXh6jXuT5NjnoBk2Rifh9dmqLtKD0vQ8cBdBHjPGFNSgBPoIwuxTdGCu10Oh/eZrm/MXKy1Ul0z
	b83rgguwRQHqI113LfmSVelr+7lMKDwxXLPZY/aAjYn58jLbw8/rSg2Jy4fjOcF0rSp7L4FQ7T/xX
	ckw2x6mqZYX39JxCHCMpT8fS9VwBGcZ5Q4OSGUKHJuzNviRKGh6jShVI8XgvLGPabnyj77i5Mfih5
	7NgX0VLfEdmj0DT2C6r/eqU6+LY1BLMIvSZRa0aGCBPvIjoykKdtHFo6iO0MuZgHQWtkz5wMApvmx
	KGmsjcK38fPdpZVASCSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qurHD-006t48-1p;
	Mon, 23 Oct 2023 09:31:11 +0000
Received: from mgamail.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qurH9-006t2V-2o
	for kexec@lists.infradead.org;
	Mon, 23 Oct 2023 09:31:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698053467; x=1729589467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1xmeQbz0nrZdPT47tiJQg4qW/3NBRGUvgECMIwRgMGA=;
  b=fJ6CLVv4YiwCrbKJ5yzxPF1sFEz+dkqFK2QS9z+Ovd8mI03+d9ZweSjm
   sIjNB6Ooip076j1SFOjmKfgO2cuVneFpNl2GbjHLfMv7bHr9OXaf2oJQd
   NeO6jSdZF6C2RKtUmXeVfNfb4NMwQAXofVyEYiCODXEo1/siBen9xTqjf
   gHyfujk/kavOSnKbf7+JAlxPnGCbR+XS66xzR8wwiM/wB0+qBnZ8PTvgL
   IZVjEw9wHswEMzjORD52WolOQSsLxsHZpikzcCrFh6lolDxVRox7RI0pE
   0FdkrsbAyLCPYzaEiLt6m52hwQbN2L6gDnbPoj5J01y7X1cvise7j9Lvg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="371871316"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="371871316"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 02:31:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="901756193"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="901756193"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 02:28:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 02:31:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 02:31:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 02:31:01 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 02:31:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICZND/DqIRqgXqADrIGc7T3KVUDtOdnXYdlyy1QlwnKRIG7N7dXZAv3fjE1XL33QJNTHgkkM/tfUg/YXZJASAmI3u+hrRc1CkR6izLWOK6siBp6ZLABm5rIkGCAQi7oW5xExO6RwZhsIYl7EfIEDS9lcUMz7hyRtkweGnQYEfy6oSXeaC/Hij+wccHTO3Gnv/QeMZiOc4lKZQ2wzfmVUAhXyWnh22GNf1PrVN3KwXxhYHjMBzbJIxBUSqaZY9AIgmEeXGD2DyQ5jU4ObWUA/n8Us0y8iWvFKTmqejTCCUuSf2KQceVPlctjpSN1SpaLKH3BZPoTkqxdwHyowZ8N3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xmeQbz0nrZdPT47tiJQg4qW/3NBRGUvgECMIwRgMGA=;
 b=SWPhTXuk/bTkkKVGPTO67NCzEMkII45GdAo4vH+6RVVvDDMTHXsoUYj40QY3ZxFAgNwpRYZXAxJ75tGKNYK/RieHXZuFbkoJ3DTYiOmpFTwzWmI4SpWNSdj12C+DOV74iinRTIKMplJ5cS5FHq+E3qlC6gAusXk0UZom9TTB7QLdtB834UNxHIiU3dmodCOG0MuxD+xFe6ly4w780jUdlWEP9b2O+OloWNCoorCEZgSvjQYAb3qHeyj080OXZU1nEuOm6CoaHYwO871jr6payKozdOnA/tnb+VyfowtW/IyPg/pJQ1mxD0NtjApKo4YCyd96Z3/nCp79i2jWclvXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5438.namprd11.prod.outlook.com (2603:10b6:5:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 09:30:59 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%7]) with mapi id 15.20.6907.022; Mon, 23 Oct 2023
 09:30:59 +0000
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
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Christopherson,,
 Sean" <seanjc@google.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv2 02/13] kernel/cpu: Add support for declaring CPU
 offlining not supported
Thread-Topic: [PATCHv2 02/13] kernel/cpu: Add support for declaring CPU
 offlining not supported
Thread-Index: AQHaA2fulhiwSXIJjU27xCEE2qMPErBXIG8A
Date: Mon, 23 Oct 2023 09:30:59 +0000
Message-ID: <0a29fef814e51a2aa0030ec9cc97366718859411.camel@intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
	 <20231020151242.1814-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231020151242.1814-3-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5438:EE_
x-ms-office365-filtering-correlation-id: 4b508f05-d8e4-4ede-9495-08dbd3aac41e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b5xzX0Yx7w4XfV+z2v8Wb5KSh4Z1gQdP2RS/Ktp3GQrhxekIe4UzMLfX/ZgSN0R7OHd89a4BjbXRMol3rFns+6V44V2eo7PRDl+DFALaFb7gvqPjL1l6DNvnrsni2QG3/bwa/O0q7IX25CdVrePWIu94AKc4ByK5TXBRQnXsG+Ws65BEuKjRvqpdd+sokQ6z7MLZBXU7wSpYMvVwC45tbb9Rd2ddlt4Cj4N77F5pssgB1Ko5E47gVxoxGyfwzz24m5Xrodj+FSks4qVivPD3kUn4i0+oOIFZ97Lhc8CkSz7MNKbdWLAfmHkKyuBqCzm0FIJfTfPRWXOF3LiOt7FB78BcvVtek6KKSTRczchBO5MPb5fnB8fElhPxNYMhEXx6oxqm11KN68ErA+S5fwtbr1Jr2c7ixHHPST/CqUXGXUfG0sXSNPJksxsChKrjin9TBEXDqoMBSpfPbC1xW2GLLTUXSh8qxftUOMmezlQciyyRRjF/OCsEONBhoHgL+X7iQnhumPLh/1faTtp8SEBBZlPXLHVI8kfiuzd3XX8GRoS0zFTOb32W1hnXyzFSHLkF5NC5u1R0egJKYgmSELaENAYupSa0DG3Cv5OWGYo/8o5lRPEzl269FmqnSPbF34Eu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(38070700009)(4001150100001)(38100700002)(2906002)(41300700001)(86362001)(5660300002)(7416002)(36756003)(8676002)(8936002)(4326008)(6506007)(71200400001)(478600001)(91956017)(110136005)(122000001)(2616005)(82960400001)(66476007)(66946007)(316002)(76116006)(54906003)(64756008)(66446008)(66556008)(83380400001)(6486002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1o2QnhOZ0NoamRTWEVJUURNMW9JRkNvcGYyRFRIYkN4ZDNrR1VCYlEvRWM4?=
 =?utf-8?B?c0xjTmVkMXk1Ri9WQ2VMektaYWlWWHlLdXNadm0wZXBFT1c3dmk3NDNlakRu?=
 =?utf-8?B?WWdmazZpb3hPZWNIalc2U0kwT1hjL1lXeGZrVFJyODhaNDdtNVFiUXArd1pL?=
 =?utf-8?B?SXJpcDN2ZU1rNHR1SVVkN1BxZlptMGJzdCt0Qzk2Vm8yUUdUOU8rblgvNGlH?=
 =?utf-8?B?TFNOSVJ5RHRxdjNneTFNYmhSTitzOW5MaXVGYkpiWWU3cHJvb3JjbDY1ZVlT?=
 =?utf-8?B?bzltWnd5ekdiWS94anBZQXpGRmIzK3BSb29GYkR3OW9XYVpEZ0ZQZ29SRW1M?=
 =?utf-8?B?Mnpxb1dqZkJjeFVMNmlNRGZyVXFuZVRlNDMxZitDMWMyakxYemRrNkdsZVRY?=
 =?utf-8?B?cm84c01SWDI5TzVwWTFMZUFaQmUrM2ZQUUNMejkyYUtlK05OWDhBM29LZ3pM?=
 =?utf-8?B?eXU3L1BYRXN5cFYyVmhlY3NvTGdHZktxM3VFazhXNDB5LzhGeVhaYlZlS1Iz?=
 =?utf-8?B?eE5tVlNlZzYwZjM0eGNDT1JiQVRteDZZK3NPcWY2c0tYTmRocXg4N20yekw4?=
 =?utf-8?B?d0x2QjYvK2VpaHJnTngyM1hWSExwQlFTUEdLTENJQ2ZYU3RZM3Q2YkVWdzBw?=
 =?utf-8?B?enV5ZjE3bExNbGxlb0RXWDZGT2dtdlFBaFNSK09NUlZKSjJkRjBKY3RKSkRz?=
 =?utf-8?B?K3BycEFGTExJN3paTGQ2cU5BaTdEOEpocE1NS2tkOFRMT21iNGtKdG9HTzhr?=
 =?utf-8?B?UzJmekJBS2o1Zk16dlNCRDB0NDdDTFVnd091bUFWR21OV3FXSHl1dy9KSGpG?=
 =?utf-8?B?MFNmOFZndG80M2g3VEdNWjJTYmpYQklJWEVQOFdwOXlZeWxkYU4wS0pHd1BS?=
 =?utf-8?B?dzhwbXpNcWtzNE5TbGVuMDV0b0w1OUxOaVlTMVJnUGVKOGZnU1Q5WHA0cFNS?=
 =?utf-8?B?RGRidnhrcWJZWWM0dWxoNk9raW1HUlBieWh0WCtvR0d0U0pBcE1XVHpUOUZC?=
 =?utf-8?B?S0lKcERqN1VUZkk1U3ZkaXhwMmFCTWpORExFTEJrUHRaZDcwMzBFYThCMkcx?=
 =?utf-8?B?Nk0wMzc1Z3YzV2graE9oOVRQSy92MW9wdlVVdDQxVXlRS0tIQjczQ1hkVkxr?=
 =?utf-8?B?aUl6eVBQV1JSWFVhL09WR0xkd01RMlpXWkF1aWpubitsY3VMU2hsbkpIN2ps?=
 =?utf-8?B?Q2VZcmR1UFZjVm5qT0owbGVkUmZZY1F5T2U0eU5GQTl1dlcrMXlZcnBNT0VR?=
 =?utf-8?B?bnRSVHF6MlFFT3ZUTHhxM293aTdNMGIzRkFjeVlKOWNZaWFQTjNtUDNhMGhj?=
 =?utf-8?B?SHh4dDJYa1BNL2tDWkkrL1R4UHZ0QkI5VFhYeDArVVFlWElFVmFQQk5kN1Av?=
 =?utf-8?B?bmJjNzVIbkJtMUxiY2t6bnRYRlc5cEVqRVY3amUycHVCL0tVdk8yWkRGaEg2?=
 =?utf-8?B?VnR4TkkydE9UMXo3MzZMZVJSdWxTWFZ5WS9iUlZLVEZGblFCYTRyMUJkR0Nl?=
 =?utf-8?B?M1kvbDJyWGUyWEJ5andzRWxQOUQ5WXBSazFGTGF2VkthU2p4eFJCQ09md2h1?=
 =?utf-8?B?YVAwN0duY0tXWGxoM0NzM3NoSUpyN005RS85b2dTRm9mVTJIdmpHaThJTkZo?=
 =?utf-8?B?OGNHRVE2eGlIUXdvNHZ6aEZubDJLdTgxMUpmWGtDSmIxQktvZS9odlF3TmQw?=
 =?utf-8?B?V0F5OWRpQ0YvRm1NQS8wWVh0ODRlN01yQ0ZaOERLMzM2ZWNidm9mbjh5SWlx?=
 =?utf-8?B?UThYSDl1L3FGUGhzb2JjY1pkblRVVlBmbnFtVmcrc1JKcGlNbDNtL2ZIMldE?=
 =?utf-8?B?a3ExTWZNYnZGMlhRYVN6RFZDdDBHcDRUS3JTc1BObWcwZFBVa1ByK3dubGd2?=
 =?utf-8?B?VCtQMzNKMzVXMExoUWtXWE1hamc3a2tKSEg2eFRrUVVCOXpDdEdmUG5EVHo5?=
 =?utf-8?B?WTdmOUVyaHEwZXc0U0dORlk5QVAvSy94ZFQyQ0U1Zk5FSHhXK1F5VHFselBr?=
 =?utf-8?B?WkIrQUR4aDVRS2p4YVBMV1Ira1AwcVpvSzRnemlhMXBoZG9ZT1k3Q1huS2Vk?=
 =?utf-8?B?d21OSFpCakFqRGxsRzFHU2pkL2gyVDl4K0hyZjBzbFM1enY3ZXVIeU9BckV5?=
 =?utf-8?B?ZmFldXROY0VYb1o2VGtpd1Uzbkl1ck14Lzd1aXZLVGhZWG00Mmh0Zisrb0J5?=
 =?utf-8?B?aEE9PQ==?=
Content-ID: <0C784A48547D5A4A997D8F29325D9EDB@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b508f05-d8e4-4ede-9495-08dbd3aac41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 09:30:59.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5oI/AO7TakQnhIU3M7LV7VXuZzNzwOFhLDR4wNDlQyvfFjw76MBSe2FX6YvAfonF99vj4lXq4LpLtzTA2G0t7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5438
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_023108_024241_D07F81AB 
X-CRM114-Status: GOOD (  26.66  )
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

On Fri, 2023-10-20 at 18:12 +0300, Kirill A. Shutemov wrote:
> ACPI MADT doesn't allow to offline CPU after it got woke up.
> 
> Currently offlining hotplug prevented based on the confidential
> computing attribute which is set for Intel TDX. But TDX is not
> the only possible user of the wake up method.
> 
> Introduce cpu_hotplug_not_supported() that can be called to indicate
> that CPU offlining should be disabled.
> 
> This function is going to replace CC_ATTR_HOTPLUG_DISABLED for ACPI
> MADT.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  include/linux/cpu.h |  2 ++
>  kernel/cpu.c        | 13 ++++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index f19f56501809..97832ced939d 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -132,6 +132,7 @@ extern void cpus_read_lock(void);
>  extern void cpus_read_unlock(void);
>  extern int  cpus_read_trylock(void);
>  extern void lockdep_assert_cpus_held(void);
> +extern void cpu_hotplug_disable_offlining(void);
>  extern void cpu_hotplug_disable(void);
>  extern void cpu_hotplug_enable(void);
>  void clear_tasks_mm_cpumask(int cpu);
> @@ -147,6 +148,7 @@ static inline void cpus_read_lock(void) { }
>  static inline void cpus_read_unlock(void) { }
>  static inline int  cpus_read_trylock(void) { return true; }
>  static inline void lockdep_assert_cpus_held(void) { }
> +static inline void cpu_hotplug_disable_offlining(void) { }
>  static inline void cpu_hotplug_disable(void) { }
>  static inline void cpu_hotplug_enable(void) { }
>  static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6de7c6bb74ee..faebee0050a2 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -484,6 +484,8 @@ static int cpu_hotplug_disabled;
>  
>  DEFINE_STATIC_PERCPU_RWSEM(cpu_hotplug_lock);
>  
> +static bool cpu_hotplug_offline_disabled;
> +
>  void cpus_read_lock(void)
>  {
>  	percpu_down_read(&cpu_hotplug_lock);
> @@ -543,6 +545,14 @@ static void lockdep_release_cpus_lock(void)
>  	rwsem_release(&cpu_hotplug_lock.dep_map, _THIS_IP_);
>  }
>  
> +/* Declare CPU offlining not supported */
> +void cpu_hotplug_disable_offlining(void)
> +{
> +	cpu_maps_update_begin();
> +	cpu_hotplug_offline_disabled = true;
> +	cpu_maps_update_done();
> +}
> +
>  /*
>   * Wait for currently running CPU hotplug operations to complete (if any) and
>   * disable future CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
> @@ -1507,7 +1517,8 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
>  	 * If the platform does not support hotplug, report it explicitly to
>  	 * differentiate it from a transient offlining failure.
>  	 */
> -	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED))
> +	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED) ||
> +	    cpu_hotplug_offline_disabled)
>  		return -EOPNOTSUPP;
>  	if (cpu_hotplug_disabled)
>  		return -EBUSY;


IMHO it's a little bit odd to have two mechanisms in place, even in this middle
state patch.  Is it better to completely replace CC_ATTR_HOTPLUG_DISABLED with
the new cpu_hotplug_offline_disabled in this patch? You can explicitly call
cpu_hotplug_disable_offlining() in tdx_early_init() so no functional change is
done.

Or I am wondering why cannot just merge this and the next patch together, with a
proper justification?

Btw, IMHO the changelog (this and next patch's) seems didn't explain the true
reason to replace CC_ATTR_HOTPLUG_DISABLED.

	Currently hotplug prevented based on the confidential computing
	attribute which is set for Intel TDX. But TDX is not the only possible
	user of the wake up method.

"TDX is not the only possible user of the wake up method" doesn't mean we need
to replace CC_ATTR_HOTPLUG_DISABLED.  E.g., other CoCo VM type can also select
CC_ATTR_HOTPLUG_DISABLED if it uses MADT wake up method.

To me the true reason is the new MADT wake up version actually brings the
support of offlining cpu, thus it's more suitable to decide whether the CoCo VM
needs to disable CPU offline based on the MADT wake up version, but not the CC_*
attributes that is determined by CoCo VM type.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
