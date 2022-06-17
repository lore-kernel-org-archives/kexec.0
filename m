Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5392C43334
	for <kexec@archiver.kernel.org>; Fri, 17 Jun 2022 21:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3aEC3cQmUFrUdhhqGa2hI3F3+sXdRZo+JJzVQopcBN4=; b=nlJzAEfXo6GQ8g
	IE+tIFMwYFY5t11zvFcv2CarSgV5N5giK2/Cr598nARu8j7YVaUJ12T7eEUQolLlqKdSvWIPq/yq6
	Cv/r3+QplvCLPepM/z+v+ONL2zo3ktWXQnSSxOupmsV6KcIaULiftI1Lmb3ueA405oWBfIXDPU9Mz
	SHDbt8iIHC2okLQiML9A5GC6JugXDv24cQsquF4LcSWdJWwi+QHMdaYQFK31iNbP26rj5i3X9jN9R
	amgBh5+9HKNurtII8BUgh9h8HCl+WxqiZkZl+hbOcDFeN/z1r6pOKYjaJA3G76GtnHNCtUj0pE2Gz
	BouJfKSByVBOuil3MIjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2JPx-009E0X-5x; Fri, 17 Jun 2022 21:22:13 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2JMo-009CXP-GS
	for kexec@lists.infradead.org; Fri, 17 Jun 2022 21:19:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655500738; x=1687036738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e7BqudSyAinua5MrcNoUP9jYm5BsNEssZ6GwS7P6a9M=;
  b=KLD/M2rx2BaW0XNP0UFugKromy85PYfT1V72K5bTxgczyqhr8TuqfVwL
   QWCfkIBym7FFXJ0LJo0dvhkrW3XgfKzS71dPrED+1EJwQGM0wyG3flSi+
   utosyXf6Ujfr6ecLUJDYBhwER9SpbXcNiLCHGiF4j8meaAJ0+i+CUmC/1
   qczKAeQHTvxXy1RvS8q9pGQEhkHZopd62a3fw87xzh/Xl0rNisZ1J0YGx
   oixRQxTHzdP0TPSwOS60thjChp0JUsVO4MRCnCBkGvzm5EWG6jyyzK+op
   bQ4Ooe0QKnQ/eyQcXJwIMMiiB91oViRUqoh4CwfxidbJsRfMBm1mW+bJo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="260018760"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="260018760"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 14:18:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="728498921"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jun 2022 14:18:55 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 14:18:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 14:18:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 14:18:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNhDKesqqhUud9Tb8jkSTGiwAmLvRVKGG6Ph3WRzb6g9s/PW3vEr3RALi1PfEBKmGh5e2QRRr+zXlRYs0Fg+A9k3G4xF9cjGylZ9i4XG6Ufa/dVHvOssysPADVXxr42gH13GgPs5k9NCFlIYOGVYxvP9ePPvxf6uOShNDrsrLDGE5rrFeeyySS4ZkM3zU2SFc/N4wa3UxgCtRLvjPHbHSq7pqOF0TZJwu5aoGYB9B6E6FJDmXyxPwyNmOTn0+F8psIZpTs1cYD900+MkMCPuxFvjE7mAarZb+EreAdghEdRpNy0FQZmTYS9oiyUG8MuBb8InOY0iskhnlzqbfachIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7BqudSyAinua5MrcNoUP9jYm5BsNEssZ6GwS7P6a9M=;
 b=A4xhjwpctBGgA15YdNyV9vrof6rh/Ze96CYtypvcBj/H9HxMtwNCjPR0BBo7slTMWbK9qfiKHF1117Q/Qb2qiN1hJCsMPmsETGiMLKX/Qy4xHNkIntXqfo2r+GEf3sxjRzOG+i8Dui+RXcPO73BzPB7o5hoc4dsOt0tGnbq+iOABoQrzmbK6cjZrm7oHnmvJ7uLyosc/ujwDMzZKhXyugioXSABcsTpAeJDODHVD3Cvwpm6ceATaIBCDiv2xElivkfn42hxlHulbyk44mARw0l5hINTRlvtdLr/xzr4KuLpfCToVO2+e9MlRwY83QOeDIaq5HzEr27Ry0Ji7mHAByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB3824.namprd11.prod.outlook.com (2603:10b6:208:f4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 21:18:47 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4%12]) with mapi id 15.20.5353.016; Fri, 17 Jun
 2022 21:18:47 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "ebiederm@xmission.com"
	<ebiederm@xmission.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"keescook@chromium.org" <keescook@chromium.org>, "Yu, Yu-cheng"
	<yu-cheng.yu@intel.com>, "x86@kernel.org" <x86@kernel.org>, "Christopherson,,
 Sean" <seanjc@google.com>, "Yang, Weijiang" <weijiang.yang@intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 03/19] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Thread-Topic: [PATCH 03/19] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Thread-Index: AQHYgV3BGYVuI+Dv/0Gr8tfHe/6Wwq1R07MAgAByKQCAATT+gIAAohIA
