Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0029C61DC4
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 00:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qI+74n2v1wEU4ZDHj5TmpnwHOr4EUMbo64pRci80a10=; b=HK5+1SRCiF2cAASr9hAcrISUVo
	SOdfUNFZ70zvzx13rXfPrIxlVUWRXAQR0mUIz6CsgYgPozd+XgdtFgmJII63pDjizy+LPotcafS6D
	cEuWLhmQTs/b0DekcscGRDTi3bWvj0w59FiUS1qJ2+uAGIuJ2cJBWYxr2difCicGbups+EmCYwWMB
	y9b8XNVyKUF5QcgP2nPgWZRytngFRsiHPmOkQ5THbfSKr6hvQXVX2lBakbPwEuKJ2/PE4Yhxe1i9a
	Hi4pQMyJqSAWdPA6beIYX6s2T/WL3tIy9hgFfpj5NXVx0GLN1+gKOL3I/o+8iGmJW1f829pVAZykv
	CEu6jOSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzkt3-00000004yAE-0ijA;
	Fri, 28 Aug 2026 00:56:05 +0000
Received: from mail-japanwestazlp170100003.outbound.protection.outlook.com ([2a01:111:f403:c407::3] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzkst-00000004y7x-3xfO
	for kexec@lists.infradead.org;
	Fri, 28 Aug 2026 00:56:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvBMbeJA0TSrwWD2yJ/kfrrW6DZdCvOHUYQXCvMtXJUXf3WZXWQ0EAk4vD6CLtbNtvOYCyQHuT3kfqa1LLh71dylMaT326jSwNG5VWiH86GwarxDzjoD7/YirPYBSgoU5Xe30Y1jKPQqAG+NlcWBwHyk2t0rAOlUcFLFF9HWX9h0yQdvM0F3Jo4paSVgt4mNrRJrGvD435UZ0+MkxyIFChuDr/xXXUb6bx1BKf72HOh5ZzTH7FcuIsnKebE5hB2EcWJDNEj79s7ftR6sWCRVBHTsQxsW+AShmO1JgZoYa9CYYQt8SHZlAB8vxvIch5Pc3iaPNIXuNwYDEkrXaf6/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qI+74n2v1wEU4ZDHj5TmpnwHOr4EUMbo64pRci80a10=;
 b=ZuYQrBnobTU4qWuaCEqEpw4nik16dSVTJUZPUkX8L2kx6Zc9eG8jOIOXP8sLDW82JMcxovN1nqSjvN/ia3eaSmUXj/VRQjEmLz/S14Vb+arZUUwJIKwkgN2eXYFEo1XUi11QsXKGEGoI/2yxbZ+LlTwomiXjcHdWPczjACY31H6npgEb66PjsqqWyNs94Q6W81INFhYJ6+CEZ/VMR4KpJUJtGFbnavGyc9Adb6lzCg9XXVaC94/Ohr3t1zPr7h4sYu7kJ/8+Gx/Jf4mdscLx8uUrumpmbQ91piFxb0tq0a/q63zQwWUw9tbBWLZ3rT65AsP5/bn8PRSws1u/Bhb/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qI+74n2v1wEU4ZDHj5TmpnwHOr4EUMbo64pRci80a10=;
 b=RksrNqOYytTPyWvIHO3rud7ofYe0J1yEG59nw3lc/NhE+xd77k+f9dM035a9vkBMIf37f+pfz9TpK9Z5Xxri/mPiImGsAZAmIcjucNmDTF7G/WRz4mpVtGujP8R9/oogCyvkAPSpzajiBHNLVRy+PUTmv3T3kC3lq7yy78siKKAUI8YH1Rl94AxsRzEr1h4+DvuGXtM9nzdoVQD2bfJHw863zG7KXBMNK1L16yutIU2ycZGevCGqI6CjBD3I2WquoqQDzVyhabU0dIHHzbF3LZbby8uyQaP9J7lyE8hFfco6c8bllgsHQKQ44iYQ+iB+tGzY1J63aOQuCbRg3vJLUg==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by OS7PR01MB13877.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 00:55:38 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 00:55:37 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>, Tao Liu <ltao@redhat.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH makedumpfile v2 0/9] Improvements to makedumpfile
 extensions, plus userspace stack tracing extension
