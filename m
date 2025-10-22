Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6DFCCD1AB
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 06:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OTX8qF60uo2K3XLXHsOW5iJoPqE+7R2rzX8ocqqhVDM=; b=i23KvRgKJYVOZ+N08vonrsHDI1
	vGCSq+EPhg9y/MBMYInjZje7EOWfJ7bQP0le6IIzoRIHHK7KErvHHjKj2R0lxHxvgaxcOjtbSfNNZ
	EPqiKtLYVg19/tZQXiyASha06kn3dUZ6DuxhyhqciHezf5c7wCKLovVWKGIlVYNeG3n2i70nSmEUH
	vYRFXrPsf1VM3SSo3Ha9k4zWY/vIQkELIxVqkmnYq6q64o12330iKDUcnzMcKZsV5LD893FYUNtok
	GcdsDN364QXAoTVXQPlQNGiLtpONrk31rwxe4Yn5R3pCvabnA5PYaRE+yJp4LqcAbt9SDI53vNR9k
	9B5Pll3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSTS-00000001gob-286m;
	Wed, 22 Oct 2025 06:37:30 +0000
Received: from mail-japanwestazon11010022.outbound.protection.outlook.com ([52.101.228.22] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSTO-00000001gm1-0lm1
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 06:37:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnR8iKeGfsVUIsMpxsgkLQPJw+yQAVE5tBtxnpcXxIzfF2AHvppjY5iEvyf5ZS7vpD/OV6euP7RA9+Q7afjBamCE8TmNC96UiTntzJNT6R+PHALdpfl93Ioe142yvABE352Nf80I2qXXDYogGklSBcuLH2HrBPW2Pyy2I/uM0/YQ5HDZ9uMlcUjR76KQgk5WJzv6I1HtBPM6RwKMmgtOYUawZMUmUnh5YtN6mILhJAlemLTsldyO6ZLVLjfs6xOYM7EykBWXEpy8YbkP91SyVTWUtKBejBYycy70xK5kngaoz6yhxyYTe7vf/CvWSbf/d7kslIo7yeflz22hvyFsUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTX8qF60uo2K3XLXHsOW5iJoPqE+7R2rzX8ocqqhVDM=;
 b=dbAp6Sa65vmpIGFyEyTlipfqdc2X9qsti+yTsgSnU5OCXSWjMhPdFhoxzU+Y2yeXnyYYItGXmXyJ7DKMR/dY52+4Nd7sqaH4XX6P07ihm8GYU23XIhjdw1MnZlmnu2V/uH32crBjCROpfSdI8oIiCyHlPwbE5/AOsLfI5goG+zjccVAnQAilfinVeP5ZuZgZzEl15ZHzUPQkfp/7FMxq3/Aug+twT9xvzxN+JOLe8v3eBvC+0GshdQZbbIneJLLQQkWirJT1xYO9Ku7Szqa9IAYcC5GwFzmgLW41YFDB8XWX5vwzdsfh9+KMHoYI8RxwrsAYzJ4cZT9a4EKDFA2K7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTX8qF60uo2K3XLXHsOW5iJoPqE+7R2rzX8ocqqhVDM=;
 b=bDHg8O/VYOB/k3G3L1fgCH0zY328BiMSY8SjHubBJKC9pM8QDZXM1Xz0+GXx2p+NudIZZo0iF5bcyUBWuYhXcICI0nov67/uj4Fa0pX5eh6N/WUr+XXAQ6IN3PwlgDBFDfnWLAyf2UjOT0iLHCMsdZdJ7DsesHooAAd6B+f75hwDva3uBXdEWDYGZVClkFpFvsubnEsnqzTq2veRqByAdrTm3cJuizcRCAw6edS00DAvvrxPOb5Hg7W6XX5MWD6BI1ioJrOdvKiRwIM/CR/fUPoUIC4C+xSlzKtlutBU+wVgqvq0QJ+kXM6zjBjUY7MjoJA9gjxfM2glctrV/ysx/w==
Received: from TYWPR01MB7680.jpnprd01.prod.outlook.com (2603:1096:400:ec::7)
 by OS3PR01MB8858.jpnprd01.prod.outlook.com (2603:1096:604:154::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.9; Wed, 22 Oct
 2025 06:37:10 +0000
Received: from TYWPR01MB7680.jpnprd01.prod.outlook.com
 ([fe80::a702:7478:5c45:6469]) by TYWPR01MB7680.jpnprd01.prod.outlook.com
 ([fe80::a702:7478:5c45:6469%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 06:37:10 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v2][makedumpfile 03/14] dwarf_info: Support kernel address
 randomization
Thread-Topic: [PATCH v2][makedumpfile 03/14] dwarf_info: Support kernel
 address randomization
Thread-Index: AQHcQhBVUDCqwJfOME6gIyqQ4U/k4rTNuFYA
Date: Wed, 22 Oct 2025 06:37:10 +0000
Message-ID: <11f97cb2-725e-41f0-beb2-b4a4562ea7b1@nec.com>
References: <20251020222410.8235-1-ltao@redhat.com>
 <20251020222410.8235-4-ltao@redhat.com>
In-Reply-To: <20251020222410.8235-4-ltao@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB7680:EE_|OS3PR01MB8858:EE_
x-ms-office365-filtering-correlation-id: 64a79dde-edcf-4a5d-3a69-08de11356dd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MVVWSDdwblp0R25ybzNTMkxZbm94RGVad3VJdnBJcXVsOWVlNmRDRHdmSklF?=
 =?utf-8?B?SGV1K0xsbSt6eWdFSUpTbEVwWWFTb2EvY0Z2aDV0SGVCZ01URW5OOE4xRWRE?=
 =?utf-8?B?TnZGaHJnVnBmcWYvQkZvR0xTQ0FWRzR4M3F1NjFpQkhXSG1zQ2FGcFNUaVpU?=
 =?utf-8?B?MnJxUXZLbXpmZWxQQnNxMU8vYi8vR2ZzSUhCbC9SQVh0VFN3Y21mVklLYS91?=
 =?utf-8?B?Y3ljOTcyL0w0VDJWcVplM3hOT3ZqSHFOQUhXRGVpc0phcFNQQ1NKM3BiV3NR?=
 =?utf-8?B?N2FjcDBzNjhIVUVIa1dUaGRLWHRPcUM5MDk1d2dOYWxJaVF0ZU9pc1JsNDZi?=
 =?utf-8?B?VGhTSmlSazFiaEk2WUpKNTl2U3RwQUQ1MU9tdllBcGtSK2hEWVYweW5kRE5w?=
 =?utf-8?B?QzVIYjRDcGQ1VXAxNmpvd3hLVVRXS3N4K3FYQS8vT3ZEMGZtTk1yT28vclFN?=
 =?utf-8?B?SGZpSjFQcEVzU0UyVGhka0hmS0hWYlF3NFBQd1BmZFNzWnpZazFDV3pWbCsw?=
 =?utf-8?B?R1A1ZHBLaExCcVdDUWZqTWw4dGRNY0ZVeW40Z0YrdFk5ZkR3b3NHV0ZNTm1B?=
 =?utf-8?B?dHJOdVFvd1loWnZJU3JYRFFQM0pIeVUxZkVHWkZxQUJqbklzUFZRcGxLQ0F0?=
 =?utf-8?B?cXB3S2VwR3dCckc5eHFjRlhVQmcrbUxPWTdXMzdvWDloNnNIWHBSejBuMVdw?=
 =?utf-8?B?dS91Y2hPSFA3MVBIamJyUDNwanlGQURpeUNBWU5DVmdUWFMxa2p0NFU4MkJN?=
 =?utf-8?B?RWdtTVBGVE9yQVRKZURFSjhjVkFmR1Rtb2c4M1QyTVB6RG1TdHVuQkdIcGcy?=
 =?utf-8?B?R2dWcFRpUnhFRENPQnM5bTJpVnBlMHc0QWo5S0p6WldTTklsQXlWM053SzV4?=
 =?utf-8?B?WlFkVWhTR29Iek4zNkFIM25ET2N6N3MrYXZiVzZpU1ZxNjI5UFpJQ21wN0Z0?=
 =?utf-8?B?d0RNZDNOTEhUUkltVFg2WUxOWi9SL0h1OE5BbkdtUzM3SDM4R253aEpIVlhk?=
 =?utf-8?B?NzZjTk9zTktlU25RRFlHMTBkYW52c0Y1WEt2SFBoRGRVNGRRSGlxMFJtc1VY?=
 =?utf-8?B?WXZaNHgrdng3WFIzYzF1STZQNE9zekdrUlhaYWlFdkN2Z1VtRGp1Z2xXQTZQ?=
 =?utf-8?B?MHB0TGdhaXJjaWZVT1JPSVlIY3FNNVA1TjNOM3gzS1ROZGZDaHU3cElpZlJy?=
 =?utf-8?B?UldRK3JEQ1Z0ajhJM2xvM0ZnMGMveEpiWHovVjExVjBaMU85UWdlSWR6ekNN?=
 =?utf-8?B?QXVyTklqTndmTUZVb2VTSkovSk1tdG5NVUl3NFFhVGlSb2psZDRFTzBFUWF0?=
 =?utf-8?B?UC9TblQ1WHVvc05DOGVrY01HMkJ5eEJ3c1dpT0M5SVdtaHl0ckJCL3R6N3gw?=
 =?utf-8?B?U3lHRHZZR09qNW1wREp3and1QitPdFB4dzZzbHFGakttQWJ0K3MvREJEUHNK?=
 =?utf-8?B?ZW9xbTF6U3I4TzhnUFhWY2ZJdktVMVhMYTdnOFRRN1NHUWJVSG9FNGxneWR6?=
 =?utf-8?B?NFB2ZFlWYUltS0lCdDlQY2tDMENnS3B0aTNIWWpIODlzYjQvaENqNmV4R3Jp?=
 =?utf-8?B?MWlPaEJJZFkxQUtNdDc5SGVsSkJwTUNZYzlJUzFGYkQxN083UFRCbDlwcDVU?=
 =?utf-8?B?NVYreTgxQ2RibzJCcG5HYnNJRlZudmpZTEhRVkk4cDcrT2VKQ281VXVqQ1VO?=
 =?utf-8?B?RWdlUTl5cWVIeGdxNVR6c3VFUWNsSjV0cnJ0R25IRCtLVm95eFlqdlJ0OWc3?=
 =?utf-8?B?OFQzSktRRmg1SG5kQUtsNmU5T2k1dWdNQ0MrcGZPa2w4aUFGUnY4UXBDN2hs?=
 =?utf-8?B?R2ZTK0NUbzlHYmV3SkZodnlUanlxUjdRN01iVG9JbjVGMlBDZnpCMHZkZ0Vv?=
 =?utf-8?B?Y2dXWG5nYVVxYkNKWEszZFVJQUEvcnpRbWtqWThVejdwcDJNSFVyYVpBN2Q1?=
 =?utf-8?B?UXZWbGs0ZXdOak1ITXJqQ1JWeXRyV0o5SWYwelBTL2RIbFJEWUdsb0ZvSkwv?=
 =?utf-8?B?TDh3VEhmZFNHdjRFK29sSE02L2tSKzBVSS9mR1M4MklldU5kakxyWEFHWktS?=
 =?utf-8?Q?LleAJ9?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB7680.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1pkOXFmUkRKRUFkamFpc2xyKzJ1YXliYzkwK1h6cjlkVGVzRzZKTysxOWpK?=
 =?utf-8?B?SUdmUzMxR1VjZmFydUpLQzA3S2ozQXh1eCs3NFU0REF2d0xzOE4vamtDZkJo?=
 =?utf-8?B?ZjVyb2gwc0xlV0VqaHUvZVBUeVNDVnphU3llVS9vcFM3Q2Rlc2Fka3pQeFZs?=
 =?utf-8?B?RTNrOGF6cnpoUTM4bytGSVZQeFY3clpheWpicUVFSW9ZbUs1MXdTck1KbjZF?=
 =?utf-8?B?MkRjM2w2STM4Z1llVUZoWXlwS2JsbkVmUEZlRFFNd2Z4QkJmSmRLaEZHdHE1?=
 =?utf-8?B?UEpXQVNFRTJxMWIvSG9VNnU1Y1hiTG1mUXRlamZpcjFubFc0bi9iNGtobFVR?=
 =?utf-8?B?OTdrbjZ0SXMrK2FnZkNpU3ZsVnRlSnViZFlzTFBja1ljM0FNcjBobzVkYkI2?=
 =?utf-8?B?aVR4Q0NwaFdFczBvSFBzRE5CVkNSNmM0MGlOQU5BU24rRVB4ZkNjME43Zk94?=
 =?utf-8?B?TDZkdlpiWFlQblhPNXprWGNLS1pWWGsyNjcyeWZhOFNqZnFBRktCcXlpSnBr?=
 =?utf-8?B?dDE4MVZSNTAzcTFYN2xoaHNNLzM5c2J1Zzd4THNOZzA4bUtGamVqTXpMK09V?=
 =?utf-8?B?NjVTT0pUQVFkUU15OHRSMGg1Nm5hR05sek1UMW9DVXJKVWNjK2xSRHp2WFhR?=
 =?utf-8?B?QnpWd0E4STBSMjFRU0FhWDJER1dnb0hGbllXaS9kVGYvYkZqd0F4am5WQnZG?=
 =?utf-8?B?bXdmNXhkZnFWNXRKQTdEY0dSNU1sc1VNRkJDYTUxU1JkMDUxWldoMCtTRk8r?=
 =?utf-8?B?bUpPMnZJQUJQR3hreXltUTNXNlhBbm5iSllQcDdCajdjY0ZKNDN4azIvMEJu?=
 =?utf-8?B?Y0gwYXUwckJpd0tGLzM0dkw5WU5wTXU3S1QvelVUYVBvTVdFTXM0NFJtdW0z?=
 =?utf-8?B?UEFTWWpwU2xTb2U1d0QvS1R2NGZhanBFUGRMNUhTdkxESTRjNzZUWkxpekNz?=
 =?utf-8?B?RXJVaVZxMkpITzI1QWhoMko4YUJ4dUsyN2JHNDkvREFoZnpQMDZkdUd4aFYx?=
 =?utf-8?B?NVM3MkxXUThITUFBb1pMVEdSamRleDhxUzFCNW9rQ0NLWlF4cEpnRHRuWVBl?=
 =?utf-8?B?SWViWUVHZit0cUEwYTN3RHpzUTlRR2o0RG1RYUF3OFN3MWxvNDdxOFdmY08w?=
 =?utf-8?B?Q2xqdkRrQW5HbzcwUUtvdWRNTDVUaktwcHZockVsY0RmTlVSU3lDRXhRL0wr?=
 =?utf-8?B?aTc2V294N0Q2eEFia3dUOG53TGxTQkRGbm9nZzZsUWg1bmxTbGlQUGFPY3dH?=
 =?utf-8?B?QmhuZVlUb2xsNkJ5REZPU2ZBTFMxbG94SWc0bUFhdnk5ZXoyUFJTZXJaZGp0?=
 =?utf-8?B?N0NCVXpUMy80NkZNREk4NCt4ZEJSanRScXJ5WnVndVpKQXpWMFhIOWFrRnJl?=
 =?utf-8?B?aU1idWEzSWpDZ3pPNHBVZkpUYmtMSjhPblM0cGlyTmtiSVB6YlRoTWpFT1BY?=
 =?utf-8?B?SDRWTm5ZTndzemJuQ2RJVjIvd0Y1SFNJQXgvaW9TM3Vab01pYkZhSDRmeFJl?=
 =?utf-8?B?RHhvR0lZV01FTGRJZDlpaWhzaFliUmxDY01CZXZIRkFPbklGckcrL3dURmZJ?=
 =?utf-8?B?YVR1M3EyQVAxeE1tL2pGZzhhYWRqOE9JdHNJY0RraVpFWEVwamdyblhFc1hS?=
 =?utf-8?B?Nlk0OHZ1ZFdEMEpSSC83WHhKY1pJUDVOWUhtaXF1Qk5QZWhLQVBLaWJ2NkZp?=
 =?utf-8?B?ZXQ3MEQ1eXhZa0JwMlUxd1VtUGlYY2hrUXVYdHI5NVQ0cDhWYWNKbWlYeVJi?=
 =?utf-8?B?ZVJHK3BsSFRYcHJNd21ualFxWExJc2NIaFRxWk5lYVVpbVFSL0d5bVNodEVl?=
 =?utf-8?B?eVZuWlVwTXk5R3RVQkNPbzIvRnVnRFpVUWtRRzJLYVhYWjNVSE9wNFh0ZXN1?=
 =?utf-8?B?azREK2FYUmlmcjhTOXVKMGQ2eXZESG1OandlenQyS3RHVlh0TFZMdG85RFc5?=
 =?utf-8?B?aUYrNlBtbFV5WFVrRVIyUENnaDMvTk4zcDdyTGNxOTRwT2l0TXVLdmg1UkxC?=
 =?utf-8?B?Z0xEQ2NoR0hzM1F3T3RGZFdlMzM1MWhmUitWOThrM2V3Y21lNGduWXdCaUow?=
 =?utf-8?B?akY4SU96VHFXVkVkckRGOGswZHNiWFJIVllib2E5U2ZaMUtPOHpqMWtJWm1I?=
 =?utf-8?Q?hJT5M4xGxRYNYWyCZTRSN83ag?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F05B0DF9938794B8DCE2E3B92D8A643@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB7680.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a79dde-edcf-4a5d-3a69-08de11356dd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 06:37:10.6338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BrTNXzTjgEMPm6GJF/3ZYpxlnn6hsHkkkdpn4iYmofgalGhQk2/wI8r5e9yd0O45fVCdH3rc0wCHhrQ26Trmkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8858
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_233726_387622_890699C2 
X-CRM114-Status: GOOD (  18.74  )
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

T24gMjAyNS8xMC8yMSA3OjIzLCBUYW8gTGl1IHdyb3RlOg0KPiBUaGVyZSBpcyBhIGJ1ZyBvZiBu
b3Qgc3VwcG9ydGluZyByYW5kb21pemVkIGtlcm5lbCBhZGRyZXNzLCB0aGlzIHBhdGNoIGZpeCBp
dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRhbyBMaXUgPGx0YW9AcmVkaGF0LmNvbT4NCg0KZm9y
IGFwcGx5aW5nIHRoaXMgMDMvMTQgcGF0Y2ggc2VwYXJhdGVseSBiZWZvcmUgdGhlIDEuNy44IHJl
bGVhc2UsDQoNCkFja2VkLWJ5OiBLYXp1aGl0byBIYWdpbyA8ay1oYWdpby1hYkBuZWMuY29tPg0K
DQpUaGFua3MsDQpLYXp1DQoNCj4gLS0tDQo+ICAgZXJhc2VfaW5mby5jIHwgOCArKysrLS0tLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZXJhc2VfaW5mby5jIGIvZXJhc2VfaW5mby5jDQo+IGluZGV4IGZkMzE2
YzEuLmQ2OGUxYTIgMTAwNjQ0DQo+IC0tLSBhL2VyYXNlX2luZm8uYw0KPiArKysgYi9lcmFzZV9p
bmZvLmMNCj4gQEAgLTE4ODEsNyArMTg4MSw3IEBAIGdldF9zeW1ib2xfYWRkcl9hbGwoY2hhciAq
bmFtZSkgew0KPiAgIAlpZiAoIXN0cmNtcChnZXRfZHdhcmZfbW9kdWxlX25hbWUoKSwgInZtbGlu
dXgiKSkgew0KPiAgIAkJc3ltYm9sX2FkZHIgPSBnZXRfc3ltYm9sX2FkZHIobmFtZSk7DQo+ICAg
CQlpZiAoc3ltYm9sX2FkZHIpDQo+IC0JCQlyZXR1cm4gc3ltYm9sX2FkZHI7DQo+ICsJCQlyZXR1
cm4gc3ltYm9sX2FkZHIgKyBpbmZvLT5rYXNscl9vZmZzZXQ7DQo+ICAgDQo+ICAgCQl2bWxpbnV4
X3NlYXJjaGVkID0gMTsNCj4gICAJfQ0KPiBAQCAtMTk0Miw5ICsxOTQyLDkgQEAgZ2V0X3N5bWJv
bF9hZGRyX2FsbChjaGFyICpuYW1lKSB7DQo+ICAgCSAqIHRoaXMgZnVuY3Rpb24gaXMgY2FsbGVk
IHdpdGggZGVidWdpbmZvIHNldCB0byBhIHBhcnRpY3VsYXINCj4gICAJICoga2VybmVsIG1vZHVs
ZSBhbmQgd2UgYXJlIGxvb2tpbmcgZm9yIHN5bWJvbCBpbiB2bWxpbnV4DQo+ICAgCSAqLw0KPiAt
CWlmICghdm1saW51eF9zZWFyY2hlZCkNCj4gLQkJcmV0dXJuIGdldF9zeW1ib2xfYWRkcihuYW1l
KTsNCj4gLQllbHNlDQo+ICsJaWYgKCF2bWxpbnV4X3NlYXJjaGVkICYmICEhKHN5bWJvbF9hZGRy
ID0gZ2V0X3N5bWJvbF9hZGRyKG5hbWUpKSkgew0KPiArCQlyZXR1cm4gc3ltYm9sX2FkZHIgKyBp
bmZvLT5rYXNscl9vZmZzZXQ7DQo+ICsJfSBlbHNlDQo+ICAgCQlyZXR1cm4gTk9UX0ZPVU5EX1NZ
TUJPTDsNCj4gICB9DQo+ICAg

