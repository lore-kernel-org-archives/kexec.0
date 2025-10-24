Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692EDCCD1AB
	for <kexec@archiver.kernel.org>; Fri, 24 Oct 2025 07:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fYiNrMIfauXVeNKK0Mah+Q4ilQTO4V8xSKI8WxKiwL0=; b=40bEJQuZPLAMSIiOs0G6UXVssZ
	dcdUZQswIlPtLEELmfTnaMS1TiHNZEAiiQuSanOZQtS3Pg+HwfoU7PvLvNBlSS4gIhZXcQTFBWNrM
	dfdjp2hvfl59TnpcFaGsMITxy9mYuzYhghNSKM6d7suc51/XRVcWgbJTJ6dwQYFcd4jUbiHni3Vjt
	rocqnThaGsVup3tuD0ZBaDf/vHJS0dXinPCA9qGI5lcgyDNfVCXEVlEqY6TuF86cGRE787P5cQOOp
	u8uTn7v7FqNwciQCDA0Voo0HGMcQjl2RDupu0uial+irTLWgms7UPLsrOs1WzN9WhHedoBhCk66gq
	X8+beecA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCC6A-00000008T8R-1T6A;
	Fri, 24 Oct 2025 07:20:30 +0000
Received: from mail-japanwestazon11011000.outbound.protection.outlook.com ([40.107.74.0] helo=OS0P286CU010.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCC67-00000008T7M-394m
	for kexec@lists.infradead.org;
	Fri, 24 Oct 2025 07:20:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz9ys5ObYUL1FExCElYxgo9sMu1DSsA+BPMamgJaTCoYi4yzk5ikOcSGCGjTnUjw3UUZzUyEnWgvr4Op1uDOlKYilpfsUP7/L/L1YEHiJIU4IyvBcqw0RZRUI7pcmdYcHk0BxCnaNU4NyomoIXoLiaoUqd7Q0xToMcj5Gh2jbEm6g+fmTHkj9SIN4bDP6rqXhmyZqol2zt9Q43FM6uc3ZsHHqwb0OpdgLuR4T9gr2OIGWvLj6nIoWewyCUdWWq6T6jLYbYSDKPPzYoAPKD72abDL4Px0S8tlxDG2uDd0Q3n9m1Mucd9jAMKRFVc8m57Oy2LSCgDmuTbJFvh1aRKZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYiNrMIfauXVeNKK0Mah+Q4ilQTO4V8xSKI8WxKiwL0=;
 b=vnjYETBvBaEekUN97y+MYkHISxLUyf922ydVUMnhFOGbT2O5t81WshbiQ8UZU+wGG+DC5N2zacKL0FL3+RFw7jiwE9ajatxcoVwzIFY7YFJbXJMdDzSJWLQ52oef12Bpw4B58zJt/heWTuOFAqA5QugjZvy7Lx5+1yRHQ8oA4XIF/JER8VoTKxMTa1im6/Ge5GIM25nZ0ELqcM1/O4bDPyYdkgU3Fi1MdfZWRNiOrv0l95ZUNo/95t++J75fZtPhziZ871otz36pJ2BQwXw5K0as/6m/x0Hu6WK9r/aZ87LBeaaM6fD5WU/nm51xJUlsm6NP5SGolAmQ54Ru1r4hXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYiNrMIfauXVeNKK0Mah+Q4ilQTO4V8xSKI8WxKiwL0=;
 b=EHkK0P7+g2v9HBICNPnpAAtYJ9toZsDI8jNLnFy9yn4NMM5ycQJ/4YddGbqOGY0qpwuwgubBO5RdcpaI/hoQFu6ApgEmOg5zvU9CCSXfNNbjukLR45gx/lbRc9TNJAp3Iv9XAw6x2+zdOm8c2To8bTR+6eqKn7gG4StET4nEbruIigj1ntQxlNkiNBCn8gf2Z1bpNcMWdigcf31c6Y3Ebl1tYgXiYvxxgE07R4r9FNf9SqApS5IOndy1vA6CO8YEQT0CWH5W5abu6XjEDQbf1TvrgLCECHSf80Rht8S4dvK7jKDBuUL8m1Y9yYXeAQIo/v3mjQjBSnL1Qjk1ALZCGg==
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 (2603:1096:400:40d::13) by OS3PR01MB9591.jpnprd01.prod.outlook.com
 (2603:1096:604:1c8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:20:22 +0000
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec]) by TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:20:22 +0000
From: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
To: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>, Tao Liu <ltao@redhat.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v2][makedumpfile 04/14] dwarf_info: Fix a infinite
 recursion bug for rust symbols
