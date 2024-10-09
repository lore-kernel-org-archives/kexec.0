Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49FECF042F
	for <kexec@archiver.kernel.org>; Wed,  9 Oct 2024 01:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BjcdNC2twD3HwebyC0Y+gYVjafb7ddU9fXtiEoFdCok=; b=UEd8SqZIAJU7sg
	uWg3EksU14ZlhYDqyDUatAa4HsBEneB4ct+XaDbBPA++dMpEcwcUT4cTXhACYChsKCvGy5ct2jlgn
	myNKcpE3nrzVuF05HIxHP+xAKpJlPvKYGTT1BXE1jJOjddtBdDb9BKgbh0uG3DQBBC9dDCFBEI0tM
	BvQB3wT2XJsO9Kf6lIIAukkE7NANIIdOgZHiC1IwlSUvClEP2zrrNJvyI3OgTeGq5K31fXKDbPxpl
	2VL2N888mVcPzFpM+ZmpEj6QQtykb2DMYz9P6sW7cFtgDse+SUuCjIz5qh0/KUN+LBSBpOydkPPfX
	T3T+XXqahrW7uXPJIv4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syLzV-00000007fm8-12jy;
	Wed, 09 Oct 2024 01:59:53 +0000
Received: from mail-japanwestazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c406::1] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syLnj-00000007dWi-3Doy
	for kexec@lists.infradead.org;
	Wed, 09 Oct 2024 01:47:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBc/txSbJ1F1n6XiTH/gJXZddMS/h8/B7OCLM86DD21ogtwJFL3gzg08kGd3yHdqXuurmAUwrdwIi7il9zpmQGu+xxoam1JmZinqBdDtArK8rgVxc95CSL11/Fm3CEv1BSoeX4xKm49Jf7jK8lXpAtAxcvsyqWY5IX5cFqcPSfhbhCKllJpf7dmdO65DH6T+rKugFZiShVABs1AjIFvU5reWfbH2y3d7cdLdJgXi5pPVEo5SYwpi8JpwFfdL7mLn4uW42tag1QOF6FgAA+IxBo10GEChxrr0ca5wDsH/d8ZsmSvZsW7HnJOgcvXI5kaW23lPELO0jxxkNJUb0fL4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIrXh78IkVzKMAs3iE1gctSCdwCD8xKqs6xhc3zqSNw=;
 b=ywmuBtTi/WaNKw8fCuGcLgtZN8ndOewe5u/KZEweySltpqUAXyGI8WjaDW5kQaNexw81zvRItBI/aRG/eETFKmqOR/u/3ybzbLclONLtFqKR4+vC8rL0PvymF95kI8aCuZN2OjhPcxVlkLEBy44c00lOKsVPl27aZ35bWLwXVh+qRcEi+GeztEelT1H0FiCXh7j4Vs+IAB1ob9AU2/8c304poXAJ7Cj8/psAIPupyCsd1eqXbExfrMiWMbH7BU55Y7Hyiror8/D0aotEoaxGMqMlYpVAWJ76hn/p51DsW5/yG29LOIey7OaNncKAL9rLYTIwlTwMAEy/ghG1WkMSKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIrXh78IkVzKMAs3iE1gctSCdwCD8xKqs6xhc3zqSNw=;
 b=Ojngtj173s07QwZtoMZXqal72U2GjR4Wumd8TB56NAcPDVOFWd19R54f6tO3Rfm23hfRnfajX0kdAR6YQAHkbg3XViYP0UBt88GECt+cX6SvbLSuukA7A6WQqSs+Av5fbJoKgeSRBQ+Q8SRwMo+G/65u1NHiTghFC34UvgULYSsT3m3IgUwojQUqj7MK+8uyE0GB13NDoyxzhPibGHmaO7fAiOIfenxTHnqR6ZGhz5RS+++D1Bcz7QMP9mYjMcxr/rjSHpCWTCHQA5zq8ZMg6On71Y2ueqmDdFUbqWV0FDvGpUbZJbWJLIx+wr6GmUyBkQClvbvotg8jsVG5L/goaA==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by TYAPR01MB5532.jpnprd01.prod.outlook.com (2603:1096:404:8040::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 01:47:41 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 01:47:41 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Ming Wang <wangming01@loongson.cn>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "lixuefeng@loongson.cn" <lixuefeng@loongson.cn>, "gaojuxin@loongson.cn"
	<gaojuxin@loongson.cn>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
Subject: Re: [PATCH makedumpfile] Fix incorrect PFN exclusion when LOAD
 segments overlap
Thread-Topic: [PATCH makedumpfile] Fix incorrect PFN exclusion when LOAD
 segments overlap
Thread-Index: AQHa7fPA1qiABnWZWUyrxFZpVkHEorJwRmwAgAyZ+oCAAR4OgA==
Date: Wed, 9 Oct 2024 01:47:40 +0000
Message-ID: <926a4dde-6ac0-4a18-9f2c-2d4482f020b6@nec.com>
References: <20240814024315.3166766-1-wangming01@loongson.cn>
 <80b58b89-d08e-45f2-af28-b285b9b17b69@nec.com>
 <5a6d9b3c-78ed-4498-941b-00dc04f7fc7a@loongson.cn>
In-Reply-To: <5a6d9b3c-78ed-4498-941b-00dc04f7fc7a@loongson.cn>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|TYAPR01MB5532:EE_
x-ms-office365-filtering-correlation-id: e071a7f7-ea16-4d01-7119-08dce8045c8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T0d6dDFGRDR6SU5uVmhreUowODNucWJGUWMwQk9JQ1NxUFhzRDFLV0VzaVor?=
 =?utf-8?B?dVFjK0R3SDYwK2Zhd0VtYkJqOEp0aFVwdDBpTWR3TVNFV0Z5eWhZM243K0g3?=
 =?utf-8?B?MXlvRkEwZHJ0djk5bmxxdFBZNTY3VTNSVnd1c08xdGxVazdPM0IrdGpDTnBM?=
 =?utf-8?B?K1labStlZUdXZDNNUVV2VzF6UTM2bDc5Ti94R1dzaXpsNjQwOHZvR1NLMXRw?=
 =?utf-8?B?WU5sQXNXbktZL2VxajA0N0lmdC9nZTV5RUxKdVhUc0VOT2dJNUhMN1ZCeG9X?=
 =?utf-8?B?WkNvemg1K2VJK2FXYVRja0dVbnlqM21lMlE0RWczMDF0R051N016RFU2aVRZ?=
 =?utf-8?B?Y2xEZCtVdnloUEJFT2JkMW4vSkttM3hIWXoranptclVtQVZSV2tPbWhuTTdh?=
 =?utf-8?B?ZEF5U0RVR0JMaGxmRWxKd2Y2emhoaE01TmJTSGZ0S2pnTnNyVDgrK1ZvcDJu?=
 =?utf-8?B?S05iUFlnVmVDS09CSTZyaHdRRGNkSzZKWlhlczNVVnNkRUVmb2JJRnZvcE5E?=
 =?utf-8?B?aUd1WjRobXhva054a281YlVGaHNMaDczYm5yUVIvSjdCOXk4eC85Z2VoOThs?=
 =?utf-8?B?dTY4SHRHOWVjMUxwZVorSWtUN05wU1lwZC9GZnJ6U2hLZFA3L3o2VWRUVVR5?=
 =?utf-8?B?bFpqaXNaREx2dXdZS1lYY0Z3VHNTYVFhb2k5ZDlQejhLU2dXMzgxdnJDQTZ5?=
 =?utf-8?B?OFBQWjZVRktQZWxjTUl1dEhNM0poNURidlNsUVVWNzV3cmZOVUVndVovY1hH?=
 =?utf-8?B?ZUozelp1MktMbkp0M2EzaFc3dzBuQW1sZUJra3dwY3kydm95RDduaVRhS3No?=
 =?utf-8?B?QmhnZ3dLYUVQWjZOYTMyaFZydks1eEx1WWY0Y3UyRmtzQjhrLzdFUWpBS2pR?=
 =?utf-8?B?Q1lWbSttem9CcTZFZ3QyVWZXb05GUExJLyswYWJ0WmtTK0RUS0hFYTcyK1V3?=
 =?utf-8?B?eWg4ZzhlTVBaVEk4YkpocG1NcnRWcnpwL1huYUVocEIzdEVlc3pjQlVVeVJv?=
 =?utf-8?B?MWNCMWZMM1JVLzhXRU9tRXN6NytUTi9GMkJCckFVTVRtcng4VzBnbFNqdmE0?=
 =?utf-8?B?VHhWNEloaDYwaXJKTkd2dEhRbjRMMHZMMVA2UzBLbHUvTnFHQktackY5RkdE?=
 =?utf-8?B?Mk1jTnFBekxIdVRpSFRaZFhtRUFsYnM4akhaYnBEZmMwN0RZV21udGcrNkxZ?=
 =?utf-8?B?VXVqbXlkVGtENk1tYmc4em91azErdytzQW5DK0JkQ2xCZU4wK3cyeFd2V09T?=
 =?utf-8?B?UzlKclZlQ0owVHB5bmYxUEwrMWhRNnJpdjAydXF1cGFkSHBrS0ZMbTdzOWlJ?=
 =?utf-8?B?NXNFVmNPWmpMRUJEWTdkWDU3QXhIRnluckNxVFk4dDJXMWpYUE95U21XQVJY?=
 =?utf-8?B?bDVxNFpTcUkxR1pEM2ZDYW14L2RzZmI0R0h2eFhDQzVKUFpEWld4QjkxMkVH?=
 =?utf-8?B?eTRJVnBMOGYzZmlDU2ptZnNPQmd4d0NVSi84Szl3aStlMzhpa1c1NndLOFkr?=
 =?utf-8?B?d3VQMW05ck1DbzBSellFR1U3ckFBSVhtZ08zdGp0MU52aGNqbE5nUUhPVjcr?=
 =?utf-8?B?ZGRQTFgzMVlHZlNLanl4ZG1JV2cwamFOeHZUYkhVd1RPRE8xRzRzOFYvMzdq?=
 =?utf-8?B?SlhBVjBVaU5Ram1JYXdqdHp6Y0phUEJpcXZkcWhOblkrMG9xekV5cjdReW04?=
 =?utf-8?B?a2RNZU9ONGJZZnNBMjRvTUJXcmZqK3pMWmQ5OTQ3cGdBOVVvcEI5OWtXSUhq?=
 =?utf-8?B?UnRQbmhXbmxJWVIzUkw3UjFNSHNsN3d5aFlUOGQwMlRYT0kyK1BNZXQrcnN6?=
 =?utf-8?B?MlJ3OGRhMGU5a1pwWmRTUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGt2SHFRanBQOEJEOHN1bnhwYUZBczVtQ1grUFVDZFBXaGZZamZyTldrNU9L?=
 =?utf-8?B?S1lGWUk3R0ozMlFiVFlQc1VmYkI3Mml3VWtqaUV2MEtDRFVrUGpEbUg2R2lC?=
 =?utf-8?B?TC9IK1JDanRDeXVhc1BBbW9EanRUQ0xoc3pqTzM2cWMzTXFEeEtDSXRJaEJQ?=
 =?utf-8?B?RlE1SzlTUmdWTDJVL2ZhYlFWWkt2N1lLOGFLSUNneDA5UFRUSXZob0pvZkc4?=
 =?utf-8?B?MkMvamEyRlZOY2FkTzJXc0I0S0o4Y0NPMEpCcDFUUjJjSjJ1ci94cUZMZjIw?=
 =?utf-8?B?aTAvZ1IwMlltc1U3aGNkUSsyTkx2Tllzejl1S0s1NDZmUU10SWt6NDR5VTY0?=
 =?utf-8?B?MWR1dytvK1Nlb0M5eHJnWm42WTFaQUFZZG9oMTVRYUJXTjhzTFB1TkwybmFy?=
 =?utf-8?B?b2l4dlh6OFVQYlgyR2xpVVFxcSs5c0xsaSt2THZ3RzNianRnQVh4SkhCbUl6?=
 =?utf-8?B?NVh3QUEwelVsRzRLaElpeS9KV1Z6YUlQUjlZUkFRUjYya1BQa3ljb2RGNHZZ?=
 =?utf-8?B?ajYwUFhTdVZZQWQxL2R6amRmS1Izd3ZjOU5PM3pnUlQ2MjRndUxBNWplQTYz?=
 =?utf-8?B?OFBnZmxyVXpvOWJmNS9OUWhxN3VJRUZFS0ZFd1RVVnRMUjkweDlQdmpKZ2lw?=
 =?utf-8?B?NklJS1BlMVV5KzlWRXUyK1E5UFdNZTUvbUdyb1paM2NQT0lIcHFQeFI5Zk5r?=
 =?utf-8?B?a2RJM2w2bFZ6STBFSVZXZEJYZnc0K2ovdjMwOGhMTmowUUZRczNwby93TUtM?=
 =?utf-8?B?L3c5YjQyQ0tzcE92eVkrcXZCN3pmWk1mTm1TZ2lJakVUTTUwT1ZFcEVtL0FH?=
 =?utf-8?B?dEtWL0dQeXlZN1BVVDE3N3o4dk9ZMTMzTXVYVkppczNneDd3TzJ6NGN1M0RY?=
 =?utf-8?B?bGdKeWt0bVprRXZGMTRoNFFCZGx3d3NkVzRWYmpUN2tQeXFTcTJXTWY3NnR1?=
 =?utf-8?B?NGFVZVdiR1dXOGltUmg2RzVvMTRUMHl1MWxDcFZCeUdiUFJSM0xZYlN2eVBu?=
 =?utf-8?B?YXZiZFdEaDlmZ1FVTVpNeGpmVWRwZEx1WTMzVEhhMVRHYnJZTFg4ejlBVkUx?=
 =?utf-8?B?RWx5V0ZkYXhSdlFQb0xZUTBqc2xmaWFTamdpV2xGdUVYdC9kZmNwMzF6SmZU?=
 =?utf-8?B?cjg1c1VhT280MUpmZWdYeVlMeUNNZHN0eS9IWHhnRFpEWWZteDY2R2Zib2I4?=
 =?utf-8?B?MDdJb0YvNGFjTnlCSkgycC9YRFFJcGN0V29NdEJkSmxSWllDTFBobysxMHRU?=
 =?utf-8?B?WlNFY2E5REFjdmhESkk1Z3VNd2MxT3RsdTJJMG03NThiVE4yd3FQNTRyNjFE?=
 =?utf-8?B?V3MrL1lOZlF4QWR4TXIwRVFmS3dpcGZUQVdLaXVBazJCRE51NzJXRmFZVFBY?=
 =?utf-8?B?Vi9VaG1WTmVKWXpwWnpvYkpCUmI4TzRtZkZHbCtJL0loN2p6aE9Pd01mWHR4?=
 =?utf-8?B?ejhvMTg2UTNqZ2h6K3dPQWUxUEs0VjJYSTdpM0c0Q1lGRGFLQU1Sb2R5RlRT?=
 =?utf-8?B?REx2Y2NmU3pBSHRtMitLRHBNZTk4alBuM2ZHbnlaNEE1VjQwYTYvbE9ENUJm?=
 =?utf-8?B?YmJSSUgwZGx0eFZaSGhMcGNPSjVVZVQyUTR6Z0JCc3VoaDJ0TmsrK1F1MElX?=
 =?utf-8?B?bUNQN2tHZ3BHTncra1kyYmpYdFV4UVBvR0lTdFhsWUorbC9KaStJSjl2REhl?=
 =?utf-8?B?SlFIM0dsdncwQTRDQUtEeWtFTDlKL2h0SG53QmNQU0o4aXl2RnBJNUptRllx?=
 =?utf-8?B?cm5obHNkcTJpWlJkNUltSmJ4OXZOUE4zL2tCNkxDNnp1anloZ1B4Z3VBaW9s?=
 =?utf-8?B?dndKOXZDVmh1d2tpeDV5LzVJeE43RHhpd2tTckxSUG85VHFwY1hhL1V2cnUy?=
 =?utf-8?B?UGlxQ3RuSWpaTFdaSHhhWnRjNHZWTUN6b3FlZjZVTXF5dTNlajlVMUVYZisr?=
 =?utf-8?B?dlFoeU1SQk43SXdsQWRXcWpRZ1MzQXQ0Nmd6Q2NuZ2tYbmNGZTRjbkRBZE1P?=
 =?utf-8?B?MVFaSEcyREVjRTVMUVg0YTVXdUVrdk1mOTcyV1hhYUpzek5laWxtS2lqd3FL?=
 =?utf-8?B?OWRPWmRCeW4wa0RtOXFYUUxGY0hWcXRhNXRmM1hMdUhVV0ppYjJSZ1FOWVBw?=
 =?utf-8?Q?MPeb+WfHACPb4wSUxgpC2te4H?=
Content-ID: <8B4A79C150E525488A1525FE65C40C62@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e071a7f7-ea16-4d01-7119-08dce8045c8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 01:47:40.9852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wq33m+BtI5x9WvteUy05+Yp/lSHYOtdYeJQOaCp8UVsBicCxyuXjABOIPFBiCKaxncWl0LnWIYAnVqpI86KEww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5532
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_184744_153220_4F991460 
X-CRM114-Status: GOOD (  27.98  )
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

Hi Ming,

thank you for the detailed description.

On 2024/10/08 17:43, Ming Wang wrote:

>> On 2024/08/14 11:43, Ming Wang wrote:
>>> When iterating through LOAD segments to exclude pages in
>>> `exclude_nodata_pages`, simply using `phys_end` to track allocated
>>> PFNs can lead to the erroneous exclusion of valid pages from a
>>> subsequent LOAD segment if its `phys_start` overlaps with the
>>> previous segment's address range.
>>>
>>> This patch addresses the issue by checking for such overlaps with the
>>> next LOAD segment's physical address range. If an overlap is
>>> detected, we continue including PFNs from the current segment until
>>> reaching the end of the overlapping region.
>>>
>>> This fix ensures that all valid pages within overlapping LOAD segments
>>> are correctly included during PFN exclusion.
>>
>> I have a few questions:
>>
>> - I heard from Masa that the overlap is caused by a bug, isn't it fixed
>> on the kernel side?  or it will be fixed but is this patch for existing
>> kernels that have the bug?
> The overlap you mentioned is not caused by a kernel bug and is not expected to be fixed in the kernel.

I see.

>>
>> - exclude_nodata_pages() is for dumpfiles created by "makedumpfile -E",
>> which uses p_filesz in program headers to record existing pages after
>> exclusion.  The function excludes pages only between
>> phys_start+file_size and phys_end, so if p_filesz == p_memsz, it will
>> not exclude any pages.
> My system's page size is 16K, Consider the following LOAD segment information
> 
> phys_start         phys_end       virt_start         virt_end
> LOAD[ 0]           200000          2186200 9000000000200000 9000000002186200
> LOAD[ 1]           200000          ee00000 9000000000200000 900000000ee00000
> 
> I added some print statements within the exclude_nodata_pages function:
> 
> while (pfn < pfn_end) {
>      ERRMSG("\nfunc:%s: pfn: %#llx phys_start: %#llx phys_end: %#llx file_size: %lu pfn_end:%#llx\n"
>          , __func__, pfn, phys_start, phys_end, (unsigned long)file_size, pfn_end);
>      clear_bit_on_2nd_bitmap(pfn, cycle);
>      ++pfn;
> }
> 
> The following output was observed:
> 
> func:exclude_nodata_pages: pfn: 0x861 phys_start: 0x200000 phys_end: 0x2186200 file_size: 33055232 pfn_end:0x862
> 
> After this print statement, clear_bit_on_2nd_bitmap is called, effectively clearing the bitmap bit for pfn: 0x861.
> However, pfn: 0x861 is a valid PFN that happens to store the kernel's init_uts_ns. This leads to an error when the
> crash tool attempts to detect the kernel version:
> 
> read_diskdump: PAGE_EXCLUDED: paddr/pfn: 2185d98/861
> crash: page excluded: kernel virtual address: 9000000002185d98  type: "init_uts_ns"

So the calculated pfn:0x861 is wrong?

> LOAD           0x000000000000c000 0x9000000000200000 0x0000000000200000
>                 0x0000000002550400 0x0000000002550400  RWE    0x0

This is a different example, it's expected that p_memsz equals to p_filesz.

But, the sizes are not aligned to the page size 16k, and

   pfn = paddr_to_pfn(phys_start + file_size);

it looks like this rounds down the last valid page..?  so

-               pfn = paddr_to_pfn(phys_start + file_size);
+               pfn = paddr_to_pfn(roundup(phys_start + file_size, PAGESIZE());
                 pfn_end = paddr_to_pfn(roundup(phys_end, PAGESIZE()));

How about this instead of your patch?

Thanks,
Kazu


>> I would like to check how they are on your machine, so could I have a
>> "readelf -l /proc/vmcore" output?
> The output of the command readelf -l /proc/vmcore executed on my system is provided below.
> 
> It is important to note that this output corresponds to a different kernel version compared to the one used in the preceding example:
> 
> [root@localhost ~]# readelf -l /proc/vmcore
> 
> Elf file type is CORE (Core file)
> Entry point 0x0
> There are 8 program headers, starting at offset 64
> 
> Program Headers:
> Type           Offset             VirtAddr           PhysAddr
> FileSiz            MemSiz              Flags  Align
> NOTE           0x0000000000004000 0x0000000000000000 0x0000000000000000
>                 0x0000000000004a54 0x0000000000004a54         0x4
> LOAD           0x000000000000c000 0x9000000000200000 0x0000000000200000
>                 0x0000000002550400 0x0000000002550400  RWE    0x0
> LOAD           0x0000000002560000 0x9000000000200000 0x0000000000200000
>                 0x000000000ec00000 0x000000000ec00000  RWE    0x0
> LOAD           0x0000000011160000 0x9000000090400000 0x0000000090400000
>                 0x0000000011200000 0x0000000011200000  RWE    0x0
> LOAD           0x0000000022360000 0x90000000f8e00000 0x00000000f8e00000
>                 0x00000000000c0000 0x00000000000c0000  RWE    0x0
> LOAD           0x0000000022420000 0x90000000f8ed0000 0x00000000f8ed0000
>                 0x0000000004c70000 0x0000000004c70000  RWE    0x0
> LOAD           0x0000000027090000 0x90000000fe100000 0x00000000fe100000
>                 0x0000000f81f00000 0x0000000f81f00000  RWE    0x0
> LOAD           0x0000000fa8f90000 0x9000100080000000 0x0000100080000000
>                 0x0000001000000000 0x0000001000000000  RWE    0x0
>>
>> - Do you mean that the bug always puts the two LOAD segments that have
>> the same phys_start in a row?
> Yes, as demonstrated in the example above.
> 
> Thanks,
> Ming
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
