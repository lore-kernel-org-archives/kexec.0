Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A140DC74A5B
	for <kexec@archiver.kernel.org>; Wed, 29 Mar 2023 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wRQfwg89yrQu748guUhPZkpt7EIwbAduITX/QzkplIs=; b=yvfVCgVmx7yE2l
	MV0VGHY+ZyiGvRl4x2V1N4okYP7rwUfGosGIU0JCoiQT/XD4eMBGrcIwJ5ESlv2crGesmuYsD7agr
	/CKRfiP8Pc/xyY1XEe0Y3i7YvHIkjwQrnmomfqwsvjd+X67KExvnDfcc+d+BiysL7ZE38V77rM6oI
	y011+j3IG2iZxglIM8zoG2OtJBQpITVwZRgR9RyPhbFDmkkcEn2PouzmXd8NNa/7dN/Hua7MNJJiZ
	6YOyARlFVs023dOxbyxIzrPjtDJXsiFtPIKEQfPycHkqTX/GYh+TtBI0OGP8GQEMPKgXQTeyBYL5G
	rQu5VGReB6zcIdZarDmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phVAC-000DuF-0p;
	Wed, 29 Mar 2023 12:44:28 +0000
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phVA8-000Dsr-0l
	for kexec@lists.infradead.org;
	Wed, 29 Mar 2023 12:44:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1680093865; x=1711629865;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=p8c4xw31Il1biIaZmjd8Wkph08NCyUgnPlUEHVMN6xo=;
  b=k4Ch7AAAO6cNne4PZhqcoRflPx8BHo1zPD9WwnnxsZLNlYc35R9UuMf+
   l8UGaqdqsTId6xk+lvCZ0kPk5hXdQLfJKfW2o2ohc4XpEKlbw9hUEwU2C
   8WRFYQ5bd2mPnhwOEM5Ros80vIbxXiw1kUJ5BvHSjrJeLXfTQQnQFumAI
   Aye7S7XIsq7CZcuoHFgdesleSCDGCnAOzNRLge/PpJyqgvYmLsmSYLSLf
   PanMu9yF+K8KZgpMgEj4IRjWY10rMVzS/lKitdeTupcbpeYEbRJxag176
   tJ2ZdnuIBVY2mbUC26TQBsHhBJrPJhVeYV8ON5F68/z170CxMVCOZZ0iz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="88321650"
