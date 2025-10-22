Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC29CCD1AB
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 06:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gQi/XUsZzzuJD0V7eH64+FheXmPPaZxLOakrdXSkQ9E=; b=wDFZeHmuT+7/hrjXhGOZxnrQ6B
	rp85ClG5TReGKzn+e/PqmOhrnEOuZyxe3iWwF8JPsBUHgDd1LAWx/33kofxCGSDq8gOk3a043sq06
	VRhd5zOk48TP81BhZTUjkh3ma+gQFFLcexkwAzJIFhGPjUzGisSr8KclTwsUvmGEq9f5XaK6gpTDP
	7jAa6wKS6IAecrCp2NXCfkvLFtFR/6g4V5Sv0Wlac8q4UKhSIcL+rP1ICwwb5zTq1vzQYBbCbL509
	vsO8S7Qhsebv2P96BEKefMwahUzTXrqHMsA7XqICKvwFwjOvvtijwflgYj+i429/DPd6hv0uVqyvh
	O8Kq89mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSU6-00000001gzY-3UXp;
	Wed, 22 Oct 2025 06:38:10 +0000
Received: from mail-japaneastazlp170100000.outbound.protection.outlook.com ([2a01:111:f403:c405::] helo=TY3P286CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSU3-00000001gz5-2eDr
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 06:38:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBQlWozZRbtvszUSstvpw9jaSvhLSbhlw4dO8bLend+PdUOABUhRA8wSdf//nFao/szbKRznd52snTocHL4nQi2WycDzV2Pf1usR5WPPfIje6KD/tI2kdqRrDsyV9Cx+6qPzh9r+LOvhshXnqV3md3Y0fYL8K+qcb6GtIUmUuyC2Wg9aE4R0eXJhU6amxl+wT8dD5FzmbOtsER74wu29292kIijb5QRNicARYnPIPENOdc+YCjVQmBpdz4S+CUn7wYb+1/EX96B5s6X2q0XucerMT61ws7AkrqdPkR8GHWjnvQxSOlIN6MZWhYxQ6EDaboDRsYPBUMRWUOGPFRUpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQi/XUsZzzuJD0V7eH64+FheXmPPaZxLOakrdXSkQ9E=;
 b=Z3hqNeBTKE6fAhsocv9kXwIUj026ThhXz6VIZYSqpE546syXP9oYXrsu044pZtbnx8CIQV0IZRLOwdN/YMf4rLIuPM094X+B19a8Rbwp+Yr1p9jENlVuTkqIhmub5bD7zyVWKUEH5yglL7K8c0CElCbnrRLXOFBHMBwSKVft3voymMuqvXO9e2N+TyOeM3ffIicRIWS3vt3bidzYF5NWyakPUTgZqL3azo6NbPTz45t0WyjpJaLFG2ag3aojEev0ovKNnm2oNjwSIXa2SLLPP0cqajwA/QpHdPRab8FCJ/OEjGukOEneEvtWTwrFkEmJg9GRN/NSSKZu+UXEDPoNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQi/XUsZzzuJD0V7eH64+FheXmPPaZxLOakrdXSkQ9E=;
 b=kh8nBoomR9FbxBvRAglO2s2G6/kQzFUpoY6BLVAZbBHQgO1sY85ZSq+CmiNe4ELeOEgwc1WW2gjWe6qs+NWQCn6G3r39DVu2h//erDE5OBM7VDM7BC8x3zZAXcHSEHFwlp9EhUyMLC9zpnsqzkkub0j/saSSHlcROEJxtgdJ3KYu+E8JunbGgYOzGW8VHfoQ2Md5OUzjPbWOkhkF6JuqLrtDPmy0oc3fhSSgEG6y4tLto9cCWUp44qk8kRcbZNcsx0GN7JA9Mlsna50BonXz96HYHAV7KDFbOEJXzHs/FBVlcwMP3MD6zXLQKXd4ezCobsc7FqNz4YkcIbQ8M9TMtQ==
Received: from TYWPR01MB7680.jpnprd01.prod.outlook.com (2603:1096:400:ec::7)
 by OS3PR01MB8858.jpnprd01.prod.outlook.com (2603:1096:604:154::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.9; Wed, 22 Oct
 2025 06:38:01 +0000
Received: from TYWPR01MB7680.jpnprd01.prod.outlook.com
 ([fe80::a702:7478:5c45:6469]) by TYWPR01MB7680.jpnprd01.prod.outlook.com
 ([fe80::a702:7478:5c45:6469%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 06:38:01 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v2][makedumpfile 04/14] dwarf_info: Fix a infinite
 recursion bug for rust symbols
Thread-Topic: [PATCH v2][makedumpfile 04/14] dwarf_info: Fix a infinite
 recursion bug for rust symbols
Thread-Index: AQHcQhBYs+a4GsJkzUO9X/R8Sc8IgrTNuLAA
Date: Wed, 22 Oct 2025 06:38:01 +0000
Message-ID: <c05710da-4807-4a98-9af7-f54ce4beb459@nec.com>
References: <20251020222410.8235-1-ltao@redhat.com>
 <20251020222410.8235-5-ltao@redhat.com>
In-Reply-To: <20251020222410.8235-5-ltao@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB7680:EE_|OS3PR01MB8858:EE_
x-ms-office365-filtering-correlation-id: d24815ca-5f1c-4e5d-d8df-08de11358bf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Y0lNMHdkb2tZQ0JPcHZCcnhGVHlIZGhuMHdXd3EzejYwMjF3b3dUc29CcnNC?=
 =?utf-8?B?RDlKQ25mamdVMUtoMnVNZ2JySkRlay9nY2sraFBLMGVRMDVQT2U0V2tzNFlP?=
 =?utf-8?B?RHp6Rk5hY3lBcnlOc2FGdS9BNmdiTzNJVk0rNjdUQlNBcjNWbmtkSnkwOVRR?=
 =?utf-8?B?Yy85akUycVZhNnJ0VWFiRjg4bGd5M1FaTk9MRlV4dmJkakxESGJOTnY1ZjdW?=
 =?utf-8?B?UlZ2dnp4VVVhMEhNWm4zQm9RaEpMVTBMNFFQUlVxbWNwZk4wR2RyZDlvL3dS?=
 =?utf-8?B?L1BXV3BpbStMM2NqclRCU294Yjh6cGEzNnNTS1R4cThaQ29tQjZUV1d4WkZx?=
 =?utf-8?B?Q2M4c0FCa0h3R0toZGR0UXJoM3RKU25MSG90dHpaSGlRZEF4bDRRMG9Ga2tu?=
 =?utf-8?B?YnpwVTRRL000cHMwWHdOVnpXS1VteWFHbXNxOHZnbGF5RkxiRTJuR0wyOTVI?=
 =?utf-8?B?NkNMaE9BKzBjRmN3OW1nbnE1azAybXkwUEFyZmNDV1Z3MlNKUVlVdVgrcGdD?=
 =?utf-8?B?Q2w1c1RXWkZleDN6Wmx0R2dvb3Vjd3ZxREVuQmZMZEloYVl4RXl0VDkvdVN3?=
 =?utf-8?B?Q1VGSmd4ZU1SRDY2UDFicC9tSnQ5T0E2N09SVlNvOFlXbmdGY2J2OG5vMi9t?=
 =?utf-8?B?dlBaY2V5SVcrUGNBSzRZM0F2eXNOU0hpV3llRmlHZno0UTgxZ1NCcHc5VFkz?=
 =?utf-8?B?bU1Zd25uaFhLc0dyL0xFZDAraElYOCtKaklRT3VHS2d3ZGJldExMN0laQVB1?=
 =?utf-8?B?b3JCbmNyRFhkZ09xUGhvdmNaVmc3TGc2ZXVEaHNmL09NWnBGN2dTNVhlVkNO?=
 =?utf-8?B?bkdORnpjZk1FeDNpYVR2bFphRWE5VWU2bCtWV0ZnTWhOZUFGcDFUM3pac1RJ?=
 =?utf-8?B?TGVkMzA2NWhWK2lncWFjQ2d0ZGpjblRzaDY3TUMxWFJjeFVENU1pMXB3RUdM?=
 =?utf-8?B?OUJJSGU4Y1NvaXUxb0pLL3hCUnMyWVdORi9OSWZlcGxrbXlsSmdQWjUyeWdr?=
 =?utf-8?B?YmdWeFFsME1FZTBzcVNnNmx1OWMxdjR0akU2QWxMYlJGMVNPc2lJR0M3bXcr?=
 =?utf-8?B?UTVRRjdGaG1oOUVac2R2eTRXNC9yNVIxdG9uZGlHMnBUbnR0NUwrMUxOTVIv?=
 =?utf-8?B?WlVJdFA5bXpIMGdKK1orSFovbkJIQ0dxM25WaGxkbWtaeE13c1ZZMmFnQkxu?=
 =?utf-8?B?b09SWmJNRGpLaFJmVjliQkJOWkNRemF0MndkOEJtSGl1OFlUaFBlREkrOHgr?=
 =?utf-8?B?NHlWemp0NVdEWExiblRtK25YQjFNZXdmQ0FKL3FSb1ZFN1FTQ0QxYUFhZTdR?=
 =?utf-8?B?MlZjVWdVeW9POEVCY1F5b0NJL3BSamJVYnZJc1ZpM1dJZ3pSVDNIVWZpaGVK?=
 =?utf-8?B?MjZ5YjhuYTFZM3p6RXBCR0pncUJya1dKSmJ2SVk3N1RUbkZONFJWM2FLTWFr?=
 =?utf-8?B?NkdrRHBNVUthMktoeUZLK2oxbDVZOXNFQ2Y1Y1ZMZDFlSDduQm5WNHZhUDdv?=
 =?utf-8?B?YmFEUlo4WnFCcjZkQVA1Wm1FL29RbXFJSERQWis1YzlQemlta211QXQraUxP?=
 =?utf-8?B?VW1kQTZOLzJSREg3RE15WVlOc3VGdXFnTFlXV3VjOFVaMjdhMjEvTUQxSFds?=
 =?utf-8?B?L0FrOUN0d0RxSmJ3M2syOFZaeVp2allramlxOUsxa2NvOTY2OUk1RjhocW02?=
 =?utf-8?B?VURxNTQ3TytJTDJ5UzUwMklCL0Jsa0NjbUI1WWE3dllTbzRLS25pWGFOTGhh?=
 =?utf-8?B?T1dDZHBZd1lpd2lCeXc0UmRHMytXSk1UR3p0UjNMOTExRmJMS1QzOHlkNlRs?=
 =?utf-8?B?VjMwOTRKOWJyVkdrbXIwS09QMklPQTJnTGZNZFNUeGZURloraG4ybEg5b3RR?=
 =?utf-8?B?bUdvSHJhZjA0OTZKMTBNQ3RqOXhLUzNIWHZvQzFaaVkxOEsySW9VWFlsaURG?=
 =?utf-8?B?d3hpU1E1STl2MVZEZXcvbXB5ZThONVNLUDIwVHdPdThMR2xxa3RJaGJRK1kz?=
 =?utf-8?B?c3BrQkpWOXRaanRxTi9GTVc1TUl3VG1OWUlMeXRuVDZ0S0lMSzJCVUhTRkJo?=
 =?utf-8?Q?G0TfLu?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB7680.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjRmY3c3ektzOHVQK2JrdUVoQ084RDNsSmswck11aXFwZGl2TnZmeTB5eU1l?=
 =?utf-8?B?eFduNXdudVVNSFhDcmorQmduSTdYWTZIZFVyNmsrUlo2Q1I2YzQzMWJyWjRa?=
 =?utf-8?B?UFlySjJSaGVMaTB2T295SjdyZGR2RFN3c09OdVc5NXh5Z25MUTI0Mkt2bHBu?=
 =?utf-8?B?VmxMam4wWkxVck1zQmhZcGlsVSt5Y3N0bmRNSldzekx2QTlhQlVLTFl2S3ox?=
 =?utf-8?B?eFpjS1YxbGIwTmd0ZDUwR1JuTzRBRWkzVmRERkR5bGFvUzdRM1FHajZSVWIx?=
 =?utf-8?B?eVpneExlQUIvWmpWMkhMOHpHcTV6anovZnd1Q3hBUkV2dzd3R3JWM3I2bi9h?=
 =?utf-8?B?MnVkUDMzSnVCb2xBWVdLMU9vTHdXMHFJem5NS0piUFR1N1pSRVRTRjA4Z0RK?=
 =?utf-8?B?dzI1ZE9GZldBRzc0Ni9WcndscW1MR2xrYWlwcVFxQlNQeWMwcVBJa0k0KzJL?=
 =?utf-8?B?SnEyKzhIWDg4emdNd1dTZWM5Yk5ES20yRUw4RXZYVVZEbkZ1SGJnb2VrZDE1?=
 =?utf-8?B?MmgxWVYyVEN1bk94VTZJaEJWTGhBVk9maTRDN005bXNRRDFyOGRhSGxnV0RO?=
 =?utf-8?B?SU05ZFd5ZlBacU1XTUdwT2F2NWdRdC9YeTFXZUVMWnh4L2dzRjBNQmFqWkVo?=
 =?utf-8?B?UDFUUFhkbzg1RmkzZG1JZnZQNDBEZ0FjQ1Z0eXc2d2J6cXI0UEhNSjdhRzNm?=
 =?utf-8?B?WGRYdlhjeXFpQVhJR0hNRlpTYzhCS0l3cWljUzY2bWg4cmlIbUZRSWNwa2ly?=
 =?utf-8?B?WkNtdzNERkY3WlRtR2oxb3pyNU5ZUC9OZFlzOWgzQlFJZU04c2FMeklISFdz?=
 =?utf-8?B?R1d1MGtnTzN0M3pPcHlsTVRWUlYrT2Jra29ldWVldVlOYi91V2diOTBFM1ph?=
 =?utf-8?B?ZXg2a3V0L3h5TkJEOXlNbXR3QkkzbC9ydE9xYUx6cStJYXoyNVlmMkFmbjRP?=
 =?utf-8?B?Y01uZ3ZIQ1RrNW1MUGVUQmxNV2VZdko1a2VlbHdLTEJ3WDdSOE9jMVl6bHky?=
 =?utf-8?B?TlN5TC92SkdYQVVLZW04a2ZQdGt3ditZOWtRdStVNStMelU2TzNuTjdIZWR1?=
 =?utf-8?B?cjRWZmxSWnRVYjloK2s4MTJ2SDdyY1Q1S0RKdllFUFJHaEl3ZjdROFRWNHFG?=
 =?utf-8?B?dGNsSmxJNkpuWkh2OUUrY0g0QTlOZFkyWGN6aS9mVmRpVjZwUW5idmlTNkds?=
 =?utf-8?B?dCsrdUpXSHdwN0xrdHhDR0tvclBXeFUyZ25HU2tCVFMvdFhtSHlZTWR4WVIz?=
 =?utf-8?B?Qi9VSDJjVnRPcXQ2SXltbVQ1MXoyRWFhWUJ6VGxLOC9pMWYyQXZ2Nk85M2pK?=
 =?utf-8?B?Vm9uWTlpVFA4UHhvdkI5N3RwTHJwODZESllMWi9XTjJXcWQxdnhLVGJyRnB3?=
 =?utf-8?B?bGFBSiszZldNaC9aMGxOYlphQytNY0dleHNYV0YxbGhUalZEOWgydXJMcDEx?=
 =?utf-8?B?KzZ0ZnVrSUtpRW5pSG5rWnlEQ1hEZTlUZXJLMFFTMU9aL1hXZWJEazdmWHh3?=
 =?utf-8?B?MTdmb0I3VU5pTlUyc1NySmVrMUwzR0oxS0liN290WHBMNFltMytNTjdySzE1?=
 =?utf-8?B?bkVER0pYNzlMWWQ2NEx6SVIyYnhvQmR3b1lTWlRyUEh0MkUzYmhscnBRdzZZ?=
 =?utf-8?B?Q1FjeE13WUNVVXV0SzVjbERZcjhvaCtQdENFSE1lVFFFQUlLcmJXUzh0YWk3?=
 =?utf-8?B?UFdHYnUxblhCMnRNZks4bWpkd0RHNE5SZS90amFqSHhwdW02eG1VZmhobk03?=
 =?utf-8?B?bWRoVGJ4NVlqT2VPR0Q5eCtzRUhoWER3Y2IvQlFDbzVxdmxKNjdnUWNVa2Nk?=
 =?utf-8?B?RFdIaDB2a3ZFbVRReTVqazZES2lVZnpZTmlWL2d6d1Y0dmUvTTk4TkUvcjcw?=
 =?utf-8?B?VHdpd051UDdGU2krc1FVUVlBbzJCVUxqZ3h2eUdzeG9HMWpkVlRTN0tNZFhy?=
 =?utf-8?B?S25vVVNkOHVnMWlTdTMwZWdkaUtKRVIrYVhFSHdCYXo4bGE2TkxxT1VIeWdv?=
 =?utf-8?B?VERzUWgrdHByT1ZUNjluMm02a3JZb25aNk95TmsxZnZ3SnQxamNmaEhIVWs1?=
 =?utf-8?B?UlhMV0gvcThrOVl6VGMrZ0FvT2owTUtVTktqTzhKOUd4MkpHTDczb2hCZUtJ?=
 =?utf-8?Q?IJw7Id3J78MEAxk30+XXy3v/2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35C4A3A24FA0F94FB35114330D357FD1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB7680.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24815ca-5f1c-4e5d-d8df-08de11358bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 06:38:01.1506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B02x6Vm3QzXnC+9RnqCfzmKiMM0aB7cMEattUWUuqepf2LADxRt8J/Npt4FM6O6se6HO4X0j2oPmFr2u6kgLLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8858
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_233807_680746_5D45A0E2 
X-CRM114-Status: GOOD (  19.61  )
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

T24gMjAyNS8xMC8yMSA3OjI0LCBUYW8gTGl1IHdyb3RlOg0KPiBUaGVyZSBpcyBhbiBpbmZpbml0
ZSByZWN1cnNpb24gYnVnIG5vdGljZWQgaW4gcnVzdCBzeW1ib2xzLiBUaGUgcm9vdCBjYXVzZSBp
cw0KPiB1bmNsZWFyIHRvIG1lLiBUaGlzIHBhdGNoIHdpbGwgYXZvaWQgdGhlIGJ1ZyBieSBza2lw
IHRoZSBydXN0DQo+IENvbXBpbGVVbml0cywgc2luY2UgY3VycmVudGx5IHdlIGRvbid0IG5lZWQg
dG8gZGVhbCB3aXRoIHJ1c3Qgc3ltYm9scy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRhbyBMaXUg
PGx0YW9AcmVkaGF0LmNvbT4NCj4gU3VnZ2VzdGVkLWJ5OiBLYXp1aGl0byBIYWdpbyA8ay1oYWdp
by1hYkBuZWMuY29tPg0KDQpGb3IgYXBwbHlpbmcgdGhpcyAwNC8xNCBwYXRjaCBzZXBhcmF0ZWx5
IGJlZm9yZSB0aGUgMS43LjggcmVsZWFzZSwgd2l0aA0KYWRkaW5nIHRoZSBmb2xsb3dpbmcgbm90
ZSB0byB0aGUgbWFuIHBhZ2U6DQoNCi0tLSBhL21ha2VkdW1wZmlsZS44LmluDQorKysgYi9tYWtl
ZHVtcGZpbGUuOC5pbg0KQEAgLTgwLDYgKzgwLDcgQEAgbmVzdGVkIGxvb3BzIHRvIHRyYXZlcnNl
IGFuZCBlcmFzZSBrZXJuZWwgZGF0YS4gLS1lcHBpYyByZXF1aXJlcw0KICBjYW4gYmUgYnVpbHQg
ZnJvbSBtYWtlZHVtcGZpbGUgc291cmNlLiBSZWZlciB0bw0KICBcZkJodHRwOi8vY29kZS5nb29n
bGUuY29tL3AvZXBwaWMvXGZSIHRvIGJ1aWxkIGVwcGljIGxpYnJhcnkgXGZCbGliZXBwaWMuYVxm
Ug0KICBhbmQgZm9yIG1vcmUgaW5mb3JtYXRpb24gb24gd3JpdGluZyBlcHBpYyBtYWNyb3MuDQor
Tk9URTogY3VycmVudGx5IFJ1c3QgaXMgbm90IHN1cHBvcnRlZCBpbiB0aGlzIGZ1bmN0aW9uLg0K
ICAuUFANCiAgVG8gYW5hbHl6ZSB0aGUgZmlyc3Qga2VybmVsJ3MgbWVtb3J5IHVzYWdlLCBtYWtl
ZHVtcGZpbGUgY2FuIHJlZmVyIHRvDQogIFxmSVZNQ09SRUlORk9cZlIgaW5zdGVhZCBvZiBcZklW
TUxJTlVYXGZSLiBcZklWTUNPUkVJTkZPXGZSIGNvbnRhaW5zIHRoZSBmaXJzdA0KDQoNCkFja2Vk
LWJ5OiBLYXp1aGl0byBIYWdpbyA8ay1oYWdpby1hYkBuZWMuY29tPg0KDQpUaGFua3MsDQpLYXp1
DQoNCj4gLS0tDQo+ICAgZHdhcmZfaW5mby5jIHwgNyArKysrKysrDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2R3YXJmX2luZm8uYyBiL2R3
YXJmX2luZm8uYw0KPiBpbmRleCBhM2EyZmQ2Li4xNGNmN2NhIDEwMDY0NA0KPiAtLS0gYS9kd2Fy
Zl9pbmZvLmMNCj4gKysrIGIvZHdhcmZfaW5mby5jDQo+IEBAIC0xMDA3LDYgKzEwMDcsMTMgQEAg
Z2V0X2RlYnVnX2luZm8odm9pZCkNCj4gICAJCQlFUlJNU0coIkNhbid0IGdldCBDVSBkaWUuXG4i
KTsNCj4gICAJCQlnb3RvIG91dDsNCj4gICAJCX0NCj4gKw0KPiArCQkvKiBOT1RFOiBjdXJyZW50
bHkgUnVzdCBpcyBub3Qgc3VwcG9ydGVkLiAqLw0KPiArCQlpZiAoZHdhcmZfc3JjbGFuZygmY3Vf
ZGllKSA9PSBEV19MQU5HX1J1c3QpIHsNCj4gKwkJCW9mZiA9IG5leHRfb2ZmOw0KPiArCQkJY29u
dGludWU7DQo+ICsJCX0NCj4gKw0KPiAgIAkJc2VhcmNoX2RpZV90cmVlKCZjdV9kaWUsICZmb3Vu
ZCk7DQo+ICAgCQlpZiAoZm91bmQpDQo+ICAgCQkJYnJlYWs7

