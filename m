Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE5DD730BC
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gh3WhZdHbMdz5olkJ0q+/ErhcYdLcBDCg8YmShiame8=; b=zxRfleajHOSwsEutpg9R+nF2yH
	oPN1ur0CP9JkvRUfm6fO/bEORkmFFIiZl/xNqEj2w4gr50HT5ZO80oE9TnjEkHOIz8A/2Ud9GrJXh
	NkSqIR8TujDBNm1h43ytnJwV2dNxmA5b1bYR3+mn9MokV3jBvBgzNtu5PHchTGi6y7MkGGDglCRCA
	JBhfBTHpDQKeueVGj3xR69PF/s+9wUIsu/L0tIH093yXr8GFSfEcA90mOZ8+5Q4V0gFkcZOalflms
	gJqihEvUGw3LV3B91Br5iBA/PdGDp3gX671sVgIk749cDip2aRLYKo9uFJeyqkUGxmHpRffCcnbEK
	aPcOxL8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Zbd-00000001gQv-0pk9;
	Fri, 03 Apr 2026 08:10:17 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Zba-00000001gPX-370q
	for kexec@lists.infradead.org;
	Fri, 03 Apr 2026 08:10:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0ds9jNkA3U2NoKbemh8aHv07p886cOMgKUj6+MFIHQOfIfB+c7zjXzN2dNOkTIK61UKNAGhc8UMYd0FlLizC+pgkknWRtKenDvkEV6gkXpBXJay1TWyKkChlEUCnimIwZkD43nZK6Nak6uigc5Bn523rL4M/VV7gm7An9pLVEKFMQ1r/XKfvFWc7pWl1gn7JOeftYEKnloAO9Yoaw1Kp34PxMzzuNQs186YJdVWhhWmeIsZaBJb6DojHoD/fvejUSi10jRNN5PLFzeqsr1drwiot/XNiMQfFk8RxRaZBvLlSwGn6LEwBdAGEMMRd1gihJcWbYwZO53uSmBHLYUylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gh3WhZdHbMdz5olkJ0q+/ErhcYdLcBDCg8YmShiame8=;
 b=OOIzoRn8ttn0h3+AjPRFEGS6+GO7do+/XXktUYMXJ1Ltrvqcmhdi+NLLOZnYKAAzcR5BjGA43YOu/Quve0QEIwnGqsV7j9Zy/B92jGhhDn5nPu8BhIj4hqlpJMFbbiysiNAGdP930rfPoH8wFCQaAQ/1rPqSSE5maIUO9VNoNWgTOF/XQgQ3yy5C+ppGyADHchlUkOaNtWtYmY2qD/x2u7fZbhY+sCzo5LO0k40jebxz9QCQJvkFDXyWcYce8vgCGKB6R8peDHAizL6N9eSe2PO3hS7mnMDNuvfbp2Z0pVP1Bh0UihZb2iiq90YDmFheX/vNiNIAGPQ17RfBJbUeaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gh3WhZdHbMdz5olkJ0q+/ErhcYdLcBDCg8YmShiame8=;
 b=M4Xden34YR4kcwFSLL1owxrEp4xdPNraQS7C0W2tBpNJr7H9CziLmjSM92ryYWOT9uiTXslPTTNpECT1DKY5WbFWWQcptFBF4o9DzDu9QXluqvjFLvrIwnDRQkbuiljNDNDeeJ5lh18e/LVd4DmNW6EPSyRtRN/lgKttKwq9ByQhYeB9tlLZYyPdwXr07QyphS/6DHACm0cjA3+tmQX5I2lvukFEQWTXlT5Bo6KSZVvhXjSrikK6jXG2TdQCxAmjywonA9zy5NxvgPo6I/4qDOmwMBucz8qCv6Ap3bX/L4pqBQz5IHRQcaUed2yXH3SUjAylMdDsXJz7DXJjK+QBAw==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by TY3PR01MB10108.jpnprd01.prod.outlook.com
 (2603:1096:400:1db::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Fri, 3 Apr
 2026 08:10:02 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%4]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 08:10:02 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>
