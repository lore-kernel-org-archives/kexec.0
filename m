Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC7DC47422
	for <kexec@archiver.kernel.org>; Fri, 26 Jan 2024 14:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sL4hSP0zUKkmymsP/SKObXFORAr4ZSLm35s41/Q0oKU=; b=JIFJF/drJQOSO/
	fbIqVKagi8NH10P4bhOIWxq4K5ye81b7x+4VAlnOPweJV5gQ01ybzJId1sf4/8O5w2B47IYb4fm0n
	BqPPdrX1YXQzVBwmAmR+nVDss6/KjB7hoJ2fj+l7oO+QrQQLFJbbQbTLnJZjxkJfWqL2dm1gwV1gJ
	jy/vNhqHgv9lP5nlWBs8AYTOniO9/DyYsu7icWm/Au/ycfQgSHLybJzRX0G7Rhgc0XnOAmF0IG+Uh
	yLoGXA/DLm8ps9KPmBCeia1hxj3lv51hlipPWtxl2BHsLP14kUzcFHXNNzppZiOqbaGttmgMFNJpF
	hEXm693u01+jdh00qyVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTMst-00000004Hjc-3DcB;
	Fri, 26 Jan 2024 14:08:43 +0000
Received: from mgamail.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTMsr-00000004HiR-02OR
	for kexec@lists.infradead.org;
	Fri, 26 Jan 2024 14:08:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706278120; x=1737814120;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WYfG8WkiTDQ3PZnDwgK27a6qqHwFvCHRq37dFIugODM=;
  b=DbcyPQUcWEeAoXfcBmyLebNBtu/MPLLN5iwATOujGDAUyMPXB86h6ucw
   pyn/6DUjYwg9S0xW9EuB2gshvjDdKpSA/vPsxT5Bs1McwbYo4JaRxSUiQ
   3DLVzUTVPa6GFjBRhemQ5vIT0ThfSv5G/CcueeN6KGzVdlD23zHSqLL2b
   rVx2ikdgb0/SfA8H0WJ5TrkUTwQpdd+3bQdlKhK0dkIW8Qg0aRi3fdkk1
   XaKAF0BeDZqI5IaeWCiYYQzOx+R7G5T0vQfipHS6X+eUKHVN2+aUORn79
   Ys72R0G/qAXSTmBasazu3Khbvnp7p8AVujLjKU+HLVAotqG2D1N5xGAqv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="392911805"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="392911805"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 06:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28831297"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 06:08:38 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 06:08:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 06:08:37 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 06:08:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cugOT0zTqn6kc85p1CYByi7wWKKq9IE3u3v4rdU7u5DU0M885ZoNkz003By9gZCpXQiGE1JPPMgxDJt+fQ7MF7dmUEpYkxkiQpzmSOzv1vCtJS70VGAzPMBPrgEelMLda9TJiU8W555O00cPEOtLFs3DUPj/3XDUQNy8QmibeGQkxz5ocl2MrCKQ/H7Yw8a1dVqqSzxVD9u11ZOLTBlKoo10yQUtvdv+zd7r4DMNmvhKcOOeysGWJYS3EEQx7iEgfoVKsmkCgJxg94MFeZE9s+A1aLDi5PQeDYeEvta1VORV1pW76uW2DDiWtNiOpRV8jadHCy36QQzSo9JnXXUBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYfG8WkiTDQ3PZnDwgK27a6qqHwFvCHRq37dFIugODM=;
 b=oLldi1upV6wrmtAzNSl0C/hsKIjtwa+Ev0N6ib/1VoARvvPsVo0Oq0WOCDzYGYKLlId1NsxFptaMQMzU+DmGVT3BiflLbAjicQK0VDbIMQsXsGZkHRYEbKwBkRdn7PMU4on5vq8XwX1VAxnCsI9Gw0Udn0zc4RXHF8qWLx+8L267+X1tBC1BtcA759+JEnwohQ01KJcWRrkMubFnXoh+SeobK7mTBukp7+SoVctIykYs+xn3IkpAF5aIUGfFI72lNnYlbDQPcTbmLZzaHVHKLg3n4zWJPMgZCmvetgqGwb6OnNLNPXL9BGj3iAU1R3ZgfMNvL8cbXQomf8s7lZvLjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 14:08:35 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec%4]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 14:08:35 +0000
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
Subject: Re: [PATCHv6 14/16] x86/smp: Add smp_ops.stop_this_cpu() callback
Thread-Topic: [PATCHv6 14/16] x86/smp: Add smp_ops.stop_this_cpu() callback
Thread-Index: AQHaTsTwkHBmL99raEi1zxttIjQCR7DsJL8A
Date: Fri, 26 Jan 2024 14:08:35 +0000
Message-ID: <e2d6aeb8eed69bd9a648de59d7abfa255b503259.camel@intel.com>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
	 <20240124125557.493675-15-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240124125557.493675-15-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5262:EE_
