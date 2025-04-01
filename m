Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72948C36014
	for <kexec@archiver.kernel.org>; Tue,  1 Apr 2025 10:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TVoShe+g13MIAf03pYybpJ3TVpnwqynEEWs/iCGSwuk=; b=fQiFM3Ptxm6wgllVZ0gp7Nx6I4
	y5eS7OXoIKPnUhXogztmT/pxT4GhYEVharEJKmFTkIfHKDVTdbQuAW4BI91WPuizG2bz5xJu5XY2b
	5QbTtTfg7XAWKcaqV4Hcm4Ul1WVmxQaRg+kX5ZxiCtqEfbMGRo76kJoNxwXAicerJAk1S4tGcBjVa
	Rys0i7GMEDZCv6DK+UybPvv2tYZ8Eqoji9EriIeRlr+EdKVO2IXYjqyp64K521F5dkQJuJYN/oed0
	MdhTGxM+uBi12kPCvXJbukhLvc/uKRZj+CcODNHC1IKK0j7uCKIaTplKBIq3tCgNI6vKSAB/oQ5m3
	BduJrxtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzYb3-00000002aiG-1L9g;
	Tue, 01 Apr 2025 10:11:53 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzYEt-00000002WcW-3k1H
	for kexec@lists.infradead.org;
	Tue, 01 Apr 2025 09:49:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743500940; x=1775036940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TVoShe+g13MIAf03pYybpJ3TVpnwqynEEWs/iCGSwuk=;
  b=BRVdsNLNW1pwrsFqrP4blc/c9+gpKjlTUfC6LEZ8d2+bupQW4Y8BMbYV
   ibzJEFhh7Sgvf5xwiHspF25Oq1RkB4KWuWNHL38udO57E/samRknt6p7a
   BBDMLyNrJFmyt2OG/QOdkN0Njs0gtDSv64SjLW/rWPToYFDR6waalhGeP
   T0GDC381tojBr4GaE+FQtYCz93PhECLSwcFfuk17afZa3AsF6ata6XuUd
   2ee5TlIyPxO/V0EeOBdPIsvC/rM2/Yybiwfnn1ii9sccNlDrWs0faG8B/
   vJ9hUoy+OzmPKvyYbarQCea5Xs01ZSEodjSH9gxcsNGi3nrri9szptG6y
   w==;
X-CSE-ConnectionGUID: bVVpWptzQcKeocJs7F3tSQ==
X-CSE-MsgGUID: lfb0TPArSXuH+3GWE/MKNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="48483106"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="48483106"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 02:48:56 -0700
X-CSE-ConnectionGUID: xfaBblfeQoGFEW/eea+qig==
X-CSE-MsgGUID: wlXtu+XgQXG6DgdRIQyPUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126230510"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 02:48:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 1 Apr 2025 02:48:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 1 Apr 2025 02:48:55 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 1 Apr 2025 02:48:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjtgTZ49oKIAGV0f5Xs6nQfFIVm1CduwhALEMS0eCQcrkYneyGl+1cvvWEjzBNXa5nmnsMkjaKqI/1eIROT+NN3xyriVLw9xEo5qZEGChbRffLm0WZD05cM21r7Fj261AHOpTIbeZyT9ccVpTK4EmU9IcyTWUIPZk0x87JcPTZ5J2Xd7wJAbjReAXAs6qU1Lhi3yc7dQjhyK7SHz3lzkZuE5UqT8t2tQAZW3cYsaxHtbcArd8HeYj4D3wh18gWNib0JvyZ36xw7JNBpan5VPdY7USTxYe2E7VBW7DiUwzAjtPdHTRJn95DyRYMbtneYFv93/jd4h9Q2/HSJV73GhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVoShe+g13MIAf03pYybpJ3TVpnwqynEEWs/iCGSwuk=;
 b=yEPNSILc1ZTFRcRyYRxqlFAAACE2hMm1zdkpR+x8S5TTuHsilOmU2Bvhm3tFKLWpUUBO/VbhcdanWMaphV9ttTWY61garyqX2BAA8CSKGIseSCgsZjfdz+HGd+JcBSvr1aMuRZmJvnLoyq14zymJyF5NPe+PpmWMyVVGF/NRx/qwca1GbT0Q+aEMFS4Oxh7rWvnvpBGdJKqWSmijAR9m+DZhxfFKGDiamoSaaKXR66Hj1pvYoIOV5goP1hODWOiwkkbMVgkRSFXlvjPyD5Iw+udv2qtmZKex6JFntIfTcpk6gPGXpzR2/VHS+8cmXV4iLxeJgLmx7DappfJGF0xW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL1PR11MB6025.namprd11.prod.outlook.com (2603:10b6:208:390::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Tue, 1 Apr
 2025 09:48:39 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8534.045; Tue, 1 Apr 2025
 09:48:39 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>
CC: "dyoung@redhat.com" <dyoung@redhat.com>, "bsz@amazon.de" <bsz@amazon.de>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH v9 3/4] x86/kexec: Invalidate GDT/IDT from
 relocate_kernel() instead of earlier
