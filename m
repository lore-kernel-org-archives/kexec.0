Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964BBCED270
	for <kexec@archiver.kernel.org>; Tue,  8 Oct 2024 07:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OrFlrBh5RWHJ4GmiQ3823eHxBlAOskF/aXO04caAt2o=; b=3+biX2Tp0MYdqi
	j+dD2uWTtUykO7i46OECCMQVXsf2dsuQHgHCouEDttbKkWoDFK/zKFryCWjenQFeIQ0NuPvkaYevy
	0OUdYgUn3UsVcrgWsVPsQwXd7AQtkMihVr9akaqx6p8NlZ+3UsirKkQdhuIpaXztJMaljtvst2u5j
	uKOPDqkmDsva86CTDKp4g81Ipcxv7Eg+Fjg7cMMRfqYNP7l869BhpX/GuipkSDwhAFhaOLNvU/ctk
	Xm3tk+kiKiX1O38sNlR3LmeVtRLVOxvg0QheDch1+6HOEyIrxKJ5xccIhjjJjikBRZyKTmFNpUxPd
	rT+f1aytklUBCDZ7mmCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy4VZ-00000004lkh-1AJi;
	Tue, 08 Oct 2024 07:19:49 +0000
Received: from mail-japanwestazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c406::1] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy4Tx-00000004laA-2uaE
	for kexec@lists.infradead.org;
	Tue, 08 Oct 2024 07:18:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj+Ca6QyS4La8/AqzqrEk+y9Wtn9B3xoT4NPyJDGoY5qt6VOPjSTQ+fZg5lKavupKxY36BYi180QT8Vd0br+N9S/sHNinKKQVsZkYP/9LFV8MF1o+f9KeEB9XlRxb5HIkkpOfkLjCyXoxH+KtaxjxKqc2yMST4gv+uLv2AB3qr49MQeD59rfO7BXpyEtfPx2lYxpwwKnDB+4FxCGc9aKWObVAZ0wkvgEcd5np7l/yWMCTKGGafyFNhNwKwqI/JlzvgXuf2pwyHIxvMx8t0DadETCdcJidSj3lb/KHh0HdC7+7noHSPaSEXM7SNKO4B8VnzmIf6wZPHqhku3+KC86kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1f2jCJ82AFDMUfFUK+3+fJKJP4wM7RX8Lfh1D6RYbeA=;
 b=qXCxYeBg08swikFAWbm/gu0LJKeB6/x/w6ZtE0b0Wwu8viZ+SrcnoHz4opF/mIhnRW0zjr0YxQ2+Ns3CLwFyvOlNnoO2ge+pxskZs1EvAiqABwstgY/4idvIvvC4yOUdUjvxjFaRF/aQejx4K5fTWS6eAbpSyxgMmKGnmBtjImFQQeRSHObqhVR0U6zLAxYfv3JYtohc6P5veTnqI326dj1/5Sgsm0rnf696MQBjSn+Ar/XCeKwAU0Byn1xghPMk2jU+otjwtU1NwwY+DBoqeYi1MCT4etIU98gf1/FHy0hYTB411q/A8zm4Lm8H2kA8Lwj75kNHDJLmsCQBBAhCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f2jCJ82AFDMUfFUK+3+fJKJP4wM7RX8Lfh1D6RYbeA=;
 b=n8qbE2ZegyaTmI0hxHV9ZDgl6PeA4fXoXQEB3gpyjJTubutHiaCjSDQreFOcboVHELQhOmbHbC4XlRBbOWSIGvXbzAg6bUBciHG/pqvLjf7/frysFKAKiEykRKz1SI3G8u/uwGCtnBCYV0JE6R0ZkzJDGQbLZufLkhF25Xe6ugJ1i+Y9OyX0ilBKUpjpxR+GDJ/e1tPzMT9SI5ywYQYTDXqxNJo2ldbD90Ra7JMrm+W9+acEmAG6Oeocjw4OdRG7q69b+hXyxZWGOIgi3cFz83Mk5b4/pVcWUn7BEoZt6EsJX8fDrky88xIyflnPXDEbAro3x7IkvttFqpQRMjfxVw==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by TYWPR01MB9986.jpnprd01.prod.outlook.com (2603:1096:400:1e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Tue, 8 Oct
 2024 07:17:53 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:17:53 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Martin Friedrich <martin.friedrich@hetzner-cloud.de>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: makedumpfile fail to strip pages
Thread-Topic: makedumpfile fail to strip pages
Thread-Index: AQHbCy9/K3pvgGgJg0+b2wXotTtF4rJnwC0AgBS7tACAABH9gA==
Date: Tue, 8 Oct 2024 07:17:53 +0000
Message-ID: <7bc41cbc-32b0-4712-9156-5a77e1994414@nec.com>
References: <164F5E03-EB17-451A-810F-58962BBC53B2@hetzner-cloud.de>
 <6a41c11b-0956-4101-9892-173bd78668b9@nec.com>
 <FC7D62F0-F41F-4773-8EAC-6235E22AD6F9@hetzner-cloud.de>
In-Reply-To: <FC7D62F0-F41F-4773-8EAC-6235E22AD6F9@hetzner-cloud.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|TYWPR01MB9986:EE_
x-ms-office365-filtering-correlation-id: d74ac68e-0de8-4dc0-d8a2-08dce7695342
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bnBiMFhJSWN3ek55eHdWbTAxRTBjcEtJMjcwaTBMNUtZSHB5TXAzcDVzWlNw?=
 =?utf-8?B?MmdFNHVCK0o3MDViN3hGdHZ4MU1Nam0zZkM5MUtlbGhITTFnaGlHbE1KdVBl?=
 =?utf-8?B?T3Uzdy9RdElYZzJOUTVBeDRHZm11dlUybXdaWm1raG10bVZMNmp6bjZGb3Bs?=
 =?utf-8?B?K2h2dWV6L0dMaDFpdTBqRHJXaFVaZzlvaFRjWjViSGJzQkxDVlQxb2JXSGJs?=
 =?utf-8?B?aUlIcEx0SFFPbGgrU3d5NnY4czVVbS8rcHJSNXErdVhJK3NUUVVoUExNejBF?=
 =?utf-8?B?RVVjd0JNTHNJd3gwUlVqMnJhNlRETncxTEZWNDA5Rmg0UWNWYVZrRDdWS0Rt?=
 =?utf-8?B?NGRndXVtMk0xVmpXUUFHcGhpbFhSOXpBU2JyUXpTeGI0M0JuRjFabWVBYUlH?=
 =?utf-8?B?UlVoN09qcDNmNWdXeWMwd2h5b0hCMGo2RlY1aVM5dStoN3ZyclRCWXhRanNG?=
 =?utf-8?B?cG4zMEJYa3FhOW9wQUF3MldxbGNqZElqK1BJVlV4dThTRVVpS3gvOU5yQVQ0?=
 =?utf-8?B?MmV0NjYza25NM3FWZ0k3eHFqV05RUmpaRW9MSDRMVDRORzFtOUViUGdEeGh0?=
 =?utf-8?B?eksxNUVJa2RoVHM0M1RrSjVoQTYwUFdXc2hWbWhJdVBneFNXSXovcjRmYS9u?=
 =?utf-8?B?eXF4T0d3SjNTdENDMHNDQ0p1S3Exd0Zua0x5dkwzcWFydUdhb1UzNDJ5amk5?=
 =?utf-8?B?RkZSNG04NGxRblZoREMwVlJsSy9BcVJDbnV2M2srYmNpMGZ6N0dTNUJjcUpp?=
 =?utf-8?B?K0NtSUY3WnhXWDhaYWZFVGlNRHFnQUxGNW9salhBZFlMTUo2SW4ydnpDbUVY?=
 =?utf-8?B?cDdyanl1Z1VncUxZTmlZMlBhQkJNV2xva1BGSjZoQjRZRE5VNlI1YTdyOGJM?=
 =?utf-8?B?Yy8xZmxJY0cxTkdBaEttS1BpTXg4YWRFNXZFemhEL2xYeTVFU2g2Um1yOUFa?=
 =?utf-8?B?VnE2TkN1QlNxVDhGMEE5dWJUVlpaNzM3K0kvK2hDcUpQQWQralFCd0ZhK1Nv?=
 =?utf-8?B?M0QxWGFRVEVkUlNsbUlnMG16THlKY1hBanpZQmtpRTlnVWdhblZyYmlrQUND?=
 =?utf-8?B?R3c4SnJUWi9PWmhoVlAwWjFJbFBGMGpoYVhnTTNnVEU1cVBoTW16amNqb2dV?=
 =?utf-8?B?RkVaMWRTOFNrN3BxRVA4dnAwRjZYcittZFo5blJBMytqYytvOXJkSjBCYzJD?=
 =?utf-8?B?N0ROZU85SWpycVhoanpjOW92Y3dxc3lLN3NZdFJ2L00yY0g1NklUVHg5QWJs?=
 =?utf-8?B?Y1Q1SFdwcExsS1c4L1ZEeGI4eW5VdVNxZjJDQlpyWXZWcXJEUXJXNkpoa0Qy?=
 =?utf-8?B?Y3FzWEl0am1WZVM2U29SR3M4N2hyMWs2UVU0VnhRcEVUdlJ2bVMrRmJPSGYr?=
 =?utf-8?B?K3dqOXJ0aUc0MTRDMWtRYjRVV0IvUGRFZFBoU0FQdU0zV2lTUFpMWEpndFBR?=
 =?utf-8?B?eEVoR3pYVFlUeGtKd0NyYjM0Y1cxZFdWZTZaSXVaV3R2Y1h6dVJXZ1FWSUVJ?=
 =?utf-8?B?SFovbnhQOVdoQmo2WE5TZGEzbTN4RnNKL3BzMEJEMnN5d0FMUk1hck5LYW94?=
 =?utf-8?B?QW9zNXM2QlU1cWhNdGNJSDU1UTZrb0F6RG15UGpqdGJXajNTQjA2WmZhYkJO?=
 =?utf-8?B?U3hXQmxEcFlocVlNbDJZQnF0K05UelplVEtkSXR1UFkxMUYvK20xNzZtY2Ny?=
 =?utf-8?B?bkhqL1hHbEoyV3ZlMzBhQ1oyZW1aZEsvaUYyMjZic0dYTjJBNStDQzNMYzAr?=
 =?utf-8?B?WXVkSWFSNmtvVGl2emZIdU1aZ2N2MFgwL0piSVhRM1RsTHlhTmY3SWpLTFVo?=
 =?utf-8?B?MVFYM2pKZDQxbkpxamJEZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3pqMVFWY0NGK0pMZ0xKRVcwSWRsV2ZxVlI4NW9QV1ZDbFl2RFNTL0lBdTh3?=
 =?utf-8?B?NFU2QmcrZzdoK3hmdnpFeXZSWHpHSERya2lqZ042RUQ2TjlGRWNYdCtOdWcz?=
 =?utf-8?B?T2ZqS1VlaFlEVUxsNmZXVmdSRlRvR2UzRDNta1BZV1BhV0MxeWthZnZOUlpX?=
 =?utf-8?B?QS9ma0JCV3psVDF1YWl2NkhSTFFlNFBHajErSWxVZ05hWG5YUVVVK1M3RUxi?=
 =?utf-8?B?SUdGdkcxcktrK09KZmFKbGxldHBNSGlyeDZyUm12V0t5cm92Mjd6NjFpRDJY?=
 =?utf-8?B?WWdqRnl5K1BmZGR6SGtIME8vSGxQOFNWSVl4cGFFamVHazk4dDY3VEVvakdO?=
 =?utf-8?B?RWVadzZkVE1RTGdnTGpZZkdCTHN2VWdFQ0JVbkFmQkx0U2JpaHhyTVowSFI0?=
 =?utf-8?B?UU9mSVZlVTY2d2xUL1NJZFFQdlMySTZqdUhGaUlGSTA0bG01dlpydWhjK002?=
 =?utf-8?B?NlJpOUZqTUdpRVpyc1VNbEpOcFNDTmdVajdLOGRUYm9oNnRMSFpwRldIcFlp?=
 =?utf-8?B?U3hEZUx5ZnhUbGI2YXBkcXBrV0R0WlR0SUdqem1lOURPUjhTQWoxZ3RyR1pj?=
 =?utf-8?B?YnVsbVp4WjFHSjBjYlJ4QklkbkswZEdHc0VSSjRxcHJ1L3M1RTVlRHdpbUlC?=
 =?utf-8?B?VkZjUWNONk9BYndtTzFKVjRPcFUyL0lGNFdMc0NxUXJkdko2SytHRDZwNG84?=
 =?utf-8?B?SzY3OEJ1ZzJyV2tYbTZjRTVZWTM5c3VNMkxRM201TU4yMXNQWUE5L1orRkFF?=
 =?utf-8?B?NDdMUVB5QU5CeE1mRXZsMHc0S2NQTVVBcVIrVnVxSXBtWXZUOHNMeHRaTUo2?=
 =?utf-8?B?MkYreDNVcmYwcmFzc0RUa1p3bmpSejZoT0pMS0hEWGdlMUVVYVpXKzNpU0R6?=
 =?utf-8?B?ekZPa0J6T0FhdlgxREhIb04xazZEcGlnWDY3akZMY0U1d3UxTjJTa1I1Ritp?=
 =?utf-8?B?aGh2bVp5T2luMElTaWJvVmJhRFptQTBpVW5wUHFtbmtDdTdOajV1emRGMHBx?=
 =?utf-8?B?MUw5Z2lIN29aUEhsSXpGUnlNVks3RXZyNThNbEg2Z1J5UFFhc051KzZBYTJa?=
 =?utf-8?B?anNGY25nRy83dmFXZXpub0d1eFNaZkQwcjBpR2IwUWFtNlJEcUp5VEdqSDd2?=
 =?utf-8?B?RDc5RW9OTHVDWGF3L1lQWmxud2ZrUzQxbEh4dk4yNFBVR2EvS0srZE03LzdY?=
 =?utf-8?B?c3BUS0hTVTZxU1A0eDBoTkV5dTZqKzBuWm5RY1ltL043STRjMUVRRUp5R2V5?=
 =?utf-8?B?Umgxb0pyTE9nNzk2QXRrZzlDdjlLKzZFWW1YUitHSGo5dm5IRTFBNFVsN2lY?=
 =?utf-8?B?anRxanFVUGxCeXpER1RUbjhlazlFaFcxanhSaW5DTU9hRnFWTXphL1dJQlkv?=
 =?utf-8?B?N2s0Znl0MWdLUGZSTmJSeGNWOThFSy9Xckc5UmNlcUk4OXRVTG9Tc3p6VjZO?=
 =?utf-8?B?bzM5WTl5aG9Cem1ybXJWYktvbmtLSHFYNG1jR2FEUEJJUFdFb0tjMHo3Q2Rj?=
 =?utf-8?B?Vk5IZGJsQStsdDhkRjNtTk5xN0NTQ3ZONUg0dWxNY09mTDhCc1ZVbVMyVXdB?=
 =?utf-8?B?ZG9YN0JISGtObEx0cjh0MTNLd1JISFQ3MzYyaXJRMWJkYVFNNlRDbkFtZSt4?=
 =?utf-8?B?TFBwWGxqOFB0dXVjaWN5RFZVS2w1M3R5SFdpYklScE1FN0NGaVlST00xbVpl?=
 =?utf-8?B?UnlUVnZEcFpBZnNhSHVPa0o0eHFtOTJ1c0VkR0VvZ1FVMCsrOGVtNFRwWUVu?=
 =?utf-8?B?UFNidkRDYUdXNkRKOHhDUlFhVFA2N1J2TEwyQWdGYi9nWG1lVDlwQXRCdHBF?=
 =?utf-8?B?YVV6azl5eEJpY1lwMkJWWVpEeThMVG1UVUNwTDJjNlVkQkhxd1pBaHVkUWhM?=
 =?utf-8?B?MzZPOVFvZTQxaVZwRjRTOFF4bDZET0lkeURsM1k4a0FtcUJ2SS81MHNYR3Q5?=
 =?utf-8?B?UmhJVWVGQmdDZ1ROM0dwUVd0NnVKSmZMVWZKNmVkU2dmSnB6aE5rRlhJdUY5?=
 =?utf-8?B?b3Z1UEZSL1VOQW5sNHdya0hKYWNPby9ZTllpZUFWaTkwR3ViVFg2ek9kd3lq?=
 =?utf-8?B?V0p6c2pDTXFOTWtWbUFuTWkreUVhVS9XQ3F1d3l4YTVQc2QrMTlWVDJ0a3I1?=
 =?utf-8?Q?0aNyfrVsjUJ7HOrr+wI/SskEJ?=
Content-ID: <8F5225DF2EB69847B0169BA1CBC7086D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74ac68e-0de8-4dc0-d8a2-08dce7695342
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 07:17:53.3661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXIJMMvjfpor1Vd1Gr6UZMKbe/YaVipgEMntCNu+ydF7PHdn2lrUYTW9U7sWKNjdDBIF6BEzboAW8PDkDCNSbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9986
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_001809_886634_82126E05 
X-CRM114-Status: UNSURE (   7.17  )
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

On 2024/10/08 15:13, Martin Friedrich wrote:
> Hello,
> 
> we have built a new package using the latest commit (bd30437c6292) and are unable to reproduce the issue.
> All dumps were correctly stripped and completed successfully.

Good, thanks for reporting the result.

Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
