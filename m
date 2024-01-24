Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E0DC46CD2
	for <kexec@archiver.kernel.org>; Wed, 24 Jan 2024 06:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jWoemmsxXZBJJo7x+g8xhq64NPov+gRFh0pCbus69XI=; b=eyFBvFbZXjeQ1j
	/1VHahz/pHoae4kf/El1ZAEneerOrfE9KX+faZcLtUdAC15MMcXRr7WZWZLpjqhISzQLuTd6vpS3F
	P7V8hI+Uq3DpUOYxp4n8e2UwldpQg+crhox7NPC0Tsl6wT7v8Yg/qgmfp1pbELCAF760pGrsuRsLg
	D4UxnWIvLR8fzmhUclM+8gIJUrnSbKRzmdYz7j+sGFgBTClN45bWXCwJEypuRwT+ZOVVQ0Z96Jy9s
	aqpguxXOSePDZFIQMUUfFjoZi8fxIO4CtHFFOp5EZu0szEHojYAyAYxq7j/skcQfxu0IfcTo/99wG
	XPcewMXEw5heXgq5GrCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSWzf-001liA-0V;
	Wed, 24 Jan 2024 06:44:15 +0000
Received: from mail-tycjpn01on20601.outbound.protection.outlook.com ([2a01:111:f403:2019::601] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSWzc-001lhU-0z
	for kexec@lists.infradead.org;
	Wed, 24 Jan 2024 06:44:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMPMBsQYlKSsg4YharCeJyUUQ2xfaBFPQsg6qtdRicS2VeNNcSqBaMnWpaKpZOnDqMk33yht5qBMxchlQRFU8Ipx4oc/TByQnYUBJiohdlgZD4B9/ZkZTdZn+Y5yLqwKFeJCeowVQDrF07nNAklqSwN7/GP05l+q6CMmcMiIKyWVSvMsgl4BmChSYeyBK6sNwXePvNcxl6/rhP6MStNCd/3EnMZxPkWAb/LZUdue2Jna5d6RHGEYLwiJYOSoHaPMyJTwvW7XVa+hNpfip+oiMhwkTZV9T4K5uq/Kz9VyW//vvRfZu6QaQBy1ovarBVrtCYcjFLl9xKH8J4lzR3tHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmfearqLp9t7F8krDWd6B2tbiOZBaf09sWqU6xjYm9g=;
 b=Inr03Z29yA08jgpi9nMvEhx2LOXYdYxCt574XMP7ex1fXsvh7kFYATCf6dgpJUOekLuEcF65AFPAG8zhJuWEux5RBghRZ4TRsZonWssBFTrtZ/X54wVCMmFxSjRUyVjan0px1efJjhHS3zPWSG7hJeIIOExtMurF02XZLy1Ztb31hLzJdHMPIj5FqyEW9mwfngcb8t9k50vOuFgIHwUgvc46qUn0+l588mFWxCG47mKZoKrZiPIsTIqBCaKm3bpd97hyQ8lCc+C+Ooif7CRp7q1J2TaKLwVfVd8MhcLNDszQxptSMNNwVcjTSMoC01AAsv1pA6Jz+TA4wQlrTSP5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmfearqLp9t7F8krDWd6B2tbiOZBaf09sWqU6xjYm9g=;
 b=h/mUe4JhNamZiJIBIsrhglWc8zj7tfzG453dybQ0oC8wIAlNYGSu/yVqQuCuY2v+g6g3tbgnZ/Lb4hnsvywrIdXySNPZmaMjZHt/bZhszXevi4qUtx1Q/y8EFE/M/Lz3t6F3gM4NOHefR9jaEciiwblHBkdsm35/20ImHGK6IqG+p4qs5CYyGhlOxQcK34Qoj6FP0d6/CN40BwiG4Uvc9kGcGVhQ0eFn4w2ynJHAmarDiZDuD/dUM5p8gLnuI9UKO2gMd1Ttt9Q5u9fgu65pvBZ3dyFbFlfB6N6jwwTqSowdNtvluc8G5f4Hd4fIJLVRXioav3qF6rSRltUCluL+0Q==
Received: from TYWPR01MB8608.jpnprd01.prod.outlook.com (2603:1096:400:179::5)
 by TYYPR01MB8230.jpnprd01.prod.outlook.com (2603:1096:400:110::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 06:43:54 +0000
Received: from TYWPR01MB8608.jpnprd01.prod.outlook.com
 ([fe80::ce3c:d74a:8b07:633d]) by TYWPR01MB8608.jpnprd01.prod.outlook.com
 ([fe80::ce3c:d74a:8b07:633d%7]) with mapi id 15.20.7228.009; Wed, 24 Jan 2024
 06:43:54 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Edward Chron <echron@arista.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "colona@arista.com" <colona@arista.com>, "echron@gmail.com"
	<echron@gmail.com>
Subject: Re: [PATCH] makedumpfile add dmesg PRINTK_CALLER id support
Thread-Topic: [PATCH] makedumpfile add dmesg PRINTK_CALLER id support
Thread-Index: AQHaOc0qoq8JKHKVGkK1Ria1lsXYC7DUQsaAgBRrAgA=
Date: Wed, 24 Jan 2024 06:43:53 +0000
Message-ID: <8640d3e2-81b5-d867-7a72-cad216208dfd@nec.com>
References: <20231228203326.9271-1-echron@arista.com>
 <97e8429c-0631-a085-f0c5-c1af91eb86e2@nec.com>
In-Reply-To: <97e8429c-0631-a085-f0c5-c1af91eb86e2@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8608:EE_|TYYPR01MB8230:EE_
x-ms-office365-filtering-correlation-id: 7f3396d3-cae0-4a5d-250f-08dc1ca7d510
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wusF1TkwFMNKo6QMYovokzKE9dQWAAKSgzy86YF8MEqjowtopu9MtcSiFkKz0mEeW2IJTKlbcoPaRK9GMXBgD/+Yi0N6E7IhjnUb8uZ8bnQLqhI3/A/ZcQN2tXebX6rP3btF44z6RnHCqEN955emA8fE9dBuNAbKCLd9Zl4uVJW41qRizwSfgBLz9xrWic0kL9lsuD76dly4dqLXqFvJ6TdFwwMihO58iH5xnfzPgaTw7672vM5mIMkFP1qpRU78AXgWBKeI9LU9Rjm76HijJw5X+cSkjQWO/knraxcuPZqF8Vjnkb4LVGeV+/Fi57AsJoSNoAKxW8kt1653Y0HACypCKsQ94pE5JObwnGTzMM49c4LGmdkokQSAuieyht3q5c308xtrYTMfo8v31DreolV5lCghAQIRNrW0mc7CS/tH/W3FtYUqxf7GsZHio5q7I3j50x5zutiJlQqv9RfKARTsOVQpQvp7lwYvp8yhUTt5A/lgx9/so45qbNrWISlqTbTFBebSL17AK/48cFBq5bpGCT51mCIX+3tTsMQFPgbYr2xaJw5YTvAnzp6eK9Vp2QOCdl1YNc9t0pCwLgOrkpjjLmB2rizioMpD7Y7h7O3wsynfVMCUfQBjQY2rZ6csRsoe2CHBw0CRTMfvaniC9x8cUcuszHxf3wgZBOGwBVY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8608.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(122000001)(38100700002)(38070700009)(36756003)(85182001)(31696002)(86362001)(82960400001)(316002)(66446008)(54906003)(64756008)(66556008)(76116006)(110136005)(66476007)(5660300002)(66946007)(2906002)(8936002)(4326008)(8676002)(26005)(2616005)(71200400001)(966005)(478600001)(6506007)(6512007)(55236004)(53546011)(6486002)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFRqblB0ZlpGUnU4UzlmT0VVRHlsWlhXZ0JhT0dsaGJNaE42VU1Oc21ERlFD?=
 =?utf-8?B?NnBnVWtVMEhrVHp0MTUzQjdNMFliaWE2QzJsUkx1cGFxOC9WQ01IenArYUJM?=
 =?utf-8?B?UGJRQnl0YndLc2pXU1VPeWJ5SUpqUXJPa3JCRUxTcVdTSFQrcXc0QzU1RFNF?=
 =?utf-8?B?U3dRRjZuWFBSWVZncUQ4eHlvbWx6TDMremR1MjlFNE1PM1oxMVYrKzN4OFBr?=
 =?utf-8?B?MStUTHVZWms2WGd4SXNwM2RTanhxQXlyU3pvYm12Y0FTSmUzTEczbThqU1pZ?=
 =?utf-8?B?bThtWGU2cSttU2xOTGdjNTlVQ0JNcnkreWlMQ0pFTUNrb3FwR2R3ckN1ZStD?=
 =?utf-8?B?ZnQzNEJOa1ZQUTBpUE9URzVZajkxbTJSNG9WWGRVL3RaRXZ4NWhkWWY2YU1w?=
 =?utf-8?B?NGJrM0VYRDV0Q1VuQnNzN2dUWjlPM2FwaHRWOWJROGxkcVVFSkZPalNDSTVQ?=
 =?utf-8?B?TVVjTkdISTE1dmV1bGFLRWplRlFIdTJrZElyQlNGQ2w1ZUN2cnNxaFJqYVlY?=
 =?utf-8?B?dk85KzBsZDhCaUJpdWpnOWgrREpJZDQ0b2NrUVRpVzhacmFabmxsS29hTnc3?=
 =?utf-8?B?NUJQczNrVjdUMDVFam84REN6U2hlUFgvei8zRGVGTGdJSCtMWlFIQ3Z3WWRa?=
 =?utf-8?B?NWF4N291ZlRHblZjZ2o5QUdRV1VXaDczcTdGdEIyTHM4YVkwditabjNsNGhy?=
 =?utf-8?B?ZCtGdytuMVZoZEEzQ3JCZWlEd1BiY0l5QlpwRmlpcEk5Wkk4Ly9nckhSZDBZ?=
 =?utf-8?B?QWx3TXcxOEZWZEtUUGFaeUxXSUtYbDNWYWdXQXpoVmVjR1g1MzEwdEFJZ3lV?=
 =?utf-8?B?S0E0MHZpS3NITFUrRDMrRVRMOUIvb3E0Wkp5K0g1azNqS3Y5bmUzc3dqVmR0?=
 =?utf-8?B?NjBub25nVTJnL1BUaitvSXJEaGhZR3gwM3YyMUdhQlp4Rk1ta1kwMytWcGJo?=
 =?utf-8?B?NlROY1N3S1B2U2lZT21aREwvcnV1K3BFVnFzNCs1N1lwOFZKcEdEaDVsT2Ro?=
 =?utf-8?B?NWhiMytyUVhETDRMRkF2czE2UXVVTEVuRzFHVzlsS1JITWZjbDU3VGVGcnJq?=
 =?utf-8?B?K2JBRENTOTdPSFM1ZkNJYzNSUGhmczJBQXd6d3NoOFlCVytHUkdqU0g3M3Q5?=
 =?utf-8?B?Um1pSlA2RjJ6QnU5UGhTVzdaVlRKWVUzV0J2ZzdhSlVIN2pkdWhQQjJwVW96?=
 =?utf-8?B?SDFKVEVNQkVDeXpzWUpLNEtBcHkvamFXNG9YNWEzMXp4S09DS3hvU28zenVG?=
 =?utf-8?B?MmZCeWRUWXNoZnFJWkJyQjFwM2VocVplRmxpVWp4eVFnV2dJNzBHcVRuN3dq?=
 =?utf-8?B?WCtuUmROZU56bTBZRGZSN2JvOGZaRUtORjBreis1bU1MbUdLWXhnUnlvNTFx?=
 =?utf-8?B?UDBIY0g0Y3BzU21QS21lekx3OFB4YWxHQUJmV3hzOWtON0FUMXNkTGk0MUFE?=
 =?utf-8?B?cysvNmlaa25hZVFLdVpORGdUaVpNM2psK1dIamlqMWZNR1I2R1ZrRnB5aGRC?=
 =?utf-8?B?d2Nhcm05K3AzMFlSc2dGaExDcEcrb29rT0lIL20zcE1kZmxmQWd2SVRWeDFq?=
 =?utf-8?B?ZEY4MktobUVEanNjNW5SVzlBeWljOWpsVWdkditIWk5xS0pZTjZicnM4bmox?=
 =?utf-8?B?YWh2U3dPWEVScC9INzRGTjhGb3ZkMFNQakVEcXRkUUR0TWhYSHdkdmdzRzVC?=
 =?utf-8?B?VFdWdnJxWnpNbEROcGhjbm45ZmcyVWFiOGVPS1I1aStraHBLeThDMnpndk1R?=
 =?utf-8?B?dHBMZUNoVlIyRm95R3c1eU9rQmZGUVVQdG03MzlKRDJiS0htWGp5Z2NEeEd2?=
 =?utf-8?B?YTE0RXU4ZituQ25rc1RobmJ3cG5NVjRldUF5em1Wa2MzdnNiSXhhbG9RSE0w?=
 =?utf-8?B?UWdQMjh2WVBnU3lMOHZVZXlSOWtKalhXb1NNNDI1dUdOUW5QWHFzT21rOU5I?=
 =?utf-8?B?eldkY0JkSzJRWjhoZGV4SUtib2VBNUhTYk9UbmVyUGpSQ0VlSTZsNjZCUHda?=
 =?utf-8?B?OUFzOStrdHYxQUo0dEN1WUN3L3hveHR6YnVMT1BwRWtDREZ2OU0zc2VwZVJ6?=
 =?utf-8?B?NkJiOWNZVERGSkRXT3NWUmxLNXNBb2dxM3FoczZNeGZGaGs1dzRaTU5WZUhL?=
 =?utf-8?Q?oG1YaoPXiwjefShboyxhKLTgy?=
Content-ID: <D0BFDEEDB9AFFC4D93D0783A0398E3B4@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8608.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3396d3-cae0-4a5d-250f-08dc1ca7d510
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 06:43:53.9263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rz1maRFnKDrMJGvVFA8sNEnSbgLzPtIYlulT+N0keArAviF3EXaSht91iS3YrqdyYveuigtTsK4wMnpN0/aGyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8230
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_224412_592520_2B205395 
X-CRM114-Status: UNSURE (   9.76  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gMjAyNC8wMS8xMSAxNTo1NSwgSEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSkgd3JvdGU6
DQo+IE9uIDIwMjMvMTIvMjkgNTozMywgRWR3YXJkIENocm9uIHdyb3RlOg0KPj4gU3VibWlzc2lv
biB0byBQcm9qZWN0OiBtYWtlZHVtcGZpbGUNCj4+IENvbXBvbmVudDogZG1lc2cNCj4+IEZpbGVz
OiBwcmludGsuYyBtYWtlZHVtcGZpbGUuYyBtYWtlZHVtcGZpbGUuaA0KPj4gQ29kZSBsZXZlbCBw
YXRjaCBhcHBsaWVkIGFnYWluc3Q6IDEuNy40KysgLSBsYXRlc3QgY29kZSBwdWxsZWQgZnJvbQ0K
Pj4gICAgICAgaHR0cHM6Ly9naXRodWIuY29tL21ha2VkdW1wZmlsZS9tYWtlZHVtcGZpbGUNCj4+
IG1ha2VkdW1wZmlsZSBJc3N1ZSAjMTMNCj4+ICAgICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9tYWtl
ZHVtcGZpbGUvbWFrZWR1bXBmaWxlL2lzc3Vlcy8xMw0KPj4gUHJvamVjdCBPd25lcjogS2F6dWhp
dG8gSGFnaW8gPGstaGFnaW8tYWJAbmVjLmNvbT4NCj4+IFJldmlzaW9uOiAjMSBvbiAyMDIzLzEy
LzE1IHBlciBLYXp1IGVuc3VyZSBzcGFjaW5nIG9mIGRtZXNnIG91dHB1dA0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBtYXRjaGVzIGRtZXNnIC1TIGFuZCBuZXcgZG1lc2cgY2FsbGVy
X2lkDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG91dHB1dCBmb3JtYXQgKHNwYWNl
IGFmdGVyIHRpbWVzdGFtcCkNCj4+IFJldmlzaW9uOiAjMiBvbiAyMDIzLzEyLzIxIHBlciBLYXp1
IHVzZSBOT1RfRk9VTkRfU1RSVUNUVVJFIGZvciBjYWxsZXJfaWQNCj4+IFJldmlzaW9uOiAjMyBv
biAyMDIzLzEyLzIxIHN0cmVhbWxpbmUgY29kZSBmb3IgcHJpbnRpbmcgY2FsbGVyX2lkDQo+PiBS
ZXZpc2lvbjogIzQgb24gMjAyMy8xMi8yNCBwZXIgS2F6dSBtYWtlIGNvZGUgY29uc2lzdGVudCwg
ZHJvcCB0aGUNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ0FMTEVSX0lEX1NJWkUg
bm90IG5lZWRlZC4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJldmlzaW9uLiAgTG9va3MgZ29vZCwg
d2lsbCB3YXRjaCB0aGUgdXRpbC1saW51eCBzdGF0dXMuDQoNClRoYW5rcyBmb3IgdGhlIGluZm9y
bWF0aW9uIHRoYXQgZG1lc2cgZ290IHRoZSBjYWxsZXJfaWQgc3VwcG9ydC4NCg0KQXBwbGllZCB3
aXRoIGEgZmV3IHR3ZWFrcy4NCmh0dHBzOi8vZ2l0aHViLmNvbS9tYWtlZHVtcGZpbGUvbWFrZWR1
bXBmaWxlL2NvbW1pdC80OGJiMWUwODkwNTYNCg0KVGhhbmtzLA0KS2F6dQ0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=
