Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F40CAC589
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 07:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=df4NlJyJauiFtLXcc8Vk+3gANJIS+U/2yuXaR0+ipX8=; b=f10/2QaHWys0GeTUwHLlzitZ6j
	JKE2JOVsaUb5xF5v8IjV7X5x8s6i5hpgPosT1KIdU8uCIkXzuOO+c/5hZB8oVjoaL9ssPtqmMIcHt
	TwYe5hqqTVT9T9wqnBYqvhAG1Ia/IkxDww45T2JOxjW2lVGhrN+BVbYP088/4eqYHbiI8i762sS8e
	XdwDFICDmxjw4WFuZSmwha947Xrw0YlEMuCJHKYPty/TE1A92UnHWQTGzeICp4PDgwJEviqXQFUHM
	yP/nDod7GoJQAlNYBDBWURC9R4rYwGVksDaMWWoXcyxn5oLkNP4cYfeiO/q0Pet6mFlKyOMXOPcRa
	YKzsAEdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvswt-00000005Flv-1Oyq;
	Tue, 09 Sep 2025 07:39:31 +0000
Received: from mail-mw2nam12on20612.outbound.protection.outlook.com ([2a01:111:f403:200a::612] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvcIc-0000000HWDq-0g2P
	for kexec@lists.infradead.org;
	Mon, 08 Sep 2025 13:52:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsXO2GFgHD2lkb4JGiHzutntPglYlu97kmjE10YwuAfoqVkcb3bFeqaY6kcA3kZCJslOzWGBvUCWFCCrxmftEtASVSbTAbTo9PRD742Srt9qccxGlwPoWmFRV2ZJcDK9iFoPd2MzJUESPzwwev+haHJVk20LKlKm5d6hpaMBTnUmdCB2AWBZjsPGbVz58dXOZjcCeEaHpSOByBI4y2oHXppvnbsSRL6PudyCJIANc+EJ4iZy1HvOCVsjKrfVWZ9xpcNwxNkO/WYmSLTmyqB/OqOAIKpxBUQiQltVzQfoysmRlsFmEkeF17x4tpZgpNNUNTC3DTR++1p3LOV72rE7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=df4NlJyJauiFtLXcc8Vk+3gANJIS+U/2yuXaR0+ipX8=;
 b=x2nCwVW2yucAjdq01uzRkc0kPGpnxKUJJYhm4Kr1n3ho8KYz5aMLMdLv5084n/n4Spf7Pjwj5IrHqgbJEegv+4BX4Id6qg2VFljeoaJuwVM2q/65NmvGiJv2oXH8MsKxZIjDg9wSXkaM9+cyDpmWzZIre8vaZMYqLTms8Nj80p6J5OHXwKzZqfyPFzxTlDjIYE4tI/Ij7EqezlV7E/Tpo70iazr/5skDuWYfCdYYpP9Qvl/HGK9R97mCwCDGJClVrJJJLh2MJdQaZoYbY41x8SSXt2LDNske/iCcRBIXRwHZeXQVVSadXaYWdchTKECjwjWLUH0PYafJj94/guqfzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df4NlJyJauiFtLXcc8Vk+3gANJIS+U/2yuXaR0+ipX8=;
 b=mVi/3e4bKURpAkNeaCK1irKHj25ThZSvFwNZl5R43jfVzBI/pQM0C11qMVzVIWqg/Kf/CpvPf0liRp+Rvq2gMs/qw6YrzfVvqjWv3/IhM/OIfvXXt8Qq+9kpX+XZC2YUWefnXypProuVlWpFlCHd77RKJfU7mtf7BVFR1je/Cb0KHLsVBd34aSvNvnQvwMgbO6vsUmJ5H64DQJ9Y/fTfFmYqcXtul6g0KF8WbQrc/QFG7+ZLEbZmlCL61IUzTo8eoBgNN6EKvuZh3dAb6pN9NYykuYRiJJHiJy6U22jUJEoQEzV2AxjyxnU8x9BHvIcXyqj+ZrNKsgErzSNHh7DAAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 13:52:42 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 13:52:42 +0000
Date: Mon, 8 Sep 2025 10:52:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	ntfs3@lists.linux.dev, kexec@lists.infradead.org,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH 10/16] mm/hugetlb: update hugetlbfs to use mmap_prepare,
 mmap_complete
