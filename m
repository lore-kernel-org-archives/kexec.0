Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F61860F0C12
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VAYGaIF/;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=JiZQ7Khn;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jiz4l0aX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tylWbFCUgeCOXBn9trkYSMBYVlhA9mV6Qs1lbXsCOco=; b=VAYGaIF/lr8ocBmDDwEfV8NfXY
	JSmMXqVXVGhp4okiiklgPE5dQ5khCdWS9iwvg/L41MVfIJ8mofX8PmN4nuZ/uPcqkeoFq/DjwV4AE
	9YfzvmFUP6CK7SbkxT9E0lBr+8bwc9me4+Bbb+LmX3xJOxI7AuMLi6cuNVZRCjE+NpEPI1sbgWmi9
	JT6mj7+iNmOErwT05UMw1GV9K+ZGMwBO9ehIIvDw1GrDuVni19D4JdtaG7G4Gl3iEQjta1ShM4M73
	VlvuaUbhfScsko6jGay6xjAAP/7XnZryoY4UMs4ZkhoCzMhnKcJDhlW4ML0uSq4g+xmQzvZmPnWvs
	bfJCTUeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6J-0000000HA8L-3a8j;
	Mon, 02 Nov 2026 15:37:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6D-0000000H9yI-3cFC
	for kexec@bombadil.infradead.org;
	Mon, 02 Nov 2026 15:37:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tylWbFCUgeCOXBn9trkYSMBYVlhA9mV6Qs1lbXsCOco=; b=JiZQ7KhnthE/UujTTN0w7r+Q2y
	sBbbiwV2pqSsa1Tg+K3383J/0CJRyIAj/IAmuFwA4z5eYQOBCRXbr+xStwsDCpxw5LiNrtvD3g40E
	g3+vH107nuAsCZBhD+J17hbEqwI1IsddpI2QDMzjDQ4o/Y6YNVC1jNeeCSppAmaVtaDfcxozfvVh8
	UQB8yQrcRf7R0OvKi6p3heW1fJ5H3XuyRzsJhY0+yER/Xa55fOjVX/VIWR9FQuC+zAFFOhHiGbhjA
	Xi6NkO8UYNHdrRKaouTz/TragBOT9WvPO7GEq/xX29fLU1FEBXw1CKhVsBjqA5jBV+rBnTBELmEil
	n5vC++vQ==;
Received: from mail-pl1-x646.google.com ([2607:f8b0:4864:20::646])
	by casper.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu67-00000003ZGe-0AK2
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:28 +0000
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2e832c03576so48290595ad.1
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633841; x=1794238641; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tylWbFCUgeCOXBn9trkYSMBYVlhA9mV6Qs1lbXsCOco=;
        b=Jiz4l0aXFAbbVPCkGs3U5yG0U7RpdJd9GjiRj6R+z4r5pJg+cn0GjvT2P59KYZeMmt
         KLIVmUd1GanLnXhiZ8aiererv3shruBfDtMmEFk5QRq+4qRJljd4Aes96Ua+XYhH12V7
         o+8/BbQUIXvn49M8VdOwUv2eyj9LxCrPyaac3sxc3O0WQPGKBPs/s/o49Fx6ief2eVP7
         SRXDA/UA2yf3hxegeDAXFYo6aZPa2X59hytA18OKvJiEdPzlqxta/saALC7ujay412lF
         RZnftIUH2hvObXA69k2sTyFjOkYhT8Cla3C5D2IJJK/C5MoIbftt7IqnEB6aOQQEOrPs
         W87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633841; x=1794238641;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tylWbFCUgeCOXBn9trkYSMBYVlhA9mV6Qs1lbXsCOco=;
        b=lPTDymSx9SoEZjYPsv/rD8rovLOt5XHwuv+v1Kg5fZd6bx2vYH/RA+OFxg3zPD+Ix6
         G/Apct9yXIrylQTLCU3AiD/0NZqMiaOPf8Q35QSuuwMVp4gg1iQTEZ8LCYS2ZmuiWexq
         5oSovvSxVwFRU0l31QNtCINDNnR9k7v1GcnY7FeRrz6JPasQbmtUC7F6u4YrMj2AUvyZ
         FAMDLHzvwSdxYLFqkgNLwcWiOc/8g0mtX2Xz8dPOcanI0XupJn0cz5uWwZ0bWyV8QcGT
         vG5b07IY5gXzkJCuSB1D/P3KkyRplFT48CqWsLYVDd3jIhmveWSaHEzAEgZ8Zf854HTq
         r8Kw==
X-Gm-Message-State: APuU4Z8aiaiIzAODvnF/F7allBe6t80EzQK27nd1ECR/qQak9i3G5RGr
	nvN5K0S34Yys47IA43tyE7RF5VKMHMMdwMcutQSe35UbaSnqq1LZXAeT+03AkatBVI0735gL255
	Ma1yUphSj7+FafiyB3rUByyaq+S3X1OE52RQVFVDeVwIyhJZHRiPygz5PZ/2F0DZaQqWw8esnWk
	eL2ymz/CYvOQeChA3EAEicuA80nhzLC/yYkPDfoTfStgjZtg==
X-Received: from plbix15.prod.google.com ([2002:a17:902:f80f:b0:2ea:a5c1:240f])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37c7:b0:2e8:b5b2:a9f9
 with SMTP id d9443c01a7336-2eb364e9f75mr92959155ad.37.1793633840266; Mon, 02
 Nov 2026 07:37:20 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:48 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-20-vipinsh@google.com>
Subject: [PATCH v6 19/27] vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
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
X-CRM114-CacheID: sfid-20261102_153723_101126_01675FCF 
X-CRM114-Status: UNSURE (   7.63  )
X-CRM114-Notice: Please train this message.
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
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index c2764fcef31d..ece2a3618f2b 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -34,16 +34,18 @@ LDFLAGS += -pthread
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
2.56.0.317.g454f8302e1-goog


