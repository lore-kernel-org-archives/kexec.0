Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BA8CAC597
	for <kexec@archiver.kernel.org>; Mon, 15 Sep 2025 11:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MQL2enNrilG5Klwx19AbsAsgsuKKC9g23G2o+HDUSm0=; b=uKno1luPdzmOP0ePOd8Q3T6Bds
	Yn++9Q1u0QlhZDDzXggJhrA6XgkwoObzgrBF5wcrGEGL4nDIY5D+5746gmEFeCEQQ1vTFEJrT6v5c
	68Fu8R1SoFS/7NUrS77aFm3cS1qsFu99PfWIorNJhoBt4do4qdgEU9lAW/dTX1TBIqqj4DMKiMafs
	69/OnPXX3umANgwH3ZKh11y7hOZ6rV4FjZhXxql5YRhO25bUKkFq/oJQzehC6grW7OOA6KhDF/AQt
	eUToncPJf0YmeFtTT9PQto61Sjwi9qaQYhE6rVC+82eqGn+vvjyoAMzhRXF1AmVjUOYKzbaEJiztW
	2V0jW76w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy7fw-00000003zSR-2UIr;
	Mon, 15 Sep 2025 11:47:16 +0000
Received: from mail-westusazlp170120002.outbound.protection.outlook.com ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy7ft-00000003zQm-3qrc
	for kexec@lists.infradead.org;
	Mon, 15 Sep 2025 11:47:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URN7+y2kuUhg/OLlMubMrAxLwgpfmHEMvwRcf5UlUseL2220CcRVS6Alm+SBfO+Z8mIpchvH30z/9EEI2Cj9i/I0qh+E7H5i1KKWAqabrvKNbRmEw375oESj0r/pDOGM2oGcCVxGPKN768KPWoQ2yLy4oLNHNKWgKBIE4pfAzVecXyhUBqNgbcG8w2NCC/lyhi6BVHXN4ts1kG0QrYfA+1bBabH9TKpjNW/xChiGVux8iPHIRRb3frMMAVSNziK/XwctNUNNXWgKuHxOFVOGcsyGcw1xrqW28mamOfjKRzdFLZ7mGtEYjK6bKk8NRd3r7xcLa6PvE7KB5PMZayeTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQL2enNrilG5Klwx19AbsAsgsuKKC9g23G2o+HDUSm0=;
 b=ZqGa8J51qopkUhLG1y1HIm59q6/GF2i2XM6zqLDPDqX8Uf+8l7JEnT7moSjR/jjUmvFGtXcrWOf+OXFyvBwKn9w2LhjnyGeaZ3tffVH2zsV+rAle/k6puiKtB6i/j+AcaB0kJy63DMzyt2xb1F9hUip/F5XtwLxdiREli2XI4+/Ab4ZSnbr59NEObF3hEK+UAWeLSo+fY4x/T3s6hMlTU4R07SXArsGqaw7oAf3fTBek+PWEmIFvQV6zf4nwIjCaxSwhOisfY9CMNFXxcC9ADTspGWuCNRMG0RJW8eP4SiNvYLzXED4toTwffhd8QioYSC9Ih3+wXhipUpy9dc0sAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQL2enNrilG5Klwx19AbsAsgsuKKC9g23G2o+HDUSm0=;
 b=Ls8iSwrAICxUh3ZGsRrGYcvdizlRBjTfhgfh5lrsj7Al+Vdbf+DNQJI6QskFaPVSWtILJYaEDN89WrjTKuPFM11bkQruZKoP5zs12+Bu5V+WVLIztLGFTdYIZFzmkERDiF1jr4uMew/5dskf5xAwQ6LPIy5DJO2nn+6dUGuQ+dtqdunLnqjpeeclOqj+UrD6BsNgzuHNpdxLqZMRzD+YYB2R/6gC3fwGvGQcghzO5gxi7PHFLS0A/UqOqDwHYdE4chfq6Su/t4BZhAls3A/0VgR6yegm3nWuHjIal8StGUWu9Xv1bLVWkwH6AnsIkL18Mn+MunueU3Nmco+WrjMgJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 11:47:09 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 11:47:09 +0000
