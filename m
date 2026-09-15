Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFDBC982C3
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vu/oKxz+arn92APs3M7qiv06zwHfUu2cH5sFUjT3DBs=; b=XgA/RuUsBEuvPAaUCVtErEOF/L
	ib8WPVKKKAvJmYdhclZTZUa/d7smr2uRvVrIXpAf1/16HCioTAWPUIf/iM9u4Q+3opMSUIVOrRSWu
	4MbgZxuhIQuhLjyPmP2acXAzmCsKUKRi976AM1qi57UGQPhpJIu+2Ih45lFEbYuAvAG9usyL1iCnn
	NzBTAnmwu8lFvUxwXDXribVep82X3DfZIv/OuzNDQw/367/DE9C8paD4Ob/A7/vxmf9ZyxXMgqVL2
	Y0ZD5a7M+J4kE/ducKMrwPPgP8ANXlJdsa6YMNyB47MbY4+yfpcUovyX63amqoi5BOW9EAvJrWwjN
	9Psb5JTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RSV-00000006ClB-3lQQ;
	Tue, 15 Sep 2026 11:36:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RRX-00000006BuW-1ohn;
	Tue, 15 Sep 2026 11:35:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2F5DC415D0;
	Tue, 15 Sep 2026 11:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A641F0089B;
	Tue, 15 Sep 2026 11:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472119;
	bh=vu/oKxz+arn92APs3M7qiv06zwHfUu2cH5sFUjT3DBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HrkMpIvO7iGYskIOyxgrnhbmY51Jc8Ub7q4Why0AOMW3f+ydbKbSBCxy95zXyqe1p
	 ZoAv51UkkYKpcZYTAAisBxBl4hf6Uv+KmnEvtmEszCrFQ4UCX6prXJTwvfuh+VBg0H
	 KsE2Brv2yI+jIip82JC/Ngr+3NzDrIw2sFwoF22lMvLiCLY/9/fGutyOhJmWBoHQ0r
	 N5tgRdT+HEy2DU7RimgNlnfIOmMDcup/G0VPUdWrNxwZPN/IikW4sEG5zmO1gaEX/J
	 VgppH76C/4vJ+axoPp1uwZD0v634hBDcqupR0UFuTNRHu80xxaX7JAyL6dF7YCetWD
	 6h8T6BgsJ0X2A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:17 +0200
Subject: [PATCH RFC POC 31/50] vfio: install the migration data descriptor
 when the ioctl returns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-31-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZuarGRo5ZqIHA3hh6zA1izPVcZ2LCwhC5SlPF3ZepH0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kkzvf951a0G+ZqpXSZ3J2/arrxG/8r9+aez1z9K9
 bjIVK2r1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRLQaMDBeN9d/bKs4OXXDx
 gkR+xafcmPCqbumzYcILTbl2Jzp0VTP8YspvytbQP3uhP99bqOslw97nz5UieFd43hf6lsB++8w
 DdgA=
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
 drivers/vfio/vfio_main.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 423ead48aafe..93d9d21f4074 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -903,28 +903,17 @@ EXPORT_SYMBOL_GPL(vfio_mig_get_next_state);
 static int vfio_ioct_mig_return_fd(struct file *filp, void __user *arg,
 				   struct vfio_device_feature_mig_state *mig)
 {
-	int ret;
-	int fd;
+	FD_PREPARE(fdf, O_CLOEXEC, filp);
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
-		goto out_fput;
+	if (IS_ERR(fdf)) {
+		fput(filp);
+		return PTR_ERR(fdf);
 	}
 
-	mig->data_fd = fd;
-	if (copy_to_user(arg, mig, sizeof(*mig))) {
-		ret = -EFAULT;
-		goto out_put_unused;
-	}
-	fd_install(fd, filp);
+	mig->data_fd = fd_prepare_fd(fdf);
+	if (copy_to_user(arg, mig, sizeof(*mig)))
+		return -EFAULT;
 	return 0;
-
-out_put_unused:
-	put_unused_fd(fd);
-out_fput:
-	fput(filp);
-	return ret;
 }
 
 static int

-- 
2.53.0


