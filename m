Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5389BCD6E6B
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 03:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J9VRMQ5Ef8ulqUN7FHiGBWdV1K/iIYqxWaAhgeSwRK0=; b=V/jJaMOcU0b4qB6brmcqNvwT9x
	efqqMy+x7Y43+82KhFFfyAL5/7GUDD3vSINFCI+mg7fcGRa/f7/ntGs1fmJ7UBTmWw14BhIsrOoPN
	rHlFLlHD4AJB8GKM5Uw8/49fa9A4eRiNFs/y4rWppCfGaFTLtvWifUgFUHntF1iqWcUjm7+pnaD7E
	/H/VPqMmrZpugNvYro6gDO6Cp92dgPwKqrjd44YqaFyfPawIeTQsAYxOMzS0lVLENL4hgC6dfUMoo
	ud2LBg5TJhmk9s3a3sSjPGa4aBbmLkR4z/JCUH30sh+3DviF6469JNSeoRzQNhGx3qVazav4BAs0W
	caHvn2wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLJU-0000000029F-1Ukm;
	Fri, 05 Jun 2026 03:33:40 +0000
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLJR-00000000283-0oSF
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 03:33:38 +0000
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-91578c374ecso124131285a.3
        for <kexec@lists.infradead.org>; Thu, 04 Jun 2026 20:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780630416; x=1781235216; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9VRMQ5Ef8ulqUN7FHiGBWdV1K/iIYqxWaAhgeSwRK0=;
        b=XLPZh+2OXf4aPZCu+ikWkVvUXLqi8WZU+Yg2vzByBPaJO1TE37MB48rVEpbrb3qdq9
         pxy1s01InB78FBG5vb1ba6gVqrJ+AmhQlilYqMKKc9ETIiAeWeJiMbaS/r79coDaONO0
         pM3Erqbk6wCz+Puj3nxTcNuZyFDAroQab+XoiQK90HvpED02JIRZI4PEiGiVTwtc77pa
         EwzX0VE74OLrUxK0f9nR7xRAgZUwmk8GyTEMhmHRQKaZHx7dIeZwVcqrQqwA/9m7F5jt
         HMvfSEHt6oNK9/1oCUF5Dk+USMAKWt3UgFrgDRBTRh0vv95JyGnRaNWjWXiV9XVFeX8g
         ZOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780630416; x=1781235216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J9VRMQ5Ef8ulqUN7FHiGBWdV1K/iIYqxWaAhgeSwRK0=;
        b=spuoYThQ4/X6+PIRjT3P3K5eCLI5uril+240HCO7fS/5ejgkKYVTSPx6GzIUmFoNWU
         DLxPf6FjeYyFkr6N8wXXDo5urZe7SzL93lDebw7RFrQBkWM48qskfWMgYvEf3WBio9/K
         TAFJmSIK9QCzl7hzicQLSguHEr31zbqiyYsEstzipBlQB5XYAuYQ/mgpwPGIWQQ3XMmd
         J7OVy84Qk2ymGlO8+syIoqD8d808861YqSUMSQR0d6Jg3CXQ5rbbdw9G1Ag1YAA5rfk5
         uk/BojrFL/nb3YupIAP1FUsJxzI/HEdphAFBEEXGL3FB3NtExx6NS1OD3YG762Nl53ys
         21ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ctPiVjBMIifpLRJ/EHolOa9bpeQfyGJFLL8nYCmQeTJD4LCDVkp8rDCxlVeqOkX+ecOwDOA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwRfKYq3t7npQE1mPgw9Cixlbhps0DVUtQsp0vY4dWwRexCehJ0
	neLSrH+DvJWqBThSAYM1jIP9Osi0zr7agVr1T0CxdFxmJWKarS266Vq3Y80OC1K00uk=
X-Gm-Gg: Acq92OFb3nT8D9Xdt8v3Y4aKfILaaD8gS5qEi4xbj8SheRE7LaBH2vl9svPcsO0sFFC
	2fGm6eNRjpAH+bAGw8MTDaHqKELkCxY/TkSA3BlxkHZs5OBQhxv29yCzAfncPwuI3RU9CxVH9Ti
	VL4IOI/IkhH5q0Ypi4FxgcuvA0ipP0oUai5WRhWLAnVmR1w2f0lUOAYCpGqOo4NPN9jlC2KIyj+
	wjOepi5VJf56sjYBtDxMDSReUOyRgjESzlK5klnbYf/2F1YAgPiymQqcE9eb71M7zZk1Afp2toy
	81+uDKrypB3Zbxst7IDcIi9AdH9XAhKOqX6+IDML4znu2pYY9FN5BV98SGEqYDZIqm4JDkQ+I8E
	ogdsEQlIh3R2ES+TuV7R8X+aMde1ycUZQYhuaTXzy3DoRo0MVu/0kdxvd7+8jR8UCP7aRoHtUQ8
	VcLy7mMiVOX8PqZT1NNg8ZeppRe+4uGtkbMQldr61DYIBSxmd9AOEPluC+uX85vg==
