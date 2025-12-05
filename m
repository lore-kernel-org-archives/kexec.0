Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF6ED2CDFE
	for <kexec@archiver.kernel.org>; Fri,  5 Dec 2025 02:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GsWiDM17YZROD4tw23rLGDyOFP99Sw+ojKKNxS99INw=; b=AWKGoCw49BUklJecnbOCyZKmRa
	lpOZAvqE7FnrqzE+wMCsfTRUJstr9n+N+lEX8cHsUjDMUtjUjbFkzpFMWiwTtJHAjMGCP9Kn+M6OK
	/TVvaMIp2I5I0ejM31/AkCtbWuYSND3ZLT545DGQsxcCGfr0teMxtjz6jyr0rK5NCIOrF6IbFr//J
	ftj6P1rItVkfSFQomlnx1vqj0c9N6LuBazjQeuVfyQnTCfZYxw8Zurnca/TQ43Wrg/p1gSv7HPuTA
	Ben2yqW4VdyNXBiVw9K8njjwY8lggQ0xuFmJmihrDOZoOm1yEFV3POmbSFegrfhNdnLYk82zLTu86
	2MWYfNYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRLCr-00000008tsT-2fsu;
	Fri, 05 Dec 2025 02:06:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRLCl-00000008trx-2cvd
	for kexec@lists.infradead.org;
	Fri, 05 Dec 2025 02:05:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764900352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GsWiDM17YZROD4tw23rLGDyOFP99Sw+ojKKNxS99INw=;
	b=SJsdaBv6y5v8SXk8h2bYznInOR7KtxK6Q5VHGh6o6l0JpqL5evYc8cjhomAxSQjmbanTPn
	zIEwztpuP9SYpL+64CgkxGTrIoarn7ba3+oD/tdS64oN14GAiDKq+LBu2M1AtZvK/5SWzP
	ODwS4z+5l4UbawlzgYyQ1nrOe1EBiFk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-JEKX6k8YPDObtSKp0i8IgQ-1; Thu,
 04 Dec 2025 21:05:50 -0500
X-MC-Unique: JEKX6k8YPDObtSKp0i8IgQ-1
X-Mimecast-MFC-AGG-ID: JEKX6k8YPDObtSKp0i8IgQ_1764900349
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A405B1800365;
	Fri,  5 Dec 2025 02:05:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.103])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3ACEF1953986;
	Fri,  5 Dec 2025 02:05:45 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: Simon Horman <horms@kernel.org>,
	kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Philipp Rudo <prudo@redhat.com>
Subject: [PATCH] UKI: Fix the size of real payload
Date: Fri,  5 Dec 2025 10:05:36 +0800
Message-ID: <20251205020536.8358-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qlVkAWJm9pPpwVjbAG8GFCT0bKSBWM3Jwi0cUJebwN4_1764900349
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_180555_737314_70DFB837 
X-CRM114-Status: GOOD (  13.69  )
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

According to the PE file specification, each section's SizeOfRawData
must be a multiple of FileAlignment (usually 512). So when ukify builds
a UKI image, it pads the kernel image, initrd, etc. with zeros aligned
to 512 bytes. The actual payload size is recorded in VirtualSize.

Since the checksum includes the trailing zeros, this causes issues when
loading a signed x86 bzImage, which is stored in the UKI's .linux
section.

Credit goes to Philipp, who analysed and pointed out this issue to me.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Philipp Rudo <prudo@redhat.com>
To: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
---
 include/pe.h      | 2 +-
 kexec/kexec-uki.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/pe.h b/include/pe.h
index 9ab3e79..3fb923f 100644
--- a/include/pe.h
+++ b/include/pe.h
@@ -116,7 +116,7 @@ struct section_header {
 	char name[8];			/* name or "/12\0" string tbl offset */
 	uint32_t virtual_size;		/* size of loaded section in ram */
 	uint32_t virtual_address;	/* relative virtual address */
-	uint32_t raw_data_size;		/* size of the section */
+	uint32_t raw_data_size;		/* size of the section, padding to be multiple of FileAlignment */
 	uint32_t data_addr;		/* file pointer to first page of sec */
 	uint32_t relocs;		/* file pointer to relocation entries */
 	uint32_t line_numbers;		/* line numbers! */
diff --git a/kexec/kexec-uki.c b/kexec/kexec-uki.c
index 9888d7e..fe86d61 100644
--- a/kexec/kexec-uki.c
+++ b/kexec/kexec-uki.c
@@ -71,11 +71,11 @@ int uki_image_probe(const char *file_buf, off_t buf_sz)
 		if (!strcmp(sect_hdr->name, UKI_LINUX_SECTION)) {
 			/* data_addr is relative to the whole file */
 			linux_src = (char *)file_buf + sect_hdr->data_addr;
-			linux_sz = sect_hdr->raw_data_size;
+			linux_sz = sect_hdr->virtual_size;
 
 		} else if (!strcmp(sect_hdr->name, UKI_INITRD_SECTION)) {
 			create_tmpfd(FILENAME_UKI_INITRD, (char *)file_buf + sect_hdr->data_addr,
-					sect_hdr->raw_data_size, &implicit_initrd_fd);
+					sect_hdr->virtual_size, &implicit_initrd_fd);
 		}
 		sect_hdr++;
 	}
-- 
2.49.0


