Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0F1E77170
	for <kexec@archiver.kernel.org>; Fri,  6 Dec 2024 02:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ml9iD49MheQMeDe1xnJJ0E4wM+bemu5G9oW+aSBbWMc=; b=3nvOX8TxBNioKyoZkoAUuSS/53
	O+8OWT8FAnzrLRaVvuW3uH5/zpM6Je9TJ+WahH1YsCQzu+RENVgeBitILqFuz1ncGT5NMaSoqoSHE
	OKp9wzkteYuzspO3Mwl0zYh9NR/AwmRi5KvPWJzNSHAKNj3217vDVWafMfU8DP1Cjd6W677p9d3Ri
	u2Ng4Q6zeZ9/79NMuZGZyJ/SpgWCsSFkqU0zPcUu9XMpqbGViAVIOWnedxPnGRfi1FRpNbopzy1EG
	jceZ1Sgu6M4ij4cHSaaOynQvEBSCWmUISE2cFLY3FKBt0xQVXsLS7+CuFPwSfQHC/tCgMWEAaILK7
	vvsP/fPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJOLE-00000000MK6-2ryI;
	Fri, 06 Dec 2024 02:45:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJOLB-00000000MIf-20A3
	for kexec@lists.infradead.org;
	Fri, 06 Dec 2024 02:45:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733453110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ml9iD49MheQMeDe1xnJJ0E4wM+bemu5G9oW+aSBbWMc=;
	b=QUAvf+jhFOlPLePibihrt4i4PJxVE5NzIXOcu+C0bWK5rKxgQWbhk6WmPnfDwwM7letwU3
	JUaUc30+7rR95vllH6yx31mHe+2XU9DmuBugRSFe/8M9MXbBYEKOPqI/YijYMosHtPwSmP
	6IC39G6SCuiDPREYisf0BR4n3SUAYU0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-7l6EaFqpNVOK0zv63BR4fA-1; Thu,
 05 Dec 2024 21:45:06 -0500
X-MC-Unique: 7l6EaFqpNVOK0zv63BR4fA-1
X-Mimecast-MFC-AGG-ID: 7l6EaFqpNVOK0zv63BR4fA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDE8319560B3;
	Fri,  6 Dec 2024 02:45:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A61E319560A2;
	Fri,  6 Dec 2024 02:45:01 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 1/2] PE: Extract get_pehdr_offset() for reuse
Date: Fri,  6 Dec 2024 10:44:42 +0800
Message-ID: <20241206024445.10442-2-piliu@redhat.com>
In-Reply-To: <20241206024445.10442-1-piliu@redhat.com>
References: <20241206024445.10442-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dz92S3z5SKG_3LEFkZ4EE86JGus3e1cuCyP8ghKwpLg_1733453104
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_184513_597818_248C9718 
X-CRM114-Status: GOOD (  12.31  )
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

The get_pehdr_offset() function helps skip the DOS stub in a PE file to
locate the start of the PE header. Since it can be used in multiple C
files, it is being moved to a header file.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
---
 include/pe.h      | 17 +++++++++++++++++
 kexec/kexec-uki.c | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/pe.h b/include/pe.h
index 2617074..1e1c59b 100644
--- a/include/pe.h
+++ b/include/pe.h
@@ -101,4 +101,21 @@ struct section_header {
 	uint32_t flags;
 };
 
+/*
+ * Return -1 if not PE, else offset of the PE header
+ */
+static int get_pehdr_offset(const char *buf)
+{
+	int pe_hdr_offset;
+
+	pe_hdr_offset = *((int *)(buf + 0x3c));
+	buf += pe_hdr_offset;
+	if (!!memcmp(buf, "PE\0\0", 4)) {
+		printf("Not a PE file\n");
+		return -1;
+	}
+
+	return pe_hdr_offset;
+}
+
 #endif
diff --git a/kexec/kexec-uki.c b/kexec/kexec-uki.c
index 235f5a1..9888d7e 100644
--- a/kexec/kexec-uki.c
+++ b/kexec/kexec-uki.c
@@ -20,23 +20,6 @@
 static int embeded_linux_format_index = -1;
 static int kernel_fd = -1;
 
-/*
- * Return -1 if not PE, else offset of the PE header
- */
-static int get_pehdr_offset(const char *buf)
-{
-	int pe_hdr_offset;
-
-	pe_hdr_offset = *((int *)(buf + 0x3c));
-	buf += pe_hdr_offset;
-	if (!!memcmp(buf, "PE\0\0", 4)) {
-		printf("Not a PE file\n");
-		return -1;
-	}
-
-	return pe_hdr_offset;
-}
-
 static int create_tmpfd(const char *template, char *buf, int buf_sz, int *tmpfd)
 {
 	char *fname;
-- 
2.41.0


