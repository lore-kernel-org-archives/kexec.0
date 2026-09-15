Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4C9C982C5
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=43PF/RCUOZQkJsOOgjTj3NZfqo5RZrpEBnO0+rNiFJE=; b=wJfUt20zCuP/1NbZ1EJKNfnyCB
	gUoTqS180PZ/0Mr4bD4Oy/XoiwBQ2OQIPjsYiNaSb1veeeqOEtL4PSztFspAMx5C6cqpMJO9e2+i4
	BarABVGBMZUGuWXFgfsAkJs9SV6hRCG4Mxbihst+zazOnFAi2Sg0UBHLcZ/bcYrD6FkswpNMV33zY
	bpjEun0/U2tYkvENnNmrmGcvjnd8/gZJFGzyGLuHIYSgVw/fJReByiF+ureavR2wzicocz/ehMTb0
	gDAmTUxjPXoJWI8w39nljUYPK2fyf5RQchD/bdLtPpXhMlXPIZPMq6w3Jp9D9pkm78dcVzxO1F2ZU
	FbMa/zdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RTs-00000006Eza-0LE5;
	Tue, 15 Sep 2026 11:37:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RTi-00000006EfJ-0c7W;
	Tue, 15 Sep 2026 11:37:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8DCDA43410;
	Tue, 15 Sep 2026 11:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022161F000FF;
	Tue, 15 Sep 2026 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472253;
	bh=43PF/RCUOZQkJsOOgjTj3NZfqo5RZrpEBnO0+rNiFJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KqnWgCCBBHbflkUyPO4GlX+NqrkQFoLbpdeV95+70PxGxWdRlCZK2hEFg7AKpGM8d
	 P+sDlo6n6p/oD4DHtw5k4ao1CCny987weMHVwVi57TIzGmedW26EG1RySUo7EUC3wL
	 govHdLEbUVf9mmDt8elYfT7Db4xTVjDVamv4EuP8wsrMfCbgWeOAVYswLv5gav0BOT
	 MlginGpeWoN48Ny0LTtfFlqXOFFO5u4nlES7nGcrAPFHjrQQttsk0uwSQM7UkTulFT
	 MHFUk3iByhyEoh4VP3/GmREzjD3XQ75V+DK8eWFkJXVQmcZAGfPHvBT+mosXjqMwpA
	 YKgxCV7My/uOw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:34 +0200
Subject: [PATCH RFC POC 48/50] misc: fastrpc: install the dma-buf
 descriptor when the ioctl returns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-48-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1831; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cqNOp0aS6I05gELpjlHXd0owI5nLbJqswEU8UWMTx0A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KkPYaw+MXnFd73DKesXPFlfMXNFNsPLRZf+RF2XY
 bp6P+0Kb0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBETGQYGSZ8vdT+NFe0bk0l
 +55pTDcfSvjMedPirtK/tvj3rIZKzuUM/8x33i1095DRM+a7Hu9qcGFp07anFQ2bOM4tOR05Zb0
 HOzMA
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

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/misc/fastrpc.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 90fd669636ec..24b84019bbd7 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -7,6 +7,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-resv.h>
+#include <linux/file.h>
 #include <linux/idr.h>
 #include <linux/list.h>
 #include <linux/miscdevice.h>
@@ -1804,6 +1805,7 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct fastrpc_buf *buf = NULL;
 	int err;
+	const struct fd_slot *fd;
 
 	if (copy_from_user(&bp, argp, sizeof(bp)))
 		return -EFAULT;
@@ -1822,23 +1824,16 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 		return err;
 	}
 
-	bp.fd = dma_buf_fd(buf->dmabuf, O_ACCMODE);
-	if (bp.fd < 0) {
+	fd = fd_prepare(O_ACCMODE);
+	if (IS_ERR(fd)) {
 		dma_buf_put(buf->dmabuf);
 		return -EINVAL;
 	}
+	bp.fd = fd_stage(fd, buf->dmabuf->file);
 
-	if (copy_to_user(argp, &bp, sizeof(bp))) {
-		/*
-		 * The usercopy failed, but we can't do much about it, as
-		 * dma_buf_fd() already called fd_install() and made the
-		 * file descriptor accessible for the current process. It
-		 * might already be closed and dmabuf no longer valid when
-		 * we reach this point. Therefore "leak" the fd and rely on
-		 * the process exit path to do any required cleanup.
-		 */
+	/* The staged file is dropped with its descriptor if this faults. */
+	if (copy_to_user(argp, &bp, sizeof(bp)))
 		return -EFAULT;
-	}
 
 	return 0;
 }

-- 
2.53.0