Thread-Topic: [PATCH v9 3/4] x86/kexec: Invalidate GDT/IDT from
 relocate_kernel() instead of earlier
Thread-Index: AQHbnlrO2GaQR/jJWU2rsGeEYOGHqbOOmcQA
Date: Tue, 1 Apr 2025 09:48:39 +0000
Message-ID: <7e48a0ca808c9ec0520fe7769a4e44a86fbcedb6.camel@intel.com>
References: <20250326142404.256980-1-dwmw2@infradead.org>
	 <20250326142404.256980-4-dwmw2@infradead.org>
In-Reply-To: <20250326142404.256980-4-dwmw2@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL1PR11MB6025:EE_
x-ms-office365-filtering-correlation-id: c6e9dc1c-f09f-45f2-0cb7-08dd71026182
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SW94QmJLS1B6eUVlRmtYUlBzZEw5ZHhtRENzeVppOW02Y3R4ZWlISGsxY3dm?=
 =?utf-8?B?eU1mZ2w2ZGNlT0VBUUplK0FzWUpPOENacjBESlpWZVZvTm9iQ1VrUnZmZm1z?=
 =?utf-8?B?LzVQUi9YSjhSNWZyY2hMS2dSOHRBdUJtOTlCNUtTSDNXNW1YcUNNYlpRN1I5?=
 =?utf-8?B?Z3N5M3F1MHAvTmFGci9GYitkM2ZITGR2RzZTeE5xVElOTGRBU0hvZWh4NCs1?=
 =?utf-8?B?Tm5WVW1lNVhYaDNzOGh5ODl2SThYVW94ZWhnTlc3N0RqN2s0amFuWDNxREhJ?=
 =?utf-8?B?VVlPa09aWEtzclhSQUhoSkZqeWxOYjJMSnJ4cFhSeitmRWJOR09SNGYrT09S?=
 =?utf-8?B?TmFaa2k0U09BN295cTFmT0JHVnB5eXFOemRMQ0w1aWsyZmtqZlpyRlo1UDJu?=
 =?utf-8?B?Q3VucE5PS25yaXJuRXNDQXo2cDFnVm9zejQwVXR3TlQzUU83RkNrLzJINi9P?=
 =?utf-8?B?UzNZN2dmTW9HYnVPU1BDSjFpT2VJMmdtQ1pnNmtxdjFub2dzT2pjaVdTMWJl?=
 =?utf-8?B?Mkh3YUQzVHozNDg1bUpFNWl1S2phSGJHb2lyczlDb2FVOWtrZWFDL1dkYkVE?=
 =?utf-8?B?UXo2R2JGMmJSWm1VMW1CdHVaRzJpc3VEZXJLQ09VNWFiblNiQmF6c2JSVnYz?=
 =?utf-8?B?ME90WWJIdmN4Z2U1cGZqRFE1Q3crNlRmUFZzcnV6RHhYV29qRXROVXM0VFFL?=
 =?utf-8?B?QlYwSVdXcFdPWDZ2NCtmYU42SFkxVUpRY0N4YVovL1diSlJTVTRlc0RFdktE?=
 =?utf-8?B?TkFyRHpIdWlJbEJhUzdrOFpYaUtPQXF4em9YQ3JkMVo0cmtyUmxJMnh2S3JP?=
 =?utf-8?B?ZFdyR3Z2VXN5OHhQMEFqNXhsQzJ1eXBpTE9NTnMxc0NOT3dEeVY3Kyt4ZDRB?=
 =?utf-8?B?KzlvbHFOaStHRVVsWW5EL0xsSUVDTWhmdVRZb0U5QVN1dFI1dUFBaUlTblRU?=
 =?utf-8?B?aU5qeHlXdVQ4NGdKd3AxdXBkanc0OUNQVDBRVm9rUkdacG1JNmk5eTVCOTYx?=
 =?utf-8?B?anRoMHNCZW9mUVo2SWxodmcwTTMycnZ1YVlJYURYUEpydDhrYi9uSU1HbUpa?=
 =?utf-8?B?cWFKNlVrQWgrWjl2TTVITnAxT3ZQTDhmNHM4RVBHZ1h0NnV1UVMrWDJQdzNW?=
 =?utf-8?B?ZEpJWHI5TUxDWFNiTVpuVmxnYnp2Ty95dTBaSGV0UTJzcHhsaHpTdWtjZExM?=
 =?utf-8?B?SG9uRG5vMnRNRHI1OHQ3UHV4Mlg0dGkxMDVjUVhFNk5DdjhzR0hEejJJSVl5?=
 =?utf-8?B?Qy93dDVWa0licURXZmxoMFVPNTFwMk16Zm9WdnJmUWZPWUZvRFhWYTMycVlO?=
 =?utf-8?B?UGV0cDJxNWY5OCtWR24rdHkzanRRRkE5NDZFelJ0MWpQaVdLamZ1SlVIdkV0?=
 =?utf-8?B?dVdveUJ2VWtoanRwN0t4K0RhM3ExeSt1cEorZkpDa3dlb3JVSnIvV1ZOVEZv?=
 =?utf-8?B?dUdPeTFFb0pHSmxsV1l3d3VrWG5BQjBncGFPZFhxcDgrNjVWcGRFZDZSRkJy?=
 =?utf-8?B?Q3ZnUnlObXFaTjBSNkhXcUY4bmE4TG5ZYStFemxVY3pVb2ZqdEhnY2Q2M0d6?=
 =?utf-8?B?Ui9WOTZyRk5BdGJXSXRjdnMxY1pRaURvR3JWMm9acXhHNTZhWXcrUVgxQjg5?=
 =?utf-8?B?MGFNVjcrQTNtSEVlTlcxN245N0oxd1M0VDNsL1NOYWNOb0RoMU9UNS8rQjh4?=
 =?utf-8?B?RkhMb3hMK3JDYXpUZmhodWUvRHBqVVRWQ0gvOC8rR3UySit2RWNRaGU0bEls?=
 =?utf-8?B?NzR1K0Y4cVN1dUVVZGpJTVZnak1GbXgxOU1ocEZwSW9aemZ1ZE1xUERTSytI?=
 =?utf-8?B?WVRHVjQycW1UL2I2dzdLTjhmemY3bVZRaEozT3o4ekdrODg2SzQ1Zmhlc25j?=
 =?utf-8?B?bDcrbGN4S3FaZkVCcnJvdFVCbmtuNjZwZHhNK1d1QkVpTWtNUmZVVHMzN3Vi?=
 =?utf-8?Q?QTMO6e13Bw0uFbLwpH0Ij2ElzOu38T70?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2Fpak02VHk4MkljQk9Fc1pCSUVXUERuL3Q5QXpyc0xnaVJCZms4SiszQ3JP?=
 =?utf-8?B?QS9TajRYU1JCMTNKNm94dXJicHVnZllZTDNjcWVxS2dYbmZFU1BCYnMrVWRR?=
 =?utf-8?B?d1Y4a1JiZFJTY0NFUkFEM2lzVHNOM0dTd0w1M0xhQ2cxVjhCN2EzR1FaZ2xO?=
 =?utf-8?B?bnh2NnFtNWtNaldZUmtwUGE5MkNaMXgvUDgrU09HYkNMQ0huUWJja21oUWVZ?=
 =?utf-8?B?MWJtMTFxQVRuVzdTOVA4SkIvblllVXl1YUNFV3ZkUTNJN0lCd0hRL1pGWk5P?=
 =?utf-8?B?ODNtSUNlRXpKaHZsZTZ4RTM0TTRHdnZxT2I0UnJEVzFWQjZTOUhCR3UzWTlR?=
 =?utf-8?B?RXo3dXhJSi9XbGY3ekxuVitsZW01LzN2c3lVME5TQWZKSmpmeFVzQ1hhbGE1?=
 =?utf-8?B?cTZ5WHhPZzAxS3dhZ1JsQ1NrRkJIOStqYVpRZkJTZzloMFRRZWliY01RdHBC?=
 =?utf-8?B?K2gybysrTkVTMlZvTDRTamRwYzRmZG5RYVpaZ2FJVWJlZjc3VFpITkh2ekoy?=
 =?utf-8?B?L2hZYXdJY1c5RmZ3Q1pwT2lUQUpISGhzbmhLSlBNc1UvcERPcDdYdzdndHEw?=
 =?utf-8?B?WXVFOVE4RzFXTkxlZHkxZ0ZOZC9MbCtzSTlqOTIrWEV3K3p2aDZRajc5R2U4?=
 =?utf-8?B?SDltallEVFFFeElyU2dTRkpubGxjMTRoV0xweXQySE0reHBZUXRCS29pWFRq?=
 =?utf-8?B?QnZQRlg1M2FIZ0dZREdWdFRxaEEvK011ZGU3Z1lqcWs1SUZLKzR5MFB4OWxY?=
 =?utf-8?B?VjdQeis0L0VrOUVZNFFCYnkybjZLWTR2YXREekhrTmJwamwyRjltRUw1ZXhs?=
 =?utf-8?B?Z1VpaVZUVUJWZDZJWS9IaDJpQWdtM3Y3T2VMVEUvYkFwaHJuRTNRM1BTV0dW?=
 =?utf-8?B?ZjN4Z0h5bnQ4QXg3dFJ5Vk92dkpmaElBeEwzcXhxUHY5S0ZPK3VGaExpcUw4?=
 =?utf-8?B?WjYxK0srWFFXd3BHc3RHWXp3cTRwTlorMUE5dStqM2JmQk80NGJvbE9RL05B?=
 =?utf-8?B?bmFBSnlyTnhWd2xXSm5Hb3BRTitJMktvR2xJTDBSaGJlNmQ0MDFuckZQLzNG?=
 =?utf-8?B?cjZMc0J0VzJ2cHlqSThjTTkrc0FxenR3MmtOU3R0a3hURndYRjVaSjE2VzJO?=
 =?utf-8?B?TVFhTUlUN2xjNU9XY3VndEZMeE5JUjZFakJpWkF5RGw0RUVEY2VGR3FnVVlj?=
 =?utf-8?B?MFRqeVREVSt4OFZEMXJRdHRtZHl2bWdWRU9WdzNEWmVObHhMaU84TTRBZW9G?=
 =?utf-8?B?bUJZeEVjNzJBaFMyVGFDNlcwT3hPRzNZOHF5VEFJMEtmTWR5MG9mV2hCMTRh?=
 =?utf-8?B?ekQ3Y2l0Q0VIaThNbFhUcjYzRGZqTmEzSzhqUmVDKzFoTVNWd2FGTXZMclRG?=
 =?utf-8?B?MXFmd1ZCZTlLZzIrbzF2VjBNWlFCTjlwOXEzV2dabXJ6TlBmTitHc1lHOXhn?=
 =?utf-8?B?NnBIVmtLWDBOK3BvK296UGttaHkzMDlMQTFiVEZDWGxURlJ3dmVUZHBnZlhz?=
 =?utf-8?B?enZGRUNiWWtwdWhLQXBMcCt0YmpKU0JvMWlBa3VDRnBkMU8zQ2h1Wml1Rjdz?=
 =?utf-8?B?MnJaV0RyTEZSK0JMUy9MUjY3eTJaeEcwY2VQd2ZNTGpGSm1NRWp2ODZ1eHNP?=
 =?utf-8?B?bCsyUUVGU1YzN3JwdzNJR2R0NkhSSXViTjdjTENHeENCUnpSK0FXZjNRc3J3?=
 =?utf-8?B?WjNKcWZFTUowdXdzak1CNXpOajdyUWxDVTBaSDcyUmhTM1RMRE5VOGRseTJV?=
 =?utf-8?B?ZVc3bTcxWndCUTQzVTZ2cndjemJJcE5HdStIbEc4VFI3T1BiSjZmR2FLa3RO?=
 =?utf-8?B?TzcxSmsyQksrMUJZOSs1eU5HU2pqcVNPM2d2L0pPV3NlSzlzbS8vT1FvckZJ?=
 =?utf-8?B?dlNwS3VsbVN2VW0xMU1GamlkaHRVSmxSc0EzTjgwTUNBRUN5bzJvQmNyVHA2?=
 =?utf-8?B?V3lERUxxZzZQVHFQTExmZDF0RmZLNTQ3Y3JDOEVEQm56WWEwenZLSFFxdlhu?=
 =?utf-8?B?bUhaTlEvSUlKU0xNTEsrY283bEdGZ3ZVT2NsdklXaStWMWNZQWlxL25uMkJs?=
 =?utf-8?B?ZVBDRm4wZlNXRzMveTFlOTJOb0J1ZVhQSjhWajJPYmVmenczQStEM2tUUjN0?=
 =?utf-8?B?TkN1U05wN05oWVdKZTBGVEJqNnpXY01WS3dDQk8yVVU4NHZ0VnBURlc1a0Q1?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83B069581252754791F7787A743089B5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e9dc1c-f09f-45f2-0cb7-08dd71026182
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 09:48:39.5779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ggUa4o5FrSIwxVl3RzWoltLJJYar8rxXZ11792/5S5wBQ9CuvtNBvqgL+G7iTs+Qbo4dXhcSwPklxT95G23kNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6025
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_024859_969329_FB64DE9C 
X-CRM114-Status: UNSURE (   9.82  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gV2VkLCAyMDI1LTAzLTI2IGF0IDE0OjE2ICswMDAwLCBEYXZpZCBXb29kaG91c2Ugd3JvdGU6
DQo+IEZyb206IERhdmlkIFdvb2Rob3VzZSA8ZHdtd0BhbWF6b24uY28udWs+DQo+IA0KPiBSZWR1
Y2UgdGhlIHdpbmRvdyBkdXJpbmcgd2hpY2ggZXhjZXB0aW9ucyBhcmUgdW5oYW5kbGVkLCBieSBs
ZWF2aW5nIHRoZQ0KPiBHRFQvSURUIGluIHBsYWNlIGFsbCB0aGUgd2F5IGludG8gdGhlIHJlbG9j
YXRlX2tlcm5lbCgpIGZ1bmN0aW9uLCB1bnRpbA0KPiB0aGUgbW9tZW50IHRoYXQgJWNyMyBnZXRz
IHJlcGxhY2VkLg0KDQpTZWVtcyB0aGUgZGlmZmVyZW5jZSBpcyBvbmx5IGNvdXBsZSBvZiBpbnN0
cnVjdGlvbnMuICBBbnl3YXkgLi4uDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFdvb2Ro
b3VzZSA8ZHdtd0BhbWF6b24uY28udWs+DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5o
dWFuZ0BpbnRlbC5jb20+DQoNCg==

