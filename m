Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28A9CF5386
	for <kexec@archiver.kernel.org>; Wed, 23 Oct 2024 13:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:
	References:Cc:To:Subject:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=m/75ffoH05isNjgdMaZDjx5JXpJaOUecEB+kpbaAFxI=; b=3bfEHni4wZpoToypctiorMl/Oo
	puqNaid67c468FqaE8Zl9OCyNXssgi6DMQzC+XdqBagCGQrrzfE8Onkd2E4Qhs3Qz8vvKbWXRXJpV
	6DNAExrXA5ssIjhuaATlxhJMWWq52d0eqo+Pvb94qB3aFu+uWKhSoGLKEuJy+bdBivhI2uana2L/P
	3mx3veOWB5/klDJsIHW+8hFKnNqM12DT7T2x/jclKaMmY4ah8pa3wAevnZx8WRPwEP2KCizIYIsIO
	Wetwhea5WZIbd7Put6MCV+xk4d92qOn48Q7/E6AuneZ5F8F5/erOqF7IJ9t4bbbXR1scKNzJRkICx
	ygOtdSLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3bR1-0000000EXzC-1l6Y;
	Wed, 23 Oct 2024 13:29:59 +0000
Received: from mail-dm6nam11on2060f.outbound.protection.outlook.com ([2a01:111:f403:2415::60f] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3bQw-0000000EXvQ-2r0l
	for kexec@lists.infradead.org;
	Wed, 23 Oct 2024 13:29:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDP5JxY+oZgR9hr/LvwDRNwUzKFOR8o3WIckcsBdzC0qyNpiM4mrmrAPnmaJ24EX/UUKMSuAjrdPzq4dFL2AuANPNaq2vys1Mukvz27kW1Q1tD0EwIxu1jmyTorHDFa62GvF5IW0sMt41BnVkJg5Ev8+RhgyJlz3MaZ0ZO5NdEqCqQb5KSVTI3xnvGO4Y3o3FrxFOyXPSCCXQF2tjSKfkJRO8103nKqq83gdkFC1uzs9mKms2Su8O8bVzZILhSul9ubXsgb5ZIe0huKGzqd4YiYyqeZVaJIImrulGDIUK+ESnmaCj20ZRctwVYiFfs/sdP10FsUdECq3/cWUVjcvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yw5k1E2GoDacqFHBSs628/qH2xEonSh5D3aIJH1E2Q8=;
 b=EvkxsMZconuFvTY/DRgrG2dqJDELwmgzBSo1uaqA5wa2gPjIZ1FSdytzZQVyV1sefePezl4wuFe7v+Rny93GcgG2gFCOB4h8QQ7JfeR8KnbGRP0OcljfL21XK9drVXN8EfPZISDYwk5fb03clldjcnS5SmnsNBG1qKVA7n8Y740RmYHe/fRY9QVYZD0dyff3NfwRPSfr6hIPiilCCXP0EWbAm36LI6gvXMyu46vWgN63wG4WxHBA1T7rEgMC/ie2/sZf56D9Aifw5fJQlHvu4hvQnDMzdqQbLTeQs15l7+9rg4jan9yOWk2AQEYfFrvrZZCE4uvQN/axBRBOmdpMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yw5k1E2GoDacqFHBSs628/qH2xEonSh5D3aIJH1E2Q8=;
 b=NoSI79B86eCD1pV9S0IHCfM8cSZ/e+SNCX9w5gzUSIx4snXVmcW/8qMP20vusLwtCpI0nzxJx/guUVxkoWxdwG0F6qbqagaJy9wMi4quc1LmOlX91qIlqDto/J1Bx4cVt7Nu730mUWwJPE4esn1dqV/Z0baPoY1GfcYb5ZSHWCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 13:29:49 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%7]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 13:29:48 +0000
