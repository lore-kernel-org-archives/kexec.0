Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F78CD68FA
	for <kexec@archiver.kernel.org>; Tue, 10 Oct 2023 07:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h7T5kOsqIyuZUJV68b/2T5TF9jexqeJ3pUKQAhO4hn4=; b=1jEaFRpvKWhBsB
	TeaXMl3PFoFquT6r1wOAE1C5ICYMLhU8lSkap1HuCbtMLKTg9y5j2ET0V64ETRSXWSUbN+pcErUWC
	5ybWA5GLwYjkwayrB0k/aaSn1YoKDPKamRC1rljQh4RTjWGVbm/mU75VM23S0FQonN3Se/DsekWw3
	/XpUP5TPVf8ADVbjD1iuhQnEftRECY9rmFCSMOy3lbrtpJTmQ9qSTRUBDxYvKJCByNifngxuwwaGG
	FcQDMpg9mejxT4YAf/b4W76vt85szkygjLFjTfJvQiM8TBleB/RoKZ6TQQ2+Zcz/9gAjHqovvJUvs
	+mL5gkc72v1PQFY9TPSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qq7Ye-00ClSP-1V;
	Tue, 10 Oct 2023 07:53:36 +0000
Received: from mail-tycjpn01on20606.outbound.protection.outlook.com ([2a01:111:f403:7010::606] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qq7Yb-00ClQY-1C
	for kexec@lists.infradead.org;
	Tue, 10 Oct 2023 07:53:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InjHFlx+cIz1YxH6kWn4010DiIxfX7dPHLCCQPtPzvMxG7Ebxt+Ps2wn4/RBQiPU4a4wTy11DWT2FLWSIiUgK+4euHjR8I+9IeMX8v/ewdjNYWRiEr4h5hxbCVTj2nVB7M8DUZo/ZFLsAWb+sxfcEEKA4m/GxN/J8NHMst9+e9Tr9scuIYhKIYALwM9yi28ZEtGnoH3NunAIE1em8wUXDWuqnfy6+5rLHCUxJm/Jls+vW0uW3//vk2Mbza+zewXPo9vzssOtFgEq5Wx1JpNoO9+mg8j1X5zpKOvFQWoyMTb2mamUzdEifc1HJeSgauDWqwGRfeGhWtBdckK//Px42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9d17+kYXATIp3NUIpJSSEKj9HENwRR5LiTxKpPhFtwk=;
 b=d11jnAoEIe01OQAVnv1WAUgzTDJws4UQ0aWPZfTRM0r533x8GdbAjCBPZE7VwSjyqmnNR7eRuZH0aCz5FKAhurBAmRS1/WgB496443vt4aQAvpxSwQFSK+FIyVS2olL2nPrPBflkku0pNrSYgpuadiTLLLBVDU7jVPOg1ZYZMrPMwN39oW+tbYb5+G59DNFgT406rxpoIWu1AAT94xkfDXiGzhGdVIw81QPP2KV39OpnOyNWqedGAEcLOpgZy7AoO5PhPUnG0n7BmVpFjRX1V9c/fyZ0BMYMgnRHwsngduIqn2h8SICbapXewEuYEF3LUAMe+oTYKAwcOU+NGyyImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d17+kYXATIp3NUIpJSSEKj9HENwRR5LiTxKpPhFtwk=;
 b=Zz7me4Le5DeFtqT94NF6IgortCnOdm1kndd/bgqAOR+res+UnP1C+Tqg9yEnApD1d7ntpXwTMpRahYme43IfAQIdKEdPvYMKrkYEZSfyJ+wfQOHRkCFohiD7cDA1LqReTuUfV3TJq68IEb8VHQvXPL9VIlgqnpVnZauC57c6iy4=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYWPR01MB8639.jpnprd01.prod.outlook.com (2603:1096:400:13c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 07:53:24 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::114b:1c1a:b05f:8b72]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::114b:1c1a:b05f:8b72%5]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 07:53:24 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Song Shuai <songshuaishuai@tinylab.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH makedumpfile 0/2] Add riscv64 support for makedumpfile
