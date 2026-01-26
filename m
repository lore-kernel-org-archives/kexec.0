Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F02FD19510
	for <kexec@archiver.kernel.org>; Mon, 26 Jan 2026 18:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OGgbDAorOlXVLa9tJcd5082PBX9Ynel2eawhWF8bjOc=; b=MKWyH97AeJir7NA2Ct9k4ZdSm3
	M7EU2UX0jLfDZYM1sfVE/srRc7RWBoY72aKkX6RQD7QXBJa3kbgOs3i8mPA8WZ2AGdWVwFTJxplQk
	BpLnr2DABtziafBGJGoIS6pRKj5LaxIy4st1WBHfPZ6oRl/0T2qsqnWsWoJmVl8t5mQs1HQr7Cc7s
	YYOFUx1yQcNql2K6FqdFWPDuzMVCW/DASagCBaNzr8WB36op3ol7lanJpqRD1Wa39Ne1uAh9npPi1
	gVF2MQGguDovIvnbBf5J2KjQxb+kOy0FLadnvJQbZ1iMIoec4rXuZdRrvrCCQOysn/LZKmqWAoQ16
	MUR71TAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkRN2-0000000D5DM-1Ht1;
	Mon, 26 Jan 2026 18:31:28 +0000
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkRMz-0000000D5CY-0qaE
	for kexec@lists.infradead.org;
	Mon, 26 Jan 2026 18:31:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLmjNW0Hl7GfZLtryt/6xN3UbCSxsM0yj6Ab5anAh/j06W8wMdKI4E9Tthjd6AkSDEYlt6P7wGyDfwY+fFpfK1FP78lcICknvT8kP2ASb8MFgsX0JREQvv7BtZTSyJALpqkXP8M51SD1s5Kr1a5PkFsiJDUq/kGfG1nWTk6u1ZFJy4gEnzwyXvxyuUtXPA+BBlbkHBh6WMuOj9DQl65fc03CwL5DO5bH69iS//f4dOFL29s70g88kJG5Nik1+1d6avZu7WVblSW9lrIy0PlBc9m3J7NvTVl2/6QhN98uIoJniQVgZr2/ZE9aYY7x/oGdHgvrjJAPLfWGdRzOPzXfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGgbDAorOlXVLa9tJcd5082PBX9Ynel2eawhWF8bjOc=;
 b=Joesc7uqwej5l34r+QMKmKAYRWcmcdGpjEyDPIG+E9DuMK4S9zSP6s0Sux6UeGewLYheOkz4oBNA6MVpmoZD6RyY/bgaz4faONY0iKBtaKSU+FOIXbjpkFyvZ30SyAbWWnYLhzpdcw/TQ+vryrASipkG+0NT10iCUBbkhRwZIGYE3Agk4qatf7GGGAf4yCWwmxPusd+wG2UT+3bH5ciMtnewyNPv4vNFZktgmlJes+808Sm5hLv50yvea22FgviogyRJ3CCkJ50HP8igZW/1+v+ysPEdnOvDl951LRKxHkLSO1Gsp5yZYhb/4TLGpuxvj04d0TvFpNCncfkcZOTW/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGgbDAorOlXVLa9tJcd5082PBX9Ynel2eawhWF8bjOc=;
 b=fBC3gfX/VPHGgV8a00VcMO0Sbhl7zkQWogXESxeTAamR0fOKzEmv4RyxkUsJ1USPj0Gv4uA/2UIuJfdshKPnw8gUMz05XdaWn/LQkLvnGNAEOvTq9xJViYW/EzqzF18l9sPyftnrjCQVPBeszzY5hRUdfD2Zwiw3ZVwe5llvKmIvsZ4v0urWUlr+eHUM9laQmOSiYbsi0MMNmcZoqkjrbhso8FAfGO2e8sFqYBZsDmps6ItzVQJMJQCH/gkAyAiEIel+ovbB4V+AgRKv3Bn+SwZgGHfuW/Ol6b/ADFBxEG2VK5mMl8IZOpXFHv+Ycd02SDGlAmlOIpVjHZ/M2tuLdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 18:31:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 18:31:16 +0000
