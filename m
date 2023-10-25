Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBDCC07545
	for <kexec@archiver.kernel.org>; Wed, 25 Oct 2023 03:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HnxwhgdQxWTYd8Lok5wAbXUoNnuhjk4wdvw0xt2Er9c=; b=iwvm9DNkfggNJv
	4RhtV6fAblOyNW34IrHQHMocFa3zegCkzm60s3xzcJsPRvVuh4jk0eN2R5Fn2SYfo73kvDLb2dpzH
	sqhayexN0tL5dNvXDEjaUQRPSsvfpoi3gUyL18K7hL5gob48PoweZH7XiMNtDNqHrJFC/LfnFJaIn
	BkYJmjMEhPzExlxQPlGwZHW4oSZqDxo1q2jjIAiuDztqoQvpFTOJf0bMFLtI7ulT2nHSaJ0FEhRGT
	3+O8x78LiUTimor2XeA+yoavDWU7Pko9aSW+mpJsm5ForV99jrp8QQIBgL3m83YZe0bp7Hb+3nAfl
	LwY6gKE3XRtcO/KHJCxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvUvJ-00BHUf-1t;
	Wed, 25 Oct 2023 03:51:13 +0000
Received: from mgamail.intel.com ([134.134.136.31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvUvF-00BHTg-30
	for kexec@lists.infradead.org;
	Wed, 25 Oct 2023 03:51:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698205869; x=1729741869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qoNOe2eGHADRLKQNUe3PxeIOsPgAyx1+t+OsOD38iUY=;
  b=lb7MMSoLe5l4ky2qSg6DuxU0nE8tRe7SONGAy7vZ3dQENCrJXxy9wFHo
   Tz8tkYA6Tj9x3aix4tJo81nmpHAqA3YH4LGy4zVBR2GQQTzAV4bCiweLe
   v0NNlT/JcjFoBusS6+j4WAOkbJ/8y2teUlhjMD1e7I1NskU0yWLsl0yQu
   iHWK8yXEnbHmKqFGhY6QT3n6napzzsJxhi59cpG38b7RL2rMFbObxBH0d
   zYcz+4Nx6P2vchq+XExn/C9fsMltQECYZhXPeaDcJHsM38dNQV8Oq13Ao
   vJgtVicEnwbHinrqBh3YmtEGouBe12l3/MUcr9zvwTYvP3aCw30pLIy6G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="451455157"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="451455157"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 20:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="932238958"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="932238958"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 20:51:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 20:51:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 20:51:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 20:51:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 20:51:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRKHYE2ro3OeBva/ArS+brp9GMrajd22tr50JifM3meefZlKgkQJcCv1yVB2F6FxYGjZ4SRLpS00lA9NSwl5GlKWGchF10758ezpjqVUF/vdXGgVjoWnJUUqeLxfBDIhVMFFByUcdR3Vhaocewz5mojcxm9LZEBSTJp/4w5epr1Exu9XtP0tlLnb7e3llqtP8haa1DKDTfYFmTiDmedo82TjVufdmxr6gh9b0kYY5CxtHz0JELL1/c+kc4+/DzXYxhOpkiwKvS+7ywo1UBnRhaoHh9SCurjBy9RPgxYd8h2ZvOOBX4zco5mHouRyINHlUzrKkI8lEaaWYFlTidlwQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoNOe2eGHADRLKQNUe3PxeIOsPgAyx1+t+OsOD38iUY=;
 b=Ko7Ym7JJhpG9UKR/+kRX7sppkj52sf44WACDDo6QYKfq76KDnjLBinbehlTJdfTn8X/m/by7dP/dgSiprnjcd0DFMV2dft/InoPrbDzCoEa9f9HEgQeqfbKhQJRuM2GweO/IluegZmWJRH3ckPFWuBn2OteBHEhNrL+0j5q1t59vNRt6HZRNQx2Duestq8V2TMJAEw6VPbRI3jQ1aiI8z36h2dAm+CQkVCGlhu9Lewag5dULFmUFrl3grtvK25Fvau5q7WM7iAOj16ntovyTrfVCGbuia5tQz9Qln3CeMQYuNb7B/PbB7WwhlGGodYEw3Irr7gjG3l+FB84RJQROyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS7PR11MB6176.namprd11.prod.outlook.com (2603:10b6:8:98::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21; Wed, 25 Oct 2023 03:50:54 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%7]) with mapi id 15.20.6907.022; Wed, 25 Oct 2023
 03:50:54 +0000
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
	<ashish.kalra@amd.com>, "Christopherson,, Sean" <seanjc@google.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCHv2 13/13] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Topic: [PATCHv2 13/13] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Index: AQHaA2fwP2oxJW5BTEmP/QrJKHzACbBYvjeAgAEn3AA=
