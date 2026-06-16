Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F408CD98E0
	for <kexec@archiver.kernel.org>; Tue, 16 Jun 2026 07:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8OrVdMvZU1+zLySnp2PQKkaezNtSAU3E8E+fHXllLKY=; b=MVBOocVMsWTCxikgN76U+WCFf/
	NLUSP9effv/lStgwp0Qq5qB+0mki6RqzJTgGQBBbA6oeIT/SuE8WX9RVElTYwIUAruCIk0yZa31XS
	ICy/+ZAVVYbcgEJsk0VaoXGOtCH0W1soeNB3dkvaY/Csjy1UJfUXRJiXovS7xCJ+WiMC/DVgKM6zJ
	q1GY0najpVxOxH9y/lGJ0smIGFd4KDvWMrDx9lUppr45CkwWNi1cmkh51w0Dl3o16Cfq+m/3ESIEE
	oiOqR+fkZ3qZkNDRM95YcnMcY7cdgKc74w0r50JvjONM51jwfChh0mul8UQbseShUQzEhPn6QXSSY
	kML6B5UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZOaV-0000000FOm2-3Oe6;
	Tue, 16 Jun 2026 07:51:59 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZOaQ-0000000FOk0-41Mf
	for kexec@lists.infradead.org;
	Tue, 16 Jun 2026 07:51:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWp9/XUFFJlxY6wXwMXjb89Dqx5HWfogBbjcaJ+hVWI8CPdEbi3/lCPYHsnhV6EjD17WNX0FMfWuQlGseAPR7nkYId5nPMcG+GXaJNJseIvJ9m+HXbitKkAfmHD5KQ+xF6VUkcKJxdVoqvlgu+0GyCoIdsb50L8NH6y4IKhPN6tDZRzeXGAj6kG8+kvlbgfDdiIsu7iDTxmlZJHzjHxQyjsDFnSPD0xg8433gRnPctFKtzOteytpjIRUjaMrg9HcQJTp1mr5B+ysS4vz+0h48Ow9iU37nGcGxRTwWmczuMEd1K5F5XSCLCxhQ++iOzdRcdmrMtdkfAaasX44lc4HzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OrVdMvZU1+zLySnp2PQKkaezNtSAU3E8E+fHXllLKY=;
 b=TpiNI45K95nGFN2qIWpoyvNPMnNmp5fd2qzRfuHlCmOgrJQibGpyDyLDywDdwWAZeAfR3mZ/Usqb48DVMXapQVX3aefDUl5vWvbraUYfkRZ02dELuAvJQvm7eQjALWk+Rg10lMXdDA71G4qNZzExUCdqV4HJv64R+KHdOSomFkHk1c7H5aBQVzoLS68mPbb8Hn8dtlL/og9riDxkI2qIQVXGXzksirog4a5jNBmXwg5P9XfPnqfOcoCA8ckpmscWF9/74iFhfo7PYOMzHGXBDcveHre3EFakcgriZENl4Me8LsFP7fTLOvKxQwMFRhrSbVemH/IKdy4IBGqTlRswCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OrVdMvZU1+zLySnp2PQKkaezNtSAU3E8E+fHXllLKY=;
 b=RakDsHaKYSE5nW/FFuWkJpYRtnVotqqEb5bGla2/jFh1cxIe9VzOHkfY5pknAK4B5OE/m6MbVyhKhUwBFcYpqLYyoxIbCqBeHSZagQZ/oC3s1ItQZudNFrV5Ci5Q5iaxnsbj4YSVY86CPYppe/TpjutldBtPMpMzHTlRupUTdwTqSGdclrJ8rk6gmmIh2rKfcv6YPCLrl5NLzy3Fbv630HbrU4emIbpjuM9uMJPZ9WjHR9yWl+pRoFRYYL9ISzUGhOg3q2Sz3Y9fkxJKOzzegp6u2DD4PFJ0a0SqBCyDuaxpPB1Rcgy4ApMqx7UwSfQGhboiOarO+kkQun6P8WQoAg==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by OS9PR01MB18050.jpnprd01.prod.outlook.com
 (2603:1096:604:46b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 07:51:48 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 07:51:48 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>
CC: Stephen Brennan <stephen.s.brennan@oracle.com>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH v5][makedumpfile 6/9] Add makedumpfile extensions support
Thread-Topic: [PATCH v5][makedumpfile 6/9] Add makedumpfile extensions support
Thread-Index: AQHcy/lclxSqixzmRk+7o4cMJqDfsbY/pKkAgACXlICAAGIggIAAK62AgAAKcYCAAF1ngA==
Date: Tue, 16 Jun 2026 07:51:47 +0000
Message-ID: <ab1b5e58-bad6-4565-a408-b1fb3d489465@nec.com>
References: <20260414102656.55200-1-ltao@redhat.com>
 <20260414102656.55200-7-ltao@redhat.com>
 <8b0079dd-e50a-4667-aabf-1612921b022a@nec.com> <874ij3zq1k.fsf@oracle.com>
 <CAO7dBbU6V7XYYO9M+z_CK8UCnzfX7TB7DZka4Z_kqP-WvDbTaA@mail.gmail.com>
 <f15ae344-bdcc-48a1-9c7b-0ea264d061d4@nec.com>
 <CAO7dBbXLBX9_Ut9yQDkOr3pWq-mSx-5=tMUU9FL83eA3Lz0c_g@mail.gmail.com>
