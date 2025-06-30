Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F13C83000
	for <kexec@archiver.kernel.org>; Mon, 30 Jun 2025 05:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZdzDcisIAJo8k05aiImnkhj24xl91/P9aUwLMQuhtuk=; b=K+/6ONxLg5bIZWhYoFgLAHre3C
	PQZK74hZWiQBfUqW+EIThXje9Qf7LeDvKdeh+zNk+GDPz70SWXVnzAl6zge8OP/8+zzNiDsQ/bMdZ
	dMGRuOG4YPPB3bkKT2ZAj8HadpQBVjTPKmFqp4Go6AKyqss/nPXR6+U7Qft8YCwpNZbW+b3XQY9AZ
	m2QU/ejseXnNLt8eUED4Q64tCr9RaqxZRv8rKB+Qiu/SV8MYoosqxSkAvCH33SDcJlTYWieULRcHY
	6rURCKZXB6BPwOBtwfK4aVF0MKZw02eOakYra/xZvF9/Q89kKa1WdKzAbTPKuCBmZD5aZb5s4W6mW
	hcwDb9iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW7PN-00000001I0w-3xtT;
	Mon, 30 Jun 2025 05:50:25 +0000
Received: from mgamail.intel.com ([192.198.163.18])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW7NK-00000001Hu9-1zqb
	for kexec@lists.infradead.org;
	Mon, 30 Jun 2025 05:48:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751262498; x=1782798498;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CSwOhvVVimb5vqiM1ecINtBCDHSZzunr41zF7Bg8W1E=;
  b=Iojkw2UssEGKoDanL7C7l7ywF7apTZIax7GusNtTqidByTO8UHTrmb5/
   BK+SmFlkZE5xRyNlEplwPcgFcTxzs95lW3px36jgGsta7geyYsShlSZu3
   sKNokewBq/YNG975YF0Ewey6JWI2infekU7vyaR2zDVDDvchdvPUZExNv
   qN1JWKtLBJHOmmVDlT96labsLecrZ/UYC8LNBUtxDoGKb1vPIpvdXVuCS
   WMIVxku2lIfz7bLFNMQtosdXQzPAw347ZjQDgX3oP28dUP+c5HSPGJsdC
   SToLXvLLqjaFoHu8Nm9eh9Nw/SPRzL0zD+odOxTvXxGG0aJjeur8YFMdp
   g==;
