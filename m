Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF86CC3DA4A
	for <kexec@archiver.kernel.org>; Fri, 16 Aug 2024 05:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y2p2twfX8wqaL7ilZaUkZpz6cXE2HLbJizBljDVyNrk=; b=IjUvK5kvEvA/7t
	YcJyUUJYwKNchdCP41+DCS2o7CDbXZ1s/jgk5LkOJ5CkOPZg7Aga0205fYoIHq0l3LjYP/MrHhDMl
	8vJESPnWdYlQiQN3Gbkfpf/rkJlR11olhrUj/bpsOKqtlaYsFnzaT18d97I1gjHm9g/6NnEM817jF
	EL1Tyy//9xEOMZljxEgk5eS/N7AnNIKpqleOt4rqwTkUpWYtuX1zJ1SMTpaJ4d+/IQnlfBwQgQlwj
	cs37n5jixx5gf9lj/5bWXWl9ZdtxOBE2R7kV9/K5XGxzZNZURottwX7+vCGu/j1uhK/RmdQa2yViN
	dE8JTCYsNgl7rprqp8EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seprT-0000000Bt7V-1HSh;
	Fri, 16 Aug 2024 05:50:55 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seprQ-0000000Bt6c-1QHN
	for kexec@lists.infradead.org;
	Fri, 16 Aug 2024 05:50:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpIXYkIjwLxyjCYwtvtF0sJlBCPWoTG+VldR7ip34zuQtkc2zaKRm6dydC2Dv6gc295WCMILvBOFrwR+EjKmt1AgNpMf4NYjU7YoMosf63OogzI+DM3aBH7rPcPs0TjHKE3nvEYGD44MrE5LIS++rzH/+ATO6Dzcgg/ogwY+KgtL9Kti5u1xfyxx5Kqu6lBdlxdBM8WhtzqAPa5gwFdJgExqgSUK4Iu8TQxR/fx3nH7mEu1gzLX//68JdgnlReBjeYiF8X9GCaSkSBKbbdH5voiT+gt+GCTNndpmSzq77eHeDq4G634lyzTbRMLB47BcybZlmVAf4j3Xhs1ifHqiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s54iRhvxZUK4sQVZQ0RZJYuIvS0YcT/FYNd+zQ5GIzw=;
 b=FDAmIYutaCWJivLCodYsj3PqpBluNluuLv5/zDXlP7qhhD5anXNzJdEc3jwByfJiRc+V81sXVnJCg24wWhwAi3srAshFZmKCrh52Lqfi4IHiGz4T4JsF6ogP3BXa6Bo8xusFCbh4L0Huy3a+peeNgiV0H5HI+sLnN3SFlG1vtjdjgjbaq0cN+YTaMZxYvspOHDeu/jUhcvNYnetiU6HVUtNrUcxuQeCzfJ7ucxa2NiCBTbfrLWOxPy+DrtFaAnetAfobMGoNq1aOeidBuQIwtTnSDfUbZQdT908KsTxCyPIypV0PGPp10mBucJaipgMZoVVRoTvSvrsxoJnpRuvMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s54iRhvxZUK4sQVZQ0RZJYuIvS0YcT/FYNd+zQ5GIzw=;
 b=WAjqAhpBQZMtTPtGxa4V0Y/ApfJpKyl21yLoYtCi6XIRec3TocIqYCg7i4Q3vVgi+9D3lK7pWKIEWrsZnTaa1jDVNQ5p0WmRp6pohHCtMw+/IRI4VBlvrB8XVXjmTbo3hGmXANCvOKYqrkxe7s6EDHDx/HkimMnvDmhHmuIBCmkiIAowdbV2dSVYYQaARVGuUxTTtE0iwfNlrI2iuVMrTEDcLxh6JXpT3N5Af7aq1dxppMu15Zfgs3eSUF1HIk7zZ4ONZNHcxpyzGnC7rnuvnNwpQoWK8VGt3wgDRCBw8fbmHJxiQg3Dk8sOkdh2SCT4AeDW/L072m/0m0bsBVO07w==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by OSZPR01MB8009.jpnprd01.prod.outlook.com (2603:1096:604:1b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Fri, 16 Aug
 2024 05:50:34 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%7]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 05:50:34 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
