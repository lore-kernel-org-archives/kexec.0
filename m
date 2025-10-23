Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CA5CCD1BC
	for <kexec@archiver.kernel.org>; Thu, 23 Oct 2025 17:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l1k7/kujl99Lp1MdZKXJk0F8jnevQm/c8MuDcG1M+jE=; b=WEhusWPYv8teybgt9PQLUQz90x
	DbnqwiuBF8NVtET2WJ/olk7bsbm/5pS5bsC/BKKyEGPQZpcUwq+hH5Kl0doqChP1yLKRZCgGlS5mD
	WEWf7CZdQ6NnEomq9kbuuY8POe/vUdlekufj2fexAlBichnCGzVM3bjlcJmt6Ep7Lh7vt/5R+jaJw
	YAL6nzYTWlsrCtIuRLjktC9w9aAzmB9k6XjS8FrZS8mhbNgFRIIsMKiox5lOH+QUEj4z6t7gAqj5W
	z1JWlVihoRvxsIfyZeqaufQ1db5vmkVXf/BOwCyvW/9zwEnRXi1I4LGT8boG+vYqZ2Tde1qAyiMfX
	SI97fLgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBzLZ-000000076bL-2cDB;
	Thu, 23 Oct 2025 17:43:34 +0000
Received: from mail-southcentralusazon11013006.outbound.protection.outlook.com ([40.93.196.6] helo=SA9PR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBzLU-000000076aI-0BGo
	for kexec@lists.infradead.org;
	Thu, 23 Oct 2025 17:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNefiWHiPTPTDBS+FKnp1uaSJeqfjbRVJkjUWKBATwHj5DZm1VEuGdI09zRq+yADjasln+O7Wm3pNyzQ004AxboKJhmGTGhfeBp2cC688gsX0XXft6NlwwNo/IVYcn05m5erNR6/JfkyIa3q8pgSs5y5iLjykMnFhwhlPt5h+batMjJucN8g5bzVgnJXWib2Da8zaQPNFZEfKgrailnUQEHPA1KSMto2B74+9CNIiPeSe7IDjAc9EWxmVqUZgHvay5Z19Z+zNn1BQNxd3c6Wos4CX+Cyzmm3/PyXOoP6rtgelGPLiaM2WGHy7BRrNLPLMjltCAQXytp6IGIhz/WVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1k7/kujl99Lp1MdZKXJk0F8jnevQm/c8MuDcG1M+jE=;
 b=qrU7kH+UI2UaGwaN/GTDUzRMTBoUtQOR5+lKRHMV/OOy4oDb6BiYFGieUL9Q3jmR4EtYA/b6G0CGOgI5yuALbGxflsp0BThY9ERWGjstZQKaJTr1H9ztu9FUfV+hu0HwOTioijkV7tIU5dxVQtKgdsBIFpARU9xQF1VRxCKu3bqu5JD6x+RgkLxxpz60Jpu9QyvbPNcXGgeQdoVaR6IeeW9X0Wkl6nd4MWXJ+ghwjAubKUSOLxbLa+gH3bVgIV2dm5f/Ck+6YyQqu+IvkKq6rlGp/2lD3lw9Hw+hoLGEncfHv8VTLZJFqULGEp9i1lbBupjoi3Yd9jz6dDDE1RwqrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1k7/kujl99Lp1MdZKXJk0F8jnevQm/c8MuDcG1M+jE=;
 b=Gh7SyhYmStbS9eEtaL3BcMZCv4oGDzajFBdX69iDd5aSM/6qZJfAZYHcX2xEjK8QyiJhm4KQY5GlojThVRxmMsAoAiyWmmJXHXZ8xkxpTpGNtQH5I/b9M64vCkQ47iTMMxcZp3NzRPT4+42j6FuF7+0yrwjznoG3SVg/N39HL3h7D8pXnLDGWhy3yKh9UPA4qPTnCXEXOf204kyAUPEroKTnjKSxwO4TLDuYq4ffWSXmT4xIafHixX8kam5z/qO6KS4sGvJhmFCL82mw/yX5wU3f7ziICCJD5ZhfQNzNldGPorQ7kV86yFDjQ7FI92obi8VUCQaKDFDmu7Co8NBprA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 17:43:21 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 17:43:20 +0000
Date: Thu, 23 Oct 2025 14:43:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] kho: Adopt KHO radix tree data structures
Message-ID: <20251023174317.GO262900@nvidia.com>
References: <20251020100306.2709352-1-jasonmiu@google.com>
 <20251020100306.2709352-2-jasonmiu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020100306.2709352-2-jasonmiu@google.com>
