Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DABC982C5
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4cyWZY3NqovxpRDY6IE9b0iFSwFNHI0DbK45a85UipQ=; b=4MdvqezUGMBGoYhnT2rboLk9sK
	2EVjjTlV3tvXLNqmHC7Buwgwxp+eMq/OgGmw7OvUtAdXI5H5XxZiSAoOGyADtk4vgMalqGz/LJTjN
	tqmVwdqGLiayowFcltAwKwrPoQEHwi+DuZobfa3W+Zv7nm4QNnr3KYu+qwIFZj1+cxbAEx3o1f+1l
	Wzf6K0A0QpUGqHohX1z1Nka9S6quDlvta2xVZhbP9/vsx9Q/gKJY0Mf1H98kUrikMuP8D+GOYS33e
	AIZCHcXrol4J7MRwciKQGomh/2BJ8LFOJhW4RowgQPOpsEMbLNEyerzlCuD/214fvuHVxez+K1HOU
	EJOMlzLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RSj-00000006D0B-3kNr;
	Tue, 15 Sep 2026 11:36:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RRn-00000006CAR-1Pte;
	Tue, 15 Sep 2026 11:35:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 194BC41253;
	Tue, 15 Sep 2026 11:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855EE1F000FF;
	Tue, 15 Sep 2026 11:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472135;
	bh=4cyWZY3NqovxpRDY6IE9b0iFSwFNHI0DbK45a85UipQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QShSpSCRD6Ol4MQvbWaGFCrC9D2hEvMMsqJVxbgperwaAzfDuHUwR651hhvjbuklD
	 V8TQMFUcMD9eSXSMuyAwgiWFzi0aqbkjT2ga+ukHQTd+ooSqbRR0w+8dklcQllx84s
	 J1vd1rrkg7W2xCcJFOtsGmjuUfysGb2g+4rZjFbqLWmyJ8Yf8Ww523QPYOM4gdlVYe
	 9qjw6VvRm1T5endGkraMKVYh3kIi8DvPoXM1B76VPl1ZetouR5ZWcWZs/UQmu4oEg/
	 QeIQWjAGAMnj1aiLn/FeAtI3+y0er7L+q8OA2u/+KtDir8seIk/RUJip7Wgf4oA2Ys
	 w5GYgWQdLMU4Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:19 +0200
Subject: [PATCH RFC POC 33/50] io_uring/zcrx: install the exported
 descriptor when the request returns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-33-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536; i=brauner@kernel.org;
 h=from:subject:message-id; bh=g4cMNX/82jJQalDLSwX1Nity2yqjS0J0NiJHAB23CT0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kk73H60xLL/uL9c1Ubz66I7n/6tuiXcUVn6/cZhl
 7opP+8pdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk/weG/3mbVB0z75nsf+2g
 kJwuHDdbwrosi1P7+cq1bOytTdFl1gz/Y3eZWfw1evMxy/980nMezqvh6nqrq+2qsnZHrDSbM9O
 WEQA=
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
 io_uring/zcrx.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 1b3b11405dac..d458c614c765 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -795,8 +795,6 @@ static int zcrx_export(struct io_ring_ctx *ctx, struct io_zcrx_ifq *ifq,
 		       struct zcrx_ctrl *ctrl, void __user *arg)
 {
 	struct zcrx_ctrl_export *ce = &ctrl->zc_export;
-	struct file *file;
-	int fd;
 
 	if (!mem_is_zero(ce, sizeof(*ce)))
 		return -EINVAL;
@@ -804,27 +802,18 @@ static int zcrx_export(struct io_ring_ctx *ctx, struct io_zcrx_ifq *ifq,
 	refcount_inc(&ifq->refs);
 	refcount_inc(&ifq->user_refs);
 
-	file = anon_inode_create_getfile("[zcrx]", &zcrx_box_fops,
-					 ifq, O_CLOEXEC, NULL);
-	if (IS_ERR(file)) {
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   anon_inode_create_getfile("[zcrx]", &zcrx_box_fops, ifq,
+					     O_CLOEXEC, NULL));
+	if (IS_ERR(fdf)) {
 		zcrx_unregister(ifq, NULL);
-		return PTR_ERR(file);
-	}
-
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0) {
-		fput(file);
-		return fd;
+		return PTR_ERR(fdf);
 	}
 
-	ce->zcrx_fd = fd;
-	if (copy_to_user(arg, ctrl, sizeof(*ctrl))) {
-		fput(file);
-		put_unused_fd(fd);
+	ce->zcrx_fd = fd_prepare_fd(fdf);
+	if (copy_to_user(arg, ctrl, sizeof(*ctrl)))
 		return -EFAULT;
-	}
 
-	fd_install(fd, file);
 	return 0;
 }
 

-- 
2.53.0


