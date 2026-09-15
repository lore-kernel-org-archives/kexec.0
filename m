Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791F4C88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bga1xdIPGJRsO6QHWVzlP+RWmBvnPkf9+o3GDcABEos=; b=zZ9iTWEBSG92R/vjx5G46iQPW9
	w5tBdLDlVxjRaGvPsGQ+WaEaPcinrpKjqcxEvaLRI32x+ZHbC8JYFkjBjE64j5AnQrNBDGg1ShXgF
	RzJswET2rBIeGVwfScZoWyep/SifwRbLLcOAtRw2qgERwuHufKnmXnKOAyUDe6lFRUD61oB5OOmZF
	R+zOFz1NZPoogUJ3E3bW/WWchic1Yme/NH3bKDD7dZuQvXrftnHu0fllctaoXTgKURjItwcBAAUHG
	SAfqyvGzxqj9vqiALjF6RYm0vky0WgQ3/O0SnuUBSksR4WgtQ+L4wIHr4lQva3kzbHgEQMyYgfaVM
	I7w7puxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RON-000000067oh-1uSH;
	Tue, 15 Sep 2026 11:32:03 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6ROJ-000000067k7-3vR0;
	Tue, 15 Sep 2026 11:32:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5F429602C2;
	Tue, 15 Sep 2026 11:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4E41F000FF;
	Tue, 15 Sep 2026 11:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471919;
	bh=bga1xdIPGJRsO6QHWVzlP+RWmBvnPkf9+o3GDcABEos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OOznBN+Uf6IkiE8I3kD7TX7An2UpW0UjMLCLWj0BehlzG79yWV8en/tlA/s8DbCrh
	 gWRF74c5iDgkaUKo3rLCkI06/mmx8PwQrzIzKtgKISnzxu+yTiJJLaPHivmCUb4yet
	 gsRSlrguCJTnrR6nfgasLlAJM/1CI/n29XMPtqVvwFxiyrAy2oSTUsfReKdzSibjFi
	 5eiTmh3x1iddDiLDSAh8Q8A5d5+aZVRA3lVTsp8ZS34IsIv2CrR/Nnb2p9GmOr9yTL
	 OCrvlFBZq7VekXjV8m8ckamzk+StbMN2Ma1rK0MuqF7AWmaoazDWObNjYBOIBY0W/z
	 h3FYCx98O7b3Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:30:51 +0200
Subject: [PATCH RFC POC 05/50] ARM: commit fds on syscall exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-5-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VK90OItgH7MXKBBbqC1mLihQj+HZYKN65ZEaMtX+9Ng=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KmZbrpIOHqtq7zi6WwlNR3r5y5nTvJML3y6vyFW/
 qkM8+m/HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5I8fwP+zW1CD2pQbsZaa6
 tgaTGX+ejU8rUZFb+L5V587bxX43/BkZ9r6dbPjsAn/5JEu7vPbfq3cc+M++af5MlaWxDNouzVe
 7mQA=
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

Add TIF_FD_SLOTS and test it where the syscall return path decides
between the syscall work and the plain work pending slow path. A task
that reserved descriptors goes through __sys_trace_return_nosave
where syscall_trace_exit() commits them before audit and the ptrace
exit stop. The traced path already ends up there.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/arm/include/asm/thread_info.h | 2 ++
 arch/arm/kernel/entry-common.S     | 2 ++
 arch/arm/kernel/ptrace.c           | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 943ffcf069d2..5337449e8409 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -144,6 +144,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
 #define TIF_UPROBE		3	/* breakpointed or singlestepping */
 #define TIF_NOTIFY_SIGNAL	4	/* signal notifications exist */
+#define TIF_FD_SLOTS		5	/* syscall prepared descriptors, entry-common.S needs it below 16 */
 
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
@@ -163,6 +164,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
+#define _TIF_FD_SLOTS		(1 << TIF_FD_SLOTS)
 #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
 
 /* Checks for any syscall work in entry-common.S */
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 88336a1292bb..59a70d90b0b6 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -83,6 +83,8 @@ ENDPROC(ret_fast_syscall)
 
 	tst	r1, #_TIF_SYSCALL_WORK
 	bne	__sys_trace_return_nosave
+	tst	r1, #(_TIF_FD_SLOTS << 16)	@ r1 holds TI_FLAGS << 16
+	bne	__sys_trace_return_nosave
 slow_work_pending:
 	mov	r0, sp				@ 'regs'
 	mov	r2, why				@ 'syscall'
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index ed7a2a87a670..75fe26012fcb 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -11,6 +11,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/mm.h>
 #include <linux/elf.h>
+#include <linux/file.h>
 #include <linux/smp.h>
 #include <linux/ptrace.h>
 #include <linux/user.h>
@@ -876,6 +877,9 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 
 asmlinkage void syscall_trace_exit(struct pt_regs *regs)
 {
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(regs);
+
 	/*
 	 * Audit the syscall before anything else, as a debugger may
 	 * come in and change the current registers.

-- 
2.53.0


