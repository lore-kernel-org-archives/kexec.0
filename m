Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAFFCAC5A2
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 20:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZGxtqEtM6qSmnl6AZaDwla56yx+e5zZr32Ux6EqwK8U=; b=QR0HgTaeCHBUJC4jOJLRf69e43
	Pxn6VKf7W3bk21m/nJbwkkfKxVNBAqrbiE6koexOl59OH4fo0mQz8xJqmlF5WSn+2ufj+BLowmLHf
	yTRejICvH551tEhS/jceGLJk8LOquTOVg8EW5HpgmOG0cDUc/yXzkNBq38U+hY260w2V1zE9ETGPr
	3JhleMGPv2/SdnvvTCYk80q+zkKAcOJEquWXM39ujIR24Pk5Q5zC+48AIdaKO76FG9BjUhjhcLyXy
	J2/NPcxnH+GPklPV5rm6yycMw5rO3UFlSmB16NMrbqvHIXO1dB/t7YrcrFm7544UcMsnymiJlRasl
	jGXchinA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uybyH-00000008wkf-1HEa;
	Tue, 16 Sep 2025 20:08:13 +0000
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyYqu-00000008WSB-3ETG
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 16:48:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/PJA5THrrIzhyTY4fNrHVPlFK7klVw4Q4Ma18Ceu9Vl/g1wbwzMsq4ed3f4zDfHY3SdjW4WH/NZ5C0vzjUffV2/icc/EvelIrKbWlb8BO9E62Tu6CL6rKY4mZyhmYPEjGqQCDqtFXcJpO7NzpeTwrT8m1Z/5lUFSmEooyLtk90hiLsiuB6qmUwO6a0VN2mr1uQaeeersy6qam4R8TovwSiapF5P7kRMBbYsH5BGwLmPwsVF92/xYyv9Qk2tHigqQwAXOVnZanl3ltZa7LrLcgq96UaXWi5VcEoLUB9ZscLEC+wTBRVohTvh7DlOZn6wr3r+0Jiz/h86X+WY34ioBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGxtqEtM6qSmnl6AZaDwla56yx+e5zZr32Ux6EqwK8U=;
 b=TgFDyOGXbQ/h+fFaVX6/G0sOqsn3RiZf3DZMTnf/SVb5uGimPK4CsEC5S1jK13ZF0az2o670mv6P/DVW7/GZ0e7xDVLd8CdErH81/1C+3E2ADIsa8RA6kob3TGH7x9iXpnbZXsbt9GNKik+AHouLuw3Vy4xa+SRauUpfR97CgsiZ24uVkMba+mTJrAQbmISMjBVW02e0nmGAd1CauVezEgREn68GN7TnvPUmXtfKB380k02QGQZ+/Ts0RAbFrUZqByk6aMFU7TxCbsEw/8FLACZxBgB0apO7AA8pTeKqBtq+EB2TOax20LnwLdjV+CaCwEjoaB9Vp210Ep0NQxRtoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGxtqEtM6qSmnl6AZaDwla56yx+e5zZr32Ux6EqwK8U=;
 b=DxrRmol33QZHK2rVawm7FRcMfeS2ROQvwAxsZO1Ri9Kh7DaJrVtsckwC7ZYHGTBSSgbwTDr442FDkE1dvRc11K5EXGk4FhH+X7usLWRuHWqJ/1qlf095hlcxgvCY6n4Cpw6CVdpLxT1+meN+V8qeYknGLRrGwow8X8Re96Uj/wT5fRor8hWiYuCkOHv2s3kYd8ik+zAj2CDntQVHUjc+Ykh3s9CytrrkpT4f636cGwdXBD7Qle4tXU8Ztj8hnCo+y83uFbRy9xcwC1wQFJ4MGtJWMST2vqACvmr1Mnh0coibXqAERkSAx7snUJGdyPfAXhG6NcYtywF7RG+oYQl4DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 16:48:15 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 16:48:14 +0000
Date: Tue, 16 Sep 2025 13:48:12 -0300
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
	kasan-dev@googlegroups.com, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 04/13] relay: update relay to use mmap_prepare
