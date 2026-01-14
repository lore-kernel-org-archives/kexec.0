Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A87D3900E
	for <kexec@archiver.kernel.org>; Wed, 14 Jan 2026 19:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=48pxd7azFqEQddtR6G3+UaBvVGoFI1N2sWGg6qeVLpk=; b=qMCStMU8bPGt+PP0SyuOVlb9fx
	w8rMbdmA6q6esDNeKkjfUul5THi8uKSBncQ0WNd1AKIYkMhlbWJJcTRWj/alI+kgMmPPQhstflpgu
	fePt3rCvrwOTnOI+CpzVmZaaxRnIalrVCnH0SV5LDs01zlwuF32H1YRSGMZ6YYWFNyMDW6YQDffxf
	76WbznTB9y089/Y9tGb+rNw0oBwq8NvvM+vWk8f1Ahd6ZDnUxhgDGLXm3DzmMxiiX+KCc/4/egxed
	fXRojHILKXgykWjvG8BAlZ2QojLc0nKHum40+lr1W/DN5Hun8IrDw95AmroYUQNdCgnrngi2IMIHF
	of7mjqOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg6Ok-0000000ASfK-1wDv;
	Wed, 14 Jan 2026 19:19:18 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg6Oi-0000000ASd9-15b3
	for kexec@lists.infradead.org;
	Wed, 14 Jan 2026 19:19:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B110440CB;
	Wed, 14 Jan 2026 19:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52919C4CEF7;
	Wed, 14 Jan 2026 19:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768418355;
	bh=PbSt1EkBjctA/aoLe3SvAGeQvdWaG+2+t05R+3HiR8Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L7mkoktXP5v0/RPVXM+q7CecPRvSeFXAVpTa/6Zi4HnKjplmUZN/H5wnjKazdmLdp
	 H8M4zx8EUPxaLtXjGTqFH4oB6mjnLPWC/BSPgdkl4h2qIjZ/HPjQL5aCE1C0JM/lhq
	 Le4s1EByn67fR4X3Sa7CgHV2tayNiIxZZYNGWS0+oRh+u/liq2Tsmx8K7sVndzLSmb
	 B0Z/FnUjSciukjiyp38oAqsfq7wdzGJRRZK4KfYUMTPZauyEEJt4T0srAwNTH5//SU
	 s/XWZE0wl+KGlzUFup0xv2Cgj76r0cxJJKixyGJzRWoML2Ql4GrYceFXQiAQ8Lx1rb
	 G7k8chNnYAEAA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  rmikey@meta.com,  clm@fb.com,  riel@surriel.com,  kernel-team@meta.com
Subject: Re: [PATCH v3 1/2] kho: history: track previous kernel version
In-Reply-To: <20260108-kho-v3-1-b1d6b7a89342@debian.org> (Breno Leitao's
	message of "Thu, 08 Jan 2026 08:40:58 -0800")
References: <20260108-kho-v3-0-b1d6b7a89342@debian.org>
	<20260108-kho-v3-1-b1d6b7a89342@debian.org>
Date: Wed, 14 Jan 2026 19:19:11 +0000
Message-ID: <2vxzy0m0gfyo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260114_111916_325530_1E194A20 
X-CRM114-Status: GOOD (  17.16  )
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

Hi Breno,

On Thu, Jan 08 2026, Breno Leitao wrote:

> Store and display the kernel version from the previous kexec boot.
>
> The current kernel's release string is saved to the "previous-release"
> property in the KHO FDT before kexec. On the next boot, if this property
> exists, the previous kernel version is retrieved and printed during
> early boot.
>
> This helps diagnose bugs that only manifest when kexecing from specific
> kernel versions, making it easier to correlate crashes with the kernel
> that initiated the kexec.

The KHO FDT is ABI. So you should be bumping the version number when you
make changes to it.

But honestly, adding this "optional" stuff to the core KHO ABI makes me
uneasy. I say optional since it is not needed for the main functionality
of KHO. Making this a part of the ABI increases the surface area we
have. The more things we stuff in the ABI, the more inflexible it gets
over time.

Any changes to the KHO ABI means all consumers also need a version bump.
This includes LUO and all its users for example. So I would really like
to avoid adding optional things in core KHO FDT.

The easy fix is to add a separate subtree for the optional metadata. You
would still need to create an ABI for the data format, but being
independent of core KHO, it will make it more flexible and easier to
change in the future. You can keep the code in kexec_handover.c.

>
> Signed-off-by: Breno Leitao <leitao@debian.org>
[...]

-- 
Regards,
Pratyush Yadav