X-Received: by 2002:a05:620a:3910:b0:915:7f9f:8d97 with SMTP id af79cd13be357-915a9daef8bmr376847085a.53.1780630415906;
        Thu, 04 Jun 2026 20:33:35 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37c645sm743050785a.30.2026.06.04.20.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 20:33:35 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	jasonmiu@google.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	ran.xiaokai@zte.com.cn,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com
Subject: [RFC v1 5/9] kho: move kho_block.h to kho/block.h
Date: Fri,  5 Jun 2026 03:32:31 +0000
Message-ID: <20260605033235.717351-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605033235.717351-1-pasha.tatashin@soleen.com>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_203337_245685_9968BDB6 
X-CRM114-Status: UNSURE (   9.57  )
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

Move kho_block.h to kho/block.h, organizing it within the existing
kho directory structure as more KHO data structures are introduced.

This is a pure code movement patch; no logic or functional changes are
introduced.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/core-api/kho/index.rst       | 2 +-
 MAINTAINERS                                | 1 -
 include/linux/{kho_block.h => kho/block.h} | 2 +-
 kernel/liveupdate/kho_block.c              | 2 +-
 kernel/liveupdate/luo_internal.h           | 2 +-
 kernel/liveupdate/luo_session.c            | 2 +-
 6 files changed, 5 insertions(+), 6 deletions(-)
 rename include/linux/{kho_block.h => kho/block.h} (100%)

diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
index a10b10700fb9..4a5477221fe4 100644
--- a/Documentation/core-api/kho/index.rst
+++ b/Documentation/core-api/kho/index.rst
@@ -95,7 +95,7 @@ KHO Serialization Blocks API
 .. kernel-doc:: kernel/liveupdate/kho_block.c
   :doc: KHO Serialization Blocks
 
-.. kernel-doc:: include/linux/kho_block.h
+.. kernel-doc:: include/linux/kho/block.h
 
 .. kernel-doc:: kernel/liveupdate/kho_block.c
   :internal:
diff --git a/MAINTAINERS b/MAINTAINERS
index 920ba7622afa..9ec290e38b44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14208,7 +14208,6 @@ F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
 F:	include/linux/kexec_handover.h
 F:	include/linux/kho/
-F:	include/linux/kho_block.h
 F:	kernel/liveupdate/kexec_handover*
 F:	lib/test_kho.c
 F:	tools/testing/selftests/kho/
diff --git a/include/linux/kho_block.h b/include/linux/kho/block.h
similarity index 100%
rename from include/linux/kho_block.h
rename to include/linux/kho/block.h
index 93a7cc2be5f5..2b9d5a080a6a 100644
--- a/include/linux/kho_block.h
+++ b/include/linux/kho/block.h
@@ -7,9 +7,9 @@
 #ifndef _LINUX_KHO_BLOCK_H
 #define _LINUX_KHO_BLOCK_H
 
+#include <linux/kho/abi/block.h>
 #include <linux/list.h>
 #include <linux/types.h>
-#include <linux/kho/abi/block.h>
 
 /**
  * struct kho_block - Internal representation of a serialization block.
diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
index 0d2a342ef422..6cedcd36bfd2 100644
--- a/kernel/liveupdate/kho_block.c
+++ b/kernel/liveupdate/kho_block.c
@@ -23,7 +23,7 @@
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/block.h>
-#include <linux/kho_block.h>
+#include <linux/kho/block.h>
 #include <linux/slab.h>
 
 /*
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 64879ffe7378..349f6d141873 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -8,9 +8,9 @@
 #ifndef _LINUX_LUO_INTERNAL_H
 #define _LINUX_LUO_INTERNAL_H
 
+#include <linux/kho/block.h>
 #include <linux/liveupdate.h>
 #include <linux/uaccess.h>
-#include <linux/kho_block.h>
 
 struct luo_ucmd {
 	void __user *ubuffer;
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index b79b2a488974..01c0ccf09919 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -90,8 +90,8 @@
 #include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
-#include <linux/kho_block.h>
 #include <linux/kho/abi/luo.h>
+#include <linux/kho/block.h>
 #include <linux/list.h>
 #include <linux/liveupdate.h>
 #include <linux/mutex.h>
-- 
2.53.0


