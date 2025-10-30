Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1DACCF9F0
	for <kexec@archiver.kernel.org>; Thu, 30 Oct 2025 07:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6lViHLLztNQVvh48cXMyD7+kLVLSCsCOMLOQmfUCqRM=; b=yUAyzUqURo9M10lILNteseYHpZ
	XI1yRTBJ2eaYPlHmVx+zrXhq3LTFmUQkV+aB6cBn67gG92sWiRBmDD6bvg3j95PRi/Uakeh5vc6rB
	4Un8qMQgq1Qo8Y/k8e4yPF8aT9qYzgkqZZEUGQ3H1JCMUvo6PDN0OWmED9YiI2UhTupeRXkTrSDH8
	CxnDdIupNZec5Mk427w1UzOZbMi/X6r0BSJ3ike72MA5G7uHPJ2788yWEADDciNA1NUQKsyZeNy79
	fOhHleP1Vr6vn8mz/41zDRFn9Ovjcicw+CaxZudd/gw27Ve/hf+SX23U+SOzkrg6HDOYP4THGpscv
	sOQc66gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEMye-00000003csA-2Rsg;
	Thu, 30 Oct 2025 07:21:44 +0000
Received: from mail-japanwestazon11010050.outbound.protection.outlook.com ([52.101.228.50] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEMyb-00000003crj-2iKW
	for kexec@lists.infradead.org;
	Thu, 30 Oct 2025 07:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUYc04B4Dp9f4coK8WxKEwJew69jCwv5Z12/kiBitAzoK1CuRywO02ow/qCLiDV6gCPhwhjOBKHT8b2qkc02VzptlWN4MtCI+AApUvHiCMNmNhCkaT9+vnOSTHGPiYSmcXOOIBvKtvEtEMehr/wrGY3ZvfZw0xg6RQydMd0Jecf3Z8Zh2xXOh3GTw36dkg7DbA5oOwxzfW+DdwsfzXJEHCxmIMdCCoe35h8opEEB6wv8egHnGmB/SGbojO9t1EKcxmOLsRggfT7NaOHpcOst66Aea4dEBBluEQmWl/2UHNXrLwNK87KrBKmbbeYLDgKrE9xsIlUZOYpH8jGrn7LrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lViHLLztNQVvh48cXMyD7+kLVLSCsCOMLOQmfUCqRM=;
 b=kawWfcztMT90zkpNFkt1kGqVodUwmfXR331Vk6DeXHIcZ0YBPrVWuMivTbLQ3wlGwYW4R2awiwvoNFsh2uDeMKHPRC3VAFbMWKQCW6u+Rf/3zqnqjFz6nSFicVs/b8NjVHn+xSPUIHfHTow2saeurMQenq5nVDpNSQYDRALz31cziYhv7aS9PiNIpwd5yu02/eLTMDwx/TTnDwwu2MGGT2yd1SzQ5tWcg+FY7ACPcUf9xCwq5Gw6Ii0N46aAjWxSLMmgW1IfWAS7ce2TqVqVPnP20KsOFcfmCkuiIuio8uJAmT2P2gLd+mKr7jgUl2YMG/OzbkFcYkxFJlbadb9omQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lViHLLztNQVvh48cXMyD7+kLVLSCsCOMLOQmfUCqRM=;
 b=PMLI82VNdY7Qdc2J4/+P0FP1NDeA4KGiJfZTUDCQTt1FfoXm/n4vyvocfhGQH0DpaGU3kCV0E4OYqDk5DtIw2El5QRs8kWnrvLwqOXgAvzP5CDrinyRF5W4YHPSZTfi0GDGP+VpNmCEiaaUHoOS0y6Np0hhILbcjP+drnOspQkIChxXju8Ti9Ia1LAAzeYE37N/c/gm/MBVv5bIbBWmnyowF1DRhQPV5pb8LfXA2ge7S/i/otQDDur8arJf1tMQtucO71Dcit2uKEmLEh0AMyjA82em0DEZkB/ZTE+OM+ui4B8ZHA4lm+yUO4pKLX9AZFH8WkXDj+2Kwt2r+87bYHg==
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 (2603:1096:400:40d::13) by TYCPR01MB9781.jpnprd01.prod.outlook.com
 (2603:1096:400:20b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 07:21:30 +0000
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec]) by TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 07:21:29 +0000
From: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: [ANNOUNCE] makedumpfile 1.7.8
Thread-Topic: [ANNOUNCE] makedumpfile 1.7.8
Thread-Index: AQHcSW3PQPeTxyWcDEmUZkITCyF8wQ==
Date: Thu, 30 Oct 2025 07:21:29 +0000
Message-ID: <da328137-5552-48cc-b55e-0d3945bc1fd0@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11475:EE_|TYCPR01MB9781:EE_
x-ms-office365-filtering-correlation-id: 2e0aca11-c5fd-48bb-2e78-08de1784f21c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TFVRNDFGNmdBTFg0c1orVlNaaFh2MFliZi9abFpFRUR2VC9kQzFiS3BnNDYw?=
 =?utf-8?B?OEJnbkNtdXg3VUMrMC9MMmdVRlZmUWNCd1FGRUh5dE1rQ1lYQXNBa2lFWVFz?=
 =?utf-8?B?RS93UHhKZThhWEpsQURUTFJwVkd2b1JuSEJxOC91MnB4M3F1TW14R0x6T3h3?=
 =?utf-8?B?cTZIZXg2bE1wTUViQTVTK0VZY05tODZCaUNHb012TDJLMWFCY0dPUjVIVTd6?=
 =?utf-8?B?ZWhVUCt4MGQ0L295TlVzczJzaitMZThWdC9yaUkxQ2VvWWNuU0NuWTJuaDlY?=
 =?utf-8?B?OUlWeXlPYXRaNU9LdnFzaUpQdWpCeldnc0FIaEpvaTNpTHFRc3BZbEhnRDAv?=
 =?utf-8?B?ZW0yMENIZFZpVm1oN0I0UGxmZjFEN01SY3NnZkNsYW9Hby95V0RoZDh6WlhD?=
 =?utf-8?B?SnE2UGNMU2QyVGx6bGxvUmlFaG0xK2dEaDZqRVh4Z2JGWC9BUDY0OEN2VlVH?=
 =?utf-8?B?VDdKNEw0ZldtelB2RnNSZlNxOTlIOGM5R0RiNG5aT0tIVllhMkd3bUlvVVli?=
 =?utf-8?B?OWgxMW5GUUtTUWtGVUZEaW1ONUlWMmFJelhndHpaRGcwNEJZclA2ZU04S09y?=
 =?utf-8?B?WkNXMS9SZjhIbTJDbUZIMkFkeXpDeHRVS2daa2c0S1laUVF0V29OL3YwLzVp?=
 =?utf-8?B?L3ZXYklRdWU1L3lYbElET3lrb2V3QnJpR251UktPaitIdmpiam1mbTMwUXd1?=
 =?utf-8?B?aHUrUUtLdnB0T2FaQm9UQTg0SE1ydnBwSGE2blp6bm5zeTNLS0J5WTR4aTVv?=
 =?utf-8?B?aURQLzJ6Yk5HK2FDeHlhWXA3ajEwWEhSam85MXlFRW50SFFjK3l0YUw1RDh5?=
 =?utf-8?B?TzR2UW9jQ0t4TlFLWFFVbkpzVFJTSGpIZUdYc0NGYXpiN0IwY01FbDVZY1NQ?=
 =?utf-8?B?TlRVUFVLa0Njb1YxM1MwNmlndlBSbFJWZnRsM1kyczBlVWZWbDF3WU1QUGp3?=
 =?utf-8?B?bkE4ODVkb1loOW5tU21UdVREd2FvaXNnLzhDMFpnN0MvdjlDTHh1c0x4ekNx?=
 =?utf-8?B?c1Jxd2lVN2g4NUUxR3Y5NHpsVm9aM0tDZkFlZDRkTDZuT2U0Mkw2QWlqQ1V3?=
 =?utf-8?B?WG02U1BxOUpxSXV5RGpiVW41NFhhbUswTkVxZjhrb2Jsa2FYTTFCYWo0eThh?=
 =?utf-8?B?V3NVVmpTMWE5TCtDK2kwaTNLNStkbWNCZCtSejI0RlpZd3ljTk1yd1dKRmlh?=
 =?utf-8?B?ZEgrUzdseHZzdFI5ZE85dzVvdjFuYVR3V2ZhVlAwSUpxRlFvWG80SVd0b2lu?=
 =?utf-8?B?ZHU2eFNQaG9lakphMytydWJIaTdvVEZuYk5LYk0waFNLZFkvUnNGVEVGdlgy?=
 =?utf-8?B?TVE3TXNvb1BjVTNEWW11THBiS1lhUXNWdWtkWFRjQWdRelh6MGZBbVk0SlNo?=
 =?utf-8?B?Zklnb2dXbGdJbll1NVFuelpTV0tDaEtEN3EvNGRWTmRtUlByVUJYYitKalp3?=
 =?utf-8?B?V2RMVjdXYXBsS2JuS0dqTzY5WmkxNzNyS0hUblJlNkdSdWJDOTBoNGNISE0v?=
 =?utf-8?B?aE5hUkpsZ0ExMkFrTWs1MFlqeXdSWllDS1FweEdzaEdlVXN6YXFpTjJsQzdM?=
 =?utf-8?B?ZnFZQVNtZmo1NWlJU29KYlRNbkxtV1NIcEtHTzNkeGJVZnBWRzdkN05jcWlW?=
 =?utf-8?B?VThNY2R5WnpzMmZFdXFpT1VYMXIzci9PMUVnNmlrOFVMZFNvQjhTMlY0TmUw?=
 =?utf-8?B?TWJsTC9qVkdwLzB2c0JzWHZrQnNISnVKTG92ZFBqTkdIaEVuUVViaWduQjBo?=
 =?utf-8?B?TW8weXVyQ1daa2lNUHovdmpZUXptN0VRcnhyOUxGbW5iVVd3YUcvZUN5cGJQ?=
 =?utf-8?B?SXpMSFlzQ05XM1M3bmF2L2RFQzJxSVltQkFTS2svbWQrNUhNWEdlTWY4ZXpQ?=
 =?utf-8?B?UmU0Z0RRNEI1ZE1hZnFnS0l1dFd2Z1NaRWxZbDFkcE4yNWtGdlJKZ24vbjFl?=
 =?utf-8?B?YlY5TnRIekZiTW5SS0cwRG5pSjVlaGcwaERNbWFGekMzM2FJV2ZhejNFU1dp?=
 =?utf-8?B?ZGlERDFGbkFxWFU4WVFZdzBYZmFwUjd1SUxCSUVYOFpmaXd2TXBkcDk1cndi?=
 =?utf-8?B?WVlRTWFPcllwckdtRk4zQmRMYmpWYnU0cW9Qdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11475.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODNNTFNBUGRNWEJvbmpqR2lLWUs0ZmRtWGs5c09KNlg1R2hZMnpBZGpYR0RJ?=
 =?utf-8?B?b3lNMU9VM3RsWWwrVklpbm9WTWNXbDR3SVVxOGF3VjByVTRhVzNXQ2ZzRzVS?=
 =?utf-8?B?ckVkQmZPVnB1b1gxa3VGZGFuQnltTnphZy82aGplWmhNakNnUFVDVnFzQkx4?=
 =?utf-8?B?b2xwZE1FYWQ1dDhZTXlhZW95K2orV202SzJ6bW9qTDlmTTlSODR2bGxDci9Y?=
 =?utf-8?B?c0E2cWphNWZvUEFwbHJhSE5VNmRQemxobjZqeG8rL2JOYXRSRzUyMW1mV3dw?=
 =?utf-8?B?dGV5SGZwY3V6aHhuNnpWaHdFWkF4aFBLUEFleVBoTEIvZ0NlWUNiU2JvVElh?=
 =?utf-8?B?aE54Q2dzL2M1cHhPQTNtY2NkVG1ZNWlyZUFhMk9XU2JMUERnaUtDOHlNMWZY?=
 =?utf-8?B?TlplanlSRGk5Z25SZDZZLytUcXJ2L3hjb0I2WEpKSWJSSjJyV0Vvc0hzdExv?=
 =?utf-8?B?eW5sNlg1STR6VG16R1dOdGYzZ0djSEtrNngwUHFDakFrMGdQNGR2TjRhQklM?=
 =?utf-8?B?cWtnS2JWeTBIcHFKVGRGTDZjSTUycHNHSDZ6YzBCUmYyeHlZcEllcGh2aC9w?=
 =?utf-8?B?VGlBQTF4aUJoeHlDL3Q5RkZIQ0QrN2pKa3VjYUFnbGdUckFURHp4dGlmblBu?=
 =?utf-8?B?UXBSZVZQYm4xbUZRSVR2Q0tUaUJyczhYVkpJeWdja1Q4SDNjOVlpZXhvTmE3?=
 =?utf-8?B?ZDhlQndJU3FLMWxueVBOVjdtbGx1NzZoam9WSlgrczl1VlJaTjdnVDlnOTEy?=
 =?utf-8?B?WDFmOUV4Wk84M3VESWYyRDZXL3podEFuOHlBMW1FOWN5ektTSktmUklkODNh?=
 =?utf-8?B?N3UvOUZQUXQ5Tm8xQis0bHVCNGlma0NkOVpSRDVaeHM1dk9vSlhidTFVdjdQ?=
 =?utf-8?B?dFVIZGF1WklDcDlLM1A2aVE5eTN1Z1dNV21aN2tJZjVTTjZycm9iRnNTZnVs?=
 =?utf-8?B?ZFVZdnV0RVdaMy84RXQ1aCt5MnRCM1NESVFEd1hoOU5xbktaN0JVU1hOcFEy?=
 =?utf-8?B?dExYdElaRUkyRFFhWVVMTWsvbnhXL0xZM21xdGhtL24rdHdPak1GS2pNYmtD?=
 =?utf-8?B?cktha0RCQTJ0MjBxbUhVQlJoeUR1N2NWdW1aZkdyOWR5bC9OcjczV2luM3c3?=
 =?utf-8?B?MXUvWFVSM2tPaFRaWWJZR0gyOEhiNElGVU1ST3IrSUxxNENVd2Z5Tk1LNyt4?=
 =?utf-8?B?RzAwOUw5dDFxaExMalAwZWR2QXRWMTlmQUpoc3VVTmErUUdEM1oyUy9iQi9i?=
 =?utf-8?B?MUdVVE9mZC94ckFKNGhrSDY0NEMxV1Q5RGdYbVlSTzkvdU4vaU4wZm1EQlh5?=
 =?utf-8?B?OGxUR3YyYTdTMUFCc0NMU1JoL21VQnRacVkyWThyb2lRYjAxWnV6M0o0QjZv?=
 =?utf-8?B?SzBxNHpubHBMZTV5eG8wR3hyVGZxTlFWYmxhOE5STEx6d09sUEZYMzJ5MDBE?=
 =?utf-8?B?d1hjNHZheUxrN2JjamxYejMwcWIvcWZYckwzTmMxSzF3R1VXd3NEL01PbHFC?=
 =?utf-8?B?SEYzcWk0dnhzK1lGNGVnSnorYmtSWDNyTG91bEZCc0RSRUJzeDQzUUFkWmF6?=
 =?utf-8?B?NGxFRFN3cm5waW5ML3BLNW9iYjFwTzZLTE5CcmRFTFJHbXNHU2VHaDlkRzRV?=
 =?utf-8?B?TStLMjgwUkd0ZmtZdHNucitibnh4SXkxUHh4a0pSVTlPajd0ajREUTVRY2wz?=
 =?utf-8?B?UGFIbURSMGVUcitMb0NuS0JjOHdFa3F1aVUvejhkeVJySE5WYzZtVkdpRWlN?=
 =?utf-8?B?bHoyV2gydmxMOUxTbzJSK0tVRk5qc05pTzZoUWFPbUlEWFpERldYRFIyYm9v?=
 =?utf-8?B?aUZ5RUp0eldYTDJMdGxiNjJpK0VVMVVONEY4bTNrZWh5dmpEd0lZRTQzVURO?=
 =?utf-8?B?YmUzYWlTZGRiOTVYQjJpWUU3bElmanBoZ3Raekg4cCtMcUt4VTFaT0xUaGZY?=
 =?utf-8?B?eFFWZmtKY3NOdk9uQkFCSVlsaGwraDRrdXdDdTl3UEJWSlNaRTZaLzRGTWZu?=
 =?utf-8?B?QkdTSlNYUFd3VVNpKzcrWWVxMDRBZWRNWHloYUxyckFQcEZCRXRPWGlYZmJO?=
 =?utf-8?B?VGpjakM1QStWZVhlYy9TS3EvdC9DK1FvUTZwYUFCSmg0S1Ayei9OYWQzTUNV?=
 =?utf-8?B?MGFJUDVlVEV4SU9sMUd5SUhONWM0VUFpRXFScXowZERrOElLYXd2NzRLMGVQ?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCB727F62D833844A0DC0573D6C5D8F3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11475.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0aca11-c5fd-48bb-2e78-08de1784f21c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 07:21:29.8065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5gvUbAOJxJPkNXCs9sGDZWLwaZAim1NiF3zFXWzAnK63HiqzS1LInzfj7DGEwONewwyNAvslOQmcLt3i98BcAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9781
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_002141_868278_4E7D63B1 
X-CRM114-Status: UNSURE (   7.55  )
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

