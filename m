Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9CDC8302D
	for <kexec@archiver.kernel.org>; Mon, 30 Jun 2025 10:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d1V0Tl1gJXVPYQJ24ZwfAYEzjZgfe9U5aU7hvA4FNAI=; b=xu3KPP1ZLTDjfu/kPEKtqWgaBq
	sb7hQ40sUEKZAegLJ0nyP5/MUBjRKP/Svkl0Akuz+tUgVjor7FvKaLwlHaEhmF5zaLFfBsuiul8Yg
	wFyKmjeci5ScQGPZFkPwhDKlm9AR2aFPb7227p1SC9Cza5QTDZSIH9+UjPSrrFiKzw5su9EsDqesT
	OZMRd0iYvC9nfc6wryI/8y8F46+AJQ3aKYHCYkYnDqVi3GLsUK9DU1hNeEP1GELu/YdCqdVUo4OC0
	EkHTLJh1ZzXYSIlDeWvOnH9bytzwDwWza2ibv3vTYXQiT6v8tB5tX6dceKPuPHchJDylDEKOWSLRE
	H1vn4OMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWBkz-00000001tB4-0y6D;
	Mon, 30 Jun 2025 10:29:01 +0000
Received: from mail-japaneastazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c405::1] helo=TY3P286CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWBXp-00000001r5I-2cdL
	for kexec@lists.infradead.org;
	Mon, 30 Jun 2025 10:15:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5FXVgIMG2DzTVkiiDfAGXF+m2T4IUCaA2x+yvLY9L/v8VD8f0FAee9ha0xZOs/OnL5H2BTC7uplt+iFGTM7LhG4FYrMSazvywM7TvRLSzkXCJNjVr9GTy+1+Lr8bfvZ6N1ux4IgOWnCarGgGGb03GeNmNNqQ5CizA6X/N4Mp6Hk1JIAUJA84dyj0j23BLgQ4EfJa90dt9FFARNceDNYcArIfx0l1kKHc2w0UUIgAtL3loH5CHBAKPJ39nCbvAFQrg7jEXdxpwHHkNfqpuyPZlG3TWtcwoxHyn4rKHSvMgDN9D3obkYitZ4JHDfCse/NV6YaiNKtcmqY3LJ4EC8hWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1V0Tl1gJXVPYQJ24ZwfAYEzjZgfe9U5aU7hvA4FNAI=;
 b=JjetkwE9xT0lgsBOFfx61uFHpePZjJsnzxChwlPl8SAlWQhb48Nm6xbx/6G5y+W2sD72xiaP96jjPgYe+G3TFYavvu7xwI6NROlHKJKruEXL+O8EvmQUiOx/MKyau401xzXWasE4lhNhzHAnjCMmVDn6mhUjJCaxl3uoDWptDcRYr+dcMvgv9jrZ0xOuvvGpnXPPHqR49ZMfrD1Yu6jBATi9RsCoI9CZ5x8faCF33gCsjuFpLWRAtxIRdhcsJPu9w+pougPRNXz7cqbWSZG6E8XfXcSMoZPWnWzEH6j6s5IW7n/4EsyAU3206hcY/pROL46pRwQbn9nGweccQdx/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1V0Tl1gJXVPYQJ24ZwfAYEzjZgfe9U5aU7hvA4FNAI=;
 b=cB72SzjlFPb/fB+w0Zn/ZEyIvlWT6TOQ9HNZ5Y+uyns7OsMOSfty9+OAzCKtmOwQjpj9rBhpWgEzNTJgJ57d2K4fQU303j90FLBrFD0eMBeIivdz3YTVH4+3LaT0QI1TwfhcmoBPKU6cy97Yr4tlHq2moLUj8CbdBipCyU2I7AgR4sK7UdNCV9/Vz8mDZZJLw8BbVCZ7Xp8xtd1QBnk0Pf3XePpk9/y9Gq3bvxxTwMtuUS+Nd/BUv9a7qbLncucIVVNxOAuQtOKHiNj+SpyQSZRDlZwOr6Jg8wB1B7brLF6CY/MGjwLSMtsb8dBnGt/KoXm6qqv7IADQ+gS1HK9TfQ==
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 (2603:1096:400:40d::13) by OS3PR01MB6360.jpnprd01.prod.outlook.com
 (2603:1096:604:e1::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Mon, 30 Jun
 2025 10:15:00 +0000
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec]) by TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec%4]) with mapi id 15.20.8880.023; Mon, 30 Jun 2025
 10:15:00 +0000
