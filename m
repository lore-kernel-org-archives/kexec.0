Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD2FC3ABBE
	for <kexec@archiver.kernel.org>; Thu,  8 May 2025 07:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NNm/GVsc/U/JM9udHFGbUagWNhhVtJjmOoQfrIgRWUM=; b=G2LKVtHlJtvzG/VRO1Cq1TqUTi
	ix6EAQo4tG8p3iUjpTWoIsihmWgeg1oUMhu2sUJ0ZcVLXpgR9aAAIhCMzHYGVUVOi0dU2zEYg/xkQ
	/Gxb8vD4v76SOQjsxdaiTGrDlEWU2Yz9TCHR+NSRn+JNj5721/pNkO5hDNxKWDZY2CX50EVBNjgJQ
	xpPno8FfulIaNJYT900aCIbtiLnif3R+prJJfTo4zClqybFPzBgbQ0SKxmQRHJPUvqGEp7l9uKob7
	BCtHN2H2YapZxXqWhUUWIV13zyOAsnpckqbtYlFEjxIQdiQJM7eMTsfokvs3tgRmQkCGoQXbUvie/
	9vLjwKDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCvsb-000000001cz-14QN;
	Thu, 08 May 2025 07:41:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCvqC-000000001Ho-1j6y
	for kexec@lists.infradead.org;
	Thu, 08 May 2025 07:38:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746689927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NNm/GVsc/U/JM9udHFGbUagWNhhVtJjmOoQfrIgRWUM=;
	b=U7LSgAnhJ9xWlB37spvXO17HuUoi5QzqfMQS1xEfoxkwawV9z2XIUgSo4sglQdoL5mEQe1
	tUKQNQZ7RwOK6XA277Q0dvkScUJdWPEiw965+40OCP9nAYLBLOG6FMiFLDNSO4SNW6D5LR
	MfC0h6N6oveHRp7vYAZ1GJ32F86uV54=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-6Xf9rjE3MSqDfkMdgcAf0Q-1; Thu,
 08 May 2025 03:38:45 -0400
X-MC-Unique: 6Xf9rjE3MSqDfkMdgcAf0Q-1
X-Mimecast-MFC-AGG-ID: 6Xf9rjE3MSqDfkMdgcAf0Q_1746689925
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C88D6195608A;
	Thu,  8 May 2025 07:38:44 +0000 (UTC)
Received: from localhost (unknown [10.72.112.8])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FDC21955F24;
	Thu,  8 May 2025 07:38:43 +0000 (UTC)
Date: Thu, 8 May 2025 15:38:38 +0800
From: Baoquan He <bhe@redhat.com>
To: fuqiang wang <fuqiang.wang@easystack.cn>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <aBxfflkkQXTetmbq@MiWiFi-R3L-srv>
References: <20240108130720.228478-1-fuqiang.wang@easystack.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108130720.228478-1-fuqiang.wang@easystack.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_003848_518965_93A79166 
X-CRM114-Status: GOOD (  17.43  )
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

In memmap_exclude_ranges(), elfheader will be excluded from crashk_res.
In the current x86 architecture code, the elfheader is always allocated
at crashk_res.start. It seems that there won't be a new split range.
But it depends on the allocation position of elfheader in crashk_res. To
avoid potential out of bounds in future, add a extra slot. And using
random kexec_buf for passing dm crypt keys may cause a range split too,
add another extra slot here.

The similar issue also exists in fill_up_crash_elf_data(). The range to
be excluded is [0, 1M], start (0) is special and will not appear in the
middle of existing cmem->ranges[]. But in cast the low 1M could be
changed in the future, add a extra slot too.

Previously discussed link:
[1] https://lore.kernel.org/kexec/ZXk2oBf%2FT1Ul6o0c@MiWiFi-R3L-srv/
[2] https://lore.kernel.org/kexec/273284e8-7680-4f5f-8065-c5d780987e59@easystack.cn/
[3] https://lore.kernel.org/kexec/ZYQ6O%2F57sHAPxTHm@MiWiFi-R3L-srv/

Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
v4->v5:
- This is on top of Coiby's LUKS patchset in branch mm-nonmm-unstable of
  akpm/mm.git. I did some adaption based on Coiby's patches.
- [PATCH v9 0/8] Support kdump with LUKS encryption by reusing LUKS volume keys

 arch/x86/kernel/crash.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index bcb534688dfe..749a60ce8b7f 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -165,8 +165,18 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 	/*
 	 * Exclusion of crash region and/or crashk_low_res may cause
 	 * another range split. So add extra two slots here.
+	 *
+	 * Exclusion of low 1M may not cause another range split, because the
+	 * range of exclude is [0, 1M] and the condition for splitting a new
+	 * region is that the start, end parameters are both in a certain
+	 * existing region in cmem and cannot be equal to existing region's
+	 * start or end. Obviously, the start of [0, 1M] cannot meet this
+	 * condition.
+	 *
+	 * But in order to lest the low 1M could be changed in the future,
+	 * (e.g. [stare, 1M]), add a extra slot.
 	 */
-	nr_ranges += 2;
+	nr_ranges += 3;
 	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
 	if (!cmem)
 		return NULL;
@@ -313,10 +323,15 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	struct crash_mem *cmem;
 
 	/*
-	 * Using random kexec_buf for passing dm crypt keys may cause a range
-	 * split. So use two slots here.
+	 * In the current x86 architecture code, the elfheader is always
+	 * allocated at crashk_res.start. But it depends on the allocation
+	 * position of elfheader in crashk_res. To avoid potential out of
+	 * bounds in future, add an extra slot.
+	 *
+	 * And using random kexec_buf for passing dm crypt keys may cause a
+	 * range split too, add another extra slot here.
 	 */
-	nr_ranges = 2;
+	nr_ranges = 3;
 	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
 	if (!cmem)
 		return -ENOMEM;
-- 
2.41.0


