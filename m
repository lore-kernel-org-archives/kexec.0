Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D799CAC581
	for <kexec@archiver.kernel.org>; Mon,  8 Sep 2025 12:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ik/27fBOO3wzflLqkjCT9xJgZN6IlCxXs/NRmZw1pPU=; b=HMpz4mrPoiC1zrgVR3TeCrgvom
	JqIPuS44ZMWBDixfdV3cT0KtB0QBulhX19wpdP7oPHwKzViaOaoFRGXBabhNEjHUqZWKaSAOpEn2D
	ZTeIyKzay148n803QGQPFlXQoeG34nW7qemw/deskaR8WrTapxq7uYFz3x1vChpQAVq20M4dl3NJl
	96a1Xd6NMd7HZ9723J8qCRAS1vFT2PuABEYxrJCiBoFEKPGL/2405mMHaMOlp9LmxsrpW9nJcrGhT
	rh8hAA46Rr3tFEp5m2nNMKIOucdpnd6m2Z0icMKytwxhU81m1RH4gqCxnJDwoKZUgZAzcgW4CAi1F
	SSwJCbqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvad3-0000000GsUW-2cIf;
	Mon, 08 Sep 2025 12:05:49 +0000
Received: from mail-japaneastazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c405::1] helo=TY3P286CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvZmX-0000000GZPQ-3zvq
	for kexec@lists.infradead.org;
	Mon, 08 Sep 2025 11:11:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wa+jm0FcWznxkSP+Gqj3uEdURY2R3pqrugdEOjx97e18dNQWuUTP3mQAYR2lWwNXplWh9NVUF9IXobQtPFUm0e8WsrB5NJN0S5vraa/5koQYjaDotyaQB2uieNV+bfb9uRnxQsn0Vv6d/sjhMxlQ0wHOw9BZt+ooPLJCwjGtDxsejpNwol0CAFo20xsceWLGL86RKWe/iG8pjwHnJf7NfXNJ98g/i5koGuulTR13yiYTgaAZGg3mWRJ9j1zZGi/9JzZK7Vfuj3pJfqso/VTVYkqyHRadyJowY/n2uaLqZ3USWG/zd2Zp5cNb/c3uomlYZ77GQxBcheyK2n87VYnt+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik/27fBOO3wzflLqkjCT9xJgZN6IlCxXs/NRmZw1pPU=;
 b=pACi3VUo3D+LCPUM7+jP180VRCuoy+YxcUCh4tLkaMLTGsqnCjTHCdzx3LzZavz9YiwFtZmsFitZNZSbyQK5aobb1Y19RcbhNUobMcZPqzXSJWy167/2nbhx19RhHqaM6b0kV5Ir6xwJSDHXop22s88tg4yb58uhQD4r327+l2Zh6aTeMd/KThsS8ENstagXq7uKRtXr8RNBFoEanYpw+/Rk2wWKhvj2f4Ot7Jm+bs0uQkGsrc9velqk8zp2AakBppBiI2dJD3+JXJReiGL3UJo+rliYyqX6nwNa+Oy8VIl48Dvvci7wnfytwMkG2fHZ2z+0ZmULBUuxIsb6pkimUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik/27fBOO3wzflLqkjCT9xJgZN6IlCxXs/NRmZw1pPU=;
 b=Nb25f3VIwAYbaYAvCFMNz3HhDkpxf8wgPttqHWWLz16/jIBfwllcxSsBolkl5MztcZ/jOpCJcvUrR5b9S0lks5C19WBT4S0f36fKvd0TPkgcTM41nZTzKb8wErLqe3JfaL0X9rfHBzOF/rnsRSOSO0/sHPxdT4C1/tdTCEiMA+uWisUfrWY4QU3BEwHBn2hUeQFAa86++MzGgDuEdWT5DhGbq3EWw+yTTYgjQ2eKlj0pjV6qMEAWekmtDnkZwzOObKPOcdOoZjurH8aSL8RspOEz7NksJYn2XcTxuCoBucnCHc+nVRE2qJJ2TnEKB/RaZntxj5Sy43S7z6aSevt5Kw==
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 (2603:1096:400:40d::13) by OSZPR01MB6552.jpnprd01.prod.outlook.com
 (2603:1096:604:fc::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:11:19 +0000
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec]) by TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec%6]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:11:19 +0000
From: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
To: Tao Liu <ltao@redhat.com>,
	=?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC: "aravinda@linux.vnet.ibm.com" <aravinda@linux.vnet.ibm.com>,
	"devel@lists.crash-utility.osci.io" <devel@lists.crash-utility.osci.io>
