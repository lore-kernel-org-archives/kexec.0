Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EDCCE7CE0
	for <kexec@archiver.kernel.org>; Tue,  1 Oct 2024 07:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SUXH3XaWgpZ2pKTjeOHtHpnim0BugMPZEL+4NYUNu6c=; b=uVd8YZ7Z/aATfN
	IfL37qSY+lnULibLF/aOg5d4E+/CCr5JFQNV8tRXxtV0H0hkZZesR9eeeEe3rbyhNb8zdBWqUgmqH
	MssCajErLn76TDCLQh4Zkte7mk9xCLjyf2rxfkeG9PPw2AY8SvnpQwP7YvFIE3qOc6iPR8fRBplwd
	iArBacKpi6AiUu+rqJJ7U7zLrmAOHWgODY3Um7PvNl9xQgctnv/vmUKXuzWqfpaRfw4kIUymH+T4i
	tk/KJlBhZpyXq1rf9yXseCZNa0DtuLoPMpHcgEhEvHqBJXdezWu2Fr6gt62T2I6i8g+wyflvI/XC1
	gwmLVOtywvjYWMIM+Z1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svXJN-00000001tfu-3iGr;
	Tue, 01 Oct 2024 07:28:45 +0000
Received: from mail-japanwestazlp170110001.outbound.protection.outlook.com ([2a01:111:f403:c407::1] helo=OS0P286CU010.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svXJJ-00000001tf2-3Qkk
	for kexec@lists.infradead.org;
	Tue, 01 Oct 2024 07:28:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grY6gaP0PA+rL5gTwmPc1m+q0YTXpJLsY98AL3Vlz+FxjQnL0tQEaRlbpNC6NQCNyv8O9Klw0tq7O3hvzxsryO77xmUjNuur2QpM70I8d1WrL/vS96KxI3lh8Q8pBSyL22Tm1Fq1gkHdGsmUAr/PyXU4+vpRMrZ2SfOG2GmkoSZqnmaQrGYuKoTIDRvrFB6kg0j4/BWJRHA51E+mURYOjjlYlJj8rAOjTjiWHZHgqOPL2eoTpFfPwRUVxjhoVvblOr5PET14MVM9vq/yj7N+O1lnNW+YSDEXC+YEQHsHcZYJQ/iQGRM/Z73jX1PNLqwW/jOkWFwFNeDy7pAXwnYa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzI9mPhlj5QmDLs6O1mOg6XTk6M+Z9I3DokXsptHUAA=;
 b=xuZKiFmBH+1PqLyK2anz/4RWoF9x6IYCaaJBR9iBMhO83mK+Nd+7uENKyb+0nJUsi8Jt53/Px4tr+KYd+nv3I2pUD+MjOaJLXOKXFFzzEFyJfEjfS1lVXyloNZg95myh3vTufWOixyabCmtlU2xaVAfeWi3onSiLdrx+CeXk77UQpEKQbjIBUkDu5eFJ5n2s7raeq1tk2ffKDVFOaBGI7GERIy0Oh7qUsZ+DMfrTTrbaqMdD/bumM3hy/tGqvtN7q1i7mQLk2i5CeIEL5ipGDVArNM7jcIsbLhmCl+HDmr6gkZWTyjSjYAH6xti3716iCuRcEhd8ubAIx+YHxPanUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzI9mPhlj5QmDLs6O1mOg6XTk6M+Z9I3DokXsptHUAA=;
 b=UVhgHjVj5RdF1hmd0ZiAR3I0jzCQNyajxTE0q6+MG4VitfbOw45tO+25UCmBnmTL9ff6hZjE5hBFi9C7hHdIj415y7Wdu6yeMD9F0OcsNKf7oVbnlKCbfh8q7Amac44hIQpjzzTV22kYtzwnluVRE3toZG0bL1SLuWHiIEiHKRj6XjEycnO12G3Yj3T8nk18khg18rhoDQ//j2qaU38nKjsoUnA/WZykGBljHxUvOVUU/7Hv5xiJZMJoBkOZeEa+sSpYJUagKLBnsr0AEhyW6nVLkakbX8FsiacRA3l58VU+SoxO0sUNUHGXwlYZzfhBNBff1KcLkRU6g4JFoU25jw==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by TY3PR01MB11906.jpnprd01.prod.outlook.com (2603:1096:400:409::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 07:28:27 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%7]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 07:28:27 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH 0/2] s390 fixes
Thread-Topic: [PATCH 0/2] s390 fixes
Thread-Index: AQHbE1OrlMsS0osi9UG6HhIe7jSX3LJxgEIA
Date: Tue, 1 Oct 2024 07:28:27 +0000
Message-ID: <5ca9e868-c7bc-4066-a267-4baaa0fc9f95@nec.com>
References: <cover.1727711991.git.agordeev@linux.ibm.com>
In-Reply-To: <cover.1727711991.git.agordeev@linux.ibm.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|TY3PR01MB11906:EE_
x-ms-office365-filtering-correlation-id: facab7c6-a52b-4932-43c7-08dce1eaa46a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Vk5zVXRZdVZkdktPeFcyZlZhQllHblFGT1RoRG5pbUozNGN4U1J2aFNyVHJH?=
 =?utf-8?B?anA1QnVkVWlSNkpLNXFlQlZwZU81TVlOQTkzTk9UTXVKNkViVDlHYUVQODVH?=
 =?utf-8?B?REFTSTBoclM5Rk42M3owYlVOUzg3aVVMdXVoMXV5Vm5aeXBUMzFxY2dXaFJt?=
 =?utf-8?B?MjNQVGYxaEtyN0tSRytmcDZiUTVtTzRvc3FqNzdnU2lpdVpDRU1NSkN4KzZx?=
 =?utf-8?B?N0VhdGx4eVhjVGpEL3BEM0RmRnU0S0lRL3NXeDF5WEpsUmg4ZkROM1F0aW52?=
 =?utf-8?B?L204dkFxRVEyZTg0Zk9uOHZCWWNrdEJBMkx5dkR6L3FpbGFMdFVrVVVYOG9y?=
 =?utf-8?B?czRCd2pwckU1WVVBbDJzUUQ3cURQOTdrdjhvaU5HS0RuZGVuTUNwU0g1OUI0?=
 =?utf-8?B?Vk5kWVhXMzJuUHFrU3MwblRNMlFGMkhGYzVyTHMxVUdmQ2JxMmptcC93c3Fl?=
 =?utf-8?B?M3VqRFZ4WkVtaHFGMHBKSmhKMnF2OEJ6QTVaV1JKUkFRNnJZY0c4Ni9hcXI0?=
 =?utf-8?B?TUpvSWNTWThUZ2pueXBmRXhnUlZZSWVvNGlUUzdPUnJXRlpCQjhKSVlXQzB3?=
 =?utf-8?B?N2dIL3M1dW5VZVFXRGgwOWVvdWFhMTFVc0ZSSVZvdGxTLzhFWFdhQk56Sk5C?=
 =?utf-8?B?TkRCdVYvQUlzNityc3JHUjVIVktpV0svWUQ4clBwb0NKeFk3OGJ2UWRGaGpV?=
 =?utf-8?B?cXNXall4ZTl2eUp4MVBHVUM1TWl3SGZoRUlBTll2Z2pyREwyWktCSTZ4ZnlX?=
 =?utf-8?B?MVhLemNrOURSamt3Qzk0TU1zVHlGbVFxbSsxTFltQkpvbVlleXlmNG5aV0xm?=
 =?utf-8?B?Sml5ZlJiUStCQlBIcGN3bFRVY2Z1aHNoWThrNDlobGhwZnRqZkZRQlZJdnFZ?=
 =?utf-8?B?WXV6M24xVnFyamxzcTRzQmpVWjZmWWwvR0dIQVhWWUhvWEpHSFBPd2tCS3c2?=
 =?utf-8?B?TWVUcmNWRzZaVEc5OWtOcmNxemFUQlQ1OE5rTXd0SmJUSGszbm5IRFFReG9S?=
 =?utf-8?B?LzJpZVdreGJ3dTJmWEh4eGp3c2xlcjhMNkllM1hLdkJnMlZNU2ZxRnlYNysy?=
 =?utf-8?B?NHFNL3U2REZkenZjaEQ3d2JUckxrZmJ3RTZKejdUNDZ4RlFSaldEbjZFZy9u?=
 =?utf-8?B?N1NJVE1VaXFobElBc1l2REhQQW1EZEhvVzRpWUhoVjBXSC81OGtDdlgzWUg3?=
 =?utf-8?B?WFJtL1pHUjdsbG1OSWdsOHpaY1pJOUQrZ2c4SVRza2U3bXFJZEVFVWg1aWxv?=
 =?utf-8?B?a0RkOFFJaFV5TmEwYjA0U203N0FaU3BUckpiWXNMRlA1K1E1VWlleDhxREpN?=
 =?utf-8?B?WGp5N09mVEkvWFFIMUVGUXRDTGFrcTJJc2dsRnNIcDBXanpQSzF0SXA4b2JY?=
 =?utf-8?B?blNNWFRTbW1iUHpoZzJlbDc1ZFVCT3Y0KzMzMnpqVVpTd0NBR0ZpWjZEdWVu?=
 =?utf-8?B?T245a3JzTmxFcUpSZmd0RHphTkQ5VGR0dHlCZ0ZEeEk0RW9BaW9qY2J5clZB?=
 =?utf-8?B?akNVMC9PdGRlRThBbzd4aW91RDROTGtTNXBDeW55ejRUUVNhREdTSWhNV3FI?=
 =?utf-8?B?QzdtZDhRRHhYR3VsUjVUQ1E4alVqQkhqQkVjMGJwYVNWSnluSy8ydUN3N2gw?=
 =?utf-8?B?dkN6c2ZudEhEb2x3OXRuenE5SzRoL3N1VS8rNVVndUtoazI0SGpaNndMTFhk?=
 =?utf-8?B?U1dzeC96VkVWbmlLM01PZnBlSGxHSCtMYTRxeEFDSFk0S1RYdjgxRHRHSTUw?=
 =?utf-8?B?MXV2MzJrLzFlazV4eWM1R3ZvS1paUGxyaDdCdWltRUZwN2NzUFlZSFJNU29p?=
 =?utf-8?Q?ySquD+tJ+Y9xiqxP2/skBPwgMJ754KxVuqxvE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXp5TTlWVjdRQldpQjJLckhmRlF5Q0F0aWJHaHdSMFp0WklBTWJIaHFWTC80?=
 =?utf-8?B?UlRvSk95Uk1NMzhWdjRYYUY3WUpSWVcyTTdhUVc5ME1vK20xcDAwOFE2bGpq?=
 =?utf-8?B?OGFKNFM3K3pHLzViYmdVVjQ2SWFsUnFDRFZVb0NYdnRQVHpnV1J1a21ISm5w?=
 =?utf-8?B?bzh2TllYelVSUU5hcklnanQ2SmZvOStYTDFIUTdqUktPRExrUkNqcjRSa1VN?=
 =?utf-8?B?T0xXdjJiaEV0R2dMR0lQVkgxSVoyTnAzTzJXeXIvYVhoQk04T29tYkJBN3lC?=
 =?utf-8?B?TzlIMFliN1hwdENLdExCYzlwZEZYMFNRUmw0cWw1Q2NybkhINjlQelYyazlU?=
 =?utf-8?B?SmxtTk90ZU41TU5Td05TeXBGUUVxNFN4cGRhL2ttNi9ua2tMV2t5SkxScnZP?=
 =?utf-8?B?SFVBSUxlN1RuR0Q4OGVHVktBMUMxRkZiL1NJbTlqWkMwOS9KcHdhZk9iY241?=
 =?utf-8?B?bnJwT3NCMEdhekNHVmE4STM5WWFzd3Y1K2JtTHlGalFRU0NuZmdSQTk0UGth?=
 =?utf-8?B?MXpuT0V1NHZIV3F5Q3BXUzlaaWpnTks5VXBwazg0T2p6b0xaS1VZZW1QMG9Z?=
 =?utf-8?B?aWxRWEJzOE13aXJzWVg2UGsxMHladytjL05EUytwdE5pMVl2eXZRZStJNVBI?=
 =?utf-8?B?VnJVeThoTXNlOUNpcGVTZyszZGtONlFvcG4zSHpJbS9WL2F3R3ZBUzZGYjFU?=
 =?utf-8?B?eHo2YlIvem53dUhGT002cnMzSTJ5Slg3RVVkOXZ0Z3pzaUlacTAvWHJQSXJD?=
 =?utf-8?B?NEkwQnJvZmQrc1hNNzJ2cmhVL1lDWVFuN2hkRW1ySTBlWENSektnM1pWci91?=
 =?utf-8?B?Qksxb0xVVGtMdjVCSXNBdFJLM0k0ZWN4ejBkR1FvMEh2NlFMY2ZFeVplK2Vs?=
 =?utf-8?B?OFlQMk1MOTAvZ0FpdVNQcnFPYThGUUlPdzlMS3h2WEY0d21LeEVJalRzWVU3?=
 =?utf-8?B?RzdQcVIzSWZ5bzh1M3E1Q2JVTUh0ZVNkd1JlMS9wVGprT0oxa1lzOE10azJp?=
 =?utf-8?B?LzJQZGhOOTVwSkVWSk5iVW1xOXhSVWJOMXpmNjlvTmZzMHo1OVllMTFlUGFy?=
 =?utf-8?B?aGFxc3kva21JUE93NWNqNTJBRmZlTVI0KzdkSkhZWGRPLzlMVjFVbk1VYVk5?=
 =?utf-8?B?MDN5cDdMWEFBdHVIb1JyYXc4eVFNelNIT0VKTkdQTDhpSTIxa3JHSDJZcnVZ?=
 =?utf-8?B?QkcrUUI4SlBGeW85eWtJRGQ4ZzFqWnV3UW5nN2xHb2pYWHBVQm5KREQxd2tG?=
 =?utf-8?B?ZXVTMG84Q2JwL0FPVDNmdllsVkhJUll2TTlWNDJkb0t6SGN5L3V4cVNrSVlH?=
 =?utf-8?B?aXIxT0NZVjQveTJCWkQzc2dQbzZWQlAyVzlOM2FTZFM0dXZnbG0rSytRUEpW?=
 =?utf-8?B?YkRmRDI0UVBnOFBLcjRMclJBQ052cnBHYStpMmtmVk9qT1pBWll0RFdzcklY?=
 =?utf-8?B?SUI4WEl6VEJqaXdxOGt5UFpOZlVTN1kyRmVldnM1UFlGOFNYYzJRcmlmVXZp?=
 =?utf-8?B?ekUvOWl0bWpCRmlQbjJEbXNFUmwreVpCeUxVcWRUZVk4MDc4T1N3dGdzK2I2?=
 =?utf-8?B?UDJtSGxYeC9PMTRLd1dOQTk2SzZBK2pMN1hLZjBWVWxxcTBxcjNhbUp3VWpO?=
 =?utf-8?B?SVQyV3lFT1UwTG5oZHBZYUl0QUVra0REOVVxVWpubElJK284Rjh3R3d0bFZq?=
 =?utf-8?B?QmtsUEp1eWVSMzFJQlFObEp2M3dIc05MdUNmd3FCQkFQT3ZYK2F3S1Foc1NJ?=
 =?utf-8?B?OER2dExtNWlkWHlMOHNPTXo4Qy84TnF4eVF2R3g2ckY2Y3MxQ1JzTzgxM0w5?=
 =?utf-8?B?d1gxNWhIVXFhVFc5bzNyMk1CUmU4TWJtSU8xUmhmZTVqVUJBNnQrU0VuRlJH?=
 =?utf-8?B?d0xuK0JyTFlPRDZwMU1kUnJNWGdKTnc0SWczM2dUZHdPaTg3NmM2bWdubnVq?=
 =?utf-8?B?SHA0TkJYUERXR2xZdHBmM0FiVUJSUFpWQXo1Vzk3S25CMGFaUzZqRDFBNUpI?=
 =?utf-8?B?d2tEY04vNXBtYXphbEpmRmJyeWE3aE5KVFQ2T3NFK1c1WUxISUVJRzRSMEtE?=
 =?utf-8?B?ODd4WnBVcTJPODNOSWVUSktydXJPSjBEUGpsaHRzWmJtdnJtYUVsYW1SYVVs?=
 =?utf-8?Q?E+N997A6XSueKMaamoJ11YwgW?=
Content-ID: <DB2EE3BE3475EA42BDC7709B03421A06@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facab7c6-a52b-4932-43c7-08dce1eaa46a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 07:28:27.6202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3XtgtL162BciOoVwup4pC3eaSDZEfiHGC+7Qrhgg5vz+i96rWLKTd7JjPNMv1r7V1oYcab7KKa5Khbh8+CEOBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11906
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241001_002842_075652_303B9B84 
X-CRM114-Status: GOOD (  10.17  )
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

On 2024/10/01 1:12, Alexander Gordeev wrote:
> Hi All,
> 
> Please find patches that fix issues on s390 only.
> 
> Thanks!
> 
> Alexander Gordeev (2):
>    Submit physical address to is_phys_addr()
>    s390x: Assume zero value of OS_INFO pointer is valid
> 
>   arch/s390x.c | 3 +--
>   elf_info.c   | 4 ++--
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 

Thank you for the patches, look good and applied.

https://github.com/makedumpfile/makedumpfile/commit/195884556117f0a4162d480a586a0eefbbe413b2
https://github.com/makedumpfile/makedumpfile/commit/90dc30d9c95cceca0f1d14573cf68d982b9a93f3

Thanks,
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
