Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C2AC3DA6E
	for <kexec@archiver.kernel.org>; Sat,  6 Jan 2024 01:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yYrKhVEqNjTjAWsHE8SUHd9djk3HxSQz74SGEKMQFLc=; b=xQDe6iIZtKmRji
	3THwVKRH+K+054rkFh2I3/rISieRDU1HuIUOV7BmjbHPCLS/fl6VqJ8F26MPXSTWke7zCVR0mpmHD
	5CnEr9fJOpcrzALRYl0YGoxAVEr4qwAoCR/lzsjEq4Ho8yqRP0NRJ1CzPSAG1fMMsZpZMBbk+Q4HZ
	ZLgHa7MY8Hc0N/CQbmS+FNjiZIafL1HUMUzOnBAfra28TFr7fssTA4OjCGoqPA2hFhEjClkVuxqAj
	hRRK10FELagM0C5wVcFKsOnes6yeNuW+kWuaZBMmQjeLxjrv+rghf8egd3mjklgDCFLD8XrTcQtAN
	tiCoNUwhZE4AWV30vumg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLvIX-000WdE-2d;
	Sat, 06 Jan 2024 01:16:25 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLvIV-000WbK-1t
	for kexec@lists.infradead.org;
	Sat, 06 Jan 2024 01:16:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704503783; x=1736039783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=X4rtDPgXeD7x51kDyAeBfKhD5yNfrjjEyL6eMPnuf5o=;
  b=SLJbOPTcAbRBs2cuu7g2q6HhdLQHMQFfiUeD/2EMw9A6RmLFNMmmA5Jr
   sndaKwyIpd19YwTF7pVV3mBIJLYrwpwolOR1vqt1amxheSZhe5xiwyRCT
   AZgfnFrQjf9YVLKPZi3EqXzdpb4xiC2/6pNiyAjQ75xA1kjE0TpBM05Hh
   fTHOZI8KtsO0ZDInXovkPqcHH8D5jmriYriEv3Uc4Bx6L6+Bl9VpzeU5a
   oDN8Nh/EOuoznojfDexGGcxTJp7RjExD67bZXQ4OteQrJbdZQGjxsKPW4
   Yx6wwg7rFpDusjUT/Gs79Zu7KC1nn2Klq8saUgEu3JVwIduFSsd2Sd/Nn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="11108178"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="11108178"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 17:12:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="899801726"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="899801726"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 17:12:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 17:12:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 17:12:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 17:12:53 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 17:12:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGCjMEYCOez5MZIAALzmeZqQIq+PlW550ruTq53Ln2daLYrtC/NML9wzZx9/esPWCMbi6UCq3GRb7kQXV8SuKWtFePls6CD3Md0iIgoiZFzLur1zsmLZnQPEpCkD4b2WZ8L/4TZRRUuaPfPlZYoZQ/uMRfhcYwW+K4fqoAuNQPUDGnouY4mftVCzBUdUNU+SYeZ6U0bMHHYhZZ2W5HcA4BV7L+6hM8WPO6BCtIxGbjki/HJtKIC8yq1oQqNxdnKOZ7d7rPbRbPwKwoiQsZ+/yvzE1ZXU+1XyFlH1qXnvK4Ytu9cfMmwlW4C5GfaTiql2WBr4USkjV1ZjIpMyt6CPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4rtDPgXeD7x51kDyAeBfKhD5yNfrjjEyL6eMPnuf5o=;
 b=dpM+sjZ8xk25RsXbInwcS8Q4ICd/E+TTiGW4K6KBp6paV52C0zczFcrKz2h9cz0b3xoOcFOsYllP9b7XOMNuVaOwFTK/qZkBWr5KptO+DryD8TVp+1QtlmuCKbzltovmAgl+RAehQHLo7CjkeA0Khr9uIRxwQTdjtVhCmEpEOm4g4iZONWmLUDS9WhDKoGsiZexdGWJWWwXVvty3tRVndZ7UMZoMcPq8djzsIujGUsh/knFGElLdRg4Zc0nYa08uTz9szxroZE2kS8Af4TU87hZBECKT1mPF/rueFeWs9euZbcuqgsNmkgP11RZk8Pc8am+UddHP/Zk+Yk32sRM4dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB6118.namprd11.prod.outlook.com (2603:10b6:8:b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Sat, 6 Jan
 2024 01:12:51 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7159.015; Sat, 6 Jan 2024
 01:12:51 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai"
	<kai.huang@intel.com>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bhe@redhat.com" <bhe@redhat.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCHv5 10/16] x86/tdx: Convert shared memory back to private on
 kexec
Thread-Topic: [PATCHv5 10/16] x86/tdx: Convert shared memory back to private
 on kexec
Thread-Index: AQHaNTHuuT5wUKCXiEmkO2ibmGVdkrDLszWAgABZeYCAAAPcAA==
Date: Sat, 6 Jan 2024 01:12:51 +0000
Message-ID: <3c607c0e6478efddaa92c8917430a1b9e3de2638.camel@intel.com>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
	 <20231222235209.32143-11-kirill.shutemov@linux.intel.com>
	 <063a42bfe538710931fca183a8d28c8a3d011608.camel@intel.com>
	 <20240106005901.jpdxd544ddih6nw7@box.shutemov.name>
In-Reply-To: <20240106005901.jpdxd544ddih6nw7@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB6118:EE_
x-ms-office365-filtering-correlation-id: 7e61378d-757d-4e4c-7732-08dc0e549a8b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZkClzDtbv665xarDkA5RPQloSN3qJYx8DYz4jdtXTDRpytzgVoPFMLoKgZ9IJ1e1ePgNyuMHlsdMzzLD3GXyMf4UB5AGcedvBVBCZzN9xhhKEdjoBt/OTE2icGbWKAJG+KMZDtp7QCUUcyHTx8CrVk8B6iR8qysS3bGe8iLL3oiTBjnJSRsp5294BxUfORZD2UmMEioP/hY/mg2pUItbPkW68quKzYZ2vGWdVNWtvoV+En1BDKeXS+2ekXa18gEx6N+SnwvtidUaWmacEGpLf+qOkuHYT8jRC2AeBCJvas9hYAo0lNBZnLh1pX2o1+OSI6rw6u0klpMwcObDPDqcc6O6AxeursJXcX2PICZ9v7uUHW+JKVQaOTLxxqwg9+Y4ppRp62lT5gYFdWYsjV2/LO8mlEKXPRKVEyHVMrJz2u4OhsEqmTQ7Gu0fhfmLeSOALtQNbb1qZ44YCW5/OGnudBK6HI6XturXOBBxGYxYvpF23/Hj6Bll4rLs84syri3UTjqRxatMlc4S9Te3T2GpU0bLxmd5Na0+O41VJy4iGlGfkuw4oP8VMU4DxdgO5l+7e9fHFOKSmDO2yM543nUt7Gn0I1iy5FdR+eGLFzLrsmBwYp0HZZ+xv+/o6fD/+qU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(71200400001)(26005)(478600001)(6506007)(6512007)(6486002)(38100700002)(36756003)(122000001)(86362001)(82960400001)(5660300002)(41300700001)(7416002)(54906003)(2616005)(66946007)(2906002)(8936002)(316002)(38070700009)(66446008)(66556008)(6916009)(91956017)(4326008)(66476007)(76116006)(83380400001)(4744005)(8676002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU5ubFNIMlVIL3kxaDg5ZWpSaHVCOENPRWRqclk1dmV5TGZYd3hXSjZvVWxp?=
 =?utf-8?B?cE0zTmJ3Nm9yc3BwcituYU9pb2QyZEhOcmRvMzIxSS9ybnNnZTVJZWRlbGRB?=
 =?utf-8?B?cU1iMWdHb2pScldEMDZ2YVlEdWVHbThib3FDTlZvNW1xU2RHeVEyVmZFT1pE?=
 =?utf-8?B?TGU5Z29lZE9QNjZLVnNiY0V4ekhoT2hPeXhLbmRpWHMwYnA0THlHbTlQdk9o?=
 =?utf-8?B?Z0RVMnoza0NGTUQvc2p4eGVaQVlaOEY1QktyYlBOR3h1TFFTUHFoanJIWVZt?=
 =?utf-8?B?QlJjVUV0WEhtMGcwa3N5THFGZ0JIMDM3eXVsZ2RqT0RMcFhOb0o1TXVUU1Bz?=
 =?utf-8?B?ZElHdUYxdDF0dFliVVpKOHlDSzE2WDN3SUsxSW1ha08vaDhoV2dMWW8yRG9E?=
 =?utf-8?B?SW9rTXAwM0dLVzhRaE05TU1OSVNFR3NJVWE1VkVyc295dS9xdGhhd2NkbGRj?=
 =?utf-8?B?Tkl6aFk5QjlHeTYwL1RHZ1gvZWcyZkhBdnZyRjRFQW4vQW5odkFaUE1rc2s4?=
 =?utf-8?B?S1lHdmpSL0JPRzBlZHh4UzQ0Y3ZXOFF3bGtmdjZIa1VrVDNRb25BdG1pYzVq?=
 =?utf-8?B?MlJHT0RMWjF5S3YzbDY3c2prbE5yUVo2QmR5VHRYN3R5NTZJUU5iS2Mza2tK?=
 =?utf-8?B?UWh5TkJxdWF2NTg3YlRKejkzQmRqWXp5YWxlSCtYL0J3dWY3c0RqMUFocG16?=
 =?utf-8?B?amR4SE9NS1c2cUV6QU5wQmhHdHdUTDFrOW4yRFB5L0ZlLzN4Z0c4NDQyYzhy?=
 =?utf-8?B?MW5OeU5DaGtZK1Y0M2tMTXUxMkcrRG9TRTRIOTRFNXdZSlV4ekdKTUl0Ulk2?=
 =?utf-8?B?YlFhN3E1N3lnc2gxRGRwS3E3am1nUG5LaHgrQ1NGT2kxVHdiTlRXUU1QblpG?=
 =?utf-8?B?azdpY1J5U052eTY0WTFqaUdHRVdWMVJxRTduZ1ViTUVBRDM5ZUZGMDdBZjM1?=
 =?utf-8?B?VkdCT0xIemdzdnhQdHZmVmVrKzluVUx4TEFsRGErMC80cVR1RG5jVlNDalhT?=
 =?utf-8?B?ckM1T1FMTGk5dnArZWtMWjl6QmluOFZsOGNqV3l3YjI2VjlxYzlwVGlYSjg1?=
 =?utf-8?B?QndhSzNhZGw5NTVySGQvRnZad2VvRVVuZldXemkwdE42WWpEWkVKN2RaQVFa?=
 =?utf-8?B?SVk4UWdXSW54cGo1bmFuM2lzSmFFRm92dzFPSDYvN0JGVE56VXB4K2tZTXY2?=
 =?utf-8?B?OGhXOFg5U0JBL0N1czNoeWJaSkZSYng1bTdpTnp5VXorTnMzZVlCR1c2TER1?=
 =?utf-8?B?d0x5RnVINFNzMnNDUUhyR3ljOGw3UFZNcktXaWw1Y2JZL1E0YWVxdmhaNDlL?=
 =?utf-8?B?bTNGRS80WENCVVZqQVkyVlRMQjFQYnRPWUpxbjNpRi91YjVMVzRvUVpCNTJF?=
 =?utf-8?B?cHByOCtEVytSclBnb0Z3TGhYbXRzSEdyN0lBQ2RSVVhnZWhKVS8yL0xFaUs1?=
 =?utf-8?B?cnI3WjhLTndteGpaM3htTGwwTHZTMHhNVVZUV2lNUHAyTTNjVDF6cXNKSHFp?=
 =?utf-8?B?MDk4U1gyV0d5N2NjTTA2VzljaUJBSDJwVzlva3ArZG5BWXdtNjJaeUw1Nkxt?=
 =?utf-8?B?VjNFSGRuQm5icEdiVnBZVFVWQ3NSSStQSEdRZjZhazJKdVZzd2lmSHJUdVM2?=
 =?utf-8?B?SXFuMnk5K1dWN0IvYk9kSyt5aXBtYmZUZ2xGcUR3aTJLV0R4RnErMUtVb3hJ?=
 =?utf-8?B?VHFPbXZyQWdCVklRdkJjZ1dpZi9iMEdSU2YyakYrZ25EZnlvWFR6ZTdkRWJ5?=
 =?utf-8?B?NkRPakcxSDRQZmEvaEd6SmJ3T09nK2hybjYwSXRxWUc2VHhrTzVJYVpXNmlC?=
 =?utf-8?B?NWMxQjFmOFgwaFhYdUUvRHdISkYzWlNEY3lSem9PbW9ZNGNZaUVhK0NJdzc3?=
 =?utf-8?B?VkNaajU5RFRBVnYrRFBpc3QwTjYzTDY2dzcrdEFBd01PQ1Z6eEM1REw4K1Vj?=
 =?utf-8?B?WVNMZFNMOHBhZk5zb1ROQU5jdVdJc2ovQUZzSEoxYnpZV2o5dk9Cc2ZEMENq?=
 =?utf-8?B?YjFWbGUvd2J6MXFoZ0ZCQ2kwNFNqV2pjZHluNDg1N3dQQ3FJNXc3MGNDLzEy?=
 =?utf-8?B?ODdiaVArekVIdTBoNXFHelVSQjhZblBTdVRtNjhQYy84TjJZL09RV3hVQU5S?=
 =?utf-8?B?TWIydkxPWEV6aXNBZUkvWXphOWxibm16MFNIdGFDNDhmNnBUN21taHd1ZTc0?=
 =?utf-8?B?SXc9PQ==?=
Content-ID: <FE208A8264D7CE42BE1E5E226E9130E1@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e61378d-757d-4e4c-7732-08dc0e549a8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2024 01:12:51.2043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IMcuZsWJxAKE3DVliarMsgjCLlsZHpyXOHXBmOoAch1oeHmVpWk2019NXpKnOUL45GuNx/ZmE/dG++xakGKx/aS8VZhxOfze5rNBQOL5r3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6118
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_171623_641157_7833021E 
X-CRM114-Status: UNSURE (   9.87  )
X-CRM114-Notice: Please train this message.
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

On Sat, 2024-01-06 at 03:59 +0300, kirill.shutemov@linux.intel.com
wrote:
> But why? There's no concurrency at this point. Interrupts are
> disabled and
> only one CPU is active. Nobody can touch the memory relevant for the
> PTE.

Oh, right, sorry. I had thought there could be other CPUs active at
that point.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
