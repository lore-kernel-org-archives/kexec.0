Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3742BCD37AC
	for <kexec@archiver.kernel.org>; Thu, 14 May 2026 02:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+PWtIDU6j5wy6d5+ZjvbMTL9Fh/dJSpq9z9nYWmFbFA=; b=dV+7ErD2mhcqSrUEy38Sb7WcR2
	uWFhUaZxCWGcEenIoVXsHAazxLDo3Veu8UgwtfyJr4SYQEqoW30W7T/1G+u1UhEzZwVEXLs2lvgZd
	2QgcnfkOyOsFL3quZc1jplI0+ugR6Mr4YH/NMaxJiBQ/68vP+pNdUMnlT98Bq53lMYEsWAFRkDb/S
	JSVsNhYYnfTOTnOBKnCuullEWcYbZ+rA5ez+Nxl461mPZL0pAYxsYzTzuFZsZr9MsaQ0W9eA+0049
	YQiLTx/J84Hwxu/ZhTwi/mxHNWYNr3qKUhSP5DXEsvcCps8rxzPqRK43UbgOa128niOsKd0jGUttq
	G80ke8jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNLmx-00000004MZ0-01Fn;
	Thu, 14 May 2026 02:27:03 +0000
Received: from mail-japanwestazlp170100003.outbound.protection.outlook.com ([2a01:111:f403:c407::3] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNLmt-00000004MWq-42kY
	for kexec@lists.infradead.org;
	Thu, 14 May 2026 02:27:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bj6IG1QrS7ankLqrti89gOIcPYyF4L7BcAsgc//Sc6DYta+onhJIHMnZKMwNa4Z/Myyy1r70qjIWxLmGkXyZsqlqdxWRcff32ue8GkJqoZM2Y+tLqZ0DPWKoHhb+CEurmoogVxDy28tEQcO8UYw9+xxmv24AdSIJAXKJankOd5lBul9G6/5/WvHF56jhXqQp+r2AoKVb9mCUJlGwMMityzHMWmnosbxCibaAHiyNO5rrMTM6dFTQ96B6jjZhdvbuv7tgzpdsMjCWqPuwZd6hj75VbiJmStSJhHMXMen6PkkycEicTdIh/zY4LydMxdawiypbzmsAo4bL7woPF7PfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PWtIDU6j5wy6d5+ZjvbMTL9Fh/dJSpq9z9nYWmFbFA=;
 b=acv5/ZQGsf5Vg39P+El6siHc9hsPYs6LhJEdekir+dbphFi8eInjBTmxytW7fRNFJQXmRjM2DpIeIDGtPhctTG0QUo4gcQEzDAgSrL7rp2FPTZoPkvIz1+sT72S7umjs7erS8QREmLSThr9P1m404rRgEl/9PImJTXdRlvy4B7GgtR8hRS2rLNbVqTnsbKHGQTOPD8T2Ec7Ig5GcskWoewxo1wXc2lalXr5K3nwFJsRZ3uzPKvLbLaeg7ZbcJqGFMSEzl28r0HfGxdjqFINtSTy4j5dhKtOL23CBcu2evAMvJaB9X8SG15J+bJt7t4warNJxrGL+izqyv0ypyNBq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PWtIDU6j5wy6d5+ZjvbMTL9Fh/dJSpq9z9nYWmFbFA=;
 b=ixi83v167UYV1ROv4voY8gNdAR3ZD5aQRqJYXHiq0ALmqMVFcM9ZIOifJU4h1i10nSgDu4V8h4CzHJ8DvOkhKpo5lVbroERrEPgTDYQ1h5wAR/01WAvZh40wlVTky0xCWQi4AEnOMgUwthSFihq4grQr0kL4i29R48GPpQCh7aiVh9gt2O64iB9EhjpXWwCwfJBl9NOe3QfZlus3ndAfrjAg+uN9f+kAV0VIUOgnuSUOda2N7Roc6Qe4TA1VRSqPrip10A6nWL97TfUws7NCeuSULCgTQri/94VfZjfyRUKNSX7BqeBat+1qS60KJnZHxi+YD3HhIsvXfAk2ujCU4g==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by OS7PR01MB12114.jpnprd01.prod.outlook.com
 (2603:1096:604:262::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 02:26:43 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 02:26:43 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Rui Qi <qirui.001@bytedance.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: Shuan He <heshuan@bytedance.com>
Subject: Re: [PATCH][makedumpfile] 2/2 riscv64: Fix huge page translation in
 vtop_riscv64()
Thread-Topic: [PATCH][makedumpfile] 2/2 riscv64: Fix huge page translation in
 vtop_riscv64()
Thread-Index: AQHc3VBmS/JboMtLsU6NKFWY3cUikLYM13KA
Date: Thu, 14 May 2026 02:26:43 +0000
Message-ID: <58d40519-caa4-4ea8-8162-bb213545d6dc@nec.com>
References: <20260506115758.2497610-1-qirui.001@bytedance.com>
 <20260506115758.2497610-3-qirui.001@bytedance.com>
In-Reply-To: <20260506115758.2497610-3-qirui.001@bytedance.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|OS7PR01MB12114:EE_
x-ms-office365-filtering-correlation-id: 8c1f780a-0e8a-4a6c-7726-08deb1603d5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799003|56012099003|38070700021|4143699003;
x-microsoft-antispam-message-info: 5Qho/twcd7JcgJ+QVNlmLwlIbNjgjyBzbCFHEWMo0yaBurkr6yKa1C7YAYw9k5zG+1n6fe0CbbadC82FoN/D+eLpWl93lXmnL1vUhlCzskhLhtpw2hOHg+Lp5nuWVSiyAFTwehjFgeS9rIZa8UAqjcoL+v8zri+KtaFjkXbxzE56XO5SzgdAEWZ8b2uy6XK7+F/9wTvTNCauoE4IiOcFUwoTjwSPFJx99Dh4qpFFVBnSdmjRLf4R4a+3Vf81H5N8T9lht6Tv88F0OK89Qhgr4cLyC3ksY0S598nMeRUVwAC9T5mmLjqRge2BIxVt0iiVTBosVdih8lHEsD7oUvr/DeadT944fk0/EUF7TXrhy1/1wQiGGYw14Kem51vnaZH+iwhEKxW/zKnd5bgBW9uPBw5LmfwcPRmjZ38uYAhElRUstWa1XmyP8cOQfgFQLjsRQ5F+9R2POzJu0yDeZ1UT0FrzmRLZPodfSvoUWbWBwr9FMfI4j5oedLWLksVMm3cJcbnvdu3UZm5XbNCCHL28YwsPof4MV2AKcb3i0kk9e2Gguvra3bLFy27nt4atDtjShgwb2dYIRIYnE+ZdE+yjZ0i/UfVIJfdv9kPXej57uE51OjwSxS8wpGyX49P88ZFv2Txl5hqMJjtd3FfHzXDAFW4pIPVD16wIiJQE4VRPnvA+VSGPmaB2EKpQNuuAKzhyIIIiLQ5Gc9XnyJpAXS5w0Q3mness1kYS/+E2YxvkdMJT7O0gG6cD2vJfVbjSogPg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003)(38070700021)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dS94N1lPdTlKZEZ6ay9kMUpYZERKQWJnSGtKM21KRm9nYXZHQVdZOWxzb2RS?=
 =?utf-8?B?L1BFZlJCYWgyVXJkb1B5VzNqdExDazU1c1VLb3hkMC85WkQwcXVTZ1pCb3Zv?=
 =?utf-8?B?eW5HOFdNZXFyeStER2ZSa2dtTVZLdjEwQXNJcUJRcmt6bjN5ZDZiRmtKOVRn?=
 =?utf-8?B?Yis2T3VCVitIZUtuaHpjdVE4SmZNVnc5VkhabDZ4YXJxRW1BK2gxQ2hpS0Zx?=
 =?utf-8?B?OUJyK3JNbG9ReHhRQlhlSWpRaTdzVUdXY0k0aHh2dnRlakcvMkNiL240R2hE?=
 =?utf-8?B?Y3RqNjk1OVVYeG1sNEhnSzVpZ3RJUHd3MnFBVVhBSW1CazBGd01KU3lYYmdo?=
 =?utf-8?B?SHcrTTVtcCtTc3hoTWdJQ2wybHM1RFpKWVp2NFZ4S0NxSkh6KzAweEZuME8z?=
 =?utf-8?B?ZURhcmhndmJwWEdXWEJqUXJYK0N1MXRyNDVzdnl5UC9sZDJsTkRKUVJWa291?=
 =?utf-8?B?WVl5S1NoVStXSjdURldnMWF6RlNSU05nTzJLQ3plZU91RXo0S1VPNHMwTy9u?=
 =?utf-8?B?OG44TlJ5bEJmenN6WEUrVHo4WEpqRmNna1ZtOUkrT3kzemt3M2wzYUpJUDA1?=
 =?utf-8?B?WFpDRURKdE54d1l4a1JuNzhJQ284ZWUxL013dlhObERoWmdtM0NRUksvNWkr?=
 =?utf-8?B?ejZyeTM1VHVQRGNZREdpU3JYL0IxMitWVzFMUUhmNmVuZWJvaVE0MXR6Uy9o?=
 =?utf-8?B?cmxnYVhsQjJrNEhTN0NoQWZkYXhzaE9XNzh5Nm9LMVF4c0hXdFdOeXdZdm1Y?=
 =?utf-8?B?NlAvRTNlT3J6NXFVbEJ0VjRxYVVUZm5KOUdya29PSlJBUlV0alNpMllPemlq?=
 =?utf-8?B?WVc2T25ZYmQvZWFpYnUzV28wWCtLeWlrU24yVjZBb2xhNkt1L1AvVzFRUkxC?=
 =?utf-8?B?dWtvNnRnN1QvRmZNVmF5aEZFaTlyRWozeGdwaWEwdWwralhEN05vVmVxeEx6?=
 =?utf-8?B?dERRaURjeHBicmZoOFlTaDZ1WEtoZzhBTXVmc21FeWw2OUR4STdRNjlOUUZp?=
 =?utf-8?B?N013VytEWkVmVzlpTDJGaWZqdUR2c1pQdmkxVkczanRwUVl3R1lxWGtWRjZo?=
 =?utf-8?B?SWZVYmN1bEJPUWN5RzdRSkt4a21aN2ZPejBJY0MzeEFwaDZVSlU3enZRNUw0?=
 =?utf-8?B?aTFLM1laN2ZQSXNHSCtqbHQxUEtmaW5vNUNnOEFSOU5xaDI3YWh4dUtWRldh?=
 =?utf-8?B?QTBHZE5USEZPV1B3Y1ZlNi93VGEzSjJNdUdaZG5vNHQyL2UvRkFUSHFwT2J3?=
 =?utf-8?B?dWRTcXRmV3pUMnplcEVFQVRDUlVGbTVseW9wSHQ5dktRaGJhaDd4MlZUK215?=
 =?utf-8?B?OEJZTWdiclVhTHowOGdrVm1nc29VeDdFcFB5UE4vM0tKZGpBYlJiYUF5ZFdK?=
 =?utf-8?B?eEZVMVM2ZFBWQ0c4WUNDSkxnTk05ZlAyYUxiZVpIbjM0WEZvZnFiOUlObXlN?=
 =?utf-8?B?VkNXNFV6K1hzdmRQc1l4TFd4S2VGRUhCZXA1bklWVFBwSWZodHFybm5xYWc1?=
 =?utf-8?B?ZzBUQkt4U2lzY0diNUNCdWpjOUZLdXkralZ1dmljRlRYV2g4VnlvL0ZqcnNO?=
 =?utf-8?B?emdqZkI2Q2VrTi9udzZ4bU1Na1haSkw3Y3BDa3dWZ2x3SThtcnZWK3lPNGE5?=
 =?utf-8?B?TjYySEQrdWZRSWFyY29zTWsyaGhsYlRNcVpGK214N1B2SUpKM0FOSGJicEpP?=
 =?utf-8?B?NnpCbGpGNGpQVXVuckg3Y1hCY3czVGlsM1VWVnFsdFhrOHdUVEFDc1hWeUto?=
 =?utf-8?B?K2tzTXlYSnIrRHJIMXVVYVZKVWwxdGltNkF6V3hSek5wTFk5elZZLytzZ1VH?=
 =?utf-8?B?TWhabk1tRDRCUDdGZHY0Zy95QkJWbStCWEdvQzlTcmk0QXpIYXZYS2ZIdnUr?=
 =?utf-8?B?akZNOXRVK1dIOTMzaUovNDd0bXk0OVNXZWN2VmNaUm1JK1FScTVDN2krOGV5?=
 =?utf-8?B?bXZFTGdJajdtbnUwWHZ5S0hpWjVRd09jRDJIS21ydVAya2VRaG01b1B0N1Vl?=
 =?utf-8?B?TEJ5Z3ZPTGdtMjJmZDNpSit2bkxuTDdENUxoWkFYZ3JDbFh6a2d6WExMTzFn?=
 =?utf-8?B?Q21ITnExTkphS1grSENiTkR5VHZFR29XRWQ3TCtqb3Zsb3lhYXA5NUVKcVJD?=
 =?utf-8?B?WjNkTkU0TTA5RnZ1SlJUQ3RmWU5DVVBhRnhjcDZoTndhajlOcU5EUFZ4YzFK?=
 =?utf-8?B?ZFh1L2ZOTUgxQ2gxaUt2Mmk0bVdYb1pER08ySXRDMnZ6aTFTSUIvT2IwZlFu?=
 =?utf-8?B?OFhqUzBKUnk5bzBMMSttV09WbUZTZzlrOGNBeWJnOWthaVgzRHFWVDQ5enNp?=
 =?utf-8?B?NVBqZkpUMlBVMGlDQ25ONU9aRzQvVmxSb2VwT2k3b1ZDUFFKOEMwdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AEBE9F25A934A4D80187BDE89C3B828@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1f780a-0e8a-4a6c-7726-08deb1603d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 02:26:43.7458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znchI/S6plftvcUxSjIM7e9RKs3iQwMqxX2qhddU+n9wT7Yrix5Rpe3aAFmvFd20kj4FH+dUnhIr85fuH89TGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_192700_300807_B2C74390 
X-CRM114-Status: GOOD (  17.37  )
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

T24gMjAyNi8wNS8wNiAyMDo1NywgUnVpIFFpIHdyb3RlOg0KPiBXaGVuIGEgcGFnZSB0YWJsZSBl
bnRyeSBoYXMgX1BBR0VfTEVBRiBzZXQgYXQgUEdEL1A0RC9QVUQvUE1EIGxldmVsLA0KPiB0aGUg
Y3VycmVudCBjb2RlIGluY29ycmVjdGx5IGZhbGxzIHRocm91Z2ggdG8gdGhlIG5leHQgbGV2ZWwg
aW5zdGVhZA0KPiBvZiBjb21wdXRpbmcgdGhlIGNvcnJlY3QgcGh5c2ljYWwgYWRkcmVzcy4gRml4
IHRoaXMgYnkgY2FsY3VsYXRpbmcNCj4gdGhlIHBhZGRyIHdpdGggdGhlIHByb3BlciBsZXZlbCBz
aGlmdCBhbmQgcmV0dXJuaW5nIGRpcmVjdGx5Lg0KPiANCj4gQ28tZGV2ZWxvcGVkLWJ5OiBSdWkg
UWkgPHFpcnVpLjAwMUBieXRlZGFuY2UuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTaHVhbiBIZSA8
aGVzaHVhbkBieXRlZGFuY2UuY29tPg0KPiAtLS0NCj4gICBhcmNoL3Jpc2N2NjQuYyB8IDI2ICsr
KysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdjY0LmMg
Yi9hcmNoL3Jpc2N2NjQuYw0KPiBpbmRleCAyODM2NWZhMGNjNWIuLjY3NzU1MzMxZGUyNCAxMDA2
NDQNCj4gLS0tIGEvYXJjaC9yaXNjdjY0LmMNCj4gKysrIGIvYXJjaC9yaXNjdjY0LmMNCj4gQEAg
LTEwNyw4ICsxMDcsMTIgQEAgdnRvcF9yaXNjdjY0KHBnZF90ICogcGdkLCB1bnNpZ25lZCBsb25n
IHZhZGRyLCBsb25nIHZhX2JpdHMpDQo+ICAgDQo+ICAgCXB0X3BoeXMgPSAocHRfdmFsID4+IF9Q
QUdFX1BGTl9TSElGVCkgPDwgUEFHRVNISUZUKCk7DQo+ICAgDQo+IC0JaWYgKHB0X3ZhbCAmIF9Q
QUdFX0xFQUYpDQo+IC0JCWdvdG8gb3V0Ow0KDQp0aGUgZm9sbG93aW5nIHdhcm5pbmcgaXMgb2Jz
ZXJ2ZWQ6DQoNCmNjICAtZyAtTzIgLVdhbGwgLURfRklMRV9PRkZTRVRfQklUUz02NCAtRF9MQVJH
RUZJTEVfU09VUkNFIC1EX0xBUkdFRklMRTY0X1NPVVJDRSAtRF9fcmlzY3Y2NF9fIC1VX194ODZf
NjRfXyAtYyAtbyAuL2FyY2gvcmlzY3Y2NC5vIGFyY2gvcmlzY3Y2NC5jDQphcmNoL3Jpc2N2NjQu
YzogSW4gZnVuY3Rpb24gJ3Z0b3BfcmlzY3Y2NCc6DQphcmNoL3Jpc2N2NjQuYzoyMDM6MTogd2Fy
bmluZzogbGFiZWwgJ291dCcgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWxhYmVsXQ0K
ICBvdXQ6DQogIF5+fg0KDQo+ICsJaWYgKHB0X3ZhbCAmIF9QQUdFX0xFQUYpIHsNCj4gKwkJdW5z
aWduZWQgbG9uZyBzaGlmdCA9ICh2YV9iaXRzID09IFZBX0JJVFNfU1Y1NykgPyBQR0RfU0hJRlRf
TDUgOg0KPiArCQkJCSAgICAgICh2YV9iaXRzID09IFZBX0JJVFNfU1Y0OCkgPyBQR0RfU0hJRlRf
TDQgOiBQR0RfU0hJRlRfTDM7DQo+ICsJCXBhZGRyID0gKHB0X3BoeXMgJiB+KCgxVUxMIDw8IHNo
aWZ0KSAtIDEpKSArICh2YWRkciAmICgoMVVMTCA8PCBzaGlmdCkgLSAxKSk7DQo+ICsJCWdvdG8g
aW52YWxpZDsNCg0KanVzdCBhIHN0eWxlIHBvaW50LCBpZiB0aGlzIHBhdGggaXMgbm90IGludmFs
aWQsIHBsZWFzZSBkbyBubyB1c2UgdGhlICdpbnZhbGlkJw0KbGFiZWwgYW5kIGJldHRlciB0byBy
ZXR1cm4gaGVyZSBpbnN0ZWFkLg0KDQpUaGFua3MsDQpLYXp1DQoNCj4gKwl9DQo+ICAgDQo+ICAg
CWlmICh2YV9iaXRzID09IFZBX0JJVFNfU1Y1NykNCj4gICAJCWdvdG8gcDRkOw0KPiBAQCAtMTMz
LDggKzEzNywxMCBAQCBwNGQ6DQo+ICAgDQo+ICAgCXB0X3BoeXMgPSAocHRfdmFsID4+IF9QQUdF
X1BGTl9TSElGVCkgPDwgUEFHRVNISUZUKCk7DQo+ICAgDQo+IC0JaWYgKHB0X3ZhbCAmIF9QQUdF
X0xFQUYpDQo+IC0JCWdvdG8gb3V0Ow0KPiArCWlmIChwdF92YWwgJiBfUEFHRV9MRUFGKSB7DQo+
ICsJCXBhZGRyID0gKHB0X3BoeXMgJiB+KCgxVUxMIDw8IFA0RF9TSElGVCkgLSAxKSkgKyAodmFk
ZHIgJiAoKDFVTEwgPDwgUDREX1NISUZUKSAtIDEpKTsNCj4gKwkJZ290byBpbnZhbGlkOw0KPiAr
CX0NCj4gICBwdWQ6DQo+ICAgCS8qIFBVRCAqLw0KPiAgIAlwdWRhID0gKHB1ZF90ICopKHB0X3Bo
eXMpICsgcHVkX2luZGV4KHZhZGRyKTsNCj4gQEAgLTE1Miw4ICsxNTgsMTAgQEAgcHVkOg0KPiAg
IA0KPiAgIAlwdF9waHlzID0gKHB0X3ZhbCA+PiBfUEFHRV9QRk5fU0hJRlQpIDw8IFBBR0VTSElG
VCgpOw0KPiAgIA0KPiAtCWlmKHB0X3ZhbCAmIF9QQUdFX0xFQUYpDQo+IC0JCWdvdG8gb3V0Ow0K
PiArCWlmIChwdF92YWwgJiBfUEFHRV9MRUFGKSB7DQo+ICsJCXBhZGRyID0gKHB0X3BoeXMgJiB+
KCgxVUxMIDw8IFBVRF9TSElGVCkgLSAxKSkgKyAodmFkZHIgJiAoKDFVTEwgPDwgUFVEX1NISUZU
KSAtIDEpKTsNCj4gKwkJZ290byBpbnZhbGlkOw0KPiArCX0NCj4gICBwbWQ6DQo+ICAgCS8qIFBN
RCAqLw0KPiAgIAlwbWRhID0gKHBtZF90ICopKHB0X3BoeXMpICsgcG1kX2luZGV4KHZhZGRyKTsN
Cj4gQEAgLTE3MSw4ICsxNzksMTAgQEAgcG1kOg0KPiAgIA0KPiAgIAlwdF9waHlzID0gKHB0X3Zh
bCA+PiBfUEFHRV9QRk5fU0hJRlQpIDw8IFBBR0VTSElGVCgpOw0KPiAgIA0KPiAtCWlmIChwdF92
YWwgJiBfUEFHRV9MRUFGKQ0KPiAtCQlnb3RvIG91dDsNCj4gKwlpZiAocHRfdmFsICYgX1BBR0Vf
TEVBRikgew0KPiArCQlwYWRkciA9IChwdF9waHlzICYgfigoMVVMTCA8PCBQTURfU0hJRlQpIC0g
MSkpICsgKHZhZGRyICYgKCgxVUxMIDw8IFBNRF9TSElGVCkgLSAxKSk7DQo+ICsJCWdvdG8gaW52
YWxpZDsNCj4gKwl9DQo+ICAgDQo+ICAgCS8qIFBURSAqLw0KPiAgIAlwdGVhID0gKHB0ZV90ICop
KHB0X3BoeXMpICsgcHRlX2luZGV4KHZhZGRyKTs=

