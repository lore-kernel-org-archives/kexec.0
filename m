Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD37EB64DC
	for <kexec@archiver.kernel.org>; Mon, 17 Jul 2023 13:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7HvP+odjnscxZJaLBoLwvMYd9oNte7FgsbczKIiGmSo=; b=tHOuq7kL49LN5L
	ylLCTiCR1KRyjFHDX02bn4gfXxPN4vyr7ZjbKMLbn+uekC/m1ZAiDlZzBVAj6GS5rsdFWRS5mIsDj
	52vFQ3kry9g8B53qawvkMGmEBqFG5U4hCAZl1/aaNT+Bm6DqiUm0wA2c8ORp0b/IgbZ38JAKroF5v
	z0dixvbWGr4uohUpiMzugxYsk30NArXdCtXG0nP2gVk5TcDKnINhQVWZXb/HapuEIdddwX11nZTLK
	LrOEFf+NJDB5dUPx5Mxgn2PgVIrDJCjTAKPp/SLqF/b/foyqlu+mbQmpJv5KjDu723oTxoQWbMkEl
	RB3GH08aOFBkeqtg/Txw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qLNyE-00444g-0B;
	Mon, 17 Jul 2023 13:08:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLNxi-0043xr-1U
	for kexec@lists.infradead.org;
	Mon, 17 Jul 2023 13:08:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689599305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ft0BFz/bLr63vEmpG5KWJeAACQDWIubwql3FdfnyaFI=;
	b=CoPFu3mT2PrEFg3M7NsDbIguuRJOjWn1/zVYdd7Kit2JSMYqahFrElCKv4LpLPD1W6yWTO
	Sqfk5q69v5zCy6HuLeYrrat4WYVVWVkIoJNgeh7XgawGzAgWpeTtU5zrg5eh9wGPchCGts
	2PEa/F5CHkwdWAgTfPKwD+UQftJahoU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-XohOcVItN5CoCRWZiNjhGg-1; Mon, 17 Jul 2023 09:08:22 -0400
X-MC-Unique: XohOcVItN5CoCRWZiNjhGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2ED743C0FC87;
	Mon, 17 Jul 2023 13:08:22 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4731D1121314;
	Mon, 17 Jul 2023 13:07:55 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCHv5 3/8] kexec: Introduce a new image probe method 'probe2'
Date: Mon, 17 Jul 2023 21:07:27 +0800
Message-Id: <20230717130732.22710-4-piliu@redhat.com>
In-Reply-To: <20230717130732.22710-1-piliu@redhat.com>
References: <20230717130732.22710-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230717_060826_714477_97E1FA8C 
X-CRM114-Status: GOOD (  17.25  )
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

As more complicated capsule kernel format occurs like zboot, where the
compressed kernel is stored as a payload. The straight forward
decompression can not meet the demand.

So introducing a new image probe interface -- probe2, which reads in the
kernel file and decides how to unfold the content by the method itself.

The interface probe and probe2 can not coexist

Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---
 kexec/kexec.c | 31 +++++++++++++++++++++++--------
 kexec/kexec.h |  9 +++++++++
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index d5e6dc0..5f75179 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -702,6 +702,9 @@ static int initialze_probe(const char *kern_fname,
 	if (probe_type >= 0)
 		return probe_type;
 
+	if (!file_type[0].probe)
+		goto type_probe2;
+
 	*kernel_fd = open(kern_fname, O_RDONLY);
 	if (*kernel_fd == -1) {
 		die("Failed to open file %s:%s\n", kern_fname,
@@ -712,27 +715,39 @@ static int initialze_probe(const char *kern_fname,
 	/* slurp in the input kernel */
 	*kernel_buf = slurp_decompress_file(kern_fname, kernel_size);
 	probe_type = 0;
+	return probe_type;
 
+type_probe2:
+	probe_type = 1;
 	return probe_type;
 }
 
 static int probe(struct file_type *ft, const char *kern_fname,
 		char **kernel_buf, off_t *kernel_size, int *kernel_fd)
 {
+	struct parsed_info info;
 	int ret;
 
-	initialze_probe(kern_fname, kernel_buf, kernel_size, kernel_fd);
+	ret = initialze_probe(kern_fname, kernel_buf, kernel_size, kernel_fd);
+	if (ret == 0) {
 #ifdef __aarch64__
-	/* handle Image.gz like cases */
-	if (is_zlib_file(kern_fname, &kernel_size)) {
-		if ((ret = ft->probe(kern_fname, *kernel_size)) >= 0)
-			*kernel_fd = ret;
-	} else {
-		ret = ft->probe(*kernel_buf, *kernel_size);
-	}
+		/* handle Image.gz like cases */
+		if (is_zlib_file(kern_fname, &kernel_size)) {
+			if ((ret = ft->probe(kern_fname, *kernel_size)) >= 0)
+				*kernel_fd = ret;
+		} else {
+			ret = ft->probe(*kernel_buf, *kernel_size);
+		}
 #else
 		ret = ft->probe(*kernel_buf, *kernel_size);
 #endif
+	} else if (ret == 1) {
+		ret = ft->probe2(kern_fname, &info);
+		*kernel_buf = info.kernel_buf;
+		*kernel_size = info.kernel_size;
+		*kernel_fd = info.fd;
+	}
+
 	return ret;
 }
 
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 0d820ad..fbeee3d 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -176,6 +176,12 @@ struct arch_map_entry {
 	unsigned long arch;
 };
 
+struct parsed_info {
+	char *kernel_buf;
+	off_t kernel_size;
+	int fd;
+};
+
 extern const struct arch_map_entry arches[];
 long physical_arch(void);
 
@@ -192,6 +198,7 @@ unsigned long locate_hole(struct kexec_info *info,
 	int hole_end);
 
 typedef int (probe_t)(const char *kernel_buf, off_t kernel_size);
+typedef int (probe2_t)(const char *kern_fname, struct parsed_info *info);
 typedef int (load_t )(int argc, char **argv,
 	const char *kernel_buf, off_t kernel_size, 
 	struct kexec_info *info);
@@ -201,6 +208,8 @@ struct file_type {
 	probe_t *probe;
 	load_t  *load;
 	usage_t *usage;
+	/* Keep it as the last one so that by default it is NULL */
+	probe2_t *probe2;
 };
 
 extern struct file_type file_type[];
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
