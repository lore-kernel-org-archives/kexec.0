Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB9CC3DA4A
	for <kexec@archiver.kernel.org>; Thu, 22 Aug 2024 06:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LHm/CnZSOFpnx57+MOcwNKcKEP2WZctrFT1M4/eYFh0=; b=VKmI6u5dBOuA9i
	vW1MiBo10HwhJbQmiK8EwtC/evgVKF1fa0iCQEWUvtY5BaQG4NPTg+f39nCTESXwGsiWiwsuvHkxI
	Wsxg/21CQKRHMVxLo++CQDGMObYeb4YMbbvNIkkzNarxylF8yk8WdQSc6/8hm/DefchkascL/4hSa
	q88W3lqaDRoHcmqvEQoMepWFe7T3aGBrjnM3+8flmAKFClEcFbRwzZ6OxPUjEwGl6eEDGjHLYzYgL
	79/Q+Hnws4eVQvDhjMjHhLp59Y4j41b/e4Ef1Bn1uah0T2xfhwurz5Pt4YYC5ElJHZoFMvfICwkVN
	ljf5b+GIA0f432a+EXIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh1KX-0000000BbdY-2KAU;
	Thu, 22 Aug 2024 06:29:57 +0000
Received: from mail-japanwestazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c406::1] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh1GN-0000000BaZs-1n7E
	for kexec@lists.infradead.org;
	Thu, 22 Aug 2024 06:25:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsd6j41M864ezHjl1JJ+1G5kJTnjlTD6bTlQYHo3aaUmwB3AnPyA1RufXFhtfwMIp3CBOyhcIC/VqeduRu5XuBFddY7g577sBTqy7dFDH4iV2ezaF4JRhT5XXVU8zsFem/btwPyXjXkijfZl2xchJ/XoZcFoGDHggZroWjZJNl09th6YDeOx5bfFKcdDKfOwB6usshSeJw/I7EqyvhOAN/8gZ25nhWv7aM8Q6dFONopQN4ypVLDiBSH9rwVUTP3l7uDPfE+0SRCL1qLIYqT+X5zRR5OjlAWT7EPifiPKIT4fpj1Tx2OeiTuClZcW+HZScF+IvwPk1odLJKr+U3jt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRHqWx9fQ+WfS99vJFSRRzL9N9/oLqXzCDhtaUMDazY=;
 b=l6MGrIIxluyy8pAKR2PZx6zfM5N0nihHrttp37tEZ4PoQ9KZY3uEIzVZoichxGCIuWvuspZJWakbXKyqsGpGmT823RRss7NzMSpqe0BhH7r/PjtTo4jz7h3EITLFJ4VJOS3+XmgZBjlIZNpKCmqsvZ58kpS/i1QkLivygCWqebvTmQWTwrjGj6qcYurpb+dpIEDAcRt4YFVXnwVadxLeZ+Lsm2a2pVjd+TaSSzewCjRiSs/Y00+ydAqxZeG2bbADrmTitgm8IdpadqWJ3c+rQlWy3nOp6EAcYjPbUxMnbzw9Hh0Xv/6aTe9+BojrJGxRexEcFMtx9g1e+cS41GAoaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRHqWx9fQ+WfS99vJFSRRzL9N9/oLqXzCDhtaUMDazY=;
 b=O3IcvDDvM9VH4k/gdZywJwcuJAqBbS0ZdzBc0MMJnm8TXJK2fl3qjymKwTWX865mxqBemDMlxEuaQTsTkk5Zp4rsZ4b65WsOPTmUKsZ4O4R8WiNQW4SJlE0bJ1OO3cbGUVdRA52bx1om/3fY8iveIsqoQe/zMI5XJ72Vpxi2TQcqADPnhRpb4I9e0QP7jQWq19jltgBGeYybHr7awrjaMneoQFHPPhLrg/Zf+jHQWF1/tdwz65AkceWRRY2slzXmM1GFdLU7zweI1zJoMrVPqwAqmfRu2DPX3oHcPKq0C0ZlW4va/bnqQBc4zYA4MTgmzJBp4Qvgqn2vEmv+W94IEg==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by TYYPR01MB12812.jpnprd01.prod.outlook.com (2603:1096:405:158::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 06:25:19 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%5]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 06:25:19 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
Subject: Re: [PATCH 1/2] makedumpfile: Add ftruncate error handling
Thread-Topic: [PATCH 1/2] makedumpfile: Add ftruncate error handling
Thread-Index: AQHa7x33iviqh2foe0qlHTCNHnX2xLIpYi6AgAf3cgCAAYAjgA==
Date: Thu, 22 Aug 2024 06:25:19 +0000
Message-ID: <9f75a7be-f7ec-4987-b0f2-d65dbccc9a3d@nec.com>
References: <20240815141733.4050230-2-stefan.wiehler@nokia.com>
 <db15a94c-3fa5-47e6-8c8d-59665bb119a8@nec.com>
 <2874031e-bb32-43dc-8220-7756dc2b36a2@nokia.com>
