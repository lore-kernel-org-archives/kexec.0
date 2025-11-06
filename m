Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC218CCF9F8
	for <kexec@archiver.kernel.org>; Thu,  6 Nov 2025 06:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KwdNpOvtsiXt+ezNTA0UnZOYLLrXgYjUy+Ne1I6lHsM=; b=XD207eKsCdewDBCH6Alqff+15+
	kTlEUxxGy4jTse0xDlyRe8+/OKEDGcjJ0NR6ed7nVVmnOSXhmywNU1+ZscLnTrjrwbGx5P0Hp4AxS
	hXgmDIccAxww1h/hsUgZ5Yh+VWIRoyjHD/nzjfCGngeq//+mp9g4+LFXmIU1j60ciAaTsajCk008F
	i4n1OmVlX5JoCaSSuixTFcjZVKjORtIKnH6EQMj7y9jC7TWZaWoNfjjxaNvVvAQ3ebiy49dCdJFFM
	+n/rm8BJ35BY8SWRxlN2VXjn4Ha1Nq6LETDAX8Hmo9yTIXif6emhjpX/lIMX8q1hoQXB/Ne3h7Bkw
	Mw/sAIrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGty4-0000000EyOV-0A3k;
	Thu, 06 Nov 2025 06:59:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGty1-0000000EyNw-39AI
	for kexec@lists.infradead.org;
	Thu, 06 Nov 2025 06:59:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762412372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwdNpOvtsiXt+ezNTA0UnZOYLLrXgYjUy+Ne1I6lHsM=;
	b=YmWHB8vWxrsWOQOUR2CaTf2PNi3T7WMgg3dt54x5Qzb12LYYLx3B7KHPmyz2o4s/aqgBgN
	K1Xe58cqVkrjTOfomcFB2sedvYE1MqOV4OC0MG+E17zA34HmZiETWIVgUWfUj97oyWFLWa
	eHmN/xRRnuoo+v4/Se2msQ51rqZjYuc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-f66wrs0gMZusn4zH_o5rYQ-1; Thu,
 06 Nov 2025 01:59:29 -0500
X-MC-Unique: f66wrs0gMZusn4zH_o5rYQ-1
X-Mimecast-MFC-AGG-ID: f66wrs0gMZusn4zH_o5rYQ_1762412367
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABC621956089;
	Thu,  6 Nov 2025 06:59:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14F201945110;
	Thu,  6 Nov 2025 06:59:21 +0000 (UTC)
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
	stable@vger.kernel.org
Subject: [PATCHv2 2/2] kernel/kexec: Fix IMA when allocation happens in CMA area
Date: Thu,  6 Nov 2025 14:59:04 +0800
Message-ID: <20251106065904.10772-2-piliu@redhat.com>
In-Reply-To: <20251106065904.10772-1-piliu@redhat.com>
References: <20251106065904.10772-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_225933_860004_86F93313 
X-CRM114-Status: GOOD (  13.99  )
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

Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Steven Chen <chenste@linux.microsoft.com>
Cc: linux-integrity@vger.kernel.org
Cc: <stable@vger.kernel.org>
To: kexec@lists.infradead.org
---
v1 -> v2:
return page_address(page) instead of *page

 kernel/kexec_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 9a1966207041..332204204e53 100644
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
+		return page_address(cma);
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


