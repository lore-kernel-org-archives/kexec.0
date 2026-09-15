Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C8CC88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o3Xn0Mlg9bYlNfr1tPx70kIWOKOkVzvKHpeJ1YxZNRQ=; b=NcBuz3XTpXDAiLtNYgE/AU8S7g
	U0qdqmpjbpceQ1jHQ20X2L1zl0DeyjOHN0m+5YNUwC3grFoz/erSAwi1B1uie8JtL+fcWw9kMEKEU
	erMFJ4QiZYAKuF+xXFkRXebXC9J85B4XJWYuIivCiFEz9N/HUIlIg3tWpnZlcftbYaoGaj1WvUe8O
	/zIRUdJMDfNSLgoq4xjDOuG+YfJUvyIxxMBivP8zxZdGZx3iJ2cH7f7TXWxdGTkrbzJngH9JZ4ToG
	XmusIgqEt6R5H/UPPP/JWrHoX2vysSLbHAUfGn1xSkM960TVQAmdhGJHjir+oCZ9dfGnQhUL8Czqm
	AfjntCHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RPU-0000000694U-0jKw;
	Tue, 15 Sep 2026 11:33:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RPB-000000068rs-3BHb;
	Tue, 15 Sep 2026 11:32:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 32F56600D1;
	Tue, 15 Sep 2026 11:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE001F00893;
	Tue, 15 Sep 2026 11:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471972;
	bh=o3Xn0Mlg9bYlNfr1tPx70kIWOKOkVzvKHpeJ1YxZNRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QMTfLeTYDVR+WQ8hqqaurH77Q8HR0/bGnyAWtgaX4cUnejbUKWLppk13HgBi3Ihb2
	 kPmiHpO3rRdjRdgFadsL7sJc/DJxI741nrJT3qwJoOB8nOvZFJR2SADGysKabk6JuM
	 +Y12LDqq0mzE7YbHwx9mql9DcjNt8nQ+Qa29un0t3I+ZOs7w3oYnaj7NIhtfD7oEQT
	 msU0tD696FtyT0wnuNKm/bu8l4L+UeODuBuHPDS4FE16FLJNZPa3orOY3/myRLQWiZ
	 tTW/UkhDAAaCJ74geD4ZPXSRk/hzP4l1fq1WFCmBvRegAKyGOdjJF20sUD1q1zgGGW
	 6g8/IXE0N6uQw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:30:58 +0200
Subject: [PATCH RFC POC 12/50] nios2: commit fds on syscall exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-12-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2707; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2xplL1NyM3O4K4L6DfydYO0Aia7T1qYz/CjAzhj5Eew=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KlVmMDBeUTxyxptzYxU+5fHZnpauZQ2vi++wMb75
 MCxSf+ndZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkuybDP6te7od7g1bqHMtY
 dzzj4ZTFk3lluoP6jtXu1/pwK+HTg9WMDD/8g02vzP+as0ShzGk9q8/0pPLva21Sv4v4uacI9y0
 z5QEA
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

Add TIF_FD_SLOTS and test it once the untraced system call has had
its return code translated into the r2 and r7 pair userspace sees.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/nios2/include/asm/thread_info.h | 2 ++
 arch/nios2/kernel/entry.S            | 5 +++++
 arch/nios2/kernel/ptrace.c           | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/arch/nios2/include/asm/thread_info.h b/arch/nios2/include/asm/thread_info.h
index 83df79286d62..7f5816e1b3d6 100644
--- a/arch/nios2/include/asm/thread_info.h
+++ b/arch/nios2/include/asm/thread_info.h
@@ -78,6 +78,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SECCOMP		5	/* secure computing */
 #define TIF_SYSCALL_AUDIT	6	/* syscall auditing active */
 #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
+#define TIF_FD_SLOTS		8	/* syscall prepared descriptors */
 #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
 
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling
@@ -90,6 +91,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
+#define _TIF_FD_SLOTS		(1 << TIF_FD_SLOTS)
 #define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 
diff --git a/arch/nios2/kernel/entry.S b/arch/nios2/kernel/entry.S
index dd40dfd908e5..b3a99a6db379 100644
--- a/arch/nios2/kernel/entry.S
+++ b/arch/nios2/kernel/entry.S
@@ -222,6 +222,11 @@ translate_rc_and_ret:
 	stw	r2, PT_R2(sp)
 	stw	r1, PT_R7(sp)
 end_translate_rc_and_ret:
+	/* Descriptors reserved by the syscall are committed in
+	 * do_syscall_trace_exit, take the traced exit path for them. */
+	GET_THREAD_INFO r11
+	ldw	r11, TI_FLAGS(r11)
+	BTBNZ	r11, r11, TIF_FD_SLOTS, end_translate_rc_and_ret2
 
 ret_from_exception:
 	ldw	r1, PT_ESTATUS(sp)
diff --git a/arch/nios2/kernel/ptrace.c b/arch/nios2/kernel/ptrace.c
index 2cd7e1ecbd74..5cee1b717662 100644
--- a/arch/nios2/kernel/ptrace.c
+++ b/arch/nios2/kernel/ptrace.c
@@ -9,6 +9,7 @@
 
 #include <linux/elf.h>
 #include <linux/errno.h>
+#include <linux/file.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/ptrace.h>
@@ -140,6 +141,8 @@ asmlinkage int do_syscall_trace_enter(void)
 
 asmlinkage void do_syscall_trace_exit(void)
 {
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(task_pt_regs(current));
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		ptrace_report_syscall_exit(task_pt_regs(current), 0);
 }

-- 
2.53.0


