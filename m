Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534C8C4450D
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JcpQuk6vjGQSe9CsOI/pxanFsfOSXhryIEYWt4/hbIA=; b=sNqvqpMrVjmjGi8kA7FoZYhQ7N
	NCWC1/kazWargxo5nZ9rnei3ADofuaHnrf3+rg3rZlqu5vsFEvRORzQokCD4qRhtqMb1921yAAzrz
	GCL0paW5ytLAud+4MdPBSxUfapWR79hqvydnupf6ks0w6NfBAT3115FFaJP2xlVVvygT5SF2OW0lX
	N9fB1jK25oNV8V1yjC9Yg5nKPqNIulK+ty4HwtzTKKkIPirZFggeXeReZIyQuJeQkKjdzT7QG2Mdp
	0j+13GBUf4RR8sM5fp9GQ9mamMVSBBAg394PLlI3Ct4zycAlU0GpydqE62n/it0ESXPbH94EXCqEy
	NXinhkXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjer7-0000000CUUx-49yx;
	Tue, 14 Jul 2026 15:15:33 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjer4-0000000CUMe-1cdO
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:31 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso1391758b3a.0
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042129; x=1784646929; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JcpQuk6vjGQSe9CsOI/pxanFsfOSXhryIEYWt4/hbIA=;
        b=S7/NVmv0MgpuBKCXw4BXNmHwdVgJ0OBHQEhj9Rb10Y0lbe9ue2uNrEpN8kycI2OmQq
         f+D9luyGArVYYJp1B5sca0gkwB3EMu+DQqJiGhnphrmHqU1x3J6NPlg8KSJQ3PlW4BkC
         tW0/q6tYCO0bVSiv2a2+ERVhU5IOd4gtq+NbMyACGd1vrukDwDU6mIFNT8rcNdnqzih9
         kbIuqkM9Rn7Lk8zC3PyLos86G+lauJ0eONsncj0EraRFpTSFgLCjqFl/eG0vMzwCQQnN
         fdJVUfa67QHAmk0qtF3p8/WaiVnGB5A2A3IcL2nP3gdgNyrYDHVr2aYsHqQvNBjuIb1Y
         Tr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042129; x=1784646929;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JcpQuk6vjGQSe9CsOI/pxanFsfOSXhryIEYWt4/hbIA=;
        b=YpiJ51qmMbUqPfjtx4TSy2qkdjMC61u6d+9+gkADA4AaNgKP/91g8jXKWH2lBbI7uH
         80zZQBl0Yo6MFPErQJYe/moRUHMvHWOb8IMhpE1Wn6p8b2SlaOcycok0lB9mHQACk+qy
         Y31+K6f5qm8TQgcoG8IhfAGrVf7w8E+KnncyaNDCaO5WE0rPdkrtjCvizQsBpRNNaqP+
         Xcu07yqvYQXr996JjVJ+61DLOCV33x8N8IJdfR6NZeM47phjUUgg9Tb+/NnB/CEr4vHB
         UwFlu4s4fcsi2RPbBkbO16zl1BzxYc1zr4yZSVi/Ivb6psLtftj+fd+7KAn5wZZz+ozp
         6VqA==
X-Gm-Message-State: AOJu0YzAgszg3exNXxLd7h4AP41WsV6v2um0N0ZMX/RfX4OrNbUh61yx
	QsbeNRBsHvdYI+DrW1wuvPohoDx+a2OyhJ4Y1ce3q+H7Pq6WK3xxGDh7LaVoFt8ru3OxwH8Yywm
	CMhn7NopK1uVAW4TDAAPh2COm/4TNC11zqYlvCtJQf8dU5GsoQYiP+WlfBNqQ8jD1FFySJUej6y
	YxHJHv/I3p7G9syuCQDaMJnc9IZVhshFzlXPYkObdljMZgiA==
X-Received: from pfx27.prod.google.com ([2002:a05:6a00:a45b:b0:848:5415:1869])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd8a:b0:848:70e7:f053
 with SMTP id d2e1a72fcca58-8488980f75dmr11709317b3a.54.1784042128707; Tue, 14
 Jul 2026 08:15:28 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:15:03 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-19-vipinsh@google.com>
Subject: [PATCH v5 18/20] vfio: selftests: Expose iommu_modes to tests
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_081530_449701_71504B2B 
X-CRM114-Status: GOOD (  12.57  )
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

From: David Matlack <dmatlack@google.com>

Expose the list of iommu_modes to enable tests that want to iterate
through all possible iommu modes.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/lib/include/libvfio/iommu.h | 2 ++
 tools/testing/selftests/vfio/lib/iommu.c                 | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e9a3386a4719..4b9cbe262159 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -15,6 +15,8 @@ struct iommu_mode {
 	unsigned long iommu_type;
 };
 
+extern const struct iommu_mode iommu_modes[];
+extern const int nr_iommu_modes;
 extern const char *default_iommu_mode;
 
 struct dma_region {
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 035dac069d60..95a494f829d2 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -23,7 +23,7 @@
 const char *default_iommu_mode = MODE_IOMMUFD;
 
 /* Reminder: Keep in sync with FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(). */
-static const struct iommu_mode iommu_modes[] = {
+const struct iommu_mode iommu_modes[] = {
 	{
 		.name = MODE_VFIO_TYPE1_IOMMU,
 		.container_path = "/dev/vfio/vfio",
@@ -49,6 +49,8 @@ static const struct iommu_mode iommu_modes[] = {
 	},
 };
 
+const int nr_iommu_modes = ARRAY_SIZE(iommu_modes);
+
 static const struct iommu_mode *lookup_iommu_mode(const char *iommu_mode)
 {
 	int i;
-- 
2.55.0.795.g602f6c329a-goog


