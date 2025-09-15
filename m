Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81855CAC5A0
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 20:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bx4uWWlu8yYCugcQZW2osJLjgLaur0EGG/CnxUsdqwY=; b=hsjY5nn/mTwOFIyFWP2o0lsLev
	CG7q/o0L2kF8oqIh8q/sAQ/6rYGDzHhP14etsR6XPh6UTnB/5iQYzmF5ch7wiAIZIRYz6Ap5DnlLx
	9h1siWkdr9C9pphTfKU6nEodicJR9Tc4e1QE13A89i1bA/IFE5ZkzCp1yMwnSF8itgME0r9NPz90x
	OAvrxyh5ItSDp/hePVRiv5cBs2k0dz6f6hI5tlzRLaDMoIh18vw0n2ReXY20A00oCAHjji4pDA8kO
	/4xkhgQMUBxui+qEskGI8NCFAAuT0JXQ71BfHlfw3bl5cb7YNzG3q6GFBH87SlTIGhhJeoqtJnOiZ
	4NceBmWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uybxy-00000008w5p-2H2C;
	Tue, 16 Sep 2025 20:07:54 +0000
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy83E-000000044vA-2OGk
	for kexec@lists.infradead.org;
	Mon, 15 Sep 2025 12:11:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQrQAg8fwI5o0BvmZDCf6ejxPbckcuaEuPFHgzp+/YlfS9GfsRR93RKMBs0dRfo7uoMisVc9OFSCC0UXqkwx3sx1Jl1/zKDkQSVhm67UqR7u9pafURXw9SdH1ImES9+LWLtVJuGImJSlN09HdIvaYoPt3exBdQjiLEayJ+Np22Q7rUiFpTrSDnehV3GtVI/mmtklLMjZYpaO7M7CwQBVaJSSL/AYeuuhpq4zi8Lg+f48eABtincCLpTyyBdJQmElouv582v+dJKrdEsulbiVl3jfmffTdyR8d9cHUclGyCQGo17Y07ciOxH/1SqlWoTm46YvdQKtkcsE0aVULILVEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bx4uWWlu8yYCugcQZW2osJLjgLaur0EGG/CnxUsdqwY=;
 b=PKmTj/blt8jcKrf1rlc1cK/EO5bkvltofj4ygUhG9D5JCd975xU5tIpsjfapmVj2kOEFgWUGL3mtoWGi5SXTkxb9JoeHEH2V3wBWMbrTLhlGvTu712WXPhulMfzULn7tWSMDeXMKfvVayKmiHTlfcqomck3VDyf55dw4hfEgVl0sbsAhycKQ1nmamEdHuam+e+szHqEU/JG+FwGwTnNO5zH4+/x123/gjNzGIN6r3RCOw3cGLXG/xTWE9XCHK2y0TBGZqURTdN3AKhJg1IqDW02aIzt8S5wG3COpetkMQTzdihsMQebCu98U+/BJ5bFCgdhA3m/OJv746PfisyM6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx4uWWlu8yYCugcQZW2osJLjgLaur0EGG/CnxUsdqwY=;
 b=IJOhYeDv7fc1i0khuTADP6IIOn43s3DgckE0hMs1IMBXi/vvIwG64gU+XqgqmVk9jOKtRBJVKMrINs8IV3Ui2bccifyujPtLbosoxrc1g9rIx1SY4HxAeBy6jNZlGm5eSmr4P2GS+vwFx3aIoQvYq7uAHtBz+8d5ED6iqhBwuo4q2RC9G7iY57Iq8ju5nDtXp+EKXKvdvTrnOBm3i89FQGNgZyaUT4fEvJVNIVQELJtAAaq2MiavvhUGaGe6QieV4mswrDmiBEtwc/Ynkwnjcl6r0bC3LdTNXX9hdY9AiraErsA5anIl+lJO+r8k3joOKxUd9Ii2IC/xOCMm5oDmyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 12:11:14 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 12:11:14 +0000
Date: Mon, 15 Sep 2025 09:11:12 -0300
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
Subject: Re: [PATCH v2 08/16] mm: add ability to take further action in
 vm_area_desc
