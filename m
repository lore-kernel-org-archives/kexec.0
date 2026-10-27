Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA97606A321
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tg2TLC9p;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KGezkC8n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	References:Subject:From:To:Cc:Message-Id:Date:Content-Type:
	Content-Transfer-Encoding:Reply-To:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=joa3AxqeUObolrsuwJzh7TiY4r/2iQfMSE/c3S5Aeig=; b=tg2TLC9pBwIf0HEzaA2lqXGIwD
	LjuyCecR1BisXcWIjHa5gJUSByJuo6VUCNYm1Wi5ZMAfDSuiDI+UqKYCP9RybtekjS7VFWX8zitFZ
	RkffOYh3bn0v9c6fS0smEDWD7cq/c7wcIgpLzGqb0aoBygOgL6GdwxcUzAWLrLSxCanv4DP5f5Xw+
	T/yS9D+4k4QiOUkrmKuqfVCFKaiGehLRhf0vmW9N1726VkBSzV6EDIhYjCJi6coWLwNYgxzd7ut09
	ykieAod1Q+4JV+uTAFksBcax3DxNQh8jAG6lz5d4iaSslZYxBwA3iUKCW3ybcKjYUQlRhl2pGAbXv
	1TgECXzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLoRT-00000005m3X-0XJV;
	Tue, 27 Oct 2026 21:10:47 +0000
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLoRP-00000005m2w-3kh6
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 21:10:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+msr3pIv1yybBmAj1X3nNBhN7z6z+nBW2tGqDaBGsmdT8azvN1UgyBk63+RA1ofnVbktL80dUSGIXkTAhqj9w2ldKPnWZYVMrtwEqVjM5woKzsFHdG4EkZuU1apw+D7YswYssbr1pkXSFnfcAMteCu2XvCxiV/Rj7yvWr5/pFVTM07IjWWD37r2OAqMAaMhgQwOafX4XpPFkwXc/bE1ZkTB1hfgLndy0jNn/EF2vy7/GUEriHHFb1XW8CWLT7OxNivumJ+GGQEkDrgCGHi5Q7zGLZ3zvT6DuXVH5yUBSMKZfXR/rNymNi4HMGcaJf5SbjOtNvq9LhLQQgVirmZ02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joa3AxqeUObolrsuwJzh7TiY4r/2iQfMSE/c3S5Aeig=;
 b=kqeOpw7uuI4H+ZkLR9y7k8PNOpNAX5tfEL92bge92tXjYD3LmaYPa/qjWZ6Vx/py0jxSN1w4dT0Yp0qL7bTYMEKoe+3Rjq+AL3nVoz1C3ZCabnJrJHsonef8AV9gF0qrJYQfkqMsPYxYk/rL6YQ3ye3E1kKbkd16QZZLYIku7oB6+UJ9K4/fMg+4OqiJ3dN7b9SEFKmTryR4YoY2tD3/tDkyccVLnf2yTXI4NPyzaumwR6UUYTobrFOLvyR7CTyXYN3z+tZzDmX5bCw44vcHrvUyafjjAqPF85fptqJiJAGUrwKgwpI+RxWrqE1kRf9utXnqUAQCUNySwKGink48Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joa3AxqeUObolrsuwJzh7TiY4r/2iQfMSE/c3S5Aeig=;
 b=KGezkC8nENubu7gTdli8/Ep7ah1oxBoA/mtcOIQrsboR/temf9iv1qIVXd8MnMHPTSyJwgli9Lv5RD30jSgLSkpwzJZXWP84Qc3c6yc/94tpu0KEn8pHa9xuBSgLi+0YOeRDR7O5zj73gYqNNitMom9oNvVnAaqNxYXnOJtvvld5dF2DyRNtObVtbxDnfyoAOt4YXBLlOshLyYKuA9Lq0aXmI0dd7xyjUwi8xUgca6P9753HVGOskPvTipbuR7JebGcfOHsYT6xbi2fcO9mK2GCbsDyvLvqkK5EnysNSpvsE/1kZqFalSm2SnH/Y32gbW5cczlDOo2MAKMYVUWL+Ug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by IA4PR12MB243497.namprd12.prod.outlook.com (2603:10b6:207:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 21:10:36 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:10:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 17:10:32 -0400
Message-Id: <DMFXGLSWYF08.30SXMF7OWKDN2@nvidia.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
 <stable@vger.kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Michal Hocko" <mhocko@kernel.org>, "Qi Zheng" <qi.zheng@linux.dev>,
 "Shakeel Butt" <shakeel.butt@linux.dev>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Kairui Song" <kasong@tencent.com>, "Barry Song"
 <baohua@kernel.org>, "Axel Rasmussen" <axelrasmussen@google.com>, "Yuanchu
 Xie" <yuanchu@google.com>, "Wei Xu" <weixugc@google.com>, "Baoquan He"
 <baoquan.he@linux.dev>, "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Kees
 Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Jann
 Horn" <jannh@google.com>, "Pedro Falcato" <pfalcato@suse.de>, "Hugh
 Dickins" <hughd@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>,
 "Pratyush Yadav" <pratyush@kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, "Jan Kara" <jack@suse.cz>, "Lance Yang"
 <lance.yang@linux.dev>, "Rik van Riel" <riel@surriel.com>, "Harry Yoo"
 <harry@kernel.org>, "Alistair Popple" <apopple@nvidia.com>, "Nico Pache"
 <nico.pache@linux.dev>, "Ryan Roberts" <ryan.roberts@arm.com>, "Dev Jain"
 <dev.jain@arm.com>, "Usama Arif" <usama.arif@linux.dev>, "Kiryl Shutsemau"
 <kas@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Peter Xu" <peterx@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Nick
 Piggin" <npiggin@gmail.com>, "Oscar Salvador" <osalvador@suse.de>, "Minchan
 Kim" <minchan@kernel.org>, "Muchun Song" <muchun.song@linux.dev>, "Xu Xin"
 <xu.xin@linux.dev>, "Chengming Zhou" <chengming.zhou@linux.dev>, "Chris Li"
 <chrisl@kernel.org>, "Kemeng Shi" <shikemeng@huaweicloud.com>, "Nhat Pham"
 <nphamcs@gmail.com>, "Youngjun Park" <youngjun.park@lge.com>, "Gregory
 Price" <gourry@gourry.net>, "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Rakie
 Kim" <rakie.kim@sk.com>, "Ying Huang" <ying.huang@linux.alibaba.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 11/46] mm/huge_memory: properly handle refcounted PUD
 mappings on fork
X-Mailer: aerc 0.22.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-11-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-11-6f74bec9a5bb@kernel.org>
X-ClientProxiedBy: YQBPR01CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::8) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|IA4PR12MB243497:EE_
X-MS-Office365-Filtering-Correlation-Id: 364b219a-63e7-4001-5411-08df346ebed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|921020|261026121527099003|4143699003|56012099006|11063799006|261009223027099003|261021123027099003|261022105027099003|261021121427099003|18002099003|22082099003|10067099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: tqoZgkyefCD9GVaBSnYTlWVsxTjxczdpbP2bgh3oPE6qREkgkWkyLz8J0RQEl3B+IR+BMgBkNBC6LCe4ai4wTizheBvS6ZgGhyHgHXJTysqWFPHK26p7JNMTKDWpbVUcVrJ93jOWt/PfcN/MBQpmEBKhhsSPvcDXtc7D/IvV7KCM9spxan2mD/W5amMSs88wdfE89+ty+WYKW6yiPfFZY/MLWr49aBdppws+I4zyrqVBfvHTcPQaXDb74BiGw7/nA4K7LCCwwni9hDgvq3G7huTcPd6/r0vHIgtG6GkYdV+dYCpTsownHv8UI6S3JSs8nVr6iL8cww9p/ryqj3aaPtRuCqdf/4a01NZj/Fpc7WkVHPeuWuHOAhg5siS3Uxc94Mp5vVmLiYdkWnrHhVu2BKHxsBvfzsLBr7J1+KPWB4uCyTfmkF9ie3YOiExZvfQUuCesd6MRLS32gHrJJ3F21esJkM/24HlgMboMAjwlJVjdMc7dz4Ki4+Hk46fXOiDL8HOAuFoH0g8MaAI1HBdMFIjLJT77NrGmhWxFuCw3o4jxwN2kWqJZDYPD2Q0TUTGJKZl7GpuRQlovNXts6Qhy5UPz82tTwSJeG4KAmeR3Aa8WdPPgMz69KmPW4oZf0cdBfUoDmS0huGL7XqNsXODVTTG7PbXZ6wODJhbWL7AWeZ0137qikuI6MRrTtw56eFWKbR/oLem4SZ3QEW68/URhXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(921020)(261026121527099003)(4143699003)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(18002099003)(22082099003)(10067099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVpDM1JSbEVCcU4rcWhRZnZUZVA4NjlEQWxOSEpWcnlZeXFCN012cFFZMno2?=
 =?utf-8?B?U29McXNpeXBxTE12VTA5R1FMVmo5RThCQTFCWmg5clA4eGt3b045UVozOFha?=
 =?utf-8?B?NndhL2s4ODdnbVJyYUVGSG9EM29CM1ZWR0MzMWowTk14eDNYb0VmZXp3NUtC?=
 =?utf-8?B?NEZZNVVvRW5xQ0JtRWMrclZmTWkzZ2QyYXdhQ2dnczhtS0ZHT1ZsejJhNzYz?=
 =?utf-8?B?UFMzZWRpSkQyK2dyU0p3dkF3eDdBOTZuYUdYQUVUN2NLT0dDR3NYeTlKZ2hU?=
 =?utf-8?B?blJVVzVYcHcxOFhJVHRnekQxamJqQmpwc2VETXV6QWE1UVl0Rms4T21YTlVI?=
 =?utf-8?B?ekxhZjBQTFdXaFg1bzFwOVV4NE9mSENtQVpaSHZsWVBlanpwTTN4YjY2SjJ3?=
 =?utf-8?B?aDMwcm8xYTBFN1I1WTlIeHFOWTFnZUFwMmtaQ083Tk5zK3VGcCs0QXlYVnIr?=
 =?utf-8?B?WWhyRjRLZlVRdjd5STZ4R1RMQndsSGdLMXhsUkp3MEQzcmNVM2lhNDRLQlZB?=
 =?utf-8?B?WXF3VE9IQm5RV2JUa3p4MkROcUdRSDdYZzk1ZjZYQTFJTGp5WDRWR3U5WXl5?=
 =?utf-8?B?Z3J2NHRpWFhqempQMFhYejRrQTJHTlpNNWxnbmQ2bjgvTHdsVHU1d3lrNUR4?=
 =?utf-8?B?Z2JnOGdWZlowVi9tSWtTU0oyNVZ6cmRSU1VmOWZOeWp1Q0F4YkpiSGJiUlQz?=
 =?utf-8?B?QlFoS3BReHdtaFhXZXFwVjJYamJrU0ZiaHJDSzBMemJGbS9LSGlOZzNHSDZZ?=
 =?utf-8?B?b25oMzZkd3VCWUttcTI5YWpIV2FGUTJ3Ty9yamlSRGgzZmxTcXZaM3JveERl?=
 =?utf-8?B?d0FBMHM1Vkl4bkpOVXlBdENXUTZHb0pyM2t3RXFQYjBFL1ZmcE9lQXV3NEp6?=
 =?utf-8?B?WVdSMEF3RVh5WjRZbEdPMkZlMnhnU2o1RjY2VncvaHFmYjVQSm1Qdy9lWmN4?=
 =?utf-8?B?RU1YdkVIektqa0pRZUpXbGV1d3gxcDdITW41M1lmbVFqcHFvblBSUWVYMGF2?=
 =?utf-8?B?VGI4RWo3OWk5Z2d6NHR1aDcyMnlhbmQraUsrVlpWV2ZxTlVWckdldHA2Z1pB?=
 =?utf-8?B?cjhaVzBBNHhhd3pqOVB2Q0RzYVVpbU50MzhzdkJsa3ZkeE1yRGQ4OWViaTFW?=
 =?utf-8?B?WXhDUUpXZ0kwekVrQmF2ZVI4UlJTUmxySzd5Rm9ncDR1ZktWSS9qYytoQ1Rr?=
 =?utf-8?B?dmVzbTBtWjJmZkdIOFYxR1Q3Z3RDTmwxc0c3K2tnSlVnSjV4OGlmemlXcVIv?=
 =?utf-8?B?ZUZncWxINjVBQmRRN1ZYT1BwUmk0aXpJYnF3TG4yOEhGcW4vc3B4VThDcVRH?=
 =?utf-8?B?UllVMm54b201cWVXOGpNdGpteXoyd2wrVEdyTVJLVVFFTytMUUJHKzZxUVds?=
 =?utf-8?B?a2l6N3E3VHN1Ykw3SGp0Y3NKbms2STBZVlJXL0VwQVAzNGZHOENjZjIvWEds?=
 =?utf-8?B?cFVWa2RKaUNJUkxDd3ZsVFZvcWxyRk1rTDRnektVd0pFYW9QK3hOaW1SRG45?=
 =?utf-8?B?ckZkSDY3RmFjdzRoQzZzWVBldUVwMFhYQUkyT2VXZVhrTnlMWmZQd1p6WVRE?=
 =?utf-8?B?QVR0VWw5VmJ1ek1pYmFxVkFRUHdkRkZPR09hamxSd3hlNmZkMDhWbmVTdmt4?=
 =?utf-8?B?YmNObkxuWXhkaktSNktZcVRRcmhmU3hlNnRocVM1UzFQeDhCVFI3VUZ4U2lj?=
 =?utf-8?B?V1hQNUp3bGF0cXhScFdUV2Z4Uzk3NEVzNjRzOW9lZ3JsMlRVUFVLbDlpSGR2?=
 =?utf-8?B?ZlA4a29jVzI1L210Y0dZRy9rVENqcHc5dlRtQlZzeDhsbjRRT3V2TVdHeVVX?=
 =?utf-8?B?V0toWTJsZFVhYUdjdEVBaUZHUTZRMXU3Y3FzRTBSVmMybXcwZjRhNktVOEdE?=
 =?utf-8?B?eG5MaHZqMGJoNjhmeVQwVFJWMlljY0lNTDBwNUFWT3JHb3FJbjRlakdzTE9v?=
 =?utf-8?B?dDE3MDl2QzN2NXY3cWgxLzBMQ3kvZTl1N0V4cnp0TVVVemo5NzhUU3RJRnZN?=
 =?utf-8?B?Y29xcWk3eHluVmQrNE5iUEdCYzFLbk4rU0gzUmMrallSZnQ0WUVrRk14UUo5?=
 =?utf-8?B?cEp0TFNYbXU1eWtTQkdaUmhGeDVDb3YxTWVQYlY0V1F4RTNGcVFaV2hMakRm?=
 =?utf-8?B?N3JUZmxYd0NnMGxBeWdobkN2SE54WFIwb2R5b2hSZ0w5U082TVVwZDRtTGQv?=
 =?utf-8?B?TitpVkZQUm5NNGJmaXhXeHFSOHdhMkNKay9QOFVNcXhJWklGR3JRTHhSdzBT?=
 =?utf-8?B?YmxnOC9NZFNsT0RJaW5hMVAxc2VWaXRBQzlCdjBYc1R3dzhlUnJyL3AwMHZi?=
 =?utf-8?Q?xv8vgtOTBGlTfsuQC8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364b219a-63e7-4001-5411-08df346ebed6
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 21:10:36.3668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOffFhSYYqxdQSUeTax7Mog/FCHRaWCmwl0OxmSJ4UAH8XumVetLoQu2ABMnDzKt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB243497
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_141044_535268_32C5106A 
X-CRM114-Status: GOOD (  10.81  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Oct 26, 2026 at 7:17 PM EDT, David Hildenbrand (Arm) wrote:
> copy_huge_pud() copies device-DAX entries without taking a folio referenc=
e
> or updating mapcounts and the child's RSS.
>
> For example, MADV_GUARD_INSTALL sets VM_MAYBE_GUARD on a device-DAX VMA,
> forcing copy_page_range() to traverse the whole VMA on fork. Any remainin=
g
> huge PUDs are then copied without accounting for the new mappings.
> Unmapping them in the child decrements accounting that was never added.
>
> Use vm_normal_page_pud() to identify refcounted mappings. Take a folio
> reference and add the child's PUD rmap and RSS accounting before installi=
ng
> the copied entry. Pass src and dst VMAs consistently instead of src and
> dst MM. Move the TODO.
>
> Fixes: aed877c2b4257 ("device/dax: properly refcount device dax pages whe=
n mapping")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  include/linux/huge_mm.h |  5 ++---
>  mm/huge_memory.c        | 27 +++++++++++++++++++--------
>  mm/memory.c             |  4 +---
>  3 files changed, 22 insertions(+), 14 deletions(-)
>

Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi


