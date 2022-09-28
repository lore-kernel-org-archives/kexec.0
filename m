Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC06C54EE9
	for <kexec@archiver.kernel.org>; Wed, 28 Sep 2022 00:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Cp9p8ckFWNsZvt83uiuFpAAlaH3eWtChIOIXIlkRehM=; b=EmIgJkVsaQ43XZ
	xWWBDqZcKuNxk/yre4oLxCIBiirK9pdxlVzGgV0PSUBd3pZE5lmo0dQ+VdyMKB9kbYKipjH6mBEg8
	J6T8PVYMcnU9SCyTG7SGtvkk9L6LZfKxl3J0n/Wk6tKTYebDtTGJFZOOSGu2XXZA+jmiqUEEv+bL4
	X25uVgMf+MHy8VKx5aKRRaRFIrRpQU1S7zBBHmTzRinlfeEqJZpKToRMfG36zLg6RPrRSm7h6gyod
	TCFEzuVqZBfnsABPq/HPd8EJ+1QNJvI4Xfsf2whZDPSToy+uIPPJg61aOcgTTomJQxBovf1jkPXqp
	su9VfevSYfWKsy9KMcmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odL7S-00DKR3-Vo; Wed, 28 Sep 2022 00:40:11 +0000
Received: from mail-os0jpn01on2078.outbound.protection.outlook.com ([40.107.113.78] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odL7P-00DKPu-4v
	for kexec@lists.infradead.org; Wed, 28 Sep 2022 00:40:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rr9pHOmQ6VqQDWCGFXE+lQJ6LwplM9SrMi8BRstOzF+5P5fOI4Bj2YVKV1bHLarMHxMd+vHZPGFWa/c405L9RsyqQprQqVMhkxgTpJvGM22g4p1IQDSj14k7iec4qsU0sF7EcdV7Cj7bP3plMm0es6Isgcscu6r3/xGFXQNBG98zjy8kF/89rwMSXGPHfWjeSpXyO9zePv1YGkSrHjlVZRAdDiGRSBfzhHO8QxRUDRITWTv/2/mKnf/H3fxOT2SC4myx6w8GqFzSCrLuHVf168pjq6aakcPbZmT//0iQCtBCHxuB9LStiNr6jF/PnEaZ41qkV2KTAfrtiOAGqMkhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2AJXEq9dBaeNsD403xRESNApsDi+cUabFks1lO77ug=;
 b=TaQ1XgI3wOSVfw0ipT3rqfwBdPIcOXGZvI+Wr88unIY7jZuXiD1NfA7aWqG3jRoRhYzH5DRJlzej/KZoBXyJcGotTfm2kGFMV/BfHI/CQbZaQ72uvwBSijMy0Wz1Ngr6L4ETC0lXbW5WnXe2yOyyM5CqU8lM3lCTOdvCvkqiI/rh8t58NgN/4aBjRp1r5qzCIvTHz/UAhzA3SqUmRakjcprwGA1BPP0lIgN10q4Os37C/jS7l0qTOWSQMDXeo4slGYqf4wdQ4K4N557S84ObP5HN8mAmtftJ3sdcJiP5aAEfUvKdQw1acEBdRso83riHWwZe0ONDXVoaSH/69PER3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2AJXEq9dBaeNsD403xRESNApsDi+cUabFks1lO77ug=;
 b=hQeX/xc1z0BWJ04IAK38x56BOyQ/xkKv/MH9zGciE2fYzBKOKIEFuJDEgONq8h9KV2quyrcmnqN8Y9vAgKorHIdE1qNmo+t0+t27R8NHucFSP2Da+HCBLUGgUDisPHkk5BKtfnfjGLaGUIe5BbxQogt5aKdyabxRCNLX9Y5Zff0=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYAPR01MB6204.jpnprd01.prod.outlook.com (2603:1096:400:84::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 00:39:57 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1f99:8d77:182b:f149]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1f99:8d77:182b:f149%5]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 00:39:56 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: "dietmar.hahn@fujitsu.com" <dietmar.hahn@fujitsu.com>, kexec mailing list
	<kexec@lists.infradead.org>
Subject: Re: [PATCH] makedumpfile: xen: Fix get_xen_basic_info_x86_64: Can't
 get the symbol of xenheap_phys_end.
Thread-Topic: [PATCH] makedumpfile: xen: Fix get_xen_basic_info_x86_64: Can't
 get the symbol of xenheap_phys_end.
