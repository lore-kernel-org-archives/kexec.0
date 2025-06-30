Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF6EC83029
	for <kexec@archiver.kernel.org>; Mon, 30 Jun 2025 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bMK8DhwW/HEA9nzq1GPNY9dSNX6j56/boo40J3dVlhg=; b=Uer8/GNfH5DRhmWqz4jNFzvUNI
	nJYNKAcvqhcLWy5HcqKKJgcLJIx0ZOGa0WzkcPEMv9YYWv6ZLuQAiKrpWAjsCkWULUi9xCq2xAvgH
	HaUbqwwD1N+9z4gZ1lxY2lJg8kEAfCFCWX+4DWYqsQ//Jdpz8U0S8wfBzaalT5JKcoYU9pPY7jz8d
	qcx7s4TSQUF66KV4MS4CAp7/+f1Xdndka0UiixFe8wZQL6akgmvclZcpgZRdavPoibXfzRGt93u7E
	jts/ea2Bk47Ze0N/XpkMwwWwFdU8eUkP3tYMpGhuKBVZSuZ7h2xMVtPnBg+6S2Lw7VH3G5sCn5RS8
	JEO9SW8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWGCZ-00000002i5X-2TGt;
	Mon, 30 Jun 2025 15:13:47 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWFen-00000002bMg-2Yvx
	for kexec@lists.infradead.org;
	Mon, 30 Jun 2025 14:38:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751294334; x=1782830334;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=PxQ4pWUGZirNWcas3PTvGlAtKMj3Xi85oH7oWlbu0sY=;
  b=j7g4PayUkKjZQnRL/PnvJWa3yeqaeLyHflgYfBRbCXXqgHwdui7zNaQJ
   Z1Fk/jquA/3LnAlVMjdzv1PJD2KeZBiloJqZuwfE65aXXyFLEpifKcap+
   nzeVPBZJAQwi5e8+wX++dDWTEtihHRJ6S2bV7uZ3ZENctE57gXMDzlZ36
   Zxm3s1gnibCnbQx9LVZnCFSqHnXuTq7iJdYyluznIl46037w93yCgpgYB
   LVwlVZ7bV4EcSuSWB0FqMDnI0G2jhU5xkrCPGiXKyUXkOAAiW/k1zd8x6
   Gt0N+0nALAjX3BWzd9CNeo3/GHGOrosPB8wwgnMADY6DdS2cgt1NDPPJR
   A==;
