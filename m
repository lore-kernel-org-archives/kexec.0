Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAFFC433FE
	for <kexec@archiver.kernel.org>; Sat,  5 Nov 2022 01:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xF28wqQjYXDqxpZ8Gg/wBA1FtJ0bvYC+3xjO8eA+Q+M=; b=De5oQdU5oSA5Qw
	t8sUVWFq8eSWCYre2LKnywl6HdE9Ao22hiS1ENGQ2mc7BddyJUFGkp1tImltI2lkNsuvPC6fsE+9J
	P0K5gwjpzowa0dhVWY1Wzz+cvElpdBRX/ez8uqzXE/a/zJyEM7V/ll0UIIytldDc336GogWa+llGg
	/BavF743lI+HqShGLzj3zWzuq2zi1+MvyU2p8VviJzW9MrX7ztvkB4D/nX0t7v0CITIdTfSgWe6h+
	r9Z3wSoHhYGKqFO9yUqY88NuOlIuBXgDQSlG/0pBcEcWHl4bB3b2hoSFW7tAxKDdUpIdkY59opRGL
	ILrlXjccEkvaxXtOHnKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1or89N-005hFw-Ka; Sat, 05 Nov 2022 01:39:09 +0000
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1or89K-005hEP-Pw
	for kexec@lists.infradead.org; Sat, 05 Nov 2022 01:39:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1667612347; x=1699148347;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=KXTapsrMi4GZX8CsOLC7l27fsWUA8ApPJuK+Nzbwuvw=;
  b=Q8jLCOmRtSUryva+HBUTn8aTRkNY/Qic+Q/PYmzfFoxtYPFs9pwwe/YG
   up3x24EYX42Sqs0+TcnTcSjDN7EmIIvrtUaQR7pamhtQS+/UScw7hY7js
   RKerblJyrDjx81651iEK9DER5GQZ2VtR1AXyi9dASv2XrcoaEP22HIm74
   443tzab55yFCf32w/flrLUdxYfA39NNrXc1vIFt+NlQ0szAmA1LoLkOZq
   xiIFD25MB1eGkpI5hoXQsWcB03fK00dF3RSso81Y/Oa2yeQISkYjuENiA
   sglFOekUjfDQ9nVpja5T6t70P55I+9i3o8eL2tsqDKhmNm+tyGF9wN88j
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="69166825"
X-IronPort-AV: E=Sophos;i="5.96,139,1665414000"; 
   d="scan'208";a="69166825"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2022 10:39:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoO5C74Vs6vrBiVJNdKrRlcHi/rNU1dDtURIotjYviAZ9K3LeL8dhYMomWRQHv0Z9uufwQn33+FXD6UvRKvQSy6v1kZaR2Y6wrYJAsc5+SYqteIsaNEPx0E9/8+1yzP3czyOJcI84JUK2sg0d+9eEe/5aCqjLGosHPqdwT9XKgyz4CK81k2bASUXa3DeL7zac+BNLBcMJ5F4fPLPuKRtp0m0r6GdKwI8SUfeuB5dvrBXWIZ3MaQ40RjcwwdVTu5XBwZEJ1O4qdEw++0lfqRwbB4D4oWXYgisyaJT+Hnmpwmi2VU1Eu3s0s6ysl5uLSEijgdorb3zKaAbrAnA1EXKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXTapsrMi4GZX8CsOLC7l27fsWUA8ApPJuK+Nzbwuvw=;
 b=SMPYeDazXoBizRma1bT0OUXLUOQSe4LdjxaCwfMaen+7DRuw+0ZYA+pqRX3vbNIidKz90cK7IHEAKAJzMs0H0O4SWSowRpRtsrgn0ebjSX+PVUpjw55b/q/Cpdekj/eVJPKiJNpdvqT/44If8RyMQrAIoZ9PrK5thdx1TqECYNb4tP5GdILkpSyw05j9NEs6QAGeJ3EZUiWD5gPU8bgNhqLCI3QO/XSwMheX0U6QSmc/Zbtp+ExPKLO2mfgUiH2gBD7BCpOrtFxghn3LuG4czgQlvvV7sYcnf5CtMlSKtvgituoGJTH6UYblV9fRUsYDi6glhvR5IrK8mTdKKEP4yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYYPR01MB7733.jpnprd01.prod.outlook.com
 (2603:1096:400:11b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Sat, 5 Nov
 2022 01:38:57 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522%6]) with mapi id 15.20.5791.023; Sat, 5 Nov 2022
 01:38:57 +0000
