Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA4B606A32C
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kfn7MGJY;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EhRKqCGH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9juNA68D1pfuFQpRVNDQa7dR4Pnf/xhC+K8NWgBMU/E=; b=kfn7MGJYj6zqccYZnIpgOHKF9r
	4586PEQboZohK8qjXTLyP04JpkantrTUmygb+BKMjoPqdaEFcwNEIQ73IH7X2nmDAYFrg6cqkF2om
	yODgZiyoBeHCtHd7DLmsIh3aW9MqzRWdks2Iv1wBmrUxnDAYKS2AMNpwlv8nP/5zpHQd+hGFn1/3M
	3knuVtYyGN67CgkmNpsjei8DzePJNpGd37kn+kep+G6OAtOtstV9bHd0sLOdrwaxj4COY/M7DjJqo
	5qOII5Xp9VdyuVZO7xXDHaXVGG4dUODry00pgtXAnz6BSqIYawvn/JvH6ee/TSv8uiZSrPssg2yZO
	aJgBAnXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNuD5-0000000HBwV-0LBq;
	Mon, 02 Nov 2026 15:44:35 +0000
Received: from mail-pl1-x646.google.com ([2607:f8b0:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNuD2-0000000HBvW-3YK1
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:44:33 +0000
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2e832c03576so48383495ad.1
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793634269; x=1794239069; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9juNA68D1pfuFQpRVNDQa7dR4Pnf/xhC+K8NWgBMU/E=;
        b=EhRKqCGHW0w9Km9nMLmu+XyghZYnJNLjLQIySgr7HDwDaGbIodibzpSQKBMGoFj7z9
         UGtNLWdyXZ+dCiC6/E4FStiyZPqHppD5QmKgloOM+bq97szxeJyD01lviCIgSPuVCkPd
         G1aZWZ3AwpoSZ8YuMD40/9wjFnHtNrsGK+KoJ8ugxQ9uu0/TT0zxE+1wnjPxHBnj/WGL
         QFWaoBEGpnRskaZewB2UQl3spJJg20/eKglIaDeo5Maeyhn3igvbbNz9hqbZrxCL0HT0
         uv0B9/PTlM63L6h4WFh/Ezdst5OFiSAKTQl5ulx0eEISD3FSKF6nBcFsWBXq8xpjFj3y
         UK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634269; x=1794239069;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9juNA68D1pfuFQpRVNDQa7dR4Pnf/xhC+K8NWgBMU/E=;
        b=1/SvMSn/vtRACoCTORszwKKp2YhmWCCUNCL9ZzUCq+Xtndoc6v2ZvZ17dWLcQhGQ8J
         AtOxr3UGKVZt/f9mPhW8SQRoGhuCu0b/yghpbFbiQe/DS9Ztms3pI5U6kvSBX/gVuxsY
         mvRIKuhqK1Mi2QTksxJhaMjUdkaoNY9SFNJULNTc1Q9dNLf7/mrDV4Zq4q3HOCNuRCi1
         1yddK0kQKx3SabD3rrBceiTKwuPiibEP9Ir4S7sAjt8kaYmXopk9GUKOSQLKdAzsjyom
         kRFcs60S8KrbHEescAV/6k1yTib0tEaPxwcTdYQGpnfQC7kIMweiYtvyFBncgsGmOJH3
         SJoA==
X-Gm-Message-State: APuU4Z+ibVqOlgBqU08oIDkm87ugUGbe3UuYk3roWShxp7rdMO9SqPME
	DOlA96IUb9ZW+29kYMaLFS97XlGjKjEIO7q4yQhD7xedpTVbixoWmbQrOvPHGx+tr79RimHdcET
	SS33+ITXNG98FH1ZZn1tQak4QqToslPFcCtuLV0mZjkQIK1deeWdG6G2WRyo0Q892itscFYm3+y
	TUH8qCcq+iss9bIl9NTxhmtkJW0uKTet4BiJLTdSiUsExNpA==
X-Received: from plkz4.prod.google.com ([2002:a17:902:7084:b0:2eb:4f47:5748])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f642:b0:2e9:5772:9ab2
 with SMTP id d9443c01a7336-2eb364ec93fmr97906535ad.41.1793633843417; Mon, 02
 Nov 2026 07:37:23 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:51 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-23-vipinsh@google.com>
Subject: [PATCH v6 22/27] vfio: selftests: Add helpers for Live Update DMA
 memory and sysfs state
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
X-CRM114-CacheID: sfid-20261102_074432_928423_DBA4CDB1 
X-CRM114-Status: GOOD (  14.76  )
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

Add shared libvfio helpers used by the Live Update kexec selftest:

 - vfio_thp_memfd_alloc() and vfio_memfd_mmap_aligned() to allocate a
   shmem memfd, map it at a 2MB-aligned virtual address, and back it
   with 2MB THP folios via MADV_HUGEPAGE, write-fault population, and
   MADV_COLLAPSE.
 - __sysfs_iommu_group_get(), a variant of sysfs_iommu_group_get() that
   returns an error instead of asserting when the device has no IOMMU
   group.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../selftests/vfio/lib/include/libvfio.h      |  3 ++
 .../vfio/lib/include/libvfio/sysfs.h          |  1 +
 tools/testing/selftests/vfio/lib/libvfio.c    | 54 +++++++++++++++++++
 tools/testing/selftests/vfio/lib/sysfs.c      | 22 ++++++--
 4 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
index 07862b470777..1c245962525b 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
@@ -33,4 +33,7 @@ char **vfio_selftests_get_bdfs(int *argc, char *argv[], int *nr_bdfs);
  */
 void *mmap_reserve(size_t size, size_t align, size_t offset);
 
+int vfio_thp_memfd_alloc(size_t size, void **vaddr_out);
+void *vfio_memfd_mmap_aligned(int fd, size_t size, size_t align);
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_H */
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
index c9ab1ea8f5a9..b9d6f6f69f88 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
@@ -6,6 +6,7 @@ int sysfs_sriov_totalvfs_get(const char *bdf);
 int sysfs_sriov_numvfs_get(const char *bdf);
 void sysfs_sriov_numvfs_set(const char *bdf, int numvfs);
 char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i);
+int __sysfs_iommu_group_get(const char *bdf, int *group);
 int sysfs_iommu_group_get(const char *bdf);
 char *sysfs_driver_get(const char *bdf);
 
diff --git a/tools/testing/selftests/vfio/lib/libvfio.c b/tools/testing/selftests/vfio/lib/libvfio.c
index 3a3d1ed635c1..00369fe7d074 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.c
+++ b/tools/testing/selftests/vfio/lib/libvfio.c
@@ -1,14 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
 #include <sys/mman.h>
 
 #include <linux/align.h>
+#include <linux/mman.h>
+#include <linux/sizes.h>
 
 #include "../../../kselftest.h"
 #include <libvfio.h>
 
+#ifndef MADV_COLLAPSE
+#define MADV_COLLAPSE 25
+#endif
+
 static bool is_bdf(const char *str)
 {
 	unsigned int s, b, d, f;
@@ -101,3 +110,48 @@ void *mmap_reserve(size_t size, size_t align, size_t offset)
 
 	return map_align;
 }
+
+void *vfio_memfd_mmap_aligned(int fd, size_t size, size_t align)
+{
+	void *vaddr;
+
+	vaddr = mmap_reserve(size, align, 0);
+	vaddr = mmap(vaddr, size, PROT_READ | PROT_WRITE,
+		     MAP_SHARED | MAP_FIXED, fd, 0);
+	VFIO_ASSERT_NE(vaddr, MAP_FAILED);
+
+	return vaddr;
+}
+
+int vfio_thp_memfd_alloc(size_t size, void **vaddr_out)
+{
+	void *vaddr;
+	int fd;
+
+	VFIO_ASSERT_TRUE(IS_ALIGNED(size, SZ_2M));
+
+	fd = memfd_create("vfio-lu-dma", 0);
+	VFIO_ASSERT_GE(fd, 0);
+
+	VFIO_ASSERT_EQ(ftruncate(fd, size), 0);
+
+	vaddr = vfio_memfd_mmap_aligned(fd, size, SZ_2M);
+
+	if (madvise(vaddr, size, MADV_HUGEPAGE))
+		ksft_exit_skip("madvise(MADV_HUGEPAGE) failed: %s\n",
+			       strerror(errno));
+
+	/*
+	 * Write-fault the mapping rather than using fallocate() so that shmem
+	 * allocates PMD-sized THP folios when shmem_enabled is always,
+	 * within_size, or advise, then collapse in case shmem_enabled is never.
+	 */
+	memset(vaddr, 0, size);
+
+	if (madvise(vaddr, size, MADV_COLLAPSE))
+		ksft_exit_skip("madvise(MADV_COLLAPSE) failed: %s\n",
+			       strerror(errno));
+
+	*vaddr_out = vaddr;
+	return fd;
+}
diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/selftests/vfio/lib/sysfs.c
index 98a46a2543cd..219db6aaa101 100644
--- a/tools/testing/selftests/vfio/lib/sysfs.c
+++ b/tools/testing/selftests/vfio/lib/sysfs.c
@@ -115,14 +115,30 @@ char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i)
 	return out_vf_bdf;
 }
 
-int sysfs_iommu_group_get(const char *bdf)
+int __sysfs_iommu_group_get(const char *bdf, int *group)
 {
+	char rl_path[PATH_MAX];
 	char path[PATH_MAX];
-	int group;
+	char *end;
+	int ret;
 
 	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/iommu_group", bdf);
-	readlink_base(path, "%d", &group);
+	ret = readlink_safe(path, rl_path);
+	if (ret == -1)
+		return -errno;
+
+	errno = 0;
+	*group = strtol(basename(rl_path), &end, 10);
+	VFIO_ASSERT_EQ(errno, 0);
+	VFIO_ASSERT_EQ(*end, '\0');
+	return 0;
+}
+
+int sysfs_iommu_group_get(const char *bdf)
+{
+	int group;
 
+	VFIO_ASSERT_EQ(__sysfs_iommu_group_get(bdf, &group), 0);
 	return group;
 }
 
-- 
2.56.0.317.g454f8302e1-goog


