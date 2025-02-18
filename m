Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91DAC021AA
	for <kexec@archiver.kernel.org>; Tue, 18 Feb 2025 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VBD7upQjejspFaxdq4wQLBvQ3D7mMxabe+OYC2ISYvE=; b=vJE0YDOz7I2a6hn36cJ2I9Wdxb
	95mT5xgVDzjSPj/eYUJ+5D05tSfTpk+WfRFCF0eCPSYv1ECPofk4wBRrjzF3GeCJxeHhp9GXovYNa
	zSELQf+X6sc4oqePRcXVjGJRqhxC74BxG3cVsnvtHqoT3Z2j9h0YFt93AGzGOdevcYX3qfaFVEJin
	/rpMWwWTv+UJU/FDuAlDtpEvXAPMj/q784uchMS45yPlcMOt8X7129Ys8cExJUj+GySdjs7KV4UUh
	Ad3V7WcRXfc8rhmqUUP5SM6a0huFnKzvyEWjkMMSI663Bq2FVWcKIP+rJeoqzTCB2M1MHkSeHuGsF
	IKTR469Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkMoo-00000008AfB-4Ail;
	Tue, 18 Feb 2025 12:35:18 +0000
Received: from mail-japanwestazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c406::1] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkMmd-00000008AAJ-08Wf
	for kexec@lists.infradead.org;
	Tue, 18 Feb 2025 12:33:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHqVECkPr7PvA+0r2FKzy33DNKs+QF2Q2g01qT6VgnItZKLoEDUwJtRWJVhS0zp1r7n7EV9BdkeOOVBfpAPFE2bDWyIoK4vwOnydUF9aHZGfXCo6DZR89eE22wReV6m6XnN0RXkeAMlib4NtHKPXvS9ZBIeKCGzTHURO5dpkd4dAzl5z2xQ4Ry/g3NebA6bX7O0BH8bWdqmV6v5PQBBp1T6unutvbnu3gRLmVgsdS4i5cLHX/DQl+F6aDaoWbfWW10HTS5kCDnGTPLg/ah25VaebDKPlChzIaQDEdds+dMbYhUycksUfPpj1Dc2MK62HbeR+LoihYIY5aRTBZAmwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBD7upQjejspFaxdq4wQLBvQ3D7mMxabe+OYC2ISYvE=;
 b=urBprKWab4x9SqLohMuRZsSnk0fvr52EDkonqEp8MJkCIYwxkPRE3AzInbyTUmUNrNiMC9sZ4nSxoULQ2bQL/GJqcfOiYsZKEzIF36THtwOltQdP+KtBzErXKzmvnCs7Rcv5l/jIAXl26bHyjhUCGEX63XxYQx3Q0HAf4MTI149GapxaU7RiAqtc/jDim5eqYo+HaWaEA9Kl+40uR5cItC+ObgZJJ0R9CK3qf000FxWjx01CT767ICJ/djFt25hSEtRpwV3mDzmtEV/a7UVIrKLD/fvcqeFt7x9GCSLQK/hum2WXZN/7BYOHaozMre8tS6Iyy4shhdiTXyMw2pOZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBD7upQjejspFaxdq4wQLBvQ3D7mMxabe+OYC2ISYvE=;
 b=d99Vg5X/4J4sOD4MeHj2KSeGfAI83ZMmFHsUImnapta6JdTrNekaY5McSithzsZ+5Dolj+yxZ02gRWSenWwrorGEAwk3J1yqj4ikLg2lXJH4DCa7j+XL4zEPuEYdcuVss4g+LRj3zNkNKH4FqOIqSjRWTgPKyIiwKL924rIzzDq3T1IhEgK2SFN/wlMsJMVoZCzQ1iiX2SbvD1wUDMrzWsCNP8dWmFkyyQuFPM5bYidkiW0cIom8XZSlPqyfJPZ9J12qwJchXAN+9qGVue9Dq9iRQhLd4YRjXfUc0m/WkHi7JRKKy+HwHSO2BayeuVh0C3toi5s9KRqe3jiwvBBEgw==
