Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B207C74A5B
	for <kexec@archiver.kernel.org>; Thu, 30 Mar 2023 02:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZSlicIJty0PtqBSj4Wq4Y80+Ecpm2pX0w0ScOzFiG8M=; b=Zw67i6tOy29xku
	xNSACY4cS3dBABJtMw/eHa7mFEhBFnF0ybFTetdYl6tUhVrqOepzf71utivZYZ6IjTWZ+pJJ/Wwvk
	pT3ZC7s8Zn9jwAt6+KzK8almfhNR0yIKsYkyTYH+DJd86qoI7TRYN13W0XmiCM5AAgf2ROFQbOQb1
	TrJg+uY03PQHZQpSiQei2T1cxmWQwk5CW7c+MD923dKyHed5UDOczA2zGr/NO5pLdcwAvbM2kg17n
	ea35eteZ3pNCFlyrQfcSaqL1hfbrEmLQCnItwh4QX9xCKmg0HP8DLrhEZRuvv55QPG1LVSvcLzfnl
	zftmWsmvfVAX7DCebf0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phiDk-002MpT-07;
	Thu, 30 Mar 2023 02:41:00 +0000
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phiDg-002MoN-09
	for kexec@lists.infradead.org;
	Thu, 30 Mar 2023 02:40:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1680144056; x=1711680056;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=2mGAeJtFh/RhEwcQFFwD4bKks1Nbg1YFmtBKfCTlQg4=;
  b=Gj0hD60w8QSO4WYA5HgzBWaxxtlCKY06m4uiEjVmE6jdreQFqGQXRZ1/
   +bHJVIu3ODwtYKfCpq9O+M3KPhZM/o7vXuBIzWBtMEujrQzl3/7VyxNrZ
   NzKNkCDfniL4PPh29LlB7kUJCH9eZZrmXiy5IQ8xntwiG4tUM3/1rWwHo
   z4+I/ZX9jmDHhxpN8rC13zjRgQxXap0XerUEj9X/j5b3P+f0IKn+iIJB5
   tRWZp7yDXtkRjKB/AAa8e1iodgWrKf6/wK/pbciaB6JLkaEH+9isgthGW
   GnGu9Ee4kaNiKySHJHk7Vi2c6H3WB/j7Y5M1tyh6Elxbfq2/M8FStLGxh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="88370189"
X-IronPort-AV: E=Sophos;i="5.98,274,1673881200"; 
   d="scan'208";a="88370189"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 11:40:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXja2/QkTqwSie0hOKInzYYFUIuQCEjAgC1OeEkbIH+M+GzkamdycqgJw1X8QpEAzQL39CvZuDC7rflNLjKxlt6jwMXBvTcH5qPPtPyEC/g3MY2dnCSulHzuYerHy3QGDV8ajtw7HnPmBDkTc2DZL3U4MROWLPYxYxE/+FNxFIV5rzMUH+PlGHIpXE7KgGclQaWXbUxM25Ew/pzn6lTbLN9Kmx9TdyqS4WcVT8ze8qr4VE1DOwtobtS2QaMDFKf0Uh8phdI9tpg4RlGooyZXQ05/Hgu7Xm2xGZ7x/IRiu4IlpNTwJu2IsN8BRz9xp2Ar6JbUfBTQgJUH7C7Kq9UfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mGAeJtFh/RhEwcQFFwD4bKks1Nbg1YFmtBKfCTlQg4=;
 b=DXCpUaj/LH+7zRZSArr2seasF1tmeG163xxoJLaI31mu5sFJ+wKEAiYZlw5ktb+dw+6DI59AYgAvjReKKd0Xg7ak9ozjwxCCvt7rjtwHKrBorRUhwS/9y6QygdOKe7OqUapaP3RGHbI+ouZf124PVMPEYVklMxUqoDAA3AD1RLG3xfkWfRSOhiJ0/V1RUWQB0endeT0tV0wWXK8wzJI4H4F59BjksW4pLqsl1lbXTO5Wrnte1O19YlQTKw7ml5VitRWjy3k3p2SlrX1LDdvvQ+Djj5h78nGQ4qPk+79aM9kO05S+Da0RmdEKeWJBwY79slm8iFvjkGXHNyfmzIZwhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6507.jpnprd01.prod.outlook.com (2603:1096:400:a2::7)
 by TYTPR01MB10990.jpnprd01.prod.outlook.com (2603:1096:400:3a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 02:40:44 +0000
Received: from TYAPR01MB6507.jpnprd01.prod.outlook.com
 ([fe80::f60c:5581:7f21:6a78]) by TYAPR01MB6507.jpnprd01.prod.outlook.com
 ([fe80::f60c:5581:7f21:6a78%5]) with mapi id 15.20.6254.021; Thu, 30 Mar 2023
 02:40:44 +0000
From: "Daisuke Hatayama (Fujitsu)" <d.hatayama@fujitsu.com>
To: =?gb2312?B?SEFHSU8gS0FaVUhJVE8oyGPOsqGh0rvIyik=?= <k-hagio-ab@nec.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] makedumpfile, sadump: fix failure of reading memory when
 5-level paging is enabled
