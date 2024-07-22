Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82754C3DA5D
	for <kexec@archiver.kernel.org>; Mon, 22 Jul 2024 06:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0o2t45eBGY+a3VsiGEz2QvOj30/ZCps4OuYpoDLohE0=; b=llIvsQqDcd5lIE
	jDtbeHFe/5RFQ8NHlE65XvgHpYh3aOAMGDAa8Ieb4fBBFjhi9h8d26gomai7HURAXFOTxJFOa2I98
	f//maX77qDTdabhLHFdliG0sjdiHnhTWRlxs8SVyWewW5nJVA+iNHoogYspk13RZz0JKggxMOs78W
	RfeB61TSRiA39ZY3bx1VwgfwVJFIyLLix4NCzIa5Zcd8Vr/g2cXRFw7sFnpXaZZ0D378eOJ7o7tym
	AY89Z3c9hNNVDnelc3wMCRH4PT5yWAULNGbbHmlz68MPnsWraLuAMFPcZHQzZ8Ddwm+lu+jQup9Sx
	oBml2Mw23cjiSpG6jsfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVmoc-00000008YgU-0jow;
	Mon, 22 Jul 2024 06:46:34 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVmoY-00000008Ydq-0I89
	for kexec@lists.infradead.org;
	Mon, 22 Jul 2024 06:46:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2wCtTbdyGGsGujrUElJKTc/mxsCgzhWTzulH62aUSQkHj+1gGNqB+goGCaHIOyJe1FosLmwBpVhPxoCv9DQyeaZdnPSs6jH6NhA56RhtfX3Pb8GVwplWfJgZCtNbOYNUrlQDmRJ6p43AHTkEKITv7CNW0P49rF5hTUMGpo1UTaqJomyt1WSgKa6K9lC/s43o3r3qswLvASoSS6XwNlM0JO6gxsSs5CmiVLiQJbe+WIv8cbTn6ubFqZ2M3r7yTZrEHaYIcLOpsnhJTC5BgdFnpqOa1i9BRRF0pCkGIGfjJ1pQKrHbZm2e3fJvtGSixYN175h635u/ZWb/S6mAb9l3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/FdAyrheMEIhSuHZljolQNODn/GcUPoYpfbB07M+yk=;
 b=ncmrso1RuSj96OLV6ad3AGeyIFgWuGYjeoGqOJC4cS4Zz4dec9FO5Vb4ghE6/jjCvP6QLFXcKosergTv+06Lf0m0LZ2JJHT79UW+vninf5ihErOszqad7ITdykAr8m03FOQksdJjG2lEDrqzii+fkZE68ZkPnYX4wNZQ42/1H9JVTmejrGMkivW0NiGJGaF1JTWhl3cQ20Uerm4ecdWHkeovgfT1gtiAyTGv2npj354qWkX8gYinJon54nIj5E0GSu02h4Khl3uL7aPMsDf3+mxWR9+IkUXQBx5lDNyFlegGLLsgX0JPMtiCS/6rdsRJD2kNSqefoKZuOCZnWMwQoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/FdAyrheMEIhSuHZljolQNODn/GcUPoYpfbB07M+yk=;
 b=d7es554sbN/arciYR5+FQdB0vmpy2ZZJF+L3Nqzo7jr7TchFaf9YLAAFqy8RZgncxl0AdZEnioyNQJvW85+c+r1CSHfOirYl5M0FGMfMPbgPksvA/vhJxR+buQpKGuc+sx6XMfkQ84JYihCL7anwKMU50xAKDqhBTdOc3cPCsegkZQjS4JwXGKV063VWhj+Qb1ZYVTyKj508zz4bpZVGE8ln/iAwRnryjmiNtLKkVti/SWi+P54jhqyt1/k4tlmUBKPbVnHpdn+fJUDUPh5xQ7zuEHUZIIm5W/hbwCx53KVj+k4KCOKVnC1qvJIRTTuvIOEH2kmDJrO+cJA04IIahQ==
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 (2603:1096:400:3a5::14) by OS3PR01MB6901.jpnprd01.prod.outlook.com
 (2603:1096:604:114::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 06:46:09 +0000
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c]) by TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c%4]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 06:46:09 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Lichen Liu <lichliu@redhat.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] makedumpfile: call initial before use cache
Thread-Topic: [PATCH] makedumpfile: call initial before use cache
Thread-Index: AQHaxqMQwxsleF2YyU2gDtYfxt0hF7H6rMAAgAS1oYCAAxXigA==
Date: Mon, 22 Jul 2024 06:46:09 +0000
Message-ID: <072f683a-e16d-45a7-9f4c-b59e75a8d05e@nec.com>
References: <20240625015712.3266086-1-lichliu@redhat.com>
 <bcdaf3b8-599d-4af1-af92-188e4072d143@nec.com>
 <CAPmSd0Pd3afnTZGog3pXEY_mh093WDW27HJLUGN2QYDwk8RHyQ@mail.gmail.com>
