Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C19CAC589
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 07:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tZOK3gvmwqWnhlifB3wIuA1W24Pi0oLtgZexkL4geK4=; b=xhZXYRGZc0PjZiHC3PRCR57UOR
	tNk6CUjVh3Hnmq8Pjw1KGh/j2NphtjyDUHcH4zt7RLLidbHFuxHtH79ggsTVgjAnPnKMPFW8gyGp7
	KPluRTqKM28SD8csGpFCVYUBSDZQ7L76E8NH40mnJGc51eK4FOclnXS5V0/14xDpHbU6Ri2kQih3o
	NACGJPBM8yv7/gaTc9un0G1rMynN3xwjzJcZJcEQGXy8L0pUbMG0N93Wj9QjXvi0HUpgyNCTLmInD
	Wt39gqYD+s+hDWOb8T2eJDeOZtN6Tbfx81a+mn9mgZ6FQm3waDn8RZCYSMRV+II2ssUSi/wytVui5
	d73w1NTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvswM-00000005FLB-1sOR;
	Tue, 09 Sep 2025 07:38:58 +0000
Received: from mail-dm6nam04on20622.outbound.protection.outlook.com ([2a01:111:f403:2409::622] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvbro-0000000HMN4-0NAt
	for kexec@lists.infradead.org;
	Mon, 08 Sep 2025 13:25:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOH61RydzvcaeM9rI6ARSluHueDIcJYly5FkcVwknIA0GOEzgf7aLZ1S1L0ksavB2qpniAL+1t4WMHDT523Z6YWLL/6XwGJJYbsYB1HGuktd08MPLbrItI6kI39YIqFle8ruvHukWT/ZqW6MzZd4Tg/Vy8cPFDgz8gKZ7GQLGQsjjGtsK9VsZih0XOalpNs02RXxVYhhJhEVVTpd38HSN5SI6/+UDmMSO/OG9IcUPf3GdQjPm4K/PPCZJS0bATWHqp6u855ou6zwjFTt4jpLViH7k82AYqgm0knBAiV4U9CDJa+nkqKp14FHAtEzh8HBbaM6Y3aUgNlenSbpZTdcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZOK3gvmwqWnhlifB3wIuA1W24Pi0oLtgZexkL4geK4=;
 b=UWsvj69Ou1aQsVHBOCWobjFCQsIbob7DE6vin7+stpZ9kxgOd9jk8OWg1DcOhhO9+KA6Dt+hUkTsdpTV4rjgYr+7HDeQSkUU5vY6ZsYN0Dh8lJsx1OR1rChOZlGJNZkTvJXNLHoCcYCxzj7AJsmL51aLkbJcoRaJaZfb/b482xilsRLw2dQqyQtkjlD+hAg5RV4MTN3oLbLuXoTlIOKfDYLBQPVOIVFwWwcJb69N+r50p5hXKSCzCqRObDGRycT5rubpC/U08v9wnga95pLKsq2uil/ycxprWZLn8Mb4Nsrci+aMLpnWYEWS3n//iDPa8YKuXZIDIHc2FpEYdhDzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZOK3gvmwqWnhlifB3wIuA1W24Pi0oLtgZexkL4geK4=;
 b=row4tRFNJSv24bpH+I7NxMZnSY2k1N3u8JurLzW5Bn8edCLvf7s5Cd7N703DydlFbNaBOPLTN3PWrKzEB26vpBMoW0NY1Kc4l7GEVi3q8AiutVxWGwLlWxuf98MMGyA732dKMAuN/A3rIBc7Qn2M6MZygkcg72aAN5MR7+UI3KRirSLJx2ExGKIYvbvPJTvkHJOh49vk3cNrNNSW9IPwqGvIAd4hLWWUuKfvpeVtigiBOEWRu5y4Cw/Vm+AEJgGcQFnq0NLYRNQf9jjfZl+xWznnxq7Jfp/+G+MkH7JUtCx0aAUweC/IOkdSy2hk+cdfy6+FPI1R6JLbXGj2+jSwJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 13:24:49 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 13:24:49 +0000
Date: Mon, 8 Sep 2025 10:24:47 -0300
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
Subject: Re: [PATCH 12/16] mm: update resctl to use mmap_prepare,
 mmap_complete, mmap_abort
Message-ID: <20250908132447.GB616306@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <d9e9407d2ee4119c83a704a80763e5344afb42f5.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9e9407d2ee4119c83a704a80763e5344afb42f5.1757329751.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: YT3PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::22) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: fce15a36-c8f7-47ad-070f-08ddeedb15fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oPZKHxJAGK769bWS22UMAkhJgHN+y1pyccrY5DKaBgzbI+GTnsUTjrPDKTr0?=
 =?us-ascii?Q?/jUvCN9otRyNkju7bqaQ4jf+F3Is6FCSLNW3vYjDBWsmGw0f9XCCpQojTKvP?=
 =?us-ascii?Q?DhUnZZ7iwSfXl1neyNh4oQMk566NOApRdt1MIOmJCXKyJfmyVFeyf6bZcb5f?=
 =?us-ascii?Q?t4E+GHNMYdmPKNQ2/7CeypAObAzcqIUyQnA1ek9iO890CWKHO5qYakuMBqtX?=
 =?us-ascii?Q?kTeiFHxQnANTkksp6zXRbdYhz9vVSQgb6sVl8xofitzsx/zGG9aCO5b81GRF?=
 =?us-ascii?Q?aNFQugSrq1C/M+XdDjjStlk8BbvjXv8qeeDrawSWsS1sCouGCsFSc/XpOe6y?=
 =?us-ascii?Q?qgwHKpTkdxIeHcanFZMaeO9cKYp2tWmpUcSqHvCUWs8CmknSvtbV0XLdkTFA?=
 =?us-ascii?Q?4IwreVkBpTjE2LnC/KZg8FnDQPhHOO12wh0vwWRQ2Q+aWp3T0gF6Fo13YnqY?=
 =?us-ascii?Q?6oYVycx5haILgxaF7tPUVNW0AuvQjU8cHnAJHi6DkZceYPKzjIODHieRGoSd?=
 =?us-ascii?Q?9L3x91YtjOYTpjWPSFyRbuNN4aD8TpumAqPCjALVtCuB6S+KGKyAvxNNvET2?=
 =?us-ascii?Q?v7nEp2g2U1HxFbWMz2WJIhmNshtUrSsnHTLHFT6V7E+S8f9+IxTDuqFRjpzu?=
 =?us-ascii?Q?uaNKSD/+E45AXk+YPheLuzuiFeiE84AKasXTR2OfbJ2zyC2ymNkVhHt3jIaJ?=
 =?us-ascii?Q?yc9rYeCfcss7Y/k5k2FcPp/6FmdaAkXU1Kg0eNYDMLvJWUo28EJym/Z8Itol?=
 =?us-ascii?Q?z6AVfBBdv2HP8CdXaaUJlclM239HI9Q5cltDH+oVOLOAdy2rqoBSIowvmTpD?=
 =?us-ascii?Q?hBwA6XxWhI8bn81bkqQ/CXJ7VCdnsJ3QLnll0SnJ3IlDtj/Nn0ijnmwuR0bn?=
 =?us-ascii?Q?QdKmLVwis61AbqK6DbmGovnWgBErbnIr6LoXMwDB4/KUGmDXXVmmO9ER9hbE?=
 =?us-ascii?Q?P5lzjBxcAzhrEBkgiy7RIBgPJE+ThKmbSyDtIT+Kr+Oa8TSUbbcOLgeAzfdS?=
 =?us-ascii?Q?Pd+N2dg0+iZKIo+o8SSED28PVj9BHP1ZGdg22cCnwT6/fiwtN9S5ApDXpREB?=
 =?us-ascii?Q?3WUjUc2ac4uoxkU6r12c2YeKFOVGC82s2g5ofT62f33FEUo5e4XOwkDVyj9D?=
 =?us-ascii?Q?NWs9eFimI09RFWZfJRgg43hvsENUFtZFiWXsZ5nDjspedtIHB0QhOEM77u/c?=
 =?us-ascii?Q?e7rseGb/1WyJgTZOEiDDBq4k9W5QiDigp/Cx8JRhbORHsTYhTvO9qDloS1kY?=
 =?us-ascii?Q?gyNShAiTKqq91OQw3ov1m408RjUuDO3ptzYSk3ahCXdR552kcPn2uV4Cl1zF?=
 =?us-ascii?Q?viOSUVSf/lnC3JpT6jMpriWtAYcU/Cak9YlDyqBorbmz/dikSfv0Z+cL14KV?=
 =?us-ascii?Q?FFyBXsqVNEuE2C+9IClTPrq8c88/j4AYNgn9Yw75D1tGU1mguENXOfYnGYtp?=
 =?us-ascii?Q?c2Zi7ZPThVs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hPOq5cGXa+8xF8pPAdL8AjcCIuuYLm6eAWDqVUglAWxmInkUTP4CbqTTG6AP?=
 =?us-ascii?Q?tWAsFiNd+CauxIp7XOzYRtbGK/YQvIz7wkOgCsjtG/N4Wap1yJ2cFdZCtRCH?=
 =?us-ascii?Q?VEg9hoHHnjQ9BK5INxkTZ6L7AmCkCD2TAXqdiplRZvFMJpZXx8OCKey5jREc?=
 =?us-ascii?Q?XLgDd31Cf3jN1DAlMoESwp3ZilMyMz9wmg8e89pmFbruL5YLhO0kFhfon1v3?=
 =?us-ascii?Q?vuVJjogrFPWK98yWSy5m80ZyayWD7b0BNHG4xH/2qJxMf4auyEkFyDdQuT08?=
 =?us-ascii?Q?PbRA6YpqFpLFbTim+Eyc/FPiex+Vyx+X6Y6FqLLWxcBO6hZmxrGtto2jfGlx?=
 =?us-ascii?Q?nb6AaJh5mlOSoyIbO690aAgBgR6xP/Gqyfd2EHD0vID3/74xQyDu8NxpxSQT?=
 =?us-ascii?Q?2LaluNmUfsIBAnOeoz0NvvJo5+WRdBTBByahq8P0Y3MvyOsNTSAM4yj3zeqL?=
 =?us-ascii?Q?HC54qhteagR9gZwkpOH0zFRKi2WCc1pmxO7ag6HDknarrvuudNJlc5Tooc3q?=
 =?us-ascii?Q?IU53+m1RjKFfzCBY+FfobHz91gqVxdo0W5umG0mHeQkVxPYo43/F120rOw4N?=
 =?us-ascii?Q?jIuyr+84CXXR2PAa3+jdu/cBwG0JA7ecl6Fm49CbKevyeK8YXUe29E3XtHIf?=
 =?us-ascii?Q?iTspGTpbPB8gpTw37o6El3sxoWX19/oEbVhgXBhlS2EmAtlG3mUgXWC2eF0J?=
 =?us-ascii?Q?bHCh5sIG4wo8ba+/pP7vFQ3c4kRwTrsaFnoMRjaakWTTiKy1PL3XY8X1PuUX?=
 =?us-ascii?Q?+xdLy4E4kvu528Lz1Mhezv4kcnDWfv+Nxyz+zxyjGwWdDJ+ngzHdV1wTpJb5?=
 =?us-ascii?Q?jFhljU6fqNBsfrTlgnqXTyHA7FcVgBrWRxsRMaw+EkmbQPh9pUxNQZt6C8ot?=
 =?us-ascii?Q?bh3DU+w5a0cVhVnKiYu/vgsRWPJVVxG+1uo67gh+JQPkknsFtHJJXrqrsvu2?=
 =?us-ascii?Q?XXZis+v+mWMHdrcax264rFbnTYXBWQ+nooZuCpiIRpniwT35M3Z4fY5TODuC?=
 =?us-ascii?Q?x5Xukox04dmVx7QUgmUJUfBwUEcZSWWKdxbItmiVo+IprLQrCuMndgOSInKx?=
 =?us-ascii?Q?xiYmSRSk8MxsYY37C+TTzAquKnZNzg5xnRmf564O7O4B83d7gny4KiMTZXo6?=
 =?us-ascii?Q?mjNoo7pG94ONF11cTLFyUcSLxLPCQokO0b4Z2+2vCU6j1UPJGpoglP9ot8tY?=
 =?us-ascii?Q?KYjFDWpJxKxc1a4p9go3MWsTUiEPiQc0N3LV3Z3+Ixg2BQhySAVz83Msssay?=
 =?us-ascii?Q?6S4BWAkDp/HOZPDANNPImoH6A9+97tZtawL+kfbOqlIKFntWbjRA7uBQ0YI4?=
 =?us-ascii?Q?pUiCKYRhmTgnfNfn/A4cKLfokscj+apNv1xZUT26zP3HtZLWTK35biGeYdj8?=
 =?us-ascii?Q?i4ONxBNLwzkoiJCr2hVuFW+StXWryJs/UJ3SUHHxb+jWDofjpE48NKKYKnQ/?=
 =?us-ascii?Q?Fe5BhyXNjBajebb49R8IuOZhM+odthwjSHUqpu8X7jl5Sy3PJTXV8pqozZCM?=
 =?us-ascii?Q?4XsBwsAjdPttBcGVUNMDy+DB92HBSOhL6HUgrmUvsc+cIDtNM8Skms1h/X1d?=
 =?us-ascii?Q?4BsdQ/K0M2AV60Dvaxg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce15a36-c8f7-47ad-070f-08ddeedb15fe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:24:49.3190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUX61/utz8GYeLqVs/Ti+CneK+qRE7en9MGLKTzmGxSu1WYpxtyqb0UgjHj7TOs+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_062508_127332_3CDDD636 
X-CRM114-Status: GOOD (  11.91  )
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

On Mon, Sep 08, 2025 at 12:10:43PM +0100, Lorenzo Stoakes wrote:
> resctl uses remap_pfn_range(), but holds a mutex over the
> operation. Therefore, establish the mutex in mmap_prepare(), release it in
> mmap_complete() and release it in mmap_abort() should the operation fail.

The mutex can't do anything relative to remap_pfn, no reason to hold it.

> @@ -1053,15 +1087,11 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
>  		return -ENOSPC;
>  	}
>  
> -	memset(plr->kmem + off, 0, vsize);
> +	/* No CoW allowed so don't need to specify pfn. */
> +	remap_pfn_range_prepare(desc, 0);

This would be a good place to make a more generic helper..

 ret = remap_pfn_no_cow(desc, phys);

And it can consistently check for !shared internally.

Store phys in the desc and use common code to trigger the PTE population
during complete.

Jason