Thread-Topic: [PATCH makedumpfile v2 0/9] Improvements to makedumpfile
 extensions, plus userspace stack tracing extension
Thread-Index: AQHdMPwOJz6H6zfpHUyrhOsRv/4RI7at2LWAgATU9gA=
Date: Fri, 28 Aug 2026 00:55:37 +0000
Message-ID: <da1ca401-2707-4d28-b26f-0efd5c88fb29@nec.com>
References: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
 <CAO7dBbXZ5VP=ProMR+mxJzh5RLJk8-eZE2rpo6rspVuLr4yqVw@mail.gmail.com>
In-Reply-To: <CAO7dBbXZ5VP=ProMR+mxJzh5RLJk8-eZE2rpo6rspVuLr4yqVw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|OS7PR01MB13877:EE_
x-ms-office365-filtering-correlation-id: df224915-e159-4a00-d5f2-08df049f1336
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: QzlVBw46CPbDrALXbj6sEyxOaSFxJGQUE0TXqeLoJUFLLexiNJWhb6zlmvjHgvE0WCDpIU3DIsJf7prb9fuILIKBkOToQbKsNrjydd1+VFenre6ZaZIt2itfTdlTRv6t9VUg4ndfVYVGTNPQx05766bDjNiZtaPDVrbfRJPqmfeiOc71ZiDk6T2aNVOriqFsPbZPij00m9Axx1tAmv0uUaM1OnSkiEyTVKS8nefvQ3YoDaD5RENWUH9B2kjZCKUJTo3Sr8qntzG2CEK6BWB7h7BZcgv7EJzf3yoG6arjYl+N8iScEeJAqm4KZCdZAJLC71OQGw0fqes/mEXgUBeRtYoLBq+wZY+4yjswqqdHUJR4XvmoV0k4nCYCfRqb0kcIf9vhNdwTtAutgJROUVMiMPoIAUBZei4NlGgW0c4/bnrrOeOTw9/NSK7Os5H50aVhIf6d+8Eq3COqQY2x9j07HF5RYlVqawglVIFMAmfXb4lqKrbphes5D1UaYoC9/6BrNdJh5Opc9+T7rsY99YgSAJFuTkq1pClfiUkE/uVyln0cdQyHlXFQkSGk70hNMVPpN3U9+Tk71SRUNuEXxyOp4syFmGLWwiFg26Y/4HKxn+9cDZHfIJnPCR8bJCCd6nMHYgVEGJNmfhFMJH+/wMDI76yzyrexKnp8dCQw2tXqvkvv9neaLyXKEq+NUgy/ZsQDW5vsgLm4DICTyjSb0z9baQfC0yWX0rtrc5hyZ152Zno=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnhkNHVaVkRDdFJXL1JacnJIZTRGR2tiUEFZdkxtamQ3Q1ZkcWVQUmg0K3FE?=
 =?utf-8?B?TUkvZHdTeUk5c054UWNwTWRicVNGQTZrREpHd2pIZ09JcUZmblJyYVVVM1E0?=
 =?utf-8?B?bHNuSGhjVGpFWTRuaytqVHFRcWgzVWRkLzR5WEdXeVJ0Kzl0VS93cW40RzFo?=
 =?utf-8?B?bExybmxpb3RSczJkak9hbGhzbE1zd0tjQ1RYekVyOXZEQlgyRloxNmtGMS9B?=
 =?utf-8?B?ZlUxL3N4dlpsWm1QRUI4dlVjUVJYU1R1Z1JWcTdhUGlPSGlIQ1RGd0dzQUor?=
 =?utf-8?B?eGRJNlRqQ0x2eE9KdmUzL0lVeUZCYnJmUjdqNWx5dkNQdmdHdXdjMjhXV0Zq?=
 =?utf-8?B?ZXVVTVhuS1J2djVtVkpuVTgwOGcwOGFUSFNSOEh1ODh2VGJFZXhEVlNBMk0y?=
 =?utf-8?B?bmNDTEMvZ2pTOW9QMUhRbEZ4TEJwN2hlZW41bnVISG9WSnZreS80TnkrNUky?=
 =?utf-8?B?QTJTeTQyNUwwQ2hsYWpvcmNBVS96aFJXamxoUVRBaENWb1A2S2RzLzNCMDZV?=
 =?utf-8?B?aHJKWVZuOThubW8wYjZiNHl1SFppanMxdzNyK2pNY2UzYmRhc2cya0xnRjVF?=
 =?utf-8?B?dEd3bFRtWXpsbTZvU2JUajdlTzZJSGZkQ1BsL3ZDMFU5c2l4aXYwVkVKSGcz?=
 =?utf-8?B?d3YzdGVEekhMcmY0Y0V4T3Q1eXFuZk9SbjZKQ3dMSFIveVhhb2xUbGtsTXNk?=
 =?utf-8?B?Wm93b1N4TDZXdmxLcVhuMmRJcCtXd01qbDZhRzROZFJjVTVQWTJVWktYR1pP?=
 =?utf-8?B?b09KTjFZMDNQaHRlS2hXdi84VFhzMThRTFFLZFZzUG1SRXg3STQ2UHgxZEtI?=
 =?utf-8?B?QTlBMFJkbDVaVW5wN0wrdFNub1kwOTdGSTVQL25TalBFWmZCLytVSHFyNVha?=
 =?utf-8?B?RnBCV2NxT1hsQ3cyc0FQQmczeWMwK0VSQVlmcmNLZEFvbXVqZkdsam1wd3lP?=
 =?utf-8?B?bE8xd3U1eHlIWm9oRmxOTmNWeG90SXozUDNVUXQ1Y0VaSFc4c2xlYWZRa1p1?=
 =?utf-8?B?ZWNoWk9VdEY0S1M2TnI2Sjg1VytEb0xXWDdUditjTmhPRnFSRlgwVkZ3NnNF?=
 =?utf-8?B?TmhxRGEyRFNNZjYrbkJVc2t6cjVlVHdLZVZsT1FiQXFxRDIxOVNVMElaN2xw?=
 =?utf-8?B?SFZ4R0dxS0gzUjlKcFRlczRabEF6UVdFNFQ4a01TMmE5dUZMK1dkWVk2ZW9L?=
 =?utf-8?B?d1VEY3d6c2xBbFBJQXlJYXhzOThEY0hseHlldnNuS2R2OTNxV2xlendyZDYv?=
 =?utf-8?B?YkRmbmRvNDhHYUphUTJYc3Zhekx5MlFoaFAwcEJGMGJwdFBOSFNQK3RoWlF0?=
 =?utf-8?B?N08rYVd3OSsrZkl3Q0JuUVp2U05HczY5eEZ3ckJBaE5BbXdCRFFST0xyNUJR?=
 =?utf-8?B?aWFHZUFwTGFSZTd1eWdqcWg5Y0pnVk1mcjkzdGIweUFaWHdOSVhvYjNNVnJt?=
 =?utf-8?B?dW40QkEzRVFPeURRWDcvWW9aOFNLK2ZTYk5zcnExcXZrdEpkTXhIM1dDNGtt?=
 =?utf-8?B?cXQ2bXNJQ2VKUXlzUnpQK3F4djhKNzlCbGNWZDh5WDZyazNDR3dLODRXcnBB?=
 =?utf-8?B?SjhUdFczOERVNS82am9SUG4rNUpVTzFUeHZTVS91RFcycjNmcVNOeGVoZEZ5?=
 =?utf-8?B?TS9Ub3VXYXJYb2RyY0FKS1N2UHN3b2hCSmx0NjF5UDlYb3JZbnN5TDV1RmZV?=
 =?utf-8?B?V3BhUnF2a3NhU1lwL1JuSTdBbTN5eGt6SG1QWHk0R1NQa2ViMkVhSDVnWXFG?=
 =?utf-8?B?ZkVMTitGQk1UeHZVNUdNNGVpV2VMY2tmbStHWVNJam1BbTNjQ2Z3eDVUbUJh?=
 =?utf-8?B?K054RGpVTVpiMUhVUG0vTVZYTEdzVHFubXkwRWFYclJVU2ZrekdsRkt6SERD?=
 =?utf-8?B?b0tPLzIraVpvbHcxZkw3aG5XcXFEWENkRzU5STkxell0LzBIZmNBV1NMWWRB?=
 =?utf-8?B?K0oyNkxiTGgxZ2l6QkZPS2FPOTkxRENPcEoxczFEZXhoZHJXWmtkOS9KOUZB?=
 =?utf-8?B?ZHVBb2k4T3dOd3BBQ1Rzd1NZU1llSEdQajdwcktKNGJud2xEUDUvQUViTXNP?=
 =?utf-8?B?ZXk1SHhXUHFjT2NJa0JkamVSTE1uT2lOWmJoMXF0R000SXl3ejdLRS9TdUIx?=
 =?utf-8?B?ZDZsbTA2S0ZXRkg1dEUxNnE3WnFKTFFMeFBwQnRXY0FpVnJJakIvdmhnaVZG?=
 =?utf-8?B?bFNGRXdoajlua2pJcFI3bWY0bFJyVFRrVUp1Yis5ZEp5eHJUc0k2UFlzU2tM?=
 =?utf-8?B?bUttdXlidW43cFFLMzJOMmlxTGFqSWFITk9QZ3FqeFV6c0ZDTndMUFN3dEg1?=
 =?utf-8?B?eXFNckk5Tm9hL2xFdnJpbnIwZVd4VjBmTDNzSmNHZXRrMnBiYnlEdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C3D14064DA30544AE0ED777657F4463@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df224915-e159-4a00-d5f2-08df049f1336
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 00:55:37.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWZHhAM7uQzwCqEIAW+D5iUSEzYCQjz3qw/Y9OdTnRJyJU4hFoA30n9pgKR54abi1ZJpmDXNJbp149rpRp8Huw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13877
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_175556_315629_2D38DD82 
X-CRM114-Status: GOOD (  29.76  )
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

