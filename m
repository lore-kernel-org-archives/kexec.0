Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEDFC35FF4
	for <kexec@archiver.kernel.org>; Thu, 13 Mar 2025 17:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CswYvkTCCpMoqI89+nDZxiVOs2267PjAonInzOt/Nt8=; b=HY3wFQGxvymaHppom/otFCF3wv
	+0in5Fj2L+FKZt+HIOoF/CI1LQ6bGiFOGH7m/TNXzQisr4qjVXR1QudnEGcjMPGFucThJha0VsB40
	+n3hgaiDDIud54T9jngThXXMxCxKgNOl7kkhr3T7rag9d/phHSjAGOwFsPzksRlmMQsdL4HB4nuxi
	jGAeztqhCK+VvK6SY9udsusQXKUSHVI+NWyLXP0j0d3q2K3Mumx0Dg9ruGihBx9Cy4vWY7D1NFequ
	UJGxcoBG1w+H33JvC+56e4kI3VYNspiTvhJyaVdFd7Bd5OpFcZgf2Hf/K350NZvfCqY8ouUrkr7zh
	ajOwDh+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsm8O-0000000Bwbf-2dRl;
	Thu, 13 Mar 2025 17:14:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tskhE-0000000Bh4N-1aEa;
	Thu, 13 Mar 2025 15:42:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CswYvkTCCpMoqI89+nDZxiVOs2267PjAonInzOt/Nt8=; b=g1oC0vFsj3Oxsz54rtwrRHjc0i
	E15wVFKDs8pLY8iyl7W0fv6+CECED2BS1qIBrNHS8kssaD6rpkmhydqVt6JXQw0JWNcT5qcVtvFvY
	A5HDao+eHxd382odU8XtlbJDSh80qZuIWCCBsoKbfYKTpnYFY02dOAHCZSQZmOqBZD3UJ3ZL8tEb+
	ecvw60vM7SeG/41b/DqSpPhM/cmjki+rB884btvDNO0WtOJKUdY4ILT8BTEWZxpnl817mTwpPfnAU
	I/Hci0ylb65NCSvgym+Yb1fKfzRma1y/2ydG1RH3X/ycTt+exC3QJN5nnJPbrgctaWcl2FEG+Xz6p
	Hccdt4dA==;
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tskhB-00000002jSm-2Cq8;
	Thu, 13 Mar 2025 15:42:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5A9CFA4761A;
	Thu, 13 Mar 2025 15:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551C0C4CEDD;
	Thu, 13 Mar 2025 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741880523;
	bh=GcM0bWRw3lqkKiGt9DpFV6nSyrYsqck9QyyQooLhfPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKh58mif1encnvopzGQ5g8u81BpNzKKnyR1m8qQQQQFsKjRMEMmH1J//1xRJ5mY+w
	 +H0rEJc6wrjQUj3wd777qw2QfvQjIWB0AR2T70uuujeB1ejksQBfCUO87h9BVIHPSU
	 EZf/Vb9bfsLAd5804VEg7rkdIybciqmUjvetIuWmGMJ84FXQyT7iHjS568tt72VEVk
	 FRkxZ8Ca9aZ6XB58b8x0LzI5TYCEjiBXVU6/z6yxmeUH5TYR/UvYrtb/yreyKwFLSF
	 WcTGizKXWyQKnMpHaxLruLRZukNBESLeygP4Jc1ORmrQ2H+ICYqgn7slmdqFHAU+2/
	 gJkGfc1gvGyRw==
Date: Thu, 13 Mar 2025 17:41:47 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Changyuan Lyu <changyuanl@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 02/14] memblock: add MEMBLOCK_RSRV_KERN flag
Message-ID: <Z9L8u4XP5U6iq5Gu@kernel.org>
References: <20250206132754.2596694-3-rppt@kernel.org>
 <20250226015342.2136669-1-changyuanl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226015342.2136669-1-changyuanl@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_154205_784659_E3BAD2CD 
X-CRM114-Status: GOOD (  21.56  )
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

Hi Changyuan,

On Tue, Feb 25, 2025 at 05:53:39PM -0800, Changyuan Lyu wrote:
> Hi Mike,
> 
> On Thu,  6 Feb 2025 15:27:42 +0200, Mike Rapoport <rppt@kernel.org> wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > to denote areas that were reserved for kernel use either directly with
> > memblock_reserve_kern() or via memblock allocations.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  include/linux/memblock.h | 16 +++++++++++++++-
> >  mm/memblock.c            | 32 ++++++++++++++++++++++++--------
> >  2 files changed, 39 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index e79eb6ac516f..65e274550f5d 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > ......
> > @@ -116,7 +117,19 @@ int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid,
> >  int memblock_add(phys_addr_t base, phys_addr_t size);
> >  int memblock_remove(phys_addr_t base, phys_addr_t size);
> >  int memblock_phys_free(phys_addr_t base, phys_addr_t size);
> > -int memblock_reserve(phys_addr_t base, phys_addr_t size);
> > +int __memblock_reserve(phys_addr_t base, phys_addr_t size, int nid,
> > +		       enum memblock_flags flags);
> > +
> > +static __always_inline int memblock_reserve(phys_addr_t base, phys_addr_t size)
> > +{
> > +	return __memblock_reserve(base, size, NUMA_NO_NODE, 0);
> 
> Without this patch `memblock_reserve` eventually calls `memblock_add_range`
> with `MAX_NUMNODES`, but with this patch, `memblock_reserve` calls
> `memblock_add_range` with `NUMA_NO_NODE`. Is it intended or an
> accidental typo? Thanks!

We were mixing NUMA_NO_NODE and MAX_NUMNODES for memory with undefined node
id for a while, with MAX_NUMNODES being older and NUMA_NO_NODE newer define
for the same thing.

To make sure both are treated correctly in memblock we use
numa_valid_node() to check if a range has node id set.
 
> Best,
> Changyuan

-- 
Sincerely yours,
Mike.