X-IronPort-AV: E=Sophos;i="5.98,274,1673881200"; 
   d="scan'208";a="88321650"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 21:44:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMmYZTavtT1qSShSbdSsAKxGeC8IXuYwxiQ0Z4nFQgZGOPymyuTXok3/JwfopAwvhD/B4PCVcZBTBjfNHRSeqT4B6i+0ba9tsXoWZi110pXGgTnSftjFzYsoVW0guLvltixsQQfQZv13qJHMta3OuLxOUjkAR8omsOuKwexFKLNs97F2EqNl+0QVj9fo68luRKxZSqNjqpr7o+oOUKinjDscSNo7DDOD1BCFSXRm/uZf6GNQVz83CI0gEcFqKfKs0Uknt0wZ+xF5k613MWgyreTOfnxmcgS9ukwh3Sl08lhy/pAw9stubjyviloY2rng2FTG4fO9j1+mHjsIEEMoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGFR3xjEPR869mGPKZUplJD6srABoQpBTWy4f9Ggog8=;
 b=bIUKZgt8rw2gkUAE58zQoub3wCAteaM6Bnuwsf38x+qnPwMVY99VhqFiIlm0WrZOVAlB/DgvoUyB0ENcAhJahFDdOt3e4sJ6HmfEAnt+7ms0RQS77/Jz5QOEvv/8H3vdLdE1i29j35HMjXbxGB9mdRzo6fWeiQNGtMDxXa5w8JVnfeKFPx4b5hc9UPcvUaPBa/zm3O6EZu1RVf87L4I8Kel0V/5D3lXzhIFuHxddQ0b6E8vdmPTtP76zcE1pxJVKca1TRMutWuKK1HKhk22n3b4vTFOiFbsMBrvbz07z1Xt22ToN6+lCjXLSIIvy0tGlkhTYon5wn89ZiIaiFiYfNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6507.jpnprd01.prod.outlook.com (2603:1096:400:a2::7)
 by OSZPR01MB6294.jpnprd01.prod.outlook.com (2603:1096:604:f6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.34; Wed, 29 Mar
 2023 12:44:10 +0000
Received: from TYAPR01MB6507.jpnprd01.prod.outlook.com
 ([fe80::3e5:8f9d:c0e1:802d]) by TYAPR01MB6507.jpnprd01.prod.outlook.com
 ([fe80::3e5:8f9d:c0e1:802d%9]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 12:44:10 +0000
From: "Daisuke Hatayama (Fujitsu)" <d.hatayama@fujitsu.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC: "Daisuke Hatayama (Fujitsu)" <d.hatayama@fujitsu.com>
Subject: [PATCH] makedumpfile, sadump: fix failure of reading memory when
 5-level paging is enabled
Thread-Topic: [PATCH] makedumpfile, sadump: fix failure of reading memory when
 5-level paging is enabled
Thread-Index: AQHZYjujRAxvHo5Cwk2zeTnUkMOGSQ==
Date: Wed, 29 Mar 2023 12:44:10 +0000
Message-ID:  <TYAPR01MB6507807A942C53AB8BBE834395899@TYAPR01MB6507.jpnprd01.prod.outlook.com>
Accept-Language: en-US, ja-JP
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels:  MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-03-29T12:44:10.841Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6507:EE_|OSZPR01MB6294:EE_
x-ms-office365-filtering-correlation-id: 57387d2d-4041-4d21-013d-08db30534b12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ogyOaijdCNe/5ESQmM0a7K+z2HDEZ4nsREThHRwoz3wnjya2AES8agj2G6PhxJgpdpe8wbOBspZ4W0ZH1hOGdkuDsFuNKw61nGDL17N/K+UrXuv5NlFaQ7m/xs7otka7RmQFQarfj+xNgQjLkjXcw/gFtuyxsX9LGgBtgt0zES+Nd8s92rkZVnDWaixYiV9wxcPfVcHxFOfPz9Qk7uyCRZqjF9zHRfCl1L6eV83QiK63EVrgzFi7HTlADfggvSKWbYAW1fZZlh8A72/fnZabCf2+X1hjMrDkXOovJ+lVyDMyg9hG0GYn1xDAdF4guegTnlu0Sa41cfQ3IggAyKsFD6aAWP800leLd/gVJRJprmmhbPftmMvIDyfMoehVb/3/iFQW66EHClo2+UAsFBIzNWDs86TdJbIPa6PkmF3nCfE4dwd5nhKcQUml1BYKgnA7+6z8LPwGQcQgPsDn0x+suPBu12az5cT5aNyTI5gQ7M0eByywSHpy61iVj0JKCqIH9/uWfyf8u+V4pqSyHf/LTXCRB8lV70VeqGQNJ+afhInKoE0b+5fDYQzdcbdsjmj/gvZDCBmgQroYihWV/M+/00BpG/L+oMNZbuzpecbUl8t6qsmPPDen/UBnyUfwhqMpEF2AGXExeyK9ORwhDoq8FA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6507.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(1590799018)(316002)(66556008)(66476007)(66446008)(64756008)(8676002)(6916009)(4326008)(41300700001)(66946007)(76116006)(186003)(6506007)(9686003)(26005)(107886003)(1580799015)(478600001)(83380400001)(5660300002)(8936002)(52536014)(2906002)(122000001)(55016003)(86362001)(33656002)(38070700005)(7696005)(71200400001)(82960400001)(85182001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?iso-2022-jp?B?UFloU0RBeWhHSE5JS1ZCekE3MjhmbzJTbCtiMjVTUWV1MkxuSG5yTlBh?=
 =?iso-2022-jp?B?emlBT3loc08vdmgzZlUra0hja2xvTEViaE9CUE0zcFBXQWlOazFMUzhY?=
 =?iso-2022-jp?B?NXljYlVjRHNLa2s5UDQ0RC9ZaU5ROUxYa3dtVUpkUEpmQWh4VkZtQnVx?=
 =?iso-2022-jp?B?ais3KzUxa2FCSWxNMkQ2WXFzY1JwK1d2dWFyd0gzOHVuNHBKNWJqQ1d4?=
 =?iso-2022-jp?B?YUJBY1BERWlwdWZTUXZSblNiYXAzM1F4SHpGb1JuZGFxVS9qNTYwMldn?=
 =?iso-2022-jp?B?T1lmSTdpRUc2Y01XZk56ZncvbUtsUktoQ2lkMWdYcEhnWlBGTDFMaERV?=
 =?iso-2022-jp?B?WTRobXpNdTc3U3FEbU5ITERqSCs2SmhHaGJ2WnFzQ2FleVBadUJib0J3?=
 =?iso-2022-jp?B?c09Vb2I1NHhtbDBxOEordGU1QTF1amdrR3ZlQ2VUZHdsUzgxUTdSV25M?=
 =?iso-2022-jp?B?RWZoVjBMR3hJSmVnTG5PSE5JeUs1cmVHS3BKUDgvQ0ZlOUd1YTF2cEFs?=
 =?iso-2022-jp?B?dWsrY1RsVFphQ2VSYS9FaitVYUF5ODBFc2VvczFxZG5ja0lxdVV3SEFN?=
 =?iso-2022-jp?B?cjV5cmkyQmtNbmR4TThoMDFNUXBidkFqb0ZJWDN4VVM5VlU1MHVZOUZu?=
 =?iso-2022-jp?B?NlBMYU5hT1hERnpXWXdZS0crTVp2ODZOaHZnWEZmeG9SVGRETjdlc3FE?=
 =?iso-2022-jp?B?TmtvOW9zWEhEZ212ejJKTkowU1pUYnpKL0Rpc2JqZXZoL21UL3k2T1gy?=
 =?iso-2022-jp?B?a25XVE0vSnRvcytnSk1KS2ltbzg0cU1oV0kzQmNTZ1psTEdkUE9TenNy?=
 =?iso-2022-jp?B?b1NhKzM4c29TRFVsY0xSbUprNGVlUVdMWTIwL1ljc21YZk8xRVk1RTFS?=
 =?iso-2022-jp?B?TEcxdWxEODA2WWdKSzh3MXlVdTlielYyNE9pdWRUaVpNdjlaL0VqQnZx?=
 =?iso-2022-jp?B?cmZoUjNUeXU2V2dyU0I3MmNFSWpjaFdBMGJkK3VZcUxxTVpPVi9WalhY?=
 =?iso-2022-jp?B?dHBibWtQYUVuM0JpVkgwNHU3RFkyekY1SnlabTRiaFRLQ2lpc2ZpUmhu?=
 =?iso-2022-jp?B?VXdnd3RUYUNwcmczWHVVeVNUaWhGZFN4anBKaUxsZ3FyME9UeW1KNndw?=
 =?iso-2022-jp?B?RTlxbkNNdDI1elNETk1UYzhDdU5OR3BkYTBlbW0ySkU0TEhIbS8zVjRD?=
 =?iso-2022-jp?B?VUFFZUV1TlZVOTF3YWo1dGtYMndwUHN5Vmo5YTV4MVd4UHZwOUd4MEVO?=
 =?iso-2022-jp?B?d0dodlZRaDJibUVjQSsyRGlIWGVma1FtbjNwak9qdUpncTFQN3RLTmtW?=
 =?iso-2022-jp?B?bmd1M0xBVzlreFNjeE5TWFV2bWdOZEd6aTBERFkwcnk2cXVPV3BIcGZF?=
 =?iso-2022-jp?B?RXN4R2JGcVBsYk0wbHJCUUVZQUlmUXp1MXRzZWFiOExKRW85MFhDckdJ?=
 =?iso-2022-jp?B?cFJmcXdFblBlQy94bjFqbXRkdkJTM0diN2ZrNjI2Q1BiYUNramR2ZFZN?=
 =?iso-2022-jp?B?YWRSVlowTGp2MjBLZFhxZ080a0E4VGFwNjVpckNpa0NSckk1TUxaZ0d6?=
 =?iso-2022-jp?B?YzZ4Q3ZCUU9YR282V3VCTHUwbHc1eWlSLzYvRXVBNzlRMVhDdU9MNkw1?=
 =?iso-2022-jp?B?QWdTT3hwSThVR2dHMDNlMmZJOUNWT1l4aHZ6eVBOYXFQTlJhcE1QK3F4?=
 =?iso-2022-jp?B?L0Zqc2Q2N2lLaVA2aTh3bTVvMTZCNkJNbzZqMnVmdU96VUpUQlBESXBt?=
 =?iso-2022-jp?B?OHRHSmsreTZjVWNRNkIyeFNqQTlsdERhbFlXZFlQMEptMFM4MDkvdUJY?=
 =?iso-2022-jp?B?RTAwVXgrazBQaFd5QVhqUWdqL08reFBkWGhvU0dsaFg4dDhTcktIeDhy?=
 =?iso-2022-jp?B?V2w4Um00MUtrZE5QSXNSZkQzWUE4TWFZYTd4R0dwb1JuQ0ZDaXUxbGRN?=
 =?iso-2022-jp?B?bVZwMmxXeHlXOGpzOGxhSmh2WEcrdUROZTh2QVBwT3N2Sm9vTTRkQitm?=
 =?iso-2022-jp?B?dllmNzcrY1hoRTcvR2V0SjU4a0ZSVEhOc3Fvem1YbS9vVXNvb2h1bWNh?=
 =?iso-2022-jp?B?QkdhRlRRbm5vOEkzSVJuTjk5WkRod2U4cHBuK3dKQXJXNzVvSmI1djNu?=
 =?iso-2022-jp?B?eTgvK1gyU1BpcUNMVlhqbXplSmQ3VWY2Ynl1by9lcEhPYjNFY3JTeFI2?=
 =?iso-2022-jp?B?RmFGRFdnQlhDbmJPUCtROXZoaTgvY1lMVTROSmhQV1JGdkYyWDVZSlBy?=
 =?iso-2022-jp?B?dm1IRk1EQjU2V0h5eitadktYMElEQUorenNRZmpMOC9WdmNQeFdCL0dK?=
 =?iso-2022-jp?B?aVMrUA==?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	YKaE8tbAwcpMh8Lxw886gIa1Ya50VIBo+/RTVDdtu4RnYYKsZ5rY0hTIbqBECDtL/pThGPDdJmvyjWMbIBvWIJ4UANxUSHIFCTe20FKioLxoR/4UBvi3n89kRr9LSxes4/VulnYkKicn9LuN+2vN9YFsWUmoZTO7c9+nYSlM9qaQl+Fd5HYfj6RM3AV1TK6U//+d7jlygytpxgrTLOFfA0/OdnFY93bEUXmfd4TcoRKDbuMyqcU523ytswaYvL2Sl3c4iMmKXiv/8EGuISRDsssSDo1b5vjSikw8vftkoAuaOwRN8tnzwuwGl4Baj7WAY5j29uOWmFfrNoq//e6GsTiFoRE60OmUey9O+LKe74GDHlZju7gio95t85bBj/kgdeX+shH7a/iCPLyU3s0RElje6Etf1sK1DxbspuEfm9kCbUoCuKqELXP6Rwgg8vkZqpzMtUML+3VLx9uKhd4xIO4ib4+TjsOQdHN00a4NB7YiJNyQmmr6JQb8J5GTDa91W1b/RtW0HDUEkaCsw5vbCB1OuwdgzGkM9qAwd9s/kb5CDgTA9fge0d6r+QnOfB0oIiRDAJlVp0B3+umvDdNFgLNfEzsBt0m5n95lGh85jKIGUsXyyoHkH88j6fT4AwSr5BuzsQc0AfZ9ltnr/7z0rsxrlf85KBi5ECx749jL66wEwFJpcqiTp3gI4QNjLDMIgKAHVEOLHIF1ineMWdlVrSS9PHZqFund6q9izUkizMRhZ8SQZ8GmSqNdLLgHBY5nHFSsa8rxpwTogxEcN5Py7zFLZRxrwhkOHEuE9VzHkg0=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6507.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57387d2d-4041-4d21-013d-08db30534b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 12:44:10.2397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fuVllvWApBRHP7tWfXVgCr6z5F9bGbw/YTN8+GNZCvFR1+KB9yX27AG/Rs2D6NHrYGAs/qLmvbIdUBnRWRipwYJLyLoGE0g3Jlle0wS7K84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6294
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_054424_668953_A65EC329 
X-CRM114-Status: UNSURE (   9.00  )
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

makedumpfile fails as follows for memory dumps collected by sadump
when 5-level paging is enabled on the corresponding systems:

    # makedumpfile -l -d 31 -x ./vmlinux ./dump.sadump dump.sadump-ld31
    __vtop4_x86_64: Can't get a valid pgd.
    ...snip...
    __vtop4_x86_64: Can't get a valid pgd.
    calc_kaslr_offset: failed to calculate kaslr_offset and phys_base; default to 0
    __vtop4_x86_64: Can't get a valid pgd.
    readmem: Can't convert a virtual address(ffffffff82fce960) to physical address.
    readmem: type_addr: 0, addr:ffffffff82fce960, size:1024
    cpu_online_mask_init: Can't read cpu_online_mask memory.

    makedumpfile Failed.

This is because 5-level paging support has not been done yet for
sadump; the work of the 5-level paging support was done by the commit
30a3214a7193e94c551c0cebda5918a72a35c589 (PATCH 4/4 arch/x86_64: Add
5-level paging support) but that was focused on the core part only.

Having said that, most of things has already been finished in the
commit. What needs to be newly added for sadump is just how to check
if 5-level paging is enabled for a given memory dump.

For that purpose, let's refer to CR4.LA57, bit 12 of CR4, representing
whether 5-level paging is enabled or not. We can do this because
memory dumps collected by sadump have SMRAM as note information and
they include CR4 together with the other control registers.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@fujitsu.com>
---
 sadump_info.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sadump_info.c b/sadump_info.c
index adfa8dc..2c44068 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -1362,6 +1362,7 @@ static int linux_banner_sanity_check(ulong cr3)
 #define PTI_USER_PGTABLE_BIT		(info->page_shift)
 #define PTI_USER_PGTABLE_MASK		(1 << PTI_USER_PGTABLE_BIT)
 #define CR3_PCID_MASK			0xFFFull
+#define CR4_LA57			(1 << 12)
 int
 calc_kaslr_offset(void)
 {
@@ -1397,6 +1398,8 @@ calc_kaslr_offset(void)
 		else
 			cr3 = smram.Cr3 & ~CR3_PCID_MASK;
 
+		NUMBER(pgtable_l5_enabled) = !!(smram.Cr4 & CR4_LA57);
+
 		/* Convert virtual address of IDT table to physical address */
 		idtr_paddr = vtop4_x86_64_pagetable(idtr, cr3);
 		if (idtr_paddr == NOT_PADDR) {
@@ -1417,6 +1420,7 @@ calc_kaslr_offset(void)
 
 		DEBUG_MSG("sadump: idtr=%" PRIx64 "\n", idtr);
 		DEBUG_MSG("sadump: cr3=%" PRIx64 "\n", cr3);
+		DEBUG_MSG("sadump: cr4=%" PRIx32 "\n", smram.Cr4);
 		DEBUG_MSG("sadump: idtr(phys)=%" PRIx64 "\n", idtr_paddr);
 		DEBUG_MSG("sadump: devide_error(vmlinux)=%lx\n",
 			  divide_error_vmlinux);
-- 
2.31.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
