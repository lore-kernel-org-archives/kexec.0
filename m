Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AB6076D8B
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MNSTv9NI;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k/uyqCwE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3Pjs45S57+QYe3zCfvXOSLki7qU0AqGmneDsSzoE048=; b=MNSTv9NIKWFp3vxrwy+DhRntx5
	NG2aC3mQuF0lZmFiZb3KNww3yfcIJ6DCMj5remslvRf32QpEb28eAtc6sH0Hecc3/9+x8lXJvl3na
	HkVnQnZbVhhBVvUonn0UgEArKdab+Fu/UUIlftEvv5QpFXIREe+YVfnxPZIkclHz6SwjKTBG+KL7a
	6nGyHvlqThYN980p8E84Y5S5/HUie7D5KI/Vsdm4fW4IaYNa31yhaVBGVEEdNwIUiPn6V9ByUnAKC
	5l7WzXCOcKf/ZMdCijULknXR8CTUm60x0Qs5eq5uuqQMl3lAneKuD+zGGJdQSjAi/2BmS03T0gZaS
	U/+lME1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNuDp-0000000HC4W-0qES;
	Mon, 02 Nov 2026 15:45:21 +0000
Received: from mail-pf1-x448.google.com ([2607:f8b0:4864:20::448])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNuDm-0000000HC42-3bEl
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:45:20 +0000
Received: by mail-pf1-x448.google.com with SMTP id d2e1a72fcca58-89f9fdbabe1so4398727b3a.1
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793634317; x=1794239117; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Pjs45S57+QYe3zCfvXOSLki7qU0AqGmneDsSzoE048=;
        b=k/uyqCwE49REa0UBCStFxHQceyRXo1lfeQCVoGkvSVNk8iIYE6HQM/T3UAc63a2nFM
         L3054b09XNh1F+onHvgkcyrNNvge2IqB2F5q30hjSjhF2v7slzd4McntHZwenm4fu+cs
         pKF5jvpHYoj91fyTX6p+1VSVb0nLYMgBuhtqLtvlUYSKLFM+HHs5JZqcDDzoMA4YbqAQ
         3uJyi2JLztkP7Gnj84rlkEvocKtdaYJfztvAOo739nOwi8X6JxCK3jVxJnY7ozZDUCDI
         jgWcuqZLrCHTGRHvWuMiLJ5r/mh/pxlfPiG3PXqnSTUKkuEMX9v8w2Rv35wDP3CcOhmx
         uGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634317; x=1794239117;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Pjs45S57+QYe3zCfvXOSLki7qU0AqGmneDsSzoE048=;
        b=WtkCjLV7wWoZ0UddrWmg8PDK+HV538qhp5GHL0EksC0Z/qhERshmqrgshJfqI3lQHh
         YG/LOgYuKHgz91AG4DwdgLbVIajGc326XbBViTFJBziznIeuImhqi9p438NTP/Fyy98S
         3jDC2YpxwWIBulHXjRTrLnLhxyj8BIL+s1QhlgevidzQX/Rr7W1hANaQH5Gwa/oD8Y4a
         rmYbUwhVYH+GqtWp2GFyij8e9bZ5eJT0NI2IPw93bZNkmq3ahJM0PrYpz/XGlFVvcUmH
         NEagD08Z6PPC+jx2h0qbdDIC4NQB1MsS89muULJ8gxva2WrtHragVOwslkeLikfNJIOW
         VAQw==
X-Gm-Message-State: AFq9FYIcQ6Q2JnL3k9IdZATv7kWv94ZPqnAvVwJbGUHw7VqtJ1h7FRT5
	wbJKu+6OWinRktETE7cqlkvQmEm4cnH2iL8SDkfRdipHDdgAkN60zX2cVR7J/RDuZ/ncv0ReaOb
	E9KJg3s0bocgZ8iGurIXj0oKqE8b7+s1KoOkByIOacJlbdsRNSAw8/iyedjqUvxTdacjdiDeGuu
	jSuSsnhUC070PjwmkF8gMrsX1EPUitQUqPpoPiliIxdpT/lg==
X-Received: from pgia4.prod.google.com ([2002:a63:e404:0:b0:cc7:865b:2dc5])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4cc1:b0:3e2:778e:3cdd
 with SMTP id adf61e73a8af0-3e9289abb68mr8817317637.37.1793633842371; Mon, 02
 Nov 2026 07:37:22 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:50 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-22-vipinsh@google.com>
