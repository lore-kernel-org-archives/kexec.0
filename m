Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161D7F532C3
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7enZU/vxLy/6ohUczG3HchuR4oREBV6X1oYMwMHYNIE=; b=ejSSC2nG10gqg0/hPobclOwxf+
	LGIE1ibCvZ1sp6OTaFsJecs2m4JFI1urm+dq5cE3bydfwoCb+KI0LkEJAyCOUvdHxwTmrWG87sDFf
	2Y0oX2wFMCahol9r+Rq0SJnDjgmq5PwL3dTNZLoqn8QAzCkIE67caJbYgdfkmsPmSmx/EXKqiF7yw
	j1Xp3PSUY/Er6h3bcd8UXlXd6ZUsJjsM/qWcPAEzoG7xKDScBp2t49l2OGxnN98TThukmeb3stLbQ
	Xv4XXu1p5mxpHT1owHlfaNyG7vQqOY97Zx57eklvrzYrqgSp1qB+4aOUUdGW6NJd3+wn7PGqwMqur
	o86LfzOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAu-00000000Bn9-2OXp;
	Mon, 23 Mar 2026 23:59:12 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAr-00000000BiS-08hV
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:59:11 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-3595485abbbso912970a91.2
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310348; x=1774915148; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7enZU/vxLy/6ohUczG3HchuR4oREBV6X1oYMwMHYNIE=;
        b=GWmh/donJKNlqc3RmuZTdoMkrkhA6i6eygtXYeElR6DjZbtS/Q2AYYLT8z6EuNnmel
         cXmmZDOubnA7dML0g+48gs7Iq6iiiSWazLrxcS0j9TUfT0saeEZ+wqJHQCtLZ/sHuoAw
         tuy6XBVKoWEudCOAnY+b/yFA3+3JM2E96KO4rLbQvRpS/JGQ+ULY34l3EzUI+toIAPke
         uUP2LEgFvaVlRy5RMFE/Fwqo+lwfBzPwtoolhMD4GUT++txaazb1Bh+mc5ie4WpQv9A7
         wUppeYxUJnxGrPIkZNvSfGz0GpjShXqatzHE5mFrwtF82ewWVUsxw2dOr3yx/HA9XYoB
         LlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310348; x=1774915148;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7enZU/vxLy/6ohUczG3HchuR4oREBV6X1oYMwMHYNIE=;
        b=KRMykvSyqDAuOwPf756tvckfLxsbKIbuQ6bVtz+EEnUe/XRdmfog/WegjzFjtdWfVO
         +jQWJYO+QF7Fhmbla3k9udwMby5w9HtewJp4Zpib8/IUVsfL8CvT95blAGVryIzX5wo0
         bQ0Grqqj8jc0rG4XZw18epqNVprMhWJOlkYZ8MBOLr0DcSk49r/+tPuJ0fzSTteDybEa
         4Bu64XKqdIHV6YNushjmC8VWwv0536bnJheZ6sajUaZmrUFeboSz+7gXQkA0jwztMibG
         D7DzkWMyblPPv1WGgj25zr0DiXnDm1sBN72Zl65Rp08w7BylOjQ6XnuhLU02kgXalhSM
         IWGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuUxjLRP8e8NW+uQ2x37zUjAtDkdiOLVntiOBJXlBWgrBM4tkulfu4VcN71eQxGVW2T5gXYw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4/PLN2xtPfuHV8zzEWM2GYQRSt1sBvfc8/myXJfrk1C/x5/g8
	2ujLEYH2K+qQoERKFchMHbSToXgcaLTfYvDQfm02xXl4jVbpId9kZIIvktXENEYf/WNLD68toEI
	wvy/gjW3ebDT1YQ==
X-Received: from pgbdo13.prod.google.com ([2002:a05:6a02:e8d:b0:bac:6acd:8182])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a15:b0:398:7855:1596 with SMTP id adf61e73a8af0-39bcea6ed94mr12817264637.10.1774310347510;
 Mon, 23 Mar 2026 16:59:07 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:09 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-18-dmatlack@google.com>
Subject: [PATCH v3 17/24] vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
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
X-CRM114-CacheID: sfid-20260323_165909_140159_9416681A 
X-CRM114-Status: GOOD (  10.46  )
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

Add Makefile support for TEST_GEN_PROGS_EXTENDED targets. These tests
are not run by default.

TEST_GEN_PROGS_EXTENDED will be used for Live Update selftests in
subsequent commits. These selftests must be run manually because they
require the user/runner to perform additional actions, such as kexec,
during the test.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 7f3c94da289d..9d5e390a61b7 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -31,14 +31,17 @@ LDFLAGS += -pthread
 LIBS_O := $(LIBVFIO_O)
 LIBS_O += $(LIBLIVEUPDATE_O)
 
-$(TEST_GEN_PROGS): %: %.o $(LIBS_O)
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o $(LIBS_O)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBS_O) $(LDLIBS) -o $@
 
-TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
-TEST_DEP_FILES := $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O))
+TESTS_O := $(patsubst %, %.o, $(TEST_GEN_PROGS))
+TESTS_O += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
+
+TEST_DEP_FILES := $(patsubst %.o, %.d, $(TESTS_O))
 TEST_DEP_FILES += $(patsubst %.o, %.d, $(LIBS_O))
 -include $(TEST_DEP_FILES)
 
-EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
+EXTRA_CLEAN += $(TESTS_O)
+EXTRA_CLEAN += $(TEST_DEP_FILES)
 
 endif
-- 
2.53.0.983.g0bb29b3bc5-goog


