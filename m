Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CE1D70E02
	for <kexec@archiver.kernel.org>; Fri, 29 Nov 2024 01:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3XFm73b9Kl2E2SGRnkOkTjW4y7axSGHVH/jR6JRpiyE=; b=Ah1LeEA/dIIAAkmpawBYecVJpY
	NtnVp6Tx9A2+/dcy7+B15h+/xizOOzVGp+vmkFzr9orFkHQjglpavkHRzyg8WtvtAfQt+X2x3qxAk
	b+z9SFo2QSywwe0na+8CIJ9MIrRdw/4Ol/hV+7iSRZZPyNwhvZl/5E2SkUL8xLvSbu9LLHKMotmqF
	aHVLn+SljCw2JC608XOW8ijnUUBsdVXOllpMO8IR35iPTkmxm/MFAITCWSIUL0h4HPf1knsT+auC9
	DL57ytaYpmiOJ36hgGAfenPPFHyXT9DpYEeOgZFP1NUdyonCHTylynKINvHSs9xkDFwpirAfpSWxZ
	hpdBbYGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGpp3-0000000GgAJ-0xhX;
	Fri, 29 Nov 2024 01:29:29 +0000
Received: from mail-japanwestazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c406::1] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGpp0-0000000Gg8l-12Qf
	for kexec@lists.infradead.org;
	Fri, 29 Nov 2024 01:29:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkfSinF29KLvq3iwAmq6hTsee+i1iZvQObsyFmDtM3E+1Ssbv2BCN+Uf8siM4MydWRR0xdyQr8mV/+bxLZcjLgC1Qyc6iCl8nCC1Q7UzzQdxXidEnJNqZaW3j7/ouONU2ozR8aWQkZXhxp/mnuXW18T7nYtlcEM2FKMueUCysdcpJfC8TbUUhZa62OzEoPdVFqJGUBqI0qD9HzTKP75f3ndYRY9HSQRgX1S5tMRoW4CGDTRBMk6/hgD5j45LgwvcZCr0jEZfDC/UJLWh5RWvsuudexWiF4o07AdidvrdthVfpVqaDUbJKNY8KmpcT8ps2tOQR063KdYN9fZA5DvYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XFm73b9Kl2E2SGRnkOkTjW4y7axSGHVH/jR6JRpiyE=;
 b=R8VCy17pwfXPCTyhhjpedrHd/Scs6KF6RoXGbg73IE45JjqquAxnHApBd14WswvyZopdzc1PZVzX3sELTlwP1/6J188Unl6QsiWug3ZPQCtTh0thSbspEnbYF2LvoHwKXlhmLkBY06hLvKDck6OoCjiEudzqWKlHE8lk4kCQtWSMGCrBaZZEP/qTuhgEMwVygr5hadmJXeLy7RxdXimsMonGQ6apiE2PBvVLSNMYisRvqdS6t/HZS/+ZySPeokm8wQHeUgPRY5HbEIjb5Q/K541Y7DYulx1LutO3nWlh+cN2FcNVIeGF6A1l6Qqfwz1xwGGMinyFafSs61Ko79DkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XFm73b9Kl2E2SGRnkOkTjW4y7axSGHVH/jR6JRpiyE=;
 b=VFeydTYro/FEU9vGs1J2KxYRrfrq67ofBUaSbQafEI3FwtTR0GX51Vvh4NP9I7s5NYalszTxpFg3K/5kdpFcnIp4DNe/fat68GeeQJRYvPokbRE9rzBhyPdpmS307bMgj+WAAzPeVqVI4ruRkpH5fxFuvDrZ3MS9ziNOXQnOEWRJABqp4sNtXP3W2p+idD2r2tLlsmGXLp3P3rv6CLKvPnDkf90kV8kuws8CMclfgLPwACBe2nJ+61j7+Lktre3qs78i7q9WU8oaFZ/zAeluUtXonSL5frGFDdub3RHunOeR5ovgLCU6Bn32/uAQyEH7ZkvNMzbGqu5gMCVPsvIfhQ==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by TYCPR01MB9909.jpnprd01.prod.outlook.com (2603:1096:400:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Fri, 29 Nov
 2024 01:29:06 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 01:29:05 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: David Hildenbrand <david@redhat.com>, kexec-ml <kexec@lists.infradead.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v1] makedumpfile: fix detection of typed (compound) pages
 (Linux 6.12)