Subject: Re: [PATCH RFC][makedumpfile 01/10] dwarf_info: Support kernel
 address randomization
Thread-Topic: [PATCH RFC][makedumpfile 01/10] dwarf_info: Support kernel
 address randomization
Thread-Index: AQHb2e4xmBBNXJxZ7UiqFa5LEXvngLSJrq4A
Date: Mon, 8 Sep 2025 11:11:19 +0000
Message-ID: <16a049cc-11c1-4e46-84a3-5ff5f0f00c00@nec.com>
References: <20250610095743.18073-1-ltao@redhat.com>
 <20250610095743.18073-2-ltao@redhat.com>
In-Reply-To: <20250610095743.18073-2-ltao@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11475:EE_|OSZPR01MB6552:EE_
x-ms-office365-filtering-correlation-id: 65328dee-7ac1-488a-0c3c-08ddeec8700c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VWtmODdvMUtuYjJxcU5FWTMxV0JYcE1YTy9EUGpMWGQvLzZLd0IwUUFYa3JH?=
 =?utf-8?B?QVZoVklaNnJlYVNMTmZuZUVNc0E2ZjdvUm5uTDdVRG8yRkh3ejFFUjY4eTNG?=
 =?utf-8?B?cHJScDNCTVhIWFpMQ2hYdHJDbHBBRjlkUTBBN05pNm12UWU2ZTBKWGIwOW00?=
 =?utf-8?B?WCtxa0UvUXFLTitsdXJNZjZ0S21xaHpJbmVjYWFrbUF0eGZPN0JYQTJBb1N4?=
 =?utf-8?B?cGRYOHJ3cVdudzBwSlJ1MUNXS29ZV2RtSkxWVVRab3crZk1DR200dVBUWFJz?=
 =?utf-8?B?d1planJlUE9LMCtVekZuK0pkZFJQMi9UTVhhSVhCU2RveDZ6NS9xNUhWKzdl?=
 =?utf-8?B?UzVHdTlLWnNIUkx3Y2U1dzhtZVJHUjVHRlJjY0lyZ3poVDM5c09iM25vM3FW?=
 =?utf-8?B?MkpKR2MrTXpJeFdKV0dyUVZNTUJHblp5UlhjS0c4cEc3MFFxNGQvaFc4bzZj?=
 =?utf-8?B?dTdLZGJRL1BEcmQ2WTJzYVM5WU14Ymk1RW1UbzNnTFZvd2JvekZNYTV3RGpk?=
 =?utf-8?B?TDBqWFBCNTdybFZvWTZ4eDMzMEJxR2NWMHJvdGwwTVRrOTVTeWFtekpOR1Zk?=
 =?utf-8?B?RUZ1aEhuYkdUWVFHcmo0OXZURWRzYnEwbUxzcFJsUEJweU56MXdFY2FjanVx?=
 =?utf-8?B?ZkpoVVM1aDl0UnQyY3Q2Ukdxdm53dVdwUHVieC9ickRkQkxGNWJrV2dmc0lH?=
 =?utf-8?B?NG9ETHRTeW5VYnkwR1p3Z01iRk5LcEZQa2taUFJnTVlodGRReUdIZjZFYXpr?=
 =?utf-8?B?dzFWZ2Q3K0p5TFo0Umkxd05udld4STZYRmpwSmNNRVNteXlNbGw0TWFMaVhl?=
 =?utf-8?B?a0oxOWpobWYxcmJxYlVpelpxNVJOQURLUlFjK0xYaWk1dGxzVHJoNkIrTFpa?=
 =?utf-8?B?N0xjWEZIS2lSUEVnMnZqVGc3VTlLek5TVG54azZwL2s5SExSMWdCaDlPRkJX?=
 =?utf-8?B?VUdCaTMxYnVGVG90MTlUTnVRVFhQbUp1eHpGaHY5Z004dkJob3pJQkRLMm5z?=
 =?utf-8?B?OTBTSHBDa3E2cmpod2Q4Qnd3NFZmWktKTENXKzdOVE1nZVRoUjd1bm10MkE2?=
 =?utf-8?B?eWwySjNlUGhGNitJSDFJS1ppVUpEVGNoNmtWQ2pYUmJPcXNDa0lnb1dOM3M3?=
 =?utf-8?B?K1dUOFF6SXdycW5nd3pqSVlZblYxVXpxWnJXM3NMVSsrdkovQWxFT21rVDNU?=
 =?utf-8?B?NjNHVzRFb1JHN3MyVnQ3NFlaRHVNSjZlVlMzVjJ5ZVNLL2ZBUC9Fa0o3bUR2?=
 =?utf-8?B?VXpWY0V2SDZwL1VrZHR6WHVRNmtOdWRjYUhBY0ZBSHpwTFJnSzVMaGtENTdn?=
 =?utf-8?B?ZkVOdkhRZWgyV0lpVVdTeHJrVnNvdklzc3BVbllGYmtpREtZSUVjV3Joc1Aw?=
 =?utf-8?B?YUpySU1vMFFuaHZrdGFYdC9yeHZsZnRjMlc0bjdTOXFNT3pIOGcrdXo5T3dX?=
 =?utf-8?B?d0Z1S0NmL0VhN1RrbHJwMzlGc01hdHhkbE5BanNXSFFRREVpU3BYRFJONVQw?=
 =?utf-8?B?bEtmTll0VG5XM01QNmhPR3N1VHltUzlWYWdkWTlZdUFuZndwTTRXb1BoT3BI?=
 =?utf-8?B?TGFlV0loQUxLUTVpUGhzeGFLbyt5RzcxaW5tOHQwSmZPMUNUU1ZreWEvaG9n?=
 =?utf-8?B?WXdJMnpMcll5ZlYvcjZ5U2J3NENjS2FteVBQRXp3OGZDUHo4ZEFSSnJtSlRn?=
 =?utf-8?B?Y0xFdlBQZ2Z2ckVJQXBIWitNZnBZdkFzZFZ4M29YdDJPY3ZjYXRZTC9idXJp?=
 =?utf-8?B?aVJVRUlnVThUMlgzcHZUMnNYQ3ducVY4VlRTVElsRy9LS2ZCMU5CR1Y5OEtT?=
 =?utf-8?B?bjNpTmpTZFdhMVpXL2R3YkNsREsvQ3VSaTFOaU9HWUFCck9xVzJiR3JmdVBy?=
 =?utf-8?B?cGcvUXBnaHRwZEZITFk3TVFIMGxkZnlqbGlNajJpOUVxU2hRY2oxS2JoMTVj?=
 =?utf-8?B?cXlsRWpOc25vWnAvRHFFKzRtaXF4K284YkgxV2JTcHN3VlFacUMrYVkvczdY?=
 =?utf-8?B?b3p6a0QrNkhnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11475.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnQzTW9WbUpqTUIxeEFURUx0VnhnbEhSaXRkajBuWElpUzlQSDZoUG43TWwz?=
 =?utf-8?B?aXJmaWM2ZDdweVo1WkdoWFVNaTFXNC96eml6eEVLN1oxbFNKN2pOTUJEaVg3?=
 =?utf-8?B?ODI3QkMrV1pNbjBlUTBZTms1NVdxd2daeFE5TnJrWktmak95Z3VNcis5MXll?=
 =?utf-8?B?bkxEL0hTSmdFVGdLNVcrU0dwTVJwMnFXMVN6THZZbVRsaG9mM3B3c2JtQ2RH?=
 =?utf-8?B?dmJaNy8zSWYrd0wySWYyMncwWWtQdXJxQ1gvVWZ1SDlIdGkxZ3V1ZnBnei8z?=
 =?utf-8?B?Rm9yUGJCek1WdjNHT015dHUwR1N1cHR0cTB5Qk96bjhJYUVqRWZvUzRRdVRt?=
 =?utf-8?B?V1ZTSkNuU3JTTHJVY244THpUMFhLemQ2a3RkckVqR3ZjbmxtZjBEOTZjWjU4?=
 =?utf-8?B?K3JRVlNrakRqSmxCdEVSbE1vMHdTdndlSGgzdjZVWDJvczJFUnBWSmZQNmRT?=
 =?utf-8?B?RDZQdjR6R1VmY0lxY3RmYmxick82cVBuVHAwb0ZwQU9YU0hqKzVnRm01NjJw?=
 =?utf-8?B?UlN4WkxZamd0dU1jLzdpeUw1ek9YVjZyTVZjamZzVWRDbnJJQlljdkIxakVS?=
 =?utf-8?B?VjJNeEFQWDQrcmRYb2FZVGpaQUFCT3FydEsrTGlIa1JSQnRBUitod0pmU1hE?=
 =?utf-8?B?WVVCSnZZNUpJSnRoUWVUNDU3UUJlTXl4MzgzWTIyZWtUbnlQbDhLL2h2K01h?=
 =?utf-8?B?dnRxSlcyaHlRNjdhajVhUWVRSXNUQzR4WnNEVjZBbzJzRVJDS29RZWZ5L2JX?=
 =?utf-8?B?MnViM0g4U1hJNm5XTitIMkplbmdmM21HRllHc01NMUhTeitkaWN2aDJMV2Zj?=
 =?utf-8?B?Z09FVzJ2TnNDSGJpMkplU3U1UGM0Z0Q4ZlQ1ajk3TXQ1SDhCci9rVzZ5d2Ir?=
 =?utf-8?B?MTRNQUs3Q0RoRkVoQjgvRVZibUZ5TjFadzZ3eG9IbHlSci9pNzBEaldYQ3Nw?=
 =?utf-8?B?ano3MDVMdXVVYm1rOCtkcmovSXBzQklEMGJjUk5QSTVaWXRMNnFsYWIxYm44?=
 =?utf-8?B?K0ZVTVFEa1o1MERSUk52Q2RRNTZhOGJNYnpXRGZ0Ni93RnhISlN2MWdlc3FN?=
 =?utf-8?B?QWxHM25oZUN2WTZ6THEvV09yTU90ZUVhai9aVmptR3lDaTZPL0h3VlVuNlRS?=
 =?utf-8?B?ZExWdkNyS1kzbHlzTDlIZDQ0Y3VYV2IvOFF0NVJ0SzR4VkhNRCt2WnBiTWM0?=
 =?utf-8?B?OHliQkVpYzFxSzVidFN3MEtPUmkxQkUzY2lzYUFWWExQSGx3eVJJZnpmcC9q?=
 =?utf-8?B?cDgzQTRYeitpY3BVd3NNektEb2xITEZ4b1kyMzVpMUdic0pueWc4a0ZGc2sw?=
 =?utf-8?B?MzIxSG8rS1poeFFLTnZveDFqWVVJeGJtVDFSQXk4akxST0hkUmZZRmo3YWNi?=
 =?utf-8?B?Q2N2TmY4NXB2YU1WT00ybmtvSnkvRDk5cStKcXgxTzE1em5iMm5kUTRYTDUv?=
 =?utf-8?B?eFF1QnFEQnZKWHZMa2ZlR2ZWTFNjeGNoaWQ5MlZFem1FOFQwdFJCd0lLY3ZU?=
 =?utf-8?B?ZjFNT08yRGVFUm5nUEg5elRkaHRKRTFVUXNjVFVvWEVnOFhGcmlDZjNScHpK?=
 =?utf-8?B?Z0ZFWmp6V21uTklpOS9LUWN2UmpzRHl4Y1VRcEs3NDRrNllkK0V4QjNtNHEx?=
 =?utf-8?B?UWFCeDBjSXRPWlZ1dkRpRnBHU3IvTjQvNUpBM1ZLTlozRkNlTnFXU3hRazRv?=
 =?utf-8?B?M0QwY1JYbGN5TDJPVk1pTHppd3B5SGQvaDVZdGZGc3MzYi9rNTFBekRFbUo3?=
 =?utf-8?B?MWh1dDAvSkUzVjUrYTM3c1lKV3FjYlRlY0lWM1ROQXhGa0NTdytCSnRDU3Bl?=
 =?utf-8?B?ems5WnVtWUNmVWNGQnVYUERVTGg0VVM2N3hPdlBjMHFCWkRLb2pDUVR4ODY5?=
 =?utf-8?B?NnhkU1d1VjY2MmlpaEdMTEEyQm9ucWJUdWpSVWJ1K0pUNUFFdXVIQzJMREJa?=
 =?utf-8?B?QTEwaGJVaEcxcVJncngxSC9NclZ4QmlTZ1VHWVdzb2dqZ3NFUlFvYUNVeGRJ?=
 =?utf-8?B?Wjkra3RaWE5QbTFzVDBNNTQ0ZG0vem13a21NQXNBaWpWbkpKa0ovTU01Y0Vx?=
 =?utf-8?B?N2U4a0RFcjZtSVJRQVMrbkZuUi81WitXOTNvQy9KczRKZHVRdlFjQ1dJS3Rz?=
 =?utf-8?B?dFlQMzIrZ0hRWE4wZzhUYi9GZWxxTEpkQmRNL2J2c25GbmhKRHpGcmhDY1BR?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DF56BE97B409D48B88BCDB5320524D1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11475.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65328dee-7ac1-488a-0c3c-08ddeec8700c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 11:11:19.6826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMIYzQiWnMZvYm9SLJzfaEJw9yx8qcNCGU7ie2030teH6qMwQSgcub5THShBngd14mRiJhCZw/L91kp3tfkjbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6552
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_041134_108510_7D198B76 
X-CRM114-Status: GOOD (  19.36  )
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

