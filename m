Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6C0CD98C5
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 08:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+D+6JocHW+u8L7RRcL7bPImW5GM/2hfYTxdVmdRh1SM=; b=p7hbQ8Fvy/OU/VVKQTntFNCrZI
	UMbqAlQDuNsxx0fgyvbSZ6ot5rIGbkyzQDDbsovtaZ5wZ+k0pHIPsyzv5Ajl926ZXuPkSeIAL17bl
	nFQSmpCz0dwGaZoXN0y9p2AN83VSuSTUmG9WJT2XRN35RBwsMko6fX5KXqDjWEDbpOntcNewNy7f7
	nW9NhHaxDSUpAOnMR40HcrCoVlzS8itSppKs44b80tZ2hK7Mf6nJGLhVlXrusr1Bsn0MFOS4zHjwh
	DOTij5tvxZzLD8VmWe1y0Qsi9Oa+lGjxeA18Wxkui2BdVlldm3tbcEPKFuWyJHfoP31yssVGCbzG3
	eVGxjiCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ2O7-0000000DqAl-1Id7;
	Mon, 15 Jun 2026 08:09:43 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ2O3-0000000Dq9d-0Xa0
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 08:09:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYk2edYb6Sl7Q6tFAd8+IEGESUZif/A8eM8VHW2rSrSYRHA+zY5IF3y7SiuvRW6rOltOQuk/wUgc9yTWpOWK7lHNbPiYU4rMyFFdMXKTUQbBJoVEyh+PsJRHGDnFCSSvfc7da1DcjJa3bj8nHlcFFYX7VDZQGLvINGFjknm+E0au4A5oeP90FxP75QwxInVVhqaNa8SGg1HOlC1b24uBI8YH9sP6JSq766PhvLArp5jz3jTTzqJNfZ6cd3mpzWHii6Q/tZNNb0j386X7CUl8ySnWjY0XKV+xN/lWuEF2CXj/EX8fJOsaCLGLSuD50vEKEO/cczpluB0Npfy8ak7zYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D+6JocHW+u8L7RRcL7bPImW5GM/2hfYTxdVmdRh1SM=;
 b=HXuS0I0rbZfwEEqARZDQ1bdHAxwKQu9WqFNIlix3Bq+Ij7mTuy15tYpOp8C0k18ADDHuDBBQpk9VHvt2/IkL6Pc+7yL1c4mgAMjJGR/wCoFSZI0pVg+Z7boSFXLoEApF/u4vieYTUQ+LJb+jTzzng9fsEZQE+/pwqTR7QKDBJegLtzH44sqEaC4uEq2ho9rKRKQ+WXr6zvoCw8FVOwcVymZqa6iINbEnj9fzp56grT9nAVMLkb0AZz9ZE3nSFBQActJfCjGUeUIzA9O9gtABjr0uGhScQziB7zBHyBmwZ+ENcA+Wl8ShgvpYtQ1Waebzb6vXbAmMVZii56d4kOTEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D+6JocHW+u8L7RRcL7bPImW5GM/2hfYTxdVmdRh1SM=;
 b=EagjW8I4Uce3DcqNo9FO/VBiCtfCEorVxzimFQzF6FZq3xLqtBeLlQ99/rX71a1qsmFvE1PhanT9oxRlLNhFLsULECfgofT2uYuWkMJpI3A7wd4xpCKcjBPQ4irufLm8SMqL2z9O3Hs2YaqDuolZtfIPpCHN6ZB3ZpDsl8/NCl0XZe7sdyFBVqjvoIKM22F56yGBnt/q2uYufS4taUjb+oiQ1Z9PRNKs1N2OC9UZD97BY49mfOc+cNKcXwNwsoiRijAOSAAJyDBS47w5Dc07U0ta3VTQ8hmi2eKyQr8DEKLuh+/tyKDn317PWN68v+BFDdZaiHuQytBsDZU7YXpnIg==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by TYCPR01MB10776.jpnprd01.prod.outlook.com
 (2603:1096:400:294::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 08:09:27 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 08:09:27 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "stephen.s.brennan@oracle.com" <stephen.s.brennan@oracle.com>
Subject: Re: [PATCH v5][makedumpfile 2/9] Implement kernel kallsyms resolving
Thread-Topic: [PATCH v5][makedumpfile 2/9] Implement kernel kallsyms resolving
Thread-Index: AQHcy/lUHhlhRvTV6k+3Sd4f1iAJO7Y/pIMA
Date: Mon, 15 Jun 2026 08:09:27 +0000
Message-ID: <22a28d23-d941-4ef0-bff0-93c97c3e9956@nec.com>
References: <20260414102656.55200-1-ltao@redhat.com>
 <20260414102656.55200-3-ltao@redhat.com>
In-Reply-To: <20260414102656.55200-3-ltao@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|TYCPR01MB10776:EE_
x-ms-office365-filtering-correlation-id: 0efcef9d-0c2f-4f24-8760-08decab56baa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: SIXYCAuZSliFk48keN7yvnuSgi0zo5LgaKrthMlKG5PXUN4rEUbJEioaiprrXtP/nDp4VtAvVSPYRsl7af6+vr+bUiIDBXHgFv98brzuKUYfDUxCON+ipTpUrQTsM2IlSnzCrrvdX+t/yRvJ6v/dd5emyN720oU01FlpjxDw2XA8ZTzwx3hRT0i5zxlxYTVKm7fd8n3qlDTzQ5JlllAxvWLFyFhMo+p3zRVePCpwQnqqcB5ZcKp8zf9gnNAQYRl21q/JIGOMhh5k8WuV/qr4tjThSSh60QLLl0VH03ojouqRVLV/J9/6CobFZLVNw95zLHWepIQOfSEJ6pQn3LRVkLCCG7IDZdZreZoeVOuFPg07w7Dp8k24NF1LSeyWUAZVrukpew4GYCv6CdVaIS7mhSWWgSOMTfoqH7N8p2ahKLHCzTF9Gg9SaCDizld+m1BP01Ylg+oPPLyfSUh7XVZ0sBPWUoSQwnk59Ih4QRSbQdcp8/VW81o0q4fdxmAbdI2H+wLevHMcwfo+l1bGRnzm53J4aBH/5PtkHEXenlkaz5xOdy08gGLkjca66/080jq2nv/ZC5apdoyPlO3TbnRyv8QJN1GsOzXQb439XrSJY2gEFUQ4IQc2KnMLu4Ps9ZEI4DHlXiTbFq/tLmCQG0PPOlswlMDDCv4bAZ73+aZLOJre1tPfrBZiCaW1bjYmvBrruVe3KhDZJQX8JPxhWS/u9jdYNYnMY3LufKjywB1z0cF9ImhXfizi5heFAipwdw87
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWdtaTFBd2llWjVpQXRIdFNLL2lwWFNzK0NBTmpsMEVVN1hWcFJmcHNPaXg4?=
 =?utf-8?B?QVM2OXdaQkFSTkJxZnhhb25tdC9FTGlua0hlQ2VwU0Q1YmtTM1Z3VGgveHM2?=
 =?utf-8?B?ZGRXQ0dRUHg3Zncxd09USkxxUUt5cktUd3BiWG5mdWJxM1RJUG5veUNZQjFY?=
 =?utf-8?B?b2VMNkdub3RCR1pENkpzOFlwc1g1SE9NcTI3M3I3WURDODdWMHI0dkUwVnpm?=
 =?utf-8?B?RHhQSVdXUkx1YzFWNC9lQTU0d3pNdm9OVk1CZVkrNkQ4dWhFbXBTb0thVzNs?=
 =?utf-8?B?UlFDVVp2WldsWHo1TkVpd2xCMEdHYWlDWWxJZjdpem4rekZNMENYcGMxbHhY?=
 =?utf-8?B?ZzdaVzVmL1lBemVnUmZXWmJpZ2tobmNCbG1zS0E0cTdMOGM2K0NLdmJCWHIv?=
 =?utf-8?B?S0ZFMXk4SDdNb0RnVFR4a3c5WDNCUXNpbkFmWXJJRTQrYWhxZ1dyN1JMVFJu?=
 =?utf-8?B?bTE0R3J1TXdob3VwM25oV3BMU0xjRzVxNFhqTVQrOW5pbmNGUG5WWUdaM3RW?=
 =?utf-8?B?amVhN2FuYmZSMk9PUzl1bVJlZkFqajNIRUEwb2QvWnYxNk14QUtidC9tVnNN?=
 =?utf-8?B?aDdTMHZ5OEw0VTZjdFdZKzB1TEhPU3FTVE1pTGxZSXo5THo1TWZtaTR6L1hQ?=
 =?utf-8?B?WjdMOUtGM1A3RnhCVEV4dnVEMS8yQnJlUHJoSVM1bHJ2UFRHSzk5S0tGSTZz?=
 =?utf-8?B?amo4YjVvZ1lBTTVZeGdJNm4wQlAveThNSXZGUzRyOG5PVjBjbW50TGlJQWg3?=
 =?utf-8?B?UU50UjFkK2FKSVRDOC9QUDl2Ykttc2xjcUlnQjdaVFVBYzZUZXZ2L2IzL0JB?=
 =?utf-8?B?YUNQck1HMXp0cDN2enU3a3lPNU1KQ1YzYlRQREs0SnNzWDJVcE9MeDA1RmpU?=
 =?utf-8?B?cFZNa29IbmxZNTdlUklmekhweE95SGp0Wm1CZnBXTmE3eTZUY3FWNlk1SXdp?=
 =?utf-8?B?TW1GRDVod1pFc3FHekR3REVxSEJUMzV6Zk5wSUhOd2MxSWdtTzAvaDA4S2Ey?=
 =?utf-8?B?ZWl1c1BQQXZ0OXVYS0g0R0tIREFpRU5kL2loWk81YWc1MHdOeHBXL09WWmda?=
 =?utf-8?B?akJlUzFoMUQxdGk0Slk0NC9Fd0M3ZnRSWFFFQ0FpZ2UvQ3NocFFDWE1LaTd0?=
 =?utf-8?B?UytzQXZTNnlpQXVZaDF1Q1ZzdTRJanBKdXdKdVZ5R1d3OGZWdFliR2pPbk5h?=
 =?utf-8?B?UUVWUVl1VHRlYlZvTy9pRXRsdTFOZEZ2MFV6blp4b2hQcUptclNCM3M1TW5W?=
 =?utf-8?B?UzNTMlg5QlZFZnppM01uV0txd0RiRlV0Z0NWb0VodkZ2WjlOa1RmWktCb3lB?=
 =?utf-8?B?bUFXblBmYWx4eU55ejJteTZKOVhmQlE2c3g0R1VaNmJjNnJpeHk1dmRyOFJV?=
 =?utf-8?B?NGN6WjA2NFkvbXRocGN1MTBCMU5sdkl0SDVMMGZFa00wQ0tuNjdtdHRBVGFB?=
 =?utf-8?B?SGNKVW51MEEwUncxeThxWkZLL2g2cXpaVDg3Y2dXS3VzdTBLVkRVZUVBZjF3?=
 =?utf-8?B?VEYyZWlxeTR0VVdkWlhZSktyTE83OUtSYkZKL3ZGbkhtbVpnSnZTMTV4UDVW?=
 =?utf-8?B?V2IvcGxRVXJWRCtoeFVCelpEUzFMNm9uVno1anY1ZndUemp5NWM5SGt0elVh?=
 =?utf-8?B?TlkzZ1ZiUHlwQ0lNZkY5VERvdzFvcnJIY2xlR1kwTFdjVUxvT3pkMUM0NjNt?=
 =?utf-8?B?VDd2S0dqczZCL1lCZExnT2FLRFo0eWZVSmZBTXFqeDg0KzlDd2YxOUhzVG9J?=
 =?utf-8?B?dzlzVEFzSEYxQ1k0MGptcHZ5OTc0RHpXUUNyeDJ0RnVKc0FFVnNiNjcvTWxi?=
 =?utf-8?B?c2FTWERBcXptSmQwL0hGSEpSaW9EdC9mZ20rM3Fib3NoTkZGd0tDemlFdEto?=
 =?utf-8?B?ZTRCL05Dbk1tdUZaa3AwQUJDa1B1czVZMURPYTUzWUdFSWRacjJKVkpwSDh3?=
 =?utf-8?B?RGJvazFCMXk3N3AwKzBwRkdrSy9vdTM4ZEt3bWdHWXh5QVJMcGlzc2R3WVhB?=
 =?utf-8?B?SCt0Qmd5bXZydmV5Z3F0MWtXcGNzb2NzaThzTG80VjQvSm9OVkpFS1BlRXVY?=
 =?utf-8?B?MzRoYVdTZjRqWTlRVTBzTG56bDVQbGpqdVJVK0s3MEdGS1Yxci9TYndzZ2t5?=
 =?utf-8?B?VG82MFNaTEs5RVhIc3VpVUczOTk2dmo4S013NmdzaFJRbUlSaGNqWENzblBX?=
 =?utf-8?B?ZXpPMWs0TzBTTFJ3d0dKQVh2eTFzdnlLdUZPdlpiT3ZWUG93WVpPUFZQUlJZ?=
 =?utf-8?B?QTA5b0crbld5K2xHYjk3Ukd3M0FPNmlVdUlpazZNQW4va2gxR21ad0RxVzNr?=
 =?utf-8?B?UTRKQW5IL0VpTG56Vk0rTGxySTBIa1hURFBka25OYUUzVmcvd1JNZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82AA88C0864EAE44930BA903E578D206@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efcef9d-0c2f-4f24-8760-08decab56baa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 08:09:27.6984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BESI0zbiVXM50AyePGSB+mrhXUVKKnZjQE69AVh/ztVvfujD1Yh+muXpN0ifk8ukGPPbXHd5v6FH4lYPE3ZajA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10776
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_010939_460538_08C71494 
X-CRM114-Status: UNSURE (   7.99  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

SGkgVGFvLA0KDQp0aGFuayB5b3UgZm9yIHRoZSB1cGRhdGUsIGFsbW9zdCBmaW5pc2hlZC4NCnRo
ZXJlIGFyZSBhIGZldyBvZiBzbGlnaHQgY29tbWVudHMuDQoNCk9uIDIwMjYvMDQvMTQgMTk6MjYs
IFRhbyBMaXUgd3JvdGU6DQoNCj4gKyNkZWZpbmUgUkVHSVNURVJfU0VDVElPTihUKQkJCQkJCVwN
Cj4gK2Jvb2wgcmVnaXN0ZXJfIyNUIyNfc2VjdGlvbihjaGFyICpzdGFydCwgY2hhciAqc3RvcCkJ
CQlcDQo+ICt7CQkJCQkJCQkJXA0KPiArCXN0cnVjdCBzZWN0aW9uX3JhbmdlICpuZXdfc3I7CQkJ
CQlcDQo+ICsJc3RydWN0IFQjI19pbmZvICoqcDsJCQkJCQlcDQo+ICsJYm9vbCByZXQgPSBmYWxz
ZTsJCQkJCQlcDQo+ICsJCQkJCQkJCQlcDQo+ICsJaWYgKCFzdGFydCB8fCAhc3RvcCkgewkJCQkJ
CVwNCj4gKwkJZnByaW50ZihzdGRlcnIsICIlczogSW52YWxpZCBzZWN0aW9uIHN0YXJ0L3N0b3Bc
biIsCVwNCj4gKwkJCV9fZnVuY19fKTsJCQkJCVwNCj4gKwkJZ290byBvdXQ7CQkJCQkJXA0KPiAr
CX0JCQkJCQkJCVwNCj4gKwkJCQkJCQkJCVwNCj4gKwlmb3IgKHAgPSAoc3RydWN0IFQjI19pbmZv
ICoqKXN0YXJ0OwkJCQlcDQo+ICsJICAgICBwIDwgKHN0cnVjdCBUIyNfaW5mbyAqKilzdG9wOwkJ
CQlcDQo+ICsJICAgICBwKyspIHsJCQkJCQkJXA0KPiArCQlpZiAoIWFkZF8jI1QjI19tb2RuYW1l
KCgqcCktPm1vZG5hbWUpKQkJCVwNCj4gKwkJCWdvdG8gb3V0OwkJCQkJXA0KPiArCX0JCQkJCQkJ
CVwNCj4gKwkJCQkJCQkJCVwNCj4gKwluZXdfc3IgPSBtYWxsb2Moc2l6ZW9mKHN0cnVjdCBzZWN0
aW9uX3JhbmdlKSk7CQkJXA0KPiArCWlmICghbmV3X3NyKSB7CQkJCQkJCVwNCj4gKwkJZnByaW50
ZihzdGRlcnIsICIlczogTm90IGVub3VnaCBtZW1vcnkhXG4iLCBfX2Z1bmNfXyk7CVwNCg0KZnBy
aW50ZigpcyBzdGlsbCBleGlzdCBpbiB0aGlzIG1hY3JvLg0KDQpUaGFua3MsDQpLYXp1