Message-ID: <229dd4f4-b556-41ef-bea9-9fafe07180c5@amd.com>
Date: Wed, 23 Oct 2024 08:29:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, Steve Wahl <steve.wahl@hpe.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Pavin Joseph <me@pavinjoseph.com>,
 Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org,
 Eric Hagberg <ehagberg@gmail.com>, dave.hansen@linux.intel.com,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
 <ZensTNC72DJeaYMo@swahl-home.5wahls.com>
 <CAJbxNHfPHpbzRwfuFw6j7SxR1OsgBH2VJFPnchBHTtRueJna4A@mail.gmail.com>
 <ZfBxIykq3LwPq34M@swahl-home.5wahls.com>
 <42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
 <ZfDQ3j6lOf9xgC04@swahl-home.5wahls.com>
 <87cyryxr6w.fsf@email.froward.int.ebiederm.org>
 <ZfHRsL4XYrBQctdu@swahl-home.5wahls.com>
 <CALu+AoSZhUm_JuHf-KuhoQp-S31XFE=GfKUe6jR8MuPy4oQiFw@mail.gmail.com>
 <af634055643bd814e2204f61132610778d5ef5e5.camel@infradead.org>
 <Zxgh-hBK2FfhHJ9R@swahl-home.5wahls.com>
 <e373dcbdd15d717898cfe8ebde74191b5f3acc4c.camel@infradead.org>
 <1f6feded-066d-4207-9645-f2bbed5ebfee@amd.com>
 <e4cc1e0cfca0d954ca22d850ac771c4bf7406902.camel@infradead.org>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <e4cc1e0cfca0d954ca22d850ac771c4bf7406902.camel@infradead.org>