Date: Mon, 26 Jan 2026 14:31:15 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: memfd_luo: preserve file seals
Message-ID: <20260126183115.GU1134360@nvidia.com>
References: <20260123095854.535058-1-pratyush@kernel.org>
 <20260123095854.535058-3-pratyush@kernel.org>
 <aXYGkb-QtYNaWYw4@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXYGkb-QtYNaWYw4@kernel.org>
X-ClientProxiedBy: MN0P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c408825-bc49-4c3d-6e25-08de5d091763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qVtRhqhpUqs08BGXmuwJEi69l/IPsQjYBBWx6BpX5L6C5t3DZ/vDi2fxJW66?=
 =?us-ascii?Q?MOggjJpP2/nmelhwTLzkxF6XrXos/dYJV6/RkOz5HOQiNTVfMRxpghEh2fsS?=
 =?us-ascii?Q?MR52/XXa0KyZFQw2BNpFc0rhTRgFpjC+rjMUXg8VwNaSaV8ZiBg1QkqQkAj6?=
 =?us-ascii?Q?7Aac0lxCigln7wQYJ1yAggWc3yYEGsqEBytooRU84IiW+QaXRIWRxcuGsl0o?=
 =?us-ascii?Q?cgzgKf/yKkkIkerk2bKrrQsRM0fyXqFhy1gmsa1eLkwCBkuszT4YUvFe7Z6x?=
 =?us-ascii?Q?caeBBjPJ/BVLtFX82tSChzU68zsekwJDWoPCoKIPoyO3FsCcfd3AOLWXGPO7?=
 =?us-ascii?Q?grNepoKu1/R3mXGQMb6/vrrUZ4gmNlv6Fu0PDvqTGOvUHQ69etOC5orttfOh?=
 =?us-ascii?Q?ULjtQXBOsvVcmn+GWVI3/M5NayWaytWRG5A+oiReRITTh4MOuwYVkgkdzVuX?=
 =?us-ascii?Q?1IFlqmk+P2S+ybYZgLEuD0hFcyC8Hl4gXWh74XMME3uB5k25U6VY81LtbG67?=
 =?us-ascii?Q?rgWjARTKqw1VBnvqLyUEZN7B19xU4LKeBrFLq8FFprdf4BlJlRbkdztzSp33?=
 =?us-ascii?Q?fVhcmHN1+4ck6O+W8YsJlPLKNgXSjw/xZJsl0rBylbOd4wVy78F+byJX5uUF?=
 =?us-ascii?Q?V11bJSLp63DpYHRuaV6/mDbwyeABXWE8VOw8SDiBUmiBwOvSImcpJpPkPbi8?=
 =?us-ascii?Q?a/qEtzIPelqJPft8lqXenLyNSiLbpuB6FwnitZ6sgeZXtjkPr6zk72YXdk2O?=
 =?us-ascii?Q?x4e1VMVyccnBHOSlN/oFU0s+KeziHpkHr4oi0HiFJFV1y7acclJL0zS38ejk?=
 =?us-ascii?Q?AXLnHd/l6VikefaySFRnrAUMpP4ugIA1wZl1AK0/Wh6AXzXnwLUUY/cVO0kA?=
 =?us-ascii?Q?wTRfsEc9jDnbSjU4tVpKf4/7xTLxC62ID930d982Efgad1fnOcG9oIxynpMk?=
 =?us-ascii?Q?mCC1OvXmw8yHYhjOjyV0YMPBJURD99YxPd1FkFGy/xmctDYqU2QCS4pHhVje?=
 =?us-ascii?Q?vtopGl1TZIsR2wnxW5idcebNBHQmSh5Fs0/1gme5TdbdHVn+ha2A+sec80dX?=
 =?us-ascii?Q?jcKZKqVFjwfo+q0iC31N3B3V2GlLIeZwY4hc2WDJqgo2iH1unxvd17D9/R5u?=
 =?us-ascii?Q?UgcWAw5nOZ7nvVOWM9H1yFXKIvQ5YBWjuEHOrV9gKqBLIDRb+Ru1najBIDkq?=
 =?us-ascii?Q?KqYq54o3+SOAO2MSDznvyvRCc5ngjUZzVobcXvrAeqjVUq/ZLXGdp1XLm9/M?=
 =?us-ascii?Q?v73WkrCEFOmq6vSK/LtmLUurmQ+4rWFQDWzJt1nhOhBexeTqjs6O/+XTf49P?=
 =?us-ascii?Q?fTEIKHsfkOI76Nlii+tJBXk3R+YO+lnaOHh69hTrRx7jrmmME9OlGiFv9GNJ?=
 =?us-ascii?Q?xJPIFx2IQH1VbCO+3CdQtzO2qtisnBAVFY9CSue+hYGCebG2flSNgKgjaC8w?=
 =?us-ascii?Q?0iajLh2sbZL2K5JkK9zDlo1VcMbmkZHOLC/EJpiA+4UjQaYJ+XrjAhEnVDYP?=
 =?us-ascii?Q?HrMeKJHnP9OUzMXdWcPwuP6H8JmnhPDLCLfkFK4SVDoCZKJUHrkxIWtMLv16?=
 =?us-ascii?Q?zSQ53v87wperW1P4aSk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7RiP5vUpibKD/rv7qPw9+OYKR5HTkwvbGyjedW6gWoh3Sp1YCedgbyxBoC5b?=
 =?us-ascii?Q?PxihbZmCBRpzv/oTK7Z1Y6eLUp0LkAB4HtB3dKhd8QgsLrlryB0ygqzIoMYR?=
 =?us-ascii?Q?PTFDRB1WiKMZvJ0YeIHwpk3BNhK4KN31eC/li/WhtOwi1jDZncBPubylCcq7?=
 =?us-ascii?Q?F97AMXAluK+9eaSI5ax66uybaJ0FW4ZstxZOh5tLNsZSo4px8Mev18GPfHbL?=
 =?us-ascii?Q?3DCZL1eBODfzsvvfwaBSxoZ/3uxfxOCri6nBAdXspKJc0cELzeE51zj5sbYP?=
 =?us-ascii?Q?JNY7JFlsD1HKpRtepTQpeP/5R9hWYvsy6+4nAgJFbOMuZSP7c5D0YsqqzURj?=
 =?us-ascii?Q?ym6HKyR9iLqUOk9iVYkJCk8MT7aJOlYYOLtN0H6qHqEBg3uX1Ev4d/hv/qox?=
 =?us-ascii?Q?UftXpLAAjSZDeIdME8JJbo94OkMN3vx2F0kFcmLEnMOgSk97ksUoRv1KtKZi?=
 =?us-ascii?Q?MX6mss/n5SDyEzB3MVh06P31qCAI9qMuw3ckduycNCMrEADCWrV1LbxKEz17?=
 =?us-ascii?Q?nOK146WhG0ec5NCohu+SlIkDv6wSIGpKLymWHKS7HUW8oOvsEc8amNxiVoxo?=
 =?us-ascii?Q?JLSa8ITvNBoexQC6w/ffi8HWVcDLxkOGo2IXLsTPVDT/M79k0cPqRCkItnPg?=
 =?us-ascii?Q?/n0awa2EOc9Y+UKQRYctsgvnr5Q8SRe/HNtv9YbgCeQVKyi/wvjMON5VsuvI?=
 =?us-ascii?Q?Y8dg91TWQR+gRVkgB4xPNFqoc1sNA9OqTtdMzlx0czSLy6GuSpy5YX+opvbb?=
 =?us-ascii?Q?FIMveE4lgRpHVd5HKZSGNxrchHrSIwdPhNm8AZx+pMPwdNS+wg3ttVfEbseK?=
 =?us-ascii?Q?E4Itw2ML7NRpFotmMTqhEsKpWK3CFuHi9S+/GqEozn+rbh79+JugOzq5ZnkU?=
 =?us-ascii?Q?0FxANeDCPiYEd5FQOShq2923tXFzrpQzVUqZzbGY5N/VUTqArd47MYztDzAY?=
 =?us-ascii?Q?A2gxyGEzfP9Gbu5eUeZATMl4SDUJ+TkLKjY61FEqKGOE4ZfMiYHNIK8M3hGQ?=
 =?us-ascii?Q?8IDEWC9kPN2PMggA3MVd2+4LoR6rGMwLqrNVYpfQRS/rFOvLSAqlyWfqDcp8?=
 =?us-ascii?Q?yF/2/o6yXPGBL8sjlEtW0liugWfkqdQXT28p8AoAqXJ8PdUKZ/Vu+ugizJxD?=
 =?us-ascii?Q?wjEJ8fbGG0xGKvAqrB8o9WY29ZoRLdBt15WQVcWs7i1h/TY8rat8uL4wUKoG?=
 =?us-ascii?Q?Gzx5llSX6BjIrF60Jb83EAXE1HgDVog3LuZSF7VfYdxRWg3qIAlHJqEXVDA2?=
 =?us-ascii?Q?eVcIDl/Jcx8s4n4cwAorRGmBpiWPRrcCbLI2GOfy3nLh32HKPZALo4fJkGon?=
 =?us-ascii?Q?dUX146D0fSZtXwBZHQs4tJDhQcfdJrqiIB/jmEFOWXuyudrNdqh8ZFUx+UKR?=
 =?us-ascii?Q?VKFbxvEfuQXUOsI3GwuXjqY0CGV6JczbW9gL8FdGrBD3NvI3GqXmgvu36KFW?=
 =?us-ascii?Q?RzWKedSwOG6bPaYZFRrz0WH85AxvpG/jgOjfZnDxtM2IkGhdZPg0XMhF2z1F?=
 =?us-ascii?Q?gqoDkCqfN2C7GLNtp25wOIU9SRRVKxM/l0fpTJy+X19xSqYja9Ti9DNwBIGM?=
 =?us-ascii?Q?8xKTNHwXjpXI7KPosHMbfUI5Dx9tQQxAlrvTrm6c1fv7nnEBU8/I9FmI0Atn?=
 =?us-ascii?Q?lrJgdjPQWPD+mxpECCy+OyKJ+nwgnjD2keLhU8yaE3L/g3tyGb1mmaKbsyrv?=
 =?us-ascii?Q?eEr5q6+aP9hjbSUOclqAdWhpVCaTdaJ1ugdbrm1Iphks4vaVKKdLoHzAn2bR?=
 =?us-ascii?Q?hmtstmXXeQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c408825-bc49-4c3d-6e25-08de5d091763
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 18:31:16.2738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGW/oedD6VHy5jh4o2wrNUWI0XLhNUkGeLyDPxtAVQTwC8TsThNgy1YdDK5g6Y5F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_103125_242440_F07AB2F3 
X-CRM114-Status: GOOD (  18.10  )
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