In-Reply-To: <CAO7dBbXLBX9_Ut9yQDkOr3pWq-mSx-5=tMUU9FL83eA3Lz0c_g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|OS9PR01MB18050:EE_
x-ms-office365-filtering-correlation-id: 58f4fc9e-5234-4238-62eb-08decb7c1e79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|11063799006|56012099006|6133799003|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: YJHLK7o7/mIfUAKgrpqDr0qSROaKXKrxYWYwmHpDQvLGBABU27uKRY6GQ6hO35Abw9d6lw3nBVgeD0TP/nzKspvovySfK4YkWvUAYRgOoqeC23dyaOlOX7G1oifx8xZZof8Pz/gKre5s++zzfbp5zbHYEhUBVyt5nDZ93gq5K5tmbZvZjti4+eUyhgJrzjUr12sjZPhCEN+rBM7jW4PR7+AN07L5Kf1MpLgYozk7ulWFZyMmJ2WJTQK5jSNpDmyq11qt5PVIGe1UoN1kW260VJLvYwl690oXxA9HBnouDQPMluqxM7VRlGglTMy14Xg4MQbkIbvlhXfnJ69YtIjDulDxwrwCHAWUJqhZe+qj8GWS0P7Sx5Fbg2VmC8DSRsENQew41YpB3LnOdaEtTFTTAyAtK13OVbOhfJWHMMhFutgrBSmcM5awPrr64ssLvxC9uA9q8OeJhn3chhnaKBoaUGezZVYqCV0djtXk/v83VZjMIDo4nkA2/IfT0Ea1yuOX9r5xrZmJKeicRBlXY5WiNtAIPXC2uk2RUVgqI7kKAPyJecKCjD9/CUEPpyhbwYPx9by5GR0LTHLa1skw2qi/wCZRyCbrec3IsxbZzi9EHXhyyryH5cXYYzw5E3XX9io4VXcFmPWJAVJa0xssZ1RCrE0nr54vKjTnyDO5bXL2qMI7o1gYe8RtCB3Nf8ATD/Zg1l5uJrTB0RHfeMm80sUGTlw+19/xJiR36IjTyCCxP2W4ag4d/V2ihJypieco0GXZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVhNQ2lrYUpvb3NGd29zdk11clQzK1F1ajRKTHh0a3ZxSFEwQkFMWHBWZkYz?=
 =?utf-8?B?bXB6c0JZMi9Qb3dYdXZWTHhmZmpHck94bHJRUXFZUVFTdkdoUDlMa2dmQ05S?=
 =?utf-8?B?REZ1d0k0UUNTZTdKdWlETk9iOTduQkdRM2lnRFR0QWlqY0xqSHMyZlE0Q21p?=
 =?utf-8?B?VFMrTXRnY3dGQ0twUlo4ajlSSDdjWGdCRWpNWlNSV1VaWUc0QWJIbi9JenZQ?=
 =?utf-8?B?clZVZnFKeU15aDdkUHF1aEYrTHZsNXRIdXBEVHRRcXkwMkhVZTNraTlrWGdY?=
 =?utf-8?B?ZDM2eDl0NjJ0SitKc01oSG5oZkRMeS9qY2duN09RcmdFTnBrZTZ2SzVLM3ds?=
 =?utf-8?B?eTR0ZnRBRjF2bTY0a2U0MlVkNVhlVTNvMzN5ZVpGb3hZREcxMFhWaEhCNEpV?=
 =?utf-8?B?M1YvUEJnMU8vdVo1ZTRhcWpRaG9wbmN3d2w3VXRyTjVwTWVNYnZneTdIb0tj?=
 =?utf-8?B?Ujg4UUphNEtoSEhNVUkrV0lOL0IxSVplMm0wQWFwTGJNOEtmNElmYWM0YXJn?=
 =?utf-8?B?K09yTkE3S0tMd3hPQmUweTR4MXRLekQ4ekhram1UU0hQbEFJSGxXbTc1UEwr?=
 =?utf-8?B?b0xDMTlWalFiY0VUOW1IaTdrQzJvQ0FxdnNHQkFSVDdvSDhzd1g3cklOMlRX?=
 =?utf-8?B?QnVzVndhVDdMTFN6SWJwS0hQQ2pURnVNR3V1WjFpVFFoaUNQcXcwTGVFOWZs?=
 =?utf-8?B?RW9qcXhWT0NwQ1M4UzBPbGVXSHM5UjlFdzdzcjlKeFpoTEF2Q1dMZjBlNHRW?=
 =?utf-8?B?NjE2YmJ2blZkeWhrVUdPbUlnNWZjQXdJSEdZRlNKY0laOUJuaEg2VDlKQ3k1?=
 =?utf-8?B?VFNBZmN2d2JZWFpRdm1wbUpVRUsvellDVHlpZUtYSm5YK0FWaGNrYkZZYlZK?=
 =?utf-8?B?Z0pSZmhhM0JqcFhUS2xndkFLUEZIcll6c081dlVjTFJKaDZlbDluS210WHkx?=
 =?utf-8?B?Tk1pc21Fd0RuZ0lDQ1hvK2hoM2F3NmY3TGdGRy9rNlZkQ1BKekJlWTlCcmJX?=
 =?utf-8?B?MEtlMFhCbjVwdExrSU04TjJva0QvcStlOGF0S3c5bUR2bnB5R1k5alNvZDF3?=
 =?utf-8?B?eEthVWtqNy8wY1c0QUp6TytjZHNYS3ZKQmpCaW9sdkp3VjdzTjlnazhxamhX?=
 =?utf-8?B?N0ZMeTlEdForejkwT25tMCsrTjJvenNlWDYrNk9POGRBaDBxWi9jWEplZUEx?=
 =?utf-8?B?dTdIb1hBL2hrUjdFTDIzVXlRRktZdWw1eSthVVFwOVJZWGtJMklrWkZ4bEFN?=
 =?utf-8?B?STlUYXZHVGUxcUMxSjRJbno2MXBqaWl4UlRDazY1UjZrRktyemROakg1bDhG?=
 =?utf-8?B?NjZzeFIzRDkrelhBMzA1bHVrTTVyVGZuNndGQTBxejc5QUdET0hiQm9KNHox?=
 =?utf-8?B?YnNRSzQ4aDcyUVZXdHJ2Zk9ENW9Nb0RWNDJ1T3BEcy81VmsxYkhJOXJ0Z1VJ?=
 =?utf-8?B?NlBCRkxVYkdvcjNGK2lDMGw3eE5zQTAvanhLbUNQdWtHeDZxOGV2cTRYdE1X?=
 =?utf-8?B?aXNiblNOeVpWOXZ3MEhFYjRDZk9WbFQzSE1Od3dWT1FBLzFRaGxDOHBQbUdk?=
 =?utf-8?B?MW9wMDhZczV0Z3U3cVpKTWpjZXI2c2szV0NkbGRqeUZKRzA0ZCtNMDZrd3Vt?=
 =?utf-8?B?WGN1dEpUaWVmMnE2WUJPYWtyZnhReDNyZS91VVdETHNmVy9kLzluVnBHQXRD?=
 =?utf-8?B?OElWZ3Z3UTFqeXRyQ0hyUDhTaWtrSGwyTEVGcFU1MEFsMW5tU2ZoNlVaaC91?=
 =?utf-8?B?SnpPOXg4UGJ5cjJVeit1WERXbjJIOWJKNm5ZUVFvK09kOTRmU05WZHpaN0x0?=
 =?utf-8?B?L1I1YkFHeWExU1NQZkJRalArZVdDRUVFakF0amhKRjBIZ2RaTlNzSzFZNUEx?=
 =?utf-8?B?OXJub3BIWE9XNEh3SndnVS9PQU5icUJDTUhWNU16cFh3dkxQVXhBM1FVMk5G?=
 =?utf-8?B?aVBQTDNNM3ZMem15c1BKWjVYV2h1b1hRZnk4NXp0WFlPM0ZpaUNtN3NSKzdQ?=
 =?utf-8?B?QmVGdkZ2NmNYbGYyeEFMQTBxa2NwMjZBNy9tbzZCWlpXM0FCYkdLR0FqNUVl?=
 =?utf-8?B?cWNnSlN0SmpROEh3aGQrVXFUTGdNZ3J1dVZ5bGdZSmtWbldTZXhMbVRXWTdJ?=
 =?utf-8?B?b2JBcmlHN0NTYTdPQ2ppTVhUSEFwK0luenBTMS83T1hWbVpZczZsbndBSmR4?=
 =?utf-8?B?eTU4aUlYbGtjZjZVTTFCalBmYzZuc3dOdXUrdUR5TS83NVgyUmpmYWU1a2pU?=
 =?utf-8?B?T1VqdFNDdkRNRW1yVUNZSklTaDFHOVd5SkxaUEJ6K2JodHhscDk5aW92UFRG?=
 =?utf-8?B?U3luNmhGZTFqbVp3SHBRLzBKZlhkRkljR1VnTDFRV1M0RFlSb053Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D32B5678CD72DA42A28B1FC8B056D58A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f4fc9e-5234-4238-62eb-08decb7c1e79
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 07:51:48.0679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qjRNVF+UA7al9D5B+nJgbuvO9f/Ffs8fHnCjOwFxhGIGJ4zGhuxLPmruwnlw/fnjqzfWBZ7BFl55bZUtdYqofw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB18050
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_005155_456741_3C902F94 
X-CRM114-Status: GOOD (  24.08  )
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