Thread-Topic: [PATCH v1] makedumpfile: fix detection of typed (compound) pages
 (Linux 6.12)
Thread-Index: AQHbPMcOMIQqkYStaUeZcupmwqoiE7LNgmsA
Date: Fri, 29 Nov 2024 01:29:05 +0000
Message-ID: <9478decf-782a-40ac-b51a-ec1852fc6760@nec.com>
References: <20241122101219.936746-1-david@redhat.com>
In-Reply-To: <20241122101219.936746-1-david@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|TYCPR01MB9909:EE_
x-ms-office365-filtering-correlation-id: 2c63e68b-6e95-497c-f3b2-08dd101536f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QVk3bkxSTU9Pa0dWZXJ4TElZQ2pNTTZlZmh3ODdSRHF3d2dScDVJRUJOOVhn?=
 =?utf-8?B?S3pzbHU4M2dIZnFhTHBEd016UTRKaTRlZ2k4S3duRDA3K2lkMUJGT1dVS1dh?=
 =?utf-8?B?ZlRoNHNJZStaZnY1d1dpM0NQK1gzRTJhSE1FbGthNHlyeTlGZE5VblZNb2ZB?=
 =?utf-8?B?WUlEd1dHMlg4OXI2SFVvc0laUHNERkFCSy9MTEgvaisvWjJLN0pLV3htK090?=
 =?utf-8?B?SlJxWnZFZkRoWVNtOUlmODhXaFpubGsyQm5xOUJUWWtXVjd4YzkwZTRiVlAx?=
 =?utf-8?B?S1pQMEg1NEVpVDJXNTFWY25HdlRPZk43eEp1ZUpmQlV2Ymo5REY5LzdaWkVm?=
 =?utf-8?B?ZlZ6YUhEc1N4MFpWQjI1WEFMYStkUGRaSjVFSjhZcFg1czhwblVCZC9Ienlz?=
 =?utf-8?B?OHJYK2xKbVcwTUs1UFZ3dnpqRGhncllNa0JDSld2Vk0vM1VFVjZPc211Rms5?=
 =?utf-8?B?S3llYS8yYUt0NHJHaHVxQ3ZjQ1c3cGN0VmlTVzVqbkxlR3R5OEtGT1pMMFVj?=
 =?utf-8?B?NmVzTWo5bDlieDR6ZHhvdFVFa1ZWVE0xZm1qaXQxTlIwQVpWZmdoTE5oalc4?=
 =?utf-8?B?U09JdHFaNDZVZ0VKTXVZOFNOdmpJS05QdTRsdzZBOXBDTDBlRHJ5VDdCTjRV?=
 =?utf-8?B?aXhZamhxM2dlVVdJV0l0K0tWTXd5aEhobm92S2lrUUxqK2o0K1NuU0l5ODJI?=
 =?utf-8?B?U1k4NG0zRnNqYmxGQlQzUjBzVXhWazF2RERoZmUra1RRRzRPM1FYdFBmTkRD?=
 =?utf-8?B?LzBqNEZwTVcvekltZXhSZU95TXJjVjFhL0gxNmg0VnNnOUNmWVZod3NtTEkz?=
 =?utf-8?B?R1NTUWRkVSt4dW1DUEhaZ1ZCKzZvdmRvcGhuOUxkRDJFTjBkOXNpcDFTKzI0?=
 =?utf-8?B?ZnJzaW5CaDk1TkRNdldVR3RyOFNaTy9iRTZ4NDJJL1VpU3V5RStBbXBwdits?=
 =?utf-8?B?M3JyWndzWkw5cDI3MG9MZEVJSVJacERzNEVucnZmQ3VremhDM1NRaUMrQjFw?=
 =?utf-8?B?TjVKWUpZbnJBMUd1REtzenpKa24ySko0ZmRRNUJMUWpycWVNQUJLeUVqdDBS?=
 =?utf-8?B?SFJaUHFaWngrbC9LL0xVOXN1YTRtdEhPVmpTdC9uWW16c3QxT0ZDVE9lSmZW?=
 =?utf-8?B?R2ZITXFKNVdCS25EakNaRE5YVWd0a1FYRlRZQ0pQNXJRMGRBSEordFdtay84?=
 =?utf-8?B?SDlvNmtNTElJWHpuWS9JdmtQeDlKWkhNMDRRZ000WnZjRHpsdHoyRUlJN1Zv?=
 =?utf-8?B?ZjBMb1ZZTW1UdktiY3dMUFVFWnd2R3BBQlFTajl3R1c4ckFLOENYT3N0Slc0?=
 =?utf-8?B?T0gyRmdzMVJlazBGOTNVcGlnOTk5cENkU3c5S01ndUxPREFPZjVRdHU4YWE1?=
 =?utf-8?B?ZXRMRS9xN0ZIWUdnNTkreGJFQ045cHMxc0pPU3pWZlBDeEMyOTUrcGlINStI?=
 =?utf-8?B?TlNTNWUrcGoyQWF6L21DcjRRY2szaE9vaytTZ3Y0OEZ6YlNZN0ZkWC81UlRm?=
 =?utf-8?B?bjNiQXNuOHBqcyt6YzlQaHJ6UHR2M0tVeUdTV0hSZHN2andFWHJiVkZzU0VH?=
 =?utf-8?B?R1d0VG5qampGYUo5VEdrM2xDRC9Lc2I5R08vVUJMTURXbk9jY3ZqL2lRMUs4?=
 =?utf-8?B?VkUvb0dCdmFjRDJDRzFOSngyY3pGQldyNXRCYTVxdFdlR3g2Nkh3eEswbCsx?=
 =?utf-8?B?OFcvYUJiUldwdTVxek5xOG9scVltN05xMW54VDkzanhZZXdKYnVucDhYTE4x?=
 =?utf-8?B?K2IyYkQ4cHZLZm5OTUdpU00yL3BLRWpBb3dJZm0wdDZza28reS90VVZiOE5Y?=
 =?utf-8?Q?9LFr13Tg4mfSbM2biVghA3gIWVu9xNGt9i1i4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmc4TzU4cjRWNXNhNEZXOWxObzY2S2ZxdElVNW1Pclp2cEZoUDAvaDZrMVhs?=
 =?utf-8?B?dktvTGRYV1JZdlhMbitieTNtdnpSOTU5aUs1a283V1VLck5id1lOakVmNDJX?=
 =?utf-8?B?TkhRTUR6dWxsMDBoZVEybWJDNVJIbVlvOU5pb1hCSnFudFhaeHZKbUZiMFph?=
 =?utf-8?B?K2xsME1EL2ZJT1oyMERLWHJCdFFtZW1ROHpvQUovZXg3WE1qQXBNZEJhV3hD?=
 =?utf-8?B?WW45cWRENG9CdExqZ0d1YWticGNoMHBYcXZySnJ3RExwbHd2Y2gzakdMZ2RR?=
 =?utf-8?B?dEl0SEVvR3BkMkZCdkR0aHFScktIdE9tSWE2SkRQcXI0MjQrblJ3dGc1Vkpk?=
 =?utf-8?B?RWdCTVYxK0xrZ1U0SmRsRDZRNjczdjZGM0NGSUF3S1VacXlxY1dwMHhUMTBJ?=
 =?utf-8?B?S05LWUJ2Y0Z2V211L3JyQmRPODlSbmNsNlFKTktkMDRzKzhUOFhUSS95d3ZZ?=
 =?utf-8?B?S1FCWmVxZzhlTGV0Z0hPNHR0UDArMmRReEpmZjlsR1dDamR4d3VPVkw5NzZa?=
 =?utf-8?B?c3kzb0c2eXFUK0ZIS3NLbGJocmR3a1ZxTDlSUmRLSUpMSjZGTTlmaFZSZGlp?=
 =?utf-8?B?bG9MY0pTano0TDM2cUJXSUV5QkI3dWJqYUlIdVdHbURnWmd0Q0JBc0dMc1Fr?=
 =?utf-8?B?RFY1eTRqL3RaR3NFaFhaVHhOQlJZZmxCazh4NlVoSEZyZVN5OWJ0MEN1eFpq?=
 =?utf-8?B?L21SVm9qZnExOU5JRHZ5VlNLbnJ2U0VCaFlRNEVySGdVbWRoeE84RHpyZnBO?=
 =?utf-8?B?RGhaVDFqSGs0dDRUWWpqNFhTcGsxTU9wcDB0eStJampPb0QwRElmSGppNmhW?=
 =?utf-8?B?bXNKYzJJaHhhMkhtcGtLeWd4WWRVbWVadmRtY1hBMEJjMzVxUFNZTEc3Mjd0?=
 =?utf-8?B?elNvNDdjQndVUlhMSVBCZTBLaHZHWlp3amgyZ3dBVm40ZmdGeEtSZnB2M0Ez?=
 =?utf-8?B?aXc4cHhoeU1FS0h2UDdTZ1RrTE9mb2RpcHAxTUxDeENCZjlkM1hPbkJqdDhW?=
 =?utf-8?B?K2ZLMlluQUVOdHpSdkRKQWU0Q1hieTFpQW5VSFlDOUdJVk9IM3hhNkRpTzVT?=
 =?utf-8?B?SzdZMnd1RVAwWU8zVXBLSnFZcEJ5eUFseWlTU3lmcVB5Mi83aUxQOHhicWJh?=
 =?utf-8?B?S0xTeGVTeWlhR1pvQXNUR1p4Vk9SSExFM3ZseThsUGRNRWtSbXFVTnp4dlh4?=
 =?utf-8?B?dEQ5Z0xrNWd0SElEM3hWNzNsc3dnYXd5THRPQUVxdS9DV3Rlc0VJV05wUExX?=
 =?utf-8?B?ZjZiRlVZOFpaSmdGYzVncXFuWUNGMGlxNENOU1BaaExDb1IvVkhFTjVpL3VC?=
 =?utf-8?B?Y1dtTCtyeG55VlhhazFFdFFhczV6dW1jNlJnNXVmcEN3UG8wdDNBMExzRTRV?=
 =?utf-8?B?ZFZRQTFPbUxWTVdjRVFDVGtjZkRlaWNxcmJjR2J1RGtZeTZUVGFwcXh2QWJX?=
 =?utf-8?B?OHN1T2srT2tzdEp5Z2VyT3o1aXJPTXVHRjhIRm1hN3FJK3crYVhTRDFKVWl1?=
 =?utf-8?B?N1V0T3JkZTkwd216OEZ5TjVXNmM4anl5dHJ6M21Lckx0c0FEbE9LM2czeTNq?=
 =?utf-8?B?cHBrLzZNZ3AzUENpNEF4T2ZPRkhuaE9PTDhURGoxeGFjMkhZRXpFM0ZGdDky?=
 =?utf-8?B?c1l6cXB1eWRkU1lXQzIya2dac1YxUUk5OFRNZTgraVdrZkxFWnNBclNCNmE4?=
 =?utf-8?B?T3RvU2ZhT0NvcFRJL1VjZUFYalFHTU15R3B0Q0FNUEVEUzRKaXBSY1VLYkZB?=
 =?utf-8?B?YllQWVBPWmNMQVdpb3I2bFNTeFhkRmF5NkFQOWRWQzZpN3FaWkdkdTJvb1Jy?=
 =?utf-8?B?d0FPaEpyNFV4ZjVpM2lCNGdEM01lR1pGTHNjQStBUE5rRytrT3dYL3plYVBJ?=
 =?utf-8?B?U2ZCcGhsbUloM1ZoRTRadCszWDFhR1YxajBPNnBnNjdkY0dFWkZ4OVhjdmN0?=
 =?utf-8?B?UXZsQVl3U0QzUW9vSVI0eThoZm55NUlEV3Q1SEJHTC9lM0haZ3JEQnJ1RklQ?=
 =?utf-8?B?RlRwc2gwSEZVUXNoWFNNa0RqdUt5VFRzRjhiNXlvWk9YaG85dTVsK255Rmtv?=
 =?utf-8?B?Y1RsOXdXYWdkMnE1cU5TM05TNjl2NUM2QU5pKzhUSk54bFdzQkMrUFpSWjlm?=
 =?utf-8?Q?WFuljHD3/3ctV3EZKDOXaFAnj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98F3685A6D214F4282E7E01F71D097BD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c63e68b-6e95-497c-f3b2-08dd101536f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 01:29:05.8241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d4j1JQoq6bAx0X73/Y44eKMj/cOkgRuUxbr1B5tibXwzU1uF0bBEtr2bVlvf+RRc8FINWUjTDRnCoCSlkZ0uCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9909
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_172926_406192_F966D26D 
X-CRM114-Status: GOOD (  28.77  )
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