Subject: [PATCH v6 21/27] vfio: selftests: Add helpers to map DMA memory at
 IOVA == PA in noiommu mode
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_074518_906150_B39B1AA7 
X-CRM114-Status: GOOD (  18.10  )
X-Spam-Score: -9.5 (---------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Selftest drivers program the IOVA returned by to_iova() into the device.
Because a device in noiommu mode uses those addresses directly as
physical addresses, DMA buffers must be mapped at IOVA == PA so that
to_iova() returns the buffer's physical address without changing the
drivers.

Add __iommu_noiommu_get_pa() to wrap IOMMU_IOAS_NOIOMMU_GET_PA and
iommu_map_identity() to map a physically contiguous buffer at IOVA == PA
by first pinning it at a scratch IOVA (BIT_ULL(52), above the 52-bit
output address space of the noiommu page table), querying its physical
address and contiguity, mapping it at IOVA == PA, and then unmapping the
scratch range while keeping the pages pinned.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          | 26 ++++++++
 tools/testing/selftests/vfio/lib/iommu.c      | 61 +++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e652b8caf5bb..d449813f9bc4 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -65,6 +65,32 @@ static inline void iommu_unmap_all(struct iommu *iommu)
 int __iommu_hva2iova(struct iommu *iommu, void *vaddr, iova_t *iova);
 iova_t iommu_hva2iova(struct iommu *iommu, void *vaddr);
 
+/*
+ * Look up the physical address @iova maps to in the noiommu IOAS of @iommu
+ * (IOMMU_IOAS_NOIOMMU_GET_PA, requires CAP_SYS_RAWIO). On success, *@length is
+ * the number of physically contiguous bytes from *@pa, at most @max_length.
+ */
+int __iommu_noiommu_get_pa(struct iommu *iommu, iova_t iova, u64 max_length,
+			   u64 *pa, u64 *length);
+
+/*
+ * Map @region->size bytes at @region->vaddr at IOVA == PA, and set
+ * @region->iova to that PA. Devices in noiommu mode use the addresses that
+ * drivers program into them, i.e. to_iova(), as physical addresses, which such
+ * a mapping makes right.
+ *
+ * The buffer must be physically contiguous (e.g. a hugepage or a THP), and a
+ * noiommu device must be attached to @iommu already. The memory stays pinned,
+ * and so at the same physical address, until iommu_unmap(@region), which must
+ * not be called before the device stopped accessing it.
+ */
+int __iommu_map_identity(struct iommu *iommu, struct dma_region *region);
+
+static inline void iommu_map_identity(struct iommu *iommu, struct dma_region *region)
+{
+	VFIO_ASSERT_EQ(__iommu_map_identity(iommu, region), 0);
+}
+
 struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges);
 
 #define MODE_VFIO_TYPE1_IOMMU "vfio_type1_iommu"
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 0df49646d016..46e9635cbfc5 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -11,6 +11,7 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 
+#include <linux/bits.h>
 #include <linux/limits.h>
 #include <linux/mman.h>
 #include <linux/types.h>
@@ -244,6 +245,66 @@ int __iommu_unmap_all(struct iommu *iommu, u64 *unmapped)
 	return 0;
 }
 
+/*
+ * The noiommu IOAS page table translates to physical addresses of at most 52
+ * bits (drivers/iommu/iommufd/hwpt_noiommu.c), so a mapping at or above this
+ * IOVA never overlaps one at IOVA == PA.
+ */
+#define NOIOMMU_SCRATCH_IOVA	BIT_ULL(52)
+
+int __iommu_noiommu_get_pa(struct iommu *iommu, iova_t iova, u64 max_length,
+			   u64 *pa, u64 *length)
+{
+	struct iommu_ioas_noiommu_get_pa args = {
+		.size = sizeof(args),
+		.ioas_id = iommu->ioas_id,
+		.iova = iova,
+		.length = max_length,
+	};
+
+	if (!iommu->iommufd || !iommu->mode->noiommu)
+		return -EOPNOTSUPP;
+
+	if (ioctl(iommu->iommufd, IOMMU_IOAS_NOIOMMU_GET_PA, &args))
+		return -errno;
+
+	*pa = args.out_phys;
+	*length = args.length;
+	return 0;
+}
+
+int __iommu_map_identity(struct iommu *iommu, struct dma_region *region)
+{
+	struct dma_region scratch = {
+		.vaddr = region->vaddr,
+		.iova = NOIOMMU_SCRATCH_IOVA,
+		.size = region->size,
+	};
+	u64 pa, length;
+	int ret;
+
+	/* Pin the buffer with a scratch mapping to look up its physical address. */
+	ret = __iommu_map(iommu, &scratch);
+	if (ret)
+		return ret;
+
+	ret = __iommu_noiommu_get_pa(iommu, scratch.iova, scratch.size, &pa, &length);
+	if (!ret && length != region->size)
+		ret = -EINVAL;	/* Not physically contiguous. */
+
+	/*
+	 * Map it at IOVA == PA before dropping the scratch mapping, so that it
+	 * stays pinned, and hence at the same physical address, throughout.
+	 */
+	if (!ret) {
+		region->iova = pa;
+		ret = __iommu_map(iommu, region);
+	}
+
+	VFIO_ASSERT_EQ(__iommu_unmap(iommu, &scratch, NULL), 0);
+	return ret;
+}
+
 static struct vfio_info_cap_header *next_cap_hdr(void *buf, u32 bufsz,
 						 u32 *cap_offset)
 {
-- 
2.56.0.317.g454f8302e1-goog