Subject: Re: [PATCH 1/2] makedumpfile: Add ftruncate error handling
Thread-Topic: [PATCH 1/2] makedumpfile: Add ftruncate error handling
Thread-Index: AQHa7x33iviqh2foe0qlHTCNHnX2xLIpYi6A
Date: Fri, 16 Aug 2024 05:50:33 +0000
Message-ID: <db15a94c-3fa5-47e6-8c8d-59665bb119a8@nec.com>
References: <20240815141733.4050230-2-stefan.wiehler@nokia.com>
In-Reply-To: <20240815141733.4050230-2-stefan.wiehler@nokia.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|OSZPR01MB8009:EE_
x-ms-office365-filtering-correlation-id: 812d8c33-3dff-4a60-19e0-08dcbdb75871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bmdMOVRraWdHVFVKQTlmSmJHdGtZZXBKNU02cjg4YmNTUDRCdUlFSGhIaWRD?=
 =?utf-8?B?OE8xTUpKZ045U0ZxcE40cDczeGxkZTlQQSttdU1FQTFlRTZkMXE2dFBoN3hD?=
 =?utf-8?B?TXRyUTh1bEFZSkZUNk1vcHJHOUt0N0NiZ21md1pVODZra2dvWE4wOVlDSjlS?=
 =?utf-8?B?d2Jpb24wVndWQmpHNTM3QW9ELzk4QkQvNWh6YzFnSGR4cENjUnZCVFlXaWdh?=
 =?utf-8?B?UW9vWG1pZzlGRmIxekJjU25FVVhyUkRRLzVYQS90Lzh6eUxLcDRmbFYzcjJM?=
 =?utf-8?B?S3VqRmNMcU9wM3I2N1EyM3hFNEp1blRnRVhkYm9YTlNQUWtodUlRVDdpdnZp?=
 =?utf-8?B?WXVyUVkvKzYzclFJQW5iK1I3N2ptazB1NDdVdkRFaW95dTVrTy9uRzN4WWdp?=
 =?utf-8?B?SGcxQktQbWtGODdGTHpnZVZIb3Z4UkIvTHBUMnRxN3QxWmlOSHVpeHhzVGhn?=
 =?utf-8?B?M095bGpVODZtdVVPUUd4eEJ0bmkwQ2dJdjQzd0dqNjBmc1Zqem5Hakxnb2dj?=
 =?utf-8?B?QUY4VHJGTHpwUVpHRzVmenFpaWJCR0hBMURjTXROTkppNFZjK0tCdGp2Q1RO?=
 =?utf-8?B?aTlhZGxjc3BBcG0veFV6dG5NbVh3YzlKc0tabmtWdWM3ZHl3dmZyMklPSXJu?=
 =?utf-8?B?SXlXNmlZN2lXZFdGdjlWbWJxWTU4L0hjZ01pd3FJSVoxc2picWdXb1MyTVRY?=
 =?utf-8?B?Q2luNSt0M3o4UnVaRVdMSW5FOVIraENwUmh4MXlPcTY0N0hhS05WUnhWQlc3?=
 =?utf-8?B?STNna3AvbXJLOXdiQ1U0SEdKbVovc3BTMjZya0ZQTGdBRXRjRHJ6bVc2WUto?=
 =?utf-8?B?akZTOHBPckxLb1kxMlloRmlIYzRNSlVSc2JTUG9tMWcwYm5RSDJkVDhLa0Jv?=
 =?utf-8?B?SDZUTWFyOVZJaUJjR0sxcVpwMGxhdGZabktmWnZsTmNTcmtSOE85N213d0M1?=
 =?utf-8?B?L1A1dGI4OHpubk5hdDBWdEhnZXBXZkF1YnRPTEF1UFREanNtM29LRUZCN01a?=
 =?utf-8?B?d2hHZzNvWDJqODdzMVhuVmJnTFQ1NHQ1cFl3UGtoT2VOYmxlWnJSUzh2TmFU?=
 =?utf-8?B?d1EyL1AwTjJMRmVZQnJWdEFLbGNzZFFCM0xYTGNrYXdReGtEQ2l2d0V0elc4?=
 =?utf-8?B?aUJPbUg4c2YwUUZZSUN3WU4vUCtJZWtCekxuZDhzaGlnaTdNN1NXdVZlRkQ4?=
 =?utf-8?B?SjhFUHlqaEhJRi9PbXlFK1BYMmlyK2R1QmgrZ0FyMUdsMG1WM0grS2VydXZM?=
 =?utf-8?B?aUs2R1dyd2p5MnB3d1UrbjBkN2N2MldUSFQxUHAwWFQrOUFiY2g4Y3F5SXVO?=
 =?utf-8?B?SXRaalhYMXlDdi8wMUlOQW5jRDA4eTFqU0dnRXczWTZWRjlnUHB0Q3VvcGFX?=
 =?utf-8?B?WExQTFhUVWdpNVE3NzNIVGttMmtoUEdsdTNQVUUyR2g1RWROb01qbmtZZmFS?=
 =?utf-8?B?azUyS0gvVlNqR3krenhEWTdsdUJHb29ESFRmWlBUUmlHL2VQYndWK29MQ0Fj?=
 =?utf-8?B?L2drMlJjL25BWTVOZlV4YVMwS1dmbW9qWDhjMGRiQUhIVENHbEV5SURhR2hJ?=
 =?utf-8?B?dVdVZ01FOWZ3YWZlK3YyS2RlZWdCeVZLNEFUL1BnUDFKaFJzZXdCTm5TZjQz?=
 =?utf-8?B?VDJ4a201M2RtQzIwN1JtcCtJQ3g5cXNybUtSRkVYOTFiZHBueGpPa1RMam9y?=
 =?utf-8?B?aVJUTzFnZXdZSG5WTmdoeWpvcW44azZEWnhUdzBPem5xVWNrVVdGQmxaMDda?=
 =?utf-8?B?c3ZiaHh3ckE1QlFFK29xUHNXTHl5RHNhbnJZMzE5aTNYRGxpRXJxQjcrOFlI?=
 =?utf-8?B?TTRNYnRLYU5QR3FUNEtPVEhnanl1d281TkJBT2NpRHRCTzRpZ3lndEgvU2M4?=
 =?utf-8?B?eU1hQWdDejh6clVDSDRTem11M2YrL0EyVTFYWkpYYnVUS1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE5Rdms2NXN4VlVReTdVK3dYYy9lSWVMcXJzcGp2TDVwNXRvVnpUYXhFSTI5?=
 =?utf-8?B?azBBcjNZUTg1eThnWkNaN0RSUVIrWWMyOXdWYTQ4bG4raTVDMGRjUlU3R2Iv?=
 =?utf-8?B?eVFHUGM1bHE1bVdVeGdRR1NvTkFaamVDVHRLVE5GTU9ha1ZNelg3K1c4bFZl?=
 =?utf-8?B?YXorR0hvNUlaMVZ2Y25RNXFlSnJ5cDc0N2QzQjRwOERFdHN4d3JlNjdtaU12?=
 =?utf-8?B?SXR1Z1BxSGk5WWR0SnVwRDVlN2VuYmN5Q1BhUEpRQUpUTWFocGlFRkVpTjNJ?=
 =?utf-8?B?ZEFEREtBYkk1cXV1YUpNeDY3UVB6SFdhUUZMMy8zTlpPdlRiQi9DbWJLQXQv?=
 =?utf-8?B?L0VlbUtmNzkvc2pjOGk0NDBaSGgzeW9TV0FQTTN4b2sweWdpVlNCQ1pvczhL?=
 =?utf-8?B?b3VqbUJrbkpVRGhYUEhTZE1yYm8wNVkxdmZlTTNRekU1T1c2ZHdNalVjN2NE?=
 =?utf-8?B?anhhSHRhaythd0E5SUlnRzJHRzJTdFcwMXY2Wk1JRkNoVEF6WUdYVVdGY2Fl?=
 =?utf-8?B?UW5hL01YNkVpUmdPVUZXMXhPOXh4Um5PMEFDU2tLZ0k1UkZiMzJ3MEowak53?=
 =?utf-8?B?R3cydk45VDY4Y1pqVEdmdExxck11UStaR1ZjZzRKbUF0S3VMTG9ZTTNFVUs1?=
 =?utf-8?B?NkZDQnpQQ0ZNMTRHeU5QaHlaeVlpV1AxZWIvY2dUTGZudWdqeTMva1NLZFZh?=
 =?utf-8?B?Y1pEenpwcXBOTy9nbnI3Wk5kN0JEbEw1OFkwQTdMVFNKVk41cm13NVY4eVE3?=
 =?utf-8?B?YU9heWtaWSs5MFQ5UC9ZU2N2NVgrYXcyTTNEQm1CVGpPN2xaWGRsUWRINnQ4?=
 =?utf-8?B?TjkzNGU4VDEyTHBWNmZuS0VuekNCWVBhbmNNaFdqa1g1MlFNOWtpNFhJNkIx?=
 =?utf-8?B?djdSRmZaYXEwMmVFVDQ2WUhIWVB0UFJ3OG9jcldTSjJZQVg0S05FWitCR3lz?=
 =?utf-8?B?R0Z3OXkwaFhDQjArS0R1aGpZcDRhTW43WXhiWS94R0F1MXFJeWt4MHNhQlZD?=
 =?utf-8?B?TEtCWWovU2wzbEk2aC9Qa1lSMjZvakp5WkVoOHdJdWVJTG5WcUx0QVZFcm01?=
 =?utf-8?B?UmpHVUFuVmtabW5vaHI5ZnppaFdDMEw2QVdtNkhrSUthTVphMHl2MXRhMVlz?=
 =?utf-8?B?MStqZW5LK0owNktuM2NOQ0dZTFd0S2JrbEFJTUlRRitRaklIakJZZThFQWUx?=
 =?utf-8?B?ckdBUEFjM3dwS3RDU3dGK0NSaHNLQktrZmN6NnhUVkxHbzVRdEY4Z3I0RUc4?=
 =?utf-8?B?SlV2dDZ1Z01nTUtYWXc2RXhsZkJtUDQ4L2lGUDJkc0h1SjhzcDZJMFpBMHhJ?=
 =?utf-8?B?NUxTeGh2aUdQeDNEZEFIZkxDSGtDRTdrUUNtdEhvYnRVZndZNVozemp3eWZR?=
 =?utf-8?B?SlRaOWFQTmlUUSt3elhsVG1Id2pmVmUvOHpRdUpKSFBXYzJBNUlmQ3Q0YlRh?=
 =?utf-8?B?VDdjLzh2RUsxdFlKVVM4Zkl4Y2wxTVdLbXFEQ0hGRUhubEtCQU93YXBYT3Ev?=
 =?utf-8?B?T1dzeWMxOUE1YjRFUjhWRmdiU2VGUW16TjdDQllxU3Y2cmJYNy9vZnZpTE04?=
 =?utf-8?B?bms5Q2hzM0hMeWRSSXo1R0ZuajhOeXgrSWhEekdLNFVvNVlkb0hvdUw0U2o1?=
 =?utf-8?B?SUxzTnFWY0JlL0loU21pcTN0ZlZyQWVFWDBIZGVFaVZ3RkdjajhtT0YwckI0?=
 =?utf-8?B?QkowcHlRQW1PY3JLbVBGOHVqUStYbGtkV3RacUcyaDYxYW5pL0I0L2ZEMU53?=
 =?utf-8?B?OE1sTXhBRUFQeEdtMVlkaER6YTVsRHAwZjk5a0p3UlorQlo1aGJBNHI0akdx?=
 =?utf-8?B?T3NseDhiR2Z1OUJTUldoUHUrRk5pc2gzazR0ODlrbFdZSmNYUE90eXRJbzY4?=
 =?utf-8?B?Zm9yQnF3WURrUVZiRjZWclMxTmxOdTdvVGJHMkJlTDBhaW9SajVrS1N3T1Z0?=
 =?utf-8?B?U0paeGhCQ2ZNdmZaSVZicXJuUXJMRTE0QUhKeUpVSnd5MVRhTEdvV053RlFh?=
 =?utf-8?B?QTNIZDcrcWZrL1ZGQ1FLRXRRaDhjUDZsTnNXeHNTa0V4enlGWnIvRkU5VGNp?=
 =?utf-8?B?TXo5MXJWbmFMeHpBSUdXOVFKRDRkV0xDZERLeW5meHVwVHdkeGtud0pIa05B?=
 =?utf-8?Q?FdOQJ+f0SKSiD5OxkEC+BjJdg?=
