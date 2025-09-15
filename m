Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7F9CAC5A1
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 20:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9L0MevsaZl4URnpEE5ruNJ+WATqAH6AxktDl4S6aji4=; b=yMXtqWA0QHpYKBHobLPsGfhi9K
	5PRebPkxSXoisahfPRZLhlT88Avsns4Gm+j5MvDDJya56I9ZSltHKmP993XpUPGkTTFtaM+GkI24O
	uhlhhtNvUs7PvKgHnJNRVKK5AvoyamKODoQRYmeHFpuTcZIepkJumN7b+PG8uiZRzTMDwFlXa0bAE
	MfMb1p5ceUKCzchU9I9FGoHnlWg7CVrQfrhaZTuHj10w4Ibs9vNv4oje86UQFjCOXnqfwmE14OjyR
	WWOKsWYpsFDXTXszEyzYNc3P+F7YiT7GkJoKwj4m4XwwDo6fnCH2NSWwERm+A0PGsWSDOnxHltY6e
	eSSZkV5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uybxz-00000008w7f-1KBj;
	Tue, 16 Sep 2025 20:07:55 +0000
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy88H-000000045uq-0LJC
	for kexec@lists.infradead.org;
	Mon, 15 Sep 2025 12:16:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v16KWpkY3ImVT7qges0lHR6lT7j5DpTGpknezkG5+BUVFtHh/ACwDMCuFCks0M1M4uI7dsgQurF1BHur3WYN9tJ67vKFtTG1NNa8TDFOQiBFZEhsO1yP9g+UiSfzvmFXoFYCtFa3hTrxdwFu8NUtPGY3O3uAY1VGxogBpxnxX462w3vCTTUYLrnAZiIU5iYOiRMaDAf8GfHQxAiVBmoK+t4RoT3E6h4mRzcn4m6g9RMHc4e1+5/z7uQz1KLfq4chgtUiM5wYpaap+uV/veh+KAeSleyArSyDLk9K6SOLyoEXkUKTWWj/C7RsZy5bgEVMRHXQopGwwcqiiGaBeSq6UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9L0MevsaZl4URnpEE5ruNJ+WATqAH6AxktDl4S6aji4=;
 b=RX7ZYWqO9jflUsBRexVAGfbTW97vj9htFuwgmCTO2W9zsaJDqY4wWOHkBiqJ8D0r2IYFMNO06BZdrYBQqPnC1usoG7AN44CR4NtmheaWHXAflDsvmIGVwPpdq8JYaoK28Au37yrAJU81e3FHs0ZIYvCD3MivUNwtoKPdPU33/XCWTtatoRdLJDi0+6w9CE+Ueo0wf1NFberNDWBqkRKliwCwbxGM8iFkvq6WyxFvRK5clvyWMmfhLcyN/ChNxvxuV/eFGk3S2/KlB+mW3D1QqDf330i5m3X0UhBPG/kv921plmP7m6QVRaVcPbj5REAmgOnC6a8+X1gjiA4dxsmTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9L0MevsaZl4URnpEE5ruNJ+WATqAH6AxktDl4S6aji4=;
 b=rR1yMTm4pit+c8u7H0D0Y9kdyhDqnW2nq695VD0nYBlSZZHp1GChE3zcAfkMrBFIhGXKppoqFSWMXnigw2BlJ2Gse+Hao02erT3c3oJfejyyH+phk2CEOZ5/16sSTCq4sHRsSGjFXq/YSC6vGG9nvtfHGYgZPPpP5fWEZmMN5hQLkHtwLQPtFCWGGDuWxMC5ta1hHeYdR4x9D3i+fwcBKn7lU0kfWLi6K2aclN6yzz5KOTL0UQ3dYmXdC73z2UZpZF7kwuj9mhfdj2OW0dcgCc9vXkDVON3umMaDOv0cjVwjPtrhKjxIiRtpk10SqJjZlEiMbMJLgM19pZIBH7uRDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS0PR12MB6632.namprd12.prod.outlook.com (2603:10b6:8:d0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Mon, 15 Sep 2025 12:16:19 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 12:16:19 +0000
Date: Mon, 15 Sep 2025 09:16:17 -0300
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
Subject: Re: [PATCH v2 16/16] kcov: update kcov to use mmap_prepare
Message-ID: <20250915121617.GD1024672@nvidia.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <5b1ab8ef7065093884fc9af15364b48c0a02599a.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b1ab8ef7065093884fc9af15364b48c0a02599a.1757534913.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: YT4P288CA0046.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::28) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS0PR12MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: f35a159a-93dd-4f31-8c8e-08ddf451ad2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FJ+GMy316Ah1W2PRNL2uK0E4d8rheS0eMVrJO4fwtwoJVvgRBslOImN624yP?=
 =?us-ascii?Q?qn/ODRZ+eoKmIUc/H8K5IVkhwAv3B1GndIBDMGBA/M2ORQkApBPyju9k776E?=
 =?us-ascii?Q?sPmiT8Cn2OcosjlMmtT9CiugaKagkVWjraWs+WUSjLf40pRrnIiJaH7qmUUR?=
 =?us-ascii?Q?D1YnJmUzM5/sKkSFbA1oYJt6UpwBYpLXAh7JD4gd+nPqoh0Vt0OgQTwCTQO2?=
 =?us-ascii?Q?pJ3w1DVazyydFZFl2tpsflpn9qZSwyWfRqxaWDU6INzU2R1RQ/zQ9IqtCXrL?=
 =?us-ascii?Q?21QRCOZLg0nI1FMwtK5xxFuABD5QHz/UynorLrHMx7g4C8/wc0jonjscEwQc?=
 =?us-ascii?Q?Ez2cXZJNjyMH6cTU/WmvIXxEauwrLLPIRRI1x63OAGB7zhXimQTj4gAFXNA+?=
 =?us-ascii?Q?dXFX49ljNP4IDBh8MqI6sW/YS7RBi32O8IW/z4aVia+Z6/MbA116VOid25qn?=
 =?us-ascii?Q?WWnDm4WwNUWVDxOyo+IL8yxp0DpA26BXsIto5Wf7MVZHArw/FOldfb0/BF20?=
 =?us-ascii?Q?+khK0J36F+nUIPZ4n/o0rDfRtrj59JU/BpXEN7BYjOE0EIJ5NANghpy1oA1n?=
 =?us-ascii?Q?T7esIJ8gzTXWF2zhIrpWsfFz7DUwIqsen6rqyYlka6JvljAQnnexWrZKidKM?=
 =?us-ascii?Q?bwsaRJ7DyYC7hR/hQ7c5MyqzErxGM7td9AEPTf5tN9BvZn6HsnzkLjqQxBfJ?=
 =?us-ascii?Q?rCFMelL0ZAu/0MVguJRRjU5fo91scmSc/i5ADIb/BHc2D3TstjxcAU0eFYqA?=
 =?us-ascii?Q?OSuiBwFrSe/Ow8MggoPW0gV+rPbhvKgDO6ZIOoGRramKN1i8sw6Mo/oAqqie?=
 =?us-ascii?Q?7hhUPSfe+KKWu6k600DNeEH4wwqglRs895mc9zS/Vf05VNajpIWCDOATw4LM?=
 =?us-ascii?Q?RMhP34Xd1TkhWfkQk6V5vsPaqjpndfnGlqinJ4M0bSXcIVPqBcpW68RyI0sr?=
 =?us-ascii?Q?IrSopJQFXWmhOOcXAC4WRJ6xO5Nsmymbvg1oHipT9KZlwozBnz+4ikzmUPXh?=
 =?us-ascii?Q?ansdYgwY+CUy7+Gn6dLYTLypjn7fyYc+BP96q3aseS1YpHn9+WmrR2EYz0Xs?=
 =?us-ascii?Q?p2kVhLx3mvujLNXztcyF9ouXiy8NJ+HWuASAC81a2N4S0JzuKDloN8BG1wxW?=
 =?us-ascii?Q?efm1gDyw4tAFPYBm75o834G3X60PnZd8nDPeD/uQaP6SIbupr2e/0zDfzRlN?=
 =?us-ascii?Q?9t6RLcgKXLFpbeUfwtjAWQjPN380JM0SoN92vky3WFaZCfq5Xuq6av/PJmD1?=
 =?us-ascii?Q?Ka9tulrWkP71qQ1y3QKWGOXgF62unORpW7h42NyJXpIccfEQAlJzSPsaXvw9?=
 =?us-ascii?Q?LJJovAtdN7zusj39sjsmd5cA2x43S3LxsWC59F16Gf2k3gXNmPOqltU/08QF?=
 =?us-ascii?Q?5gMJ4OxrVFtRxyLfoQ0XhvfAA169q4zXhcdoaBV4Er0MNKjj5LDZQkIHkTtW?=
 =?us-ascii?Q?mOej1NYler4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WgeUIJi5cY2sk5lj8fMjb+H+kNFLtDA7lYE2X0J/GN5d5Ob0yf+l1+EZdKBo?=
 =?us-ascii?Q?+RhTJ29Te8+tf3x4tbPbdBM7rBkIiTVK4ix4yblQnvO6G+L9zbhliXopHrd2?=
 =?us-ascii?Q?NFFkFVVeYNMQA/UB1NmQSJzE4NFPmO9dhzdjYo5IwmCpkQ1vYtDBNo8y9JB5?=
 =?us-ascii?Q?LOKYnrViMUuiiVGlAoQ5ivfDXViVrxsE/Cx3oreqaoaiqNjdkcs0T2F2hj+x?=
 =?us-ascii?Q?u933Qdle6HxY8QXI/Clx6OQRLFaU4w7qL+DSCETS3JD+KD3v+8ObP0hiJ7tz?=
 =?us-ascii?Q?QHfprJZyWKoC1gBKoWFQFhHnJk7nUqnHQEhohe8kFWr+ieOCFiNO/J5nh5zn?=
 =?us-ascii?Q?c14VmrL3LInJ3Sw3wb1CFw9gUjBFRsCKqYeP3Kpuyfuom2ncO0PbAorjCpKN?=
 =?us-ascii?Q?VQqgeWK1PAw69K3bCLplbimtl2qhCcyRKcoLgcCQOgHVMQTZv3hXChl3GNhP?=
 =?us-ascii?Q?jPkrow1WVCFc9ElpIqaXejhoIsPSsBG28of1LCkmM9OY912wgnVg93ycxa5h?=
 =?us-ascii?Q?kXqsYL7wDrPgEoJ8R2xBFCA6+KsqwVrXQSHOsROsW8jWAe+3BNiQ5/f1fIwf?=
 =?us-ascii?Q?LDeYaWNiMjyhiEW1EguQQABUcOMsP0fbe8yYCScBSzVNix1JMT2w4exz58tO?=
 =?us-ascii?Q?ngtwUsSXRXmL88OqDha1EivU7oyhVgXmjrndhSvMiJOFN4OiPswEX/1lFEwS?=
 =?us-ascii?Q?ZOr2gthO5JJnLqYuN+qkGt0U+/Eka3+KKoDKtSk1KtUD2k0zHq89sSOT3dHW?=
 =?us-ascii?Q?JB50Ku8O8S6zPmNR6p+xvGQYnokn6ncqaGJ/FDXyQ6hhq1aWm4UWLJ2oU4cm?=
 =?us-ascii?Q?tS/g2sM8/YfeNVWtfv/vMtfNhKPCdh0p1bpnCJgOiTrDeX3y+gxqCFzSQYtS?=
 =?us-ascii?Q?mOtawXaV2y9IbYMwRareJ/fdhJRFOD7ZC1lAGh+oFuTlpIwgDyEOj622oqF+?=
 =?us-ascii?Q?/F8J2R+GwDE7cK+ksSQEjWTwJdjqQZ4RDFwRzVXVo90323HTq4HHcuQ0habU?=
 =?us-ascii?Q?zguwnBRC5Hb8K0r04OcGoJ6PHm8MlEvb2TT5QhFfT2+aNsKYNVqLFqL899gp?=
 =?us-ascii?Q?NWwA8gjiGgtYpUFUu+Cg0ALcvic2lgHyMFdayXTQ98cynm9SmVrMD4qZu1+P?=
 =?us-ascii?Q?mIZBVI1Oa+nFyuriJnScudW8JM4zxi6T8rIlVctAoVFaV1N3vx+Km/9AkBYd?=
 =?us-ascii?Q?+PKBlXnYdcnqP9V0ww5eldolEmyLHbuCpCTVaMxS1aQ3Le6kHCrwvO6hzw5B?=
 =?us-ascii?Q?DXtVAV4nHiUarz0VQ2pwY7m8GDWFtI8itNriN9vFG1n+y08VxRsgJX9oA33C?=
 =?us-ascii?Q?4HJvlVsYd8qxMXz9jufApjap6Nxq1MqT3xpqyP4EtsL6TA0F5apODmOPnVcR?=
 =?us-ascii?Q?yS6NvJ6OMaq31dh9bsPKmxY3HHiC/cHFdE1hUwSJaB4Nyy+k43r9GSS1nK1m?=
 =?us-ascii?Q?5EIljg2pSt3bKjfdKoJFbiT/eAoy+/zrMIKEScHw6y+EOezTjqB2Xt2o4Oxd?=
 =?us-ascii?Q?IvZnZoM0NAtT81lqejPsR1wZiLQIryf6qKQ9n+qWu9RFNoBFrCApj0YGSwVG?=
 =?us-ascii?Q?tDjxwenHqv+3Ncshhmo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35a159a-93dd-4f31-8c8e-08ddf451ad2a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:16:19.3375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEkAUuneTEE997o8Ffh1wmwK0ptrvvqE/Q+wl2h3x6DZFuitcS2eewWiuv5vGq3l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6632
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_051633_117162_FEEB329D 
X-CRM114-Status: GOOD (  15.62  )
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

