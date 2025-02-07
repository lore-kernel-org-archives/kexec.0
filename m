Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9BBC02192
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 08:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xGCEQWnsV0DXZyX4AZtteWaBo+Ye/T/FHSq8IEPdnnc=; b=A/WftuBuauRmaRwabw7CFb0YDY
	i0I8xRDWUKCSvQHwgdt2izkfhbDY3ZViaa/DGkGg7Sis4iZAT3pLG497CId2leNr4u2Z+o2j7ACZE
	R7ndEKD5cdku0BQk9mlHzAZm7CHhRpXZ9Od9csJGPQ92pfKiOyK5fe71cZtuOfFWCJEgundPSIwR5
	WjU5UgOgL7euTwCE2kBVBBQ57ZiMBLDmtzaxSWextowFaV3P/SPFl6jFlAaWqPS/WEbJXF70aMkmt
	nd9vdR6Eqc7q72Ps/zLLsW3AcyzMStUKwvw6TWQdN0rNXJw2IXBH3GhrFbclBdGq76+XqIHSlZaRw
	X5912bHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJJ3-00000008jGR-1wa6;
	Fri, 07 Feb 2025 08:01:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJJ1-00000008jFR-0P80;
	Fri, 07 Feb 2025 08:01:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9B37C5C662A;
	Fri,  7 Feb 2025 08:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CFCC4CED1;
	Fri,  7 Feb 2025 08:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738915302;
	bh=kFDeL/SJLlnJWVrJNKoLmxn9dhqX2WUHrbLloiO0mH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FjyuP9Y4T8Fan+zoNUKCQyuX6jxV85gLTZoZl7hEYpJX0wcJ9Ctafn5JB4bniEoFv
	 SRkEJ61x6qG5jit8nnguB76u3YF0z83cdx1SC73KnrQlo65sYoDYjNF/UqkYX8TYUd
	 bCmI4+wD37/kwXdMLzB1jxhIP+dKPVsS2Ufjzms022j0pW2Bt1nKew4tWOZJRGhCTD
	 kgzARsNkHKsPZIn6VJM0V5oKERYoKKUqLbyB+tjXl7V0B9DPzDkjQjNaTK6Rlw8X1m
	 qoMEe5lFxkKWH3vGFGn4uYLipyVg/XSaNFkC30V3xMSio2VBL0kcdTLfmhgm1pd5gF
	 SflwleruakgWw==
Date: Fri, 7 Feb 2025 10:01:22 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
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
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
Message-ID: <Z6W90hz6WaXfZCjQ@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206205030.38d84d4062786c9e36a825b6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206205030.38d84d4062786c9e36a825b6@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_000143_221791_51D9758D 
X-CRM114-Status: GOOD (  20.39  )
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

On Thu, Feb 06, 2025 at 08:50:30PM -0800, Andrew Morton wrote:
> My x86_64 allmodconfig sayeth:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: kho_reserve_scratch+0xca (section: .text) -> memblock_alloc_try_nid (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: kho_reserve_scratch+0xf5 (section: .text) -> scratch_scale (section: .init.data)

This should fix it:

From 176767698d4ac5b7cddffe16677b60cb18dce786 Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Fri, 7 Feb 2025 09:57:09 +0200
Subject: [PATCH] kho: make kho_reserve_scratch and kho_init_reserved_pages
 __init

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/kexec_handover.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index c21ea2a09d47..e0b92011afe2 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -620,7 +620,7 @@ static phys_addr_t __init scratch_size(int nid)
  * active. This CMA region will only be used for movable pages which are not a
  * problem for us during KHO because we can just move them somewhere else.
  */
-static void kho_reserve_scratch(void)
+static void __init kho_reserve_scratch(void)
 {
 	phys_addr_t addr, size;
 	int nid, i = 1;
@@ -672,7 +672,7 @@ static void kho_reserve_scratch(void)
  * Scan the DT for any memory ranges and make sure they are reserved in
  * memblock, otherwise they will end up in a weird state on free lists.
  */
-static void kho_init_reserved_pages(void)
+static void __init kho_init_reserved_pages(void)
 {
 	const void *fdt = kho_get_fdt();
 	int offset = 0, depth = 0, initial_depth = 0, len;
-- 
2.47.2


-- 
Sincerely yours,
Mike.

