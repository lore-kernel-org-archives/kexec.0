Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E7AE6F066
	for <kexec@archiver.kernel.org>; Tue, 23 Dec 2025 07:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TWXtb5O/1yASGhJU8GXsODK6IgyOP/Mf5+75f8BuIdc=; b=1QE61iI8WUOHaPQj09EerGzMZb
	PzjQccuUdiyiQC7Prbrt4cWIHe2+9IcpSY2nyV/FytZgtvH3KQiKH86iSLHApxpu6VGUplEPXtCkQ
	0AYO8XQP0+BL5X1eoFBhcOUpCu7TfJYauULrzIcoouRpkodpsEhKCZIiNjNK0a0ZgbRn74bzFolY+
	qkaUvhWbeXSHH10FQSugs06RPDR7bhjCQc9gz0roV0bYKJDiRei9SkKXMJM7E26MWW69LnVhEBGRi
	7+vH3C44Swzg1ogZw98AW8akX2WLFQ8L0URB0rEVx4qYMi9rHFXe/E+lJ10IyEjfwoqpB3DPiGhhb
	djfaT9vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXwyk-0000000EegN-26js;
	Tue, 23 Dec 2025 07:38:46 +0000
Received: from mail-japanwestazlp170100003.outbound.protection.outlook.com ([2a01:111:f403:c407::3] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXwyd-0000000Eefp-0RaK
	for kexec@lists.infradead.org;
	Tue, 23 Dec 2025 07:38:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDvFhkIZdx35wnupJm/+7fuv37i3D2wc0dNU9GSGxDrn/9ikfJdLe5CiqzZgoGFkGbYG0mwzMNmZbBokZ5q0NNgk01N3H+zC8axmRmt1SVffDWsT2gGOxZYIUD9h3lRAnt6wiVDbFmUA3Qju5HuFOoO+IsJD0x4gmk2hk8eqOitHXIH9LoMbBTtewaYTwZyuPXKijWMZoAuumHz48qk0UizAPtMmoNkU4zGj4bLZGXNrNbUuW1M8whGazZaCNZYXF9VUH5CDXDLXs42xhIsf6fCfzItQGcgOh+aFYcR2DVT5E6j6/Iboqp7uZ4HIZU5bnpTWPOE3Lh/l6IoeK1PBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWXtb5O/1yASGhJU8GXsODK6IgyOP/Mf5+75f8BuIdc=;
 b=mcSaSdxzn4nMu4j8JM3KVSlccX32c0U96HOi/xDwwdDcDD69QilhkuKcwWtrsWqjC5+Sd3jG7jL7bGAtj1yWdKIfkaxG77fmls824DznPD03AkNqWs2NBPGd5cFopuwPhSol1SNRXhDMhmx9X/NuX09KjFk4ZOdw+a621x9DCrKmnTqqF8HT9XdT3AEcadgXskaluNJyHpO06R0Yy60abUrKk0XUrrEkOFDK+rxBhQsTLpnigpP75IEub3nSYmJ61zydgdSFr3cojGfaSBIacTNxIIMqdgFOZ0kx207NstyFeifIh8UmbkalGkWKJ4+3F8APJEAq4sxhC+Rqr4tsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWXtb5O/1yASGhJU8GXsODK6IgyOP/Mf5+75f8BuIdc=;
 b=OmEhulk0lmgNmBlPy6BFxlx9bwcahY2GM3wTkidTPAqMBfquaB+30b4XCul5ltF3RnbFzbTnK99/tp0ysKFuhPVKyLV+eAVPskrMz6qHLuqPvJqeltf3X9CoMnsp9UE4slEdGI8VzCtx6kTbV0M7ND6oZGcCGJ7zlbCBQ4TTreGxeiO/C9BL2xGvthNHk3vuGoFSSL30ts3URDlsU0i1goIDkumJKSEuU3xdXZJXK/hwkQNaReOl5Ymzmrv/AjkpL8mvdx1l0qCHf/qb0XeRasaYkTtl7Q4o7rT2PFlJXCsMJ/VhRKSbhNfUbrcvNdToOYwg4QJIyHu7B9Sr66FcXA==
Received: from TY7PR01MB14510.jpnprd01.prod.outlook.com
 (2603:1096:405:245::11) by TY4PR01MB15584.jpnprd01.prod.outlook.com
 (2603:1096:405:28c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.10; Tue, 23 Dec
 2025 07:38:27 +0000
Received: from TY7PR01MB14510.jpnprd01.prod.outlook.com
 ([fe80::2ab8:58c8:b276:9f7d]) by TY7PR01MB14510.jpnprd01.prod.outlook.com
 ([fe80::2ab8:58c8:b276:9f7d%4]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 07:38:27 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>, Stephen Brennan <stephen.s.brennan@oracle.com>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH v2][makedumpfile 08/14] Implement kernel btf resolving
Thread-Topic: [PATCH v2][makedumpfile 08/14] Implement kernel btf resolving
Thread-Index: AQHcQhBgjIXRm8wn0Umjj+20uXp5hrUPKfOAgAAwDICAH9/+AA==
Date: Tue, 23 Dec 2025 07:38:26 +0000
Message-ID: <a3bbfb41-397d-4525-91c7-d3f2703bc708@nec.com>
References: <20251020222410.8235-1-ltao@redhat.com>
 <20251020222410.8235-9-ltao@redhat.com> <87bjkgilxs.fsf@oracle.com>
 <CAO7dBbVck88aKxrk2sZ5Si_PJH1mvLbjx+92+xEcB9SM8kRcjQ@mail.gmail.com>
In-Reply-To: <CAO7dBbVck88aKxrk2sZ5Si_PJH1mvLbjx+92+xEcB9SM8kRcjQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14510:EE_|TY4PR01MB15584:EE_
x-ms-office365-filtering-correlation-id: eef9687a-dc95-471f-8961-08de41f642cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VXpSeUI0Vm52bGlrN3F5K0tNeXB3S24vV0IwOFB0OGZJOTNPWkJXcWFYZ2Nq?=
 =?utf-8?B?NTBJU0hKcWhJeC8vMGJ0VWt4YlI0cTRPaUZFOVlISm12Q0ZVQTh2SUZWdXVl?=
 =?utf-8?B?K09MQkVpWENHQ3hmYjRDRnMwY1d1Ly9IaWFMM1BORHdoamo5SSszNzhEZXRr?=
 =?utf-8?B?elliZlh6VUd3SmlYRlU2azZEcGlPcHhpekwweXMyalZYak5vNWJwb21ET0F6?=
 =?utf-8?B?UkVYTTFVOEdsQTA0WkZuMUxuU29ZM1VQb295blAzUGlIdFR6SWJCakZTZlQy?=
 =?utf-8?B?RFNOMnpad1FyWk9ZWFE2UHYyTFZ3QnZjc1VmcWxENDkwVElxRlNPaHc1M3NP?=
 =?utf-8?B?dlp4MG1CV2hUNDR5WlkzQWs4ejlLcXhiZUV5SG5LbUVLU0UzZVBFeTdWenhI?=
 =?utf-8?B?c0U1MmxVMWN1RzJ3K21OMFJOTFp6M2s3bUJFYSsxYWt0RTh2d0xsNVBKOU00?=
 =?utf-8?B?bWtOQkNXQ1FLSkh6MFFjaS8zdktZdzNmSkpBSU9PWmhOaU9RVHRtL3pKWGR5?=
 =?utf-8?B?QmEyWlVmK1pRMlpvYWJGTVhnS0hJeWFzbjMyMW1WalRVN1RmR0lNVlhKb3Bj?=
 =?utf-8?B?dkpLbkxRTEZ0dFpJTUl3ZVFtcFU2OWQ4YmJLNXcwQlN1bW13Mktib3p3VXlI?=
 =?utf-8?B?MHBPcnVoN2JzMGFMZTU2bkVzaURFRnJWaDNEZi9qekJhUVk1MDU0TVgvRkNm?=
 =?utf-8?B?VkhOMklBVy9XZWx0Q0dURWpURFl5dDlOallWZFJrczA4TXc5TUVMd2V5V2tJ?=
 =?utf-8?B?OE92RW85RW5PM0VlNFBmM1c1U3dpWEdMV2VQZG4vZlplV2Y1N0IxRy9aTUJF?=
 =?utf-8?B?Y3c0U0tQQUVBcXBWUnRnTXNSajR3c1BvcFB4alBZVjZKVFRQbVREeTFwY092?=
 =?utf-8?B?S2c0YzhacU1QeVVaNkVWMlBRRFExbUFDTldxSTVHMjdTU3QrMDFQSUpOd0Vx?=
 =?utf-8?B?Q2hrTXBZY0M3Smw1UjFTSWpzQmRhMnVMRTVZRENVcWdOZ2xvQTRKZ1h3R1dy?=
 =?utf-8?B?bnQrT2pkajY0T2NKZ3RDaVBSWFBOY3d5SlNScWp6L3ZSL1RPRUpFS1NaOExj?=
 =?utf-8?B?L3FGSlluQXhaZXJ2dlZPQXlDWWNBb2ZaSWgwWHJIV2pKOUdDWEM5NTJuSytw?=
 =?utf-8?B?SEtVOC9ad1E4amVkYVBzbUdOWXlyUzlqWXdPYzFKU0s3ODFTNlU2dGtidjBT?=
 =?utf-8?B?ZXJtY1ZPenJpY2EwZWpwVTVqN251WmlNWmVaRTVrQUNVRHQxRmFrK3RxQ3Nq?=
 =?utf-8?B?Q0R1bkRyN1p0clB3QnV0dUZSVzZFV0p5cWJGRS9wd3NzOEFFNURmOUtwVWJ0?=
 =?utf-8?B?UzBMZHlnNEF4djBPNnE2bkV4aGhiaS9DcEdNWnVYMndYZXNReUNYdDZBV29Z?=
 =?utf-8?B?SW9QYXYza0JYWWhZQUFaaHlCWDhUL3kvbVdHUnozb2RTclNoWkhLM0gwSm5u?=
 =?utf-8?B?aWYwZFpibG1zbENmc2JCZ29SRzVobkREeURZZ05oVUFlRyswME9HWEQ4QUJJ?=
 =?utf-8?B?b1U4UE1GR1NKeFJxVU1Md0trUnFHcUdjQnJsOUllRVBaT3g2S2hrenNnUmxy?=
 =?utf-8?B?TTRldURyeVhqU0tCOUY5SDRiendSVEFNT25XUHpoblRPcWlVeUNMUHZ6LzJq?=
 =?utf-8?B?T21WeU5VRGtudkF1RFc4WGEwT2E1RVhnODVOQU50VHNOMUIzL2dtL1hSOEV3?=
 =?utf-8?B?TjVrZzMrRFZobHFhTEt6TjNVYWNTTFd6b1lITlBmaERhaUU0dVVwVjhSaTBt?=
 =?utf-8?B?TDF4UHQvaHVkUVB3dTZMa2g3MnVXclJZd2JidlBkS1RoZWhQQ0lsMTFjNWFu?=
 =?utf-8?B?YkYyeE56djFmMzhVZE5oLytyTGE1MW40cGVySk5qQllYeUdkUVNWdE9jTi9I?=
 =?utf-8?B?ei80V2wrcmZUdDJXZHZsdGF6K2k2U21vUFJSQTRnczVvRTBnNC9SZWYxcklq?=
 =?utf-8?B?MDJqVHhmdW43SUVBVVpRcVNnRHgvVVgwSXJNL1duK0NwdWRkVjF4RjBDdHNV?=
 =?utf-8?B?UDZQRVVqRXlFS1F5RG9sNzB0bXZ1cEU2WThJS0w3cVpsNjRrWXV5c2JkVWdR?=
 =?utf-8?Q?2YiLy/?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14510.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDVGbVQ0WXN4MUYyVnY2dTJsS3YzZEFCclhCQU5GaWN5aXRWVTgwWkh1ZUYw?=
 =?utf-8?B?MlcrWTFSd3BIbVYwWHhSVlpJRXZRVVo4SHpRTXM5bTBveEpyLzZSWXNxTHFW?=
 =?utf-8?B?c2pIaS9NSVR1SGs1ZUpjeWlzS3c4SkRaY1U2ZURPaXFVSVlZN2RaYUExN1NX?=
 =?utf-8?B?OG9FbTF2QUo5anN2dG51SmFDMjNGN3g3WkluMTNWcm1OODhjamNsUUxqaWh3?=
 =?utf-8?B?eEk4RlJyVCtYSk1aL0lMeXRlcjlBWm5yQW1INURxbW1tYXZUSzdVNW05bEVK?=
 =?utf-8?B?NE9TUDdSQi93Q013WjVmTXdBaDgzZ3NONGdhcEF6cHBZVHhrQ0JtOGtOcjd6?=
 =?utf-8?B?K3hzTzNrV1NFUWJjRi8zRlFsZHQ5aS84RkxtamNLU1RMYmVmb2xTZ3ZYSXN2?=
 =?utf-8?B?ckJBdlhTZ0tCQVk5SitFS1RteU5mWk94dFVtVHM4TFlNUi9DcTJmdGM5M0pH?=
 =?utf-8?B?RElQZnpKUFZTRllJdjExUFhJR1lXYmZKMnFhVEJEbHYyU2xMZ1hJcTU1ZDM1?=
 =?utf-8?B?bDVCYm41aVBGbTZEby93L3pLZjZZcUtNQ29ac0YvZ3pvSmZUbU01RGNCT1NX?=
 =?utf-8?B?UkhoN2VFcTZZcFZxekFFK3k1ckdvVEx2SExLZlZha2JrMXNhVnFOUkowVXY2?=
 =?utf-8?B?T3M4ckRITUtMK1grSzV1M1NCdTZ1aldsWUlHOFE5QW85OTRyaFVpSXFnaCtQ?=
 =?utf-8?B?NXRGTUpaQWIvYlhVUmFFeTZkL21Sa2c5YWI0OGVJK3JLbU8wdzh5RG1lNG4w?=
 =?utf-8?B?dUZwSi9NWXUzZmdoeFE4aWZKbksydkdiU0VYZ3hDbzRkZ01zR3ZJMEtLQ0E5?=
 =?utf-8?B?aGVtVUdGeXZaY2l2cGJyWW9iZkJiOWcrbXZubTNMYk9XZTFwN1FwV0pmOU5I?=
 =?utf-8?B?c2Q5S01vd2ZBRk5TVkZRTjVhdDBYOFVsSEhEbVI1VWFSaGE1UC9iODlzUUpU?=
 =?utf-8?B?c2dDK0JVNit0VEpzanJZdXZzdXl3cXN6N2JwMGdHRGNQU3Q2cFQwNVBmRzdi?=
 =?utf-8?B?YXljTlYrMzEzMzZGZkZndVBmL2I3d0lGMzdLMmhBaWV5WURYMDQwUHNncGlo?=
 =?utf-8?B?cHAxbnk5KzNmbERocWJVek9CRkg2TzJVV3hwQmhBYWdSbzBoV21NYnFaWFQw?=
 =?utf-8?B?STg0U1VUUnp5dkpZYnZEdERSN3hQUXMrNUh5K21vRlFreHFJRnpydSswNHRQ?=
 =?utf-8?B?UklacjkrRmY1THd0V1lMTVhIb3h4Q3BiWG5Bd2JaeFJIUG01OFF6cE5QSmls?=
 =?utf-8?B?bmVVTTlLSFQwd2lwdGRndFdpcWZqYjgvUjJpajNSTU84VzBLcERlTnNYVHpH?=
 =?utf-8?B?L29raEhGS2pjL0t5eFlmejVDV05mNFJoSkdXTmY2M0cvNG1aTTRSRlQwdVZn?=
 =?utf-8?B?eS9rRzMrUW1aYTFYNlJ5anNnMmtQYlcwemZSS1VQT2RyeDMxdUtTL3ZDV2hm?=
 =?utf-8?B?UFZ4Q1doUmdyQzA1WENrSEU1SDZMdWpGU3lrWXRYN0xlbHljT2FrM2ZTdm56?=
 =?utf-8?B?THBDZFpsVmxjZ2ladDl1SDI2SVdlaU1GdHRWSFZVK2hxSmlWYmdRcGFWYTRE?=
 =?utf-8?B?c3cyWlF1TzgwaExjMVkvVlJnVEpNWUJLWjVtalUwSDd3bXQ4a3BVNWNWMFFu?=
 =?utf-8?B?L0NjbGIvamRwUkRKUGV0bXJ0eWlybE5GVGVLMGVUbmw1VmhGT0kwYmoyeW8z?=
 =?utf-8?B?SHBJV2M0QVUyYkp1ak94MFRGR0N2VDY2K2NlTEVrMGQvaHRiVlNjOUlXM1B5?=
 =?utf-8?B?d0cvY1ZOVmFScStMSHBGdjcrbmxSWUp4MVNQWnZrZGVMRmV6SW9KUGRDZ3I5?=
 =?utf-8?B?SnNJSTdMeUorbjJJOWFpOHVaU0NLMjc0bk9Nek54N2VYUTB1Qk1XRWpTMXgw?=
 =?utf-8?B?NUpORjc4bTJIMjFhYkJvOERvc1A4eE5vUGJRYlpTRjZXRkhRMHlUWEM0cUIr?=
 =?utf-8?B?Z2FPSEVyMWRhTTJyaCt4MUFJUTM5dlkxNDJnMXZiRDl3aENKWG0xdllKaHpm?=
 =?utf-8?B?cXFjMUVPM2JiYkY5Ym1KdlZKS1dsVlBmekFhY2xDZjVLYzBhTEx5eE9kZ2NN?=
 =?utf-8?B?SjlKQ2NrMTZERmtQVFA4K0xucEpoN2k5aVc2aERBV01URmdmTWVGZ1lOTXBp?=
 =?utf-8?B?Vk9MZVJ1bUV6bS9KOG0vWXduak1CQTBncGRtNlcwdDJMdE1Bd28wUWpmNGJ5?=
 =?utf-8?B?OGJwUEZDbXJIRXZzRTkrUWt3UjdjUzUvRjFXalF2UE1rcUtRZk54NzdxdW1H?=
 =?utf-8?B?cHdLTzdITC9ZMDhyelBHTERJZ0JlK3RyQ1dFclJaYjUzdWlwdWwraDFRZG9j?=
 =?utf-8?B?dTVkbzM1RHNqNEszSDVMZnh3NzF4RXhsdHBRK2UzSzc0MDZvbnpPQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFD3BEF19E1EBF45A1CC1076693CF61C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14510.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef9687a-dc95-471f-8961-08de41f642cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 07:38:27.1395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGrqe6hMIZDDT1PNS8rAgmvEhznOZKdmk5DvC8apHeWHgfp/Y+56Rwp0dVZErPbXXgTyI+CD42IMUxQNNaf+nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15584
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251222_233839_512540_F122F002 
X-CRM114-Status: GOOD (  26.52  )
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

T24gMjAyNS8xMi8wMyA5OjUyLCBUYW8gTGl1IHdyb3RlOg0KPiBIaSBTdGVwaGVuLA0KPiANCj4g
VGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIQ0KPiANCj4gT24gV2VkLCBEZWMgMywgMjAyNSBhdCAx
MTowMOKAr0FNIFN0ZXBoZW4gQnJlbm5hbg0KPiA8c3RlcGhlbi5zLmJyZW5uYW5Ab3JhY2xlLmNv
bT4gd3JvdGU6DQo+Pg0KPj4gVGFvIExpdSA8bHRhb0ByZWRoYXQuY29tPiB3cml0ZXM6DQo+Pj4g
VGhpcyBwYXRjaCB3aWxsIHBhcnNlIGtlcm5lbCdzIGJ0ZiBkYXRhLiBUaGUgZGF0YSBjYW4gYmUg
bG9jYXRlZCB2aWENCj4+PiBfX3N0YXJ0X0JURiBhbmQgX19zdG9wX0JURiBzeW1ib2xzIHdoaWNo
IGhhdmUgYmVlbiByZXNvbHZlZCBieSBrYWxsc3ltcyBvZg0KPj4+IHRoZSBwcmV2aW91cyBwYXRj
aC4NCj4+Pg0KPj4+IFRoZSBidGYgZGF0YSBpcyBvcmdhbml6ZWQgYXMgZm9sbG93czogZWFjaCBv
bmUgb2Yga2VybmVsIG1vZHVsZXMsIGluY2x1ZGluZw0KPj4+IHZtbGludXggaXRzZWxmLCB3aWxs
IGhhdmUgYSBidGZfZmlsZSBzdHJ1Y3QgZGVzY3JpYmluZyBpdHMgYnRmIGRhdGEsIGFuZA0KPj4+
IGhvbGRpbmcgYW4gYXJyYXkgb2Ygc3RydWN0IG5hbWVfZW50cnkuIEJ5IGdpdmVuIHRoZSBidGYg
dHlwZSBpZCwgd2UgY2FuIHJlc29sdmUNCj4+PiBpdHMgbmFtZV9lbnRyeSBmYXN0IGJ5IGFycmF5
IGluZGV4LiBJbiBhZGRpdGlvbiwgbmFtZV9lbnRyeSBjYW4gYWxzbyBiZQ0KPj4+IG9yZ2FuaXpl
ZCBpbiBoYXNoIHRhYmxlLiBTbyBnaXZlbiBhIHR5cGUgbmFtZSwgd2UgY2FuIGFsc28gcmVzb2x2
ZSBpdHMNCj4+PiBuYW1lX2VudHJ5IGluIGEgZmFzdCBzcGVlZC4gSW4gb3RoZXIgd29yZHMsIGJv
dGggYnRmIHR5cGUgaWQgYW5kIGJ0Zg0KPj4+IHR5cGUgbmFtZSBjYW4gd2UgZ2V0IGl0IHJlc29s
dmVkIGZhc3QuIE9uY2Ugd2UgZ2V0IHRoZSBuYW1lX2VudHJ5IHN0cnVjdHVyZSBvZg0KPj4+IHRo
ZSBidGYgdHlwZSwgd2UgY2FuIHJlc29sdmUgaXRzIG1lbWJlci9zaXplIGV0YyBlYXNpbHkuDQo+
Pj4NCj4+PiBTaW5jZSBhbGwgbmFtZV9lbnRyeSBhcnJheSBzdGFydGluZyBmcm9tIGluZGV4IDAs
IHdoaWNoIGNhbm5vdCBpZGVudGlmeSBhIGJ0Zg0KPj4+IHR5cGUgZ2xvYmFsbHkuIFNvIGEgdW5p
cSBpZCBpcyB1c2VkLCBpdHMgdmFsdWUgaXMgYWNjdW11bGF0ZWQgYnkgdGhlIGxvY2F0aW9uDQo+
Pj4gb2YgdGhlIGJ0Zl9maWxlIHdpdGhpbiBidGZfZmlsZV9hcnJheSBhbmQgdG90YWwgcXVhbnRp
dHkgb2YgYnRmIHR5cGVzIHdpdGhpbg0KPj4+IGVhY2ggYnRmX2ZpbGUuDQo+Pj4NCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBUYW8gTGl1IDxsdGFvQHJlZGhhdC5jb20+DQo+Pg0KPj4gSGkgVGFvLA0KPj4N
Cj4+IEkgaGF2ZW4ndCByZWFkIHRoaXMgcGF0Y2ggaW4gZGV0YWlsLCBidXQgSSB3YW50ZWQgdG8g
YXNrIGlmIHlvdSBoYWQgYW55DQo+PiBwYXJ0aWN1bGFyIHJlYXNvbiB0byBhdm9pZCB1c2luZyBs
aWJicGYgZm9yIHBhcnNpbmcgdGhlIEJURj8NCj4gDQo+IEFjdHVhbGx5IEkgbWFudWFsbHkgcGFy
c2UgQlRGIGRhdGEgZHVlIHRvIHRoZSBmb2xsb3dpbmcgY29uY2VybnM6DQo+IA0KPiAxKSBMZWFy
biBCVEYgZGF0YSBzdHJ1Y3R1cmUgYnkgbWFudWFsbHkgcGFyc2luZy4gSSBoYXZlbid0IHdvcmtl
ZCBvbg0KPiBCVEYgcHJldmlvdXNseSwgYW5kIEkgcHJlZmVyIHRoZSB3YXkgb2YgZG9pbmcgdGhp
bmdzIGZyb20gc2NyYXRjaCBpbg0KPiBvcmRlciB0byBsZWFybiBhcyBmYXN0IGFuZCBhcyBkZWVw
bHkuIEkgZGlkbid0IGRvIGFueSBwcm9qZWN0IHByaW9yIHRvDQo+IHRoaXMgb25lIHJlbGF0aW5n
IHRvIEJURi4gU28gSSBzdGFydGVkIG1hbnVhbCBwYXJzaW5nIGFuZCBrZXB0IGl0IGluDQo+IHRo
ZSAgcGF0Y2hzZXQuDQo+IA0KPiAyKSBMZXQgZXZlcnl0aGluZyBiZSB1bmRlciBjb250cm9sLiBC
ZWZvcmUgYWN0dWFsbHkgd29ya2luZyBvbiB0aGlzLCBJDQo+IGtub3cgdGhhdCB0aGUgQlRGL2th
bGxzeW1zIHBhcnNpbmcgd2lsbCBiZSBydW5uaW5nIGluIDJuZCBrZXJuZWwsIHNvDQo+IGl0IHNo
b3VsZCBoYXZlIGEgZ29vZCBiYWxhbmNlIG9mIDEpIGFzIGZhc3QsIDIpIGxlc3MgbWVtb3J5DQo+
IGNvbnN1bXB0aW9uLiBTbyBJIGNyZWF0ZWQgMiB3YXlzIGZvciBCVEYgcmVzb2x2aW5nOiAxKSBH
aXZlbiBpZCBvZiBidGYNCj4gdHlwZSwgcmVzb2x2ZSBpdCBieSBhcnJheSBpbmRleChzb21lIG1l
dGEgZGF0YSBvZiBCVEYgdHlwZXMgYXJlDQo+IG9yZ2FuaXplZCBpbiBhcnJheSwgc28gZWFzeSB0
byByZXNvbHZlIHRoZSBjb3JyZXNwb25kaW5nIEJURiB0eXBlIGJ5DQo+IHRoZSBtZXRhIGRhdGEp
OyAyKSBHaXZlbiBuYW1lIG9mIGJ0ZiB0eXBlLCByZXNvbHZlIGl0IGJ5IGhhc2ggdGFibGUuDQo+
IExpa2UgSSBzYWlkLCBvbmx5IG5lY2Vzc2FyeSBkYXRhIGlzIHN0b3JlZCB3aXRoaW4gbWVtb3J5
LCBvdGhlcnMgYXJlDQo+IGxlZnQgYXMgZGlzayBmaWxlcyB0byByZWFkIHdoZW4gbmVlZGVkLiBJ
J20gbm90IHNheWluZyBJIGRpZCBhIGJldHRlcg0KPiBqb2IgdGhhbiBsaWJicGYsIG15IGFwcHJv
YWNoIGlzIG1vcmUgd2hpdGUtYm94IHRvIG1lLCBhbmQgZWFzeSB0bw0KPiBpbXByb3ZlLg0KPiAN
Cj4gMykgSSdtIGhhcHB5IHRvIGltcHJvdmUgdGhlIHBhdGNoc2V0LCBpZiBsaWJicGYgaXMgYmV0
dGVyIGluIDJuZA0KPiBrZXJuZWwgKyBlcHBpYyBjYXNlLCBJIGNhbiByZXBsYWNlIGFsbCB0aG9z
ZSBpbnRvIGxpYmJwZiBBUElzLg0KPiANCj4+DQo+PiBGb3IgbXkgaW1wbGVtZW50YXRpb24gb2Yg
QlRGIHBhcnNpbmcgZm9yIGRyZ24gSSB3YXMgbm90IGF3YXJlIG9mIGl0LCBzbw0KPj4gSSBkaWQg
dGhlIHBhcnNpbmcgZW50aXJlbHkgbWFudWFsbHksIHNpbWlsYXIgdG8gdGhpcy4gQnV0IGZvciBt
eSByZWNlbnQNCj4+IGF0dGVtcHRbMV0gYXQgYWRkaW5nIEJURiBzdXBwb3J0IHRvIG1ha2VkdW1w
ZmlsZSAodW5hd2FyZSBvZiB0aGlzIHBhdGNoKSwgSQ0KPj4gdXNlZCBsaWJicGYgYW5kIGZvdW5k
IHRoYXQgaXQgZGlkIHJlZHVjZSB0aGUgYW1vdW50IG9mIHJlcXVpcmVkIGNvZGUgYnkNCj4+IGEg
bG90LiBUaGVzZSBhcmUgc3BlY2lmaWMgZnVuY3Rpb25zIEkgZm91bmQgdXNlZnVsOg0KPj4NCj4+
IC0gYnRmX19uZXcoKSAtPiByZXR1cm5zIGEgInN0cnVjdCBidGYgKiIgZm9yIHVzZSB3aXRoIHRo
ZSBsaWJyYXJ5DQo+PiAtIGJ0Zl9fdHlwZV9ieV9pZCgpIC0+IHJldHVybnMgdGhlICJzdHJ1Y3Qg
YnRmX3R5cGUgKiIuIFRoZW4sIHRoZQ0KPj4gICAgbGludXgvYnRmLmggaGVhZGVyIHByb3ZpZGVz
IHNldmVyYWwgaW5saW5lIGZ1bmN0aW9ucyB0byB3b3JrIHdpdGggaXQ6DQo+PiAgICAtIGJ0Zl9t
ZW1iZXJzKCksIGJ0Zl92bGVuKCkNCj4+ICAgIC0gYnRmX21lbWJlcl9iaXRfb2Zmc2V0KCkNCj4+
IC0gYnRmX19wb2ludGVyX3NpemUoKQ0KPj4gLSBidGZfX25hbWVfYnlfb2Zmc2V0KCkgLT4gcmV0
dXJucyB0aGUgbmFtZSBmb3IgYSBzdHJpbmcgb2Zmc2V0DQo+PiAtIGJ0Zl9fZmluZF9ieV9uYW1l
KCkgJiBidGZfX2ZpbmRfYnlfbmFtZV9raW5kKCkgLT4gbG9va3MgdXAgYSB0eXBlIGJ5DQo+PiAg
ICBuYW1lLiBOb3RlIHRoYXQgdGhpcyBkb2VzIGEgbGluZWFyIHNlYXJjaCwgc28geW91ciBoYXNo
IHRhYmxlIGFwcHJvYWNoDQo+PiAgICBpcyBiZXR0ZXIgZm9yIHJhbmRvbSBsb29rdXBzLg0KPj4g
LSBidGZfX3Jlc29sdmVfc2l6ZSgpDQo+Pg0KPj4gU28gd2l0aCBsaWJicGYsIHRoZSBvbmx5IHRo
aW5nIHlvdSdkIHJlYWxseSBuZWVkIHRvIGltcGxlbWVudCBpcw0KPj4gcmVzb2x2aW5nIG1lbWJl
ciBvZmZzZXRzIChzdXBwb3J0aW5nIGFub255b211cyBzdHJ1Y3RzLCByZWN1cnNpdmVseSwNCj4+
IGV0YyksIGFuZCBhIGhhc2ggdGFibGUgZm9yIHN0cmluZyBsb29rdXBzLCBpZiB5b3UgZmVlbCBp
dCdzIG5lY2Vzc2FyeS4NCj4+IEZvciBtb2R1bGUgQlRGLCBidGZfX25ld19zcGxpdCgpIGlzIGF2
YWlsYWJsZSBhcyB3ZWxsLg0KPiANCj4gVGhhbmtzIGZvciBwcm92aWRpbmcgdGhlIGluZm8sIEkg
Y2FuIGdpdmUgaXQgYSB0cnkgYW5kIGRvIGENCj4gcGVyZm9ybWFuY2UvbWVtb3J5IGNvbnN1bXB0
aW9uIG1lYXN1cmVtZW50LiBJbiB0aGUgbWVhbnRpbWUsIEknbSBrZWVuDQoNClRoYW5rIHlvdSBm
b3IgdGhlIGluZm9ybWF0aW9uIGFuZCB0aG91Z2h0cy4NCg0KQ29uc2lkZXJpbmcgaXRzIG1haW50
ZW5hbmNlLCBJIHRoaW5rIGl0IHdvdWxkIGJlIGJldHRlciB0byB1c2UgdGhlIA0KbGlicmFyeSBp
ZiBwb3NzaWJsZS4gIEl0J3MgaGFyZCBmb3Igb3RoZXJzIHRoYW4gdGhlIGF1dGhlciB0byBtYWlu
dGFpbiANCnNjcmF0Y2ggY29kZSBhbmQgZm9sbG93IHRoZSBjaGFuZ2VzIG9mIEJURi4gIElmIHlv
dSBkb24ndCB3YW50IHRvIHVzZSANCnRoZSBsaWJyYXJ5LCBwbGVhc2UgZ2l2ZSB1cyBwZXJmb3Jt
YW5jZS9tZW1vcnkgY29uc3VtcHRpb24gZGF0YSBvciANCnNvbWV0aGluZyB0byBjb252aW5jZSB0
aGF0IHRoZSBsaWJyYXJ5IGNhbm5vdCBiZSB1c2VkLg0KDQpUaGFua3MsDQpLYXp1DQoNCj4gZm9y
IGFueSBzdWdnZXN0aW9ucyBvbiB0aGUgd2hvbGUgQlRGL2thbGxzeW1zICsgZXBwaWMgYXBwcm9h
Y2ggZm9yDQo+IG1ha2VkdW1wZmlsZSBjdXN0b21pemF0aW9uLiBJIGd1ZXNzIHRoZXJlIGFyZSBj
YXNlcyBvdGhlciB0aGFuIEdQVSBtbQ0KPiBmaWx0ZXJpbmcgd2hpY2ggYXJlIGRlbWFuZGluZyBm
b3IgZXh0ZW5kaW5nIHRoZSBjdXJyZW50IHBhZ2UtZmxhZw0KPiBmaWx0ZXJpbmcgb2YgbWFrZWR1
bXBmaWxlLg0KPiANCj4gVGhhbmtzLA0KPiBUYW8gTGl1DQo+IA0KPj4NCj4+IFRoYW5rcywNCj4+
IFN0ZXBoZW4NCj4+DQo+PiBbMV06IGh0dHBzOi8vZ2l0aHViLmNvbS9icmVubnMxMC9tYWtlZHVt
cGZpbGUvY29tbWl0Lzk4MTI5Mzk5YTNhMTBhZTcyNDA4YmM0YWFlYzI0ODVmN2QyMjA2MjYjZGlm
Zi1lMWU2YmQ1OWFlOTU2ZGY3ZDJkNDJhZDM1ODBiZDNjMDRkYTUzM2YxYjkwODI3YTA0ZTJjYzI3
YmJmMjRiMmE3DQo+Pg0K

