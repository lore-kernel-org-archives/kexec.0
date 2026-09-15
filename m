Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5094C982C7
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mbTaUTx0F+8Yd8wvmtUsGd49oHWKxWwv7CwFTyLjhec=; b=0m4r8v6WUMbHaC3U2pi6C3oMg7
	Bz6bB+v65ypjPrVPvXSgGRMFvPqOs7fNuXyGeph+NzxF94Nu/iXVsSWQucASwj59q8KwOeyn6f/7a
	ql6XRn/8gY/LY0jD+g43St2PbhpEr0+ABGIVQ5ra0O1np4RUDIjjEbdBdbwGsCxp8hJXIVz5dlwza
	x7U1K3ducw1WqINuobZEPK8ujayidsk988QwfBHBTUfToqPdi0jCgZy/oPPos949IMEe3evO0k9Th
	g+wu/iG10OOYYr5MKYr4ZYWHoaB8/4tGK9DlaCS5y26sMQEkgmFyujgt8ts90/Bv1+M+pKnf01u4R
	Fg+cHf9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RQE-00000006A3B-3Cw8;
	Tue, 15 Sep 2026 11:33:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RQA-000000069yf-3wRD;
	Tue, 15 Sep 2026 11:33:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 579D2600D1;
	Tue, 15 Sep 2026 11:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01081F000FF;
	Tue, 15 Sep 2026 11:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472034;
	bh=mbTaUTx0F+8Yd8wvmtUsGd49oHWKxWwv7CwFTyLjhec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KlpWXuFj0+jdehVdQRW9dTm9BsasJoCQHq4y714jucc2LKezn+Raj3o0ioX232wqM
	 jhHvMuhWUpiDNoQEY8ZOItiHHjXIh3EJ4lYCmA5rI9RGISwFKPW38moaoO3+dsZ0aK
	 HShijMbdV4vAKfbEdZN7JwWHJCH9KbWrPxcDpTVAS0WUv3FhYQrUmcvC9ARRSnSa7u
	 Ca768uVHlWEAIo6sTG8e8Q1xpvU8CLuiq6NSrBvgzzER0wYqMt62L865asuebsmyIW
	 I7PEM9/+fxn9Mvp/KBLnfVW338UGGCg59dyrovq5duqMA/k5+J43h20hfjg0v7DEBj
	 Nim9gww77JPsw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:06 +0200
Subject: [PATCH RFC POC 20/50] file: warn when the descriptor table is
 unshared with slots
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-20-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; i=brauner@kernel.org;
 h=from:subject:message-id; bh=G9FG2jHFipdUrRTGsnorEbb5m5RZUr4ZNfIJ8EYrZNY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Klt0PSve+Zwt2WPgtbjy2r2c+q+Ga6c6JRtXJz8V
 7d7s9uBjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkk9TEybK8Ujbgr9+l9SPar
 Xzk+r7k8K/PX8z83lr3l0RmsOXPvPIb/xe7Pwk1X1l5rbbs/0/NrxfS1XTYnq53m69hY7lW8vLu
 CBQA=
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

If the fdtable is unshared or the task exits we can't install
reservations. The reserved fd isn't reserved anymore. execve() would
leak the reservation into the child.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c     | 3 +++
 kernel/fork.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 745f6eb5279e..1aa0f7b99fc3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1159,6 +1159,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	io_uring_task_cancel();
 
+	/* A prepared descriptor would be installed into the new program. */
+	VFS_WARN_ON_ONCE(me->fd_slots.nr);
+
 	/* Ensure the files table is not shared. */
 	retval = unshare_files();
 	if (retval)
diff --git a/kernel/fork.c b/kernel/fork.c
index 59c5cfa3e482..bd0e1e85abb0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3217,6 +3217,8 @@ static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp
 
 	if ((unshare_flags & CLONE_FILES) &&
 	    (fd && atomic_read(&fd->count) > 1)) {
+		/* Prepared descriptors live in the table we are about to leave. */
+		VFS_WARN_ON_ONCE(current->fd_slots.nr);
 		fd = dup_fd(fd, NULL);
 		if (IS_ERR(fd))
 			return PTR_ERR(fd);

-- 
2.53.0


