Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A122D4A5EB
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 03:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uUfcEW/wlh3C/HM93w8YTTa2lylF3eZQ+D1pvi16zc0=; b=DgIgO/79JcyDng4o3YARpMo3WK
	Wbw5Bl1Gm9AXimjUysGoOAhkHjDgA/8Xsf8VrnLae0FJZ8madm5Mj3N7r1oJ8rcWOSwwTlue0BufV
	UWXdt7OM70Nj+TXB+0M/dnniFzxX+uy0jp9pzXFpb//G/xFk2VjNUfnT9u2BcxelcdDPVU9NO+thc
	if47zvNx886N60B/yL81nKJp10lDKpktuO9vHkkL9plpaDC/7Yh8S3UT3CDc3ORrPiAyUqNPyiDoj
	8VmLGvLr3FIYdwgUOZaHtV9kHIw8ZIGxDia7FyT6WTcPdhcGZrIyk3NNv2a126lDdUFnsBBfXMXxE
	zyoycphw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhftl-00000001JOK-1RvQ;
	Mon, 19 Jan 2026 03:25:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhfti-00000001JNT-2jUQ
	for kexec@lists.infradead.org;
	Mon, 19 Jan 2026 03:25:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768793145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUfcEW/wlh3C/HM93w8YTTa2lylF3eZQ+D1pvi16zc0=;
	b=JU4kbkfjEAkT70vewBHXymc/mRynGzDaGMGlZi67VJ1LPSH6kdQBrFETflt31MsnQahdCK
	w1P1tn0yQ86kiBW+zdClLuck9vD9zb/zpgmgGkFM5eJtSNbfk9oP8kCP8c/Jtp7y5qgUle
	TBbbgjC3JxOOm/isO9yNQDwZguiJYmY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-WBnPK6nxPgym9yRbPGjS6w-1; Sun,
 18 Jan 2026 22:25:41 -0500
X-MC-Unique: WBnPK6nxPgym9yRbPGjS6w-1
X-Mimecast-MFC-AGG-ID: WBnPK6nxPgym9yRbPGjS6w_1768793139
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D70F01800447;
	Mon, 19 Jan 2026 03:25:38 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBD0C195419F;
	Mon, 19 Jan 2026 03:25:26 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv6 02/13] kexec_file: Move signature validation ahead
Date: Mon, 19 Jan 2026 11:24:13 +0800
Message-ID: <20260119032424.10781-3-piliu@redhat.com>
In-Reply-To: <20260119032424.10781-1-piliu@redhat.com>
References: <20260119032424.10781-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260118_192546_779184_FCC8B32D 
X-CRM114-Status: GOOD (  13.06  )
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

Move the signature validation at the head of the function, so the image
can be unfold and handled later.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org
---
 kernel/kexec_file.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index eb62a97942428..0222d17072d40 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -231,18 +231,19 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	kexec_dprintk("kernel: %p kernel_size: %#lx\n",
 		      image->kernel_buf, image->kernel_buf_len);
 
-	/* Call arch image probe handlers */
-	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
-					    image->kernel_buf_len);
-	if (ret)
-		goto out;
-
 #ifdef CONFIG_KEXEC_SIG
 	ret = kimage_validate_signature(image);
 
 	if (ret)
 		goto out;
 #endif
+
+	/* Call arch image probe handlers */
+	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
+					    image->kernel_buf_len);
+	if (ret)
+		goto out;
+
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,
-- 
2.49.0