Message-ID: <20250915121112.GC1024672@nvidia.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: YT4PR01CA0188.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::16) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 4082ca6c-3820-453d-8a18-08ddf450f784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dzsySAwkFVc5J7k/gJGmr9YXF6rld3I8L7Y9nzDZoHSX+fOgM2GPdL7EA6Vo?=
 =?us-ascii?Q?uEfz5IMOPZhiebdbzHEQqpCp0DIgrbnKx6Gg1VLLudlPB812S0nRIZZdn2N3?=
 =?us-ascii?Q?2v0qvhxj5uhB59qpfseTP4JXSuHKBhVCtfTbGBUBBSSsPSZQf/vLzC0ABy7u?=
 =?us-ascii?Q?aWFLqLYcSNBanp3S3/DxXqmq7Zc/F+M+/kJtGMEJWsRIp/zogAflhHMANvI2?=
 =?us-ascii?Q?gpjQDXq3RzrpWHonIx0jZwZmSGVbSdYQp9s0DkZQkOV8khbb5Gunr9IxXTPs?=
 =?us-ascii?Q?s6hjVz1EVX0j3A/MUM5n/etizjl+dkPV94A6JSem07417uQNyisPtyRdUwFw?=
 =?us-ascii?Q?OjNTmbKM76+zMjs+SVaLoGIF75dtN7fxxGubaqWuvJngyrNop5Ha0md23JH3?=
 =?us-ascii?Q?VNqrT+FZ7PBmvSCxDB4H02PXnhczW0cDZc9wDeg9tiYIxMHC7ElibLqYlj4K?=
 =?us-ascii?Q?BxLa0G5d9IWSEx6TQ4mLx7utF6aPJ/6MQ+Pd+gQAIJbu7ePahUgxUIEmuBx9?=
 =?us-ascii?Q?qe4OIG7RkoCuv6S1gg4Z2OCC/v3unmoEFG7vsUAzwCb0S6qQAVNlglYsR6JN?=
 =?us-ascii?Q?hDwRVkV4SucBmWUdtNTAkPzgZQ16W3zhFEBH9fufRf1K3ioe5ofyEhNBNmyz?=
 =?us-ascii?Q?k1gI0ip3MEm4bqv33iltMrFkluE+qG7+5qpzLX4OaQ3N98zoegTuLp4eipGn?=
 =?us-ascii?Q?G4sAesxdDI3LD3wJfKjF2aUmqfl7aB4lkiIp5DxoyePdaX71pvkTYZctJebv?=
 =?us-ascii?Q?Moe5bGlKESGR8OC2FxkP99MZ7om/VsJjgyWCHzEsYAg3dNF+wSqMhdLKT2bU?=
 =?us-ascii?Q?5lFfWtpo4bOKJqdH+gJPQThIdwww73g8kcCyBxHY8X6U4IretMj1eY1buWEL?=
 =?us-ascii?Q?vWr7LvY2UlvGk5o9WZQxrNmaASoauxkCMSPqA/b816c5XZj1Cza8tq4tCHCX?=
 =?us-ascii?Q?13KSJaeFyTVbGt2sFthvhM7jWpsGI6al/VPfMkHtBMU0rpnf1I14ogSP2ozH?=
 =?us-ascii?Q?CM31c1Y9842aL5l1uCArrjJeB5SUNZUcicoGvQiPR6qg3JKBm94N5Ak9YHTz?=
 =?us-ascii?Q?mcbtm59LeiPUvWGizY3/nD6LAUvKcd/U2fqwojr19p5Ws6uwiHoDAHfHFMpV?=
 =?us-ascii?Q?gjFMlCaOqXJmyb4PE8wAcwj6kvAEl+ry3hgtWoIOrjxSSBYrnMijXHtvpauO?=
 =?us-ascii?Q?Icpps3DoUt11a5X6jK2EeRj/R1mTEbAjLKCXTlH5Zbh5WP1dEDcMwsPThqgK?=
 =?us-ascii?Q?vaWFBvPIpkfzXsT55X8OJNo3sxHZff5bs9Ostg6jQREMZOk7zUnwkp5ueGQz?=
 =?us-ascii?Q?Rro070McqwpY1VxHxZA+uIZA8gqlGcadtmgo6OZF1t76qM3W73M8YEfV1Oeo?=
 =?us-ascii?Q?GHaOt2yVk4xozs/fOg9Tn7eoK62JpndnV38f/1SuQhR1IHdTxFF2KtIqtgsv?=
 =?us-ascii?Q?450zTlfE8Ak=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KVKj9+BouTdnTX+BdH9uwWNlRf9+k8iuqaBjUMna9pcCNwfSgbFkdKi6mnDu?=
 =?us-ascii?Q?0KWrnnPW5mBGhx3N5ojzL5bio7BSpG+yFFG3ATjikBcXTpdRqv7cIjiNo/qJ?=
 =?us-ascii?Q?EeAKVN7kEyc0ipGhxEJj+C6i0pe1hWFUOGDqR4G3e7IcmBAhU3xtYMr6QsZr?=
 =?us-ascii?Q?DOXPiU2zBdknVJToIxQFjpG8kRepn7u+FgXhklLePUo7JTrIUbb5SQzSxZT4?=
 =?us-ascii?Q?M3VehJ/Mqwnz/JyBYW/DSVpQjc78jWNX9EOBxRt3FVxHkGYlCdcy2ZECydal?=
 =?us-ascii?Q?SYKdLkbJA8Nhof8L/6DYa9C1bvG/Bux6TV/1aq9s7fWSuMGN7DaiZS1rlAAA?=
 =?us-ascii?Q?g/fbF+/Pz0laxRCtEOxc9hoKz1DKiiGYPBTC9jIOfjQk7pyZD9+5ZbV+zXpy?=
 =?us-ascii?Q?7VGq9Uztn5fCim+5jXc6T9pwFW5wYSJmSUqbukuo4iod5lk4IEWqe7/6zzDl?=
 =?us-ascii?Q?nPFT2iKrR9LceG/0EvAcJEuJG7pByPcMg2Efp7zLkMuP50waGHq/PpFAorfK?=
 =?us-ascii?Q?HvPq5jikhZp8XCFYeYzMFnotwJpj6gzs/8k4STa+oxrnd2UAfOq1ZQ0bfVHL?=
 =?us-ascii?Q?Yu/DS4OULMx4D8VI6B1AAI00+hoyNAt3vJCQbzLhAPG+ot851P8FCITNvBgB?=
 =?us-ascii?Q?owphiWVU/VAWls5uwEtO/OX1u6mo1qO8tErti0AWa45JqIbNxcjX37pp/4Vr?=
 =?us-ascii?Q?f8mpZMQzTwGKOCLaK9fn5V7XbcPUGqRGJk25bMJuJ0M2Jhx88EHRPUxXRPNf?=
 =?us-ascii?Q?6l24bvhY/l7qhrKYq9hMEnqEvHABfSmx6oMOne6dBh5+ghbm0JWm4Kgc8Lbo?=
 =?us-ascii?Q?aPmuO3BiJIcmi7kx8WIPiLlrwbc3bGNLimhzciIXYh8GKaBroFxh2SGntcUf?=
 =?us-ascii?Q?m40Jj1YNgW8VdTdyfwVefbVeTuQ8s/Fm8msHqZlfoz6D2sTdNfXzmLvD7at8?=
 =?us-ascii?Q?EP1eG/dgaz8ijPbA1ef6WP7a2CkjyjDGomOpytuHEqHcjlzg+Z1Z54ptov4w?=
 =?us-ascii?Q?yLiFAU0csnjarMQcN0ZBICbQcHQpqJsKeMseNJkM9wj2EowGhICS/c3qoc5o?=
 =?us-ascii?Q?iXOp5DcaEwX1Au4dW3Q/h5P+fRyT9/Mp33e6qnve2DRO4+7XRGjIX2+vpl6r?=
 =?us-ascii?Q?UStMCjVEOSaNqubJJwosATdQptN2ZPgx8Y9Th41jaW81ttGgehAW7gxEUEGv?=
 =?us-ascii?Q?PahBSxPzmHwUv2tjbZ/bqQ6L9U8f+CLPx0RB6PVvnuH08ii0byYqIF+SU59d?=
 =?us-ascii?Q?XRyRmkpq34ONsM7RzSgFO7uT+LOQsSGvRCcBsE53lAcSbz2k4psjoi1tLejl?=
 =?us-ascii?Q?QkVX754z23S5iQeTP8T3uNBfcYA0JFGo/kNW88onTJ+i7xTgXWq4Sjtw3yA+?=
 =?us-ascii?Q?IAS4fWs6gw46kTfkI3mIsk2z/vqm//0Dubcv0Kl//PMoWUHlnKQSwGt37ANG?=
 =?us-ascii?Q?li3Onq3S7Fy4H8wE18n4C7amp6T44Ia7KJLWxHU5xhqhOItsMm54ZxMUqc8Q?=
 =?us-ascii?Q?+XXSHM+OuSmfl++PuzBOA1KATMc107FR4b/poyW1UnjKPxX3DrsQcAZAVnmu?=
 =?us-ascii?Q?IKXCdpSj7k6C3fdSZPc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4082ca6c-3820-453d-8a18-08ddf450f784
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:11:14.5370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRRlItnu8SXrt4No5ZKs065QCVFt6ZERgEYfgL4f5Cw3eSNI3JMMNoyv9KZ9Q9ns
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_051120_611497_454D01BA 
X-CRM114-Status: GOOD (  12.38  )
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