Thread-Topic: [PATCH makedumpfile 0/2] Add riscv64 support for makedumpfile
Thread-Index: AQHZ8TR3j0iN0urU5U6xRgHvpfHfSLA3gAWAgAYpTQCABRH0gA==
Date: Tue, 10 Oct 2023 07:53:24 +0000
Message-ID: <be6675f3-067a-c172-d8f7-d2768ff344d8@nec.com>
References: <20230927111822.180630-1-songshuaishuai@tinylab.org>
 <b7d09d33-c606-0c76-8865-e4e43a5d43ce@nec.com>
 <B9C2DD515F0AF3F5+86a54502-04b4-3f3a-0b70-7bb0daf3203e@tinylab.org>
In-Reply-To: <B9C2DD515F0AF3F5+86a54502-04b4-3f3a-0b70-7bb0daf3203e@tinylab.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYWPR01MB8639:EE_
x-ms-office365-filtering-correlation-id: ad1e323b-b173-4c93-5b3c-08dbc965fb2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xWI0NuopV3ct8vyaXlONVMgPDEo8lBW4vpoW/dJsVpPgajDhQ8ox01rJJbfTYGV6aWlAQ5H7rPcz7vf6TmQWoiIhIhAL63IY6S9y8lEt8Z19HIvA/d5JmCdJnXGM7bD0US3nGO7dNfJG6y7mt20sXiKIU+EE/Y01PmTxIgY6J3eLwWfHQghqVz6cKWf9IrOrhMaFOnBQ4NP8FMpXtl9rRyvQ1FLPDMwMdZ+m63aK5LDJugxa8Wx4teKeQScuUNqq1HFGBZXr//WFw/dbmloVYC/0w9fW8eD2r2mTEK//eCooS9hQ8J+m0uW3fNUC4+2EBvDD4q1P7vvvh81cQR0+TfY2nxKXFx5QMFBtGFf9+wpz0No2GPtRux7Oe3lIuahmzA3jxq/mTmkNsq6p2/jffM1gUyQtR8P/RqeGj4jNDBENDyDqhbWh6HkMI+V7JpTRRYTv0foTWZKo0oO5PE2BW0dPtRQ+YH8mY1lEHn7yrkkb+z2VLZIYcSWhu4U38ku4jrfYQYGOLcGqMgHkC/x5xm01Kk4Rhj5hVGfV556Aq/2zeBLDZwaox/nJTqWY1jzxJj3WGYvwyu4uadrKysRjykuTqfFJqTS2+t283NBj4jPRv+XPSPOf/2oJdRyuwQy3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31686004)(53546011)(478600001)(6486002)(966005)(6506007)(6512007)(38100700002)(82960400001)(31696002)(86362001)(36756003)(85182001)(38070700005)(122000001)(2906002)(83380400001)(2616005)(26005)(71200400001)(76116006)(66946007)(110136005)(66446008)(8936002)(64756008)(66556008)(66476007)(316002)(8676002)(41300700001)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWNZeXlQYlpIZk5mdnlnK1JUanFBenRVckM3NldPOGhqTXpPU1N5blVBbElv?=
 =?utf-8?B?WmdyYnN0dzlqM0hIYmdGN0dpOGx6bk9zRld1K01sN0RiNFZ2T3p3SE9QOUUy?=
 =?utf-8?B?SDJqV2RPZ0tNaW1pTHVQa3M1T0Z2aHI2alNQc1E3dktNNkJvMmNtRCtOKzBP?=
 =?utf-8?B?VW9vZTNOOFZ6TzFlK2pmUGhwMEFIRWUrR0VpZmNxWThXbGF5ZWUydlNKVWJQ?=
 =?utf-8?B?L2NsT2RMRkdtWGJLZEZ2c1FBZzN4dlh0Q21kb0E1OXd1WFJMZC9NZHRDKzBs?=
 =?utf-8?B?RUNqTWpkZlZ4MFB6OHo2anlNME1IQnFiZ0JzTHZNeUsxR2hwOExuU3lEUlZn?=
 =?utf-8?B?TFNLMEkwRzA2Qm9XbXlNcWRYNlpMSEtUVTl4ZU1xYkpTRkpmOGY0Rmd3VitU?=
 =?utf-8?B?K2hKR0w4dnV5YWVKd3hCYWJIOGp3eWZmSlpMWHZuTVQrU3IxbU1YMU4wZDJP?=
 =?utf-8?B?WmdEb0RTdk0yNElWNXZORjlLOG1GVjFIeGFHS2xhcTBWUnZIcnI3bzZpTEtB?=
 =?utf-8?B?KzR5OGY0RUhjWHJoeGdpb1hYOWY3dU9Qb1hOeXFZQ05LU0l2a3M3ZlFaY2gv?=
 =?utf-8?B?SzU1MVVOa1g2UXgvOEE1VFIxaTFQa1BWZlpuNWFDb1lIMWk5R1RGNVZzeGha?=
 =?utf-8?B?Z0dWcVNab3IxUzUvM084M1hGYTZzTkNlS2xQbTMvSHljaWV6V3ZjbEgzd1pB?=
 =?utf-8?B?UFVLcUpLNlVVQU5DOWhRUlo0S3R5RHJuQnpIYmFmeitqYlBqQ0U3dnZ1QWcy?=
 =?utf-8?B?c1YzSmY4UENDV0gwck5TcnVMSzViMEFmMlJFY2FVa2VzeHhTLzJiSDRzQ2k2?=
 =?utf-8?B?NUhJbHp6SzcxeDY3cTFBczc5TmdrakVLY3FUK0FLL1AxalhzaEVrNnBBWmZI?=
 =?utf-8?B?K1lKWnBjMUZFZXJZbnVBVHZObGx0WlZNV0hjVDl3MTk3cE1xdE5pNlpqdktL?=
 =?utf-8?B?clhFcVZmVE5GQzFpenRueHVlcXJzYkYzcGpZU096UkFhbWZxcUV5WXppOG1V?=
 =?utf-8?B?czY1RU52M1d6Mi9iRW5YYUhJUkFTRldSRWFHK09QZm4zYjZqcWhMVTRpdTJ2?=
 =?utf-8?B?bjJ6VDB2TURUemR2dElqSzVFWUxLMWl5YjZQaGJlTVZtcHJwSkZhSlRGdENx?=
 =?utf-8?B?K2NsZk1GVW9pTEZ1Ui8zRlNxd0t4TTJseXd4dFlDbWV2Q2pTNmhyZlJIeFNn?=
 =?utf-8?B?Ull5T0VSa09iZU9zcVZKdmMwZzRQeEJEN1phR2N1bmpBb3l5aTZTTmZNSk5Q?=
 =?utf-8?B?d2VIWHRYR2FMb29namlGeVhPQW8zNk1TQnVwektlRUxqVW1OTWdJS1ZxdkFI?=
 =?utf-8?B?dWcrSVZ2eE8zNTZhK2F4ME4xV1ZTYUlsM0FWUk0rWDhzSDlpL1FkM3c1dzBW?=
 =?utf-8?B?VDV1MWdEajR0YjREWUl1WVNORlVKRllmeThnZG53dG1HY1F0a1J5MU90cnhN?=
 =?utf-8?B?TzA4Z3hERWM2ZlFZRzBxVFZWTDVPZGFJRUoxb1l4Ui90dk8rT2ZDYjg5NW9a?=
 =?utf-8?B?RFhZWTFhNThIRTBHdkhLeFhNbmpGWHNlSzJDOUFFT3RiaVBPWTQ4L0ZTSk9X?=
 =?utf-8?B?UDZ0T0hkeGpjZG00M1B2cmhlWlg5RENKNTZOTk1yYzRweHpyTkVOeUJxVEJi?=
 =?utf-8?B?MGlhVm9oKy9TSzI5Qk1LZG1ha213Ry9BeE8wN2VuZ2RtYU9mM29JUmo5UFlN?=
 =?utf-8?B?MFJ5SkpxWFR5WlRvU05vZ2k3MVNKS2tSM1gyTFRub2NnR3IxdldCVGhESUI4?=
 =?utf-8?B?U2VMazB2QjBadFFiMmJnOXJiU2VzekRxWUlkb2t4SnBQOFF4Q1N0NnlQNFh4?=
 =?utf-8?B?dk9qRlI4ZThVNnNPRU84SzQvOUFnOW9MMFlMbk53ektRSnc3d0svN2srSnh1?=
 =?utf-8?B?SUxaalowRTR0R1ZEZE55ZkxlV2crZHRDTUxuWEJ1WEI2bm1PeXhrWUFZSThH?=
 =?utf-8?B?dTdHdk5sWkJ5YnFXWVMxUzFld0MrSyswSXhBbm83TFpORk1LUFlHaUlobXQ1?=
 =?utf-8?B?dzJqUEsrUjRod0xyUjI0Zk13NGtMaHhRQml6ZEdWejZzdWdVM0s1Yi9NdzRq?=
 =?utf-8?B?U0hsRFRnVlJSNkVaQzZuYXhkRklMTEQ4TUxMVVNsYnp5VWxJZkFEaUJ5d1ZV?=
 =?utf-8?B?bDB4ZUtiSis2Q2xPRTJYdGR3TjRWV0IzbUVVcVptZGpNMlJwb1pVTkkwK2Ju?=
 =?utf-8?B?OEE9PQ==?=
