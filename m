Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ED9C88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BqXm1gwNkPuV8t/s5aBHvxXoZQi1gmoyMrWOmcTh+e0=; b=vsHZShiO6FVyXNBA8h6vfMdm3p
	lEBnygdjgwJa0cpSoKuSJBr9Q8mPxS2F1UhhrEsK8wkcbffeBy1YryLIbOHsQsPjoXND2EpOsaUOG
	Qy5l29ymFqWgg1LGbhIr5O185esvOUdaBUn8WsUUMFrY0hcFlfkHVzsnRBifA8IaH8JM5bipvnzUi
	kBDL5JVO92xaOVNImiRwhVrCeHcALSEhCFbpmnEbg0OJOimFiCzDjWO0+pSj4Zl+jy6t3BEwkPvZz
	7uufGVHD+67yH/QbonAU5FGFashqYAMTo9/n41ygjBvs0fJn73gWB3ruv6NZAcCr7d+5BHzQgBJp2
	bd9xxF9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RTi-00000006EfG-04Z3;
	Tue, 15 Sep 2026 11:37:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RTS-00000006E7I-0cmP;
	Tue, 15 Sep 2026 11:37:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id ABFD44184D;
	Tue, 15 Sep 2026 11:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A48B1F0089B;
	Tue, 15 Sep 2026 11:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472237;
	bh=BqXm1gwNkPuV8t/s5aBHvxXoZQi1gmoyMrWOmcTh+e0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=a6dDn4u7UHWeS4oTPwJxZY/4MEQxfhe+w1dKAeLobwNA3kw8GA3R9jRM2UR2mitay
	 53rP31LX9IqiX4KyqJPeG5/A7Wk+vS/URJ+UIVi9s1V2CPS0HR+hZ4KD6LOwLi84oS
	 QHwPtObpcQ5V14Eq0QEfaz7SuQthG9rIDnYNoZNXfjPTl3loRHMdpOz24R20W3G90W
	 UlZUihfBsJUGHcwdaoYH/9Wk5PPbgvkC3G4N/+PjxTb+vMzH1dM6mnf2s5E522jH4C
	 ipwBTphCPJfK0gAPAR1mBJJ0lQjIBDvfQG7LHcMtNeNhxBkuWpXGTndvfVHeezP+yl
	 SKtsU9/kk2SGQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:32 +0200
Subject: [PATCH RFC POC 46/50] xen/gntdev-dmabuf: stop putting the
 descriptor back on failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-46-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1632; i=brauner@kernel.org;
 h=from:subject:message-id; bh=njDuxDGw0hmgU8wKPypyXyk5GfJpiYpSpC9eP8wkYpU=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGqpLH/I6D6Uv1WDf9ilssavQSoU/hfbYczV5DbAAkrVEcQbC
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmqpLH8ACgkQkcYbwGV43KLDpAD/YSHF
 Q2prY93oobCwIjSF/SfO7Zal68tdHzxKNHmWJJEA/R/JD6+ZeSXqBuxwWtOWojlugYUiab/9tAe
 INmLXFesK
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
 drivers/xen/gntdev-dmabuf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 83b0df460894..a3ecc7c83974 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -357,10 +357,10 @@ static int dmabuf_exp_from_pages(struct gntdev_dmabuf_export_args *args)
 {
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct gntdev_dmabuf *gntdev_dmabuf __free(kfree) = NULL;
-	CLASS(get_unused_fd, ret)(O_CLOEXEC);
+	const struct fd_slot *fd = fd_prepare(O_CLOEXEC);
 
-	if (ret < 0)
-		return ret;
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
 	gntdev_dmabuf = kzalloc_obj(*gntdev_dmabuf);
 	if (!gntdev_dmabuf)
@@ -388,17 +388,17 @@ static int dmabuf_exp_from_pages(struct gntdev_dmabuf_export_args *args)
 	if (IS_ERR(gntdev_dmabuf->dmabuf))
 		return PTR_ERR(gntdev_dmabuf->dmabuf);
 
-	gntdev_dmabuf->fd = ret;
-	args->fd = ret;
+	gntdev_dmabuf->fd = fd_prepare_fd(fd);
+	args->fd = fd_prepare_fd(fd);
 
-	pr_debug("Exporting DMA buffer with fd %d\n", ret);
+	pr_debug("Exporting DMA buffer with fd %d\n", fd_prepare_fd(fd));
 
 	get_file(gntdev_dmabuf->priv->filp);
 	mutex_lock(&args->dmabuf_priv->lock);
 	list_add(&gntdev_dmabuf->next, &args->dmabuf_priv->exp_list);
 	mutex_unlock(&args->dmabuf_priv->lock);
 
-	fd_install(take_fd(ret), no_free_ptr(gntdev_dmabuf)->dmabuf->file);
+	fd_stage(fd, no_free_ptr(gntdev_dmabuf)->dmabuf->file);
 	return 0;
 }
 

-- 
2.53.0


