Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854FBC25B78
	for <kexec@archiver.kernel.org>; Tue, 28 May 2024 11:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T9WRA0FfenUpJVx4Q78fcEl4PuY5zAbV2B78egBY5OM=; b=K3lYPk3TgSVaM7
	hKeO1yjvzijAQ1PwCNQzRQSGfYSe3O8HDd4d24Yb7Nd0ZHeNPHWJ1d6hI/SpLTCHF4cv2g/asvjQ5
	9mYe2PVGSCVjQnL4GlxGQheYR4amNZwuHR10Gi/skYI0xRcuDIPZX5uwNaP/lhxWBrX498p+1+fbT
	ZSXYuO5Awqw6V5hgvkymhH/D0Tj52xAbFqqCu4rqxnsBEIZ3biM4nLaxIyRUFCI/4eySjzn5/duoC
	UXBos3nPDvDqqR08A0DtC0j8zffIJ/QJ14DU/1wpAGmc5MEmvGikbYiNwzYKmLxFRGIvPZZhxqNQD
	pwlgn+AGvvsmllnpAdMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBul6-00000000K9i-2SjS;
	Tue, 28 May 2024 11:12:48 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBul2-00000000K5E-2e1F
	for kexec@lists.infradead.org;
	Tue, 28 May 2024 11:12:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716894765; x=1748430765;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=knkkC2uX3zp6PJzLSeotWlsZPnw4KywbqHeSe7eDdKY=;
  b=YXlzu+x2WHuCEXeA57DgCkk3lUmNL+GAG4UkHyqLAmvR94fZwvrQjJnV
   68vMT+GkUyfzmo86ibb5VY82klMzDwg33CZpVOvNQtSBqVl9d9yV67kjM
   evWhevwDykn0tFhUPnhS4gT/9zNiSQa+xBUpe8oYI9dC/RmBaMl7mjsar
   rJqU7kYXI1hZB/ar3tkRN0PoRlcg2TvWyRNjeDMGwoKZFsP3xuwQeMXT2
   zuk9yrQXw7LKMPlnrq4tfxtFBoYEY7Pg65FWVn4DDEq+PXC9LENg7/Cn/
   Fwu3nB82iAcYWknNmIPS83CJ/JM+bTTHnNx+YY7KJraM2+8oQ93sJM0ls
   w==;
X-CSE-ConnectionGUID: bSjI8jmdR46ok/thU1I7pQ==
X-CSE-MsgGUID: JLap9DFiSQmw3xmI5t1voA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13079544"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13079544"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 04:12:35 -0700
X-CSE-ConnectionGUID: NZuO/9MfRWKhRtHIqLsnzA==
X-CSE-MsgGUID: g0gIDN6uTuGyT1rEUGBuTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35653114"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 04:12:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 04:12:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 04:12:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 04:12:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUxEB+DoBxODEHFLpuFhCwiiCRcMHKX1FLNNybQPvrEtCXUyri3IA6vbIIfhViezmGFvLcnXNsvNuHecEeNJzJ4+qHdQ1+LKAKYi/tmd9ZADj09LUy7Aw5SjsUDb8fc/DvkTMMgRxYtB0y6zdL6R1VqfkcUnjifCkOh1gYeKs0Pw/pTzEwxbsg+FIdT72yFzVf5phIh+d+1aSQGoROL7GPRq1sG2TcLE/flKcMDrbdJtOr8rph40J4vAE4nGKNY1GP/zpH8J/tCCkHL9epYTZBLztIwWdUcNL39X/ZJQ2JAV1Z3gv5629MZ/tPFIbcWHCNERij0VcpQpoCH4gzlXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knkkC2uX3zp6PJzLSeotWlsZPnw4KywbqHeSe7eDdKY=;
 b=k0LwRwsDvE999aI60fejmdc3YRB77goVSQx+6MCb2o2uw4+mWSyKEDGGCQbrwibOojvhqMffF3tKsNeiALAJqmuHiYtgkwoHBfPYhtWHkyWNaR3VV75RRJXQ3FhU1WrDBx+nHrRLmpHgw2esXPlsYzov3OSvw6IY78hzm2VlDhJW2faVyY5wPzL64mIs3CSiIk/Sui0MAWMRxdJ9aNxKQFfLACG4JhpKvItvR0a7IHGKgaRhJquCXDf0d92zKvEbHCQ+j+/O9eFviE9//QL+4jKbPLujf7oWbZbca2rZElrSQaxCbx47T0aeZvX3+Z4RUax466pg8LtsB6xoZQevpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MN0PR11MB6111.namprd11.prod.outlook.com (2603:10b6:208:3cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 11:12:26 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 11:12:26 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "ardb@kernel.org"
	<ardb@kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "seanjc@google.com"
	<seanjc@google.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCHv11 06/19] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Thread-Topic: [PATCHv11 06/19] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Thread-Index: AQHasOU84tfcfZdkmEyRmpURY8DGibGsfgmA