SGksTGl1DQoNClRoYW5rcyB5b3VyIHBhdGNoLiBXaGF0IGtpbmQgb2YgZW52aXJvbm1lbnQgZGlk
IHlvdSB0ZXN0DQp0aGlzIEtBU0xSIHByb2JsZW0gPyBFc3BlY2lhbHkgaXMgaXQga2VybmVsIHZl
cnNzaW9uDQo2LjExLjgtMzAwLmZjNDEueDg2XzY0ID8gSGF2ZSB5b3UgY2hlY2tlZCBvdGhlciB2
ZXJzaW9ucz8NCkFkZGl0aW9uYWxseSwgZG8geW91IGtub3cgdGhlIHZlcnNpb24gb2YgZXBwaWMg
Pw0KDQpBbHNvLCBpZiBwb3NzaWJsZSwgc2hvdyB0aGlzIHByb2JsZW0gcmVzdWx0cyB3aGVuIGFu
IGVycm9yIG9jY3Vycw0KYW5kIHRoZSByZXN1bHRzIHdoZW4gaXQgaXMgY29ycmVjdC4gUGxlYXNl
IHRlbGwgbWUuDQoNClNpbmNlcmVseQ0KDQpPbiAyMDI1LzA2LzEwIDE4OjU3LCBUYW8gTGl1IHdy
b3RlOg0KPiBUaGVyZSBpcyBhIGJ1ZyBvZiBub3Qgc3VwcG9ydGluZyByYW5kb21pemVkIGtlcm5l
bCBhZGRyZXNzLCB0aGlzIHBhdGNoIGZpeCBpdC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogVGFvIExp
dSA8bHRhb0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBlcmFzZV9pbmZvLmMgfCA4ICsrKystLS0t
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2VyYXNlX2luZm8uYyBiL2VyYXNlX2luZm8uYw0KPiBpbmRleCBhZjZi
ZmFlLi5iNjdkMWQwIDEwMDY0NA0KPiAtLS0gYS9lcmFzZV9pbmZvLmMNCj4gKysrIGIvZXJhc2Vf
aW5mby5jDQo+IEBAIC0xODgxLDcgKzE4ODEsNyBAQCBnZXRfc3ltYm9sX2FkZHJfYWxsKGNoYXIg
Km5hbWUpIHsNCj4gICAJaWYgKCFzdHJjbXAoZ2V0X2R3YXJmX21vZHVsZV9uYW1lKCksICJ2bWxp
bnV4IikpIHsNCj4gICAJCXN5bWJvbF9hZGRyID0gZ2V0X3N5bWJvbF9hZGRyKG5hbWUpOw0KPiAg
IAkJaWYgKHN5bWJvbF9hZGRyKQ0KPiAtCQkJcmV0dXJuIHN5bWJvbF9hZGRyOw0KPiArCQkJcmV0
dXJuIHN5bWJvbF9hZGRyICsgaW5mby0+a2FzbHJfb2Zmc2V0Ow0KPiAgIA0KPiAgIAkJdm1saW51
eF9zZWFyY2hlZCA9IDE7DQo+ICAgCX0NCj4gQEAgLTE5NDIsOSArMTk0Miw5IEBAIGdldF9zeW1i
b2xfYWRkcl9hbGwoY2hhciAqbmFtZSkgew0KPiAgIAkgKiB0aGlzIGZ1bmN0aW9uIGlzIGNhbGxl
ZCB3aXRoIGRlYnVnaW5mbyBzZXQgdG8gYSBwYXJ0aWN1bGFyDQo+ICAgCSAqIGtlcm5lbCBtb2R1
bGUgYW5kIHdlIGFyZSBsb29raW5nIGZvciBzeW1ib2wgaW4gdm1saW51eA0KPiAgIAkgKi8NCj4g
LQlpZiAoIXZtbGludXhfc2VhcmNoZWQpDQo+IC0JCXJldHVybiBnZXRfc3ltYm9sX2FkZHIobmFt
ZSk7DQo+IC0JZWxzZQ0KPiArCWlmICghdm1saW51eF9zZWFyY2hlZCAmJiAhIShzeW1ib2xfYWRk
ciA9IGdldF9zeW1ib2xfYWRkcihuYW1lKSkpIHsNCj4gKwkJcmV0dXJuIHN5bWJvbF9hZGRyICsg
aW5mby0+a2FzbHJfb2Zmc2V0Ow0KPiArCX0gZWxzZQ0KPiAgIAkJcmV0dXJuIE5PVF9GT1VORF9T
WU1CT0w7DQo+ICAgfQ0KPiAgIA==

