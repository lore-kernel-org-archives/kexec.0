Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D38ECD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aF0BH6dZpM5RACWLo6N4NcvxHw87HpE9a7jatFY2Xnk=; b=ff1koqxGddNGZbJ4kh3xu1zcCn
	BkMERxq982FXqY9ZcmiiyiBzlEzxD+YdnKfbLTryVPEnGepGcbyyOGg8AIfOoahy4XzEvNBRTbgO2
	mdjX2roNTZoRyP2aKp5Oc72niAN5OAEyMm9MOv71BWf91kXjTX3zum7twkHtxklHtVUqPphBClo3t
	kn0tLbsBo0mTDZdG8QpgL4Aghk3vPXC1IeBD5WB7V3I+FLoZGvjfZtloH5YnHp8Dd3/7y7vIbViPC
	iTBVsi4dSyOiUe92UdsLEb8HGV1AFKlY8++U9+tH68hn5Y2gRSRwLJuJnJ+E1/xR1UkInFGvyvi5V
	2jsi2G3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzse-00000009U4h-3puV;
	Fri, 15 May 2026 21:15:36 +0000
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsa-00000009U1n-3Q3n
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:15:35 +0000
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-12c1a170a50so288801c88.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879732; x=1779484532; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF0BH6dZpM5RACWLo6N4NcvxHw87HpE9a7jatFY2Xnk=;
        b=S59HdEasGOffR6+wdiUnpfB/2XlnlNQv7Dr6wXjWnZpSYO20qIWBUDXX/ib08CGLLq
         BF6FmcjAzsU1AKpVdo1gOf9D2GxeV+74Y9xlysValjyBREJEzW1tdkjH+w03ZaVSs7V6
         i9Y6aaN4ObRpcSAhwbtbayJN3jkPFyXAkic/KVhU6teTOi7YbRKUR/BJd8nJ6PKbB1rU
         +WSflQDhGfoiksYIOsdOb2gHMtnMW6FrYYT0grj7xnPzGe4+VDvfA8W8+dLi4y0wdacI
         Z9G1gL/IKq+6tjHuDUQIk/l7ewxsh1zALfSbwbI0e8XC6kR17BCaC9hLDxKUkCDdMsAz
         bSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879732; x=1779484532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aF0BH6dZpM5RACWLo6N4NcvxHw87HpE9a7jatFY2Xnk=;
        b=W5mVeOFKmbz5kIf9fXbuTTIlQir8CxGjjFi1TiiAps+WoHqAHGIeNHZs/n6INfNhbS
         2wex+qtChUGgqeObpCZ2+6SOtpjiKxZ0qtYSxN3iO+MZ5G9CgSKyDBosu4a/FmWfeJ95
         MkjJNz8BiRPX8xkeeFqzLDF2A1IFZCRW843DfVBG8cBHy16OsToICboUdQweAasoxhJN
         4T+gsh4oYtW5noYOGTJVEwVueHYeOkKmy4d0SjMjC8s+QZYbxuM7b2IO1Lv+HRCWQLAq
         DPBdi00QfmuoliPkvpA2edCF1kUqzF0BeoKgGe6Hn4t/TSDuJqLx7yiLB4Q9A8ASp2O4
         u2Yg==
X-Forwarded-Encrypted: i=1; AFNElJ9d9TBDJwFk1eQNie+/2KHveOgU8kHB5KkpIsfZYdzj1ABTXWs5Ol2LtTBosvSgbrll2MgRcg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwVt/HcSdCZSkbCA9iYh5H7gTmUdgzMiNlbxWn0nj3M88e0H5QO
	coUpoYs90Ox1bkGVlmhdFzjfmgAQjebUE3vD4YL4I1VgPcyY1mhSgpxC
X-Gm-Gg: Acq92OGUmFtMP9jp7nYj+//p8Mj820DWtr0qDSpap8m0zrqMdbE2UDvaMVzN7hPoY5n
	p8+AhzRFkbdUNWlAHyGTeUiaq2AQvHgxLQE4QKGR+4dAvFNcBGABrRIhWg2wHrTAxOw8A5yBAxB
	Mv+NtPHSp1vh+8wGSL1DfIZKTgjUhP28FZnhwKIMDG77DO1ckFa8hpueIml2RK9cEBNlZEYyuBv
	VW3ROsBaX+AwpFiytUsRrAktYds0/vdXas04OHt0vBR/C3nFO4zj2YJrL/vRAgggPncMEubljpz
	AAX+bBUk8KVtPdEhCag5/A6TEjnAWLgnqleM9m/y3+jBCQHmlDPKKzIrfl6U1IXB5s3AlOILFJH
	INLm2D5l0DMm4+Y4Jf7Kdux6ePqcnbdycur7tK4dWpaPo7+BJZ/Az7rWStyxzsT/8uzxlSO3tEA
	/7uAs4Cgh/dBeHpJm4anzYDN48YJzDepllDpT6YltnSA==
X-Received: by 2002:a05:7022:6621:b0:134:a710:d908 with SMTP id a92af1059eb24-1350451887emr2398095c88.13.1778879732067;
        Fri, 15 May 2026 14:15:32 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a618sm11245224c88.12.2026.05.15.14.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:31 -0700 (PDT)
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
Subject: [PATCH v16 28/38] x86: Add early SHA-384/512 support for Secure Launch early measurements
Date: Fri, 15 May 2026 14:14:00 -0700
Message-ID: <20260515211410.31440-29-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141532_883292_EEDC0B6A 
X-CRM114-Status: GOOD (  12.16  )
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

On newer TPM 2 implementations, SHA 384 and 512 banks may be available
for use. If these banks are enabled in firmware, they will be used for
the Dynamic Launch. The DLME will also use these algorithms to measure
configuration information into the TPM as early as possible before using
the values. This implementation uses the established approach of #including
the SHA-512 library directly in the early boot code.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/boot/startup/Makefile     | 1 +
 arch/x86/boot/startup/lib-sha512.c | 6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 arch/x86/boot/startup/lib-sha512.c

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 071a90f23ae0..527cba7e4560 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
 
 slaunch-objs			+= lib-sha1.o
 slaunch-objs			+= lib-sha256.o
+slaunch-objs			+= lib-sha512.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= $(slaunch-objs)
 
 pi-objs				:= $(patsubst %.o,$(obj)/%.o,$(obj-y))
diff --git a/arch/x86/boot/startup/lib-sha512.c b/arch/x86/boot/startup/lib-sha512.c
new file mode 100644
index 000000000000..2afd5c5935cd
--- /dev/null
+++ b/arch/x86/boot/startup/lib-sha512.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ */
+
+#include "../../../../lib/crypto/sha512.c"
-- 
2.47.3