In-Reply-To: <CAPmSd0Pd3afnTZGog3pXEY_mh093WDW27HJLUGN2QYDwk8RHyQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10963:EE_|OS3PR01MB6901:EE_
x-ms-office365-filtering-correlation-id: 40e51fb1-32e4-485a-874c-08dcaa19f81f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aTdyWitmZzhaREpQZXFSNlE1OGgrTkpXV3dsR2ZZbjlCN080YysxUjhOREJj?=
 =?utf-8?B?Sm92Z25oSEVuVU53dkUwYmF5eFdjQUo3aGlyRGRTVWF6ck1SRHFSZFNrUmlP?=
 =?utf-8?B?VTJzRnJySTFRWnJQaEJmUmhnUWpSOWZsc2pJVTMvVTVVMW5sK1h2S1k1UUpB?=
 =?utf-8?B?OU1GeXRTUWVSZ1k4QXBvd0F0OGJ1aUFGNFVKZ0FMRWo4SHhteHdBc0F6TlMz?=
 =?utf-8?B?MEN3VW9PZy9BbEVydG9sbHBJbFpxTVFHZVJoclhPMGtGbzJYbVR3dEtweE9Y?=
 =?utf-8?B?ckR1NDBxNlQxakhRTmRxa09PaCthb0krT0R2dmVROUNCRkphM1JCemVyZUht?=
 =?utf-8?B?N0NWOUt3Y0lLa0ZQcms3K0NVOEFTemUvTng1b3MwRjJ2WHpBN2RvZTF2THdz?=
 =?utf-8?B?NndFaTRyVUE1TlJtTjhaZlBZYjdHWkZ0QmwxanB6dUJTbjludUZlaWxhUDVj?=
 =?utf-8?B?aGdjOHV5ZFlJR05VQzlJL3FWWVlFSFMxZmw4Vk05ODZDcG1oUDJHMkZ0TTBQ?=
 =?utf-8?B?cmFIM2lSSTRpNzk0dWpoYzk5cjFEWlEzeFJkTTVIRXZPb3Z0V0VFS0tqSkho?=
 =?utf-8?B?TFFCWEgydTljb3ZTWFI5cVk5ODVTd2VMbVg3amE1eUl4a0RRQjd2aFJOODhQ?=
 =?utf-8?B?SVpKQlpiSGgvdXVPNXpZMGpuYkxHemhyQ2FQbndMVGFvc1BMSGJ5c1ZjZmpU?=
 =?utf-8?B?OUp2QmdscFU2Nng3bXplTTdVSUVISzhidDY2QlJCSzdFNGs3bW1YM3ZraUsy?=
 =?utf-8?B?c2ZyaFVXK21yV1V4ZVRuV0FDV2l2WHpLVmJjNFcrbit4QlRwNm93RnIxWWJQ?=
 =?utf-8?B?MGJEUmMreGhLQ2JzRVVqMVFrek1SWlRIQjFGcFZFU2lTL2JhSEZNZ3FHMVhP?=
 =?utf-8?B?R0xCNmp1YUNNM2FQb0ZmQ0U5WGxGOURndWlKK1cxWXpIeHJrU20rK1IyWUNh?=
 =?utf-8?B?VWxYUERKS0lRMm5sTE53L0dvWGk4YjBna0J6NWJ5djN1SW5ycjQyM3BwSWlJ?=
 =?utf-8?B?Qm5wR0RIQkp4VExXaUFvU05tc3JpRy9ZYnhxdHdON3dMbVB3alBocVpuMk91?=
 =?utf-8?B?SWRXQjFTekhhR1JxdzI0VVREUkxIeGVnamdrZFZJTkw4OGpKM1ZHTC9ZbnhI?=
 =?utf-8?B?c1VFdDkrODBQN3NnQm9EcmhvSnVONG8wUjQ4QVZYcW5yMnRqV2x4U1Z2RHow?=
 =?utf-8?B?YmF5Q1pBMXFUbzZGdjdPQ3l2OEZ1WGx5djhsa0JNMkxDRjlaWXFmUnI1dkpl?=
 =?utf-8?B?cFdjcXpBQkwxUjN5SnUrRUlMZktLdlMwUWpHWGJscVpUc2lCTWVvays3QjIr?=
 =?utf-8?B?SUtHQ3ZzTThUQk9uSkhMaHZaVGtqNVBCWW5zV29HQ21mOUpRQVlIK2FzSEVw?=
 =?utf-8?B?Vlg2YnZnK0loa0dWQlUxOXNVMmhWalI2czBSbzArdk02cmhIU0J3OU1TdkVC?=
 =?utf-8?B?SEZxTmRHK3Fqa0ZuM3RvV0t5UkFoWjhXOXlWei9mVlFvV2NxMDBjZWVWSG02?=
 =?utf-8?B?OEZYL3BpeVA1OVlXY2lWaUxYUyt5WjlPYWluMVpINUZQUkl2M245UWxxSnho?=
 =?utf-8?B?dkJFaDFYQlArNDRwSWN3Z0RzY0Qrbzd5UkNTZlk1WGNUeHpqYW1aSHJtWHJZ?=
 =?utf-8?B?WkxMemdMcWpGSi9Qc0hvVk9tdE5DNVVoY0pORExMNFNtb3NVWlQ0OVdaYVlV?=
 =?utf-8?B?bVFkcXVQVXRRRzBwUWsyWjl5V1VnbjduY2FyaDFlUDRldUxXRDlkK0JHaG1n?=
 =?utf-8?B?ZHlSQUp3TUZXT3dOUVlwalBQVk9uVUs2dGtaTDFadTVIZ1VrSVh0ZWhxUlVw?=
 =?utf-8?B?enV5NDdDcGp0RDNtZWU0ZkhkZHdqUDh4SDJHVlF0YzZrQnNUdVIyb2dPelUy?=
 =?utf-8?B?Ymg4di8vRmJob1FVUk90TmJSMU5DY1IyVW1xTFdNU0kzWmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10963.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTV4S3RwT0I2MjBCY3oyZDdSbEpaMXRFdlhmamszMC96ckxrOExWOWYxdUJI?=
 =?utf-8?B?NFY4dWJNWnF3Vkpjek9WYzZIc0oyUksxQ3U2V0VORTEzZlIxMTJaak55Q2h0?=
 =?utf-8?B?VTlUZVZ2M2hXb2tuR3BvbmxYSEFKNm5ESTVCSHBsRUdRcEszMkJVbmNuU1J5?=
 =?utf-8?B?WXg4eTlBNVE2TnlrS1FrTCthUU5KV2ZxeFFxbzYvOUdXS1pjaGNZbzNVNmhR?=
 =?utf-8?B?UXl3aWIyV3VUM0ZobWZpTWN3Z3ZVWHQrQjBzbjMwU09CVEt2a1VwMG5JVWFF?=
 =?utf-8?B?QlZJd25mUlRXNkRHSW1acUQ4OGV6b0RTN3ZsWU9xWVVWU2FnZ2o0RHJwaUZj?=
 =?utf-8?B?Ukk1b2pnVUZ5Wld3ZUh5bHZzTFgyY0ZRY2lMWmptTk5aNXZ3b1RhWkRpZUds?=
 =?utf-8?B?R3ZWbCtFZ3ZyVUFDd25weldUWVBZdHhxVFBrRk41bWJXWE5IZno1d1craFJ5?=
 =?utf-8?B?alNMK2xtUEZMblVra05ncmFxUi9jZ0htYTZQOFNIVVRRZ2lrdzk4b3VzM1pw?=
 =?utf-8?B?UVBVQVZoQXNId1VKTDFTTUQrdXlRNDdteG9SUUs0c2U1TC9BeHV5UzhySGZs?=
 =?utf-8?B?ZnplQXAzREY5UTN6L3VUQ1JsZmZXVmE0NkdRV05saFVwdjhURmVHTHBZdzNm?=
 =?utf-8?B?a3puaGhNQzdLaEZ0OGRtUkEyK1RWbUU3bnR6SGc5eW9vcWlLejRhdHhJVHZ5?=
 =?utf-8?B?MWo5M2JsWnNsKzBTajd4dXB1R0hodGl2bmhUaGhLWlFVTGNSUkIxaEJiVzI5?=
 =?utf-8?B?WXpMUG9ibEdNZHVjcjB3WlA3anpMN1BWdkNRdy9NTUJDQmJyY3BuWTQxdjB1?=
 =?utf-8?B?VTNodEhaVGNOb0M2aUI5djB3ZFhpOGxzazNqU2VCV0Vtc0tRaHBCU2pEY1VM?=
 =?utf-8?B?c0FBMjhNM0x4K1dzNmo0eEU2OGtZcDNxbWw4d0x1Sy9ZNXV4MS9tWUZnZWxh?=
 =?utf-8?B?MU16MG5SeWdpSUU1L3pOeTBDVlpVWHBHbHovZE1pSUJKVFNJTmFDR0tIdWlJ?=
 =?utf-8?B?bzNuMUlqVDdTK0RWNm5Ma3M1MzBnSlV2clZZZm05KzZPalVKOGhFZnJsbS9o?=
 =?utf-8?B?RzdaRGZsZVJXY0lCdmZtUGtIcXRrVTF3dThBQWZWY2Zab09vV2FnckRVcDdL?=
 =?utf-8?B?OWFWWnhWaDJMKytOSEtIRm0vc0l0alhZVlNaZWJYM2t0KzNRcnlYS05tSzNG?=
 =?utf-8?B?VytwZjZvaXdiWlBOdlovaWxTSU9vMVNuYXE1NU1nVjk4T0E0VmhvK3p0VmlH?=
 =?utf-8?B?azhaVHpYaW9taWhwc2w1dDh2YjQ1SzFMcngveVZ5L0IzNC9rMENUNUVoSG91?=
 =?utf-8?B?OEVqL2tVOUkzaW9hZXVGSitYY29rME84WW5LYi94eUQyUkJicWRYQmFGdDZp?=
 =?utf-8?B?Yjc1WUgvMXhsWEgyMWwyMHhWMzZlQTMwNjJwR1FRVTlNSlJDSGsxS1RYeFhG?=
 =?utf-8?B?cndaMjN2cG5OTkdnRmxNemk0b2dhcXpnM2NjZkpESXd2ZW1yZXJIeEgwVk9o?=
 =?utf-8?B?N1F0OXBhY25NSjRYaEl6Uk93TUlqUmNmYVY4c2VmUll5TkJnY2oweEJaSDdq?=
 =?utf-8?B?aS9EWUwweW5sN09mZ0hBYnhpUjV5Zy9DT3RpbTB4TGdYMUpvNTZ5dys0MnNO?=
 =?utf-8?B?Y0JpOFQ2U0xtSW41NjN0bFNKelV2b0pnSzQwZ0Rucy9wSkM4VDJ1cUEzR0Yz?=
 =?utf-8?B?QkV0dHgzdTRSR0ZVWUNUMnlrRitJay95eXFDMjg4RVh3TXgwaWN1NUV6YTRX?=
 =?utf-8?B?ZExYcmlZam0wTjhyMG9Hbm1kOHBvb0F6NWN3bHhXY2pGZ1FDYXZOUDliLzk2?=
 =?utf-8?B?T3ppNjBIZlVianZnc291dDVaZms5NjFsbkFBNVZqdmZQb2Fpaklzdnk0blFr?=
 =?utf-8?B?THNSeXVlMDViS3ovc01BdnhaZ1M5ZDhCUXRGUVp4aGU3VUNaSXZXelkxN1Ar?=
 =?utf-8?B?dGFEc3BROHlLSm5FZmNMS3ZEdTc5akVkSWMwbG1aRUxLTWcxTlNyQXdOT1B4?=
 =?utf-8?B?TmY5SjhYZmF6dGp5Z2NRNkMyazVyQkdUbDRodzdMeXhsd2JET2FFamhpNUJS?=
 =?utf-8?B?blJMKzJNdDNyQXJvemJyYnVPS08yTURVMldUR1YvYjNtY2xOY2tnM0Ivb3dX?=
 =?utf-8?Q?9UE7kWzpB1gQfXPOpSDtCe5IZ?=
