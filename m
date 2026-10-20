Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D371D606A329
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 18:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZrMnOHRT;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MqIbdFJz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bk7jnHkCaTC6apRDhn9sV5M02QmCrnv+VHnvjh6o6qg=; b=ZrMnOHRToZIevD24H0SJdmisGh
	iUsZkspEIIFWMqAFCuVpffIx35KA8scZ6WLNNYVGIwjeXgL9G6jTNn8AXUDnNVtiwbSPGP47/Pu3T
	0q6v7SBDFvDH0vc7GTUziIIF0wVS4XIGTsIRCBNWDINYInh+1OeqIzs0rAAFX7sqBp1VpvesOkw71
	Zz6cWrMuJbPos2PueK70CjO6mCP0suAMm63ESRtmMm5926nz6KKAu3FmbCoBCcXBkuZ6BQte3vdge
	xKZpnwphWmchJxOLNaccer5PhOOzFPmP0szEsJ6tMJWtVsr0H8+EFdi1Q5iFJAslEBTA5k0yHyEGz
	pZSZBXTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJEhD-0000000ASsI-3Jab;
	Tue, 20 Oct 2026 18:36:23 +0000
Received: from mail-southcentralusazon11011045.outbound.protection.outlook.com ([40.93.194.45] helo=SN4PR0501CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJEhB-0000000ASrk-06lD
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 18:36:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fes33Vb5bVLa8XJddrFIjcBBTUwtajjaRvlffgDQ75lPnC+08QizS12KEMt7QTT9h+gjrTK2KRPoAala+Wa0z+u09gtsWHF+vbn+hspSukZMBePtE4O6/n/nf47fJMsMR5Nfz5fTXPROtF+zTHIboGDrEazSRajYnYxcWPg9Q7gAGp9AkVqgvPsfFYo3begpjbq65KOrBA0DhgDGqywatG9221nriSxITXYS2f+82uVDVFqQ/ttrIAfLsIUGLmYhVptZu8DuQzRDhrjLfDcI/0wA7+ir/sSUGhEHPXqJgki6KnQTNkHlmke5akVfC+2wIxMAmvBUs0MsPm4bz8s3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk7jnHkCaTC6apRDhn9sV5M02QmCrnv+VHnvjh6o6qg=;
 b=ewj+LSIvP/qUYmSWWn0k/4mS/JTyplm8pJkKZ3txZ07vNJYFFBZ78Fqi8th+PTljU4QIW9hLK+kAhhZyF+OR+EjpAkFBwDMT8PQvEEFMxi4nESTRwr2lhd0Xht5Avg+FIKh7fLpKLLVKk1JyoDsev7x5tQDJVf4sjnLKZON//bTH9vQV4vbOaetHgo55PPtMK3oTWCanBUDMvqsqTOlZ0w7tsr/4Je/48bS/UF5mOl3B3pEW+fEV4lQugbazPexdbg5D5YT5FOzCxUfFai3M67UfflcCilB64n4FjYPcs7NapEX9geHTdKQtqAk4brCnWDDKrrg4B5i7F13rU12cEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk7jnHkCaTC6apRDhn9sV5M02QmCrnv+VHnvjh6o6qg=;
 b=MqIbdFJz2O+uKA1RQvKlyZ1nz2oX1//etAzoTK6UAwBfVXC6rS1nHh6gTXJrrImlHrrtCUuXV17hcUFDMyU52NbfEU5unNnKoqYOoIHqiNaY8TmzkKT6mzY6H1YVfIM3rV7LaFoEW7UXdLxvUH3g98PMniEwONaQuPrVfuzNbF++xZ3wxtTUvjH2gwjJzOI1Ac0VMSUgSDbzG1i4qLCoajvnwJuC6ilM9LB544tUN2cEmRoKvT/8wJWdGem8nrgZ1+zw3x60byBYm7+jlWJILI+zsDAEvp8U79doVmwLe08rEUkF/kFr8RENLlMtE6YMRAN3CG3as7f1YLlGqVOn1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CHBPR12MB443627.namprd12.prod.outlook.com
 (2603:10b6:610:36c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 18:36:10 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 18:36:10 +0000
Date: Tue, 20 Oct 2026 15:36:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Philipp Rudo <prudo@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Pingfan Liu <atlarge80@qq.com>,
	Mark Rutland <mark.rutland@arm.com>,
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
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <baoquan.he@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Dave Young <ruirui.yang@linux.dev>
Subject: Re: [PATCHv7 00/13] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
Message-ID: <20261020183609.GI3008132@nvidia.com>
References: <20260322014402.8815-1-piliu@redhat.com>
 <20261011201325.GA918242@nvidia.com>
 <722bd9d8-5620-498a-a6c2-d9a1f498e0b7@app.fastmail.com>
 <20261020194719.4fbd4e4a@rotkaeppchen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020194719.4fbd4e4a@rotkaeppchen>
X-ClientProxiedBy: BL1PR13CA0302.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::7) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CHBPR12MB443627:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3a841d-6153-4fbc-cf58-08df2ed90324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: JeAXw9a+mn8LyJe/njYKMpNN/PPk2t/IyBWkbWzOKF2ISpR40ZME0J7zZQdiwaGeDIfhXJtA1Mwv9rvurV8psjYx0vK6o1xeKXj3WAxx7ql1eA3YdF8E4zmRJVmP0W98JV6boE22bl5HCP84bywGo0aAvmhybU1noczIkR+ydwZahIh6AA6zLRGo84kjAaybP24fPNDDdHaAvxF0WY4j0VtKXyOKKRAtdOM/8f/qU4gAHX/FKg93b40ILLbUJS1t/hIvnclu3TOu0xIwx0BnepRwHPh/LjVblRa5Vh1PPH0h7jeYbgLv6hl+c1gy03YDvxRWaAYk4sexoQj/Be7iDKh5elkQ6m14TELX1N9wM4ILe2v/9CTBByRKgEZgD9xIcfPl/g4NG6W9eiG4JKPi82xxBlw1PiC3iIewE5vNQU6o8sa3cEwssl/n9CLRg6iWmrto0S5ez0NYKMdEAysIOZlIVVgy170ziHuWAhJZ4129UZ9RbcP7vvEeq63Z4PS1vOrKi0cOff3rtUByIXhMJhA2d4OuGBtXv35RHmopRLcF0MQ3L/bUonGXYOVi4RxgaLFM8wy7OQhmzedgWyUMdClFqpz07np4SRdfvbPuQ22/sqNNDCudfFlHh6/jZrjYbvmbC+FCxkf8dVL0VHgOpOsyx+1Nz6x5hJW3qZdRcGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v3+H6yWAyfD5DNL5jPyCA2q3JE99nw6kysQGYRtbH+5DKzy875lLrkIEJ793?=
 =?us-ascii?Q?2NuWok1ZKkyLnEe1Yn8opIaUcGQovf2z5tavvwSlWVGK/96ZHwguHGj0hOSi?=
 =?us-ascii?Q?5REkdJdUw8hhioBF5MyUaj1DmkMOUlWMFud/BE/uHN8xoZP3c872ST3MUe5v?=
 =?us-ascii?Q?trKb5lo0TETfrV6i7ngVnh7EpkpKE3XDwoxi5IGoh1REMxq3SUe16d1omRXr?=
 =?us-ascii?Q?5C85D8KcbgK7Il5PDxVWB/EfklxIY2tS27gjH+pO4CkEanP53wBK/rXJ6RPV?=
 =?us-ascii?Q?v0oI5A1BjHBD5g6fd14nMclLd22vuAlj62kluwH05rIqk31Mya2NtPnSVrHm?=
 =?us-ascii?Q?qeXu/750Tl/I/9nZTJFhGeWaWUF1it8biMXRVsZ3RdLqZwRAlfIC7uhTN2lH?=
 =?us-ascii?Q?dH9CGktIYnn0FaHn6gD3ZOAuxnOiSjxs8sF8Km1+ELt2c2QRuMm1adfqPDPC?=
 =?us-ascii?Q?G7k7GWGlxgYfnFoK6VEcoaxh7rc/GjTKoY8M1lek7Lt16R1iVGRZgm6WXcmN?=
 =?us-ascii?Q?16vOhVWHAcqegFpGAuuhrrsX5j5xDAxIHr2Hc7ZiwCAJrI8i1E1jtx/Q7mek?=
 =?us-ascii?Q?IgZM5AQdUi15Vh/QdOIXJziorSL0AfpyiEDFsiNx3dLE1HzEDkS5WOsd+Vjm?=
 =?us-ascii?Q?3LuHFrDunQ53rnDAciEvpJPRogbED85qQuobyZzJHA2SBadlZQeWabDZi2KP?=
 =?us-ascii?Q?YTEJ7o/Emv/ficNkWz47vAdyGOMNzdefiqI67DQIvcMLl0svzLFEetRtGK3A?=
 =?us-ascii?Q?VT/oku9uQoUscaQbJU25qVqEQSK4sJZS5q7WfhXFwcoxXAeAJk5WwtaXI0S3?=
 =?us-ascii?Q?qiQ5+4CCCPnaU1EDshSEt8uYW1L+5iv+x/7CB1p8UQg76Mmy/0wSd35EfTxM?=
 =?us-ascii?Q?ZuDXEEjoQIdq4QNPpmHWDxdkAIxZaxbdiKF+FbzB73hqASIdANGwVmCthUHi?=
 =?us-ascii?Q?h7XX2Sd0v8EcrdcwDGRshEZprZauVP4NsPwTzUHrokSPE11oo9TvgN6ZmNGm?=
 =?us-ascii?Q?+4JQEzsFyIKaR9xOfxF//4RyQmMtrcE8R8PBqTZIQiz1HfCH+bjWNRa5k89X?=
 =?us-ascii?Q?qDKcWqEzG/bvyvpf4AMKmVqh9krqR2mBovqupukEK91ZX7UHlN+iie5fTATi?=
 =?us-ascii?Q?rLxVsgSlulbzO2LLWC0T0k5Miiwka70pwkbU6X0jPJ3vmChJb5ZKPA0x9l5k?=
 =?us-ascii?Q?FifOiYdx/l79mwfHCMaTZcHxzgBkoRI4SKmEwIJ4nS/pLKnfsZdQM36UNsoH?=
 =?us-ascii?Q?+VtqEaT8k6SPUVQXKzXY/7EK9URChamxdpvh75mwvOyuPxtoHmqiVN8tmhL3?=
 =?us-ascii?Q?aNhQPxHtLdLh2aQMkYNtjBdHIfYr9UMB4WrYyFiau8s4b5/kIvszpCGAlhFo?=
 =?us-ascii?Q?OzQPDi2Mk6yFOtmoxcc2FFTfFf2U7F183JndFWiP+gip1bPJmHryZl3zv5Du?=
 =?us-ascii?Q?lBxd9gy74pUMz//BrpAdTRsW/JVnq28vDIDbbU6xsGorJJHfOQei/ZgEcSQP?=
 =?us-ascii?Q?r6543fyAkOZmQsIvnmNLZJTN0l6TJDTo73Pxj7tTCHuys7ubmAHA6ES0OwqR?=
 =?us-ascii?Q?Bfx1mhtEPnfeoZgpXN8ONWxlvziR4g8ZrPkuwBzLxIt0sFnH8usBEINiLNZQ?=
 =?us-ascii?Q?FUahMTPdC0IIQJdrK+OOu5hYhpyOkgNCm1YnvPVWNGXQNV0kAbRPr8aSYSu0?=
 =?us-ascii?Q?eTO2UUme/lzrtvKpr1GCBYqK4nZCvuLsYhzdqbHwrr4Qnymb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3a841d-6153-4fbc-cf58-08df2ed90324
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 18:36:10.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOQ6QQFnT+g7MMZRiFdXnM9tOCTXM63RzmSbna/Al1OKLUYK7hM2ANG8db84OWbR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB443627
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_113621_066378_B4BC7DE3 
X-CRM114-Status: GOOD (  17.06  )
X-Spam-Score: -2.4 (--)
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 07:47:19PM +0200, Philipp Rudo wrote:

> The reason why I and Pingfan abandoned this approach and went for eBPF
> instead was due to security concerns. Our premise is/was that the EFI
> stub must not be able to harm the running kernel. Be it intentional or
> not. That's a guarantee eBPF with its verifier can give but a simple
> file signature can't.

This seems too much to me, I think the approach of signature
verification is sufficient. If you can load a module then you don't
need to fiddle with some covoluted EFI attack. Distros should include
their EFI signing key in the kernel keyring so a standard UKI passes
the test.

The eBPF approach fails from my perspective because it never actually
runs the stub code or using the EFI entry point. My interest is to
actually use the EFI entry point, not just treat it as some convoluted
zip file.

> But that still leaves the "unintentional malicious" case. Meaning,
> that someone tries to be "smart" and does weird stuff in the EFI stub

Buggy modules exist too, it is up the signer to take a position on
that, IMHO. How can you have an "out of tree stub" if the only things
loaded are signed by the kernel builder?

Regardles, Ard's suggestion to move the execution from a kthread to a
user thread could provide enough isolation to mititgate even this..

> Two more comments with my distro head on.
> 
> First, kdump is extremely important to us. So the final solution needs
> to be able to load a crash kernel as well.

And you want this to be a UKI too?

I'm not sure it is so good for crash robustness to have so much more
complexity in the boot path..

Though I wonder if you can run the EFI flow when initially loading and
staging the crash kernel? Then stop at the exit boot services and wait
for a crash before jumping back into the flow.

Jason

