Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF63C07E9D
	for <kexec@archiver.kernel.org>; Thu, 29 Sep 2022 04:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4TEdyCOB3S0mJxGlKnynRqmHFle3RUePQfHKrJMULwM=; b=M4Iy9GkBI9TZWw
	AQMb2FaJFY5DT7zCHY3/zCdE16Q5Y3jrC9la1uCkEmtFMENPQCmeNdLD2PDP//TC1m6fI5lOozmNX
	pHJcpmo8KfhdKARbDCrLPmoK2uj8dITu7JOFbwC+6mOiL16SJo6Z5rOjf7l9nG3EiYmfvxaeEsMTg
	zpjCPLPEUnqQOZZGWJozTFX602gy2El1PFBT10YiLE3TtUOLNNHd8S5CUeERlNZmaYDIrW+w7s/mO
	m5t4Sbe/GPbnI6Ckzte5j5SLimM01YDwNvsAXY2dm8g2TttWSndGjB/ewd9TjMEsPAmlBL1rxkuHu
	Y0AHD/amtgQHBCBfVm6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odlBZ-001A1b-8W; Thu, 29 Sep 2022 04:30:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odlBW-0019zt-Hx
	for kexec@lists.infradead.org; Thu, 29 Sep 2022 04:30:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664425805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3zu4RR04ENxJtg3w+s7/WFqAJY9gBd1dDL8X/mjPqo=;
	b=KHZbCfQpeX0u76m/HKRCHsAce9NdQvvQEmJnSg6BESD9Q86VCtdOkozbyLk4sy0krhnPqM
	yGi+Y8v3n2vsjFReQxPJWpkOjuM+9QhoKI8w7RcqoNeu9/Loyt7L8vMXRf8i3iCgWX/nyQ
	TpZ4gDn+4VufS5ptC2UETbfAe9tb6Zo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-BqgYVAqEO_yRGEcJvLwwTw-1; Thu, 29 Sep 2022 00:30:01 -0400
X-MC-Unique: BqgYVAqEO_yRGEcJvLwwTw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AF9D800B30;
	Thu, 29 Sep 2022 04:30:01 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-179.pek2.redhat.com [10.72.13.179])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A16807AE5;
	Thu, 29 Sep 2022 04:29:53 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: kexec@lists.infradead.org,
	ebiederm@xmission.com,
	Li Chen <lchen@ambarella.com>,
	Baoquan He <bhe@redhat.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH RESEND 3/4] kexec: replace crash_mem_range with range
Date: Thu, 29 Sep 2022 12:29:35 +0800
Message-Id: <20220929042936.22012-4-bhe@redhat.com>
In-Reply-To: <20220929042936.22012-1-bhe@redhat.com>
References: <20220929042936.22012-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_213006_690338_F9B6A52C 
X-CRM114-Status: GOOD (  18.74  )
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

From: Li Chen <lchen@ambarella.com>

We already have struct range, so just use it.

Signed-off-by: Li Chen <lchen@ambarella.com>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
Baoquan:
  - Rebased to the latest linus's master branch, fix the conflict
    in include/linux/kexec.h.
  - Test passed on ibm-p9wr ppc64le system.

 arch/powerpc/kexec/file_load_64.c | 2 +-
 arch/powerpc/kexec/ranges.c       | 8 ++++----
 include/linux/kexec.h             | 7 ++-----
 kernel/kexec_file.c               | 2 +-
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 349a781cea0b..60e12b716d3c 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -35,7 +35,7 @@ struct umem_info {
 
 	/* usable memory ranges to look up */
 	unsigned int nr_ranges;
-	const struct crash_mem_range *ranges;
+	const struct range *ranges;
 };
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
index 563e9989a5bf..5fc53a5fcfdf 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -33,7 +33,7 @@
 static inline unsigned int get_max_nr_ranges(size_t size)
 {
 	return ((size - sizeof(struct crash_mem)) /
-		sizeof(struct crash_mem_range));
+		sizeof(struct range));
 }
 
 /**
@@ -51,7 +51,7 @@ static inline size_t get_mem_rngs_size(struct crash_mem *mem_rngs)
 		return 0;
 
 	size = (sizeof(struct crash_mem) +
-		(mem_rngs->max_nr_ranges * sizeof(struct crash_mem_range)));
+		(mem_rngs->max_nr_ranges * sizeof(struct range)));
 
 	/*
 	 * Memory is allocated in size multiple of MEM_RANGE_CHUNK_SZ.
@@ -98,7 +98,7 @@ static int __add_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size)
  */
 static void __merge_memory_ranges(struct crash_mem *mem_rngs)
 {
-	struct crash_mem_range *ranges;
+	struct range *ranges;
 	int i, idx;
 
 	if (!mem_rngs)
@@ -123,7 +123,7 @@ static void __merge_memory_ranges(struct crash_mem *mem_rngs)
 /* cmp_func_t callback to sort ranges with sort() */
 static int rngcmp(const void *_x, const void *_y)
 {
-	const struct crash_mem_range *x = _x, *y = _y;
+	const struct range *x = _x, *y = _y;
 
 	if (x->start > y->start)
 		return 1;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 13e6c4b58f07..b900311b4f87 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -17,6 +17,7 @@
 
 #include <linux/crash_core.h>
 #include <asm/io.h>
+#include <linux/range.h>
 
 #include <uapi/linux/kexec.h>
 #include <linux/verification.h>
@@ -240,14 +241,10 @@ static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
 
-struct crash_mem_range {
-	u64 start, end;
-};
-
 struct crash_mem {
 	unsigned int max_nr_ranges;
 	unsigned int nr_ranges;
-	struct crash_mem_range ranges[];
+	struct range ranges[];
 };
 
 extern int crash_exclude_mem_range(struct crash_mem *mem,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 1d546dc97c50..22df37ca5143 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1141,7 +1141,7 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 {
 	int i, j;
 	unsigned long long start, end, p_start, p_end;
-	struct crash_mem_range temp_range = {0, 0};
+	struct range temp_range = {0, 0};
 
 	for (i = 0; i < mem->nr_ranges; i++) {
 		start = mem->ranges[i].start;
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
