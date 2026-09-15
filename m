Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88896C88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IxmCoZxNvEY3MY1bZ7ewHUS2NdsWvLK1wdW+Bpu3XII=; b=pojQvd8b5w9BisiMihatKCAdQc
	sjhr8E2wDd/34+4B0spKLdGnJ/triNF7fYFBtrU58x8s+Rclr41BASWX38ylNnga3H9PPRGXY3uXz
	0npNGxfUtNBhk/ZOTAYfmLLz/XG3WdzEZR2SCH9WCBNcGIq0mtMOzP57/+dpuANmUeumD+xsI3PIp
	De9jv57Sr2u42idOPS1hUL0AZmUfBkeifCNqGCuu/HkSdu3VOpVZLBOwkNcdUA+WXjU4laZENHmp3
	kqywjoAFd8HLfBJUizV916Yvz9d6xCBOQ2407Sw9lOwKncdqPj/wGuoYYoNc7+KIcX9ewRwQl1qTY
	Aj3PLGiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6ROT-000000067vn-1ZBp;
	Tue, 15 Sep 2026 11:32:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6ROR-000000067t7-08Ks;
	Tue, 15 Sep 2026 11:32:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BCE854197B;
	Tue, 15 Sep 2026 11:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887861F00893;
	Tue, 15 Sep 2026 11:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471926;
	bh=IxmCoZxNvEY3MY1bZ7ewHUS2NdsWvLK1wdW+Bpu3XII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=C4zmLfJvLb8/XMAlQ0q3DR72O6RIbbpSlqr7mpxZZCXJCOZxs052NdpfsCeWB6jTO
	 sp7ZSYu4dpiFz7qZobKbv0Abd6MgSlwyvtgrq+Q5gxYnbTDPGivrBv40jjmQzLGjRT
	 vrpW8H100OjuekLO+QbwSm4M7Pzv6OLBPqNmMdQXQ9Pvk4HwKHgkGGqx1zr9MQdDkX
	 DH4Qvm5HZpUEMbwwqO5pgKn+CIl2pzB83ZS8OPqmZIf0xHJv0M68Lea7oxkcu2dWSZ
	 yYvMHPI29Nvht7tAvKnNjpHySotS6aewXYvlGWWYpncPxSi676hzekHoKm/yXfnU59
	 FZU3zcroOoqIA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:30:52 +0200
Subject: [PATCH RFC POC 06/50] arm64: commit fds on syscall exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-6-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2286; i=brauner@kernel.org;
 h=from:subject:message-id; bh=k8f7wEWfxKpIfpqM0ZZciT9rU/+Z+B0mDMLnzjQbKbc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KnZs3W+lNrE9bX1j9JX3V1/xZvtQk5p++zvYh+2m
 2y+/NbBoKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi8csYGbbp9Kz+NflwSea1
 kB+Gs1Oy2DcWpDxrSJl+sK8+M9b2eyTDb3Z/1XKDldKc0bdKrTceZZ30eNPnnY6Zhw+Lb5A7wqf
 zgAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

Add TIF_FD_SLOTS to the syscall work bits. el0_svc_common() rereads
the flags after the system call and takes the trace exit for any of
them. So a task that reserved descriptors ends up in
syscall_trace_exit() which commits them before audit and the ptrace exit
stop.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/arm64/include/asm/thread_info.h | 4 +++-
 arch/arm64/kernel/ptrace.c           | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 5d7fe3e153c8..e48006eb98a8 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -74,6 +74,7 @@ void arch_setup_new_exec(void);
 #define TIF_SECCOMP		11	/* syscall secure computing */
 #define TIF_SYSCALL_EMU		12	/* syscall emulation active */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
+#define TIF_FD_SLOTS		14	/* syscall prepared descriptors */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
@@ -107,10 +108,11 @@ void arch_setup_new_exec(void);
 #define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)
+#define _TIF_FD_SLOTS		(1 << TIF_FD_SLOTS)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
-				 _TIF_SYSCALL_EMU)
+				 _TIF_SYSCALL_EMU | _TIF_FD_SLOTS)
 
 #ifdef CONFIG_SHADOW_CALL_STACK
 #define INIT_SCS							\
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index f743cbec1c3a..3bedfed977d4 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -28,6 +28,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/regset.h>
 #include <linux/elf.h>
+#include <linux/file.h>
 #include <linux/rseq.h>
 
 #include <asm/compat.h>
@@ -2486,6 +2487,9 @@ void syscall_trace_exit(struct pt_regs *regs)
 {
 	unsigned long flags = read_thread_flags();
 
+	if (flags & _TIF_FD_SLOTS)
+		fd_slots_commit(regs);
+
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)

-- 
2.53.0


