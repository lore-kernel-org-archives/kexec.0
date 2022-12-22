Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD420C4332F
	for <kexec@archiver.kernel.org>; Thu, 22 Dec 2022 07:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=79vSoX64C1hjoJui4EHVoJmscGxwz3JQN71krs4cx4E=; b=1e7sCcsOWmhC4J
	/tFpebA9D3eEKLnd0wwjk3nyr6w3xCB5b4GxggcFiQvwCpXCrPa9pfqLfqgO1/J1usJkd8pggtjPD
	CrNsWOKSMYU3NAcpGLMwXSnluwjJA21/mJ9ezUgKJGIPu+LdOzk3ZN9/Fa46MizylPSNU8MT9Qwiq
	cpErYSDIvul7+mDnCngdpAIGzpuyvml0Nbn7ydKjpj6Re2IkSk5JzX3rSzNnp1XY0yfF8r0vJlxJz
	0KdkPKL9ZFSWyJkRLWg5rSlIDZMg8+779k9nIATWi3MfYrIwyQUvqU/Wfn8GJSE+Z3TCCXwab2xNo
	NtnflgwOBBagF48KKuTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8Fau-008LrM-D4; Thu, 22 Dec 2022 07:02:20 +0000
Received: from mail-os0jpn01on2064.outbound.protection.outlook.com ([40.107.113.64] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8Fan-008LoF-Ko
	for kexec@lists.infradead.org; Thu, 22 Dec 2022 07:02:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlw7q0Hxe2WKpkFSbxHlhlw8wLG8hrqRP7Qr6rqqZBTroNGO7Jv5FcgJ3cQAbpGJbhvMACUjP95bEY/DYXNXDQxwWqq+hwhzUnO2Oew47zMN9Z3Vmlu01VtcmOnLxTkDw95syEXzBZu/wmjp0TMKE8WbBs6mYEWtMnF1kkWeDMq+Vfor/DVpenOJ0UoZ68IwVwj+KPAuqxckYnjJXPxDAW4WVwo9JpHVr/WeC3a60ZJzuf9QRrBdU8qibzMnl5kMubsXxKbahT76hruwq0+9SYEZYJ5MIcroLJME1meN606m5l4QA4Prq03bCmkansia43hGTztwlYjvWp2W4Uab4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srQUjiDAk2kHYfojWbUw4kieDnSnScMOKOOQWVQNyF0=;
 b=Ofaq/gucMOdTLxO1fDihysINjSu8GKLrPsgDkwpehQWyjx0KlHpk0+E1wHVL12ZR3pJqvMw3eNSP6oLeCy5S6onhlE6+8EhKoY9Ur0en3m5M0eOAQd5b/Q2wUQay4/YKOYZ8CyQYmc1ZqJd38s4c84uF2XC+yJ89txz8aVFaPWWvv0PzhQjYSmEC8Psxa/tyRwGJyt0spC3gD+WivNgDzcdASfNIuxtXqkobHSyu6Qmo2xmQgbYki2vMEek8wPiVy8yJovepeyBW7aecicVxqiDDZHwSDoOxYm9/zV7ed17rmgW6ZUt8EzM2PcW8pPwINfliZBY4hQcQZqdgYjN/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srQUjiDAk2kHYfojWbUw4kieDnSnScMOKOOQWVQNyF0=;
 b=NZ/SyI/w6cdZMiiXJZaVGObIuN8B5b+oqgVUI6cuzfX6+WK3KqWYGgHm0ecvyLAkUqbmj9mGAyyVWBCLo4BV/XOY6e1imUppjkdSePV1JbC66fLd93rSM3OlaKQSizPJ3wK9V7qhiumq/IlvFv3SAFJHINMy3BzJdvG0T5MGi3Q=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by OSZPR01MB7819.jpnprd01.prod.outlook.com (2603:1096:604:1b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 07:02:06 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::7841:9155:aaae:72a5]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::7841:9155:aaae:72a5%9]) with mapi id 15.20.5924.022; Thu, 22 Dec 2022
 07:02:06 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH makedumpfile] Fix incorrect exclusion of slab pages on
 Linux 6.2-rc1
Thread-Topic: [PATCH makedumpfile] Fix incorrect exclusion of slab pages on
 Linux 6.2-rc1
