Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90F6CCA46C
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 14:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I5lMH9rYNUp70Wp2Bd3SyIU5Dc6ty3PWbEheraIsOsw=; b=Tcs6Cjc1/wjKbK/kPleVHhIzdq
	v1ZqJ2wj7fOGg2JrszfWY825gGq85HwY3nmCa5qfY5JFD4FlCJANktGutOSwkWKQ+dWUI6kVOvchT
	Gknam4SjpsUtqIFOQPXfEw9zCoHZCLASESpaIr1md4K5aVORhnhw58uHjRwBoFuDiAZQ7Yo2DlWH4
	ihh3FfuvyFjtPtofi1wtrEgtKCN+E5EmyFXg9ixcV4j0qRiP2fZPVd25XdgmtS9U9R8u7coOzYwq2
	PIWYI3GGf0iWwTACdN371XrnMeBMaHCaYLEtnEVk7NEDxTgw4wGEwUySYKd9tuDbs9jj2YDxfxbMl
	pLnT9Wag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHj7n-00000003Alq-2mOH;
	Fri, 16 Oct 2026 14:41:35 +0000
Received: from mail-eastus2azon11010007.outbound.protection.outlook.com ([52.101.56.7] helo=BN1PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHj7j-00000003AiD-3lou
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 14:41:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHYISTBLRJ6EfinJnTw1xkvu53vwgZa44wmqKAQ12oVj8CWnOECFHFPzOoufOctudVLzY59E+RS2soQdNXo61JoSzdOy2eQY9udbT83tTDdtSpQY2QfhOsZaLMy8CtmsCnppyeHVCVo3oqCU4JqYhcgGxqhO/13mXco3TDwr2s4oL19OsRprRfbwlAwjSoV8iiv0ZLbWjmC3hDTMTdGDpU2IH8LmCMywCk3X+Oeg4/nwxJ3u72fVf64SdLdcIRP/vvAT2MzAzZcRTaZg/RK1AXoHUDr0CGyZ0u8xAAKCNJYUd8Hj9I2Rw8beFSEbIfjx00ofVgXTy9zMu0WHe2MRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5lMH9rYNUp70Wp2Bd3SyIU5Dc6ty3PWbEheraIsOsw=;
 b=lzlhurncn97dl0Tt63Q9pP0rpEkUMnVMa7caoPi0nEemruhz3hD9aEVxtaCYow2fP6RwSVkhdO32tPb2wY6wgEGBzl3fk4CB+quz5MeZGQEsTEp3AwxMI9AVD8E83GV3nBfOS3eD7/8gftauouXN94Qkc8tBwTiYs+xanqRbgrHuWg6BjpZTbrGWnpWOKAKWLIr+SVvxYmK+VUgpTOC8njlnkf0jQiNLEh9BmsUZ1JEUnj2DMBwehk7MAeoM8qvWhV0qlKQk4t7r/zfGgQkkImMCKaeSSWuZWc9I2BhdKdmwRYwRmLr1cfsycxa4/76T0VoOMfndYsNsav3k/q/Eow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5lMH9rYNUp70Wp2Bd3SyIU5Dc6ty3PWbEheraIsOsw=;
 b=adC7d//yg9G5R7/bLxzeD9d4xyAaMu0/SrGwu8fqY1OnX4D72+JfMtlB08aGOmtzV3RrplDjv5W39c6nz/6SylX/VPZMr37KuTPnoC5QXAMx/Sky1+phbALxLSrl1nyfmmDUjDsF85OfY1/ljKq+KFFq0vVT6ecQjWAzBPDyyyI/CqgG+KS1B7pZkf/Q/yK7VgmhAfKSs2k/Y9L+Z1fbclVZvp8lE457+A8e/b66poeom5mS3Pxt0XWn85MSHT+vXFS9j7jvqfULqAIWQsrIy3LnwJYjYsPLLge7GJ/GDPchvMDq8f7YeziKB5ffiFJh4liWlUJ/I0E8fqrNoemcNg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH0PR12MB8151.namprd12.prod.outlook.com
 (2603:10b6:510:299::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 14:41:23 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 14:41:22 +0000
Date: Fri, 16 Oct 2026 11:41:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Abhishek Shinde <abhshinde@nvidia.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 00/13] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
Message-ID: <20261016144121.GA439341@nvidia.com>
References: <20260322014402.8815-1-piliu@redhat.com>
 <20261011201325.GA918242@nvidia.com>
 <722bd9d8-5620-498a-a6c2-d9a1f498e0b7@app.fastmail.com>
 <20261014000227.GV13920@nvidia.com>
 <8fb05f13-e770-41a4-af66-d239b4c95201@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fb05f13-e770-41a4-af66-d239b4c95201@app.fastmail.com>
X-ClientProxiedBy: YT1PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::24) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH0PR12MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: bb009909-ae20-4d6e-1cb0-08df2b938c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|22082099003|18002099003|10067099003|4143699003|11063799006|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: jKuxXePb2nWtdDarAqze/H5ri+ymT23COIAtShYOHcHwJINrY5z5mEfN9zl8XA7h2V74L7pM0YP2xVtkyKOPIksPJdCliMcZcXw7hPX2YDSWvMpMcybLAXRKkgLje/N04fzCKartUpGo2kavK/b5xZ/3m+qKVwpzq5/WyFsXRk6wUsH424RF1FCJwt+30r7tkFhO4T4HWPBD/UkP3VmwhQSl/mrh8ucsF2/7/hdb8sQUbiGjjpVDAs8x9eUmNSTjO+g6FyPif2l9uLthwrr2CiOdIvj2TRl/zJcvIITSoiYFqCqtFxe7sicv0HHdoijjKOCVfwKTZLD2eQOx6mm/S9FneFukUuEaDwKSLrNZdeuTZh7fy+/0v99JlVdc4KrMUYJFXv0oRChxjJkO/+++dCYrnvNYhEYh4yTuQ12RCj4KhdjoeRLWStJnizc8vy1916DtVqGTSls3StTwktUkG8oZ8IdAvxVuAgM0epi4u86etCxd4TI+3bI7KnsTHS37/Sd0JgckCMb73dZB2mN75Xv4oQifhHdQ/LQqUpA1Z9CGn3Bg2ec9EETb8AJOyjI2GNvdogF0NCG5wxwt7cnt7JYySNXJUthslYIa3gimtJ6Pterrq/KGDWoyiMU2n6/gXaJUaqyskvdg8GyD+3yJAzyiFb/Sdz6xReZJlhw4Qng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OSAUION8X2/zsDSlNcMJpEWiYa0bAWtuiREK9+O/sp3QZ6yheGh4N39B5Kjw?=
 =?us-ascii?Q?QH695/QykccATgcc5aVHDbh/Z1DH+KOQvlWQHo8igeis4nE/iv3mOMDTm/a1?=
 =?us-ascii?Q?fMhbaHZumHfAfudW44AEEUHqapLl3g1XqHYFBglZaENvXO/5zlLGj9X5JQl7?=
 =?us-ascii?Q?JfvMnEA+Qa2yhRv0zaAiXyzy/wZApaYQuvpTbxZWs+8TRdbwbHEqcAt2W+4r?=
 =?us-ascii?Q?ffIPDYzf3RA52Q9vOaEmD/y6oTo4/wbwNJFhRuyWGXJFnKhV1CsQzrMKjqWy?=
 =?us-ascii?Q?wb4YhWa6stOECvbb/pPZ5K7bcM+nZ9Jfoyb8aiQCpOGvo4KVtzIVACgaGpWC?=
 =?us-ascii?Q?tRe3B+r1l67hJMhJnfFACySJvPMJ9e3viT/68cuO4AIjW7IOy0HDE7hyM5ec?=
 =?us-ascii?Q?Qzi1AQpeEPKEvKTPE9CmJr91drD5gH8sGUoqlwPwlh1cgJropTmTKWgmssQ1?=
 =?us-ascii?Q?AObTlEDoQSIZniW7IDIouUa9yZs+b3SVBDXhe9XwOEgDNiAOhcQbpL2kjTFs?=
 =?us-ascii?Q?Xjbod6fpaoxy8zCj5tBPoCvAbo55IpmF1lGHjEB7ILZ15Y2q+zqRGnA5OZ+l?=
 =?us-ascii?Q?+FcKNAS1Pcrg9mx8cEH2KuOepfscPyl+poZYZzVU0UGjxxPaN1Cd9G8gBu/B?=
 =?us-ascii?Q?jHTOF54P6W/ZDdNdMPOToRFfZF3E7luwViEAUe5qyhCpAGY6GpxOlMvjn1sU?=
 =?us-ascii?Q?tpYlHhUEBtYGPw1A1yv/zKbzLo8F5Fna6PRM2mELEBAaDtzSEKxdzzovowJQ?=
 =?us-ascii?Q?FSIATOGMbIf+omAZr2Sz6OQE6EMILeDnAwNOzPA13R9DKNX+oIUHGL05t0vi?=
 =?us-ascii?Q?EfxNIEsE3er97tGqjBBNMlisBVHqMOTfT5J/lC4UWdT2WDLBBbKXmz41ldtJ?=
 =?us-ascii?Q?u+X62AglMBPJ7HJqOgCwu+oJ4zsIij2JBpz0lCAEqwO0h2U3vqIi9SLXaiJo?=
 =?us-ascii?Q?XRbVg53nR1+0UJtANcP1SjFNvtb44NrhguJDnHC3kEBSUI9f3NRwnMSSAQ9Y?=
 =?us-ascii?Q?xYlx2A4j+nNQv1sKHSSEvE2WfPEMW5urEP3/Jdgb/LVK4CW2S4MTfygx/S3k?=
 =?us-ascii?Q?mYR95R6cso6rNde36wrKI0Rvp52kWVtxTx6UwVkn2Gja22k0v5gDogmWw7Ni?=
 =?us-ascii?Q?1AC6NQqrUm1I02tvkj1cAnNkpCUYsCNrTao7UImk4YHXErBRCefwcderOXTx?=
 =?us-ascii?Q?jtzgcBL8wVXNyj6vgwAbJc+j5sRHgZ6y2Ae1sBVPPi7ASMwUgr9/irVx6DNr?=
 =?us-ascii?Q?AjOrGBXGTqT4gJ81Sa29RFKgpwdxBJN4JBr80sojaTDbPULEBjJ1TFtPS1nf?=
 =?us-ascii?Q?gDfpTiyXLIl3P2vz3PJAaC13V46opiOihbqaFaeRDog+hXzuFdKhIFFPgIX4?=
 =?us-ascii?Q?q0pfTz7tg+LWLAIvYTyGZ1c54wsrLVL+xQ1sji8L4GoF65rIOnx9qVuHCDjc?=
 =?us-ascii?Q?eUUs9Vu2SAkp2+uo65CEuKW65HkdcPMhhjlgSX/v6AIfQcKK7VH6Yf6OQtmc?=
 =?us-ascii?Q?xb6wI2r9PX4FXAIWYyUEgRYTybE85bO+nnQxGR+yt/A6ilVlvliAXmNN8nCA?=
 =?us-ascii?Q?W/H+byl6qw617BtsF7Pze7ocr5EgjA6F4jO5YPtqsxKvGPbHVPlYz5CuQJzW?=
 =?us-ascii?Q?yk5iFMxvQgH1n33DbTpYFsKcD+r46e9RpxnJm7jgzcPgA36G77LB0Eu8s1wX?=
 =?us-ascii?Q?AnZW4djUkvhlgGmxwuDjbK4MRxO5VJbuFqT8oxV8IBSXhzXn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb009909-ae20-4d6e-1cb0-08df2b938c31
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:41:22.3671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hRMo+LDGwuCGVGlICGltyTeKjtASd+43zlMLWws7rCIqDK1Hjg6l9ePAI1DH65F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_074131_954331_263DB664 
X-CRM114-Status: GOOD (  17.85  )
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