Thread-Topic: [PATCH v2][makedumpfile 04/14] dwarf_info: Fix a infinite
 recursion bug for rust symbols
Thread-Index: AQHcQhBX989qt1l4MkmGca9kXtbDCrTNuLKAgAMwfgA=
Date: Fri, 24 Oct 2025 07:20:22 +0000
Message-ID: <7ba9471f-6119-4353-8218-6486bbc85103@nec.com>
References: <20251020222410.8235-1-ltao@redhat.com>
 <20251020222410.8235-5-ltao@redhat.com>
 <c05710da-4807-4a98-9af7-f54ce4beb459@nec.com>
In-Reply-To: <c05710da-4807-4a98-9af7-f54ce4beb459@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11475:EE_|OS3PR01MB9591:EE_
x-ms-office365-filtering-correlation-id: bd6570a6-827c-4296-cb8f-08de12cdcb8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QlZpTXRnYUlLWnRPLzFRRWVNQ3VpN05vZU8wN1NpODMyM0M0bHFWSS81djlv?=
 =?utf-8?B?Nk90UkRndldzTzZ4WTBjbDVGdGpNeGNPWEtuK3BSOE5LdU54ZnlEM25hRzZT?=
 =?utf-8?B?Q3U5WHo2QjRNZm9Gc3lHM0dsUzdGQjVpbFRmd1BRQ0I5RzE2SkJ1YmliMkp0?=
 =?utf-8?B?QndJeHJ4K1RUSkJWeVlqcVlqbFdTaC9BcG16bDFSdzZKeVR4aWFKYTI0ekhF?=
 =?utf-8?B?dUFCd010UlVHamVjakFldEoxOUI4STNnQjduVm5LR3hBSkI3QzdSalh5UUpT?=
 =?utf-8?B?eFgyelFOby9uSHRvRFpvNEMxZnhuOGI0dGp1dGNwbnMwMWtrM1JGbGVpUU90?=
 =?utf-8?B?R09adW5VczJTNldoTnc3MTc3K1NwY2Q2OTNrUjExVnRkVzhyZVlPeTVTV2VW?=
 =?utf-8?B?anRJOHRJczhhTW9RS2ZCM0g1VkZKbHZKdVFzTjNVaVV5U2dzSGZOVnR5NUJs?=
 =?utf-8?B?Q3UzbFU3ZlI3Qll4dUpRNmR1QjYrSjZCN2hIRWxJcGhuaE9xeHdWc2pvd1hM?=
 =?utf-8?B?QWRTT0d0cE4wZWhHZGx1cDNxUWxnZEZ2TWNKNVhPYkpMOEhlQXNLMzZKczNi?=
 =?utf-8?B?NjVrajhYTnk0bkFUWnNyWThPS3dyRzhDTzVWeWUxUnRETGlkUTQrbTMxd2p4?=
 =?utf-8?B?eTJkZ3Q5RGRHdHNhZjRCeFh5a0VveUN3UmhHaWdWcUtOd1FBSnl6TjVuMEw4?=
 =?utf-8?B?UExKbVlpaVU5QlQzbEM3Z2VVR0hHbCtGUnBJT01ZaXNjTXRkYVlZMm83eTRy?=
 =?utf-8?B?UVVBTE5CNlpIei81TTRVSnNkU2cyZDR6ejQ0K3hTcHIrbTYrR2ROT016MmFP?=
 =?utf-8?B?SDd0bnNBY216MFF4Z0FCZHV1WS8yd1Ftdy9xVE9Ud2NtU3Y4UFh5dG80NmNn?=
 =?utf-8?B?R200K0YyOUhsZ0hyVHBrdGhuckIyLzIzaVpHUnJheHZqN3FBTlU3dnFkTDhv?=
 =?utf-8?B?N1BzKzFtVW55YllyR1gwMUIrS1YvWDRxWk1GSFBnTE82WFFuTCtpL0ZlNUtL?=
 =?utf-8?B?Wkw1TnQ0blVZTU5VMlJnTUszUmhNbDlWdDF5TWJNN0h0NDBMTXF0dzl3QlIw?=
 =?utf-8?B?bWVEVUllRk5WL1J6aE9wbENNazB5NmJ5ODdsdlI5SldwVVlZejBkams1Ym5j?=
 =?utf-8?B?TTFFVUFjaG51MVpxaHJwbWQwYWhqUXpyUGtFOXcwY2ZUZit1ZXdoeSt6MW1T?=
 =?utf-8?B?anZJTmVXM1pIQlQ0TXV2cVhyMHh3bndQVCttVkkrRXFSUU9neDA1WGk0dndh?=
 =?utf-8?B?b0paYmljNHZUamNkdHZVbTY0TlRaeHlXRnU1QlM5c0tPTE5VbFdxVktZeDF6?=
 =?utf-8?B?SGdFVUx3blRUMWJJL1hHTnBSeStGRlRBOG5zM2NNWDZRb1Q2NnRHTTRtZ2JE?=
 =?utf-8?B?MjlxajhCWVcxZDNmeHBUYk9DQ0NVV0h2SjUvUnZjMnFHZm9vOENrU2RnbFJj?=
 =?utf-8?B?Wk43WUp3VExRK2puWXZpNmNlVWVIcDVmSGRIWWtSbXVNblRsbnh0MlBuWkZP?=
 =?utf-8?B?dEtsVGdOVE5QZUczK0ZPbFdXY1RUUUNyWVVVZ1B1WnhQVDFSK0NRSHptRjVx?=
 =?utf-8?B?b3JaOFU0dXJ2dEwzN0VXQlFGMVczS004NnllcEdzblp2ZUlCckZPWVFWRkpQ?=
 =?utf-8?B?ZWpnSjJNM2l2WGN0NDBOa0VBYjI2K3BtSkxueXBNSXVLM1hWRWV1VFFOaTBK?=
 =?utf-8?B?YVE3aE45ZStHMGRHWUxiUThoelM5cEVCaHhiWjA3SVVIZlExb2UrYXVKMHdw?=
 =?utf-8?B?OXRpVWRYbUJJOEZoMTFBUjFrOElRSGlvbkpPRmNZWVdocXZtV3dRamo3cmdo?=
 =?utf-8?B?ODZ2QVpVK3hvVk9pbXViampDZ3AxRUs0TllJNGZ3RGRxL3RiZzQ2aWVZL1Q3?=
 =?utf-8?B?dWs4U1dvSDBMK29OTzF5ZDlzbENEQTdCbFMrTHJzMGcrV3c0NUljRTFYc2tO?=
 =?utf-8?B?Q3BKb2hkUjVEMmUzYW15eUNCOUM3MjExZzhvTVVNZjJuY3JuaCtGQXREejhC?=
 =?utf-8?B?bGNLdTMvTjlGTGpoVWVIRjA1c1d0Qk9HNVBEak9CWlMwWDdGdVlUOXl3WStF?=
 =?utf-8?Q?UUeE2T?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11475.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGhZQjlPZUNRaFk4SDArWlVYd0VLNDcrZERrL1JGSmZ5NnRYQXpzSFZMREhV?=
 =?utf-8?B?NVB3ZXNvSjlidXZYL0ZEdmdxd0VuR1RPK1pGdEFMVUpzbUwvdTQ3K2xlaC9n?=
 =?utf-8?B?L0tZSHErQVg4T1RQRjMzK291N0JPa2ozK3VDS2V5WGI1QW1MZ014ZjQvRCtq?=
 =?utf-8?B?ZEUrS0tWZVVSeGwydXRmQml3S3Y3QVZjRGd2K2ZjUTlQT3ZudmxFdGh4Z1Jp?=
 =?utf-8?B?SFVhZE5GelMwUzdJd3pTMloyaG83TzREemhveEhoK2RyWkk0RENJdkxJWmdl?=
 =?utf-8?B?RzhjNWZaWnFCSnlPN205aGJBbnZYb1pLL0h4eTdIWVRVV3NXb3EvYTJ2cFZu?=
 =?utf-8?B?Wmg2QlRJVHhlMlVONDA0ZENObGdFTXowd1BsYWphbVpTTDlXTnYxcHZqbzVN?=
 =?utf-8?B?YldadU1TaS9KbGJraC9nRXJWYWlSaS95c1V6TzFsY2Fwd3RXUXF0c0l3NE50?=
 =?utf-8?B?SmNEdkVQOERJYUR1cWhZRmw1aTZQMjd4cXNyRUQzY05jMkNORnhFbkZNRE1Z?=
 =?utf-8?B?RHdkbFI5R1I5clQrc3krM1RIRlg2ZUNJVkZQZ1c0MmhrR0JBcWZtZGRwZmRS?=
 =?utf-8?B?N0RCRXY5ZUEyaStFUDlua3dWVTVZRWM3NWJSRnYycjBLWmhWbTlic3NJeUFq?=
 =?utf-8?B?THhIWTE2a0RVTDZUdGpMaTFPVVhGVUpZSTdSUXcyaE15bU5jbWF3ckRxWDc1?=
 =?utf-8?B?c0c4cTErRmhkZHJKKzg5OXhoa0VzYnYyeENzZHJ1cDBtbDF1b1Q4RHFTK1ht?=
 =?utf-8?B?Z29KZUlrNHFBQ3AybmVJb2E2NUl3MEpKR3lIcjUrTzB4amtoVkR5RENoT084?=
 =?utf-8?B?RmpkeWJzcTUzenpTNHltWmhYakUzVTlwU083MGtPYVgxUWRCdC9xUzlOM3dW?=
 =?utf-8?B?bmdlMXVBajJGTmJmT2VpS2FUTHVWdW1ta2hyNm9lVnFKVGJrT210VVBvS0Fv?=
 =?utf-8?B?N3N2UEFQZVFOZTZDVUFnN3VuNk9jdyttdEUyUU1ETFZ3WTdpRkFDYmF6M3Rr?=
 =?utf-8?B?MUd4eWQ2b0dhc0pJeTBlSWNxTURUNFFwU0tqZWRsNU03QzlmZ1NIeHRtcHFZ?=
 =?utf-8?B?N0N4SkxUazhKRy83dGQrNGZCTFgxTTBsdzNRT0NIc0FBemdEU3R2alltejQ0?=
 =?utf-8?B?TktmZm5aSk9DdjlKbXVqWGc5dVVHejIwVUFCS1Mzclc1MTF6ZTJhOUVzOFow?=
 =?utf-8?B?UzhQS2tpdWF6V1VEdGU4YlpsQUthTVRxL3E2Q0tFZU1OVVVKbXVueUo1ZnFl?=
 =?utf-8?B?TmZKYXJHN0JMOFdHclBGS1JtVksrcFpKTlhSMmxTRzl5dndtamJZNW1DeE1k?=
 =?utf-8?B?UURiaDdkdGJhb1lmV1ZWTjVjRWVCZk1LSVQxSy81N0hJa0YwUHVKMXBPNjN2?=
 =?utf-8?B?SEJjUjh1RXRMWnpNQm03WTNCcmFSNjhJazNpOXc5bHU4UnJXMUdzSHVSUGxR?=
 =?utf-8?B?QjRWNDNZQnU5MFdOcVUxRmRhODgrYXBLSHhiNGpPckMxRksvZ1h2UThyMEJN?=
 =?utf-8?B?UnVqSE0xVzBBRElVNDh2OTJQR3Vac3kvSWYvMHZhMmoreFg1cGlxNHdOREkz?=
 =?utf-8?B?bStIMis3MFRrdm9mZ0ZxVyt2TWNTUFVLbEMzdm5Xck14UGJHMlVZSk5zV3Vx?=
 =?utf-8?B?UXNZRk4za3o5ekQzWjBrSUtxRE5UOEozekdHS05IYU9hdERITnNtOWg2eUJy?=
 =?utf-8?B?K204Z2FwTy9ucGNwQ1dYbWROOTNzUmJCL2RWUzN3S2ZGQWRsV0ZEOFh1TFV5?=
 =?utf-8?B?M04xSk1ON3NKc0NXdWlFQVRyaS96VzRETzAxdEJGRGdvV1pqVXpWeG5sdEpT?=
 =?utf-8?B?Tmw1Y0JUazJXMkhSUlAydGtNN3pVMnIwTXM0ekV1V29NM0R3cXA5WXVyMi9M?=
 =?utf-8?B?TGQ3UnpVKzVmbjg5QXJWcVJrQzE1SmpQM251OEl1ajBoMGU3NkRaOUx2L3py?=
 =?utf-8?B?WjZUSUwxZnVETlo5ajJuT21xQWk3MS90WUwvRUR0YWVCSElLSUJHYk9jTGZy?=
 =?utf-8?B?STlHVkQyZkFSYm85SXowQVFvUTNzYmhmU3RwaFNmRkxFdlo5dk9EaHhqMk5P?=
 =?utf-8?B?S0p5a1NiQk5abC9zQmlabXlJbHNScjZzMDZKV1phdEdkUGIzS3dPY1RwKzJ1?=
 =?utf-8?B?dHlWTEFHem5nTUR3SHlhNGNicklhVVNnaHIzMG9wRDg2ekswb25IZzBuVXpS?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <101B434121FB4043818D98B007F461C1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11475.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6570a6-827c-4296-cb8f-08de12cdcb8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 07:20:22.5202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eP9liymIFXVMKlGkdLY3b9Q11B5Q9xX1Tzw1BQtYst2rn1MSEhXJ4nNFfzqHGJWOR8VZXogGjjGkHP/yunCGKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9591
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251024_002027_809347_FE7A2C43 
X-CRM114-Status: GOOD (  21.60  )
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

