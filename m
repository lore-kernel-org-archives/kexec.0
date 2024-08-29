Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6571FC83030
	for <kexec@archiver.kernel.org>; Thu, 29 Aug 2024 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3diEZ0AX44F6Hu1MFhBS8P9pl+ATb1rBDnTN0kEDccg=; b=uoI0DmQe8rVwsi
	t8TXeg87pGOBOvZ1TJo9Rna8kmKz0sEDTrkQx81w0wuJBga5YC0ahBtt9+LVqggPIHEd6ap6kVQX2
	MB8ODuihio1UuYzeW4QOq/+VIgjU3qKJIo0V926dS69Kz/9ozJZXF9U6n/IfiF27QfJU/0C2AUttO
	u3jyJqVJ4/D8HvnDiPRyg0EtpmDo3Rdt2K5nIUtaOyC2iYbWP2Q28Pqbznllr4QbbIihni4Im7jAz
	/jVwntJQ6JQy1BEkCXSJtIWhi5dqUaDXXcWwr8LArNxYsMaEb5v8cVk8LDZrY40iGOxC4oEjOxWtd
	NlMXc7Rxcd/TQNEs9IdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjcZy-00000001cTq-0DhM;
	Thu, 29 Aug 2024 10:40:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjcZv-00000001cSN-24l5
	for kexec@lists.infradead.org;
	Thu, 29 Aug 2024 10:40:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724928034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHcFyd24V34lOmEbXBxWKp9v8JyyTdWT1cJNwjQiQ5g=;
	b=gXC35fQAsNlJPd7dRdheJ4A3uHwOeN0OaXR/P3N0qmIJ4abjY9c9eXysEW0JE69Ex1dnfi
	zyTMmw14k4pBVk6IXZYexMY+9wz3a21sxKu39Kcl+ERByQRWosRTxOrCg7KW0Q+VTOS0dU
	i7jM1ijne1xDWm6fX5b2v9ycpw6rVV8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-ZeTETdOyP-GoaoS1_s5QLg-1; Thu,
 29 Aug 2024 06:40:31 -0400
X-MC-Unique: ZeTETdOyP-GoaoS1_s5QLg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33A581955D54;
	Thu, 29 Aug 2024 10:40:30 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E9301955BE3;
	Thu, 29 Aug 2024 10:40:25 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: thomas.lendacky@amd.com,
	dyoung@redhat.com,
	daniel.kiper@oracle.com,
	noodles@fb.com,
	lijiang@redhat.com,
	kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 1/2] x86/mm: rename the confusing local variable in early_memremap_is_setup_data()
Date: Thu, 29 Aug 2024 18:40:15 +0800
Message-ID: <20240829104016.84139-2-bhe@redhat.com>
In-Reply-To: <20240829104016.84139-1-bhe@redhat.com>
References: <20240829104016.84139-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_034035_627840_D6BA32E8 
X-CRM114-Status: GOOD (  11.78  )
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
