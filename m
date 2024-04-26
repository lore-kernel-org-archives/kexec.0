Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17ACC4345F
	for <kexec@archiver.kernel.org>; Fri, 26 Apr 2024 08:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HAsWnUELPWQ4qtK+5ihY5/tEdtGKfxFS27DIzHFEIkc=; b=frZJ8h3ik7dEib
	pyvuXEaouL0opJ2+dSasUyh1Sa4Q/3DqGUCrtsPsHFb1R/boAmUIPxM/FogfTgdx9PuQUvpuLXHNw
	gAM9CVpKW2UBWLDpqspyLzMREK3r9bfIz/9MoC1xNO+aByooiGLcA2y1dftLIYvI+nrU2CpqCfs0q
	EZ0rXaLuAxKSSDzVzWo38JGBnMj9XblAfC5BQxy4E1uUkOPC/AHe0mhPgyX3Vr9CLFLlLsAcvSxRD
	tY5VvMNdSVROxMFBT2vFCeSMlKCDqskEgxEQ6/RsG/93bBgxtANoFauJyIJw72HJQf/QMSx/ysv8e
	uce3GFd2HhFa/Z12cI/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0GX9-0000000BZjt-0gzq;
	Fri, 26 Apr 2024 08:02:15 +0000
Received: from mail-tycjpn01on20600.outbound.protection.outlook.com ([2a01:111:f403:2019::600] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0GX5-0000000BZhr-39QU
	for kexec@lists.infradead.org;
	Fri, 26 Apr 2024 08:02:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkVQ9721+HtfYS0aHJJJT3qyNdr7583g5TOlfnHMA6vM1MUz+/Hi2v5dX/JQIB+FYqb4khcpP1uCsA7+xgZIwL1iI9EdrX7k6GmSnJW5prUFpsu1Pgsz2tDp5wH1kziwQgkJ2eas+Rft7AQdYK5uYrbljSxoLdvYHR1+rBg+96bzA0GeJUc06nuF5dhdEG7NlK4WWN75hMg945y5/zVFPjU3wAN8QCPS7tQk8UkvlB0owL7f1l++JgKPe1sSErDywjCMq1C1FkHM2KtIVwdKYO6nvz9e12bJiBGeJ6yILyJkIwOaRXmLOixKlL8Ajp+fDUvwdZjJKdkGP1+69wg25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nf+Z1+scYmyiz7H5rgLRZbvjSu0vRe0+QlYGrrokO/k=;
 b=KZ4OODz+sRxIqLfJkN0ZqDrNXF90SsUwKagpKK02CJfqoOw/96yXWsvfsy/gXy99X7NXpnUdMUxuCYtTS1fYHPHWLumwfg/hMHU6miGetUb+enjsej2/4y0yN/Vm+ldaQsB1jKZ/ue72uHD0gwY3KxNasEaHBlldRs0YOEBoudyjSud30QdJk2BA0luufBt69h6vFzL1a3R+KUYKRdFqz0MmkIpRIAKUdcecq1UCnsD39OLiwBYiyWkfq2jrfUkUY4xjqYSSGKlUjfjidazI5Zaes0PYysHeUVPvKG/HyAemF9dNu3O/qndn2hiseSj85R17RZzOY0+uZnVQ/2WpFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nf+Z1+scYmyiz7H5rgLRZbvjSu0vRe0+QlYGrrokO/k=;
 b=XKRS9GU72T3ybQgohZJsILPSDYzfFpxGNz4Hhlufcuki+kLMthV7bKVFHBDyJR3UmcH6gvR9lNK9LEppvtREIAI2Tgc2yelYo2t/WvXZ2vAVypE9/LB6g0KrT3yabYFVVNMAOdVJDk9Yo+MvhxjOIa5bLsQ8tYdkuAAyB9376oekilHRau8XLIfh0h6/0GYXZCNjtsSQg9sW3vL1DHQhncxlSlEUsSK6mNCqzLFOzlTuOQTMXp87ruAEdLV0snq/zjMqoKAt/5AI1mliIaLdAu69eFh+2M32trsfHuSz26IdTGF5U7b8xf4Q3OrwcC6yqAIgHwg+TvZHbtMYusd11Q==
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 (2603:1096:400:3a5::14) by TYVPR01MB10702.jpnprd01.prod.outlook.com
 (2603:1096:400:2af::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 08:01:54 +0000
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::7245:8970:3fcf:1f6b]) by TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::7245:8970:3fcf:1f6b%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 08:01:54 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Coiby Xu <coxu@redhat.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
Subject: Re: [PATCH makedumpfile] Make sbindir configurable
Thread-Topic: [PATCH makedumpfile] Make sbindir configurable
Thread-Index: AQHale4jyRefM1ax8Uq9mo+kIQ+A6rF6NCOA
Date: Fri, 26 Apr 2024 08:01:54 +0000
Message-ID: <f362963f-1e38-437b-a7fd-28070bd10c2f@nec.com>
References: <20240424022047.13325-1-coxu@redhat.com>
In-Reply-To: <20240424022047.13325-1-coxu@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10963:EE_|TYVPR01MB10702:EE_
x-ms-office365-filtering-correlation-id: 9c5d4c10-8b97-42ce-73a8-08dc65c72377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?clpGWGRrK3dNbWdHRFFxTjA5ZkJEWHJrem00T2FNanhXbEVWQ2VIbzR1aXpr?=
 =?utf-8?B?b0k0MDU2SExzcFkva0FQcnRGL3p1clF5SmpTcU9DZXVyR0VqR3pTTVBOcGFR?=
 =?utf-8?B?c2lGT0FOL1R4b0xXeG10c0RtSkV2ZTB6SWlJT2U5Sm5zMExwenFGMXdMRU4x?=
 =?utf-8?B?SlJyRVRYZFlQK29QY2ViaWoySW9RaXRkWTYyS2xqSHVoaHdnYVp2L21hc3Nl?=
 =?utf-8?B?cFNkZnhRbmE3S05qS1lJYi92blQ0UHNmZVBROCthQ2hacWNQbFpxR08wZTdC?=
 =?utf-8?B?R1V4VHRCMUZxR0lvY2lzdnN2THl0NnE4cGZIekpnZHMwNUhoZzBUaHBPemFM?=
 =?utf-8?B?eEJNYTF1aDJXeUlqU3ErcldiN2Fwb3dYVWZTd3gvYUVZMnRTTFFmM3hwSm5H?=
 =?utf-8?B?clpUUHNrdStrOE53aUlZSmhFbUYzV2hQa3BOd0RlM2IzQnA3QTI3UEdubnZu?=
 =?utf-8?B?dytmSVNmK3ZHRHd4bzJZblNCbjhlYjgzbFg3akdOUmZyNjRnUlRKbDhGZ2ZV?=
 =?utf-8?B?azlkbW5FL0R2UzJJZktNalJ2aTI4MldNQ0RVVFc1MkNPdWoxQUdHTVZpRTFO?=
 =?utf-8?B?bTMzZ21TT0tlTHE4VG9KempqbmdHMHlqaUgwZXl2UXZwU2JkZFZYcjVnL3JJ?=
 =?utf-8?B?ZmdCVXRvUDl3RW1BR0lhZUxuVjJGNEtWNEVBd2E2dEFQcWpRYVNHNUFpeVhm?=
 =?utf-8?B?UzJhZEltNUZrdlRYRXJNTnljTmRYQlBqY0NDV3lQS2wwaHJUSmIxR3N6aXI1?=
 =?utf-8?B?ZlZyLzdpTFJCeTRxbk82bktQSVFWdUhETzVKMkdZQmNIK0JldmdFZEVMd0ds?=
 =?utf-8?B?ZDEzSGE2UG5ISUsvck5RNEN6dWRwVzBjc2NnYlV5cEFDU0g5VWYxVGJkSXQr?=
 =?utf-8?B?b2ZzMkRzL0thdnV2RUd6YjRpZ2I0VGtSVjlwRUdSWGwxMzdadW1abTJuSzBm?=
 =?utf-8?B?STVEc2ZGOVNlczlzZDV2bWVGY21xcXZZVEhGV01XZlA3MU1ZNThMcTFjSlRs?=
 =?utf-8?B?bS9rZXVWTnVwL1BzamU2RUxFTXF5bmpDWnJvajErRmxCb0V3Y1J3QUZSblBu?=
 =?utf-8?B?Lzd3YXdxcVpNL3pJWm5nNkZiMUdlTVBiWUF4d3YzRjVsRkpMT2NzcTM3MVc4?=
 =?utf-8?B?UjBtL0w0alpHTlV3RDduZVF4ZWs3VVFYU3FBbWkyQTdZWnZXS0JTMWN1VFpM?=
 =?utf-8?B?WEZEaFBWRlZyc2V3cDZxQjV1WE0wNmtXdWNta0V2Znd2VnJrTTR4ZmxZazIx?=
 =?utf-8?B?K0hJcHV6dkZQMWhMTkFDLzJTQjhsWGU3WTg5OGtFcFZ6MUVQSGIvWWM0RWRv?=
 =?utf-8?B?WDJITGZydHVqS29rZkJ6ZFlMZS9iS2tCK2dOV2RkS0hZOG1JNTNBMERiVWNw?=
 =?utf-8?B?WmJJU0dxWkk1YlM5VS9wR0VabTloQzdaSmVrelRQbDZTb3dzM0U2SzJMakVE?=
 =?utf-8?B?VGVwRUozOTJhSkZsVlFCRFovSTBodUdnY0dLUWpqRkNLSitIY21kUHhUSkt1?=
 =?utf-8?B?KzVmRVRZNE01R1NhanFzblIzVzJXTUpKRmpKS3VRa0Y1NkQ4MTVCVnR4a3hp?=
 =?utf-8?B?UGxQVkUxZk9WRTdqcWYzdnRSeTZXanRweE5paisxeEErVjVhK1gxL0VtUVJo?=
 =?utf-8?B?dmNWNjlaZHFxcHYwbkRhVFFQdFBEdU5OY3k2a3FlbVNSM05hd3pTOTROemQy?=
 =?utf-8?B?bDJmSlQxVmh1YjRpaUFsN2J5MTlKNlNYZzdBVHYrbFFOcFNKSU1HTzhRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10963.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2YrWTFzejhEcy90K2dFZERKbUhYaHFsY1FmdE9aUGhqSHpZMWQwZndjVk1R?=
 =?utf-8?B?SHRKNnI3RzgrdGJhZ2JDb1kyRFBsdlZVWVVOYjJWSTAzcW1hSzVwNEV1ajhN?=
 =?utf-8?B?SjQvY1dORXBpOFVTWnV1WGVQMzd4WUFrTWlRVC9VYm9QZWVrMUxMTHRoSEFZ?=
 =?utf-8?B?Y0ZlNWpaSHd6SlVHR1FzM3p2eFg3dS8xVzNJQmUveDZhUVhQWFpHUUVIZGNa?=
 =?utf-8?B?U0Y4aFBkVFNGd1dtTUN6enlnRkJqUFhMaCt6K3VwbjVONUlCMEEvclJ4Z2h2?=
 =?utf-8?B?TWZaWnl4UXFaSStFSUE0cWdLTkZRWnhjUy8xaldqUTRiajdkb0EvRHFJRzgx?=
 =?utf-8?B?WHY0UG40WWpYeGwvb3A1Uk11ZEFVSy93K0Z5TUZnaHNEV2JoY0lhaHhVczU5?=
 =?utf-8?B?V0dzQUNVc3ZtY25zNjdKeDErVVlwS2F4ZWd1UUxEVUZ0VnZOdXpoRDZMZEVN?=
 =?utf-8?B?dzNxRzVvcCtqall6Rmd3d1VVYk9SR05TcDFHSVcrVWE1TzJycDJzb2dPTXhp?=
 =?utf-8?B?LzU1b2N3V3M3eUVnWnc3d2dodFN1RVFuSWFCcnNZQThLdllad01jY3pRLzFk?=
 =?utf-8?B?RlkwMHZFRmVJR013TTdweS9ZdmYxOWFjTWhhNnBSQm81NCtkVWN5U3g5TlQ2?=
 =?utf-8?B?NEhRc1kxc3RqU3h4QUF2QWdCb1F4SkphZjcwRW9PVElVRWlWci9EeWhpWWs1?=
 =?utf-8?B?dHh3Y3JmNm1IYUIyRk1GTGJZTG1lZGYxNDVHSXRrWlMvazN5dVRNa0N1L3lQ?=
 =?utf-8?B?MjFDS2swN2wrUFlDOVJhWDZJM1pIb01venlZT1Z1T0ZwaWQ1LzQ5QlRqOVVw?=
 =?utf-8?B?Ykh5YTBvWUlqeFgxNTRDRWxYazRxM0djbVRtYk8rdmlwRGhtQXlYajZ3aEk0?=
 =?utf-8?B?alorTHo1NVpVME5UTnZrQUdDY3dXY2paeU4wbUhneTh4RlgzSGR4V3FCUVY4?=
 =?utf-8?B?NmhKcC9pckNYVE93ZEdtVTJyZXVDYkhJa0pXMklWUWdxRVhFQTVTU0kwdDdu?=
 =?utf-8?B?NWR0bHFENC9tMzBDakYxZ09KYyt4elpJdStsaFN2M0pXOWUzWk5selZyYjZ6?=
 =?utf-8?B?cGpXazdpVFhpNDF1dTdncUcvdWZkcnVSMDRSVnUyZXJNTWFFTDNVL2R2Sm9x?=
 =?utf-8?B?Tyt2V3JQZ004MWcrZVZoQldKeC8xQllMVCsrTnRvYS9PN1l0YkY2Zzh6aC8r?=
 =?utf-8?B?SllyYlFzRXl1ajlmeGZicHNCbHNvU1BzQmJqNFk1UjNCOTBjelJUVjRmaXFD?=
 =?utf-8?B?bGdPdFk1cXBFL1lJOWdrcFRhcXlidm50aitIQ3l5MmhjNlNmdXMxR3BBK21x?=
 =?utf-8?B?L3dtY00vVTBXUGNXUDRrTjVieHdWcUc1ekRhSjNXREw1eDBvVEtpVDJNM0lu?=
 =?utf-8?B?VHZwcTJuK21kWVNzM2tBd3lUU2cwbmFHVkZFWXczeTFHdGhaeXpIa0hBTVlw?=
 =?utf-8?B?MHVFblBIQUs0SFY2ZXhpYlY4MGlJRHVVcE9pMmIwYTRic1hPaGxQWDNTYzNU?=
 =?utf-8?B?K1RYeFlzK0ExMlJUb2FkT3RxVVdBRHBGZVc4V28wbWt4VDg4TEU2NFZ5ckhE?=
 =?utf-8?B?UjBBbWY5TnVCbXpvNzVZeTg4QjYyZXA3c1g2Z1pCeXRhVzRoOGVhVzJnVTlV?=
 =?utf-8?B?UnpCZlhaZTB0YWVoWEpSWi8xMDlvemJRZ0FtaDdVa01ZMFZHdEkwLzcyQTZI?=
 =?utf-8?B?dXREUEsxYmZIazFSNG9MNVpiWmxFTGczVE41Yk43eWhNM3QvRGtEZVVzaE9q?=
 =?utf-8?B?Y2JmbXZIVE9FZ0N5MHkvdmVuUis2Ri95SU1VY21VUnN1NENpeVdlUGdPaklR?=
 =?utf-8?B?WjVCcm5EcWlzT2F1dXNUTGl1dm53dnZGbTEzaHJkQ0dOT2tNb29iU0dlMWtQ?=
 =?utf-8?B?azR1NkhKTkRIVDNFV1VDcFRpSjIwb25kT2Y5QzdTSTQydEdraE9Icnp2QVk0?=
 =?utf-8?B?SStaM2NYK0E5a1Y0WFNRTkpqQjdYTzN3Wmc2TUcwY2JNc25mUStiVU5EaG53?=
 =?utf-8?B?TkM2WStaZ3BXcnlaVmx3N1BFTS9BaDh3cHlHMjlXcjFtNFNNZUNpTUR4YXhs?=
 =?utf-8?B?QjNoRHlNKzUyNUtUMDMyVkhxQnRENWZPRkYwUGtxcnQ5dTBDTXF4Z09haW8r?=
 =?utf-8?Q?9KwZkyKzXGrf6dXcRI6+9JHCI?=
