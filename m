Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2856ECD5BC8
	for <kexec@archiver.kernel.org>; Tue, 26 May 2026 15:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yXJHT/nl7RJyzhR5KfCpyXi9LiUdlUUFWLId5lh91pI=; b=g0LadXKbxP+hhipKXlkgYN9NNz
	IgiP3jU7vC/JOWxlUXFH/gVPpE2kl1bQtSrCleeHPWPva+thAcKrOQQaIJ1bJkP/vfDkgYRkngKoS
	CC2not3OWBe36W/i9NGyYnX4zdyE6PK2k8Iu1j8A9MWO0T8zGiY3UhOjldWIpNFv0cxbhZitJP05W
	MXYm9CXBh8JyyfuLRNINHtYTytkEK4dck2KCttn6/Hxdf6BmFdBlES1w2Arhh2mcNNdL2ai45QjBu
	BhGg/9bvK05R4SQjfRLUia/wNjfmshMb8RfI5Hi5VBUtrFWEZbSD+ml2GPDg9L34oqsB3sK/NCsrr
	gVS8LYsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRtXI-00000002LFW-3rQB;
	Tue, 26 May 2026 15:17:40 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRtXG-00000002LFE-45kW
	for kexec@bombadil.infradead.org;
	Tue, 26 May 2026 15:17:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=yXJHT/nl7RJyzhR5KfCpyXi9LiUdlUUFWLId5lh91pI=; b=BhdiHvp5//Rbb6uVHLIW6svevL
	UFdrWWvcXianolBI0VvVdHzlRgp2EPXB5Lmzy4rhGMsFCZaoQMtScSsarl03Qt6wNH2AX4tt3elGd
	K+gZ2kTYNUoMqIl7wpx/xYX+INivUDuS+bIUQQTz6kb3h0R3Ia0Iv44skN6aMBcZqHNYW6bCr+gPM
	qPc69117xOyiNtF4QMEnrc0lJoihiHLIbQ+WPYuTt8gx/wu/syfdHLSh1zbdNJegt0AlqpQpICFYf
	R6efEDY9RmB9syTw+Jf0UgeKKIk5vPwWP5s1xHH67gk54VcWJX67pEkE8So3ABMZLxvp/fz2172BR
	4mscD1xQ==;
Received: from linux.microsoft.com ([13.77.154.182])
	by desiato.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRtXD-0000000Berc-1xEQ
	for kexec@lists.infradead.org;
	Tue, 26 May 2026 15:17:37 +0000
Received: from alhe-dev-ub.waqitnwczulubdoacjva2kqlvd.phxx.internal.cloudapp.net (unknown [134.33.52.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0602E20B7167
	for <kexec@lists.infradead.org>; Tue, 26 May 2026 08:17:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0602E20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779808635;
	bh=yXJHT/nl7RJyzhR5KfCpyXi9LiUdlUUFWLId5lh91pI=;
	h=From:To:Subject:Date:From;
	b=SVeiUvrRvL2olN2ncYKY5o9ChWPsc/pBYeLlZ7BJyU1QB073AJegnwPUN7AFad2UW
	 a8NcaFzsdJX3d+UNbC63uzyH6dC+MpLJSsN3SLlAa5Rsc3HSOs3YqHcTHXtgukVKbt
	 XIeW7kvVB53GSNiDw+gmj/C0z2TATPJlJSApXvNU=
From: Alejandro Hernandez <alhe@linux.microsoft.com>
To: kexec@lists.infradead.org
Subject: [PATCH v2] kexec: restore functionality to preserve fd xattrs for uncompressed kernel images
Date: Tue, 26 May 2026 15:17:14 +0000
Message-ID: <20260526151714.4181388-1-alhe@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_161736_003138_A93E60F9 
X-CRM114-Status: GOOD (  18.71  )
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

Since commit 714fa115 xattrs attached to a kernel image file (such as IMA
signatures) are not being preserved, do_kexec_file_load() was modified to use
memfd_create() which now passes an anonymous file descriptor to
kexec_file_load(). This change eliminated the filesystem inode identity of the
original kernel file, hence attributes are no longer visible to the kernel IMA
appraisal handler during kexec_file_load, causing IMA policy enforcement to fail
even for validly signed kernel images.

This patch attempts to restore such behavior although, only does it for
uncompressed kernel images. To do this, we first figure out if the image file is
compressed or not and call each method accordingly.

Compressed images continue to use memfd and cannot carry forward the original fd
security attributes, since their decompressed bytes do not match the signed
artifact. Proper handling of compressed images with IMA would require either
signing the decompressed artifact or kernel-side support for decompression
within the kexec_file_load path.

Signed-off-by: Alejandro Hernandez Samaniego <alhe@linux.microsoft.com>
---
 kexec/kexec.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 08edfca..68f23dc 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1305,6 +1305,8 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 	int ret = 0;
 	char *kernel_buf;
 	off_t kernel_size;
+	struct stat kernel_stat;
+	off_t kernel_file_size = -1;
 
 	memset(&info, 0, sizeof(info));
 	info.segment = NULL;
@@ -1328,17 +1330,39 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 
 	kernel = argv[fileind];
 
-	/* slurp in the input kernel */
+       /* Hold original fd with its xattrs */
+	kernel_fd = open(kernel, O_RDONLY);
+	if (kernel_fd == -1) {
+		fprintf(stderr, "Failed to open file %s:%s\n", kernel,
+				strerror(errno));
+		return EFAILED;
+	}
+
+	/* Compressed vs Uncompressed */
+	if (fstat(kernel_fd, &kernel_stat) == 0)
+		kernel_file_size = kernel_stat.st_size;
+
+        /* slurp in the input kernel */
 	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
 	if (!kernel_buf) {
 		fprintf(stderr, "Failed to decompress file %s:%s\n", kernel,
 				strerror(errno));
+		close(kernel_fd);
 		return EFAILED;
 	}
-	kernel_fd = copybuf_memfd(kernel_buf, kernel_size);
-	if (kernel_fd < 0) {
-		fprintf(stderr, "Failed to copy decompressed buf\n");
-		return EFAILED;
+
+	if (kernel_file_size != kernel_size) {
+		close(kernel_fd);
+		kernel_fd = copybuf_memfd(kernel_buf, kernel_size);
+		if (kernel_fd < 0) {
+			fprintf(stderr, "Failed to copy decompressed buf\n");
+			return EFAILED;
+		}
+		dbgprintf("%s: compressed input, using memfd kernel fd %d\n",
+			  __func__, kernel_fd);
+	} else {
+		dbgprintf("%s: using original kernel file fd %d\n",
+			  __func__, kernel_fd);
 	}
 
 	for (i = 0; i < file_types; i++) {
@@ -1361,11 +1385,15 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 	}
 
        /*
-	* image type specific load functioin detect the capsule kernel type
+	* image type specific load function detect the capsule kernel type
 	* and create another fd for file load. For example the zboot kernel.
 	*/
-	if (info.kernel_fd != -1)
+	if (info.kernel_fd != -1) {
+		dbgprintf("%s: using image-specific kernel fd %d\n",
+			  __func__, info.kernel_fd);
+		close(kernel_fd);
 		kernel_fd = info.kernel_fd;
+	}
 
 	/*
 	 * If there is no initramfs, set KEXEC_FILE_NO_INITRAMFS flag so that
-- 
2.43.0