CC: "stephen.s.brennan@oracle.com" <stephen.s.brennan@oracle.com>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH v4][makedumpfile 1/7] Reserve sections for makedumpfile
 and extenions
Thread-Topic: [PATCH v4][makedumpfile 1/7] Reserve sections for makedumpfile
 and extenions
Thread-Index: AQHctiAAQEZHUCh0AUGHJpUU1Zcua7XNFkmA
Date: Fri, 3 Apr 2026 08:10:02 +0000
Message-ID: <1874a957-5436-4913-b5d1-72a51220e8b3@nec.com>
References: <20260317150743.69590-1-ltao@redhat.com>
 <20260317150743.69590-2-ltao@redhat.com>
In-Reply-To: <20260317150743.69590-2-ltao@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|TY3PR01MB10108:EE_
x-ms-office365-filtering-correlation-id: a211d0a0-d91b-4d5a-4e7f-08de91586820
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: yLWNZKvYheSEc/QpLtdJNCmpiM68PVQGUhtgEi4SNqXiGIxJNIxOJQEI3CEu4GcHYcz9xR/4O4+KIjJ5xiMt+nK/A2ity/UXcqxrEli9gm/4HhXvpHgL3dDVT90MHrhigRWxJdz9SZUfo0ksmbDgxJRkVsA/ZOcwEK7YbTkaOXnTPWOJE1QnnqrnUF60rFYZt5f1/1HOWcq9BS6jHrs2WhaNouWJOEgdRROtWFXtmssdYQ3346o5iNLpWWCQXSf1fE8In9GVW1Hi+fz0Lg5vg8ygmtaoFerXAH9T5vbAYT5aY9NbqYemuvKzHRNEbvLSDGiygfRtmfcQh2qfZdmDo6XtjAbyB2Apxz1LHhpxIzre/5RwMcEIPxy/Meh5VcugN5qPX5qJOolJyIA9gbeXDWziOOnSATgxcBT9TB8KbdwoE8DO3ZEBtOHZL1KTxY0JY6ahRa2YuMMgMh+IyBlmVrN5TZKB6xZRgQDzE491r/fkoJPg9a4lhJCtU/ctWRwfaEKB0gcNCAlmWrpvNIatsQyFDDayNMq1PxpJtgdKXJYyrVwXpY13JU0Wh772vt9UuqOYin0n4TWc4/n40Fyffb9S8DcJ6oleoJ/sKZ4mwjvtRf7sZmF7k1qtNn8+6BujiIhCsFUPEFVK/rLSH2abqwRq5+IFX0NdEHX1NsKQ1FhbLdVTY4LJKiwBpwuORhl1VJJpJSea+mL/h4HnWvBQ2xWfEHszlWpU/uYwCCwTfdrlyuzvCgM8h1MSLtytu1+azwXfZgRPK8WbeTV1bjmbB5quPyoC27ACp0rroNw0YYI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXZTaW0wWXlzcHNVV2JQRzB4cHRwSzlnbG5Dc2pmMk9GWk9lWEJUc2ZocTBE?=
 =?utf-8?B?ckpsMDA1RmQ0cjBrVUVmaVVsd3BwSTJGdlo1TTN4R0YzeTJ6M1Bna29mQ00x?=
 =?utf-8?B?ZzRMV0xMSWYyaFRhVHBwVHV3WHlZNk9QWjJsaEpmZlJjbE9PSnVBcUNUUWZp?=
 =?utf-8?B?RzY4b1RnRmJYeWc4TlUrYU9Vb2R0YXhDR3dhbzFOcFVyOFMzcFVnVjlmOG9J?=
 =?utf-8?B?emJaK2ErT1dNdkhPeFJYL0dwd1dCZDIrTFpUSVk3TFU0Ujd3WDYvMDlBSExz?=
 =?utf-8?B?THdlaXQ1UTJnTS9VYURqR0IxOGFCcFNGNCtHRHJUK0J2NU41NWtSQW5vTEhx?=
 =?utf-8?B?dTlRWjBoYzNMT3lmS3RERFJra1BZSGJOUnBWTldQNWFYOElBN3AwTmJoSFM1?=
 =?utf-8?B?ZE52bDl6VDV1cjM3U25VRVJSQk8xWUlNOFJaS0tEM1gvVkxCKzlkNHQyWDUx?=
 =?utf-8?B?cnFqSHZQeDJybjVIWW5odnZKbHJybDh0dXJycGt0Z2NOZkdJbFFFSDEraUhn?=
 =?utf-8?B?T2Q3NCtHTlJ3RmhpNitwRmRha2lnTTd2RndMQmNGR0RWSDJuMkdoTWEwcEJ2?=
 =?utf-8?B?dVh6SWtBS3FKVW1iOHVZR1RaenZJMWpiV0x4YXdPelJHNXdrQnZMVjd6OHg4?=
 =?utf-8?B?aTZTWlcxSXpxTjh5SGVURmdiSXRiQjZyMTJ3ZkxpTjNwWWpVdUtGMlVpVFZv?=
 =?utf-8?B?dWsxSkVOK3pISG5RbSs4T255alNyWmcrajB1NlJ3T1l2ZmxDdFc0OS9iVnBm?=
 =?utf-8?B?WHptb3NZcm5mbU82NDh1MVRKQ004a2IvVnl1U2RNb2x2cHgzQThUZ1R0eGsr?=
 =?utf-8?B?czUyOXpScG5iREtMdXNJL1lPRllLSDFhTm00UjFZd2N3aW0wS2tDeXRVaG01?=
 =?utf-8?B?Ykx1bG5LTGJBeTY0MlBZbHFQazBzQ1pCRUgxRUxidHVwdmVPS3pTSmloUW1h?=
 =?utf-8?B?eDJhVVdNYi9DM0dDaDRib2pVRmZqbUNBc1N0aXpCdzJyMHdPYkZxS1lvcm5G?=
 =?utf-8?B?bUlKMDh5MW9Ic3d6MG9SOG9lUmJNdGhwbzh2N0dJb3pwclRaUlBsb3c4cUxl?=
 =?utf-8?B?ZkI5TEhBMXJCbFdvOTliTTI5WnVNSE8xVFg2N3J5RXJ2ajJkbHJQc2xEYlNL?=
 =?utf-8?B?UDMxekl4eFZXYWMvMVhtTGlPZkJKd0x2UnpkZE5HNWpFV1cybWhTd24wY01N?=
 =?utf-8?B?L1A0UWVkY21pdVNTRnlJRm5kMUZJMk9kWFprNWdUbGJVSEpxMHRXWGhDK0tO?=
 =?utf-8?B?Y0JyVTUrNjVtWFJVR1E3bXFCTlFkN3VUc29ybkhkV2Z0bEt0YWkvSE5ISnVx?=
 =?utf-8?B?bHRSSjFlL0g3bSt2Z2VRMWs3RkJMVldkRytqbVc3elVGeWJ1SXhqaXNMTklU?=
 =?utf-8?B?Q0hSNU1HWEZtbnJvUmVvMStESHFTOU5pcHJUTUJXS2l4T3c4M25CM00ySUZ0?=
 =?utf-8?B?QXJzVmdqVS9oMzVzQ3VESGQzSUc5OStlTWNIUC9xUUlyWTFyTHZPWktzcWlh?=
 =?utf-8?B?VFRtSktzVDV3dWlxZFc1M2VycGluY05XeVQ5bUgyQ0Q1cGFoRC9wTllITVZL?=
 =?utf-8?B?UytMdmorM2dOZnIyZ3plMXZPU3lnYllFcXhxS0phbVpTTjRFa0txa0ZZTnIr?=
 =?utf-8?B?UXRUU09vZ1BEenlFa2FjajhNaURySEk3dTB6OUhBY3lZRDdDZEdjTlFJRWJK?=
 =?utf-8?B?dVNoYlVpdkhHTUdTMFkvd0xtNWkyU0V4dFpPeUlYd2plVGJpWEoyRmEwVWs4?=
 =?utf-8?B?dDlvc01tMm5TdHFCVngzVTkwMmU1Q2JZQkFCZ0YxdlV4a1d4MDgxSUxyNDdy?=
 =?utf-8?B?NFJhUFQyTDJtTkhsekpPZHVsdms1N3BhWDkremRUa2t0QzBRaUV6bmdMR0M5?=
 =?utf-8?B?K0pScThDWFh5dnJqeG1SL3ZmVHB2YUxZM1JyYTNQZU4rclF5UGZFenU3am9o?=
 =?utf-8?B?VDB1ZHlxcytEMG9VRHdocXZQSHhSci9oL0U1bTFWZW9ueHNIK2UwYk54UEFz?=
 =?utf-8?B?am90N1VzTC9aWjAvMUFGdGVsNDlxeGpaVGlTYmR5YVUxcWZmb1p0Q0JNZkdr?=
 =?utf-8?B?NGUvcXl5QnFuVTJUV1NOQkF3K3FSODdmU1ltei9TeTVvTHFnWU43cTM5SWdZ?=
 =?utf-8?B?WmdiR3lHS2w1MVdaMmU4QUxLN1NRT243T2o2VWJZOFZXeEZCRk8wOVFWSWJj?=
 =?utf-8?B?dm1KaURWYWNPa0FOY2pYYUp6Y3YyVXRIcUUweG1pbk9RZTZzRzFaOFNyQ2R5?=
 =?utf-8?B?V0Z2VEY4akg5TFRDbzhZSTRPcW8zN3ZXUXVGZHcvakFzc3krZFgzT3F3NDRP?=
 =?utf-8?B?YmoreVNQNTVSZ1FveU1DWEJ1ODYzM2lmMDZhVmMya3Bjb01sQTJ5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <126ADE74F3B32C4C802326EAFCC9403C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a211d0a0-d91b-4d5a-4e7f-08de91586820
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 08:10:02.2882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25UA+09onD/fBV0dDK1OYdh1oN1tPLLasL39XSImwDYgH9mXoyRQ+MZxTeQaYO1IPS0LK9/3//7IoAVpuhzqMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_011014_784246_1EDB7633 
X-CRM114-Status: GOOD (  18.07  )
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

