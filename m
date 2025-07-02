Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE79C83038
	for <kexec@archiver.kernel.org>; Wed,  2 Jul 2025 00:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fWP3vPe8HXanVKhcDTAl4U241IjrvocBlIoOKqQTpEU=; b=hivk8n2V0QdpThAZaRl9Z/V+Vc
	SXUPLs+Kwmkj8A/B0CVZdof5fQ6NPL1Bz79ZNdyo1pZ6oqlDVpXDF+hNAi5BlNde1XTKhFw8hcykt
	69M2q1T3tuvoHZnAprRUjzvlgsJ4TrqAanNMjgdN4ADV5KgmQcaqp1ss9EBg3z3Ki85HaZYiaYZGa
	jFDoPa3hmDU6PJ45ydCwQ/Y+IeO+HjIh3xhi1VvXJBd7fXXCvRnu+85VCFiaWwY45BKuajJ7uWygP
	CbyiN7V577F/TsZwaDa0xwjkzqaPKllNtm8DRhRMi4WFM+ecBDHA69nJOlENPgt++6rr4PJCl4i3g
	4t9kQdRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWkwv-00000006sbn-14Hy;
	Wed, 02 Jul 2025 00:03:41 +0000
Received: from mail-japanwestazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c406::1] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWkwr-00000006sbG-49X0
	for kexec@lists.infradead.org;
	Wed, 02 Jul 2025 00:03:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnQb/wGFYC1GzwN3Cn7j/CNhE6sy1vBm1SnKnvkRYsf1lcbqJvdB1w/hO3M+cwt6HQNyDHNY+0wvHT7oW/6BqBYG596QWSDUYZZZ/9l4nU7dsZWRpncmEDXY1dgVp5QJdea8Ikh1qi3TT7Z6Q+4AmApGMeXo2oXwQWsaeeAemYnTd4S62EQEA449s6eN0krsJFNPnVzZNEaMqDAubgFUUOW5fWeG7EpxUXvC9PATnq6eDgeRTetsMbwuMdaMK73p6e2kMhED66Mpx8YSJ60chvLz0KOgDT7gGDU/7sjUEkZRAZpH4UqDETyErQ/YE0fCTB573hXZE5MFRz5QZ7DUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWP3vPe8HXanVKhcDTAl4U241IjrvocBlIoOKqQTpEU=;
 b=McBHkSO+N6SdR+EnuhqyFUAlYJGFccKmUXb90bHT0gpvdvt6F5XH5U147woxZkKduny794ccWtsmQfLyI91D64YoB/3nR4xLlIq/Xqxaq64H8HpDbp1CLjQrkLSmbxWFVpnfPVrJWrESVkxvKreo+/C5P6nSlUpsoLv1vQJphs5WOaa5dh9P/Yt0gO0VfMkcn0176hBP6A2Q+PLvDuf/L+26OGQGhmT+FftYBJylUH07S89N9gsZITjBwb64weegmW+VzetPVP5NUvrwamuveYrGvLV2jEqCG6k7PHbuR+rcsieQyJaMcPPJtiHKKVImHUvZSU/oY23OJurY5uvV3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWP3vPe8HXanVKhcDTAl4U241IjrvocBlIoOKqQTpEU=;
 b=NmnG9s36MDDdQoFiczBOW9jOnJs/sdLFo/YwxOD2XJpskHCx3XDcIlaV7bj8vx/fY762GdugwEKTIWjNFfih9oiG5yqqT2PO5C72EzDs/x+JNI2KxNPF6tUlhXHMxNPB1Qyq92JlPlykCaM0oS4mVzO4Lf3s8vnLhK6PcAKNuM3BQy8be61Iy8eemF7xm2fLqTTdmGQeTE2vuBOK7Os2BM0+IrFy8Ovvec1lxfG1C/S5oGiWmofrUyPObv5AAP2hGI0QvLFlHt0JpKnoA8QAwGF+bAYSvnvxNFVUDpVRCB/u9mJn9ek8NOt8kR3PBXBUv5YVxjL7Lf9LCBKWgEs9+g==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by OSCPR01MB12549.jpnprd01.prod.outlook.com (2603:1096:604:327::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 00:03:30 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 00:03:30 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Zhiquan Li <zhiquan1.li@intel.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
Subject: Re: [PATCH makedumpfile] Add confidential VM unaccepted free pages
 support on Linux 6.16 and later
Thread-Topic: [PATCH makedumpfile] Add confidential VM unaccepted free pages
 support on Linux 6.16 and later
Thread-Index: AQHb2PXaJYe7rlfYqEiy+lQnniY73rQbNkmAgAAovgD///5ggIACugUA
Date: Wed, 2 Jul 2025 00:03:30 +0000
Message-ID: <25f0ebf9-d8a7-4fb6-a716-bcef962443d6@nec.com>
References: <20250609050244.837619-1-zhiquan1.li@intel.com>
 <d650c4eb-5eae-4a0f-94f4-98877e9e68f5@nec.com>
 <a2e8c88a-1fc7-4d40-b081-afacbe95f2d2@intel.com>
 <b90adf53-4cdc-405a-b979-9cf2e30b9ca9@nec.com>
In-Reply-To: <b90adf53-4cdc-405a-b979-9cf2e30b9ca9@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|OSCPR01MB12549:EE_
x-ms-office365-filtering-correlation-id: bdb09ca1-7f39-4253-47a6-08ddb8fbe0ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UXdRL2tUSXd5UmF4SFNheVB1WWxyN0VtZitjeEtCcUF5TW04ZVp3L3lWMUxK?=
 =?utf-8?B?SkFWOEZEYm0yV0xadHFPYzhVdjU5WTdiVkZiNUU1MTdSaGVmWXZQdWNVVkxE?=
 =?utf-8?B?SDA2YVhZSWlGalp4aTJiQ1FQRUgvZEdpbzJCOVVidERrVERZYnZUTnU4d2dG?=
 =?utf-8?B?Z0FMZDdybkcxY0dpNHFXUmE4ZUZXbktPSWRSUnZNeGcvOGpQc25KQmhDdmtC?=
 =?utf-8?B?MGVYQ0Vvb0VtUGMxTVp1VGtIeDFncDBBOWJXSGo2OWZ6NUpiZFh5UzdJNWVB?=
 =?utf-8?B?V1I5TjJlWndZWkFCUzhDSC9oRnRvRGdrZXIzVVlrckhHTjNqenNiNjJJQjNq?=
 =?utf-8?B?K0ZCMDBReU9EV01MSlBSS3REQ1o2VkN5L2NCQ1grRW5BSVZSd0FMZnRRVGth?=
 =?utf-8?B?Kyt1UTZCdzVPZzE2emQ1Vnd4b3VFdXovRnRRTVl4QWhIZkNidHhlREFoa3VW?=
 =?utf-8?B?czFnMStON1FUdjZqT3NObG5RMGpjTnhYb3FQaFpxaE1CcVhBekFFTCtzbExq?=
 =?utf-8?B?N0tLbE1jY0J6LzRUckV4L1lpdFJNK2FrVVZnQnVIekhqWERSOFVoUXJLbWlS?=
 =?utf-8?B?ZHl3L2dQUmJIcWJvcUxKNzI4eVlXRytrVkwyamRwakhUMnJkNkJkMUlSbk5R?=
 =?utf-8?B?b3pSRjFTU0pMSFZLaUhnazJxMlhoMW4rMEdmcnFYKzhGa0lBY1FXOGMvSVZW?=
 =?utf-8?B?UisrYmNlUVE5ZE5vSHkwdUhWY1pkUVFoSjdTaUk3WkxaK1QzeStqRXh4aXpF?=
 =?utf-8?B?bXdIRXczSmdoZ1pFTi9GRnNDQUtxYVp1NElQV0J0VVl0MmNaV2lUdkFLSm1B?=
 =?utf-8?B?MW11UnhWR1hYOHJmbzNVRGl5MGpPOU5KcmxCUGVPWUNtNkRlRXBZZkhoRTNo?=
 =?utf-8?B?bmFKcndPSjZPdHJaeWwzZzcyVE1DZE9kNkZ0aThyNHVpaER4ejZRVm1VemVw?=
 =?utf-8?B?RmNsMmZZRXc3TDVJbnZPNHVTNU5PWnZKS0h5Z2l4MFNTNysrWE5ZNWViblNS?=
 =?utf-8?B?SEl0Sy9BSStxcm92aFRnbWpMN2ZYUDdmVTdQVkNtbU55UHNDeTliNFdZRDZZ?=
 =?utf-8?B?U1kreWlCVEQwVG9MZkl5emFTSzhYSEdDYkhsWCtHK2dWejI3SldDNWNwZUcw?=
 =?utf-8?B?MG5iQ0lLdTg5RlNmVTlyS0pzK0FhOTFERmdOaHdVeGxWaXFuSmJpUEUyRGFj?=
 =?utf-8?B?d1kvemIzMjJJaUVqQnJQbTJ2V3Q3RFRXTHFwMEEyeC9KZkdpMkg0elBNdWI5?=
 =?utf-8?B?M3Z4aGFDU3JWalBHTmRCMVA5Z1hTTnRrSG5rZ3hVVmhYR3lqN3cyVHNMUHNy?=
 =?utf-8?B?MnFid0piSjBZQkxXaGU5SlFPL00wZmI2SGlUdEcvT25Dd05Iejk2QlF1NnNv?=
 =?utf-8?B?ZU9HUDNESHhHcEo0VE9zYnRrT29OcnZqSG4xbHRDNzNTQVJRQnM5WHRPd0ZG?=
 =?utf-8?B?T1FNMXZQSEZSbVVWVGZyU3lTN1QzUG1KWmsySDBMQVNQZU41SVNRdWJJV2M0?=
 =?utf-8?B?VlB3QS9SUWVGQVNKb2F0WHpBN0pzbTNKZWlZVTB3NmwvVzNDZEVZMC9WeTJX?=
 =?utf-8?B?bjQwcVg4Q0V5dkxEK1V6YXVmY0pRb1UzMnk0d1o4dE1laDMwQVBITklkaEpT?=
 =?utf-8?B?VUdDMzI2UUlZdkdoMzA2emdLYmhQSjI0T2lXLzFSTVdXSGRIdUJhaThsWk9p?=
 =?utf-8?B?TXc2d3B6cUFhT3ZPaERmNkJHeWdoR29rcjNaSlNJdENheGpjOFNSemdBYTR3?=
 =?utf-8?B?ZGxMT05zLzFmNU9adlZSaC8yaS9lK1BFeDRQY2VOdjVSck14VlVWcUFsV1Bp?=
 =?utf-8?B?QjF6UlVxTEdBSW5iM2RheFliaGJ6ZnQ4aEI2VWNBand4ZGhHSFZtMzN6N01v?=
 =?utf-8?B?ZXo0NkpLOVdZTkoxaHNxRDBhSVplZ1RNWjhuUGZ5LzQvWm9keWJhYVRrVGlR?=
 =?utf-8?B?WHFJbG5VMVJsbjlzT1AwaDlvWEh6SWdodlg2N3hZd2ZJUTNUOGtGMWxuazdi?=
 =?utf-8?Q?/gbOmS203/kyXPqd+CwXOPaA5YuAKs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wm5BMmFWTzFZeXpyNXNiQWswOTVlNUVsSTZSRitYRXQ5WmNnTlU0MjBLeVJj?=
 =?utf-8?B?NlRrbVorUzZIRk9VY2Y3aXNTakhwNnNha1FpTmNiQ0tnaUtubURCcnVwRHJx?=
 =?utf-8?B?R3ZQZU9JdkxueUVZUnMvZENqeHhXTHZkVEJqZ2lXaktNeXhKMUxONmRFbjR5?=
 =?utf-8?B?TlE1TWc4K1Zkei9UbWI2T3YvUjdXS0RRY2JPWERobHVNczlvZ0FOYWJ5cFRw?=
 =?utf-8?B?VElCNWFUTWtWclRLaXpQVm5wNm1kblU5Z01lQXJVZktiQ2pkTHhOb1VFbGFl?=
 =?utf-8?B?TUlqTHpFZzY3T0svMVFKQmJzZVdNOURma0dSR1FSSlZrUjZpejhTRk1peHpT?=
 =?utf-8?B?Sk5TY2dNb0w5c01DSmZmdkhweVNIc2ZoSFRuOVJsSzRneEEyWVVXQVJJZktE?=
 =?utf-8?B?elZYdjJYWFovYnVjYU42all1MVhhMlBON3ExSUZlVEVxWjhlQ0w2NjhGUS9k?=
 =?utf-8?B?bzlJSVZxQnNJVktzTnRGVGJpNUdHelM5OGV4Z3hLSUdxYzExbmRITk5ET2ZT?=
 =?utf-8?B?V1V6elZadExzQUVVcjRUUktoYmxDREp0MmRZZVJPSDB3TzdXaTd2Yi9mSElD?=
 =?utf-8?B?aDNiM2NDdWhxYVpEanlGNkl6ODlLNGlxMWhCcW9OV3dqQzc5L2pzSy9CMUpv?=
 =?utf-8?B?VGF3cm43d25uV0JSZ0lVM0lBdzcwUmI4SkZCSGxmVXlvSllEb0lXMFpoQm52?=
 =?utf-8?B?R1NOT1ZXVnBxdm8yenVQZURFQjA4YnVEWjlRUWFJMjd1NFdmZXcrbmdkYVNS?=
 =?utf-8?B?eDNQbHBnMHVzdTIxMFBjbmlRK2Yxa1pIRHphejZLM3JuZG14ZGhTTFhPR1Rh?=
 =?utf-8?B?RE1USEh2L1ZQNFpteVdBY3p3OTVuVnhCVmx5VzhzMXdYN2dnUldtbTJkL2NB?=
 =?utf-8?B?c2RlMlN3SHEvU0w3K1hIN0laNEs2bFY4bmtLQ3l4RlV5WGZHeUtmN09yVDFh?=
 =?utf-8?B?bzVIUzJSZUg5R3RDWkdxdU83QXJZeFFhdHphaEtld3RFYkx6TWJUTnlwOTFj?=
 =?utf-8?B?VG1BaFpoeEdFMDM4STkzS0tHblR2eWYzNm5ib01jS2sra1plVlNVRFlWVjNh?=
 =?utf-8?B?WE9lbGEwKyt0T3hJMDRZVlhoOTZVbE5uMjFua0daMzdHNGFZNUNHcjQzOFFV?=
 =?utf-8?B?Z0h0b2NqZHBRbUxEOGl0eFFsRjJPQWpvcDdyN2hpblZmSVNxYjhsNEpHdVEr?=
 =?utf-8?B?K3UxUko2dXhiUXNpVVVYYmJWOXpxU2pTbnV5bHhnMS9pbHhDNGJ5ZHlOaFlp?=
 =?utf-8?B?YUVhYThrL0ZjMis4bnlDaGxtS3hXUkxxZTAzbThDYWVPNm1sdWZhZGorcEpk?=
 =?utf-8?B?dzhCRGh5SUZPRXhLUkp3NzJKa2M1aE1yN3VCL0ZJclptYnNOUGNiU21SNDhO?=
 =?utf-8?B?VDVidlBNUWxKeUJBRWxVL25KNk1ZNCtXWDlVT2lKLzRIOHc1eDcwUHZRbS9R?=
 =?utf-8?B?b0k2ZG5nVlRLZHdkNkIzclpzRUk4SmI2bkhYV3FUTkNEcVl1cVNiVTdxZ0ps?=
 =?utf-8?B?WXhvWmZIZWM3TjBSNC9BRXN3U1p4bzgvcThnYmN2cVRLSjQ4NHNaYUdoRXhO?=
 =?utf-8?B?WWZwS0piR1RBT1FBcXJIYmdyYXIzQ0srR1p5TXNoWmNWcVFLMnlGUGFzNGdJ?=
 =?utf-8?B?TFFFWVp4WFIxK3krdklVcXQxS0kveHFOcTk4TXUxOTBOczNyQVdxUy8wVkFt?=
 =?utf-8?B?M1RJZHNrTjYzdFdQVDlJK3dNSDB0WTZyeVo0RVdWRWtNck51ZHVOa1hMUHF5?=
 =?utf-8?B?TmNzM2JSd3B4aFo4bUVsYVhaOHpwekNKMTA4eEVCT1RVTUtLd0t3WjI4d2I1?=
 =?utf-8?B?cXpJYkpHSWV0WFg3MDFEMU4wdU5mRkp6RzZKeHVHc0NuWU5wczd1RzIzL3Fn?=
 =?utf-8?B?STVodzFTdURveTBWNDU0aWRiVzBXQjI3VEpXOUd4amNNWDEwbm8wUUZTQmFz?=
 =?utf-8?B?cUFXVUxJK0FOU0hJbnhpZkdKZnRIT01DVlRzSXZFVU5DVERQVXNIZUhBbWV2?=
 =?utf-8?B?MnVidzBxbVhlajRGOVljRzdjdFlyUmp1dmkzaWZkeVRnVk1QT3owTmd1dVN4?=
 =?utf-8?B?bjZDN1Z5VkxDK3ZnQVZ5a09hQ0FNUDdDdFFKRWR3a1NDbWwxR29CYWZPcDdM?=
 =?utf-8?Q?c19Ik+pu/hQj5HXY43M63mbU6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D27285ADDA195F4BAA9D0DA6CAFFD3AD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb09ca1-7f39-4253-47a6-08ddb8fbe0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 00:03:30.2506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UE4dUDHxVGUz16SF/0TFx2f/f4N8fsEm9ib9Ojar9kfrbq4NcyBkE1dr8apZ7QFilDPahqVYH0mY9823755G6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12549
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_170338_146576_870A9ED6 
X-CRM114-Status: GOOD (  20.37  )
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

T24gMjAyNS8wNi8zMCAxNToyNCwgSEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSkgd3JvdGU6
DQo+IE9uIDIwMjUvMDYvMzAgMTU6MzAsIFpoaXF1YW4gTGkgd3JvdGU6DQo+Pg0KPj4gT24gMjAy
NS82LzMwIDEyOjA1LCBIQUdJTyBLQVpVSElUTyjokKnlsL4g5LiA5LuBKSB3cm90ZToNCj4+PiBI
aSwNCj4+Pg0KPj4+IHRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLCBhbmQgc29ycnkgZm9yIHRoZSBs
b25nIGRlbGF5Li4NCj4+Pg0KPj4NCj4+IFRoYW5rcyBmb3IgeW91ciB0aW1lIHRvIHJldmlldyB0
aGlzIHBhdGNoLiAgVGhlcmUgaXMgYSBsb3Qgb2YgYmFja2dyb3VuZA0KPj4ga25vd2xlZGdlIGJl
aGluZCB0aGlzIGZlYXR1cmUsIGl0IHJlYWxseSBuZWVkcyBhIGxvbmcgdGltZSB0byBkaWdlc3Qg
dGhlbS4NCj4+DQo+Pj4+IEBAIC02NjMwLDYgKzY2MzMsMTcgQEAgY2hlY2tfb3JkZXI6DQo+Pj4+
ICAgICAJCQlucl9wYWdlcyA9IDEgPDwgcHJpdmF0ZTsNCj4+Pj4gICAgIAkJCXBmbl9jb3VudGVy
ID0gJnBmbl9mcmVlOw0KPj4+PiAgICAgCQl9DQo+Pj4+ICsJCS8qDQo+Pj4+ICsJCSAqIEV4Y2x1
ZGUgdGhlIHVuYWNjZXB0ZWQgZnJlZSBwYWdlcyBub3QgbWFuYWdlZCBieSBidWRkeS4NCj4+Pj4g
KwkJICogQnkgY29udmVudGlvbiwgcGFnZXMgY2FuIGJlIGFkZGVkIHRvIHRoZSB6b25lLnVuYWNj
ZXB0ZWRfcGFnZXMgbGlzdA0KPj4+PiArCQkgKiBvbmx5IHdoZW4gdGhlIG9yZGVyIGlzIE1BWF9P
UkRFUl9OUl9QQUdFUy4gIE90aGVyd2lzZSwgdGhlIHBhZ2UgaXMNCj4+Pj4gKwkJICogYWNjZXB0
ZWQgaW1tZWRpYXRlbHkgd2l0aG91dCBiZWluZyBvbiB0aGUgbGlzdC4NCj4+Pj4gKwkJICovDQo+
Pj4+ICsJCWVsc2UgaWYgKChpbmZvLT5kdW1wX2xldmVsICYgRExfRVhDTFVERV9GUkVFKQ0KPj4+
PiArCQkJJiYgaXNVbmFjY2VwdGVkKF9tYXBjb3VudCkpIHsNCj4+Pg0KPj4+PiArCQkJbnJfcGFn
ZXMgPSAxIDw8IChBUlJBWV9MRU5HVEgoem9uZS5mcmVlX2FyZWEpIC0gMSk7DQo+Pj4NCj4+PiBq
dXN0IHRvIGNsYXJpZnksIGRvZXMgdGhpcyBtZWFuIHRoYXQgdGhlIG9yZGVyIG9mIHVuYWNjZXB0
ZWQgcGFnZXMgaXMNCj4+PiBNQVhfUEFHRV9PUkRFUiBidXQgaXQncyBub3Qgc2V0IGluIHN0cnVj
dCBwYWdlLCBzbyB3ZSBuZWVkIHRvIHNldCB0aGUNCj4+PiBvcmRlciBoZXJlPw0KPj4+DQo+Pg0K
Pj4gWWVzLCB0aGUgdW5pdCBvZiBvcGVyYXRpb25zIG9uIHRoZSBidWRkeSBzeXN0ZW0gZm9yIHVu
YWNjZXB0ZWQgcGFnZXMgaXMNCj4+IE1BWF9QQUdFX09SREVSLCBhbmQgdGhlIHR5cGUgUEdUWV91
bmFjY2VwdGVkIGlzIG9ubHkgYXBwbGllZCBvbiB0aGUNCj4+IGZpcnN0IG9mIHN0cnVjdCBwYWdl
LCBub3QgZWFjaCBzdHJ1Y3QgcGFnZSBvZiBNQVhfUEFHRV9PUkRFUiB1bmFjY2VwdGVkDQo+PiBw
YWdlcyBuZWVkIHRoZSB0eXBlLiAgVGhlcmVmb3JlLCBpZiB3ZSBzZWUgb25lIHN0cnVjdCBwYWdl
IHdpdGggdGhlDQo+PiBQR1RZX3VuYWNjZXB0ZWQgdHlwZSwgdGhhdCBtZWFucyB0aGUgbmV4dCBN
QVhfUEFHRV9PUkRFUi0xIHVuYWNjZXB0ZWQNCj4+IHBhZ2VzIGFyZSBhZGRlZCB0byB6b25lLnVu
YWNjZXB0ZWRfcGFnZXMgbGlzdC4NCj4gDQo+IFRoYW5rIHlvdSBaaGlxdWFuIGZvciB0aGUgZGV0
YWlsZWQgZXhwbGFuYXRpb24sIHdoaWNoIG1hZGUgbWUgdW5kZXJzdGFuZA0KPiBtb3JlIGNsZWFy
bHkuICBBbmQgdGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUsIHNvIGFjay4NCj4gDQo+IChUaGVy
ZSBpcyBubyBuZWVkIHRvIGFkZCBteSBhY2tlZC1ieSB0YWcgdG8gdGhlIHBhdGNoLCB3ZSB3aWxs
IG1lcmdlDQo+IHRoaXMgd2hlbiBNYXNhIHNlbmRzIGhpcyBhY2suKQ0KDQpUaGUgcGF0Y2ggZ290
IDIgYWNrcywgYXBwbGllZC4NCmh0dHBzOi8vZ2l0aHViLmNvbS9tYWtlZHVtcGZpbGUvbWFrZWR1
bXBmaWxlL2NvbW1pdC9jMWE5MzAxODU0ODJhNzJiMjkwMDk5YTRmODE0YzVmMzJiNmU0Y2M4DQoN
ClRoYW5rcyENCkthenU=

