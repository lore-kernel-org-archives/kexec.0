Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F172C35FF1
	for <kexec@archiver.kernel.org>; Wed, 12 Mar 2025 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=smwmDBLOWfUhJklrdermZZW/GJNGuEkisxlZADiwt80=; b=ODDqDxeYwzbYN+UB50xqSAUFt+
	AhzS3XgtlbrOvkkTAe4e2IgT20CqO9WBL9aElFV0E6tdYL0SNTgGUd3xUBwQD/iG3Ogm1GkwksZSF
	osw3IAxmnmPhAfm7ZXttWdu1w7+5zST/phm4vZsBV4slmHTBxnEwaOFJ10Qqe2x6skvyiQcd36xSw
	NwlpsEMgd5ei5NPGTkgKQ5UV2iIzxnt4/g50+VYCP4XFo4m/QkPSCbAL7kyY5NGv/Sq+ZWwI4b2hH
	kzsHc59Mu4uyA6ShTlrAcZG2/+c/joUpfeoRTFA8y5710cemNUsZrCiabgdQ++pfZYw66sh+OKf26
	gcJEYLrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsOM7-00000008vlr-342G;
	Wed, 12 Mar 2025 15:50:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIV-00000008jRu-1WI4
	for kexec@bombadil.infradead.org;
	Wed, 12 Mar 2025 14:43:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=smwmDBLOWfUhJklrdermZZW/GJNGuEkisxlZADiwt80=; b=RbnOGxjYBz98oRqawqOY0eW/OF
	msz2Cc3lSLeyxwEwziWg51tcedhkawDdCSaIMwfmH9tDT3P4rjPwc6cQicRTetKsTKl+XQGKbltb4
	9xT1PMk/1KvwGc+fteEKwTTJV62/ucIaUbaD47TARCJfEDEy/Ijn3Sw5A4mZ+4en8P0KKb4vYV+mh
	Z1Ty6ksFmWmAUKMDy6uUnJqWZgGgy0ADNURLWpt5m+2hfb9HfCx4XLdw69SXy3sb/LCdM1wm6KoLi
	sKAKrSAUpanBRVteyV7SUZNWFcq7CZmqqO/+kuO8yMpgrmpkd7s7Y56qgS8bPoBYZ1lHas4xHa6u5
	+/GiIu+Q==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIS-00000002QEs-2cNj;
	Wed, 12 Mar 2025 14:43:00 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIR-00000009uUc-2cfY;
	Wed, 12 Mar 2025 14:42:59 +0000
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
Subject: [PATCH v7 6/8] x86/kexec: Invalidate GDT/IDT from relocate_kernel() instead of earlier
Date: Wed, 12 Mar 2025 14:34:18 +0000
Message-ID: <20250312144257.2348250-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312144257.2348250-1-dwmw2@infradead.org>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
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
index d58b4686645c..17d41e6e1a4b 100644
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


