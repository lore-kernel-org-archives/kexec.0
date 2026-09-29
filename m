Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41D8CA5FA1
	for <kexec@archiver.kernel.org>; Tue, 29 Sep 2026 02:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2S9MDWnYOTpKs2bPF+PlMJUbdw9VC+LTqUv2+MsrUwU=; b=NKdKuQ4hbkw8rsKc2YmsrxJHoe
	5dwggm47l3CYoLex32TOypPbCXNPej0Mf/yfMZE8xD4u5mDzcxqc5VoB8qW5cYADX14Qh+qpw25Ex
	ldG476Hn/SWAh6bmMOnkGpKmq6cAN1G9DVnD4nBMLLcrJINyOhYHLlGj56L4FVCymmBoWYpF+AMCi
	pVG7LAf+lMvYXzynrYRx7wvMzhtchU2Ib3os5l30LpEQxEnV8d6Epq8LQ4By+PiRYa9D1xAQRsZHr
	oscmkwnkUqD5XoF2dzzWCRXioLUG7QOPY/jBF073pcGMkevmKZydqd6KaG5o+21mbWOubx6zKeH57
	r2oTNHAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBNAm-000000025q5-48qn;
	Tue, 29 Sep 2026 02:02:24 +0000
Received: from mail-japanwestazlp170110001.outbound.protection.outlook.com ([2a01:111:f403:c407::1] helo=OS0P286CU010.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBNAk-000000025oS-1Uqf
	for kexec@lists.infradead.org;
	Tue, 29 Sep 2026 02:02:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWIFxl9f2aZHIhBgVIITcF/oPFqvilMOqw+KNFI9AttR1zrthU2hUKe3ALf+pId0Fq2/14jeg/7KesBeIBqbV5SUsgeYTMs6cVa/gveZ/YHE5AAYpjo0Heq8ZCEjRSCL6YpjDZ9r2sC5BcSdYf+zp2Irc77cUzMJuH0aexGClrthfkwUVOyfzy1J4ia/Lbx0tRucuNJTFfXRu8pvwbBxR/2lScrt2W0E+JLPvQHp+KHxvQ0bQ0udE3ZfuBQghr7FC7xh3rk6lcorf8v4Nap5dZSLRS3CAzV+tqoXPpGPva4ZvDbaBPcwBbB3O5jB7g7FCfTbbxpjusrFdg0tJSwzVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2S9MDWnYOTpKs2bPF+PlMJUbdw9VC+LTqUv2+MsrUwU=;
 b=kXvEaWwQJuAb24n4WEWqJJNhcG+z8mpHt5uhKpLzlDm6nGaGdQBKx6yYnVGM2Dii8zFBMuToivkAno+MnYz0TzRX5+9VoRGemAJrIVYHug3oqkUhVhuxvGvmu/QQJ8RFLAHjO0EWQ2PPCPtBazN6lFg5hKV33ewzBfcPSPAEsG82jQzVlZvrnTOQKwKn/6vFncEPNdqAKZpbQhYRRfy6qv1AAMCidH2RPSNfsWE66oEbsuFzaqRJWFIY7kbhfi/GB9ataNd5OS9T341/lRAbQvG84B/Q0M3rO/Mi3LQEGl1D9FCms6bjwjM3gbnr4ec6LJved0mPu295Jc24S568OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2S9MDWnYOTpKs2bPF+PlMJUbdw9VC+LTqUv2+MsrUwU=;
 b=gtSj2yIuNjFnuuhHgHMqG7f7zoDo0apDgf+gdkIJaef00DqKtZQjvbzrtOihwsGAB6d+eI1TslvsH1lN4mgVpr6q6n3zKJuSr6JOVgbXObhqzKmnYRxKzHoWqPA3u/pUb1SbzSVRxfCUbcU421zgaBzDd+7dXrKuQwBjVhCAdWsPPO4aN+7vEglr1OJ8xB+qYipmm+YyRk4OVzETadLPH+VuUOg06BO98iH43o+Utn3julcrSILp23ToKlAeDaIMathXArmQ9lO957cVdGfT22cb2yEoYw+RWhnL0e2kuTBe52wJp7A/BCUInBwxW/ZXyfnDK4xsDk8HwNSP9lTV/g==
Received: from TY1PR01MB10753.jpnprd01.prod.outlook.com
 (2603:1096:400:322::11) by TY4PR01MB14973.jpnprd01.prod.outlook.com
 (2603:1096:405:261::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 02:02:03 +0000
Received: from TY1PR01MB10753.jpnprd01.prod.outlook.com
 ([fe80::2a66:6d54:28:11]) by TY1PR01MB10753.jpnprd01.prod.outlook.com
 ([fe80::2a66:6d54:28:11%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 02:02:03 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<kazuhito.hagio@nec.com>
To: Dave Young <ruirui.yang@linux.dev>, "David Hildenbrand (Arm)"
	<david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He
	<baoquan.he@linux.dev>, David Carlier <devnexen@gmail.com>, Tao Liu
	<ltao@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH] vmcoreinfo: export SECTION_HAS_MEM_MAP
Thread-Topic: [PATCH] vmcoreinfo: export SECTION_HAS_MEM_MAP
Thread-Index: AQHdTzO+BJ2P/k/90UqMIxuihT5eO7bj3nqAgADVNACAABrzAA==
Date: Tue, 29 Sep 2026 02:02:03 +0000
Message-ID: <9d1f8623-c14f-4e51-8aee-6971a4cfbd31@nec.com>
References: <20260928-section_has_mem_map-v1-1-4129f6ba2838@kernel.org>
 <9c47dad9-2716-4ae0-b6e2-9e6b5c718859@linux.dev>
 <4a57b255-cb38-4e8e-908b-d32e55a1a326@kernel.org>
 <a13c01e1-def0-4aa5-b54f-18e523082b29@linux.dev>
In-Reply-To: <a13c01e1-def0-4aa5-b54f-18e523082b29@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB10753:EE_|TY4PR01MB14973:EE_
x-ms-office365-filtering-correlation-id: f46f9057-9096-4454-3db4-08df1dcda83c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: /VKsHQ63y5vyFrtI8JiG/wGh72YR8Wytg8g7eUmuoNAHfDDiYPzp6rpcuX9ZZC7D6caZ3zEVlpURnIh+jaodvqRt1Lha9BE4iDLuAMI1RX+ffmxOK0HqOsykA2cxz4+8pcSQJzFrZb2S8gAhA4D2qRNj50ykP4pZ33dqTgVx0v8tPW/gI5MJVEvRb2Ovmz2cL2CWVxEDseSRhCKR0vtKRsVeAvl58jFSRkEzlksrxFfJCewmnCz2MALZA44JuGFJv0NTqW8oPyUdYZavDFSetMAFC8F10W+pYjV3SLgjooKJG+kFqhipshBcJYYjj4FVlhnrVf7IJOmfLEZSt0pNwNxAYimKaQDaZT411Kb2zM76Wru9UTdjCEcld0jp+hF8bJ0eukrzQCZbc+b/e3G7TkXWjWNxWZxWNcdeM+txqb35wjDAUFn+G4LsJEPtjtk03Q/2bDgW+f1SrTojd4rpstFq6+5n7Iac4MMY/aEtLngLIwgU0fgHjbV4eINza2jrSjukiLtLKNVAr25C4+esCcf4NcjgBGVZ+ZonzLfTSTFAJrNhA9vjuln0uzguFS0mknaN38Q9EBofhDqq+3PATJfw07DUH1wQAzU2WKuQUE+bILFdaEXebzN7AwJsKd87JG0CRhQFfcTNZcVKuP2t+xsvjiKUZKlsoKLf6yhMSd3wahN5PTF/ynxs8hh0KpNF/XHH3oh/pn208KYL/dMQhdUkINfNswTE1xaAzPP+eVE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB10753.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nkp6cGxyT0hsRmJsUHlLdVlPK2tHNStIYlU2MEp0cnE3ZUtyV3AxVHdRVzdw?=
 =?utf-8?B?VlBhZnBjREppQ2FDNkVnUFpDRTVxa2FWSmpUdGhTYnRCWXhXZmticTJkUHA3?=
 =?utf-8?B?QUVxZFVlS2dnellwTVJXc2MyRjlwSHhyS01vS0NVRW5BbHVjTExSdktYWFV4?=
 =?utf-8?B?V2JtQ2E5Y0l5aENOM3QwSFpaVWg3aERCVUI4aHdrNk16ZUc1aU9ocDVzVTcy?=
 =?utf-8?B?TnN3eDEzUHEvREpMZFRrdXc0SlZ6YjZnQ21iQ0dTanpscEVzcFZTMEs3eG5M?=
 =?utf-8?B?RDEvUVQ2Y3MwZ1BIMGFEWFFhcjZlQ1FzY0RjRXJOMWZPc3hDb0Z3L2RSVjBm?=
 =?utf-8?B?blFlOWlnK1ErQjNQYm1LRjRlVmtxMU5WZFlreEhzSng2ZXYwRE92VVgyYkNh?=
 =?utf-8?B?Qkp1RmljbWdMOHA1bk8yRkFyVHdmTlc2cENUOUNwdEdWUlJTQXpONGxwcEY1?=
 =?utf-8?B?bU5jSmVzbG95ZEkwR3J1QjhoQlVJTWxKYzFvRFBiMnVnNStRZndaZkdjNnZV?=
 =?utf-8?B?K3Nra044YzVneTIvNCtKcjRXZWZTY0RoMnNtZ1k1TE95czhzUUFCTlpWVnBL?=
 =?utf-8?B?SE1Za1B5cHZPU0h2dnpqMm9qK1U3THBFZE9TaUtPVVhjU0lVU2pNZnlkdjNY?=
 =?utf-8?B?OGtKWnNlUU1HUTR2QVpvU0x5ai9BaVpTc0FiQnA1c1lUVjZpQURwdGlKb2ZZ?=
 =?utf-8?B?bUk2TVhxdExSbXRJeUxjM3A1azFtL051cVJSNlN0dEdQZm5oek9RcFJuam5G?=
 =?utf-8?B?RnErUnEzTHNzTExUUFRNelZKeVVlTm9jYmtQcTZrS09YL3pkSjVUam8vaEM5?=
 =?utf-8?B?emM5cWliYzBia2YySEs1eW5rN2lpRmdwTWwwZVJvRjZza3VoWlJXT1dDTXo5?=
 =?utf-8?B?Zkp2MUJZS1RGdDcwbDJtWm8wUVEwYkQrNDY1RHVkNXpNSVkxbHhvdzlER05s?=
 =?utf-8?B?V09Gbml5bjJldURUbUFEUFFjaEprODBYaUFVSU1qcUZpTkg2TXpOdUlkU2g2?=
 =?utf-8?B?SG5aa1FnSE00eGVaL0VtSXl4cnVrUUtKZ0FteGZ5cnU4WktucXpsa1hzSG4z?=
 =?utf-8?B?aHZMcVJoTWNZU0Y2SXVjZktTSS92c29Od0t1clBOUGtZaXo5U2ladGlWN1ZX?=
 =?utf-8?B?NTZzNENUUWppNTRjeHVUcnRsVnJ0Zm1yNU5BSG5qYzVvUGMxUG0vRTlZL3Fn?=
 =?utf-8?B?L09hZFdHMWFWMDdPU3BSTk1sRkE2MGRpZ3BKZE9vNU5MQkc1QjFLWFE2emVC?=
 =?utf-8?B?OURaenl4bjZjMjdTTzMrc0Nod3JFY0NLWVkrU3JoYWt0V0dxVUpaMlFXVWZj?=
 =?utf-8?B?N2lER2VZNXpTZFdwS0RHWGN6SmpUbTZGcHRDWlNQc2I4UkY2ZFA3MjRGaUd0?=
 =?utf-8?B?RFBtS1IwMXB4MnBQYTRCU2xnNTZvTHUxN0FQb0pua1FXUllkeWRWN3Y2ckxt?=
 =?utf-8?B?enNYaytTMDNVRFM1bzFOWGNUakhtUmFTeER0RjVzdjV5WCtjZTdnK3JyVS9U?=
 =?utf-8?B?UmJSYlZXTWRQZVF5OFBBNjR3TGN6WTBjMDAxUXE5UTdacUdkdnViN210bDkv?=
 =?utf-8?B?OVFiZENlYmtVWW81OENKUHRvdUdEQVl5YjVxcEtyZzZSOFQ5K2ZmU0R4b2JT?=
 =?utf-8?B?TVZySC84TkZ4UEFvamF2bm01NkJSWUJ0MzY2elUvSWZUQ1pDZVpqUm1hM0lt?=
 =?utf-8?B?YXNBR25QU3N4WnhOUWN4UnlndGxKOWVwZVljdkhVbUhtZklZb0RrRjJlVktt?=
 =?utf-8?B?MktmSnZIOHVyY1oxZXdsQVV1MndCcWIrbGZienNoSkJRaXlWc1piYTJ4NCtT?=
 =?utf-8?B?S1ZkaTV1MFpKVjV5eTI0ZDlDMGdPM2hZelA5TURqNStTenlTbmhxQjBOQ09F?=
 =?utf-8?B?UTFqb20reG50TkpFNzRBeWZqcDdRN1hZRUsxNmFqWW1TTUV2bFdHVStjT1ll?=
 =?utf-8?B?Vm1zbkdYbitXbkNkWWNnVjl5eEVWbmZ3MS8wb3ZrVVNGemM1TVJ6S1lSSVJS?=
 =?utf-8?B?N1Q4eFJFc3l4akVqeThDQytnSmV1UjJrTThsVXhWeldia29LNFlmd0lsUGdB?=
 =?utf-8?B?WFFrRWs1YU93Rm1oREpxVmp4NzhBc1YrWFIwc2JadTF5cHc1K3RsUndob1Yx?=
 =?utf-8?B?SG5aOXZlMzF0YzY0SUdsSXFpZ2NXemxOUTRJL0E1SWFOZ3cvWWF6SGlpbnIw?=
 =?utf-8?B?TXV0Nm1hRUJ1ZFhZWmIyM0JnbmVZN2Z5RWU5N2FmYUxvVW1rdVRNRFZhNzJX?=
 =?utf-8?B?YXdkZktVK29WS2JlY0hoaDdkSHJnOEorc3ZLayt6eVNNZ3VjVzZ4SEVxQnIv?=
 =?utf-8?B?NmJydnNlaUNIbmpFdXRlZjQ5b0t3emlOT1BJRkxMUlN1Rkc3NGpmbzhVdHdD?=
 =?utf-8?Q?CJQfKOX1MyHlTEvA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68F2A203F2584540815548E4C4C0CCD9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB10753.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46f9057-9096-4454-3db4-08df1dcda83c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 02:02:03.7819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0+6+DpbPyI2MpAO1NhwJEicUKgjYDp7MfzGcDkIUiLMSOq1+WCJiMLmahQKM6tM5jZH8Quzf2LGWr9TnL5jSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14973
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_190222_402686_14F611D3 
X-CRM114-Status: GOOD (  20.09  )
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

DQoNCk9uIDIwMjYvMDkvMjkgOToyNSwgRGF2ZSBZb3VuZyB3cm90ZToNCj4gT24gOS8yOC8yNiA3
OjQyIFBNLCBEYXZpZCBIaWxkZW5icmFuZCAoQXJtKSB3cm90ZToNCj4+IE9uIDkvMjgvMjYgMTI6
MjMsIERhdmUgWW91bmcgd3JvdGU6DQo+Pj4gT24gOS8yOC8yNiA0OjQ4IFBNLCBEYXZpZCBIaWxk
ZW5icmFuZCAoQXJtKSB3cm90ZToNCj4+Pj4gVGhlIGNyYXNoIHRvb2wgY3VycmVudGx5IGhhcmRj
b2RlcyBTRUNUSU9OX0hBU19NRU1fTUFQLCBhbmQgbWFrZWR1bXBmaWxlDQo+Pj4+IG5lZWRzIHNp
bWlsYXIgaW5mb3JtYXRpb24gKGFsdGhvdWdoIHN0aWxsIHJlbHlpbmcgb24NCj4+Pj4gU0VDVElP
Tl9NQVJLRURfUFJFU0VOVCwgaXQgc2hvdWxkIHN3aXRjaCB0byBTRUNUSU9OX0hBU19NRU1fTUFQ
KS4NCj4+Pj4NCj4+Pj4gTGV0J3MganVzdCBleHBvcnQgdGhlIHZhbHVlIGluc3RlYWQsIHNvIHRv
b2xzIHRoYXQgd29yayBvbiB2bWNvcmVpbmZvDQo+Pj4+IHdpbGwgbm90IGhhdmUgdG8gZ3Vlc3Mu
DQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEhpbGRlbmJyYW5kIChBcm0pIDxkYXZp
ZEBrZXJuZWwub3JnPg0KPj4+PiAtLS0NCj4+Pj4gUmVzdWx0IG9mIHRoZSBkaXNjdXNzaW9uIGlu
IHJlcGx5IHRvICJbUEFUQ0ggdjIgMDAvMTNdIG1tL3NwYXJzZTogcmVtb3ZlDQo+Pj4+IFNFQ1RJ
T05fTUFSS0VEX1BSRVNFTlQgYW5kIGZ1cnRoZXIgY2xlYW51cHMiIFsxXQ0KPj4+Pg0KPj4+PiBU
aGlzIHBhdGNoIGNhbiBnbyBpbiBpbmRlcGVuZGVudGx5LiBJdCB3b3VsZCBiZSBwcmVmZXJhYmxl
IGlmIGJvdGgNCj4+Pj4gZ28gaW50byB0aGUgc2FtZSBrZXJuZWwgcmVsZWFzZSA7KQ0KPj4+Pg0K
Pj4+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDkyMS1iNC1zcGFyc2VtZW1f
Y2xlYW51cHMtdjItMC01NGQ4MWQ2NWUxMjVAa2VybmVsLm9yZw0KPj4+PiAtLS0NCj4+Pj4gICBr
ZXJuZWwvdm1jb3JlX2luZm8uYyB8IDEgKw0KPj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEva2VybmVsL3ZtY29yZV9pbmZvLmMgYi9r
ZXJuZWwvdm1jb3JlX2luZm8uYw0KPj4+PiBpbmRleCA1YTQxN2Y4YTkyMmEuLjc4MzNhMzYwNjRh
OCAxMDA2NDQNCj4+Pj4gLS0tIGEva2VybmVsL3ZtY29yZV9pbmZvLmMNCj4+Pj4gKysrIGIva2Vy
bmVsL3ZtY29yZV9pbmZvLmMNCj4+Pj4gQEAgLTE4Miw2ICsxODIsNyBAQCBzdGF0aWMgaW50IF9f
aW5pdCBjcmFzaF9zYXZlX3ZtY29yZWluZm9faW5pdCh2b2lkKQ0KPj4+PiAgIAlWTUNPUkVJTkZP
X1NUUlVDVF9TSVpFKG1lbV9zZWN0aW9uKTsNCj4+Pj4gICAJVk1DT1JFSU5GT19PRkZTRVQobWVt
X3NlY3Rpb24sIHNlY3Rpb25fbWVtX21hcCk7DQo+Pj4+ICAgCVZNQ09SRUlORk9fTlVNQkVSKFNF
Q1RJT05fU0laRV9CSVRTKTsNCj4+Pj4gKwlWTUNPUkVJTkZPX05VTUJFUihTRUNUSU9OX0hBU19N
RU1fTUFQKTsNCj4+Pj4gICAJVk1DT1JFSU5GT19OVU1CRVIoTUFYX1BIWVNNRU1fQklUUyk7DQo+
Pj4+ICAgI2VuZGlmDQo+Pj4+ICAgCVZNQ09SRUlORk9fU1RSVUNUX1NJWkUocGFnZSk7DQo+Pj4N
Cj4+PiBDdXJyZW50IGNyYXNoIGNvZGUgbG9va3MgYmVsb3c6DQo+Pj4gI2RlZmluZSBTRUNUSU9O
X01BUktFRF9QUkVTRU5UICAgICAgICAgICgxVUw8PDApDQo+Pj4gI2RlZmluZSBTRUNUSU9OX0hB
U19NRU1fTUFQICAgICAgICAgICAgICgxVUw8PDEpDQo+Pj4gI2RlZmluZSBTRUNUSU9OX0lTX09O
TElORSAgICAgICAgICAgICAgICgxVUw8PDIpDQo+Pj4gI2RlZmluZSBTRUNUSU9OX0lTX0VBUkxZ
ICAgICAgICAgICAgICAgICgxVUw8PDMpDQo+Pj4gI2RlZmluZSBTRUNUSU9OX1RBSU5UX1pPTkVf
REVWSUNFICAgICAgICgxVUw8PDQpDQo+Pj4gI2RlZmluZSBTRUNUSU9OX01BUF9MQVNUX0JJVCAg
ICAgICAgICAgICgxVUw8PDUpDQo+Pj4gI2RlZmluZSBTRUNUSU9OX01BUF9NQVNLICAgICAgICAg
ICAgICAgICh+KFNFQ1RJT05fTUFQX0xBU1RfQklULTEpKQ0KPj4+DQo+Pj4NCj4+PiBBbmQgaXQg
ZG9lcyBub3QgbWF0Y2ggdGhlIGtlcm5lbCBmb3IgYmVsb3cgY2h1bmsgd2l0aCBpZmRlZg0KPj4+
ICNpZmRlZiBDT05GSUdfWk9ORV9ERVZJQ0UNCj4+PiAgICAgICAgICBTRUNUSU9OX1RBSU5UX1pP
TkVfREVWSUNFX0JJVCwNCj4+PiAjZW5kaWYNCj4+PiAjaWZkZWYgQ09ORklHX1NQQVJTRU1FTV9W
TUVNTUFQX1BSRUlOSVQNCj4+PiAgICAgICAgICBTRUNUSU9OX0lTX1ZNRU1NQVBfUFJFSU5JVF9C
SVQsDQo+Pj4gI2VuZGlmDQo+Pj4NCj4+PiBUaGUgbGFzdCBiaXQgY291bGQgYmUgd3JvbmcgaW4g
Y3Jhc2guICBTbyBhbGwgbnVtYmVycyBzaG91bGQgYmUgZXhwb3J0ZWQgaW4gdm1jb3JlaW5mby4N
Cj4+Pg0KPj4+IFRob3VnaHRzPw0KPj4NCj4+IFlvdSBrbm93IHRoZSBjcmFzaCBjb2RlIGJlc3Qs
IHNvIGxpa2VseSAuLi4gaXQncyB0aW1lIG9uZSBvZiB0aGUgY3Jhc2ggcGVvcGxlDQo+PiB0YWtl
cyBvdmVyIHRoaXMgcGF0Y2g/DQo+IA0KPiBSZXRoaW5raW5nIGFib3V0IGl0IEknbSBoZXNpdGF0
aW5nIHRvIGFkZCBtYW55IG1vcmUgdG8gdm1jb3JlaW5mbyBhbHRob3VnaCBpdCBpcyByZWFzb25h
YmxlLCAgYWJvdXQgdGhlICNpZmRlZiB0aGluZ3MsIHRoZXJlIGFyZSBvdGhlciBwbGFjZXMgb3Ro
ZXIgdGhhbiBtbSwgY3Jhc2ggY2FuIG5vdCBkZXBlbmQgb24gdGhlIC9wcm9jL2NvbmZpZy5neiB3
aGljaCBpcyBub3QgcmVsaWFibGUgaW4gdGhlIG9sZCBrZXJuZWwgbWVtb3J5LCBtYXliZSBpdCB3
aWxsIGJlIGhlbHBmdWwgdG8gZXhwb3J0IGFub3RoZXIgZWxmIG5vdGUgZm9yIG9sZCBrZXJuZWwn
cyBrY29uZmlnLiAgU28gSSdkIGxpa2UgdG8gc3VwcG9ydCB0byB1c2UgeW91ciBwYXRjaCBmb3Ig
dGhlIHRpbWUgYmVpbmcgYXMgdGhlIGZpcnN0IGJpdCBpcyBhbHdheXMgbmVlZGVkIGFuZCBsZWF2
ZSB0aGUgcmVtYWluaW5nIGNvbmNlcm5zIGEgZm9sbG93IHVwIGl0ZW0uDQoNCkkgYWdyZWUsIGZy
b20gbWFrZWR1bXBmaWxlJ3MgdmlldyBwb2ludC4NCg0KKHRvIGJlIGV4YWN0LCBtYWtlZHVtcGZp
bGUgbmVlZHMgdGhpcyBidXQgbWF5YmUgY3Jhc2ggY2FuIHJlYWQgZW51bSB2YWx1ZXMgZnJvbSB2
bWxpbnV4LikNCg0KVGhhbmtzLA0KS2F6dQ0KDQo+IA0KPiBUaGFua3MNCj4gRGF2ZQ==

