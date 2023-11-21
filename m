Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB457C5AD4C
	for <kexec@archiver.kernel.org>; Tue, 21 Nov 2023 02:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e3hCR9iyCfg6sQfgEDAFsdqNo4G/ZKL8QkV2sqYfw2M=; b=PkNWCt6b5/Rd9I
	5OA9xrocN8F0k3nj4wvcyxF2tzyYWVX6KM5f7Oe6519naYC3FMHO564edLX0heQzjU7q025jPU5sJ
	NPplzTu0HbXOHAvP4QdOhL/9FfCB+yisNso6UUXhZDlUHjR68YV4dCC8VpD6a0c6Be2/A3kw+OTZb
	AWVjV5MVIr8R6nBDOHFrWg9ZrpBRgXQwjoQTibaS+kIc0XLhPE3yQOSNCV0EWea8iHmnAjLVcdN4k
	hLsMfGtVuS37sg3hf4aNpc6NlgnQnU27iRxnaGE/JBSMSMUp2RsVOyxEm+/DZpidAiPK59+9n3hil
	CjeJzrOWd99a9SjD70oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5GBV-00FOSc-18;
	Tue, 21 Nov 2023 02:08:17 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5GBR-00FORJ-0Y
	for kexec@lists.infradead.org;
	Tue, 21 Nov 2023 02:08:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700532493; x=1732068493;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=E3NfkS+K7A3L/1pWIOLgL7fdAq96sR95H71EF+jnj3Q=;
  b=TlHnVSRtQE6JNYNFFucn+7xC1RoQK96SPCWReJ/YgzFL1WWGgAsdM3r6
   YyiZOgFxYcZGPzYpQsRuUEMCj84yUQGy7m08X82ZXCMGIvlzsWJ5G53BR
   eDXcT5CuvDzMKI0hJNOMHOyVprul2mHJzT62/jZRk9jWjrRNC3pIRWBta
   35Dq+q1S1RamujTFtAHe4cm0vqz9IpDfZ8tYndxAbng/JfXldKS/xxmAq
   QdJRsrk3/0hTcLp/OuQh4Xe/OJSx33kqt/sFNLZe4gxmv8E+v9kZV2QFc
   8XMXVzpePZFfAhdG4o4Z6J9AkTxvflZHPFibflywka6FTDgtF0mnIWGyA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="13294321"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="13294321"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 18:08:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="1097903380"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="1097903380"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 18:08:08 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:08:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:08:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 18:08:07 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 18:08:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOidlB85GuSOwDUni3SkDQVEL0bKIuvdneZk4hYDAC+V4TcioYdm3PeuoX9SaF8w1RGEH6r1abHNK6aKcWYf/2q9VGcJ+Fp/23bNwUBvSE06FApG3wwgejc5ATYeCXjq9O3r4Ag1K+URepl16C6wt9L4A9TALBvYsjWmJJ/uQIF6NqEZAD4yeSpfrtR1g7G86q0Bw961lTjdgWYE2yDduVkQc2CBNi8MgPc0upqK8ANZktil+jnOvCEcqSTS3ECrEyj4XAzbUh1CQgIGLYASw229cg7txR/8iVu5lHYlatjxoNGpl1wuZdvNQxegDeC6638VFKkx39aklVptRbwg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3NfkS+K7A3L/1pWIOLgL7fdAq96sR95H71EF+jnj3Q=;
 b=Lt9rMd0Z/3Z0fzoQOAaSrWR0dQttECKN0UGVTfN8ULnesnygd70JDJTE+NjW/iD3Ye8h3G4vhQzVWUMOHZJJSRRmeoxbrq7iaCjJC7OPwVSyzYd9drxPgISJp9GHbR2BSi36QHe9gHwlODlpOFxwu8lkGWhN2IWnkMqc+uV1OYOgzv/DjzPkqqBtYXBOSohNJtNVpYYYLshTwvPxrBKKlrn4aorT16ar1UUPIAObeo4v3q3xGhLtshuAkkiOZLC+s1VoOtrwVKVbYuqgL3Lec1BwQrX1eqkCnct5paPkeMB36313boWgiXW0KETlAdvAh7P0/0b6TY7rHzlqr153KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB5016.namprd11.prod.outlook.com (2603:10b6:510:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 02:08:05 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 02:08:05 +0000
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
Subject: Re: [PATCHv3 01/14] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Thread-Topic: [PATCHv3 01/14] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Thread-Index: AQHaF7t2S8M+YAtB4EyYvs4vOfgvD7CED6SA
Date: Tue, 21 Nov 2023 02:08:05 +0000
Message-ID: <593f33e7888e92f1a24c6b21e3f53a6a13d991f1.camel@intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
	 <20231115120044.8034-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231115120044.8034-2-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB5016:EE_
x-ms-office365-filtering-correlation-id: cbe2e22e-761f-4be7-e604-08dbea36b316
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1qSibf7hhVp8Qm3z75NRdwfxJQnpH5hGfaEcqWmKX8N81kPc0pU6ra4KNfLtvlmPH4Yxc8WaNsjgNOht2E8ZMwr6Z6pgzuy504eRsDkZ6GPeGgmHT/D6jiP0vfuEzpZdHP6IGKDEg9CP9ybFof7u6nNMFR5PfOv8eSWcrfBsJ61GvqK6vYlTN6vnHA0Ixb0chqPZcjTULDGjdET43ujFUWcnlzwTMZfhboonh8gZo+1SZltc5ZTwWnhAMrEq26n2Jutejy9TD0f/bwwvtbi9ZCCK5q2hkmujGmmqO1bpVlj2Dn88Num/plU4mIqBRZgZo8fgIuvuMCqDAowtbd+CszfLzIuesiJyREvnTZg1h5uAMkI8fHItDo5sCxhxgpkJ4cLwOM+eEV3ZVT8M+WusXJISV2FuPo8xLj6hwWlyGjGjhH9lAFpr65iQpAuvrpdIYGRY9c3sLroAM+pXn60d5yuqQunTRg6ZxM352X15EV5DEu7lkcW9YmW+8mSDiS9/nmz59CGO1KJD6eUY5NGxHiSXsLvWOYk2hs1hI+nteGy0Hd04bsMAo6/pDiLH5aVBkrUwM4UjP2RZjlgmKCSv9pnyy3mC0ac4a5JcXQgAy8tptmJwwKWwIehTBVr2WP6h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(36756003)(86362001)(5660300002)(4744005)(7416002)(4001150100001)(2906002)(38070700009)(6512007)(26005)(82960400001)(2616005)(478600001)(71200400001)(83380400001)(122000001)(6486002)(6506007)(38100700002)(76116006)(91956017)(316002)(4326008)(110136005)(8676002)(8936002)(66556008)(66476007)(66446008)(64756008)(66946007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWlMV2NZTmZzUjFCR1RTb2pxSWs2aXVlQy9QUnZDRVdEWmxTUGVidzBMaW5j?=
 =?utf-8?B?NmdTUU9KR0ltd3EvZ3ArS3lyY0l2MUorcmtrOGZpNFljbmorYkxoeitVb2Jm?=
 =?utf-8?B?WTVyNU5CR1QvWDM0VkdvdzNmc3U0dlVQeUh0M0l1czIyWWk5MmROVXgrZ25J?=
 =?utf-8?B?UUNpditxNjRwaFhienpKRUxDUitULzh1QjBUYnpCOENmek5OYWtvU3pXdWQz?=
 =?utf-8?B?TktMYWVVMnJ3OGdycXZOTDFDdVlza2dMRzRSUmdtZ0FNMzZSQ1hNWEViYVBy?=
 =?utf-8?B?S0NoOVhFL2dvUGhWU0tOVE93Tkh4VHVGNTJManR5b1dJbnRiRFJta3dRY3dW?=
 =?utf-8?B?bGxwajl4Z0UwdXVnQ3ZreXBnYjFIYTVRMmJYbzJMejd6YnBYTmJIdUFLb1Fr?=
 =?utf-8?B?N3pRblpRK3hPZzZIZzRWS1MweE9jL2dUc3BndmRNQWpoQ2lsckRxK05PN29X?=
 =?utf-8?B?VGc2endvS2xwN3V0eVhKMHAvZlZBN3I4VzdhWXNNa08wMStuNmpOdm02cEdp?=
 =?utf-8?B?STk2cHVleE9TbWR0a0YrMFA5MnZIM3JnREcxL2FnRzU2Z3h0QjdnbUF1NGxw?=
 =?utf-8?B?Y0ZDNnRxQlVyWU54KzNzNVh1Tkp6U01KcVliNDlZVUZGQ0hWc2U2a3NFcCtZ?=
 =?utf-8?B?S1ltODNvUThMM2NKRCtINmRjKy9aUnYxUWl6Slp2Z1BXNmFMSTQ1UGdHVVl5?=
 =?utf-8?B?dXcyODdpb203bGlLTHBHRmZuNHRjQ2FZR0ROaUY1RnRFSTQ5WnYvRjJJQUIz?=
 =?utf-8?B?WVgzc2Y1aVpCVk9Dc2lxY251RTFmOTFIU0lya01GZVNWZDk3TFIrem1WTzlT?=
 =?utf-8?B?eFc5RnY0eGZxbzN3UzBJTVpkRXVmb1dObDJhUWF0NkUrZGZUYlVneWN2K2Zq?=
 =?utf-8?B?UHdib0JWVnBKSHRIT3VEcE1DTXBFdHZWVTFMaUphVTV2QTJPcVlaWGpQRU9v?=
 =?utf-8?B?aVM0QW9RSXpscjkvbjZhQ0RCZmh3dnBRN1hOSFlsUXdOYWY2clpLYzRBOXZV?=
 =?utf-8?B?K0hMR1JQTkl3bjg3RGljbnVoRkJZejlUT1pFWTNLRlhWSzZDSzB0ZERGVi9a?=
 =?utf-8?B?c0xyY2drWmtyaGowUHJuREJ6bTMyeWhOZUtubkZzTjBpdmYxSDVrZ09PSlZX?=
 =?utf-8?B?eklEK0pVUFQxTVpVaFlFNnlLaENGa1VuaitEWWVtR2R3UWlMS0FUWWcrcnNZ?=
 =?utf-8?B?cThZbW4xSHAyd3V5SjlLL2hWeWcxeG1nSkRuQ1Q3eVg3UzlUbDVKVDgzbGI0?=
 =?utf-8?B?YmF6dExKY291aHVkNmxQRlZwb0dBNWFwNGNBU2toUWNCTjZvZVhVSWd3QkdG?=
 =?utf-8?B?MitnTHNycFBQb01HZ2lhYjJGUFZyNFlwbkhBOE93ZjJFc2RISldxR1pjNnE3?=
 =?utf-8?B?Q0p6dGVXNmtVMjJ5VklNcWFveW5wNlNxME9UZVdNeXdJc3Z1QjlkV2laWTVS?=
 =?utf-8?B?ZGpqc1gwMGU4UG8zanFGRFB4UjQwTVp0UWgzdDB3TmNiSWFPcGdydFZvb3Y2?=
 =?utf-8?B?UG01dExDK0hZakJJb0ZQMU9kSENYajM4eEcxWkN1bWdRY2FyOWdpWmtqRTBy?=
 =?utf-8?B?TnpJS1dmaCtoeGsrSXJQZ01GRU80MkhNMVVFUmhPWkowM2tTL0NRQXNBNnND?=
 =?utf-8?B?Wi82am5Ed0U5cnBnM01GRDlqZ0dBdllhM1I0eDVEdmM5SURKaGZSdzEvbjVu?=
 =?utf-8?B?M3h3eHUxSk9YbmdNQmg4UThNNmMzOWV3VFJhUUF0UmNpTVYzSVdNSDJrWk1a?=
 =?utf-8?B?QmpiMC9CTDRlRzE4SStvNHNWMDNXeW9teUxGa1p2VndTaGlmU1E0dkM4aXlo?=
 =?utf-8?B?NWt1azZ1bG5USzQ3NlJicjM5U09NMVI1emxheERQaitZYlBPd3FwcEtEWGx1?=
 =?utf-8?B?cEpKZDMxaEhKWjhxYW1tNDJvMW0yNVZEUmF5NDZKTDhMWDlWZUIyd0VQOUhp?=
 =?utf-8?B?VEtiRlZXYUZLMTRqYWJMTE5xZW83T0p4VnJuZ1JnQWdBUjJzTlpEQ1h6WWY2?=
 =?utf-8?B?VnMwdkNSbWh3QmZyOUxqcm04T3VvcE02ekY5ZlVoYzZpTDB3Rm9pOXpFQURY?=
 =?utf-8?B?SzF6QW9EUEZmMnZ5aHRGeU5TZUxBTUlySUppYTh5M1pEOEZBQkhhQXptVTZo?=
 =?utf-8?B?MWFiRDJ0MllYVFJuZ3YrbXFSTFp3czNkQzd0ak4yZXg3RDFhSDJPRnhsdG95?=
 =?utf-8?B?M2c9PQ==?=
Content-ID: <8AFD9CCCFDF1724F8B2443974966CF85@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe2e22e-761f-4be7-e604-08dbea36b316
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 02:08:05.6810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ao7btIXxhN7w+BT5DM/BBjGido7pHU3VYl3LtlWPozxR+lBm8DwEgjNgzHHUg4ivyej98ljhgqJSmMNyluRY3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5016
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_180813_243711_5C947DF9 
X-CRM114-Status: UNSURE (   9.97  )
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

On Wed, 2023-11-15 at 15:00 +0300, Kirill A. Shutemov wrote:
> In order to prepare for the expansion of support for the ACPI MADT
> wakeup method, move the relevant code into a separate file.
> 
> Introduce a new configuration option to clearly indicate dependencies
> without the use of ifdefs.
> 
> There have been no functional changes.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Acked-by: Kai Huang <kai.huang@intel.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