From: "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: where/how 2nd kernel's elfcorehdr_addr comes from
Thread-Topic: where/how 2nd kernel's elfcorehdr_addr comes from
Thread-Index: AQHY8CxI/OE2BYk0u02bs+ytvPdxfq4vjmKA
Date: Sat, 5 Nov 2022 01:38:56 +0000
Message-ID: <39ff647b-8250-45bb-73a3-c7a29f1d67b6@fujitsu.com>
References: <72d4be26-1711-aab8-50ed-8af538b4f6eb@fujitsu.com>
In-Reply-To: <72d4be26-1711-aab8-50ed-8af538b4f6eb@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYYPR01MB7733:EE_
x-ms-office365-filtering-correlation-id: e3ebd0bb-938b-4666-d7ba-08dabece8172
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  iCiaUxN/uXKcy03DaYvjre/F9GfkssRIpPnlu+qtwgujOyrvlUCzRLHVlSznFuvnMCC2ceQY1fw/LbZrE1c7mKjYC3sV3ps9Q+Q9tvxjISOGR5p7GXX0Uc5l5lEthK+WD08gWRJ076RHNZoCu9qlxwxc/AmipovBLUKOfkhHNmAhBtAE5S04h+2hlVtY3fhdhU8nStRN3u90oWan2CaSW2DFr2WqQy7v+XqeEezJQbC/VUxj3/je+XDbyqbjBlmE52wIRX+vAVMatqulM9SumWVpzTmrCKBIIq7xCY0eri4fYjttsqmgVvolRuKFye12kyei5U7rLGfRL3I7jcVjtCvSsfFZTPwNmqrXySSzU7UXMbQO1IDT/GJT3EOcLkgWB+AhcKZbB0qYcx0yH0YLLE6M+1oZsUroLXd9y1ESG4hmPfMBsRNX+CHEAHC6/6tz2LdHtxC0Kev/UtMO9YDRYpNI2VV+1L8QzVAsCdh8HxVcWMPlQuIo9ejIqYwxeQCjqlMbJGywRbyO61EJIqRzQttaw3QBmh05fL3FxrJnhzHsGDU+Hwgk8H5GnGSsoEaV0DVHgKhaxlrCjCCCGBMMzVSZFduLmvJTfTLdA1z1mh57qVyrk3H6Bb2uQQL2qUrKJ5tjY6M9hLSMoQ3VuawllD+dol8IFbbt2idKJgnqzQSZMHIEwxpJUCymslvfmTPEXt6f8nmCmgO87pJxWwvY+iZUEmHsIK13s7TJ+jrtvPZ1vMUPQ2D/39TmGWIqcfnjFDomdDN/+Fjk96VuY2/SL5VGaF4id/k2TDy5Q5hd+a0if104a5KIEpBbgkIltOsuJd606pKNiOMT0fxIcRXzTJyIaxHlDoA4WYp3ysV/iUi4lFX7hb9iToVqdYPJ653EgjATASPZCohZaZy4EFFANVJPXGVRy4/QRIb9ol0tUB0=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(1590799012)(1580799009)(966005)(6486002)(478600001)(31686004)(6916009)(38100700002)(82960400001)(83380400001)(5660300002)(36756003)(6506007)(31696002)(85182001)(53546011)(86362001)(316002)(122000001)(6512007)(76116006)(91956017)(41300700001)(71200400001)(38070700005)(26005)(186003)(2906002)(8936002)(66556008)(2616005)(64756008)(66946007)(66446008)(66476007)(8676002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?MUk0eVpZT204UGI4YkgveENwY001L1VXNWlqdVltQ2pBYmVDV1FXdUt1MXpQ?=
 =?utf-8?B?V2wzM09ZNG9WWjY3Wk1mR2hLMENtUlVhZjlLeFczTCtNL25FYnFzUjltZEVG?=
 =?utf-8?B?WnMxaHNhNUdKejR1ODZoU245YTNiOXpHUElVNkExcWptYjg3MllpeHlSVi8w?=
 =?utf-8?B?N2NiVWgvbEg3TUFjRUFHYWxrZHNxVkdhTzlYSG13ZGVZZFRuY2ViSkhNbkNy?=
 =?utf-8?B?OUZvOWhOT2h3ZHFpaDlkMTc0MEp3QWNXMmFBbmpaZHVuS055Y1U3cXZLbnlq?=
 =?utf-8?B?eHFtVHJkekxmVUVzZVZrRXkrbHhiNkU0YzNwU3hpbk1SaTVteWQwRzVvNjEx?=
 =?utf-8?B?NFhPZStobmRmSTY1Vk5aSUlYeGJWYTArRVpCbkd6K0RFZUFWOFZHQ3d0MlQ1?=
 =?utf-8?B?cnUyT0N4N09sVG1rSlF4TXBJbWsySDlYYXNYQTZPalJLVkYvZGRZWkZrWnZv?=
 =?utf-8?B?eVozLzR4WWFSbnQzN2s4WExoRGpJWHVQZjlZWDVGbGN1ZTAyOFovbGJaOFB3?=
 =?utf-8?B?K2U4bmVTQytLNUxmUTFyWUlFMzJnLzBKRFdkWlZiQlBqVFpEQjIwbmNzemEy?=
 =?utf-8?B?cU5STnEycytwaFdSY1Y4Ly9Eb2JGSXBBUExLOGgwZWlsUzlXZWFVY2FWYWQr?=
 =?utf-8?B?RkEvWmdWSWE4MVYzS3lONmJYV2FwQ0UvYVY1R000THFuU1ByL0d3aEtUdWQ5?=
 =?utf-8?B?SjJPTzREL3VhcVRmWG5aSEhFS1FaNW00N0l2N1VoTDNqZUJ0cnhDV09MbHhz?=
 =?utf-8?B?b1RUQlVhVTBWVkxlWUFnb1JkMTF3NzhsWXNkejFtL1UrVytOUExmck52elh2?=
 =?utf-8?B?ZTluNUJZNFZDVlVMQ2tmdDRCMDdiOVNpa3VWeUxhMjRXVEtHdlJyeTIwMDFp?=
 =?utf-8?B?dHcxSG5qSHptQVJEaVZaRDV0MzJqUW5OelBCQkJUdU81MnJONjVtaWVFbWRB?=
 =?utf-8?B?RVVuV2o2TWhHL3lQbXRtRGFRR2hSSWdieUxDbGxHU1R4MVBGMXU4eFp5Mkpu?=
 =?utf-8?B?dnZtN1E4SzYwU3dORTl6Ry8ra3VUN0x3d0tmTk5DbnBoY2tVOHBQUExtTXlN?=
 =?utf-8?B?VjRaS2RyMmduQ0FJOGxnaTZaYkRhbFZxQ040bFNiK2RGVjRjV3NkZzR6WlRj?=
 =?utf-8?B?YzdVKzFGL2pFN3ZuOTRZK0lXV0NpYmRsRFFYMDY1S2thQ0JSTzJWTUdWZWhK?=
 =?utf-8?B?RjVmSUw1UWNHVER2L1dSeEd6MXdiUUFacmNtZ2lNazNtY3A3c3hjWnhKREQw?=
 =?utf-8?B?T3dvYmh1WmNvZU1jd2hPVTMzQUxRN2FUbUFIWFNBVGJzcGNPNEo5WFNKMXE0?=
 =?utf-8?B?MWZxNEk0SUY3dWN2YUtsaHowcHN6T2JaeXdnQmdRV3lqNk83Vk9PMHIyWWJJ?=
 =?utf-8?B?TVBmQytqM0JNd3ZrRlR2SUJrYmNQdnE0NWhzNzJ0NkJzaThiUjZHYS9UYnNa?=
 =?utf-8?B?N2Ftdk1zVXpCVXR6ci9MRlEyc3Zmd2prTk9IOCt4RzNQeVFCeE1oaEhIeDZP?=
 =?utf-8?B?VHJTNVBVUWo5bkt6M1h4amtncStIaTQzd2dZMEZ6NkRyak83L2N1WU9Mb3dB?=
 =?utf-8?B?NStwRFhOMjMrQTl6eHpsR2xGbHd5Y0JlSTNNcUIyS25FL3BHeStIWWRCQlZo?=
 =?utf-8?B?akZoTUhrZkM0WDI3aCtCL2VXOTRWSC85eGNCT0N3Z2ZDVTY2NHh5R0dJNk5N?=
 =?utf-8?B?VC9KK1hrNDNQRmR3bkQ0WHNZc2VaNnNpNVY4UmlDZ3RvUi9EL1lWZ2NNSSsz?=
 =?utf-8?B?dEU3YkVLTFlMcExVWlBkWTg1Z0h3SWFqY09DeTE3WVRSN0lRREp3ZzBDcmlh?=
 =?utf-8?B?OThJbFdzWFVva25CamlvQmozU2hWKzg1N1BFWU1GUDRUbTVCMkNaL1ZsQVJL?=
 =?utf-8?B?aXlmQ0VOZFVNNFB4N1B6VFM1czU2V0JLd2svTkVrRWl1VjZWaDZvcXZneGNN?=
 =?utf-8?B?Um0zT3UxMFY2QitGU3l5cmNJQTJsSzhoZUJUUkl0OXhXd1FwZUMzL29lMWIw?=
 =?utf-8?B?eC9HbTZ4UWFPSTJWTFI3Um5kSU8zZnN2MjVRd09DeFIzS282WExYd3hwbHNE?=
 =?utf-8?B?cG9CVE1ON256RFNMYzM0UUc3RUIvVXFMTW8xbGxZU2NvRHA5S2YxSkNKQ3J0?=
 =?utf-8?B?NW50NGRpWjg5cFkvZXp5QWF1eG1BSEdPNGtCRzlJVVhVSitFRnJlbWxJNjds?=
 =?utf-8?B?MHc9PQ==?=
Content-ID: <75AE913D8947E3489EB96D05A71B19D2@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ebd0bb-938b-4666-d7ba-08dabece8172
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2022 01:38:57.0361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1WGrY4CPe5WUSz8ae1MltIZPP6SugPXXRgwC1LTuIz4UdoFwkB5GShzyKMhDur6wS8UXjcK3mXS+xZYTr1WnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7733
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_183907_221308_3BE4AF7E 
X-CRM114-Status: GOOD (  20.05  )
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

DQpPbiAwNC8xMS8yMDIyIDE3OjAzLCBMaSwgWmhpamlhbi/mnY4g5pm65Z2aIHdyb3RlOg0KPiBI
aSBmb2xrcywNCj4NCj4gSSdtIHRyeWluZyB0byBhZGQgcG1lbSdzIG1ldGFkYXRhKGxvY2F0ZWQg
YXQgcG1lbSBkZXZpY2UpIHRvDQo+IC9wcm9jL3ZtY29yZS4gVG8gYWNjb21wbGlzaCB0aGlzLCBJ
IHRoaW5rDQo+DQo+IHNvbWV0aGluZyBpIG5lZWQgdG8ga25vdyBpcyB3aGVyZSB0aGUgY29udGVu
dHMgb2YgL3Byb2Mvdm1jb3JlIGNvbWUNCj4gZnJvbSwgYW5kIHRoZW4gYXBwZW5kDQo+DQo+IHNv
bWV0aGluZyBpbnRvIGl0Lg0KPg0KPiBJIGhhdmUgcmVhZA0KPiBodHRwczovL29wZW5zb3VyY2Uu
Y29tL2FydGljbGUvMTcvNi9rZHVtcC11c2FnZS1hbmQtaW50ZXJuYWxzLCBhbmQga25ldw0KPiAv
cHJvYy92bWNvcmUgaXMgYSBlbGYgZmlsZS4NCj4NCj4gSXQgbWVudGlvbmVkIHRoYXQgIkNyZWF0
ZXMgL3Byb2Mvdm1jb3JlIGFzIHBlciBlbGZjb3JlaGRyIGluZm9ybWF0aW9uDQo+IHJlY2VpdmVk
IiwgYnV0IGkgZG9uJ3QgZ2V0IGhvdyBpdA0KPg0KPiBlbGZjb3JlaGRyKG1heWJlIGVsZmNvcmVo
ZHJfYWRkcikgYmUgYXNzaWduZWQgaW4gMm5kIGtlcm5lbC4NCg0KSSBnb3QgaXQsIGVsZmNvcmVo
ZHIgY29tZXMgZnJvbSAxc3Qga2VybmVsJ3Mga2V4ZWMtdG9vbHMgd2hpY2ggcGFzc2VzIA0KZWxm
Y29yZWhkcj14eHggdG8gMm5kIGtlcm5lbA0KDQpUaGFua3MNCg0KDQo+DQo+IEkgdHJpZWQgdG8g
Z3JlcCBpdCBpbiB0aGUga2VybmVsIHNvdXJjZSwgYnV0IHN0aWxsIG5vIGFuc3dlci7CoCBTbyBp
IGRlZXANCj4gaG9wZSB5b3UgZ3V5cyBjYW4gZ2l2ZSBtZSBzb21lIGhpbnRzIG9yIGFuc3dlci4N
Cj4NCj4gYW5kIHRoYW5rIHlvdSBpbiBhZHZhbmNlIDopDQo+DQo+IFtyb290QGlhYXMtcnBtYSBs
aW51eF0jIGdpdCBncmVwIGVsZmNvcmVoZHJfYWRkciB8IGdyZXAgLXYgLXcgLWUgaWE2NCAtZQ0K
PiBsb29uZ2FyY2ggLWUgbWlwcyAtZSBwb3dlcnBjwqAgLWUgcmlzY3YNCj4NCj4gYXJjaC9zMzkw
L2tlcm5lbC9zZXR1cC5jOsKgwqDCoMKgwqDCoCBlbGZjb3JlaGRyX2FkZHIgPSBFTEZDT1JFX0FE
RFJfTUFYOw0KPg0KPiBkcml2ZXJzL29mL2ZkdC5jOsKgwqDCoMKgwqDCoCBpZiAobWVtYmxvY2tf
aXNfcmVnaW9uX3Jlc2VydmVkKGVsZmNvcmVoZHJfYWRkciwNCj4gZWxmY29yZWhkcl9zaXplKSkg
ew0KPg0KPiBkcml2ZXJzL29mL2ZkdC5jOsKgwqDCoMKgwqDCoCBtZW1ibG9ja19yZXNlcnZlKGVs
ZmNvcmVoZHJfYWRkciwgZWxmY29yZWhkcl9zaXplKTsNCj4NCj4gZHJpdmVycy9vZi9mZHQuYzrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVsZmNvcmVoZHJfc2l6ZSA+PiAxMCwgZWxmY29y
ZWhkcl9hZGRyKTsNCj4NCj4gZHJpdmVycy9vZi9mZHQuYzrCoMKgwqDCoMKgwqAgZWxmY29yZWhk
cl9hZGRyID0NCj4gZHRfbWVtX25leHRfY2VsbChkdF9yb290X2FkZHJfY2VsbHMsICZwcm9wKTsN
Cj4NCj4gZHJpdmVycy9vZi9mZHQuYzrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxm
Y29yZWhkcl9hZGRyLCBlbGZjb3JlaGRyX3NpemUpOw0KPg0KPiBmcy9wcm9jL3ZtY29yZS5jOsKg
wqDCoMKgwqDCoCBhZGRyID0gZWxmY29yZWhkcl9hZGRyOw0KPg0KPiBmcy9wcm9jL3ZtY29yZS5j
OsKgwqDCoMKgwqDCoCBhZGRyID0gZWxmY29yZWhkcl9hZGRyOw0KPg0KPiBmcy9wcm9jL3ZtY29y
ZS5jOsKgwqDCoMKgwqDCoCBhZGRyID0gZWxmY29yZWhkcl9hZGRyOw0KPg0KPiBmcy9wcm9jL3Zt
Y29yZS5jOsKgwqDCoMKgwqDCoCBhZGRyID0gZWxmY29yZWhkcl9hZGRyOw0KPg0KPiBmcy9wcm9j
L3ZtY29yZS5jOsKgwqDCoMKgwqDCoCBhZGRyID0gZWxmY29yZWhkcl9hZGRyOw0KPg0KPiBmcy9w
cm9jL3ZtY29yZS5jOsKgwqDCoMKgwqDCoCByYyA9IGVsZmNvcmVoZHJfYWxsb2MoJmVsZmNvcmVo
ZHJfYWRkciwNCj4gJmVsZmNvcmVoZHJfc2l6ZSk7DQo+DQo+IGZzL3Byb2Mvdm1jb3JlLmM6wqDC
oMKgwqDCoMKgIGVsZmNvcmVoZHJfZnJlZShlbGZjb3JlaGRyX2FkZHIpOw0KPg0KPiBmcy9wcm9j
L3ZtY29yZS5jOsKgwqDCoMKgwqDCoCBlbGZjb3JlaGRyX2FkZHIgPSBFTEZDT1JFX0FERFJfRVJS
Ow0KPg0KPiBpbmNsdWRlL2xpbnV4L2NyYXNoX2R1bXAuaDpleHRlcm4gdW5zaWduZWQgbG9uZyBs
b25nIGVsZmNvcmVoZHJfYWRkcjsNCj4NCj4gaW5jbHVkZS9saW51eC9jcmFzaF9kdW1wLmg6wqDC
oMKgwqAgcmV0dXJuIGVsZmNvcmVoZHJfYWRkciAhPSBFTEZDT1JFX0FERFJfTUFYOw0KPg0KPiBp
bmNsdWRlL2xpbnV4L2NyYXNoX2R1bXAuaDrCoMKgwqDCoCByZXR1cm4gaXNfa2R1bXBfa2VybmVs
KCkgJiYNCj4gZWxmY29yZWhkcl9hZGRyICE9IEVMRkNPUkVfQUREUl9FUlIgPyAxIDogMDsNCj4N
Cj4gaW5jbHVkZS9saW51eC9jcmFzaF9kdW1wLmg6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVs
ZmNvcmVoZHJfYWRkciA9IEVMRkNPUkVfQUREUl9FUlI7DQo+DQo+IGtlcm5lbC9jcmFzaF9kdW1w
LmM6ICogTm90ZTogZWxmY29yZWhkcl9hZGRyIGlzIG5vdCBqdXN0IGxpbWl0ZWQgdG8NCj4gdm1j
b3JlLiBJdCBpcyBhbHNvIHVzZWQgYnkNCj4NCj4ga2VybmVsL2NyYXNoX2R1bXAuYzp1bnNpZ25l
ZCBsb25nIGxvbmcgZWxmY29yZWhkcl9hZGRyID0gRUxGQ09SRV9BRERSX01BWDsNCj4NCj4ga2Vy
bmVsL2NyYXNoX2R1bXAuYzpFWFBPUlRfU1lNQk9MX0dQTChlbGZjb3JlaGRyX2FkZHIpOw0KPg0K
PiBrZXJuZWwvY3Jhc2hfZHVtcC5jOsKgwqDCoCBlbGZjb3JlaGRyX2FkZHIgPSBtZW1wYXJzZShh
cmcsICZlbmQpOw0KPg0KPiBrZXJuZWwvY3Jhc2hfZHVtcC5jOsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZWxmY29yZWhkcl9zaXplID0gZWxmY29yZWhkcl9hZGRyOw0KPg0KPiBrZXJuZWwvY3Jhc2hf
ZHVtcC5jOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxmY29yZWhkcl9hZGRyID0gbWVtcGFyc2Uo
ZW5kICsgMSwgJmVuZCk7DQo+DQo+IFRoYW5rcw0KPg0KPiBaaGlqaWFuCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
