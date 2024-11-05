Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DBAD12671
	for <kexec@archiver.kernel.org>; Tue,  5 Nov 2024 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vBDTGTvVLQpCpeQkGCmkbSGLEUFaQLYGg9oKyOJWbtU=; b=oXbvRh/5bmOP6m
	ZydIl+tsDKraLfnlH5C5uk8X7WhI3/q2rU3eM3uLIzADHJlrDwh4eQpEbAw3P+kX0r0pKg3RW0GlW
	VF9APuHDrqC+CD8sqoEwp+aaS5/txbY/Y+NqZ6j04wIlmZiFQf8KQSqsP2rFRzomyVfc6DDlV6xm7
	O+Rp0QnuqBfaAP+PmNVGMmIZ6LBBufNNy0sW07p74sY/6yG5U5fqPjb6/MBZzi8yprfFgZYCWbj82
	lpyeI2HGweW4TCTRMXSbQOEywHz2mM41uh6iAc4UcbuJlUEjNJm6BLr4WP07xZ1WViGgcZT0J/yrC
	IGrvAdWcguNwXF4XgXVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8GRX-0000000Gcbn-1obW;
	Tue, 05 Nov 2024 10:05:47 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8GOV-0000000Gc6W-3sWI
	for kexec@lists.infradead.org;
	Tue, 05 Nov 2024 10:02:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730800960; x=1762336960;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c947SI80bvORi2784ETqBiOQHDcpRooZHCWK2bjbiVE=;
  b=h12fJBSCt0KSeoEU3qFOsqCULtn20mSqSIAI3N8aAiDPs0TRMX1950WF
   rJxWweSH+1e3JqjvpBNxiCCu2hi+/xGvjthE7dEC1IfQXUaoMirf+dzu0
   mV/jxEX8NB8XR0aqR+4VahrFRnEZIBUqunqFvam1eYnRl1gUK1glfBCOV
   rqU2mibANGoZV02O6fgmh4yqXgCqhxFrkWzr5ceGLR7uSP7rLLtdw92Zm
   XOZ/vNBAd4xRypNWy17H15/6jAsWCZtxfMevN8zfNTmI0NtbA2uD45oc9
   wdq3oDXJ5esoPhtQaF1AmH2Q/eXhjPiuJXXNnkRtm0qHlPiw/IuiYB1M0
   A==;
