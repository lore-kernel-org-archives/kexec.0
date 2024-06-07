Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D932BC27C55
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 06:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r/Pk/xGRa+k4x90qOGU00EeQ7YBrCjJ1RXumoVlaR+c=; b=IrINHNNfciDFyR
	HjdjXs8oeSJJ4j2X+jMPhZJQY445FYpByrjSK/q8PIhwSsHo1tGylOjQV5WSCCWuxKR6FeT5tinGd
	FOWlc1x5EfzRYAr7uITRZMkkTIYR30wvx0HC0WP0rYL9wZ0ujZSBJp6PZTEospl7q42GojxF4959q
	AOEWV5rTr/gwrkDQJzqNiRUhBn3ARm4/ROBe5VfvwAc92Qvr9XUHjODrkd4cWiReLq3kD78J44whG
	fCwEuPoHslASQ0poeIJEMS14WbFm/P0Jv4np+e0ITfZVqE2MvdS05xSvTxmODKYEx6RjxUWdajZBB
	E2rnUrclvx9dfX4ovvWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFTB9-0000000CiwS-2MJ5;
	Fri, 07 Jun 2024 06:34:23 +0000
Received: from mail-os0jpn01on20625.outbound.protection.outlook.com ([2a01:111:f403:201a::625] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFTB5-0000000Civ1-4AWw
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 06:34:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBA9gWqWZsgcgvPPVVJKIQ8EwjUPV8IkWQNV7uI2Wmh5xm89EVPDHcP/J8wsvKTn6wvDeZKaXSLLUYghURA/jYgXMF99rt/tg4D1ZxaljL17sbED3IE2jskRDBSOsY1sHSY04qf2pEDK62OmAOOAVBuMIUAoAUuaf67zHyqmgzJjM/aY7yfKbbezYaQM6k0FwJLWum1Zrc7FwA4axcIGCUoraUNFdU/5ubZVkX88RnTiormD1TBKG955s01FP7z3ftYWt/5j0AL/HRpiDHLdSPrdGxLenllQws+MTskcaQlePOxU6zKhPQKWDlZgaCAZdsE4ZqzL2R+VK2p8BuVdTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2e/HL0OyBVb5jFWmD3eVwrnPMfW6tCkMBNAe+RsaXIk=;
 b=krho3RHGun2Gc5+jTRW8cGGLv8KcGseHhomnhvbxEO9UuKNaiEBjc0Roy6c27cytBIKNk/wmeh01B0Z0jGdf8I9vH9Qh9xOaXWxDcEx6Qn3ut22H/UibV/Y82IgR87fbYfRINWmjFDbteYhFPwf/qVlGDHl6f0f/VjVvN2h/UkFMPNcDy6Tpp/ye2CNpF1eTp377GymuzPbRIWkZE/N6jG7WLFRn9awERc2Pqqa7k6jf/V1++QCxRoLDeOVrHK55NfK8Mr7N5+CUm2+WyKa6n9gyLu0fWd+prPLHcdoK4CbIbLkF2OAj+3tg0+sdBzxJ7TskdiMNlOmSw2NnEQ/XBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2e/HL0OyBVb5jFWmD3eVwrnPMfW6tCkMBNAe+RsaXIk=;
 b=rJBAFaQHp+5uYlRq3S8qesQ4uLdRtrJcyYYyAEz2RYjSnr6Dn0ARSge69AE4uolBwYBuiRcW5ZR8qyn2Toro39peY1V8ZeWZVw0nhEbMXhAQ00N2vIuJBI+xnGwvoIPlbTQH/j4988aFS2BiVl8Tj9LFtYZfjK66KepCcKHxI1tJlXQcf+4aUcm23yH/jOCOGT6fLOcLhhEpNwhVwtQtTiCcdABjrl+Y/ZudWSzFUAStkzbGrUKVT1c1v4BK7aK+rMNbDQ6ug8wrNkN8Zyvuidhk6Qu/zl4VWn7taeB4xFUIYoeOTJNJI6mPqQFtQgU6AqGbCOFwVE1nZyh/S30cMA==
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 (2603:1096:400:3a5::14) by TYCPR01MB8549.jpnprd01.prod.outlook.com
 (2603:1096:400:154::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 06:34:06 +0000
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c]) by TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 06:34:06 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
	<k-hagio-ab@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC: =?iso-2022-jp?B?WUFNQVpBS0kgTUFTQU1JVFNVKBskQjszOmohIT8/OHcbKEIp?=
	<yamazaki-msmt@nec.com>