Content-ID: <A9578BCB30E8224997D82A7FD3449C6D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10963.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e51fb1-32e4-485a-874c-08dcaa19f81f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 06:46:09.3073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qc0LP1WLUASkSgS2w91u/em72zpFpivAEn20lUCFr5B4gu7m4S5f2qIi3EKNHhX/LaZTPxS+jtSDtgdPDuTzmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6901
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_234630_370263_00DF2100 
X-CRM114-Status: GOOD (  19.08  )
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

On 2024/07/20 16:38, Lichen Liu wrote:

>> This will work only for 4.19 and later kernels, but might reduce users
>> that hit the issue.  Does this work for you?
> That works for me because I'm testing for the 6.x kernel.

Thanks for the check.  Is the issue a segmentation fault?
I've made a patch below, is this OK?


 From 084742cba5b81da563074454ab8c879e8e411cb0 Mon Sep 17 00:00:00 2001
From: Kazuhito Hagio <k-hagio-ab@nec.com>
Date: Mon, 22 Jul 2024 14:31:43 +0900
Subject: [PATCH] Workaround for segfault by "makedumpfile --mem-usage" on PPC64

"makedumpfile --mem-usage /proc/kcore" can cause a segmentation fault on
PPC64, because the readmem() of the following code path uses cache
before it's initialized in initial().

   show_mem_usage
     get_page_offset
       get_versiondep_info_ppc64
         readmem
     ...
     initial
         cache_init

The get_page_offset() is needed to get vmcoreinfo from /proc/kcore data,
so we can avoid calling it when a vmcoreinfo exists in the ELF NOTE
segment of /proc/kcore, i.e. on Linux 4.19 and later.

(Note: for older kernels, we will need another way to fix it.)

Reported-by: Lichen Liu <lichliu@redhat.com>
Signed-off-by: Kazuhito Hagio <k-hagio-ab@nec.com>
---
  makedumpfile.c | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 5b347126db76..7d1dfcca50d8 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -12019,14 +12019,14 @@ int show_mem_usage(void)
  		DEBUG_MSG("Read vmcoreinfo from NOTE segment: %d\n", vmcoreinfo);
  	}
  
-	if (!get_page_offset())
-		return FALSE;
+	if (!vmcoreinfo) {
+		if (!get_page_offset())
+			return FALSE;
  
-	/* paddr_to_vaddr() on arm64 needs phys_base. */
-	if (!get_phys_base())
-		return FALSE;
+		/* paddr_to_vaddr() on arm64 needs phys_base. */
+		if (!get_phys_base())
+			return FALSE;
  
-	if (!vmcoreinfo) {
  		if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
  			return FALSE;
  
-- 
2.31.1
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
