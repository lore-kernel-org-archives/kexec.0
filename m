Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F57C4345F
	for <kexec@archiver.kernel.org>; Fri, 12 Apr 2024 05:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=V1hrIa6q+Icn39mUaM8fDAmrRu5ynxUBbz4x2q1OxPw=; b=z4Sb6Jh/7FyS4o
	WupVqX+20vQWWsSE9Ti5ibxCW/N27TmQV0BX11K3IF4armoWc6YTJYGtgFO+G/lBLq3E6WFR0E1nc
	WOCCnM6mcOYZQqnF5s+Y1oJMvH8auWcYPl3wvgxWCC0ntGtm4GG/bLITeFoghnZtZE5n5nbKX7i4I
	KN90yhHyq5zkVlaTsYLJdxpSyi1xamh4nvyuKTYE2CvUW0dDsWYwvDQJki9NNgJzzXfvRaw3TS8py
	5+0xZyVTsYhtWoNfyBR7LOAiSCAh99bRBYDqY+TPk+Lo3m0NBHBlNjBEOSrKYxnDirZZIlmd3zCcy
	Ta+szvASOZFHecyrsbJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv9ht-0000000FRk6-0IP9;
	Fri, 12 Apr 2024 05:44:13 +0000
Received: from mail-os0jpn01on20601.outbound.protection.outlook.com ([2a01:111:f403:201a::601] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv9hn-0000000FRip-23Od
	for kexec@lists.infradead.org;
	Fri, 12 Apr 2024 05:44:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n515n64ip3XugTEhvszm+aZxsCAsGtOdl8JAt82aQ2bKFsKDT09/icghU2fokxJssvJtGdQMnMKrE6APcp3RiunPvCl9v6QCLUYOtb5MW24K1h6jGUEZzz2b/y4AJUAgHVnVIwg+x4KSstZN6dbe3dQEMmqRbHqgVWXFoE7eUulIA0FIlIiAXbRvjwcguP/qKv4IJxbXGdms3FTW/tHuDEEbzdrV+CvyvHPfad6dj7RRAo8hVMOGqCm+15IULsUfl8adoGQvjQi4Ek3y4cucYxD9YbzJRXBE8N9MsNV1dQOWi/KBVbeq5SZ1DyC8VCqjZ2SlJxmZfwEMFHMOfOfK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fGxbztjSvKZ6EafFE9cciNhEwjucr65EshhFCvqmFM=;
 b=SaAFWY7EtPb3F4hfzP1w0cFLGazJM49VCy9pHJvvNV1t94xD72lbO/WDZhuvxFfHpz6qQIB1499SMGY0QefNLP1YhvIIvEfn0eopsm4rmF9OI1UCLCV4duj8Y02KLedRHV8z3fnF7Pxyo5vY4WExb0FXpkk7rjKcs6g4NJI6DF82Xiyz/QYi3+D8Fe2lj94++6z4aemvIUHHjKRchGnkX48i4A1HdZSYxs4DuDMKoRAfvXYr3kK7VNcGchdHY9rdDWzUWWlOim3T+F1L9fQ5KPPasMcXKs90dfysjF3ER3YyU/ebpfPlNK9zBh/AnF9aL9OsfhPCgo5Hc2RsiYp2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fGxbztjSvKZ6EafFE9cciNhEwjucr65EshhFCvqmFM=;
 b=VPZaugdGn1JxPr1OCjk8yRx6myqV3hVxNlcoGPlyB/QRYNcQ9zFgGnLGaZKHXgwqLENEgBWlF+Z7YBnllLFuwhCsDxbq8YaHIQrh2GfgOmx8pu3LZZnDSktDCJxszR0pbe3dgKvT+hVzEq5g4g7SQaHfCfwEy7S9z1Nm50jJ2mpB/XijvK44eullnmQo/fXGxvMXK2kD414iwxisJHkiKfdz+0JT+bCATbAbWg6D5RQWs5mb5Mf7VyqO18S+g1f1geZCGQSoVXu4PZwLMqmaGFuC41VKz2Lo+DTxYoTd6bL/ayALfshz6xgmORRugEuGTmDj0faZ7lYADkI7z40eYA==
Received: from TYWPR01MB8608.jpnprd01.prod.outlook.com (2603:1096:400:179::5)
 by TYWPR01MB9759.jpnprd01.prod.outlook.com (2603:1096:400:235::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 05:43:49 +0000
Received: from TYWPR01MB8608.jpnprd01.prod.outlook.com
 ([fe80::a059:52a5:50dc:dacc]) by TYWPR01MB8608.jpnprd01.prod.outlook.com
 ([fe80::a059:52a5:50dc:dacc%5]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 05:43:48 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: [ANNOUNCE] makedumpfile 1.7.5
Thread-Topic: [ANNOUNCE] makedumpfile 1.7.5
Thread-Index: AQHajJxk7EGXMfCcQ0S06B3QBR7bvg==
Date: Fri, 12 Apr 2024 05:43:48 +0000
Message-ID: <2caf15f0-dff1-4097-b980-77d8aae4d213@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8608:EE_|TYWPR01MB9759:EE_
x-ms-office365-filtering-correlation-id: ddb9a607-032e-4068-d33a-08dc5ab386f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hs+w3vw2+ZVzGL4I+vTklzfaUz0SgsMzqcNb3DUsar2idmkLLghtzXL0LK98azAY60YxIBSf0P0LI5DU7+MHnI9Ms3GysFGD8zQTciJr8SF0r/Ha5WlGicQNAwNQmSw9Sl8axhLEgiuLzUT87BYKNs/2Uc1E+4JxM1wELemTzzI0maUUJSv9a6YFFs4ejF0Mypj76yvJAgr8bVy3woyIFTjHnRTEEmxXmXO+/Ig5KbhStCFCAO3e4eVG8VOD4Li/pJEpKw/96kI5BLILYgP14H5OF0DOcs0qH3KFZhQOdNvbDjHOXvIJM0cgFFiJjEvb/NgVOY2+lAqbh1Jehp0Oq7Kym4AuGfJvdQ3YRzghF+P8dknkoUxyonZtkx7+k91LE/P9zQPO9JzwgOPWRVEiJn+BKDojoam8NreSKbelr85/dUQdo2e2TnSMsgFf9t/QJEAPeNKKbqw8WvPZ6jwQTiYq5FEgOjIL59rwlri/DUkaS+/igiFJyDbQg11fYpuKKsm+oufrZ/KAvKswMkYu2iy7Zhb5wh9zrbk70hDG1UD4fY6dTEh+zXTHOsslddcrgF4XLgsLqcEIPpq8KkDl8UaN8B1PLy+YFqIQuLzbfKWRALKqPMQQiCuV6isAy7dYfGcCIfWcdwG1werl92be+3pEN0BIMt1U7l0vdy7nJ+o1YIXz27wRLr+rr0mzW8HOQFltsTifZk4YaV3MQ7p1mjPG6tIaFtfC11auPDBht1k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8608.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTR1MFdYMG9DeTJWU0hzY3FtNXMwUUhQQTYvcHBrZEp0ZW5OWGZZeFFQUlht?=
 =?utf-8?B?NFZPSEdGOFRWc1B2bkdQNVFtVDZBYWtrZXA0MEwwMWl5VnNnb1NzVlhWNm1F?=
 =?utf-8?B?NGxMRnVGOG5ETWRoWTkwcGRIV0tPcU1adUYvWWZXdUwxVXpobXlXU21zTzNj?=
 =?utf-8?B?QVhJemYveTQzNFYvRVJWTGpoYlZ5UHZtL0hMWjJ0NXZhK0F2cUtUdWIvRHRP?=
 =?utf-8?B?aG1GZlA0ZkVKWHNJVG9WZ3IrK2c3aURxVWY4a2wya1hRcjVobm1JTnplNi9s?=
 =?utf-8?B?Ynh0b2UxcmR3ekRTMjFYTnBtejJKSW1zZGZwUnMyVThKblM4dG5xcjAzRDg1?=
 =?utf-8?B?K2VGVHF3WUYyVU8wbkZpSUt0aE9MOXpsc2lvL2dxdnRZaDl2SVQ1TnFZeU9s?=
 =?utf-8?B?b2VnbUV4Q3dyQ241R1JXYXpjWHV6UUhaVTd3MWxMNVlla0ZkalVhWWFNMUxN?=
 =?utf-8?B?bU1tb29JV1pDeGRjNE1BT1cvejhPaXR6STJqYUR4cjRJbnQzdFM1dEgwVG9G?=
 =?utf-8?B?Wk5zMzBYY203UHNMblcrM2RhVUY2UitIdDBhR0VVL2hxV3IrVEZZdmthOWFC?=
 =?utf-8?B?a0dNQy8zcDBEdEVrSERwVExxZkpwRGJsTmZqR01Yd09HdHRyVCtiLzlvUk9K?=
 =?utf-8?B?eVlGZFc5OEg0WGVHUjgvTUlER1d4RDBoVEV5bjNDVnFiVTRrT2pETVdkK1Nm?=
 =?utf-8?B?ZUp2dGhLSE55WXVxc2xOTGJRSFhYOFlva29BMkNBVUhVK0IxTTREem1reWNU?=
 =?utf-8?B?Mkk0SWJONElDQTF1eUU0bmtKZWU3bE50V3VYclhtbHptOHhiN1lLdHVraE5M?=
 =?utf-8?B?am05d0haa1BEazB2KzlsWTVHTDIvaiswN3dXQ2c2OWlLdTExaTdNVzJCa2tz?=
 =?utf-8?B?NTZxZy9IYzUwWTZ6SXplQklpZ0xJSjVRZjBHUUhtanFzKzFScjVObzZ4aWRC?=
 =?utf-8?B?dWgxQ0ROeTNiV25WY3Y0RVFPRXVaWDNobklWRFhKbnJvSEhZQ3dCRCtlbEhv?=
 =?utf-8?B?b0FPQjV2N3NWcVJ2STRML091L1pjNjlzUUsydjlaaW5nU3dQY3dONTBVSUdG?=
 =?utf-8?B?TFVkc1ErMlFOVVd1OWlvaHAyaGd4d0J4MDZXZi9PNXRGNVlJd3pUQlVSU0ti?=
 =?utf-8?B?QjFvYmpERjBpbDVlN2R2YWJndUw5Mi9qc3NMcEo0Ryt6eTRIL2grU3JzYWxE?=
 =?utf-8?B?UFFSZlFDOW0zRStnTEh6bVhUaHhhVXpjZUkrVTVwaktualJQTmxWa1NVMmk2?=
 =?utf-8?B?Z0Y5eTBieTZJc3d6b29ackJnemNjOWpDRkxsRE1iYk9sOC90MHdyeXJFMWJJ?=
 =?utf-8?B?cWl1b2k2WDU1ek1ieUtBRDV0cXlSMWN4ZHdiR21HY2RLZlN6RG1GU0MwYXVo?=
 =?utf-8?B?YWVwNExwa2luSzFYcUF3dTNLdnNYYjY5bzZPMVlIZ3JMS0dHb0xtOFZxZUZj?=
 =?utf-8?B?OGNxSldyQ2MwWUdqV0VrOEEwM1FYRGVZNzViY1VsQnlzelRiT2p6S0xXblBC?=
 =?utf-8?B?dVIyeFJHUFIxRFpzWUdFU0dyNXY1dXNUa2QvcDNXbm83WDh0RjEyOXJsZGFZ?=
 =?utf-8?B?UXJsMmE5cklLVlRuWFVPWUxXeEI4VkM2Vy9hRTdkcEZUVXpMYmlYZnY1RXhY?=
 =?utf-8?B?RDF4Rm12TURaTHd6WGhaM1lZS1VqMmRQWG5CVW9Jb1VXQUFNTWtCcVNFSjBV?=
 =?utf-8?B?YUZ2dHJSWU5wRU1oZm0rZE04alNuRHB5TlIvYnpNOWsyR2R1SjdQVDJQdW1E?=
 =?utf-8?B?eXdScFE2WnpmM3FqR3BQMlpMNytEM3ZIeW4zSk5KazNNdHc4KzZxNDlEM2F6?=
 =?utf-8?B?ZWF5SnhGbSt2TnVvdk91UnhpZnZXRU11V2liS1VOMmp5WUU1bHZIWEVXODFh?=
 =?utf-8?B?TWVhSFdZb3d1Zmh3MkVISVA1a2tnemorOFRSNmk5QjdSRFpwc1hZYWUwVzA5?=
 =?utf-8?B?c0tKeE93T2cza01uQmJnMi9QYWRoZ0R0eDF3Zk45bWpoNEdKeFI1NUlGWEhH?=
 =?utf-8?B?NU12MUlqZytmY1FudEFwZVNkM2ZhclBwWm15NGJuVXRkSUJ5TFFWR3FhWUsz?=
 =?utf-8?B?YmpvSDlocmhpL0hVTmxWNHdvcHZmWVJqUCtxOTRKUUppOWZMRGJKekUwM25D?=
 =?utf-8?Q?rGT3jy2Y2l/x4TU7U+f08vrLu?=
Content-ID: <A08C07E1C1DFFE4CA25AD9265C89F165@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8608.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb9a607-032e-4068-d33a-08dc5ab386f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 05:43:48.8897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Orgz9kHeEUpDLKvLI8YH8txK/7dk4US9yUuHMettxQB1bY5QO8nrMz1gLX7wZ9jm+WWUrCeFK7sh2yzYZXT9Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9759
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_224407_787848_98171744 
X-CRM114-Status: UNSURE (   7.05  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,

I'm pleased to announce the release of makedumpfile 1.7.5.
Thank you everyone for your help to maintain the tool.

Download:
The latest makedumpfile can be downloaded from the following URL.
    https://github.com/makedumpfile/makedumpfile/releases

New features:
- Support for kernels up to v6.8 (x86_64)
- Support for printk caller_id by --dump-dmesg option

Commits since 1.7.4:
c266469 [v1.7.5] Update version (Kazuhito Hagio)
94241fd [PATCH] ppc64: get vmalloc start address from vmcoreinfo (Aditya Gupta)
71ac00c [PATCH] ppc64: read cur_mmu_type from vmcoreinfo (Aditya Gupta)
48bb1e0 [PATCH] add PRINTK_CALLER id support to --dump-dmesg option (Edward Chron)
6f8325d [PATCH v2 2/2] s390x: uncouple virtual and physical address spaces (Alexander Gordeev)
7bb90b7 [PATCH 1/2] s390x: fix virtual vs physical address confusion (Alexander Gordeev)

Description of makedumpfile:
The makedumpfile is a tool for creating a dumpfile from /proc/vmcore
with filtering out unnecessary pages for analysis and compressing the
remaining pages, in order to shorten the size of the dumpfile and the
time of creating it.
https://github.com/makedumpfile/makedumpfile

Thanks,
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