Date: Wed, 25 Oct 2023 03:50:53 +0000
Message-ID: <43cb47df38e9be18402d9243aae4ac29b3728be9.camel@intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
	 <20231020151242.1814-14-kirill.shutemov@linux.intel.com>
	 <d86dbb81338d3473f24b3c479cf985a70bfc1118.camel@intel.com>
In-Reply-To: <d86dbb81338d3473f24b3c479cf985a70bfc1118.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS7PR11MB6176:EE_
x-ms-office365-filtering-correlation-id: 4e381306-d45e-416b-cd23-08dbd50d9680
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e13UlT5Eetg8Bcedzhkj5zn2goD1U3Khaxvkq119Juku+OodK6XfKcC5pxUu+H6F9dGAwQd7/dJ6T45maFxGkO1VB2NDbqcvU3vmD4yhbCxO1ZSakTY29qKZcy6soUSqzPV9Sy2Q57IgAreW66M2Cgbv0+g5gZaCTs8hoHS2xkr5fmuk3mr3IY39iZz+Q1JTlbPwJhpcgbWX5GDa8p0VVwwQHXZZJwvpnGQ+LjGr0bjCFPvBKRQRvYR3/yPefg9b6WXUhLZPl/uFaMt4cLKpXcMct7w5fKnAh7yDRIhuWUa+JdxXwTX2zi7WAzTti0ct9N1ywHK8MRdyMPhNPTBEBEc4//JOWMd1xx1Bj2n5lidmDeTpF8nJR0o9/EyXaqgx2JFmiLb7UH8WzKHyw8o1Oh94GHx791DbFfrI8bnsbhoSxLjXz5QLv8GfM+x8xKO7t1flMqS4uEwalg8sI/8f6GVSZgcaS1PqEzQWQkihB/DGMbtrAurxDraRQhz3ee/Azv4GeQlDyJH/rie7OCBfmFksKOwlGeR+cBGq5x4D+F66/bF0gAY+4qEVkOaj43W87WiB6e2o8BCsc7Gban9382Gs4g2r+QeNKy3AViHwujA5P7vp+2xVCtTvOpgJVefs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(54906003)(41300700001)(2906002)(38100700002)(122000001)(66476007)(64756008)(66946007)(66556008)(82960400001)(76116006)(71200400001)(2616005)(478600001)(66446008)(110136005)(91956017)(6506007)(316002)(6512007)(6486002)(83380400001)(4326008)(86362001)(7416002)(36756003)(5660300002)(8676002)(8936002)(26005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDZaQXMya0NZYloxRVQ4YVZhWHF5ZWJzTStZVnVFWFd5U1NmWU9aZVBjK2hm?=
 =?utf-8?B?dllNM3M3czY2N1p4WlpwY3BWUjZFQVJET2ttd2N5N1ZyMFBxYWNlZ1pZUXNX?=
 =?utf-8?B?eHdraEhDLyt4eXhwWklxY2NoNlVWNmx0cFNDNm5ieTl4c0xzNWF0WEdGUlUz?=
 =?utf-8?B?L0l2RHgyUS9BY010dDcwZ0Nsc3NUYlkwQ3VLbnBoSE8waVFWVFRBOWpMN014?=
 =?utf-8?B?R0hNUEs4ZGorMWJYM1Z3MmxIclVmY1QrVWtuRHlqMDVXMllnUmJVMmRpdHZv?=
 =?utf-8?B?L21MYVJWUFhmRE9aN3kvcjloVDlKSXBVQ3NlQVBSS2UxMElObk56dDEzQmxN?=
 =?utf-8?B?T09sbjJsRTlYa2hZYTVHQng3cVVDNzBJSjNURUh4ZEV5dzJDQmlKbHBFdlRS?=
 =?utf-8?B?T3IrVTBJMUhWMHR0ZzFMQ2gyRE0vRmRMOHhTNWdPNFRlempoMEgxNUVzS2pU?=
 =?utf-8?B?Y1M3OVM0V0c4NU9Pcjg5L2swbjZCaEp6T1hLUnhKQk56WnpZQUZBd0NkV3lr?=
 =?utf-8?B?NjBDYnZtODJkSmxqUXNscEtEb3JEa3llamdEeGNLSEV3aHFXeWQ2V2oveGVZ?=
 =?utf-8?B?Q1lST0xlck1udkdoMTlvRjhocnQ4QzVkVE4zU3F5ZkFnNmFYbGZGRkM1NmRi?=
 =?utf-8?B?TmxtV3ZKTHU0ajN4eXcrMkhSZXpCZU5QM0k2ZmJJYkZkQ1hwZjRZUERic3hE?=
 =?utf-8?B?dTdLZVBldVdMa1M3b1VZWHR1ZnREeTdJcElBZ0dNVXdONW1Va3pkeXhZUGtL?=
 =?utf-8?B?eDZ5RHB4eldCTjh3T0tqVlovUjZEVC8vZWNMUXVIcERGTStJcnA5RG9TcEVW?=
 =?utf-8?B?UG44VTE0Qm9ZRWRqbEpWTXRHRVlRTzdJNWR1akw4RnliQUxiVUxDS1RNZjZr?=
 =?utf-8?B?STVoRTNjbkR0RU1DM1FLcDlxbG5neEUwSm9XdmFCZVVha2hIdnczM2NZeEcx?=
 =?utf-8?B?Q1JpRFBPLzJRYTJWcTlNWnBJYzNDdXQyNWxua1pBM0NZb2hTUGVCNDI2N2xY?=
 =?utf-8?B?Ynh3cFJTMnNsTkpCN3ZnSTNMQktzdzZVQ28vb05SYUxvTEVzVlZrYzM1YStw?=
 =?utf-8?B?MUJYQUFKbGRMSFVHalEyRXRYVy95QTlyNktxQ1VsemtvdGhPUm5UNkhxNUlQ?=
 =?utf-8?B?WUFkWHEzOWlFQTdVSXZVVVIwVlhWbExOZlZmMzNYWHI5RlNIV3hTazhXYTMz?=
 =?utf-8?B?THhBOHZ5ZmxXTjZWOVRGcFdPMzZYNytlSVM3TWIwNE5yM0VNUmthdnlZK0lq?=
 =?utf-8?B?N0Q2WDhVa0RPYW5DejVFK3YwemJVOEsrVTd1aXJyd2s3Znd0dVJWN0tWMWk3?=
 =?utf-8?B?S1lEWTlyNFNUVWN0b3FxQzdscldYakJlSTFyK1MzZDAwMWlJSldmQ2thKzZL?=
 =?utf-8?B?QjRrY0dKajlrS2lXRUU4NTJJYXJtWFhRaDgyQlNiWjFwK2NoZHlIT05jREZ6?=
 =?utf-8?B?RmRvWERLZHNKbmlRWkZNZW5DMnltUVlEb2E1eGozRGg4R09yem1EMWhrMmVq?=
 =?utf-8?B?a2FqdlRMRVZCRXR2NnVJSjB1djlDMnFoQlNPNHhFU3NDNzRGdk5sTzFEVUxz?=
 =?utf-8?B?WngyU21lUkszOGVSa1U3S0hNcGN0ZmJKVmlvWWkwM2tPSVZhR08xSmhYRllK?=
 =?utf-8?B?eTREY2JVc05ZT3NnbHdYbWdHOStLeCtyWEFqQTN3VThIZFRSRERzYm5LdFJI?=
 =?utf-8?B?YWM4ZWVHSHFIUjkvWVhrNmc2ZlRVRFBWMUJxOUhBSmRUQlNmNWVibXVkYU43?=
 =?utf-8?B?dUpxb2pVbGhPVkt2REIvRDVUdVNLZEhVSmZyM2diaEQ0Z2ZlN2NkZkdJRktF?=
 =?utf-8?B?ZUtvZXQ5bUdnMTVUOHRubGxkakVCb1J6YTdJWFhOaEVlam1MelkyUE04QlRi?=
 =?utf-8?B?cVhNeTBSTlJONU4wNGFMSUV3Y0lHNEFDV0dCU3RHTWVWVFEzN1h2Vk91RDYv?=
 =?utf-8?B?QzVBeFVVdE5UNFNhVGhtU2M0b2JLS2RwZmx0UkdLOS9ZbWpGVVlyQkUxOVVa?=
 =?utf-8?B?eEdwWXNTOXg2dTBRbzl2cHVrRlVhVXUwbmoyd1NoSWZIc1ZzdTNkTEJHRFhY?=
 =?utf-8?B?S1B5ZmdTUVJ0ZVUrQ1FyQzZacUs3ZkRNL3o3T1FqNzgxanI3K1pCQnFHRHI2?=
 =?utf-8?B?eCtQaHRrQ3pEQ2tMVGc4ZkdpalV6WEI5bGJGK1FTR2FKNXJsVi9ucXZuOC9C?=
 =?utf-8?B?K1E9PQ==?=
