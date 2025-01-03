Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC35FE77188
	for <kexec@archiver.kernel.org>; Fri,  3 Jan 2025 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EQCu7SbnoniLFssV6yMjvoZ34KaPRXkJzOTBzRq3EkM=; b=VdZ8iMtnsuTbIEQLdI3rrKyFVD
	LXb+gvtC29tc8I5XwKvDN3+UtFFdZJGoJzKILMxjYumCswH4uFL4okiYnP6pt0NsnGkW5trBWMJf1
	5/l8fIRvO8dxS/JwC8/cTvGhWLM/XLfadBNtF3WrCKi57k2trbZ78cLpFsVUPBHQXz6qap8j3Hj2C
	qsDnSaoge+nUpTvvqleGDDJc1HQL66s7LdMMKltSJ9u8zYQc6Rbi3VQTSNo7W5blutWPdIr4YeqPX
	NkYdJJy4YWOBCU7Jj5O8y6PMlqjSTvpRT+/6A6zaCIwXy7wjwJF7JY0V1rZh8no3BVmw2ShdKCt1r
	U8rM5iqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTcIC-0000000CNI8-2ITc;
	Fri, 03 Jan 2025 07:40:24 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTcEb-0000000CMZO-0uqg
	for kexec@lists.infradead.org;
	Fri, 03 Jan 2025 07:36:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735889801; x=1767425801;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g3zvfL7SM18qPBJF+LUW0DyMXlOj91qyaDGD+yNCNq0=;
  b=jFTIY6L+FP3UOIkvKmpx1m5xu3P14JKP/pR6WBFMzYJ83aapvMV+mSNB
   WNEUzgVKvfMK9IlZOJEGsNbUEozIVTNgCa1DSrkQr+Uz4ElNGUqOhOmCt
   HDjjGfSHUkHNDj7UHyir4cWl5c2md2rJYc4De1nCT575uu1kir8qqhS0D
   F67YHafHK9ome7/7XSD/f3vMA0tfHo4CwO2iaUpJnJ3OnmCXHqbOfNdQB
   P1Nn7sbNnG4UCl8MsZfJJARA3jK6vliUl/ofsPllDItAMw5i2sBMc6wZ2
   oI9+pDIc2Uh7FkO2nlBaJNxzJc9eC623iTS5tg1IjLusUUCF8aUEGXgdW
   w==;
X-CSE-ConnectionGUID: gW15GeLxRk2OOyCRhpA+yg==
X-CSE-MsgGUID: q25lyU17QhCrIvWjCKYKWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="38962901"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="38962901"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 23:36:40 -0800
X-CSE-ConnectionGUID: 2iLMaDcFRlinGHpfOuhxug==
X-CSE-MsgGUID: dj58z/vSTgOciwimmrGWKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="101915698"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2025 23:36:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 2 Jan 2025 23:36:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 2 Jan 2025 23:36:39 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 2 Jan 2025 23:36:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUDLG5uiOBvJnCzlI5Rg6iwDC1kLTjwn2ndQwSPWezM62c1QiWckG9JyQ3lICrRcu20synvlRQIVLAJ3c7GBncEr+kBr7Kx2FqsEV4GY+eqM13viDd4PmIT8aB4gFWeZ53/VYgTgeDY+W3aO6qD7/Ohe5mD3GsJjeI8fqSzKiaWpD0c6Y5BvAsDr26gdtK7Q5b9nLpdPzVXwCwWRIZekG3Z1Srgjs1skiFLUFnaTblRkMBZ8Zv5fR5EHH5SnuAb7sSVK4KRVuOiSqVTo+eYR4jH8R2/zdAT6J7ZXfeh/OYMf4Wsl+fATczNA4nhB1yz0lMzK1BI64Y3yF06kF10nOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQCu7SbnoniLFssV6yMjvoZ34KaPRXkJzOTBzRq3EkM=;
 b=QLUbO5uM2w+Kw8SEVyzJP/V5g4xWk2O6ThfiDgciefJXMp0dArQtOLblSpT1UDYAcGD9uXz14ZFVzWoS7qGluUajrnBe2/RFvC0ZDKJTtsXfpvH7P6Bx2pa/bP2KC03FNdBNvnXTFAMe7GxmMrAjdoEuZjtUP5lrz3nITnsJO6JcfVmuixs5IgFFheX7uXMHzzMNyNPgQi298b1fcptDGBfjz+KaDWOyuWw+A3WDvBcVXalSmqYpf1EkX89ubnuypdV0mYaJx8eRTjyONEcvG2Xo7jfCnyA4pUtINFe2QA9+cejYkqONTH8Cz2BMMWgKzruRtbTTxUqKAJW4rBdJEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11)
 by DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 07:35:48 +0000