X-ClientProxiedBy: PN0PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::20) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c1767e-8b4f-4897-a413-08dcf366c442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnpvZUxFamF2cGVJMkNPTURqbENrcmJ3WXNOTVF4dDZQNDdOMCt3R3pmUyt6?=
 =?utf-8?B?aXdCUDV2dDVhQi9KYVYzVW5PWFFzQUFlT2NwWUx5VDY3QmM2ZXdDR01MOVJk?=
 =?utf-8?B?dUk4S29qT1NGWmhNTERsQzRLUzZQM0ZLaVBBTXBNRldFdVpkaUZsVDhZSG1W?=
 =?utf-8?B?U3lXTU9iWnN6OHpnZDFjcUZOVlUxZTJvNzZ2ZFhDOXdIcjlNS1hOWkRadkMv?=
 =?utf-8?B?TjRLQ1lIcHNGU0U4WE55elFHcEtoY1dkMHZudldYZWFlMTdYQ1hUeHMrZU5n?=
 =?utf-8?B?RmhCUEtKWFM4dXpZelFOdDBIU2k2Uy9aOXAzQXg5cXRiZFhya0ZxRmUzMGhT?=
 =?utf-8?B?UG9jTW5OUXVwZHlYbWNWOXFxWnBIVVVJczY1MHFxVlVDUFF4OWx1WFBmaEw1?=
 =?utf-8?B?ZXM0elJqL2FYM0tmR2FCUThKVDBSTjMzbnAwL2dNM3RISGs0bEtabzRLWE1Q?=
 =?utf-8?B?S0pBblloeUZEcElSTkU0SEtRcks2aVhING5aQUtucHk2OVJQTTR5K3dsTTYv?=
 =?utf-8?B?dEdjL2dOZ1ZLK3lTQnBKUU5XUWtYcm11R2pHbjI0cGluM2YyN0hXb3ZBTHAw?=
 =?utf-8?B?VVBlOFBIc3F2dWFkalZjWVU5V0ZKakpuNkVEb01sbVZsVVhNaDE3eEt1Y1hJ?=
 =?utf-8?B?clJaZFFmcUlIeEViU2kzOXR1S2phOGhBbDY5YlM0WkFQTWxqcUJ1UzlyTERF?=
 =?utf-8?B?ZXVmZzFOYkFIc0EyK1pCOHkxSHgzMG55VkZkYVdKMTNQYWQ2dEEzQjRlUFNm?=
 =?utf-8?B?WmV0RlQrS3FJQUZVOXlQWkNsbFI0Y2pzN25IRE4wQjJTQ25SWVM5MTlyQUpK?=
 =?utf-8?B?ekNJVWxodFZlUGZnbkNCRHRGVDBXUFNpeDNjYTdkVEdabi9HVlpGb3dPcDYy?=
 =?utf-8?B?TytzbTYvQ3l4SjRBT1FrUklSNURVcEgrNlZ3WktRTEVjeVRSSkdnT3ZTTjUw?=
 =?utf-8?B?dDVoY0FSbWVJSjljMVIrK055TEhnQUhwb2VxY2grbmN6a280cXBZUEd1WG1B?=
 =?utf-8?B?bHlxV1k2Y0pGYmZiTEVudkpCMzRtczBEcXZqbUZPazc5UndpNC9rTTJkMlVY?=
 =?utf-8?B?OXc1MThXaXNETXUra2tUMUpmU3c3TlpKd2UxT25kNGpRbE4wMzBrREtVb29T?=
 =?utf-8?B?djU1bTE5R0p2ajVzZi9JTE52WnpLbXRXODhhODFWSUhNenNDUnVQSjI4dy9a?=
 =?utf-8?B?RXNmVDZCbkJTY2xUQ05YTHY1ZldWRGI5a1hibGo2dENUdWxtSHF6MDRwRldi?=
 =?utf-8?B?Q0p4V09MWGFwSXVxTS9ySWxCeUdNK0c2UmR0WnlaUU5pU05ndnVyVEVuZVNS?=
 =?utf-8?B?NXpMaXB5Z3htMnErcFNWM0k4SGJLODBiQU11eEEwTk9udENOWTFuYURrZVlY?=
 =?utf-8?B?bmYzZkxKYWw2ekpqSzkxbmdZVThlUXVmdGJicjl5ZWp1MUpzNjZKcG9OOWVZ?=
 =?utf-8?B?T29sMG9Xb3ROSkJ5UGhYTkRabUpacGlTd21CS21tWDJlSFNvTThBZlYzaXg2?=
 =?utf-8?B?T0NtOCtqZkc4bEZrR0ZmTkNNN0pManBlVHZlMStmNHlvdHJaS1V4bDZMdEI5?=
 =?utf-8?B?QzRKcnJ5R0s5enJNbHRteFU1RHpMRkpmQjByVzMwR2ptUW93anZJbEY3aTls?=
 =?utf-8?B?eCtDa3h0Q2pvQ1BVNEdPWENiU1YzTnlqdlZMSXVVQnR5bFJZT2s2U0xNVTcv?=
 =?utf-8?B?dzlmamRJRmJtaVpTZmpsb2VqNEEyYTVyb1RLK0RpV095TUYxenNyb0trdWk2?=
 =?utf-8?Q?bj5aKk6tEJ0Lzxyu1DMNdK4dKIQD5yAOaGZmI5e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUw2RTBMZ1E1eThaNXY5MU5idFJuUThCUnNpc3VqV1c5VHZvMWg5bGJnbEZu?=
 =?utf-8?B?K2YydFR5Q05EdFBrTlpoeGovYmhobU1WaUg4T3RldnNPSUVwVVdueWhLV2g3?=
 =?utf-8?B?Q3kycUNPUEwvVVVCVHZURlVud2o2OXVpT2RqRFVzTHBDaTB4Vy84SjJrYkhQ?=
 =?utf-8?B?MFFQdnRyVTZVZzlSUGE1NW9aUEVOUEVUUDJDOTJlclZ5MGlYUTlHejJFbGhN?=
 =?utf-8?B?aGpNMDVHN2orZVpYcm1HdG9oYzY1WFYyZHFzRlZuSnpudnFPdENiRGtqbFM1?=
 =?utf-8?B?TDFoakNZQUNGaTF5SVRnUHBXYTVyQzJGRUFEN1ZQUmhuYXFtNnUzNExPQjVv?=
 =?utf-8?B?YnVxM2srRG1Ob2ZmUEl1UW1DVlVGSlhVaUJTR2g3VGNuTGRuQ0tDWE5tc0la?=
 =?utf-8?B?WS9SemNIN1EwREpDcGRFYWJ0ajVGY0FuRysvSlJvdUxqRmtVYXo5WGs0S2VJ?=
 =?utf-8?B?U0IrVlBMQ1NDNHFScDB1blNsNEFpSkhCUStQSmNzQ0RVMEREb016RnVtS1lY?=
 =?utf-8?B?UXhBRVFUUTh4bjRRUzV0SzZ4U3JFRllmdlRpck1ORGlBRW5RWUxKdDZ4VldZ?=
 =?utf-8?B?dm9NU2lLb1VnWklBWFZwNXBXTytaeXMzd2ZTV1I0T29yRk41UmFFRnZ2Rnl1?=
 =?utf-8?B?N09ud2U2L053MzVEK1NsTzFhTDJ5MzlUcnJrNlhVUUVRczNOMmd3T1IxTzFo?=
 =?utf-8?B?SDJveVpHTzRTbk15a2p6NUR0UEIwam1tYnZSTjl6UTB1VU1pL2RzSUNuV3F1?=
 =?utf-8?B?ZDNwdjZLYzRvMnpNRjkvWjYvR1hscDRxUWM3ZGNacnRLS3JaYnBlQWltZm8y?=
 =?utf-8?B?SmlybzN3ZnRRRVZ4S3ptalJydkxnTlhtOEMvK0pPb3k1QmZqdkJ3b2FWRnFK?=
 =?utf-8?B?Vm5EVGx3N1lGb2dFdUZMdHIvNTlDaWVJZ1pqejZFZW9JcUZrVC9YcDVXeDNh?=
 =?utf-8?B?a3U5RWRISW1QSURjcEUrMEtCallBRk5hK3Zrejd1T1NQQ2lwbHVWWlM5SEMw?=
 =?utf-8?B?L0ZkOHlLeFZsMVVHY3RzY2FVbE5MaFhndXlpUW9BRlpROXNpcDZiZjgwYkMv?=
 =?utf-8?B?a0dsOFF4aGVjSEJlSkZnd09QL0gyOGR0UUszZzd4YTc4L25GdENqVzZ4dXJK?=
 =?utf-8?B?M2FrdDVweWJkRGVsU2ZWRVRmRmhQYmxXdXNiMVM1WkpEWk5aQjdKNzVhWk9M?=
 =?utf-8?B?V003emNiWGxmRFkybGwra01TYXpGUFc4aXR0SVNrdzU1V083aStuUWJvM3Rp?=
 =?utf-8?B?cDE4c3k3bCtoV2pSbENmVGMwdzRjT21ubUlQdWVGK3ZsQ2lrdnVRZVNKQW5T?=
 =?utf-8?B?RDdhRDZKenhrbEdoeHF2U09sRkJZTWFKZXZ3ZXcxL1V5a3VqTGE2alVqSjRz?=
 =?utf-8?B?VGdRVVdFMEhaQlltVHN6ZXRFcUozSXg3eEVlNW5CcS9ENU5Cczg2aDc1SkJI?=
 =?utf-8?B?cmtKZi9COG9qWkpKQWdLQkxqVDdLWmd5Z2hJeW9WaC9WSnd1NWxhQXd0cHUy?=
 =?utf-8?B?aUVWRkNRWEVxMUU2emV1VjlMT2dBQklOSHRQeng5NmRoUk01emFZNVFNYkIr?=
 =?utf-8?B?NWFUSmtYM0tUdnJBaW5OcUg4ajBxNkcxMXFtd0JnbTlnOVgxL1hnbHpaZ0VG?=
 =?utf-8?B?VGhZVEc3dVFFaDZLTUxlcDV5U2lrNklTdUk3MEg3UGdIanlneFNlT3g1d0RQ?=
 =?utf-8?B?cmk3TUYyclpKREZGc3llTG0zK2ZyYnBFajEvTWdYTTdoUXFrcHp2WnFQenNF?=
 =?utf-8?B?UnFzdFRtNUdpQUhZQVNJNVpxOTcwbnY2bzFaanNnM1VOWUNCdmVwdkt3UmZ5?=
 =?utf-8?B?eHhlSEJnN0lTc3dkUjlBV2JjbFhQa094UmJlSUZvS3hSdkhBL2JIbW1ZZGdk?=
 =?utf-8?B?d2Z0Qk1KcXdYVU02SnRBa1FKMVlSVEhMNVJ4emxtTHprSTVjeHN4am00eUx4?=
 =?utf-8?B?QlFMWDNVZ3M3U3pMcy9Wci9ZT0FUZk01bmkweUNmRllBaDJxdGVQNGYvVlV0?=
 =?utf-8?B?MDhnVkgzZFYrTWlLNTAwWnBnVTNjd2dHMmp0ZURBMjBCTXRCbDNtcm92OHRp?=
 =?utf-8?B?Y0xHNlhRV0VBdU9JTkdsVlpVSDNtVnJzRDBDd01XcFlnckV3UHBKR2tkTzJ3?=
 =?utf-8?Q?MVVuT/nRARq5A1rvEUyOD2btu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c1767e-8b4f-4897-a413-08dcf366c442
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:29:48.7796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZuC+e14GGAqukI8KY2W5TDei/q5GeNQqq2RwgUul+6F+rTzkRTrl7Dp22HztYW6Sg8gZUnJw4vf6RKY6J7PcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_062954_876359_391AF4EC 
X-CRM114-Status: GOOD (  33.01  )
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

