Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8168103E195
	for <kexec@archiver.kernel.org>; Wed, 18 Mar 2026 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zCozF4TumMwOms9OqQxOoUEHlGbfrZtREKPghz2vWDc=; b=NC/H7WEf7mPsQcAjdLYXAGpJYU
	ms/ySLq+egHZLRWdCJwIcp5kPk/V/ElElmDXI5kqHP8W9gRL853ajfnOl6KeU6V/07zE5YB+52cal
	sQ8875w+geomp/+AVDz6ifcn58yg4nzUIoJyHi2cJC+gAXUxyDfPTNaTaLWNKO2eFath6go15rH5Y
	OS8yUPZ6sAdNsKMWdcsRlKj1I8vqs3hqb+DVm2RCScy8mF/e3Z7qbUPlshRqHCTmVK/virKn7SuRe
	U2vgNMmkY2xOtdnUCJ/1DNs/+EMpP2lnXEOmPQlaftrXh+mvjOWl1TU7/lrQwRHBKEnl6BXIhgO0a
	gbOgY7KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2sXx-00000008f6O-3EMl;
	Wed, 18 Mar 2026 15:10:57 +0000
Received: from mail-westus2azon11010021.outbound.protection.outlook.com ([52.101.46.21] helo=CO1PR03CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2sXv-00000008f5z-1yId
	for kexec@lists.infradead.org;
	Wed, 18 Mar 2026 15:10:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnnzoC1CmUfy7lObUXm5gXrw+wu0qTkIwwrQxtqlI2ZYXU1dZPbWt7mbaDjUKz1G8KyNYQt6m2ptHGLYNKHh6yuqJbcL8if1g4+qHp5b5khS36kkj5D21TtgEbpYdhakNJiFXvcCWh4wNMjp+DTQUEImNBBdBY1YVGbE4Y94pbGq0A7FcF4bkBolSYnx7SsG69zbJ4rjayObXc9NoHmBIlhngTqR+woO6DLui6o96ehHrT4k5lsxUdqn91w2CJZ1QbswMG6hcpB6qEaynC1he817qtomMK7h37iKX50tYle9oDz3bBaCwEdEZd6Vwx+GVMrQQlAzt++UNLOg0MY4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCozF4TumMwOms9OqQxOoUEHlGbfrZtREKPghz2vWDc=;
 b=poqTfbW/365BwJPFUa20Vk7UWJVweEl6BLthsH3VAw0kvrfsGYng4G98GOrI85Xh/HEGm399oRWqeobUSp0gsAx1l4qoECgVd+ZP5EgohgAQKtpi0bzWcCr64LZb4cS7hIeNvFKFTYSMVnaIVzxDcWB2DcM0x0YtdNH3EPmPMNO5r7ipYNBA7U99wPxS67QDiji/NQjUANouGc7XwZD4pewf36KtQywikeOU3wnku8itbbRwYN76TsCT0bAbJHtGzK+9eLY9IpynopQM4XfHOtT6B051kAaSU3hPrQu2NHb1BbCycreVGibiUewjqtKNq59v22dsgRmOZxGCS4pKCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCozF4TumMwOms9OqQxOoUEHlGbfrZtREKPghz2vWDc=;
 b=X8b92VU0g9AUhRy2o2c9YhOWQJH+lfQwbscVo6lyVdtQp/JPULrYOnBrbQA3D4pFEx5mSkZr5DtTh4PX+t9SDXY4QHoTCZtZo93tnj8gLA4APusVj0RSp5XIUOXDcmRIjvUF/pOpdMaD+D69Uw6yptcyNsLjT5+h+nOP9+pp7ibSBgv67FPOcHqFilXVBOeuiwWMUep1m9dJ2j5nxsIY2WMrTxcy5n3UsUhDqvI1KGaoYFhzB0AKUHX/GfvZNFRqrblN2EopQHSmWYcjUHrYQpkFWd3ZEbf+YA3khzZmaIfLW6/bzHCp9K8W6yNKb/OKZzz6D3skwX5QVx0x0VwGGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 15:10:47 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 15:10:39 +0000
From: Zi Yan <ziy@nvidia.com>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>,
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>,
 Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 2/3] kho: fix deferred init of kho scratch