Thread-Index: AQHZFODcxWWDp5nypk+IZSMwRba77K55fNeA
Date: Thu, 22 Dec 2022 07:02:06 +0000
Message-ID: <a549d1d8-1ec3-9206-0790-b636d83bcaf3@nec.com>
References: <1671588393-23443-1-git-send-email-k-hagio-ab@nec.com>
In-Reply-To: <1671588393-23443-1-git-send-email-k-hagio-ab@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|OSZPR01MB7819:EE_
x-ms-office365-filtering-correlation-id: 8d08682c-a8aa-4fa5-48c7-08dae3ea6faa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  YhUFc3xAvlbf3ksAdvIpvx6kTNV1EepEzR+IgI8JQTjZsAtM5OU7qt3/rLxrOaqBgXB9MNQ6LAAZOfBRb529eubX1L+k4eXkwfc8skGoBGBBZn7/d6uKu2DCkkYppiG6+yFESVbT2bkw3FNKtXeFRWi9ThM/xfJHazw6mq9gOscjWCaqsCB+O5ro3SCtypE1zSB99pFthzG6ZKJJWoHFMQ03YSwiHXTL5EQX4L9cAPlNlrqjir71iXUDR4FUJ1ox4J0hFqEBLTxyqoAX5WBB/M5MWFl/uFPPCbkJTDZp3C6zZqDIB2j4Exm/+Jd1vYV6W+GLVjdlWKj56TrBOOmcDSCyZtRaHyBtsBO43ZV4AXKjOwO9XNTOr+kArGMr+cWmFPqzFo4C6TB8o0yprvsIVGRGipKVV/9k4xpe3mrTOomCK0pc86oHiPckE2IdDrY0XkRCuwPHbMgPpr+sVP9QDq5qWzfNEcDTE6dQS1Q0S+kvp0keaMkGgGJKqImsd/PLUJebQ44Mpg5oNYSOjTCcS00NM6R+BMhHgvJEqvf1Sep2Dp08LaUH21p5tZ1N00pDIW11VOCsTuaQLnN4U84hxX2Yfc8MR4/C9aWHNl4AiVtX+CmX0zRwwzxpC1A4rLcbZFHhRsSTBU1AjbEisnvr0HoMI941swQP/lspgpC5B+nxjDQi3ma1onihQmYa3Ibfk8UsmBwhamG1nhZgDcxdvOv802VDRoP86affmwQUvP7TK8N8IOdgkcCfWNM5VXAh+yDIHTyhC3PaHGq0zcU/vw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199015)(82960400001)(36756003)(2906002)(85182001)(76116006)(64756008)(66556008)(8936002)(66476007)(4744005)(71200400001)(966005)(66946007)(5660300002)(6486002)(6506007)(53546011)(66446008)(478600001)(6916009)(8676002)(186003)(38070700005)(26005)(31696002)(41300700001)(316002)(6512007)(86362001)(2616005)(38100700002)(122000001)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?eXRzbEh6d0FiUUN3eDErU1NQRFRDNGFrY0I3S0pVL3ppeklEZkJwcitiRVo3?=
 =?utf-8?B?TzFzVGlGSm1nOXJZYzRuUlBBb1BCMU51Q2xiSmsyRDdlbVpOOXB0TjdLVFBV?=
 =?utf-8?B?Zmw1SytrcTM4RjFJTnpBb2FnNUJaWHRxTUVUVElnWllSUDNpZkw3T1lUV0sr?=
 =?utf-8?B?bFJCbGpyekVsMkFJaSt2MFo0c1NKVUc0a3QyUWtINzZkWlBiNU9Ob043MWlD?=
 =?utf-8?B?bU16TXU2dURQamJNYVI5eXNseGhoVjJqMVRZUGtTM29jOE95bXVmL2xZM1ZH?=
 =?utf-8?B?VHNrSHA4a3IzTXZnMURsT2dML3FNelV6RFlUU1V6VWdFakdrSVRtYnRHQkN2?=
 =?utf-8?B?d0xEQWgwSE9mcG1PSTJmeUZDVkhUejR0WXlZS0p4UUhuaG9tYWZ4K0pLSWVK?=
 =?utf-8?B?MVI3OVlEYUFTVWsvZTVxNWV2OGpiOU9FdHpKWjg0RUxtMWROSGRmWXFVUG5K?=
 =?utf-8?B?b21RWFZRY0F1ZWswcHNLakVtMU8wVDM3SjA3end0MG1KVmNNMnR6SWprVVJy?=
 =?utf-8?B?N24wdlgwWTRxSFc2OG5sdlc3QXE5YVhBMnU1Z0FHNHk1am9qYVllNnZwTXZ5?=
 =?utf-8?B?VmdrK0QxeVJDbVhYeEFJS3JIeElCQkpLOTNadWFzSG13dnNSSmlIejl2TzZK?=
 =?utf-8?B?MWYwUjdqSFp2VUdWaXVwTGFhSWZWQ1pIbUVOVDBaRWxNbWxMYmxjZW91S0pq?=
 =?utf-8?B?bTNsdllKV1hHR3hkaURuK1hpZTBiZFJrbVI2dzlNYWRvM0M2bkpmNnFNdG0y?=
 =?utf-8?B?eTdXcFZ5S3RYVkp6d0tCT0oxOSszOUtFNzI2cGQxZTR2ckV4UlU3YXBSVWdK?=
 =?utf-8?B?bVlMU3M3TFJBRUR1UENNZU1tYXZvN2RyNmttZ0NFdVA3WVR1a3VCUzNhTU0z?=
 =?utf-8?B?c1NXMDFnM2FyN2ZWZm1jeXoxenZ5Ykp4NkdNZ09sUU92NHVXQjl6MlNqVndl?=
 =?utf-8?B?dE5mZU5GOGMxazYzdUZocG1PZGZDSlFweUtIaGs1WWZpd1htQWNmYlNMaHg4?=
 =?utf-8?B?Z0R0SzNubGMxSUZSU29qTkticzdHVG9Rd2RMSDJOTmp4TzZFRXlUTUFRK1FO?=
 =?utf-8?B?d3lIQkpDakR0TTY4WWJ0OTJjWEhMSzNucHJUU0hsZ2ZFZUdXWit3WStmYU5a?=
 =?utf-8?B?eHlGWTQ5R1R6QUdnUVBBNW0vNFIyRmpteGZaRTF0aHRSVnluUFJPYkx6aGJl?=
 =?utf-8?B?WHIxY0Jsd2hva0U0M3VFRU93K1I2dk5yQy9KSkYvRGxtRFR0andWc09UWEs1?=
 =?utf-8?B?blV3UUxSa1JzdFdhcDA4eG9aUW9vakhwTThZYms0MHdPbnJKWWZHOEJlOTRo?=
 =?utf-8?B?VmJteHg3VlZ3MFdzSDJ4TFlPWXNnb3BpS0RENWl3VE10ci9CNzI4WUVhSXJ4?=
 =?utf-8?B?ZGhXTDd2NnRXVS9VeUh5QitIYmtyOU9oRGV0bEJjcFNGcnJmZ0hDY1ZjZ1JJ?=
 =?utf-8?B?UE9RQlY2L0cxVktBZ3pGbWRvS3ArR2hmdm1SVHdpWmYvZFcxSkVCcW12TXRY?=
 =?utf-8?B?RjZzT01JVUxmVE9xS084NEIvNFRtUW1rK1d3TmVUVWx3VTRhNlZBa01oTGtk?=
 =?utf-8?B?M0tZZTlXR3FaeGQxcGhQZHZaZUxWTTBNZVNObDFHcG1ITEk3QXd4bWQ2QW1w?=
 =?utf-8?B?Q2ZXZ0xkUTNhMm9ReU9LcXpKZGJBdFkwcEV3eURMTzFnMHBFU3RKTlA1c0FW?=
 =?utf-8?B?QkFobHFhenpXaVFvczZndmRCWjRWNVhuZHUzcDdQbjcvR2hUeFpwKzRjd0d6?=
 =?utf-8?B?QzFCLzZqWWxpNmN5TSt3ZSt2aXZDb3pFNFlOdjVyNG50bGhVRmJKV0M0YVhX?=
 =?utf-8?B?MFRjRndZd25BdWxNKzhCVmRVMlNwaW83bFlsb2RpZENyM21WUjZwM1RuY0pt?=
 =?utf-8?B?dWYrVUZ2ajBEeXFEOXY5Y282Ny9VL2hyWDdKaW1MSVB5bGNJWjgwZ3I3R1pQ?=
 =?utf-8?B?ZkVwcHlhbWtCWXljU2RrV2lxRUYxNHpwblJSTklkcUsyYlVIYVRYSVdCVHFl?=
 =?utf-8?B?ZnA0aGk1RE5WbDc5WDR3RjVZZUJvL3o1U1ZJZEFSVDN1d2Y1a290SGxmS3Y5?=
 =?utf-8?B?TUlBWVljdnp1N0VtanI1NTNEN3I2emhNNUdYN0VsZkRDL0FreE9wR3Bza1l6?=
 =?utf-8?Q?uSKX3eTCn7I+Cqws2C8R3gVA5?=