Subject: [PATCH 2/2 makedumpfile] Fix wrong exclusion of Slab pages on Linux
 6.10-rc1 and later
Thread-Topic: [PATCH 2/2 makedumpfile] Fix wrong exclusion of Slab pages on
 Linux 6.10-rc1 and later
Thread-Index: AQHauKSxpq/YPA+zKUeEOuU9OWvP+w==
Date: Fri, 7 Jun 2024 06:34:05 +0000
Message-ID: <1717742044-27933-1-git-send-email-k-hagio-ab@nec.com>
References: <1717055930-23334-1-git-send-email-k-hagio-ab@nec.com>
In-Reply-To: <1717055930-23334-1-git-send-email-k-hagio-ab@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.8.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10963:EE_|TYCPR01MB8549:EE_
x-ms-office365-filtering-correlation-id: b6a6e0b4-673b-4729-5d46-08dc86bbd462
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?iso-2022-jp?B?NVJEUTNxZFExWCtaQmEya0VSeGhDT1ErOUsyeG9RMU42Q1R5WFIxd1hN?=
 =?iso-2022-jp?B?Vnp3aDhTOURtMW1SdHpPVmhqeDhwT1VUMVVVeDhDaitZdHFmUlRWV0gx?=
 =?iso-2022-jp?B?dE56VkFWYnA1S2VhbjVjcUZBRXVIN0s2NVB3ZjExWnVuaGJHajlUdy9K?=
 =?iso-2022-jp?B?RzZGZDlOVVZMcEUySE1tRDJJbTlaUUllUmhaUUZqdVFBWm5GcUZ3eUJW?=
 =?iso-2022-jp?B?c1FJaXMyNGRSYld5VnFVZUZYbkJqcWxaTkNpaXlyaDA2eXNjTjZXeTA5?=
 =?iso-2022-jp?B?SFZrelRRVUhzZG4vWXo4NjFTRzdVREZPR3FRZXlEVVE4OUZPT2RKQ0F0?=
 =?iso-2022-jp?B?aFhMbzZqc2VVWjEwTHpBOGZJMjFaY1NYYlBvTkNPZFRDemFPQXlLeGtL?=
 =?iso-2022-jp?B?OGNPdU41UUYwb041eTE4dVcyc2xjSWVza2Fpckg1MjNBWXN0MXNxckdx?=
 =?iso-2022-jp?B?MGlFclpXT3VVb1d6RlJZbzMzbGR1WXhVQkUvMk5LYmpmd1dpY3J4WnMx?=
 =?iso-2022-jp?B?M3BLWFJxV0w1SGo4WVRUajBEQ3FuSWY1MjAzVFJKOE9lbDhIKzlhYUc4?=
 =?iso-2022-jp?B?akxZbzJpSkZwb3BpUVF2bm11bWljaFF1MkRDWWFkYVdRaUNPcjJSR3NI?=
 =?iso-2022-jp?B?S3RUWHFIRGMwa1NtTzgvZ3BmRkYzcWtKTS9MY05haTNwdTFDUk42bHlZ?=
 =?iso-2022-jp?B?QURRa0p4OE15SU16b3F4YVA2U0x4RU56b3BEUUNtNHRiTnRLcWZGS1cr?=
 =?iso-2022-jp?B?d2ZFWEl6RnQxWllya09XRjdyU2RLV2NZYW9LMlI0VEJObXJaTUZiUXg1?=
 =?iso-2022-jp?B?N3AxTkVWbXBMZzdva3FzWnRZOStsblk4VDFWQThwcU5HSjJ0Ny9uUUx3?=
 =?iso-2022-jp?B?WWhSTFlnalZ4RGNOemJ1YmcySVVQaDRWY1cxVzJyT0JPUUJBL1JlMzA3?=
 =?iso-2022-jp?B?c005TFQ1cndPOGJ6UlV3c0wwd0hVeVVBb0VSaGkxRlBTb2w5ODh6VDJD?=
 =?iso-2022-jp?B?ZHBHUThkN2l1SGJXY0JURE85KzRZNU9IVTI3bkhFZVVtU0Ezckxab0xP?=
 =?iso-2022-jp?B?ZGYwUCtxR1RnQTRuZGhGZy9OaUp0a1ptYS93djdWckFyZEZSbkM1c1Yv?=
 =?iso-2022-jp?B?RGs0dHJVMmxxeFpwY2dPb0RUMmkvajVzclJ1SEVOZkVlekQ4WDBUdUlK?=
 =?iso-2022-jp?B?REZZa29MYWJad2p2Q1R4b1ZLVmExM1NNbEdmbzB4a1VTNzZNaWlvYkIy?=
 =?iso-2022-jp?B?Q1Y5ckZMSkFDUHdVcjZ3d2JSOUNGRTgzbFBWUDZiN1RRYktKVXd0cUtJ?=
 =?iso-2022-jp?B?VXRRWG9ZZzc0am5RVi9icUJiaFB6S0F0S2pwMFRIT2tITjJmbnhURmJR?=
 =?iso-2022-jp?B?T1dLVmoxeUxXVHNnbmR1VkJkckhCcGROUHZ6NS81elJJMnZCVWpocFlH?=
 =?iso-2022-jp?B?aGZVdU9vZS9ySjVvZ250SWREMXM3SmxFNzgrbXRydGtSN2pQeGtTMEtS?=
 =?iso-2022-jp?B?enhPR2lkNGliLzZNaUpjUUZpZi9jYmtkckpyRWU0OVFvS210cGdvWDZo?=
 =?iso-2022-jp?B?eFBCY2FROW1FdFBmUVZEU2l3UmRsR2NYaWtsb09mQVh5bno1MFByekNm?=
 =?iso-2022-jp?B?cjhvSUNGS1VOOGxQbUtIQkhUY3liQW9oL3NEb1dZM1lqUmZvVlNoMlZO?=
 =?iso-2022-jp?B?cDhCdDVRd1BsbTI4aEhKbVh0ajRGY1BFN3NLZ3hKYjdZRWY0MU9nOHJS?=
 =?iso-2022-jp?B?elZEVTlEbnJJeDFQYkpiZU9WVzhsNkp4NWRiMDlIekRHaC8vR0p6RWNU?=
 =?iso-2022-jp?B?OXNDK1ZsNFBFVnBhd0Fnb3JwWVFwc1Rxbm1HTmEvY0szQ0xuRVhPKzVP?=
 =?iso-2022-jp?B?dW9nRDR1UmxtUk12R1hWa0dEQU8ybFJzYmxnYlBjKzZDd0xTeUdMa0h5?=
 =?iso-2022-jp?B?RjdiTzdkdHJNcjZXVk1QS3hiSXhTV0pCZVlWV3lKYmVpcHVxMUZkSzhR?=
 =?iso-2022-jp?B?RT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10963.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?a0VnZ0I5WUtydFRKb1Z2SmVyeUlRZnZUVWIwT1Rsdmg0bjFqQlFnaU5y?=
 =?iso-2022-jp?B?a1Z0SWNtL3RFWmp0Y1NzYW9EK2hmU3dvcFJncngyK1Exb2huZFJVSW9y?=
 =?iso-2022-jp?B?cW1QWit0c3c5UCsyQ0tFTVFrQm9majFYYXlmYTZRV2xmQ3NYQU94RFdZ?=
 =?iso-2022-jp?B?SmZWTG1BdHF2UnJENXRZUjdRd0hnQzAyTDFLeEZGVzhkWmx1djUxWjJn?=
 =?iso-2022-jp?B?eWdMZG9obVdMWU4veS9QSS9PdWtHRHJHbjRYYk5YQzR0SytOOFl0d0JP?=
 =?iso-2022-jp?B?UTE0ZjJGOWxjUlVRemo2WEJnRUZabldNbEVJZ3ozakZrT1cvVVR1N0Zs?=
 =?iso-2022-jp?B?NWpBNHUxTktPOXdzZWtWckd2a2RkVkEwTmhqbkZvaml0V1BsR3g1cFQy?=
 =?iso-2022-jp?B?MHJKMnpId3dxdjhFMDErVFNUU0ppbTJ0NEg3ZUpYdzd5UFB2Wlo1a3dH?=
 =?iso-2022-jp?B?QlRoYzFwdjZod3VwekV3N1VXU0Zla2dCekZKOTJ1M29CUktVNDRLanIv?=
 =?iso-2022-jp?B?djJlQVQ0K0ZtZGs4WmdnSmRqdDJhMC9xTkV2dlhZTUt5MC9oQTFKRTJL?=
 =?iso-2022-jp?B?STZJMWp6YWQyQ0daREdwOWg0dVo4c0ZQNjF4QjlLb01PUkRBaXZ2VHhK?=
 =?iso-2022-jp?B?eXROK1F2bjhRZUZMSUo0Y1BwTjFHNUY4UTR4YmdRdUtoai80YkpUOCs3?=
 =?iso-2022-jp?B?eGpHTnArOTlOTENwRnZsMXdWemlQLzRndEd4UE1GRHhOck50ckNTUGY5?=
 =?iso-2022-jp?B?NTBmWjRYMk5JNEdUMnJxZ1p4MHFoT0dLWGJFYjVsNXhMbWt4dlU0dzN5?=
 =?iso-2022-jp?B?R01iOVJmSEpQMDZ3NzQvdExmanJqc3JvcEJneGlJSDd4OUVwb3pBTXVl?=
 =?iso-2022-jp?B?NWsrMElXTVEwM1N5aWNMR3RlT2xHRUc4eGdkZ094RmV4b3M3Z25GNHlp?=
 =?iso-2022-jp?B?bFRxckcwNk1YVnorNUxiUmJvaisvc29QdFhrUnhXdkJKVVQxc3BUeUZL?=
 =?iso-2022-jp?B?aytaYkJnd05lcnJxdjNXNHVrNWdBYmxxK3pDcUcwM3dOdXRQRjRqdkxC?=
 =?iso-2022-jp?B?bzQ4ckxHVmdXQjd2RVljS3M2MGdZYXRnT0I4U2lLOTNrN1JxQy85NWJN?=
 =?iso-2022-jp?B?bXhudnpNUGdLMFdiY2MzaDE0aFJpc0I2VnFrNnhCRWxnWWIwY1o2ZWlW?=
 =?iso-2022-jp?B?R1FaZS9WYlBsMVpRbUpkWnh1QTRRb0kxaVdJeGtFaXhTblV4NGFGaHlD?=
 =?iso-2022-jp?B?U3U0dlR5TDhFUUsrdHlBdFExc3dXNGVVTzQ2cmVldGQrb0Mxcnh0TmlF?=
 =?iso-2022-jp?B?WEgzcmVEZW0wWjUvakNFNDdvT2EyVmd3eFI3dU1qczVOZFBsR1Y0dG54?=
 =?iso-2022-jp?B?d3Q1TWEwaGNmaXUxbFN3SmpLSUlWRTc5c2ZSeEdRYWJLNW90VnJMZ2di?=
 =?iso-2022-jp?B?ZHVPeVBGZXBLR0hucjZieG1xMm05U1U3NjF6MW84SnU2ZEJOczF5R2tB?=
 =?iso-2022-jp?B?T2VQTDVtRUo2eng5dXgvK0llcWtjV3BTeDZpNkJQTjdHY3hpR3E4QnZx?=
 =?iso-2022-jp?B?czNmVmg0SnpsQVNTRzk3eFdmN3hqeW14akkxUGV5YjJ1WENmTXYra1dr?=
 =?iso-2022-jp?B?Q2pUemFjd2YwWE11SlZGcW5sRHR2UlFxaForSm1XMmdBajF0dkRVZmJC?=
 =?iso-2022-jp?B?WGFMTlVqVGw3RmdCcW9pQndQQWZOdGdDSUhSZDM0UHptdFlZS3RnUzNk?=
 =?iso-2022-jp?B?aGZPazNRNFVSeWtWUFQ5YnNCRHNNamNIaG5zWXBUNlNsc1Z5VXZxeWk0?=
 =?iso-2022-jp?B?bHdoeXcvclIzOC9nNFFWRGl1WEVSdDBKcmc1MGtndXIxNkNFMXZmSkxU?=
 =?iso-2022-jp?B?VTF1Mko1UEIyNXdjV3FrcndHMmp0cDMwam1wekNRRmNVT1FTMU9MT2dB?=
 =?iso-2022-jp?B?WWxvNFExOVhhN28xWGxvRmFtbEtXdk5wTmlUMjNRMTFTcjRlci9VRTI0?=
 =?iso-2022-jp?B?dzhBVG1wb3RFQ09oTUgyMTkvYmhEYkRaeHBUSmlKMUp0aWtkUXp5V3pC?=
 =?iso-2022-jp?B?Zm5ranNHdkxKdmlmN2hOVjdUSC9CTGI0bnNERDFXNUpaZzZKMC9kQ2Yz?=
 =?iso-2022-jp?B?UDB1L3ZBTWhuTEZMeVFyM2xtcWNuVi8rY3Q2SzRFMzJqK08xVDNCU0JZ?=
 =?iso-2022-jp?B?V3Y3ZEV4TjJRcy9rOUkwM2N1L2lYSHFNQi9IWnk4a1BER0hDS2VsUWxi?=
 =?iso-2022-jp?B?aXhJeCtwd0JWcjBzamFnMy9RTEpQRE1qaG1PL1dHakRtSTI0NndEWG1k?=
 =?iso-2022-jp?B?TFVhbQ==?=
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10963.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a6e0b4-673b-4729-5d46-08dc86bbd462
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 06:34:05.9823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2gE1VSWJtTh1RbxTp7bGU0ES4tOsP8bD0t1IErdQWjEkztSGin9BsvtTa8sETNYJDf5WOOOh632GAvqhjOiHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8549
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_233420_705131_C96ABCE3 
X-CRM114-Status: GOOD (  14.72  )
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

