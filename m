Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB53F532C4
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CreqaGlwQEQK+YRyK6iGxzdx6WSNNVSy3f0PqjRZciY=; b=SBUTo6/DyJQAmTfGXiVUKKS1R0
	AkbskM9ZdebXlLzz2EJR8yzJiFH85N2qeb4ZgoM/T0heG7RXlLdcM5IatwmF5kyt3L/k/bYO6P34+
	LWTCFjwyuhJcgTLNkTpwmbgcnOPXVdAS+50jk+lhCmY4Rz5QOm/wAYxjcqMZV1smbFMTtrDFVXOfs
	MBTZ2HGO10HWLog1xIhrKvUVqZXSI/izDAOZvaDB4783VVcon45jlushVdM7XcrTMmOKrUnCty4R8
	7/6Fqsce+bbfUfSAbX5GtfIevwQPUjdwl8lKTcMmPUFEuvYJmMNp3hnNZZXFALL1NJMiC5zNZAGIG
	CK+v1/aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pB2-00000000BvN-2Bro;
	Mon, 23 Mar 2026 23:59:20 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAz-00000000Bp0-0S6p
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:59:18 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-35b8f351debso810092a91.1
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310355; x=1774915155; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CreqaGlwQEQK+YRyK6iGxzdx6WSNNVSy3f0PqjRZciY=;
        b=M/HW0vcqP68XR+zNUR0TPKaGnxOrPY+APRCglZtR9nxne9g/GBfaqgrzrd/FXmVVXS
         Ge034UUi2gDsy19bYNfLJwbdDUUFojxyCaQhn6AEhW8qRB1hkYnvTUmYPmar+WnbBEIj
         Vyh6V+WOUonvtacrfM0u+7igSyVeDg52vuUZo4pdjSiIqgJvhVhWLq2Lvd5IhxHxdeV1
         WWxHGbM7vKONtzxu9VZ4oTZbTaRM7t6B9rBkXalWA+TqqU6PWjMwlp7zLxvqcW52gSF5
         veMF6b3lWu8k3Ay7cecpOR/MvqKwjBrL+Evq4vu9ImmMxyxapl3yhcndnO7N+v88TAZq
         MgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310355; x=1774915155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CreqaGlwQEQK+YRyK6iGxzdx6WSNNVSy3f0PqjRZciY=;
        b=olHkdhstLpNQX2iKB8ReSlC4+Z5wQwG7RwNv4rtkpTOMpBEQWQGYl6VGcJaZS4yKKV
         V5rDcfCcpl5vHkgn7tsJMAVeDpSWr2a+u1xeBg1VD11V1UU5AnzCH9+mYdoJjqATQe2D
         u2Z8yU0+XZGsR//Dqjmus2k71VwbsS7qvpGjgE25/+fu2wApVDEsJohuXvdrw3p4/yRx
         P3AVUY920+iv5uJT8RJLMQ3ouSeH9H5OXVjQOzKjtuYeLa9xOrOUL72yUT4rwnI2fKUN
         H9orZ8UmiSAnNYbrABA23AP2tvHnosSZYgOEDQmJtbcVr0SdmpZZMFgjjg56lGg50kN9
         OS5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMljXc+9baOu5emiA3Ql56cpUzI7KaAvBV5EVTcgYfSp8WeWq10Myz4KQV0wyj8GCe7/ZPng==@lists.infradead.org
X-Gm-Message-State: AOJu0YxPzWgSqxdVeK4jX0WZzSWfnWezHSM7WOHBQsTb9p0X24j6eHs6
	b1bMPj9lSliRYCD6zWDxTZZjxvmdiBeKfOB/MJIsy95hsnJyglFy4BcRabTe9JCHQBCn0mi0ygo
	elNMHv2MbaSS8Lw==
X-Received: from pjat16.prod.google.com ([2002:a17:90a:d10:b0:35b:a2ad:add2])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d85:b0:359:1063:6aed with SMTP id 98e67ed59e1d1-35bd2cb3e52mr11055132a91.22.1774310354638;
 Mon, 23 Mar 2026 16:59:14 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:13 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-22-dmatlack@google.com>
Subject: [PATCH v3 21/24] vfio: selftests: Expose iommu_modes to tests
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_165917_226103_226F5D72 
X-CRM114-Status: GOOD (  14.45  )
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

Expose the list of iommu_modes to enable tests that want to iterate
through all possible iommu modes.

Signed-off-by: David Matlack <dmatlack@google.com>
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
2.53.0.983.g0bb29b3bc5-goog


