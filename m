Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A112CAC5AB
	for <kexec@archiver.kernel.org>; Fri, 19 Sep 2025 07:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fg+98tTegNerBM263uZEtTcom+RrVSGH9ZWZ4syminU=; b=Iei5MnmnSxAjiyKV4y+ystkFtM
	pu3iSnutPT3XF7FB7D4UYcFtAVZaU2x27z3duJ4ZAVP67JYUUGd3RhpVzpZRrHC+1Vgv78YnK0k9f
	BxqzU/iGZiIYuqHhLN/vsibeFwbA1J9r2I8LM+M6shH8yXzVq9u7Nqx07Mbuk1SGz45gLCi1zgZaB
	QsovYV9cMo+pKuDikfqdTZEK/ZR3HuTu2pMBVAfj2aIFkxFta+WN+Gae6mjj98j8qV8WhWQ0qs3sG
	ZTTYYzsx/qMPsnJg9Z7MxPez+m8bsm2hl3XvNWP9rl0YUVkgeSEa5yGovlDNAqeljEZ0QMOkC/+oV
	dZTi+cKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzVwl-000000029zI-0dMn;
	Fri, 19 Sep 2025 07:54:23 +0000
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyzlQ-0000000EwWJ-1AjG
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 21:32:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJyBWfxHS9tnvWzVqZzFkI7OaTGQGREs89pigQCPKRvvx9uMFUYQMDaFEBTkfGy6DnaP2kZgfraazi/7hCej0BYILtlRs/FZM6G2PK/xToMdw6Vr08sl8qwkMrqx8+qIVO0q6OUqjlThkrBqKdpKqJ9oc9EC+gyBZt2pkAw+XBfb+ZyRcBLoE5zAkYGMW+0KodKYoqDN/tyW8WOi9VzQVvdKI/fsZbsMe047w5lFKe7nm7LIp8PXY+6LkcGzVOZlELZ/fkxwfgnX8maG9M6k6K0gn4Dc522bqY41KNuOWQ0V+FE72Dlp+P6vb4OmX9CVCXboIk4mm4XoX416UvoIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fg+98tTegNerBM263uZEtTcom+RrVSGH9ZWZ4syminU=;
 b=xTEOzTgyhdiIDIbuXE/lx8apcXJFoOe/GdcBtETJtuTedmhBhuqp5/6vDDWP8coS5WaNxUozwia4Bo7U7eOpaFfFfsg1cgCLpAWVFUSOLPUTHvv55clI5bAI59u845bGrT2HlqxalVgM/zIVu0rBQNF1nnv8t5b4YqSRhHfqTHSvxk6tVleDQYPDMT3JLD4kuIUFcPc+7HwP5xum2f1Q1W9gepjte2hCNA6WnY4ZuCmxQyl1WbupfaYX+q8pw8wflboo5dNKXBU81cw6w+S4BJQFDlNCISJ71j5/KvZpxUG7q4jGQd5NPlEHiIMVJpelZWtgOriLunX53nlVsIITmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg+98tTegNerBM263uZEtTcom+RrVSGH9ZWZ4syminU=;
 b=qDEtYj2rb7Fwr6uk4g4xQjiHfdmHGRkyc8Tk0Yzlq/OGt6iAdPDIJo7/QvSpOJC206pUWbAALSbOK4PK+S2pNeg1POPKCGiQel8QjF7IdfZrU4zpZHcdUV4TOYq6Bric33AlwwRKp0q/20yDQokU9hy+9ZwN0lfWbFhhfCBkISy/j5T2nyCT15ISVnEUP12udJpXq0ekrfc/9bhuLsJm+3iF34ZZAYlc2fJoVXZI/Tc26eWDqaCgv7oi6lfdtC00LT1oA2uyAqqBz4i6fBCWjKpCWAvJlRstuuMPtfm/eGS98mpbYqtLt9QKfzFKgaRZHcT+YpUPIShensR13/zg/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 21:32:11 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 21:32:11 +0000
Date: Wed, 17 Sep 2025 18:32:09 -0300
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
Subject: Re: [PATCH v4 06/14] mm: add remap_pfn_range_prepare(),
 remap_pfn_range_complete()