In-Reply-To: <2874031e-bb32-43dc-8220-7756dc2b36a2@nokia.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|TYYPR01MB12812:EE_
x-ms-office365-filtering-correlation-id: e1152011-a112-4535-fd43-08dcc27331c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M2sva3BHVXFWbXJIc01mVmMxYjh1TUExTDZpaWQycmozTVZtQzU3NnhUY3RF?=
 =?utf-8?B?MUtjSDNsSzFKQm5uTjJUZDdMdTV0cXdDL1pxOVlzcElDaUkvUnBuSThnTkZt?=
 =?utf-8?B?ajFlclM0eTN1cnREOEdXaE9SRWhEbU14cFFUS0FtMDZYZ1c4ZnltbytFQnY1?=
 =?utf-8?B?K0FQbGx1Q0ppc0gxa081U0E1cXc2UUZPQ2FTZEd3WUJvZUxaTGV0M0ZiNjND?=
 =?utf-8?B?Mk83ZlJ3aVJVRkk2RW1Fc0hRUUk2ZjNjWTNaa3YwUEdYSWV2RW5IZDhEem9u?=
 =?utf-8?B?ZndXS0tJTUEwcWRXTUROL0pOVk45dGZ5bXdBbkZXNzUraVkwcHpGc2Q4dytQ?=
 =?utf-8?B?dWdyUzlHS0p0SXA0THRKWC9valpsdkxsTlJNcmJHRVFmUStoLzVkNUlqTlBh?=
 =?utf-8?B?bitqQ3lwYzJzU3RUS3EwSzNIYWRtV085V3hTdnlSNXlPMDJsSkh0NFl1VGd3?=
 =?utf-8?B?QWZ5UVQ5S3hyc3hUcTBCdUtZVDVjNElISmlJRGpCZUt6eXh4WUtPRzRqNEN1?=
 =?utf-8?B?Nm9SMERNVHZYcnF1QVN0TVFLRTdqTCtJQW5wVVViTXRjUE5oQ0NQdkpPSTdP?=
 =?utf-8?B?UWhqRWNJeXhhelduSGQ0S0NOTkRGOFp0VDBLTkgrdjFwcHVZVGFzeHVpWGhk?=
 =?utf-8?B?aTlBODNZdDhGN0ZKN3d3OUVRYVZjOG5pODdtZHRVQVcrVFdpUVNDNWYvc2Jn?=
 =?utf-8?B?QkFneUlBeVQ3SlNBUjcxMmpjRE9KelVHMzBiNHlPejA2TkVya1hFQitsRWRO?=
 =?utf-8?B?MEFkS3dQdnRPUFcyN29QTDB1S3FrU2FMZTlNQWlDMGFkYmswQUExdVQ1TTBN?=
 =?utf-8?B?VkpseVF4YThlbWd5a3A5Ui9DeStFSmZIcnFMQXJ6UlZXcC9KSzhIOGUyc2pz?=
 =?utf-8?B?MlVYNnI0bFVJUjdnbXhyL0xLeDZYNTZpTzgvTmYxK0liV09qR0NyY3NSN0p4?=
 =?utf-8?B?MEx6K2tkREtobXJsVTJVcHV6bGdZaVNZWFZQQVd6RlQvTVpEKzBIS3VyTGY5?=
 =?utf-8?B?aHJEUnB4VCtndEdiRkd2cUhUbTlZZCtRVjJWK1FUWHBiZlJ6VS9zYTRwbGNK?=
 =?utf-8?B?bzdXZVBLMU8rWnBYSStHSFEwYWJObmw2dnYzT1NRVU8yZXVqZFM0Z0x0aVlM?=
 =?utf-8?B?Umd0WU1jNmkvWnpPcmxkWkVHdDZSQXBjQ1RDOVZxVG16UnlpTzZFTmdGWWlp?=
 =?utf-8?B?bS84b3lnZTRWbTIxWStXS3JsTnB4eEdZcy9uK1ZHWDVqWDExWGlEekdnVXY4?=
 =?utf-8?B?ZHErSjJQczh4OXNQMCtDNzdqNEVXYXBLR21OeEZ4WHBlM3BKajc3c1JwejZN?=
 =?utf-8?B?ekNTbEFuNUNBMkt6OStaMTNoNUQvb0Fsd29MQWY4YlNONldwak5zdFM1anN3?=
 =?utf-8?B?NFE2UzgyZzFKc3VRdGpFUUtaeHVzWXJQOVZBMURVTktZcjdpazZHRFVURG55?=
 =?utf-8?B?MzV1Mjc2c0RXWUNhVVJUVDA5UHJXT01Helltci9yM0wwMEVaZnBIM3FpTTRw?=
 =?utf-8?B?cm1ZK1RXaDNwMGQ1U2RNTlJWNDRSSDhFblZyeGRncHZBUWhtN2wrS0tUSUgx?=
 =?utf-8?B?RitObXYwdldJRUhnWGdRUm90Yk9vbDBrK2o1Ty9ZL0lIM1ErSU1EUmR3cHFE?=
 =?utf-8?B?cXp3VENndkdOQnQ4K2Y2QUZLdFBIdHpGL0FuSjVHUExlM01jUjVxa2JQTUdR?=
 =?utf-8?B?Y3htck5rYkhZRDQwb2VGNThxVFpmakpJc3hzMUp6WkY2WG1rNVZVZ3FlVllQ?=
 =?utf-8?B?cjlrbjBLcGJOSUNmRW9MczZjd1RlaHJIbVJ6a0ZwSEVES3NramZVTElmNXhU?=
 =?utf-8?Q?SPRLSPLyr/hJyFHEs5NbFSFrzvmd7yO1boy8I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUVuNkVjRURFQWx3NnZrdW9SQjFPQklORzNZSFdFNTJZV2YvbzZwRjJzajJm?=
 =?utf-8?B?dzRUdGsvN1YzejljeTRSTEVvZHJ4eFdrSFI2TTg3Q3hHWUtmTVM2RU9DQUUx?=
 =?utf-8?B?NkxaYUJoN0Jra1NHK2ZzRit1cm9hYU9IRlBiNGtNb0N0MzAyMVlRS1RkUFpi?=
 =?utf-8?B?aXFBZWdZei9RbnBpSUY0aXRRMU1MMEsvUGJ3ZnY2NEZ3Z1MvZnNqTWVTemhy?=
 =?utf-8?B?cUkzTmdLU1lQOThxalFxRkxnMFQxZmxsTjhPenJWdWhpSUF6SGh3WmNIbnVi?=
 =?utf-8?B?cUxzRmx3QU5CYXpNRGhZVStrbnRJVkk2NHE1SCsydGpwcWpZb3UzTnJrNDcw?=
 =?utf-8?B?N01BQ0ZTbEdNOEJTZ09CNGs5bFp4ZnpIMVZHYVNoOFQxS3hBcVd3Y2llcFVp?=
 =?utf-8?B?YU9JL3p5Z215Z1NmL3pYMk4rNHBMVTJBaTgwcDYvVHVSaUVrTFU4b3VMNG5P?=
 =?utf-8?B?L2UvVTZMY3dQUFRBWnZUaVd5ZWVTRjZJVE5sZHpmNzZnRjBsTzEwbC8xUnZp?=
 =?utf-8?B?NGtpaUJTckliZFYrM2xEeUNZVkxoNlhEQUVZWWFwbjZJODFoMmV3OENXS3Yv?=
 =?utf-8?B?VGhUY3pSSEJjQk50aU11dDJHRWdHblhqNDJjM0NlRSthRStPQ3M2ak41N2d0?=
 =?utf-8?B?TDhERndDVG5pZWZiV1ZYc01yaGJUeXdoTGFGeXJWbk5PRE9zM2orVWM3MmFk?=
 =?utf-8?B?R2N5VmV4T0JkaGpZVnlONFI4b1E5SFp4Y2NWdytKSnREVlB4RDZIb1paNVVN?=
 =?utf-8?B?N0JqYzBLaWRhbDVlSlhheTFac2k3c0U4d01aenNWQVNJM3EyaDRSTi80R2Q3?=
 =?utf-8?B?cDNKZjc5N240V2VnREpjZkZXYUc2dThOa3VOM1dGdEphMGpyaUpSYkliQmZU?=
 =?utf-8?B?UENnMi9rV09sOFRnVW4wUDQ2Mk13aVZKdjFKbUZzTzlhU21HY3E2WHArenFC?=
 =?utf-8?B?YUExSEdldUlhcVVFQ1BRVmg1L3hNNTU0SHpjd1dpbEtFQXpqMmRFQnRIL3Fz?=
 =?utf-8?B?U1ZwdkZObk9WWjIzeHU3RUtzSVNVYjIwaFBhd0lsVWJ2QlRxQU42MVkwRy83?=
 =?utf-8?B?TTFRY1dQTFAydUM5T2R4SHNBamE1TnhRdmx3WDZXU0RWbHJLWmlkS0FsaDV3?=
 =?utf-8?B?b1lGbFlGdnpFeHlEQ3QySkJwZllHanpNaDZFdWw3MmdKcnAydDZhNlZ6QTho?=
 =?utf-8?B?ZjRreFVVbzFRck9qcGltSWpoWU1IREJrZWhEYUlBd2R3Y1dTamk5UCtIdW9W?=
 =?utf-8?B?cHlqOTNJS0lZWnJ3Zk1YQkdnQUk3eXo5SGQ4V0JOd0lTbnNZNGdzc3pLd1FG?=
 =?utf-8?B?SEsvSm05dEJ2RW52VklINlpZbk04R0ltcFpMa2NLZmszajFOQlE3UlNvWEF3?=
 =?utf-8?B?eU1RWE42NUE0MDZPbVRsS0xVNXVEbnNlZjVyZVo2eHRTNWgreFRMRExhUjlu?=
 =?utf-8?B?S3cwTWRtNkdoMDZmTHJlOThheUlSZ0tETDU0ZTd3TGdEQ2NuUFV5K09zSTNq?=
 =?utf-8?B?elFOYk1UZXBnQUdpb1JsRE5LVWlERCtMZkhyOWwwQklKazEzQk5FVjdtL2l5?=
 =?utf-8?B?MmdYanQvWFJiUElNZmdOYWpmQVNBVDVrTTUzdG1mMjRJZThCaldYSGxROFYy?=
 =?utf-8?B?anVEb1JnMmExM2h6Vk5TRy9JdVhCQmRnYlZJK2RFVm1nSVpMV0M2aFJMZUQ5?=
 =?utf-8?B?M0IxdmNTb1RoSjJlVVpkTkJyRzhxMmJqYi9iaFVWNThVdHdESG1MQ01JbTg3?=
 =?utf-8?B?dVlIZlNTam5HZXgwUEtQN2o1TlVjQUNac2ZlWkhxM0JKQ1EycjhJVFlnVVVS?=
 =?utf-8?B?SFZyZTBydHhOZEV5c0JEMlYrczhDakt3TEJla3VsWXlOUFA0YnVBc1VDMDV6?=
 =?utf-8?B?ZEVmbjF6dTl6cEwzOXJzcHJJM1QyT2RTV0JKMUxTM1BDRHB1THc4WkM3WEs2?=
 =?utf-8?B?YVhNZWdnRTBUQUE1Y3pmMHdsajRYbVYvUkNWNWlXQm5KSmNJREpoRnlDNy80?=
 =?utf-8?B?SU5OU2JNdXJWcm9iOW5UMHRQN2RIbEs3SmQ1QVN2dEF3WThZR1MrdWtzNkRR?=
 =?utf-8?B?SlY2VE8yaTJUM3RyVlRaSFR2ZW9GbXFtRXZ0MDN1eFFMZE9iczltZmhlVk5N?=
 =?utf-8?Q?Wj5XriZjGu8dsxYtUqDu/mefu?=
