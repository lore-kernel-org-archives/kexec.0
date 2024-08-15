Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46531C52D7C
	for <kexec@archiver.kernel.org>; Thu, 15 Aug 2024 14:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hmNHGRKKKwKDGX4sp1jgtKMSA7JdJh+vRgJnv+F3ddw=; b=kNNTT+5cawQpmO
	NtbUAIIh9lXwFM41zwVH4jSE2sAC1LHq1v+LOABX7oz+N6bcRK+TEjYfgZeEyrXUW2pdLnsZeu4u0
	VxKtNkCHB4n/aqjVPuBeEmO5IP4mbBEJlFkeHiHXrjnhi3qypf4s/jncElLqFrDnkUdkKhpBIFOUz
	cq8qcK2wk/R7yhEs6hnFjSrXgBI4EyI+WECsCYDLJU2piuDkU12EzRlZRRQ1kLgTEdvIPHc/3jA5X
	svYaU4YJMXt4OvqhuRpiXb31SV6C6kYNLnGWZuXxZOzjlo6tBxnLvGgToa9U6BQlAeW3wP1PSLO1L
	n7aSxuRPk7x5hlWWq0AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sebIn-0000000AB9S-3nl1;
	Thu, 15 Aug 2024 14:18:09 +0000
Received: from mail-vi1eur02on2044.outbound.protection.outlook.com ([40.107.241.44] helo=EUR02-VI1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sebIl-0000000AB7C-0Pk3
	for kexec@lists.infradead.org;
	Thu, 15 Aug 2024 14:18:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4WAB7hEPxhMGqjZ2NGNNW39fv9VexIiDWjjVIpfdUX13GNBp+xRct2pCxKN0pMIGR2mKmGUnTVAb4syRmH/UcYMDY0CmtMUAPtXSFVkodrVRjFiiNR7KLPTJW3+7IlJta/meRtYpf7iCBX1C8DRmgjbHuGXrUjURRgjRUl1jIsP71fDehS0QsOkgX8kfu8/rMg9T7I9/JWyM4JsFjRWrseemjplq4Lla+eJlRDzt4Q4pKaJhIB3EdqNEZ8r1jC2gVFg73GeZGrjKIoFuOSairfMS2AJbClS/uoVK13B7We17BmVEwG4RFHQL4ApzOSmQ2HfQ/uOMcEcNQzaWwgFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zIYr/aqVKbngGNS/1ZvEfw84jOqkxI6t6IJnXHoej0=;
 b=IeJ2jvaZWtQQFCsgCfIIobmw4s8DnL1H1Ysf21DyQnHr2HxyFB/hliRYFuhwBTCtH4M+Vo0ngM23mSoQwUKf8inOIOzIbXfO6MNX30bvbVCQBXRLqQ///yVZsaUK0P8sqVrXKfUfV/wDKSSflq10VVai4W7I+Kk9AjX2arrW037cJ/ZWPu1FBOR9SZMWSHqxaOZDFx/m/RjFO3xHNDVl3ZvOggvSeQBWwbY/eCqYlFCg2ws6AeuMPLsPkUIG7bDhLmawiF3i4XmEwFRptu2jKbjvjtgMq72DVNq50wgIzl7DdgEnTCVvfaSF+Bymi0U/njMqhthFoM1SY43zP3NYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zIYr/aqVKbngGNS/1ZvEfw84jOqkxI6t6IJnXHoej0=;
 b=AG32lmPdKskabPiPJkHPu6IicTd5EghiNw8XLycGQq1vFF408cb05J57xMVUKGqwiCdHo88HvuwflYqG6Hyu0p8QhvnEO9AJqa4Nm1N5ph6+e2iQV3i6XN9KZedrDWDz/JFbGBhj30RV+7kD7c3KCNo9W/BNl9yPbtI7DEiq3i0FjCXr7ZNvRhBMSIv8JfSIHoZ8Q1WPKPNg/nHhLu46fWY8wc6Q/bkNFyuyegqdp02yNNCgK+OFNcViuSZBFriDk1SFlpJuUlg3tYQxWL2wuuQAjsrdYJr/I14Xp5yvUZ91/jeP1ESCd392mV8LQSUipQ5eHZSKbTZtRWDpekZ1jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by VI1PR07MB6543.eurprd07.prod.outlook.com (2603:10a6:800:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 14:18:00 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.7849.024; Thu, 15 Aug 2024
 14:18:00 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Masamitsu Yamazaki <yamazaki-msmt@nec.com>,
	Kazuhito Hagio <k-hagio-ab@nec.com>
Cc: kexec@lists.infradead.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH 2/2] sadump_info: Return empty string instead of NULL
Date: Thu, 15 Aug 2024 16:17:34 +0200
Message-ID: <20240815141733.4050230-3-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240815141733.4050230-2-stefan.wiehler@nokia.com>
References: <20240815141733.4050230-2-stefan.wiehler@nokia.com>
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|VI1PR07MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: acfe7b7c-5e27-462f-66a6-08dcbd351191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHpGUHFySHpnTjlHNit5T0cycmhqc1J5MEtXempWcElDbjlvcEVRdnlDaEM1?=
 =?utf-8?B?TWo0MkVIQVRMS0ltaGJjRnVqNEUwanBXV0FWQ0FEczMvbW1DNGxyWC8wcWlM?=
 =?utf-8?B?YkpxeHdPeC9KbjRTVUVYMWEvQWl0NHBUckNYUVhNSWlaYVlibFBVWk84a2dV?=
 =?utf-8?B?R29mdytXblRJZmdORFlSV2FqKzF1d1dXQkNIWU5JWm5ISExBb1h6SWlBU3pG?=
 =?utf-8?B?Y2VrcVJCNEtOY0V2RWdNRkFYQU1aL0hUTHN3b2lyMFRzYU5XNUZzY0p5VDAx?=
 =?utf-8?B?NGc3anczekVXU0dLejg2UkFENFJmNDRyY2pvdFBmSHB3b3NZdWk1N3V4dndw?=
 =?utf-8?B?SWMyenNZVlZ4NGNQUkJEZm5OemszRkE1ZVlnazIwWDJ4SjlYRmk1UTVDSklz?=
 =?utf-8?B?R1QzUUw3NElsYVJ4eWVNNHhlYUFjYlJzMm1zcHpUbWRzcnRVeEdBY3kwbDd5?=
 =?utf-8?B?eWZGTHJWUDJXTGZ5Y0hkZ1JNOUdQWGlVYWltN0FYUjdVTHB4QUpnREpzaDVt?=
 =?utf-8?B?WDFhbTlETFAzTWIxanN4Y2k3YzdtZ3hYMG9Vc2lOcFFmZ1Fza2Nsd0l6b3JP?=
 =?utf-8?B?ZWc3Z044WWIyV2tmQWVGei9VSVhFTGNhM0ZNZGh4KzJTQmliWGdPTG9EV2xs?=
 =?utf-8?B?OGVqSk5QT0ZDa0RZOEtDTENsQ2p3b0RDVEtGMnV1bVZCZE16dHJiRGV2alo2?=
 =?utf-8?B?NDVwMnlHWDZGcE5hTk5UM3dnOUh2dXE2ZGNFM0YvMWJxWlRUQ3hKZUZiUGVo?=
 =?utf-8?B?TlNaUnk2TEpOMTZBNXl4cTBCTHI4RktZU3lyM1NGcGt2TFVBcHVOYVZKVzEz?=
 =?utf-8?B?Q3l6Wm9CQW0wUlFzdGFGRmZNS1R5THg1OEJSRnN6S08vUmUrbVJHdWZUY1Fn?=
 =?utf-8?B?bTBrNXNDVms1SU5HY3pKQ1BucjNPSkRNWVphbkhVRHIyTnUxYjhacGo5dDVq?=
 =?utf-8?B?ZTFWMk90NXJiNVEvWCtsbDhMY2RXNGEvUHRYSC8xM1BVNlhYeVNqb3JrVEI4?=
 =?utf-8?B?UVB1VitZQWt3WXVlbVliVUx5RkJxODhTckd6SjZLQkxMZG1ib3JJNldSb3Jx?=
 =?utf-8?B?a24vQUZYS3VUTC9MMEpUaVFZWEk2Ri9sVmJWM1M0cjhacm8rZ1NtVTRHeU9K?=
 =?utf-8?B?QjRMVEJhVmthZ2ovY25JUWUrbitCNDZnVGFkSzdIb05jQnlvOFQ2SFlvS0pi?=
 =?utf-8?B?SUpONStpc3ZxMnVWRGEya2hIc2tZZEtocm55UGg3SXlwYzk0RzhpKzFIQkJN?=
 =?utf-8?B?enFyckhPM2JJM2Y0YTZxR1BjUzFWbEF3R2RHOGFtVDFzV2U5MnllM2RyT2ZP?=
 =?utf-8?B?bDg0SzBQblhoZXAydDdCSW9VbkpkNEdvUDZRUTJQMjNSZGNucWNqTUZRd3Jk?=
 =?utf-8?B?RFJZWUhUbnFYR1NibzRiOWMrNjZDWHAyTE1PWU0wK0NhRkVoeStHd2FDeHNL?=
 =?utf-8?B?UUN5NWFTT1J3VlhYWU9idlNnUDhPQXU1ZkpjUVF5UWx2ejl2b1pnZElxVTdZ?=
 =?utf-8?B?U2NhUCtraDFIZ3hxNlIzbnp4b1YwWk5NWmEyb3FLdFcrbjVnNGNCQTZqMktL?=
 =?utf-8?B?VldIQ2xieUYzcURyUXFmU0w4aFRZbE1ObVozamVBNmRXcEtRWVVNRFhJNUE2?=
 =?utf-8?B?b0wxb1VjNm8zdTFadndJZnpsZ3h2TVQzWUROazVkUTkycTVabDI1dit5bnkr?=
 =?utf-8?B?bkxadmlPc1JkSlFua0phRkN6R2JzTHZlWXZoQWJEcUFKUE4rK2Q2dHFwRXM5?=
 =?utf-8?B?SitWUEhoQU1rUkhNUzA0ejB5OFlROEdFYnlETXdWRU85ZmdrSUoyWHhrRG14?=
 =?utf-8?B?NnNETGVlNnk3cnMyUGN0KzBjc2RoY0FCSXJjVThwOElGaDkwbU5TYVNqa0w4?=
 =?utf-8?B?NFFQVjl1UEhTdXZFcWxOY0lZSjlRYjgrNWFTZEJiOFpBeGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2t4bW1XN0tiNnNwRkRvVXlvRDVyQ1F6cFhkaDNmVE45UFYyWUdKS0JJcWVH?=
 =?utf-8?B?NVlmc0xxS05OL0hoNW9UbDB0TG95cDQzVXkwU1R2KzJpLzhtaE01a21La1k1?=
 =?utf-8?B?UFR2MjFybW5uOC9Weklsbk5vY283TXRuTTdNQ2IyMWZPNjNkRXVSa1BYWU9T?=
 =?utf-8?B?bFdtclowUXBqTU1RSDZrRG5zd1pKeHRZYWF1LzZTMkpXaGxVWkRrRlQ1RFVu?=
 =?utf-8?B?bDR2SngwMkcrOStFOEZwRHR6LzNQNVExTVZUMkF4OU9NTXdsUW9JZy8wcHB5?=
 =?utf-8?B?OHRObTZGZ0pxUjJiOVVScy9wenJhU2dyUDhReHp6cnpHVDV0UnhWMCtlTFRD?=
 =?utf-8?B?Tk8reUhQaWRieVNENzJydkNpN0FIV2lWcU9tNjM4TmJsNy9wUG5Wb3Q0S0Fq?=
 =?utf-8?B?THY3Qld3eE4rcmFFRFlHcDROdUNLR1dLV2k2WmxGWG5wVnh0M05hNWxUdVlT?=
 =?utf-8?B?dFdyL0NIbFBKUWc0TzhVSGM2QjRHS3NBWjZ4cEk2ZTlSbnNrTHBjV0xnU1ZU?=
 =?utf-8?B?dE9Ec1U0TTRpZUxUU3pyZnVaTXgwdExmYUs0cklaTXdjYVNlQzNRTXRZK2hN?=
 =?utf-8?B?Q2ozbWZzbGY2L2NTQ01uZk9OaTBHN0xkUVZwRU9GaDRjSVpIc3l5T3dwNktM?=
 =?utf-8?B?Yy9Bd2JiK3FSUkhmMElLaHNOazdaQ0JTU0Vobnh2Y0ZIR1NkQm5HV2R2eXp4?=
 =?utf-8?B?Q1RZamRaWGRuSUZUWlY4WmFjcGN1eUVHWkRHQ0VmcUYxUFg0UFQvVmVLSFRj?=
 =?utf-8?B?K3pWUlVKb1ZnZnNBT2ozcVpMMUVpK01vVGxPaHJlTlJjanFnZnVZR0ZXQ2pI?=
 =?utf-8?B?WHV4Wnk5T3RTZ2M1aUpXRjB3bGVyQmxyMWtoanNveDY0M1VlT3hreGV5OU4w?=
 =?utf-8?B?SW5uSHZJb0llcUFnU3M1VklEbjdhRERqU2tLTU0vSWRwZnJNWGxzRWVOQ1VC?=
 =?utf-8?B?Qm9kbHlDVEJkQVl0OHlyczZNYnVJbmVQTHRXZjI2K1BJaDgzL3dnRzgwMEZ4?=
 =?utf-8?B?RUJKYzJKZXNZUUFQU1FCTEQvbVZ5UWJFdksza0RKd1MwektTWWF4dXNVWUxQ?=
 =?utf-8?B?d3FZT0F5akRGMm1jN1krMzFEaHE1ZW4wZ2V4a3RQOTNTY3FCcjZoU21scGVX?=
 =?utf-8?B?NXZtZ2tWUktzMnREVkJNRjJ3OVJEQzdqVWxCRWduYjZRbDBRQThvQUVIbHdv?=
 =?utf-8?B?U21CNHEzRjk0RHFVRmJyK1dyQzZxK0VVd0kwZGxBWk0vOTJTNDYvT29MeW5z?=
 =?utf-8?B?R1FtK1FlY1lCVzBnVXpDLzcxanlFYmJsa3Jvc2pwZUNPWXRYTEJ4REdwTlB3?=
 =?utf-8?B?VGMxR1RXTjVHT25YSTc1ajgwZ2JFcEE2RldGZkR2dGJLeURlRjg2MkxvaURU?=
 =?utf-8?B?cWk5aVRzd25MZ1lrcEFwK3g5aXRkWjBmRm9YVnd6RTQ3L2RqRURac2VOWkZr?=
 =?utf-8?B?bW9TSDJ5MDdXbitydndHSmxmU29rUmwvRFgwYmJzUzNUaXAzbk1IRzNRYm00?=
 =?utf-8?B?WU9tQ0ZaTml6VTg5aVpRb2plSVRYeDNkdXpvOUIyN3BKZ3FwdXhWY2ozU0lr?=
 =?utf-8?B?LzFZbEU4WkJzL3VvL1cwbEJDK0RHcUR2VWpGME1hTWt1RE9HM1JSZ2dMNGl6?=
 =?utf-8?B?SU1RZGx6TE5Tb2JIS2ROOUxvQUYvMDQ1cFNyTTBJalk0eWFjRmp5QWJtRE44?=
 =?utf-8?B?eUFGajlyUjRTTDkxQWhVeXU0dk5RMWw4eFFBM01JdHNHN1pnL0JFYjVKcEdv?=
 =?utf-8?B?MXBuRFpoKzVmWkY3VFFFdUx1OWdGTmlKNmd3VjlPL05RdGxuNkI3bm9XSndu?=
 =?utf-8?B?L1MxWWFZNHZ4UXpNSnJTUVNyVXZXTW1ycDBlZFJtZ203SEpGWmhudHNYd0RN?=
 =?utf-8?B?d0QrUjNuYUUrL1FLUE44NDFoY2l5WkN0d2lDd0NrVHRqdUZ6REZRMkEyWmhk?=
 =?utf-8?B?NFhtdFVmYzFycW1yUmtOdnJub2tNYmQrU2NKYmdWS1NJaEtFTThRNUxhZ3N2?=
 =?utf-8?B?MVdhaTJuanJySTJqOGVzYlNLclJNdEhUYiszem96V3EyUHpmQjErOTJxaStv?=
 =?utf-8?B?NnZ4WEpqTFY5cWhJYnliUXprb3hRYThGQmpzbytjd2dhQUFzYTFSNnpHc3FZ?=
 =?utf-8?B?TlQxd3NNRGxlN0hMcTlrN3BWajNjcGFlQVFZME94cWxseFJjL0U4c3N3ZThO?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfe7b7c-5e27-462f-66a6-08dcbd351191
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 14:18:00.5987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmz8epRaYg7hKlW6qf7FQ/2r7a/EPeou6uaASD3FL/nP0X0pdcROzLzfUIuIs4LWEiru39cJrFT3sHYnY7SzhWRL2gkfuUkoGZQRP8MGveU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6543
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_071807_387352_CD46C0DF 
X-CRM114-Status: GOOD (  11.33  )
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

Rm91bmQgdmlhIC1XZXJyb3I6CgogIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBtYWtlZHVtcGZpbGUu
aDo0NywKICAgICAgICAgICAgICAgICAgIGZyb20gbWFrZWR1bXBmaWxlLmM6MTY6CiAgbWFrZWR1
bXBmaWxlLmM6IEluIGZ1bmN0aW9uIOKAmGluaXRpYWzigJk6CiAgbWFrZWR1bXBmaWxlLmM6NDU0
NjoyOTogZXJyb3I6IOKAmCVz4oCZIGRpcmVjdGl2ZSBhcmd1bWVudCBpcyBudWxsIFstV2Vycm9y
PWZvcm1hdC1vdmVyZmxvdz1dCiAgIDQ1NDYgfCAgICAgICAgICAgICAgICAgICAgICAgICBNU0co
ImJlY2F1c2UgJXMgaXMgc2FkdW1wICVzIGZvcm1hdC5cbiIsCiAgICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KICBw
cmludF9pbmZvLmg6NjE6NDE6IG5vdGU6IGluIGRlZmluaXRpb24gb2YgbWFjcm8g4oCYTVNH4oCZ
CiAgICAgNjEgfCAgICAgICAgICAgICAgICAgICAgICAgICBmcHJpbnRmKHN0ZG91dCwgeCk7IFwK
ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCiAgbWFr
ZWR1bXBmaWxlLmM6NDU0Njo1MTogbm90ZTogZm9ybWF0IHN0cmluZyBpcyBkZWZpbmVkIGhlcmUK
ICAgNDU0NiB8ICAgICAgICAgICAgICAgICAgICAgICAgIE1TRygiYmVjYXVzZSAlcyBpcyBzYWR1
bXAgJXMgZm9ybWF0LlxuIiwKICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXn4KICBtYWtlZHVtcGZpbGUuYzo0NTQ2OjI5OiBlcnJvcjog
4oCYJXPigJkgZGlyZWN0aXZlIGFyZ3VtZW50IGlzIG51bGwgWy1XZXJyb3I9Zm9ybWF0LW92ZXJm
bG93PV0KICAgNDU0NiB8ICAgICAgICAgICAgICAgICAgICAgICAgIE1TRygiYmVjYXVzZSAlcyBp
cyBzYWR1bXAgJXMgZm9ybWF0LlxuIiwKICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgogIHByaW50X2luZm8uaDo1
OTo0MTogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyDigJhNU0figJkKICAgICA1OSB8ICAg
ICAgICAgICAgICAgICAgICAgICAgIGZwcmludGYoc3RkZXJyLCB4KTsgXAogICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KICBtYWtlZHVtcGZpbGUuYzo0
NTQ2OjUxOiBub3RlOiBmb3JtYXQgc3RyaW5nIGlzIGRlZmluZWQgaGVyZQogICA0NTQ2IHwgICAg
ICAgICAgICAgICAgICAgICAgICAgTVNHKCJiZWNhdXNlICVzIGlzIHNhZHVtcCAlcyBmb3JtYXQu
XG4iLAogICAgICAgIHwKClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBXaWVobGVyIDxzdGVmYW4ud2ll
aGxlckBub2tpYS5jb20+Ci0tLQogc2FkdW1wX2luZm8uYyB8IDIgKy0KIHNhZHVtcF9pbmZvLmgg
fCAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9zYWR1bXBfaW5mby5jIGIvc2FkdW1wX2luZm8uYwppbmRleCAyYzQ0MDY4
Li4wZGJkZTkwIDEwMDY0NAotLS0gYS9zYWR1bXBfaW5mby5jCisrKyBiL3NhZHVtcF9pbmZvLmMK
QEAgLTIzNTEsNyArMjM1MSw3IEBAIHNhZHVtcF9mb3JtYXRfdHlwZV9uYW1lKHZvaWQpCiAJY2Fz
ZSBTQURVTVBfVU5LTk9XTjoKIAkJcmV0dXJuICJ1bmtub3duIjsKIAl9Ci0JcmV0dXJuIE5VTEw7
CisJcmV0dXJuICIiOwogfQogCiB2b2lkCmRpZmYgLS1naXQgYS9zYWR1bXBfaW5mby5oIGIvc2Fk
dW1wX2luZm8uaAppbmRleCAxMzE2ODdhLi5mNzg3MmI0IDEwMDY0NAotLS0gYS9zYWR1bXBfaW5m
by5oCisrKyBiL3NhZHVtcF9pbmZvLmgKQEAgLTE0Miw3ICsxNDIsNyBAQCBzYWR1bXBfaGVhZF9k
aXNrX25hbWVfbWVtb3J5KHZvaWQpCiAKIHN0YXRpYyBpbmxpbmUgY2hhciAqc2FkdW1wX2Zvcm1h
dF90eXBlX25hbWUodm9pZCkKIHsKLQlyZXR1cm4gTlVMTDsKKwlyZXR1cm4gIiI7CiB9CiAKIHN0
YXRpYyBpbmxpbmUgdm9pZCBmcmVlX3NhZHVtcF9pbmZvKHZvaWQpCi0tIAoyLjQyLjAKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