X-CSE-ConnectionGUID: FkzE+RPIQxOX74H2nErZWQ==
X-CSE-MsgGUID: /SlBrcqyQY+kb0wimqQzyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53397355"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="53397355"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 07:38:52 -0700
X-CSE-ConnectionGUID: lLnEdXR5RhWqpSI2UrPTuw==
X-CSE-MsgGUID: lZ6KYklQRdK7tWyfhxtPVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="152866738"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 07:38:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 07:38:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 07:38:51 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.61)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 07:38:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yufhpwZ/3kCJvbSezwD4vo3ovBL7VysrvGnZPxdTgjnax+RLoeOyWipkcoHWEvNnbGvFuvYxSQdg3D2CDcDOt+9SlEQkIZJrS37v0ABHOd7XJyTyMW8SapTUK//h3zSSNcHYnr/hlZvS23pKJ67EzTZxU+bXbmCyYSW3sk2OK0EOfY719UDqiGwDLnSNm1nx7ZBpRywwh9WJRjzqaI8KcLh+TBX41vJg4h46rBLz26slhAL3hj/OYWvxt7PKKvPSGxo3yr2Qhoao1Iyf1bNvwIJ9PSWyRZzziJuXe+b46/x9+Lhal3fKS/SQPqCwQ8LAYtN9hWYpDrYvMMtOZ8Tg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMK8DhwW/HEA9nzq1GPNY9dSNX6j56/boo40J3dVlhg=;
 b=C69mcHEKWIxEdoFhatQ7t0P3YJ8K9ptC2HejuACEMZMhGwttVAdK52yc0av7H0JBCgUMBGWtaGxiWEwHDNwIhSwZmVDI78r8HAd1wyzqXv+CdE0JwGZv7RJDUTa8rCEZPb8xq6i6dz7QF8fNK7KGLfqDZRBpR5PAMV8aoMw+DNpmoAtykGDMms8jzwuHgzRoPGXZn0w1sHNuVxQdY/2fjG9COVmRBBCq/lEDFGtoeGyo+567eAqmfJKFwRqalGD3dImHxByXj4MRHIhKkrvM6HUCfT0SoAseah1X8Yr6YK+YiMoRodsRYZs6A4UFDuhbc2bFVizbudSwd2jeI2HZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11)
 by IA1PR11MB6444.namprd11.prod.outlook.com (2603:10b6:208:3a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Mon, 30 Jun
 2025 14:38:45 +0000
Received: from PH7PR11MB8478.namprd11.prod.outlook.com
 ([fe80::6961:eda0:dc93:5b4d]) by PH7PR11MB8478.namprd11.prod.outlook.com
 ([fe80::6961:eda0:dc93:5b4d%5]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 14:38:45 +0000
Message-ID: <d718b201-d033-4952-987c-a16d78fa0c4b@intel.com>
Date: Mon, 30 Jun 2025 23:21:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH makedumpfile] Add confidential VM unaccepted free pages
 support on Linux 6.16 and later
To: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>,
	=?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
References: <20250609050244.837619-1-zhiquan1.li@intel.com>
 <b2387999-66c5-4f9f-9052-d85208fc5694@intel.com>
 <214fcd88-4c5d-4656-8e0f-83e40310eb3d@nec.com>
From: Zhiquan Li <zhiquan1.li@intel.com>
Content-Language: en-US
In-Reply-To: <214fcd88-4c5d-4656-8e0f-83e40310eb3d@nec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To PH7PR11MB8478.namprd11.prod.outlook.com
 (2603:10b6:510:308::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB8478:EE_|IA1PR11MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c52b37-58f9-4360-5a7a-08ddb7e3d182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXFHOVpoRExvTW5udHZaTVNpU2xuK0tCdHhDTEl2OEhyNCs5eUprVG9BTmtQ?=
 =?utf-8?B?WFU5YTE3Vm83aEhKYUs3Ym13d0psNk1sRHJILzNFUjNzSjhtNlY0a3dpRkNq?=
 =?utf-8?B?Y2NsNlZvdnU1K1o0cUhxMzcvT0NDV0l1VkI5OVlEcW4zQURIRU1jNzJDeE1l?=
 =?utf-8?B?RTBEY3BZQVNRT2VTdkd6ZWQ0MmFDejNOSzhyWkVRNUMza0ZrK2lock50RGU3?=
 =?utf-8?B?ckpOV09TcU1TNFB6WGQ2bFFrYy9NM2hvUkZ6QW1tMTB1RFdOR0c4SDBYUWZz?=
 =?utf-8?B?WFpNd0s2ZDZvaVhtN2M4V1EwcnhIQ3lFR2ova2FhZmRIUU1MOWtyVEFsSzQv?=
 =?utf-8?B?OUV4bmM5U00xTFRad0s4L2V4eFRLRHVML2VSeTRVTllXblNoa2tMOVJ5OUpJ?=
 =?utf-8?B?bXlRV3JwUnRrd09MTGIxNXpDSzc1UFRZRHcwbnZaNlYveVNhWkpSUXN3eEZB?=
 =?utf-8?B?a21idk1aSC9XU3pXd3hSczB6QWRUQlNIelhXV216WE0zUXVLdm1WdVZSSFB0?=
 =?utf-8?B?SElxT1lyK0RTTlVSMkVSdnJHOU1kVmFyQkpFTG1ZWDREZkF5SW1mQi92SlV2?=
 =?utf-8?B?aTgxQzlvK0xDWFdpR1dZUThXeVZlTktEY29SbzBpS0hVZnkyTVppY0owbG1h?=
 =?utf-8?B?V1krQW0wdjI3RERuMHV2K0hJb090b0VxQ1JvVTk4bmxNeklUOWswbFo5Q0hZ?=
 =?utf-8?B?cWJtVlhibzJJQktVR2tqaCtnbTVCcjdQN3Fqdkt3bHhRcFFwS1NyK1JIMVMw?=
 =?utf-8?B?SmtLdms1aDYyanZ3M2xtemZhZ0FveXBHOXhvQzVOMHJpWlNYN1g5eENUdXV1?=
 =?utf-8?B?M1JWNy9rSE9oTDUvQTEyZEJsQU81aDFmQm5jUndzam1KbkV3TFVBdXp3N3Fq?=
 =?utf-8?B?bFlWNHF1bG1JdUtLU1U4cmJpaE1KaSsxd0picjhOZlRneXVnMzcwcjlPUjJY?=
 =?utf-8?B?TTBhcWFyV3M2T0FZWGdIVFNlZGJicDdHaE1EcjM0bkdmWlR0V1laMW5PMThO?=
 =?utf-8?B?Q1pRVWZpeGc4WHZlWTRkLzRFdUFYSkIwcUxNOEI3U1lhMko1Z1BMNXNaUW1O?=
 =?utf-8?B?VmhEcmVnb3pHSlZBNkRtZnNSTXQ2L3YxNXI0RUNLY0lCRTB5eGRteW8rNTBH?=
 =?utf-8?B?SVdocWhrOFlrMWFMYm1Dc0l1OGNIQkduRVF2NVhsalRqTUsyQ0x6WmpZQWdN?=
 =?utf-8?B?SHVFT3dXZ0p4bUdhalJnTndNRW1COUtNSU9oMTlEN3VFcWpHVWgvZ1ppWHJz?=
 =?utf-8?B?RXNSQ1kvbk9CbHRRYUJTbzBkR2FpM0FJN01pNFg1U1RGdmg2TjV5ZUlnMFBj?=
 =?utf-8?B?UTcwSndObkhvOHdiNHloU3lDSWtXS3pFKzBXMnZJdEgvbG9GVHBKYjIvWU1D?=
 =?utf-8?B?UGRLb2RLbFlQNFFaZ2pmOXJNbmxsaUEySWRhS1RqcG1wMXBPNVFsampuQ0d3?=
 =?utf-8?B?QnNRVWFQNndjRUwwSmwraExpNlV1bHBNYTZoekk5MW1aWGxVazZEbjh5c1N6?=
 =?utf-8?B?Z3dUczFOaC9HT1lmbTBTam4xdmpNaXEyeWhHRlJnY3FyUnhtTldRZldZNHhi?=
 =?utf-8?B?MDBETVVlY3ZhMzVndDQrVVhnWlh2Uzd4U2d6NUNld1B2OXhOeDFJRThzek1w?=
 =?utf-8?B?c0FBdEdtNE1mczA2WVVFYWVlWFdvWW1tZDRvQ0FPZVU4R0Z1MVRmbHE0Uzhn?=
 =?utf-8?B?ckxnNS9oU3YxalgrbVc1SEhSWVNrajdWaTM2Y2pnaG43L2xUbmJVU0piYWNI?=
 =?utf-8?B?ZGVheHBISElWS04xRndsdmhDaytCRzcreFJudUZ5UnZvcitvQ0toaitlRG5w?=
 =?utf-8?B?V3pSVWdnczNJYkNVcU5UY01QbjNuem5tVFdVbGNSKy9CS21xUUxVMWUrYWRJ?=
 =?utf-8?B?c21hVlF0UllHWFZiRUtPdFZFUFYwUEdXKzJBQWRxQzB1SUxUVjc1RU44bFBs?=
 =?utf-8?Q?RIdv7FsZjJ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGIvN1A3UURKYnllcDRadFVJZWpJT3p1M20xeVZVMFdaQnVVUjNDSFVxRExB?=
 =?utf-8?B?c2QxanExK1lrZnpFeDJoQzdHdG5jWVlLM1BqRmVkeExVZUZSb1R3aEJpcXhE?=
 =?utf-8?B?YzRLUzRjMWk1L1R3blBQam4wV2orUDZJamswaTlVN1ZEL3R4T08xRWpwazNU?=
 =?utf-8?B?aUxFMnA3S2xia0o2eG1hRlI5aGhDYWY1NWF4V1AzRUNvRElER1JwTWRYOVdI?=
 =?utf-8?B?VzNnRGZwamg1VHdFY3FMNXA5UmRYUzFwNTJLbWdNdFQ2aW15TDd3VVpIUGVL?=
 =?utf-8?B?R2x5NnBoUmRoTUFtazVGYnAzTy9NOHRldldLR0h1TERCME9uQkJFS1pkajhC?=
 =?utf-8?B?czBZU2JaNHRFN1VBVTJ6Y0k5OE1JNzF1T2VSVjdYVk9Nek51a3BoY0xtazdB?=
 =?utf-8?B?ZzJkZHZiN0ZXSGlXckJpUWRTZnhCb0lWeDIxL3RsYlAycG02ZHpMTDFaUjhT?=
 =?utf-8?B?ck9Od3BUWEc0R1AvL3k2cGEwWDJ0NEZVYlBlWVF3RmRSSnA1Sy8xY1NwV1Rv?=
 =?utf-8?B?NmZTWlRNV25RZTNZQnVPcGFYRkxML3JJK294QkRaTjh2Tm9EWEgxVTZiZkt5?=
 =?utf-8?B?N0kvb2lGNWZOR0pva1hOM3lkM05nU0JnRk9JYWxYMVFaYTNPMEJyWTg0Y3J1?=
 =?utf-8?B?UWhsb2xaVUJVT3NoZ0oxOHFMU04vRVlGUnNRbHhUa2x2SzUvM2V0elJwaWhU?=
 =?utf-8?B?Q0JtLzJHWVczcVlwaXNxQVRmZFRNK0duZWRwK2x2NmU0UDRjc1N3QW0xTlRF?=
 =?utf-8?B?MkkyNGpNVTJoWkI4S0k4bXpZS0Z6eDlQQWJnRnlYWis0ZHRQclNpSzRhZ3ZZ?=
 =?utf-8?B?dldhMDhvakhJOTB5QmVOWWM0Um9kOXZnWVA4K1QwMEJSWElyejk2NnJOZE0w?=
 =?utf-8?B?RHVUdEltT21pZ2FUN0Fjc2s2K0ZFMGdLRHhtYk4ralVURUtyNmxaUEgwYlhV?=
 =?utf-8?B?K3BrbTNLV1dlb1R6M1dKK0QwNWZaSlZZZlFpVVRHNFhkNHFTa1FEdXhsU05u?=
 =?utf-8?B?TS9pMm9mRGRkbTh2QXdjRGZua1E2VGEyRGVEbGRuZFZEYk5OU0JJQ0NkU2Rk?=
 =?utf-8?B?SnBIbDlha3RHK25GSFNpSDBacmtoeXoxRGNWWlBGR3BVTkN3T0hPeW9VcWs3?=
 =?utf-8?B?ejkrLzlQQTkvcHIzRXR4SzdOUjRncTBWTlpydE1rcFNmUytQczc4Zy9wVHNW?=
 =?utf-8?B?dllxK0Ribmg4azRPSWVtOXRGRnIrdUYrekFIVzk3SXlMTGQrM0p5d2N1MlR4?=
 =?utf-8?B?VFBjTUtoNnd3bDBTTVNiTVl3aFBPaFV3bEhKRm1zS3VxbWVCb0hTVE9OamFF?=
 =?utf-8?B?UExLeGVaZWFoOTlSVFAraHpHRmFCTDBjVnByQUJBTjNqWGRPODNaOU1vQ0Ey?=
 =?utf-8?B?eFhkZWhpczEzc3E2RGRMSVA1NS9nQzZXdGxTQWNlYkZDeXFxOUU5K2pjcWI3?=
 =?utf-8?B?RnFCOEYwQkU5ZStOUUxwSytuS2V4THlsUVdHWFV5dkhaR0ZxZkJUM2dhbEZD?=
 =?utf-8?B?YUZsZ1l0b1dxWlE1bHE3NmFHSUMrQkcwenRTQWtMTzYxcXdNUDlINXRkSnBk?=
 =?utf-8?B?WWlxYUNmRXhEbUNsRWNtTzdDRHVyV0dGUGg5VnpnTUtqaWVKSk9ZMUlFOGV0?=
 =?utf-8?B?S0tNeitlV1k2NVBqQVlvUHVwUUVSUWVkaDBhZ1A0NFp0bzcxaGFNWm9BVjhO?=
 =?utf-8?B?VjMrdnAzTEhFeHJvTjBsT0FPMlVzaElBaWgxVEFEZUFyYkRjeWJkaFhaOXQ0?=
 =?utf-8?B?dTdFS3RTbWJYY1NncXVzck9UVk54d2RZK20wY1lmSlQrZE9mRktIbDlkUHFy?=
 =?utf-8?B?L0V6ZmxmNWVmeGJpSTBLclYwRWVpTGdlaTFZYnpqZy96NGdHTEpVd2xwRDU3?=
 =?utf-8?B?RjA4Y3Zka3V3UXlJamVOZWY2MjhURzhiTXVNdEtmeW5JWkRmZU5NSjFaRXpi?=
 =?utf-8?B?d3E4WTNwOFFjSjhGSXJBY2hzVFJ4TEZuTCtWWGp1Y2hXNitGclFoOEZ4azhk?=
 =?utf-8?B?Mk0vTzZKL1pFb1owZlI0RCt1Q296OENoOTRNNVM3b1dGNjRxUWhxOFF0and0?=
 =?utf-8?B?UTlmM2pRdFpvemJaSC8xUERzblo5YkJCYUl3R0U0S0U3Q0QzYnlHdzFSOFpu?=
 =?utf-8?Q?NDLMHQ5vpglBOW/IVNpvqTk4e?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c52b37-58f9-4360-5a7a-08ddb7e3d182
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:38:45.8514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khQWd5GCZuvm9yfkaKWElhVVsgHbvFG00JcSLyUbeYkFxqgCssQUw+Ik40RaYadKYDwn6xGNFIgChBjRfooHag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6444
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_073853_706473_552EA58B 
X-CRM114-Status: GOOD (  11.93  )
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



On 2025/6/30 18:15, YAMAZAKI MASAMITSU(山崎 真光) wrote:
>>> UEFI Specification version 2.9 introduces the concept of memory
>>> acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
>>> SEV-SNP, requiring memory to be accepted before it can be used by the
>>> guest.  Accepting happens via a protocol specific for the Virtual
>>> Machine platform[1].
>>>
>>> Before unaccepted memory is accepted by guest, any access from guest
>>> will result in the guest failed, as well as the kexec'ed kernel.  So,
>>> the kexec'ed kernel will skip these pages and fill in zero data for the
>>> reader of vmcore.
>>>
>>> However, it introduces a problem.  When exclude a page filled with zero,
>>> a pd_zero, which sizeof(page_desc_t) is 24 bytes, will be written into
>>> cd_header and this part is not compressed by design.  As the unaccepted
>>> pages are exported as zero pages, which means ~1/170 of the capacity of
>>> unaccepted memory will be added into vmcore additionally.  In fact, they
>>> should be considered as free pages and most of the time should be
>>> excluded.
>>>
>>> Unaccepted memory is unusable free memory, so they are not managed by
>>> buddy, instead, they are added to a new list zone.unaccepted_pages only
>>> when the order is MAX_PAGE_ORDER each time conventionally.  The new
>>> page type, PGTY_unaccepted can be used to identify whether a page is
>>> unaccepted[2].  Therefore, add following changes to exclude them like
>>> free pages:
>>>
>>> 1. Add NUMBER(PAGE_UNACCEPTED_MAPCOUNT_VALUE) to identify a page is
>>>     unaccepted, a kernel patch[3] to export the value of page type
>>>     PAGE_UNACCEPTED_MAPCOUNT_VALUE since kernel 6.16.
>>>
>>> 2. Add a condition to exclude these unaccepted free pages.
>>>
>>> Dumping host kernel will not be impacted by the modification, because it
>>> cannot enable CONFIG_UNACCEPTED_MEMORY, so the page type
>>> PAGE_UNACCEPTED_MAPCOUNT_VALUE cannot be found in vmcoreinfo and skip
>>> the step.
>>>
>>> Here is a vmcore size statistic of a freshly booted TD VM with different
>>> memory sizes:
>>>
>>>    VM.mem | Before  After
>>>    -------+----------------
>>>    512G   | ~4.9G   ~2.0G
>>>    256G   | ~2.0G   ~1.1G
>> Kindly ping.
> 
> I apologize for keeping you waiting.
> This patch look likes right to me, so: Ack.
> 
> Thanks,Masa

No worries, Masa. Thanks for your time to review it.

As a hero feature, TDX introduces ton of concepts, which brings a heavy
burden to the maintainers, but to keep the commit message concisely, I
have to only put the most important key points into it.  And then
clarify the details for any questions.

Fortunately this problem has only been found to impact makedumpfile till
now ;-)

Best Regards,
Zhiquan