Message-ID: <20250908135240.GI616306@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <346e2d1e768a2e5bf344c772cfbb0cd1d6f2fd15.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908131121.GA616306@nvidia.com>
 <f81fe6d4-43d2-461d-81b9-032a590f5b22@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f81fe6d4-43d2-461d-81b9-032a590f5b22@lucifer.local>
X-ClientProxiedBy: BL1P223CA0031.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::6) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 138b36b5-423c-4e7c-ad4f-08ddeedefb5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bjwSF03mWWQGBQV9xcVpderw4SUHy4KrCQQyv4kvXf8zoc1JlerE+znIxeYB?=
 =?us-ascii?Q?G4gBy3+/nMMHCFvi3b+4N0iGFHxl7Oz7o9/MINhG5BHf0omutbvV8FUhas6g?=
 =?us-ascii?Q?jnXeo53eEMW/Fggtrpn1lUcuDu/h1D063fghkqO3etroSEZQ8CanStKiEywr?=
 =?us-ascii?Q?HAlZMZB7La7woILl9rXp748RuFRwvph9cDfJUMkiVBRz5rktBbDNuOkCr1zn?=
 =?us-ascii?Q?RdYlSlUu3i9xt80fGTfS9uKVzkQv4XBvc8K+pXoJoX9wrnRlZbO73vhhxQDq?=
 =?us-ascii?Q?SAPIgeoivM9mEBJi5jU6EWw5UstzmUrAXhi+qj3ZsYLDmzmNgU4XGrh2BcJe?=
 =?us-ascii?Q?SBsHbRidOEeYSIwG+001CevmncfApjVzOq3WCo+jKVjY2q2KhuGpgzFLIiqn?=
 =?us-ascii?Q?Y+WCkL9xl9ViBy3IMsTNqkJlO+AprmB/yiVRc2Dod6mY7do2PTZlVrzthju1?=
 =?us-ascii?Q?hWcK45cYniyTBXCi4C8FgTA4/1iCoD9Fj0yR7K8F1TjOKvo3N1EjR78a8O2r?=
 =?us-ascii?Q?f9wMT2VTd5Defetg6ZR503J8QhrqcpIHBNdKBX44Ommdu5NB7bZcZN3NMfIN?=
 =?us-ascii?Q?8XjBxWWE3KIaYQC1G3cw/aBwV/nEwy7O16sOCil+NxaVeLZjicL/EUbm+CL/?=
 =?us-ascii?Q?8/A7RFn6YcHbJ/qjVP6qwTJFcFxIPHmpxcG5h7X5pl46ecuZkRZSn0oDLVkJ?=
 =?us-ascii?Q?SHI/nuSi38F0061nNSpO9v4o68osXVXhaZlyBiwB5WmmzuxEv/p8iGIb23uP?=
 =?us-ascii?Q?kzdSBiUnJG1+Dxsmkuk4cAUMHmvwwQONlmXp/CnmbBNht6PMvDoU8r72BmVf?=
 =?us-ascii?Q?ole95X6RCUOv3atrJeqhU3C8m6ivNPo/DUOOnsA313Um0ksxWB56HqKxrm/c?=
 =?us-ascii?Q?1cFKI6YCZUOCwwrB+4PF6K/qIewhdQCBmt2d/DwDI7y+e00x6xQRdnhUX6AO?=
 =?us-ascii?Q?OdFbCySG2C1YERnVgk8lIXMRuDLNF5u9bOD0kAOhuPn6dXBD4t3x5ioQlVCf?=
 =?us-ascii?Q?wxkNhxXOkGHFAO9scnwRNLQgVjvmgNaTfxKXzvD4jUUtdyI9xSIvaeqZyHek?=
 =?us-ascii?Q?lTfItD+ZGWVfDdwJnTX10EQQTflk7Xy5RBtsUxIu6ANTPU1cCQ6LIgiFNXs7?=
 =?us-ascii?Q?uuRooupzA3UJtzIjHQMFG0uZXnJpZF8cX0TGsUCFoBHYlbrlkkOJR5JxvvRI?=
 =?us-ascii?Q?SWO2QL1if33r+X5SprIhaGov6ZUJJYvze/iUhODba/qee0qCPeZeYwImu2X4?=
 =?us-ascii?Q?Umuu4PN1785e/2vOsJj7zAp5xG1Aqm5M45sj+2k56FZhJmoBzYYE7LbkN5de?=
 =?us-ascii?Q?NC9kSDBqi4VedXYw39YrIpM0swxzhWZhqaCGi8TjZqeI4qCN8Qgs+BEYa4F/?=
 =?us-ascii?Q?dfCWkGK6YrXQIttZh0xxT04KThDtmhQpP0xPRHydaqLH4sLJchQSjR7gngjb?=
 =?us-ascii?Q?LLgShQy881E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aPrRPhrFQjv3SfE4vSQ1NbAV019tcqU1qVXsxZxVNICd1JIWa9Btp6PgGwbY?=
 =?us-ascii?Q?j36QykEKmw3MbKP3Ir8gVskSI+m2kYL2ZcEXiY2sOU79fkH4EfjJBS3F/mv3?=
 =?us-ascii?Q?VYUiclUy9JnHBK47oK/0gw9zrYVXRdhh6vIFQiExf72Ih3BjLDiZ3leiEWG4?=
 =?us-ascii?Q?WkQnIvfWQqB3U7nKO/DlqrVtsRKpBXHEIrtAjlvnk/x5s5hHdh7DBwq20GVX?=
 =?us-ascii?Q?HwBN15CGALZzJIKD60c35HJsTI+G/XOojXyd3LyL7MtbGLCuQRYkAalMpLcT?=
 =?us-ascii?Q?Q8ibCYPKspIzXdSxvTahKz0cb4kXWBvGDRxva2ATE4u0lxrdOObNOEAS1vla?=
 =?us-ascii?Q?GCtqKnKYYFCPd+lJQueYHqsA+iM0RhedisUFnyTyKt/asdNCAQnw/1X321+h?=
 =?us-ascii?Q?HbY2HvPH7QuIH03RVCIchn96RmmkSCrvLKwoBcLcyJeCE0XPhuEK2ZKSbKW3?=
 =?us-ascii?Q?UFjNYVjfNo6QeMyU+T+LRS+fMgShvmtiGT/7cY+80MMGEq5D+PPgL7tlTj3z?=
 =?us-ascii?Q?It/aRP67rKnXJtUkJX0JYy7tbLbnIL2rWjI2ZwRGQS0rZmfoQanypALvjACI?=
 =?us-ascii?Q?V9Fe3B/0Lsubnrq0QAFfLDPivuxFPCk9jb37pReyWrvg+q+WXtbJT4DXVFoo?=
 =?us-ascii?Q?qqqnOFA3OhagjBS2f2Ng3wNk2zZfzE7YriqbGyt/svbmnpg+Lc3vRm/uvFB8?=
 =?us-ascii?Q?LG9Uvum84+nJtwxdIXtePgR9I07/EcqQY1Qd/pk6kghilneAW+H5/WcqjNis?=
 =?us-ascii?Q?Op0tGlqFGHj0+T35arH/scobiVwNMC0KnzY9S+efQ5LlFKmRz+3WJKohl6Pu?=
 =?us-ascii?Q?Zi50Yza8T20DTbZ7yG+4KZhG6YFr6U04FG5fc33TJI/0Kw+TQ+LJiXXuKsmm?=
 =?us-ascii?Q?MIDIK1toAP1q4dT96OytNZdQc0l5uej2WAg7NXZvbyI1sccsb+cFmXeWwtZC?=
 =?us-ascii?Q?u2KorS9mMIr9I79HriRS1gEfsg8EF8KjgjvqoiyB3tK/lqxa9Jzb5XO4TDtU?=
 =?us-ascii?Q?4IkMlJquopjhDZmBMM2hvs8+3Nqe7fJ3rBie9hk8fvmtM3qa8fVgfW3yOkuD?=
 =?us-ascii?Q?ljJWhUY03ETvH9oKM2LiFVWil/Xt3oSd3rl/vDatmpzG1bwN0HlIbM3v6S+U?=
 =?us-ascii?Q?Ag3VsTM8lcR/6GHNUUQjdpOuKqPNjW/NNTvO0vMAexwaIoF7QCe3a7WNBGxa?=
 =?us-ascii?Q?w7eabV20HzvHFTBlqKjgxFHExrg2y/MqLHvp6I90bPqSVikQ/khp4XNOM4QN?=
 =?us-ascii?Q?pO+Meeozw/5+owDbiZceaVM14wxfdGDvxVnxJT8oJj8PMHXDVV62kYxo/hLb?=
 =?us-ascii?Q?fL/ef68sYwHm1VDIuTT6T+3qN0g4CcMztQYwIWHKRyeSjvzdjFYMJAyxjPaF?=
 =?us-ascii?Q?XPJ+1ScS7MrwVA9FWzfvqcj07vGKTn4VbNR97NulhumgoZcCQgOQ/Sivun1K?=
 =?us-ascii?Q?uNAs/vGfivsRe1vgQ+FYXWkDlUjO8oR+LejuUpfUHTRcsA7yaHds9DPIUkh2?=
 =?us-ascii?Q?juqdzv/maaavn7RycNnVOSZq92hwhZd/qI8esCEfzrPJ6sABNCVK4Rhkt9es?=
 =?us-ascii?Q?4+KMaf++WgJ/M9H73NI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138b36b5-423c-4e7c-ad4f-08ddeedefb5d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:52:42.5830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9qQ772z8XaykaPtdPYnP0aqwJ4R0lpVij/kI/kg6PbGH1JhimkgakmrVDSi4uWe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_065250_193913_CBE53900 