* Required for kernel 6.10

Kernel commit 46df8e73a4a3 ("mm: free up PG_slab") moved the PG_slab
flag from page.flags into page._mapcount (slab.__page_type), and
introduced NUMBER(PAGE_SLAB_MAPCOUNT_VALUE) entry into vmcoreinfo.

Without the patch, "makedumpfile -d 8" option wrongly excludes Slab
pages and crash cannot open the dumpfile with an error like this:

  $ crash --kaslr auto vmlinux dumpfile
  ...
  please wait... (gathering task table data)
  crash: page excluded: kernel virtual address: ffff909980440270 type: "xa_node.slots[off]"

Signed-off-by: Kazuhito Hagio <k-hagio-ab@nec.com>
---
NOTE: This patch can be applied on top of "[PATCH makedumpfile] Fix
failure of hugetlb pages exclusion on Linux 6.9 and later".

 makedumpfile.c | 24 +++++++++++++++++++-----
 makedumpfile.h |  6 +++---
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index a6cadc9..cc39f73 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -275,13 +275,26 @@ isHugetlb(unsigned long dtor)
 		   && (SYMBOL(free_huge_page) == dtor));
 }
 
+static inline int
+isSlab(unsigned long flags, unsigned int _mapcount)
+{
+	/* Linux 6.10 and later */
+	if (NUMBER(PAGE_SLAB_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
+		unsigned int PG_slab = ~NUMBER(PAGE_SLAB_MAPCOUNT_VALUE);
+		if ((_mapcount & (PAGE_TYPE_BASE | PG_slab)) == PAGE_TYPE_BASE)
+			return TRUE;
+	}
+
+	return flags & (1UL << NUMBER(PG_slab));
+}
+
 static int
 isOffline(unsigned long flags, unsigned int _mapcount)
 {
 	if (NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE) == NOT_FOUND_NUMBER)
 		return FALSE;
 
-	if (flags & (1UL << NUMBER(PG_slab)))
+	if (isSlab(flags, _mapcount))
 		return FALSE;
 
 	if (_mapcount == (int)NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE))
