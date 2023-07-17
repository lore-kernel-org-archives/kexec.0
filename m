Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A2EEB64DC
	for <kexec@archiver.kernel.org>; Mon, 17 Jul 2023 13:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zgXeCFeGVRmYmPlmhg1qSPqh10e0x15WD2919la66RQ=; b=k3c7CI8O2F/dxq
	aBLrKpK2Q7yDqqEAw9Kg/For3wUSicL/yTjzMg/2g7cAO4iMHlZCAPfyfdtbx9qlP8+3LoiQNRsR4
	QQD6DScypEYN0Atv4jA6IGbG7x0WC9Re1BetM/IlGZRDX4PvYWOAfZf4PddRhx0kqJZWeUdgVIBlG
	LzYAVsKGqF2GmEADBE0RQwvtWjQvLxvMYaagIrBAFkCZeOQz1AdBmrf+//GDTZUy2dtpxzp3mkWP9
	r1y/lftsyWjixpOmp5uCpF/XSLbUbP5zZOsTF0fl1mgr29ue5trU1W+rXkdX06pGr39b1+cDQcAj6
	GD8MSCVvNKpvkSbSc0Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qLNxy-004402-38;
	Mon, 17 Jul 2023 13:08:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLNxI-0043wM-2Q
	for kexec@lists.infradead.org;
	Mon, 17 Jul 2023 13:08:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689599279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hB4yKUUCHsvcqTEkZdwu1CFj2KMtVLu2C1cBDm1Vgr8=;
	b=J/Bwjb0TZdEqiFxSCko+poLgDUZtTydJmi/zy1iQuiQRx7+6LIekwoKo5tm0EcUueXVvrS
	LEhOxpCOD4ZgEAJFdeyBOEaL7xheW2epZrUlRwBWPvHiwEqmbmK2/Z8BfZNIjJ9Qgd5rP9
	4kRBWI+NNJSDJhN2zYBHJhApeno0Yr8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-GLXRbSpJPY6NkJ5Q2wDiKQ-1; Mon, 17 Jul 2023 09:07:55 -0400
X-MC-Unique: GLXRbSpJPY6NkJ5Q2wDiKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DE0E3C0FC9A;
	Mon, 17 Jul 2023 13:07:55 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6DD2C1121314;
	Mon, 17 Jul 2023 13:07:52 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCHv5 2/8] kexec: Isolate probe method
Date: Mon, 17 Jul 2023 21:07:26 +0800
Message-Id: <20230717130732.22710-3-piliu@redhat.com>
In-Reply-To: <20230717130732.22710-1-piliu@redhat.com>
References: <20230717130732.22710-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230717_060801_035336_EEA401CD 
X-CRM114-Status: GOOD (  17.41  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Isolating the calling to the probe method, so in a later patch, a new
prototype probe2 interface can be introduced without exposure of the
change.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---
 kexec/kexec.c | 81 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 32 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 36bb2ad..d5e6dc0 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -694,6 +694,48 @@ static void update_purgatory(struct kexec_info *info)
 			   sizeof(digest));
 }
 
+static int initialze_probe(const char *kern_fname,
+		char **kernel_buf, off_t *kernel_size, int *kernel_fd)
+{
+	static int probe_type = -1;
+
+	if (probe_type >= 0)
+		return probe_type;
+
+	*kernel_fd = open(kern_fname, O_RDONLY);
+	if (*kernel_fd == -1) {
+		die("Failed to open file %s:%s\n", kern_fname,
+			strerror(errno));
+		return EFAILED;
+	}
+
+	/* slurp in the input kernel */
+	*kernel_buf = slurp_decompress_file(kern_fname, kernel_size);
+	probe_type = 0;
+
+	return probe_type;
+}
+
+static int probe(struct file_type *ft, const char *kern_fname,
+		char **kernel_buf, off_t *kernel_size, int *kernel_fd)
+{
+	int ret;
+
+	initialze_probe(kern_fname, kernel_buf, kernel_size, kernel_fd);
+#ifdef __aarch64__
+	/* handle Image.gz like cases */
+	if (is_zlib_file(kern_fname, &kernel_size)) {
+		if ((ret = ft->probe(kern_fname, *kernel_size)) >= 0)
+			*kernel_fd = ret;
+	} else {
+		ret = ft->probe(*kernel_buf, *kernel_size);
+	}
+#else
+		ret = ft->probe(*kernel_buf, *kernel_size);
+#endif
+	return ret;
+}
+
 /*
  *	Load the new kernel
  */
@@ -703,6 +745,7 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 	char *kernel;
 	char *kernel_buf;
 	off_t kernel_size;
+	int kernel_fd = -1;
 	int i = 0;
 	int result;
 	struct kexec_info info;
@@ -720,11 +763,6 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 		return -1;
 	}
 	kernel = argv[fileind];
-	/* slurp in the input kernel */
-	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
-
-	dbgprintf("kernel: %p kernel_size: %#llx\n",
-		  kernel_buf, (unsigned long long)kernel_size);
 
 	if (get_memory_ranges(&info.memory_range, &info.memory_ranges,
 		info.kexec_flags) < 0 || info.memory_ranges == 0) {
@@ -742,13 +780,13 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 			return -1;
 		} else {
 			/* make sure our file is really of that type */
-			if (file_type[i].probe(kernel_buf, kernel_size) < 0)
+			if (probe(&file_type[i], kernel, &kernel_buf, &kernel_size, &kernel_fd) < 0)
 				guess_only = 1;
 		}
 	}
 	if (!type || guess_only) {
 		for (i = 0; i < file_types; i++) {
-			if (file_type[i].probe(kernel_buf, kernel_size) == 0)
+			if (probe(&file_type[i], kernel, &kernel_buf, &kernel_size, &kernel_fd) == 0)
 				break;
 		}
 		if (i == file_types) {
@@ -1263,10 +1301,10 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 			unsigned long flags) {
 
 	char *kernel;
-	int kernel_fd, i;
+	int i, kernel_fd = -1;
 	struct kexec_info info;
 	int ret = 0;
-	char *kernel_buf;
+	char *kernel_buf = NULL;
 	off_t kernel_size;
 
 	memset(&info, 0, sizeof(info));
@@ -1290,31 +1328,10 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 
 	kernel = argv[fileind];
 
-	kernel_fd = open(kernel, O_RDONLY);
-	if (kernel_fd == -1) {
-		fprintf(stderr, "Failed to open file %s:%s\n", kernel,
-				strerror(errno));
-		return EFAILED;
-	}
-
-	/* slurp in the input kernel */
-	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
-
 	for (i = 0; i < file_types; i++) {
-#ifdef __aarch64__
-		/* handle Image.gz like cases */
-		if (is_zlib_file(kernel, &kernel_size)) {
-			if ((ret = file_type[i].probe(kernel, kernel_size)) >= 0) {
-				kernel_fd = ret;
-				break;
-			}
-		} else
-			if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
-				break;
-#else
-		if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
+		ret = probe(&file_type[i], kernel, &kernel_buf, &kernel_size, &kernel_fd);
+		if (ret >=0)
 			break;
-#endif
 	}
 
 	if (i == file_types) {
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
