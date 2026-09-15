Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA10AC982C9
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mjqLYqkFC5yCbrRzMMvOpmvK8b+wb1Az5sELRN6Iqmw=; b=4gIMMI2aLhqUTdDyGgjUrpHIjM
	DCx0HzEtyQvGgBRid0ADAMshZkpohxjkEsYAFM1yl6t0IMXJlSSUYAbrbvM1jd/jUaRua5zN7smjv
	+ZL5ODznYgL8Txpact2xkQT780Od16Z41GlP9NeO/wr4UaIY8zuAliH8k2GFJX0lONVy1nulwfDtQ
	oE95kxg3je2balFs5vH7dbGM1btHxq5YyogTSQMpsyPkjzW/YtJtoGG04SGWpELI9aiw62QQP31Vi
	LoEpkU+iCaCMYhJ5A5TmRGPFSxd2V+gweiAdmT50lLdrrMArZbpP8ZczF18cWT501kzMDuK0gTzfO
	D7Pk0QKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RTl-00000006Eml-0W34;
	Tue, 15 Sep 2026 11:37:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RTa-00000006ERV-2m7I;
	Tue, 15 Sep 2026 11:37:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B699B602C5;
	Tue, 15 Sep 2026 11:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE621F00893;
	Tue, 15 Sep 2026 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472245;
	bh=mjqLYqkFC5yCbrRzMMvOpmvK8b+wb1Az5sELRN6Iqmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fNFTQOJL+iGGO+zzzm7cDe+/taoDcFY7fewDCdDuBMLNk844/5YTOXExel7EKsF9S
	 oLRnzjguOrHBG/PK7ZC549dR4lB6cSOioaIssgENRRB/BPi7+UG74t/yS8GmkCNH9C
	 SYkWW/2u8YiYHbyNYlVSLFpnBvaUvCIp4Mwu/abM5lLuo8GHPpD/0L9dCr6/bh0kxz
	 Ano4WmSOQb609KJxhLhb4QylzFqFY4npF26OT03shrB8BqGetnHALS1L68dHSQxDHf
	 lkgeVcI6ujFF+0WS99WYyuepbVTQzAmtrQq19Z8PUhZtIGApiugszVbmJFY6aacriE
	 TeUsi9M9eNUTQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:33 +0200
Subject: [PATCH RFC POC 47/50] iio: buffer: install the buffer descriptor
 when the ioctl returns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-47-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RM8/Ryi0JBjisB2tI5DXR2rE8sCF/AliS5Zp4F8Qhf4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KkPFJZ6IZfMtyJ0UsaFFiuPoGWsPxtn3v1o+e3z3
 stfX0943lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR6LMM/yNudM+8naelq7Sn
 g+X00Zpv+usvL13mfINZZtGLrdYV3KkMfzjPLfxTceTH7fV1ATe3FQTfd1Vd7vTqOWPz3spdkTu
 WLmIFAA==
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
 drivers/iio/industrialio-buffer.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 2c9ec93dff47..9fb15bf82d0a 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2041,7 +2041,7 @@ static long iio_device_buffer_getfd(struct iio_dev *indio_dev, unsigned long arg
 	int __user *ival = (int __user *)arg;
 	struct iio_dev_buffer_pair *ib;
 	struct iio_buffer *buffer;
-	int fd, idx, ret;
+	int idx, ret, fdno;
 
 	if (copy_from_user(&idx, ival, sizeof(idx)))
 		return -EFAULT;
@@ -2067,26 +2067,18 @@ static long iio_device_buffer_getfd(struct iio_dev *indio_dev, unsigned long arg
 	ib->indio_dev = indio_dev;
 	ib->buffer = buffer;
 
-	fd = anon_inode_getfd("iio:buffer", &iio_buffer_chrdev_fileops,
-			      ib, O_RDWR | O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
+	FD_PREPARE(fdf, O_RDWR | O_CLOEXEC,
+		   anon_inode_getfile("iio:buffer", &iio_buffer_chrdev_fileops,
+				      ib, O_RDWR | O_CLOEXEC));
+	if (IS_ERR(fdf)) {
+		ret = PTR_ERR(fdf);
 		goto error_free_ib;
 	}
 
-	if (copy_to_user(ival, &fd, sizeof(fd))) {
-		/*
-		 * "Leak" the fd, as there's not much we can do about this
-		 * anyway. 'fd' might have been closed already, as
-		 * anon_inode_getfd() called fd_install() on it, which made
-		 * it reachable by userland.
-		 *
-		 * Instead of allowing a malicious user to play tricks with
-		 * us, rely on the process exit path to do any necessary
-		 * cleanup, as in releasing the file, if still needed.
-		 */
+	fdno = fd_prepare_fd(fdf);
+	/* The staged file is dropped with its descriptor if this faults. */
+	if (copy_to_user(ival, &fdno, sizeof(fdno)))
 		return -EFAULT;
-	}
 
 	return 0;
 

-- 
2.53.0


