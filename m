Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF57CC27C4F
	for <kexec@archiver.kernel.org>; Thu, 13 Jun 2024 05:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sKw7DqkMOPyxzfwmqZjIHdeO0lsWJsQyuc1JPO5DOPY=; b=mZsqZHTfBTF1Rf
	7el3te9ZWtM/lHWiu6ds0ugpSg0iNvvXtCOSYal0PxUN2WRLWd/7LkbKBqwt3w7d7q3IUDzY9BEgf
	0UizWYDnRGxwLzVLZJ3JXo6LTgLyS6mrZ9lkmDClSMRTxtQwSJmCm2caZvRMVYgDC4dEIrXGcthTa
	FxougAMHbA/8Fn7t6Udmii1lHx2vK4SFlAa24eK0hHYPWN592ooCn9Y21LKNi44ZKxai7JOGUZpBf
	9A3Z/Wk1tTWRSbJSRBX0fzUq/aD+I8rC5PTtEsPNGkIx0a7oPitqCrevXvt3SnZyBYJLYmDm4gE58
	PRN4i7scAw0BTyAnzMpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHdFh-0000000FCcO-3DHS;
	Thu, 13 Jun 2024 05:44:01 +0000
Received: from mail-os0jpn01on2062a.outbound.protection.outlook.com ([2a01:111:f403:201a::62a] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHdFd-0000000FCaH-3CCp
	for kexec@lists.infradead.org;
	Thu, 13 Jun 2024 05:44:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8vbwupGX8kWTY+og/Q86/MuYJJh2GTFLNszlYhl8tKdDY0exnBc1BbLLynXkNI0umMm6OIhRZ9Z8XUBK7WhAggLYxHnjUfsKr4SdKHc6U08e28I49mOofGrmlAKZFLWpnOHtnHmg7kc3YEENn+GLW9Ql633qSpWia69vboeaH8U14MS3eiH5g+x4KjFi77OlnkfTzGlee+bLW0GPDb9fiUofKifSGg1BdKL6YZprZn4wMo9Y6HfErs/r5WpfwLBHJN0lu+RJOewrddqUu5+9jFm4wf6fHuv8O+YBiZPE8FJyigyV+8AymSySP7s37tuxf7HVwOZEqHzUyJKu0Yfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ecH5NsAkWKWFmxfjzscOL9Qpm5liqef3BRwn3KEwO8=;
 b=btQTvk89iZm3M5C/KkIqzfpD3GkSdti+z/ZI9Bxm2W+7EaEMZ3GcMByEo03bVjw5nDuezIEv2nKgXZw8DHJ7FuYQ+/7okA58RaYw9lJa4TLge5sIK42n1jK5hv1rMf23o+Dw9Y/lZpKc1Rodyx9tdi1/VxiuTqu39QM4veGnXR9oRIBhIXEJTTyRlGz7jmysKpmZ1uS7eUXrwjL3x2AHG7lKrkpZZgIxJEUYPvtzTQ2s5eT1oaqYPEFbq4DQlExL9VrtEX0s8YcztyeHcWXHXzmxv8rC8gUPExmCTl2yNwitPxeuZaex9g10Fk1PUEa9rfb1wXhMZcJQAVc/yjO0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ecH5NsAkWKWFmxfjzscOL9Qpm5liqef3BRwn3KEwO8=;
 b=m1lueRwgEmQMYqWMJ5InD4CxefTIvVNu1d2dcEdyG9qvKmRv+lDOL7UL9gSbLit5YooqWZMFOkCFKeSWiV4GW0LaiF4QfgK2fD0oMWor15NsI5Og63NE8+gTTnFw6LhdJWgEK6q/uocm5NJBQ7/JC5K5EVNhlWJE28AXcz07opr/rN2kRRo+0yRcnx8D5QkSRPv2ROU+w7aCgaeUKPf54bU2yBWoPxPH4lhWTjV4fSy5/2flXFZoM2sbSfParsD5I4kIpAhQ4cRU67841Ihjfy2RfX6ZNi+OvtYT2CT8SFi/ddqh8O5+AC6yzf/5dJ42U98ZElb2KgBfODYTMK9VKQ==
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 (2603:1096:400:3a5::14) by OSZPR01MB6924.jpnprd01.prod.outlook.com
 (2603:1096:604:138::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 05:43:34 +0000
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c]) by TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c%6]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 05:43:33 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
Subject: Re: [PATCH 2/2 makedumpfile] Fix wrong exclusion of Slab pages on
 Linux 6.10-rc1 and later