Ck9uIDEwLzIzLzIwMjQgNjozOSBBTSwgRGF2aWQgV29vZGhvdXNlIHdyb3RlOgo+IE9uIFdlZCwg
MjAyNC0xMC0yMyBhdCAwNjowNyAtMDUwMCwgS2FscmEsIEFzaGlzaCB3cm90ZToKPj4KPj4gQXMg
bWVudGlvbmVkIGFib3ZlLCBhYm91dCB0aGUgc2FtZSAyTUIgcGFnZSBjb250YWluaW5nIHRoZSBl
bmQgcG9ydGlvbiBvZiB0aGUgUk1QIHRhYmxlIGFuZCBhIHBhZ2UgYWxsb2NhdGVkIGZvciBrZXhl
YyBhbmQgCj4+IGxvb2tpbmcgYXQgdGhlIGU4MjAgbWVtb3J5IG1hcCBkdW1wIGhlcmU6IAo+Pgo+
Pj4+PiBbwqDCoMKgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDBiZmJlMDAwMDAw
LTB4MDAwMDAwYzE0MjBmZmZmZl0gcmVzZXJ2ZWQKPj4+Pj4gW8KgwqDCoCAwLjAwMDAwMF0gQklP
Uy1lODIwOiBbbWVtIDB4MDAwMDAwYzE0MjEwMDAwMC0weDAwMDAwMGZjN2ZmZmZmZmZdIHVzYWJs
ZQo+Pgo+PiBBcyBzZWVuIGhlcmUgaW4gdGhlIGU4MjAgbWVtb3J5IG1hcCwgdGhlIGVuZCByYW5n
ZSBvZiB0aGUgUk1QIHRhYmxlIGlzIG5vdAo+PiBhbGlnbmVkIHRvIDJNQiBhbmQgbm90IHJlc2Vy
dmVkIGJ1dCBpdCBpcyB1c2FibGUgYXMgUkFNLgo+Pgo+PiBTdWJzZXF1ZW50bHksIGtleGVjLWVk
IGtlcm5lbCBjb3VsZCB0cnkgdG8gYWxsb2NhdGUgZnJvbSB3aXRoaW4gdGhhdCBjaHVuawo+PiB3
aGljaCB0aGVuIGNhdXNlcyBhIGZhdGFsIFJNUCBmYXVsdC4KPiAKPiBXZWxsLCBhbGxvY2F0aW5n
IHdpdGhpbiB0aGF0IGNodW5rIHdvdWxkIGJlIGp1c3QgZmluZS4gSXQgKmlzKiB1c2FibGUKPiBh
cyBSQU0sIGFzIHRoZSBlODIwIHRhYmxlIHNheXMuIEl0IHdvcmtzIGZpbmUgbW9zdCBvZiB0aGUg
dGltZS4KPiAKPiBZb3UndmUgbWlzc2VkIGEgc3RlcCBvdXQgb2YgdGhlIHN0b3J5LiBUaGUgcHJv
YmxlbSBpcyB0aGF0IGZvciBrZXhlYyB3ZQo+IG1hcCBpdCB3aXRoIGFuICJvdmVycmVhY2hpbmci
IDJNaUIgUFRFIHdoaWNoIGFsc28gY292ZXJzIHRoZSByZXNlcnZlZAo+IHJlZ2lvbnMsIGFuZCAq
dGhhdCogaXMgd2hhdCBjYXVzZXMgdGhlIFJNUCB2aW9sYXRpb24gZmF1bHQuCj4gCgpBY3R1YWxs
eSwgdGhlIFJNUCBlbnRyeSBjb3ZlcmluZyB0aGUgZW5kIHJhbmdlIG9mIHRoZSBSTVAgdGFibGUg
d2lsbCBiZSBhIDJNQi9sYXJnZSBlbnRyeSAKd2hpY2ggbWVhbnMgdGhhdCB0aGUgd2hvbGUgMk1C
IGluY2x1ZGluZyB0aGUgdXNhYmxlIDFNQiBtZW1vcnkgcmFuZ2UgaGVyZSB3aWxsIGFsc28gYmUg
bWFya2VkCmFzIHJlc2VydmVkIGluIHRoZSBSTVAgdGFibGUgYW5kIGhlbmNlIGFueSBob3N0IHdy
aXRlcyBpbnRvIHRoaXMgbWVtb3J5IHJhbmdlIHdpbGwgdHJpZ2dlcgp0aGUgUk1QIHZpb2xhdGlv
bi4KCj4gV2UgY291bGQgdGFrZSB0d28gcG9zc2libGUgdmlld3BvaW50cyBoZXJlLiBJIHdhcyB0
YWtpbmcgdGhlIHZpZXdwb2ludAo+IHRoYXQgdGhpcyBpcyBhIGtlcm5lbCBidWcsIHRoYXQgaXQg
KnNob3VsZG4ndCogYmUgc2V0dGluZyB1cCAyTWlCIHBhZ2VzCj4gd2hpY2ggaW5jbHVkZSBhIHJl
c2VydmVkIHJlZ2lvbiwgYW5kIHNob3VsZCBicmVhayB0aG9zZSBkb3duIHRvIDRLaUIKPiBwYWdl
cy4KPiAKPiBUaGUgYWx0ZXJuYXRpdmUgdmlldyB3b3VsZCBiZSB0byBjb25zaWRlciBpdCBhIEJJ
T1MgYnVnLCBhbmQgdG8gc2F5Cj4gdGhhdCB0aGUgQklPUyByZWFsbHkgKm91Z2h0KiB0byBoYXZl
IHJlc2VydmVkIHRoZSB3aG9sZSAyTWlCIHJlZ2lvbiB0bwo+IGF2b2lkIHRoZSAnc2hhcmluZycu
ICBTaW5jZSB0aGUgaGFyZHdhcmUgYXBwYXJlbnRseSBhbHJlYWR5IGJyZWFrcyBkb3duCj4gMUdp
QiBwYWdlcyB0byAyTWlCIFRMQiBlbnRyaWVzIGluIG9yZGVyIHRvIGF2b2lkIHRyaWdnZXJpbmcg
dGhlIHByb2JsZW0KPiBvbiAxR2lCIG1hcHBpbmdzLgo+IAo+PiBUaGlzIGlzc3VlIGhhcyBiZWVu
IGZpeGVkIHdpdGggdGhlIGZvbGxvd2luZyBwYXRjaDogCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xrbWwvMTcxNDM4NDc2NjIzLjEwODc1LjE2NzgzMjc1ODY4MjY0OTEzNTc5LnRpcC1ib3Qy
QHRpcC1ib3QyLwo+IAo+IFRoYW5rcyBmb3IgcG9pbnRpbmcgdGhhdCBwYXRjaCBvdXQhIFNob3Vs
ZCBpdCBoYXZlIGJlZW4gQ2M6c3RhYmxlPwo+IAoKVGhpcyB0aGluZyBjYW4gaGFwcGVuIGFmdGVy
IFNOUCBob3N0IHN1cHBvcnQgZ290IG1lcmdlZCBpbiA2LjExIGFuZCBTTlAgc3VwcG9ydCBpcyBl
bmFibGVkLCB0aGVyZWZvcmUKdGhlIHBhdGNoIGRvZXMgbm90IG1hcmsgaXQgQ2M6c3RhYmxlLgoK
SSBhbSB0cnlpbmcgdG8gdW5kZXJzdGFuZCB0aGUgc2NlbmFyaW8gaGVyZTogeW91IGhhdmUgU05Q
IGVuYWJsZWQgaW4gdGhlIEJJT1MgYW5kIHlvdSBhbHNvCmhhdmUgU05QIHN1cHBvcnQgYWRkZWQg
aW4gdGhlIGhvc3Qga2VybmVsLCB3aGljaCBtZWFucyB0aGF0IHRoZSBmb2xsb3dpbmcgbG9ncyBh
cmUgc2VlbjoKLi4KU0VWLVNOUDogUk1QIHRhYmxlIHBoeXNpY2FsIHJhbmdlIFsweDAwMDAwMHh4
eHh4eHh4eHggLSAweDAwMDAwMHl5eXl5eXl5eXldCi4uCgo+IEl0IHNlZW1zIHRvIGJlIHRha2lu
ZyB0aGUgbGF0dGVyIG9mIHRoZSBhYm92ZSB0d28gdmlld3BvaW50cywgdGhhdCB0aGlzCj4gaXMg
YSBCSU9TIGJ1ZyBhbmQgdGhhdCB0aGUgQklPUyAqc2hvdWxkKiBoYXZlIHJlc2VydmVkIHRoZSB3
aG9sZSAyTWlCLgo+IAo+IEluIHRoYXQgY2FzZSBhcmUgZml4ZWQgQklPU2VzIGF2YWlsYWJsZSBh
bHJlYWR5PyAKCldlIGhhdmUgYmVlbiBvZiB0aGUgdmlldyB0aGF0IGl0IGlzIGVhc2llciB0byBn
ZXQgaXQgZml4ZWQgaW4ga2VybmVsLCBieSBmaXhpbmcvYWxpZ25pbmcgdGhlIGU4MjAgcmFuZ2UK
bWFwcGluZyB0aGUgc3RhcnQgYW5kIGVuZCBvZiBSTVAgdGFibGUgdG8gMk1CIGJvdW5kYXJpZXMs
IHJhdGhlciB0aGFuIHRydXN0aW5nIGEgQklPUyB0byBkbyBpdApjb3JyZWN0bHkuIAoKSGVyZSBp
cyBhIGxpbmsgdG8gYSBkaXNjdXNzaW9uIG9uIHRoZSBzYW1lOgpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMmFiMTRmNmYtMjY5MC0wNTZiLWNmOWUtMzhhMTJkYWZkNzI4QGFtZC5jb20vCgpU
aGFua3MsIApBc2hpc2gKCj5UaGlzIHBhdGNoIG1ha2VzIHNlbnNlCj4gYXMgYSB0ZW1wb3Jhcnkg
d29ya2Fyb3VuZCAod2UgaGF2ZSB3YXlzIHRvIHByaW50IHdhcm5pbmdzIGFib3V0IEJJT1MKPiBi
dWdzLCBidHcpLCBidXQgSSBkb24ndCByZWFsbHkgbGlrZSBpdCBhcyBhIGxvbmdlci10ZXJtICJm
aXgiLiBXaGF0IGlmCj4gdGhlIEJJT1MgaGFkIHB1dCAqb3RoZXIqIHRoaW5ncyBpbnRvIHRoYXQg
b3RoZXIgMU1pQiBvZiBhZGRyZXNzIHNwYWNlPwo+IFdoYXQgaWYgdGhlIGJvb3Rsb2FkZXIgaGFk
IGxvYWRlZCBzb21ldGhpbmcgdGhlcmU/IAo+IAo+IEknbSBzdGlsbCBpbmNsaW5lZCB0byBzdWdn
ZXN0IHRoYXQga2V4ZWMgKnNob3VsZG4ndCogdXNlIG92ZXItcmVhY2hpbmcKPiBsYXJnZSBwYWdl
cyB3aGljaCBjb3ZlciBhbnl0aGluZyB0aGF0IGlzbid0IG1hcmtlZCBhcyB1c2FibGUgUkFNLiAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