@@ -2977,6 +2990,7 @@ read_vmcoreinfo(void)
 	READ_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
 	READ_NUMBER("PAGE_HUGETLB_MAPCOUNT_VALUE", PAGE_HUGETLB_MAPCOUNT_VALUE);
 	READ_NUMBER("PAGE_OFFLINE_MAPCOUNT_VALUE", PAGE_OFFLINE_MAPCOUNT_VALUE);
+	READ_NUMBER("PAGE_SLAB_MAPCOUNT_VALUE", PAGE_SLAB_MAPCOUNT_VALUE);
 	READ_NUMBER("phys_base", phys_base);
 	READ_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
 
@@ -6043,7 +6057,7 @@ static int
 page_is_buddy_v3(unsigned long flags, unsigned int _mapcount,
 			unsigned long private, unsigned int _count)
 {
-	if (flags & (1UL << NUMBER(PG_slab)))
+	if (isSlab(flags, _mapcount))
 		return FALSE;
 
 	if (_mapcount == (int)NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE))
@@ -6618,7 +6632,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_CACHE)
 		    && is_cache_page(flags)
-		    && !isPrivate(flags) && !isAnon(mapping, flags)) {
+		    && !isPrivate(flags) && !isAnon(mapping, flags, _mapcount)) {
 			pfn_counter = &pfn_cache;
 		}
 		/*
@@ -6626,7 +6640,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_CACHE_PRI)
 		    && is_cache_page(flags)
-		    && !isAnon(mapping, flags)) {
+		    && !isAnon(mapping, flags, _mapcount)) {
 			if (isPrivate(flags))
 				pfn_counter = &pfn_cache_private;
 			else
@@ -6638,7 +6652,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		 *  - hugetlbfs pages
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
-			 && (isAnon(mapping, flags) || isHugetlb(compound_dtor))) {
+			 && (isAnon(mapping, flags, _mapcount) || isHugetlb(compound_dtor))) {
 			pfn_counter = &pfn_user;
 		}
 		/*
diff --git a/makedumpfile.h b/makedumpfile.h
index f08c49f..6b43a8b 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -161,9 +161,8 @@ test_bit(int nr, unsigned long addr)
 #define isSwapBacked(flags)	test_bit(NUMBER(PG_swapbacked), flags)
 #define isHWPOISON(flags)	(test_bit(NUMBER(PG_hwpoison), flags) \
 				&& (NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER))
-#define isSlab(flags)		test_bit(NUMBER(PG_slab), flags)
-#define isAnon(mapping, flags)	(((unsigned long)mapping & PAGE_MAPPING_ANON) != 0 \
-				&& !isSlab(flags))
+#define isAnon(mapping, flags, _mapcount) \
+	(((unsigned long)mapping & PAGE_MAPPING_ANON) != 0 && !isSlab(flags, _mapcount))
 
 #define PAGE_TYPE_BASE		(0xf0000000)
 
@@ -2259,6 +2258,7 @@ struct number_table {
 	long	PAGE_BUDDY_MAPCOUNT_VALUE;
 	long	PAGE_HUGETLB_MAPCOUNT_VALUE;
 	long	PAGE_OFFLINE_MAPCOUNT_VALUE;
+	long	PAGE_SLAB_MAPCOUNT_VALUE;
 	long	SECTION_SIZE_BITS;
 	long	MAX_PHYSMEM_BITS;
 	long    HUGETLB_PAGE_DTOR;
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
