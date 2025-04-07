Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9A1C369B6
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 08:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=geGb3jek7KlIMIbcLWTLWaSu94BBbGctjeal72k8Nbk=; b=o569vR6q5IXfXyUtr6FZLH3zgG
	zP+HtZg+PJjBy2eZA1quNJld/IkN+LAZyAzIeg1/QucRjgi+C82ju5mKu/m05oxUioJashGTSUgBU
	j1MM2ivWdKMFjcKSdQpWQO9GLACdyI2UiXI+8L6kWt9Oevf6e3YHl08nGydOvdV96PhUw9G78l9FR
	CVI954/Hx7ruJcAH76pg8Td5/rSI4w8EJV1IoJAqJAQ0YSajUmOx2xMBIekKYwHoS8eF1LHErFiH6
	GWSL3NeRntjMU/BAIgIRla5z1AtaNEUM4VU5QfCLgS52TRMKdwoISRnsw+qTssZv9HwgWOUlDLBR4
	1fVUud/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FJQ-000000017SF-2MF5;
	Mon, 14 Apr 2025 08:37:04 +0000
Received: from mail-dm6nam04on2062c.outbound.protection.outlook.com ([2a01:111:f403:2409::62c] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1nNr-00000000hpX-1XpZ;
	Mon, 07 Apr 2025 14:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIBm8Ya0P/NJf6/oRFLlI77vh10pTgdpziP9loW9XysNrdSP9MyxN7oNAscYyC6jMU7tZStJWJcLzyPGQiG5xUIDGs1IWY4JOG5Yz2O0xNHURdCDjEO8PyCVsHk5KAz767DwJ1x5mjb2opu5h6Tpw0JGhHS6Xww6gu9dLoxMOIUStRr4lUJi7dHx8Sp7eXl2kzKpuXbj7ruqc/h4ExCn1acuMZJg6ZUprjRU1iqI1C8KTb4i3jaPPjRh+ILFVnOwsNDEY9OObdTPkHa3r6YiVV/TweWF6KJB5tHuuSpX8ps4wwSZYiznc3970MWNS5wmaAjGSCCrrApNFYfQFAoilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geGb3jek7KlIMIbcLWTLWaSu94BBbGctjeal72k8Nbk=;
 b=bXxxYpCSFC6V9sMuDkRe9eVd9WSObhnM67kl4q5TMYM394Q0/nn3KwGTEil+14C0bcgKCL1do0iBeqyOmESHHE1IoAxEfDuDz2rOMMoregRP00b90byibZswo2IyPcPw56ByI3Ry81kYHUsEhjypn/Xf8s4DwRxBWDUZU8kT+s2Pc0jGJfXERRdTXjjYw7m/terSIVZTxGYzW5FWZjRrgSN6xEp41hGmGl1HpZtDQzXHKkwmXJrumQeQo0NwGxuznShASnpmeFj4gUyNU/BspaX5mfbwbrttqm0oUgPZgjF7JCffizNYh2Jg9xmtNPCjzgfn79W558VkQeiNvigWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geGb3jek7KlIMIbcLWTLWaSu94BBbGctjeal72k8Nbk=;
 b=iHXGVBYa2AcscxuTQ3Yg5WvQk5lTRva7tzRoG3v6ZIZjBfbPeHbo+m6i69wtFIT2st7qW5YJei7jGeJeHh+Kyz/SVPGk+DS0/ZyV/REttu+WK/5AJGY6JgFlvcV+YWwAQbxjABSpBpoHrYOd1hmSuuBASknc398d0oSMGXdGCe0rAYgRDFZC0MO7mv4FAcBKTzBftWs780lgiNp0gcSGq/ahPVucmXb6sOk2w1IGRPJsIq3cJcEL6094hwg4V2t6ja8+ysY4TqXxLhz6f/6emA/Xo5jwY9aTYenbHVLFtnPI/W4qXbbCwtF3Sb9AgVtNybYGE99bUc1gRh9Ecfjmdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 14:23:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 14:23:26 +0000
Date: Mon, 7 Apr 2025 11:23:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <ptyadav@amazon.de>,
	Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, robh+dt@kernel.org, robh@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <20250407142325.GD1557073@nvidia.com>
References: <20250320015551.2157511-10-changyuanl@google.com>
 <mafs05xjmqsqc.fsf@amazon.de>
 <20250403114209.GE342109@nvidia.com>
 <Z-6UA3C1TPeH_kGL@kernel.org>
 <20250403142438.GF342109@nvidia.com>
 <Z--sUYCvP3Q8nT8e@kernel.org>
 <20250404124729.GH342109@nvidia.com>
 <Z-_kSXrHWU5Bf3sV@kernel.org>
 <mafs0cydrq4wv.fsf@amazon.de>
 <Z_KtFnmExftpotmR@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_KtFnmExftpotmR@kernel.org>
X-ClientProxiedBy: MN2PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:208:120::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 2211a832-49a5-4542-84e9-08dd75dfc2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L9TmdO+u4t2CJNJNRN3WfPkvRFhuWEcKvfXDKMWoGYlNsXYGwQ0yrII0Ivb1?=
 =?us-ascii?Q?7vkNZcmxguicuG80Y4vcuoZV8jMqdHPd2gGZUuNaZVxwjNzMP3Zn7UQe65GD?=
 =?us-ascii?Q?qKI8S42EIhmra2BbNic44NbL/+CjCezgNX6Sb76fGQ8IYS3JEiJIHTSYBtOE?=
 =?us-ascii?Q?QrUpvj9qKHtZ8Amt1CMERj3tTN9YSUHmlmUuuIcxWQBX1bI+YKZQkvJPDoc7?=
 =?us-ascii?Q?Q3w5WVvlLWEjJ7Q6Ex5Vzp/yFFl5gLoaTtAc6H/bIoCXAnmyyCphHvHsWAzk?=
 =?us-ascii?Q?GQBbhYitdRkdhtNMwB/hewWemksU665fq6kff4cJN625jcTjnbuBxwRE3Zsh?=
 =?us-ascii?Q?P8uTMIRtHaEhWU2NB2ZfMfP7KZjHVH7efAVb2lPzDxb3UFOuOSkwOl+MwbRE?=
 =?us-ascii?Q?xKD4AsgkbvWUiowiPylkanDRSHAhjH3jgkOXQ21NVclfVNXxNJNUtC9mABCA?=
 =?us-ascii?Q?6uvOBmFhor+Hcr7ojstqpqDL2JaRJRM6OD0bjyHns9Dd1s8PauKX44N/2I+4?=
 =?us-ascii?Q?FU/rjxjGpEdy4hh9wr0ychrXroBt+Nc/eARCZE1NbLQ25bZvN9WVY6azlkm8?=
 =?us-ascii?Q?vltE27IXOktv5RSpDoHEB8HRH+lxVC6RFOcIpF0koIwlTV3iSwCM7NBpsE4h?=
 =?us-ascii?Q?3Y4dSjXaq9C/bkiZjeyMpHyxoYtyhYvcL6W418HOSP9H2jmKa3ll3vbksxJv?=
 =?us-ascii?Q?I3zRjbEJNa2US+VHCYvo3fa/2iypxHfCFZdF41yD/GuHGLjoyZdBX76DGWYp?=
 =?us-ascii?Q?MbNy4DlVuwLjXiIb1m9nbBzyICeyBQRu1xN3Ia4+S5XiUFZQ135W0kpr0qVR?=
 =?us-ascii?Q?jWm1ZUJYTQrpB+yVcjjqqooKFOQiJb5UZ51mwsWsM3EO8OU6iWsTVpmEERMV?=
 =?us-ascii?Q?DGvTSTFxN+esRFD1IZSU0TczHybBK4F8QH0igFslLMhH2It6bpzm5pKsQntJ?=
 =?us-ascii?Q?kFOIE3UpfAkfgG245DNjsf7eVtkSadLB5dIhkc6QlxOpFjKSbmnP5OFi5GjG?=
 =?us-ascii?Q?iE2zGCFSRAXUR0yL+DmpesD+geRjiDQNlLB/bMTFqHmWCwt8aLfsjRyZvLKo?=
 =?us-ascii?Q?prUmDLweIiWZy2iwfi7sK3BNtc5A6akf57Lg8lphYylzZVqFokEazA+wsVnp?=
 =?us-ascii?Q?rg1uHQNg3gw6txmjjwN6QnOb6UiB/uQSoRgSQtQ+QbkTyObeQUacWqZfOV+D?=
 =?us-ascii?Q?JqvYfpiYZh+AmbIQuQc/C8K2188yTmUkxI2nqf9FnRLm7IQqrhR343RXBHhU?=
 =?us-ascii?Q?iHyB0xMVdyZaiIHgndTfJmDXQZDjeQRm1/+A/NJ+8qe8yZFXoYwnZ15svm6M?=
 =?us-ascii?Q?IsGiAqyUVnZqvb+ylCWsLVr7WyNrm6+PH0z74CY6B1MHWLwblvJnRA3HmEhO?=
 =?us-ascii?Q?scQT34Gbuyv2i/v9hOjuVsJXC+rO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y5aYtQNR25+algwOZDneW0kScR0/grlP0bNHyJGC4J2M4Yy6vwFAkdCK7OYT?=
 =?us-ascii?Q?iqA8P/qY+Fn/YdRU8TTvuSBhtHP4UQPrY8c+SqypSjbi50XQnMvXDMII9eSE?=
 =?us-ascii?Q?H9DWiRloIfKpTQpO6QgjefZwc86F82j9LhHDeIjoAemQ4vuOvVc2bIUHQqfW?=
 =?us-ascii?Q?HLb5bpVKkLAE2kPvRPQx2Wj0c6pVQkDDD1rdk+DEO++oDrl4TBz+03WKY3qO?=
 =?us-ascii?Q?SS73XkKm149dYyDV2VU7Qzyh0F8NH7acwhNew03JN+6oGHTCJ5PwIVo5Ok+/?=
 =?us-ascii?Q?8g8BEyY6hz7WPWZ7MJn5qulSLIl+JhDwR7hWv2hDXmk4cn8uZle9XDkvWh6X?=
 =?us-ascii?Q?tp7XzQA0Jy+qKmFN+kr/sSV4g3A3PEsuGortaHbue/GYdf+ZOiyqCnyD6ExZ?=
 =?us-ascii?Q?35UgFa5AyjEPWzQuABNZBHw3O0trA4ZbHWq/VFUIRdpSV29WOwf2gclnSQfr?=
 =?us-ascii?Q?A9yqICaQpxqQXx1cseFK7W4dIUqkKmtKCTdIFVvdpgDFj/hGRbVCxvJXAHaJ?=
 =?us-ascii?Q?goZm+d8LlvknFKC56rA1FrkuAVxVc4VkUY6yqgY3CT2sLiUDzrDUatb/QVVe?=
 =?us-ascii?Q?iWdFGHuoKK6Wx/X+ExA2+5Y4dATuEStK7xz2dsR9ydaJ/vpPWGYazoMFrDcB?=
 =?us-ascii?Q?BN/g00hQdiss4HFB7lJzpvrBBd0b1lCegEK63KXiMh8gRR96Ev/MF98HmaLE?=
 =?us-ascii?Q?wFPj16gaffMYOgjMfKxtXO8wdt9ZYDAXNftogN3ecXOG8he58YjYNDGspT9E?=
 =?us-ascii?Q?BVaYcGHE+rGf4Bbc734JU+aBmzmfQc0MBtUFYcSZViVO1nmrE4xWq1PD68x8?=
 =?us-ascii?Q?+RfymkrGoo2k3vocNjq6Re5FmGKhKXH/1YT8/Ymt0xJ6VI9Fn4366/rgSY8S?=
 =?us-ascii?Q?ZQgVP9K0YiA0gguyeg9xjGkkIqPPuKs5Ll7T9cKLvqv8gmBQzepDOKgbiHg6?=
 =?us-ascii?Q?+hgDNE9yQyQeQcs3O1MF+Em1Lgdr7UjdxHaqBms1dtfEVOMH805ryEBtYuFp?=
 =?us-ascii?Q?Bi9dTqaqgsI6K8aIWoPGqi/TNGva+dppBtY0PoqQk1x6gOxGpv3OHms5uIr2?=
 =?us-ascii?Q?zy277c4UzzVpF8IjRV6FELbaA5XlQWX47elojgUuD8Fzbksb422lGpFT4dgy?=
 =?us-ascii?Q?OHgHMlvPPikTbmYEzlO2GFD0d8s5LWIntNQKpbtWFzIR8bqwFM29G8FYw8kt?=
 =?us-ascii?Q?4u4bhgmJInd2jruP+lWcuO0JdQcqJq+rlSux2pv2RneBbFcDX2loj1kUY4rq?=
 =?us-ascii?Q?aY97jTcEhC9cQ8zzXaRTIIJEJDfPA+kYgZG463SWkS+iyQBaMkelubxnHs//?=
 =?us-ascii?Q?eBnurNQRogTOoFgwMhon/DU0XYyuxetXdV1PfRjt2RXCD8MkmcAGy6kmrL3+?=
 =?us-ascii?Q?ZiiN7sUe1q35u/eeN1eXOLbhuvhHMhNGI70gR23fF196e/q/iJmtC5Qrx3g0?=
 =?us-ascii?Q?sSESIJF4GcHohSIC+hsyEugCdLf3Pqa82l6XYTlUS+145KX9USJUiQF9/nc/?=
 =?us-ascii?Q?YasQqKVnuCzeeOp14nW5E4VkyYTuRJXm3rEq9+7yuFMPmaXHDXZJ7sTrTXQN?=
 =?us-ascii?Q?pqw2k8/BR78mLmAsyaZGse59IQkXr+JQEeDT5igD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2211a832-49a5-4542-84e9-08dd75dfc2c7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 14:23:26.4596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bk6hQfpUpya+DMbNcKh1mHZbOj5KBBQCVz/bz9lrlRlZMHfLSXQrvZJf0D9z+Bpv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_072331_407988_2BD295B8 
X-CRM114-Status: GOOD (  10.81  )
X-Mailman-Approved-At: Mon, 14 Apr 2025 01:36:58 -0700
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

On Sun, Apr 06, 2025 at 07:34:30PM +0300, Mike Rapoport wrote:

> It's more than 200 line longer than maple tree if we count the lines.
> My point is both table and xarrays are trying to optimize for an unknown
> goal.

Not unknown, the point of the bitmap scheme is to be memory
deterministic.

You can measure your workload and you can say I need XX MB of memory
to succeed a KHO using bitmaps.

With maple tree you need to both measure your work load, compute a
worst case fragmentation, then say you need YY MB of memory to succeed
the KHO.

Since we are looking only at worst case YY > XX

These are engineered systems, there is limited memory available to the
hypervisor, and every MB is basically accounted for to minimize the
memory requirement.

So every action needs to be worst cased and accounted for in the
hypervisor memory budget.

> As I said, this means an alternative implementation of the memory map and
> free lists, which has been and remains quite fragile.
> So we'd better start with something that does not require that in the
> roadmap.

I think the obvious next step is to use the bitmaps to generate
contiguous ranges to pass into memblock reserve. That will get you
performance equivilent to mapletree and deterministic memory usage.

Jason

