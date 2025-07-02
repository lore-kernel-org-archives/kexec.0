Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DFFC83013
	for <kexec@archiver.kernel.org>; Wed,  2 Jul 2025 06:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n1ymcUdB7S11CZobpT2p+i0WMsX8tnAhx5EZ/AaIgZM=; b=Pn8vBLfcEMoEMrkxQeb+ocK663
	oAzcrQDe3MoE/rujMb2nTc8xe5udiCFQGGH4o7JgNhW0s75BIgt2VKnbStGrPPnRzpwsV+g5ZGiE2
	yjc/OGZyqweK5GzfMaORC6gEWoZTXlCRzPEO4TykDT8vStTAaeuD7IKtHGE+T3I74mY1Qdunnt0uV
	+LT8+z7VadKX28xM8ZyR+vkS0/ReOLSY8Cn/8OlTeDnj+lsEC4hap/5hhoI0bjibKkHQh+1R9iieD
	5ZEPcP5PRVUDwdQkvWG07A0+wo9cqq8anyuUurx4ZVzxOEjmhmYDFJC/WV9NG1thjazk+zs66FvHw
	gq3P58lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWqYq-00000007Lzn-3EbJ;
	Wed, 02 Jul 2025 06:03:12 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWqYo-00000007Lxf-08VF
	for kexec@lists.infradead.org;
	Wed, 02 Jul 2025 06:03:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4ZoH1Vzr4z7uSmHy979p8u7QnrrWQUjCPKg+4qY4DKMqW1NdVy7nhKIFfn5rxjMU0xBqM5cBz6/OEt+Mn7SBDGoU3bqGd9M26kppcSB3UpwBisnAj5rhF5drBKJafp4oQWiIIh80R126oKNlJX7cy4XAAqM/J4QcqPizzJRqynjEXT5jak5Wer5wuEwDSinEu5eUCNONOolkvh7oCg4SXojcnYnll9c2KQlt85HfA2SHeLUjyKAuBLaaBUC9fZwold7OfpYpsQUR2fzog6WepyeRLLytWV8OUWM0HwwZInatB86DKDJpRvnuU3Itoa++Rn0tSwytoMClT1Utjx1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1ymcUdB7S11CZobpT2p+i0WMsX8tnAhx5EZ/AaIgZM=;
 b=IECJyerhLoRa9PPmqDrdMaqfjRcdyhDVBKgnhCIuWMUeKuozciJxeQPYl142GyJ821mO6Tf6zovkosIGwwQbK/AhzERU0B6VgUTjou+SCoisUWmbBRzuQe7JAFrJ7p0bN11n2upn+c5h2ypS4/WKw4jNLRCXatP3o3MKW33krgV+1S/HndZQjyoo86duNiucVpqqZWZtdcVDjyWT8c8+4u+MMDTh6vFoLBsM0oM5RehzZvESa2XjtncuvvoLSQmuA+NEt5HmJ0Sog6Q99szLJKh5pc8+AZnZStvqRMKECBiRHpzyF51xyb1ZyMQLduBJpq75+nxSHOM/0NK3ODQvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1ymcUdB7S11CZobpT2p+i0WMsX8tnAhx5EZ/AaIgZM=;
 b=PWHaDK6DAIzCd2W0XytKeMF0aG05cQZEi02QPwK9KmnL14xi83mOkPavQ6ltyfveBovtIB0gogFozwVKY4eD0Q4krI8YkZSt0kQFT02wlb66WXaNwtC5Ep4w+8RlvRvVyNyiv3kMincmtujGlCk11vrcvL3vXZycto/hCAJ5pbQp5ROTy503TiUyeoEVvHZ7WyWQkjFhA89K8oPUDeuN0bIMrfviCpXtfP9f59n65upQwvIb4nka+P4ZBwNP5m4BUkW1+QjDacsK+ACWl+r2CkpKJwTMlSOFUJVVuoP0Ya412zCaGNgqphf3+VVnTpfBAwfB8km5IgahPt9OeHe5/g==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by OS9PR01MB16295.jpnprd01.prod.outlook.com (2603:1096:604:3f3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Wed, 2 Jul
 2025 06:02:56 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 06:02:56 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>, "sourabhjain@linux.ibm.com"
	<sourabhjain@linux.ibm.com>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode
 (--num-threads=N)
Thread-Topic: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode
 (--num-threads=N)
Thread-Index: AQHb5XiBHM/FX67D1ky3gbRMCQy+FbQc6x0AgAAGMoCAAQ/0AIAASZSAgAAEXwCAAAMEgIAAEL0A
Date: Wed, 2 Jul 2025 06:02:56 +0000
Message-ID: <29488c31-41a4-4dee-b768-9f8c49deeea6@nec.com>
References: <20250625022343.57529-2-ltao@redhat.com>
 <7c13a968-4a3a-4d0d-8977-3ba0a4a845b1@nec.com>
 <CAO7dBbXpkshxguPbHDA2YFZeYsDAbyswBCQ7x0UKY__4H1K2jQ@mail.gmail.com>
 <5c425f4e-4e89-4500-993e-e4dfec50a4fb@nec.com>
 <CAO7dBbXweDPUpsEDYhFZqf-eAALGrFOBJh-=bQAYMUsj2ioNpw@mail.gmail.com>
 <e78c8c33-5718-4218-89a3-ea4d7e3a6c64@nec.com>
 <CAO7dBbW=zX15-LDE71qYMJKmm=EF-VANJ3YtK+8n92yrSOS3pA@mail.gmail.com>
In-Reply-To: <CAO7dBbW=zX15-LDE71qYMJKmm=EF-VANJ3YtK+8n92yrSOS3pA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|OS9PR01MB16295:EE_
x-ms-office365-filtering-correlation-id: ca697cbd-c750-4357-8f7b-08ddb92e175b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TDJuS1d5L0hMNUpBMWZwMldzWkxhTWNkSFRudWxobGZEeWxaZ1pRSzdnSXJz?=
 =?utf-8?B?a1c0NzZRVStnUFdFbVhBMnZkM3JUZVJGajRzZUV4a3VFWEpxVGozLzlMNS9n?=
 =?utf-8?B?R084dHJJeDcrQ3NBVGc2T09odTJmcC9RdTlEdk5MalQxVmp1RDRuTW10QWtJ?=
 =?utf-8?B?bHpINzJuelFBenljQ3JCaFdBekZ0eVRsaUhRU0pXbUsrdERCb2FCUVU3QjBG?=
 =?utf-8?B?RWppeWJWSjgzTXFLVURVaCtDT3VGT1JxdCs1M1NIQ3hwVmpRYjVBR1FqQ3Bu?=
 =?utf-8?B?dzdlV25ETzNIVC9wTVlselpIanhsRU9WWml4YTh1Q2IvUXhLeWNoenBqdHdv?=
 =?utf-8?B?THpueXBKWW1XenpNbW9EOXNGd3g4L2J4VU5xTmxDekZXcEJGQnhncXNkNW5x?=
 =?utf-8?B?QTFybjA5bWZkMlgvK3JsVllXZ3BqMXl3c1JwQTh5LzRFY3pjblBFRXpVclY1?=
 =?utf-8?B?ZHo5a3RORko5YVgzQmxiRFBwTGkyQ0luSUZleXpKOWZhMk1jQXVSSFRiOVNV?=
 =?utf-8?B?UVhNZzRVeW15OWc0eXZjYjNITHFqMzdGRjBxUEpXQ1BKTEVlNSsrTFUwR2FN?=
 =?utf-8?B?T3VJSXVXVXgrbGJkLzNYbnh0NVJzOGR5eVlCZ1BpYnVTOWRoMjZTWGNQeDdV?=
 =?utf-8?B?dVNrc1R6MWdsNTNObmZSY3c5YXBaRy9uM0xDWUdJNEVDcnhRdlhZMk41RFFu?=
 =?utf-8?B?STkzbFZrMVcrMmtQdWJBMXIwMjdHeFl5RXVyN09VU2xxaGJxZlBJbnVJQ0hN?=
 =?utf-8?B?WXlXMCt3NlBOd3Jyc1BFS21iUWFVTmxhVzBaSE1QZStYcm42N001aFpydFZt?=
 =?utf-8?B?U3prMjJVOXlCUGhzQUd6Z2gwbG14UUV3eUVLTUhHUlFJbzJNSktUSVppN0pU?=
 =?utf-8?B?OWxCVHMwRGtkWW5iV1NneGlFWXlIaHd2NkpCTVFzYjFVSm1ubFlFRHZjRFE5?=
 =?utf-8?B?d0EvYWxvMTZJbkMzQUhieDB2QnFhMDcwb2VSWDd4TFQ0c08wVFpGL0UvN0N3?=
 =?utf-8?B?dUhMREdQaFVTbzhvcStQOEV3QmJvcEpvMXE1RXVVdjNlODgzQ2NDRTIrK0U0?=
 =?utf-8?B?RlM1K2pJOU9qWVlTbDFYYllLUXRTT01RL2dDalpCclBkSTVqeFUyS3k2cEtk?=
 =?utf-8?B?SzkyN0RPeGFTdTlQZUI4Y0wvT2tLbm5EaklwaWRHbFZQSzh1eEhKTXVNY1Fp?=
 =?utf-8?B?Q3FqMmxRdWVOeWUrWFR0eVlPdFd1UTNNdzgwRDVVOXhMLzFGU2VZOHAyOVE1?=
 =?utf-8?B?cjlUWW01VFl2TWdCKzVjMEphZTY2VDd2Zk5BK0NUSnQyUmNDaFE2OFFlQWhq?=
 =?utf-8?B?Qk9CZ1hKUDdLcUVPY0c5VlhGZ1JsbVBkNFhqVTFkeVZ4L0pNeDlNRC91aHdG?=
 =?utf-8?B?RU5lbG1wSDZrQ0NzQ0NUYlNEdFFjNzBYNEVHWEgzOG5iaFBvQU9hZ2phejdV?=
 =?utf-8?B?OG1oTGdxR1lCV2RBSjQrcUNkd1BVOGlsUEhkc3dyeGpuVzI0U1NzN2lSdTVN?=
 =?utf-8?B?VUdEVklXcUQ1Y25CWHpBaFFWcGRuZkFJVldXWEtPRTZ5ZUF1cnk1UUpsY25x?=
 =?utf-8?B?dTB2Mk1aclpkZk9sSzRZdk50VEVUeVY2Sk01UjB6RjdqVnBBNCtZTmRKSzFu?=
 =?utf-8?B?ajZML2U4S1czTFI5QjJLUTduMjdaUzQ1S1hpNHVPZzN6SFdMc2JuR0hLVXJx?=
 =?utf-8?B?UG9tbzk3TmJ1VzAzRWNIL09qTFBMc1JsUEI3YWVKNXI1VElUTzdmdzYwR1Zu?=
 =?utf-8?B?S0RkWjFYRnl0YUN4dDVlSmQwT2N4S3phODNUWGxZOTk4TjAySXFKY3owd3Br?=
 =?utf-8?B?b1pobDNPT1N3WmN3S1RFdW9zYnJQVy9pZGp1QXlJTHFyVDJzRlZOcm53Sk5k?=
 =?utf-8?B?WEM5VjRwWTBjRUZyYm1US3p4QmZ2YVg0KzdmRFhMdGwyNXMzRStwbHNzNkpJ?=
 =?utf-8?B?c2hRQWtZZXRzbTBTd0Rkc3NYU1pJUk5QQVB5Ry9ZdTBoWk52YnVaOWs1QTR1?=
 =?utf-8?Q?kq/CIAg0HC8w6KnM/i1BBdXdJtBeTs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YklhcXZ5clVmTUh2L1YxYjl4SHdsWngxanZva2tnM0xsWU9iRlkzSUN3NVR3?=
 =?utf-8?B?Y1VMYTRYY1N2Rno4U09KcGhmVy93ams3L250RjFWdWw2MW1NUTRNMzdLOCtQ?=
 =?utf-8?B?RzZYTVNFOUcvbndxWEo1UTRBd0h2WUZBYng3M2RCWm96aW5WeWVONUJiL3l6?=
 =?utf-8?B?alFpTnJtZDY2ci9PNkxZWndSeXpyUHZxSGZ6R2dmUUljOExKMXpVMUg1dmlC?=
 =?utf-8?B?STNkYStsL1hYMllYVE1nc2lDQ1NxMnFHYk5Na2NwSWlOb3lLWE9NbGVLamdF?=
 =?utf-8?B?TytBUU80N2V3bHQvMjdJdWxsSG5FaWFaZ1FUTWMyekYvVWtySi9lMStybFJJ?=
 =?utf-8?B?Y1dpTDNBV3U0Sm1YVEdTR3V0QVA4U204b1FmOU5vZ0xGTlVqNEs3b21zNzF4?=
 =?utf-8?B?VHAvVjREcmdpdU1kcmhIOGlVcWxPNjJ0ZkxHQ1MrVzdEbis0K2lxNk4yRW1h?=
 =?utf-8?B?QUhlSmFveDhQdlBETHJvUGJ4THNjUzFVUW1wenFxY3NaRXhZWm1YYWM1ZHFG?=
 =?utf-8?B?REtiVUhzWGlRbjd1U0pJdHdjNExsQnp0ZGsvZHFmbDd4T2lMNUFjTklyTStO?=
 =?utf-8?B?VjdFSDhVcFRKaEYzTHRWZ2t3bVAxK1FpOEZKWUJwNHJsVGZjQ3VyemY0Qlhu?=
 =?utf-8?B?VFpqRk50R3AyZVRzc3VyeVF6OVljOGFxdFd5MUYzdmdrbW1va295UlBSRHZy?=
 =?utf-8?B?a2JyQVhGL0FOWHZRbFRYVThuS1BRUkJLU0lDc3l5TC9oQ3F2YjRoT3BDV1Zs?=
 =?utf-8?B?R1Bra20yVDZwM3R6U2ZoNm1sNWl4eGlDSDhJY3F0YzJoY1JlaDVJekhhVXZr?=
 =?utf-8?B?Z0ptblI4REUyU2NyZDRjTlgvSUxMSStDNkI1UXB1aktueUJMdXNERVh5dDlS?=
 =?utf-8?B?aHhRd2puL2tObHBQdmxKM2wyTUlqZ1pHZWNNR3hIMTlEa3lKL0hNQ0VGLzYw?=
 =?utf-8?B?YzRWUUxpdE1QRlNZNjExRUJIaThwRTgxL2xVVVB0ZFVjc1VQUUphSEdkT3Ba?=
 =?utf-8?B?MS9tb3JUQkpBWStSMU9GeWQ4STcyeGtoQnF1djdqR2Rmc2xWODI0THpsSnR0?=
 =?utf-8?B?V3hacU1qUDlxWkhuZE80VWxSaXF0emtJSGt0RUYrSGpKTTU3cFhaUXBLSG12?=
 =?utf-8?B?MWZQUnlYaDNQV1pwQ2NCNDBjSG1pWGlwaE5NNHIwY0NQT2RmMXpwUUZhYkp4?=
 =?utf-8?B?czJ3cGZPSGNsVWpVT1hpcmZrNHRVK2syTGUxcm4rcXNZMUxEeHV6bkVhU3R0?=
 =?utf-8?B?OE1MWXVNcW8xSUNVOEJtMVFweHZRZVRzb1dMUTdMSzZVYUdwSGk3VlZqSEJV?=
 =?utf-8?B?MG54TUxWSDN5REhYWjdzSC83c2hOMWttTzB4cDNwcitKNXdFQUxVNVpkUUZN?=
 =?utf-8?B?M1lGVVh3OG5ITFhRUUxFaldNMC9IcThZcjZtUkRKdHBIWi9scWRWZ3U3NVNu?=
 =?utf-8?B?V2NIdlFDakZJU0ttamFXQU9teXNNWTFZNDdvUlFyTW53d1V5NkRwV1hGL1Jt?=
 =?utf-8?B?OTREZGJyUDBiWllIYTNFdE5Kb1E2TDJUdnVLM2gvZnA2NUJIYnVHRWlqbUxH?=
 =?utf-8?B?aGlwK1M2aXhZTC9tZ3NieEQrc3BBeThkYlFlTnAxTG45Y01SZ2hISGZWVVc4?=
 =?utf-8?B?dzFMZ3pSbXZIUTFpZUVUT1c0eU03K1kwcjh2N3pBUlI3aSt4aXdicDBtbFpY?=
 =?utf-8?B?TWR4TUVXWEpTdU05amlUR2wvaGt3ZXc2L1ptNmMvSDRVeTRIZjcwNVRtL3NF?=
 =?utf-8?B?TDBSWnZPTldlRTFMMldLSGdqOHhvZDR6ajI3NzArS1BuOUZ5dHFTTi9xdmMr?=
 =?utf-8?B?UFpvMFQzbUUwRUZUd2hvd1krY0FYc2d1SUpXVCtDVklRRDltYVVpR2dMNTN1?=
 =?utf-8?B?WmlzRnoxOXVvUUdNRUkrcFN3b2gzMkVmL2RrTlUxYkNGQzVreDNidzVlY0Y1?=
 =?utf-8?B?aTZqK1JMZFNwZVZNQVpTQm1zMm9iY2RxR1JoN3g0WGZLNVhYTkRkRU5vZEtp?=
 =?utf-8?B?Wi9mQ1FIVXI0TkNNNGJuRjRNYzdRZFJ5dEVZMFRxMUdpRCtCQnNnWjhLcVR3?=
 =?utf-8?B?WkYwZXl4RVV5aXR5OGY5dGRoMXNrYlhaQmc3WCtGUk9tNWQ0VEJlNUZzRkhW?=
 =?utf-8?Q?mjSIrX8RI7Hh2/eyfHOtrDqLc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F6513596A8C9745B8E70FF6E16A41D6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca697cbd-c750-4357-8f7b-08ddb92e175b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 06:02:56.7734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1jqaspU7KYQ95YYEI4hhND76mwjjG466VNBv+iTZnTIw2zCkd3Lpzjd4Qat0zCN68W5+EzjeUS5/meeGuXK3rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16295
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_230310_230830_BE0584F6 
X-CRM114-Status: GOOD (  11.71  )
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

SGkgVGFvLCBTb3VyYWJoLA0KDQo+PiB0aGFuayB5b3UgZm9yIHRlc3RpbmchICBzb3JyeSBvbmUg
bW9yZSB0aGluZywNCj4+IGRvZXMgLS1udW0tdGhyZWFkcz0xIGJyZWFrIHRoZSB2bWNvcmU/DQo+
IA0KPiBZZXM6DQoNClRoYW5rIHlvdSBmb3IgdGVzdGluZyBhbmQgaW5mb3JtYXRpb24sIGNlcnRh
aW5seSB0aGUgcmFjZSBvY2N1cnMgYmV0d2VlbiANCnRoZSBtYWluIGFuZCBzdWItdGhyZWFkLCBJ
IHdpbGwgY2hlY2sgdGhlIGNvZGUgYWdhaW4uICBJZiB5b3UgY291bGQgDQpkZXRlcm1pbmUgaG93
IGl0IGJyZWFrcyB0aGUgdm1jb3JlLCBwbGVhc2UgbGV0IG1lIGtub3cuICBJdCB3aWxsIGJlIA0K
YmV0dGVyIHRvIGFkZCB0aGUgc2NlbmFyaW8gdG8gdGhlIGNvbW1pdCBsb2cuDQoNClRoYW5rcywN
CkthenUNCg0KPiANCj4gW3Jvb3RAaWJtLXAxMC0wMS1scDQ1IG1ha2VkdW1wZmlsZV0jIC4vbWFr
ZWR1bXBmaWxlIC1kIDMxIC1sIH4vdm1jb3JlIC90bXAvb3V0Nw0KPiBDb3B5aW5nIGRhdGEgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogWzEwMC4wICVdIC8NCj4gICAgIGV0
YTogMHMNCj4gDQo+IFRoZSBkdW1wZmlsZSBpcyBzYXZlZCB0byAvdG1wL291dDcuDQo+IA0KPiBt
YWtlZHVtcGZpbGUgQ29tcGxldGVkLg0KPiBbcm9vdEBpYm0tcDEwLTAxLWxwNDUgbWFrZWR1bXBm
aWxlXSMgLi9tYWtlZHVtcGZpbGUgLS1udW0tdGhyZWFkcz0xIC1kDQo+IDMxIC1sIH4vdm1jb3Jl
IC90bXAvb3V0OA0KPiBDb3B5aW5nIGRhdGEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDogWzEwMC4wICVdIC0NCj4gICAgIGV0YTogMHMNCj4gQ29weWluZyBkYXRhICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IFsxMDAuMCAlXSAvDQo+ICAgICBldGE6
IDBzDQo+IA0KPiBUaGUgZHVtcGZpbGUgaXMgc2F2ZWQgdG8gL3RtcC9vdXQ4Lg0KPiANCj4gbWFr
ZWR1bXBmaWxlIENvbXBsZXRlZC4NCj4gW3Jvb3RAaWJtLXAxMC0wMS1scDQ1IG1ha2VkdW1wZmls
ZV0jIGNtcCAvdG1wL291dDcgL3RtcC9vdXQ4DQo+IC90bXAvb3V0NyAvdG1wL291dDggZGlmZmVy
OiBieXRlIDExMTE5MDE5LCBsaW5lIDQ5NDE4DQo+IA0KPj4NCj4+IFRoYW5rcywNCj4+IEthenUN
Cj4g

