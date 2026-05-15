Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D402CD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6v1a1pQ4RntgauZdGQ/AgmAZlKsDK24ag7JDuVxfuOw=; b=FLSAJRDscqgVOflswA+EoDxM+Z
	D3HgWs09uMTi7XYCKL7dS6qOY0asLxWXkP6L77Gn9jqSAM5isMEHIdlNC9x353/PMRsWl3ehXhazC
	/lSe+FMUH1cIPJE2QRyRSpu/ofnamSDnIY4fGJEym0QuvJZi+opgakie7nchhJbptXYYvW3hUH2ba
	V4DIE38xJ2k9F+zxhbPSRIgRMSsQ7lSfQurU4BS8iUM8p+qlkbfm5UT/G8p/OCtq+mKXvx4Xyxkjf
	QuzeRvkHou/XRzSD1wHLQohy1l4F4g5xguncXOLzTZDJ2lM+cFtMBYhXyJzG3ySPEV83+f8xK/aWA
	XwBlphwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzzV-00000009Vem-0Fvz;
	Fri, 15 May 2026 21:22:41 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzzS-00000009Ve3-0Oyj
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:22:39 +0000
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-47c918c62b4so293132b6e.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778880157; x=1779484957; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6v1a1pQ4RntgauZdGQ/AgmAZlKsDK24ag7JDuVxfuOw=;
        b=oRN1vuspbrqCCGZgwo8N1qEpjFpbxHe06hDrPjf6xubzcgBxLVTqt8SRolrGF4vYvx
         +hOZZkheFmUcGpKOX1busAvHRf12YX0UCDiNdvJHzlHUjNG+hOcVSXfOWrYIdXK8M3Iq
         30lV5lnPmYJJnZ11p9U8ec+GSOpy+tOHYYOBFpP8fzur4jEV8hkiyObKs7TAm9QPqArO
         5o/HcFbufvyJlBYw1vgPkyoVTuzXahinTB8nOqdO0dLssT9xbWoSE44VrE0721xgEek1
         v1FeLOBXe7xQAqIx6eVcidU4ZOjR0DQT3IEH/mYjI62OPgvRnHhDS1htnfAqmWgE2EDk
         fgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778880157; x=1779484957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6v1a1pQ4RntgauZdGQ/AgmAZlKsDK24ag7JDuVxfuOw=;
        b=rDqM0eA53CE+6CpGBVHiQzg2+enCQV4KOllxKPMwCNmv26ccCcyH0NkD43MAkOkAq7
         FnyPp5V08DiLf/TpdsvBuU4yAY93VkripxqFTtjoTsCsDL+g3sFQ2Iepv4h8UzX7jJbg
         t6LaKKfMPAtdGMA94P0DSYfQONruafxpxloVngAUHRiscEaRydGCN2QvA3SxGKHLlHiT
         jUIl2ES4XvB5KqU9LHjZzDK+43aP8vU6gYNdJcZQ06ppRjbhr/4P0FKs+Uz4ta6OuOF2
         Gd4uAEIV4CJzeZxY/Udmbdd5PuQP3OytiaT0iDic09wftvlWjg/j3XpGpX19qVdU+iRN
         cLVA==
X-Forwarded-Encrypted: i=1; AFNElJ9SofRn8xmqxvMwolp1mNF9ZddLpDiJvqgLamImaIUqAaNQCocsws6xsGsS3Im3Ac6flFT3Mw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzHPJRVrsOo70P62K8D5Hxog8Y0D0Mh7WnPHavQDs1+fucapgb8
	F5vSGxnXfzyNAFFb43gXjmcN0y72nHkDn/7VxiFFiYcwc/SxuXwYkJ9xQXrVj57v
X-Gm-Gg: Acq92OF4D2f7eHpwxsHGInd9syg5hCN4W9LIh+uOGxC99yR5iW696MXK0uJZFvA+fyC
	4JVg0kGOCXImsOSS7CV7csCIpCUYQKL+cAbjTs/hQbFfISRQb8l/r3IloygvjRWipPCFFPDHLPK
	josz/yRcx4ITZxTdHRz4zmOdYD9gjs3lWc4yxq2maMn+VbTdUoij5w5iI9D7k5ZiKlTt0bl40PF
	Gqg4WLUdFMSq6bGyvnEtSORvHd7eBmF+rl20I88bdxXZdv3nMjiSBhflzxC2glzM7ZGxkAOOc/K
	btHhODIvbn5RcMIu6TonOdi8mHTGdNVueTpzMG1mCiw9o2xgJs/F6XU+HMkUDPPnoqZbiahIPQq
	FN2ywVgAz1JyAGgxYukiSFyCGpIKTtwVD6ujO2eLSwI/NER83RlIiN/uP3mCCnLqqQ40VdyxGtG
	y1S8W9fDjDwBBMkAVpGwAxHue2TwcPxc+rt7Qt3qqydQ==
X-Received: by 2002:a05:7300:818b:b0:2be:7885:31df with SMTP id 5a478bee46e88-30398618b3fmr3091136eec.17.1778879729276;
        Fri, 15 May 2026 14:15:29 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2ea6dsm8268038eec.4.2026.05.15.14.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:29 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 27/38] x86: Add early SHA-256 support for Secure Launch early measurements
Date: Fri, 15 May 2026 14:13:59 -0700
Message-ID: <20260515211410.31440-28-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_142238_142540_70B39BAA 
X-CRM114-Status: GOOD (  11.54  )
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

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The SHA-256 algorithm is necessary to measure configuration information
into the TPM as early as possible before using the values. This
implementation uses the established approach of #including the SHA-256
library directly in the early boot code.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/boot/startup/Makefile     | 1 +
 arch/x86/boot/startup/lib-sha256.c | 6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 arch/x86/boot/startup/lib-sha256.c

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index e283ee4c1f45..071a90f23ae0 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
 
 slaunch-objs			+= lib-sha1.o
+slaunch-objs			+= lib-sha256.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= $(slaunch-objs)
 
 pi-objs				:= $(patsubst %.o,$(obj)/%.o,$(obj-y))
diff --git a/arch/x86/boot/startup/lib-sha256.c b/arch/x86/boot/startup/lib-sha256.c
new file mode 100644
index 000000000000..f60df97f9244
--- /dev/null
+++ b/arch/x86/boot/startup/lib-sha256.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ */
+
+#include "../../../../lib/crypto/sha256.c"
-- 
2.47.3


