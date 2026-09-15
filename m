Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E482C982C3
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6C1meFw3vaAeYs/vq+sJtwpKCB4NBzs9iQTrTMdIhys=; b=OWPvkogsI9p1lK//KM6zbLXUFD
	a6xKL83Dvi0k32ck/HGKbq5wOnVcGy/SajY9vPnlHNUv4h2wGhPT9l1IRwoNblvwDUAj7F8KWNgh7
	FUhc0FIUCAwB4ForYcsmh6fglAI2bXiq2HR4JpiYZeQ3Pvso62pRrAuzrQQqPL8rdkAnwOdSqyKDp
	YwiaBpUC9rJSXvmhqae1g3haVidKuYeAtzmszd7J7zXbGlo12kCts6EmR/qEQslP/rxUtosym79+L
	82XEUgJVlHcRFKorM7/ZtNGn6Tdyk4W4tgFWCn0x6XHIwABc3Ouu1U3ePeIOFsvaqJrGjUAypqVyk
	IZNszidg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RPk-000000069Kl-47mf;
	Tue, 15 Sep 2026 11:33:28 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RPQ-0000000692O-2vxs;
	Tue, 15 Sep 2026 11:33:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7255D43DFD;
	Tue, 15 Sep 2026 11:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365EA1F00893;
	Tue, 15 Sep 2026 11:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471988;
	bh=6C1meFw3vaAeYs/vq+sJtwpKCB4NBzs9iQTrTMdIhys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FIre7IPObUwSzXf3O2sx48t2Z4H5e1F4uGdxGhRX7VJFjXC2A06It6HiWigcBBMAA
	 8Vra7vVQTvHialB8SqOPb2eU66kL4TJRssBUy55uhNbh7Fx5LNe7AZKu6GLyBUfsD6
	 gvQWFBQP1xhLlrZ1husySN/1kg49H9IBp7PQSW5R20QShWAwc1I1rkhE5a8gn/MPIL
	 K1rfYqLjcpreBV4aXozkph6wt+CPhATz8dRKVe/qhoxpxLlAiPlvfFlTEM17EJsySw
	 IAUl5j4U2w/1V7oWGu6C8lLy1GXU5KsBKij6oQvNp9K/WGJ/hy1wm8Um42Z4sZZvVR
	 5URNgqeCv80NA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:00 +0200
Subject: [PATCH RFC POC 14/50] parisc: commit fds on syscall exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-14-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3161; i=brauner@kernel.org;
 h=from:subject:message-id; bh=u9Db1ViJfwYuzioCFI+Ic9SCMW7ME/y8i4wAOxFSJrA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kl9v0DgirDZt09b9j68fGdbuw7L0fhlLFrRRy8y8
 rKpH2YS7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIzTeGvxJCRtXLj2eFi4bc
 rj56m0FOYPZfpoLaW1crUibKsk2wd2Zk+BO9OoZ7Whbr1/StJ2JZ1nLsCE4I1fn9/7LOIUMGzZM
 FfAA=
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

Add TIF_FD_SLOTS and test it in syscall_exit once the return value
has been saved to pt_regs. A task that reserved descriptors calls
do_syscall_trace_exit() and then continues with the usual reschedule and
signal checks. The traced path already ends up there.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/parisc/include/asm/thread_info.h |  2 ++
 arch/parisc/kernel/entry.S            | 12 ++++++++++++
 arch/parisc/kernel/ptrace.c           |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/arch/parisc/include/asm/thread_info.h b/arch/parisc/include/asm/thread_info.h
index b283738bb6da..14a40c53689f 100644
--- a/arch/parisc/include/asm/thread_info.h
+++ b/arch/parisc/include/asm/thread_info.h
@@ -52,6 +52,7 @@ struct thread_info {
 #define TIF_SECCOMP		11	/* secure computing */
 #define TIF_SYSCALL_TRACEPOINT	12	/* syscall tracepoint instrumentation */
 #define TIF_NONBLOCK_WARNING	13	/* warned about wrong O_NONBLOCK usage */
+#define TIF_FD_SLOTS		14	/* syscall prepared descriptors */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -65,6 +66,7 @@ struct thread_info {
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
+#define _TIF_FD_SLOTS		(1 << TIF_FD_SLOTS)
 
 #define _TIF_USER_WORK_MASK     (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | \
                                  _TIF_NEED_RESCHED | _TIF_NOTIFY_SIGNAL)
diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index e04c5d806c10..c5807cf6fbd8 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -1732,6 +1732,8 @@ syscall_check_resched:
 	/* check for reschedule */
 	mfctl	%cr30,%r19
 	LDREG	TASK_TI_FLAGS(%r19),%r19	/* long */
+	/* descriptors reserved by the syscall are committed in do_syscall_trace_exit */
+	bb,<,n	%r19, 31-TIF_FD_SLOTS, syscall_do_fd_slots /* forward */
 	bb,<,n	%r19, 31-TIF_NEED_RESCHED, syscall_do_resched /* forward */
 
 	.import do_signal,code
@@ -1765,6 +1767,16 @@ syscall_do_signal:
 
 	b,n     syscall_check_sig
 
+syscall_do_fd_slots:
+	mfctl	%cr30,%r1
+#ifdef CONFIG_64BIT
+	ldo	-16(%r30),%r29			/* Reference param save area */
+#endif
+	ldo	TASK_REGS(%r1),%r26		/* struct pt_regs *regs */
+	BL	do_syscall_trace_exit,%r2
+	nop
+	b,n	syscall_check_resched
+
 syscall_restore:
 	mfctl	%cr30,%r1
 
diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index 1d9e210702e1..f142766792af 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/file.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
@@ -381,6 +382,9 @@ void do_syscall_trace_exit(struct pt_regs *regs)
 	int stepping = test_thread_flag(TIF_SINGLESTEP) ||
 		test_thread_flag(TIF_BLOCKSTEP);
 
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(regs);
+
 	audit_syscall_exit(regs);
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS

-- 
2.53.0