On Sun, Jan 25, 2026 at 02:03:29PM +0200, Mike Rapoport wrote:
> > @@ -67,11 +72,13 @@ struct memfd_luo_folio_ser {
> >  struct memfd_luo_ser {
> >  	u64 pos;
> >  	u64 size;
> > +	u64 seals:8;
> 
> Kernel uABI defines seals as unsigned int, I think we can spare u32 for
> them and reserve a u32 flags for other memfd flags (MFD_CLOEXEC,
> MFD_HUGETLB etc).

It is a bit worse than that, the "v2" version is only going to support
some set of seals (probably the set defined in v6.19) and if there are
new seals down the road then this needs a version bump.

So I'd check that only supported seals are set here:

> > +     seals = memfd_get_seals(args->file);
> > +     if (seals < 0) {
> > +             err = seals;
> > +             goto err_free_ser;
> > +     }
> > +
> >       ser->pos = args->file->f_pos;
> >       ser->size = i_size_read(inode);
> > +     ser->seals = seals;

..

> > @@ -444,13 +453,23 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
> >  	if (!ser)
> >  		return -EINVAL;
> >  
> > -	file = memfd_alloc_file("", 0);
> > +	/*
> > +	 * The seals are preserved. Allow sealing here so they can be added
> > +	 * later.
> > +	 */
> > +	file = memfd_alloc_file("", MFD_ALLOW_SEALING);
> >  	if (IS_ERR(file)) {
> >  		pr_err("failed to setup file: %pe\n", file);
> >  		err = PTR_ERR(file);
> >  		goto free_ser;
> >  	}
> >  
> > +	err = memfd_add_seals(file, ser->seals);

Because we really don't want this to fail :\

Jason