From: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
To: Zhiquan Li <zhiquan1.li@intel.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>,
	=?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Subject: Re: [PATCH makedumpfile] Add confidential VM unaccepted free pages
 support on Linux 6.16 and later
Thread-Topic: [PATCH makedumpfile] Add confidential VM unaccepted free pages
 support on Linux 6.16 and later
Thread-Index: AQHb2PXanXk3+ee6rUm4GDBvQsNqGLQQHNeAgAuAmAA=
Date: Mon, 30 Jun 2025 10:15:00 +0000
Message-ID: <214fcd88-4c5d-4656-8e0f-83e40310eb3d@nec.com>
References: <20250609050244.837619-1-zhiquan1.li@intel.com>
 <b2387999-66c5-4f9f-9052-d85208fc5694@intel.com>
In-Reply-To: <b2387999-66c5-4f9f-9052-d85208fc5694@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11475:EE_|OS3PR01MB6360:EE_
x-ms-office365-filtering-correlation-id: 67f7516a-8e8c-4de8-2674-08ddb7bef8de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MWpFVXpUV1Y2VW9URGpGaFZCdDY5YzRlS0dzN2lXa3lIKy9iSGdxOUxNOE5s?=
 =?utf-8?B?OFBLaWUwc2VtbTg1N3BQc0ttcUdHZkhCd0FJbjJxUy9ZQWRjMURkS0s4UGZq?=
 =?utf-8?B?cWVUNlhLWGdyM3dRYWc5ZVNscHcwUU1kdmhydzlFT3VJRmphSE1ZS2dmK3VI?=
 =?utf-8?B?eWFzRGswaVRIVzVsSHpua2h1QTZqd3RKenRpeUVCdkZvS2JkUWZlUnRCaTRX?=
 =?utf-8?B?NkVUbzVyd21ZQ28veDRhbzNKUXg3eUNrMXRjeGhvdmptZWhZOXgwaEh3REVY?=
 =?utf-8?B?K3FtVktUZDljNDYzNUFFTlRPTzA0RFB5VXV5TzhBcDJCN3ZxSVZSZ28yV3Ba?=
 =?utf-8?B?eHMzYU5tVUxOVFMyTkJxdy9ObHVNSG9taEZ1dWVjMFF0Qjd5VXVkZXdMWGNw?=
 =?utf-8?B?UjBPZjJPaHBUZmZCWkRCT3lYN2VuS1J4RWFnWm5OZXZBTmlzQ0FoanpSdkxs?=
 =?utf-8?B?RUJteTVTaFg0SXgzREZNbE93MXBKa3dzNHRYR2ozdDlOYmlzdk5sOHI4ek5N?=
 =?utf-8?B?WDZoUWkvUzgxd1VERG5XTWhERlREay9pM0lqQ0pGWHRhd0RaZm9sZVcrYmRh?=
 =?utf-8?B?OE52S2VLMlZNcE9jcnhXYlpwTUVlY0piOXQyT2FhQW1GKzg5YzRpbHZCNGo0?=
 =?utf-8?B?TWxGQ29EOSszWm9iS3F6YnB6ZFl5Z1REeTBlWmdxMllTWjZyRjJRT2svY3dU?=
 =?utf-8?B?UUMvQjd1ZU5zZXhLN2lDNWxnZWRVNHQwdkQzbkpsdG1YdXROSUlPUnozTFBn?=
 =?utf-8?B?b3pDckNJNnZWbjh2OXR2N3BjQ2txUE8xN05mazNKbkg0dHNocHRLN2NNSyto?=
 =?utf-8?B?alV4dlBzSDJJTEZMdXRJcVNGbFpsajBhVnFwL2VMZHcrOVBVRDQxdkk3V2pT?=
 =?utf-8?B?d3hOMUNSKzdzUDRXQkxnSkFwc0s0Y3RXY21wREJKSnlnQXczeUwwbkFZbDZE?=
 =?utf-8?B?clBIU09zT1NwbjJZLzFIc0NiQzZWc3p4NGw3ZjAzRjdZNzYyUFcrd3NUVVhC?=
 =?utf-8?B?ZGQxWWJKOGx3K2grYlExRGhHRkpCSXdWb21UNlFoOG1nRzV5SWx0TkZvK291?=
 =?utf-8?B?U3NEc2pLSnRrRHVWekE3MWpZMVJ0NmdhNHkxQVU3bmR2UmwrakdVbFZrbk1T?=
 =?utf-8?B?SlpFR1NYcExFLzl2TFVFQ0U2djVQQmpPVjVlTmljK3NqOXZ1SWNXa00yaUR1?=
 =?utf-8?B?RThrTFJmMlJZQUQwdktGQ1VXWFRoRzRXMDMxZmFLTEZjSlpPQWJoUEJkUGFF?=
 =?utf-8?B?QWlCNjhLTElpbVl3Nk9kWUl3Wmc3SVV1VmZBUWZ0bTZ0Yk80QUYvYSt1dzdV?=
 =?utf-8?B?OEh0ZW5XNFVmdElvdFVnZ0Z6WXJaZEEvMWNHOWRRc3pLV3BzRVBwZ2dwcG1m?=
 =?utf-8?B?Z2pkNmRranlZUXdiaFFvZ3RLWTQ0SzdUU3VGT01WdFNvRllZa1pNNTRqYk9X?=
 =?utf-8?B?K1B4TzNUbkhuSjBVRDRqWDlYWEZLR0dhbXR0R2RzNE96TVV6dE4zMnJ6bitx?=
 =?utf-8?B?dk1uZys0clptNlNiTGI1QWFWL3hRT3FjWjNFRmNOMVVEalcvOTBiRC8yZ0RB?=
 =?utf-8?B?ODV0REg2bWdUakhNc1R3RldSNTM4RVJrVEJTaDM5UFZhL0Ruc2VtTHNXKy9r?=
 =?utf-8?B?S3VoZU5tRkd5OFBnNk1qRnRkSnhCeEg5eEIyMkY2SmdqTWpIbnZFa3Y5Njdq?=
 =?utf-8?B?a0xRa282NzZOeGYyWG1DMytESHJmL3E2Y2gzOXgvSkZ4WTc5Y1pXT2ZNMEtj?=
 =?utf-8?B?MVk4SHI0N2ZQWDFHdEUyR1Fidm9rK0haNi8zUXNYMG1kc2RPMzlVZlNCYXYw?=
 =?utf-8?B?WENDay96NU9vZlo4TURiWGEyWXdjeUlLM1BpMktGd3gxZE1aSS9qM2J6ZTRx?=
 =?utf-8?B?SUpBSXJFc1kxMGVhNTRoclJPbXRXL21QQi90M1gwVVZqMmg0cjRHOHlIc1Jj?=
 =?utf-8?B?aG1xSXJEQ1pQQ0ZicTkrTldmemU5NTExV1NadXZjTUhZU0pBQXNOYVNvcE0v?=
 =?utf-8?B?UzlXODVXenJ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11475.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVJHbHRHVU1wakZGcERFdTE4NHlNNW5pU1FBV01USGpIY0M3VjJLRDdINm5j?=
 =?utf-8?B?elZJZEpYYXJ4cE1iNTNwOGQ5UVBQRjVmYUFFQldIMytDVlZhSDdDWnBnM1o5?=
 =?utf-8?B?YkF2Y1VBb0paUFpabS9YV09oZlFiUlA1b0U2aU9CZzJTcnRqeVN2S0dhUmFs?=
 =?utf-8?B?c0lhZ29WcEZXUVloRXJmT0FyaGdZQzB5Z1h3czRqMlphN2hiT1V0WUdQVkIv?=
 =?utf-8?B?REVJY2xXTmc4MVBLaFZxbzF1RVcyNEU1bzcvZ3FjWDBtdXJSazEwOFk0YW9h?=
 =?utf-8?B?TDNNUnREdllmS0d2R2NFM01XK1lYUVhFZ3VhSVROVmdWeHhRS1dGSUFyTjVD?=
 =?utf-8?B?RU15bXlCMnZiVmp2bHhsbklNa3ZLWndkTHFiY0lIa0dueTQrNTF3R2o5cGgv?=
 =?utf-8?B?UEhTWXFQNGJOajQxRSs0OHdMN3p0clA5ckQ1VEtLVlowYXRmdHpRb2RKUEpH?=
 =?utf-8?B?NnVOUDBwS2dQVktkcWhPSi96L3hiRm5tbGgyVUI3VUdNQ2FYN1l2OE43aUhi?=
 =?utf-8?B?R0pPNkJFYlRhMW1hZUVxK0NhcG0xa2hJVXpFdzhBZWY0V05tcEJMYnhWZVB0?=
 =?utf-8?B?V3ZJWmdEL0gvd0VFaUtuekU5RjRSK3pnODFuTGh3NThiT21kMUg1R2dDckhH?=
 =?utf-8?B?TEZxY09LazMvdzJ5UmNUSzl1NzdXV2U2Y1FYT2Jvb1BkeHBEYnNxOVJWVGYr?=
 =?utf-8?B?bVJQZDAzakxiTHZ5THZFc1AwbFNKc1pUWStsWHFQa2xuNDFudnQzS0NLdDRW?=
 =?utf-8?B?bjFsRDhYTGJOaVFvd3AzMTVNWUFmNDRXRWZqWEdKN0NzMkQ3ZXBGTXVsbVlj?=
 =?utf-8?B?SmxlQkVDYWpKTUtibmc3THRoQTI4UHB0TXM4cGwwL1dlaTF1VXc1UC81RmJx?=
 =?utf-8?B?LzRJb1hRNmdneHJ3ZmJXN0hoQ04rSnRSV2xnRi8rMW90L3ZkK3lNYzVWZ0N1?=
 =?utf-8?B?NkcrTTRVNU1KWEhtcG91TGo4NUdod0JEUlBETTh0a1JYUDhTdHRFY1ZoZEJh?=
 =?utf-8?B?dkFzYU1RSmlvY0FMN1VIS0xCeWtvTnVoZENJdkcxRFRlTkZIRnR5TU45V2h5?=
 =?utf-8?B?U1ZxblNYKzBmUlZNM1JhYVZJZWU2c2xJQzUzTkhRL1BOejRxaEFGTFZBN0lO?=
 =?utf-8?B?MEJSb2U4cEZ3cEtiekNRTmxLc2lXQ2svMkZXZHg1dkVjRTNNdE9oUm9hK2Va?=
 =?utf-8?B?TEUyWGkvWkJjcmozMzhaMmVtVlRWKytUNGw0c0gxZmEzRjZXckYzMm5DYlp1?=
 =?utf-8?B?bDlxVmRkRElNZE1SYjFCODJQV2RyNGxSZ0tMTndTS1hxNVRtVEMxOFFaR3gv?=
 =?utf-8?B?MWMxeCsrelJXVS9ib2hEakowSHI1Qk1BcitDajlid0pzZUk3RktldnBJWUtV?=
 =?utf-8?B?MmZQakgrMFZFWkRESkgxZ2pYTzIvSm15ZzZCOWU5ODE3WStVOTFuREEwN25w?=
 =?utf-8?B?R3JGNlBVaWg5dms1bURMcnNKOVU5SHpUajZTZExvdHNmQXl3UEhVdW8rVW9x?=
 =?utf-8?B?M3F0bGFqdE9TNERxZ2cyU2pQTnE4aEZvR3o2M1kwbFV2cG90bmpWcTlGTkFD?=
 =?utf-8?B?ak5FSlI3bk83aFVub0xXUzZJd0U4YjRwWXA1NzA2eHVqNi84OUdneFZDeGR5?=
 =?utf-8?B?dWxwdWQrczdmTk51U0JZSEJHVnJDdFAwRGNMVDNuZTN6Mi9FYVordndOakd3?=
 =?utf-8?B?TzJYd3Nkbjc3ZUU5aUN2clc4YzcxOHdGQVo3eUF3L1Z4b3M1Vm1uVVordGtt?=
 =?utf-8?B?eGFFT3A1dTNLUWlXZmNDZm9vYVBLc3lxNkIxc0NJOWd4Yk1mVVFaQlhQb2JM?=
 =?utf-8?B?M3BYdm5wV2d4N0N4a2xpQ1J5cmFlSEl1OWtzWm5nQUVybHZXMzdaOE1ZOFFv?=
 =?utf-8?B?bWxDSjNxQlpidDJHcDFOWkZJMUVKeHM1ZU9ZRDBkSzh6K05uQStKTHJGaFFQ?=
 =?utf-8?B?OHNXdjlFT3AvZ1h6OEJ6SjlacGR2cytZTytodUpwdTA5OVJmdFVhZUtPZmFv?=
 =?utf-8?B?UnFyR2l5dXViQ0pKMlJWeEZWbXJ1TElqbVUydnM5ZU5PK0RlYWMrUXhseXhj?=
 =?utf-8?B?eXFtWTc5bm9idmhMdllIanFkLzF0d0thSENHKzlNN3lyVDlyK1RhOGFQcTZh?=
 =?utf-8?B?dndVMUk3dmlQcmtkK29uVStXMmx0Y3pWelRsZFMzWEhsR0Z0czdteDd3MEJV?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CB1A73BB3BD4649B3A194F9E6E9DEFB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11475.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f7516a-8e8c-4de8-2674-08ddb7bef8de
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 10:15:00.3170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4l0fL1SlkNaW7e3UGrMLPycGKhlgbUo0bz0fvyUOG6F4+3wj7PF9i1ZEWqToYX3nzESI51FoEySwuhOnoREkeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6360
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_031525_935439_13B5A8CF 
X-CRM114-Status: GOOD (  14.35  )
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