On Wed, Sep 10, 2025 at 09:22:03PM +0100, Lorenzo Stoakes wrote:
> +static inline void mmap_action_remap(struct mmap_action *action,
> +		unsigned long addr, unsigned long pfn, unsigned long size,
> +		pgprot_t pgprot)
> +{
> +	action->type = MMAP_REMAP_PFN;
> +
> +	action->remap.addr = addr;
> +	action->remap.pfn = pfn;
> +	action->remap.size = size;
> +	action->remap.pgprot = pgprot;
> +}

These helpers drivers are supposed to call really should have kdocs.

Especially since 'addr' is sort of ambigous.

And I'm wondering why they don't take in the vm_area_desc? Eg shouldn't
we be strongly discouraging using anything other than
vma->vm_page_prot as the last argument?

I'd probably also have a small helper wrapper for the very common case
of whole vma:

/* Fill the entire VMA with pfns starting at pfn. Caller must have 
 * already checked desc has an appropriate size */
mmap_action_remap_full(struct vm_area_desc *desc, unsigned long pfn)

It is not normal for a driver to partially populate a VMA, lets call
those out as something weird.

> +struct page **mmap_action_mixedmap_pages(struct mmap_action *action,
> +		unsigned long addr, unsigned long num_pages)
> +{
> +	struct page **pages;
> +
> +	pages = kmalloc_array(num_pages, sizeof(struct page *), GFP_KERNEL);
> +	if (!pages)
> +		return NULL;

This allocation seems like a shame, I doubt many places actually need
it .. A callback to get each pfn would be better?

Jason