Date: Tue, 28 May 2024 11:12:26 +0000
Message-ID: <8bb73d1a7b79d8c7bb8dd6673cf864c265ec6899.camel@intel.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
	 <20240528095522.509667-7-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240528095522.509667-7-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MN0PR11MB6111:EE_
x-ms-office365-filtering-correlation-id: 9bec7725-82fa-47c3-61f4-08dc7f070e97
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?R3RNL3h2UWJleXlWb1lvNVVqakRXQUdKOG81NUhBR09adzNFWWloZlkwZzJt?=
 =?utf-8?B?Y2dQOWVrdUxhS0UyV3R5R3p5OElBVHg5WE9Pc0NTWDUxZW9ndmNtcnlXWXJV?=
 =?utf-8?B?Q1R3RTFnUDAyNEhURDFmVHI5Uk5JY2ROUHF6RlcyZzV3K2tqSTByQ3hJVzV2?=
 =?utf-8?B?M2dzdm9XV1ZvVmN5cFhhQUpEcHpVK1Q4Y1FzVG1DSWl0RThXQ0xUTFJlTmtX?=
 =?utf-8?B?Vm5UZE1FaWhNcVVidzNISXFsTUNMYWRpbTBkbWVDY2lHbWFBSCtXalNwcERa?=
 =?utf-8?B?ckg0N05wekxDN1FCd01wRmNId2ovY0ZWWDdtSXY0Y2QzUTR6N2w3cFl5WmNM?=
 =?utf-8?B?Q3hzSytxbGRwZDVqRWpReGxyNXBBSkpVdkVlSVBwNEZrc0s2M01xQkNnTzhV?=
 =?utf-8?B?MDJSc1M3VCtDWWFWWDhObmQzR0cya3duQzRQWFoxRno4RXVNbTVhSVJDdDlS?=
 =?utf-8?B?MEVPOHdzdGoxL21zVndDRytlVnhqVkEySWtUYjF3cEQ2SEJWZVZqVWZ3U3A3?=
 =?utf-8?B?cWlOcGM0YmhNdlZEYXFFR1pyNldldXZDSThFdjhMV3hyMzNqSnowTHFsWkdI?=
 =?utf-8?B?MmVSdHFGRDBVeW1pTzFlTW4rZHBFY2hGZXd3RlNlQjBNNHZmcFBJQkd5WUFa?=
 =?utf-8?B?MUZqakxnclkxMWFEZy96RXVLdTBlSWUxelpLY3ZyQlkvKzMwZVN3TWoxeTh6?=
 =?utf-8?B?Y2RMdDJZNHIxOTh4aW1ESi8zZWNNYTMvL0dpSlVtSkdqcWRySUJITlBTQXM4?=
 =?utf-8?B?Q0RwY3BPb21Wb3VhWDdLQ3ptc3J3cEdMN1E4OFQvV2NudTNBT0N4b2dJMVJq?=
 =?utf-8?B?a0g4Vmp0VnYzNGlZQU9SVWI2cDZ1N1lLMitpckJxQnF6aTAxUW1XNU5BS3Bp?=
 =?utf-8?B?Ly9IT2pQWFF4cGhqbkdTNUpRVit5UW1xb2p4eVNkazlJU05ydktkbWtlVUxS?=
 =?utf-8?B?QUdzNlQ1RVhXdUtUclRyZ1Z2bFJRbnNJbmtCcGcvS3ZiTFFUc3F0a3FvUDBE?=
 =?utf-8?B?ckt3elZHbmdUMEZBOUFMSlN0N1NxbWRKRFdPclRqektWckhtL0FHVWVsdzZ1?=
 =?utf-8?B?SGVrZnFEQWdnbXM3cHNzYWlnWGpwOEJTczhzdWYwMjBSaVdlZ2ZIWjF1Q1pM?=
 =?utf-8?B?MzdGWFMyK0FxY1JadEpaUVcrby9PS0NTeW5qSWNCMzNDR0FleXBYWkRXUTRF?=
 =?utf-8?B?Wm9jRDB3MTJTWHZ3cVVYRXZhUWRzMnVRYTdBV3J6aldyUEVvNWptdUVSSzJP?=
 =?utf-8?B?MXdOdGx1OXZuOXp3WnVWZE1IcW93WGNyb0wrSVVaUkExdTY0eVdFM1E5WHZE?=
 =?utf-8?B?NnFBMkc5R2YwTTUzOS9hMGNFaHZOZ2dvZnJaYkxGMFpNVGJpSGdaNXEzL1Q4?=
 =?utf-8?B?M0RkbEVVUDV0VnViTkxIZUpJc1dCYUp4elpTVnFtUzg1YTNkc1k1b2lMQy9C?=
 =?utf-8?B?OWJlMkZmWmpFeXVma1JGc1NwVU5PYXlNNHBtOWo2eWYrMGpoUC9BY1JGMGlM?=
 =?utf-8?B?SUgyZWQwNzhveUJKMVViTkwzZVpGRzRnMEV0WTdQREhXOEQ5dUVVWVNYTHJG?=
 =?utf-8?B?ZnpBOVUvZHpqd3NjK3pSdzNoT1BVQ2pscjRqQlZtbWNNVW5ZZ0V1dmJFMkNF?=
 =?utf-8?B?Ujdic0loSDVyRlNWSVhzdkVNRlFZOTUwV0dXSjhhMnRwakRmSWhmZEdDNktN?=
 =?utf-8?B?dnVKK1dBSm52ZE1kVWFDRWNXa0c1NHhxQ2tOZlhnU0ZZcklxMFRveVJVR0Fp?=
 =?utf-8?B?MldlbUw1aWFWVWdzSzZlc2VMb01lTjhvRmhObTBQU3lRckxsTFNUYXdlMlRD?=
 =?utf-8?B?L0RCcVZHQ3NrVEVON3VZZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2lEMHNBYnhqUk5WNS9jOUQ0eVhZRlhjd0N4dlNBWTJmd2Q4UHVTMXkwSWZD?=
 =?utf-8?B?V01FWVNBRkF2TmJZTVlpZnNBUTZZT1I4dzNNQlJKczRhRGh1MStHUkp4MXhs?=
 =?utf-8?B?ZWhBcjdGcWlMRmErRDhmZGVFTjdjOHdWclBObnN2b3d1SFVEOGxFOXJwaVk4?=
 =?utf-8?B?ZXdRTUZsSEw2M1BuM2lFSWRzSy9pdVk3NDV1Y1E5MlJ4aTVNOG1RZzBYckdE?=
 =?utf-8?B?Q3VQZVlKRWUxS2pNM3ErQTl2STRYUW1BNit5L2RYMG9OQ1BUZHp6b1lvTlNK?=
 =?utf-8?B?OGgzbTg3YkduUzQvRkIrMzFMNnRMa3EwZXFyRzdTRFRJZm5pUWNOZmQwTW1i?=
 =?utf-8?B?ZExPY1hWUExWZ3hXL1lXV0dzUzVoM01BVGxpT3pXaEZFNW5xbUc3S3hoSHpS?=
 =?utf-8?B?a2lzeFF2NGpaYUU3SllWR2FtbkZDVFVwTDNjYkhyVnIxYUZkQTFBV0ZFSmZt?=
 =?utf-8?B?dXdPem42V21RenAwSXVmMFJ0cm80bVgrMjI5T3M0OEFUM0J3TXJOY3Q5MDJl?=
 =?utf-8?B?WFJrc0taYWthQmFZcUNscVM5dElIUUszbVlPQUMwMm0yajE3VDVZaVIxbS9l?=
 =?utf-8?B?L09wdnl0MlB4bWtKV3N1eHNrL0NNY0l0M2FpQVNCb25QZTNkN3JwK1FQcVlv?=
 =?utf-8?B?bG1MNVp2WUtocUlwWjdubEkwaVRTNEJYZmdYNk1zVmlMRE9QYU1NVm0zYUFq?=
 =?utf-8?B?MktkK2t0Q2haa2ZoWXNKenZoMDFEZE1uK1NRclhSQzJVUjg0Wklxd2llSnN2?=
 =?utf-8?B?WGlNbjRkMEYxdHk0RXpRdHB1L240WkkwUFh1am9UVjZvTDlPQ2gyelhZbmd6?=
 =?utf-8?B?RHVnRjJTZFpyeFZVSjllUkhJN0VUL1VLNnpwQ1hZU0t4WjV0aWlkMGI1WGxD?=
 =?utf-8?B?elI0UTJFWTM4dXo0WEZyRHVkQVkvNVlTRVIrNTFsZW5qVytBditleC9wbnZX?=
 =?utf-8?B?bHhqeGhsSE5PclBHbkNzSmhCcFZrZU9ibUZwbE1naURMQlFQRXhrUVNxZm5k?=
 =?utf-8?B?Sm5KSkZBQk1KZEl1dmhBUEk0a25JYmxwck02U2JVb2JIYmhGYVFjREo5TTZy?=
 =?utf-8?B?TEZ0SU5FWVRyUUEvZVF6R2NNUENWWU9QcGZhYzduUE9SMzNTN0FxUkFwaFRC?=
 =?utf-8?B?dEhNckh2SncvbUIyckRSS2JldCsvVDE2SnBweCtLRjhYOUwySkV3ZUdpM2x1?=
 =?utf-8?B?VDRiQmlvWThMRmpOWnNaeGpNRzNlQjNVNnNrYTNCZXppNGNLc2dzblVrQmFH?=
 =?utf-8?B?WThkcXdZSmhmK3hsZW0xcnFqZVZ4SUlSVWVwMFQwcWZjN0RkV0ovNkFaTVZL?=
 =?utf-8?B?Vlhpenl4SXY2Yis0NkpxN2dCN1k5N0c5ajFhZm9CbDVrQ2J3akNKajl0VlhJ?=
 =?utf-8?B?RXJVWDdJYXRoS1JiNUNRSEFiSk1leW9wQ3lQd2czNWtDUEdVSXRybXhqa1hk?=
 =?utf-8?B?KzlvNGkzRi91SDVSaGhSbWxEOWpzSzFreTBUa0ZwSy84bm84OVVKS0xmQUYx?=
 =?utf-8?B?TWRJQmlzbENnVCtEUW9mMWUrTUpHb09ZQVZYamRqSjN1VU1MdGxhMTRYRDVW?=
 =?utf-8?B?c3oxNHRZbTFlRGM5SlVLWjE2WkUrU2h2SWJlRGxsajcxV3plcGpQaVY3b0RK?=
 =?utf-8?B?TDFINUMrcUt4QU0xR0xCYmxXelVnVlVrWDZiNVY0VFZvZWp6T0NqYThqeUkx?=
 =?utf-8?B?S2NkaWQvK0grZHo2KzYyK2hSa0dlZEFSbDE4THpHcTNiQjN6YXVhQUtCdU41?=
 =?utf-8?B?aGErOWVHSW4waVNBdnJnM0VKZnhnS2d1Z1VHMDM5MkJjY0doU1hMNHp5RU80?=
 =?utf-8?B?cW1lbDJ0TTBXRWZLbGx1VmlOTGxBYUtHcjNlUGpDRm1kbUtVd1g0ZHkwR2tT?=
 =?utf-8?B?a1hmMCt5ejZ4YkpVa1NCS3pvUVovRklpbEhEWi9RN3pwTXZsYkxkeXBiU0kr?=
 =?utf-8?B?OEo5SVVTZlk0dmVkQ2owZENTTnlrQTh2a1pMOTRYU0pqRSs2QUJ6anBEd01F?=
 =?utf-8?B?QzFlbzRtU1AyM0ZtMThxMERzbmdjb3lkMktiM2I4Z0EwM0sxM2luaUVZU1Fw?=
 =?utf-8?B?RlpZaUR3QWc2REd2bWtWTFJqVmRYQXI4bVBmRDN5b0sxSll0YU9KakRBd3F2?=
 =?utf-8?Q?vOT1xDXOni4GITW3EudRsPxlJ?=