SGksDQoNCldlJ3JlIHBsZWFzZWQgdG8gYW5ub3VuY2UgdGhlIHJlbGVhc2Ugb2YgbWFrZWR1bXBm
aWxlIDEuNy44Lg0KVGhhbmsgeW91IGV2ZXJ5b25lIGZvciB5b3VyIGhlbHAgdG8gbWFpbnRhaW4g
dGhlIHRvb2wuDQoNCkRvd25sb2FkOg0KVGhlIGxhdGVzdCBtYWtlZHVtcGZpbGUgY2FuIGJlIGRv
d25sb2FkZWQgZnJvbSB0aGUgZm9sbG93aW5nIHBhZ2UuDQogwqDCoMKgwqAgaHR0cHM6Ly9naXRo
dWIuY29tL21ha2VkdW1wZmlsZS9tYWtlZHVtcGZpbGUvcmVsZWFzZXMNCg0KTmV3IGZlYXR1cmVz
Og0KLSBTdXBwb3J0IGZvciBrZXJuZWxzIHVwIHRvIHY2LjE3ICh4ODZfNjQpDQoNCkNvbW1pdHMg
c2luY2UgMS43Ljc6DQo2NWUwYjU0IFt2MS43LjhdIFVwZGF0ZSB2ZXJzaW9uIChZQU1BWkFLSSBN
YXNhbWl0c3UpDQphNDQzZWI2IFtQQVRDSCB2Ml0gZHdhcmZfaW5mbzogRml4IGFuIGluZmluaXRl
IHJlY3Vyc2lvbiBidWcgZm9yIFJ1c3QgDQpzeW1ib2xzIChUYW8gTGl1KQ0KZjFmMzU2MSBbUEFU
Q0hdIGR3YXJmX2luZm86IE1ha2UgZ2V0X3N5bWJvbF9hZGRyX2FsbCgpIHN1cHBvcnQga2VybmVs
IA0KYWRkcmVzcyByYW5kb21pemF0aW9uIChUYW8gTGl1KQ0KNjViZjRjOSBbUEFUQ0ggdjJdIEZp
eCBhIGRhdGEgcmFjZSBpbiBtdWx0aS10aHJlYWRpbmcgbW9kZSANCigtLW51bS10aHJlYWRzPU4p
IChUYW8gTGl1KQ0KYzFhOTMwMSBbUEFUQ0hdIEFkZCBjb25maWRlbnRpYWwgVk0gdW5hY2NlcHRl
ZCBmcmVlIHBhZ2VzIHN1cHBvcnQgb24gDQpMaW51eCA2LjE2IGFuZCBsYXRlciAoWmhpcXVhbiBM
aSkNCmI4NjU3NWIgW1BBVENIXSBNYXJrIHN0YXJ0IG9mIDEuNy44IGRldmVsb3BtZW50IHBoYXNl
IHdpdGggdmVyc2lvbiANCjEuNy43KysgKEthenVoaXRvIEhhZ2lvKQ0KDQpEZXNjcmlwdGlvbiBv
ZiBtYWtlZHVtcGZpbGU6DQpUaGUgbWFrZWR1bXBmaWxlIGlzIGEgdG9vbCBmb3IgY3JlYXRpbmcg
YSBkdW1wZmlsZSBmcm9tIC9wcm9jL3ZtY29yZQ0Kd2l0aCBmaWx0ZXJpbmcgb3V0IHVubmVjZXNz
YXJ5IHBhZ2VzIGZvciBhbmFseXNpcyBhbmQgY29tcHJlc3NpbmcgdGhlDQpyZW1haW5pbmcgcGFn
ZXMsIHRvIHNob3J0ZW4gdGhlIHNpemUgb2YgdGhlIGR1bXBmaWxlIGFuZCB0aGUgdGltZSBvZg0K
Y3JlYXRpbmcgaXQuDQpodHRwczovL2dpdGh1Yi5jb20vbWFrZWR1bXBmaWxlL21ha2VkdW1wZmls
ZQ0KDQpUaGFua3MsDQpNYXNhDQo=

