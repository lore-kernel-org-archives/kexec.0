Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E5FC004C0
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 09:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IovSwpumffc3in0hso7k7zcjv9sCN7xC6CEBu9axw1k=; b=Nrl1hpSi3jC6Xi
	Bsvn5BWKBJadRmdSyITs3/4+PaPzfiTCJbXO1R/ZnxqI2+jk4ldEdmVxpyCnd+CNmy32Z5vDX0rtk
	5+zJeO6AKERSgszH3Uuaj3AxQVN3t0MKs6tCwWteU5d0E1k5Hf4dnxCTS/nJyErTtSQsG6zgLR+c6
	Id11ISurkmdovLcZNYx5iesXdV7pl3SwstlT2iQ4hCA9NeQ/7xHBNzWmmR3KlbA9OnkbYz3oJ//Jq
	0+bdir2zZmgSURvsCjoP0/v/WZXoxPAeQhR5t+U7slTYOPGqAWkGKIjfLEx5ftLnQkMxGyAnWj+Qw
	sr58fF3sqZX5JtOpIH3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtm8u-001i0h-1U;
	Fri, 20 Oct 2023 09:50:08 +0000
Received: from mgamail.intel.com ([134.134.136.31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtm8r-001hzj-1K
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 09:50:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697795405; x=1729331405;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=chPiyyeyOrN1WFOHBSB6Up9NIzjXXKNlzwuRJ0/qvEs=;
  b=WcQeY6jipasdWE8pBOFs+l6lLAeOysygCOG9PWgIVb7NZohV8xvmxDns
   Cat/zI3QPu1QD462xb4/b2ajLaw7NSWloP/g1InTMIGDyALA2TroszEZB
   zyfoRX8e5jSI1LXQycMkz7Nfpp4gRAyTMMJ0QyFFrBabRKcSfhpB73rq3
   5f6LGZGG1zqFnor9Cj2V9RIG6DG/Jh6ANcNI4hsSTBIDsj6GU6LT+cZ2b
   tW+Jjrb5yx5q3XbeIFJR6AZqbDkuF6QiQKVCQTedEBsSB7Vda7JfUzbTz
   r8SPEToELBiqFHQUuHPcvrDRAqk2DSDTzR22XgbXDBNzdg3HrPfNyEPjk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450694564"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450694564"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:50:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="1004555634"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="1004555634"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 02:50:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 02:50:03 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 02:50:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 02:50:02 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 02:50:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT8G1u+/Dd8wMm40w1rHwVpO7q2vNvFGnGtRy5iWtZXMhS/riU8bCifd2n/ot1f+aCEIff4mQs8qziHOFNXLv72yA/hcoIpyAb93gCgE03/Ui3QJHne0N5D/xAE5qqndopo48U87F8jqMDleFxfxoy1d9jytD/X3cQUsoD6qkyUPRBdDm/in06BgQaA2RJ5OirbG6fhU8qZa8HEIsP3ep5cvEuuAwIi1P9awox7TulsboSXrB6ClFidQ43ILOL9I6d8Gqp9LMc7dRvZuZtumJ6ItDXgY3zVSRUgfEp4uFd5ThzOwWzrvxWaFVcf0Q9lXGXh4yejLfa135M7CAiv68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chPiyyeyOrN1WFOHBSB6Up9NIzjXXKNlzwuRJ0/qvEs=;
 b=hQ4mhd1e2cK1BXpQfBO16nfxBF+Z0tUhSltOuUpk+l8c74MWZ9FBs4W4hKCbf0OK/OM915+v/6sJVRMqDuEqMAVPEdtvhteOJBjRxOjBbrdZqwKZs+8pSsOsUeQ3EjDfj6/hs66cmxBkDymxpu29zR0SZQRmO/A0qkQDNIcqKYXNX/7qk5xB4MyGgAteRHduStToNZtBVf6t2WyVZ/j8eK3AD400/k+b06YtzbvCDRRaOopdqFrrPMe9RaVxcGuA2xzUnMsOWR8IU2Cl/j4bv+V+j98YDtEtWZRzSaZqekeyCd49PkJiPngn6fyf8oNnQ7GiQIZt7mC08YzELyFVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24; Fri, 20 Oct 2023 09:50:00 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%7]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 09:50:00 +0000
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
Subject: Re: [PATCH 13/13] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Topic: [PATCH 13/13] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Index: AQHZ949Af5rSrjmHNUm2GvR447PSc7BShnCA
Date: Fri, 20 Oct 2023 09:49:59 +0000
Message-ID: <f0317ec1f52b96c76d8feeb3f21c16dec1de81c8.camel@intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
	 <20231005131402.14611-14-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231005131402.14611-14-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM8PR11MB5573:EE_
x-ms-office365-filtering-correlation-id: c535de9e-b78d-476b-3e54-08dbd151eca0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DleVCYJI8y3w9UqRVxacnp4+H2jXsq6zhakoG/mPZZZ+dTRV3gykY5Dzon2PbC1pXFJUc9u9TW+wayRdVaEJ9WBs/YLW88iR0jyI6nTnc/pQvpSTl1F+sso5UBT5ulCZ0f+IOw6bK3vMSsbP9qjGNa1y2sBbdTb+9e0vxTidBGWdn14dbdu1uMaCjsXWQBWLFmOmXMqwLjKkuTjScbHCGKnyUNAjJ6cfFmoOpNDBVKFRdJBiyUD+uhvJavrGg9v+zZam/Fk6ya0U8M/fwODI2RB3GPQL5OwnaKQx2yYTGi/3b0psqopDE2CYaRQJkzyPLrUUzEhKI/UAM8ZWa52pGMq5nIsPGu75Z9NwSS8jTC8Mb75rdrmPtSu/957LCLXNiDTFup3M2CzdoCU/HyV48S90P0HqM6NIJOeZ8BZFa8mhSGCEx3JJeBM0HW8hzs3WLs9ZGZ63BZ013+FGxtkt5KprgNMsi/No6j4oL1Mqk08Fup5a4p4q3N/dHGkAPREEQnoouLNAzps2rcK3sCuLbEs7a6wF19C60S7MBgW5cY7M5xFCygXZvlHTlbWB3vyGyO8i2OuXiSJsm7kuD2OZGQ9LL+jEtupNdUKFsRtiCRENUMovzpZqZ1wQcbNAyJKm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(83380400001)(7416002)(66446008)(38100700002)(54906003)(2906002)(122000001)(6512007)(36756003)(2616005)(86362001)(8936002)(91956017)(316002)(66476007)(41300700001)(66946007)(5660300002)(4326008)(76116006)(64756008)(8676002)(478600001)(110136005)(71200400001)(4744005)(6486002)(6506007)(66556008)(26005)(82960400001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3FDQkdSSlloSkNhVHdOaEdNaGVOcEx1dGRHNGZ6RE9QK0tpSUhsS0RublNX?=
 =?utf-8?B?NCtxbUdsTkdFay9BY2lCR2NJdExVQk9tNFhZQnZKcmlVTzBtS2k5QkhpbXM0?=
 =?utf-8?B?alZVOHlIdCtieTM3b0Z1anpYRTdkYlN5bWluSmF1RUJKMWYwOXB6WmFhMFlY?=
 =?utf-8?B?VDc3VFdmaDlDNGVkdzlJQngxdFhXTlNmdDJTRGdwZ0xmZFJ1bWZDamFaRTZL?=
 =?utf-8?B?L0xzL2V4TUFKTmIzT3hwV2FNb1dXNXlIUXFxL25rT3dzSkFER1JHaUt5VnBk?=
 =?utf-8?B?RnBNSXlUMkNVaEdYN3RJTmZlemc1SFhBUVhMckhBYkszL2M3SkxXUzg2SkFU?=
 =?utf-8?B?MkJEVTdzblhjZklJOUlhY0tXQm9IRWdjNWpRUTl1d2hyLzk4L1ArMUlsYWwx?=
 =?utf-8?B?cFhXcU96UUhPZGpZL0NtZ1dFWUczV3RXQ2NSOGtqM0lFMVJCOUs2TmhtMkdH?=
 =?utf-8?B?QjkwSlkzQXppc1hFNzFHTjRzckdqOTZ1MXIyMUNabEltU1k0MERTWDExU1VU?=
 =?utf-8?B?T202OVJJdHZ5cGg4S3lva0FNUU00c1dTRkw0andXdjFCMTR6c2k0ZkJraVYw?=
 =?utf-8?B?Tm8zOUI5WXE4YzJ2ZkxpZ216YldOUTZLZWVlMFVZYmNnbndFRmRUcTBBSUxU?=
 =?utf-8?B?Y0I3NE5scDQwbHFlQ0tVSk5vU0ZKSXhZRllxaTNnbm9Ud0VvMEcvY0tqNURJ?=
 =?utf-8?B?OFk1Skw1VkVzeWJjbnB3MFB4Z1JlYjNMWWc2Z2ZnLy84Sk1pWkg1RHlOZ1Ra?=
 =?utf-8?B?UVdYTEhRQjk3RkJ4R0N6dEd0OEFLVDdFQWx0dDl6YlFlWUxLbjdYc0NTdjU0?=
 =?utf-8?B?M3hyVVhGUGViSnduS1RibDRKdDBWNC9Mb0RzYlZhSG1yVlRRL294K2hUWkFG?=
 =?utf-8?B?cDlja1g4ZzFpVEJmakN6RkU1alc1eXNJUFpKTFVEUEd2cU04aE5RYU52b3lH?=
 =?utf-8?B?K296Q0cvNTB1R3Vlb1lqdjB1OFNQTGozYXA5WFhxUUpzSUUzOHNFanRpekxj?=
 =?utf-8?B?RVBqVENqRjYvR3hqOHllRTdKUEw1dWErRmdRNHY5T2FFWkJ1UVo4RmJqUVhE?=
 =?utf-8?B?T0s4ZVRPL25kQ3piZFRzTlBOSkZ6OTUwRS9Wa0NaeDgvdTNqclBTOGlxRGhD?=
 =?utf-8?B?U2VJelNRZFJMeHZVSC9HU055WXlXYXdIN1BVMlhMaE8vZTd5dUJBWU9wbjF0?=
 =?utf-8?B?Nmg4RWQrcVJ0NHUvVkJBRlJRU092OHYrM3hmN2RsbGNjZHg5ZUtOOTQ3L2g1?=
 =?utf-8?B?dWxLL1dnOVRsbWR6eTZSZ1ZSQnVCV1NSMjJUZWpmSmlTaTJwd3hFQ3V3Mmdr?=
 =?utf-8?B?R0RZai9jUElOWDdXTHhHL1NPUDAwQlU2dEhFU0dnZC9BWWpDUFNFdFlrUDFs?=
 =?utf-8?B?QVg3U1N1QUFoc2M5TzF0b0ZQNkFHMFNKRW1nZUwrWkdjbnlNaExMa3lPcHh5?=
 =?utf-8?B?T1dveXpOT2krdVF6R3dsY3NmMjNVNS9za1MrNHU1dzZab2hJV3ltL0dBZW9k?=
 =?utf-8?B?cy9sU1dkSzJTQ05RcEUweEJMeDlxeHlIeW94TFFtS1V0cU1nT21lenNNWThv?=
 =?utf-8?B?aVYrNFErRHJ5QnlLVGIwckNBMVprTHhLbHZobXdadHRubmRZcUpqNE5VV1Zn?=
 =?utf-8?B?ZkdXV2I4Ujl3VzB5WEF6N1F5VEluWVk1Mk4rWGluU0t0enV0SlkxcXRlMXp0?=
 =?utf-8?B?RDdwQUtMRW9ENFNVcjZ3QWtnQVM0dUlwL1FrYzE3ZkpBckxTVFFLNml4a0JR?=
 =?utf-8?B?WWZrMXUrWTRxcWgxdmRaSTQybE5tUXY1NDV3cDZ0Y25HbHN3QWpaRVNkZUxQ?=
 =?utf-8?B?aXBqNXhSVEtteDZ3NTVqSEduY2JocmpnVHlsMkxabFM5VWloWFU1WDhtVmtU?=
 =?utf-8?B?S3dsTmhRSUozSzRhcE52WDhBL3orRFVYZHBzT0tTdkVadkhkcVl6V1hZQ21G?=
 =?utf-8?B?NE14anllcVUwZWJjTlVnem96MWpiTzVCVFlYQ3FFOXQyZFVLcWgwUW16TFEy?=
 =?utf-8?B?T0VRZy9VQW55VUk1RmJBaU1YYUtnbi8zdDBaazh1RFhPU3RvR291Z1U4aDl4?=
 =?utf-8?B?clJ6bzJkNkd5U2FrV0hsRDR0WU1yb091YUpwLzg5dTB2NG9mLzAxc2M5aWVG?=
 =?utf-8?B?MGUrODN2WDFIUC80Wkt5SWgwak55OHRTTGU1UzZsSjQrczhZMmNVcUp1aWJT?=
 =?utf-8?B?cEE9PQ==?=
Content-ID: <A8D2C38AF9A8A94BAF6F1F6B3DB6FD67@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c535de9e-b78d-476b-3e54-08dbd151eca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 09:49:59.5422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: psrk3ynTA8Pv2AfyBFfO0etx7gJ31iMqwCyXDvW+19j3DWNvJMT71Ox8iVbRY49rOQ47qm2oann8tJn21xBw8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5573
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_025005_531206_B15C4925 
X-CRM114-Status: GOOD (  10.01  )
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

T24gVGh1LCAyMDIzLTEwLTA1IGF0IDE2OjE0ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IMKgc3RydWN0IGFjcGlfbWFkdF9tdWx0aXByb2Nfd2FrZXVwIHsNCj4gwqAJc3RydWN0
IGFjcGlfc3VidGFibGVfaGVhZGVyIGhlYWRlcjsNCj4gLQl1MTYgbWFpbGJveF92ZXJzaW9uOw0K
PiArCXUxNiB2ZXJzaW9uOw0KPiDCoAl1MzIgcmVzZXJ2ZWQ7CQkvKiByZXNlcnZlZCAtIG11c3Qg
YmUgemVybyAqLw0KPiAtCXU2NCBiYXNlX2FkZHJlc3M7DQo+ICsJdTY0IG1haWxib3hfYWRkcmVz
czsNCj4gKwl1NjQgcmVzZXRfdmVjdG9yOw0KPiDCoH07DQoNCkkgZG9uJ3QgcXVpdGUgdW5kZXJz
dGFuZCB0aGUgY29ubmVjdGlvbiBiZXR3ZWVuIHRoZSByZW5hbWluZyBhbmQgd2hhdCB0aGlzIHBh
dGNoDQp3YW50cyB0byBhY2hpZXZlPyAgV2hhdCdzIHRoZSByZWFzb24gdG8gcmVuYW1lPyAgSWYg
bmVlZGVkLCBwZXJoYXBzIHB1dCBpbnRvIGENCnNlcGFyYXRlIHBhdGNoIHdpdGggcHJvcGVyIGp1
c3RpZmljYXRpb24/DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
