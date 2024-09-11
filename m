Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9178EE0217
	for <kexec@archiver.kernel.org>; Wed, 11 Sep 2024 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ulSd4ZVkyk8aXtEpV8XbvnVhCNLr+WQViybbvqBsz4o=; b=URBp2fXQxlovrm
	b/Uq9P7GMWY4W4fAEXVerTJ1xdbTLCvO6HsnlIC/8L/tjorUzYCrwhlipotnrqPkt5aPX6rJHVn9G
	xKrFmgPtKVbHHCiXfZzz+rei9YF96DfpTvNE6ftTItFU6Z5mvJ3H0V8zHNSqVBZa80rYZqsi8aXx1
	JZ1x6riB+a5NMc52RmWPMYlhdUWkbLWdMo8R1/nDBzWQaDfqOYVqCIaPjOHJXYzpOy6x0WNkThk+N
	GnngYOLLB0cxZcfjaJqJx1wU/5JGC9bS9tYu4DhV6iaSuASr4O52bsb9l+/yjPrb+rnLVG9QMP6aN
	8efVtgS+c6xfDoq5fvtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soIcu-00000008cbj-3to7;
	Wed, 11 Sep 2024 08:23:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soIWi-00000008avf-3e9Q
	for kexec@lists.infradead.org;
	Wed, 11 Sep 2024 08:16:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726042595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5yv95X4eG3twwLNvJXq61BcdIuFvnrT30obkauJq40=;
	b=edJGh4cJ+5EunFZ7X8SqzqRGAaVW4A95xsJo3vjWyFU7mWWrHbR3nhWJHOYlGrJyldsbRE
	wk8Nm7G7asHfO9LNF0ZpaqAcyGedd4x4fhyemDBa/gxTj2i3HyNsD9Nq2F+UxZaqPDLTZ6
	L8UB+QhVkyYumlgWmopMUF1s2Ud/dzg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-l4hOSEeuM0OsJUmBcCcalA-1; Wed,
 11 Sep 2024 04:16:32 -0400
X-MC-Unique: l4hOSEeuM0OsJUmBcCcalA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18BE91955F29;
	Wed, 11 Sep 2024 08:16:31 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.58])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 291A830001A1;
	Wed, 11 Sep 2024 08:16:25 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: thomas.lendacky@amd.com,
	dyoung@redhat.com,
	daniel.kiper@oracle.com,
	noodles@fb.com,
	lijiang@redhat.com,
	kexec@lists.infradead.org,
	x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 1/2] x86/mm: rename the confusing local variable in early_memremap_is_setup_data()
Date: Wed, 11 Sep 2024 16:16:14 +0800
Message-ID: <20240911081615.262202-2-bhe@redhat.com>
In-Reply-To: <20240911081615.262202-1-bhe@redhat.com>
References: <20240911081615.262202-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_011637_021983_9570CA80 
X-CRM114-Status: GOOD (  11.30  )
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

In function early_memremap_is_setup_data(), parameter 'size' passed has
the same name as the local variable inside the while loop. That
confuses people who sometime mix up them when reading code.

Here rename the local variable 'size' inside while loop to 'sd_size'.

And also add one local variable 'sd_size' likewise in function
memremap_is_setup_data() to simplify code. In later patch, this can also
be used.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/mm/ioremap.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index aa7d279321ea..f1ee8822ddf1 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -640,7 +640,7 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 
 	paddr = boot_params.hdr.setup_data;
 	while (paddr) {
-		unsigned int len;
+		unsigned int len, sd_size;
 
 		if (phys_addr == paddr)
 			return true;
@@ -652,6 +652,8 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 			return false;
 		}
 
+		sd_size = sizeof(*data);
+
 		paddr_next = data->next;
 		len = data->len;
 
@@ -662,7 +664,9 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 
 		if (data->type == SETUP_INDIRECT) {
 			memunmap(data);
-			data = memremap(paddr, sizeof(*data) + len,
+
+			sd_size += len;
+			data = memremap(paddr, sd_size,
 					MEMREMAP_WB | MEMREMAP_DEC);
 			if (!data) {
 				pr_warn("failed to memremap indirect setup_data\n");
@@ -701,7 +705,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 
 	paddr = boot_params.hdr.setup_data;
 	while (paddr) {
-		unsigned int len, size;
+		unsigned int len, sd_size;
 
 		if (phys_addr == paddr)
 			return true;
@@ -712,7 +716,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 			return false;
 		}
 
-		size = sizeof(*data);
+		sd_size = sizeof(*data);
 
 		paddr_next = data->next;
 		len = data->len;
@@ -723,9 +727,9 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 		}
 
 		if (data->type == SETUP_INDIRECT) {
-			size += len;
+			sd_size += len;
 			early_memunmap(data, sizeof(*data));
-			data = early_memremap_decrypted(paddr, size);
+			data = early_memremap_decrypted(paddr, sd_size);
 			if (!data) {
 				pr_warn("failed to early memremap indirect setup_data\n");
 				return false;
@@ -739,7 +743,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 			}
 		}
 
-		early_memunmap(data, size);
+		early_memunmap(data, sd_size);
 
 		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
 			return true;
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