Date: Wed, 18 Mar 2026 11:10:34 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <AD9E1B18-C813-480E-894C-FEEB51EE8A93@nvidia.com>
In-Reply-To: <20260317141534.815634-3-mclapinski@google.com>
References: <20260317141534.815634-1-mclapinski@google.com>
 <20260317141534.815634-3-mclapinski@google.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b08ea5-92e4-435a-ad74-08de85008418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: M6O0qj+iauFbiOYhFz7Dg9jBaywA+qzZMWjnRPpe6n4zGUlCnM0Ev2dJNHwDob1EaGGqMYb0PtXySR+/83tS1iOEePj3or4bFLuzbo9BoTKu7XZUVTtMpkzRBMZW0d6dyVO3lSq2C52zYRr5sY0MTlCWusag8WwSmDkcULouHJnybt/VoLxO69cgEvdXQMnUZid7lVFZqU5P5QB/HtZSB1KwFdtacC5VH0qgSLd/RTSxUTlupRkHzn17hagspw95IdMqFPx5oH+i6gGV0+l6SQZN0BjDLle8pLKZZWX4P4KqjbK96VEgrjXpp7ftI6v18/ne+QuMHmwB2AMQJ+z8a9ZJcQUpBtTwZ1Fl8+uwhOIFuUf3feI1jxbe8Dche0rmA5aqdteyHfTLIVtSSkLYmHmWO5Kq1AYsU/ApMCY5f6+7dU9x6aIVapav6QH/0/b7LkldVOeRnlgDOe66lI1suDIo1lm/EOjp8rlX01E6ALzjSnUFgcXE+UO1th0WweZvH0Fo7L6DoMjThjf8AOdypm35OFOkk6uGLpuT6/4d/I4glL8MdQd2b+zlbLzjWcn988JRleBhotbEUR6ivGGD6C1XWrCsrj49YVlq2RTZMr4QCJojFQC8CgKleuqlLeIPDtHkcox4dLawIEu47gpYFSZL+6HE5l8uguHD2p9GbmYYGjQc1qnbvUgDNLIJKNoqSmKfmVuCoS0/SmHWmuqauE0DyJtfEwxH9NAGl7vFdpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1M3TrqRS1gYHgAzfVEw8AVHKmQ2qkkHEO9SSmTE967jnmEuWf/8HSQQCWmWw?=
 =?us-ascii?Q?p0g1Ofsk5kes8tho8A/DKO2ZO9G+M5KGEEU1XEvlysicnkSWR9tmNIpPykKF?=
 =?us-ascii?Q?IbUGCucw5dWevQc+MwZ9FwECZIhgodjYa4y/U67CJCmLdYGbezCYldcr/cSS?=
 =?us-ascii?Q?GXnJygvGNFHRxHC5Tgk5jAGEKDDO2rgLPllgxveeBZu+FaoM+p6TjB51WmkW?=
 =?us-ascii?Q?mCSdjTlN6664EIhRlhqE2Ilb4XCSDpLlirIIKKsLCZrUEgLWyA8RnbRf6Aw3?=
 =?us-ascii?Q?Lwj4y9N79PU9L9Q59JpWJGSrDmpvtSm4mS7R8h1AwXOcAREcl2pTVmE34HZS?=
 =?us-ascii?Q?Ihqr08fNjl6Fz4R26svFBizs5jwgjyfZ9d1iFx86SqQSOZ0YjnQfo55H1JtG?=
 =?us-ascii?Q?bZ8QzGMwB7lgG3wtXzrw2Vm0KfTeozInhxszXmp2MJ4x9wfwAKAyGrLsHiNn?=
 =?us-ascii?Q?2Ym1Fga5RGSkCwZaWu9hbmAcxnP+jOHFG2QLriYde2wlhskzmqa1xNznYtOK?=
 =?us-ascii?Q?6NX+D2E/2NUWhhaw01UogrsobQUGs5uLbRZzX400NkdiPXo1MmHWpUWkt5rQ?=
 =?us-ascii?Q?x0FKT9PDP2hUvpX/hFzTG9LGYlUVZz7hznFdP29eU73qXxXTb1eKAr3a93z7?=
 =?us-ascii?Q?eZc5NZlJC702Co3dIyIESNnHrQuX6VM+xrfUbvq2//kRoUg9+r1XMikD6UuV?=
 =?us-ascii?Q?5lX7/0iI5Cl75E9bQt5KyQZwcoPFa24uJhEtMPXg6ZLKcCKNcIpkBjIjnSvm?=
 =?us-ascii?Q?b2YVW18Gf3OTwg3Y2JYMo9tJ30Y+xb0G6CC4/stLZ//9eogCz5Er+QqaFh9k?=
 =?us-ascii?Q?N23fFGZ94fYcze46rJEz/V3pAPTlEzK3ZHaTsn8ueTuaYzIpepsDtmkPKoPw?=
 =?us-ascii?Q?hnQroH978+X4ysY6dKsNeEH0JfnMJKx189lxqJOKW5S+xOsT25CUAVN6arzR?=
 =?us-ascii?Q?5EEUnzkyZ+fcV8b1af/NZ9eyi7xtUwc544iSp1tstoSmW3pZaL9hXZscAsfX?=
 =?us-ascii?Q?AzD/KfJq6tpdB1Lnu7odRN4CZc+2PojiweJYsxnu30NbHXzFsPJrY7BDsShN?=
 =?us-ascii?Q?MaHVREkt2yXuaQJw9MG3fNNOBQhtwEv+LRGsVkfdEeSFT8dBzgwdl8hmaTDy?=
 =?us-ascii?Q?I0SjlFxGARKs8Y7Y1r39BxQKjhC7MCQm4K8bFcQYzCA9feF6sMFnRP+7+XpI?=
 =?us-ascii?Q?084MlKiEqOm0lGqCUJ4SxnPfUAbAZhNoz4iSpry2NxAvdBuQfWD9d7/wBH0z?=
 =?us-ascii?Q?Rx2AcvYWYeemf3RPikaQoTOn0cpnp5dmkPP51fyE70ty492WalRMfZwyPxsZ?=
 =?us-ascii?Q?puQYvD0Y2Z6fKXwzw4KdnuM6rxelVtOZdowr4G8a9J7MZjwmq6KWl6orCPDC?=
 =?us-ascii?Q?Ke0IP9uarJQd8ShEE/o7RttCDo2pl6Qaj8GMm10DWjk8IAR2XIkDHhz0dHaG?=
 =?us-ascii?Q?rDC+U/c0CGw81Wy5JLovNUvw7SdKmQZdFWAQ+Yqu8edrjhpLPbKoKU6vFTOZ?=
 =?us-ascii?Q?+rsHBYLz0nf45Y0bOZWQrqFUqjmfeNgmQS8jkIUL/M1FcYHd1w6rgR0+1MEj?=
 =?us-ascii?Q?+GoGuR88NXOwRWqpW5HV8hpqbMQQjU9UxEJmrj+C2PzV2e5nUxJXMyDTdRsL?=
 =?us-ascii?Q?hZktjm98WzRF9tOHxo6EeB0iyGx0s1lh28pwiYpX1GbE/87wrG5pxGikTMRm?=
 =?us-ascii?Q?kVnpyjpWUwodk3KlO6frIjHoBIKUnxA7hflUn94k9lY1RZGo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b08ea5-92e4-435a-ad74-08de85008418
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 15:10:39.7326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHcEhYH2tV7gSsiZLDhZH0PlUEiv4td9Yt+fVeRJtH+GNmNcjmNPyFezhyy74/6h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_081055_716201_9DAE6B8B 
X-CRM114-Status: GOOD (  16.28  )
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

