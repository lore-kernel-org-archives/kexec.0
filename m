Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9EEC282EC
	for <kexec@archiver.kernel.org>; Mon, 17 Mar 2025 17:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lufeK9vbnwGEJnYpqZhfpGvzGQh65DFkqZjuzFxgQVY=; b=fw3ThQBLvM3va6rzXyQdqsizkC
	G5JnRXYKsHvPJw+VuweU1FBA96KlD0NaSXcBlRLm7oYRgzyuU8En7iiIQxqEQHTxIGeU7Xc2Hc9Up
	SLFRWeAgMH/bsJhcZqhNbAfCH9bwqABBvhfk3lJOXtEaoaLa75NJ1UqSnzP19bT4jgpf6Hn+B6u2d
	pIlUsWHcpsueohwDlTzGP3b1LtWFKan4pqWC5ivyn+DiHYrl9yRm0GcTJrbkr3xHjilZZ2tHeCnXT
	ogcIKJNa/hmVUrPOj/WN7KFpPQIHchxN7BM91p+Oo9GliU6H9XLtSutTCS7ncfJBX8+8GaKQFS3EX
	0+K8AvkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuEB4-00000003YGN-3gQ0;
	Mon, 17 Mar 2025 17:23:02 +0000
Received: from mail-dm6nam10on20630.outbound.protection.outlook.com ([2a01:111:f403:2413::630] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuEB2-00000003YEg-0Byd
	for kexec@lists.infradead.org;
	Mon, 17 Mar 2025 17:23:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laVHAZ7jBqyymvGL3vYLHqQiDvE51BOqDC8tIAnDSja1kVJ/CmDUUP8CkJhe1PooVKJeBrAaN8EOW+Louqt7BoQiRlVT4UQWM+2zr65FCUvyqxsgNCL8DIDNtHGtxxptP5533hCJqaI1il6TQ4njuRF3cNqiglDidYqIsrTECUU9qFwGzu7hB+0ZK/+7C7QUU1+JOWEHJ3aCjfjJaP6wapSsHucY6t3dXgHWjSi9ySnr06HsUhGGD9RaHGrHWxXgNeWTNCYSxD5yJzzU473H9EUE8wD2VHv9/cRGmCYIJyaKme0KHo4DnvxEuQkF/uvSMP52c6fIG0E/S4P8LjSNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lufeK9vbnwGEJnYpqZhfpGvzGQh65DFkqZjuzFxgQVY=;
 b=OTPw45TneKBetRCOj2xC8FZsJ67qKp8ZEJCpoRzriELUPow5WHhBHm+pbeMiN6sp425RNDKLFEpjjyopNzXJtifJ4DGq+jLXVGbTPRDOfA1QlVORuG9Tv2sxunJPcaSKe9uLPxh4ltO4BD5N/MdJlcB9FlDwPdGH+kGClreH2YrFgheeB+dEl3f6+bS37yipV8/sMocrXdGWR0Kj3avGbOogMap7Ng5Ry6h6Zui7OGRRp3ZyOFFb5z40QMDKg/K5cc5w4b8P9Y0plS5MB/HLuNqYsmAmoHTYsninrnpLzr1MiS5hRf5DWmwbdCj8RaYsO6TvMZ1yE2U9GYeiIMkMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lufeK9vbnwGEJnYpqZhfpGvzGQh65DFkqZjuzFxgQVY=;
 b=rJF995La16OPJ8gTk9a0nLdG5MrWS7I3ijv8hw3JxfpfbpULPTi/Xx9bkzTlF9em7RLfuaeaHtHs8dYHM415daX1AP/mvKx3/PmVPdqPT6eLK3H6DIEUV9riBtT54U0dZ7T48psvse2MkBtxO/8fz3Q2LgpuriVd0eL/wsX6KD8n0uZNFIdgozHT9Ce+acgA73eJPRBuc00nXNevnvw7tAHOK9UKHAg2uzfWsrVoXefZauUWtGLoxo8/2SmR/PYBAx+VFxA6K6GzHLv4Zy8wDq/lJK46GMkq8Hw0Td0dGcJNujrFwsfI6CYgJkTP7V5JROZG9yl60iaUmFY8/iPO6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:22:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:22:56 +0000
Date: Mon, 17 Mar 2025 14:22:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Rientjes <rientjes@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Frank van der Linden <fvdl@google.com>,
	James Gowans <jgowans@amazon.com>,
	Junaid Shahid <junaids@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Pasha Tatashin <tatashin@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Vipin Sharma <vipinsh@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>, linux-mm@kvack.org,
	kexec@lists.infradead.org
Subject: Re: [Hypervisor Live Update] Notes from March 10, 2025
Message-ID: <20250317172255.GO9311@nvidia.com>
References: <a350f3e5-e764-4ba6-f871-da7252f314da@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a350f3e5-e764-4ba6-f871-da7252f314da@google.com>
X-ClientProxiedBy: MN0P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8f569d-7809-4424-5c64-08dd65785b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?duGSdK4Z1qW6NcOhTACShZCM6zj3cWDeyBoApJbnR8iZPSI9jN0pdHwiLSHC?=
 =?us-ascii?Q?1Mc6iJQrKA0OqW6kx9dFYaAcLwZp/CofM3pv+bR/3uv3pwnw52Zyu0Pa/T8r?=
 =?us-ascii?Q?tjhm2T7egBe3GFwlIGrBdofAdtC6F2qMtT3AvNzhjsXlRwG0tzsHFoFPK1v0?=
 =?us-ascii?Q?BgVZ1vbXlDSVfKj8Rb9dqZVh0gSAL1sXnkoxaEVnbLSo947xbmPUMlzqhnM0?=
 =?us-ascii?Q?kxAgu/KR9+3rkNz4atMywr7pLkSrmWMqWOtyoEThbjUzELKju0G2EorS8rF/?=
 =?us-ascii?Q?rIIB2BfChs1/5zGCSdlbrmVkpunjJXXKPALfkx0F+YZAy1JCOKLjl7tnUzxt?=
 =?us-ascii?Q?PiUoeSWw1qrCN+ut5Mlb9lYvAzxb9W0iwb/prP6wW1TKZgPAPbCuOxKFKDrG?=
 =?us-ascii?Q?KZR7SBGwpgvx6ldZDniTPHeSKlPvyk43HyEFwHLkwuQ6U4qxrKDoFx6ijvNx?=
 =?us-ascii?Q?WPqMi3VSBQ8jf8tXiw4W5vqpzqcBsyZGbwsdzDJDjbWJLA6e7wVYv9TUNyxQ?=
 =?us-ascii?Q?MSjXmQcz2+jP5WcBmVUy+KXIghRiOpi1cd2vkpVlqCBpAZqtSxrATE/f4wjU?=
 =?us-ascii?Q?g9lxL3XCxLW7RrNE9u/7zGKN6tSu320PzfPocBnxTusycWYJFYYsJCde11JW?=
 =?us-ascii?Q?CqifyWSAgH7lGgZwNFORTmSlz77/dY/EMY27Xz9rt3AUPIb72jHVL/yi+33X?=
 =?us-ascii?Q?q0hqnvrPAhwS0XFeJyrvzbK72cnUaFwYn0cC1Aw/4p8OdP/+hdaH+YyVgXcC?=
 =?us-ascii?Q?ERbnNNk9ImQIt9mTG+J5eTld8KossgHTPpuz2jiYlybKfhnK75E4aAQS6six?=
 =?us-ascii?Q?6Bg3e1zFks0NvO63NyY/NMwXYK474oZO2XP4jDfPNrz9ypVTZxdVUzqXeSBy?=
 =?us-ascii?Q?BsEK4k3cYC6geG9HH1AfgupAMKS67y0NifzUIk0dizpr28uHUVram0qEFIB3?=
 =?us-ascii?Q?+r062uYgViCRhyv6gAgxtNMK80rWkgiUmkt8bL68vYmJ77NisGoaymd9PQqn?=
 =?us-ascii?Q?gXZLluyWdwTp40x+fHI5R1B+YANmY/3uJU6QJuyIt745gFokctyBnRo4MCTx?=
 =?us-ascii?Q?emEgEzyl+wJfnXz/z2jNhs2bTrh/zm15q6PFvRR1XXZPkn5Sv6O+kpwjMS/W?=
 =?us-ascii?Q?0aialFoEhuA0nspIVGEpdCecVhitUSOuMysuG/B5jvBGBvUOITTrEyqu6Ann?=
 =?us-ascii?Q?l6KRCyTlLQjkwOI/sehoByUWWuBX+jqLS/605R50MF3rbYCNlyXTPOHwjLoY?=
 =?us-ascii?Q?gXqwkQS20mZ54WG6wHZedfgzX51EbQWvo6Bu+EnWaobDnMhpXtaSEa+iJ40u?=
 =?us-ascii?Q?604HlobUVvoiz669Pe+XE8fJlvT/wrreZUUjOnWnf9v1wtF2zKuDxnJSVmqy?=
 =?us-ascii?Q?5Uusur0bw1w1W3LIJk2t8Y3A994T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8jkFOMsZ3KC06V64Abz2/jH6/r6S9V8UZ2D/SiM5Yj4Rvgv+LSeSJ47bdixZ?=
 =?us-ascii?Q?RH91bRHfY3R21OFZCQ04qgJpJO3ou9Np3elgH+L0HHknJ/3J9j0Szzedsad4?=
 =?us-ascii?Q?eCz11Ah4zpLDdqNjNqveAmeCvtLO/42vG+7mOeGHWNTMlDYz7aGXqv6X8BlG?=
 =?us-ascii?Q?1FZ/1gqHeDAYJ3eOPiHjJbc+VRQgtXSFgvecU40IGsb2KDw0gN6AhggBde88?=
 =?us-ascii?Q?CTWHTkWy5iEVCoBANpb+uxYAsf5CR0WaxI3Xz8syVc4upKzLt0lQUbN6oa/O?=
 =?us-ascii?Q?gz42xOiW492QP/eC46JfTi3YTsq0xw6ZxpiUQ6CtsGuagrhNhndvVYOOYkU5?=
 =?us-ascii?Q?bdSJuWFMJ1AcJTQFt0OPDwPGV6rVIfJ2MOujxXGjVAhdoE1t4GLU09HUlAGR?=
 =?us-ascii?Q?94r7EzQsUosn+4vXXAY1MGvtz0j4iIJobksX3UaMFyZBdzI4EkaYxlpEKQiS?=
 =?us-ascii?Q?UqUoS6ykhRosRwv75wuP15ceKXFpg0nMMyE1pDSx+pl2LEJV1WuSplAoswSQ?=
 =?us-ascii?Q?uypoRtd0jv9Xmqu6cIXe3He6dLy4OBWFpIok7Q4OCv3lCnMsttGomSLao63B?=
 =?us-ascii?Q?9+VuHQ3vwRfqvaL/L+IukEWzyHJPmrD16RS+VItslLqPSgC2LTkrO1IXZM8m?=
 =?us-ascii?Q?2CHBayPut4Stkpb4SWfRU6AaxtCodLpdOeom6l3gyOkpj+6yJS4pmMxsyr/6?=
 =?us-ascii?Q?qeWKIcppzYAEh/92Map+/qLpPLBMjw3fqg3WKMD67yJNH4IramelOLGAP5Ej?=
 =?us-ascii?Q?Sehp6t85PzIJBtXBL35xplxN4uB7QVHaCpZbFAVJZsTd4Z6t/4HCWUyeFhR5?=
 =?us-ascii?Q?+jQ4wIlCwtNiFVXnjAwZr3dCfgUuztNYDKs0LIWwIxZnBMbZihXnguxAcVkP?=
 =?us-ascii?Q?fL21wIDxZBalzZz9NsOxrNiOhlBmzs3+/VoBJisDLkpETjqnN2LmL1xbJGNP?=
 =?us-ascii?Q?yzzl7XuyQ0UdhBGkaX2a+jQDG/NKiLM/lRVoQ8/svpgCEA7LugGD+6U9iveL?=
 =?us-ascii?Q?TqOxDdIUM48HOYH7APgLZaJ6Fd14bYsgJykRApXaJgmJQDgHFFVf0ZaFvZd7?=
 =?us-ascii?Q?Hp/QMNDOXksaHOFdExnA1gVZ8tF58k5WCzvgkAGuc338pCpp8uj6UWbxi62s?=
 =?us-ascii?Q?SOpFDAHpN9zlGXQafsn/poRttZs31XCn9Fe5ETBVthqTTN/KRMwqTACRUndd?=
 =?us-ascii?Q?ZexWiVf9AmhWRHi9X8l28HIXMbyzVUhYEK6tTJeGyoIIn45ch/ZSkFK35J8u?=
 =?us-ascii?Q?sRF5cMkugOC3kehFm6+zjRTjdxi40kyPNa5r+Sq7Lj/xuZwzxITa5yzod2PW?=
 =?us-ascii?Q?45VDL+LMhzjLrrQAhkmsxF7ST2lavBuLEhAFEC6Lszs487qUyBfhiMNu5zdb?=
 =?us-ascii?Q?bVjR6NnyjCeOeGmtfNDvRReGn6GaIN19l87KtDCwRwEQtC+86oCoaI5N6wvm?=
 =?us-ascii?Q?lTQyVvgJMV+QVG1UlCYR2sK7UqKxkZz66xZRBOufr8xwOt3IpKF4PZZHfgpG?=
 =?us-ascii?Q?oeDxFCDXkCF26t8TdM7vaIZNJPqB7JUHu3Oj2MyYRkZKb6GeNQ8R0VQciuIR?=
 =?us-ascii?Q?8TvThLabXd06WsORf9bOoYA/prAw6VEZkV5TjFoD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8f569d-7809-4424-5c64-08dd65785b4e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:22:56.1046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvQj4Xni6l6SDRZSi79GH3di7Y3obHBj4K9LYkmt1A7C5QOLeMDGjJBu705OPt0P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_102300_085964_AF09D705 
X-CRM114-Status: GOOD (  24.48  )
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

On Sun, Mar 16, 2025 at 08:52:43PM -0700, David Rientjes wrote:

> Pasha asked how drivers would know if reservations would be denied in the
> first 4GB of memory.  Mike said an error code would be returned.  Pasha
> was specific about devices that wanted to preserve the memory because
> they knew DMA would be on-going during the reboot.  This became a more
> general question: what devices should we support for KHO and what should
> we not (what is considered too legacy?).  In the meantime, Pratyush
> suggested explicit checks for this.

IMHO supports DMA to all memory, and doesn't require swiotlb seem like
reasonable starting points for device capability.

If you can't start swiotlb later, after the buddy allocator, maybe
just make it KConfig conflicting with KHO?

You could probably also preserve the swiotlb memory across the kexec
to bootstrap it, but why? It should never be used on modern HW..

> Pratyush noted there was no way to preserve folio orders in KHO and he
> also noted there was a need for page flags.

I think the xarray idea will preserve folio orders, that was a big
point of it.

Not clear why we'd need to preserve page flags. The same page flags
may not even exist in the new kernel? New kernel should set the page
flags correctly based on what it is doing. Shouldn't, say, memfd know
exactly what it's page flags should be in the new kernel when adopting
the memory?

> Pasha asked how cgroups would be handled, but there was no current
> support for that.  Pratyush said the current RFC focused on anon memfd
> and has not yet looked at hugetlb.  Pasha emphasized the importance of
> focusing on one type of memory to start.

I'd say userspace should deal with this. It should de-serialize the FD
within the context of the cgroup it wants to charge that FD too, and
the de-serializing process should charge that cgroups accounting with
whatever is restored inside the FD.

Is that possible?

> Andrey had recently sent another patch series for KSTATE[3] that was
> discussed, now in v2, which was closer to being a formal submission
> rather than an RFC.  He noted his concern with KHO was how hard it was to
> write serialization code.  His goal was to give drivers the ability to
> migrate structs across kexec which could be more elegant (see the
> struct kstate_description).  

I think we will have structs, I think most things will be structs. The
KHO just gives a small FDT area to keep track of the top level struct
pointers in a more understandable and auditable way.

> Mike suggested on top of KHO we have FDT, then what Pasha is proposing
> for dynamic tree on top of that, then perhaps kstate on top of that.  He
> would need to look more into kstate.

This makes sense to me. I think the FDT should be the first layer, and
then we can go item by item and decide the best serialization to use,
always starting from the FDT.

At worst the FD is just an expensive way to store a pointer to a
struct.

If we determine at the end that the FDT is predominantly used for very
simple struct things then maybe it gets replaced..

Regards,
Jason

