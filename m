Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C08C44501
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6euMhf7mogWwsfwAzliK6IQ37N0mgMRUyNxCkXOGnkg=; b=aIJxsQs8U6CQ19VuYo83nrxsPz
	Qb4Q8G6lSz7zjpRHpH3bzNfQAC6QXTxIgY3X031TgM78ruKhwGRo/dacmhOeWcL/dhmx02bOXw5z0
	RN8+I3mtk2oypCEZO5X+CR1bQ3+Tt/E6j6XhqOXRHLqCQfEIGnoKpMS9m6NjiceS9lsEp5O/rstZX
	pVhXAnFvaXVmTKXXdVFZbsx1e6jXSpF2nvW1B0cVWZBy78uChuisLMDi8qrN+rWy7VhUuIa3HGIob
	gKcKgU+kHC9AJ78b5zG6pttOU4sue4xC2Lp5LIbCHcAuHkLYniS1MtCGRit2R14sw4dzpvQYcvYaH
	ztlr6kWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjer4-0000000CUOx-3fBn;
	Tue, 14 Jul 2026 15:15:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjer3-0000000CUKV-0lue
	for kexec@bombadil.infradead.org;
	Tue, 14 Jul 2026 15:15:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6euMhf7mogWwsfwAzliK6IQ37N0mgMRUyNxCkXOGnkg=; b=YLVaXG+9IYxKfo5PfOYujaXeBZ
	r//2Xqr3H9b3OzBDZpR9PFBeFvZsCOA2SnNiut4978FipWgeGw2/cFpd0I9gCeWfq0+q7K/UCCubf
	liyeicsdtKaLXCbGd0L4r26IjUrsujyl2pnPZczQugQ4X4c8Edcush4by9ykzcE4ShlRAViFcGRcO
	VN/VGy9KVn0eI6iTjB+UzkRSCWM9c/biGNs9JRF9Rf17BpZO9aKXiAOdQ28f0stYTtTrVx9BpYLDV
	tG4pMjYJLoziP1jhxU/rUA/tulgcyOZm5pKcaQW8j1568VgQw5kfHLui0TWrPCmZv4ssjTYwqZET+
	Ck2U/S7g==;
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjer0-0000000Cd5F-0VUf
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:28 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-84a3514f912so4346994b3a.3
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042123; x=1784646923; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6euMhf7mogWwsfwAzliK6IQ37N0mgMRUyNxCkXOGnkg=;
        b=BwuPiOF7i8sK2qCMhhyya1+YrHZMR+uSR5KQHqqeExW8KOANuVb7Z6C9E8Acotrztu
         l2FAP6paC869fQWnKMZiskXhkRj9H+Bwe8qBwymbmwvQXdtJhMhAVbuU3bxauc+KXd9I
         G3ZN7XZaXYu/eP/fAAH0YmH2UbzhDCQVSk4EuXNY67/CnmyedwMNlqNJBPkGFK1wZTfW
         3Nfu6+eyhsAEIf7Ec9NJxTBlA8vvyXAuRGyC2mKzRnH4gJAycz4PkJhUiwoninT2lfJg
         zR3aSu1u6Z5pcsGzfRmRC2poGVIGozwjV27OEImS3O0yros2L/ahMXnid7vPpllhK2K6
         1Dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042123; x=1784646923;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6euMhf7mogWwsfwAzliK6IQ37N0mgMRUyNxCkXOGnkg=;
        b=BVQsrHnKArLIXLCZSJXSFFpOF3NV3OawKnRRRhFNQ3136UnTW+POjYNj1ZyKZ9yEWK
         G7gWCv/vhi9huUxvNeb5Q2SbSHa4RZ5gYNqodWHW78fvUJdn8EzylVYeqJ1vEbR548HC
         6YGvr3T5yzJ6wLPIhveaRhaBpq9NJ6jc4fVyHeRDCJVigFdQNBr+qXj5wM+ghgOL55HY
         1fS2ZR5g2LyEoPWtLCmeaUeb+xJ/ZAuJrzYhMDCBPI1pe6qTp06GQmW33mUmkajwqRam
         PF2b2ASeDH0nAaI/RUC4+fYyfO8JPOEzhQvJ3Dz9t6/rk+Hwhk6xGRi2R+psdmegtPs+
         KUeg==
X-Gm-Message-State: AOJu0YyEL8kHesft//5V4yUKPr5+0vIzGQ+SKnTyfAzdXm64rLSqHldn
	xhAQ0vtDN9dlPsviPDPDOTSspvKIq/Fv5lXfldnnPt1b60rXUpDIjPBvyYxA2bV2/D07J9A5enJ
	gBNlF5FxFqJECWjG0AXkFTVCjPiJT5Xb4pZMQ9W/rhuDMYEretQ5aTKIVhGSOSNPhs2TvSH1iWO
	SA29k20F0LsZIftTxdxQsnraZr32BKcaWi0f1TGrSX4xozAw==
X-Received: from pful22.prod.google.com ([2002:a05:6a00:1416:b0:847:7fb7:7370])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e87:b0:848:6dd5:f69
 with SMTP id d2e1a72fcca58-84a516062dfmr4085012b3a.42.1784042123043; Tue, 14
 Jul 2026 08:15:23 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:58 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-14-vipinsh@google.com>
Subject: [PATCH v5 13/20] vfio: selftests: Build liveupdate library in VFIO selftests
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
X-CRM114-CacheID: sfid-20260714_161526_375797_C2EF17EB 
X-CRM114-Status: UNSURE (   8.02  )
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

Import and build liveupdate selftest library in VFIO selftests.

It allows using liveupdate ioctls in VFIO selftests

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index e6e8cb52ab03..4c8a30f950c4 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -21,6 +21,7 @@ TEST_FILES += scripts/setup.sh
 
 include ../lib.mk
 include lib/libvfio.mk
+include ../liveupdate/lib/libliveupdate.mk
 
 CFLAGS += -I$(top_srcdir)/tools/include
 CFLAGS += -MD
@@ -31,14 +32,17 @@ LDFLAGS += -pthread
 
 LDLIBS += -luuid
 
-$(TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(LIBVFIO_O)
-	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBVFIO_O) $(LDLIBS) -o $@
+LIBS_O := $(LIBVFIO_O)
+LIBS_O += $(LIBLIVEUPDATE_O)
+
+$(TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(LIBS_O)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBS_O) $(LDLIBS) -o $@
 
 TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
 $(TEST_GEN_PROGS_O): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
-TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBVFIO_O))
+TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBS_O))
 -include $(TEST_DEP_FILES)
 
 EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
-- 
2.55.0.795.g602f6c329a-goog