X-CSE-ConnectionGUID: RcEp4FCmS3eIcv5lg3ECww==
X-CSE-MsgGUID: iDJvy1vbTa+1K/CSJrE8LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="34466588"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="34466588"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 02:02:32 -0800
X-CSE-ConnectionGUID: TCrYx6WIRv2Q+2L7KOY3AA==
X-CSE-MsgGUID: yNsKvDrJTGCHh6pzmFtDww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="88521135"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2024 02:01:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 02:01:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 5 Nov 2024 02:01:49 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 02:01:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9e+mueICFUkzg1HkWOco+q5LL4kcO4xRyHQEd6pdospw2Rui2jcCfJUcxZ19xvXhYw7Zqh5J6QwG3ccmNHvmxswvCUu+S5PJaQy0ZHnOk7nniMWdwGmaaDxXDOBtKJFSbqxPkGY2opzstRPntQ3TNZW1NUFazOpr1sTW5mN+HzaTzP63bprYP2Kz7tfG56uodOB4xMKMOx7m5kfkFi21cre5gNGCOEh2XQZ23RdB7RR59ctY4UdC9FWwoYbAWCJXzIdIiEWjG3JR+vPZOybVFPhLv1xWrX9duB+O6LYqPgxTRqaNbqi04W/4c/DDyduhWCEjzqYIEp9Sqg+4uVT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c947SI80bvORi2784ETqBiOQHDcpRooZHCWK2bjbiVE=;
 b=aLD4SY02pyL6C0KvYDUwTpk7wLGxY/MApxapi0mhoe/LrAWpYl2gjwqQtwFvsokk+Oq7KW+nkzCx7elKGJ5AfBLAD5c9yZmqz26lKoBbm3zaaED0Ho5TPd79nHLapQZXBCde1UJqNO+9jgcM6CINZkY2v1Waz6BI6UyeyHIPbZR54b00H/Fn4TMTlYznO6Rz03HFuzyFa5NpNkHEvYhLj4NvhUG/ucMMnsJX5PTo9qdnQ5TxllIVP6z4MenqTdZAAbw7XL4a4AkiWnBgVFPbE5n35X4PkEIHdLIP5D3y7GXMmpK1+IA5/cIlbosnBKCUFLC32LKskfgyENWpGrwFxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB6121.namprd11.prod.outlook.com (2603:10b6:208:3ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Tue, 5 Nov
 2024 10:01:46 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 10:01:46 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>
CC: "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [RFC PATCH 2/7] x86/kexec: Use named labels in swap_pages in
 relocate_kernel_64.S
Thread-Topic: [RFC PATCH 2/7] x86/kexec: Use named labels in swap_pages in
 relocate_kernel_64.S
Thread-Index: AQHbLbL0FnWtRsI0DUijwCJOaBLjX7KoeAkA
Date: Tue, 5 Nov 2024 10:01:46 +0000
Message-ID: <0f32bae97ce6d0a179b78352c30048d0b83551a7.camel@intel.com>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
	 <20241103054019.3795299-3-dwmw2@infradead.org>
In-Reply-To: <20241103054019.3795299-3-dwmw2@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB6121:EE_
x-ms-office365-filtering-correlation-id: 1cfdb75c-0452-4726-3de0-08dcfd80dbda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RlJZeW5XZXQyNUJuYk1Nd0pDYi9sbnRyK043WGxGakxIN09BTmQwYjZVQXpE?=
 =?utf-8?B?dVVrQTlWZ2tqVDNSTmVneFNxdkY4UXo2aVc4SDZsQUtqY2VSQWV6REp2K0xN?=
 =?utf-8?B?RVQ5UnYwSTFocjYzcldlVlRaSkllRXhLeHUyekRwQmMwc21rejBXbjk2bHNC?=
 =?utf-8?B?aGFydmRJZzZwOWFwbnpIVlh1ZUlxOTF3K3E4VGk0YlBGK1RMNWV3WWlSUzJV?=
 =?utf-8?B?UkQ5bHlDTzZhZE5Cbk9pRmYwclFhR3Q5MzNvMC9oM3RmM04wcEJ3NUEzWVkz?=
 =?utf-8?B?ZkJ1SmRIcEVJWFFUMDRMbm1mUHoxRDRPYWZLRlFCRElVQ1RNVUFnYmZXcDRh?=
 =?utf-8?B?Z0tJRzJFTk56cEYzMG5FNk1WYXd4RURDR3Faa3Qwb1hsNWpxVWhEMHkwWjhl?=
 =?utf-8?B?VG04NkY3dm84LzYyUTUxRjZNZDlzL1RYaEZOY0hrZG5lQnhySnFwTjIzMU12?=
 =?utf-8?B?bnA3cGZHNnY4cjlZSlJocFB2VHBtTXpCaWsrR2V0ZFIvQ1Y4eW1SeWdDSk83?=
 =?utf-8?B?WHU3WHNWTmFQSG4rRk8zVUY3UzFyc0JXWlpGVkJxTklFdFJsOUtSZDN3ZHln?=
 =?utf-8?B?SVJDYWxibThqQjZLeVdZNGU2Wk9YeHVjdlUweTM3Y213SDRvQTFpanpVTFVl?=
 =?utf-8?B?WFpaNmxsNjd1VFFpaXJ2eklzUU02dWYzQVpxcDNpNmZQZFJFUm0wMU1ZWmJP?=
 =?utf-8?B?aWNoWGt0Z2FMNVRHWmdoTitOdWV2OGdVbVY1MGxyYUVJVE0xc3FVWFdTcVU1?=
 =?utf-8?B?d3MxSWluTnFyNFRGcUtJVVNLN3NjZjNkWklJSURGaGwvRXV0M3lkc2FXRjNV?=
 =?utf-8?B?TGxJc004ZTJtaE1QSUd0QWgyR1huUWQ1Q0Q0ZlVrRlpkRkNyeENVVFVpNzZN?=
 =?utf-8?B?Y2wzdEJ5QWhmck5XT04waUJYRlB6aVREWU5YRC91cDhzQmFhNSswNmxYK1dr?=
 =?utf-8?B?d1BkWUpWdWY3cW5Wa0wvdmlKWHVhOUhoeDlueHJyMW5UMnljM09lV0hVUVp6?=
 =?utf-8?B?ZkJrM01oY1hLaHRIZnpxdldkTE1TdFVuSU1kRGdXQ1hMY25iazkrQkk0bW5h?=
 =?utf-8?B?enUvaWw2R1d1R3BxTGNjR0hxdGJlZ3VMUndYc2tKQ003cFFWOVJGV1lPTzJ3?=
 =?utf-8?B?MGpra3RLZVEzVDJ3aWtCYmpoUEFYblgyWDl6bjExS3RqK04zZ0JDckJmVzVQ?=
 =?utf-8?B?aHBjOHNNeWhnSHBWV05DYWZkYStwY1g2SFViYTE0M1RYdFBNYkRzUjhIWUhB?=
 =?utf-8?B?MHBiMjdueHRDK2k0YU1wZ1IyV1RpUXQ5TUJtdTRHL2VOV3l5UWlVN0FmMEJy?=
 =?utf-8?B?dER3UUJjSmxuaEhGc1ArU1hkNzJNOWxpTkhnUzE0R1dEdEgrVUlnV0pyemY0?=
 =?utf-8?B?RWtscnZ1Wit2VG5CSW5QYnlrMHJmQWlYTVNGZUpIc0JIemh5WEdSb0VacDl1?=
 =?utf-8?B?dG4vWU54WitXSDcxY0Q4U01Zb3J3NUorbXo3dHVRS0NlRXFUREd1L0xsV0VX?=
 =?utf-8?B?cVh3UStyb2ZEZXpaWDVaZkRFYTNRNzV4VFZ6TWRtZ0puS3BhdlJWL2FwVDBV?=
 =?utf-8?B?OWJ3S2RpR0lhYld4N29DaFlVOWlqM1d5bkZ3TWZLV1pITTJSMFNaMkVKSVo4?=
 =?utf-8?B?SVhXV3hONmlkZ2ZCZndqOTBJaEMxbEt0TlRCVU5PM2Y5eThwVmF1SU42VnZ3?=
 =?utf-8?B?VjJ1dnZPdGNPdGJZb1VqeHkvM0EvaEhFakxTTmF5aXQ3T2VZSTNGTUNyMFA2?=
 =?utf-8?B?b0kxZzIycUxPeU1reTN4UndmREMvdnFMSXlWS2hPSjZQdDhRNmRwRFQ5VVZr?=
 =?utf-8?Q?a6zOhqm8W0i6EhmrLoLW5UghTukZcaYgFdA40=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czg5ZUVXMDA0MUM0dG8vb3c2cVZhYzdUUWJPSXV2WlNmMjFQQmtDRG96TFpx?=
 =?utf-8?B?QXY5ckZOWmZMWkk5ZE1tMFVRaTJ6eWNhL0J4WEFId1YzcEl5Smp6ekoxRGd0?=
 =?utf-8?B?dmdmY1pLNlF2ZEtJZEk5NDZhWlJlTElwYVUxS0ZibWdhZXNNcG0zZXBlWkl6?=
 =?utf-8?B?RXB0WVh4S2dSMmFvMGNXZzVjVlpRNk1qRUZ1YlJKQjFhVnNZbHJrNTJKUG1V?=
 =?utf-8?B?Qk83RHVqRXQwNUJqbk1jSXcxaEVyOC84WlNFTVYrZmhGK0E1T3dCb2x5SG5Z?=
 =?utf-8?B?UTl0aGZWWnlQWXQ3V0F4K1kxVEVJUDFpb2U0dXBIajJSZStteVQ0R1dEQjk4?=
 =?utf-8?B?b2hWdXdmWXYwLzFZMUlzRVFVZksrNHpvaXVNOC9QTDBiQmM4N0VWaEpFaXdn?=
 =?utf-8?B?UHY2ZmVteUpSa0hMKzk1Y2JHOVdqQzV1bnp2dC91LzE5aVFFcW1hRkt1TGw2?=
 =?utf-8?B?WWo1Rk82YWI2cTlac2RCQnBJOWdJOVpDbENnMFBmWlptUjBtajhmMzlhV3dS?=
 =?utf-8?B?RnFDWDY4cUFZWXJkRkVDdjRJQno1cEEyNnJCbG9EQ0YvdVU1MHd0OW1Tck16?=
 =?utf-8?B?SGhWWTIzeFFKMUo5SUxPSzgvT0l5NTRmT2JWMTJDL09vTmJZbzNPRjRUZjFY?=
 =?utf-8?B?cHhYZWN2TXFLVWNBL3hGRlZjeWgvamMrN05Hc3o1alQwTXh0TTE0RU1HNGQy?=
 =?utf-8?B?dU1GYnJsRGg2bHEwRFlZbE9zdkxvS3RwM1lBRUlEWis2MnlkTTZKRzNEQkRU?=
 =?utf-8?B?bDVqeDJZbUNibWZ5Y2pCOUVKNVBBeCtlb3hyT0ZNRVhDczlDcFhBTzA4ZVIx?=
 =?utf-8?B?Skg2dFk5cEhzdllzelJ1ckZtT0lRamNaQjJDb1M5NGNCcXVJeUdNVkh4ZVZ2?=
 =?utf-8?B?ajl2eE83MDdVK1l5QWU4cExVNVhsTmtrUGx4VFJvQVFwRENXd0lwdmxINGdF?=
 =?utf-8?B?ODhXcnAvVWhJaTg5OE1tclNGbmhaWkN0MXQ4L3lkL2lqeHVYeWVwZVZQc2Ey?=
 =?utf-8?B?QUF5U3N2M1JUeWkzejZaMDVxeHVqTllNaDRiUlBJRXRsbzIwYWY0TGtBc0NO?=
 =?utf-8?B?Qm5HTWloaWt0K3ZMMCtkWlV6QVVuakdZcjRMNm1Kejd0M2N6MFF1blU4NEdh?=
 =?utf-8?B?RUhBTUNWM0YzUGloQXlOcXlvcDBuWDdySFNBZGRpTFdYRlRFY2pjVHFZenpO?=
 =?utf-8?B?UVpRaXM5eDAzUWUrUGMzbkN6cktLNUM3bVBPaU1UUm5wUHpmV2RnSWNXbnNG?=
 =?utf-8?B?STZseTBoZ3JiOS9DOGh0OTlQeVBCU1Y0aUxNMUtwZXp4TEJIcStvclk1TzJ4?=
 =?utf-8?B?MmFJc1UxM3hXRGZZN1VUT2FhVGY1OUdBWlI0NEZkejV2S1J0SVBpYU1paUZ6?=
 =?utf-8?B?MjkzYWpsZ0d4NFlTTTRMRFhvSmYxV1ZOaXZsKzRJSHJZazVWRVYzRkJsYjZ1?=
 =?utf-8?B?NWFxYVdDc2tCQUNpdG5qd2tuZStucGJyaU5wdGM1SkNGb1E4NllTRjlvbzg0?=
 =?utf-8?B?TGRua2RubUhUYmIvVHFqREFWcHNybElObXRVL2VBOWUrUmxkZDhsUy9XNWdC?=
 =?utf-8?B?MXdoeGpVSzAxOFY1bVdqc1hLZTRQT3QzQ012bEd6RmVBamtUMXA4WTJPT0lZ?=
 =?utf-8?B?NlNHcDFtKzU5b1B3djdsWHlJOXlycUF2aHZqUk1VYVo4cG51L3Q5SGgyQUNs?=
 =?utf-8?B?S1EramhuUDZxK05sb2syRXV1WXJwdnJiOVV3YjIyT1JpOFVJS3VtWEs4L3hl?=
 =?utf-8?B?MXNPcHhlR3RoREhXZDlZdVlWbDJSWkREWEdZUkQ1TnhMRDlidXlqYnpZQ0wz?=
 =?utf-8?B?YklNengzVVdSelV0VENTMFJXYUcwWmk4NC9DNG1wYWhGRzlTdVlOeWhtYzNK?=
 =?utf-8?B?ajBpTlZOamgrOWtQdFU1TWhPYi9mREE3TkpraUFxYXQrd2c3ZmFBM3JXNGkr?=
 =?utf-8?B?T0MxWndTUGNTUXF5RWVOS0V1U2tyNEY0UUJmZ01OYnNGazhuNEZ6YUZINFZT?=
 =?utf-8?B?L2RndGtFaTFLVFZQU3V4ZEQwRVdvNm8zdXVtVGw2aWpDdnhMbThYd08wamMr?=
 =?utf-8?B?M1BvenNKOFpoRHkrclhyZThUaFJVS1JZLzMzSGhFMng2b1RQWEdNUGk4eFla?=
 =?utf-8?Q?GZorfDhfS873iHHN8Ilm6Fj71?=
Content-ID: <30FC13726DE19E42928B7AF687067B5D@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfdb75c-0452-4726-3de0-08dcfd80dbda
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 10:01:46.5538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8RJJArGp5PSGgSfsjxQvQcGfz0YfO5LE+3vKHJmdHI27kD9tybsnjpN8iOKi+n7oOk9XQCoZ7fQGM55gE53BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6121
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_020240_002043_00EC9DF0 
X-CRM114-Status: UNSURE (   9.41  )
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

On Sun, 2024-11-03 at 05:35 +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Make the code a little more readable.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Acked-by: Kai Huang <kai.huang@intel.com>
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