Date: Mon, 15 Sep 2025 08:47:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrey Ryabinin <arbn@yandex-team.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>, James Gowans <jgowans@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, Pratyush Yadav <ptyadav@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Chris Li <chrisl@kernel.org>, Ashish.Kalra@amd.com,
	William Tu <witu@nvidia.com>, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 6/7] mm/memblock: Use KSTATE instead of kho to
 preserve preserved_mem_table
Message-ID: <20250915114707.GB1024672@nvidia.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-7-arbn@yandex-team.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909201446.13138-7-arbn@yandex-team.com>
X-ClientProxiedBy: YT3PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::6) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS7PR12MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: cfea70a8-0fea-4dfd-1c13-08ddf44d9a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ya7ru0aU4mx4eNJfhYHQaXo0YhFl/wDFmoA7Hv+DC2lm/QLbykiv99UJwS3C?=
 =?us-ascii?Q?9xlCsALTNpIFfvOGlhveW7CoMeqycBnVD4ShpC9VY0O4d/7ttPUQAqjZkQnW?=
 =?us-ascii?Q?6hZkU5PFpwp+vDJAd8M+vmtMFeZ9ylvp9wz526thiQROI2Wl+w5pdL9I/i2o?=
 =?us-ascii?Q?mPxGe0F4ABxOddx5LXRtu/7o6LGCquW3hPxQxyrEXzdf4Wpg0NqhgeM4SXEe?=
 =?us-ascii?Q?+T3f3+xJnt0AIVR2Jnk1PRSp2eiBaFi50eEx6MU2f1FA2F/l/jXd5yXgy3xg?=
 =?us-ascii?Q?lOwls2WK14HQ4QAee3kACXyc5FruEKx8cyMsNrpt4P+DtauV7FP3hrfldIgd?=
 =?us-ascii?Q?vFxKQQWTyGbqYBCmeAuStYLS/+mo01s0UE9m0J/5qIOA28cqojZVo9AhWF/V?=
 =?us-ascii?Q?A25rtTcqXrajnnx8enLmCj4MfapgDZYHsjXqUi2/rwnGWj1zmnxdI28S4PyD?=
 =?us-ascii?Q?kYBggthmfntuUzSXg6gfDsosQJzi7YmQhNd+6C6ppmp4thY506pavlg2xptx?=
 =?us-ascii?Q?I0Sav6QJNmjZK+ybrTfooDiX8dPmAExVZJifwES4wnMIBc2Qxjy/kAeYF3y4?=
 =?us-ascii?Q?+v1f9xfmQqLGwxXQ1sEb1OSqBIzRuNu5TObTppF8t8AEXQyEDQ4Nt1QP/wAS?=
 =?us-ascii?Q?gVRc5iujopKZx7JxUlDuDPE6nZbs7AK0e86W/0/D1TWitCxoUX5K86pxB+gn?=
 =?us-ascii?Q?uvaC+aueQahjOzbSWN3zEe7sIMelIlIhmNHjm5zZgv85q3RQ0mL+7KTFadX7?=
 =?us-ascii?Q?klc3qLAX20nrzNRrRCAze8iDnsoDbJtxNkKmLPjftv3LnyLbYTZPcXXQg6gt?=
 =?us-ascii?Q?zCr2mn3hUBFFcmFRwJPKrHSQfoXawe3t3YzMKQ5gl25NRiX1peUTid2mhntp?=
 =?us-ascii?Q?7N17bZRHSmagBzeyj6bakQI/RWIJsr/9of33rRcDMIaD5htFzruyRM5Tkj2m?=
 =?us-ascii?Q?eKQwj/bR2hwYletFtkxHx0LhLl2qwBtxsu/u5mkVHooDMJfPkrodmX6nttL2?=
 =?us-ascii?Q?6PWAYHzviRguUyOI7L7vttMmjq7MmnJCXt4UssFul8bF1GWE0Fjk2zref+T0?=
 =?us-ascii?Q?ZKweh+HfYtpJcjezoigtqfqgL/k9frkRrElNWHo7mkdwq9+GfPLlB7hWmB73?=
 =?us-ascii?Q?DkTIPojb6Mk/FMbgyTxFD6GsnT+/AFoUH0RmrH5DWjoW0TwczQGvjcF3ax0x?=
 =?us-ascii?Q?B9OFkMs9/bRdiPxKLnFiZLHyAHvz0KT1h4Xd1uyzrjKYiRvPsw8oTuFLS7J0?=
 =?us-ascii?Q?XQViyrKPZPLbRORgNMubYsc1nOOt/r82lh5iETg3abN9MtRuS8+FjdP+vTlS?=
 =?us-ascii?Q?+XMPB7yVkUR2rPIE2q6O4QECO0cndwteUmB6Ra6NBK9fe7/JGw30RrDbT3lq?=
 =?us-ascii?Q?YnBR7FeVzoSfF/bspxj57W3btrDxTSwcz4VPcBLYJw319cclmLybfEnFdW9p?=
 =?us-ascii?Q?LApnz2oJg6c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aXY8unhMel7EQoJtgLD3hRff8zILwNhWsKOW0S1i7U0Ee3NXzt6po4X1Mkh5?=
 =?us-ascii?Q?+z3BABjReF0X6B2Jh94VQDVeTbeZsjCBpPK1BNgIDRGa5gV/NTD3VuYOa0wj?=
 =?us-ascii?Q?e1uugRVh8Jndc5TP4KMSMDl6zI+j7ztg/hQwTG2GM2wQSpoUVrTGGhAprQqX?=
 =?us-ascii?Q?wxrWaC59Xx7U3KIWf6P7Wiqv84g1tgX+b2zuEXH+FpuhepEM0f+MPQA4ZT2w?=
 =?us-ascii?Q?lsS0BykKPWCdqhhbBJg8whVtNXM9hrJYTSKVxYd3Hw4qAfKrRNCqLSHZm/Hy?=
 =?us-ascii?Q?fkLfTwtFC1otTprZthLxpOI16st4j7nLSyPFQ+XTTc7Fz03l+PbRnz7noB5E?=
 =?us-ascii?Q?Wd96M+91JCiBgGXpKz5mwuQSdcO3n9VeZbK8JmxKC79YTosJ+svJtQpMQccJ?=
 =?us-ascii?Q?ZaTbF2RtSTizzhZpijXMIXXJ1b4O1aOJbbp01F+gqDReLMQF5oU3odF0vVbp?=
 =?us-ascii?Q?ZAzJ43+Ppxhudgjw9voygCYY0mskex05uTOiPp4BkMmmDQl31+oOsfMVlHeu?=
 =?us-ascii?Q?qzBgustLJ4OPxlAoy46HxOL184bS3OUbqRuoyeaFuyGCl9d8AYREDf6PvBHH?=
 =?us-ascii?Q?VRccXxF7J3WT6STNDZkFs16ukCGHZSl41XxRiQTf3n3Mut03PLZY9Qy1fMBF?=
 =?us-ascii?Q?I3bJ3C4tgZ8NhRjPljm90pWoa2EKz3+bypqAmP9cu8/2Ywp7lOoJHhbPrNxo?=
 =?us-ascii?Q?aJpvbTuMgnnSLtu68IZMc06KuJ5dqww0Q0/U6C7Zays0lV3g9mkAZxLhBel0?=
 =?us-ascii?Q?UwaetZoNboXLZX6+A8bFhNwl6eeyM+22H3BfZNHMCaPxRIvgrxMJu3WMPM0m?=
 =?us-ascii?Q?KTxVzm2ddzZj1cEy9ZuAbM9Q3u02uJT/DsRfa1lpy4Xu5qQdwUuexR8HXLXS?=
 =?us-ascii?Q?ToohPkoCdObNn5t0gXPBWC2snpY5Gdz4hw56SdZBifmnf8dajPL8GgxQZtza?=
 =?us-ascii?Q?w/CGJFECA9cVRM0fB2Phgwdh28fIlSqi0w0kBjJQekl1fjJUKfcWIgEVa2Im?=
 =?us-ascii?Q?kI9RpgKOJmGzV1h0rUtabOHsCcWIrhGumegyiwmnEoQm1AVVSiQL1cdtpglU?=
 =?us-ascii?Q?bLqa8/uOaf0vQRboIagYYSZ8aSoN1ioeb6MiFVeAROKscblq6OZpQ7vWVQfH?=
 =?us-ascii?Q?HOvh/3LkF2QRBHvQvkhFNWMlCL2VaFwdhvBiYas3I8/ND6+fFoc1sDgILBIx?=
 =?us-ascii?Q?uldudJ+Nt/egk3ni01KxWspUHEloeyap/QFKDDOi3lLJS633rPaBi6wEyger?=
 =?us-ascii?Q?wCc3LLshu6wZFhdZPJO2uHBDavFcbnY4jeTO18DPPiq83sjeWHvK2y9DXcXG?=
 =?us-ascii?Q?HW47Us8QltmmBZ2ZBLR0H6AoLJr8d7JagFqeXFj0VVIxMZAPQ+lLZ5jUCa6h?=
 =?us-ascii?Q?2qux5ckXe9IvU39ekEOCnoXsd/AqjlbEj2TeRWIjBgLqHkxSazmhDravis6j?=
 =?us-ascii?Q?M9+Aschj4BzXTBYZr2ZXDp0hrvzLOC8Z6JdD5iltFIbQnTCvHkHeNBVvNHxk?=
 =?us-ascii?Q?5bGvQUbrBDZbeHFjQ36RFJQE8AZL8vcBg0XaQBjPhQG+7uujXV2lHeKKRMyK?=
 =?us-ascii?Q?DY1OUxNaPct31pPck8k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfea70a8-0fea-4dfd-1c13-08ddf44d9a02
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 11:47:09.1808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPZ+9P+zCHeBskwdwSaqaQOqZn4BbmpyCLnF9kIwC98C390qV6bnTCMvGcOE29a2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_044713_956692_70B09498 
X-CRM114-Status: GOOD (  16.47  )
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

