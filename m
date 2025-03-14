Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11087C35FF8
	for <kexec@archiver.kernel.org>; Fri, 14 Mar 2025 17:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ZEU4ooB9JbXRgCaEf2/WOsbQmZpDXUsz2616q1hGqk=; b=zqGJ4DLtDMkfo1W8oTzCbfQFU/
	BWR8cFuuc5UZTzyymX/K1kS5oS2J0Wcsbtvi/wKbDf1YH0cvPfN5yNOgTQ2IRldlZY0hijj2ZgUWN
	LJA694Lvy28ccOSMc+LjeJn2eoLmShKt+hRzFWTwWlldPg5XFIT+dDYundrGHoBOZlkksUkAjzWsB
	wUxd/1W1rBr2YXWyMZRpMgS2vlKLOQHAKTHsk2DR2ohY2jA1LcsohwCPejssrJL+qI+unuCb7mx9E
	esUM74xEKn/jBADWDU8Ejt9+KufJV20hMtG4hpNdsEq64Gz/jEjBYjp01nk7tOTt20JVBejM/1ykb
	hMhy2AUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tg-0000000EsPy-3JuT;
	Fri, 14 Mar 2025 17:32:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8te-0000000EsN3-1gxj
	for kexec@bombadil.infradead.org;
	Fri, 14 Mar 2025 17:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7ZEU4ooB9JbXRgCaEf2/WOsbQmZpDXUsz2616q1hGqk=; b=h8NSWW9622lyf+TkR66+QUn3pB
	vnD9qJh9YuRa82X3/xejTJyv4mUvkP02rihXQkbmK9S7TSOHAABGDtKRRHlDRYrdEU4RlAO/8S3fE
	DcDjjNZLB5FK7pL7gWtdVbWck58neWnKh6XbdGCIWD6Pv/qO6tNprEj3VN1ZIBdPkFfb8JyBxEtIB
	6/evZ7cZ3tJC0hGc1NaK6/wjYhN/TtnpM9KV5whneVvCSs2tMHyluC+6Q71rzWr883CJu2uvYXgGr
	5S44TQNl/dX2pQ8l22tfnJP5WyVBCDevxUUtj5gBd/PzlSSYlvJ7mjBfb0v+/vDhpb+m0T2CVAw8R
	4V0G+bcw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tb-00000002vUA-3fSj;
	Fri, 14 Mar 2025 17:32:32 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tZ-0000000CsWL-0pvp;
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
Subject: [PATCH v8 7/7] [DO NOT MERGE] x86/kexec: Add CFI type information to relocate_kernel()
Date: Fri, 14 Mar 2025 17:27:39 +0000
Message-ID: <20250314173226.3062535-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314173226.3062535-1-dwmw2@infradead.org>
References: <20250314173226.3062535-1-dwmw2@infradead.org>
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

A previous commit added __nocfi to machine_kexec() because it makes an
indirect call to relocate_kernel() which lacked CFI type information,
and caused the system to crash.

Use SYM_TYPED_FUNC_START() to ensure that the type information is
present, and remove the __nocfi tag.

I still can't make objtool happy with this in both GCC and Clang builds
at the same time, so not yet for merging; only included in this series
to nerd-snipe the objtool maintainers.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c   | 2 +-
 arch/x86/kernel/relocate_kernel_64.S | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 7abc7aa0261b..84f59f18dcb6 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -380,7 +380,7 @@ void machine_kexec_cleanup(struct kimage *image)
  * Do not allocate memory (or fail in any way) in machine_kexec().
  * We are past the point of no return, committed to rebooting now.
  */
-void __nocfi machine_kexec(struct kimage *image)
+void machine_kexec(struct kimage *image)
 {
 	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
 	relocate_kernel_fn *relocate_kernel_ptr;
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 228301ac66e9..dbcef3430285 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -5,6 +5,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <linux/stringify.h>
 #include <asm/alternative.h>
 #include <asm/page_types.h>
@@ -59,8 +60,9 @@ SYM_DATA_END(kexec_debug_idt)
 
 	.section .text..relocate_kernel,"ax";
 	.code64
-SYM_CODE_START_NOALIGN(relocate_kernel)
+SYM_TYPED_FUNC_START(relocate_kernel)
 	UNWIND_HINT_END_OF_STACK
+	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	/*
 	 * %rdi indirection_page
-- 
2.48.1