On Wed, Oct 14, 2026 at 06:39:14AM +0200, Ard Biesheuvel wrote:

> > I've asked some folks here to take a look and try to test this with
> > real DRTM capable HW. It seems very promising that it will work to me,
> > and I surmize this is also close to boot a UKI?
> 
> It already works for UKIs as well.
> 
> The next step is to run it deprivileged - I think the arm64 stub code
> is already very close to being runnable in that manner.

Abhishek was able to test it on some Grace hardware, and investigate
the DRTM. He was able to show it works, using some FW debugging to the
serial port and the post-kexec dmesg:

 <kexec>
   INFO:    DRTM service handler: version
   INFO:    DRTM service handler: get error
   INFO:    ++ DRTM service handler: TPM features
   INFO:    ++ DRTM service handler: Min. mem. requirement features
   INFO:    ++ DRTM service handler: DMA protection features
   INFO:    ++ DRTM service handler: Boot PE ID features
   INFO:    DRTM service handler: dynamic launch

   [..]

   [  10.655030] DRTM: launch completed

So this solution is absolutely viable for DRTM kexec. Great!

He had a couple of issues, I will try to summarize them as I
understood them.

1) ARM DRTM requires that the executing CPU be the boot CPU when
   launching the kernel. My patches enforced this in the EFI stub
   assuming that the EFI stub will be the same CPU as after exit boot
   services. Since the kthread has no CPU assignment it picks
   something random and fails these checks:

   [ 3219.695710] kexec_efi: EFI stub: ERROR: DRTM: boot PE 0x20000 does not match current PE 0x430000
   [ 3219.695726] kexec_efi: EFI stub: WARNING: DRTM: preparation failed, continuing without DRTM
   [ 3219.732742] kexec_efi: EFI image suspended at ExitBootServices(), system table @ 0x1001bff00090

   The kthread this runs in picks a random CPU so it doesn't
   work. Abhishek was able to put a kthread_bind() in to always use
   the boot CPU

2) Most of our systems use 64K page size, so the restriction in the
   series is not great. Abhishek used a 4k predecessor kernel and
   confirmed he could boot a 64k successor

3) Some compile glitches:

   1. arch/arm64/kernel/kexec_efi.c:175:35: error: 'PTE_ADDR_HIGH'
   undeclared (first use in this function); did you mean 'PTE_ADDR_LOW'?

   2. KEXEC_EFI_STUB declares depends on ARM64_4K_PAGES but nothing about
   PA_BITS, so a 4K + 48-bit-PA config does not compile.

   3. With rustc 1.85.0, which is what scripts/min-tool-version.sh asks
   for on arm64, the link fails:

     ld: arch/arm64/kernel/kexec_efi_glue.o: undefined reference to
     `__rust_no_alloc_shim_is_unstable'

     ld: rust/alloc.o: undefined reference to `__rust_alloc_error_handler_should_panic'

   He used rustc 1.96.0 instead and it builds fine.

Thanks,
Jason