Content-ID: <B43A2FDBAC579248B8D83B6215D5D9AF@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1e323b-b173-4c93-5b3c-08dbc965fb2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 07:53:24.6007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c47RlgIwZ+PKqjdn0IZlRkAGQJoDce7J3VGsnyWLj//37dJqA++3xLSmOIy1V6dHU7tzpMfk0rVLzOpjgUp44A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8639
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_005333_796326_75217E7C 
X-CRM114-Status: GOOD (  21.95  )
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

T24gMjAyMy8xMC8wNyAxMToyNywgU29uZyBTaHVhaSB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAy
My8xMC8zIDEyOjIyLCBIQUdJTyBLQVpVSElUTyjokKnlsL4g5LiA5LuBKSDlhpnpgZM6DQo+PiBI
aSwNCj4+DQo+PiB0aGFuayB5b3UgZm9yIHRoZSBwYXRjaC4NCj4+DQo+PiBPbiAyMDIzLzA5LzI3
IDIwOjE4LCBTb25nIFNodWFpIHdyb3RlOg0KPj4+IFRoZXNlIDIgcGF0Y2hlcyBhZGQgcmlzY3Y2
NCBzdXBwb3J0IGZvciBtYWtlZHVtcGZpbGU6DQo+Pj4NCj4+PiBQYXRjaDEgLSBBZGQgcmlzY3Y2
NCBzdXBwb3J0DQo+Pj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+Pj4NCj4+PiBUaGlz
IHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgcmlzY3Y2NCBpbiBtYWtlZHVtcGZpbGUuDQo+Pj4gSXQg
aW1wbGVtZW50cyB0aGUgInZ0b3AiIGZvciBrZW5yZWwgbWVtb3J5IHJlZ2lvbnMNCj4+PiBhbmQg
c3VwcG9ydHMgU3YzOS9TdjQ4L1N2NTcgcGFnZSBtb2RlcyBmb3IgUlY2NC4NCj4+DQo+PiBDb3Vs
ZCBJIGhhdmUgYSBsb2cgb2YgbWFrZWR1bXBmaWxlIHdpdGggLS1tZXNzYWdlLWxldmVsIDMxIG9w
dGlvbiBmb3INCj4+IHJlZmVyZW5jZT8gZS5nLg0KPj4gwqDCoMKgIG1ha2VkdW1wZmlsZSAtYyAt
ZCAzMSAtLW1lc3NhZ2UtbGV2ZWwgMzEgdm1jb3JlIGR1bXBmaWxlID4gbWtkZi5sb2cNCj4+DQo+
PiAoSUlSQyB0aGUga2V4ZWMgbWFpbCBsaXN0IGRvZXNuJ3QgYWNjZXB0IGF0dGFjaGVkIGZpbGVz
LCBzbyBwbGVhc2Ugc2VuZA0KPj4gaXQgb2ZmLWxpc3QuKQ0KPiANCj4gU29ycnkgZm9yIHRoZSBs
YXRlciByZXBseSwNCj4gDQo+IGhlcmUgYXJlIHRoZSBsb2cgZm9yIHRoZSBTdjU3IGFuZCBTUEFS
U0VfRVhUUkVNRSBrZXJuZWw6DQo+IA0KPiBodHRwczovL3Rlcm1iaW4uY29tL3pjZjk6DQo+IA0K
PiBhbmQgdGhlIGxvZyBmb3IgRkxBVE1FTQ0KPiANCj4gaHR0cHM6Ly90ZXJtYmluLmNvbS90ODlr
DQoNClRoYW5rIHlvdSBmb3IgdGhlIGluZm9ybWF0aW9uLg0KDQo+IA0KPj4NCj4+Pg0KPj4+DQo+
Pj4gUGF0Y2gyIC0gcmlzY3Y2NDogQ29ycmVjdCB0aGUgcGZuX3N0YXJ0IGZvciBmbGF0bWVtDQo+
Pj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4+
Pg0KPj4+IFRoaXMgcGF0Y2ggdGVtcG9yYXJpbHkgZml4ZXMgYSBpc3N1ZSBvZiB0aGUgdGVzdHMg
YWJvdXQgRkxBVE1FTSwNCj4+PiBhcyB0aGUgY29tbWl0LW1zZyBzYXlzOg0KPj4+IMKgwqDCoMKg
wqAgVG8gbGV0IGluZm8tPm1heF9tYXBuciBpbmRpY3RlIHRoZSBkaXJlY3QgbWF4IFBGTiBhbmQg
dGhlbg0KPj4NCj4+IFRoaXMgbWVhbnMgImluZGljYXRlIiwgcmlnaHQ/DQo+Pg0KPiBSaWdodCwg
d291bGQgZml4IGl0IGlmIHlvdSdyZSBvayB3aXRoIHRoZSBQYXRjaDIuDQoNClRoZSBwYXRjaGVz
IGxvb2sgZ29vZCwgc28gYXBwbGllZCB3aXRoIGZpeGluZyBpdCBhbmQgc2V2ZXJhbCBpbmRlbnQg
DQphZGp1c3RtZW50cy4NCg0KVGhhbmtzLA0KS2F6dQ0KDQo+IA0KPj4gVGhhbmtzLA0KPj4gS2F6
dQ0KPj4NCj4+PiDCoMKgwqDCoMKgIG1ha2UgdGhlIGtkdW1wIGhlYWRlcidzIG1heF9tYXBucl82
NCBjb3JyZWN0LCByaXNjdjY0IHBvcnQNCj4+PiDCoMKgwqDCoMKgIGRpZG4ndCBkZWZpbmUgQVJD
SF9QRk5fT0ZGU0VULg0KPj4+IMKgwqDCoMKgwqAgQXMgZm9yIEZMQVRNRU0gdHlwZSwgdGhlIHBm
biByZWdpb24gb2YgbWVtX21hcF9kYXRhIHNob3VsZA0KPj4+IMKgwqDCoMKgwqAgYmUgYWRqdXN0
ZWQgdG8gc3RhcnQgZnJvbSBpbmZvLT5waHlzX2Jhc2UgaW5zdGVhZCBvZiB6ZXJvLg0KPj4+DQo+
Pj4gTm90IHRha2luZyBvdGhlciBhcmNoZXMgaW50byBjb25zaWRlcmF0aW9uIGFuZCB0ZXN0LCBz
byBJIHNpbXBsZWx5DQo+Pj4ganVkZ2UgdGhlIF9fcmlzY3Y2NF9fIGluc3RlYWQgb2YgQVJDSF9Q
Rk5fT0ZGU0VULiBNYXliZSB3ZSBjYW4gDQo+Pj4gaW1wcm92ZSBpdC4NCj4+Pg0KPj4+DQo+Pj4g
VGVzdHMNCj4+PiA9PT09PQ0KPj4+DQo+Pj4gV2l0aCB0aGVzZSAyIHBhdGNoZXMsIHRoZSBmb2xs
b3dpbmcgdGVzdHMgaGFkIHBhc3NlZCBpbiBSVjY0IFFlbXUgDQo+Pj4gdmlydCBtYWNoaW5lOg0K
Pj4+DQo+Pj4gUHJlcGFyYXRpb246DQo+Pj4gLS0tLS0tLS0tLS0NCj4+Pg0KPj4+IDEuIGJ1aWxk
IGtlcm5lbCB3aXRoIEZMQVRNRU0gYW5kIFNQQVJTRSBtZW1vcnkgbW9kZWxzDQo+Pj4gMi4gYm9v
dCBrZXJuZWwgd2l0aCAzIGRpZmZlcmVudCBwYWdlLW1vZGVzIGJ5IHNldHRpbmcgbm92NGwvbm92
NWwgaW4gDQo+Pj4gY21kbGluZQ0KPj4+IDMuIHBhbmljIGtlcm5lbA0KPj4+DQo+Pj4gVGVzdHM6
DQo+Pj4gLS0tLS0NCj4+Pg0KPj4+IDEuIGNyZWF0ZSBrZHVtcC1jb21wcmVzc2VkIGZpbGUgdmlh
IHRoaXMgY29tbWFuZA0KPj4+IMKgwqDCoMKgIC0gYC9tbnQvbWtkZl9mIC1kMzEgLWYgLWMgL3By
b2Mvdm1jb3JlIC9tbnQvZHVtcC5maWxlMWANCj4+PiDCoMKgwqDCoCAtIG9yIHdpdGggYC0tdnRv
cGAgb3B0aW9uIHRvIHRyYW5zbGF0ZSBzb21lIHR5cGljYWwgYWRkcmVzc2VzIA0KPj4+IChsaWtl
Og0KPj4+IMKgwqDCoMKgwqDCoCBrZXJuZWxfbGlua19hZGRyLCB2bWFsbG9jX3N0YXJ0LCBwYWdl
X29mZnNldCkNCj4+Pg0KPj4+IDIuIHN0YXJ0IGNyYXNoIHdpdGgga2R1bXAgZmlsZSBhbmQgZG8g
c29tZSBWVE9Qcw0KPj4+DQo+Pj4NCj4+PiBBIHRlc3QgbG9nOg0KPj4+IC0tLS0tLS0tLS0tDQo+
Pj4NCj4+PiAjIFdpdGggdGhlIFN2NTcgYW5kIFNQQVJTRV9FWFRSRU1FIGtlcm5lbA0KPj4+ICMg
dnRvcCB0aGUgdm1hbGxvYyBzdGFydCBhZGRyZXNzIC0tIDB4ZmYyMDAwMDAwMDAwMDAwMA0KPj4+
DQo+Pj4NCj4+PiAjIC9tbnQvbWtkZl9mwqAgLS12dG9wIDB4ZmYyMDAwMDAwMDAwMDAwMCAtZDMx
IC1mIC0tbm9uLW1tYXAgLWMgDQo+Pj4gL3Byb2Mvdm1jb3JlIC9tbnQvZHVtcC5maWxlMQ0KPj4+
DQo+Pj4gVHJhbnNsYXRpbmcgdmlydHVhbCBhZGRyZXNzIGZmMjAwMDAwMDAwMDAwMDAgdG8gcGh5
c2ljYWwgYWRkcmVzcy4NCj4+PiBWSVJUVUFMwqDCoMKgwqDCoMKgwqDCoMKgwqAgUEhZU0lDQUwN
Cj4+PiBmZjIwMDAwMDAwMDAwMDAwwqAgODAwODcwMDANCj4+Pg0KPj4+IENvcHlpbmcgZGF0YcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDogWzEwMC4wICVdIHwNCj4+PiBldGE6IDBzDQo+Pj4NCj4+PiBUaGUg
ZHVtcGZpbGUgaXMgc2F2ZWQgdG8gL21udC9kdW1wLmZpbGUxLg0KPj4+DQo+Pj4gbWFrZWR1bXBm
aWxlIENvbXBsZXRlZC4NCj4+Pg0KPj4+ICMgc3VkbyAuLi9jcmFzaC9jcmFzaCAvaG9tZS9zb25n
LzlfbGludXgvbGludXgvMDBfcnZfZGVmL3ZtbGludXggDQo+Pj4gL3RtcC9oZWxsby9kdW1wLmZp
bGUxDQo+Pj4gLi4uDQo+Pj4gwqDCoMKgwqDCoMKgwqAgS0VSTkVMOiAvaG9tZS9zb25nLzlfbGlu
dXgvbGludXgvMDBfcnZfZGVmL3ZtbGludXgNCj4+PiDCoMKgwqDCoMKgIERVTVBGSUxFOiAvdG1w
L2hlbGxvL2R1bXAuZmlsZTHCoCBbUEFSVElBTCBEVU1QXQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBDUFVTOiAyDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIERBVEU6IFdlZCBTZXAgMjcgMTg6Mzc6
NDUgQ1NUIDIwMjMNCj4+PiDCoMKgwqDCoMKgwqDCoCBVUFRJTUU6IDAwOjAwOjE4DQo+Pj4gTE9B
RCBBVkVSQUdFOiAwLjAwLCAwLjAwLCAwLjAwDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBUQVNLUzog
NTUNCj4+PiDCoMKgwqDCoMKgIE5PREVOQU1FOiAobm9uZSkNCj4+PiDCoMKgwqDCoMKgwqAgUkVM
RUFTRTogNi42LjAtcmMxLTAwMDA3LWcyMmJmYzc2NjM4OWMNCj4+PiDCoMKgwqDCoMKgwqAgVkVS
U0lPTjogIzEgU01QIE1vbiBTZXAgMjUgMTk6Mjk6MDUgQ1NUIDIwMjMNCj4+PiDCoMKgwqDCoMKg
wqAgTUFDSElORTogcmlzY3Y2NMKgICh1bmtub3duIE1oeikNCj4+PiDCoMKgwqDCoMKgwqDCoCBN
RU1PUlk6IDUxMS44IE1CDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBQQU5JQzogIktlcm5lbCBwYW5p
YyAtIG5vdCBzeW5jaW5nOiBzeXNycSB0cmlnZ2VyZWQgY3Jhc2giDQo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqAgUElEOiAxDQo+Pj4gwqDCoMKgwqDCoMKgIENPTU1BTkQ6ICJzaCINCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgVEFTSzogZmY2MDAwMDAwMDBlMDAwMMKgIFtUSFJFQURfSU5GTzogZmY2
MDAwMDAwMDBlMDAwMF0NCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDUFU6IDENCj4+PiDCoMKg
wqDCoMKgwqDCoMKgIFNUQVRFOiBUQVNLX1JVTk5JTkcgKFBBTklDKQ0KPj4+DQo+Pj4gY3Jhc2g+
IHZ0b3AgMHhmZjIwMDAwMDAwMDAwMDAwDQo+Pj4gVklSVFVBTMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFBIWVNJQ0FMDQo+Pj4gZmYyMDAwMDAwMDAwMDAwMMKgIDgwMDg3MDAwDQo+Pj4NCj4+PiDCoMKg
wqAgUEdEOiBmZmZmZmZmZjgxNGZhOTAwID0+IDIwMDEwYzAxDQo+Pj4gwqDCoMKgIFA0RDogMDAw
MDAwMDA4MDA0MzAwMCA9PiAwMDAwMDAwMDIwMDI1NDAxDQo+Pj4gwqDCoMKgIFBVRDogMDAwMDAw
MDA4MDA5NTAwMCA9PiAwMDAwMDAwMDIwMDI1ODAxDQo+Pj4gwqDCoMKgIFBNRDogMDAwMDAwMDA4
MDA5NjAwMCA9PiAwMDAwMDAwMDIwMDI2MDAxDQo+Pj4gwqDCoMKgIFBURTogODAwOTgwMDAgPT4g
MjAwMjFjZTcNCj4+PiDCoMKgIFBBR0U6IDAwMDAwMDAwODAwODcwMDANCj4+Pg0KPj4+IMKgwqDC
oCBQVEXCoMKgwqDCoCBQSFlTSUNBTMKgIEZMQUdTDQo+Pj4gMjAwMjFjZTfCoCA4MDA4NzAwMMKg
IChQUkVTRU5UfFJFQUR8V1JJVEV8R0xPQkFMfEFDQ0VTU0VEfERJUlRZKQ0KPj4+DQo+Pj4gwqDC
oMKgwqDCoMKgwqAgUEFHRcKgwqDCoMKgwqDCoCBQSFlTSUNBTMKgwqDCoMKgwqAgTUFQUElOR8Kg
wqDCoMKgwqDCoCBJTkRFWCBDTlQgRkxBR1MNCj4+PiBmZjFjMDAwMDAyMDAyMWMwIDgwMDg3MDAw
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgwqDCoCAwwqAgMSAwwqAg
Ly8gc2FtZSBhcyANCj4+PiB0aGUgbWFrZWR1bXBmaWxlJ3MgdnRvcA0KPj4+DQo+Pj4NCj4+PiBT
b25nIFNodWFpICgyKToNCj4+PiDCoMKgwqAgQWRkIHJpc2N2NjQgc3VwcG9ydA0KPj4+IMKgwqDC
oCByaXNjdjY0OiBDb3JyZWN0IHRoZSBwZm5fc3RhcnQgZm9yIGZsYXRtZW0NCj4+Pg0KPj4+IMKg
wqAgTWFrZWZpbGXCoMKgwqDCoMKgwqAgfMKgwqAgMiArLQ0KPj4+IMKgwqAgYXJjaC9yaXNjdjY0
LmMgfCAyMTkgDQo+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPj4+IMKgwqAgbWFrZWR1bXBmaWxlLmMgfMKgIDE4ICsrKysNCj4+PiDCoMKgIG1h
a2VkdW1wZmlsZS5oIHwgMTA3ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+IMKgwqAgNCBm
aWxlcyBjaGFuZ2VkLCAzNDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+IMKgwqAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3Y2NC5jDQo+IApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
