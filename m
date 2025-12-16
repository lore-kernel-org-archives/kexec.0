Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230FCD5C0C0
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 01:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=POhLhNZ1zpDkvx5NFMn6+BIeJbKdzRv0ACR1cbx1arw=; b=TH5LiU1Dlo9p6xE4HuK4JRUIly
	7mWaSRw+mv3tZVnHTm8gHjMI39pc1ifbFM9wrbryGJP6i1kmHxYuU7t97F6XfIE8qgdwi8VKragcf
	mqMDDUAMsKbU1I54YGy/lhsSTHwYa/d5gFLpvKgyOx6DcAITH83rL6znJV2bRIlB80aMMwI5eFdM3
	siSMzJPImlIkhuSfcMmanK/1KZe5pwptKjFbUHVMIak7oHpVfaHKhx7Ribd6EDP/EBAv9LJDc4VoK
	k2Ur1yCCISo4+QAtv2MEStnPHASrTR3LWLa1EgtKRZZbg1RXKCl00LqtM6e1YwL4XJU/+mmqkm6Qs
	Qtug2HDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVKBz-00000004W4h-1rws;
	Tue, 16 Dec 2025 01:49:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVKBx-00000004W3d-2tK0
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 01:49:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765849772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POhLhNZ1zpDkvx5NFMn6+BIeJbKdzRv0ACR1cbx1arw=;
	b=DQRlnwBKRqZKt3TMzKU6lVCfp+lX2IC6f6H7DQxDx6x28x2wgg6z+PFJuM7vW3BkHU3x2O
	xgJqjADByy5L20w4iLBgSm1BD/GN3Eob1y2dvg7kATYgBvDScWbrCWNar7V1cEDf7gM1EU
	oAC/BfXdvSlrJsKzZn97KrYh7YBFVVI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-OpxS92fXM3yIi2XPyRk4Kg-1; Mon,
 15 Dec 2025 20:49:27 -0500
X-MC-Unique: OpxS92fXM3yIi2XPyRk4Kg-1
X-Mimecast-MFC-AGG-ID: OpxS92fXM3yIi2XPyRk4Kg_1765849766
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C0A31956094;
	Tue, 16 Dec 2025 01:49:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.35])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D4C9180035A;
	Tue, 16 Dec 2025 01:49:19 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv3 2/2] kernel/kexec: Fix IMA when allocation happens in CMA area
Date: Tue, 16 Dec 2025 09:48:52 +0800
Message-ID: <20251216014852.8737-2-piliu@redhat.com>
In-Reply-To: <20251216014852.8737-1-piliu@redhat.com>
References: <20251216014852.8737-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_174933_800495_4936314B 
X-CRM114-Status: GOOD (  16.46  )
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

*** Bug description ***

When I tested kexec with the latest kernel, I ran into the following warning:

[   40.712410] ------------[ cut here ]------------
[   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 kimage_map_segment+0x144/0x198
[...]
[   40.816047] Call trace:
[   40.818498]  kimage_map_segment+0x144/0x198 (P)
[   40.823221]  ima_kexec_post_load+0x58/0xc0
[   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
[...]
[   40.855423] ---[ end trace 0000000000000000 ]---

*** How to reproduce ***

This bug is only triggered when the kexec target address is allocated in
the CMA area. If no CMA area is reserved in the kernel, use the "cma="
option in the kernel command line to reserve one.

*** Root cause ***
The commit 07d24902977e ("kexec: enable CMA based contiguous
allocation") allocates the kexec target address directly on the CMA area
to avoid copying during the jump. In this case, there is no IND_SOURCE
for the kexec segment.  But the current implementation of
kimage_map_segment() assumes that IND_SOURCE pages exist and map them
into a contiguous virtual address by vmap().

*** Solution ***
If IMA segment is allocated in the CMA area, use its page_address()
directly.

Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Steven Chen <chenste@linux.microsoft.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: <stable@vger.kernel.org>
To: kexec@lists.infradead.org
---
v2 -> v3
  improve commit log

 kernel/kexec_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 1a79c5b18d8f..95c585c6ddc3 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -960,13 +960,17 @@ void *kimage_map_segment(struct kimage *image, int idx)
 	kimage_entry_t *ptr, entry;
 	struct page **src_pages;
 	unsigned int npages;
+	struct page *cma;
 	void *vaddr = NULL;
 	int i;
 
+	cma = image->segment_cma[idx];
+	if (cma)
+		return page_address(cma);
+
 	addr = image->segment[idx].mem;
 	size = image->segment[idx].memsz;
 	eaddr = addr + size;
-
 	/*
 	 * Collect the source pages and map them in a contiguous VA range.
 	 */
@@ -1007,7 +1011,8 @@ void *kimage_map_segment(struct kimage *image, int idx)
 
 void kimage_unmap_segment(void *segment_buffer)
 {
-	vunmap(segment_buffer);
+	if (is_vmalloc_addr(segment_buffer))
+		vunmap(segment_buffer);
 }
 
 struct kexec_load_limit {
-- 
2.49.0


