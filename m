Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121E8C35FF1
	for <kexec@archiver.kernel.org>; Fri, 14 Mar 2025 18:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YA4cz3IqKYs8g/T34NdCWeOqKjRd9LcnyNkGC/9OpFU=; b=E+pv3LLWEy41H6SMF9F0fsTGXz
	YXY1Sn1Y3qQ+UlbfNPyqu2qq9/LoiPBsYwN3xBik0LnVminh46NZLxAH7XikbqcDV4tCPGzLcMg9W
	vXNj9ZhlU6fnesUpAAzoijWpjvHQSkTXm1zXWDGPQM8siYB1JomvhJmsnnRjE0w9hCJCUBR698/pf
	Q2EuXrN8KL7+9T7yRG/NMeKduV/9oaMb4F2lG/6b4D4Q0fe/dUfNlmgZ/8FV0BYyacP/xo/iIzZsL
	QCWhRy0PYttzjY0VZTJd1hmlulF7KEiBbrIK1kTOrbU7+HQVchZY0xQ03vG7x4fP6FYujXJV7NPyK
	1gFi3ETQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tt9W7-0000000EzRU-2qjY;
	Fri, 14 Mar 2025 18:12:19 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tt9GS-0000000Ex32-0zTw
	for kexec@bombadil.infradead.org;
	Fri, 14 Mar 2025 17:56:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YA4cz3IqKYs8g/T34NdCWeOqKjRd9LcnyNkGC/9OpFU=; b=gUQO3UtyUMXfkoHY35Due7617c
	GQLNYIyJZ6cu5vT2UBXPDrWAmV0dG5RR+gk9dgwnutpLoljUUiHv1KXha68ASFKh0eQNsXvQPAkfH
	BV1pE5gV3kckJ9Zk1oa3GEJ+izc7bY1jHUqAgvXynaas1/9dxJfzLEaXDZmxG6n1s+tJZ3jiuEijP
	b8XpJxWBW4H0RvHS53dLW0+99NsJEiOpxTP69TJTY5pu24vCAipSQc6EjaxKhaVDe9kXF6NKwdnAT
	YfAJTMjs3RrHcwM8Er7/iWGVjdvRl9e5uXtsW8WVB/mYlzFTzEQPITJLsN0j4hmn/DiQozPaJDNrx
	YqcHAo9Q==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8ta-00000003tcs-2mto;
	Fri, 14 Mar 2025 17:32:35 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tZ-0000000CsW8-0KEO;
	Fri, 14 Mar 2025 17:32:29 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v8 5/7] x86/kexec: Invalidate GDT/IDT from relocate_kernel() instead of earlier
Date: Fri, 14 Mar 2025 17:27:37 +0000
Message-ID: <20250314173226.3062535-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314173226.3062535-1-dwmw2@infradead.org>
References: <20250314173226.3062535-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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

From: David Woodhouse <dwmw@amazon.co.uk>

Commit 2114796ca041 ("x86/kexec: Mark machine_kexec() with __nocfi") marked
the machine_kexec() function with __nocfi because I failed to make objtool
happy when actually *providing* CFI information for the relocate_kernel()
function that it calls, and __nocfi was the easy workaround.

When that eventually gets fixed, the check on calling the relocate_kernel()
function pointer may trap. Obviously that should never happen unless the
function prototype gets messed up, but that's exactly what the CFI check is
for.

So it would be kind of helpful if the IDT was still in place and the trap
could be *handled*. It can remain valid until the moment that %cr3 gets
replaced, so shift the invalidation down into relocate_kernel() itself.

This is a useful cleanup regardless of making CFI work, so do it now.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c   | 10 ++--------
 arch/x86/kernel/relocate_kernel_64.S |  9 +++++++--
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a2e00a814708..7abc7aa0261b 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -434,16 +434,10 @@ void __nocfi machine_kexec(struct kimage *image)
 	 * with from a table in memory.  At no other time is the
 	 * descriptor table in memory accessed.
 	 *
-	 * I take advantage of this here by force loading the
-	 * segments, before I zap the gdt with an invalid value.
+	 * Take advantage of this here by force loading the segments,
+	 * before the GDT is zapped with an invalid value.
 	 */
 	load_segments();
-	/*
-	 * The gdt & idt are now invalid.
-	 * If you want to load them you must set up your own idt & gdt.
-	 */
-	native_idt_invalidate();
-	native_gdt_invalidate();
 
 	/* now call it */
 	image->start = relocate_kernel_ptr((unsigned long)image->head,
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index cf736bbaec98..4f8b7d318025 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -79,8 +79,13 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	pushq %r15
 	pushf
 
-	/* zero out flags, and disable interrupts */
-	pushq $0
+	/* Invalidate GDT/IDT, zero out flags */
+	pushq	$0
+	pushq	$0
+
+	lidt	(%rsp)
+	lgdt	(%rsp)
+	addq	$8, %rsp
 	popfq
 
 	/* Switch to the identity mapped page tables */
-- 
2.48.1