T24gMjAyNi8wMy8xOCAwOjA3LCBUYW8gTGl1IHdyb3RlOg0KPiBUaGlzIHBhdGNoIG1ha2VzIHBy
ZXBhcmF0aW9uIGZvciBidGYva2FsbHN5bXMgc3VwcG9ydCBvZg0KPiBtYWtlZHVtcGZpbGUgYW5k
IGV4dGVuc2lvbnMuIEFueSBuZWVkZWQga2VybmVsIHN5bWJvbHMvdHlwZXMNCj4gd2lsbCBiZSBy
ZXNlcnZlZCB3aXRoaW4gYSBzcGVjaWFsIHNlY3Rpb24sIC5pbml0X2tzeW1zIGZvcg0KPiBrYWxs
c3ltcyBzeW1ib2xzIGFuZCAuaW5pdF9rdHlwZXMgZm9yIGtlcm5lbCB0eXBlcy4gRHVyaW5nDQo+
IG1ha2VkdW1wZmlsZSBrYWxsc3ltcy9idGYgaW5pdGlhbGl6YXRpb24sIHRob3NlIG1pc3Npbmcg
aW5mbw0KPiB3aWxsIGJlIHJlc29sdmVkLiBBIG1ha2VkdW1wZmlsZS5sZCBzY3JpcHQgaXMgaW50
cm9kdWNlZCBmb3IgdGhlDQo+IHB1cnBvc2UuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFN0ZXBoZW4g
QnJlbm5hbiA8c3RlcGhlbi5zLmJyZW5uYW5Ab3JhY2xlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
VGFvIExpdSA8bHRhb0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBNYWtlZmlsZSAgICAgICAgfCAg
MiArLQ0KPiAgIG1ha2VkdW1wZmlsZS5sZCB8IDE1ICsrKysrKysrKysrKysrKw0KPiAgIDIgZmls
ZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBtYWtlZHVtcGZpbGUubGQNCj4gDQo+IGRpZmYgLS1naXQgYS9NYWtlZmlsZSBi
L01ha2VmaWxlDQo+IGluZGV4IDA1YWI1ZjIuLjE1YTRiYTAgMTAwNjQ0DQo+IC0tLSBhL01ha2Vm
aWxlDQo+ICsrKyBiL01ha2VmaWxlDQo+IEBAIC0xMTMsNyArMTEzLDcgQEAgJChPQkpfQVJDSCk6
ICQoU1JDX0FSQ0gpDQo+ICAgCSQoQ0MpICQoQ0ZMQUdTX0FSQ0gpIC1jIC1vIC4vJEAgJChWUEFU
SCkkKEA6Lm89LmMpDQo+ICAgDQo+ICAgbWFrZWR1bXBmaWxlOiAkKFNSQ19CQVNFKSAkKE9CSl9Q
QVJUKSAkKE9CSl9BUkNIKQ0KPiAtCSQoQ0MpICQoQ0ZMQUdTKSAkKExERkxBR1MpICQoT0JKX1BB
UlQpICQoT0JKX0FSQ0gpIC1yZHluYW1pYyAtbyAkQCAkPCAkKExJQlMpDQo+ICsJJChDQykgJChD
RkxBR1MpICQoTERGTEFHUykgJChPQkpfUEFSVCkgJChPQkpfQVJDSCkgLXJkeW5hbWljIC1XbCwt
VCxtYWtlZHVtcGZpbGUubGQgLW8gJEAgJDwgJChMSUJTKQ0KPiAgIAlAc2VkIC1lICJzL0BEQVRF
QC8kKERBVEUpLyIgXA0KPiAgIAkgICAgIC1lICJzL0BWRVJTSU9OQC8kKFZFUlNJT04pLyIgXA0K
PiAgIAkgICAgICQoVlBBVEgpbWFrZWR1bXBmaWxlLjguaW4gPiAkKFZQQVRIKW1ha2VkdW1wZmls
ZS44DQo+IGRpZmYgLS1naXQgYS9tYWtlZHVtcGZpbGUubGQgYi9tYWtlZHVtcGZpbGUubGQNCj4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uMjMxYTE2Mg0KPiAtLS0gL2Rl
di9udWxsDQo+ICsrKyBiL21ha2VkdW1wZmlsZS5sZA0KPiBAQCAtMCwwICsxLDE1IEBADQo+ICtT
RUNUSU9OUw0KPiArew0KPiArCS5pbml0X2tzeW1zIEFMSUdOKDgpIDogew0KPiArCQlfX3N0YXJ0
X2luaXRfa3N5bXMgPSAuOw0KPiArCQlLRUVQKCooLmluaXRfa3N5bXMqKSkNCj4gKwkJX19zdG9w
X2luaXRfa3N5bXMgPSAuOw0KPiArCX0NCj4gKw0KPiArCS5pbml0X2t0eXBlcyBBTElHTig4KSA6
IHsNCj4gKwkJX19zdGFydF9pbml0X2t0eXBlcyA9IC47DQo+ICsJCUtFRVAoKiguaW5pdF9rdHlw
ZXMqKSkNCj4gKwkJX19zdG9wX2luaXRfa3R5cGVzID0gLjsNCj4gKwl9DQo+ICt9DQo+ICtJTlNF
UlQgQUZURVIgLmRhdGE7DQo+IFwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQ0KDQpQbGVhc2Ug
YWRkIGEgbmV3bGluZSB0byBmaWxlcyB0aGF0IGhhdmUgdGhpcyBsaW5lPw0KDQpDb21tYW5kIHBy
b21wdCBpcyBzaG93biBvbiB0aGUgc2FtZSBsaW5lIGxpa2UgdGhpczoNCg0KW3Jvb3RAcmhlbDk3
dSBtYWtlZHVtcGZpbGVdIyBjYXQgbWFrZWR1bXBmaWxlLmxkDQouLi4NCklOU0VSVCBBRlRFUiAu
ZGF0YTtbcm9vdEByaGVsOTd1IG1ha2VkdW1wZmlsZV0jDQoNClRoYW5rcywNCkthenU=

