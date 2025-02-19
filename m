Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7F7C021AA
	for <kexec@archiver.kernel.org>; Wed, 19 Feb 2025 07:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TWGXF7MV8G9MqF/3hcMNPYM338Vdzeo61cefvJOSakI=; b=Rn8szrgpDUDm6ABDzvMwsbAyi/
	mCEaxvHPNwMadG4uEzxL7SHX1Qruka0Cwr3jineBFOSuo0V2nFp1rZsmAj2FEG5fIe9kSKrmEnT0q
	6WqazMtdLBa7DHU2jdZT1Hl3PiWM4sefRd9DjBDB7ocbYpLAcLepPq1FVvVpmmscIeYnlowpcpLtc
	1nlG6JZM0LRWStWOHQ/8jQd5dvqR9vMpf/FvYp20K/xWBJ4gIkyvbp2LLUKK34Z01bQ4Vd+CHQe4r
	yC/MPUBlog9s0rY8LfFH594Y8XrmsoNc1ZgQTTJITWG01haT28wke8D7ao6BT1ZjT+Qqzspt7XhdN
	w3VD1+IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkeSI-0000000BE8A-3Y0V;
	Wed, 19 Feb 2025 07:25:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkeRz-0000000BE0x-3v2f;
	Wed, 19 Feb 2025 07:24:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7F5B45C4B20;
	Wed, 19 Feb 2025 07:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1235C4CED1;
	Wed, 19 Feb 2025 07:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739949894;
	bh=SRqj9MZLCV8OPtw+RLc/L0/R3k9RqsqUSw55QX9OOlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtKBbQaYTslR+0p7SefBILIuS73xk2HkHE9X1wi3f1RYXdzexSpsyIrHcPKNtZYjL
	 BvKiLvIz6tiQbKcH9IhyUrzpRPaTkQMGYuEz3o1+LwRY6+cXJ2ZdV6QYVU7JbUtlYQ
	 05YBQSpFJ0o9+4PFttNGG2I4B8gyRtwm24/vnas8DwL/rcu9i5Hz/rxhmWxht1y1Dw
	 wkLpe3ZZgtmacfwPN46ynU8iy+ypPSs9dwF5Tdr7KWenmjNUChafxZkv2PmgFVMNfi
	 6mdnd8DQM0qYd4dN8GiXu45YvQUX49U1bZ45kTkOBpF0wvbKLl80gJxVUX5K2raMUR
	 MM9jdOERGv5AQ==
Date: Wed, 19 Feb 2025 09:24:31 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
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
Message-ID: <Z7WHL_Xqgoln9oLg@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218155004.n53fcuj2lrl5rxll@master>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_232456_081084_CF3DC300 
X-CRM114-Status: GOOD (  22.98  )
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

Hi,

On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> >to denote areas that were reserved for kernel use either directly with
> >memblock_reserve_kern() or via memblock allocations.
> >
> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >---
> > include/linux/memblock.h | 16 +++++++++++++++-
> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
> > 2 files changed, 39 insertions(+), 9 deletions(-)
> >
> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> >index e79eb6ac516f..65e274550f5d 100644
> >--- a/include/linux/memblock.h
> >+++ b/include/linux/memblock.h
> >@@ -50,6 +50,7 @@ enum memblock_flags {
> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
> 
> Above memblock_flags, there are comments on explaining those flags.
> 
> Seems we miss it for MEMBLOCK_RSRV_KERN.

Right, thanks!
 
> > 
> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> > again:
> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
> > 					    flags);
> >-	if (found && !memblock_reserve(found, size))
> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
> 
> Maybe we could use memblock_reserve_kern() directly. If my understanding is
> correct, the reserved region's nid is not used.

We use nid of reserved regions in reserve_bootmem_region() (commit
61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
know the distribution of reserved memory among the nodes before
memmap_init_reserved_pages().
 
> BTW, one question here. How we handle concurrent memblock allocation? If two
> threads find the same available range and do the reservation, it seems to be a
> problem to me. Or I missed something?

memblock allocations end before smp_init(), there is no possible concurrency.
 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