Thread-Index: AdjReGs1LM4LddpXRUOuXPWjEIJLGwAznPkAAAAdyEAAIt+bAA==
Date: Wed, 28 Sep 2022 00:39:56 +0000
Message-ID: <dc8ab538-420c-90e2-3a9a-2e89acb49b08@nec.com>
References:  <FR0P281MB2123EA0E029E96579F0C6DF894529@FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM>
 <9505bcd8-f63a-6e6c-0aaf-7ba4f3330cfc@nec.com>
 <FR0P281MB2123CCAEA1BD726D6F290BEA94559@FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To:  <FR0P281MB2123CCAEA1BD726D6F290BEA94559@FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYAPR01MB6204:EE_
x-ms-office365-filtering-correlation-id: da159c34-9267-4051-44ca-08daa0e9f7a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  l6jDhvBoRFV1KgWL3TLRwS59iYX6NqBwUpX+kvoKws13T6dAJgcWehQJ7LedBupbCM1myBqALqBn+E+uqFSqGhfZPopIcOdzoMR4U7ss1Fbt5pMyM/R9KsD7GPphlCyaSBDRgqvgop26/kmieZF6cpzQWcAly6mscrAi1HvybwOwGt4Vb/cAjCCe/9XIuqM+IZnCes0Wsv+GARVXFVqfrFn4aR3wHi+vqHV23Ha/5+KgH1xRVmYSquWvnKJxsnj2umB1L+fTLQyTFVz3wdrL/7yvFXHUBuWsI6ZTWOc4Szkj4R1k+fELvBk4Hzs/L04zxQLEVt6XmoMgPlcd1vtVkQRBSsCMPkx6OmeMoul0r4qq3ngdygFktXta3cqdW+sZ9fa6clhwb0D5/dDjWrxwtF871LHfUcZvP/9bgyuBxGetMr5hAmcR9vc8FZC5rI2zOKlapKdJjny0TB39Nw2G4XPNxYRuw4UFdp7u2MXchUkha8961SoGs+fjoqPXf6L/vO7U0GfJFIwthaWvlybWEcx1T76k6yVtuG0Lq/uM5f6YoeMZiQcjKyWhLW7oZiY8sFu+eKdRTYFu9/9UQOJv1WG0DE/T0L4aR8EynDvhgNxSY+ZwysYE3VyRI0VS6MHaQlu3SwvOIgEurYAOOvTbBtmRVn38ktwhR7gZQHq7APgH+sMrRcIXGziV5aHO5u/2bemhJiTukNE7kY31ftnKy+mkb0YHxf8oVxPPK/iUnSL23MgC9WnTEnutkiOvyicExK6pqu5fORvheKEAHNM+9o50mN7Wbc++/VxFFAOYqgFIhkFNJNNs9YOAvPql3lk/NvbB+SH+BgWmCUAF9jh/1g==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(2616005)(186003)(966005)(8936002)(64756008)(83380400001)(38070700005)(31696002)(86362001)(6506007)(82960400001)(122000001)(38100700002)(66556008)(8676002)(66446008)(66476007)(41300700001)(6512007)(66946007)(2906002)(316002)(478600001)(76116006)(71200400001)(5660300002)(55236004)(26005)(53546011)(85182001)(36756003)(31686004)(6486002)(110136005)(15583001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bHhDNHdEZEdEeWNhdmpaWHkyZ1FQeFpRYTI2eUdrcUFrMk9HVUlDSDRiYmlm?=
 =?utf-8?B?VFk0TDJLaTh1UkNGOHNCRXF1QlBva3RlcitmRGQ0OHhESVRyd1FKa1o5L2ZD?=
 =?utf-8?B?RG5GZU5mdjkyNEV6ZWgzNHRRb2hLVEFNVlVhdEdqSjdSY0hhMVlUajFmWWNB?=
 =?utf-8?B?aGp4VFpMelQ5Y0VpYjhkOGkyNmkxSUF5ZmN3ZlVTc0FPcTFLMjU2S1pqaW5t?=
 =?utf-8?B?cUZLRDJXc0loL2RtQUZlK005QW9MWS9lQ2NJbWpiakRtREpoemFneG5Mdmh6?=
 =?utf-8?B?NlVJZE9lakZsZlRPblBCWWYrNzFvTUxRQjFmUTBRRGRKbkhvd0RJSlJNREMw?=
 =?utf-8?B?RjVqbHRUTXVJa1pzUnF4Y3dXR081N1lCeGlka1RCYUJHdFA3WmdOU1g2OFhy?=
 =?utf-8?B?NkEzWVRvYWRZYnovbkRLMkhyZU5JLy9BV1dyb2N2Z3djQ0dlS0l0MzFTcW9P?=
 =?utf-8?B?czNYRFVKYjRTdk1ocDJpK0dUUkVONjNLaE8rK0N5bWRZSEhvZFdpWGNDSHRU?=
 =?utf-8?B?eWxMUmR5MzNPOTVXTFpBY0gvY1EwL2pIMEx5anJiTGYzQkx1NE4wc0J3eFRh?=
 =?utf-8?B?eERUNlBQUnRpREczdTF1bXZOSjd6WWRSMWVmaXlBVFlCc0h6Y0xrbnVER0xI?=
 =?utf-8?B?cmFhczFqcVZXVGJIbzE0TEJ1U1BWOVA3RkpWVkFjaU83ZlJVdzEvcGl6U1Q2?=
 =?utf-8?B?YjV6OU4vMzA3TFVkRCsreURVUEhpN2tHdlE3YzFDMDdieWVlcFdRU0drMDJq?=
 =?utf-8?B?M05oQ0VjOE5FOEdIaWIrTUZCOXhDd2ROZmc1RVhxOWNVeUV4UmFZZjNhVjI2?=
 =?utf-8?B?dlM2MXM1TlZwZXh6NVBiZkZBTGdRejdzenEzdGJuNUtkOE1SM1dYcVpUV1ZK?=
 =?utf-8?B?Q3dqaXRpWG9Idk5qZXhjVnBVVUpEZWFYZENnUStVSzA2RUJoUmdNT2NRSU9L?=
 =?utf-8?B?eXJTb29kTDVYZGE4anNRS3N3UGhuYnJiWFMvWldJd1FzbWU0TGVmVXp3MGlD?=
 =?utf-8?B?dWFnQklLd3l0emJMcVhKUTVuSEk1YWVUbTdBdnNjcXp1dGxUbkFYelY0eTFI?=
 =?utf-8?B?REJHQnhRV2l3NEUyUW8rOENrM3RUM3FaSjB4a2VFeWhTN1FYVDU1TjJOTU9S?=
 =?utf-8?B?MFZIOU42MGF5L0JRRmZLTkVyQ3dVUVM1bXpNVXdLdXpKbUhzK2tUd3RPbGV4?=
 =?utf-8?B?UVpZM0g2eDlXOHpCSnNJT2x6TVl2YlBVS1V2T0krclUvaTNtSUxiVWc2YVlZ?=
 =?utf-8?B?cWFCWE5FZE1xV2l2T1hmc3BLejdlVXozdW4yYlB1Rnh5S2RoRi9NQVdNWUg5?=
 =?utf-8?B?WkV5bEtLUk1JYnNrcjRRWjR5a1Q4ZGxpdlIyVVQ5SFZlRUxhRzhIREhTWXVM?=
 =?utf-8?B?OTdXaDVTUDRXQjYrVWwvMTFhRElndko3MXJ5Z3htdzN5YmtHVEkxWEZkUFYw?=
 =?utf-8?B?VzYzbDhXT1VmUmU5OC9LaUxLcmhQQ1hRallnbFJVVEo4ZzBtZFZGZjhka2xa?=
 =?utf-8?B?dGJ6WFk0S0dXQmxucjNIQXNZRWJtdXdTVDFxV3Z3cms5VmpxYlRLMzA1VVJN?=
 =?utf-8?B?MndRT2IyWHNkdDY2U2hRNC95MmpSOHc5c1ZwbkFlVWwyQ0ZRV2ltTXlCK3hS?=
 =?utf-8?B?UFpWQUk5SG54UThDQ0c5UVZSTmZnWUhWK212dFFROWZjN09ad2dMaHFRbWJG?=
 =?utf-8?B?d3BEOGFEL1JEM1ZpdFZucWxQcVpkUW9qN1V1ekhtOHBKMjNnMGlQbi9sbWhx?=
 =?utf-8?B?VzN1MjN1Q1ZLT251K2kvRUVjZGVMSFJtVWcxOU1TUFRVdkxONTVYcTVNSnhC?=
 =?utf-8?B?OHdZbjRKMlg1Z2w2cHBQQ1owR3ljRHdGT05tQ1UzWkh0VnlsK2NHRkhwZlBW?=
 =?utf-8?B?ek54eG5yY08zZzErTzNrTDRiMXJTUm9FbXZtWTNTY3FNNUg4U1B2cWYyTTFX?=
 =?utf-8?B?bE5XbEdtOCtOaWs4eHc3N1F0ZDRCeEt3VWF5dHZaeGZtc0hBMnJscHJPSmU0?=
 =?utf-8?B?VWU5Zk9OSXZLSE82THRxbEo0dXhlOStNdGJQUFh3WmNUOFpBTXRCNEtMY2Vx?=
 =?utf-8?B?VjdoMnExYTFIVEtFRHVzVVZacXl6Q25ELytTVFdhUWs0VHhzUHBxVVdZQi9Z?=
 =?utf-8?Q?RcIPeNSQdKPf0OMhhg5gOFqTE?=
Content-ID: <5B0ECB48397E0146A83ACFFB3E4B2EBF@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da159c34-9267-4051-44ca-08daa0e9f7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 00:39:56.8333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QljksLuFi9dN03JyTcdNrAKFcz8WRSJMVAaB+PaWxaysC0opB3LkVuazllHe1ObZuj0tkcAtw0Z0vCyA4iviZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6204
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_174007_680479_F2C212CF 
X-CRM114-Status: GOOD (  13.93  )
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

T24gMjAyMi8wOS8yNyAxODoxMywgZGlldG1hci5oYWhuQGZ1aml0c3UuY29tIHdyb3RlOg0KPiBG
cm9tOiBIQUdJTyBLQVpVSElUTyjokKnlsL7jgIDkuIDku4EpIDxrLWhhZ2lvLWFiQG5lYy5jb20+
ICB3cm90ZSBUdWVzZGF5LCBTZXB0ZW1iZXIgMjcsIDIwMjIgOTo1OCBBTQ0KPj4NCj4+IE9uIDIw
MjIvMDkvMjYgMTY6MjQsIGRpZXRtYXIuaGFobkBmdWppdHN1LmNvbSB3cm90ZToNCj4+PiBIaSwN
Cj4+PiBJIGhhdmUgYSBMaW51eC1kb20wIHJ1bm5pbmcgd2l0aCBYZW4uIFRoZSBleHRyYWN0aW9u
IG9mIHRoZSB2bWNvcmUgdmlhDQo+Pj4gbWFrZHVtcGZpbGUgc2hvd3MgdGhlIG1lc3NhZ2U6DQo+
Pj4gZ2V0X3hlbl9iYXNpY19pbmZvX3g4Nl82NDogQ2FuJ3QgZ2V0IHRoZSBzeW1ib2wgb2YgeGVu
aGVhcF9waHlzX2VuZC4NCj4+Pg0KPj4+IFRoZSBjb21taXQgMjY1MWQ1NzEgY2hhbmdlZCB0aGUg
YmVoYXZpb3VyIG9mIGluaXRfeGVuX2NyYXNoX2luZm8oKS4NCj4+PiBXaXRoDQo+Pj4gLSAgICAg
ICByZXR1cm4gVFJVRTsNCj4+PiArICAgICAgIHJldCA9IFRSVUU7DQo+Pj4gKw0KPj4+ICtvdXRf
ZXJyb3I6DQo+Pj4gKyAgICAgICBmcmVlKGJ1Zik7DQo+Pj4gdGhlIGJ1ZmZlciBpcyByZWxlYXNl
ZCBidXQgaXQncyBzdGlsbCB1c2VkIGJlY2F1c2Ugb2YNCj4+PiBpbmZvLT54ZW5fY3Jhc2hfaW5m
by5jb20gPSBidWY7DQo+Pj4gVGhpcyBsZWFkcyB0byByYW5kb20gZGF0YSBpbiB0aGUgYnVmZmVy
IGFuZCBsYXRlciB0byB0aGUgbWVudGlvbmVkDQo+Pj4gZXJyb3IuDQo+Pg0KPj4gVGhhbmsgeW91
IGZvciB0aGUgcmVwb3J0IGFuZCBwYXRjaCwgSSBtaXNzZWQgdGhhdCBhdCByZXZpZXcgY29tcGxl
dGVseS4uDQo+Pg0KPj4+DQo+Pj4gV2l0aCB0aGUgY2hhbmdlIGJhY2sgdGhlIG1lbW9yeSBpcyBu
b3QgcmVsZWFzZWQuDQo+Pj4gQnV0IEknbSBub3QgZmFtaWxpYXIgZW5vdWdoIHdpdGggY29kZSB0
byBkZWNpZGUgd2hlcmUgdG8gZG8gdGhpcy4NCj4+DQo+PiBJJ3ZlIHR3ZWFrZWQgdGhlIHBhdGNo
LCBkb2VzIHRoaXMgd29yayBmb3IgeW91Pw0KPiANCj4gWWVzLCBtdWNoIGJldHRlci4NCj4gTXkg
dGVzdCBjYXNlcyBhcmUgd29ya2luZy4NCg0KVGhhbmtzIGZvciB0ZXN0aW5nLCBhcHBsaWVkLg0K
aHR0cHM6Ly9naXRodWIuY29tL21ha2VkdW1wZmlsZS9tYWtlZHVtcGZpbGUvY29tbWl0L2EyMTM2
OTQzYjFmMTczZDJiZjdlZmZmYzI5NTQyNTU2ZTM4YWE1NjQNCg0KVGhhbmtzLA0KS2F6dQ0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