Pj4gVUVGSSBTcGVjaWZpY2F0aW9uIHZlcnNpb24gMi45IGludHJvZHVjZXMgdGhlIGNvbmNlcHQg
b2YgbWVtb3J5DQo+PiBhY2NlcHRhbmNlOiBzb21lIFZpcnR1YWwgTWFjaGluZSBwbGF0Zm9ybXMs
IHN1Y2ggYXMgSW50ZWwgVERYIG9yIEFNRA0KPj4gU0VWLVNOUCwgcmVxdWlyaW5nIG1lbW9yeSB0
byBiZSBhY2NlcHRlZCBiZWZvcmUgaXQgY2FuIGJlIHVzZWQgYnkgdGhlDQo+PiBndWVzdC4gIEFj
Y2VwdGluZyBoYXBwZW5zIHZpYSBhIHByb3RvY29sIHNwZWNpZmljIGZvciB0aGUgVmlydHVhbA0K
Pj4gTWFjaGluZSBwbGF0Zm9ybVsxXS4NCj4+DQo+PiBCZWZvcmUgdW5hY2NlcHRlZCBtZW1vcnkg
aXMgYWNjZXB0ZWQgYnkgZ3Vlc3QsIGFueSBhY2Nlc3MgZnJvbSBndWVzdA0KPj4gd2lsbCByZXN1
bHQgaW4gdGhlIGd1ZXN0IGZhaWxlZCwgYXMgd2VsbCBhcyB0aGUga2V4ZWMnZWQga2VybmVsLiAg
U28sDQo+PiB0aGUga2V4ZWMnZWQga2VybmVsIHdpbGwgc2tpcCB0aGVzZSBwYWdlcyBhbmQgZmls
bCBpbiB6ZXJvIGRhdGEgZm9yIHRoZQ0KPj4gcmVhZGVyIG9mIHZtY29yZS4NCj4+DQo+PiBIb3dl
dmVyLCBpdCBpbnRyb2R1Y2VzIGEgcHJvYmxlbS4gIFdoZW4gZXhjbHVkZSBhIHBhZ2UgZmlsbGVk
IHdpdGggemVybywNCj4+IGEgcGRfemVybywgd2hpY2ggc2l6ZW9mKHBhZ2VfZGVzY190KSBpcyAy
NCBieXRlcywgd2lsbCBiZSB3cml0dGVuIGludG8NCj4+IGNkX2hlYWRlciBhbmQgdGhpcyBwYXJ0
IGlzIG5vdCBjb21wcmVzc2VkIGJ5IGRlc2lnbi4gIEFzIHRoZSB1bmFjY2VwdGVkDQo+PiBwYWdl
cyBhcmUgZXhwb3J0ZWQgYXMgemVybyBwYWdlcywgd2hpY2ggbWVhbnMgfjEvMTcwIG9mIHRoZSBj
YXBhY2l0eSBvZg0KPj4gdW5hY2NlcHRlZCBtZW1vcnkgd2lsbCBiZSBhZGRlZCBpbnRvIHZtY29y
ZSBhZGRpdGlvbmFsbHkuICBJbiBmYWN0LCB0aGV5DQo+PiBzaG91bGQgYmUgY29uc2lkZXJlZCBh
cyBmcmVlIHBhZ2VzIGFuZCBtb3N0IG9mIHRoZSB0aW1lIHNob3VsZCBiZQ0KPj4gZXhjbHVkZWQu
DQo+Pg0KPj4gVW5hY2NlcHRlZCBtZW1vcnkgaXMgdW51c2FibGUgZnJlZSBtZW1vcnksIHNvIHRo
ZXkgYXJlIG5vdCBtYW5hZ2VkIGJ5DQo+PiBidWRkeSwgaW5zdGVhZCwgdGhleSBhcmUgYWRkZWQg
dG8gYSBuZXcgbGlzdCB6b25lLnVuYWNjZXB0ZWRfcGFnZXMgb25seQ0KPj4gd2hlbiB0aGUgb3Jk
ZXIgaXMgTUFYX1BBR0VfT1JERVIgZWFjaCB0aW1lIGNvbnZlbnRpb25hbGx5LiAgVGhlIG5ldw0K
Pj4gcGFnZSB0eXBlLCBQR1RZX3VuYWNjZXB0ZWQgY2FuIGJlIHVzZWQgdG8gaWRlbnRpZnkgd2hl
dGhlciBhIHBhZ2UgaXMNCj4+IHVuYWNjZXB0ZWRbMl0uICBUaGVyZWZvcmUsIGFkZCBmb2xsb3dp
bmcgY2hhbmdlcyB0byBleGNsdWRlIHRoZW0gbGlrZQ0KPj4gZnJlZSBwYWdlczoNCj4+DQo+PiAx
LiBBZGQgTlVNQkVSKFBBR0VfVU5BQ0NFUFRFRF9NQVBDT1VOVF9WQUxVRSkgdG8gaWRlbnRpZnkg
YSBwYWdlIGlzDQo+PiAgICAgdW5hY2NlcHRlZCwgYSBrZXJuZWwgcGF0Y2hbM10gdG8gZXhwb3J0
IHRoZSB2YWx1ZSBvZiBwYWdlIHR5cGUNCj4+ICAgICBQQUdFX1VOQUNDRVBURURfTUFQQ09VTlRf
VkFMVUUgc2luY2Uga2VybmVsIDYuMTYuDQo+Pg0KPj4gMi4gQWRkIGEgY29uZGl0aW9uIHRvIGV4
Y2x1ZGUgdGhlc2UgdW5hY2NlcHRlZCBmcmVlIHBhZ2VzLg0KPj4NCj4+IER1bXBpbmcgaG9zdCBr
ZXJuZWwgd2lsbCBub3QgYmUgaW1wYWN0ZWQgYnkgdGhlIG1vZGlmaWNhdGlvbiwgYmVjYXVzZSBp
dA0KPj4gY2Fubm90IGVuYWJsZSBDT05GSUdfVU5BQ0NFUFRFRF9NRU1PUlksIHNvIHRoZSBwYWdl
IHR5cGUNCj4+IFBBR0VfVU5BQ0NFUFRFRF9NQVBDT1VOVF9WQUxVRSBjYW5ub3QgYmUgZm91bmQg
aW4gdm1jb3JlaW5mbyBhbmQgc2tpcA0KPj4gdGhlIHN0ZXAuDQo+Pg0KPj4gSGVyZSBpcyBhIHZt
Y29yZSBzaXplIHN0YXRpc3RpYyBvZiBhIGZyZXNobHkgYm9vdGVkIFREIFZNIHdpdGggZGlmZmVy
ZW50DQo+PiBtZW1vcnkgc2l6ZXM6DQo+Pg0KPj4gICAgVk0ubWVtIHwgQmVmb3JlICBBZnRlcg0K
Pj4gICAgLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tDQo+PiAgICA1MTJHICAgfCB+NC45RyAgIH4y
LjBHDQo+PiAgICAyNTZHICAgfCB+Mi4wRyAgIH4xLjFHDQo+IEtpbmRseSBwaW5nLg0KDQpJIGFw
b2xvZ2l6ZSBmb3Iga2VlcGluZyB5b3Ugd2FpdGluZy4NClRoaXMgcGF0Y2ggbG9vayBsaWtlcyBy
aWdodCB0byBtZSwgc286IEFjay4NCg0KVGhhbmtzLE1hc2ENCg==

