Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46266CD98F0
	for <kexec@archiver.kernel.org>; Thu, 18 Jun 2026 08:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0WnJHhTyk7UnjI4xiqMX+uGK//5iu/hIfaMWv1kVUEE=; b=KQgL7iCi7v75Ar8cNm7O3IZ3Hq
	TbQYvcz2Yj+q9ZmEOSbNUvLEP3JpRPz1NKbnkqZrga0uKrv7CV/Q6hKt9mAchpSZSw+dpFYsSpq7b
	Wcb04aZMZNjfTTOeITFm7YguRll+YJ210XdnpJej4w0HCIig07YUcIyeOVAZ6xCDofbV1i4Ackf9U
	lZTOoobu5JzOP6E6PBsbnjisLpPadGANd+JzhThUenaUpjT9AuG4JACVlHOmFbmvieuBubyRXoB4D
	jUA5BnM1C1zTS1kKiWNHOlXO7LGI5uXw2pqTkvURnqxu7pJ7jnos1nuVv29PH+0r4AJ9d01g5yj2t
	gnbOZgCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa86Z-00000000qlf-2CY0;
	Thu, 18 Jun 2026 08:28:07 +0000
Received: from mail-japanwestazon11010039.outbound.protection.outlook.com ([52.101.228.39] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa86W-00000000qkh-1o0X
	for kexec@lists.infradead.org;
	Thu, 18 Jun 2026 08:28:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRT6Sz1D+sBomr+IJvkAxUVqill1VJ6JRvXdpy2dx82hRz2rqVGnoqNpFNWWl19bRZRx+Q5UCVCF35cZVYZg+mEFn1eTRlIrMhjp5AKIQy4UqTzZE8IOYDD+p/v/VA3QSE4BaSA8Cn3Dk6RpNHMULLhHcesw5gTfMPtc9RwFZ820dIM2vLevjATtJzQ57xrOqtYrxYjQMC87jDlFJh70s1WoTqgQ8KV0HtWn+gK8v6vG9k474KYUhMKOUo8YG5DfaQ/mY9dD+9ScRXfRMHZemsPc0kidq3VHDe3iJQ97HdzgUgvKeAERx17rQYCo/thJZD7CBu1PC4dZIrUAlo7iEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WnJHhTyk7UnjI4xiqMX+uGK//5iu/hIfaMWv1kVUEE=;
 b=C2bZ4hmXlgPmffvfdWKKVHOMnbkOidiviG0B0Th4j92Qah6li5KKSqkHGv+EVi3QX8+enM21COMKR9ZsQ6C4qTyEMpTPoIYOZubs4D1u1VBja/GWghVrwGLHHfVOTQp9CczZcZbgF8ZsWqjNsEdYYMWUsrk58deO+eN7Fx2RXZm8Hd/79FvNioXcA2zARR9S4vVjn2X3TnGiTK+rw+YW+LqoLl7eeaKcJOsKVIZw7dqgHtF9H3xRKgGrG5f3vanugKDIn4+/v5b/GEEpRj75HEHJ6eMfaqqocLqXNN0Y/RD+2dEYs3FI6+Xhiy+MBtlftJjLauNvAxeGu2SAyqOLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WnJHhTyk7UnjI4xiqMX+uGK//5iu/hIfaMWv1kVUEE=;
 b=DyAuHF1q4xFhrL7dpO2qMyBT45AngyuPBqKaGZbX6QzHxrDPQAHydyw8ZwyA4+z6AdM930icSURtR5ZoTW5/Z943o6kufrsAqS+Y/6ffZXW6pnq9Ivuv73TX9IHe520hJ9RB7P19/a7sIKWifmtkjoelkjXWzXe6ifv13I2ScxsJBkkS1CTPhS9y4fNEk0fb3uwBmQV6JZmqTClZWhkKZbp1YwH8LaF1kKJGmTZMbgni0gHdsBxTirILUVmcfPMXyOnEb8+UO9zTwron/UCfE4+tV00rFkQpvy5rZZvY9PsYvHoZM2IDlktjXLM8fy6d8ptvYUHfpPYc6F1ryMGKoA==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by TYWPR01MB11192.jpnprd01.prod.outlook.com
 (2603:1096:400:3f7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 08:27:54 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%6]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 08:27:54 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "aravinda@linux.vnet.ibm.com" <aravinda@linux.vnet.ibm.com>,
	"stephen.s.brennan@oracle.com" <stephen.s.brennan@oracle.com>,
	"kjlx@templeofstupid.com" <kjlx@templeofstupid.com>
Subject: Re: [PATCH v6][makedumpfile 02/10] Implement kernel kallsyms
 resolving
Thread-Topic: [PATCH v6][makedumpfile 02/10] Implement kernel kallsyms
 resolving
Thread-Index: AQHc/hkE7HzQWhD0REqk0i1Yn5AMU7ZD/FgA
Date: Thu, 18 Jun 2026 08:27:54 +0000
Message-ID: <30fe770e-286e-4272-bb7e-0e9ad01cecc5@nec.com>
References: <20260617051834.95404-1-ltao@redhat.com>
 <20260617051834.95404-3-ltao@redhat.com>
In-Reply-To: <20260617051834.95404-3-ltao@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|TYWPR01MB11192:EE_
x-ms-office365-filtering-correlation-id: 268c53d7-f9b2-491c-e878-08decd137e90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|56012099006|4143699003|11063799006|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: f4RGxjndV5CEvLueISDjQHtHSyFGCeb75Z3WaN/DSy70oAExpNmeQVYJz019QdANEEkyWonOoOr4xgAZmWhkMpyhCsXrzXH8G9dlY8dtQvHIVVFV3aERcpf1ieXUCBR4W/7M/OsjuA+3NqNydJvA6m12ujpCWUPz7OnakpEoZpSyc18e2Dw4SyWcKgt85TzppQNcjhLs6LaBzVxzYVUTm3ym/88sejnYc4PcISBVHfNffBeIcUBYaGvXXhRuIWreqxv0QX2rtM0ddQ8t7d7DCOBt2nz5s5j+vMKn3ZvQXbmsKPa1QYw2GTNg1MTvKrY8h/6yRZGBMvNAcMUELfD5Qq8Wa7TcbAekEw3f5lfIoZomU7LcsKjbVKaC8OAHItDGNTUo2Uqe/+RkZhVsXIF8QXEiR3gxhR2ni/RcTfW+p091KRjJy8wv6H6rVSFDXmNtHtPEpRMYeD45stX4Z1MOewMtEl8YrrJ0BRVFGmkFfKyJ3Bk/GFymkTNkiAsHOzCMzw2VSC12ceGpi6rmQ+QjgWxkXyws7LzQ/6WyYd4FGv1STb0NDUr8kZAao89xR/Jsgi/mwfG6gC/C2Xi91HrKAJyNoncPVccXbYDUVG4HxqvyRYu7yb35xOSAXorn1L9aL5irMM/SrtjxnCiLwMTPnu5xz1JSTKBa/gXaSLvw/AmaaFAT+kjJVCMozOVOG1upJFSa3sC0HJEnO1awD1kxLeVTZ4uL7rDdb8D6VYklmKLaUrmuTIGbuwYojLASUjM8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(56012099006)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHhkVCtFOGZHbThIWXVQaGtpTmlrUmdObXZOK3ErbTRrV3JDRk0weGYxeU5W?=
 =?utf-8?B?QjNLeGxqcTdrZElwbnY4MGpFSVhvb3dEbGc2OE1wRkpmcys3Tjd4YUJOdnQx?=
 =?utf-8?B?ZkZvVndzWVN4bll2cFdaT2hvU2JpcE5kRUZObWNDSkxYWWo0TXpWSUlENnJR?=
 =?utf-8?B?bkYxaHhxTS9QWElmWnRZS2g0enNsWE9GcUxLcE5sNThtbmg3UjhhdGJ3QjNK?=
 =?utf-8?B?b3E4S2dUKy9GaGlZTVEzcG9FbVZHRjJwMW5DaFY3d2xtNUFteXhQZGNKbHMy?=
 =?utf-8?B?V3kweGcwSm1xbG1jNVh0OGVaMTI4VklFTEo4a2tjQjF5clIrVW9SY1lrN2t0?=
 =?utf-8?B?RVhqWm11VHVpcGRER29CUU5sL0pReEVsWDM5RU5CR1pJZlI5OStOTGdUMWpp?=
 =?utf-8?B?aTFCNXI0ajlxWTUrMVo2ZmovT0ZiYnR3SzczNnBSblNZUjBJRHZWbU9MaXhG?=
 =?utf-8?B?cWJkaDVGNGdaNEJsSVNOY0xuMHhFKzV4MkROQ2I2SjM0UFlIcllRWktYT3ND?=
 =?utf-8?B?S2dXRlB5alk5SUVtT0hYQzFvOEhkTmhBNzkrendYaTNHZXZVQTZVYU90QS9n?=
 =?utf-8?B?S3NDdkM3L0NUdG5jOVI0YWN3VGRkQVcyMlo4RGJSOXAyeE5uOWg1ZGk4TG1H?=
 =?utf-8?B?OVpTUTJyS1NyelU2NndBYWlXTjZKT2pLa2FRVlBUbUFGM2lLWGdsVkY0bHly?=
 =?utf-8?B?NDVIMDFWTFJEY3ZpQ3g5cjg2QSsrazR2cW1Xd3RqUS82TGRXRnRhMDZERWtp?=
 =?utf-8?B?TFFlQWRyb0czQTE1cEtWN0MzTEsxa2Q0QlFybW11NUMyeHVoMlNyVlAwbmhN?=
 =?utf-8?B?QWl5WU9ueVpycjNNWiswWXg4VGs2WUxValFvOC9CeCtuWUpwRDhYZTltMnVy?=
 =?utf-8?B?R09IaXhtOC9RbDQ1SFBhUTR5MklhYTVRNjNDTHNLaXhKbVlqZFk4TlpyeXFl?=
 =?utf-8?B?ODBic1F2Vm9NL2s1MkluYlBvVGVITDFFTG9ucXpVWTgyRHBWdk94SFVMaDdQ?=
 =?utf-8?B?Zkc4SWNuTzYraTVoRG40c201bVI5Y01oZGNRUGMyUVhtSVE5VlgxZnI1MElS?=
 =?utf-8?B?NG95bUdHZmV3UGt4cTEwbk5Lc3BHNjBSOU1tcFZKeGhQa0RPSVp5WkVCK0tQ?=
 =?utf-8?B?TXJVQ0Q0bmlJdFljMXVxRTRTOUFNZk9VMFNwaTlOZzRZUVhHSUltWkFMUUtC?=
 =?utf-8?B?d1NKSGZBYUZmR1VUZjVwM3BuNWVJVzRUNm1ET0UwNFRxTVFNT0pXZ2wveUhq?=
 =?utf-8?B?R0p3Tm44RWdDeDFFV24yemkwWHBPN3d2WURCTU1YNE9USjVrRGNVV0ZiOGha?=
 =?utf-8?B?Witqd3VsdzhzajB1SUYwMS81Sm1ISDFhc3pYeFlIaHFHYjU0UEhZYzhtZTZX?=
 =?utf-8?B?OTNQMG15TUhkc3U5RjJpZ1YxN3A1RlRONE9nVUoyYVVxaU52Q3Q4OXhBNTZO?=
 =?utf-8?B?MW5UTkpnVllQR0NkVzBBVEM4cFB3bFZTZWxLZWpsK0FvV0VMY01NZVNxMWVJ?=
 =?utf-8?B?UjFPSUVXREZ1c2VTUlVPaThhNnk0cGRJUDl2NGIrV3V2RHRNbHdrR3VvODdi?=
 =?utf-8?B?Z0p1ajRZUmtBbGdjMkxoSTR0dXEvTys2Wmw2dDVGeXFqRGxnRVJMU3pxaXBS?=
 =?utf-8?B?V1BQUU1BOFZLYWRJNERkdGVSNmErd1RXSWRBVVVvVGxWVEJ3Nk9sK0Y0VW9J?=
 =?utf-8?B?NTBKREhnUisxWVBZNGwxdHVZMkplMDYxUmFVUGxCWnA4d3FuT0tLUmxHc2hI?=
 =?utf-8?B?WlNzRFpmOStFS3YxZXlzeU93TEJJRzkvU1BCc2cvK3gwdmdIZVZUckZHM2tl?=
 =?utf-8?B?Z1ZtUVBjd3loY2pNZTQ1cWFBaGpGYWRDbjlzeVQzckxZb0ZKNjNRVUl0bnlo?=
 =?utf-8?B?Z1JPMzMrNGRJODNvVkNwVzVaRVNUVVMyeGNhT2orUHpmcHRKSXoyY2paenNj?=
 =?utf-8?B?U1cxN2tnbnQ1cG5tamlqMHpSYXNOeUY1TElGM3VCVVRYYWg1ZUZBSnczT0F6?=
 =?utf-8?B?WHdndTZUZTlManFhVDRFejg0dU1SOW1zM2w1eHI4UWpySFIzTWZwWDdneTF1?=
 =?utf-8?B?T3hYMWNZSjhiN245eFVmWlFVQW0zaXBiVVcyNmhjL3FPWjJWZEU1Mm1kczVr?=
 =?utf-8?B?dWtTWVdIZ1NNaUorS1NkbGlOSWRESFVKcGpSc1FRUzRCR0tRSTZqV0svRFZh?=
 =?utf-8?B?Y05OMmtYbHl3UFIrd3NPUWdqZXNMN0lUWVlqMXB3aVFNYVF1bFNBVGtaQTd0?=
 =?utf-8?B?UG5xZ3ZVZXhkaXJodUl5ZWZHZXUxV1loeTB1Z09abEp5cDBDUGNydllhTnNx?=
 =?utf-8?B?dEx5dU1yV3R5VlJTZCtpN0lBVTVJcjNseDZ0WmU0Ykh4aDk3RkRYZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08B1412E85FB5949827DA129E18AC8E1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268c53d7-f9b2-491c-e878-08decd137e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 08:27:54.4188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBTM6orDW+UKSyNrnY+vlTZBwXmEjV3BZSJXYqZelaaVV9Bu0hz/f0OVq5kH6CTPmS5gq1zLW1xOnHu0+LhH7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11192
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260618_012804_829901_38362C15 
X-CRM114-Status: GOOD (  16.78  )
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

SGkgVGFvLA0KDQpPbiAyMDI2LzA2LzE3IDE0OjE4LCBUYW8gTGl1IHdyb3RlOg0KPiBUaGlzIHBh
dGNoIHdpbGwgcGFyc2Uga2VybmVsJ3Mga2FsbHN5bXMgZGF0YS4gRHVyaW5nIHRoZSBwYXJzaW5n
DQo+IHByb2Nlc3MsIHRoZSAuaW5pdF9rc3ltcyBzZWN0aW9ucyBvZiBtYWtlZHVtcGZpbGUgYW5k
IHRoZQ0KPiBleHRlbnNpb25zIHdpbGwgYmUgaXRlcmF0ZWQsIHNvIHRoZSBrYWxsc3ltcyBzeW1i
b2xzIHdoaWNoIGJlbG9uZ3MNCj4gdG8gdm1saW51eCBjYW4gYmUgcmVzb2x2ZWQgYXQgdGhpcyBt
b21lbnQuDQo+IA0KPiBSZXZpZXdlZC1ieTogU3RlcGhlbiBCcmVubmFuIDxzdGVwaGVuLnMuYnJl
bm5hbkBvcmFjbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBUYW8gTGl1IDxsdGFvQHJlZGhhdC5j
b20+DQo+IC0tLQ0KPiAgIE1ha2VmaWxlICAgICAgIHwgICAyICstDQo+ICAga2FsbHN5bXMuYyAg
ICAgfCAzOTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiAgIGthbGxzeW1zLmggICAgIHwgIDgzICsrKysrKysrKysrDQo+ICAgbWFrZWR1bXBmaWxl
LmMgfCAgIDMgKw0KPiAgIG1ha2VkdW1wZmlsZS5oIHwgIDExICsrDQo+ICAgNSBmaWxlcyBjaGFu
Z2VkLCA0OTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBrYWxsc3ltcy5jDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGthbGxzeW1zLmgNCj4gDQo+
IGRpZmYgLS1naXQgYS9NYWtlZmlsZSBiL01ha2VmaWxlDQo+IGluZGV4IDk0ODIzMzIuLjNjZDcy
OWYgMTAwNjQ0DQo+IC0tLSBhL01ha2VmaWxlDQo+ICsrKyBiL01ha2VmaWxlDQo+IEBAIC00NSw3
ICs0NSw3IEBAIENGTEFHU19BUkNIICs9IC1tMzINCj4gICBlbmRpZg0KPiAgIA0KPiAgIFNSQ19C
QVNFID0gbWFrZWR1bXBmaWxlLmMgbWFrZWR1bXBmaWxlLmggZGlza2R1bXBfbW9kLmggc2FkdW1w
X21vZC5oIHNhZHVtcF9pbmZvLmgNCj4gLVNSQ19QQVJUID0gcHJpbnRfaW5mby5jIGR3YXJmX2lu
Zm8uYyBlbGZfaW5mby5jIGVyYXNlX2luZm8uYyBzYWR1bXBfaW5mby5jIGNhY2hlLmMgdG9vbHMu
YyBwcmludGsuYyBkZXRlY3RfY3ljbGUuYw0KPiArU1JDX1BBUlQgPSBwcmludF9pbmZvLmMgZHdh
cmZfaW5mby5jIGVsZl9pbmZvLmMgZXJhc2VfaW5mby5jIHNhZHVtcF9pbmZvLmMgY2FjaGUuYyB0
b29scy5jIHByaW50ay5jIGRldGVjdF9jeWNsZS5jIGthbGxzeW1zLmMNCj4gICBPQkpfUEFSVD0k
KHBhdHN1YnN0ICUuYywlLm8sJChTUkNfUEFSVCkpDQo+ICAgU1JDX0FSQ0ggPSBhcmNoL2FybS5j
IGFyY2gvYXJtNjQuYyBhcmNoL3g4Ni5jIGFyY2gveDg2XzY0LmMgYXJjaC9pYTY0LmMgYXJjaC9w
cGM2NC5jIGFyY2gvczM5MHguYyBhcmNoL3BwYy5jIGFyY2gvc3BhcmM2NC5jIGFyY2gvbWlwczY0
LmMgYXJjaC9sb29uZ2FyY2g2NC5jIGFyY2gvcmlzY3Y2NC5jDQo+ICAgT0JKX0FSQ0g9JChwYXRz
dWJzdCAlLmMsJS5vLCQoU1JDX0FSQ0gpKQ0KPiBkaWZmIC0tZ2l0IGEva2FsbHN5bXMuYyBiL2th
bGxzeW1zLmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uYTU1ZGNj
Ng0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2thbGxzeW1zLmMNCj4gQEAgLTAsMCArMSwzOTIg
QEANCj4gKyNkZWZpbmUgX0dOVV9TT1VSQ0UNCg0KSnVzdCBmb3IgY29uZmlybWF0aW9uLCBpcyB0
aGlzIGZvciB3aGF0PyAgSSBjYW4gYnVpbGQgd2l0aG91dCB0aGlzIGxpbmUuDQoNCiQgZ2l0IGdy
ZXAgX0dOVV9TT1VSQ0UNCmthbGxzeW1zLmM6I2RlZmluZSBfR05VX1NPVVJDRQ0KDQpJZiB1bm5l
Y2Vzc2FyeSwgSSB3b3VsZCBub3QgbGlrZSB0byBhZGQgc29tZXRoaW5nIG5ldyBmb3IgY29tcGF0
aWJpbGl0eS4NCmlzIGl0IG9rIHRvIHJlbW92ZSB0aGlzIHdoZW4gbWVyZ2luZz8NCg0KVGhhbmtz
LA0KS2F6dQ0K