TGl1DQoNClRoYW5rcyB5b3VyIG5ldyBwYXRjaC4NCkkgdGhpbmsgdGhlIHBhdGNoZSBpcyBiZXR0
ZXIgdGhhbiBiZWZvcmUuIFNvIEkgYWNrIHRoaXMgcGF0Y2guDQoNCkFzIHlvdSBwb2ludGVkIG91
dCwgaWYgZXhpc3RzIFJ1c3QgbW9kdWxlcyB0aGVuIHByb2Nlc3NpbmcgZm9yDQpkd2FyZiBvY2N1
ciBpbmZpbml0ZSBsb29wLiBUaGlzIHdpbGwgYWRkIHRoZSBmdW5jdGlvbiB0byB0aGUNCnN0YWNr
IGFuZCBjYXVzZSBhbiBlcnJvci4gSSBhbHNvIGhhdmUgcmVzYXJjaCB0aGlzIGJ1ZywgYnV0DQpj
YW5ub3QgZmluZCB0aGUgcm9vdCBjYXVzZS4NCg0KVGhlcmVmb3JlLCBJIHRoaW5rIGl0IHdvdWxk
IGJlIGJldHRlciBub3QgdG8gc3VwcG9ydCBSdXN0IG5vdy4NCkhvd2V2ZXIsIHRoZSBjYXVzZSBz
aG91bGQgZXZlbnR1YWxseSBiZSByZXZlYWxlZC4NCg0KQWNrZWQtYnk6IFlBTUFaQUtJIE1hc2Ft
aXRzdSA8eWFtYXpha2ktbXNtdEBuZWMuY29tPg0KDQpUaGFua3MsDQpNYXNhDQoNCk9uIDIwMjUv
MTAvMjIgMTU6MzgsIEhBR0lPIEtBWlVISVRPKOiQqeWwviDkuIDku4EpIHdyb3RlOg0KPiBPbiAy
MDI1LzEwLzIxIDc6MjQsIFRhbyBMaXUgd3JvdGU6DQo+PiBUaGVyZSBpcyBhbiBpbmZpbml0ZSBy
ZWN1cnNpb24gYnVnIG5vdGljZWQgaW4gcnVzdCBzeW1ib2xzLiBUaGUgcm9vdCBjYXVzZSBpcw0K
Pj4gdW5jbGVhciB0byBtZS4gVGhpcyBwYXRjaCB3aWxsIGF2b2lkIHRoZSBidWcgYnkgc2tpcCB0
aGUgcnVzdA0KPj4gQ29tcGlsZVVuaXRzLCBzaW5jZSBjdXJyZW50bHkgd2UgZG9uJ3QgbmVlZCB0
byBkZWFsIHdpdGggcnVzdCBzeW1ib2xzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFRhbyBMaXUg
PGx0YW9AcmVkaGF0LmNvbT4NCj4+IFN1Z2dlc3RlZC1ieTogS2F6dWhpdG8gSGFnaW8gPGstaGFn
aW8tYWJAbmVjLmNvbT4NCj4gRm9yIGFwcGx5aW5nIHRoaXMgMDQvMTQgcGF0Y2ggc2VwYXJhdGVs
eSBiZWZvcmUgdGhlIDEuNy44IHJlbGVhc2UsIHdpdGgNCj4gYWRkaW5nIHRoZSBmb2xsb3dpbmcg
bm90ZSB0byB0aGUgbWFuIHBhZ2U6DQo+DQo+IC0tLSBhL21ha2VkdW1wZmlsZS44LmluDQo+ICsr
KyBiL21ha2VkdW1wZmlsZS44LmluDQo+IEBAIC04MCw2ICs4MCw3IEBAIG5lc3RlZCBsb29wcyB0
byB0cmF2ZXJzZSBhbmQgZXJhc2Uga2VybmVsIGRhdGEuIC0tZXBwaWMgcmVxdWlyZXMNCj4gICAg
Y2FuIGJlIGJ1aWx0IGZyb20gbWFrZWR1bXBmaWxlIHNvdXJjZS4gUmVmZXIgdG8NCj4gICAgXGZC
aHR0cDovL2NvZGUuZ29vZ2xlLmNvbS9wL2VwcGljL1xmUiB0byBidWlsZCBlcHBpYyBsaWJyYXJ5
IFxmQmxpYmVwcGljLmFcZlINCj4gICAgYW5kIGZvciBtb3JlIGluZm9ybWF0aW9uIG9uIHdyaXRp
bmcgZXBwaWMgbWFjcm9zLg0KPiArTk9URTogY3VycmVudGx5IFJ1c3QgaXMgbm90IHN1cHBvcnRl
ZCBpbiB0aGlzIGZ1bmN0aW9uLg0KPiAgICAuUFANCj4gICAgVG8gYW5hbHl6ZSB0aGUgZmlyc3Qg
a2VybmVsJ3MgbWVtb3J5IHVzYWdlLCBtYWtlZHVtcGZpbGUgY2FuIHJlZmVyIHRvDQo+ICAgIFxm
SVZNQ09SRUlORk9cZlIgaW5zdGVhZCBvZiBcZklWTUxJTlVYXGZSLiBcZklWTUNPUkVJTkZPXGZS
IGNvbnRhaW5zIHRoZSBmaXJzdA0KPg0KPg0KPiBBY2tlZC1ieTogS2F6dWhpdG8gSGFnaW8gPGst
aGFnaW8tYWJAbmVjLmNvbT4NCj4NCj4gVGhhbmtzLA0KPiBLYXp1DQo+DQo+PiAtLS0NCj4+ICAg
IGR3YXJmX2luZm8uYyB8IDcgKysrKysrKw0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kd2FyZl9pbmZvLmMgYi9kd2FyZl9pbmZvLmMN
Cj4+IGluZGV4IGEzYTJmZDYuLjE0Y2Y3Y2EgMTAwNjQ0DQo+PiAtLS0gYS9kd2FyZl9pbmZvLmMN
Cj4+ICsrKyBiL2R3YXJmX2luZm8uYw0KPj4gQEAgLTEwMDcsNiArMTAwNywxMyBAQCBnZXRfZGVi
dWdfaW5mbyh2b2lkKQ0KPj4gICAgCQkJRVJSTVNHKCJDYW4ndCBnZXQgQ1UgZGllLlxuIik7DQo+
PiAgICAJCQlnb3RvIG91dDsNCj4+ICAgIAkJfQ0KPj4gKw0KPj4gKwkJLyogTk9URTogY3VycmVu
dGx5IFJ1c3QgaXMgbm90IHN1cHBvcnRlZC4gKi8NCj4+ICsJCWlmIChkd2FyZl9zcmNsYW5nKCZj
dV9kaWUpID09IERXX0xBTkdfUnVzdCkgew0KPj4gKwkJCW9mZiA9IG5leHRfb2ZmOw0KPj4gKwkJ
CWNvbnRpbnVlOw0KPj4gKwkJfQ0KPj4gKw0KPj4gICAgCQlzZWFyY2hfZGllX3RyZWUoJmN1X2Rp
ZSwgJmZvdW5kKTsNCj4+ICAgIAkJaWYgKGZvdW5kKQ0KPj4gICAgCQkJYnJlYWs7