T24gMjAyNC8xMS8yMiAxOToxMiwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+IEV2ZXIgc2lu
Y2Uga2VybmVsIGNvbW1pdCA0ZmZjYTVhOTY2NzhjICgibW06IHN1cHBvcnQgb25seSBvbmUgcGFn
ZV90eXBlDQo+IHBlciBwYWdlIiksIHBhZ2UgdHlwZXMgYXJlIG5vIGxvbmdlciBmbGFncyAoUEdf
c2xhYiwgUEdfb2ZmbGluZSwgLi4uKQ0KPiBzdG9yZWQgaW4gcGFnZS0+X21hcGNvdW50LCBidXQg
dmFsdWVzIHN0b3JlZCBpbiB0aGUgdG9wIGJ5dGUuDQo+IA0KPiBCZWNhdXNlIHdlIGN1cnJlbnRs
eSB0cnkgZGVyaXZpbmcgZmxhZ3MgZnJvbSB0aGUgbWFwY291bnQgdmFsdWVzIHRvDQo+IGNoZWNr
IGZvciBzbGFiIGFuZCBodWdldGxiIHBhZ2VzLCB3ZSBnZXQ6DQo+ICgxKSAiZmFsc2UgcG9zaXRp
dmVzIiBmcm9tIGlzU2xhYigpLCBtYWtpbmcgdXMgbm90IGRldGVjdCBmcmVlIChidWRkeSkNCj4g
ICAgICBwYWdlcyBhbmQgb2ZmbGluZSBwYWdlcyBhbnltb3JlLg0KPiAoMikgImZhbHNlIHBvc2l0
aXZlcyIgd2hlbiBkZXRlY3RpbmcgaHVnZXRsYiBwYWdlcy4NCj4gDQo+IEluIHRoZSBjb21tb24g
Y2FzZSB3ZSBub3cgc2ltcGx5IGR1bXAgYWxsIG1lbW9yeSwgYW5kIGZhaWwgdG8gZXhjbHVkZQ0K
PiBvZmZsaW5lIGFuZCBmcmVlIChidWRkeSkgcGFnZXMsIGFzc3VtaW5nIHRoZXkgYXJlIGFsbCBz
bGFiIHBhZ2VzLA0KPiB3aGljaCBpcyBiYWQuDQo+IA0KDQo+IFdlIHNob3VsZCBqdXN0IGNvbnNp
c3RlbnRseSBjb21wYXJlIHRoZSBwYWdlLT5fbWFwY291bnQgd2l0aCB0aGUgdW5tb2RpZmllZA0K
PiBQQUdFXypfTUFQQ09VTlRfVkFMVUUsIGxpa2Ugd2UgYWxyZWFkeSBkaWQgZm9yIGZyZWUgKGJ1
ZGR5KSBhbmQgb2ZmbGluZQ0KPiBwYWdlcyBhbHJlYWR5LiBUaGlzIGFsc28gd29ya3MgZm9yIG9s
ZGVyIGtlcm5lbHMsIGJlY2F1c2UgdGhlIGtlcm5lbCBuZXZlcg0KPiBzdXBwb3J0ZWQgaGF2aW5n
IG11bHRpcGxlIHBhZ2UgdHlwZXMgc2V0IG9uIGEgc2luZ2xlIHBhZ2UsIHNvIHRoZXJlIHdhcw0K
PiBuZXZlciB0aGUgbmVlZCB0byBkZXJpdmUgZmxhZ3MgZnJvbSB0aGUgUEFHRV8qX01BUENPVU5U
X1ZBTFVFLg0KPiANCj4gSXQgaXMgd29ydGggbm90aW5nIHRoYXQgdGhlIGxvd2VyIDI0Yml0IG9m
IHRoZSBwYWdlLT5fbWFwY291bnQgZmllbGQNCj4gY2FuIGJlIHVzZWQgd2hpbGUgYSBwYWdlIHR5
cGUgaXMgc2V0LiBUaGlzIGlzLCBob3dldmVyLCBjdXJyZW50bHkgbm90DQo+IHRoZSBjYXNlIGZv
ciBhbnkgb2YgdGhlIGludm9sdmVkIHBhZ2UgdHlwZXMgKHNsYWIsIGJ1ZGR5LCBvZmZsaW5lLA0K
DQpIaSBEYXZpZCwNCg0KdGhhbmsgeW91IGZvciB0aGUgcGF0Y2ggYW5kIGluZm9ybWF0aW9uLCBp
dCdzIHZlcnkgaGVscGZ1bC4gIEkgaGFkIA0KdGhvdWdodCB0aGF0IHdlIHNob3VsZCBkZXJpdmUg
ZmxhZ3MgYXMgaXQgd2FzIGltcGxlbWVudGVkIGFzIGZsYWdzLi4NCg0KVGhlIHBhdGNoIGxvb2tz
IGdvb2QgYW5kIHRlc3RlZCBvayB3aXRoIDYuMTIgYW5kIG9sZGVyIGtlcm5lbHMsIGFwcGxpZWQu
DQpodHRwczovL2dpdGh1Yi5jb20vbWFrZWR1bXBmaWxlL21ha2VkdW1wZmlsZS9jb21taXQvNzJj
MzQxNDk0OWJkMmU5Mjg0YzhiYTdjZWFmMTA5YTVhMzRhYzJlMQ0KDQpUaGFua3MsDQpLYXp1DQoN
Cj4gaHVnZXRsYikuIEluIHRoZSBmdXR1cmUsIHRoZSBrZXJuZWwgY291bGQgZWl0aGVyIGp1c3Qg
dGVsbCB1cyB0aGUgdHlwZXMsDQo+IG9yIHByb3ZpZGUgYSBtYXNrIHRvIGJlIGFwcGxpZWQgdG8g
dGhlIHBhZ2UtPl9tYXBjb3VudCAoImJpdHMgdG8gaWdub3JlIikNCj4gd2hlbiBjb21wYXJpbmcg
dGhlIHZhbHVlcy4gQnV0LCB0aGVyZSBtaWdodCBiZSBiaWdnZXIgY2hhbmdlcyBjb21pbmcgdXAN
Cj4gd2l0aCB0aGUgIm1lbWRlc2MiIHdvcmsgaW4gdGhlIGtlcm5lbCwgd2hlcmUgdGhlIHR5cGUg
d291bGQgbm90IGxvbmdlcg0KPiBiZSBzdG9yZWQgaW4gcGFnZS0+X21hcGNvdW50IC4uLiBzbyBm
b3Igbm93IHdlIGNhbiBrZWVwIGl0IHNpbXBsZS4NCj4gDQo+IExpbms6IGh0dHBzOi8vZ2l0aHVi
LmNvbS9tYWtlZHVtcGZpbGUvbWFrZWR1bXBmaWxlL2lzc3Vlcy8xNg0KPiBDYzogTWFzYW1pdHN1
IFlhbWF6YWtpIDx5YW1hemFraS1tc210QG5lYy5jb20+DQo+IENjOiBLYXp1aGl0byBIYWdpbyA8
ay1oYWdpby1hYkBuZWMuY29tPg0KPiBDYzogTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVh
ZC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQu
Y29tPg0KPiAtLS0NCj4gICBtYWtlZHVtcGZpbGUuYyB8IDYgKystLS0tDQo+ICAgbWFrZWR1bXBm
aWxlLmggfCAyIC0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWFrZWR1bXBmaWxlLmMgYi9tYWtlZHVtcGZp
bGUuYw0KPiBpbmRleCBiMzU2ZWIzLi5iYWQzYzQ4IDEwMDY0NA0KPiAtLS0gYS9tYWtlZHVtcGZp
bGUuYw0KPiArKysgYi9tYWtlZHVtcGZpbGUuYw0KPiBAQCAtMjgwLDggKzI4MCw3IEBAIGlzU2xh
Yih1bnNpZ25lZCBsb25nIGZsYWdzLCB1bnNpZ25lZCBpbnQgX21hcGNvdW50KQ0KPiAgIHsNCj4g
ICAJLyogTGludXggNi4xMCBhbmQgbGF0ZXIgKi8NCj4gICAJaWYgKE5VTUJFUihQQUdFX1NMQUJf
TUFQQ09VTlRfVkFMVUUpICE9IE5PVF9GT1VORF9OVU1CRVIpIHsNCj4gLQkJdW5zaWduZWQgaW50
IFBHX3NsYWIgPSB+TlVNQkVSKFBBR0VfU0xBQl9NQVBDT1VOVF9WQUxVRSk7DQo+IC0JCWlmICgo
X21hcGNvdW50ICYgKFBBR0VfVFlQRV9CQVNFIHwgUEdfc2xhYikpID09IFBBR0VfVFlQRV9CQVNF
KQ0KPiArCQlpZiAoX21hcGNvdW50ID09IChpbnQpTlVNQkVSKFBBR0VfU0xBQl9NQVBDT1VOVF9W
QUxVRSkpDQo+ICAgCQkJcmV0dXJuIFRSVUU7DQo+ICAgCX0NCj4gICANCj4gQEAgLTY1NDksMTEg
KzY1NDgsMTAgQEAgX19leGNsdWRlX3VubmVjZXNzYXJ5X3BhZ2VzKHVuc2lnbmVkIGxvbmcgbWVt
X21hcCwNCj4gICAJCQkgKi8NCj4gICAJCQlpZiAoTlVNQkVSKFBBR0VfSFVHRVRMQl9NQVBDT1VO
VF9WQUxVRSkgIT0gTk9UX0ZPVU5EX05VTUJFUikgew0KPiAgIAkJCQl1bnNpZ25lZCBsb25nIF9m
bGFnc18xID0gVUxPTkcoYWRkciArIE9GRlNFVChwYWdlLmZsYWdzKSk7DQo+IC0JCQkJdW5zaWdu
ZWQgaW50IFBHX2h1Z2V0bGIgPSB+TlVNQkVSKFBBR0VfSFVHRVRMQl9NQVBDT1VOVF9WQUxVRSk7
DQo+ICAgDQo+ICAgCQkJCWNvbXBvdW5kX29yZGVyID0gX2ZsYWdzXzEgJiAweGZmOw0KPiAgIA0K
PiAtCQkJCWlmICgoX21hcGNvdW50ICYgKFBBR0VfVFlQRV9CQVNFIHwgUEdfaHVnZXRsYikpID09
IFBBR0VfVFlQRV9CQVNFKQ0KPiArCQkJCWlmIChfbWFwY291bnQgPT0gKGludClOVU1CRVIoUEFH
RV9IVUdFVExCX01BUENPVU5UX1ZBTFVFKSkNCj4gICAJCQkJCWNvbXBvdW5kX2R0b3IgPSBJU19I
VUdFVExCOw0KPiAgIA0KPiAgIAkJCQlnb3RvIGNoZWNrX29yZGVyOw0KPiBkaWZmIC0tZ2l0IGEv
bWFrZWR1bXBmaWxlLmggYi9tYWtlZHVtcGZpbGUuaA0KPiBpbmRleCA3ZWQ1NjZkLi4yYjM0OTVl
IDEwMDY0NA0KPiAtLS0gYS9tYWtlZHVtcGZpbGUuaA0KPiArKysgYi9tYWtlZHVtcGZpbGUuaA0K
PiBAQCAtMTY0LDggKzE2NCw2IEBAIHRlc3RfYml0KGludCBuciwgdW5zaWduZWQgbG9uZyBhZGRy
KQ0KPiAgICNkZWZpbmUgaXNBbm9uKG1hcHBpbmcsIGZsYWdzLCBfbWFwY291bnQpIFwNCj4gICAJ
KCgodW5zaWduZWQgbG9uZyltYXBwaW5nICYgUEFHRV9NQVBQSU5HX0FOT04pICE9IDAgJiYgIWlz
U2xhYihmbGFncywgX21hcGNvdW50KSkNCj4gICANCj4gLSNkZWZpbmUgUEFHRV9UWVBFX0JBU0UJ
CSgweGYwMDAwMDAwKQ0KPiAtDQo+ICAgI2RlZmluZSBQVE9CKFgpCQkJKCgodW5zaWduZWQgbG9u
ZyBsb25nKShYKSkgPDwgUEFHRVNISUZUKCkpDQo+ICAgI2RlZmluZSBCVE9QKFgpCQkJKCgodW5z
aWduZWQgbG9uZyBsb25nKShYKSkgPj4gUEFHRVNISUZUKCkpDQo+ICAg