Date: Fri, 17 Jun 2022 21:18:47 +0000
Message-ID: <b1d4d26144e933382a92425164f78367ff92aea5.camel@intel.com>
References: <20220616084643.19564-1-weijiang.yang@intel.com>
	 <20220616084643.19564-4-weijiang.yang@intel.com>
	 <YqsEyoaxPFpZcolP@hirez.programming.kicks-ass.net>
	 <ca4e04f2dcc33849ebb9bf128f6ff632b5ffe747.camel@intel.com>
	 <YqxnwRn+/c+i1vL6@worktop.programming.kicks-ass.net>
In-Reply-To: <YqxnwRn+/c+i1vL6@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1f718d7-5d07-4242-52c8-08da50a6f7a6
x-ms-traffictypediagnostic: MN2PR11MB3824:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB3824460205096EEACF58CC3CC9AF9@MN2PR11MB3824.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aDJAOUmnR4sc8KStZ/0sxQqAKcmpb2aROygkHktfUuAA+8Sc6qqVdwPqxHeVD51vYXTYkRNEZYDft95+KfhVWCYDmOZBFd7Smv/RCxre00u8/aXVbYyuqXwcZSaPdTx8PUq7nLSpCw8khQr2ArlPwDfHMLB6x9XmBk4Q10PQkphMSNl1LJ/IrDkuBhAS5n6wnnxGsMu2YOOOjXKLWYMn8iDrAwKEX/VUPebgkquDOz3G0K7Dipu8lFbs1aI6qbrmoKGl5OUkU+V+bNNekDpaDhhZ4puajKbGY3hL8dGWcOyqf2aAXz1I7CldtPl1yxUhxU4pAdUuryrPTr3+0nWu6cyQ8I7tbUPKlJERyHmgFvVaSZUW09Xazc/z8nbIQJa+JbzhwnQygTOixR0LHvbHML0ulN6KAH3uQuhUdJWEhjXeqEP9hvk9/3MIlqubFmQW9gRQrGxcFG2F2ZLRqnLOBLREc5gQFDhNYWPTb2QLCt0j74do1mHLdemxjsSq3+Q2P+U+++j9/pvP0SjSxTQWpMVQNcdSXysNJyJzxOI1l7eMp7qVxo0eUVoeMVxqJYhQficWOpvfkUgTqy0gvWWSjjKa5z9XeY1GL/taDPM+EdqNukSKtuZtQPDEufeDW7EZ0EAwzwLqkAXVfr9aBnfaxSLfjnM8VNzNJv/prycVzrlFBMohJkuZfZUOHqslfZoa1ZI4G3gGrcKCfWDUGppAzSBxSov4Aj1qWQILVN6RjSk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(316002)(498600001)(54906003)(186003)(2616005)(38100700002)(6506007)(26005)(110136005)(66556008)(6512007)(76116006)(66446008)(6486002)(86362001)(122000001)(66946007)(66476007)(64756008)(8676002)(4326008)(38070700005)(82960400001)(71200400001)(2906002)(5660300002)(83380400001)(36756003)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alhSTGpKaVNuMmtIUXFNWGV0cS9MYmVWUmZxczJHek5RSU4vemNsR3FMTHF4?=
 =?utf-8?B?eHFFL3NWUmFza2t4ZU93Mm1rT2tyN1hLTE5kN2ZEaTFmdWpjWEJqeFQ1bXZ2?=
 =?utf-8?B?d3NKWVhMWC9oR2RkODlJTnEvbncvYmdZV0FxUVljVXE4QTlOT2czYjlZNU5i?=
 =?utf-8?B?RGQvRVViR1JVT3ZoZEg0M3lOaUhmSzdNa2pndzVvZXEveTZwcWxYL0ZoT09E?=
 =?utf-8?B?Z3BJWDFORjZ4by8xNUZ1Q0x3M21FL3hLR0Z0ejZsUXNTV3M4NmRLU0RtVWx4?=
 =?utf-8?B?MUJPcjRHWUd3a0prMTl2aXQ2UVJiWGtUUUNpdjFSRVI3U1U2Wk9tdDFQMG5U?=
 =?utf-8?B?dGtOaUJ4RksrdGhOcU05WXZLYzJ3UDZwQzVkZStHclVrZHZTWnljM1FOYkNW?=
 =?utf-8?B?aUo4YTdEL0NCL2FVSktrV0pPVXdxOGlkVGlXb0tnbytsZnM4ZDN6NG1MblZi?=
 =?utf-8?B?eC8zcHpKM2lqTEpHcFlkZExTUjZiWEhoRW5WNGtCbUJ6SGZydHZtb0RKS3k0?=
 =?utf-8?B?c3prMWNZRmVEa2JpV2pvUWxKTHgrWG5ZbVg2eDBpMmk4RlBGQjdnaENjVE5m?=
 =?utf-8?B?T3F2ckc0TjRNWjMyY0NJZ2h4aCtLbGVxdC9hdkZSaFBjdzBSOXovcmVuNHA4?=
 =?utf-8?B?Y0pxa3FHVEMvd1lOT3p3b2NKK3JDNVBvM3Y2RkNTa0NWWUMrRDdFY29EcXdJ?=
 =?utf-8?B?YU1qVE50UVBuVHhpckwrRG04NkFaNXVPTEM1aGpMTEZNeGVqbkJMSkk4VXIz?=
 =?utf-8?B?eDVEU1o5bjRtVG1NMFlLVzA2N2tZZ3p2b3czaXdrWjFUTkxwOVV4M1krd2pL?=
 =?utf-8?B?aWJ2MEhyaVFRQ1lvTHQ2T1BRbEMycTNzM2xiUmpJbUpMZUhYd0VGK29MS0Ny?=
 =?utf-8?B?WTU0ak9MQ3g4ejR5bEg0a0pYZW1ZNzdSOVorRmE3RUVRd3VOMFh1SG9jVm5y?=
 =?utf-8?B?YXQyVU1IdFhXVVhuZndscUVRMmFGc0xyQkhNWE9sdTNLeGRkdmVkWFU2N2k4?=
 =?utf-8?B?a0xxKzJ2RzRucWQ3Q0xBWngxblRmK2ZDb2ZxUjd2TUtHUlhYdjh0bjNydGdH?=
 =?utf-8?B?dzJ5MjBjM3J2THNDNm96Mkc5WWVsbmtKZFRsZXJZejVwRElJb1RtN0xBWmF6?=
 =?utf-8?B?NFpzREhxWTVKWDVJeFJYRVpLejcwV0x3NDBta1pKSWtpeXpSNlNOQnpzUWJM?=
 =?utf-8?B?Vld1K2Q5V25IamJ5VTJZZU92Zm9oYStmUjZCeUhjYXFMYTJ2V1d3ZEZya1ND?=
 =?utf-8?B?MURHS2d6SloyZFNUaG9WYzlmejFFeE5YUFc0OWhyZjFJYitrZWJOYkFXaytQ?=
 =?utf-8?B?VHRUcjliZndsWGJtY2pmZDZ6bWVNZTBoKzVtZkZDcDVmb0tRZm9UMWZtaGJC?=
 =?utf-8?B?dU5XeVZvMGxRNCtjQTZYaVNOUGY3eVN6VE5XR1NXNGlzUGtHdzdNNDBlaXNM?=
 =?utf-8?B?SW9zYzVoMlVkOEEzWnlNVVZrYTl4MmZacTNCOFBDWnp1S3J2c0x6c2hCTnlZ?=
 =?utf-8?B?QzgwT2xsWEJRdk9BTm1qZDlycFgyR0JvaXJEalFvTHlxcXRDWUFNQjAwaWJ1?=
 =?utf-8?B?U2tpT25sdzBUaVlra2NiR0NkWXozaE5icWxGaVFTZHV5VURSaWdoWHZ4d0FF?=
 =?utf-8?B?OTdveE9lbHNsVVAvc3I1eVRESGd3NjlhYzROTGcydFBwRU9PQStFZldsaGVu?=
 =?utf-8?B?TEpUaWticlFxYW9TclBXYjNMQzRPeVlTZ1FOQTFwNkFidnpNL0RiMVhiY04y?=
 =?utf-8?B?b0hvN05IMFRPNU8wUWF4QU1Vb3Fsd3ZQQVdJT3dGbklpdHA1RFdIZUZQNndK?=
 =?utf-8?B?WTM5OXcxK1BZR1dKenhEL3ZLUXB2UlR2aGRmcXZWQlNXV3hXUnloL1BIbGVu?=
 =?utf-8?B?T0JFZGZyQ2M5RVgrbnRTNTNzR1VNdXRXeVcxMVRjcndRT1hzSStEUXIyMXN5?=
 =?utf-8?B?TkJwbmlLK1lIaElXYUpxWTVsU2htelJSL2Fpd002Q2orWDMwVk9vcjI3NEM1?=
 =?utf-8?B?NGF5bzV0WlVORlROVHJ0VDdWS2ZBeGg4ek1TUGFyVDAyd05hVzdpOVZmci96?=
 =?utf-8?B?anROL0tLMUdxVFFQRGF0ZnhiV3lwcndUcU5kS2NWNzRrV2h2ZTUvVjdSazRI?=
 =?utf-8?B?Z1lvSVV2L2x6Z2hIN1p0K0cwVXpZSE0xbGlSZzJBYkZ1aXZCcWpIZ1FEeSti?=
 =?utf-8?B?T3FJQk1Tcmo0QU1NTkRzcjVwQWdwWlJBMkEvWmZLUUpWTVlKRWlST05wdDhS?=
 =?utf-8?B?R1htV1RaUHc1U0dBejVua1FFZjR4MHh1K0FnSGxMeExXaERJNkwxdEVNS1lu?=
 =?utf-8?B?ZlZvT0VZRVc4V0Y4c3ljZnRSaXJYTzlsYnF4bWpkT1RkdVZKV2ZkWVY0cXBF?=
 =?utf-8?Q?GePniCQLxGXbNF4hm5K4ZSHs2+UEG2YOPf1a0?=