X-ClientProxiedBy: SJ0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::35) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cce2de4-567e-4ea6-b82c-08de125ba7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VP/4nMClekIWlqvgogXStF62J0hmzMlK3+t+6DF78bOUwYMwjgJd6d7Xtcbq?=
 =?us-ascii?Q?TGNmDeLt5Rfr5NQhMErKipDShB4dZ3VBUjukMD0b+N4TpBUoKnuadU9Bewie?=
 =?us-ascii?Q?xwXyXYl720lO12nUE6DNg1OOr5HUT56uYO5q6YkuM5rDym1MWMOETG/yDOZb?=
 =?us-ascii?Q?pFuMTpLZbjowxNvrGQyF3u+XvxteJPR5qYBT4oELX6BA+ouG7QPvDDYIdem9?=
 =?us-ascii?Q?DNyH2QIqKfR+H6wshcVpwRSpyxB961QjDxE/4s7BbCSKUFNkN3lcFMpWgzmj?=
 =?us-ascii?Q?PKnFtKn1YbDK57KFRmmB4FRmEK8eI6a+XykC9DTCVC9tfE3MDgTYlvK85zzr?=
 =?us-ascii?Q?mQvbsxC8ikkXHriJQevW8W+Yl61fhNlVT2XVHMbDyBIE0yWlCyIr/sQGHIYG?=
 =?us-ascii?Q?uiI3s0vpiI1d7tyVeBzK0tGEr6dDwJcpMq6QcTdH5RHD1mexOzQuDw4DUj0c?=
 =?us-ascii?Q?IbcyhPqyvsrn8yDe/cZ6j12o24/9CoZomyfIs1AubcJofltML0rZeDt6irVT?=
 =?us-ascii?Q?dkW/wvE8ZVCBTAfNjFoB7YS6sJ0IjkH4LskCr38lIVXziUq52TjJ9pQiLM/4?=
 =?us-ascii?Q?FNGTCoFQ2UdStRaGEpLjZjtKEHTlEmwzH+dDyh8WAHBCZ3oPDZK18cOrfHmc?=
 =?us-ascii?Q?9zEbJZ0pTX6Zn/VYePYYaWr3B++T0M4Bele8iKiFNpJrqA/zKduOwIKpZMUe?=
 =?us-ascii?Q?aSMQWvoCoUQ0XzB99mtdbdjeGst1JMYc7EQUPqGL90Mrj6G/zdCq+sXLeerj?=
 =?us-ascii?Q?SeA3zI9VvgJ6IPz5bjY4FitAEY5bfOLNcUAlrTYGTxP6kFMoT9Dg1+aOXMJr?=
 =?us-ascii?Q?Bu7Vk4d6kP7QwWVO+khtyKsZsUc1vidPRwrpf20ykn4RqDue0X8gT0Dql9Wj?=
 =?us-ascii?Q?pucmI0XT0oAde/PYqoQyuMmRnJcb5xo+LMdQx83Nu6/aAEoEUYvCAAQ5ewMY?=
 =?us-ascii?Q?FWOJtyGz315mlZazagL50CjTlDcEaKsnZpP4qyDJW6IvAlzqSauZLo825tfo?=
 =?us-ascii?Q?r4LI5Xz1etFIvXusjYViYMicNmrJy4Jz7RGU2zzBKgRry2i9avnuudqn23Ox?=
 =?us-ascii?Q?I7vC5PLSkJTqKVGakxJAqeO38vhM1u0OYQY9QdvWqaISrOcl6KhpF2mum0Zh?=
 =?us-ascii?Q?cIPDmc7TKgF+o3PPOZbi43wTXgSe2LmLq8GVxrw0TissOdfYya40GUVyTebe?=
 =?us-ascii?Q?hc0lS8v1V/J8qe19fTBQYm1HTCAqocCtJV5r4AK+8PUlEP1jQ91wk63v4gGk?=
 =?us-ascii?Q?sepVGXAo2u9suvgr0GocSi3D8iNZbU7Tfss/eIYLj8MPYovTsmJLnux7K05/?=
 =?us-ascii?Q?cu+Qzq/6QPxSrOVv+emTHeMlz2UcKFt6HJ61ivHMXrqn0BE0A0YwscfIJThW?=
 =?us-ascii?Q?Y0avO/KmZe1m1PsSDH8PpEK6ZkBfn02nYwIMIpZ+asu+SFQrexpPJ+as+VqI?=
 =?us-ascii?Q?FG/G4j3X00fT4eg6GW3AfJ7hry9W2CMN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I37rgXlc6GUS9c0dZNQ3VypaYctCj2Rgn0o4ok9h5OcamFxAj3NZu/o2M1El?=
 =?us-ascii?Q?BjgUJuQs5DOANn+jfW5yDZrpHC9BBL2NQ3ZwjkFYUgRQ83SVmCSTWpvgR7Ds?=
 =?us-ascii?Q?5WMSgFpJHj6tBxG4ETWrEKf+wj5pP1poAmrTI/2Gh7V+ugb9ZGcSKNTrSNg7?=
 =?us-ascii?Q?J2fWOaGq8EQJ1IL0B27sxgz4YZaLlBSl4PdMBHfu4UDEYTxidDHKgDaJM05h?=
 =?us-ascii?Q?yA6Orf0m3Z+rcXjWeAtzsB4d/zmUuQn1p13TOgT6k996sLxjTQ83rpRIq6+X?=
 =?us-ascii?Q?Y/Ca04EJTXYpqHXuma9XgKS/81xZ2TfY7Jov/UNv+cTzhVTjYk829sfxJ/it?=
 =?us-ascii?Q?hIKITKRSnw8VDzm3tAUJCryXapp2oIN6C36eyfqifU1xKd9BoSwpbwEFmwz8?=
 =?us-ascii?Q?9ltIWtGffL5BRKZ/06WZj2cDjy6iqjnQoUPLfUEueVwkyy5TtDbFilK8AmoO?=
 =?us-ascii?Q?ACgvksuUWYTAclPxygYrH39ZdGP+Fm7GNqPGih/QLmOV0vQ9etM1vOyEuQha?=
 =?us-ascii?Q?nVVqpPgXBaHpCNL6u+zyk3lN8ddCI3T8ORHmchmuvPOsexCROwB+SyVUU4N+?=
 =?us-ascii?Q?vNI0eFY2E2dpEPSiGX/CHKqPjWADTJbwjQB0A5qr7JoSJlop3T8lGOqRHOcX?=
 =?us-ascii?Q?Di0CMHQq4JB/Ur/hOyoLD4iEzeKkrv+BVPP14ZXAz2utYxAsBwDh6Z5c53iM?=
 =?us-ascii?Q?nOGrVGSLar+IxxSzeSrJUxsvz2WK1xoGJnnoy1/DUmjZoQrGw37qvFX9hS8c?=
 =?us-ascii?Q?bDRzMxXRnEXRGNfPlVv9jxB29x5UdoYXPJ/Q1RIcFmfJPMmgfM4baFUFm/Hm?=
 =?us-ascii?Q?81X3ALw9w6LHR9kbcT0Sa/aS0jWm9ki8ewgeio72G/99QudYguAoEgcsA0u5?=
 =?us-ascii?Q?xbNF4PFE2388p6wVlmLuGpOn7hnc1fpiC+Z0SRX/sbQFyhfi5Dxw/jfornXQ?=
 =?us-ascii?Q?424mDGouxSMlAN57FSZuZRAfTeCQAHUYDlWfIc5n3P/J+Ds1cOkHdLnH1G0t?=
 =?us-ascii?Q?AhVO5095hcnF80XwoNoguYFnAoPPs8+K09N8hVy5fFBkauLEgEw8BjfbvUot?=
 =?us-ascii?Q?9lpbAuSc8Jzb3jJmHViVV7QsP90F6G9oiLS2581Oc7qRQ7bMD5S2e48596Vw?=
 =?us-ascii?Q?G20mcykVV0/4QV31lKdgqMk2m6qVLVedoMGpEuU5d/Z5d8ozQvZdFKqHmzf9?=
 =?us-ascii?Q?tvbVlBMzF15/ea5ONhlfXrhxQ8BuckpXVBvCLTmOR/++/J4c4QaW24MBbLy8?=
 =?us-ascii?Q?jP/8C9r6CkKPpkJw/V1HzO9qVrQLnIDojP3Ny1D5UZPbICUp/F6lwA2+xUzK?=
 =?us-ascii?Q?ybjSouhoZhGOMEGnZWrm6vgktuIit4gYdii24JP34/5cwbKvVrS5NbkEIyu0?=
 =?us-ascii?Q?ouBle70qH/S1ShZ9l+stVVwBF0fere/9eM2x07f4U6yjLdi9akVuT76CLm5p?=
 =?us-ascii?Q?yIyZUXbSfz3BzBzGnlIDXMB36ulOUv9dVmQHxbyix5N9+N82mfE312jTgLgY?=
 =?us-ascii?Q?aDc02c5/hAdIP4c2rlFf2Q/ig9yqe5lcRGK6xj8LqN/UiHjhlVDA5eIuC8OZ?=
 =?us-ascii?Q?WrMsObTP1w6j8y0MsypP1i9m6lc8HPC3V/4odLZv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cce2de4-567e-4ea6-b82c-08de125ba7c7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 17:43:20.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85QH0WMY5+v/ruqR41x/GKpfha2W9z0cdTiBSrL8G8vJUG7BgQRvzszt4auskHs6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_104329_051360_C16AF237 