X-CRM114-Status: GOOD (  24.62  )
X-Mailman-Approved-At: Mon, 08 Sep 2025 23:53:50 -0700
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

On Mon, Sep 08, 2025 at 02:37:44PM +0100, Lorenzo Stoakes wrote:
> On Mon, Sep 08, 2025 at 10:11:21AM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 08, 2025 at 12:10:41PM +0100, Lorenzo Stoakes wrote:
> > > @@ -151,20 +123,55 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
> > >  		vm_flags |= VM_NORESERVE;
> > >
> > >  	if (hugetlb_reserve_pages(inode,
> > > -				vma->vm_pgoff >> huge_page_order(h),
> > > -				len >> huge_page_shift(h), vma,
> > > -				vm_flags) < 0)
> > > +			vma->vm_pgoff >> huge_page_order(h),
> > > +			len >> huge_page_shift(h), vma,
> > > +			vm_flags) < 0) {
> >
> > It was split like this because vma is passed here right?
> >
> > But hugetlb_reserve_pages() doesn't do much with the vma:
> >
> > 	hugetlb_vma_lock_alloc(vma);
> > [..]
> > 	vma->vm_private_data = vma_lock;
> >
> > Manipulates the private which should already exist in prepare:
> >
> > Check non-share a few times:
> >
> > 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
> > 	if (vma && !(vma->vm_flags & VM_MAYSHARE) && h_cg) {
> > 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
> >
> > And does this resv_map stuff:
> >
> > 		set_vma_resv_map(vma, resv_map);
> > 		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
> > [..]
> > 	set_vma_private_data(vma, (unsigned long)map);
> >
> > Which is also just manipulating the private data.
> >
> > So it looks to me like it should be refactored so that
> > hugetlb_reserve_pages() returns the priv pointer to set in the VMA
> > instead of accepting vma as an argument. Maybe just pass in the desc
> > instead?
> 
> Well hugetlb_vma_lock_alloc() does:
> 
> 	vma_lock->vma = vma;
> 
> Which we cannot do in prepare.

Okay, just doing that in commit would be appropriate then
 
> This is checked in hugetlb_dup_vma_private(), and obviously desc is not a stable
> pointer to be used for comparing anything.
> 
> I'm also trying to do the minimal changes I can here, I'd rather not majorly
> refactor things to suit this change if possible.

It doesn't look like a bit refactor, pass vma desc into
hugetlb_reserve_pages(), lift the vma_lock set out

Jason