Content-ID: <5CAF1AD0C970A54BA72743CAF8CE56FE@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1152011-a112-4535-fd43-08dcc27331c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 06:25:19.1999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9ZcwbyNSfUe4oEM2zcnAqyjli1/MxbvQ9um/+gYasLucGXgitR7OTbt+93v80KcLkcIc/WiBNsSPI55LC6+RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12812
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_232540_024799_2E514F44 
X-CRM114-Status: GOOD (  14.60  )
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

On 2024/08/21 16:30, Stefan Wiehler wrote:
>> I tried to reproduce those warnings, but could not get either one
>> with a plain make command and gcc 14.1 (or clang 18.1).
>>
>> out of curiosity, what compiler version and build command do you use?
> 
> We use GCC 12.2.0 and build via the BitBake recipe:
> 
> https://layers.openembedded.org/layerindex/recipe/52214/
> 
> The recipe removes hardcoded CFLAGS in the Makefile, so it is not
> obvious to me right now if we get these error warnings due to additional
> CFLAGS we inject by default to each recipe or due to below patch alone:
> 
> https://git.openembedded.org/meta-openembedded/tree/meta-oe/recipes-kernel/makedumpfile/makedumpfile/0001-makedumpfile-replace-hardcode-CFLAGS.patch?h=master

Thanks for the reply.

I found that the 1/2 warning is reproduced with -D_FORTIFY_SOURCE.  The 2/2
warning is still not reproduced, but the patches look good to me, so applied.

https://github.com/makedumpfile/makedumpfile/commit/3de748452194e9363042b27ae069c779059a12f7
https://github.com/makedumpfile/makedumpfile/commit/bd30437c629220d26824a8f1ef28b2e47e0529e5

Thanks,
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
