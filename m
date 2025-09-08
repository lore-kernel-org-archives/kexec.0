Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386EACA1016
	for <kexec@archiver.kernel.org>; Mon,  8 Sep 2025 18:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5L2mCeZscAu3I/FAPVFK9ewez86G4TJ9lRGMl1h+bHo=; b=UqlUP0HO4bEaTAZx0epteQr5OI
	r2BrSqZE4F4j53GW9A1lqZw3IMl60weX0ZXJ2pGSrfGCB0SV7GiCls1hZYSRr6AyClLHAk150C871
	DQn8wzp6renSEcdIYuGm8E/6PSxx62uPsxvb4CehLL6S5cv1Ho6gjc0qz7tVB+nANYJfCz8qWs/u+
	uj+CG9zvYfQ9u5Sisa0I7j3nmLS3L287NyXkw9rwGIxz3bVJhJiVL37mOayXxjEW+9vBSR5mvdxuZ
	+8H2UF7DnHiZjtFNoyhJvaokoW1JfLBUkk1GP1W6sPkBZgbeSVvmPt/DN26YvB126TMgFnqevVEXe
	FRQOxhmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvgUk-00000001VFW-0Ziy;
	Mon, 08 Sep 2025 18:21:38 +0000
Received: from mail-dm6nam10on20604.outbound.protection.outlook.com ([2a01:111:f403:2413::604] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvcdi-000000001tx-0qc6
	for kexec@lists.infradead.org;
	Mon, 08 Sep 2025 14:14:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcgvVsvoSFLzuKmdSfpgjXG9J1lqWyucHhaDrDAP0yicpscL/VPs4hyuPPmz/CDQ7xLUouWAV9o9U/0DDFkPT/g91kVzpMaTPentTyPAd0k6p7SCEwxol1va54WdcMl33FdYSwD4YIFe0Vqwp5FTbHl9VNTeRfYTCagYZkfv74K7hwkubmUcuTTHqbjG9nYQaBr0bqvvFhRGxTqdjOKerYwLK+30IPuSfUGnzorVUgsBt75WtBA6S8uEjclcsqq2+hhLh4fZ3W1lMmsCwX6gffVh2iRh1+2+FfKcLtO6A4y+28mblgOTYq6IFy7vjbRmsj0Ksi+FGyOabSZ1gkvS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L2mCeZscAu3I/FAPVFK9ewez86G4TJ9lRGMl1h+bHo=;
 b=PnXiDz6uSYJSFoSNO5CcHPsH+opq+o513Ui6jV98nJo5fMmdO5HvsCjSrAYAw54jj9N5BWm86WHaQasfwo4HgYDyTWb08nJa1nePELMa+MIUj5ab91AvXsl6HpMjomi3ACqihkyCrI/yHPoHjkEgswFwO38Gf8ohGqOnZziB9mKTIcDrmWuqU2P3WLeaSWsGPMuZpbRCCxUsSUXJBtnpG8L1r+6fY7JekpfgfQhzObRLY+HhnSor23UE4EOb3QO/U5+oxakyeXa8c26LscYQvbgO0/m0rdPuYUJXDw017fsE5a/Un8BmlDC86Yv9yFpBvwpzzN+4cBh1Xu0w1XAQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L2mCeZscAu3I/FAPVFK9ewez86G4TJ9lRGMl1h+bHo=;
 b=gwtHBIJsDlCZTUDg5IPccA003x6Fb49RCR0FvQO8QCQUBz5NIcSHp8Lab55prfT50aZia/pPSgxDQs0ct8nyY/uUZGiyH/WOT+dZUUDSl9Wut1LY99WnYVw868hXKmjcPC3j2SvIh47ltTta7EvVivRJeH4XX63Twgl4f0dcANwG8nm0//Ew0owsfsIEIpiPluJnrvoHsUK1ZzOiIXPuwkAjsAsnycloy3uoqZ3MoURAWzhgcspBuhY/j2b+Q50S4AjCeQ0kmnjhUNITPknd1FDfTtDwl3ZPg8YjoVAi17dLq5QM4sxi++ehykVJUPcuV9LgNfruqneRZHtqcIRXKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 14:14:26 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 14:14:25 +0000
Date: Mon, 8 Sep 2025 11:14:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <20250908141423.GJ616306@nvidia.com>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908103528.2179934-2-rppt@kernel.org>
X-ClientProxiedBy: YT4PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::18) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6c1e44-30a4-4bd5-1c4d-08ddeee203db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wV45UqxVX7th+QSdTWkPGFGAWXf0G/POAT1OPv9upWdnZYr6ZP9K1rvSgJzn?=
 =?us-ascii?Q?B+5vD2OfUIPVFB6HdyjxwmxcsmTDEWIqxWHaorLCNjrehTsPXjSPoIzRknpv?=
 =?us-ascii?Q?UI6KeTMWHYjVWM/3PlVWvC8UQMuHf7x2KRwbXDvU5ev6sGhYyqj+tWHasLUM?=
 =?us-ascii?Q?jf7fXMx03yebYuim4Gs/MK2CEIS1MWDiOl5Dj5zt5EFYTKj60s+eh3sz7nFh?=
 =?us-ascii?Q?KieKM1zkcMWb0olR1wRJoq/+wzD8MycpKT4X0Cd3XnN7PHyRh4ZfN29KIW1V?=
 =?us-ascii?Q?J2BQypIXxXLs4bJHxuuYILxlFCjBVid9OYOCUUu05FWR2mOA/DVYyUF9VCE0?=
 =?us-ascii?Q?61utxJkx9rxBqs810CpsEsaKC3azy7PK89GkPT6dN5Q06JIxexkkj8bZce+g?=
 =?us-ascii?Q?BpCwpHsyzIuSS1AynVSbraPCTad2bzAGOXVbklf5vmxEBTMgNnfI4ezH2XvP?=
 =?us-ascii?Q?fBH0UuqQAa1+0nSagnRK/0cWG3qSkHuJSiZUeY7Mv56cUJAsn75xIA8QvJsI?=
 =?us-ascii?Q?7NdmQEilRbDK5J1nlhbCR1laEdEyYDMQ2udAILyjN1yqQNOXzgUa7NSRipmq?=
 =?us-ascii?Q?fnOXdUgplhLn+3v8FjQHBGU1dL0E2PWXFCuOQWdOGflpOBTj4iyt3/2cPuqY?=
 =?us-ascii?Q?4UX3GIydHhd9TMFH0E8ADx6mmVLdYCeZvsD7yT9fkQfqg2iPjmwm1YpeTF57?=
 =?us-ascii?Q?cuGyj/gLmIZjoQpKvVylXD1a8wXb9wyyHzMR4Ww5Rif+SJsJtU0e2UjAz55d?=
 =?us-ascii?Q?Z6KVa76szPKqwz32M/AEx7Jaz92HbPAYUkiVir395f5wld54uFENZpM32//S?=
 =?us-ascii?Q?eR/2wqr11CrRM+IxNn+5Cn0y2oaewVaRCrK6VTLcknT3RDskk2yb5l1IaZ4S?=
 =?us-ascii?Q?U00zTjqkjxvrNKraadGnL7nx965i8AoRALbJR34xgJmkSgmROrLm/sszLxVT?=
 =?us-ascii?Q?KP3p0Rl4oW61KA2+x3VE5x1+KWkV1uqKJ+/+K3jnBPMmYJPuXxFyzpe1MjL3?=
 =?us-ascii?Q?UTUf3tGBA+Zik+nzTq9GLvguHpOPM83QE4GCN3YD56bhmz5BFffDHt5e0CJX?=
 =?us-ascii?Q?csBR33a8swFWdGN2utmVN51hjdVTnTnW/Hn3456C9Y4RJWAJzm6OOiKD5r6r?=
 =?us-ascii?Q?gVm++wTLe6s3WkgMzDhF2MFaKbnWGdTUaFz6kLQfksy5lGfV+AnCXhR599MN?=
 =?us-ascii?Q?9G4NPEhmGJ+CeXmSMW+WYlVsfO4j5X4t6idxBiq868+EBpddrbFxYJYpo11F?=
 =?us-ascii?Q?eyouXR0LTg9kGUgSoti8jhosgcGGWA95mDl5Clf6D7d5HvyTwcsoVRgOtc2r?=
 =?us-ascii?Q?ufJSf13JSgUTx0qLCswSGf+FEtLrGeetnOu95TZyt5FnCDENdh525hSIaizF?=
 =?us-ascii?Q?fyBtbOH0Kz0C5L9JGjJ7IyMPMUhvCjM1C0IRSvcqCTEtGTe6SfsPdDfkUMY7?=
 =?us-ascii?Q?ApHH6c5HzFg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LNGZoVQVXzL0/wcf9ZFoyiQxBgUCeru+PqfMA3uA/rWV02i03ARJWOjJDsHR?=
 =?us-ascii?Q?fO2DLhJNI20LzjiPX90qFWJ0EAp4Hz0v+RQMBVJ8p2u+78CZnKVqAsiM2K0u?=
 =?us-ascii?Q?z9/9wMR0yU6e0bkejZQi8M0vZtCRSQlFDzFdPoMZRD/LeLAUYO1qgyCepHqI?=
 =?us-ascii?Q?ajLNmLqA/i07mWmLbCpxApNCWY4QYuShuJC2hnNSecZWd3MLfhMjkwww6Dca?=
 =?us-ascii?Q?KpYXPCyUF0DrkCRSC22W7+xlh4fQYqdN34xNn/KagqTY/WNJcIkrSU8Y0BRk?=
 =?us-ascii?Q?s72e2fK22kfCMKkYbSdbheEF0LmKWahQKPcC1ytZRlUEiMUqCvOO2JxMtwei?=
 =?us-ascii?Q?NxkTqKx4ufIsziyEugI2CIOqDD3rNP61VEocdp9y+zd6FwgCauVtutYI7YUb?=
 =?us-ascii?Q?TTaHbpZ5XfK4P5sGtdkOtBYTqvGDRb7fxdkBOAaiNImBgRtjwQn2zmVKN/RT?=
 =?us-ascii?Q?VDwmp4qJFp9jHH0Yh7WcLpaKT9VaCl8rIswU1QLrvd3BQ10qXixrvH/yaEjS?=
 =?us-ascii?Q?+GbAgBWJJoi9bM53jTJbqE2ErmUDRvHfA5IXSFWWc7oAvhidYuMTwdVZzShu?=
 =?us-ascii?Q?WdsPcDtSqYhzeEQ6P11WIZIAhiDWFjQYWfwWGset7v77D8Bf6oEOgNhpvc3T?=
 =?us-ascii?Q?0TMnu2QD380cd/KykPPosR4525uZ3aGavKE2tRw4OwrNL9EV64gqgDgtAN5j?=
 =?us-ascii?Q?Fvha0QzYnRg2wKf6z4M7cHQPU6ykv4661NB+HaZlZQKZJ2BgdDwWlzCRoF6f?=
 =?us-ascii?Q?L9WAwBwixCPd1ucuTQ0C4fELicnZGohU4iosIkWnNQvbAd/6BB6hdZpQxmjZ?=
 =?us-ascii?Q?4Pk6nmKNhmNLQMVuVb2nR1nITuEI4sfzefHTYEJvL2/SiTZqHMMlX/mP1cRz?=
 =?us-ascii?Q?jEFXWmPhbcPNhuQfKd65dQJfxkfqqOEctF8gEw145B+1qITse+pFgYA1Lk0x?=
 =?us-ascii?Q?GFjjH2HNs1prgeviyQzTrDnbYIxjxOE698gAP5UEo2l5PC30I6UBycRsAfPB?=
 =?us-ascii?Q?A1KockygytxfXZSHsIcNqFB+RLVBbHUDLadHfb4z3MMSIcay7ET0iymdQT4o?=
 =?us-ascii?Q?jBvWQOtVjh0ztd0OPiWTelzFkgCIB36yzisUjEJFB1cSNi8BlGm/PZcvkrvK?=
 =?us-ascii?Q?Vy+4neoSNGqM+QBpZ8BaEbbw45Mvt18gvvUJpnpoSCw2kcmdfmAoDm/Eadat?=
 =?us-ascii?Q?ZQ0x1dBchMtwIL9/UhRpPuYbwmXZe2RORYyRv6FYWLKz3r488XEvG8Cs5l96?=
 =?us-ascii?Q?iTfZGERonAIbgbpAqcZUxxhnvmOALSwScSHuq9T1hztonY9w84Sywdrrv6WV?=
 =?us-ascii?Q?nYKZlw4uEGWtKH4+r16eiGgb9bxO3XV9jITQwS67NgXdngzRZ+w9JCPTv94I?=
 =?us-ascii?Q?6317UM3mK7Kg8jK1I1M5/aOvCm5NkLTwqrbdY+d0tPRAf5MlrNLaugPjU64g?=
 =?us-ascii?Q?C5qeY225C8NzlggEEP98Fe5/p4mVjKdKTqtkhI5LqXaCHxIHKUUc45OUIzA1?=
 =?us-ascii?Q?xRHlguMfhspp4hWi8DyCiEbytFJwupCwZlBK0Bq/Pvc0cNd72BD4ffchEgxe?=
 =?us-ascii?Q?zncBm6qUiuYZb35NGnM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6c1e44-30a4-4bd5-1c4d-08ddeee203db
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:14:25.3731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QS9O4MuSWPoruEftG0NNorcud0k48ekgYQZANuMYSagcmOhPr39fWq+JDzqsWvCA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_071438_238785_1CA9006D 
X-CRM114-Status: GOOD (  11.12  )
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

On Mon, Sep 08, 2025 at 01:35:27PM +0300, Mike Rapoport wrote:
> +static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur)
> +{
> +	struct kho_vmalloc_chunk *chunk;
> +	int err;
> +
> +	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!chunk)
> +		return NULL;
> +
> +	err = kho_preserve_phys(virt_to_phys(chunk), PAGE_SIZE);
> +	if (err)
> +		goto err_free;

kzalloc() cannot be preserved, the only thing we support today is
alloc_page(), so this code pattern shouldn't exist.

Call alloc_page() and use a kho_preserve_page/folio() like the luo
patches were doing. The pattern seems common it probably needs a small
alloc/free helper.

> +	for (int i = 0; i < vm->nr_pages; i += (1 << order)) {
> +		phys_addr_t phys = page_to_phys(vm->pages[i]);
> +
> +		err = __kho_preserve_order(track, PHYS_PFN(phys), order);
> +		if (err)
> +			goto err_free;

I think you should make a helper inline to document what is happening here:

/*
 * Preserve a contiguous aligned list of order 0 pages that aggregate
 * to a higher order allocation. Must be restored using
 * kho_restore_page() on each order 0 page.
 */
kho_preserve_pages(page, order);

Jason