T24gMjAyNi8wNi8xNiAxMToxNywgVGFvIExpdSB3cm90ZToNCj4gT24gVHVlLCBKdW4gMTYsIDIw
MjYgYXQgMTozOeKAr1BNIEhBR0lPIEtBWlVISVRPKOiQqeWwvuOAgOS4gOS7gSkNCj4gPGstaGFn
aW8tYWJAbmVjLmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gMjAyNi8wNi8xNiA4OjAzLCBUYW8gTGl1
IHdyb3RlOg0KPj4+IEhpIFN0ZXBoZW4gJiBLYXp1LA0KPj4+DQo+Pj4gT24gVHVlLCBKdW4gMTYs
IDIwMjYgYXQgNToxMuKAr0FNIFN0ZXBoZW4gQnJlbm5hbg0KPj4+IDxzdGVwaGVuLnMuYnJlbm5h
bkBvcmFjbGUuY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4gSEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA
5LiA5LuBKSAgIDxrLWhhZ2lvLWFiQG5lYy5jb20+IHdyaXRlczoNCj4+Pj4+IE9uIDIwMjYvMDQv
MTQgMTk6MjYsIFRhbyBMaXUgd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4+ICtzdGF0aWMgYm9vbCBpbml0
X2thbGxzeW1zX2J0Zih2b2lkKQ0KPj4+Pj4+ICt7DQo+Pj4+Pj4gKyAgICBpbnQgY291bnQ7DQo+
Pj4+Pj4gKyAgICBib29sIHJldCA9IGZhbHNlOw0KPj4+Pj4+ICsgICAgLyogV2Ugd2lsbCBsb2Fk
IG1vZHVsZSdzIGJ0Zi9rYWxsc3ltcyBvbiBkZW1hbmQgKi8NCj4+Pj4+PiArICAgIGJvb2wgaW5p
dF9rc3ltc19tb2R1bGUgPSBmYWxzZTsNCj4+Pj4+PiArICAgIGJvb2wgaW5pdF9rdHlwZXNfbW9k
dWxlID0gZmFsc2U7DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgICAgaWYgKGNoZWNrX2tzeW1zX3JlcXVp
cmVfbW9kbmFtZSgidm1saW51eCIsICZjb3VudCkpIHsNCj4+Pj4+DQo+Pj4+PiBUaGFuayB5b3Ug
Zm9yIHRoZSBleHBsYW5hdGlvbiBbMV0uDQo+Pj4+Pg0KPj4+Pj4gc28gd2hpY2ggY29kZSBwYXRo
IGFkZHMgInZtbGludXgiIHRvIHRoZSBtb2RzIGFycmF5IGJlZm9yZSB0aGlzIGxpbmU/DQo+Pj4+
PiBJIGNvdWxkIG5vdCBmaW5kIGl0Lg0KPj4+Pg0KPj4+PiBIZWxsbyBLYXp1LA0KPj4+Pg0KPj4+
PiBJbiBrYWxsc3ltcy5jIGZyb20gcGF0Y2ggMiwgdGhlcmUgaXMgdGhlIGxpbmU6DQo+Pj4+ICAg
ICBJTklUX01PRF9TWU0odm1saW51eCwgX3N0ZXh0KTsNCj4+Pj4gVGhpcyBhZGRzIGEgc3RydWN0
IGtzeW1faW5mbyB0byB0aGUgbWFpbiBtYWtlZHVtcGZpbGUgZXhlY3V0YWJsZSdzDQo+Pj4+IGFy
cmF5LCB3aGljaCByZXF1ZXN0cyBzeW1ib2wgIl9zdGV4dCIgZnJvbSB2bWxpbnV4Lg0KPj4+Pg0K
Pj4+PiBJbiBrYWxsc3ltcy5jICJpbml0X2tlcm5lbF9rYWxsc3ltcygpIiwgYWdhaW4gZnJvbSBw
YXRjaCAyLCB0aGUgZmlyc3QNCj4+Pj4gc3RlcCBpcyB0byBjYWxsOg0KPj4+PiAgICAgIHJlZ2lz
dGVyX2tzeW1fc2VjdGlvbigoY2hhciAqKV9fc3RhcnRfaW5pdF9rc3ltcywNCj4+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKGNoYXIgKilfX3N0b3BfaW5pdF9rc3ltcykpDQo+Pj4+IFdo
aWNoIGlzIGEgZnVuY3Rpb24gZ2VuZXJhdGVkIGJ5IHRoZSBtYWNybyBSRUdJU1RFUl9TRUNUSU9O
KCkuIFRoZQ0KPj4+PiBpbXBsZW1lbnRhdGlvbiB3aWxsIHVzZSBhZGRfa3N5bV9tb2RuYW1lKCkg
d2hlbnMgaXQgZW5jb3VudGVycyB0aGlzDQo+Pj4+IHN5bWJvbCwgZW5zdXJpbmcgdGhhdCAidm1s
aW51eCIgaXMgcGFydCBvZiB0aGUgbW9kbmFtZSBhcnJheS4NCj4+Pg0KPj4+IFRoYW5rcyBmb3Ig
dGhlIGRldGFpbGVkIGluZm8sIHllcywgaXQgaXMgZXhhY3RseSBob3cgInZtbGludXgiIGlzDQo+
Pj4gYWRkZWQgdG8gdGhlIGFycmF5Lg0KPj4NCj4+IGhtbSwgbWF5YmUgSSBzdGlsbCBtaXNyZWFk
IGl0IHRob3VnaC4uDQo+Pg0KPj4gVGhlIGluaXRfa2VybmVsX2thbGxzeW1zKCkgaXMgY2FsbGVk
IF9hZnRlcl8gY2hlY2tfa3N5bXNfcmVxdWlyZV9tb2RuYW1lKCkuDQo+PiBzbyBJJ3ZlIG1lYW50
IHRoYXQgaWYgbm8gZXh0ZW5zaW9uIGFkZHMgInZtbGludXgiIHRvIHRoZSBtb2RuYW1lIGFycmF5
LA0KPj4gbm8gb25lIGNhbGxzIGl0LiAgaXMgaXQgb2s/DQo+Pg0KPj4gICAgICAgICAgIGlmIChj
aGVja19rc3ltc19yZXF1aXJlX21vZG5hbWUoInZtbGludXgiLCAmY291bnQpKSB7DQo+PiAgICAg
ICAgICAgICAgICAgICBpZiAoIWluaXRfa2VybmVsX2thbGxzeW1zKCkpDQo+IA0KPiBObywgZXZl
biBpZiB5b3UgY3JlYXRlIGEgZXh0ZW5zaW9uIHdoaWNoIGRvZXNuJ3QgcmVxdWlyZSBzeW1ib2xz
IGZyb20NCj4gInZtbGludXgiLCBvbmNlIHlvdSBsb2FkIGl0LCB0aGUgY2hlY2tfa3N5bXNfcmVx
dWlyZV9tb2RuYW1lKCkgd2lsbA0KPiBzdGlsbCBiZSB0cnVlIGFuZCBpbml0X2tlcm5lbF9rYWxs
c3ltcygpIGlzIGNhbGxlZC4NCj4gDQo+IFRoZSByZWFzb24gaXMsIHdpdGggdGhlIGludHJvZHVj
dGlvbiBvZiBtYWtlZHVtcGZpbGUubGQsIGFuZCB0aGUgbGluZQ0KPiAiSU5JVF9NT0RfU1lNKHZt
bGludXgsIF9zdGV4dCk7IiBpbiBrYWxsc3ltcy5jLCBtYWtlZHVtcGZpbGUgYW5kDQo+IGV4dGVu
c2lvbnMgaGF2ZSBhIHNpbWlsYXIgc2VjdGlvbiBzdHJ1Y3R1cmUsIHlvdSBjYW4gcmVnYXJkDQo+
IG1ha2VkdW1wZmlsZSBpdHNlbGYgYXMgYW4gZXh0ZW5zaW9uOg0KPiANCj4gJCByZWFkZWxmIC1T
IG1ha2VkdW1wZmlsZSB8IGdyZXAgLUUgJ2tzeW1zfGt0eXBlcycNCj4gICAgWzI1XSAuaW5pdF9r
c3ltcyAgICAgICBQUk9HQklUUyAgICAgICAgIDAwMDAwMDAwMDA0NmVlOTAgIDAwMDZkZTkwDQo+
ICAgIFsyNl0gLmluaXRfa3R5cGVzICAgICAgUFJPR0JJVFMgICAgICAgICAwMDAwMDAwMDAwNDZl
ZWI4ICAwMDA2ZGViOA0KPiAkIHJlYWRlbGYgLVMgZXh0ZW5zaW9ucy9zYW1wbGUuc28gfCBncmVw
IC1FICdrc3ltc3xrdHlwZXMnDQo+ICAgIFsyNF0gLmluaXRfa3N5bXMgICAgICAgUFJPR0JJVFMg
ICAgICAgICAwMDAwMDAwMDAwMDAzMTA4ICAwMDAwMjEwOA0KPiAgICBbMjVdIC5pbml0X2t0eXBl
cyAgICAgIFBST0dCSVRTICAgICAgICAgMDAwMDAwMDAwMDAwMzExMCAgMDAwMDIxMTANCj4gDQo+
IElmIG1ha2VkdW1wZmlsZSBkb2Vzbid0IGxvYWQgYW55IGV4dGVuc2lvbnMsIHRoZW4gbWFrZWR1
bXBmaWxlIGRvZXNuJ3QNCj4gbmVlZCB0byBpbml0aWFsaXplIGl0cyAuaW5pdF9rc3ltcy9rdHlw
ZXMgc2VjdGlvbiwgdGhlIGJlaGF2aW91ciBzdGF5cw0KPiB0aGUgc2FtZSBhcyBiZWZvcmU7DQo+
IElmIG1ha2VkdW1wZmlsZSBsb2FkIGF0IGxlYXN0IG9uZSBleHRlbnNpb25zLCB0aGVuIHRoZSBl
eHRlbnNpb24NCj4gc3Vic3lzdGVtIHdpbGwgcmVnaXN0ZXIgYWxsIC5pbml0X2tzeW1zL2t0eXBl
cyBzZWN0aW9ucywgYm90aA0KPiBleHRlbmlzb24ncyBhbmQgbWFrZWR1bXBmaWxlJ3MuDQo+IA0K
PiBUaGlzIGlzIGxpa2UsIGV4dGVuc2lvbiBzYXkgIkkgbmVlZCBzeW0xICYgc3ltMiB0byBiZSBy
ZWFkeSBiZWZvcmUgSQ0KPiBjYW4gcnVuIiwgdGhlbiBtYWtlZHVtcGZpbGUgc2F5ICJPSywgSSBn
b3QgaXQsIGJ1dCBiZWZvcmUgSSBjYW4NCj4gcmVzb2x2ZSB5b3VyIHN5bTEgJiBzeW0yLCBJIG5l
ZWQgdG8gcmVzb2x2ZSBzb21lIHN5bWJvbChlLmcuIHZtbGludXgncw0KPiBfc3RleHQpIGZvcm15
c2VsZiBmaXJzdCIuIFNvIGNoZWNrX2tzeW1zX3JlcXVpcmVfbW9kbmFtZSgidm1saW51eCIsDQo+
ICZjb3VudCkgd2lsbCBiZSB0cnVlLg0KDQpobW0sIGJ1dCBhcyBmYXIgYXMgSSd2ZSB0ZXN0ZWQg
d2l0aCAiZXh0ZW5zaW9ucy9zYW1wbGUuYyIgb24gUkhFTDEwLjI6DQoNCjEpIGFkZCBJTklUX01P
RF9TWU0oeGZzLCB4ZnNzdGF0cykgYW5kIEdFVF9NT0RfU1lNKHhmcywgeGZzc3RhdHMpDQoNCm9r
DQoNCkxvYWRlZCBleHRlbnNpb246IC9zaGFyZS90bXAvbWFrZWR1bXBmaWxlL2V4dGVuc2lvbnMv
c2FtcGxlLnNvDQpzYW1wbGUuc286IFRoZSBhZGRyZXNzIG9mIHhmc3N0YXRzIGlzOiBmZmZmZmZm
ZmMwYzBiNTQwICAgPDwtLS0gb2sNCnNhbXBsZS5zbzogVGhlIGFkZHJlc3Mgb2YgaW5pdF90YXNr
IGlzOiBmZmZmZmZmZmI0NDEyOTQwDQpzYW1wbGUuc286IFRoZSBzaXplIG9mIHRhc2tfc3RydWN0
IGlzOiAxMDI0MCBieXRlcw0Kc2FtcGxlLnNvOiBUaGUgb2Zmc2V0IG9mIG1lbWJlciBtbSB3aXRo
aW4gdGFza19zdHJ1Y3QgaXM6IDI3MDQgYnl0ZXMNCnNhbXBsZS5zbzogVGhlIHNpemUgb2YgbWVt
YmVyIG1tIHdpdGhpbiB0YXNrX3N0cnVjdCBpczogOCBieXRlcw0Kc2FtcGxlLnNvOiBZb3VyIGtl
cm5lbCBpcyB1c2luZyBtYXBsZSB0cmVlIGluIG1tX3N0cnVjdA0KDQoyKSByZW1vdmUgYWxsICJ2
bWxpbnV4IiBlbnRyaWVzIChvbmx5IElOSVRfTU9EX1NZTSh4ZnMsIHhmc3N0YXRzKSkNCg0Kc2tp
cHBlZA0KDQpMb2FkZWQgZXh0ZW5zaW9uOiAvc2hhcmUvdG1wL21ha2VkdW1wZmlsZS9leHRlbnNp
b25zL3NhbXBsZS5zbw0KY2hlY2tfcmVxdWlyZWRfa3N5bXNfYWxsX3Jlc29sdmVkOiBTeW1ib2wg
eGZzc3RhdHMgaW4geGZzIG5vdCBmb3VuZA0KaW5pdF9leHRlbnNpb25zOiBTa2lwIDF0aCBleHRl
bnNpb24NCg0KMykgcmVzdG9yZSBJTklUX01PRF9TWU0odm1saW51eCwgaW5pdF90YXNrKSBhbmQg
R0VUX01PRF9TWU0odm1saW51eCwgaW5pdF90YXNrKQ0KDQpzdGlsbCBza2lwcGVkDQoNCkxvYWRl
ZCBleHRlbnNpb246IC9zaGFyZS90bXAvbWFrZWR1bXBmaWxlL2V4dGVuc2lvbnMvc2FtcGxlLnNv
DQpjaGVja19yZXF1aXJlZF9rc3ltc19hbGxfcmVzb2x2ZWQ6IFN5bWJvbCB4ZnNzdGF0cyBpbiB4
ZnMgbm90IGZvdW5kDQppbml0X2V4dGVuc2lvbnM6IFNraXAgMXRoIGV4dGVuc2lvbg0KDQo0KSBh
bHNvIHJlc3RvcmUgSU5JVF9NT0RfU1RSVUNUX01FTUJFUih2bWxpbnV4LCB0YXNrX3N0cnVjdCwg
bW0pIGFuZA0KICAgIEdFVF9NT0RfU1RSVUNUX01FTUJFUl9TU0laRSh2bWxpbnV4LCB0YXNrX3N0
cnVjdCwgbW0pDQoNCm9rDQoNCkxvYWRlZCBleHRlbnNpb246IC9zaGFyZS90bXAvbWFrZWR1bXBm
aWxlL2V4dGVuc2lvbnMvc2FtcGxlLnNvDQpzYW1wbGUuc286IFRoZSBhZGRyZXNzIG9mIHhmc3N0
YXRzIGlzOiBmZmZmZmZmZmMwYzBiNTQwDQpzYW1wbGUuc286IFRoZSBhZGRyZXNzIG9mIGluaXRf
dGFzayBpczogZmZmZmZmZmZiNDQxMjk0MA0Kc2FtcGxlLnNvOiBUaGUgc2l6ZSBvZiB0YXNrX3N0
cnVjdCBpczogMTAyNDAgYnl0ZXMNCg0KDQpTbywgaXQgbG9va3MgbGlrZSwgd2l0aCB0aGUgY3Vy
cmVudCBjb25kaXRpb24gY2hlY2sgaW4gaW5pdF9rYWxsc3ltc19idGYoKQ0KKGNoZWNrX2tzeW1z
X3JlcXVpcmVfbW9kbmFtZSBhbmQgY2hlY2tfa3R5cGVzX3JlcXVpcmVfbW9kbmFtZSksDQphIG1v
ZHVsZSBuZWVkcyB0byB1c2UgSU5JVF8qIGZvciB2bWxpbnV4J3Mga2FsbHN5bXMgYW5kIEJURi4N
Cg0KSSdtIHN0aWxsIG1pc3Npbmcgc29tZXRoaW5nLi4/DQoNClRoYW5rcywNCkthenUNCg==