X-CRM114-Status: GOOD (  32.98  )
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

On Mon, Oct 20, 2025 at 03:03:04AM -0700, Jason Miu wrote:
> - * Keep track of memory that is to be preserved across KHO.
> + * The KHO radix tree tracks preserved memory pages. It is a hierarchical
> + * structure that starts with a single root `kho_radix_tree`. This single
> + * tree stores pages of all orders.
> + *
> + * This is achieved by encoding the page's physical address and its order into
> + * a single `unsigned long` value. This encoded value is then used to traverse
> + * the tree.
> + *
> + * The tree hierarchy is shown below:
> + *
> + * kho_radix_tree_root
> + * +-------------------+
> + * |     Level 5       | (struct kho_radix_tree)
> + * +-------------------+
> + *   |
> + *   v
> + * +-------------------+
> + * |     Level 4       | (struct kho_radix_tree)
> + * +-------------------+
> + *   |
> + *   | ... (intermediate levels)
> + *   |
> + *   v
> + * +-------------------+
> + * |      Level 0      | (struct kho_bitmap_table)
> + * +-------------------+
>   *
> - * The serializing side uses two levels of xarrays to manage chunks of per-order
> - * 512 byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order of a
> - * 1TB system would fit inside a single 512 byte bitmap. For order 0 allocations
> - * each bitmap will cover 16M of address space. Thus, for 16G of memory at most
> - * 512K of bitmap memory will be needed for order 0.

