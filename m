Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA09C77B73
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 02:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gaa1xnu+Glubd5Iifxe8tiE2t4RDLLi6+zt00LlXfTE=; b=fRUT4wJPzvkCas
	oHJQlQj99wkbGGQ0/9i4Rd4IPZC+MSAF+OtFhjwk6e8RJ9jU8aqq5fxEG9eWAJvQxPmKARLjLLLk1
	7KYB0fX02oCUaOuq0S0rpMwTBU0NpL+Vg4Z6W2OQ1DYXuM+yrSd8H8f59IGtxrHGX54psKxVEfDfX
	WDveh+tt9P26zYUt2Xb0D2Fb76PYdXZg8GRbuSJwpyThzGyGXJSzYdKjURen0Jvd/cByxZ4trbx48
	Y2ieZ7tlsm9p2/JwBejA4bq8tNmwz8L6Av1XPsmFMMdTD15+Uah/JpEg2hTKChWxW6llq/ELP6oqn
	Cp/H6HSP0h/seIo3j9+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puld2-009aU1-0b;
	Fri, 05 May 2023 02:57:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pulcz-009aSg-2c
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 02:57:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683255421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rF9HTBYforRCQhZc154sfTm+T/3ktYGCUDJugI2yXM4=;
	b=PPDPPxolr4Pm7cuf2Y8UdHTS7dLHzJE0WWy40CKxRC6kE7YFumuC1Hp6U2w8x0VUQCcQpR
	KBLosHV5gR/8GJh8+YprQgj7whk24dLpLO6aEh+FwGM1qiTh6BaBoRnEGNxLbJmLC5RV8d
	DasAN/Qoon4wHeU0z8A/SCgVSJfDsoM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-cD1lPCkcONCoDykdcjWQLg-1; Thu, 04 May 2023 22:55:01 -0400
X-MC-Unique: cD1lPCkcONCoDykdcjWQLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36E013814944;
	Fri,  5 May 2023 02:55:01 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CBA72407D450;
	Fri,  5 May 2023 02:54:58 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCH 2/5] arm64/zImage: Remove unnecessary allocation for kernel_uncompressed_buf
Date: Fri,  5 May 2023 10:54:34 +0800
Message-Id: <20230505025438.11943-3-piliu@redhat.com>
In-Reply-To: <20230505025438.11943-1-piliu@redhat.com>
References: <20230505025438.11943-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_195701_938630_12F7D6F5 
X-CRM114-Status: UNSURE (   9.83  )
X-CRM114-Notice: Please train this message.
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

Since slurp_decompress_file() allocates the buffer to hold the content
read from the file, no need to allocate the buffer again.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com

---
 kexec/arch/arm64/kexec-zImage-arm64.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kexec/arch/arm64/kexec-zImage-arm64.c b/kexec/arch/arm64/kexec-zImage-arm64.c
index 6ee82ff..166d7ef 100644
--- a/kexec/arch/arm64/kexec-zImage-arm64.c
+++ b/kexec/arch/arm64/kexec-zImage-arm64.c
@@ -67,15 +67,6 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size)
 		goto fail_mkstemp;
 	}
 
-	kernel_uncompressed_buf =
-		(char *) calloc(kernel_size, sizeof(off_t));
-	if (!kernel_uncompressed_buf) {
-		dbgprintf("%s: Can't calloc %ld bytes\n",
-				__func__, kernel_size);
-		ret= -ENOMEM;
-		goto fail_calloc;
-	}
-
 	/* slurp in the input kernel */
 	dbgprintf("%s: ", __func__);
 	kernel_uncompressed_buf = slurp_decompress_file(kernel_buf,
@@ -128,7 +119,6 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size)
 fail_bad_header:
 	free(kernel_uncompressed_buf);
 
-fail_calloc:
 	if (fd >= 0)
 		close(fd);
 
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
