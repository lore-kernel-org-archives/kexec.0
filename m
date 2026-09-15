Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6ECC88E53
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xKFkiCa0hlTe3sMnpSzoSnXToiZbVbh61g+KJO9ieuc=; b=Z8o9BCS+h9jQFz7Ti60U6P7H4+
	GouPNh6kCj0T96cl6SYhvMSCvgty5PAURubiCc22LX0s1YuND+Nu0Yd1Ba5EPgiHx+SeR0fvxvYH4
	jaqu+gjM1QbDOY+qi/H5Q2W+DlLRcMAJifGu+s9wWa/XccN6BtMrY6imZfkQVFfrIgu0bUOhtCu+4
	6p93mJxqncaN9B4KaRIZyuVkJezCewEodH0LliwCHkzSn0Ar8D51cxtaBBESssnqAqMynSRquBFpN
	yfwKfAM2xWPjc7CXOT+uHrGWQHPG3d9d4f5RA39Ior5Us0omSYO1YXc1qJphJqZ1q1lxRlmUGGkCd
	9JJnCO+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RTf-00000006Ean-3NKF;
	Tue, 15 Sep 2026 11:37:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RTK-00000006DpU-1hSd;
	Tue, 15 Sep 2026 11:37:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CD294602C4;
	Tue, 15 Sep 2026 11:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6561F000FF;
	Tue, 15 Sep 2026 11:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472229;
	bh=xKFkiCa0hlTe3sMnpSzoSnXToiZbVbh61g+KJO9ieuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oOCbPxoTA5tRVDE1SDW2p9tC0NlFv3Be5GpoNWhYmURnweQxEsEdX5T61GQni5xDr
	 dB8oKq6yW0o0+gkex/ln8ORrTi4m/ksGAeRyzNp36yZlNMlPyIA0cXetpfDQyX5Jlw
	 kUeKik4FTXQWhScuFLMluxrSG6c9A9ZCbrTYp9zYSiEAOHtRRYECmeCyootOfrgsFF
	 4aVzqXKYOQKlcIlDUd5HFPC99RpSLMKbQX+NeTk8Ib6ernTnIZhKKs5s66GAw9HT8a
	 aS1v8S5YrjxrTs7D5UvVddV+Ou7n/rKAkdnUoUpvZBcB6uDYitfeHcIW+Z9u4N80Fg
	 U5N4JdROMjYmQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:31 +0200
Subject: [PATCH RFC POC 45/50] accel/habanalabs: stop putting the dma-buf
 descriptor back on failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-45-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ydrjF0IvCagPMk+8W3Lo5F+Om/GvHyzFN7KTNwOeZ+c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kn/suYdZ5X5676SLT84zbaJW7EmM036Hiq6ZOOqB
 ZPZLiWKdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEfjfD/8KDx3tMQu5s8Nvq
 pTQrXEN8zcGDu7l3Sq29EHzMOo0/S5yR4VJD+//LnadWytZe1frxs+H8kb1LmHzvH1hrULDM+7H
 3NRYA
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
 drivers/accel/habanalabs/common/memory.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/habanalabs/common/memory.c b/drivers/accel/habanalabs/common/memory.c
index 361cff577381..1559442cd56f 100644
--- a/drivers/accel/habanalabs/common/memory.c
+++ b/drivers/accel/habanalabs/common/memory.c
@@ -1861,11 +1861,13 @@ static int export_dmabuf(struct hl_ctx *ctx,
 {
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct hl_device *hdev = ctx->hdev;
-	CLASS(get_unused_fd, fd)(flags);
+	const struct fd_slot *fd = fd_prepare(flags);
 
-	if (fd < 0) {
-		dev_err(hdev->dev, "failed to get a file descriptor for a dma-buf, %d\n", fd);
-		return fd;
+	if (IS_ERR(fd)) {
+		int rc = PTR_ERR(fd);
+
+		dev_err(hdev->dev, "failed to get a file descriptor for a dma-buf, %d\n", rc);
+		return rc;
 	}
 
 	exp_info.ops = &habanalabs_dmabuf_ops;
@@ -1889,8 +1891,7 @@ static int export_dmabuf(struct hl_ctx *ctx,
 	 */
 	get_file(ctx->hpriv->file_priv->filp);
 
-	*dmabuf_fd = fd;
-	fd_install(take_fd(fd), hl_dmabuf->dmabuf->file);
+	*dmabuf_fd = fd_stage(fd, hl_dmabuf->dmabuf->file);
 
 	return 0;
 }

-- 
2.53.0