Thread-Topic: [PATCH 2/2 makedumpfile] Fix wrong exclusion of Slab pages on
 Linux 6.10-rc1 and later
Thread-Index: AQHauKSxpq/YPA+zKUeEOuU9OWvP+7HFN/eA
Date: Thu, 13 Jun 2024 05:43:33 +0000
Message-ID: <bb9512b8-f511-4d74-90c0-139fa18addae@nec.com>
References: <1717055930-23334-1-git-send-email-k-hagio-ab@nec.com>
 <1717742044-27933-1-git-send-email-k-hagio-ab@nec.com>
In-Reply-To: <1717742044-27933-1-git-send-email-k-hagio-ab@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10963:EE_|OSZPR01MB6924:EE_
x-ms-office365-filtering-correlation-id: db5c07f2-a2e6-4737-5239-08dc8b6bc3a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info: =?utf-8?B?aVhHS0g2Y1ZMalNNYzI0Y3hzbjVGSUR2RXFGeGdqNzUrVFVKSEFSMENueXFl?=
 =?utf-8?B?M0JhcUZnbmFqbzB1dHhYSVdxV1lLRHVDUmFBd05XcUNLVmo2eU1CMVg1NDg4?=
 =?utf-8?B?WGhLV0VLWGhtbnRPWnR6eFFHanRiM01sN0pTczVCNXdlZkFkSmlTNFdRYm5C?=
 =?utf-8?B?dzlxeWRJQWxuYzJhbkxNS1hBdGR2TGUxcitIdTJnRW1HNXRwNTZWL29RUWdl?=
 =?utf-8?B?TTc2ayt0cXY5MVZiZ1h2c2ZDdGxPMnoyREdWQk5TNW9wVDZEVmdSSU8yMHpK?=
 =?utf-8?B?WDVEbG5lUkJIU3lvZEdYZGYveXA1Ry95RVpWWGVDWWlRWS9TY2FrZW5RT0dP?=
 =?utf-8?B?dDlmQTJjd25KMElmSEU4UE9sSGVhU3Myejh4aGdLYUlJK2lBbExmVHo5dEox?=
 =?utf-8?B?cnFWdTNqUTBEdFNUY1h2RU1RREFrRmhMK3VxSm53RnRVdmZMWHc3clNFdm5h?=
 =?utf-8?B?OGF1c0NVdnBDV1ErQ1JEWTFMWU9TMG5YUmRTMFRURnVicFI2Nml4UDJrbjlF?=
 =?utf-8?B?YWRFanZLNGJ5VHpwSlFKQjNwUEQzUHozRE9aRVV0bXlLNFdoQXE0amp6SlZ4?=
 =?utf-8?B?cGkxbFdRbUpRczIyeWVyanVESkVHeGpRUndJUlRmRGVRdVlVNUN2TkdJMlVh?=
 =?utf-8?B?MCs5VGxad0NUTmxOVE9JQlFvRThSb2U3NTJ3dTQ1L0xZTGFoTDl6b3ZQeXdV?=
 =?utf-8?B?eUZKMWdiWG9pRGpLWGh0SFlzVklRYkZxK25oWkMybE0wcEE0Vnd5ZmdET3Bh?=
 =?utf-8?B?VnRybHRlLzVySzliMDJmcGxEbFBiemxoT2RjMEhneHZETHRUR1B0QUNlQVNP?=
 =?utf-8?B?bVJrc0FaOEJTN1d2eWZjdDltdy9iakk3SGcvVmNqS0tGYmNlbk5CZi95YVV6?=
 =?utf-8?B?ckN0MklBK0Z1dkxQM204ZjAxUlltNVo4VzYzcTBxTUI0OWxMVHRmODJscUpu?=
 =?utf-8?B?dlA5OXA2MkcyTk1IK3VRVGJpNDNJa1ZSanA3RlpITkRXUEVha3dxZzNkTkF1?=
 =?utf-8?B?Y2VpQ0lLY3pyZHovRW5Nc2ozV0dLY01mMGlIZjVIK1pNZDRvYjR5eTBlQjhK?=
 =?utf-8?B?U3ZiZ1NBSlV3a0VlcTBFMWpXblNqU1JsUXcwbTF5VmlYS3dLUjR1eUNhdC9j?=
 =?utf-8?B?NUErTFVvc1JuTiszOEdnbTFDWlhJT3ZBa0RESlcyUXNFQmJ1U3k3REI2YTJJ?=
 =?utf-8?B?NWhNTEYzS2FGNnkzUy9aZ29QWEcyVkg5OElUNGtZMFlvSWh6YWxnQlFINy9l?=
 =?utf-8?B?RzVBa0p6dmJpUGZFaUxiVHFid0M4N1F3NHJwREptckxMbExBZGhKTUxzTkNn?=
 =?utf-8?B?aDJGV3BvOURSNko4UFJKcWNEdlF3NmxLN2JFWkQ5d3pKNEhaS3Bmd1VEdDFo?=
 =?utf-8?B?clROK1Yrb1BLZ2xjcURsTm1ZQW5oWEFtbkY2WW91WmkySzVhVEE2NHRMd2NB?=
 =?utf-8?B?Ui83N1A5K2FiZE1aRGtFcGVhTG9vckovTlMwSGhzd1BxcUNZZU5JSy84TlhQ?=
 =?utf-8?B?MDYwcEtLd0hiMm9NeG4zK1VCMTNwTmdSWXFtYWpMVGdqOVpOdlFFd0F1Nkly?=
 =?utf-8?B?aGVwaHhZV2o4OXExUGpBT2R4VE5TZ0tScXROS0NTL3pLSFFFa21Zbi9PSnV3?=
 =?utf-8?B?VHVjM0pweTZVZWpLaHJCL2h1R0V1TDRqOEVCSzV5VEFEeFNPdTV0N2FVS1Zo?=
 =?utf-8?B?WmhmNmhHMXhPZEM3dVVVZGg3dHFCYzlTdW9tdFlzQThheVhSK2p6OGJyZHJ1?=
 =?utf-8?Q?rY8N/kOQtJuKfZ7K6k3fdAfOW1kofMo6ca03++C?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10963.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFBXdTFrT1d0eENQSUxIM01wUHdzc0hCd09rWS9GbExjOFgydVZQU25DdWRm?=
 =?utf-8?B?TFBhZ0VtUEhZMEFnc1lta0RDblh0SGhRZjR3SDEwYVRSNEZhWEVZOVFrZE5R?=
 =?utf-8?B?VXd1aDFyNHpBL004cDFBOXJWNHJmMXFjTnkxcW12d1ZZRkg2WHNVUmJld1Jo?=
 =?utf-8?B?dnRLZW5kTVhFREg0c0QwUkEwTVYra2k4ZVJ5WUJkbVcrNG92a1ZiVWdMVG9y?=
 =?utf-8?B?R3RENjM2MVpoc2hSTWxYRXRlQXpHdmZEWkNNUDFuQlZqMmxXQXhoc3Y0RG5Y?=
 =?utf-8?B?SHdHTmRNajhsVWZ3MC9WbCsrcGVNaWMyR1RyNlFDQ3RrNS9VU1Rjc0tDNUxR?=
 =?utf-8?B?OE9oQW84R3JYWTNUN0t6bWl1aVZjNkJRdXZSbWo0YzUxWktWb1hFdmg0eGtF?=
 =?utf-8?B?Y3gzMWo5N3Y5NnBwY2tqUmw5NDdCT0dnTlJULzQweGZOakdCeXVncm1sMmJh?=
 =?utf-8?B?LzNudk8rb2lDL3BXQ2Q0ZGZtTlA4NnlvbmN5VFdWZzJRQ2xrV1dvdVhvVFRE?=
 =?utf-8?B?a1pmL0RlelJWM2ZlanM3UnlxZWdjdi9oNUhrVjV2VnFzdjdDdmM4clIrK2Rm?=
 =?utf-8?B?akc4OVVXaCswMEZNQUVvblkxKzl4ckF1T01oSVEvMWdUSTJCOWkyY2RkZzNr?=
 =?utf-8?B?SzZPOWg5S0VjZEFRUzlXTHVYM3BkbjlyaWpROHN5SHhGYkxLWTIyTlBCbHZh?=
 =?utf-8?B?bll3MjBRNC91LytYZDk2aTB3cWRQVVpQeDZNeE1QR1JOeEgwVnU1MXZobW55?=
 =?utf-8?B?UlFqWTJOVmdFeU1haFhnTHJJayszRFo4RkNBc2JPVjJYMUxYaEdlUUdWM2ZP?=
 =?utf-8?B?S2ppZFZTTUpveldHUVlQS2lMdWxOZnpKMkxjSWcxQnBCSkZ0V3A0TDBQbHAv?=
 =?utf-8?B?MDlkNmVXWHpMZEJYL09RZVI0K0xzeTAwVHkwdGdZdjk4dHM1WjN2K1FkaWht?=
 =?utf-8?B?UTJYVXN6NCsyVzVwbHJxbkhUZkEzVHJKSUE0YlFLWUFSMWF0czRLZTdJSjUw?=
 =?utf-8?B?b1BiV0JSYlhBQURKUEhadWZzNlltWDI5T3pya2FxdEZZRGtKc1d5RUZZTWJp?=
 =?utf-8?B?L2IwcldVeUtYMWZBR1llMWVCbVg3UEJLei8ycDZUcEQrSitCd2lQem1oNldY?=
 =?utf-8?B?RVBndk9WOUJOVm9sODAyN2NrQ2ptMmFWNmUzc1lMQ21KOC9uT2o5YWtNZFlr?=
 =?utf-8?B?YUFKM3J6TGh4QkNDaVNmNHo1SEwrSGIrRys1RG8xYjg4QzJkeDNxeG1rMUtl?=
 =?utf-8?B?dU9nWGUyVDA0bnhGTnpGZVBVS3N1ZU5iNnMxV0lGd0tuRW5pekdpRm9PVVhM?=
 =?utf-8?B?S29tSWJYQlVWb2FRNjN3OEYxRlZ5ZEJsbDJJWHM0LzJWZVdwVk14MTlqT0JV?=
 =?utf-8?B?Sm9nYkdlRzh3VC9PdXBaV2Fjdjl2WkNhOWpMcWhpVmFJdXFERUZNa3NITUlZ?=
 =?utf-8?B?Ym9qNnVQZkpabmFWOXhickRZMjc0M1ZvMXQ5M3F2ZXRLWEVqaTdGMC8yTklF?=
 =?utf-8?B?eS9qVjZ2bW1xczNvR28wVG9kMnpmVjJZRmR0akZBRVlIODJDMng0OXVDVVJV?=
 =?utf-8?B?Z2Yza1V2YWNobGd0eTdsMXZWYXh3T09RTElZSEYzOFRpbURPc01RRnl4WU1S?=
 =?utf-8?B?MTR3RzZtOThIdjBHSm5XZGxLY00rdjk1UWZ6U1JvYms4VlNaRzZ0dTdKR2xR?=
 =?utf-8?B?aFZ2UDFnQm9FendHeWdIWVBGR3JQRDhweXdwZWh3bXdwdDg4MFB0dnJJSkRG?=
 =?utf-8?B?NDN6eUI3MlFIYS9Ja1NKbjlkOU5HQ3AwcG9xUGJwVlRZUFN2TGhWTUdSdWlq?=
 =?utf-8?B?a3lzWGNIR2hrZFBkSzMrR0JaTDVVQmovTTE0bnVqYytyZ2FodjZ2U2FHRVRI?=
 =?utf-8?B?ZFdOc0lvOVp6dVJQVVRiZzJDTkdNY3p2TkN2WHZMcjN5dGhXVS8zL2g2WGhE?=
 =?utf-8?B?UWQ4aDY0dEd6VjNhZytWUTlTazIzRVIzTklwcFc5cmVpMmlTWURuYTVxTDNI?=
 =?utf-8?B?MHhJNkNjeUl5Q2o0OTlka056bkYzUUdCOVJqMDd0WlVvUHpUQThPNjRpRW1h?=
 =?utf-8?B?OXdsdnMwNHdva0U5aUFob2VaQldET3hMYVYwUmtMaVdaUnc4MjN2THJXQWc5?=
 =?utf-8?Q?Q7Xnq3enTO5u7t2tDzitOpoI7?=
