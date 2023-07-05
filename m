Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702D0EB64D9
	for <kexec@archiver.kernel.org>; Wed,  5 Jul 2023 02:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7CSxseN3dRrOgFPW/LOViQL49Ck5amie6F1RP7AOy0k=; b=Go8XpXHjA3DtF4
	K6b4L2ad4PUHDVR1rslV/y6OsqqnmUYw3wbwOl9GplOn8kJqwfcrMbG+4yUFdNwyP73/yvBzl6/0P
	6Lktn1ljz/GHsDERio8bZT+F/it9zwYaDvIpjQYwD+3nSmYuLIAz4EPnKUtoB02XCKKU12/wXGr+L
	hKkZkgeZjt7NsWrvIviqM3eriWq/Z7m9vLGKKKX7xBT6VUauEf9EtITOkhXSq33syD291msFxlhD6
	DdMcnL5w9rK2pG1IQo74qRT0KihWFT+WQjLW9GfRYKX/sZ/CRM6BBvhpdxJ3d0t3YKueIMg9Abblv
	zFQBye/L4UlHx7Q3wlXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGsYV-00Edol-2M;
	Wed, 05 Jul 2023 02:47:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGsYT-00EdoB-0A
	for kexec@lists.infradead.org;
	Wed, 05 Jul 2023 02:47:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688525264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Zv0ZIBcubRVFd0aPY9hgjti2jW8lVVyFHpftPXK2YY=;
	b=d5ix9TqMTg8jnmgOXpguIEx/7gzFOtCqz1DrfbFKejcoiSrZ6ehnODk2+kouCD7OhDFkkF
	QnyotSnfXbYgGaRKctw7ZgaKH4WcawYtl3qMMv+fdXtzEVf0es3V9E4oIIVzNBEl9YEBvz
	GfQwrRfXUv/IPd7dwGluOrF5DtwL3ts=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-65If1DHgM6ag-5UZEVKjIQ-1; Tue, 04 Jul 2023 22:47:40 -0400
X-MC-Unique: 65If1DHgM6ag-5UZEVKjIQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92A211008133;
	Wed,  5 Jul 2023 02:47:40 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A85C51121314;
	Wed,  5 Jul 2023 02:47:37 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org
Subject: [PATCHv4 1/8] arm64: Fix some issues with zImage _probe()
Date: Wed,  5 Jul 2023 10:47:18 +0800
Message-Id: <20230705024725.11741-2-piliu@redhat.com>
In-Reply-To: <20230705024725.11741-1-piliu@redhat.com>
References: <20230705024725.11741-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230704_194745_160766_79A34A95 
X-CRM114-Status: GOOD (  11.69  )
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
index 6ee82ff..3eb1ad8 100644
--- a/kexec/arch/arm64/kexec-zImage-arm64.c
+++ b/kexec/arch/arm64/kexec-zImage-arm64.c
@@ -55,8 +55,7 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size)
 	}
 
 	if (!(fname = strdup(FILENAME_IMAGE))) {
-		dbgprintf("%s: Can't duplicate strings %s\n", __func__,
-				fname);
+		dbgprintf("%s: Can't duplicate strings\n", __func__);
 		return -1;
 	}
 
@@ -67,15 +66,6 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size)
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
@@ -128,7 +118,6 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size)
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