Content-ID: <2E463C303B7F634B8A41DB979E6E09E8@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10963.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5d4c10-8b97-42ce-73a8-08dc65c72377
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 08:01:54.7076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDQD/k7rkMo7lqPotBIsbA5Kdh2jrvh/5WsXNVUi+VeLtCDkRTu754zfAflbX2gakJbI2O/AMi8KiWeaQIleKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10702
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_010212_109101_4FD51E01 
X-CRM114-Status: GOOD (  13.19  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 2024/04/24 11:20, Coiby Xu wrote:
> Fedora is going unify bin and sbin and /usr/sbin directory will become a
> symlink to bin [1]. So make sbindir configurable to support this case.
> 
> [1] https://fedoraproject.org/wiki/Changes/Unify_bin_and_sbin
> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>

Thank you for the patch, but sorry, we will be back on May 7 and then 
start to work on patches etc., so please wait for a while.

Thanks,
Kazu

> ---
>   Makefile | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 55c9c7a..0cd2b03 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -101,6 +101,8 @@ LINK_TEST_PROG="int main() { return 0; }"
>   LIBS := $(LIBS) $(call try-run,\
>   	echo $(LINK_TEST_PROG) | $(CC) -o "$$TMP" -x c - -lebl,-lebl,)
>   
> +sbindir ?= /usr/sbin
> +
>   all: makedumpfile
>   
>   $(OBJ_PART): $(SRC_PART)
> @@ -126,8 +128,8 @@ clean:
>   	rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.8 makedumpfile.conf.5
>   
>   install:
> -	install -m 755 -d ${DESTDIR}/usr/sbin ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8
> -	install -m 755 -t ${DESTDIR}/usr/sbin makedumpfile $(VPATH)makedumpfile-R.pl
> +	install -m 755 -d ${DESTDIR}/${sbindir} ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8
> +	install -m 755 -t ${DESTDIR}/${sbindir} makedumpfile $(VPATH)makedumpfile-R.pl
>   	install -m 644 -t ${DESTDIR}/usr/share/man/man8 makedumpfile.8
>   	install -m 644 -t ${DESTDIR}/usr/share/man/man5 makedumpfile.conf.5
>   	mkdir -p ${DESTDIR}/usr/share/makedumpfile/eppic_scripts
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
