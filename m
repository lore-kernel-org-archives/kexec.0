Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C25D73E8D
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 21:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dy0UJfAzqC2Uv0TXXgbyaGP8I7SQ7WbjV2I2sUTFK/o=; b=4gq5cKN7BUkWBzkWkjPrc1ob79
	35AoU9H/PMY+y9dnVL1Eza3IUGpM/YK/HoYODhGsu2IUidYpc3KmbyHCYxDnQhfxDyNzFCoK4gAdx
	RkbRIa4jTM1pt6647rau7x07JIBPNRRMfOLWyuDvThcAL7cXiL8MdFnTF7gHnHPLPceoORVCAsNfE
	evoEwcMj07CBZzuvzrYDDDRRYHq9CGlQZFCR8rna+4Ez9pGTHMkXYuufvHjmS050Q14LfitKwu5KJ
	3XbBfK534ICbmcnRsp0suevwUGKA2elEcSQL4oAkyebKsQKbpvzW5UGzoW4YvI/TUHvhYeEJvadQc
	RzeayK8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWp-00000000fZM-4ArK;
	Thu, 29 Jan 2026 21:26:16 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWc-00000000fO5-0QYt
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 21:26:04 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2a79164b686so15015965ad.0
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 13:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721961; x=1770326761; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dy0UJfAzqC2Uv0TXXgbyaGP8I7SQ7WbjV2I2sUTFK/o=;
        b=aBkxdsInToWsW7uXGH3cCryXDRJsXigur0X6W4m9EIE8fUY739Zhf7NBap/UFu6oST
         5jpg+3iciUr/o/8SunHfuRyOeb/jFvhWYDv3AnK1vHAUMXyCNJKMtqVR06PZ6ggJt9fI
         o9EzeIldHxx+8UMLujhLpWkv2mooLvVVMhhMnDkQem353G6TJDol/kMK2yAN9JmfMXKg
         3xJd9cTTo9UYgGwx6mq3qv1oBWkV8nN2iBaxTuUfyV9WEbVYtO6MBQ3bBwNd15l24kkR
         9nptSKvsv7xD2Sk/8O+qZLginQhz9S6+R/d/gd8V9lk644aZ+cWZ0dYwk6U99MkIBk+s
         cwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721961; x=1770326761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dy0UJfAzqC2Uv0TXXgbyaGP8I7SQ7WbjV2I2sUTFK/o=;
        b=J6R20mU3TZEtE4hza9HXHedpKDMYD5zkjgVN5nlnQYmYhqNK71EAMQCgCrRU2EZnul
         auI9NttpfMX5iNaxmKwrUQLOvJiJrK8wtlHZ06yiUylqUY+Q/063rmNX4L7fMeOP6PSA
         VgEFP3vW08hNeGbB/zyzMMiIeSFzndYzf9k3os5GCluBDzaG9TmOXyZefaG3Hu5ihMiq
         S1elUx4+ieIw/LNUBxkYFtm83vLIvovgFSeuoMDgMwOznnGYowYe01ZVYn9cLenVIJRl
         IVw14Qd489vfvzfvhVUYDwC/smV16xsQ8xcQ8TteAR1fg23yx7bhL+4mXc5o0bLD3907
         LcpA==
X-Forwarded-Encrypted: i=1; AJvYcCWvex5R/dPngWDEfqrJupANfWIOk91ANY0EauA5Ju7xpeRq7/9kFPlv5EQDM8rSpUmVAdOl1g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxy4BmYP47J2nteQn5r14Yj1cQmzXuTJ+uJUT4bDcTEpV+qO0JU
	XIEtxQnGuaufdjcGiTEsUynF8i2sgV4GiFHqd9BL7vCGQZOmc+63phGpA26p/0W2wFtgsE+DTnx
	hhcF1MgqEDQy8xA==
X-Received: from plrp10.prod.google.com ([2002:a17:902:b08a:b0:2a0:8ca0:1e55])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:290d:b0:2a0:dabc:1388 with SMTP id d9443c01a7336-2a8d990adfcmr3786725ad.28.1769721960616;
 Thu, 29 Jan 2026 13:26:00 -0800 (PST)
Date: Thu, 29 Jan 2026 21:25:01 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-15-dmatlack@google.com>
Subject: [PATCH v2 14/22] vfio: selftests: Build liveupdate library in VFIO selftests
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
X-CRM114-CacheID: sfid-20260129_132602_189557_41A2195B 
X-CRM114-Status: UNSURE (   9.15  )
X-CRM114-Notice: Please train this message.
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

From: Vipin Sharma <vipinsh@google.com>

Import and build liveupdate selftest library in VFIO selftests.

It allows to use liveupdate ioctls in VFIO selftests

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 3c796ca99a50..1e50998529fd 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -12,6 +12,7 @@ TEST_FILES += scripts/setup.sh
 
 include ../lib.mk
 include lib/libvfio.mk
+include ../liveupdate/lib/libliveupdate.mk
 
 CFLAGS += -I$(top_srcdir)/tools/include
 CFLAGS += -MD
@@ -19,11 +20,15 @@ CFLAGS += $(EXTRA_CFLAGS)
 
 LDFLAGS += -pthread
 
-$(TEST_GEN_PROGS): %: %.o $(LIBVFIO_O)
-	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBVFIO_O) $(LDLIBS) -o $@
+LIBS_O := $(LIBVFIO_O)
+LIBS_O += $(LIBLIVEUPDATE_O)
+
+$(TEST_GEN_PROGS): %: %.o $(LIBS_O)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBS_O) $(LDLIBS) -o $@
 
 TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
-TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBVFIO_O))
+TEST_DEP_FILES := $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O))
+TEST_DEP_FILES += $(patsubst %.o, %.d, $(LIBS_O))
 -include $(TEST_DEP_FILES)
 
 EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
-- 
2.53.0.rc1.225.gd81095ad13-goog