Content-ID: <A8B6B0CF41FC6548A79EAA17C5A9CB10@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d08682c-a8aa-4fa5-48c7-08dae3ea6faa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 07:02:06.1004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPsQtLWNl0JWqU5uU4oQQVVP7sbE1B/psTXHf9bQo+6MEqxvc+7iFZ4J0b5V2aoW9zmW1INGq2aezYnm5FG6rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7819
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_230216_116178_DEE5C398 
X-CRM114-Status: GOOD (  11.54  )
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

T24gMjAyMi8xMi8yMSAxMTowNiwgSEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSkgd3JvdGU6
DQo+IEZyb206IEthenVoaXRvIEhhZ2lvIDxrLWhhZ2lvLWFiQG5lYy5jb20+DQo+IA0KPiAqIFJl
cXVpcmVkIGZvciBrZXJuZWwgNi4yDQo+IA0KPiBLZXJuZWwgY29tbWl0IDEzMGQ0ZGY1NzM5MCAo
Im1tL3NsW2F1XWI6IHJlYXJyYW5nZSBzdHJ1Y3Qgc2xhYiBmaWVsZHMgdG8NCj4gYWxsb3cgbGFy
Z2VyIHJjdV9oZWFkIiksIHdoaWNoIGlzIGNvbnRhaW5lZCBpbiBMaW51eCA2LjItcmMxIGFuZCBs
YXRlciwNCj4gbWFkZSB0aGUgb2Zmc2V0IG9mIHNsYWIuc2xhYnMgZXF1YWwgdG8gcGFnZS5tYXBw
aW5nJ3Mgb25lLiAgQXMgYSByZXN1bHQsDQo+ICJtYWtlZHVtcGZpbGUgLWQgOCIsIHdoaWNoIHNo
b3VsZCBleGNsdWRlIHVzZXIgZGF0YSwgZXhjbHVkZXMgc29tZSBzbGFiDQo+IHBhZ2VzIGluY29y
cmVjdGx5IGJlY2F1c2UgaXNBbm9uKCkgcmV0dXJucyB0cnVlIHdoZW4gc2xhYi5zbGFicyBpcyBh
bg0KPiBvZGQgbnVtYmVyLiAgV2l0aCBzdWNoIGR1bXBmaWxlcywgY3Jhc2ggY2FuIGZhaWwgdG8g
c3RhcnQgc2Vzc2lvbiB3aXRoDQo+IGFuIGVycm9yIGxpa2UgdGhpczoNCj4gDQo+ICAgICMgY3Jh
c2ggdm1saW51eCBkdW1wZmlsZQ0KPiAgICAuLi4NCj4gICAgY3Jhc2g6IHBhZ2UgZXhjbHVkZWQ6
IGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3M6IGZmZmY4ZmEwNDdhYzJmZTggdHlwZTogInhhX25vZGUg
c2hpZnQiDQo+IA0KPiBNYWtlIGlzQW5vbigpIGNoZWNrIHRoYXQgdGhlIHBhZ2UgaXMgbm90IHNs
YWIgdG8gZml4IHRoaXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLYXp1aGl0byBIYWdpbyA8ay1o
YWdpby1hYkBuZWMuY29tPg0KDQpBcHBsaWVkLg0KaHR0cHM6Ly9naXRodWIuY29tL21ha2VkdW1w
ZmlsZS9tYWtlZHVtcGZpbGUvY29tbWl0LzVmMTdiZGQyMTI4OTk4YTNlZWViNDUyMWQxMzZhMTky
MjIyZmFkYjYNCg0KVGhhbmtzLA0KS2F6dQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
