Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704A8CA1009
	for <kexec@archiver.kernel.org>; Wed,  3 Sep 2025 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hR6IJbj1Vfo1F8yJ7ahz2cOIPT3YmpnAowzpDDMIGdQ=; b=K4g2b6/IMwely/sl8CsIW7EoCZ
	De/B6ycz0R0T83cPKHcMVdjIMOmSPR0kopBtsrN5fcRcEPmSUysHjKUbYw0uU5v823unaWeEEA6cb
	E2zmoWezGJG8R2pqdd6byFYvgEotYfkBUYeor+8V78tpW4iWJBiKqnC7gYKbuZzNti1Uvjp5QRxat
	hEAPK5zJ1K1Ks5ecT91CiTjTq3u8RRig2P7jzupsjSyOgU5kq2Lg4qepYuIdChq4b7Kpxg8nOAj9C
	YNxpffBkiZ5A6b/Uvsq+IxKy8J3NeVbWcTxhhvi2w3X1dyaikN7q/OnO4neCvhbD1no6vkT0BNKPX
	UvRB26JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utpWK-00000006wAn-0Cu0;
	Wed, 03 Sep 2025 15:35:36 +0000
Received: from mail-mw2nam12on2060e.outbound.protection.outlook.com ([2a01:111:f403:200a::60e] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utn2H-00000006U44-3sYE
	for kexec@lists.infradead.org;
	Wed, 03 Sep 2025 12:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMYIjoreorXNUnQuL/iZ2u7zBsqlwMISU4b/iVYCQRnaeYdY27NaRMGTVWoSzPWoQE2bW+jIerv/QuB01M1R4LwrOglBKyvDtlCOvdfDhu//bSofoMmLZKlz7ZW3BV4i2UYndyEoeyPoKtMlisl7BoaNjH9DJnhLWB+Ut/AcnnfZi9soHlxpNBIQEplL5wSngJfg4XaKI9dTrMUetfqFxtw2zowvzJj5xeGXij3pcMPvXdbQntTEAakX48IPjdo/x4L9/hohxh+Jkim3GXKx6eQ9t4qggKoBPucGD/koWlHeaQ/hnequAyHS1MIwYVUkszRV/aSij0jkyCew45/fMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR6IJbj1Vfo1F8yJ7ahz2cOIPT3YmpnAowzpDDMIGdQ=;
 b=v6WgGoyS8ziXe5oPVQ1sk/G6Ypow80fyHA+Lja63XdLUtG5Rt46TcgruDL0xpKoKcnHN5y21LR6rONzwQ1jJzmMfbCTVoHwtGTNoCR9KCGjxPbz2BWOgfKTOeSh5V3m3kfaaM1KtcaenbrY7yJpqIhz2/SNhul+ByBnqA2dTJAQbP3DJgbK76nzZzu9Y49aI6F7J4t7tU6sgEEhcdS+UsNOwN8/dn8vrmbC3xsm8VP6lz47s/tn3kUzoRSnn/geETG7thPAUSPz2JiiyElOkBUSokTN9yZg5mC/NPuAiKOv/oqTyOJhPUP6BNuwzAEowptKbD5oeVVvKfGChYLN8dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR6IJbj1Vfo1F8yJ7ahz2cOIPT3YmpnAowzpDDMIGdQ=;
 b=oJM72u7TKDfIoC3UQetVbsZkjaNRpp9S85fKb2O8EKNsIi3P9m2OnAMquK6r1JrScq1Wki/60/sdx+wXcZFaXLjnQoWc8yoydW/DM2+eFIpe7olVmbwGwEAFdPB6aB4JIZI5L4/+wtONOTNrpbw4FU+wwnajkEVAELaxtu79wjkZzlIbXZQaNGrFIIRUir6Y6rU2wyFFcraYrihnon5MPxEuu+JjYkxocSoKjIRdwZn5v3NcVvxAGsN8HfaG0ilLSNPt7GzeAM3V+BZUBhaSP8EcZ1M+DQe+ToeJYCqw7kWQnmMW5Od11vNhZgT0AwVVX/sDQczGCoulRNTXjbfbDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 12:56:22 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 12:56:21 +0000
Date: Wed, 3 Sep 2025 09:56:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kho: add support for preserving vmalloc allocations
Message-ID: <20250903125620.GG470103@nvidia.com>
References: <20250903063018.3346652-1-rppt@kernel.org>
 <20250903063018.3346652-2-rppt@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903063018.3346652-2-rppt@kernel.org>
X-ClientProxiedBy: YT4PR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::24) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: e8626334-0c2b-49c5-b4f5-08ddeae94842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b8XdwMsnf1ADUDutP+3YyNer4xm/+XjOcQU+rWs5QoO0Bg3tfQgt5BXTtyrp?=
 =?us-ascii?Q?+KOvUPCbt34vb4yj82hCbYTCXEk3EQFqFCpLVPOaqDdu85TrxCYeaN09Ny0+?=
 =?us-ascii?Q?HFETlOCYEzBZIRPiNNkx9bDM4vcseSkBDv3dFzE7R2OwwqgLHbKyybYtIeEy?=
 =?us-ascii?Q?9jBeqV58RelIuE/ryZ/RCNqwucRK14syzRoXqh2o1kEqH4NR68QB4JfhW3o+?=
 =?us-ascii?Q?G5ZxZpy8obsg9POSVwa6bmQC2kUBukPxLJC7cGlVM3tPIK/7Jls2HobnsQMF?=
 =?us-ascii?Q?P56aXBZXJglH+YqNV2FEFYJURjersFOlL8AEXl2fA0CjkXAIGAx9nKCgsNCt?=
 =?us-ascii?Q?eJoWV5QVwRQuXFtigxzWb53IeQrNGN85s5dAXKmDMKpv91yV5I27K0oHqKki?=
 =?us-ascii?Q?4UZi2nUXglaI77MGOmL4uE/soDEmjvpr2inrINdWTudy4imQw/QDJrnr3rDX?=
 =?us-ascii?Q?NI6JFebu49ILJCQEFOsnKKEjr5I8NZhM/MwUC23QS7h0fWDfsWy/ACC+VdBb?=
 =?us-ascii?Q?Nk6vB8Hn4u7Igtz/DpoMDVn6f5spCuFHZ4NyY+ZYLosxAJSi7scPEMTcRM53?=
 =?us-ascii?Q?C8YNs5Xb22yyjTgme7nwn5bEYwWV/F6GubOSHAMO5gPw3x+PofB9sC+iow+n?=
 =?us-ascii?Q?s0WJU6xuQEC43p0AX+bO3JYL/k4pu+vl9WYz5BQRFRW5ySWNwD9fCxScmowJ?=
 =?us-ascii?Q?Za215oWjRSqwseIh5gUED8ukh21h0m1+ftebqdjNCPm76zyPO4834JGIozSq?=
 =?us-ascii?Q?/tOjK8EzGNzvt61uckUcrn1r0oSXNYgJv1Ky4+X0nSqA1KNbltWKtKg1wYF+?=
 =?us-ascii?Q?rL4qInrPpx2WWdsqyjibH9P6gjyps+UOu2tdgSxljlKqTiY0c553Ybu+dzmT?=
 =?us-ascii?Q?DH9jaDygg6T8JKpc9Ka/HZ0Uwcpbc9F3lHzoW6Mi4CJT4UvXDSvNDkwEnBpr?=
 =?us-ascii?Q?MefY+3IuNByDTs/sNrcLHjwAmVmqyBR2fbLPM+c/zAFOnP9dKqauOJ/2tq3u?=
 =?us-ascii?Q?A6narhFAYmK6psr8X614qZ388DiRNgMBt4Lbj2OyvcJsfhFzJ2YxNuweJLx8?=
 =?us-ascii?Q?E5icPYyY5tkQPaEAfP1IAYuBqels5ItqNkCqYhh45JxU4YW3d0UurUK+aYzU?=
 =?us-ascii?Q?dGDNbM6YihN6rzhk3Dp2zkJSPUsXt6SSNqRjSdvnMJITX9lyOEAk2oCBfuiG?=
 =?us-ascii?Q?WbPdWZ2qTUzBF1S0tHWwHMZ2wia11bDaDvBYF0MYAc3SMfrGtV4iIYi8EQlD?=
 =?us-ascii?Q?rdizFhQGKeoX7kQwIJwB6lgVvYQUjzfWJX2b59jSM9at3qdObqiB1wNIRi9s?=
 =?us-ascii?Q?tGntTKtDcFuJZtKtspnXxzGn/5fIOlNRclEyUI6OIXIn7BgF2LMWx1g/prS4?=
 =?us-ascii?Q?vc6xiGpab7fWYpA9X3/W6sQS7XkplNuxXXIrkyE1zhRZ9557WtMfbyz9Eya6?=
 =?us-ascii?Q?ZlPfuf/1ffc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FuBwuQpJJbJ3C4gECWgpctoGrAIHUAm8BMqE4/ebCzTa07wVrTrcBnnFIoGB?=
 =?us-ascii?Q?4SP2LDUlxzGb/L00uNr0SzZ3s+94nwA+Cd1PwFC9OyJYqThPErWsiIXGarfZ?=
 =?us-ascii?Q?wDFeC02s38U7gwXskqagdCpWtT3vGnSQus6snyUZxdkU7ks1KgQQO/0weSzs?=
 =?us-ascii?Q?knm9LIsNAxlHdkBFxvD7LHE/1t94NYO0ujsuVdEqhUS7kcSwWNyULv+ead1w?=
 =?us-ascii?Q?Grytk88uNy9TAu455kcVYDuLQjq3IDGkRHg37mXwPYZmv7SjevLMfC+XHE5Z?=
 =?us-ascii?Q?Hz425tTk1sWieRbozdd3psPClLJsM+PbxFjyAaaJNi0p4R3p3MVffuo5DsuY?=
 =?us-ascii?Q?nzL1Dvtqs72nbKy4RhM1WHFvn2SHMPWup4cURosIuhWMxndoJdouqimEqTO0?=
 =?us-ascii?Q?D6fk/9F29CzTM95QNxX/pA2p6P4bWwtbD6qQL3buw5Ga7ya7coGCixqkpVHP?=
 =?us-ascii?Q?8wp3+kBLl9+Q+E3CZFg4Ll8trt3NG77iOjsReFgtC8M4VY7RuEsazQjwgkri?=
 =?us-ascii?Q?+HbdTZIgOFiYM0KNYUoEdLCdcZMb+fyd8SPl2eSgcA7kMuZizijIHYOFrTyt?=
 =?us-ascii?Q?Y6UkbHclWhoAbRm2iMf63O03gaOq3OGF6sZl7mAZCLEX6xR9AW3OIN7/sGvG?=
 =?us-ascii?Q?1B25HrWWx/N9OlzkFPa6Jcdw3SgPTb7c+bXNd8iyrccl0GGfPgxSA23PVAYl?=
 =?us-ascii?Q?JWQLX9YZjembX46yweGlVKq4y+QriwrcZP6Vk8ljlwYcDGUAJfAcONWPv2HM?=
 =?us-ascii?Q?Z/wtec1P8mBxXOQTrgDNE3SaFd0R7BIB423h2p4yfvUBVjm0jQ/nXnWDZbzw?=
 =?us-ascii?Q?l12NLPJnnp3nXDwxNbwh/MXkcZcX0hdy+aw6fVDcgmGNIG2Ob/z2j/FiW65s?=
 =?us-ascii?Q?5lNJEzQF+1roIAIrjuo0pe48CQu8O7G69GKPEBWRSm0A/Fwu/WJh+28VmZ0m?=
 =?us-ascii?Q?Zf1blKvnAnLvdsi7SCmZskPfOV2lhf+qYlM3ZTfUB/Y+7B2btQLKEMeRYH/k?=
 =?us-ascii?Q?V1e84TpLmwBo4ys7PO7hJwimgj+yh16dfDeema9hHOnQgYjshcTwi8NRVvoO?=
 =?us-ascii?Q?colP75AMQdMhNvnojLv9WMHjsYbgNEwBPkyX8aqYUgoSkSQm16n90kJ/OHFH?=
 =?us-ascii?Q?HFx80wvrvv1chai48OXcJsaKmyJToRHcYAchh7LVBwZ2VKvE2VLV89fnNhNB?=
 =?us-ascii?Q?g7heh/uYOykTeISYN4y4wTk2wHknpmVBpwNxPXehUYb+Bzl9zqoxDNpwO2oZ?=
 =?us-ascii?Q?x/nj3QOBT5jbGAhz55IOT8gH2KKAC2ZPKJoRJs/ZyvWlLuPfUsSs4GRSk2Oq?=
 =?us-ascii?Q?AknMwhRRj0uKedv0h/4AjY8MP8dTSj9KRFsmP6AQtP2h85zZ+gBaykSZxoE+?=
 =?us-ascii?Q?HBQ1n6RzATyLFZVz1c/zDnWHWZxd3HMPGDDygjGBTvZ+/g0dlKOu9zZpbdOA?=
 =?us-ascii?Q?j6r7jvGCvNdEboClsJ3eqze6wI42iFrycq5w2Xr6MwxSKs7JB0O+smB+ceQ+?=
 =?us-ascii?Q?essNz6SSpxxjoX8fWXhveUftAaZSg8vGvneUBVe+h5Ab8Y/Pk+HUprQ/5Wxj?=
 =?us-ascii?Q?tzivcBMORiIY5oK5ihI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8626334-0c2b-49c5-b4f5-08ddeae94842
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 12:56:21.8745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PiYiKNWaUgv4BJdanJin8iIhpO1Bx7J/hvpO3EledOoLLGlMogw+iGxxm0sJiZ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250903_055625_965398_13469138 
X-CRM114-Status: GOOD (  12.70  )
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

On Wed, Sep 03, 2025 at 09:30:17AM +0300, Mike Rapoport wrote:
> +int kho_preserve_vmalloc(void *ptr, phys_addr_t *preservation)
> +{
> +	struct kho_vmalloc_chunk *chunk, *first_chunk;
> +	struct vm_struct *vm = find_vm_area(ptr);
> +	int err;
> +
> +	if (!vm)
> +		return -EINVAL;
> +
> +	/* we don't support HUGE_VMAP yet */
> +	if (get_vm_area_page_order(vm))
> +		return -EOPNOTSUPP;

This is a compatability problem.. Should have some way to indicate
that future kernels have an incompatible serialization so restore can
fail..

> +	chunk = new_vmalloc_chunk(NULL);
> +	if (!chunk)
> +		return -ENOMEM;
> +	first_chunk = chunk;
> +	first_chunk->hdr.total_pages = vm->nr_pages;
> +
> +	for (int i = 0; i < vm->nr_pages; i++) {
> +		phys_addr_t phys = page_to_phys(vm->pages[i]);
> +
> +		err = kho_preserve_phys(phys, PAGE_SIZE);

Don't call kho_preserve_phy if you already have a page! We should be
getting rid of kho_preserve_phys() :(

Jason