X-CSE-ConnectionGUID: 14RgtfeQQl+11Pt2bs0G3A==
X-CSE-MsgGUID: NvwwY7h2Tye1fCZEYN9YCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="52707887"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="52707887"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 22:48:14 -0700
X-CSE-ConnectionGUID: qWnfU5VNQ9qfErPtNqn27A==
X-CSE-MsgGUID: d2ZNxx9pRV2LoNJyWcA9aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="177034531"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 22:48:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Jun 2025 22:48:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 29 Jun 2025 22:48:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.41)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Jun 2025 22:48:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/xERtDzAxOmQxGch+X1KnS2PndZHnmRP4AL6y9DNNIspDeRHv268rF21ON/6P1rLTAePte9A2hf9EDX6rMIW1SU03gqayiSJf9rgyhWUilEC2vN6dwgYM2tZVLlcFqRtyj36PG7Ekd1xyLKLFO0rG6TH6EfytnRmdKdrCLRFRnE5oek+tXqwPwOm6jh5BtDUA4cGd+WUEe1EnOfd4LLNbZS2XJwbDQZpi/4IxP59iS2dvSqkHN/5Q3Nnc/1+bB2T2UxGYFluKoxEw+PClf6kpvH+IGVhN1PGJdmIZvUP5yuNj4RAgSfUgqSAMLtMvtgjH5S1qTvZnJqdxg76ejy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdzDcisIAJo8k05aiImnkhj24xl91/P9aUwLMQuhtuk=;
 b=F+PRSfrq0o4H6eKmL1B/4FnA6VokIsOv/oiTiKERosBr8vE03Rqn9rTuId3W0FkYlDpk561nQ95eHw1XSbeKuC8NqP7PWySFAVHwX2EdROUC0xQIU5R+jtsmEbYsQlAbbPBHisYS8Un4bZZmWPv0orgiNDMQbijVUA1Rmr4b9crw+DY+aNXihEvb2UxB/dBEBH/LyDJ6ea6yvZ74+K7nVdlSwi5zZXZ2iOcFl1o9/Dg3gc4M+slVSnZjcJnBHDSKTHi0BrfXgd4eFR66KnzIaPQLwP+yJ+MleiIlU3WK6v6w1HzSEiCMrtMb92I28hARcor29zzgpJilB3Xx+VzVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11)
 by IA3PR11MB9063.namprd11.prod.outlook.com (2603:10b6:208:57d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 30 Jun
 2025 05:48:11 +0000
Received: from PH7PR11MB8478.namprd11.prod.outlook.com
 ([fe80::6961:eda0:dc93:5b4d]) by PH7PR11MB8478.namprd11.prod.outlook.com
 ([fe80::6961:eda0:dc93:5b4d%5]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 05:48:11 +0000
Message-ID: <a2e8c88a-1fc7-4d40-b081-afacbe95f2d2@intel.com>
Date: Mon, 30 Jun 2025 14:30:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH makedumpfile] Add confidential VM unaccepted free pages
 support on Linux 6.16 and later
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?=
	<yamazaki-msmt@nec.com>
References: <20250609050244.837619-1-zhiquan1.li@intel.com>
 <d650c4eb-5eae-4a0f-94f4-98877e9e68f5@nec.com>
From: Zhiquan Li <zhiquan1.li@intel.com>
Content-Language: en-US
In-Reply-To: <d650c4eb-5eae-4a0f-94f4-98877e9e68f5@nec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To PH7PR11MB8478.namprd11.prod.outlook.com
 (2603:10b6:510:308::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB8478:EE_|IA3PR11MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c3ed11-01a7-435a-11fc-08ddb799b290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVIyTUl4aERDUzROa2xON2NuQ200WkYzbzdJNUxNZThxVVg4TWNYTFE2R0xC?=
 =?utf-8?B?QnNZNy9rU1BPVlJjMlB3VTdzTkt2UnZLM1dSM1hCMFNoWTNzNFpCT0YzMzBw?=
 =?utf-8?B?WnVBMy9kWW5lWmNtNldUelg1cDlIZ2I2cmovRGx0U3FFV0VIVG1hVThTbGhX?=
 =?utf-8?B?OVFlRG5hNE1ZWGZkZzZuMlg2NVhldlI5UFBFSHpQdlJtbnpHWDVCR0FqdHBv?=
 =?utf-8?B?VTdMTUwwYkE0YzExcVpwRWRCS0dJYTBlaEoyeFQ4UDBsalg3MS9kZXhzQ0Q5?=
 =?utf-8?B?MUpIekFiTU1FUDhyWndyS3NueU9QQ2NqTlUyZkpaWmpBVWYzb2FVbWl1Tklz?=
 =?utf-8?B?REo0VEd6U2lKL0hVNnNVMGxWeE82dnc0S1doZlBhcGY2VUk2WG9aZnVQYmxl?=
 =?utf-8?B?eVpPb2VFRVc0eUkxelQyYmxiQlNDcEtydzVWZzhST0EzTWJVNDlHQTJmMkhM?=
 =?utf-8?B?UDFCV3pVR1MzL3NXeG5IMEVqK1NBNEhmRFduV1VpVlpMNk4zMFg4SmJhRXI5?=
 =?utf-8?B?N1h2OWJFL0xOVWUvWFkzMy8wS2c2a1JIVHYzaVZBNHE0ZWhpend6eWMxbGlu?=
 =?utf-8?B?YVdsOW8xbjdEM3RPajQ1M1JqMTRTcE14R3FJNFlac2VCRFE4Z29aSGVWcUZu?=
 =?utf-8?B?TmVzcUZPUXdLT2UvcnY4Y3V1YW9DcUhGS0lZOWZPSHBIa2c4UTdJeVdIc3ZW?=
 =?utf-8?B?MXNWelFDck9NZmVlWUhwOVZJay92YVB5bk12bzNCSmFLMC9welFqVHBoUlR4?=
 =?utf-8?B?WEF3Rk9sNnRQWGw5TDMrcGJkNGhiOUtFajFnN0dXOTl2RndNeHBVWldsWHoz?=
 =?utf-8?B?YldwTHFncXN3ZjVUdHgxM252UDJrWEZaajVEMnY1Um5tUVVnaVhTbUZrOXJ4?=
 =?utf-8?B?dFNwZURKMmhSSW9XV2tFWkY5eTQ2bFNwbWxLbHdZTjhCSXdXNUlDNFJpL1Nt?=
 =?utf-8?B?NjZ2YTBTTEtWNm5ldzFNQlAxUDI0WDd6SjRrdXcwK2VQdFVsS3VZL3ltVHo1?=
 =?utf-8?B?WHg5ZjdkZC9hN2c4Z1NLNjZ5TXAvTkhCSjBEOWZEMDVqYUE5a3g1aUFiSVNR?=
 =?utf-8?B?cU4xcjBoZHBTemNSU3VFYTJtdHU0MFU2WXFqR3lxenFqOVJ4bGU5bnN2ZmlY?=
 =?utf-8?B?dWZBOUN5LzMyYmNiS0t4dFVOR3piejFmRUsvN3ZnNnFQSVZ2aFRHZ2NrS2l2?=
 =?utf-8?B?RDMxelpSczRub0lOV0FnMHU3TU1qZktZYkFZNldBR1Z2LzlLTWpOdTRRUmRV?=
 =?utf-8?B?WUlWeGg0c1BCL05ieVF6Yi9ndXBXM2pFTCtuZVIxbEptd1habUp4alJOdzhF?=
 =?utf-8?B?NHJERWRSWkR2emlCSEdlczRLZ2VndnBUd2hiVEIxQXYrUzlMb0srN2dWa1p6?=
 =?utf-8?B?em5HV0Y2cE9oUWZwdThzK2IxVmI4SFk2S1dpZVowTWZYbzZjem01dG44OGxw?=
 =?utf-8?B?Z29DZnlJRXRQNWdkYU56VjNGazNaYllhWEZTaFEzSTZpcnFDcGIzNmpQeHFK?=
 =?utf-8?B?OERPeUtmNWVaUk9hZElneE0xcEZENW5BY3ZKdE13cnRGQlZJYUZPcktZU3hR?=
 =?utf-8?B?ME4wRVpoT2w0UU45YndsN1d2YWt2VGV6OHh3dnl6WXdDRDJ6dmh1VmlBcTZa?=
 =?utf-8?B?UzhaaEZBcURGTG01SjdhWEtEMm1NR2ZxeHNzaWhCVVQ4cmQwTUVIT0dxbitD?=
 =?utf-8?B?Z1JTaHNLeVdXaFN5YkVlYm14eG4rZzFRQ2kwUXFxVVJHdkxybGVRZlVJRUlv?=
 =?utf-8?B?VzlSUlFYSG5FZlJIcXlKM2VYd0xQb2VJNWQ5aXI5YXJNVkh1aHRPT2pMLzUx?=
 =?utf-8?B?dEp1dzJKS24yWVkrT2c5ZzIyS3VRckMrVGpXZUh4dWZHVU1ZNnFLWXlGZEUv?=
 =?utf-8?B?dVJDd1hVTWQrNXpHUjlkbXlIOWVXa1VpZ0xmeHdsbWw1NHRhZzFmWkk2VXJB?=
 =?utf-8?Q?4v7ZamrI9o4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnkxMXROQUN5NzRhRWVyaHA2K3JYL1g3SHNKU1dncnNmWlNENTVTMXVISE95?=
 =?utf-8?B?Q2ZsbkhDMlp1T3hNemdieWNBK0YycWs2RHI3eHdKaUtXR09NWjJEMDh2aHVy?=
 =?utf-8?B?SkVNRDE0WTBxVGVBa2txTlBTK0F0K1J6TXJHd1pCeEMwMCtPODVpUGVnNTho?=
 =?utf-8?B?MjFqV20rMU5xMDVzdWhRLzJBTVVETjNjM1hWZDcrK1FrQmRJaHhZcUxGbkYr?=
 =?utf-8?B?ZkkwL2ZMRnpjL0UwRHRwT3ljYk5VeHlsUEdSVGtwUG1JLzI5QUlZMFVvMU1D?=
 =?utf-8?B?Ym5aSHB3cXcxYXY0dVFzTHFrUk00MUZocXZ2SkhnRm5Sc3NRQjg2aXVFQ3Jo?=
 =?utf-8?B?WWNoSUdVQnVPTkJsdm1KckM1RUdFQW1XSUNpZnk0ZW1BTzlyYUJNak1abzgv?=
 =?utf-8?B?UFFIVEkyTnF1dlMyelkrQ2FQaUlaL3gxYk1Bak9zQkhpTUlRZDhNVDlSK2tT?=
 =?utf-8?B?THk3dUxKRVZONDdXaWcxVFdPMThjSEZPQTdPN1ZpQmJ2eHhkNk5ZbEtCYXBn?=
 =?utf-8?B?R2lPTDJ1NnVHSVlEQ1VTb2xSTnpFM05TdzA0cmdhZk15Q2d4NkR2czJXOTQw?=
 =?utf-8?B?aDh5S1lIT1hnSVgxTWFvNWo2L0dHOUJnU0xUcy9BSlprMEh4d3FDcXhHMXpW?=
 =?utf-8?B?YlpaVE1pS3JOa294SjBObWk0K041OGlqb0lKb3IzdU5janVsckpCOGovMWsz?=
 =?utf-8?B?N1RhbUE2YmFUbExYK0RvbWtSZHZtZTRETnlBNmNLOVJBaFVwQjk1QVdhbnEv?=
 =?utf-8?B?YkUrbm1udXVyci9yR1Q0MUxKZDdKZENWdnVncWZ6aS9FZWlsc2MwT2hiOEw0?=
 =?utf-8?B?cFVOSEl0N0ZVUjhoV3NXeVE3MkMzbFFXeXJUK0lzZmRnd1lWRklsd0Z3WjBG?=
 =?utf-8?B?M2pXUjIyR2NRVkl5RDF0aXZxU1pPR2pvQmVnRkF0ei9JNks5cFpERDI2R3pk?=
 =?utf-8?B?dUNraGdoWUdHOXRMNUEreXZuOStXbTFBS01WUkNXQ0lBY3lFeXJMcXhOcXhS?=
 =?utf-8?B?TmJPaFFaVGNyR3F0aFR4eE4wdThSR3llakQ2dElmWURRTXlTelQ3ZXl6WEhM?=
 =?utf-8?B?T1FrV2pXT2ZLRVJKdTBIY0wrNkdyZDdKRFJkc0J2YUdnbEtiV080ZEZucFpl?=
 =?utf-8?B?MEsrbzlKNXpuTkdSSUc3RmhFbDQ1bFErL1NBZ2RGZXo2OTJWK24wVkpZNGtH?=
 =?utf-8?B?SnF3SHZUcEpmYmFQazVKKzY5RlFiTE9QZUpmMDhkUWlYR0VWcmx4d3FObTJO?=
 =?utf-8?B?NDZzK1lLQnZmeDAxY3FmOTFLeEJwMFdmbVBSeVFrV1M0YjdCTXU4b0VSTHl1?=
 =?utf-8?B?c0JDeFhtNHdvTmVubE9PYW9DR1FDZC9qVDgvWmVubTMyQlpmWGxXTVNsamxa?=
 =?utf-8?B?MnQwYmRxQUJXMGJWSFpCOElYZnc2d3lWVW5aVjZYWTIwQnZRV2ZlaFpHQ1d2?=
 =?utf-8?B?ZjA3RHhzREQyOE1Ba0c0YTg3Slc0dzV2SDFmN1VDblN6NWw2VUJyakJES3Bz?=
 =?utf-8?B?N2ttWXQzbExLWmZ4ZGx0SjMyYWZlcFpabVhqMnBNT09MNHFudWlCbmVhMzRh?=
 =?utf-8?B?UEExbExGWVVuSXJocHh4eTdPZDBhb3BUR2VrdDh0Umt2WmgzRkp6RWR0c2U3?=
 =?utf-8?B?enVhWWxxOWZyNFRXWitOTHlRb2VheVZmdmdodXBSK2RaK1l3cXFFdEprekoy?=
 =?utf-8?B?ZUorY0lUTmJpV3VvYXNYMGowZ09KdDBsdGhrTlJwVjVCbTkxTGlLdzhkWjFM?=
 =?utf-8?B?TjNId3pzNkVyeDdSamFzNm9sMm05MDZtV1VER3NvRTFiODgybnF0anpsQmpV?=
 =?utf-8?B?OU9pK3pwR2FYUzJJWndvbzJvZWVsSmxsQ1NCdnB5M0RwOCtrSzNXV201ZjRJ?=
 =?utf-8?B?WmhzbXV6Y3pRS3Izbi9iYUpYVks1aUZzcmJnclNhbFFmYmVqNXMxaDlxTlZF?=
 =?utf-8?B?L3QrTG1EeUxUR2VTaTBaLy9rQXQwZnRSRzFFS3E3WXFkK3lXRzlvNUZnWTBF?=
 =?utf-8?B?S0JSUGU5N0laV1hSTVlRWkQvOEJCU1E0US9yckh5SFl5czFzREtObXFjUC9m?=
 =?utf-8?B?UUpTVjBONU5UNFZEaU5WWXhZamtuY3RYU3FzSS9YNlhlRzVBREtrSndRRDVn?=
 =?utf-8?Q?15LXNYWBLH+S70Un64YEq53IE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c3ed11-01a7-435a-11fc-08ddb799b290
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 05:48:11.1472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOj8g6dPytJiwhic1GCiiM6kWWIpsLaP8DfOjmU8c0GipgTBJDlEfy1u/51JY0P4dEG9/GgISDV5KFl9qTFvNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9063
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250629_224818_562889_1CDD50A3 
X-CRM114-Status: GOOD (  23.53  )
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


On 2025/6/30 12:05, HAGIO KAZUHITO(萩尾 一仁) wrote:
> Hi,
> 
> thank you for the patch, and sorry for the long delay..
> 

Thanks for your time to review this patch.  There is a lot of background
knowledge behind this feature, it really needs a long time to digest them.

>> @@ -6630,6 +6633,17 @@ check_order:
>>   			nr_pages = 1 << private;
>>   			pfn_counter = &pfn_free;
>>   		}
>> +		/*
>> +		 * Exclude the unaccepted free pages not managed by buddy.
>> +		 * By convention, pages can be added to the zone.unaccepted_pages list
>> +		 * only when the order is MAX_ORDER_NR_PAGES.  Otherwise, the page is
>> +		 * accepted immediately without being on the list.
>> +		 */
>> +		else if ((info->dump_level & DL_EXCLUDE_FREE)
>> +			&& isUnaccepted(_mapcount)) {
> 
>> +			nr_pages = 1 << (ARRAY_LENGTH(zone.free_area) - 1);
> 
> just to clarify, does this mean that the order of unaccepted pages is 
> MAX_PAGE_ORDER but it's not set in struct page, so we need to set the 
> order here?
> 

Yes, the unit of operations on the buddy system for unaccepted pages is
MAX_PAGE_ORDER, and the type PGTY_unaccepted is only applied on the
first of struct page, not each struct page of MAX_PAGE_ORDER unaccepted
pages need the type.  Therefore, if we see one struct page with the
PGTY_unaccepted type, that means the next MAX_PAGE_ORDER-1 unaccepted
pages are added to zone.unaccepted_pages list.


The corresponding kernel code snippets are here:

1. the condition to add unaccepted pages to zone->unaccepted_pages list:

1428 void __meminit __free_pages_core(struct page *page, unsigned int order,
1429         enum meminit_context context)
1430 {
...
1462     if (page_contains_unaccepted(page, order)) {
1463         if (order == MAX_PAGE_ORDER && __free_unaccepted(page))
1464             return;
1465
1466         accept_memory(page_to_phys(page), PAGE_SIZE << order);
1467     }
...
1474 }

At L1463. only when the order is MAX_PAGE_ORDER, the first page is added
zone->unaccepted_pages list, otherwise, accept the unaligned pages
(whose order is not MAX_PAGE_ORDER) immediately.  As the unit is always
MAX_PAGE_ORDER (Condition 1), it's not necessary to set PGTY_unaccepted
one by one for each struct page.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/page_alloc.c?h=v6.16-rc4#n1463


2. the operation to append unaccepted pages to zone->unaccepted_pages list:

7278 static bool __free_unaccepted(struct page *page)
7279 {
7280     struct zone *zone = page_zone(page);
...
7287     list_add_tail(&page->lru, &zone->unaccepted_pages);
7288     account_freepages(zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
7289     __mod_zone_page_state(zone, NR_UNACCEPTED, MAX_ORDER_NR_PAGES);
7290     __SetPageUnaccepted(page);
...
7294 }

As you can see, the linked list append operation and set PGTY_unaccepted
is only applied on the first page.  But the number of account and
statistic is MAX_ORDER_NR_PAGES.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/page_alloc.c?h=v6.16-rc4#n7278


3. the operation to move unaccepted pages from zone->unaccepted_pages
list to buddy system:

7191 static void __accept_page(struct zone *zone, unsigned long *flags,
7192               struct page *page)
7193 {
7194     list_del(&page->lru);
7195     account_freepages(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
7196     __mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
7197     __ClearPageUnaccepted(page);
...
7200     accept_memory(page_to_phys(page), PAGE_SIZE << MAX_PAGE_ORDER);
7201
7202     __free_pages_ok(page, MAX_PAGE_ORDER, FPI_TO_TAIL);
7203 }

As you can see, the linked list remove operation and clear
PGTY_unaccepted is only applied on the first page.  And the unit of
account and statistic is still MAX_ORDER_NR_PAGES.

Then accept the pages in size PAGE_SIZE << MAX_PAGE_ORDER at L7200 and
add the MAX_PAGE_ORDER pages to buddy system.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/page_alloc.c?h=v6.16-rc4#n7191


The consideration for Linux kernel is the overhead of switching
operation from SEAM non-root mode -> SEAM root mode while accept page is
big, so it accepted as many pages as possible at a time.  If
makedumpfile can be aware of this feature, it can save a lot of disk
space and dump time.


Best Regards,
Zhiquan