x-ms-office365-filtering-correlation-id: ed8ab966-97a4-45ca-e88b-08dc1e784930
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5lTQev0Eb/cTbEWri9IfJmXbH6u3k4mLlaJfuyJ4xqBf/f+ZIN/5QegRq1brWCILaCyt6JHdcqO9LTwRWy3RIYaDrzi7udWE1DES1QS9sUBkgyW2sDnsUysaUVH5qGvRepRe4H6BJwHkCq2lDbqLZThdez1PGLRPHNNe5k7PUP/6D+4d71TJldc3PGSa83K8mmGly1M0xXfcJhDMtfu1qbF6a8No/Cp6lYzWTdmEd0PmV8vXToqlqZjDpkWBP8iRTbcrEIZYwk6togoMs9lKrnqF5zDUobbcMNT9Dfyhm9bc1XNGKHCOkZqOs870h4z80fLIAC9CREzN8xyxmPZB4dv6Db12TgHSr8BqeRMYdYwvhlMBjZIh0bO6wvkGZjkomuo3OoA+y5B8IEbiOWss18KGnnLLSz3RYFQz+kl79+Fxlng9ZnWP0+qc6KaPHwKnLS4vdu6wAGA09XNuofbZyNFKAMC04MSp2F9Y7xVTeCaRjljoFtIqvyHaHd/2CxsqfvB1WrPALj9vSG0l3oFltq1lpDH+grIscCK80eb311HH5k6KTYIo2KaoZCGuy/1YUeuEcX6pNk3shcmzqGCclYkHTJIF8m1/1TJ6/3KCTR5d1Vb+I2pKGm8Q86ml27wZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(7416002)(38100700002)(2906002)(122000001)(82960400001)(41300700001)(36756003)(5660300002)(38070700009)(86362001)(6486002)(26005)(478600001)(6512007)(6506007)(2616005)(71200400001)(83380400001)(4326008)(8936002)(8676002)(316002)(66946007)(54906003)(66556008)(66476007)(76116006)(66446008)(110136005)(91956017)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2laR1hsRE14MDdxTVZHQVR6RzdiZm5YTzJFZWcvc3VkZXAwaFRTZTJySDRh?=
 =?utf-8?B?UGRWVm5PSEVhY2UzL2I2KzFGUXBwLzFOcW1HRXZ6MkkzWXE2ZVoxQ0hJVXow?=
 =?utf-8?B?ZHcrbDJ2U3liaXE4cDVzamFtb0ovNlhGRFdMemhDcVBGVE10YjJYZFZmWmUv?=
 =?utf-8?B?b1FCSWZOQmU0R0pyQVRrTi9ZUlRzOE8vZER3KzZwNTY5SUxUcmJ5SnVLQWtm?=
 =?utf-8?B?MFdEbW1oNEFuNkRoeVlBcW5JQXA2ZU13K0p2UUxqcjg5ZHZ3L3VNa2J6QjhH?=
 =?utf-8?B?a2VVb2ZkWDNjMGlFdzVtdmM1SS9uMkJmTi90aUxLMDRTR2RRQmJaTGtYN0RF?=
 =?utf-8?B?T2pyZnVYVGNxTG9ESEdPUjNxZ2hoR0JLc1RKTXJpcWMrK3FuZlhBejZnb0ha?=
 =?utf-8?B?Qk4ydi9UTmlWWnBWbk1YWG9RVTQrS2JsTU9MWVZBK3VhMmdJRHVRQnkveTR3?=
 =?utf-8?B?RmpxNUNXNWtTU3MyVUt6MTJiR0xPWGlkVytkMEt4UFo0UDAxTGkzRW1GMzRG?=
 =?utf-8?B?ODRNZmM1UWVJb3NsYVJaeWxmWDdKR0JqOUpqSzE4enhtYU1hNm9zYVFsaG1M?=
 =?utf-8?B?ZGRaY2hGbFRYeDBqRXpSUVE4Y01FMGU2WHlHVDJLV1dUYkJ6dFl5OVlFdXo2?=
 =?utf-8?B?TzA0dkZ0Zk42aU51MzhhdHcrQ0FwY2o4ZXBBTCtHeWRBR2p6OFpQYmpDa2s0?=
 =?utf-8?B?N2pmeTFKZFVISWYvQ3BHTmF1MXJRWE9mMlAySTdEZVdCYVhqbUhDNS9PQ0lw?=
 =?utf-8?B?RmRpUGZOUDNCeVpTNStUb0liT0pFVWtJdE5SWW5zeTkyZUhVWmU4ckd3amwx?=
 =?utf-8?B?MjBSVEhsWDlZdngrVTlBNTd0VTdzQ2VRa1plSnk3WTJUc1BtTkk5OE8wUTV4?=
 =?utf-8?B?cFRGMkF3TUNxYXYyNjF2TEVsUmFVcWtmQUpMalVCNFBnV01aQTRpTGxxRlE3?=
 =?utf-8?B?T3ZHYSs5Vy9MQzFWRkgyUFRVSnZyWjc0Rkp4enJzUU16N2lPSXl1Z2ptVUJy?=
 =?utf-8?B?YkJuRDdGN3U3Yk5LSzRXaGIxWTd0VW9seHlkTDR6dWpGaFc5OHM2RHZEZFFB?=
 =?utf-8?B?VTRrY3RlNktNcVFKUXd4OUJsMloyRi91azB1RXJZYUVEZTFTZStDNFd3aHFS?=
 =?utf-8?B?TjJ0Z0ZVOGtJNmdzSlM5aEJxaGc3SXF1TWFvaXZwZ3A1RVpJbDVFTnJQUG5H?=
 =?utf-8?B?T2xWVW01MXhQN2FPMGpwZnlmZDhDbmt5ajVZYUNIR0V4S0xiUHhFWlEyQk50?=
 =?utf-8?B?cU1rTEZIMVIySTRKQmVUMktKUXlrSDNWakNNZzlzK2hXVWdnbVc0MzRwS1dB?=
 =?utf-8?B?T2xWYTUrdnA5cHJjVE0yTWZVMWtHeW96WHlUZFhGODltd3JnbVNObThjY2I5?=
 =?utf-8?B?d08xU0w0Uzl1WXFlR0JrSnJLZDFHN1RKd2htcUlKOG1scGozVnIwa0l6Z1Nm?=
 =?utf-8?B?S0JLcWpMWU5DQTAwYXRXSHRtSEhJSjl2Ym51UUI0eWV2MEUvOEp0U0JTTFpM?=
 =?utf-8?B?dE5hdVZMVFRuMnJ2NXV0MmF4TW1tV09BTy9DME9SN1Z3ZkZ0cjk2dVBIVVd0?=
 =?utf-8?B?SkM0OHk0UDY3TU5lSUF5bUNjMGdFQjN6RmNEZG5IRGt3dWtkYXQrc2Fna1dk?=
 =?utf-8?B?bnY1bmYreExobzVXQUdlR0FocmI0cXhYWGl2N3NkbVdza1dmMWhxR0M5SXB3?=
 =?utf-8?B?SEtwb2F3R3Y4QlVkNzZqazVKZThMdUllQ0tUdTJqdEYreElISU1aa2RMVUhz?=
 =?utf-8?B?ckZHRHlpOUp6UUtUeWM2YlAzUHdVQzJBMnNQc1NTMGhKSXlZaklXSHhNY1pI?=
 =?utf-8?B?U3RENFI2QytHSGFKeEd0enlOUWU0K2FxMWJ4M0VyZHEySXFHNHB6TE43YUZH?=
 =?utf-8?B?SFlzZ2hPR2hqL3FlTVFoRGZxeDMzUzljSHBLUFFmaGQ3M09TNGZsQTZCcUtu?=
 =?utf-8?B?b3BBYzVYYUJIbEs2QXEvQXRaZVhlZ2Vxc2NoWlFISzQzS1lYK1g2eHJ0c1ND?=
 =?utf-8?B?WU9TY05uemRJeXNxZUh1OW9iamdmQWlYWmVsOXh1cFc4dzBpYTNYSnpJUHNh?=
 =?utf-8?B?SDF3TkpjZzU5UzZ6WFVRbzJNU1hqRkdXcHU1b1lEYllzQys4V000SjBPUUJE?=
 =?utf-8?B?cVdwSVh3b1QvQVJUc3JyZ0d5QjgvVlJNdi9sMDVESUZrdDBvVlFwWWR1YThX?=
 =?utf-8?B?clE9PQ==?=
