Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEE7C4450E
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w4NITAiOyX61WSGfTGRgV5OG/+gstw4nR1bSZsXufP8=; b=iBgOp8BmXAhWxNMGOO3Y1Tu0Zz
	5U4Gfdb/uXlG1YuPovuuyNLyZx0+8bPspI+ttlgjWVv2hZXMMRY3bgkcNmajqU0KVqF3urObypciy
	aVxq/Cq8uKiJBWnoFCV1MThl2cj1t9n5WAPPfQ8NyB0Um6N68HuPeR7A0b1yft8M0Bc99FtHSQb/Q
	knF01coPj7lQyf/weEFBKe2pM0k26S7UwJ0SqSyDprNj5Wh/NaODlIN/bWBGpjgHLbq4R10AxtzmL
	qOJCvjXVjb9d0wmpLlFhtFvU5rapH+i7UyiY9InEmvG8oTvQtl2qP3EIP7GRLFpKxE1tZX9F/cTbg
	tkMpcppA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjer9-0000000CUY4-20bi;
	Tue, 14 Jul 2026 15:15:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjer7-0000000CUSL-0pho
	for kexec@bombadil.infradead.org;
	Tue, 14 Jul 2026 15:15:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w4NITAiOyX61WSGfTGRgV5OG/+gstw4nR1bSZsXufP8=; b=SIKcJcrhVxMMV4ShFtL5jF+mzZ
	A61hKaNgIdxrx+YLbzJrGR88AavQQ+g6uGsLWFgFWlK3503vwwIIOaNxp4ag7BZrb6JGsdEwlq50k
	HcB8AYi8sYjFqzvJkgFZbyjWKK6RfHU/VbQvIB1h7RX3HidFD4bksGyDkjsuWpPS6ffRsXXN2Aj0B
	jSUNNco9aX1LUeMFXSO7uuH2wc9cYIfW0TS8m0nXsAMJojnvbp5EFHd8dYlaPXVA0s0KJCVdphx3c
	6WKWJyv7oBR6Ox+ltf2Q7TWFHvo+ODFBmagP29GUd+35DNfxNfKQ1X1WJ2VdrYncMWlPy1O0BuTCq
	3GaCa4bg==;
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjer3-0000000Cd76-3imq
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:31 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-c8952346bb9so3757466a12.2
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042127; x=1784646927; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4NITAiOyX61WSGfTGRgV5OG/+gstw4nR1bSZsXufP8=;
        b=KSnjzdYDTvDFoDnqYPlfhYBkGt1OK1ssFu6ngmHHlSFr02L87McHQlakztmPiMVV1u
         rkQgwHFaoYzhoiaYowhIM2wX21QE93LB6fIJ1bY7z4tsaPxryBEeI7KO2nOZSFDevv7U
         96cn+JupBlvfg5ZHAhCbItY9vXWHSaL7WZyJp6HVYSy88ubAVjTGDhKEJwkgiiL0CBjH
         fGnMqv7/rVBrxMYyS7LiH2UGaIDBQaOza4IRa69aND4tKN73WTgaUFNHrb+/HPmZ0cnq
         J1gK5Uwt47mC0C18uKn/zv8dBGiQNdAwRCSrUQV8FHrLEXkC87l7D/QVHH1FQq6Z6K5w
         Ie/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042127; x=1784646927;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w4NITAiOyX61WSGfTGRgV5OG/+gstw4nR1bSZsXufP8=;
        b=RMqKojnFr1spFkO+A7jUvavMYGM7h1Hki1N2JSOHHDyxZX8ty5w1cI4GF+GwOZngqg
         /J+7GIe+MFkMzN2ATJYMHdro3RuJu0bfxOvg52lEwnDTVga39nTr3JEo1Oq8Ylisjuln
         6P4bxC9aJ4Sz7CCiXwXf/MauOKT0Syqu+XScEd99W7cr/a6IR++lLDUv7zfEGinPEakQ
         QXMKS4Xa0NG5JLXapl2XtUOtfP4YZzUDOdU2FP6HUkWQtottPq2n5PdDQL2JmfztwjZG
         8gBIyyze8qPY/sIWEfKnaFY0iCs4kfMglCarPBBrUYzWwTXigQBOiwljCL9AN96yjrvv
         gVeQ==
X-Gm-Message-State: AOJu0Yy8xqqpiAHFK3BeWRQ2Fhq/NvMNd2zIWl6IEhFyJX7APSy3NII2
	Aj6sevUet9pzkVVqmfJ20Z+3MPtPnHHdPOM3tjyBgw/kmq9xi1vUiaxABRUli1xOwY7lTspUXud
	esUYLmfol0eMIRz2X3gUrfdrxEcqY0Fngpwn7whKXzLUVciH58rfpWEdbBQWVaug5WSYogrF7tT
	erNTulVZzBsJEEfbu4CXSMgNGXyvpI5Ecr+D/WA4ChRibZ9A==
X-Received: from plbkx14.prod.google.com ([2002:a17:902:f94e:b0:2cc:61be:8bbb])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db11:b0:2c9:d539:61e7
 with SMTP id d9443c01a7336-2ce9ead007bmr140240975ad.19.1784042126213; Tue, 14
 Jul 2026 08:15:26 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:15:01 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-17-vipinsh@google.com>
Subject: [PATCH v5 16/20] vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
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
X-CRM114-CacheID: sfid-20260714_161529_962347_F5EE9AB7 
X-CRM114-Status: UNSURE (   9.19  )
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

From: David Matlack <dmatlack@google.com>

Add Makefile support for TEST_GEN_PROGS_EXTENDED targets. These tests
are not run by default.

TEST_GEN_PROGS_EXTENDED will be used for Live Update selftests in
subsequent commits. These selftests must be run manually because they
require the user/runner to perform additional actions, such as kexec,
during the test.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index dc06fddcf855..591f1a52c310 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -36,16 +36,18 @@ LDLIBS += -luuid
 LIBS_O := $(LIBVFIO_O)
 LIBS_O += $(LIBLIVEUPDATE_O)
 
-$(TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(LIBS_O)
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/%: $(OUTPUT)/%.o $(LIBS_O)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBS_O) $(LDLIBS) -o $@
 
-TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
-$(TEST_GEN_PROGS_O): $(OUTPUT)/%.o: %.c
+TESTS_O := $(patsubst %, %.o, $(TEST_GEN_PROGS))
+TESTS_O += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
+
+$(TESTS_O): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
-TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBS_O))
+TEST_DEP_FILES = $(patsubst %.o, %.d, $(TESTS_O) $(LIBS_O))
 -include $(TEST_DEP_FILES)
 
-EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
+EXTRA_CLEAN += $(TESTS_O) $(TEST_DEP_FILES)
 
 endif
-- 
2.55.0.795.g602f6c329a-goog


