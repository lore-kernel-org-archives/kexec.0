Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95385C88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o2lQ5Ka+5N2KnUU5FmxbFpjzBp5OWSe8vXNiFGVP9wo=; b=UfYCtjuCm8ZzAmzhv9zaFRrLe7
	MfQh69SEromX2M3AE33LqDUdGNp19xTSDb4e4qDImZCazwOvs2rDjxk57C3xJW/W5YiltJQwpGON9
	M7quClgyq/m7ZoFtInnYE5PF2lL2bzhBXS1t4HXub30w5rBwelsI2YKDQEDzXRQ1arXJKVRptwkZ7
	AmzDjw7VcEVbSkd4zHPLBZr00UQCiBvqeJSnsXtcNyyvgCOzHnBncQBdMAzwLj9OV3Uv6EDyP+YMK
	XCTS4Fgqw/QnORlGJYoDxakxBhkwVa1S8FX44VwgVLsNCrpm9hyCUSL9qjTdOA6HfA8QFR0tm+VTx
	JXjuCu4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RTG-00000006Dgs-22cP;
	Tue, 15 Sep 2026 11:37:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RSI-00000006Cbb-3ErB;
	Tue, 15 Sep 2026 11:36:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 807664078B;
	Tue, 15 Sep 2026 11:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA1E1F00898;
	Tue, 15 Sep 2026 11:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472166;
	bh=o2lQ5Ka+5N2KnUU5FmxbFpjzBp5OWSe8vXNiFGVP9wo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OMJ+b7mBI0Q8O65xdljhCPY3wAhJtYK6vRviUYwoOTOfvpAhVhrNZ1kCsXQAqmv7v
	 3GuPhfOQ15Waw0FL/v7cPGU1CKFB0vIzNSBGpVjd2qBgP1hQ3swVBB0qsd708/I1v5
	 vg/o9z55oXEAHcBz+9R03GejIoqfhheuysEBDKH6SjqNuu/M7QucGgMkPeQdb5GX9n
	 uQNmyO/vVkhVONQwgr/tUv50HwF7x4nXtsyG+xs9H48A8Y+g/iDSD50VrmcEX/KGAo
	 6x7qUbImLs8LGWOMAtx7W/94RYq1+vZrklFF1JGznEjJF5X02jojdwcWqWCWnxH6Bc
	 DQcVPuaGmWDvQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:23 +0200
Subject: [PATCH RFC POC 37/50] tpm: vtpm_proxy: install the server
 descriptor when the ioctl returns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-37-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2398; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WL6iBvGKSQMcLT8fyxBve2m38vKajd88XKUitLJDfoo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KkLDfGbfS6nzTDW3+CR3ZeWem2mM3pd9c9eC2/x8
 KvW8xPoKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMhPNYb/Ude3PmqXNzFcrfTk
 c5TA/YXTT8zPT3uZ3v9yqU5S93XBRYwM/34c1tN5sX7LjoD5b9gnnuLVilnzKtv7cqb0mf/eLA+
 5+AA=
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
 drivers/char/tpm/tpm_vtpm_proxy.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index b81fd2a537df..8eb87044596a 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -531,8 +531,8 @@ static struct file *vtpm_proxy_create_device(
 				 struct vtpm_proxy_new_dev *vtpm_new_dev)
 {
 	struct proxy_dev *proxy_dev;
-	int rc, fd;
 	struct file *file;
+	int rc;
 
 	if (vtpm_new_dev->flags & ~VTPM_PROXY_FLAGS_ALL)
 		return ERR_PTR(-EOPNOTSUPP);
@@ -544,20 +544,15 @@ static struct file *vtpm_proxy_create_device(
 	proxy_dev->flags = vtpm_new_dev->flags;
 
 	/* setup an anonymous file for the server-side */
-	fd = get_unused_fd_flags(O_RDWR);
-	if (fd < 0) {
-		rc = fd;
+	FD_PREPARE(fdf, O_RDWR,
+		   anon_inode_getfile("[vtpms]", &vtpm_proxy_fops, proxy_dev,
+				      O_RDWR));
+	if (IS_ERR(fdf)) {
+		rc = PTR_ERR(fdf);
 		goto err_delete_proxy_dev;
 	}
+	file = fd_prepare_file(fdf);
 
-	file = anon_inode_getfile("[vtpms]", &vtpm_proxy_fops, proxy_dev,
-				  O_RDWR);
-	if (IS_ERR(file)) {
-		rc = PTR_ERR(file);
-		goto err_put_unused_fd;
-	}
-
-	/* from now on we can unwind with put_unused_fd() + fput() */
 	/* simulate an open() on the server side */
 	vtpm_proxy_fops_open(file);
 
@@ -566,16 +561,13 @@ static struct file *vtpm_proxy_create_device(
 
 	vtpm_proxy_work_start(proxy_dev);
 
-	vtpm_new_dev->fd = fd;
+	vtpm_new_dev->fd = fd_prepare_fd(fdf);
 	vtpm_new_dev->major = MAJOR(proxy_dev->chip->dev.devt);
 	vtpm_new_dev->minor = MINOR(proxy_dev->chip->dev.devt);
 	vtpm_new_dev->tpm_num = proxy_dev->chip->dev_num;
 
 	return file;
 
-err_put_unused_fd:
-	put_unused_fd(fd);
-
 err_delete_proxy_dev:
 	vtpm_proxy_delete_proxy_dev(proxy_dev);
 
@@ -640,13 +632,9 @@ static long vtpmx_ioc_new_dev(struct file *file, unsigned int ioctl,
 		return PTR_ERR(vtpm_file);
 
 	if (copy_to_user(vtpm_new_dev_p, &vtpm_new_dev,
-			 sizeof(vtpm_new_dev))) {
-		put_unused_fd(vtpm_new_dev.fd);
-		fput(vtpm_file);
+			 sizeof(vtpm_new_dev)))
 		return -EFAULT;
-	}
 
-	fd_install(vtpm_new_dev.fd, vtpm_file);
 	return 0;
 }
 

-- 
2.53.0