Content-ID: <4DB101B29C7C5949B9883332033FCF57@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e381306-d45e-416b-cd23-08dbd50d9680
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 03:50:53.9007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufax4tyOXKR9zH4gAPu0maVkqO074zYayes0fGpjkPL2Wwe68TUTj/4oMvD/PcrZ63htLMWAQ301iqdo5JMhQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6176
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_205110_071989_41B87B4E 
X-CRM114-Status: GOOD (  17.57  )
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


> > +	.text
> > +	.align PAGE_SIZE
> > +SYM_FUNC_START(asm_acpi_mp_play_dead)
> > +	/* Load address of reset vector into RCX to jump when kernel is ready */
> > +	movq	acpi_mp_reset_vector_paddr(%rip), %rcx
> > +
> > +	/* Turn off global entries. Following CR3 write will flush them. */
> > +	movq	%cr4, %rdx
> > +	andq	$~(X86_CR4_PGE), %rdx
> > +	movq	%rdx, %cr4
> > +
> > +	/* Switch to identity mapping */
> > +	movq	acpi_mp_pgd(%rip), %rax
> > +	movq	%rax, %cr3
> 
> Do we need to switch back to kernel direct-map page table after CPU is wake up
> again?  We do support normal CPU offline/online, but not limited to kexec,
> right?

Please ignore this.  I found if I am reading right even for TDX guest the new
online cpu will start with trampoline_start64 assembly, so it will load kernel
page table anyway.  Sorry for the noise.

[...]


> > +	for (int i = 0; i < nr_pfn_mapped; i++) {
> > +		unsigned long mstart, mend;
> > +		mstart = pfn_mapped[i].start << PAGE_SHIFT;
> > +		mend   = pfn_mapped[i].end << PAGE_SHIFT;
> > +		if (kernel_ident_mapping_init(&info, pgd, mstart, mend))
> > +			return -ENOMEM;
> > +	}
> 
> This is for kexec() IIUC.  Add a comment?
> 
> If we consider normal CPU offline/online case, then I don't think we need the
> identity mapping for all memory?
> 

Also this one. :-)

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