Message-ID: <20250916164812.GM1086830@nvidia.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <ae3769daca38035aaa71ab3468f654c2032b9ccb.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae3769daca38035aaa71ab3468f654c2032b9ccb.1758031792.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: BLAPR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:208:32d::6) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ba4db9-17a8-48b8-4955-08ddf540d455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y3s1kf7V8heKV17eIqquy1ZN04e/zQTUTMYIRw48ly3jYe8ccTQBEfAMqSc6?=
 =?us-ascii?Q?FudoAUyU0ArFjJi4RX3RhZLzUDObS1Egr87uF5YHivcKWciOUrbX7RS0OjAP?=
 =?us-ascii?Q?FyFCYoE/y9JCAX79jGHpTAH0fRjj7bRBvKEw0tQb3PUam5ftH1f/K/+MpXTB?=
 =?us-ascii?Q?cqqk2nNntPUiGMMdYumSg/Dir899vINi8k5NKOpOIPnHDCQ6v9mFtvBjeFY+?=
 =?us-ascii?Q?3ce7w6c58538DV4hJmTyjOBmCPxP4kqa/sEHcmz2YnPbLL5Vqvun0D2wJ8p1?=
 =?us-ascii?Q?59+Vp2DP+4eHuU5y/XmUKZQ0tQmmDUgRJbyQXEc8BWWGOWS2nvd3qobYYOBy?=
 =?us-ascii?Q?AT9Pc9U/1zTSXA5sxjOY/DIr5Z9hNt3X5yh2nZlH3/Tz6noCk0RWY4JqUesY?=
 =?us-ascii?Q?kJXpqwJ1FmtF/G5+Dbv9dKNH0TdFhPYOkY5L8Pw9m3kwOgyN1FAhwJu6aQ7C?=
 =?us-ascii?Q?DsKgLS5h9mWJCgt/BjmeuzKTV3pQIs/Ipzv7ReysiM14l2IuqaTQAmKkDW+B?=
 =?us-ascii?Q?Pv21CX6Gi1y3LWeGX16a+gQX4agQVILiHMOjTKV1MzNloC5rjxeeOmeZRPHf?=
 =?us-ascii?Q?M8Wx5/722UaQICJQosJCmic529qBAMm21PWKkDpkvAI/sMo/2H+y68TPtpRa?=
 =?us-ascii?Q?OrXVkU27BRNVwqHzCHhT0pSOonwIy9dbZ+N61AfUWF0Y2hJxrMJJ69cUh1WI?=
 =?us-ascii?Q?xB0Ch4QMTWxgiIWfIsKQZAxvClS4C9FbQKdksbnpjKFte+KnUzOQjtA8LTUG?=
 =?us-ascii?Q?oGlWGSU1LVVLI6Bvm/wWUG48Y22se6JZZW9/4uEC49i82ROd8rHNtm2J6Vl4?=
 =?us-ascii?Q?Lm5CzO9W1VpYrRW6EBAfi+GNFSfHyxB0dkWEBrv/bK1rY0/LwiFBK851MdAy?=
 =?us-ascii?Q?5RwufG+gmdR5O8GurYEI0SBZ4SDqTtjsgNKuQmO6qN9QEXQqTyCYN3cQl8hj?=
 =?us-ascii?Q?BWdih9buibfUxryiTlNOu279HVAMa22upVNm57zmDZycQuFyPDRAIPuLHVHt?=
 =?us-ascii?Q?0lfGzwUyRw4CCNKWF4RwWklUnsKykA6y7LryxD8zvbolvAxk18ucq7DfwBoQ?=
 =?us-ascii?Q?IZXnZ+HSCbirIYmxGjXGDLNwEh+/nmo+6HmDPpYQlOe4TxDs2Q3hP22+BfdS?=
 =?us-ascii?Q?z/6MpGok/oivhCZqJP6iBFxdV4PsmeuSxMwYBWY/e52n9nyzGyKRZhlRsm7Q?=
 =?us-ascii?Q?fNhlTWcKy9xgE5oeSHnlVMcMiWdoKU4dg+ILTLNMh8jsH2QmIRX+w/aFSp3u?=
 =?us-ascii?Q?OISp+ZzR63hXQ6e6uFRRPoNM+vNK9AzMW4YRP2Ce0LJMaOjFOzVWBGUgoUDm?=
 =?us-ascii?Q?1dCSA6Zx9/2hCJF74LKLdQ6+fUf3RmzCzt9spHEFXAVfOS9BXV4ZdLe6N6/g?=
 =?us-ascii?Q?P9S9ZwVnFZtZymXpn9j+/aAUk5SsJ7uVhLoWumliY9rMO0zqOgW5m8lgC2s1?=
 =?us-ascii?Q?HrqYn6I92B8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Duq5LEZpk/YBdps7+9tqiQbxVyXjQ6DwRwGD7gvOXbqvJf3cAMFfGkuAI6s?=
 =?us-ascii?Q?kgzVQxnppEx3Hxa1KvIhfiocMEroUhxs/AJGLViw5u8BwWlax4eFrOewFUQk?=
 =?us-ascii?Q?/nAC9AHLxIpcMEKt1X/e59t01FR79RPPRCA7MYPiQ339HbOqjKIPeplHXzNA?=
 =?us-ascii?Q?oR4V3e0TsDg7v0VIGIelwuSs4WI47o+Im7uRzmDJe8aND19qrjLm61ZtRK7s?=
 =?us-ascii?Q?kNbnt5kp9eLYf+SNrGVqsRNwqHmjUWklH8yVXKE0ldQnV5hRBERmG82BA1dy?=
 =?us-ascii?Q?0ldP6cIwNzaBnieqIObmKYgcReAwGcf51/cERNotidr/RFunydtNC0mD5hs3?=
 =?us-ascii?Q?wf1cEohL4Yspiwq3rPyhvNpOSGu9NL5Aqlza5D36zhsKab+Mz+jalkz5a4FR?=
 =?us-ascii?Q?b/r3Rr7WtswikEKlxjRGxCbND4mMWXkTdNJyp2Gr7RUO66ZPw51yN+3jCTTw?=
 =?us-ascii?Q?mW2di0SvXhyT0scsQyWk49mUiWgFkcd/Ff7P7eInR7/+SBdn4SwsTzluMjLj?=
 =?us-ascii?Q?lGjho5O0YoS/yh6F7WLqB04hBUWGzJ8DXCOT1ZwCu6MfVi7/RdxTDTCJEHaD?=
 =?us-ascii?Q?eGUy2sfX71VPEg+Y92222XpmQJEisQgbscHYok7xJP1ANtkustVFB33SmtYN?=
 =?us-ascii?Q?tgbCCgu/reyPaKuy9mdEbtmsXdgnaTYgAxe+qahoMh0/jbjpV/coO1jM1+24?=
 =?us-ascii?Q?EDy906JVYxGXaopLndYhov8EalQNnu7IAhPJnaaHLg+vY8/aK3VtkH1yYHwY?=
 =?us-ascii?Q?VzxpmTkuVSmKi4GK120cluvxJxSseQUluAenvL3N4RHH/Q3Kln+1N+dxMBvN?=
 =?us-ascii?Q?78PkTJdZ511jiK5SdG4N8KlPGh2oTffc/W26LGdK23lQQ3eSi7qfDu2DTRzB?=
 =?us-ascii?Q?LdSM0pe9aL7gF4d/hctDsYBYAJ/6uu3BYEzY/jFMxJFCjdCqjOPuOyub0vRs?=
 =?us-ascii?Q?sCCQbt0N0C+4pQfhTQwzelNkHmRSHrl+4HXh9GSWJ5kLADWoBevBAgY3hcNS?=
 =?us-ascii?Q?aRxQj84kDQMHNfyldnCdgATBN6CY23TEiIygJfSbOLOZTbbsoKOGF2GwU5nQ?=
 =?us-ascii?Q?OZ7fqmxzWe4NakSiKARUZvWSxR254gsLVEzwztcb/kqDCK4CPll2U/BprqjK?=
 =?us-ascii?Q?VHjhIFrinWzfer0RbSf/88XrvF+lO6zrg9mjoIjjyzBxpcyKGJeRMNyxfBCB?=
 =?us-ascii?Q?velojaAo/wDZV0VF0l+Ar9Qm/6iylzUKf8jbWBmixT9EBuz2AuCElpQwboph?=
 =?us-ascii?Q?Hq8OGcJwI25y0pm0xNYtAZEtXSV43bZ8y24SqF6au6HkbmKg8zk/7YOSvqaN?=
 =?us-ascii?Q?/HavOgfck4fzQnVD8qrQx2jl6yFaNRmIV4H6kIeH6hfMCX32s7iGjzkQSy82?=
 =?us-ascii?Q?n6bGBt3laRK1Ic1Lz6I+OSsrUTIMqxVR/laJY3F/oqIFuZJafhEvSDwvef9Z?=
 =?us-ascii?Q?O09zMqsyV4BgYfxiX9gcLUee7p/QT50VAPYNeRAdXdEwp0ALpfwMCPDYW98d?=
 =?us-ascii?Q?VJr5ujnd3n7DnDNVPemsryDvKGTs40GynW7lM51DrQBD3LvrJ0iEn9MHlzr3?=
 =?us-ascii?Q?S/spiDlKNfnIu6wrzO3Qzf0c9ufYIVAnMpJnLOOA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ba4db9-17a8-48b8-4955-08ddf540d455
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 16:48:14.7629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4fivfu+frkvHJBnjEA82CgOPlL2cLtcBCqd1SwbVM+wIOZQIM/DQUGJzfKXCHwh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_094824_803609_D2226FE5 
X-CRM114-Status: GOOD (  11.52  )
X-Mailman-Approved-At: Tue, 16 Sep 2025 13:07:20 -0700
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

On Tue, Sep 16, 2025 at 03:11:50PM +0100, Lorenzo Stoakes wrote:
> It is relatively trivial to update this code to use the f_op->mmap_prepare
> hook in favour of the deprecated f_op->mmap hook, so do so.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  kernel/relay.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

