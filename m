Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8ECC07E9D
	for <kexec@archiver.kernel.org>; Thu, 29 Sep 2022 04:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xcLzsqfRhBxYRjBhpyflYHYs4l2ALv0QzaMake04vK4=; b=Hv6664GUL5xC62
	kvzZQrslpnE8iM+0px5RZohoGPV6feB8x0gzCYKipjRlckBwKS0DS0vuj9yIyIysTN9ZlrchAGhwm
	SJ/hQ7i7XOnpX81NhYnUt9EHC4wctHWA//1LbWFbJPFux2F3FmBUk9z+DZG4X1QIOQc5VA12Sqq19
	j+BRzyI1bAkDcur8V0UGvs7QfBlR1dwO4Jd/vRZnOGNmORSu7jNZcZTVvYl4gbzj7aS2+42wKbFSf
	5tkY7o2W5KpGp3RaxEBwp7Bw5IAX58l/JplX+xSbxfyAPot/d45tjB1l1ruUNTawVA48xv63aY2TA
	EsAezaRrUsQwxKDnCqfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odlBS-0019yo-Vh; Thu, 29 Sep 2022 04:30:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odlBQ-0019wm-Of
	for kexec@lists.infradead.org; Thu, 29 Sep 2022 04:30:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664425799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X56MXTeL1zgJJtmkM3hVmZyHPkYGCqsYss1h8imBOow=;
	b=WYyQie4Oijtl275H8CkEUgHGvmQhxXg81abWNYG7Dv/KoXReEsPy7VC7oWWeIpWCilCbqh
	iRJXKqh9/f1rbyLLzdLXqMcXksMGDFm0qpOkDqs3uYf8Gwf5GwwnyAoy7C5FAx2LpUYsA2
	zeRb0WayJCQn6xerCtiZRhgrf9ikCOE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-BdnAzjN5O3CslsDk2kU_SQ-1; Thu, 29 Sep 2022 00:29:53 -0400
X-MC-Unique: BdnAzjN5O3CslsDk2kU_SQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD16A380673A;
	Thu, 29 Sep 2022 04:29:52 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-179.pek2.redhat.com [10.72.13.179])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0037A7AE5;
	Thu, 29 Sep 2022 04:29:48 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: kexec@lists.infradead.org,
	ebiederm@xmission.com,
	ye xingchen <ye.xingchen@zte.com.cn>,
	Zeal Robot <zealci@zte.com.cn>,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH RESEND 2/4] kexec: Remove the unneeded result variable
Date: Thu, 29 Sep 2022 12:29:34 +0800
Message-Id: <20220929042936.22012-3-bhe@redhat.com>
In-Reply-To: <20220929042936.22012-1-bhe@redhat.com>
References: <20220929042936.22012-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_213000_931921_406E488E 
X-CRM114-Status: GOOD (  11.14  )
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value kimage_add_entry() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index acd029b307e4..4d7da1556df8 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -561,23 +561,17 @@ static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
 static int kimage_set_destination(struct kimage *image,
 				   unsigned long destination)
 {
-	int result;
-
 	destination &= PAGE_MASK;
-	result = kimage_add_entry(image, destination | IND_DESTINATION);
 
-	return result;
+	return kimage_add_entry(image, destination | IND_DESTINATION);
 }
 
 
 static int kimage_add_page(struct kimage *image, unsigned long page)
 {
-	int result;
-
 	page &= PAGE_MASK;
-	result = kimage_add_entry(image, page | IND_SOURCE);
 
-	return result;
+	return kimage_add_entry(image, page | IND_SOURCE);
 }
 
 
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
