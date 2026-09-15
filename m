Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EE7C88E53
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tjgNPx3x7WII2tr/AwvmAnEJWXGOM0OeaxbIcUanKyI=; b=D0gEB/vhaHsDkn984B37IyOFUE
	k5QXmnrkD4cjGSaALFJoQQa00JFiKbEwBJYpA1vcgNG536LnG7Yu+MMmXCScBGmRXLmPF/eox/N/w
	vW347vgPwhIJDadO0RLqEE6vOeP19uMRgBeFqkTSx5gE7j5DL9c1wIB3/fFg1yMnURqDi8e6NUmOv
	CT81e1Gd/T0lJX1hVaqmyxwoQuH9+8EGvIjTeZy2XJe9BfTBNWSgiOTBs/lPQYUYd9wVEgjH6RgNL
	QJbapWHy0tDs/XJarNlpwI0jEWgUpMPSEvIbnIAJf+SSEBjMEJ2Vo9q/ljXV+adDC5RDEsG0zKnAI
	iGcVKpdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RTt-00000006F2x-1bCD;
	Tue, 15 Sep 2026 11:37:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RTp-00000006Evz-3IF9;
	Tue, 15 Sep 2026 11:37:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 860D2413D3;
	Tue, 15 Sep 2026 11:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B071F00893;
	Tue, 15 Sep 2026 11:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472261;
	bh=tjgNPx3x7WII2tr/AwvmAnEJWXGOM0OeaxbIcUanKyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SMo47o/JPxKGY6qTNLRWBziEbn+58IX3nPctPMC7Rjv/4Cm+o+BJijIJnYVe8zJNi
	 wtm2ogfTwLSXwVXiRa8BwU676bAhTFIUDdSLL7QWmD6wZs73V9DyEUOfRDrJ+IY403
	 kqv0bmOC18w9ruJeugOg/OVAFQjR9gpxqiygmBT/TwoeVymZyVDEbKq6Hd3l29gwkE
	 6gMLb1D7frbGbL+XuuTzjEeBT25eZX3KvVOEPtQdK5AuDh5R02exf0Wm9bz+fe67Iz
	 hw49+A+yqFYEMWzyNlTUmA/r+VKXbFFAqeFAkxdiB9zM9A5cJNU9ykZ66qrgX/f5g4
	 5B2mHT5wBqVHQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:35 +0200
Subject: [PATCH RFC POC 49/50] iommufd: stop putting descriptors back on
 failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-49-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3656; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Tx0MTQ1YnVtsCJithyQQ1YlkyHM6SB+QGz8po6KWPTc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kk3WbDjFvN29pT3Xq7896z8vX2FtjvvefB1xQfue
 XsWsk4o7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI3CuGf/rLHM5NDdh5MSei
 56otb6TCFq/HRZ/fcG4J0t5of2Rr5hxGhp4HVV1b2aIEtkx5uGOb3IS1967+fbb6v6rTAdk7ocz
 G3mwA
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
 drivers/iommu/iommufd/eventq.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 747dd5155121..f5fdc6cdf0a1 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -412,9 +412,9 @@ static int iommufd_eventq_fops_release(struct inode *inode, struct file *filep)
 		.release = iommufd_eventq_fops_release,                        \
 	})
 
-static int iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
-			       struct iommufd_ctx *ictx,
-			       const struct file_operations *fops)
+static const struct fd_slot *iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
+				struct iommufd_ctx *ictx,
+				const struct file_operations *fops)
 {
 	struct file *filep;
 
@@ -425,14 +425,14 @@ static int iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
 	/* The filep is fput() by the core code during failure */
 	filep = anon_inode_getfile(name, fops, eventq, O_RDWR);
 	if (IS_ERR(filep))
-		return PTR_ERR(filep);
+		return ERR_CAST(filep);
 
 	eventq->ictx = ictx;
 	iommufd_ctx_get(eventq->ictx);
 	eventq->filep = filep;
 	refcount_inc(&eventq->obj.users);
 
-	return get_unused_fd_flags(O_CLOEXEC);
+	return fd_prepare(O_CLOEXEC);
 }
 
 static const struct file_operations iommufd_fault_fops =
@@ -442,7 +442,7 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_fault_alloc *cmd = ucmd->cmd;
 	struct iommufd_fault *fault;
-	int fdno;
+	const struct fd_slot *fdno;
 	int rc;
 
 	if (cmd->flags)
@@ -458,22 +458,19 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 
 	fdno = iommufd_eventq_init(&fault->common, "[iommufd-pgfault]",
 				   ucmd->ictx, &iommufd_fault_fops);
-	if (fdno < 0)
-		return fdno;
+	if (IS_ERR(fdno))
+		return PTR_ERR(fdno);
 
 	cmd->out_fault_id = fault->common.obj.id;
-	cmd->out_fault_fd = fdno;
+	cmd->out_fault_fd = fd_prepare_fd(fdno);
 
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
-		goto out_put_fdno;
+		return rc;
 
-	fd_install(fdno, fault->common.filep);
+	fd_stage(fdno, fault->common.filep);
 
 	return 0;
-out_put_fdno:
-	put_unused_fd(fdno);
-	return rc;
 }
 
 int iommufd_fault_iopf_handler(struct iopf_group *group)
@@ -506,7 +503,7 @@ int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 	struct iommu_veventq_alloc *cmd = ucmd->cmd;
 	struct iommufd_veventq *veventq;
 	struct iommufd_viommu *viommu;
-	int fdno;
+	const struct fd_slot *fdno;
 	int rc;
 
 	if (cmd->flags || cmd->__reserved ||
@@ -543,24 +540,22 @@ int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 
 	fdno = iommufd_eventq_init(&veventq->common, "[iommufd-viommu-event]",
 				   ucmd->ictx, &iommufd_veventq_fops);
-	if (fdno < 0) {
-		rc = fdno;
+	if (IS_ERR(fdno)) {
+		rc = PTR_ERR(fdno);
 		goto out_abort;
 	}
 
 	cmd->out_veventq_id = veventq->common.obj.id;
-	cmd->out_veventq_fd = fdno;
+	cmd->out_veventq_fd = fd_prepare_fd(fdno);
 
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
-		goto out_put_fdno;
+		goto out_abort;
 
 	iommufd_object_finalize(ucmd->ictx, &veventq->common.obj);
-	fd_install(fdno, veventq->common.filep);
+	fd_stage(fdno, veventq->common.filep);
 	goto out_unlock_veventqs;
 
-out_put_fdno:
-	put_unused_fd(fdno);
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &veventq->common.obj);
 out_unlock_veventqs:

-- 
2.53.0