On 17 Mar 2026, at 10:15, Michal Clapinski wrote:

> Currently, if DEFERRED is enabled, kho_release_scratch will initialize
> the struct pages and set migratetype of kho scratch. Unless the whole
> scratch fit below first_deferred_pfn, some of that will be overwritten
> either by deferred_init_pages or memmap_init_reserved_pages.
>
> To fix it, I modified kho_release_scratch to only set the migratetype
> on already initialized pages. Then, modified init_pageblock_migratetype
> to set the migratetype to CMA if the page is located inside scratch.
>
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
>  include/linux/memblock.h           |  2 --
>  kernel/liveupdate/kexec_handover.c | 10 ++++++----
>  mm/memblock.c                      | 22 ----------------------
>  mm/page_alloc.c                    |  7 +++++++
>  4 files changed, 13 insertions(+), 28 deletions(-)
>

<snip>

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ee81f5c67c18..5ca078dde61d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -55,6 +55,7 @@
>  #include <linux/cacheinfo.h>
>  #include <linux/pgalloc_tag.h>
>  #include <linux/mmzone_lock.h>
> +#include <linux/kexec_handover.h>
>  #include <asm/div64.h>
>  #include "internal.h"
>  #include "shuffle.h"
> @@ -549,6 +550,12 @@ void __meminit init_pageblock_migratetype(struct page *page,
>  		     migratetype < MIGRATE_PCPTYPES))
>  		migratetype = MIGRATE_UNMOVABLE;
>
> +	/*
> +	 * Mark KHO scratch as CMA so no unmovable allocations are made there.
> +	 */
> +	if (unlikely(kho_scratch_overlap(page_to_phys(page), PAGE_SIZE)))
> +		migratetype = MIGRATE_CMA;
> +

If this is only for deferred init code, why not put it in deferred_free_pages()?
Otherwise, all init_pageblock_migratetype() callers need to pay the penalty
of traversing kho_scratch array.


>  	flags = migratetype;
>
>  #ifdef CONFIG_MEMORY_ISOLATION



Best Regards,
Yan, Zi

