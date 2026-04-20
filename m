Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411C8EA71B5
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 02:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Bh20uoKoEuJHCOppBCW9EV3A/doOyMXa3pzPtyAl95s=; b=UurVCZij/eiENDLCWerDm6k7IP
	lFwU8OPyff6lgZBpxzW50RXUVGx0S+AxpduvHd1MXWeSePa+7HiM+3ihpXZyH5JLJOWVvJPuusiVm
	Kep2BOWVje7hCgDFjxr5jiGubhHXB2+F1BBJXmWGG9tKdkunzFRjaWzMA0zF7W660QCTgbR7aNkaY
	BEnBw+8Nz5M/ZBq8vBBMRvfkNhoTbVzWQqP+3A9Z/YmuLzGUqhHzwE3TA6O/8F3n/SBQfTqU/tRIG
	6McT//4luMV++LExxdLAWIdxp8GTwLd86Ly2SxcyVLMjp1jTRu8H8ST93kdZO0Az/92N5oKAJK06R
	Si1PQq+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEdwg-00000006IxU-461p;
	Mon, 20 Apr 2026 02:01:06 +0000
Received: from mail-japanwestazon11010066.outbound.protection.outlook.com ([52.101.228.66] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEdwc-00000006Iwi-457l
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 02:01:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QH2WG79AnQsJFKP6Phl69ghNmzusV+yEpj9CSI1JOg6VKhGRQe0a4bY83OyF+yQzGXSy08mC1vetqXTqlongjqByXafGvdlD09yOxvkodwngoKcWDNW60ug/+gqse4tZR+rYY558afiaiQyHr8+/4eorvUUCSZznL0onVAjeYAB4wmo+5uI978VEdF4VeY3fd+iQjqR4J5pa2nHuuAR9RivIeJRyPnEGQkQZ3aystjU2Kxx+H+ypEroV9flxqfJjSO5qiTP9WcsMHliyIbyvIUmoKowbsCqUu4E4AGAxcDzLhFN7yhlmn6/Ga/9N4q3OdLalJJuL7oSUvFJMbPZw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh20uoKoEuJHCOppBCW9EV3A/doOyMXa3pzPtyAl95s=;
 b=kB6xa+YUMrbgZpOQWeR+pVO67VBhwaeCwVT+ZSu6cY33MMB3s/g/UmZNILtGJKEOo9CxTqa665NXo77TnIsg9rB1/IgC4bFJ0y90dlmNT0CmnoBBjzkwdPB3+ctJ90NwjxYQH+sOiweF+iZeMbGvi2AqiGXsY/7moEfgwh7ZZR5ajyA3javnHFzUW4iF0Nq7a6Jo4S0t5iunJeiix1FRZp9czcMNMBbuvmI5lWVg+jPgtvQnfpA1xyow/TPu0DpxrM0eApfsfn+U+yFVHbNeG8nQkxzdlhKZ2QZyI5UJ62gh3WYe2DIbgshqhlYipZHsTu3jTjOJm1va9thk25a6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh20uoKoEuJHCOppBCW9EV3A/doOyMXa3pzPtyAl95s=;
 b=slABRKor5SxOfAU7gIYvwEreSc6fvlaftpCKxLW4mEMeOhdYucBRO5ENjKGNM1iRYMQzTn+AXYb/fvupXdkAwsOUQn8GzwHe3GJyEjqhJIxduKHPE4tALNrX8NzsqB4C7yRdxDk+Yy0zVwibLUB+XGHnO569yLGef7ctbVX26bFheeuOHS/RSK+28Uaq6wpYJFsZ5zCDInam2t7WV6JuR/62dqMnjPSX/3M7XpAdWVG6Lufhi8Ymh1iCyRYOLY6d5FkBz5rjucf/iOUU9t/izN6eUs355FTl7XFLNzh/3YsB87lT5ZAG9+tb8YzSMMD/k9jqJZMlJUPVc7AJrdk/IQ==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by TYRPR01MB15809.jpnprd01.prod.outlook.com
 (2603:1096:405:2c5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.31; Mon, 20 Apr
 2026 02:00:47 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%4]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 02:00:47 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: [ANNOUNCE] makedumpfile 1.7.9
Thread-Topic: [ANNOUNCE] makedumpfile 1.7.9
Thread-Index: AQHc0GmB/4j84pHQUE6De+YWXQPuug==
Date: Mon, 20 Apr 2026 02:00:47 +0000
Message-ID: <ffe967c2-627e-4164-afc2-4fc4e3299460@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|TYRPR01MB15809:EE_
x-ms-office365-filtering-correlation-id: 705047de-e941-4032-a76d-08de9e80a3b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: npIftEf1nKvR/MKufPqDtqKuvaWMql1fS16aQ1vQkGjeUwzmxxJ6/bLuu+59nUnu48+7YogqPQmWSeCDk/3byc+ynfIZA20kCh1jlPh0h9bdYUN2FFS/gfjhDKw40YCUZF0hQm0Yhg0cIX/zWvP4mcLAKYd6bHiOkxwAbjt1cDOFH01UR1yndRXvhUCiJZ2Ick336jo4Vf30wV+1ZUjHo64aUi5NZ4JN8rB82jdppEnwTIAM1a0frrswr5UdivAqImxjqe5cGTZmJrVpPpWsYqx2ZiHwuQpRZoXx1r+Wa+HFpyyBSUjg9gc1MYWbB3INSNUC6uTn4FsjPg+g3Zpx68bvaSYAWMceyXxgiCvNRlopcFMFZm+K2Vfi7NWOrjBQvoTvCI6gJX99brugUU4w5HpYLmd7p+f8v1Xq2A5CuCmgvpS6Ra0rGDgBOQrztQVv6fttJzXZnWbb3NJet3YmcfnRFWPj2SKqddKy7nqpRJ+ULJ358oErHZs0vEtAukERU0MUlIabCM74xZPzSEkQlLzP7mizv+s/QtNLX5gRWF2sy5lHrtlN/Ant6gk9nSj6AlYpj/EUSrl7hD33WUSIEp6hXhmCvSfyIPjBaM/ccZ0ZZTf5ISjVMRN/gL5K12XsFhVHvwyb9akqGBVJU9D5h3cBmkezcV2RW4VJOkhHF2MHMS+yugKb6vZCbv+3dfFZAFDrNwI6m/XlQkFDlkzxSVfzyVnM+pWi2ZdHaQ6OQCjgzOoXe56A6Rnl3nh/xPrQfj0HkLYEV39Y+MXyCzGIgCk0Zw8PPmbQxmg8GtXetc0Mx7sLlShHdWAuznUqFu2t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGVCK0NNK2k3UmE1WjdIWitEZng1bUpsbnh4UTNSU3NaV29NNjZIelNlSVd0?=
 =?utf-8?B?M2J6V3BtaEhxUUVRSC92Q3g3MWlKZStrb2IxWnpvdFFrRUxtZGNuQ01DelFr?=
 =?utf-8?B?SFo3RHlhczA3bkRnRWEzdzVyWUVqRFRESUNXRGdmVnJRLzBDd2h2TElORFR6?=
 =?utf-8?B?YjRiQ3FuODBZZks3bTRkakFZM3VCNFB2ZVFXR1JYN1hBUTRESmNQTGJsbDho?=
 =?utf-8?B?TXRudkUvY2JHdHIrVXB3a3BaT1JRbjJnYmtvQWFGTVpxa1Nsa2JmeGpUd3gv?=
 =?utf-8?B?aWdkWVRaQWZCWjdwNDh5VThlNWt5eFl0VGNIV0RVTFNUbytybG5jL1I5OXNP?=
 =?utf-8?B?K0tSbE5CMjdXUm5tWEE3b1ZoazVYSjZzMVN5QkxKVWhvRkR2TWRTZGlhRkcw?=
 =?utf-8?B?QWVvVWVxMS9RVGN2TURUSS9rT1RuZUdpN24yU1lMamdWTC9lWDhucUJ1T21K?=
 =?utf-8?B?cFVFK0ZZRUV1eTNGeW1NOEVaZm41QWVDMDkydnBQR0JQenhYNHd6Tnl4WTJs?=
 =?utf-8?B?blA0NXh3a0ticEdvY0F1NjZhYXhzYXBiMHkwVUVDdFBUU2l0SGFlaXY4WXRQ?=
 =?utf-8?B?NVRnb2hRSU9mQWVoWnBpL0JuZDVFZG1zcWxxaEo3cW13ZG5SaFFMeEVxUHRO?=
 =?utf-8?B?MEYyWk83dW1CY2FwL2JIVVdnMGZ2cFB2cGlCbC96Mkpnd09McXczK3FoNlp3?=
 =?utf-8?B?NGxMQk9YRFZBdzZjejdDeW1ITFZvVTZQR2VQQkRManN6L00xTTB1QTN0dTNx?=
 =?utf-8?B?NW5PSlVhTXRqSnA2WkNMTTZIZ0MxbzF4K1hFVWZ2TDV6MVJBS1JiNnF5R2w0?=
 =?utf-8?B?OUdpVFR2V0hBQnBJWDBhMVVXanhPM2IzYlhYZVhnaTVza2xycGNvODFINHE0?=
 =?utf-8?B?S1o4TFJFejlPSCtLanIzTTJzWGhPMmdoNWd3R1FyRndHWHVoU0lwOGExcVRS?=
 =?utf-8?B?eHlIekVjOHpZb1U1dG5JWEFCaGQ5NlNtUmI1dXJnQ2I2UW83Z1pZcG9sNXI5?=
 =?utf-8?B?YXVXTTZSdkUyVFdkS1E3MzdzN3Z3cHAzQVl3dFhCQVZHWDRqanFra2J1VmFS?=
 =?utf-8?B?bVE3ejRBYmR4a3FTTERxVlAvY3BwWGp3TXY1NlJvQUdHM0taeE84elJOYWh3?=
 =?utf-8?B?NVBhZnE1dGtVcmFpajJFWngxVjh2YitVUkQxUkE0TGVJUUJ3RjI4N2pGZENj?=
 =?utf-8?B?QzhxYkNEZ29zdUpZclNJNnFNdkJGeTdTYWxSR0Q5N3UyY3dIVFRBQzU3b3Fq?=
 =?utf-8?B?U1pmajlTS21qRjhlWE1TRXNyRm1wTVhQN1hpZ2hlTWlRM28yeldEWWszRFg0?=
 =?utf-8?B?bG5YRjNsZDlIdVY3MThCUStuSFEzUld6cVNaNzU3a3lKVWdZaXN2a2R3RmV6?=
 =?utf-8?B?d0R6emdRamphWnI3b2EyZDhRQnVxT1BkdW9DdFFGT2w4c2V2cHpKK0dzV055?=
 =?utf-8?B?a1hiMTducU9KUHFyRWM0QWxtUnp6OUt0VnRIeHNSV2lHRm5uT1VhbDcwb3k4?=
 =?utf-8?B?RHBOZjJrdVozeU9zNVl5UWdkTXZxUkxOUHc2cThmZXFnY1ZlNTVPK2xpWUR4?=
 =?utf-8?B?aDNzK1ZDeTc2THZNaFFENzUyQ0xMRW8yU0NBUkNIUVN1UFR3ZURYd3FuQzYw?=
 =?utf-8?B?UmszVDJ5VDdFS1RuYlJtSjV3SmkrSklqK3kzeTlCbnJXNXBqZXd5UnRyYTNO?=
 =?utf-8?B?R3JOK0N3a1NmYnU4SDVnakwzRjBoUUR3T2Q4TU5kVVpzWHdCeWVyZmhoMEJU?=
 =?utf-8?B?eTRXWnphVzVoTmFNeW90N2ttelFsa3lrM0YrM2N2TjdVSjNXS1BqMkRxRXVk?=
 =?utf-8?B?RUFvWnVZaEdhTW5abWh2bnpIRFdKZHBadHlRbnBzNkhGT0NoelZRN09OeXMy?=
 =?utf-8?B?eEpyYTNKeWZiYXVRVElCMDNoZk54aDdwU0E0OEgrSUt0Ymh1a1AvTVFLNnZh?=
 =?utf-8?B?UUxUMWV2ZkN3WHNYZ0M1YzhvWWpPcS9XOHVnRG5qUmVQMWhucjhlYnV2WnVv?=
 =?utf-8?B?NnpBQldKbk5UK3NEZjVmVnBqSTc0THBNVmw4TVgyU2lFMFE5TEE4YThqejc4?=
 =?utf-8?B?bk56aysyaXFoRWluV3JFNG1UekwwaW5JUUlYUkpIMEZXTk1RbFRhUWQzYVFo?=
 =?utf-8?B?RTVpOFVrd1o5SWE2cys5L1B0ZFZDK1FRVXJ5UVNxbmErNnJSTjBkV2pVQlFO?=
 =?utf-8?B?RlE3dDIxcmdheXhPMHNRUWpqeFkzRkEvQnNaRUFaWUpjS1N5TmJxK21NM0xT?=
 =?utf-8?B?eUVza3NubkxleU9vTnltRGlQUTl1MG5nbTRYd0hPZHAySW4rUWE5QVFYS2xX?=
 =?utf-8?B?cmxncVN5dFVEUktpUDU2M01pRTVjM2dtOStSQmpjRHpkZTNNTGdkdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <353537295F6CAB459BCFA6568ACDFBF4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705047de-e941-4032-a76d-08de9e80a3b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 02:00:47.2609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIAE2Rgw9EWJY5nBLs2W5skn2lERc97oZYIMpRfxmoDKkn8Ma//oHr04QREtPa8Rmyd2lxNgW/LshYsGwmhQhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15809
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260419_190103_379916_11034721 
X-CRM114-Status: UNSURE (   5.94  )
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

SGksDQoNCldlJ3JlIHBsZWFzZWQgdG8gYW5ub3VuY2UgdGhlIHJlbGVhc2Ugb2YgbWFrZWR1bXBm
aWxlIDEuNy45Lg0KVGhhbmsgeW91IGV2ZXJ5b25lIGZvciB5b3VyIGhlbHAgdG8gbWFpbnRhaW4g
dGhlIHRvb2wuDQoNCkRvd25sb2FkOg0KVGhlIGxhdGVzdCBtYWtlZHVtcGZpbGUgY2FuIGJlIGRv
d25sb2FkZWQgZnJvbSB0aGUgZm9sbG93aW5nIFVSTC4NCiAgIGh0dHBzOi8vZ2l0aHViLmNvbS9t
YWtlZHVtcGZpbGUvbWFrZWR1bXBmaWxlL3JlbGVhc2VzDQoNCk5ldyBmZWF0dXJlczoNCi0gU3Vw
cG9ydCBmb3Iga2VybmVscyB1cCB0byB2Ny4wICh4ODZfNjQpDQoNCkNvbW1pdHMgc2luY2UgMS43
Ljg6DQplYjQyZDYzIFt2MS43LjldIFVwZGF0ZSB2ZXJzaW9uIChLYXp1aGl0byBIYWdpbykNCg0K
RGVzY3JpcHRpb24gb2YgbWFrZWR1bXBmaWxlOg0KVGhlIG1ha2VkdW1wZmlsZSBpcyBhIHRvb2wg
Zm9yIGNyZWF0aW5nIGEgZHVtcGZpbGUgZnJvbSAvcHJvYy92bWNvcmUNCndpdGggZmlsdGVyaW5n
IG91dCB1bm5lY2Vzc2FyeSBwYWdlcyBmb3IgYW5hbHlzaXMgYW5kIGNvbXByZXNzaW5nIHRoZQ0K
cmVtYWluaW5nIHBhZ2VzLCB0byBzaG9ydGVuIHRoZSBzaXplIG9mIHRoZSBkdW1wZmlsZSBhbmQg
dGhlIHRpbWUgb2YNCmNyZWF0aW5nIGl0Lg0KaHR0cHM6Ly9naXRodWIuY29tL21ha2VkdW1wZmls
ZS9tYWtlZHVtcGZpbGUNCg0KVGhhbmtzLA0KS2F6dQ==