I think it is valuable to preserve this justification for
bitmaps. There was a lot of debate over bitmaps vs ranges and this is
the advantage of bitmaps. It is a bit subtle..

> +/*
> + * The KHO radix tree tracks preserved pages by encoding a page's physical
> + * address (pa) and its order into a single unsigned long value. This value
> + * is then used to traverse the tree. The encoded value is composed of two
> + * parts: the 'order bits' in the upper part and the 'page offset' in the
> + * lower part.
> + *
> + *   <-- Higher Bits ------------------------------------ Lower Bits -->
> + *  +--------------------------+-----------------------------------------+
> + *  |        Order Bits        |               Page Offset               |
> + *  +--------------------------+-----------------------------------------+
> + *  | ... 0 0 1 0 0 ...        | pa >> (PAGE_SHIFT + order)              |
> + *  +--------------------------+-----------------------------------------+
> + *            ^
> + *            |
> + *  This single '1' bit's position
> + *  uniquely identifies the 'order'.
> + *
> + *
> + * Page Offset:
> + * The 'page offset' is the physical address normalized for its order. It
> + * effectively represents the page offset for the given order.
> + *
> + * Order Bits:
> + * The 'order bits' encode the page order by setting a single bit at a
> + * specific position. The position of this bit itself represents the order.
> + *
> + * For instance, on a 64-bit system with 4KB pages (PAGE_SHIFT = 12), the
> + * maximum range for a page offset (for order 0) is 52 bits (64 - 12). This
> + * offset occupies bits [0-51]. For order 0, the order bit is set at
> + * position 52.
> + *
> + * As the order increases, the number of bits required for the 'page offset'
> + * decreases. For example, order 1 requires one less bit for its page
> + * offset. This allows its order bit to be set at position 51,
> + * i.e. shifting right, without conflicting with the page offset bits.

This description is correct, but the diagram is misleading. Maybe like this:

 *  |0| ... 0 0 0 1          | pa >> (PAGE_SHIFT + 0)              |
 *  |1| ... 0 0 0 0 1        | pa >> (PAGE_SHIFT + 1)              |
 *  |2| ... 0 0 0 0 0 1      | pa >> (PAGE_SHIFT + 2)              |
 [..]


> + *
> + * This design stores pages of all sizes (orders) in a single 6-level table.  It
> + * efficiently shares lower table levels, especially due to common zero top
> + * address bits, allowing a single, efficient algorithm to manage all pages.
> + */
> +enum kho_radix_consts {
> +	/* The bit position of a 0-order page, only supports 64bits system */
> +	ORDER_0_LG2 = 64 - PAGE_SHIFT,
> +	/* Bit number used for each level of tables */
> +	TABLE_SIZE_LG2 = const_ilog2(PAGE_SIZE / sizeof(phys_addr_t)),
> +	/* Bit number used for lowest level of bitmaps */
> +	BITMAP_SIZE_LG2 = PAGE_SHIFT + const_ilog2(BITS_PER_BYTE),

"bit number" is a bit confusing when using a lg2 terms..

        /* Size of the table in kho_radix_tree, in lg2 */
	TABLE_SIZE_LG2 = const_ilog2(PAGE_SIZE / sizeof(phys_addr_t))

	/* Number of bits in the kho_bitmap_table, in lg2 */
	BITMAP_SIZE_LG2 = const_ilog2(BITS_PER_BYTE * PAGE_SIZE)

Then use the constants in the structs:

struct kho_radix_tree {
       phys_addr_t table[1 << TABLE_SIZE_LG2];
};
struct kho_bitmap_table {
       unsigned long bitmaps[(1 << BITMAP_SIZE_LG2) / BITS_PER_LONG];
};

> -struct khoser_mem_chunk;
> +static inline phys_addr_t kho_radix_tree_desc(struct kho_radix_tree *va)
> +{
> +	return (phys_addr_t)virt_to_phys(va);
> +}

virt_to_phys already returns phys_addr_t ?

> +static inline struct kho_radix_tree *kho_radix_tree(phys_addr_t desc)
> +{
> +	return (struct kho_radix_tree *)(phys_to_virt(desc));
> +}

phys_to_virt returns void *, no need for a cast

> +static int kho_radix_set_bitmap(struct kho_bitmap_table *bit_tlb,
> +				unsigned long offset)
> +{
> +	if (!bit_tlb ||
> +	    offset >= PAGE_SIZE * BITS_PER_BYTE)
> +		return -EINVAL;

WARN_ON ? These are assertions aren't they?

> +static int kho_radix_walk_trees(struct kho_radix_tree *root, unsigned int level,
> +				unsigned long start,
> +				kho_radix_tree_walk_callback_t cb)
> +{
> +	struct kho_radix_tree *next_tree;
> +	struct kho_bitmap_table *bitmap_table;
> +	unsigned long encoded, i;
> +	unsigned int level_shift;
> +	int err = 0;
> +
> +	for (i = 0; i < PAGE_SIZE / sizeof(phys_addr_t); i++) {
> +		if (root->table[i]) {


if (!root->table[i])
   continue

Remove a level of indentation here

> +static int __kho_preserve_order(unsigned long pfn, unsigned int order)
> +{
> +	unsigned long pa = PFN_PHYS(pfn);
> +
> +	might_sleep();
> +
> +	return kho_radix_preserve_page(pa, order);

might_sleep should be in kho_radix_preserve_page() ? The might should
be placed around if statements that might avoid a sleep, and that is
not in this function.

>  static void __init kho_mem_deserialize(const void *fdt)
>  {
> +	struct kho_radix_tree *tree_root;
>  	const phys_addr_t *mem;
>  	int len;
>  
> +	/* Retrieve the KHO radix tree from passed-in FDT. */
> +	mem = fdt_getprop(fdt, 0, PROP_PRESERVED_PAGE_RADIX_TREE, &len);
>  
>  	if (!mem || len != sizeof(*mem)) {
> +		pr_err("failed to get preserved KHO memory tree\n");
>  		return;
>  	}
>  
> +	tree_root = *mem ?
> +		(struct kho_radix_tree *)phys_to_virt(*mem) :
> +		NULL;
>  
> +	if (!tree_root)
> +		return;

Seems weird?

if (!*mem)
   return;

tree_root = phys_to_virt(*mem)
kho_radix_walk_trees(tree_root, TREE_MAX_DEPTH - 1, 0,
			     kho_radix_walk_trees_memblock_callback);


This is prettty good now, IMHO

Jason

