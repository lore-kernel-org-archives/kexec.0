Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE77CD4857
	for <kexec@archiver.kernel.org>; Wed,  4 Sep 2024 17:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:
	References:Cc:To:Subject:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2Br2S8Ga9jStd9bmGM9OIJux732C0pmZTC1Ve1Hpy4w=; b=LCmrMecoSBIr9R1EWEUBj1vkyy
	2NilsAhbtV/QqBXoiz6gPYtgNOkNT1UF09PPsFXqdp1iyKCBMQOFlHMmmTgBp6FQICplPpHOEMqR5
	+7O5047SKqHkOqHkpC5YZr3Yob0vHucZpEDNJDLtYJ6fnDG9UI2niecwpbC45WIRRmTzGxrwZifYe
	gaK7XmmJMe7RaXGxl+hfpJp7Mrer8o+M0S5PuBWpkS2cA+PkD6aditEyG3v/Z63Wi2J3Gvb4zuVFM
	6gRnAIAT/mhoPUyk1nT62s9CMsQIf9Nk6T9XSwoDcip5+9WV0dyCCzOz2dQ47NXBerqPKoloQyEz8
	UWI2sFaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sltxp-00000005UNa-1vlQ;
	Wed, 04 Sep 2024 17:38:41 +0000
Received: from mail-dm6nam12on20627.outbound.protection.outlook.com ([2a01:111:f403:2417::627] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sltwh-00000005U0Z-0PN6
	for kexec@lists.infradead.org;
	Wed, 04 Sep 2024 17:37:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkdjNjoEOSwUjBj0BQqc9Dkd0Mtvrt9ehSwzWFXaO20mn6kWByQCPp8/punHn2lFdvbY9zGKZIMEGFPQHiUBDJhdLw7cqoFluuvL6OCi+kY7i6/DscsYdKvCdK2NrPMR9FcDwdUmlxXDH30e8oQrkoYr6UBfUbcdB1JVbgSplUNKS3CxpaKxFhmrBsyvhzqiCHIruE+uyAMzEExq5xE/uGqc5TPVGdJy7Z6YQG80/sx+7poE7tRrIG+3TJ/rjbgOqIpZybUtTVgxwHpfhD+uqT3fQK7hRBaQiiDRSVr4GvZu4+kZqo3CTkX80fB124oOFo7wfH+akMU7zlyogJ1JSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMTT09jMOOGoOB+eZ4FJWI4jVmaZjHkvEUu57TVxaAA=;
 b=JZk5Fb8IiitN5ccFGWgZYijWfoc0K8WdvLp/ZYCq2GgiN1RweDN0MNNoNCCiZRvBN/yCSjQR0i7cG0Q6osGxkPlgVrXzs1D/HJdEkRaianVCoRjCCcxmmhYr2/FM3jRonG91Eszj4bqO8RADAmHwggkNGQRZKi0wwK6YhY70qFOAZquKBLhZcmq4tS0qXr4fo1u1LnfUdCu0bjPIAxmBorcuqIYDwFzkQo5vBtbX9Cdl59OG2PQbTYZaF5khxrOeKoBjIwdF5/kTOJG/bD8BqsVTMme0mlpau2Z4pB7Yp4QxNDaVi6QDDcapmW55/D9pJK1MBJYOT/QA7FBVMgqY+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMTT09jMOOGoOB+eZ4FJWI4jVmaZjHkvEUu57TVxaAA=;
 b=q7L6i9obC16Kvl/GC5As1wI3sfgKRkmljiO4EU+++ePA6+RvUVmWMCn5zM5Aq/2jOVj3tcOnwi0igfoETZfk1dRVB0ONqpipkcL52l5oMse8G38QBZVCNJ87T5R10UPTIY/ZzMKRkChokawcAPPdh2JLVRidUwR82MZA+tJnzxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Wed, 4 Sep 2024 17:37:22 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 17:37:22 +0000
Message-ID: <14b0bc83-f645-408f-b8af-13f49fe6155d@amd.com>
Date: Wed, 4 Sep 2024 12:37:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/sev: Fix host kdump support for SNP
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, thomas.lendacky@amd.com,
 michael.roth@amd.com, kexec@lists.infradead.org, linux-coco@lists.linux.dev
References: <20240903191033.28365-1-Ashish.Kalra@amd.com>
 <ZtdpDwT8S_llR9Zn@google.com> <fbde9567-d235-459b-a80b-b2dbaf9d1acb@amd.com>
 <25ca73c9-e4ba-4a95-82c8-0d6cf8d0ff78@redhat.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <25ca73c9-e4ba-4a95-82c8-0d6cf8d0ff78@redhat.com>
X-ClientProxiedBy: SN6PR04CA0106.namprd04.prod.outlook.com
 (2603:10b6:805:f2::47) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b4aa8f-98ae-4603-de66-08dccd083b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTgzbDVWTTJzemVRaEpOQ0xKUEtvbXVWTmJEZHJrS2crUE44WHllNFBrRmlS?=
 =?utf-8?B?c1dNTDhWdXRyM2d5L0lBdllPUTcwWm40NEtqSS9HR3pnWXVkcnJsTVhZNXFT?=
 =?utf-8?B?QVRNdVdnd296dXViV21pSkk2dGlZdTM4ckxvZVBXVUcyUXNoMUtqcWdvQzJq?=
 =?utf-8?B?Y2xYbWUzZUt3S3lSdjRmODJrb0h4dGFGVTlxZW5OTnFPNDVVcHY1OXVDb3lm?=
 =?utf-8?B?VVMxK3I2aDJPdnFMUUtaQllDUU1wTmU1cGpkRXMrQmwvZVVTNkpCWVdCMy9u?=
 =?utf-8?B?QUZDTko5bGcwSlIyRXR3ZE8xN3loTU4wWUtUcktSbVRLcENOQmlMOC9tbXJC?=
 =?utf-8?B?bEovWUJURktOTzk2NnZTcUZLRlJkdlo0ZFJKVDV5U3A4ZlVVL0FENmNsWXRq?=
 =?utf-8?B?VjFUamVlOERVMWM0QzRPUGc4VFhhbUc4c21SM3JkMm9pdXRvcWovSERBYVpa?=
 =?utf-8?B?eWFaUVFSb0JEVTFjYWJnTEY2V3hYRjVSVHBDRzAyUkF0dEUrYXkzQ2dyZEU5?=
 =?utf-8?B?eFNmaHE0M2thTlQ2cUdseWtiVjVpSC9WNDhWUEhRQi91K3NWeDJOb3hHc0hG?=
 =?utf-8?B?Nzh0eHZOa2wrQStqZXUrVzg5UHl6Rm9rY0NxaHhiWGVUK0FVdDI0VEhPZC9S?=
 =?utf-8?B?eGdLZVVGUzdxT1NOd242LzhaWjlYaGZUQW9kbzBkUFZkbjhHdmp3VVd4TXNQ?=
 =?utf-8?B?aTAyRUI3cUxsQTBoQjdYUS9TcnJKWktXNHFoeGFLOVd5cHZIMmxtYUtnQkY0?=
 =?utf-8?B?REdoZjZKaldraHU2blZkTUpOOStoVXY0ZCtDVC9jOC9PZWlEZzZRN3FKK3gz?=
 =?utf-8?B?MHpScjhVMWcvUmh6dUhyR2RBalJBSUowTWZsa1NqS2p3OEtYY1luKzRVL0Zo?=
 =?utf-8?B?bVpKUXFyN21mcUlIc3QzRE9jdzRRMXJBMXFYZHY4S3MwVDdhNVpxT2pWRWtR?=
 =?utf-8?B?RGdUc29wVncyWVlXVUpsTGdOM2tENC9kbytDNzZYWTdkSWtmTFc2cndUd0dW?=
 =?utf-8?B?VFV6V0ZCTEVSRm1TK1g1TG00eUljemtteXFlZDFLVTRJUlJEVEg2dnZjWm9w?=
 =?utf-8?B?ZkVXU0praEpoRW1WT2xCL293MWxRTmIxTTdJVjdVRjZGNE15M1B1Y3JpWjdX?=
 =?utf-8?B?ZUl6SVp0YlN1SzFDRy9YbU1FZGxJRnF1L3ZvNGpyQmdpZ3lvSmZ2aGZZM0hE?=
 =?utf-8?B?Y2J6YWVnS09LZnJXZm9uSm5HWnFGNDhZOUdVZExjSS9haTBFTUV4aU1ldzMz?=
 =?utf-8?B?ejd4QVM4bUU3UEFSbWN2ZFppSW5RUE5INzdYbWJmelcrcWlIb0lid2tpNENG?=
 =?utf-8?B?TWduSTAzQUpieHdYczVacVlTUmpzaVNJaXVSUEY3QlJTTWxsRmpScGNuK095?=
 =?utf-8?B?enZDZ2RuSVlpUHJRSTZua1U0empNRTVwZUs4Q0NOdDNzK2RRb2s3ZTVua245?=
 =?utf-8?B?RnV5UGFLZ1RRM1l2cVFramZZbEpkSGk1Q3FUUWtpd1dWa1h4NjIrRDlCb3lT?=
 =?utf-8?B?dXFuSCtNYWhlaEJYWDcyVVhKbFdCYzVqdEtPT3RtS0R6a1VWNEVkRWw5VUNC?=
 =?utf-8?B?TkJvZmZCcUdRVXNuRVgwd1laNG40TWw5ZjZsV29mc2tUMExuVXFWRlpvZ0c3?=
 =?utf-8?B?S1JlZFVKMyt3VkFsZXRjNit0UHFvTHN4b2EwUGxlalc5WE9VZUxYeUh1Q1d1?=
 =?utf-8?B?WTh5OHZ4OExRbkx6cEdudFZGQ3NoNDJZWlR3V2dpcHdaQU9KQTErcXh4aTFy?=
 =?utf-8?B?bGFFZHdTallLN1ZZck5oZTk5S0ZLb3NYSlJmQW1pKzVEdWNyM2VpZ1ZHRGxE?=
 =?utf-8?B?SnRORWEyYzh1ME95K3JQdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0E5QzM5SUxYUGJhdkJjQmRiWEszelhncGxVR21JakczZ3NhTHFIOFBvYnJM?=
 =?utf-8?B?V1orQytrUlVJVGdsNy9YYUZDUUpWU3Jma2FjL2tkdXBWZ1ZpUk1JVnlnZ0NL?=
 =?utf-8?B?TXQ5SUNyNGxFdVRya3cvdmdiMTdCdHNGSVJCaEppNUhOT1pMMXJhNEFmNUxn?=
 =?utf-8?B?Y2VLMlEvU0thSWhtYVh2RXZZa1ZVaDkvMm95N0dpLzVJZlVWemcyRE1WNWQx?=
 =?utf-8?B?RmtKVVdQdHNLWUZZUHNCbHJMazRkNXhlOFl6Um5kSUg0NVIyV0xMTXU4S053?=
 =?utf-8?B?djZ6bmJ1RGdrZW9qdW4ybHhHYVBYSVVEdk1zaEY3UlVLZkZDcllSOVNYeHhE?=
 =?utf-8?B?LzU4bG1zcEJEeHJUZ3ZoZGJWdXFYYnJNVGIzdmgwZlRXcDdWSXRBV3l4M1d2?=
 =?utf-8?B?bnVENjJ4dEhydG1jY0ZUWTNOWHpXRkxtMERmbG5hQ1ZGT0h0Ui8wWGRXY0dG?=
 =?utf-8?B?MXhFYVUxei9OMGx0NWVsTXEvSXdLcXk4T1VzUnYrVnpiNklVTjlGbmFWc3Bp?=
 =?utf-8?B?QW8vTEprc0l4NnlldDJIdTRCYlVad3dvMWIrcHZVSmc0TGNBWGRuUWo4LzVR?=
 =?utf-8?B?djRPQmNZWVhETXQwWTcvMEE4T28vaTFJNjhma25FQzQvd3dXK2wzNysvWGgw?=
 =?utf-8?B?aWxFNTRPLzhCeVl1eGtyYWlWUmlyY3hoNGJhaWhkaGJiaG44dmxVQ05LVi9L?=
 =?utf-8?B?SFF3bGt1OVdPMEk5Q0hFYjZQUTNGMUVWM3hBbC8wSDJIRmxJcUkxVE9kaCt4?=
 =?utf-8?B?cGZpQ2RiK2dXZEN3aXF4dHk0WkhZZGhISTRuZTRaZ0tHZ0x6dFE5enFZZlFj?=
 =?utf-8?B?WVlIYmlKWEhmcGdYY3o4dHdkcXFaQ0o4OXlOYS9ZVTZ2cE1yWHdZcm83UUxC?=
 =?utf-8?B?d0R0RUZ5dzBZR0k5NWUxN1ovMEF2d2hUbzcyMEpNbGg3RUFoYW1qalRRZmFl?=
 =?utf-8?B?eSsxaHAySFkrcm5ZbzQ3eEVTb1JrUloycEtweFlndW13M1FPa3MvYVg4MGN5?=
 =?utf-8?B?M2lvRmZuSWNmenEvcXBIVjN1L2hxZDBrTitTYkJTektOL1MrY2F5TlVnd3ds?=
 =?utf-8?B?Q0NYRzJtdjVLbmdsLzFrNmhZckMyR0E5RFpaNFliRkRZU2IwWE01UFptZzcv?=
 =?utf-8?B?WmkzK3Jza2JqdUhXaFRqRzgvVkg1Y0Z1Q0hZaFFmMTkyWjVsQTNJclpKd3Jw?=
 =?utf-8?B?S0FLWTZWNGFvT1ZhMUdjSGxMaFhzc1BZZHUwRVdmMkV6S2JWZjFqVUZFMW5N?=
 =?utf-8?B?aHQ3T2I4QmtOajNteTBRSEZNUElxaWVjSkdFVHY3bjZwV0xTb0pVWjRFdW9i?=
 =?utf-8?B?RUk5WU1SQlRxMFdvYXdIeGRlZkd0SVRWdThCQkFvMXVHSHFmRXc1U0pXZ1ln?=
 =?utf-8?B?YVpqTnM5cjBHc2hwUVk3bTdCZ3ZSY1cyYiszRUNsTUdwb1phRWZoM3E5MEV5?=
 =?utf-8?B?aU51Tzc2Tlp4ZlZwNVd5Vk5RcVNVQ05VajBoaWVFT3NUUWRMVW96SlRJZ2RW?=
 =?utf-8?B?K1lOK3U4VlRMdWE1bUFQZGtDdy93SjdsSDBnM0ZEQUhrU1hCd1B1WkhRa0pu?=
 =?utf-8?B?SmVZY3A5Uk93THhZQlpMSFprdDBvSkdwcUxxVlo1R3pENzU2dlQyeTBIdkR6?=
 =?utf-8?B?VCs0V2dMN2ttQzI1bUtadjdFdTY1VTZSQXJCQlpldDZXa0xqQ3ZaVkxKUHNl?=
 =?utf-8?B?OHNwZlpoeUpuVHFkMGJYVUJxUE05VU9EaTl6N3kwL3o0a1kyeHE1QWJtd2RF?=
 =?utf-8?B?Zm5TQ0JzMWJlYUJLQTVkYkdJanFxSk4yeHh4bDg1TldQZ0k5VFloYzgvbmg1?=
 =?utf-8?B?cDhWdkFuc2cwMU1lL09PY2pIQXpabE5vRmlVQjFxQ1lsQ1R0d3dpYTBHb1dV?=
 =?utf-8?B?dmdWOGpmT1dYUHE1UTVLczJuWi9BSHBtV3FKR0NlWHdodkNaWlQySzQ2bVVT?=
 =?utf-8?B?anhIaUNNMllvejlJL1Jabmx2b1Fwb2VzMXVVRlpLMU04cFZ5RElFNmcveXRi?=
 =?utf-8?B?MzFCc3JvV3dWWldCZ244ZGVWS2svQjBMUUExNDZCZGMvS1NOS0pMNlBCR2dT?=
 =?utf-8?B?WUZtYWFkQjllREFmODFFU2ZBRkZ5aWVwNktkWXVJbWEvUlMzTC85dTMwc3Jk?=
 =?utf-8?Q?29lbDlZuJ+gU88ulVvYZTxxRE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b4aa8f-98ae-4603-de66-08dccd083b9d
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 17:37:22.5473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9D3VS/cwl2IYhbvu6I4h0FYcgPDCyF8xq2AfA1B0PZ7XPZzBEcYD6EtO93ZREICffQOzNT9d+J9V39td70mrNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_103731_203975_B15DD50B 
X-CRM114-Status: GOOD (  27.61  )
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

SGVsbG8gUGFvbG8sCgpPbiA5LzQvMjAyNCA1OjI5IEFNLCBQYW9sbyBCb256aW5pIHdyb3RlOgo+
IE9uIDkvNC8yNCAwMDo1OCwgS2FscmEsIEFzaGlzaCB3cm90ZToKPj4gVGhlIGlzc3VlIGhlcmUg
aXMgdGhhdCBwYW5pYyBwYXRoIHdpbGwgZW5zdXJlIHRoYXQgYWxsIChvdGhlcikgQ1BVcwo+PiBo
YXZlIGJlZW4gc2h1dGRvd24gdmlhIE5NSSBieSBjaGVja2luZyB0aGF0IHRoZXkgaGF2ZSBleGVj
dXRlZCB0aGUKPj4gTk1JIHNodXRkb3duIGNhbGxiYWNrLgo+Pgo+PiBCdXQgdGhlIGFib3ZlIHN5
bmNocm9uaXphdGlvbiBpcyBzcGVjaWZpY2FsbHkgcmVxdWlyZWQgZm9yIFNOUCBjYXNlLAo+PiBh
cyB3ZSBkb24ndCB3YW50IHRvIGV4ZWN1dGUgdGhlIFNOUF9ERUNPTU1JU1NJT04gY29tbWFuZCAo
dG8gZGVzdHJveQo+PiBTTlAgZ3Vlc3QgY29udGV4dCkgd2hpbGUgb25lIG9yIG1vcmUgQ1BVcyBh
cmUgc3RpbGwgaW4gdGhlIE5NSSBWTUVYSVQKPj4gcGF0aCBhbmQgc3RpbGwgaW4gdGhlIHByb2Nl
c3Mgb2Ygc2F2aW5nIHRoZSB2Q1BVIHN0YXRlIChhbmQgc3RpbGwKPj4gbW9kaWZ5aW5nIFNOUCBn
dWVzdCBjb250ZXh0PykgZHVyaW5nIHRoaXMgVk1FWElUIHBhdGguIFRoZXJlZm9yZSwgd2UKPj4g
ZW5zdXJlIHRoYXQgYWxsIHRoZSBDUFVzIGhhdmUgc2F2ZWQgdGhlIHZDUFUgc3RhdGUgYW5kIGVu
dGVyZWQgTk1JCj4+IGNvbnRleHQgYmVmb3JlIGlzc3VpbmcgU05QX0RFQ09NTUlTU0lPTi4gVGhl
IHBvaW50IGlzIHRoYXQgdGhpcyBpcyBhCj4+IHNwZWNpZmljIFNOUCByZXF1aXJlbWVudCAoYW5k
IHRoYXQncyB3aHkgdGhpcyBzcGVjaWZpYyBoYW5kbGluZyBpbgo+PiBzZXZfZW1lcmdlbmN5X2Rp
c2FibGUoKSkgYW5kIGkgZG9uJ3Qga25vdyBob3cgd2Ugd2lsbCBiZSBhYmxlIHRvCj4+IGVuZm9y
Y2UgaXQgaW4gdGhlIGdlbmVyaWMgcGFuaWMgcGF0aCA/Cj4KPiBJIHRoaW5rIGEgc2ltcGxlIHdh
eSB0byBkbyB0aGlzIGlzIHRvIF9maXJzdF8ga2ljayBvdXQgb3RoZXIKPiBDUFVzIHRocm91Z2gg
Tk1JLCBhbmQgdGhlbiB0aGUgb25lIHRoYXQgaXMgZXhlY3V0aW5nCj4gZW1lcmdlbmN5X3JlYm9v
dF9kaXNhYmxlX3ZpcnR1YWxpemF0aW9uKCkuwqAgVGhpcyBhbHNvIG1ha2VzCj4gZW1lcmdlbmN5
X3JlYm9vdF9kaXNhYmxlX3ZpcnR1YWxpemF0aW9uKCkgYW5kCj4gbmF0aXZlX21hY2hpbmVfY3Jh
c2hfc2h1dGRvd24oKSBtb3JlIHNpbWlsYXIsIGluIHRoYXQKPiB0aGUgbGF0dGVyIGFscmVhZHkg
c3RvcHMgb3RoZXIgQ1BVcyBiZWZvcmUgZGlzYWJsaW5nCj4gdmlydHVhbGl6YXRpb24gb24gdGhl
IG9uZSB0aGF0IG9yY2hlc3RyYXRlcyB0aGUgc2h1dGRvd24uCj4KPiBTb21ldGhpbmcgbGlrZSAo
aW5jb21wbGV0ZSwgaXQgaGFzIHRvIGFsc28gYWRkIHRoZSBib29sIGFyZ3VtZW50Cj4gdG8gY3B1
X2VtZXJnZW5jeV92aXJ0X2NhbGxiYWNrIGFuZCB0aGUgYWN0dWFsIGNhbGxiYWNrcyk6Cj4KPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NyYXNoLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3Jh
c2guYwo+IGluZGV4IDM0MGFmODE1NTY1OC4uM2RmMjVmYmU5NjlkIDEwMDY0NAo+IC0tLSBhL2Fy
Y2gveDg2L2tlcm5lbC9jcmFzaC5jCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NyYXNoLmMKPiBA
QCAtMTExLDcgKzExMSw3IEBAIHZvaWQgbmF0aXZlX21hY2hpbmVfY3Jhc2hfc2h1dGRvd24oc3Ry
dWN0IHB0X3JlZ3MgKnJlZ3MpCj4gwqAKPiDCoMKgwqDCoCBjcmFzaF9zbXBfc2VuZF9zdG9wKCk7
Cj4gwqAKPiAtwqDCoMKgIGNwdV9lbWVyZ2VuY3lfZGlzYWJsZV92aXJ0dWFsaXphdGlvbigpOwo+
ICvCoMKgwqAgY3B1X2VtZXJnZW5jeV9kaXNhYmxlX3ZpcnR1YWxpemF0aW9uKHRydWUpOwo+IMKg
Cj4gwqDCoMKgwqAgLyoKPiDCoMKgwqDCoMKgICogRGlzYWJsZSBJbnRlbCBQVCB0byBzdG9wIGl0
cyBsb2dnaW5nCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9yZWJvb3QuYyBiL2FyY2gv
eDg2L2tlcm5lbC9yZWJvb3QuYwo+IGluZGV4IDBlMGE0Y2Y2YjVlYi4uN2E4NmVjNzg2OTg3IDEw
MDY0NAo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9yZWJvb3QuYwo+ICsrKyBiL2FyY2gveDg2L2tl
cm5lbC9yZWJvb3QuYwo+IEBAIC01NTgsNyArNTU4LDcgQEAgRVhQT1JUX1NZTUJPTF9HUEwoY3B1
X2VtZXJnZW5jeV91bnJlZ2lzdGVyX3ZpcnRfY2FsbGJhY2spOwo+IMKgICogcmVib290LsKgIFZN
WCBibG9ja3MgSU5JVCBpZiB0aGUgQ1BVIGlzIHBvc3QtVk1YT04sIGFuZCBTVk0gYmxvY2tzIElO
SVQgaWYKPiDCoCAqIEdJRj0wLCBpLmUuIGlmIHRoZSBjcmFzaCBvY2N1cnJlZCBiZXR3ZWVuIENM
R0kgYW5kIFNUR0kuCj4gwqAgKi8KPiAtdm9pZCBjcHVfZW1lcmdlbmN5X2Rpc2FibGVfdmlydHVh
bGl6YXRpb24odm9pZCkKPiArdm9pZCBjcHVfZW1lcmdlbmN5X2Rpc2FibGVfdmlydHVhbGl6YXRp
b24oYm9vbCBsYXN0KQo+IMKgewo+IMKgwqDCoMKgIGNwdV9lbWVyZ2VuY3lfdmlydF9jYiAqY2Fs
bGJhY2s7Cj4gwqAKPiBAQCAtNTcyLDcgKzU3Miw3IEBAIHZvaWQgY3B1X2VtZXJnZW5jeV9kaXNh
YmxlX3ZpcnR1YWxpemF0aW9uKHZvaWQpCj4gwqDCoMKgwqAgcmN1X3JlYWRfbG9jaygpOwo+IMKg
wqDCoMKgIGNhbGxiYWNrID0gcmN1X2RlcmVmZXJlbmNlKGNwdV9lbWVyZ2VuY3lfdmlydF9jYWxs
YmFjayk7Cj4gwqDCoMKgwqAgaWYgKGNhbGxiYWNrKQo+IC3CoMKgwqDCoMKgwqDCoCBjYWxsYmFj
aygpOwo+ICvCoMKgwqDCoMKgwqDCoCBjYWxsYmFjayhsYXN0KTsKPiDCoMKgwqDCoCByY3VfcmVh
ZF91bmxvY2soKTsKPiDCoH0KPiDCoAo+IEBAIC01OTEsMTEgKzU5MSwxMSBAQCBzdGF0aWMgdm9p
ZCBlbWVyZ2VuY3lfcmVib290X2Rpc2FibGVfdmlydHVhbGl6YXRpb24odm9pZCkKPiDCoMKgwqDC
oMKgICogb3RoZXIgQ1BVcyBtYXkgaGF2ZSB2aXJ0dWFsaXphdGlvbiBlbmFibGVkLgo+IMKgwqDC
oMKgwqAgKi8KPiDCoMKgwqDCoCBpZiAocmN1X2FjY2Vzc19wb2ludGVyKGNwdV9lbWVyZ2VuY3lf
dmlydF9jYWxsYmFjaykpIHsKPiAtwqDCoMKgwqDCoMKgwqAgLyogU2FmZWx5IGZvcmNlIF90aGlz
XyBDUFUgb3V0IG9mIFZNWC9TVk0gb3BlcmF0aW9uLiAqLwo+IC3CoMKgwqDCoMKgwqDCoCBjcHVf
ZW1lcmdlbmN5X2Rpc2FibGVfdmlydHVhbGl6YXRpb24oKTsKPiAtCj4gwqDCoMKgwqDCoMKgwqDC
oCAvKiBEaXNhYmxlIFZNWC9TVk0gYW5kIGhhbHQgb24gb3RoZXIgQ1BVcy4gKi8KPiDCoMKgwqDC
oMKgwqDCoMKgIG5taV9zaG9vdGRvd25fY3B1c19vbl9yZXN0YXJ0KCk7Cj4gKwo+ICvCoMKgwqDC
oMKgwqDCoCAvKiBTYWZlbHkgZm9yY2UgX3RoaXNfIENQVSBvdXQgb2YgVk1YL1NWTSBvcGVyYXRp
b24uICovCj4gK8KgwqDCoMKgwqDCoMKgIGNwdV9lbWVyZ2VuY3lfZGlzYWJsZV92aXJ0dWFsaXph
dGlvbih0cnVlKTsKPiDCoMKgwqDCoCB9Cj4gwqB9Cj4gwqAjZWxzZQo+IEBAIC04NzcsNyArODc3
LDcgQEAgc3RhdGljIGludCBjcmFzaF9ubWlfY2FsbGJhY2sodW5zaWduZWQgaW50IHZhbCwgc3Ry
dWN0IHB0X3JlZ3MgKnJlZ3MpCj4gwqDCoMKgwqDCoCAqIFByZXBhcmUgdGhlIENQVSBmb3IgcmVi
b290IF9hZnRlcl8gaW52b2tpbmcgdGhlIGNhbGxiYWNrIHNvIHRoYXQgdGhlCj4gwqDCoMKgwqDC
oCAqIGNhbGxiYWNrIGNhbiBzYWZlbHkgdXNlIHZpcnR1YWxpemF0aW9uIGluc3RydWN0aW9ucywg
ZS5nLiBWTUNMRUFSLgo+IMKgwqDCoMKgwqAgKi8KPiAtwqDCoMKgIGNwdV9lbWVyZ2VuY3lfZGlz
YWJsZV92aXJ0dWFsaXphdGlvbigpOwo+ICvCoMKgwqAgY3B1X2VtZXJnZW5jeV9kaXNhYmxlX3Zp
cnR1YWxpemF0aW9uKGZhbHNlKTsKPiDCoAo+IMKgwqDCoMKgIGF0b21pY19kZWMoJndhaXRpbmdf
Zm9yX2NyYXNoX2lwaSk7Cj4gwqAKPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3NtcC5j
IGIvYXJjaC94ODYva2VybmVsL3NtcC5jCj4gaW5kZXggMTgyNjZjYzNkOThjLi45YTg2MzM0OGQx
YTcgMTAwNjQ0Cj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3NtcC5jCj4gKysrIGIvYXJjaC94ODYv
a2VybmVsL3NtcC5jCj4gQEAgLTEyNCw3ICsxMjQsNyBAQCBzdGF0aWMgaW50IHNtcF9zdG9wX25t
aV9jYWxsYmFjayh1bnNpZ25lZCBpbnQgdmFsLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKPiDCoMKg
wqDCoCBpZiAocmF3X3NtcF9wcm9jZXNzb3JfaWQoKSA9PSBhdG9taWNfcmVhZCgmc3RvcHBpbmdf
Y3B1KSkKPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBOTUlfSEFORExFRDsKPiDCoAo+IC3CoMKg
wqAgY3B1X2VtZXJnZW5jeV9kaXNhYmxlX3ZpcnR1YWxpemF0aW9uKCk7Cj4gK8KgwqDCoCBjcHVf
ZW1lcmdlbmN5X2Rpc2FibGVfdmlydHVhbGl6YXRpb24oZmFsc2UpOwo+IMKgwqDCoMKgIHN0b3Bf
dGhpc19jcHUoTlVMTCk7Cj4gwqAKPiDCoMKgwqDCoCByZXR1cm4gTk1JX0hBTkRMRUQ7Cj4gQEAg
LTEzNiw3ICsxMzYsNyBAQCBzdGF0aWMgaW50IHNtcF9zdG9wX25taV9jYWxsYmFjayh1bnNpZ25l
ZCBpbnQgdmFsLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKPiDCoERFRklORV9JRFRFTlRSWV9TWVNW
RUMoc3lzdmVjX3JlYm9vdCkKPiDCoHsKPiDCoMKgwqDCoCBhcGljX2VvaSgpOwo+IC3CoMKgwqAg
Y3B1X2VtZXJnZW5jeV9kaXNhYmxlX3ZpcnR1YWxpemF0aW9uKCk7Cj4gK8KgwqDCoCBjcHVfZW1l
cmdlbmN5X2Rpc2FibGVfdmlydHVhbGl6YXRpb24oZmFsc2UpOwo+IMKgwqDCoMKgIHN0b3BfdGhp
c19jcHUoTlVMTCk7Cj4gwqB9Cj4gwqAKPgo+IEFuZCB0aGVuIGEgc2Vjb25kIHBhdGNoIGFkZHMg
c2V2X2VtZXJnZW5jeV9kaXNhYmxlKCkgYW5kIG9ubHkKPiBleGVjdXRlcyBpdCBpZiBsYXN0ID09
IHRydWUuCj4KVGhpcyBpbXBsZW1lbnRhdGlvbiB3aWxsIG5vdCB3b3JrIGFzIHdlIG5lZWQgdG8g
ZG8gd2JpbnZkIG9uIGFsbCBvdGhlciBDUFVzIGFmdGVyIFNOUF9ERUNPTU1JU1NJT04gaGFzIGJl
ZW4gaXNzdWVkLgoKV2hlbiB0aGUgbGFzdCBDUFUgZXhlY3V0ZXMgc2V2X2VtZXJnZW5jeV9kaXNh
YmxlKCkgYW5kIGlzc3VlcyBTTlBfREVDT01NSVNTSU9OLCBieSB0aGF0IHRpbWUgYWxsIG90aGVy
IENQVXMgaGF2ZSBlbnRlcmVkIHRoZSBOTUkgaGFsdCBsb29wIGFuZCB0aGVuIHRoZXkgd29uJ3Qg
YmUgYWJsZSB0byBkbyBhIHdiaW52ZCBhbmQgaGVuY2UgU05QX1NIVVRET1dOIHdpbGwgZXZlbnR1
YWxseSBmYWlsLgoKT25lIHdheSB0aGlzIGNhbiB3b3JrIGlzIGlmIGFsbCBvdGhlciBDUFVzIGNh
biBzdGlsbCBleGVjdXRlIHNldl9lbWVyZ2VuY3lfZGlzYWJsZSgpIGFuZCBpbiBjYXNlIG9mIGxh
c3QgPT0gZmFsc2UsIGRvIGEgc3BpbiBidXN5IHRpbGwgdGhlIGxhc3QgY3B1IGtpY2tzIHRoZW0g
b3V0IG9mIHRoZSBzcGluIGxvb3AgYW5kIHRoZW4gdGhleSBkbyBhIHdiaW52ZCBhZnRlciBleGl0
aW5nIHRoZSBzcGluIGJ1c3ksIGJ1dCB0aGVuIGNwdV9lbWVyZ2VuY3lfZGlzYWJsZV92aXJ0dWFs
aXphdGlvbigpIGlzL2hhcyB0byBiZSBjYWxsZWQgYmVmb3JlIGF0b21pY19kZWMoJndhaXRpbmdf
Zm9yX2NyYXNoX2lwaSkgaW4gY3Jhc2hfbm1pX2NhbGxiYWNrKCksIHNvIHRoaXMgc3BpbiBidXN5
IGluIG90aGVyIENQVXMgd2lsbCBmb3JjZSB0aGUgbGFzdCBDUFUgdG8gd2FpdCBmb3JldmVyIChv
ciB0aWxsIGl0IHRpbWVzIG91dCB3YWl0aW5nIGZvciBhbGwgb3RoZXIgQ1BVcyB0byBleGVjdXRl
IHRoZSBOTUkgY2FsbGJhY2spIHdoaWNoIG1ha2VzIGFsbCBvZiB0aGlzIGxvb2tzIHF1aXRlIGZy
YWdpbGUuCgpUaGFua3MsIEFzaGlzaAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
