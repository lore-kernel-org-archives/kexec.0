Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41DBD1CA15
	for <kexec@archiver.kernel.org>; Tue,  5 Nov 2024 03:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MGnFwj/3l519r/sSkX23Nu00SVqOXpfmGtHOVPu3C3A=; b=UwHGPkHX9yePfM
	2TCl80a+ZgVRVIyjaqCEpEyGTo2jIk65vgur/pTamzql0T/zP+G7IFMcagKvW5PAdpgg/TOj3HHfQ
	ZBtC3RYppdcE0NvhSRxX0lrkvBbZa0hYAt92DOlcLHvPU7nlEC7f2BA8eu45KGsncLfMlaxmFh8AB
	9oD0tNdqcMFk8pqS3Z4D64nm+itFseo7z0vXImdJsG1mHLsC1lMnarhz3SORkm8vIE7HJNz91arcq
	CUOR+5f7HaUWT7akTcwHK7JuGmNx5PyMqy2c6xe1IPzcUIaZ6q/RwfyxT/RIENOOLg29D+tKk3yW/
	UpryaYVABiAeKKXqfIpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8AhG-0000000FomH-2CG8;
	Tue, 05 Nov 2024 03:57:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8AhD-0000000FolY-0xNh
	for kexec@lists.infradead.org;
	Tue, 05 Nov 2024 03:57:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730779054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pWQs1wtKjDhG2VkTLmELqJolYRd3d/1stog3JANf50M=;
	b=B+Vlo9EYP+hADhkSgZIJhG2i2AvhEVoHDMcENdAc7wdoF4KhWvwa+b8Hqz1E+DWb8xY2eb
	rZ8qjxVWSud73hHk5wWtGBI/UJ4ZsNS4/qhukKmKEosyyxGhhxLFtaKsc69mnyH3e4/xAw
	Pgait4TG4uZGVZ9/ePn8iDOY88xcSWg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-KzVlvFDcMjGkS0itX1dTog-1; Mon,
 04 Nov 2024 22:57:31 -0500
X-MC-Unique: KzVlvFDcMjGkS0itX1dTog-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ECE31955F41;
	Tue,  5 Nov 2024 03:57:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.65])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5288819560A3;
	Tue,  5 Nov 2024 03:57:26 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Philipp Rudo <prudo@redhat.com>
Subject: [PATCH 1/3] UKI: Split out the routine to create temporary fd
Date: Tue,  5 Nov 2024 11:57:05 +0800
Message-ID: <20241105035710.11384-2-piliu@redhat.com>
In-Reply-To: <20241105035710.11384-1-piliu@redhat.com>
References: <20241105035710.11384-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_195735_361396_0B454856 
X-CRM114-Status: GOOD (  13.90  )
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

The process of creating temporary fd for initrd can be reused. Hence
splitting it out for later use.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
---
 kexec/kexec-uki.c | 53 +++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/kexec/kexec-uki.c b/kexec/kexec-uki.c
index 210ebb6..8a7d349 100644
--- a/kexec/kexec-uki.c
+++ b/kexec/kexec-uki.c
@@ -35,6 +35,34 @@ static int get_pehdr_offset(const char *buf)
 	return pe_hdr_offset;
 }
 
+static int create_tmpfd(const char *template, char *buf, int buf_sz, int *tmpfd)
+{
+	char *fname;
+	int fd = -1;
+
+	if (!(fname = strdup(template))) {
+		dbgprintf("%s: Can't duplicate strings\n", __func__);
+		return -1;
+	}
+
+	if ((fd = mkstemp(fname)) < 0) {
+		dbgprintf("%s: Can't open file %s\n", __func__,	fname);
+		return -1;
+	}
+
+	if (write(fd, buf, buf_sz) != buf_sz) {
+		dbgprintf("%s: Can't write the compressed file %s\n",
+				__func__, fname);
+		close(fd);
+		return -1;
+	} else {
+		*tmpfd = open(fname, O_RDONLY);
+		close(fd);
+	}
+
+	return 0;
+}
+
 int uki_image_probe(const char *file_buf, off_t buf_sz)
 {
 	struct pe_hdr *pe_hdr;
@@ -42,8 +70,6 @@ int uki_image_probe(const char *file_buf, off_t buf_sz)
 	struct section_header *sect_hdr;
 	int pe_hdr_offset, section_nr, linux_sz = -1;
 	char *pe_part_buf, *linux_src;
-	char *initrd_fname = NULL;
-	int initrd_fd = -1;
 
 	pe_hdr_offset = get_pehdr_offset(file_buf);
 	pe_part_buf = (char *)file_buf + pe_hdr_offset;
@@ -63,28 +89,9 @@ int uki_image_probe(const char *file_buf, off_t buf_sz)
 			linux_sz = sect_hdr->raw_data_size;
 
 		} else if (!strcmp(sect_hdr->name, UKI_INITRD_SECTION)) {
-			if (!(initrd_fname = strdup(FILENAME_UKI_INITRD))) {
-				dbgprintf("%s: Can't duplicate strings\n", __func__);
-				goto next;
-			}
-
-			if ((initrd_fd = mkstemp(initrd_fname)) < 0) {
-				dbgprintf("%s: Can't open file %s\n", __func__,	initrd_fname);
-				goto next;
-			}
-
-			if (write(initrd_fd, (char *)file_buf + sect_hdr->data_addr,
-					sect_hdr->raw_data_size) != sect_hdr->raw_data_size) {
-				dbgprintf("%s: Can't write the compressed file %s\n",
-						__func__, initrd_fname);
-				close(initrd_fd);
-				goto next;
-			} else {
-				implicit_initrd_fd = open(initrd_fname, O_RDONLY);
-				close(initrd_fd);
-			}
+			create_tmpfd(FILENAME_UKI_INITRD, (char *)file_buf + sect_hdr->data_addr,
+					sect_hdr->raw_data_size, &implicit_initrd_fd);
 		}
-next:
 		sect_hdr++;
 	}
 
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