T24gMjAyNi8wOC8yNSA4OjA3LCBUYW8gTGl1IHdyb3RlOg0KPiBIaSBTdGVwaGVuLA0KPiANCj4g
SSBoYXZlIHRlc3RlZCB0aGUgcGF0Y2hzZXQgdXBvbiBteSBmaWx0ZXJpbmcgZXh0ZW5zaW9uLCB3
b3JraW5nIGdvb2QhDQo+IEFuZCBJIGFncmVlIHdpdGggeW91ciBjdXJyZW50IFBHX0lOQ0xVREVf
SEVBRCBkZXNpZ24sIGxldCdzIGdvIHdpdGgNCj4gdGhpcy4NCj4gDQo+IFJldmlld2VkLWJ5OiBU
YW8gTGl1IDxsdGFvQHJlZGhhdC5jb20+DQoNCkhpIFN0ZXBoZW4sIFRhbywNCg0KdGhhbmsgeW91
IGZvciB0aGUgdjIgcGF0Y2ggc2V0IGFuZCByZXZpZXdpbmcuDQpJIHVuZGVyc3Rvb2QgdGhhdCB5
b3VyIGN1cnJlbnQgZXh0ZW5zaW9ucyBkb24ndCBuZWVkIHRoYXQgZmxleGliaWxpdHksDQpzbyBJ
IGFncmVlIHRvIHN0b3AgYSBwcmVtYXR1cmUgZW5oYW5jZW1lbnQgYXQgdGhpcyB0aW1lLg0KDQpU
aGUgcGF0Y2ggc2V0IGxvb2tzIGdvb2QgdG8gbWUgYW5kIHRlc3RlZCBvaywgSSd2ZSBhcHBsaWVk
IFBhdGNoIDEgdG8gNw0Kd2l0aCBUYW8ncyBSZXZpZXdlZC1ieSB0YWcgYW5kIGEgZmV3IG9mIGNv
bW1lbnQgc3R5bGUgdHdlYWtzLg0KDQpUaGFua3MsDQpLYXp1DQoNCj4gDQo+IFRoYW5rcywNCj4g
VGFvIExpdQ0KPiANCj4gT24gRnJpLCBBdWcgMjEsIDIwMjYgYXQgMTE6MzHigK9BTSBTdGVwaGVu
IEJyZW5uYW4NCj4gPHN0ZXBoZW4ucy5icmVubmFuQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4NCj4+
IEhlbGxvIGFsbCwNCj4+DQo+PiBUaGlzIGlzIHYyIG9mIG15IHNlcmllcyBvZiBpbXByb3ZlbWVu
dHMgZm9yIG1ha2VkdW1wZmlsZSBleHRlbnNpb25zLg0KPj4gdjEgY2FuIGJlIGZvdW5kIGhlcmU6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2tleGVjLzIwMjYwNzE0MDA0NTUwLjM2OTgxNzUtMS1z
dGVwaGVuLnMuYnJlbm5hbkBvcmFjbGUuY29tLw0KPj4NCj4+IFRoZXJlIGhhdmUgb25seSBiZWVu
IGEgZmV3IGNoYW5nZXMgZnJvbSB2MToNCj4+IC0gVXBkYXRlZCBleHRlbnNpb24vc2FtcGxlLmMg
dG8gdXNlIHRoZSBuZXcgQVBJIGluIHBhdGNoIDMuDQo+PiAtIFJlb3JkZXJlZCBhbmQgcmV3b3Jk
ZWQgdGhlIGV4dGVuc2lvbiByZXRhaW5lZCBwYWdlcyBzdGF0aXN0aWMgcGVyIFRhbydzDQo+PiAg
ICBzdWdnZXN0aW9uLCBzbyB0aGF0IGl0IGlzIG1vcmUgY2xlYXIuDQo+PiAtIEluY2x1ZGVkIGEg
bW9yZSBjb21wbGV0ZSBjb21taXQgbWVzc2FnZSBpbiBwYXRjaCA3Lg0KPj4gLSBJbiBwYXRjaCAx
LCByZW1vdmVkIHRoZSAibnJfcGFnZXMgPSAxIiB3aGVuIGV4dGVuc2lvbnMgcmV0dXJuIFBHX0VY
Q0xVREUuDQo+PiAtIFNpZ25pZmljYW50bHkgcmV3b3JkZWQgcGF0Y2ggMSdzIGNvbW1pdCBtZXNz
YWdlIHRvIGV4cGxhaW4gdGhlIGRpZmZlcmVudCBjYXNlcw0KPj4gICAgYW5kIHRoZSBhbHRlcm5h
dGl2ZSBhcHByb2FjaC4NCj4+DQo+PiBOb3RhYmxlIGltcHJvdmVtZW50cyBpbiB0aGUgInVzZXJz
dGFjay5jIiBleHRlbnNpb24gYXJlOg0KPj4gLSBMZXZlcmFnZSAiZGV0ZWN0X2N5Y2xlLmgiIEFQ
SSB0byBhcHBseSBCcmVudCdzIGFsZ29yaXRobSBmb3IgY3ljbGUgZGV0ZWN0aW9uDQo+PiAgICBp
biBsaW5rZWQgbGlzdCBpdGVyYXRpb24sIHRvIGF2b2lkIGluZmluaXRlIGxvb3BzIHdoaWxlIGl0
ZXJhdGluZyB0YXNrcyAmDQo+PiAgICB0aHJlYWRzIG9uIGNvcnJ1cHQgdm1jb3Jlcy4NCj4+IC0g
U2V0IGEgbGltaXQgdG8gdGhlIG51bWJlciBvZiByZXRhaW5lZCBhbm9uX3ZtYSBlbnRyaWVzLCB0
byBhdm9pZCBoaXR0aW5nIE9PTQ0KPj4gICAgaXNzdWVzIGluIGNhc2Ugb2YgYSBodWdlIHZtY29y
ZSBvciBhIGJ1ZyBpbiB0aGUgZXh0ZW5zaW9uLg0KPj4NCj4+IEFzIGRpc2N1c3NlZCBvbiB2MSwg
dGhlIGZpbmFsIHR3byBwYXRjaGVzIGNvbnRhaW5pbmcgdGhlIGV4dGVuc2lvbnMgYXJlIG5vdCB0
bw0KPj4gYmUgbWVyZ2VkLiBJIHdpbGwgcHVibGlzaCB0aGVtIGluIGEgR2l0aHViIHJlcG9zaXRv
cnkgYXMgc29vbiBhcyBJIGNhbiBnZXQgaXQNCj4+IGFycmFuZ2VkIHdpdGggbXkgZW1wbG95ZXIu
IFRoZXkgYXJlIG1vcmUgZm9yIGRlbW9uc3RyYXRpb24gb2YgdGhlIEFQSSBhbmQNCj4+IGNvbnRp
bnVlZCBzaGFyaW5nIHVudGlsIHRoZSByZXBvc2l0b3J5IGlzIGF2YWlsYWJsZS4NCj4+DQo+PiBU
aGUgbWFqb3IgZGlzY3Vzc2lvbiBvbiB2MSB3YXMgb24gcGF0Y2ggNCwgZGVhbGluZyB3aXRoIGhv
dyBleHRlbnNpb25zIGFyZQ0KPj4gY2FsbGVkLCBiZXR3ZWVuOg0KPj4NCj4+IChhKSBFeHRlbnNp
b25zIGFyZSBjYWxsZWQgZm9yIGFsbCBiYXNlIHBhZ2VzLCBhbmQgdGhlaXIgZGVjaXNpb25zIG1h
eSBjb25mbGljdA0KPj4gd2l0aCB0aGUgaGVhZCBwYWdlIGRlY2lzaW9uLg0KPj4gKGIpIEV4dGVu
c2lvbnMgYXJlIG5vdCBjYWxsZWQgZm9yIHRhaWwgcGFnZXMsIGFuZCB0aGUgaGVhZCBwYWdlIGRl
Y2lzaW9uIGlzIHVzZWQNCj4+IGluc3RlYWQuDQo+Pg0KPj4gQXMgSSBleHBsYWluZWQgaW4gbXkg
bGFzdCByZXBseSwgSSBiZWxpZXZlIHRoYXQgKGIpIGlzIHN0aWxsIHRoZSBiZXN0IHdheS4gSXQg
aXMNCj4+IGxlc3MgY29tcGxleCB0aGFuIChhKS4gSXQgaXMgYWxzbyBtb3JlIGVmZmljaWVudCwg
YmVjYXVzZSBtYWtlZHVtcGZpbGUgdG9kYXkNCj4+IHNraXBzIHByb2Nlc3NpbmcgbWFueSBleGNs
dWRlZCB0YWlsIHBhZ2VzLCB3aGljaCBhZGRzIHVwIGZvciBsYXJnZSBzeXN0ZW1zIHdpdGgNCj4+
IG1hbnkgaHVnZSBwYWdlcy4gV2UgZG8gbm90IGhhdmUgYW55IGV4dGVuc2lvbiB3aGljaCByZXF1
aXJlcyBhbnkgcG9saWN5IG1vcmUNCj4+IGNvbXBsZXggdGhhbiBQR19JTkNMVURFX0hFQUQuDQo+
Pg0KPj4gLSBlbGZoZWFkZXIgcmVxdWlyZXMgUEdfSU5DTFVERV9IRUFEDQo+PiAtIHVzZXJzdGFj
ayBvbmx5IHVzZXMgUEdfSU5DTFVERS4gSSBjb3VsZCBpbWFnaW5lIHBvdGVudGlhbGx5IHdhbnRp
bmcgdG8gaW5jbHVkZQ0KPj4gICAganVzdCB0aGUgc3ViLXBhZ2VzIG9mIGNvbXBvdW5kIHBhZ2Vz
IHRoYXQgYXJlIGFjdHVhbGx5IHVzZWQgYnkgdGhlIHN0YWNrLiBCdXQNCj4+ICAgIGl0IGhhc24n
dCBiZWVuIG5lY2Vzc2FyeSBzbyBmYXIuDQo+PiAtIGFtZGdwdSBidWZmZXJzIG1heSBiZSBjb21w
b3VuZCBwYWdlcyBidXQgaWYgdGhleSBhcmUsIHRoZW4gdGhlIGVudGlyZSBwYWdlDQo+PiAgICB3
b3VsZCBiZSBleGNsdWRlZC4NCj4+DQo+PiBJIGRvIGhhdmUgYW4gaW1wbGVtZW50YXRpb24gb2Yg
KGEpIGFzIEkgc2hvd2VkIGluIHRoZSB0aHJlYWQuIElmIEknbSB3cm9uZyBoZXJlLA0KPj4gSSBj
YW4gYWx3YXlzIGZhbGwgYmFjayB0byB0aGF0Lg0KPj4NCj4+IFRoYW5rIHlvdSwNCj4+IFN0ZXBo
ZW4NCj4+DQo+Pg0KPj4gU3RlcGhlbiBCcmVubmFuICg5KToNCj4+ICAgIERvIG5vdCBjYWxsIGV4
dGVuc2lvbnMgZm9yIHRhaWwgcGFnZXMNCj4+ICAgIEhvbm9yIENGTEFHUyBpbiBleHRlbnNpb24v
TWFrZWZpbGUNCj4+ICAgIFNoYXJlIHBhZ2UgaW5mb3JtYXRpb24gd2l0aCBleHRlbnNpb24gY2Fs
bGJhY2tzDQo+PiAgICBJbnRyb2R1Y2UgYSBzdGF0IGZvciBwYWdlcyByZXRhaW5lZCBieSBleHRl
bnNpb24NCj4+ICAgIE1vdmUgcGFnZSBjaGVja3MgaW50byBtYWtlZHVtcGZpbGUuaA0KPj4gICAg
U2ltcGxpZnkgYXJndW1lbnRzIGZvciBwYWdlIGNoZWNrcw0KPj4gICAgQWRkIFBHX0lOQ0xVREVf
SEVBRCBleHRlbnNpb24gcmV0dXJuIHN0YXR1cw0KPj4gICAgQWRkIHVzZXJzdGFjayBleHRlbnNp
b24NCj4+ICAgIEFkZCBlbGZoZWFkZXIgZXh0ZW5zaW9uDQo+Pg0KPj4gICBleHRlbnNpb24uYyAg
ICAgICAgICAgICB8ICAxMCArLQ0KPj4gICBleHRlbnNpb24uaCAgICAgICAgICAgICB8ICAxMCAr
LQ0KPj4gICBleHRlbnNpb25zL01ha2VmaWxlICAgICB8ICAgOCArLQ0KPj4gICBleHRlbnNpb25z
L2VsZmhlYWRlci5jICB8ICA5MyArKysrKysrKysrKw0KPj4gICBleHRlbnNpb25zL2xpc3QuaCAg
ICAgICB8IDEwNiArKysrKysrKysrKysNCj4+ICAgZXh0ZW5zaW9ucy9zYW1wbGUuYyAgICAgfCAg
IDIgKy0NCj4+ICAgZXh0ZW5zaW9ucy91c2Vyc3RhY2suYyAgfCAzNTEgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBleHRlbnNpb25zL3ZtYV9tdHJlZS5jICB8
IDE0MCArKysrKysrKysrKysrKysrDQo+PiAgIGV4dGVuc2lvbnMvdm1hX210cmVlLmggIHwgICA3
ICsNCj4+ICAgZXh0ZW5zaW9ucy92bWFfcmJ0cmVlLmMgfCAgNTYgKysrKysrKw0KPj4gICBleHRl
bnNpb25zL3ZtYV9yYnRyZWUuaCB8ICAxMiArKw0KPj4gICBtYWtlZHVtcGZpbGUuYyAgICAgICAg
ICB8IDE4OSArKysrKysrKystLS0tLS0tLS0tLS0tDQo+PiAgIG1ha2VkdW1wZmlsZS5oICAgICAg
ICAgIHwgIDc4ICsrKysrKysrLQ0KPj4gICAxMyBmaWxlcyBjaGFuZ2VkLCA5MzEgaW5zZXJ0aW9u
cygrKSwgMTMxIGRlbGV0aW9ucygtKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZXh0ZW5zaW9u
cy9lbGZoZWFkZXIuYw0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZXh0ZW5zaW9ucy9saXN0LmgN
Cj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGV4dGVuc2lvbnMvdXNlcnN0YWNrLmMNCj4+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGV4dGVuc2lvbnMvdm1hX210cmVlLmMNCj4+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGV4dGVuc2lvbnMvdm1hX210cmVlLmgNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGV4
dGVuc2lvbnMvdm1hX3JidHJlZS5jDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBleHRlbnNpb25z
L3ZtYV9yYnRyZWUuaA0KPj4NCj4+IC0tDQo+PiAyLjUyLjANCj4+

