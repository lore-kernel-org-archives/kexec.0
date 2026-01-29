Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61174D73E91
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 21:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xZYm6U95PKyVs4z00Hg/ZV7BBbgjTCKK+U9M7txSstE=; b=cxcpY/3DunIy2bKF/paHXI68EQ
	LoouMWlrTOuJUqkw7go2U0ZtrukHoftjBaoqKr/BydZMy1IZt7uo6KsCJpI7C0XYrC3Z6NF6Pm1Vu
	nvvlQLjR9zy/ugFNRFo0lLYNShfERS0+93TK5uUJkhkslgpr5ITwJhS7DjRybk1BXhMQE9QsZM3vZ
	pLWXPYKshEUKq8UgVjew83n5iFYHzr43/u1Oo118QIy/U7sjSS81AWlNworariBTyKnvWoRBwure2
	7b5U6/2eAtH3JFpXQe0wVHdtXR5Yz4mhVsrCLXdV69ucvTxlnNRTQTni6yCk0ac0H0/4iizDAo02F
	D9bfzXuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWv-00000000fiV-39WB;
	Thu, 29 Jan 2026 21:26:21 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWm-00000000fVH-1Gpj
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 21:26:17 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-34ab459c051so2564063a91.0
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 13:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721969; x=1770326769; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZYm6U95PKyVs4z00Hg/ZV7BBbgjTCKK+U9M7txSstE=;
        b=ZfzsTMfhlqtvNpFVbnjT2WepacoKz/MF9scckujZCzkgiPWm/uHvX9USYnFkkUhAiW
         sHpP+6qod/psX/xKZqVNu1LWx2hORHPlSU4rZHLlfxWsXx2QxXQq9hJs24DAIHOCwO4P
         JJYWLR5PbIZsG8U4AwYZ8Y+Vj0k4yelhUrULULwB2tjqHRtgG+YBbcOg+IYJZSfSl/h6
         VN0uFaW1xznJkGfQbEbq566sZ7QxKXj0RCVdbVLTdbrwgYcBsXlEvOuYb52qPgKs7GgA
         L7JMdRB4yd4wOaBTkg9koAebswylXDwTSDhDnQO22F0dfDpaLyw+ZKT5w5fBCiw1vtDv
         j8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721969; x=1770326769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZYm6U95PKyVs4z00Hg/ZV7BBbgjTCKK+U9M7txSstE=;
        b=JxpIlHpsRq/01rdkF81uq3QUoxRfv971yVUYNYRuFPMI+MjuOe63msLRr+i5h5EKGG
         2VQzrmEWwtq0QuZvCWWtiYF2MsKJAxE4lZc9v1Jek228L+TYHRxSLwyQGZlSjYeBy+Dv
         Qw/yDe+3OYOYzs7gvUoeCqh9a3Gh+IoOtFJvZyvx9AYesg69Hw7YVTmys9ieaCbUROpm
         LlxUAFbC48CmfERM+SA/GSO0wMcKW/gs+jQHh5XKruJEJCXf8nUCQgwrwicISnik/qAP
         tXQwLCUx+phgsAVISMi7saHmat2zs4ugIKkb6p7PD0UcktZHhAKZRiAvOKw6eoAIvL3j
         /iWw==
X-Forwarded-Encrypted: i=1; AJvYcCVWpNciaJ4GawxsAMtKwIFp7gEXeyxTQP6rZL7/qi3edNh0nYE+dUS9eIsilvBZ/WjwJcIjjg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzNsZnKdGW9S516tLlfp0V5RmtZQaK9ieiLPKTfc5Znl6T10025
	PiFtgaHPJYhOgEQ/JtoEMBG60CFd1S/OrHDRFxWp4lpaBru0qlQkvww/Uk2bwvvsUOjjAELYIJe
	Mr6K0/J3ZEX8zDA==
X-Received: from pjpy19.prod.google.com ([2002:a17:90a:a413:b0:34c:9f0b:fd7])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3ccd:b0:352:bd7c:ddbd with SMTP id 98e67ed59e1d1-3543b38af32mr803010a91.23.1769721969001;
 Thu, 29 Jan 2026 13:26:09 -0800 (PST)
Date: Thu, 29 Jan 2026 21:25:06 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-20-dmatlack@google.com>
Subject: [PATCH v2 19/22] vfio: selftests: Expose iommu_modes to tests
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_132612_451184_57BB5CD0 
X-CRM114-Status: GOOD (  13.77  )
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
index 5c9b9dc6d993..a03ff2281f11 100644
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
index 58b7fb7430d4..add35dbc83f8 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -23,7 +23,7 @@
 const char *default_iommu_mode = "iommufd";
 
 /* Reminder: Keep in sync with FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(). */
-static const struct iommu_mode iommu_modes[] = {
+const struct iommu_mode iommu_modes[] = {
 	{
 		.name = "vfio_type1_iommu",
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
2.53.0.rc1.225.gd81095ad13-goog


