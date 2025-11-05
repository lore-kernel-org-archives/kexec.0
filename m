Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F34CCFA0D
	for <kexec@archiver.kernel.org>; Wed,  5 Nov 2025 13:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ja9p+P+rNRRYeXFBvoi2wZobttmqe4trTxhUjdYX52E=; b=TEWHFEUNsSowcraQfDxj/cuIs5
	FdJhW5G0Ov6i7cGmypoI/RfP9/9p17urYNo67XehROpVM6SwwF+w40FPZyj/0FNhX2TIRJpVTBqyM
	sOEKUrD1zG3y9jIOV9uxgRCzS3hS72byoMfyR6+JUGrHE1Fnyt9iUfdpbweOFZNnJ8RRQWWaaB6B7
	EZ8yMi0lJD9b0onhcNA1HQR16V7KXG7dNHThrAd8edJzi+BE38P5+s1PJGSwGw4VCh61q97IUYMWI
	ftqywWOXnchGtOEXDGMtsWFtIIf8OHXrlm5K8ev78JQKe6j97eu87i1w2vBkwsGn5FEqwZGZxy+DD
	xEppz08w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGdGt-0000000DjlZ-2Sxn;
	Wed, 05 Nov 2025 13:09:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGdGr-0000000Djkf-1EuG
	for kexec@lists.infradead.org;
	Wed, 05 Nov 2025 13:09:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762348192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ja9p+P+rNRRYeXFBvoi2wZobttmqe4trTxhUjdYX52E=;
	b=eptM6BKlNfZZ1j9kqUWr3iL4az9dYGR9H+Xe2TiaI3MuQBBNWeX2Yp59IsZtfOsEIIohgg
	+/xpHKu4mNGy4J89rObpujmyU4K60LYfE+sw5sUBOUqhIzLbp5PvgXE7w+ZCtpG8ZUPbgr
	VZVv5yZEsVMX8VaBcYMhhJLdtPyFVx8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-NUMzGBzsPma595Rz1981wQ-1; Wed,
 05 Nov 2025 08:09:48 -0500
X-MC-Unique: NUMzGBzsPma595Rz1981wQ-1
X-Mimecast-MFC-AGG-ID: NUMzGBzsPma595Rz1981wQ_1762348187
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47795195606B;
	Wed,  5 Nov 2025 13:09:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.93])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 059D83000198;
	Wed,  5 Nov 2025 13:09:40 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>
Subject: [PATCH 2/2] kernel/kexec: Fix IMA when allocation happens in CMA area
Date: Wed,  5 Nov 2025 21:09:22 +0800
Message-ID: <20251105130922.13321-2-piliu@redhat.com>
In-Reply-To: <20251105130922.13321-1-piliu@redhat.com>
References: <20251105130922.13321-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_050953_406194_14FE2ADE 
X-CRM114-Status: GOOD (  13.66  )
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

This is caused by the fact that kexec allocates the destination directly
in the CMA area. In that case, the CMA kernel address should be exported
directly to the IMA component, instead of using the vmalloc'd address.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Steven Chen <chenste@linux.microsoft.com>
Cc: linux-integrity@vger.kernel.org
To: kexec@lists.infradead.org
---
 kernel/kexec_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 9a1966207041..abe40286a02c 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -967,6 +967,7 @@ void *kimage_map_segment(struct kimage *image, int idx)
 	kimage_entry_t *ptr, entry;
 	struct page **src_pages;
 	unsigned int npages;
+	struct page *cma;
 	void *vaddr = NULL;
 	int i;
 
@@ -974,6 +975,9 @@ void *kimage_map_segment(struct kimage *image, int idx)
 	size = image->segment[idx].memsz;
 	eaddr = addr + size;
 
+	cma = image->segment_cma[idx];
+	if (cma)
+		return cma;
 	/*
 	 * Collect the source pages and map them in a contiguous VA range.
 	 */
@@ -1014,7 +1018,8 @@ void *kimage_map_segment(struct kimage *image, int idx)
 
 void kimage_unmap_segment(void *segment_buffer)
 {
-	vunmap(segment_buffer);
+	if (is_vmalloc_addr(segment_buffer))
+		vunmap(segment_buffer);
 }
 
 struct kexec_load_limit {
-- 
2.49.0


