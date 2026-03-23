Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC66EF532C1
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bCulrz/+ZC3yY//mGMCNHFkV5P7dfGgY4CJSUX7daUA=; b=knVG2yiq1Qia1B9uBfwdO/SBx/
	RAPW4P/GzetgdJCltfC0Wqu2OeHWffhsq5pNAyXGitH9pPViC2YEea+smpHmFauPUfu4xCKETCgeD
	WgMhGPaKVWmEGC3I1I1GlCG0IjUyEpps9qX2p4kDluDBSYTwzOgDudn1JTVl8A6amShux1VVB9Vlz
	EMNykbU5lsypxcbewvwKdEQiQK/M9nN+gUHx4fFQCjwYdH41uqbN/ojMMnxzxDZP1ndyWAaEm61cF
	BA3qkDGSBCLc0DJdUeRgzafQc676ESImTKiMNA+8FGUqYa8lclXaSSgl7cx24Mb2sXU8S87gQ+zTd
	sjcm/OvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAu-00000000Bmd-0kb5;
	Mon, 23 Mar 2026 23:59:12 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAp-00000000BgS-27eW
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:59:10 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-3594620fe97so34421205a91.1
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310346; x=1774915146; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bCulrz/+ZC3yY//mGMCNHFkV5P7dfGgY4CJSUX7daUA=;
        b=ZnR5D8zIZXR447NYjuLslSJrD5EjgoHs4J5TjBI5oFaELQPxiF9uXDWbIugu+2eJF+
         7NjFarlxO0F6chmuwN5cdiFKxzEJm9d5BxVvxDSJpVxQGyBhbkrzihJPJK8ni49fmCzv
         0o5IiJ+3K9Ar1hNNBjo5kYtbms1j5M9FDojPPSy8cOBP9tv2Jtik+aAtOuanpGNdvHAD
         ME5VbeeHphI+yqT+mAM0pnMGhW0bI43lBqj8YM+U7jqprju71vzTl0RMV7XOZBIyz3j3
         pGpE8zNeI6WQt8cIgQopy3w48r4M29vnOi8Lq/0wPL9PhiNnQrP2J+Bp2kf+Iuk2GlEF
         TH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310346; x=1774915146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCulrz/+ZC3yY//mGMCNHFkV5P7dfGgY4CJSUX7daUA=;
        b=BUVk3Egmvj1wwLJOW0hjMQmfQPS2+uC4ixPFlV4fTnxmiD/vFccRmt36wciRdZ5+mJ
         It3szsgsQeD51zHbmBVRsGER35fKs3EUSrDYo5mNJ+uoJr6iQyWaCC5ZBhlH2bly4B4j
         mplJLv1GE3xszxU/0ewzopFMNAVlTbvgUoGGhZW3kZupaJdP8lFNGgp0QuoqP+zM1Fm7
         xsdlMYgtMXxpqGG6mfKEFTvUTB3M0fEDHGFwzXbbZP7n7LioUFK8QV0u1OVEs2VY+3HX
         gUvQeRWd1/AMaftYtBhjVqb+BATlbcLH4o6z7nydf0G33qbTZiq9j8h5fJLc93YWziVS
         qSKA==
X-Forwarded-Encrypted: i=1; AJvYcCXrxH+FVte6MFJg+1U8ge4/8XT+T81W3b9bqourd2OKgClOh3ZRsjtiwvt7OopkcSTW5urcFw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxtlBsqXzHr20aUIc1x+0Z2NuiXLg+qpBMCYXfjYimDcJ8wXPh7
	RbFtvAb0brhgOv2pZJK9sbykQSsSk81hLSRMZocsSTlmsfKh3XpidfEKvvTnAgEXw7QtwTuaK/C
	Jo502B4PLEXVxcA==
X-Received: from pjvd16.prod.google.com ([2002:a17:90a:d990:b0:35b:a305:76f5])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:15c2:b0:35b:e4f8:78e1 with SMTP id 98e67ed59e1d1-35be4f87c2bmr4832204a91.11.1774310345696;
 Mon, 23 Mar 2026 16:59:05 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:08 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-17-dmatlack@google.com>
Subject: [PATCH v3 16/24] vfio: selftests: Build liveupdate library in VFIO selftests
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
X-CRM114-CacheID: sfid-20260323_165907_596871_52CBAF59 
X-CRM114-Status: UNSURE (   9.83  )
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
index 8e90e409e91d..7f3c94da289d 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -20,6 +20,7 @@ TEST_FILES += scripts/setup.sh
 
 include ../lib.mk
 include lib/libvfio.mk
+include ../liveupdate/lib/libliveupdate.mk
 
 CFLAGS += -I$(top_srcdir)/tools/include
 CFLAGS += -MD
@@ -27,11 +28,15 @@ CFLAGS += $(EXTRA_CFLAGS)
 
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
2.53.0.983.g0bb29b3bc5-goog