Content-ID: <852F9FFEC0B3A34C820973608A5C1C13@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812d8c33-3dff-4a60-19e0-08dcbdb75871
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 05:50:33.9992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EbdyFHKdu8XNVlZtc4u74X7PWpiWqppzN821CTijT3bAiruOElhBqX5Ja89i8lXqh3G1rr+PEYKoNOtfpGGp/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8009
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_225052_633174_C2EAA296 
X-CRM114-Status: GOOD (  17.09  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gMjAyNC8wOC8xNSAyMzoxNywgU3RlZmFuIFdpZWhsZXIgd3JvdGU6DQo+IEZvdW5kIHZpYSAt
V2Vycm9yOg0KPiANCj4gICAgbWFrZWR1bXBmaWxlLmM6IEluIGZ1bmN0aW9uIOKAmGR1bXBfZG1l
c2figJk6DQo+ICAgIG1ha2VkdW1wZmlsZS5jOjU4ODQ6MzM6IGVycm9yOiBpZ25vcmluZyByZXR1
cm4gdmFsdWUgb2Yg4oCYZnRydW5jYXRl4oCZIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIOKAmHdh
cm5fdW51c2VkX3Jlc3VsdOKAmSBbLVdlcnJvcj11bnVzZWQtcmVzdWx0XQ0KPiAgICAgNTg4NCB8
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZnRydW5jYXRlKGluZm8tPmZkX2R1bXBm
aWxlLCAwKTsNCj4gICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCg0KSGkgU3RlZmFuLCB0aGFua3MgZm9yIHRo
ZSBwYXRjaC4NCg0KSSB0cmllZCB0byByZXByb2R1Y2UgdGhvc2Ugd2FybmluZ3MsIGJ1dCBjb3Vs
ZCBub3QgZ2V0IGVpdGhlciBvbmUNCndpdGggYSBwbGFpbiBtYWtlIGNvbW1hbmQgYW5kIGdjYyAx
NC4xIChvciBjbGFuZyAxOC4xKS4NCg0Kb3V0IG9mIGN1cmlvc2l0eSwgd2hhdCBjb21waWxlciB2
ZXJzaW9uIGFuZCBidWlsZCBjb21tYW5kIGRvIHlvdSB1c2U/DQoNClRoYW5rcywNCkthenUNCg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIFdpZWhsZXIgPHN0ZWZhbi53aWVobGVyQG5va2lh
LmNvbT4NCj4gLS0tDQo+ICAgbWFrZWR1bXBmaWxlLmMgfCA2ICsrKysrLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9tYWtlZHVtcGZpbGUuYyBiL21ha2VkdW1wZmlsZS5jDQo+IGluZGV4IGNlMGQ0MGUuLmM2Zjcw
ZmYgMTAwNjQ0DQo+IC0tLSBhL21ha2VkdW1wZmlsZS5jDQo+ICsrKyBiL21ha2VkdW1wZmlsZS5j
DQo+IEBAIC01ODgxLDcgKzU4ODEsMTEgQEAgZHVtcF9kbWVzZygpDQo+ICAgCQkJCWNoYXIgKmZp
cnN0Ow0KPiAgIA0KPiAgIAkJCQkvKiBDbGVhciBldmVyeXRoaW5nIHdlIGhhdmUgYWxyZWFkeSB3
cml0dGVuLi4uICovDQo+IC0JCQkJZnRydW5jYXRlKGluZm8tPmZkX2R1bXBmaWxlLCAwKTsNCj4g
KwkJCQlpZiAoZnRydW5jYXRlKGluZm8tPmZkX2R1bXBmaWxlLCAwKSAhPSAwKSB7DQo+ICsJCQkJ
CUVSUk1TRygiQ2FuJ3QgdHJ1bmNhdGUgZmlsZSglcykuICVzXG4iLA0KPiArCQkJCQkgICAgICAg
aW5mby0+bmFtZV9kdW1wZmlsZSwgc3RyZXJyb3IoZXJybm8pKTsNCj4gKwkJCQkJZ290byBvdXQ7
DQo+ICsJCQkJfQ0KPiAgIAkJCQlsc2VlayhpbmZvLT5mZF9kdW1wZmlsZSwgMCwgU0VFS19TRVQp
Ow0KPiAgIA0KPiAgIAkJCQkvKiAuLi5hbmQgb25seSB3cml0ZSB1cCB0byB0aGUgY29ycnVwdGlv
bi4gKi8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
