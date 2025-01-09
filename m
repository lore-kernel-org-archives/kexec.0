Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC8AE77197
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 07:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Z7mGlKvKy5SqZStSpEOrC66l/cJcotrJit7imygcRDE=; b=WXII9D27juEa8gqXQY0+JdC7K+
	T6UQ+b55MtDMBbLxHIGlfKRlZK1gEDkjk4v4yv29kJow3ABTDFbZfET69c9qczLtjPM8JhxGf21il
	ltTsvNAnotdqD2WPAtqR5mM8gdjvGuNfE6OjlEp+l2l1I4lI7mLoAwsi2CErbWHXRvxrb+2GiekLF
	l70KNcxN/DWKfItKwDHQgwMaKVuB3QCZcW4AgnBqDu8LxS3imrYfCducQAWHNEEkMQtrlkRNUGvds
	pH84SPQjd+XmOuih/vNErhxiVF2VwFfBktGUzlTr7SpMGOqF1FC6/Cm6LlsEfld1ZNOLZn26+wZri
	lq8ca79A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVnSA-0000000B7aa-3uJU;
	Thu, 09 Jan 2025 07:59:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVnS8-0000000B7aG-0fUM
	for kexec@lists.infradead.org;
	Thu, 09 Jan 2025 07:59:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736409579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z7mGlKvKy5SqZStSpEOrC66l/cJcotrJit7imygcRDE=;
	b=BOQKYZ8pRazoRlZZH7xMgzwqvJLr/UgNz/H2GvLZYxXRrqVYLZWth/XL8jO7q1E1PsMDqY
	T0m/ap32/lnmcTgigG9LAEsEeaQ6MjW4glM2vHC+KMyvSpnQfDRDALI27zdjv5OfwGT1Gw
	71329jsqxs+EPZ/ZNZIgxP1Vovy07PM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-u0WExUGLMe6RfrsA1kaCTw-1; Thu,
 09 Jan 2025 02:59:37 -0500
X-MC-Unique: u0WExUGLMe6RfrsA1kaCTw-1
X-Mimecast-MFC-AGG-ID: u0WExUGLMe6RfrsA1kaCTw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E65351954195
	for <kexec@lists.infradead.org>; Thu,  9 Jan 2025 07:59:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AB78030001BE;
	Thu,  9 Jan 2025 07:59:35 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: kexec@lists.infradead.org
Cc: snishika@redhat.com
Subject: [PATCH] Improve message readability and fix typos
Date: Thu,  9 Jan 2025 16:59:31 +0900
Message-ID: <20250109075931.6976-1-snishika@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K4JmSF7ZvT3XBBpnrsQKcE_q6MCTpP258Xd5vAWFes4_1736409577
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_235940_354139_FC8B252E 
X-CRM114-Status: GOOD (  12.34  )
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

This patch enhances the readability of several messages printed by
adding a space after a comma that is not followed by a newline. These
changes ensure that messages are easier to read and understand.

For example:
Before: "The kernel doesn't support mmap(),read() will be used instead."
After: "The kernel doesn't support mmap(), read() will be used instead."

Additionally, this patch fixes minor typos in the messages, further
improving clarity and correctness.

Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
---
 makedumpfile.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index bad3c48..2d3b08b 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4444,7 +4444,7 @@ initial(void)
 #endif
 
 	if (info->flag_exclude_xen_dom && !is_xen_memory()) {
-		MSG("'-X' option is disable,");
+		MSG("'-X' option is disabled, ");
 		MSG("because %s is not Xen's memory core image.\n", info->name_memory);
 		MSG("Commandline parameter is invalid.\n");
 		MSG("Try `makedumpfile --help' for more information.\n");
@@ -4527,7 +4527,7 @@ initial(void)
 
 	if (info->flag_refiltering) {
 		if (info->flag_elf_dumpfile) {
-			MSG("'-E' option is disable, ");
+			MSG("'-E' option is disabled, ");
 			MSG("because %s is kdump compressed format.\n",
 							info->name_memory);
 			return FALSE;
@@ -4541,7 +4541,7 @@ initial(void)
 
 	} else if (info->flag_sadump) {
 		if (info->flag_elf_dumpfile) {
-			MSG("'-E' option is disable, ");
+			MSG("'-E' option is disabled, ");
 			MSG("because %s is sadump %s format.\n",
 			    info->name_memory, sadump_format_type_name());
 			return FALSE;
@@ -4635,14 +4635,14 @@ out:
 
 	if (info->num_threads) {
 		if (is_xen_memory()) {
-			MSG("'--num-threads' option is disable,\n");
+			MSG("'--num-threads' option is disabled,\n");
 			MSG("because %s is Xen's memory core image.\n",
 							info->name_memory);
 			return FALSE;
 		}
 
 		if (info->flag_sadump) {
-			MSG("'--num-threads' option is disable,\n");
+			MSG("'--num-threads' option is disabled,\n");
 			MSG("because %s is sadump %s format.\n",
 			    info->name_memory, sadump_format_type_name());
 			return FALSE;
@@ -4721,7 +4721,7 @@ out:
 			DEBUG_MSG("mmap() is available on the kernel.\n");
 			info->flag_usemmap = MMAP_ENABLE;
 		} else {
-			DEBUG_MSG("The kernel doesn't support mmap(),");
+			DEBUG_MSG("The kernel doesn't support mmap(), ");
 			DEBUG_MSG("read() will be used instead.\n");
 			info->flag_usemmap = MMAP_DISABLE;
 		}
-- 
2.47.1