On Wed, Sep 10, 2025 at 09:22:11PM +0100, Lorenzo Stoakes wrote:
> +static int kcov_mmap_prepare(struct vm_area_desc *desc)
>  {
>  	int res = 0;
> -	struct kcov *kcov = vma->vm_file->private_data;
> -	unsigned long size, off;
> -	struct page *page;
> +	struct kcov *kcov = desc->file->private_data;
> +	unsigned long size, nr_pages, i;
> +	struct page **pages;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&kcov->lock, flags);
>  	size = kcov->size * sizeof(unsigned long);
> -	if (kcov->area == NULL || vma->vm_pgoff != 0 ||
> -	    vma->vm_end - vma->vm_start != size) {
> +	if (kcov->area == NULL || desc->pgoff != 0 ||
> +	    vma_desc_size(desc) != size) {

IMHO these range checks should be cleaned up into a helper:

/* Returns true if the VMA falls within starting_pgoff to
     starting_pgoff + ROUND_DOWN(length_bytes, PAGE_SIZE))
   Is careful to avoid any arithmetic overflow.
 */
vma_desc_check_range(desc, starting_pgoff=0, length_bytes=size);

> +	desc->vm_flags |= VM_DONTEXPAND;
> +	nr_pages = size >> PAGE_SHIFT;
> +
> +	pages = mmap_action_mixedmap_pages(&desc->action, desc->start,
> +					   nr_pages);
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nr_pages; i++)
> +		pages[i] = vmalloc_to_page(kcov->area + i * PAGE_SIZE);

This is not a mixed map.

All the memory comes from vmalloc_user() which makes them normal
struct pages with refcounts.

If anything the action should be called mmap_action_vmalloc_user() to
match how the memory was allocated instead of open coding something.

Jason

