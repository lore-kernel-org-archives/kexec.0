Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1733D116FB
	for <kexec@archiver.kernel.org>; Fri, 25 Oct 2024 15:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yure1T8e33YVHWaql0hBe2Bp+Qqd3wfjoNkwh2PhFBU=; b=jtSZ14v+s6YiXg
	Ltba+zIyCDg8AnMYVWA7DkYqfOTPknE3FrG15P4AFHMGUSCkwSghjMoopgmm4XIWr1PThQmejeL0/
	TTKTn6/XLCi2nLwsY/QMUu2LhBjETgRDgNNIhbFhLEvKcv/RWVcAPk8HO4Oaq1ihQl4au/iC/lvhl
	lydBxvZj7F7pE8XtwZ/GXTRFmFVszNYu4VsYIrLSfeKNCcd9a/ny0XfYiqoBp3gXzuoKG0alZr15H
	VzChZYT5d0Nq4zqcPhtvaJUBZQ4F7uwbW2v/Xki4DQ5Ki0wUhLdDRWhSrpUzXY7r0ykp4cmPrjho+
	wMH6eXwOfezQXWt+Xlow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MLT-00000004GRh-1B3G;
	Fri, 25 Oct 2024 15:35:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4LzP-00000004Asq-1sbn
	for kexec@lists.infradead.org;
	Fri, 25 Oct 2024 15:12:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729869154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UerumhmGRgSm1AsU/ieQ+gWT/mqI7oI1n5V7Kl7Bfao=;
	b=HCYGFgfCMHNSarehRCaSP7uVM+vkNMk5LydC2a67LZ8gNqc6Tn6IhzixzzeReS9SITamTS
	Pz2K9BWn/utDdQgZGRHekthwHuXu9GSfNFq4S1nHdYlpa0RJBQ1t1m1ZP5hkYkzoCXr/tZ
	QG7PXvXAwI1rQGLpaAdvwdc7xQ8s1a4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-8XrGVJi3OyGjKDZHuJgcSw-1; Fri,
 25 Oct 2024 11:12:30 -0400
X-MC-Unique: 8XrGVJi3OyGjKDZHuJgcSw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98ACF1955E70;
	Fri, 25 Oct 2024 15:12:27 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.65.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 006CD30001A9;
	Fri, 25 Oct 2024 15:12:19 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 05/11] fs/proc/vmcore: factor out allocating a vmcore memory node
Date: Fri, 25 Oct 2024 17:11:27 +0200
Message-ID: <20241025151134.1275575-6-david@redhat.com>
In-Reply-To: <20241025151134.1275575-1-david@redhat.com>
References: <20241025151134.1275575-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_081235_585746_1B15DA85 
X-CRM114-Status: GOOD (  15.24  )
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

Let's factor it out into include/linux/crash_dump.h, from where we can
use it also outside of vmcore.c later.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c           | 21 ++-------------------
 include/linux/crash_dump.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 47652df95202..76fdc3fb8c0e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -683,11 +683,6 @@ static const struct proc_ops vmcore_proc_ops = {
 	.proc_mmap	= mmap_vmcore,
 };
 
-static struct vmcore_mem_node * __init get_new_element(void)
-{
-	return kzalloc(sizeof(struct vmcore_mem_node), GFP_KERNEL);
-}
-
 static u64 get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
 			   struct list_head *vc_list)
 {
@@ -1090,7 +1085,6 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 						size_t elfnotes_sz,
 						struct list_head *vc_list)
 {
-	struct vmcore_mem_node *new;
 	int i;
 	Elf64_Ehdr *ehdr_ptr;
 	Elf64_Phdr *phdr_ptr;
@@ -1113,13 +1107,8 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 		end = roundup(paddr + phdr_ptr->p_memsz, PAGE_SIZE);
 		size = end - start;
 
-		/* Add this contiguous chunk of memory to vmcore list.*/
-		new = get_new_element();
-		if (!new)
+		if (vmcore_alloc_add_mem_node(vc_list, start, size))
 			return -ENOMEM;
-		new->paddr = start;
-		new->size = size;
-		list_add_tail(&new->list, vc_list);
 
 		/* Update the program header offset. */
 		phdr_ptr->p_offset = vmcore_off + (paddr - start);
@@ -1133,7 +1122,6 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 						size_t elfnotes_sz,
 						struct list_head *vc_list)
 {
-	struct vmcore_mem_node *new;
 	int i;
 	Elf32_Ehdr *ehdr_ptr;
 	Elf32_Phdr *phdr_ptr;
@@ -1156,13 +1144,8 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 		end = roundup(paddr + phdr_ptr->p_memsz, PAGE_SIZE);
 		size = end - start;
 
-		/* Add this contiguous chunk of memory to vmcore list.*/
-		new = get_new_element();
-		if (!new)
+		if (vmcore_alloc_add_mem_node(vc_list, start, size))
 			return -ENOMEM;
-		new->paddr = start;
-		new->size = size;
-		list_add_tail(&new->list, vc_list);
 
 		/* Update the program header offset */
 		phdr_ptr->p_offset = vmcore_off + (paddr - start);
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 5e48ab12c12b..ae77049fc023 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -121,6 +121,20 @@ struct vmcore_mem_node {
 	loff_t offset;
 };
 
+/* Allocate a vmcore memory node and add it to the list. */
+static inline int vmcore_alloc_add_mem_node(struct list_head *list,
+		unsigned long long paddr, unsigned long long size)
+{
+	struct vmcore_mem_node *m = kzalloc(sizeof(*m), GFP_KERNEL);
+
+	if (!m)
+		return -ENOMEM;
+	m->paddr = paddr;
+	m->size = size;
+	list_add_tail(&m->list, list);
+	return 0;
+}
+
 #else /* !CONFIG_CRASH_DUMP */
 static inline bool is_kdump_kernel(void) { return false; }
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.46.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
