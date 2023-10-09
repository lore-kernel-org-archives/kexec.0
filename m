Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D93BE95A8E
	for <kexec@archiver.kernel.org>; Mon,  9 Oct 2023 12:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JPjjd5jO+d7TgRM46BngqjIRp0NvZaXvkVjGb9cl1LE=; b=2lh/qD2fo/dgNg
	tYdW8MRCUIC8zRAptNYLnk772Yj4L9YCT2cXt7Lh+qsSM1OZvbF6h9w0qPP7L5o4+/3HYEQKozhZd
	TjskgjVyFxS6w9VoT3jsPmSHY0fQGO6xWYTNNzE1RvlOQN40vbPtWlSoFIXLKvuBYQNT+xz1cN2J8
	dWqXuXZKSm6CqiMM5TbHy5QU/TSOFzTjWEabgejYpdUkKSOLStBXw0jkKV4Jb6qdEiamISjfvYUCM
	daQEPuQ+u3Z1fLayPuhh0j1UAmw1hjJNXgcmuQXchs2m1DQpMj7IYcstZOuaWELCLiexSqy4wRnL/
	9uOove+XH/yiRTabG+UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qppPb-00Agpf-1p;
	Mon, 09 Oct 2023 12:31:03 +0000
Received: from mgamail.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qppPY-00Agoh-2L
	for kexec@lists.infradead.org;
	Mon, 09 Oct 2023 12:31:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696854660; x=1728390660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=34DkuhxnJI++Ab/EZpc4Lsrjmp5BtQNlhH6JNDDaVU8=;
  b=n5W1DMzfkDnmLLm61FZEKOj4Bh4V6eg3bRKmbgXAuthV+KBO/fyF43FN
   5J1tFTDl8ZMVKFQmh4aqSN/rbj90RDY2BBDwyIJEjTNOdaQP31z4DaB3T
   M3DF9Lc+x8yDinoXyWCVqn7DAfK1xJgr1kT66IMaO8m9seDWHW5dP3h3e
   ityCeLzYncLx7V7QZgtd77JRxDeA3eDvRmsoi5bvLhPRuzO0zlvosZErq
   uZAQ6pVu2cjSYVN1W1ffOq2FvFncxXpfw92zuF1+2Vtozy2xLqAyyHyyi
   PgJRhMS0Y6NHagCrisTL2MGu7f8tpqSdRAPuRkgRPwmlgUUVtSFQzHgeG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374458216"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="374458216"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 05:30:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="702889557"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="702889557"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 05:30:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 05:30:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 05:30:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 05:30:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 05:30:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/FG01MKG+dTnnhSwyo5Ye7tN1zwjgW35V1FYn3sWi+qq5v5soml6D4J/iVC824fuGFhh7O/9YUjaAyx9ckLlsAcEK+zQIXUhvWRJfLASPkKrVg2TowsU4QQM+KYWgfLPFwEgHUgFZei+hfvw3KWuyncGCXBjp5EaFXxkaTWAouRPNrh8ip6WEJhcivElvgb50ZqmpMBA45MzjXhm3SOiQwZhpLQcsnFDcfcRuvqd0MiR+Bf1S3eabjMBMl+Re95nq7fnZxBwR4dyP3R0CWGQ0uk5a3JGwhHF9pcgPCN+W5CNJK4s4ghGruD8cApglYd00WCmmKXXw2ttIpBImFmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34DkuhxnJI++Ab/EZpc4Lsrjmp5BtQNlhH6JNDDaVU8=;
 b=U+nv7HgUAGFOYegVMiuWHofyQWXqkK5D1G1e+bBfJEm4Tlc9sCy0u/xft2DSN+ZPLuva9SQHAh6WjIsDjW/5pU6dhsDxJECUDM8ZXOgMzGUUYk01hqhl439E2KXPvYBNtSj+I4T4+80y+aSDAPAdMOHyLkmfNKJLa0kD64U+8XkGYj03dCu5z7jwIATlexQ+xGDTsm6nmdEsd+bVptoKRYWxG0VULEiizMB13AiWyKnrwLVa/iN0dt4yx97cM8/+sVfGcj7E8JiOEJlnADfvL6384WNLqNC4RYV8PJpU2/nA+IsWrB3pri2eIgn6n0TT+Ngh8PVAofBykUF8WxZ+ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW4PR11MB7054.namprd11.prod.outlook.com (2603:10b6:303:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Mon, 9 Oct
 2023 12:30:56 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Mon, 9 Oct 2023
 12:30:55 +0000
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
Subject: Re: [PATCH 05/13] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Thread-Topic: [PATCH 05/13] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Thread-Index: AQHZ948nj/zMOYVRoEiJKhSTORDfuLBBacSA
Date: Mon, 9 Oct 2023 12:30:55 +0000
Message-ID: <2c76fa83b154566e49425e3a7ccc9a268318d63a.camel@intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
	 <20231005131402.14611-6-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231005131402.14611-6-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW4PR11MB7054:EE_
x-ms-office365-filtering-correlation-id: 8697b6c2-91e2-4d65-ebaf-08dbc8c395aa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wkIzXEpuzm7ObaDyILVWFho8xHPelgdLeyDErHnD0ygwAlAgdNLtXPF3h3HWZ9m/inwJdcQcpkKfMTFyElZbVh5TFeh0fIdEQmwgkHjXGPkgtDG9+KrcS0RlLfsuZC0Zt64GNksxKVN5TAEYby1Xji4QPFSd3IF3gX8UvPrNQoaEtQgUAp5JowRCqYg1+s1h5yRvUh3xgmdaHcvJBt3qGno+/V9PwNx3Q4PI5xpAycf+fC3uAzqMrRYgyKMBQw4m9tYPjWG36AmlXvN2Q8chdk3mMcsHIMrD0un5euYY1xH7Z5xluhhKMZt/glzp+kSBaBKwx9/rXKEEcvraJQer4foMgX7k2+yWU9U0hqiaqI7wf0OV+XPS657Vh3Aw9OSh/IoY4u5RCjNX+Hv5rAKPUi4TswhQlLnO5VkQjstqS63a1uta88vFE20Jqg6FakAlVL6A22wrklYq8ECPOG37pAveU6rpE1Tan1+AozDz99IsZfb5il96CDgYRjAkcNH6oTzzey7Oc5oQaqOt/ey7DiQcB34VzboFWnDNruBtx/6WlMZ5UQDVOaqeNOoXm/pDJYOf728tyeyMq/3V2x0xVawJfMttNRCkva77xCzNMr3QaMHBlgjc+L0us6ekctUS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(122000001)(86362001)(38100700002)(38070700005)(82960400001)(36756003)(2906002)(6512007)(478600001)(6486002)(41300700001)(8936002)(5660300002)(4326008)(8676002)(71200400001)(6506007)(2616005)(66946007)(66556008)(66476007)(316002)(91956017)(7416002)(64756008)(76116006)(54906003)(66446008)(110136005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTUwOHlYcnNjTlVZMXBYa2ptZXIrY2ZydVRydTZwZ0s3WVVOcWtxV0d0R0NV?=
 =?utf-8?B?RDBoK2NFRE1GWUJHYkswdWljdmY4S2QvN0VSV2RNaElZbWNZbW1ubmZ2d21K?=
 =?utf-8?B?aG9PamdvZnNXcVBYU3FCTHRBaVVnWEU5Wm03RSs5SHBEclFtM3BseTA3Q2d1?=
 =?utf-8?B?cVh2R2hwdUUwUFNwQmVaaVlMbGlhNFdZT3A5V0FTYW5VMkZ0Wi9GRWJYTHdj?=
 =?utf-8?B?V2JycUpoTzZBcTk4R08rT2NDakMralNKOVowYXRsQ1doWkF3U1dFTFRXNk9m?=
 =?utf-8?B?RjYyWHBoSndqWFN4NW9BY2xRK1dyUFVpdkoxcDFSeklMN1lzTGMwVy9ZL0JM?=
 =?utf-8?B?ZGtWampJOXV4MnE0TDVtL0NMeGVuNzZUNkhIdEhrbVN6NkFxay9hVzYwazM0?=
 =?utf-8?B?SU8xM3J5Q3h4NElsdENBYmRiZmpMQ1ZVbnZnZGtFaDAxNEEyV2dTQjB6NVkv?=
 =?utf-8?B?ZUw0SzNJdmR4R2VIcDBVUTlkOWRndFNGL3FLakVheHRyMWJycHVtc21nUGRs?=
 =?utf-8?B?M1YzQ3hZbFpack42cWovTG1vT3FRM3dzS0VrZ1JmVExFYk5rZzZ2SldCNklR?=
 =?utf-8?B?MlFWUytHVGZqM05EaVZReElDTWQ0Z3NFQTdMdEU1djl1RDZ3MEtIUXJlTHll?=
 =?utf-8?B?cGV0RnZONWcrYkVwV2hUTGpXazdWZktBQ0cyVGQxa3BiTXMrRWo4RTRrMGlH?=
 =?utf-8?B?MkxPekR0bUZvTVlNVjdQTmRaVHovKzlUM1loRmRMMjlWV1ZCYmRGbW55U01I?=
 =?utf-8?B?WU53R0NsbTN4ZkZmR0NBWVY1c3FLSGt3ZjNDSi9Mam1sd2lvVlRpNHNNY0pv?=
 =?utf-8?B?YVBvbE5yYi91dHlFdjU2bWJEWmZDZ1lseFhaY2tWMXUwUzhmUGt5OUVZTDA3?=
 =?utf-8?B?OFpVd3FZSnRlaTV1QS9ma3Jsa2xTcEhkTzZjTWRZdG9Sd0dwcWZaRURmZFRG?=
 =?utf-8?B?YmgzaDdsTjkyK0MwV0k3WS8rTW0wMDRJcDNxd0VkNHZURjdxajVIQm5Iaklk?=
 =?utf-8?B?VVhXY3NvWHdkRHpkRkFYSW5hS2lsU0h1K0NuZG1Oa2Jvei9qMEY3NVZhQVlt?=
 =?utf-8?B?eXV5WGlOSkNpaEFucGNnL0RKbklQK3ZQSGR6S3FJVVJhcXg3Nlo2eWVIUXo0?=
 =?utf-8?B?TTdVb3NQK0pMVWxiL1J2NkFBaUxsaURHL2xuVDhmd3g3ZHJCVEVac1E3YVVU?=
 =?utf-8?B?MENSVVM0ZTFRRXF5TFdmcFBIdHBhelJMelJKUFlFM1J5cUdyRkZTVE1CVlJJ?=
 =?utf-8?B?VXZwOVQzODlOZjd5UWE1NU9Lc21hOG1oMERWUXY4RmV2L3JUQUY1bkJEc0ZK?=
 =?utf-8?B?ek1XeWFGcjV2SzRVTWo3cDErMGZNMmpSZEZURERJQzlVY2t2dDVaNk5RQ1ZD?=
 =?utf-8?B?RUJ2d3BraWN0eThOUjN3TVNkL3FzMmNXZTh0czlSb3c5WU9YeW5pY0NjamhW?=
 =?utf-8?B?NmtmOHZsd2gzVWFwOEhqSE1PNExkNWRiL0tOR0RFaGIxSEQ3cDU1bWZKdC9K?=
 =?utf-8?B?dTRHdkZGejVTMVNycEpIZXVPUVNzcWdBS3FzVEc4NE9peGZ6OXdGUnZJNW5B?=
 =?utf-8?B?czdzL3JPb1lJcTJTUTc0YWc1K2FFVmo5eWY2QnF2YWxGTEFmL25rTkc5UTI4?=
 =?utf-8?B?VStaZi9RaWdBV09wNDNOQndiNWdRK05GZkl0WHB5L1BSSjVuUUJjWUFRemZK?=
 =?utf-8?B?NG5VRVNMTzNyWC9WTnpFbXd1WWFMajRpOSt6SXFQQk9KNFQ5Mkx1Wkh2N3N2?=
 =?utf-8?B?VGZmUzlyVnJZaHFPMmNEaVhRMlMxRGtUUk90OXlmSjUzV2V6OGR0aWhOanlP?=
 =?utf-8?B?UTdhdWZLdkpndnNvUVJnVEJrTjAvcWloT3E2emk4d1FXa2lVZTBuY0t2MmFz?=
 =?utf-8?B?ZTFYa2tFMHFLRzhJWWJIZWdTTUFBSUF2bThrVWtBcXlXeGFWdlF3aHNrRnJu?=
 =?utf-8?B?enFISFJ6ZVcwNmN6bHpxWmRBajFtYktPQm83cytFQ0NUb3dQeEtINnk1aXQx?=
 =?utf-8?B?M1RXZGZNaEFDL3VHNmRNSU5hM1dlcjJnNHFZeUZIZTFEMjZGc1lPdTA0cFJ6?=
 =?utf-8?B?bWh3S2Z2Mk1LcEFsdi92UEttQVZYSUtqUkhPcWdJcjJyWWRDNEVFby9Cbk15?=
 =?utf-8?B?RE9nQTArSWJLRk55cGxpWDRDOW5Ta2NSUE9INmVBTkFJdGxGdGFKOC9Ga3FI?=
 =?utf-8?B?aXc9PQ==?=
Content-ID: <CDAE0833FEC3DC4AAF98E69EF2EA620E@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8697b6c2-91e2-4d65-ebaf-08dbc8c395aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 12:30:55.7684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmboMmBJR80OOz0nRYG4W4eN6gPoJmvk6F9HvgGv6Dt0Uxf2rfWgi6DOSy2uyhY6d3fBZv+TX8T5ErEu+Tj3VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7054
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_053100_831132_FCB9B2A0 
X-CRM114-Status: GOOD (  17.48  )
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

On Thu, 2023-10-05 at 16:13 +0300, Kirill A. Shutemov wrote:
> TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> to #VE.
> 
> Use alternatives to keep the flag during kexec for TDX guests.
> 
> The change doesn't affect non-TDX environments.

Nit: non-TDX-guest environments. ?

> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Kai Huang <kai.huang@intel.com>

> ---
>  arch/x86/kernel/relocate_kernel_64.S | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 56cab1bb25f5..bea89814b48e 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -145,11 +145,16 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	 * Set cr4 to a known state:
>  	 *  - physical address extension enabled
>  	 *  - 5-level paging, if it was enabled before
> +	 *  - Machine check exception on TDX guest. Clearing MCE is not allowed
> +	 *    in TDX guests.
>  	 */
>  	movl	$X86_CR4_PAE, %eax
>  	testq	$X86_CR4_LA57, %r13
>  	jz	1f
>  	orl	$X86_CR4_LA57, %eax
> +1:
> +	ALTERNATIVE "jmp 1f", "", X86_FEATURE_TDX_GUEST
> +	orl	$X86_CR4_MCE, %eax
>  1:
>  	movq	%rax, %cr4
>  

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