Received: from TYWPR01MB10711.jpnprd01.prod.outlook.com
 (2603:1096:400:2a7::12) by TYYPR01MB13498.jpnprd01.prod.outlook.com
 (2603:1096:405:1be::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.21; Tue, 18 Feb
 2025 12:32:42 +0000
Received: from TYWPR01MB10711.jpnprd01.prod.outlook.com
 ([fe80::72c3:f5a0:5472:3ae6]) by TYWPR01MB10711.jpnprd01.prod.outlook.com
 ([fe80::72c3:f5a0:5472:3ae6%3]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:32:42 +0000
From: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<m-yamazaki2@nec.com>
To: Coiby Xu <coxu@redhat.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<m-yamazaki2@nec.com>
Subject: RE: [PATCH] makedumpfile: fix gcc-15 compiling error: too many
 arguments to function eppic_init
Thread-Topic: [PATCH] makedumpfile: fix gcc-15 compiling error: too many
 arguments to function eppic_init
Thread-Index: AQHbfFWUy/IRG1iHVUS9ovvyD/W3BLNNCMKQ
Date: Tue, 18 Feb 2025 12:32:42 +0000
Message-ID: <TYWPR01MB10711AE8C0037FB3FD7D74F6CA2FA2@TYWPR01MB10711.jpnprd01.prod.outlook.com>
References: <20250123094710.212511-1-coxu@redhat.com>
 <zumzzlgu4t235ms6lvwckc24oseb5tg7hx275l74llq2lhkdiz@d3l5cis6f53n>
In-Reply-To: <zumzzlgu4t235ms6lvwckc24oseb5tg7hx275l74llq2lhkdiz@d3l5cis6f53n>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10711:EE_|TYYPR01MB13498:EE_
x-ms-office365-filtering-correlation-id: d10c07ab-a6f5-4545-c6ac-08dd50185710
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|4053099003;
x-microsoft-antispam-message-info: =?utf-8?B?YTFaL2x2RXJ0ZW9wWDVHM1B6S1VsSElkaTFkOUhTYTRyQndhMGVmaHNYOEpn?=
 =?utf-8?B?NGdmR3RDS2pwM1A0T05nME4rcXJod0QyenRZWUlkYVdNK2lrVUZEK3lCQWho?=
 =?utf-8?B?QTQ4ZkYyQ2gyTFpIWlBZTW4yZUMreGJmQkYyYzluZVM4eW9NS29OdGV1Qkxi?=
 =?utf-8?B?N0lPZEticzZxWGVTS0VOcVRremJYQ3VSTlZkWWl2eEQrTkhGZDlGMnNYd1Jk?=
 =?utf-8?B?dVd1TURrV25BNlFNUG1ZWHhrQTEycGZTeEl2aGozY1p6S2NqNlN6Tmg5V1Qy?=
 =?utf-8?B?Tmh2U3ByV3RWR3FLWHQwM3UxaHU3bVVhbDNrbWFST2ZJbFVNcTcwOFJUS0hh?=
 =?utf-8?B?TWhQcHdJblVoUXo0UlNPNG1FN3BsQUdINWZ2ZWZYSDVkWHJma2VUVG82d25Y?=
 =?utf-8?B?YXdVV29IaG5rMnExUkpGUGdLL2owbzY0TFZuaUpTQzY4dGcyNkw4QXQ0TnZo?=
 =?utf-8?B?bHRadGUzTEd0TnJuRG93ZktCSE4vOVBhaXlsVlF6UDk3S2laVTdwd2VWajNS?=
 =?utf-8?B?MEt5VStnVEZEMFFUWnNRSjlHQ2gvWGlmSTVWY0cxQ0xTOEdsaGw2MHBWL3Bs?=
 =?utf-8?B?cXBza3NxR3FaR2RpdFZyRXlydjhSUWR0Q1NrRnFMUy9UcHkrQVEvc24rQXVz?=
 =?utf-8?B?amYrN2EyWFhlQldVd1VuWkZhV0JSS0ZuS2Rhd1ozNjJLaTN5QzVRZ24ydk1j?=
 =?utf-8?B?Rnp3eEFvVUNjdWczcEZZSXVSMUNDdmY3WVVtNUNGWkc5UlNFVFlqOUV6d3g5?=
 =?utf-8?B?UzJjU3RPYkd3QXJkNjkwWi9zdmVRV20rQVJWMi9CRE9tSnNvNW1vTUsycXFN?=
 =?utf-8?B?K1FTOHRVUGdJSXV0ZGY1ZFF4WGdRZnZ1VlpaQnI0Mm45SzJuR2Z3cWgxNklK?=
 =?utf-8?B?VVMzdTZTNERXdXJYN2xtN2VjMkdvVFpPM1VRR2J2TzJmTWE4UXNlZ3hYQkNJ?=
 =?utf-8?B?NU1jaEZuVGFxZGlzSlovbGpGNXU4ZTROUmhNM1BpQStWNGFRNUtsQjE0NVBE?=
 =?utf-8?B?L2Zsa0xxOUsrYVlKWlNyS3dvcFU4d0lTWTYwWnp0Y2RvZ0UwczdCcGlkZ1d4?=
 =?utf-8?B?cStNcVFtazhkRUxxWmNBZUlwUmxkWjNPdVQ3citiQUdLNHIvdW5vb1hXRVRn?=
 =?utf-8?B?UWVsUHMyY3FvTkhtU2kyUlVhMEUzdmJiQnNqYVdsd1RYc2VJTEFRZGw5cHFw?=
 =?utf-8?B?RjBnNlVDU3FRUUh6NFVnQi9kM0dUN2ZBU2t3cmkvQ0lvUzhnUXZHcFV0Z1dX?=
 =?utf-8?B?L3NXMWxWemV4R004UTVmVHFNbGh4UjkzcHZLQVRyVWxZZ3NCcFVRb0RMeXU2?=
 =?utf-8?B?Mk1wb0t3bUwreG52K3g1dEZZTXo2d29sWW4vdldERjZiUzEyU201aXNVa21N?=
 =?utf-8?B?amk2YkIwMGZRZmJUZkZyb1h0WERvMk9lRE1Tank2bFA1dDZsM1BaKzVSbmRM?=
 =?utf-8?B?c2xwZWhCczN3WmhsQVB6U2VCb3VlTHFXdWVSQThpUHRiOFFpanFvTitYNmdr?=
 =?utf-8?B?NUwrNS9ZQjRvVGZoanpaTGpuUVlIYTJZcGRPdHlWRDlYdW1HS1luZHM0YmM4?=
 =?utf-8?B?eVFJUEM1M2FOZFNVdUdnM2E0b2NTNmFERTk0M1hWS0lGdkltZ3NudWFuZ2lz?=
 =?utf-8?B?NEN4QVNkVjlGUXQ4Um1IMDJUc0haeGt5TmpTT3hiSVI3QnV0aUY3VU9DZ3NR?=
 =?utf-8?B?K2h6OGlqSFBFSSt0STFxWFFqZHQrUkJzeDBhQUREZTJzVUsrcFlSTFRXR2l2?=
 =?utf-8?B?MXJUVmlld1VEMldzR1pqcGVvcDN3MUtDZXd1RFJGV3gxQTlwRUYrZjVXWkly?=
 =?utf-8?B?NHZDNWlKZWNOeTFSYlR4aXk0cVR3R202T1B4aXFGT1BnZkd6RCtWUlBYTnJE?=
 =?utf-8?B?NWNDNm1RY2xSTXdKL2owS0JrcENnV3JKZVBkNEF2YUlGZVZCUW5xMzFtaGpZ?=
 =?utf-8?Q?Ja4co9Ktlh968rm6ud5ZGJ7k3YaO7zbH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10711.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3Uyanl2MlVXRG4yQ2hldFZlNkxrTHNEcFU3SU4wbHV4ZlFaeDBFVk93cXk1?=
 =?utf-8?B?bmJlYlVyT3lMUDNrVzRzZVVIbEtqZnQ1U0syb3M4ZXluM3BBL3RtdlhSeVhp?=
 =?utf-8?B?NzFtemlFNkVuVUlZSTdKQ24zUmNWbi9UaktpMjVFV3VzT1BNd0lDOFcxZith?=
 =?utf-8?B?b0MzbnNvV011dktEVlFRNlFpVWpkOVBpK2hoRDR4TGwzeWZqUzVNMG9XaGpX?=
 =?utf-8?B?clVFQi93ZzNqcUxCdzRuSzE2STJKdGw1M0lpQnZhQ1N0L043ZE53bHpPM3Bj?=
 =?utf-8?B?NVRpUnNOck81WGVKYmRYTkppNmV2dmVaSmdSNkh5T3BvQ3FKWVJkd1MvU2hq?=
 =?utf-8?B?TDRPaVF4ZmVUeVZaWkkyTnpvNHZ1WTV6Unl4VXlQS3Y4bXFVYnl1em5EV05m?=
 =?utf-8?B?SmxYdytFRFZEeDBPZW1rcUVjeXpMTlRXeEZDcVhkenlwQ3JDVjJiRFFKK090?=
 =?utf-8?B?MDZ0VlUzNFVadXlKa0p0TVJZQ2pzd3Ryc2o0cUR4SXB6bUlFaGVkck40Um1w?=
 =?utf-8?B?ZFdsZ2VSQS9ScGtoT05sNnc0amo2UDNLWkhjY1F1YU96NnRGNkE1Qk9aY0Ir?=
 =?utf-8?B?QTBKd1V1dmdFUW9DTStJZi9Ka1h5SDNPWDBWaEM2OWNwQ3o0aEp5aWJCWmww?=
 =?utf-8?B?S2JjOHVYa0o0Z0lPVjJqRHllc1F4QWVPZzc3NTRwVlM5T0o2THpOTmk0dytH?=
 =?utf-8?B?U21oRG9ETncraEpXb1ZzOTBoUGpGTHFvdDYvRUpRTjJMRlpNQXNZNWplejls?=
 =?utf-8?B?Y202NjQ3VG5FNm9uUUxlUUplZE8zdE55SFhmVHdZOGUrSnBSbEREL3pZOHpv?=
 =?utf-8?B?ZU5uTlhDQkZIMjJUdDVtWUpwMlJkdnhHcDVQQUlIaUV1cjNLODdpNVNWVVRy?=
 =?utf-8?B?TTluYlkwb3drblZhZUZNaUJkQWRLUEJwMXQwN2UwZWRjN0ZXcUR6Y1czdHUv?=
 =?utf-8?B?S2FQZ3FlbEZNenEweXdBMTMzWFRtdTl2ekR2SUlkaUZHY0hlRUd4N2JadWlR?=
 =?utf-8?B?T0xMbUpOaHlpRlFBaHlYZTBUTDNzeFlibjJqMFdrM3dyY251STFSZnkvcHNv?=
 =?utf-8?B?NjhxbDFxY3loV1dld0tZaExPM0xqZk8yUmNRaWRPajQvTWlLUjAwcnBTRGNY?=
 =?utf-8?B?OEtMa1ZSWG9IVnVJRWpVaEs5bU9paTRKWVFIdkhMQlpDSXROZk5ZWXN6cXZt?=
 =?utf-8?B?NFB3OVNvTExia1dBcUVOeG81eURjR0lITWVEYk1JV3Y3ekF1NWl3UjBTSmtR?=
 =?utf-8?B?SDlzZC9PQnluTElnQTlka2JhMC9Sa0FCU0FtRlExQkVQRGU3WWhZRVo5RmNZ?=
 =?utf-8?B?TVAzVHdPQzhSZ3ZTdFhOZWVReFpyZVlRNldlTldQWDlXUUVxQkZCTnI4ODI5?=
 =?utf-8?B?M21sWjJoKzdJWm9HbUY4MC9xbEN1cllXVDJZeDU2Z3hiSzMwZGtOajErQVZa?=
 =?utf-8?B?Sm41amJYaGlQSWQrUFFFRnZQa0pqNm1jWXg5YmYva1NtclNjZlZoWENyTHZz?=
 =?utf-8?B?VXNqclkyeDM3c1UxQnpRSnhOQjNHalNla0lqUkVsSi8yNDNRd0djTEIyRXlI?=
 =?utf-8?B?YnI1QnZZVkRlUkZGdGxxdlg2WCtiaFo1RFVielBrTllsQTFmS3ZFNjF1WGpN?=
 =?utf-8?B?MUtrRExpaFFKNnhLZkRvOVk1VE1nT1hvT3FyTDl2MkUwSzVIcHM0NFBsWThp?=
 =?utf-8?B?cHRVK0pzSHZ3Qkk1MHdyMnR4M1A3elRiY25CQ2JXRktlV21rSGxhMjB0OU1l?=
 =?utf-8?B?N3NVb2dHRWxpWTZ4SXlWd1lkanBqZDQxWW84ejhQaFZqSDlRTVFHMUJFOEV4?=
 =?utf-8?B?WWoyNVhOT0NaTjlneFhEVWZsVWloTDdOdHpWYnNGbFVzekNUa3ozMXhML3pE?=
 =?utf-8?B?S2g5dVJhUkdsSkptQm5BQ2o4Ri8rUWVDOVBmeUdaRlJ5R282eGZuRDNZVGZw?=
 =?utf-8?B?UnFXYVEvS3NDVWZNRlh5ejdENjJlRzJTR1ZhZExneEtPYTlrbVlLeHNVdjdq?=
 =?utf-8?B?cmdYdWlvdFRjZENoZ0d4ZEYvdFNZRzRMbGN0V1RsK0ZRNjIzRWd2cXBIdklQ?=
 =?utf-8?B?a21Tc0lXL2VJbjJpRUdldVNNenhobndodng4N1FSVVJ3ZlRJYkthWWRPbnI3?=
 =?utf-8?Q?13sI=3D?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_004B_01DB824C.A38417B0"
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10711.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10c07ab-a6f5-4545-c6ac-08dd50185710
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 12:32:42.6108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCwt5oplJ7H5ha1+5DEZCICIN40yOvGj+h/rg6/AWTOak0GrzeDOhu62+IMGnvXtS8QnVHirZTF8/nB2WNb1ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13498
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_043303_444854_09F31B4A 
X-CRM114-Status: GOOD (  15.13  )
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

------=_NextPart_000_004B_01DB824C.A38417B0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Coiby,

Oops. I'm so sorry. I will correct any typos found next.

But, Thanks for finding this building error and fixing.=20
When building makekdumpfile against gcc-14, not problem.
However, certainly could not build using gcc-15.=E3=80=80Thanks!

Best regards,
Masa

-----Original Message-----
From: kexec <kexec-bounces@lists.infradead.org> On Behalf Of Coiby Xu
Sent: Tuesday, February 11, 2025 4:18 PM
To: kexec@lists.infradead.org; Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: Re: [PATCH] makedumpfile: fix gcc-15 compiling error: too many =
arguments to function eppic_init

Hi Kazuhito,

In case you miss this patch because I forgot to prefix the email subject
with "makedumpfile".

On Thu, Jan 23, 2025 at 05:47:10PM +0800, Coiby Xu wrote:
>Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2340813
>
>When building makekdumpfile against gcc-15, the following error is
                ^^^^^^^^^^^^^
                makedumpfile
Oh, there is a typo. Please help me fix it if you are going to merge the
patch. Thanks!

>shown,
>
>    erase_info.c: In function =E2=80=98process_eppic_file=E2=80=99:
>    erase_info.c:2226:13: error: too many arguments to function =
=E2=80=98eppic_init=E2=80=99; expected 0, have 1
>     2226 |         if (eppic_init(&eppic_cb)) {
>          |             ^~~~~~~~~~ ~~~~~~~~~
>    make: *** [Makefile:109: erase_info.o] Error 1
>
>Signed-off-by: Coiby Xu <coxu@redhat.com>
>---
> erase_info.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/erase_info.c b/erase_info.c
>index cbe1681..af6bfae 100644
>--- a/erase_info.c
>+++ b/erase_info.c
>@@ -2192,7 +2192,7 @@ process_eppic_file(char *name_config)
> {
> 	void *handle;
> 	void (*eppic_load)(char *), (*eppic_unload)(char *);
>-	int (*eppic_init)();
>+	int (*eppic_init)(struct call_back *);
>
> 	/*
> 	 * Dynamically load the eppic_makedumpfile.so library.
>--=20
>2.48.1
>

--=20
Best regards,
Coiby


------=_NextPart_000_004B_01DB824C.A38417B0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
2EMLNit0jMCyyhcWeni34dwzJBOuPSukPwqQ+P3qzL1rHN6AtvO17vCBMdtYF4kanSwqDsEC74bR
GTq147XI93vlqtsK99j81pFFAeTq2YbvWCkt0HVmE/0hw1jJ5MpciB8yHa1Ur0OdcZqSxgLKLpaK
wlrU5r6mhSuhfYRJc7qjTeVXGIDXHJ8byVTOlQ1micZWtSOEbn4x1jXr/pvS4p6NkItuC7ocs+8j
Kp1Nv1eoXhdZYq744wOz+tbJDri/ea9JrS17lDm1yGbib0rQ970uUgoGT+CyB9o4ckOniFjHjChw
OvwN4Jl7l3nAIWTGgZzVyQzxmgyClRzimCRATlKHFgyYps+81E9rlgXNsW1wWflEyvUyO7yC3wnR
z53FhyjaGLt0Rbf3UorEaG/swkFxz7THcUVOeaFT7m3r4KeQoyWubPJqh5WvJFO86IfgWdM0e1Up
RgOwIzQIsN0w2CjGCQIDAQABo4IBfjCCAXowDgYDVR0PAQH/BAQDAgGGMEwGA1UdJQRFMEMGCCsG
AQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDDAYKKwYBBAGCNwoDBAYJKwYB
BAGCNxUGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFAApNp5ceroPry1QLdugI4UYsKCS
MB8GA1UdIwQYMBaAFK5sBaOTE+Ki5+LXHNbH8H/IZ1OgMHsGCCsGAQUFBwEBBG8wbTAuBggrBgEF
BQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3RyNjA7BggrBgEFBQcwAoYvaHR0
cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1yNi5jcnQwNgYDVR0fBC8wLTAr
oCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXI2LmNybDARBgNVHSAECjAIMAYG
BFUdIAAwDQYJKoZIhvcNAQEMBQADggIBAJGRR2vVogNGaQ0jmPHmCBqkZROGrQpwzZ3Oky7fXiYm
d7zIpVfDN8oG2psGNtQ0w4OcGSG9lydsdRK26vb+e3W0/d57wrI2FjHO/gOQjQ1tX3ckKFeKl+xq
ftiN18STm8jYWr7ClsYAvLJYGB/Lv1giBthYBMHXny28SHlQ7ySkamNj3nG/7TvRfcVi4bJ5nIi9
qjbqY3zvYW7FHFiE0vAYcjLfw30BJrVDcFM0pKsetmeBp2h8eCUblbdMwVHXUk4Q4BQeFSCltVW+
AJiAYDp1JfTLnPuTetdXKMU6zsoFJet0k8pp2mXi+pimEfv4/jSfMFFzEkeu/kV5eVOtv52uPJc2
NlIKbN+Q64Ko+ykG4nu9pvT/2h40RGCfPpIsKMspwNdsxspxFeA2EUGXM3g5QGqJ5IFeTzTDY3PH
XYq82PvnxZq/E6xchtfRnHCjWHe7DvkAja/yrAVZc1yU7ypbZVeirqSKFal6K68OYV9IDBEvHDAi
OBS7Mb1JpD6k6ia5oLtBMpYwjSEvRviYQ+r0aw89CrVSbCRxgUn9ngj3cNm4pxeYoya4A1NLrDHA
gTDxDkxDrL19snEYQ6A6BgvhAio1QtvkJg+e3Yt6IiISeHxS6Hy1rCpKOdHSHsG/mriaCjcvVn1B
C57FSe1YP3q3ijSrWNdYvKumA/tlye4LMIIGsTCCBJmgAwIBAgIMT9cU/k8Xmprq4m5rMA0GCSqG
SIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYD
VQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzMB4XDTI0MDkxMDA0NTIwMloXDTI1
MDkxMTA0NTIwMlowgdMxCzAJBgNVBAYTAkpQMRkwFwYDVQQMExBORUMgR3JvdXAgTWVtYmVyMQ4w
DAYDVQQIEwVUb2t5bzEPMA0GA1UEBxMGTWluYXRvMRwwGgYDVQRhExNWQVRKUC03MDEwNDAxMDIy
OTE2MRgwFgYDVQQKEw9ORUMgQ29ycG9yYXRpb24xLDAqBgNVBAMTI0NDLTI0MzYyUDMzRkQxMCwg
WUFNQVpBS0kgTUFTQU1JVFNVMSIwIAYJKoZIhvcNAQkBFhNtLXlhbWF6YWtpMkBuZWMuY29tMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq0qO4iCizOyjc+YbUa3oRrqTAhDblri1L5LW
w+FqJSeuWrrX+Yl56dx+LcM07+VjDqbwxCAtKLPSqtUYvit7f9EWBoa6Fu70B62o7EV5vFQU881T
1smCT3v7VtHpyxO/dcBRsJ7rwK9o3Pg2OK9jXDjZgJpKMOLtcHLAI/XJ0lvhBWPRiA98Z/uQ309r
x1kSObeJLPnpPBYPckPFAqyulMAX0rmUnRdwYrGznICq4JYVK1ywgWmFwyaAUdiabQ1OdJ8++di8
OWE+D9OCuIkM7m+gWzusbT7OEoK5P/H61GpqWM8fUPpnnHN0z3nij64OD7cULhxwcxv7UdonrkTm
jQIDAQABo4ICAzCCAf8wDgYDVR0PAQH/BAQDAgWgMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEF
BQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2Ey
MDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNt
aW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDATALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoD
AjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJ
BgNVHRMEAjAAMEEGA1UdHwQ6MDgwNqA0oDKGMGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3Nn
Y2NyNnNtaW1lY2EyMDIzLmNybDBDBgNVHREEPDA6gRNtLXlhbWF6YWtpMkBuZWMuY29toCMGCisG
AQQBgjcUAgOgFQwTbS15YW1hemFraTJAbmVjLmNvbTAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFO6/yp7PSm8j
kUQOpCOx5BlOCaBkMA0GCSqGSIb3DQEBCwUAA4ICAQB/k6c3mepAwslz3HrKrVWOOO36T5eTW0yb
aPKSDe/k38Gr7FXCgtrSvpQ5RZQ4VSxw3Ty/ZCnJugadcaemgDBRgMLFiBfB2TVqVbundoszPhSw
Fe+frFg35nqvfiaJvccHBFnNhsq+PEz2LbO8whQpybnU4roxvCo+3syHIbIcDOjIdUje0t/S1bfY
OD1pJEnXN4YBYlLSz5WdDOoO6M7GzWXbgjV4Yw7msRnkJhglyJibs0OkB1TlXQ+2POW/TmdE/Mti
SyvmeyagQ7BJAicwE0Qtv/gcEnSYqALPiL0bFNB9WUy+TOtQs3F9h4JIhfTSD1ZsDhu62RlV8+BC
+/DKoJn6GI9CWlO2GAcV/iz3x3IehdRWWcv/A9gFy+frcXgKz6P0YUh3TYjnIpEcYgikYEQejtfF
pA1uU+sLVymtTo9oh5SJLyTMyyf7JoiM4/H7fbkrm05mV2Efk38WQoyXOzpvFMqOBGDMkjNLzxaV
EO/vki2WRPouHcYFX/Ye85WUNut7XNNAEgH7zzVMZbZnEC5MQfdrN5qB9B3Yyl3WOq5u8mTYnaRm
lSa13cXMjVfHQgfT9B4XvKgN/DRGCH3dTNSLebqz/eAJASRe9xPAnOEaFBDGxZev7pc8JegahRv/
oVnniZtUAbq5EefydRujfLp+WdysOf1ZfzZsF2/f4DGCA2gwggNkAgEBMGIwUjELMAkGA1UEBhMC
QkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2
IFNNSU1FIENBIDIwMjMCDE/XFP5PF5qa6uJuazAJBgUrDgMCGgUAoIIB2zAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTAyMTgxMjMyNDFaMCMGCSqGSIb3DQEJBDEW
BBR/g1PUQjEJ+0VD1ZNNlLva1LGCyDBxBgkrBgEEAYI3EAQxZDBiMFIxCzAJBgNVBAYTAkJFMRkw
FwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlN
RSBDQSAyMDIzAgxP1xT+TxeamuribmswcwYLKoZIhvcNAQkQAgsxZKBiMFIxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBT
TUlNRSBDQSAyMDIzAgxP1xT+TxeamuribmswgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAw
DQYIKoZIhvcNAwICAUAwBwYFKw4DAhowCwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgB
ZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAWirfw4aKMpGtK5Hd+v8z0CN0ZyPAw50abA0vMp+n+RXq
ACsskfdxr7BVBwA7n8AV7jZpHKfkpbhok4CezGNJaMd74r41bxC6uJgb50ejO5IZfhAiVGltVFkY
sXpeXGY8tldAZZ3Irwo8CPKU8BsdmXWoC3UvzA0q2AzoKGucqE+c1FixeWk3UHgSvZZDbdTXj516
RRNDhzTJ5SbjJT78Bo1JhoYbqeh+qXnUf/+cLGiwcbkxEMEw+bg3TPvKP4Z6dREntO7jE47yeaDy
XX/CP115t/dQc8iZ1BsqF7IBkqSQCQSiCpt/Fvq/z1ty8sNBJvG9biZalDyCfYT+o7lN1gAAAAAA
AA==

------=_NextPart_000_004B_01DB824C.A38417B0--

