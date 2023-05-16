Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED35C77B7A
	for <kexec@archiver.kernel.org>; Tue, 16 May 2023 07:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nZyBFDiqduAf0wreoz8T4VaHsEuTvbig2SlCp2XHHrU=; b=31XJ8DMtFsteFr
	g2BaTXSE4T6exqYEImguIVm9SraFBsGdj5QhYEsrP1PoZKiCILKOCBDh7q7kewcKfCG0Tr0QxPQiy
	OoTlh9d9b9KmwAw+FuFxSZj1lGVz8mkdjFuq0oN97OD4agNM9B8q5OpUyRslzkospSLx0v6IMR+TX
	HXIterVAec+DVBBM1x5QSvrSdWVUW9ktTeR7ExRKxLmXW3tPgf61z6IYQJlTNJXGhyikxYv5ZYfCC
	YSB2xGAgWFUZ7ZGy2e4Vk1MQ6OebjZ/Z66W2oVoppQNtDQPvuccSD6Papgu1OXl5HbLmTzmGt9hfr
	eA/AeY8qObiHU9RA6EeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyp9v-004eph-1V;
	Tue, 16 May 2023 07:31:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyp9t-004eoD-0C
	for kexec@lists.infradead.org;
	Tue, 16 May 2023 07:31:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684222304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ba853WRnD/DZhYmAYGiTlW4wCTdmvrl48H9h/BgRaQ0=;
	b=Y9yQAsnEUawD1CicCC+/DyGhcs6fMZuEH831fz/KGYnfeKS+fRRH5UQDe2TKCCNEdCojM5
	ebMqmhutJyFNHTJDGeKRKiartJmnfcYZJ2jMLk0Jk4yFtGAn4khKBYyrJKULoTLGTz6HYN
	dOjvDYdLeBh70i5ldix11gqRaM0Nm28=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-h33K_gh2M66XV16Y4EdpzA-1; Tue, 16 May 2023 03:31:40 -0400
X-MC-Unique: h33K_gh2M66XV16Y4EdpzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C3F23C10223;
	Tue, 16 May 2023 07:31:40 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-20.pek2.redhat.com [10.72.8.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4D1631121314;
	Tue, 16 May 2023 07:31:37 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org
Subject: [PATCHv2 2/6] arm64: Fix some issues with zImage _probe()
Date: Tue, 16 May 2023 15:31:20 +0800
Message-Id: <20230516073124.23531-3-piliu@redhat.com>
In-Reply-To: <20230516073124.23531-1-piliu@redhat.com>
References: <20230516073124.23531-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_003145_169130_1BE5832C 
X-CRM114-Status: GOOD (  11.57  )
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

From: Jeremy Linton <jeremy.linton@arm.com>

Current compilers note that fname will be null while
attempting to print failures from strdup().

Further fix a memory leak caused by kernel_uncompressed_buf
never being used/freed before the allocated block is replaced
by the one returned by slurp_decompress_file().

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---
 kexec/arch/arm64/kexec-zImage-arm64.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/kexec/arch/arm64/kexec-zImage-arm64.c b/kexec/arch/arm64/kexec-zImage-arm64.c
index c04669f..8a23dea 100644
--- a/kexec/arch/arm64/kexec-zImage-arm64.c
+++ b/kexec/arch/arm64/kexec-zImage-arm64.c
@@ -56,8 +56,7 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size,
 	}
 
 	if (!(fname = strdup(FILENAME_IMAGE))) {
-		dbgprintf("%s: Can't duplicate strings %s\n", __func__,
-				fname);
+		dbgprintf("%s: Can't duplicate strings\n", __func__);
 		return -1;
 	}
 
@@ -68,15 +67,6 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size,
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
@@ -129,7 +119,6 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size,
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