On Tue, Sep 09, 2025 at 10:14:41PM +0200, Andrey Ryabinin wrote:
> +static int kstate_preserve_phys(struct kstate_stream *stream, void *obj,
> +				const struct kstate_field *field)
> +{
> +	struct reserve_mem_table *map = obj;
> +
> +	return kho_preserve_phys(map->start, map->size);
> +}
> +
> +struct kstate_description kstate_reserve_mem = {
> +	.name = "reserved_mem",
> +	.id = KSTATE_RESERVED_MEM_ID,
> +	.fields = (const struct kstate_field[]) {
> +		KSTATE_BASE_TYPE(name, struct reserve_mem_table,
> +				char[RESERVE_MEM_NAME_SIZE]),
> +		KSTATE_BASE_TYPE(start, struct reserve_mem_table, phys_addr_t),
> +		KSTATE_BASE_TYPE(size, struct reserve_mem_table, phys_addr_t),
> +		{
> +			.name = "phys_range",
> +			.flags = KS_CUSTOM,
> +			.save = kstate_preserve_phys,
> +		},
> +		KSTATE_END_OF_LIST(),
> +	},
> +};
>  
>  static int __init reserve_mem_init(void)
>  {
>  	int err;
> +	int i;
>  
>  	if (!kho_is_enabled() || !reserved_mem_count)
>  		return 0;
>  
> +	for (i = 0; i < reserved_mem_count; i++) {
> +		struct reserve_mem_table *map = &reserved_mem_table[i];
>  
> +		err = kstate_register(&kstate_reserve_mem,
> +				map, crc32(~0, map->name, RESERVE_MEM_NAME_SIZE));
> +		if (err)
> +			goto out;
>  	}

As I've said to the other proposals, this doesn't seem to be bringing
that much value compared to just using a normal struct:

	for (i = 0; i < reserved_mem_count; i++) {
		struct reserve_mem_table *map = &reserved_mem_table[i];
		struct khoser_reserve_mem_table abi_map = {.name = map->name. .start = map->start, .size = map->size};

		err = kho_preserve_phys(map->start, map->size);
		if (err)
		    return err; // Should unwind the other preservations!
		
		luo_preserve_key(luo_obj, map->name, &abi_map, sizeof(abi_map), VERSION_0);
 	}

Jason