Content-ID: <02FE8F5F91E5654F8D9F52B4CDC08E64@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f718d7-5d07-4242-52c8-08da50a6f7a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 21:18:47.5387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BGcSzHwhHKrTXQCO0jn12rA+LGWxypAI4jnUOapZ1xR5jp6l7D/AJFtqyBakmLgCqw+mV7TPEHPdu6qnHtRUizJPiGX4WHfuj811ltr/cJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3824
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_141858_718020_3457CBF7 
X-CRM114-Status: GOOD (  27.51  )
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

+kexec people

On Fri, 2022-06-17 at 13:38 +0200, Peter Zijlstra wrote:
> On Thu, Jun 16, 2022 at 05:12:47PM +0000, Edgecombe, Rick P wrote:
> > On Thu, 2022-06-16 at 12:24 +0200, Peter Zijlstra wrote:
> > > On Thu, Jun 16, 2022 at 04:46:27AM -0400, Yang Weijiang wrote:
> > > > --- a/arch/x86/include/asm/cpu.h
> > > > +++ b/arch/x86/include/asm/cpu.h
> > > > @@ -74,7 +74,7 @@ void init_ia32_feat_ctl(struct cpuinfo_x86
> > > > *c);
> > > >    static inline void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
> > > > {}
> > > >    #endif
> > > >    
> > > > -extern __noendbr void cet_disable(void);
> > > > +extern __noendbr void ibt_disable(void);
> > > >    
> > > >    struct ucode_cpu_info;
> > > >    
> > > > diff --git a/arch/x86/kernel/cpu/common.c
> > > > b/arch/x86/kernel/cpu/common.c
> > > > index c296cb1c0113..86102a8d451e 100644
> > > > --- a/arch/x86/kernel/cpu/common.c
> > > > +++ b/arch/x86/kernel/cpu/common.c
> > > > @@ -598,23 +598,23 @@ __noendbr void ibt_restore(u64 save)
> > > >    
> > > > -__noendbr void cet_disable(void)
> > > > +__noendbr void ibt_disable(void)
> > > >    {
> > > >         if (cpu_feature_enabled(X86_FEATURE_IBT))
> > > >                 wrmsrl(MSR_IA32_S_CET, 0);
> > > 
> > > Not sure about this rename; it really disables all of (S) CET.
> > > 
> > > Specifically, once we do S-SHSTK (after FRED) we might also very
> > > much
> > > need to kill that for kexec.
> > 
> > Sure, what about something like sup_cet_disable()?
> 
> Why bother? Arguably kexec should clear U_CET too.

Hmm, I think you're right. It doesn't look the fpu stuff actually would
reset unknown xfeatures to init. So kernels with Kernel IBT would set
CR4.CET and then MSR_IA32_U_CET might make it to the point where
userspace would run with CET enabled.

It seems like a general kexec problem for when the kernel enables new
xfeatures. I suppose having vector instruction type data stick around
is not going to show up the same way as having new enforcement rules
applied.

But also, looking at this, the existing clearing of MSR_IA32_S_CET is
not sufficient, since it only does it on the cpu doing the kexec. I
think something like the below might be needed. Since per the other
discussion we are going to need to start setting CR4.CET whenever the
HW supports it, for KVM's benefit. So those other CPUs might get
supervisor IBT enabled if we don't clear the msr from every CPU.

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9730c88530fc..eb57d7f4fa6a 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -96,6 +96,12 @@ static void kdump_nmi_callback(int cpu, struct
pt_regs *regs)
        cpu_emergency_stop_pt();
 
        disable_local_APIC();
+
+       /*
+        * Make sure to disable CET features before kexec so the new
kernel
+        * doesn't get surprised by the enforcement.
+        */
+       cet_disable();
 }
 
 void kdump_nmi_shootdown_cpus(void)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 738226472468..de65bac0ae02 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -787,6 +787,12 @@ void __noreturn stop_this_cpu(void *dummy)
         */
        if (cpuid_eax(0x8000001f) & BIT(0))
                native_wbinvd();
+
+       /*
+        * Make sure to disable CET features before kexec so the new
kernel
+        * doesn't get surprised by the enforcement.
+        */
+       cet_disable();
        for (;;) {
                /*
                 * Use native_halt() so that memory contents don't
change
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