Message-ID: <20250917213209.GG1391379@nvidia.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
 <ad9b7ea2744a05d64f7d9928ed261202b7c0fa46.1758135681.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad9b7ea2744a05d64f7d9928ed261202b7c0fa46.1758135681.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: YT4PR01CA0271.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::18) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 639f8dc2-f2a8-47e8-7b0e-08ddf631a955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pJ45+/caKWnRywXZqrPOiqlVU6nevB5xbvSc8DLBDVGHRFHHyljnqTcf5GOT?=
 =?us-ascii?Q?rsPfO9RnTE/mE/MkkR+tceKjcHo1s9Ulf3PAr1vH6JXJMalF5yYvnOkIU8Ra?=
 =?us-ascii?Q?rD9MS4OuUgdcIdt0t6PiJ2ZOQhR3E9nB7MMRS2q27b7gB82kckh9djmHpQV4?=
 =?us-ascii?Q?w5PznvCz5l1Ph4WHmEkyGR3ezBt3OQc8XqfLTPodJhXIhKH6ZUKEldRsCNsi?=
 =?us-ascii?Q?UYscqIJRKbYu6Nz2qMYEpN1dpPOciK9RSxsSZ24AB4L6c9PJdSPQJ7uJ4NHX?=
 =?us-ascii?Q?20cbg1MRziQ5853xTjiHpNlm7LaV5OGldmWlhexeCOuBzR2tanh/jvNOA2Bn?=
 =?us-ascii?Q?/e+1i/0yY0yR/QQMy6GHz4TF7dUs16w2CoXPPfbg4Ej4I23xkU7InqPpksr8?=
 =?us-ascii?Q?yRMEQJtrrHcEnuMvz9CqYKjRCn9gKQ8XaNhG6OXs8I8nGptxydJ1VsSFffsx?=
 =?us-ascii?Q?xZrYBTkkMvJGIYJV2TZSoenVY/Tv8aT+LVIrzb0W87ILOWkJmCDc0czItESO?=
 =?us-ascii?Q?2kIcr4q+KI1Z5ToMovxnbbwQPQRt0MsbYGfhtGfWsui8LWNdm3YYxoLwI4n9?=
 =?us-ascii?Q?uBf0KlwEeXZMWgO2Cjotc7oAq93HbmKcZRJA7MqCXqmhDeE61kgPJmaD/P/D?=
 =?us-ascii?Q?HcGffUn11gpadt7FbEAsYFxy0Y5gLAnywgbi/+GHgEF0sLho6aGVN6eg2yDD?=
 =?us-ascii?Q?uyBIc8DeQK7r0dF129eLA+JobVobSgTKytnjSiKml0HQ2z+8FHdTb89qytfw?=
 =?us-ascii?Q?cQRxVHBdHs6dtDaCsuHdieyIdQ2BW7Vrigu+cTsxd6w3fUZkM5U7Hm3EnwaV?=
 =?us-ascii?Q?gbsZDpmAzTd42rFaUMVJqOyZtou/gkH+NsQj32dI2CsvQ10GNnh7r+9f10Rf?=
 =?us-ascii?Q?aGfDGGK1metNFvB/UP5AX65z7+6l7wC6yMLmL2m+47MEG6UtukdJz3xkZQh1?=
 =?us-ascii?Q?nGDbHGQk1MSJEjVdxaf0/yFarq4ZqwddcbSqMagjfERypdcEDxgmrm0S5mLK?=
 =?us-ascii?Q?VACPDV6K0SxyhBtud2LZP3dd4YdKKkGhHKwFcHK7b9mFYyBokSEyTE2Vdvtq?=
 =?us-ascii?Q?j57q8zEUGCTS0pEb76sTeMnLwTT4FfdbnKOsjLOImqNNOXafkJi8YD6SRKsK?=
 =?us-ascii?Q?vj3b6JCusav6BJhPXxPJhjvP6iqEQFn04YiA/tQX6HJtiJgyO2MYhrsFYf2w?=
 =?us-ascii?Q?Y9ZUSLG6ST/tT+4El5EwvMV+nEq99hqsYr8DYJ8xpoObtalMrkpBOU/fRNHT?=
 =?us-ascii?Q?S9Bm+uO7u+CNtDHhOQNgcAF/JBCtuIaGsN5W6z3Mikmc+qcXfh3SAIuQN8cV?=
 =?us-ascii?Q?DYZqhtaEn3Dy+ALokq8j1ow/vTYrc1ureU1Bgh37pxOm6Dx0cJsxSy3yR/iI?=
 =?us-ascii?Q?B/CjGoyZEmTKhBBOa/B06WsfkKCzwgTU7HHVYyTsCdYy4iz5vYsSJRoMXxlu?=
 =?us-ascii?Q?hyjR2yisLLA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VE1M5nI7CHqGhXFCR1h3SwjboeR9TDhDAS6cltLkVKUjpaIkBBbyPp2Jo5+o?=
 =?us-ascii?Q?latx4mQqsG9ecOG51PfljBdbnzY7l38GrDWxEOF7UzocMJoGftMPw1iOxStL?=
 =?us-ascii?Q?3v15sl8ieDcT1EprXi3L0Q78WVFzWsQZHPSCKOwOwh+9o8RmTFZTqZGdWPdp?=
 =?us-ascii?Q?DrOmhbT2icS1L3vqZeNvz//AJNxvM0pZiRi+3pqic7dZslLDX8D63Q9b1pH8?=
 =?us-ascii?Q?u5ljrzOdOxj3+urb2zEER00p8IN5mGFiMF3Ga0TEPDI5lBqJ3VTWMgWmZDu3?=
 =?us-ascii?Q?x7EEG9/IqF7bmn3s3uvOQ99M6zyG0nTt1xPxvjB/Si1+iVBbd+qyGs4l6O2Y?=
 =?us-ascii?Q?nqYb7p1Beav/QI0mHKQn8+iCE/N40x4xeW3XtSkOF6sc8HQmaK1ufm75aogN?=
 =?us-ascii?Q?NcPRSBm6REouUZjnjG/5QIssRxoR1t2nLUEYIVUDtd76nUQS8+/vZZ47ppRJ?=
 =?us-ascii?Q?lEcZHm4XykgwpXdWKT8SXEPe0/r4uYjBym5xX5XRHPinIOSdwVixEWkAYmey?=
 =?us-ascii?Q?upUv9g71WfHdiw1ae6hDOJ0GrjqNMZxAP8SkU2upAyKbxuiajxnZuTiLMY8R?=
 =?us-ascii?Q?yS2dPHOEt0B05GrENhkPsuP3W/o9D7tu5jlP+nnHMqRZ/UW3CBLKaa4DldqV?=
 =?us-ascii?Q?osLVZXydG8/Rwb9hqg4ej3ZQJmmTlZWi7lHJ1v+BWmw/5m6V77YrPQGILUcZ?=
 =?us-ascii?Q?LD4UtmWi8XgobvxKKdHMMNJAAn9Px+WKSfQBXorYfEYwcMJnk03pPuE7EiNg?=
 =?us-ascii?Q?BifZTNEj85cmfPE89Y64xekY67l8sjNel0b69w18IROAidmpjciB6vlbtVPp?=
 =?us-ascii?Q?VXt5vG6hOhXpCavjsOAyT5V/Bl7vTcofMAr3NWEV8YToZMwHg3Nnqjisroyx?=
 =?us-ascii?Q?F8K5c9dlvAu4TTUDr1fAxDqR2SPGd8Neaqz20cipL4j5UJt+ngnBH8b4KgrP?=
 =?us-ascii?Q?YhwGaa/8R4DXH0/lGTsmLP7MdtddR5ZGTr5iDVvFNQ6RmtRpBau10aUDl+I2?=
 =?us-ascii?Q?Hah8i4UMSHMmfENjVmPoM31phoMydeVgdtB6xT+10ZSP4jeaNAvLAVcC68MJ?=
 =?us-ascii?Q?i8zv8CsrrpUK3SCQiM49hoawkzn/bKJatXLykgAvIoSytQjre2HaNg9ePD2q?=
 =?us-ascii?Q?dg5/QUXlXUPYXGGZMibnTLT3JSVS8ZkOjFc/qrjNDq8lQJ9cH/H9FdFCCm1m?=
 =?us-ascii?Q?Qc8N7VzXKbJgHS8OjRJT9yEE5CNgW6Nd0M++z70EbhAVChljO63x1XOwB32H?=
 =?us-ascii?Q?EM1lfmGv/HKp+r945cXAO+HvwK9o+zPKTxAMX7zV6UVFhzVaNP0PODsD/ZQv?=
 =?us-ascii?Q?YYGL77PB+TtQcbOEK7UZBf3zVlVQ9lA1y6dg31hFMdYkvFESxtn2KnQEPLG/?=
 =?us-ascii?Q?toSm3wb6pEA987Q81quh7fvcFaDsg/7ZbLxiiWFPE62IjuON+VUjMsoIXkvu?=
 =?us-ascii?Q?Rr5f7O2c06w2UZmpuwjn/8PkqC71dg5xbFH9zvvUyCh+LIn6sQHsodz+yKWY?=
 =?us-ascii?Q?/fMSKupUMVb5ANSXU2ObnwjaN910ovIAy/qy11MIs/7v2lcedwR6Pb2Y5Bx6?=
 =?us-ascii?Q?SRjW+JDilZdPwP7qKEY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639f8dc2-f2a8-47e8-7b0e-08ddf631a955
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:32:11.2905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAcPgQzT+7q+cXbQ14vQdUdeWVMtd4UMmJsscqqOXQ+L5WAf+ODkmvyg93UIg6II
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_143232_318701_322B5C88 
X-CRM114-Status: UNSURE (   8.26  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Fri, 19 Sep 2025 00:54:15 -0700
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

On Wed, Sep 17, 2025 at 08:11:08PM +0100, Lorenzo Stoakes wrote:
> -int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
> +static int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
>  		unsigned long pfn, unsigned long size, pgprot_t prot)
>  {
>  	int error = remap_pfn_range_internal(vma, addr, pfn, size, prot);
> -
>  	if (!error)
>  		return 0;

Stray edit

Jason