Content-ID: <B293AEAC472F4E49B85318E82AEAB704@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8ab966-97a4-45ca-e88b-08dc1e784930
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 14:08:35.2584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EtBvhgMa7OV2a+LI2/o4GOrHZW+OxCXkq+1mIDiqs6RwGyogrPd3Cy1JxBNqkzKOCSDUw+uwnLzWOkTlBzVnTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_060841_148335_04DC8E81 
X-CRM114-Status: GOOD (  20.27  )
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
> If the helper is defined, it is called instead of halt() to stop the CPU
> at the end of stop_this_cpu() and on crash CPU shutdown.
> 
> ACPI MADT will use it to hand over the CPU to BIOS in order to be able
> to wake it up again after kexec.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Kai Huang <kai.huang@intel.com>

> ---
>  arch/x86/include/asm/smp.h | 1 +
>  arch/x86/kernel/process.c  | 7 +++++++
>  arch/x86/kernel/reboot.c   | 6 ++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 4fab2ed454f3..390d53fd34f9 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -38,6 +38,7 @@ struct smp_ops {
>  	int (*cpu_disable)(void);
>  	void (*cpu_die)(unsigned int cpu);
>  	void (*play_dead)(void);
> +	void (*stop_this_cpu)(void);
>  
>  	void (*send_call_func_ipi)(const struct cpumask *mask);
>  	void (*send_call_func_single_ipi)(int cpu);
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index ab49ade31b0d..00c1b957476d 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -835,6 +835,13 @@ void __noreturn stop_this_cpu(void *dummy)
>  	 */
>  	cpumask_clear_cpu(cpu, &cpus_stop_mask);
>  
> +#ifdef CONFIG_SMP
> +	if (smp_ops.stop_this_cpu) {
> +		smp_ops.stop_this_cpu();
> +		unreachable();
> +	}
> +#endif
> +
>  	for (;;) {
>  		/*
>  		 * Use native_halt() so that memory contents don't change
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 0574d4ad6b41..0a75efe579c0 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -880,6 +880,12 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
>  	cpu_emergency_disable_virtualization();
>  
>  	atomic_dec(&waiting_for_crash_ipi);
> +
> +	if (smp_ops.stop_this_cpu) {
> +		smp_ops.stop_this_cpu();
> +		unreachable();
> +	}
> +
>  	/* Assume hlt works */
>  	halt();
>  	for (;;)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