Thread-Topic: [PATCH] makedumpfile, sadump: fix failure of reading memory when
 5-level paging is enabled
Thread-Index: AQHZYjujRAxvHo5Cwk2zeTnUkMOGSa8SmWIAgAADpiI=
Date: Thu, 30 Mar 2023 02:40:44 +0000
Message-ID:  <TYAPR01MB65070FC33DFEEE0B92F3EC5D958E9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
References:  <TYAPR01MB6507807A942C53AB8BBE834395899@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <5f31e4eb-5768-bfda-3e3a-289d5944e014@nec.com>
In-Reply-To: <5f31e4eb-5768-bfda-3e3a-289d5944e014@nec.com>
Accept-Language: en-US, ja-JP
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels:  MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-03-30T02:40:45.188Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6507:EE_|TYTPR01MB10990:EE_
x-ms-office365-filtering-correlation-id: 604a06dc-036f-45ad-29b1-08db30c82941
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  yl1hQ367rj4d9r2DcztPzEpjjK5fQMvtldXy0re1AwVn+l+7o/F2YA4aEc4bfnzxKPxwM+Ta2Ea1RhPRXRGPOLeYQQcoW6PZb7zXBKcYTrdtY0K8XUoEqyBo/eBRh8VYrAr0AuQH/6pBvqbzac1cjHe6sFGXmnZxNtQ0dlcNIRcoQ9PEtvgygB9wm7fKnQj0sSrlzhaOWt4yq9WkElhBohFhRQqUA5ubcUUczsubDi7iMOl2IhxvS0tclnxXuM1TI30c0GNtkAq9+cXV1BkB+unhigcBlbeEo8PnMB4PQ5hs+bkBLLenODN7RuGEMn2u4EL4t7oDXdhzrBSKfMKz6QhIE8I4UxQkVPRcwF2vZHSwsZAEuwyzGJ/xSxR29eEsYiGYwIElcMimGpciOjg3O0Lx/eaaenrc1dxRtO6fvCmC/oxPaKMnze0t+vvkoZacTI06PEjhCJxqD6WEhsj8I4UQxBLs6obt9euJU6dLt2SOQPU2NPGtjK9svnvFEiu+s4GAb8lqnGCcpA1gtQi62YDVKjs3Zmkm1DTFLGvDbGi9XmsaVf+OJYFMYhtAW+/P30xPHz4QzMPpp7ouBAlQ3wyiDI5lRC5q20i/oX2zHRQdKSn+bZSrxnU4kegWlqVM
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6507.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(1590799018)(33656002)(558084003)(85182001)(86362001)(1580799015)(55016003)(478600001)(82960400001)(316002)(966005)(8676002)(7696005)(110136005)(66946007)(64756008)(66446008)(66476007)(71200400001)(41300700001)(9686003)(26005)(6506007)(186003)(76116006)(122000001)(2906002)(66556008)(38070700005)(8936002)(5660300002)(38100700002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?gb2312?B?UWNteDEvcWU1eHdKazFpSk8vY1h3Nlg5SlA5R3RIVTVuMDF2RXBwOGppQXFK?=
 =?gb2312?B?TmZqTVVwcW5KZDdBSHdWRFF2OU96TVQ3dFN6T21qMTFYcWxhTGtZS0V6NHJh?=
 =?gb2312?B?WVNMLzR4dE9haHVUb1VETFJmM3Q4czV6QnRpYnR2YnBwT3BSL1JMZEZQUmdw?=
 =?gb2312?B?S3EzcmhqTy9lY0RXdTNac1V0cHNYNC9wMGczUlRBZjNvdTZPZkFPR1BUMUlu?=
 =?gb2312?B?UkEyQStnVjZrVWRkeWZiRTE5SGV3K2ZaaWoyQVAyVHp0YmduVHJTK0ljdmlM?=
 =?gb2312?B?YWpuMTJUaHdPTkNEUzJUMStrYlc5MTV2RDgvNWptU2pkaFFhUk13N2RXdStj?=
 =?gb2312?B?eGZTL3ZmSHRXbVhzQXVjWVZkaDNIYVFaOVdGNGpTN2xrSXlyZjNsNjZqT3px?=
 =?gb2312?B?R1V5UWdFM3I3d2c2bkZ4TE1EaGpHVnJEeE83R09rSktDTTRmeGw5MiswbTZp?=
 =?gb2312?B?M3NzL2NMQUowOXN2QmNOZFB0dm9MZzhzaURRRnZubHdYOGUzd0VCOWdZb2Qx?=
 =?gb2312?B?ZkNvVWJMVk5HYlJDcVRreEZQdk4zNmpwNnVlanVrNUZSVStuanRuVEs5YkxC?=
 =?gb2312?B?SHBPSGFQQ0E0OU5yeUkwTWlxbDA3SVNCL2wwZDVwQ21sdTRpSjcxMWh2RzJD?=
 =?gb2312?B?b05UVEpkU3RKbzBQOEx1VkFmeno2ZVUrbFpPWXdyVjlCNUFEeEhWS1NMSUoy?=
 =?gb2312?B?bWlqTmQ1d3FUS3JQdHZLMnZCa0dNcnY4b0dCSFNtUGMwRkpXczg0eVVWOSs2?=
 =?gb2312?B?U2VSZFhHTStSMm9SeUFRSEJzNGsvVEF0QjR0RTI1bWdyc2RtckxMTkwzQVZv?=
 =?gb2312?B?VVBrbWwrekMyeGZDbmZYR0wxczkwT1A0blFLZnhnZllTUEM1ODVRanZUd0RT?=
 =?gb2312?B?a05tT3BrWXBXc1M2NmQxYkdqQlZtZHkwQVpXU01sWkpBeUdYWGw1NjA1dG1W?=
 =?gb2312?B?Tm9RUHc4N25OMjg4MDNteEYyYWgwOFl6Lzh5TmNtRjg1Wnd6MzhjTC9CZFJQ?=
 =?gb2312?B?bHlXa3FIQjkzSFpseDF6S3hhNWdOem1jTmRSVDQrQ0tOc3RaZE05VWQxT0xy?=
 =?gb2312?B?cHNUU0Jta0NiMVJMYmFyL09FWUs2Um1PT1Q1RjJaMUxxTUYrYmQrOFBEczdN?=
 =?gb2312?B?aU04MC8rc3VxcXg1VnFyb28zMjFsRGc2Q0REWG9mTFVBZFRJZ0dnMmlyNDlq?=
 =?gb2312?B?Mmh0aWdYb0tMR2wxeTVHTHpwb1NxRVh3bjB3Mms5all2L2o2N2FmcEZSbXFs?=
 =?gb2312?B?WW9BNE1KNjRqOHQ5TTdnQXZ1M05yUWVzS2tVSnNRcFNCK2tUamtONi9tTjUz?=
 =?gb2312?B?TjRlRXhOcDhOQmlONGFkZUR1aVppYzh1YXVlak45R3huanFDbTgyTFJaTmVL?=
 =?gb2312?B?TkF5L0RndlR5RjIxWG0rNElnYlMrbmRDMUdjWTBqZDVBL0sybmw3MDk5aDF1?=
 =?gb2312?B?UkhZRFpLS1pRUVhHa2g0RTVQS2h5YU4yWGFUdUU1Zk5qYzlNeVROam1mNlM3?=
 =?gb2312?B?ZXZ3SjQzVitVcGJhR2JpZVJlY2VoWnlQcHR1VWMzNlZYYzVlaG5KMDUxN0pV?=
 =?gb2312?B?eGpSZE4zbmVMZmZYRWU5RVBqN01ZdjFLMDlZbjFabmFzVzI4b3dHSWw3TjdH?=
 =?gb2312?B?WkxoRnFpempTRWl2UmRqVEhYNWtjMjl1aExoaHFrRTJwWmkwTXVJZFlubU1z?=
 =?gb2312?B?OFJ2cFRXVXB6bUxyTUVOTmJpVlJMS2xObXplT29ma3dUM3ZHN1dYaDk4NC84?=
 =?gb2312?B?MkdTeURkWlVOejc2TnFkWmlWQXhST1BYeUhrZnN4aFdpemhDR3ArUmtUQk8v?=
 =?gb2312?B?bDZRTHVsZnpYUjF2ZW9DazcwQ2hwYVg2YXJIM1RDY3NCbGtEL3djOFU1SkEw?=
 =?gb2312?B?UmlCT3dQYUpVa2Z5ekJqa3BCVHU3YjBDcS83SUZGQW5vY2VwRnJDd21tOFRx?=
 =?gb2312?B?VzdaalpzWk1Qc0R5TndscFRFRFU3UXZLLytmcVBGYjN4dGlmVnh0ajhCRHlB?=
 =?gb2312?B?MWVPWUhKZ2N3b1MzaVEvOUpmRHd5VnlxRE5EaHQ5T2d3ZDVzMlp6bEVLRTZk?=
 =?gb2312?B?S2xUYlNybGZTRWFVemtLc3lWaDhSTjF3QU1vVEV0L0Z5ZDVHSHlXUU1rYlRW?=
 =?gb2312?Q?XGdVFh+F/pkor6pKmhpMtPZeB?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	S0VIPNxs4Moid9JXPBeIJaTg++3D8RAlLKo3SnGdwt9eJbVIAI233GdllbPi1WphGkIygaP+eyhK4jEjQynawQJ9q69UUZAJTC8fwejZsTSLN7VOGT1rU/d/tdWEX5kp17ltzrSqs81KJ+t6KOsxpuaNcA3oTAFjysZp129k3dV4EFckrgtcbQUg7XLPFJwzwxxtYvKWc6HaklG2EEgMlYnMoglYvFJlfaiMxeGimT26Lm+UV7hAp1AEJ72sn0yNbsK1KgJWHA43Tgigz8srzbOtONhZCxj8yxcTbGGFkPTb5egFYlVS+6ucAdJmjRqWOuNVygAK1UlTJxMlGym861iIxOERp7UjksiYTfuNEmZi1ShXOa4cK4YuAJXH5e3OcQQM9ytwPd0FyPjjPkPXfyQ7XVNQxocyRX+yp65uAsGp4jVgKhtU/dXbfZSa4OXGxHGjrsjfFqsyciTY5QnxiksFnhBVjl18ts+8n2Nx7rbcG2Y9M9yI0Zwa/akteBvh99SxaZ4PZjD8FfYh+K9k5CeAavxPPnodLrNer2gJtarcfRrLDJNyewfCNOXqs3PPMNbq+HHl15X2oADHU6fTLMEkLfXGNZ4aXToNxhQj5FKK/YRyvS7r8kc5uV59eJWPtVAguKO6rLbJp1u+0B3icXQsLLt3SN7c/AkN018h9EoEEKWbF7Y1uR/tdhvE3w50FMMhzn+Po5hb6ZeQntqCchbcgB8ssHiHeSmDPjlKgp07ZypYRbsx+heQV/XDDi3p6J2glQKCiHhbL8dlu1ktYwyj6rnVkUmIS+IlhviXbMD/lJVB+vfZscqUW9jgWJqu
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6507.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604a06dc-036f-45ad-29b1-08db30c82941
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 02:40:44.6626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QhPJG/UrjKFJZneKArHfbgKXMvHh3P0P6fzzpLuy6xyRshDKdPUQJoF8qgxzmmb3ONqbcDH6r78u4DiOFoqLnP+5akKA5LvIH6pQp595sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10990
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_194056_535536_70EECCDE 
X-CRM114-Status: UNSURE (   4.65  )
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

Hagio-san,

> Thanks, applied.
> https://github.com/makedumpfile/makedumpfile/commit/58553ad03187f0cf208d6c4a0dc026c6338e5edd
> 
> (oh, "devide" is there..)

Thank you for the prompt handling.

Thanks.
HATAYAMA, Daisuke
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