Received: from PH7PR11MB8478.namprd11.prod.outlook.com
 ([fe80::6961:eda0:dc93:5b4d]) by PH7PR11MB8478.namprd11.prod.outlook.com
 ([fe80::6961:eda0:dc93:5b4d%5]) with mapi id 15.20.8293.020; Fri, 3 Jan 2025
 07:35:48 +0000
Message-ID: <22683f35-fa16-4f68-be57-831f632d5d27@intel.com>
Date: Fri, 3 Jan 2025 16:12:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash: Export PAGE_UNACCEPTED_MAPCOUNT_VALUE to
 vmcoreinfo
To: Dave Young <dyoung@redhat.com>
CC: <bhe@redhat.com>, <vgoyal@redhat.com>, <kirill.shutemov@linux.intel.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<zhiquan1.li@intel.com>
References: <20250103074941.3651765-1-zhiquan1.li@intel.com>
 <CALu+AoSNhhjxcKp2S0ERkOyezyrxcf87qxKh8isVgwehqOgbfA@mail.gmail.com>
From: Zhiquan Li <zhiquan1.li@intel.com>
Content-Language: en-US
In-Reply-To: <CALu+AoSNhhjxcKp2S0ERkOyezyrxcf87qxKh8isVgwehqOgbfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::19)
 To PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB8478:EE_|DM4PR11MB5326:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e040e0-e431-492f-3ded-08dd2bc93d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckEvTUR3bExNTVBDZHMra1RDTWxSZHlkTDRDbG0wc0QvbkozM1NQckVOOXpD?=
 =?utf-8?B?b0JVVWxsMjU3M0dsMG4rNTdydFE1ajNYbW5iMmNlaHhsNG9tRm5KcFFGWEJa?=
 =?utf-8?B?aVRsSzQyR0ZhaSt2UmZqTVFpbVBBWEJJbVJhWTRKQjA0Q1B2WTd6TklRYUpD?=
 =?utf-8?B?MXJ4a2g4U1BrWVBDTFJxWWNacU9WSUNqSUhncFc4VVVJZktBbitPOWQyQlE4?=
 =?utf-8?B?SndFVm0vdks4MytvY21Dc3Nvcjh1TkRxbVFhNFZQQ1Y3RDBLbmpoOWlxcEU1?=
 =?utf-8?B?UHAwVU5ZcUtGWE0vbWYweTN5ZGIrOG9PU2R5dzM1MXJGQmxCK0RSRDFpZDlq?=
 =?utf-8?B?aGFEZUNSQk9oR1kxOVJmS1hmY2FpV0RKTU95THBPbzZBUStnTkRzWEo3SlZn?=
 =?utf-8?B?TWNGOHA1cE45OWw1TFZMT1RkeDRaNjRhVmZhUWQzZTIvdTRRa0k4elpwVTdl?=
 =?utf-8?B?OWNDNDJ1bUVjeW1kRlgvc0N1ek94VmxWSXVqVWI1UkkwQ200YTVIZHpRSWJ1?=
 =?utf-8?B?L2NCcEtNUnpvOWJKT3Q5S3RtYkpCc0ZvZ011eE05cmluQklNMTJVYWUwamVG?=
 =?utf-8?B?UmVNSDhXUDV2ZEtxbVd4M1ErREsramhHZHhmMUZ2dndGY3VOekRFMEdmL0Nm?=
 =?utf-8?B?eEs2SExjS08rRjdqZDFpWGt5TVRkelBFVVpWZVBsRkRTcis3aTJzWDBNZTRh?=
 =?utf-8?B?a2t3dTFkTGlhekw0L3F1T3luQnRlMEZrSkd1NEFiN09rMGRrMEdVUXFVUkhD?=
 =?utf-8?B?aGpoUEhpeXhHR1BmY05haThWK2ZZS2FpZmVQelZRd0FuUW1IYzUyTU1LWDBI?=
 =?utf-8?B?MnFrUXhxQzVvcTF4aHZWbjl1bnM0NlE4RUh6ZGk4alFTSGx3aXNjNEp3a2Yx?=
 =?utf-8?B?VGQwa0N3dlhwZXpLMFFVeUJQRmxWVDh2KzhwSGI5c1pIOVI5VmJ2dTU0K0NY?=
 =?utf-8?B?M1E0SWZNQkxPc29ZVXNpY1pKWVBnTWNKK0FTUHNMS3hyd01MTVgvNnAraHBR?=
 =?utf-8?B?Z0l5US83Q1pIUzhHS3YvOERGSmdsd0wyT005Y0VxOGl6QjB6eGdSRnJFdkNI?=
 =?utf-8?B?d2xUL0ZhNndWYml2SzFadFdWUXRlNkc4K1lVOXUrQ1UvbU52OVRxWXp5MmhX?=
 =?utf-8?B?SGVyRHlBcHNodlhjRHhNRFE1bWR4L0g3eE5DY09UeGZBWkVFa0Q1WlpIN1pO?=
 =?utf-8?B?ZGs3Z0ZpcFFmSkorYUdYMmo1TU5heWF1SDlxZlJLV09kQ2M1Qk45ZTZva1pU?=
 =?utf-8?B?MHV0QnNSNi9VREkyelJnVnJORTJUZ0pkUXdlcWRtd2VuVmNmd3hiei9Dc0Mw?=
 =?utf-8?B?OHBvZnJJd0ZYTEphdVZhRGpxU1Y5ZnA4ekxrenJqN3BvdFRZd1kvZThaRlVB?=
 =?utf-8?B?dnBUVXFwVXgzLy8wZ05iazFPbk1iYmdRTXB2Rk96V1M1S0lRajRpWXhDblNR?=
 =?utf-8?B?dWZLWStIVSt4U3UvTFJFQzZyKzd3NHp6VDlLYkpZNjlDb2ZvN3gwVENWZmRD?=
 =?utf-8?B?d3lFUGYyYThyWk5GcURzSkZ4NWc1MTB2N05zMDllRWFyMmZ5MVpUaS9aVDZB?=
 =?utf-8?B?VEQ4R3FiM3VscllqZ1YvQlQ4VGZlSHMxbm1meTJXKzBXRTJhUmcyemVtQmQw?=
 =?utf-8?B?N2F1OWRETDJXc1RCOXMzdWRWZ3JMbmJLWG1SNDVRVzdkZmpkVjZUaFF2OE1T?=
 =?utf-8?B?WFdkQWN0dnlFZFg0b2FaU0t5WmdESktCeVBqZ1g3VHRKS3d6M2R2OHlmZUFv?=
 =?utf-8?B?U2tHYlRtcnpSNnQ1c2liZEQ0N0tVdVo0TEZQZzh2bTM5ZVNCY2oyUDJQZS9W?=
 =?utf-8?B?alpYUTVub1RGUGNVTHVRanUvZmFReUJOZmlKSzZZTmdCVWlYZUZidEZCNlNK?=
 =?utf-8?Q?+40uf+AUXYbeg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXdEaWQvY0w2VHhRWGNGUXJnVTBrcjNPbVhqSUd2bk1UeWxDR0U3SFZES08z?=
 =?utf-8?B?SytoekpoZE1uLy9xUHlSZVQzTWhoNW9ZMGtQTkdFOHVmUWJaZStBcElUY1JB?=
 =?utf-8?B?OUQ0M2RFdHp5WEhOMWErUG9SdmVjRkRsVmlLcG1GSkpmWTNWSE9WeFFERXdi?=
 =?utf-8?B?MVFXblBoRUVJaUg0QmxaTlB0K09OeHpYdyt2TkgyZ3ZaRzg0RHJ0bXl3M084?=
 =?utf-8?B?SlhiMVpVMGpFUVhTVkI2dnU4WUhmcGUvTGJUSXA4dEhEMG1UeExhZ1o3MWov?=
 =?utf-8?B?Uy9KMks4UGFnYkNxMVZXQTRzekEyeitYeU1nNHgxS29kdi8waCtiYW1ybGM4?=
 =?utf-8?B?S3htb1lreW13eUJLMEMyeC9Ba1A2cmtObDVzcXdHQ3FEckt1VW1tbVdxdlJt?=
 =?utf-8?B?Mk9tdm44c3dQWFcvM09PWGMwNWVGWnRCOEVTQlNGRndUUGRlUm50UGxoWXV6?=
 =?utf-8?B?WEdOS1hHamZ0eHIrbVJwQnVBcEtqSzVtTXk0eWdHU3g1ampWczNUOForcSsr?=
 =?utf-8?B?QW9neTBUanIwSXU0R0l5TVFBM1BJSWFtbk1vYmZwS2FHbVRXM1JsM1c3cmsx?=
 =?utf-8?B?RmhFcGRwUnp0ZEY2dlg3TnoxK2pqUUdLckhFaGdabTdBSVhodGJrQ2xtc2oz?=
 =?utf-8?B?ak1tVjZWWVpvQUc0Vm1HQXlwUkhnenJzQ0JFU2l3c0xjektKUSsyZ3Y2SzBC?=
 =?utf-8?B?NXBjTHlaQy80TGRMdEFyd2srNXZPQVdxZlhIdEpKeWN5YVZtMmZmTWpOVTZX?=
 =?utf-8?B?cEdWSzNISGtBNkhUMllYVWorWURGYmpTalFoS2daQlJOZnhhbURqTThyUXBU?=
 =?utf-8?B?aUx6bC8vT3lKWmx6TktObXJxdW13akZneWY1cDNDVkErQWE0QnRtNUs1ai9W?=
 =?utf-8?B?amVQcC9qY1NrcW56aWtsaGNGZVBXQ2pWVUpGRHlUMjBlQXZ2clc5cU9KVTEy?=
 =?utf-8?B?c21TTnpldU0xS3V4NlVoMVd1bC80VWl5akpLRERVcG1nejJwdVZjVDFhWGIx?=
 =?utf-8?B?aE1jbzAya1ZEZDUwVmx1bXV0bFhBSzErOHczdEtvNXJ0SFdlSkQvZ1hPWC9J?=
 =?utf-8?B?aHFDRkdyYWdYREFSMzcwREYwZ1VkRTFsZ1Vtb20vT3hKNWtOdXZEcmlqSFVF?=
 =?utf-8?B?bkJpUnAxWGtQN21FM01wSThHWXFiNExiaHBMRDlTWFFKbzgwbVBLNG9VN0RB?=
 =?utf-8?B?R3ZBd0dNblFraUxwTnQxOVhEMWx5Mm1iSnYxOXB6UHJoTnBGN0xTa1VKREw0?=
 =?utf-8?B?RTlBR2VjbmhYWHlURkRoQWx4NDBId3M2V2JOQno5THpBaWkvdjl1NmZVZk4w?=
 =?utf-8?B?aGZNVzZjWFdIbE00Z3FlR2JQZ25hK1RQb2oyQmlDbE8rVUZqcXRNSVRNa3FK?=
 =?utf-8?B?NnZZRHJ4UzMyRkNYanQzb0I4TURseitzaVlxZzRFUW9oeTNlQzhGNVQyeE9K?=
 =?utf-8?B?QmxibFVQVDZSZGZHTmJNR1RyMGI5ZFR0YXdsZ0g1ckdYdkdPY3B5NFZ5cTdw?=
 =?utf-8?B?ZmNmMU5qdVpHaVFDejJvSmZPNlloTTBLbHBIQTNPTnM5VmRiQm9Sa1gvTWwx?=
 =?utf-8?B?VUY3b3lzV0Z3VitzSXprY3BzY0JEeEdwbVJyNjE1ajJvRHB1OWZoTFdxOUZt?=
 =?utf-8?B?NzFsYUp6bGhjL2JPdHVMZ2JZd0ppcWVJb0RaUEQ4YUx6OUs1L2xEUXYwcWJr?=
 =?utf-8?B?S1hSMEVPNDdIdGZnaDF5ZTZzQUhBeGwrZkFEblozN2pBVTQyNjdKcDVWR3F0?=
 =?utf-8?B?K2hPekNZUWtYbVZtcTJFWTdYNkRnZCt2SXBMVGNsdjdKbXVOV09GYlpKQ1FX?=
 =?utf-8?B?b29iY3RxWE9Bdyt2TGE2ZWNlS01hRnc2ODZGQXZ1Z3oyMW5NQzhoQytQWGND?=
 =?utf-8?B?QkN1SEIyWngrMUl0eWRhR3BiSng4eDlneVBjYlYxVDUxUFI4YVhyeEYxNCtU?=
 =?utf-8?B?SWlqQ2NBOWhKRXhmeXVJSllLeC9vK2I0ZkJ4WWFRanVPZTE5V2MvN2FGVHZP?=
 =?utf-8?B?N1FlVDFySlFZcjZ6M0w5NG5ZOU5rTXRwRVBraEQ5RnYxYmxuM3l6V1JScjRF?=
 =?utf-8?B?amV5Slp5eWpHWGVjUnJlWlNHVmp1ZDZWM21RSDlUKzZSOHIzVGw1bEEwbWc3?=
 =?utf-8?B?L0dLVTA4T01lYzlObkFjUVdFTkdibmF3Z2dHSHFUT2NJbGVRbC9hVHRkbTg1?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e040e0-e431-492f-3ded-08dd2bc93d76
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 07:35:47.9565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhHRqs9DeUZPUNTrRJ2HG4xD4Q7R/UFIlO41RYlUj7WBLMs7Qm+PnqXPcU8IXjEkfXN9hJ3+7DyvIO4AHTz8lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5326
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_233641_277132_C8126D0A 
X-CRM114-Status: UNSURE (   6.06  )
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


On 2025/1/3 15:18, Dave Young wrote:
> Please add into admin-guide/kdump/vmcoreinfo.rst if you add more vmcoreinfo.
> 

No problem, the changes as below will be added in V2.
Thanks for the comments.


--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -331,7 +331,7 @@
PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|PG_hwpoision|PG_head_mask|P
 Page attributes. These flags are used to filter various unnecessary for
 dumping pages.

-PAGE_BUDDY_MAPCOUNT_VALUE(~PG_buddy)|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)
+PAGE_BUDDY_MAPCOUNT_VALUE(~PG_buddy)|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_unaccepted)
 -----------------------------------------------------------------------------

 More page attributes. These flags are used to filter various
unnecessary for

Best Regards,
Zhiquan

