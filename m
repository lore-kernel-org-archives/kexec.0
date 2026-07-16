Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B376CC44501
	for <kexec@archiver.kernel.org>; Thu, 16 Jul 2026 01:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zvA++/WY8VjHbMj7dKXST2WqnCQMUolMJADY+jYW3bA=; b=M1+7o3jSvJlCymRV9dj0QDbSB1
	F5alqUE3FrNnDgMl4E74nS6D8Un7CWVLEU5HloaDySyPU7jqmdx7b2qIQiPY5Tbz3dHC1ciDRteCj
	JsLwwnYmAFVkpEQP3FKLFSuAMk4OcI5iPCFLB1sIU5yvnwqDodqWcZOD/UKefoAtutWX3cfUUvouC
	LEUxyfwdwBtMveHuKAHx5Ovm2cqq5pB0CfpR1o//LhWMExuJSsgW04ZHZG0XQRs89WBmBc9ZxIgkm
	CyPZyQztXfiAf09XZnovkAQF1yjyo7alsXuUpYBxd0yGMc32rYpNKZaFJJ1T2vbBT3XYjFOv3PZvR
	6XllnafA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkB6Y-0000000GDDs-1JC5;
	Thu, 16 Jul 2026 01:41:38 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkB6U-0000000GDCk-3u6H
	for kexec@lists.infradead.org;
	Thu, 16 Jul 2026 01:41:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2xhDoRtAcRRYf3AVgmLKxi6alMWMkcytrFwuknAOXo1s+kS22aYldzu0/y9XrRf0MVOYDOQ6p2IBpv/dYLGJrz7JszSgNWEnUM30uK8X2vxG/jKgdviQL4jDImobBj2I6z/vs1JMxWSWygKxE91czIbaJb+mniuAQWTyeX4c4jdmrNUN3+3mYMRsBZ2SXvFwWBnyzjFYVbR9UUTg96mWUNfl54c0y/TFxH4aaj+/n4NKcI6ZOd5lL85FEQA/uszxNi968rkHEZ4MJgLyXAU9ONCZTQ0EXsC47GUnuT9plUNOI9pl93TJpylbnhtGQxXzAA6QTXSZXS64FxNVHBa5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvA++/WY8VjHbMj7dKXST2WqnCQMUolMJADY+jYW3bA=;
 b=eKtxRZnrpyiC5vLTJNCnPLYiQLpNrDG4PhfyZIDH0zDgoxKThVE/OJ6M8YDGuW5N+71kLc6vykKyo+D5XMFsYl/M2GRPLael9UD29hRokCFgnTprPJB8Lozn3AdSd919V02f4WhAWJq+FUo5rdWXGqxmnAT5i4q5jCi6/RTg6d6wfcEU04W5paACVgy8R0kelGhdGZQ9XC10TgAi3/JH2WNWnznB/og5rEm6/GSoViyoUmQW3TP59fu7220fWoV1aXh8fDHPe5iTSTDRG6NJ4w6+RI5AeJZHJIigpRP1+8B3+ZnFaU/PqKYZcITT+mDuTCkVD/C0jvoewRvSyXeGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvA++/WY8VjHbMj7dKXST2WqnCQMUolMJADY+jYW3bA=;
 b=cT2iolo7Rv1UBfgiVA0kEVqRlu5IHgkmadVmV5wGUVWHhhe5+5wTtlewOcgvq1ES+Ii23axt+CFqBLldle3VGOR+yzRmcXME2m4Vp8aE+W46SEp7Kbsr49f7mvhUALQwAH2HungQE72mpUYsIYKaaD/P5iGlsYcvlSvLmdA5d8MJhW+OCRo4NRt3RSrPxKoq3LJrlk1TX9+XBEVOSSGh+TcwsStw9YcDaFur/8R09fMobCVD2wfiu7vbtdCW9DJReqKmA8TVzrhzSv/59TQo/SbBI8FfTjLq1Z+U8VoFwAFhVdsoY47mg4eDt3da39E6KpHD7Anh3ZEOLRL7DI+7+Q==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by TYRPR01MB15903.jpnprd01.prod.outlook.com
 (2603:1096:405:2cc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 01:41:20 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 01:41:20 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Maxi Saparov <maxi.saparov@gmail.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>, Maxi Saparov
	<masaparov@coreweave.com>
Subject: Re: [PATCH] [makedumpfile] Avoid glibc lazy-unwind machinery in
 parallel teardown
Thread-Topic: [PATCH] [makedumpfile] Avoid glibc lazy-unwind machinery in
 parallel teardown
Thread-Index: AQHdE8dd+RgyGssLOE6GP7KNTOcQt7ZvYKgA
Date: Thu, 16 Jul 2026 01:41:19 +0000
Message-ID: <e12c1ef4-6c9d-4e8b-8b58-63c305558c85@nec.com>
References: <20260714193045.14773-1-maxi.saparov@gmail.com>
In-Reply-To: <20260714193045.14773-1-maxi.saparov@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|TYRPR01MB15903:EE_
x-ms-office365-filtering-correlation-id: c169daa6-8bc0-4c26-db00-08dee2db5602
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|5023799004|11063799006|56012099006|38070700021|6133799003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: F4EdE2PeFF3GjCCk5OkU1ZbqGZA/Q81yEkyVX6ys4R4SmjTvLFVntaHLQGdKoN7ZVoFkaxv5EUrbtLRkr7DBJzVrGfa4pwbgqo7Z/AXnYLmiNpu6khDQ6g2OdIeHLW29lS5JI2AxVyGUUhH+bYkvQLdOPkA6XpFhcQg+CFcLZc9LRXhT4mDTse4N4Pf3nw1cm+L22GsMGr1c080rbvqu6p1RQHOAaueMLnkbPb4Ukh3msOT+yrX73SLPb32SaPrfxh9m45YIFyVmKd++a+BtsxXuNWB+m2Ho3Zv+yrRjtSDbk6jXzGJLGDbr1DwaELAfSWoeRGtjnBNkJOa8JK3zTt9nh0r4A4AMTrN8i32G46kt7M37oWfeYhVjefX1B/I4iOCRQ5aJMQo3QoC63Ll3wKeOLAP42cAu96QY6NU1vS52I4EJ2TbgRSYKcP0+fWqg6QZmk6Lg2hcv0qkj1UDMmITFaeJoN+n8AelLumksVuIPsLYsX8evUOnxSQOjtuZKmCMkaXH6eIlzIBTJoTvoL82LgquRGrPUGCWNpB78pzuumTaLPdcK5DEN+WeXa1qxA2mXhWcU3UmjI+zq96swkwMTANEOW40YsOWf3IZIFcOoneyzwsclwUfD7wKVadykn/4o9TTwMpcM6PU82O5wAcZA6kcOWn9f9DXJUeEpPj+7jiBv4gWOw3zN2VKtsCVsztqQFd3ymJtTPfoO+vYFFf+eXIsUy6V2Z4FejqNrWDE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(5023799004)(11063799006)(56012099006)(38070700021)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFZHcTRmNll0TjhKVXRQbzZhcDU4RGJ5M3p5RFdTMDZlS2MzcDhvamk0d1hE?=
 =?utf-8?B?TVNpb2FRRURvOWNoVGMzQUFFdGdOTTEwZ2ltNFEwKzVpWFdRQmErVzE1NGFU?=
 =?utf-8?B?ZlZiS25YM1RZUzhENXNoaTAwQUpCbXE4ZDVHbkt0NU53T1I4Y1U1WFJRRG1I?=
 =?utf-8?B?cy90d0xBSjByQmJsRlJwcnFpbFlMOUp5RzU5TE90akZPQlJxd3FuY2wvWmhv?=
 =?utf-8?B?a0xnZE1BRVViNkdrVThZNnNEUDV5MU9FSjdnY1pYbzFjaDdvRU84RC9ra0I2?=
 =?utf-8?B?Qnp2SGNTVG4waXRQaVVtdDJ5TnNqYTdjZ0k3Y2lWaXFvOHpMZzNTMmozWjI2?=
 =?utf-8?B?ZU85dUVPK2FGc3ZxZCtzV1V1NERDQWRRZ3RhVEhiN2E3L25hT3BGeHgwL2tR?=
 =?utf-8?B?amlPTDViZTFrbW1tUlFINHVwZm43ZGRlenRWL1Rhd1JPVUtJUDhMaFNRT1BI?=
 =?utf-8?B?M09SajFueHRhWlp1RXlsN3VPVDV3Y0N0WFV3WjB3clE3UU9ZWVlWazNGU1Vs?=
 =?utf-8?B?VmR0U0l6MTh5dGlnQ3dvUUw1TXdmYWMwMG9xTThoaVU5MHZMWnI4TGJ2aS8v?=
 =?utf-8?B?R2VrMEpSM1dnZXg5eGtZM2hsL0ZiQkxKYW5JVDZEVmVmQ3dWbm9ieVpBZ1d0?=
 =?utf-8?B?a0pGOW1oYm1NSmNGdXlEeFU4WjhXMHFia1RNYzJHLzN3Sm9WYlNCbTJYZThY?=
 =?utf-8?B?UytuOHlvWDQzWDBBcGgvdnhRanVmeTJuNUtQYUo1dFJobDVUQ2tPMDQ1c2pC?=
 =?utf-8?B?KzZLTWN5aTlRZnNHbU8zWTgwQkZRTTdsVW5xdWNjcFpCdjhyRjVBNkdzNCtw?=
 =?utf-8?B?TWoxVDN5QkFMQWdoK0t5dGVTR2hmQldRbzU0Z1VDTGZ0R1YxZ09aNVArbDM1?=
 =?utf-8?B?T2E5R09qTlBmd0JPVFJ2T2JNT1h0STlTQnhSSkI2VkpOYm12TTJDdUlrUzE0?=
 =?utf-8?B?WVdWTzYzTlp2THhsQnJFSnhadDF3K1c3Ymk0bWVtR0hNYkQ4YjVOY28xYmVN?=
 =?utf-8?B?cHYzRDBRVnAzTk5NUEpHSlQybGdsRm1uL2VXV0hNNWtxVGhIU0paN1pla0R5?=
 =?utf-8?B?NWQ2UzdJRUQ2QmEvWkxkSWVxOE1zRFVwcXduZXp3QmV2MWJnYVNvTmRBMmsw?=
 =?utf-8?B?bWd6QlRSQ1BKZU5iUFpoODdSQVVpK2dSS3BMaW81bHJRN1NMNFZEa1YzTlAx?=
 =?utf-8?B?Tjd4Rnh4OEN4YnRXaTZIN1YxR1BrcVpJZ0o5WWxzVnhZL2tteU4xOFJyTkJB?=
 =?utf-8?B?Y2FyOWdiT0dhbHVvMjl6REdFWVk2WmhMYy9IdU1LUkJ0aG44SDl5NURsSy9B?=
 =?utf-8?B?K1B5dzl6dzFRQng2U09oOFdSczdXVmZ4c3c0WjQxbngzaWZaa1VkaUYwc1Jo?=
 =?utf-8?B?aC9hK29ubjdlS0JOUnhvMHZvVDYxM0FBYW9FYWREbm0vWmhBTm9RK056cVNL?=
 =?utf-8?B?VmJBb05idmtSUkFFNmtWeHhCZXJGVXdZTktnbCtuRjE4cFNyRXJvNDNjbCt5?=
 =?utf-8?B?QkF0Z2dTd2tWR1BpQ0greHhEc1M3YWhmdFNBSUZTVVdwRlhnM3FNUjRTRURJ?=
 =?utf-8?B?cmgrajZOSVRtVVU1WjRIV3haN053UU1PZmR0Mzlvc1BvSUo1dllzZG4xTWUz?=
 =?utf-8?B?SU9ZMkpKQzlQYm5zdGIvZ2gxOE9BOVpLbmJWdVFMM3QrVTJwL0k2UHpMZ0Jx?=
 =?utf-8?B?aWdQa1g5ejlBVDczTzZ2bmd4MzZnZnMxSzc3allzK1hXRXp3bEF6MGNkTEJL?=
 =?utf-8?B?Y2V6N0NtMzZKSkRtcnVlWEpLNGNxcnQva1FqZlg3bmJySXAyZ0ZJYmhQL0lU?=
 =?utf-8?B?TzJiQzhpN0JUVFZjM3hJWFMrRU5iWFovV0JmaU5wS1loRGZ4UHJLZEs2Z3lm?=
 =?utf-8?B?RGtlTjhUZlRNaVQxb0JwVXdhMjdWMmNvbEJ2QmRFOVZUanlFWjI2YzFERm0v?=
 =?utf-8?B?Slh4MkcyRHlyOTRJT29VbjZlS3V1MEMxd1hGVnVuYm55VXhiVHFDTGEzSjJY?=
 =?utf-8?B?MFUxay8yUnI5RDkrcnhhcmg1b1VZRllqRktWTlIzRTFSQnBoUnlISTZGb0RJ?=
 =?utf-8?B?bWVxL3ROQzlVKzJMSVZicExWRy9OcnpkRHU2Tmd3Qm9zTXU1N1BXQkJFYk8y?=
 =?utf-8?B?cnVHOGl6aEx4aDAxOUh4djMwSGwrQnNXNE1JbWtPaE1yWUFTSERwMmV4Q2tw?=
 =?utf-8?B?bVZveTF3aWtsenRKVitIZEZXY1FZVWtyaVVDalNQdmZFTjIrZFdTamhweXI3?=
 =?utf-8?B?WlhuVlpLYWpCYTFLV0tEOExjb2pkcmNWMXdlamkxQnVVZGtJM2ROSngyZ1A5?=
 =?utf-8?B?K3RjdGgxMys5WUVBSU9qM2tRa2tGeFJKWkhVdlFzWm9YUDhnTDZaUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A04EFC072E54B4F8BE215ED8886461E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c169daa6-8bc0-4c26-db00-08dee2db5602
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 01:41:20.1851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e1Xr942SvF0H5/qfKscfyInlkG18ET92cY3Czwbhrdz1aYxe3YHwKugjMPOq+kCETDbiRVjTXf+JY0mOkMBAGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15903
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_184135_293573_07E9E17F 
X-CRM114-Status: GOOD (  27.08  )
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

T24gMjAyNi8wNy8xNSA0OjMwLCBNYXhpIFNhcGFyb3Ygd3JvdGU6DQo+IEZyb206IE1heGkgU2Fw
YXJvdiA8bWFzYXBhcm92QGNvcmV3ZWF2ZS5jb20+DQo+IA0KPiBXb3JrZXIgdGhyZWFkcyBlbmQg
d2l0aCBwdGhyZWFkX2V4aXQoKSwgYW5kIHRoZSBjb25zdW1lciB0aHJlYWQgdGhlbg0KPiBwdGhy
ZWFkX2NhbmNlbCgpcyBldmVyeSB3b3JrZXIgZXZlbiBhZnRlciBhIGZ1bGx5IHN1Y2Nlc3NmdWwg
cGFzcy4NCj4gQm90aCBtYWtlIGdsaWJjIGxhemlseSBkbG9wZW4oKSBsaWJnY2Nfcy5zby4xIGZv
ciBzdGFjayB1bndpbmRpbmcNCj4gKG1pc2MvdW53aW5kLWxpbmsuYyksIGFuZCBnbGliYyBhYm9y
dHMgdGhlIHByb2Nlc3Mgd2hlbiB0aGF0IGxvYWQNCj4gZmFpbHM6DQo+IA0KPiAgICBsaWJnY2Nf
cy5zby4xIG11c3QgYmUgaW5zdGFsbGVkIGZvciBwdGhyZWFkX2V4aXQgdG8gd29yaw0KPiANCj4g
SW4gYSBtaW5pbWFsIGtkdW1wIGluaXRyYW1mcyBub3RoaW5nIGhhcyBsb2FkZWQgbGliZ2NjX3Mu
c28uMSBieSB0aGUNCj4gdGltZSB0aGUgY29weSBmaW5pc2hlcywgc28gdGhlIHByb2Nlc3Mtd2lk
ZSBmaXJzdCBsb2FkIGhhcHBlbnMgZXhhY3RseQ0KPiB3aGVuIGV2ZXJ5IHdvcmtlciBleGl0cyBh
bmQgaXMgY2FuY2VsbGVkIGNvbmN1cnJlbnRseSBhdCBwZWFrDQo+IG1lbW9yeSBwcmVzc3VyZSBp
biB0aGUgY2FwdHVyZSBrZXJuZWwuIE9ic2VydmVkIGludGVybWl0dGVudGx5IHdpdGgNCj4gMS43
LjcsIGdsaWJjIDIuMzkgYW5kIC0tbnVtLXRocmVhZHMgMiBvbiBhcm02NCBjcmFzaCBjYXB0dXJl
cywgYWJvcnRpbmcNCj4gcmlnaHQgYWZ0ZXIgIkNvcHlpbmcgZGF0YSIgcmVhY2hlZCAxMDAlIHdp
dGggbGliZ2NjX3Muc28uMSBwcmVzZW50IGFuZA0KPiBsb2FkYWJsZSwgbGVhdmluZyBhbiBvdGhl
cndpc2UgY29tcGxldGUgZHVtcCBtYXJrZWQgaW5jb21wbGV0ZS4NCj4gDQo+IFRoaXMgYnVnIG9u
bHkgYWZmZWN0cyBkeW5hbWljYWxseSBsaW5rZWQgYnVpbGRzLCB3aGljaCBpcyBjdXJyZW50bHkg
d2hhdA0KPiBtb3N0IG1haW5zdHJlYW0gZGlzdHJpYnV0aW9ucyBzaGlwIChEZWJpYW4gLyBVYnVu
dHUgYnVpbGQgd2l0aA0KPiBMSU5LVFlQRT1keW5hbWljKS4gU3RhdGljYWxseSBsaW5rZWQgYnVp
bGRzIHB1bGwgdGhlIHVud2luZGVyDQo+IChsaWJnY2NfZWguYSkgYXQgYnVpbGQgdGltZSBzbyB0
aGVyZSBpcyBubyBjb25jZXJuIHdpdGggZGxvcGVuIGZhaWxpbmcNCj4gb24gdGVhcmRvd24uDQo+
IA0KPiBBdm9pZCBlbnRlcmluZyB0aGUgdW53aW5kIG1hY2hpbmVyeSBhdCBhbGwgb24gdGhlIHN1
Y2Nlc3MgcGF0aDoNCj4gDQo+IC0gcmV0dXJuIGZyb20gdGhlIHdvcmtlciBmdW5jdGlvbiBpbnN0
ZWFkIG9mIGNhbGxpbmcgcHRocmVhZF9leGl0KCk7DQo+ICAgIHRoZSByZXR1cm4gdmFsdWUgc3Rp
bGwgcmVhY2hlcyBwdGhyZWFkX2pvaW4oKSwgYnV0IGEgcGxhaW4gcmV0dXJuDQo+ICAgIG5ldmVy
IGVudGVycyBnbGliYydzIHVud2luZGVyLA0KPiAtIHB0aHJlYWRfY2FuY2VsKCkgdGhlIHdvcmtl
cnMgb25seSB3aGVuIGJhaWxpbmcgb3V0IG9uIGFuIGVycm9yLA0KPiAgICB3aGVyZSB0aGV5IG1h
eSBzdGlsbCBiZSBibG9ja2VkIHByb2R1Y2luZyBwYWdlcy4gIE9uIHN1Y2Nlc3MgZXZlcnkNCj4g
ICAgd29ya2VyIGlzIGFscmVhZHkgZXhpdGluZyBvbiBpdHMgb3duLCBzbyBqb2luaW5nIGlzIHN1
ZmZpY2llbnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXhpIFNhcGFyb3YgPG1hc2FwYXJvdkBj
b3Jld2VhdmUuY29tPg0KDQpUaGFuayB5b3UgZm9yIHRoZSBpbXByb3ZlbWVudCwgdGhlIHBhdGNo
IGxvb2tzIGdvb2QgYW5kIHRlc3RlZCBvay4NCkkgdHdlYWtlZCBvbmx5IHRoZSBjb21tZW50IHN0
eWxlLg0KaHR0cHM6Ly9naXRodWIuY29tL21ha2VkdW1wZmlsZS9tYWtlZHVtcGZpbGUvY29tbWl0
L2ZlOTg1OGZiN2E1OWE3ODZmYjFjMDBkZGM2ZjFlMmEzMTAzMWRkZTkNCg0KVGhhbmtzLA0KS2F6
dQ0KDQo+IC0tLQ0KPiAgIG1ha2VkdW1wZmlsZS5jIHwgMjAgKysrKysrKysrKysrKy0tLS0tLS0N
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9tYWtlZHVtcGZpbGUuYyBiL21ha2VkdW1wZmlsZS5jDQo+IGluZGV4
IDQ2ZDlhYzcuLjVjOGI2MGUgMTAwNjQ0DQo+IC0tLSBhL21ha2VkdW1wZmlsZS5jDQo+ICsrKyBi
L21ha2VkdW1wZmlsZS5jDQo+IEBAIC04NzkwLDcgKzg3OTAsOSBAQCBmYWlsOg0KPiAgIAlpZiAo
Yml0bWFwX21lbW9yeV9wYXJhbGxlbC5idWYgIT0gTlVMTCkNCj4gICAJCWZyZWUoYml0bWFwX21l
bW9yeV9wYXJhbGxlbC5idWYpOw0KPiAgIA0KPiAtCXB0aHJlYWRfZXhpdChyZXR2YWwpOw0KPiAr
CS8qIFBsYWluIHJldHVybjogcHRocmVhZF9leGl0KCkgd291bGQgZW50ZXIgZ2xpYmMncyB1bndp
bmQgcGF0aCwNCj4gKwkgKiB3aGljaCByZXF1aXJlcyBsb2FkaW5nIGxpYmdjY19zLnNvLjEuICov
DQo+ICsJcmV0dXJuIHJldHZhbDsNCj4gICB9DQo+ICAgDQo+ICAgaW50DQo+IEBAIC04OTk0LDEy
ICs4OTk2LDE2IEBAIGZpbmlzaDoNCj4gICANCj4gICBvdXQ6DQo+ICAgCWlmICh0aHJlYWRzICE9
IE5VTEwpIHsNCj4gLQkJZm9yIChpID0gMDsgaSA8IGluZm8tPm51bV90aHJlYWRzOyBpKyspIHsN
Cj4gLQkJCWlmICh0aHJlYWRzW2ldICE9IE5VTEwpIHsNCj4gLQkJCQlyZXMgPSBwdGhyZWFkX2Nh
bmNlbCgqdGhyZWFkc1tpXSk7DQo+IC0JCQkJaWYgKHJlcyAhPSAwICYmIHJlcyAhPSBFU1JDSCkN
Cj4gLQkJCQkJRVJSTVNHKCJDYW4ndCBjYW5jZWwgdGhyZWFkICVkLiAlc1xuIiwNCj4gLQkJCQkJ
CQlpLCBzdHJlcnJvcihyZXMpKTsNCj4gKwkJLyogQ2FuY2VsIG9ubHkgb24gZXJyb3I7IG9uIHN1
Y2Nlc3MgdGhlIHdvcmtlcnMgYXJlIGFscmVhZHkNCj4gKwkJICogZXhpdGluZyBhbmQgam9pbmlu
ZyBpcyBzdWZmaWNpZW50LiAqLw0KPiArCQlpZiAoIXJldCkgew0KPiArCQkJZm9yIChpID0gMDsg
aSA8IGluZm8tPm51bV90aHJlYWRzOyBpKyspIHsNCj4gKwkJCQlpZiAodGhyZWFkc1tpXSAhPSBO
VUxMKSB7DQo+ICsJCQkJCXJlcyA9IHB0aHJlYWRfY2FuY2VsKCp0aHJlYWRzW2ldKTsNCj4gKwkJ
CQkJaWYgKHJlcyAhPSAwICYmIHJlcyAhPSBFU1JDSCkNCj4gKwkJCQkJCUVSUk1TRygiQ2FuJ3Qg
Y2FuY2VsIHRocmVhZCAlZC4gJXNcbiIsDQo+ICsJCQkJCQkJCWksIHN0cmVycm9yKHJlcykpOw0K
PiArCQkJCX0NCj4gICAJCQl9DQo+ICAgCQl9DQo+ICAg