Content-ID: <517EFF4CF24BE74E9D760E771F7BFDDB@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10963.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5c07f2-a2e6-4737-5239-08dc8b6bc3a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 05:43:33.9341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GZSpv+GCET39M30YmUE9TLvScBubUkBf3k1T4k46aR3shSX3/igXsf4mnMFaZJZs340Fdi2maTEfynJ8vSNEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6924
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_224358_037820_AAC67515 
X-CRM114-Status: UNSURE (   9.10  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

DQpPbiAyMDI0LzA2LzA3IDE1OjM0LCBIQUdJTyBLQVpVSElUTyjokKnlsL4g5LiA5LuBKSB3cm90
ZToNCj4gKiBSZXF1aXJlZCBmb3Iga2VybmVsIDYuMTANCj4gDQo+IEtlcm5lbCBjb21taXQgNDZk
ZjhlNzNhNGEzICgibW06IGZyZWUgdXAgUEdfc2xhYiIpIG1vdmVkIHRoZSBQR19zbGFiDQo+IGZs
YWcgZnJvbSBwYWdlLmZsYWdzIGludG8gcGFnZS5fbWFwY291bnQgKHNsYWIuX19wYWdlX3R5cGUp
LCBhbmQNCj4gaW50cm9kdWNlZCBOVU1CRVIoUEFHRV9TTEFCX01BUENPVU5UX1ZBTFVFKSBlbnRy
eSBpbnRvIHZtY29yZWluZm8uDQo+IA0KPiBXaXRob3V0IHRoZSBwYXRjaCwgIm1ha2VkdW1wZmls
ZSAtZCA4IiBvcHRpb24gd3JvbmdseSBleGNsdWRlcyBTbGFiDQo+IHBhZ2VzIGFuZCBjcmFzaCBj
YW5ub3Qgb3BlbiB0aGUgZHVtcGZpbGUgd2l0aCBhbiBlcnJvciBsaWtlIHRoaXM6DQo+IA0KPiAg
ICAkIGNyYXNoIC0ta2FzbHIgYXV0byB2bWxpbnV4IGR1bXBmaWxlDQo+ICAgIC4uLg0KPiAgICBw
bGVhc2Ugd2FpdC4uLiAoZ2F0aGVyaW5nIHRhc2sgdGFibGUgZGF0YSkNCj4gICAgY3Jhc2g6IHBh
Z2UgZXhjbHVkZWQ6IGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3M6IGZmZmY5MDk5ODA0NDAyNzAgdHlw
ZTogInhhX25vZGUuc2xvdHNbb2ZmXSINCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEthenVoaXRvIEhh
Z2lvIDxrLWhhZ2lvLWFiQG5lYy5jb20+DQoNCkFwcGxpZWQgdGhlIHR3byBwYXRjaGVzIGZvciA2
LjkgYW5kIDYuMTAuDQpodHRwczovL2dpdGh1Yi5jb20vbWFrZWR1bXBmaWxlL21ha2VkdW1wZmls
ZS9jb21taXQvOTg1ZTU3NTI1M2YxYzJkZThkNjg3NmNmZTY4NWM2OGEyNGVlMDZlMQ0KaHR0cHM6
Ly9naXRodWIuY29tL21ha2VkdW1wZmlsZS9tYWtlZHVtcGZpbGUvY29tbWl0L2JhZDJhN2M0ZmE3
NWQzN2E0MTU3ODQ0MTQ2ODU4NDk2MzAyOGJkZGENCg0KVGhhbmtzLA0KS2F6dQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QK
a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2tleGVjCg==
