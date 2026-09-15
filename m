Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0214C982C7
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LsNpEFA01NMLmoDGH+WQ2k5w2caYKI3aFXCKnW6fq4M=; b=XxELFZMvhoWRxm/Y/BAXIJDlOJ
	/9kJGQ+oJlmprDKbq1x7KaKxeX/a/adhb+PlWBWZaThQVnUrMtljmZqKqBolBwATAMhIV+oXt21R/
	79sZREo6hvof/Tjov5w/nplB0cx5XoHwNULi1dPIKAsraH+L90bf7XU2WGbHFD3UaEidwIqT7OLt9
	pv9ogvcbpuaxLT1udtKa2ShqN+7YLfyP9DiLNiUIE+nxYXPXHhk9H3yqITTXeBDTm3g0G87zf5JFK
	xWKGmY8lPVA88bp4wB5OljOKJoCmeZIIefGroBNPa0DzswWnbiSeG1+Nr1NZBmY/v2CIE/Sny95gv
	iOm9mUXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RQ1-000000069fT-1647;
	Tue, 15 Sep 2026 11:33:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RPn-000000069OE-25QI;
	Tue, 15 Sep 2026 11:33:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 432C0437CE;
	Tue, 15 Sep 2026 11:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8D71F00898;
	Tue, 15 Sep 2026 11:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472011;
	bh=LsNpEFA01NMLmoDGH+WQ2k5w2caYKI3aFXCKnW6fq4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jUmSavNiamqp7sEiSGUpt1XZfKBJkPkcG/PFCGuuE8ULC/JC+9Uv/jivWwgpx6a/O
	 ndFuFYQRnEyeD6+NTxQCHA1WQfYk7Jmw39axkxPneZ0ZlWHflWnPtQntegHAjSQOHr
	 qvPuy2KIMTAU8QpGMIZajMcBNJZLx1KDydcGwu/7Fq4Sm2suht1GMp/5OShBghjByJ
	 Wo0vc/D/MORpmKTNOKDNlY4+TTriFUPTu4Y02yC+j0UyASaEIruvlKlSwBV+MXdIZL
	 vi9GUupn2o56nWtYus7diY/kBIvVMBlvyHSKLH2hV7NTFX1VBgWRv0lAAGJXCHoiGT
	 eaCHwlU6HAvXg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:03 +0200
Subject: [PATCH RFC POC 17/50] um: commit fds on syscall exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-17-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=brauner@kernel.org;
 h=from:subject:message-id; bh=S9sXo+/yQO9aORTIGU5zP9aw99mbVPSatnA1JIW5H/M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KldP/NzGWPyQ7vZ1w8Z91Y4Xry4dOW/w5ekHD1Nn
 i1f3lHo1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRnzMY/tdevWsc17Pol1js
 drW1Ndl3Uj4rJ6jNqM1Qvbkzdcr/kFkM//PT/U4ukVght9Iz6NLyeqmVG29b1dz/x+3x4GR56M6
 Uan4A
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

Add TIF_FD_SLOTS. handle_syscall() calls syscall_trace_leave() after
every system call, so test the flag there and commit the reservations
before audit and the ptrace exit stop.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/um/include/asm/thread_info.h | 2 ++
 arch/um/kernel/ptrace.c           | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index 7a6f4dc99fa1..7140516ee0b6 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -44,6 +44,7 @@ struct thread_info {
 #define TIF_SECCOMP		9	/* secure computing */
 #define TIF_SINGLESTEP		10	/* single stepping userspace */
 #define TIF_SYSCALL_TRACEPOINT	11	/* syscall tracepoint instrumentation */
+#define TIF_FD_SLOTS		12	/* syscall prepared descriptors */
 
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
@@ -55,6 +56,7 @@ struct thread_info {
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
+#define _TIF_FD_SLOTS		(1 << TIF_FD_SLOTS)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL | \
 				 _TIF_NOTIFY_RESUME)
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 7da0a5223aa6..f1f89181fb7e 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/audit.h>
+#include <linux/file.h>
 #include <linux/ptrace.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
@@ -142,6 +143,9 @@ void syscall_trace_leave(struct pt_regs *regs)
 {
 	int ptraced = current->ptrace;
 
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(regs);
+
 	audit_syscall_exit(regs);
 
 	/* Fake a debug trap */

-- 
2.53.0