Content-ID: <2D35AAAF440CB84AAA7EBA4CB1209C44@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bec7725-82fa-47c3-61f4-08dc7f070e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 11:12:26.5765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HldMyMkhC3ITkB72My0R+oobw9A7eP3X6ReE5E8gzPcWRHsAP36I4w2XlTonI3GggfuUxyFTobBXyOan3x8dEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6111
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_041244_739998_E97F2EB2 
X-CRM114-Status: GOOD (  18.33  )
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

On Tue, 2024-05-28 at 12:55 +0300, Kirill A. Shutemov wrote:
> TDX guests run with MCA enabled (CR4.MCE=1b) from the very start. If
> that bit is cleared during CR4 register reprogramming during boot or
> kexec flows, a #VE exception will be raised which the guest kernel
> cannot handle it.

Nit: the ending "it" isn't needed.

> 
> Therefore, make sure the CR4.MCE setting is preserved over kexec too and
> avoid raising any #VEs.
> 
> The change doesn't affect non-TDX-guest environments.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Kai Huang <kai.huang@intel.com>

> ---
>  arch/x86/kernel/relocate_kernel_64.S | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 085eef5c3904..b668a6be4f6f 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -5,6 +5,8 @@
>   */
>  
>  #include <linux/linkage.h>
> +#include <linux/stringify.h>
> +#include <asm/alternative.h>
>  #include <asm/page_types.h>
>  #include <asm/kexec.h>
>  #include <asm/processor-flags.h>
> @@ -143,15 +145,17 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  
>  	/*
>  	 * Set cr4 to a known state:
> -	 *  - physical address extension enabled
>  	 *  - 5-level paging, if it was enabled before
> +	 *  - Machine check exception on TDX guest, if it was enabled before.
> +	 *    Clearing MCE might not be allowed in TDX guests, depending on setup.
> +	 *  - physical address extension enabled
>  	 */
> -	movl	$X86_CR4_PAE, %eax
> -	testq	$X86_CR4_LA57, %r13
> -	jz	.Lno_la57
> -	orl	$X86_CR4_LA57, %eax
> -.Lno_la57:
> +	movl	$X86_CR4_LA57, %eax
> +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
>  
> +	/* R13 contains the original CR4 value, read in relocate_kernel() */
> +	andl	%r13d, %eax
> +	orl	$X86_CR4_PAE, %eax
>  	movq	%rax, %cr4
>  
>  	jmp 1f

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
