Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613A7C282C6
	for <kexec@archiver.kernel.org>; Fri, 28 Feb 2025 20:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oMsvCa0RZBbh1a14dfeYFwcIWgC4rKUWn90abl03P5w=; b=YTIHs6DZDreeKPHTuzCG7L4jPx
	tiSCjFcukRhhuIz3m6wmXiXf22Va7AWGKWbJhR93vLhDMzHty4ckdheCqWiRUFPZ6g4hUlA8te0cf
	KmPaK1Z1HvQseoEsc6TR3NN2PCGg5Bppr8rKZNWB6jm3KZrp6GuqIfInTl9eevhNCbjTuE9NyxqSK
	dScM/7S92L5A0BdvBVOeiHhfnK+rjsg5I5i/PpJwQmmtS2BRrAKLN4bvwCmD0yQfmIQmKxwORY5wu
	6XvADO/kFhrrJ6fTguKUA+E4n4r9/vyjT74s0IfD6uGbQjs3oO3lZFJVB8OZy9g2SGILYarLEyUnR
	cisiW8mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1to7Iq-0000000Ceit-0iLo;
	Fri, 28 Feb 2025 20:49:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1to6qk-0000000CZVy-2Fvm;
	Fri, 28 Feb 2025 20:20:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9F51D5C62F8;
	Fri, 28 Feb 2025 20:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A39C4CED6;
	Fri, 28 Feb 2025 20:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740774045;
	bh=bbzE7bwrYKBUNI91akgimXhe+iLOXIRvjnh9wKEiBG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfFIn91KSNHhn07yKT9l2oOU8euWhSQeLxxD1+CP5Lmkt8N8i6O/Zn9pEs4NGiCJj
	 qJEjrvhzqZMOIYECg3O0McklsQMWurW5bICaO6Eqlily54ppx+yXiPrIfcDSkbmmEy
	 mgA+RTO662SeKhJ/BeytWpw2yGPCMjmkdX2P8FuJVAKh+rj8Ay73HcAZ8F0mxABP/0
	 t/Etv53LQUPDT8LDrOxXxcp5ZTSXxggaTWVIPD4REQMGOIcj+m3X88aLIXEmmDQWmj
	 830FksBD61RtpQPNDjonn0bpZ2XqD0baA3+sDkYSi8hDY+Sf6kIPnRC3EZcEYLP+NU
	 hO0vT2n2HTtbg==
Date: Fri, 28 Feb 2025 22:20:23 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
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
Message-ID: <Z8Iah6FgrhSzApwf@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <mafs0cyf4ii4k.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0cyf4ii4k.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_122046_683263_39FE624B 
X-CRM114-Status: GOOD (  28.92  )
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

Hi Pratyush,

On Wed, Feb 26, 2025 at 08:08:27PM +0000, Pratyush Yadav wrote:
> Hi Mike,
> 
> On Thu, Feb 06 2025, Mike Rapoport wrote:
> 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > Hi,
> >
> > This a next version of Alex's "kexec: Allow preservation of ftrace buffers"
> > series (https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.com),
> > just to make things simpler instead of ftrace we decided to preserve
> > "reserve_mem" regions.
> [...]
> 
> I applied the patches on top of v6.14-rc1 and tried them out on an x86
> qemu machine . When I do a plain KHO activate and kexec, I get the below
> errors on boot. This causes networking to fail on the VM. The errors are
> consistent and happen every kexec-reboot, though fairly late in boot
> after systemd tries to bring up network. The same setup has worked fine
> with Alex's v3 of KHO patches.
> 
> Do you see anything obvious that might cause this? I can try to debug
> this tomorrow, but if it rings any loud bells it would be nice to know.

Thanks for the report!
It didn't ring any bells, but after I've found the issue and a
fast-and-dirty fix.

The scratch areas are allocated from high addresses and there is no scratch
memory to satisfy memblock_alloc_low() in swiotb, so second kernel produces
a couple of 

software IO TLB: swiotlb_memblock_alloc: Failed to allocate 67108864 bytes for tlb structure

and without those buffers e1000 can't dma :(

A quick fix would be to add another scratch area in the lower memory
(below). I'll work on a better fix.

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index c26753d613cb..37bb54cdb130 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -623,13 +623,13 @@ static phys_addr_t __init scratch_size(int nid)
 static void kho_reserve_scratch(void)
 {
 	phys_addr_t addr, size;
-	int nid, i = 1;
+	int nid, i = 2;
 
 	if (!kho_enable)
 		return;
 
 	/* FIXME: deal with node hot-plug/remove */
-	kho_scratch_cnt = num_online_nodes() + 1;
+	kho_scratch_cnt = num_online_nodes() + 2;
 	size = kho_scratch_cnt * sizeof(*kho_scratch);
 	kho_scratch = memblock_alloc(size, PAGE_SIZE);
 	if (!kho_scratch)
@@ -644,6 +644,15 @@ static void kho_reserve_scratch(void)
 	kho_scratch[0].addr = addr;
 	kho_scratch[0].size = size;
 
+	addr = 	memblock_phys_alloc_range(size, CMA_MIN_ALIGNMENT_BYTES,
+					  MEMBLOCK_LOW_LIMIT,
+					  ARCH_LOW_ADDRESS_LIMIT);
+	if (!addr)
+		goto err_free_scratch_areas;
+
+	kho_scratch[1].addr = addr;
+	kho_scratch[1].size = size;
+
 	for_each_online_node(nid) {
 		size = scratch_size(nid);
 		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,

> -- 
> Regards,
> Pratyush Yadav
> 

-- 
Sincerely yours,
Mike.

