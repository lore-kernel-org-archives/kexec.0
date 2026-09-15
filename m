Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B73C88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Opabrir2qKnajEOx/bmqQ0vFOOuJF5mcXpUx8QfYgRo=; b=kGtSvd0LQkEMshptvYhS179inf
	9HWbi423SNk9eiebEfIcqRHqLvsCacOo1ajQR9PPLWqMub19quofPZ8EYU+sHMhAi0pp8flC1pE87
	nhJwHSX9XxmF0xJ2SBIGGthkxu3DtDC3y9H7yfQHlOeak9DQxgBIPtE9hq0fSOxpIqV1LtoZTM85O
	bDizFHi9FSgJHSolIn+3zq8z/Jl1ASFaTFSA8+hulB2BmY1Kw7Ju/QgGSzBM3oqrBWhfBGEbwxn1a
	b/6XVi+yPBYrONtxEkQilm4hC8LBXlYSMYDoLYQP0ZEP8anGGi7xZGKtMH9JuX44ps9LOsjao/ars
	d1izJUFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RQ3-000000069mT-1P2K;
	Tue, 15 Sep 2026 11:33:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RPv-000000069Z8-2wLF;
	Tue, 15 Sep 2026 11:33:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0A7A3602CA;
	Tue, 15 Sep 2026 11:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A06C1F000FF;
	Tue, 15 Sep 2026 11:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472018;
	bh=Opabrir2qKnajEOx/bmqQ0vFOOuJF5mcXpUx8QfYgRo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m6JS+1osV+HHQ3+stbRMi1nG57ukYiJTEcH35bNEsuFkz3EDpaPqRCxptR5myI3CQ
	 DrVL3ticaSsEmHs4hzrQOkVHuI+pRvmExpm7hSTVT1Fy4ahKbV0yxhDmvASrd6aMLO
	 kfyvZnG8hPY/OSMfxVk2m1KEfL0A4tlDKieBNoYaPaJt6kinrooutLXDgSWdlzJaI4
	 Qyu0CqnjMLHGESZU0vH6Xh9zHueNHEtLJB7dyoK2455umDXJ25s2IeNCaoYNiPSyj5
	 BtthgxR3vTZnXL/kG06SW2wMzb3uuLV+YqWCArv2R8bMdgvjWU+Ck1onWTajB/my7G
	 f4cwtNsAzJb3g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:04 +0200
Subject: [PATCH RFC POC 18/50] xtensa: commit fds on syscall exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-18-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2590; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ob3PjpQ/cxpLv/3i+RPAC4oxtU+7SyXGKknKtjIi6uA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Km1PCQWPOf+dN42p7eiixMDrC8oHl3XfDxb8HXeu
 Q8v17M86ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIlRQjwxxl+ehP3JqHnz5Z
 rnHMf3GFlcCby16MDPn/pqho/776ZA8jwwxuu0Z35YDFs7a2ZE2t16lXXVd42bXR6lPXzm5Ltrk
 6jAA=
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

Add TIF_FD_SLOTS and test it once the system call has stored its
return value. A task that reserved descriptors uses the traced path.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/xtensa/include/asm/thread_info.h | 2 ++
 arch/xtensa/kernel/entry.S            | 5 +++++
 arch/xtensa/kernel/ptrace.c           | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/arch/xtensa/include/asm/thread_info.h b/arch/xtensa/include/asm/thread_info.h
index 5b74dfc35ef9..0c8eb5dc8398 100644
--- a/arch/xtensa/include/asm/thread_info.h
+++ b/arch/xtensa/include/asm/thread_info.h
@@ -124,6 +124,7 @@ static __always_inline struct thread_info *current_thread_info(void)
 #define TIF_SYSCALL_AUDIT	9	/* syscall auditing active */
 #define TIF_SECCOMP		10	/* secure computing */
 #define TIF_MEMDIE		11	/* is terminating due to OOM killer */
+#define TIF_FD_SLOTS		12	/* syscall prepared descriptors */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
@@ -134,6 +135,7 @@ static __always_inline struct thread_info *current_thread_info(void)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
+#define _TIF_FD_SLOTS		(1<<TIF_FD_SLOTS)
 
 #define _TIF_WORK_MASK		(_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP | \
 				 _TIF_SYSCALL_TRACEPOINT | \
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 272fff587907..4b95f48736e6 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -1976,6 +1976,11 @@ ENTRY(system_call)
 1:	/* regs->areg[2] = return_value */
 
 	s32i	abi_rv, abi_saved0, PT_AREG2
+
+	/* descriptors reserved by the syscall are committed in do_syscall_trace_leave */
+	GET_THREAD_INFO(a4, a1)
+	l32i	a4, a4, TI_FLAGS
+	bbsi.l	a4, TIF_FD_SLOTS, 1f
 	bnez	abi_saved1, 1f
 .Lsyscall_exit:
 #if defined(__XTENSA_WINDOWED_ABI__)
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index 364e4fdabb00..d44d62a56b85 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/audit.h>
+#include <linux/file.h>
 #include <linux/errno.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/kernel.h>
@@ -571,6 +572,9 @@ void do_syscall_trace_leave(struct pt_regs *regs)
 {
 	int step;
 
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(regs);
+
 	audit_syscall_exit(regs);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))

-- 
2.53.0


