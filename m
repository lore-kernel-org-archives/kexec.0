Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C6ACD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zqo7CRqxUyGu2ximwHeynWdE4uCktJ1VQ9YKgYjfZfU=; b=sK7NXPUcHo/tSyR0mpSuMobf5k
	B6bkVt4HTEne5aHAa7MLCPF09WVVFVYgFq0PQtPha1KQhKiKJr46yWOC7FzLw5VxzQ3ywIm6AkOYT
	CxqMoEwlzhLZymdrzrMkj/eSw+2cOhjlpGt843//oAx6oFL0YeyB0lNEwtxttU7cfkZUQmjIcsKC2
	ihaYBC4PkDSs4ve4Eyr72sxLncpzeRm2usrxNoxpqepep9VImnTODWJUpsLcYWxo9vGNDqoiwET6O
	iLatWzaYpDq8Jfm+V8F402vbBRMPMQ/ZMRnAFlnXRFbvfJ33rr4IpmVOiVz5tZ9laCKL4S80y9/dH
	kR1fa1Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsX-00000009Tyq-2zcD;
	Fri, 15 May 2026 21:15:29 +0000
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsV-00000009TvQ-0i9Z
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:15:28 +0000
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-2f7020a928eso392757eec.1
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879726; x=1779484526; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqo7CRqxUyGu2ximwHeynWdE4uCktJ1VQ9YKgYjfZfU=;
        b=FdSOBP7Il3II8CGWwK3h836Y/af/9sf2jmU6bM0WvBYeVpNHWlMjF/8BngJm7FDTms
         +9GBw5MNk8DSOwu29u+WiPwxpM78OA7MyNOv/jtzJhum0qaz7/xajzRG7duUEL4xPQx0
         4fkpTn4z7z0AFjTX2/O7Qs0t1Qn732kM3lC8mc7rzDn48JlJYkTngssey93ZtMzSbFGi
         CUEGkZ7QjdSgW2TzNThSCyS7eEWMCIDCLjKZd9u/EU/0IqYovKYYqRogHRYsRV/kaNoh
         mVzLB9xyQKRnQpdQcqWqybnYDDujBN83TImsZ4gOX3EJucE4d57UiOshCUEVmT7mMSkI
         tvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879726; x=1779484526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zqo7CRqxUyGu2ximwHeynWdE4uCktJ1VQ9YKgYjfZfU=;
        b=bTdoa/1+YQMf+NBXy9Zd9adJgXXE/hu5txCAEhu6s2dcmdEjEjXvlkDRmQ9axDlVXn
         w6aKKYAwhRKZEjd12Wu1hoLM1bxBHm66B1hEFAZZcMWS7ubet7CsHrUYo6sryeUdiaR5
         LdhdibFBAwyP9qEA7OwHmltzu/nHp1PbsrPhfg+ySP99uCHa57zLe7T4/Ei4ovGMwhVN
         VsImKTn14PYXerJi+kTYjBLQE/LyU7t6c0d9GD30dVit7Z7eGE1ElyLmQFGxuPspqNgl
         daq7+QZvSSUCXd/641hdbaRrr39Msg+XemRh0iMAeT85cDmNBJyPTVoUl7YXEFBop1HV
         BADg==
X-Forwarded-Encrypted: i=1; AFNElJ+9FQu5UA5kVC4K+/hwDeJ6756Ctwp1wHd4fgolprNXYmVMSurIwyPBz7afW4fwcv/VFwmlpg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzUGtALFxIfFjUxeFtp8ZMEv/Hqoo8qxFSWCmWgBUeic/LJZMnb
	KCknkrhaMkahhAiBffiA4JSyFryxYOOpBq7O2hWF0Y/T4R7fCnXnY3w8
X-Gm-Gg: Acq92OEj62Ica6tS+pQRkc4tO2jl9k/mavworg0zu+P+XZt+8ScULeH+8YPasbbeGMC
	BqJT5FAeAT70P8KpBWOI23sKhJT7geoOJMVufYojnLW0bhQQs0bV71nvZVMyTk1oNVlcqXQqIhH
	4rgazLynwpBO1dEJokvg0Ix+cR4j3rKso8TWcn1oyq9m/73lwdgK4u/k5nV2Q1kWJxYsAVDvCJq
	Rfi2j86t2hrJkJfVzumn8Mj2BWXGpB2EDxaF0+nxn3MQuulTV6sObgr7wjOKrSoIP/3wIWlgGRo
	VnHmcd26eG8MstKlYKzjYX94ogobido5HgqO/sqnrIQcpT2Q8RqFwiOZANSG7meEj3mwQkbK/YJ
	feX8afNPVBieD6Gd7E0frFsmpnWvre+O1uMDC/mYNQUELYU5WDgLpt6ErzJa8LToBwvUzYKzS0d
	txzc/vEfomhOk+KrqAtlO+8H/G7s/qu7c=
X-Received: by 2002:a05:7300:fb83:b0:2de:cc07:e8b with SMTP id 5a478bee46e88-3039818afa7mr2863582eec.1.1778879726369;
        Fri, 15 May 2026 14:15:26 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302977a9474sm8155633eec.25.2026.05.15.14.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:25 -0700 (PDT)
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
Subject: [PATCH v16 26/38] x86: Add early SHA-1 support for Secure Launch early measurements
Date: Fri, 15 May 2026 14:13:58 -0700
Message-ID: <20260515211410.31440-27-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141527_225227_6AA0CC5F 
X-CRM114-Status: GOOD (  14.55  )
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

Secure Launch is written to be compliant with the Intel TXT Measured
Launch Developer's Guide. The MLE Guide dictates that the system can be
configured to use both the SHA-1 and SHA-2 hashing algorithms.

Regardless of the preference towards SHA-2, if the firmware elected to
start with the SHA-1 and SHA-2 banks active and the dynamic launch was
configured to include SHA-1, Secure Launch is obligated to record
measurements for all algorithms requested in the launch configuration.

The user environment or the integrity management does not desire to use
SHA-1, it is free to just ignore the SHA-1 bank in any integrity operation
with the TPM. If there is a larger concern about the SHA-1 bank being
active, it is free to deliberately cap the SHA-1 PCRs, recording the
event in the DRTM log.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/boot/startup/Makefile   | 4 ++++
 arch/x86/boot/startup/lib-sha1.c | 6 ++++++
 2 files changed, 10 insertions(+)
 create mode 100644 arch/x86/boot/startup/lib-sha1.c

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 5e499cfb29b5..e283ee4c1f45 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -20,6 +20,10 @@ KCOV_INSTRUMENT	:= n
 
 obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
+
+slaunch-objs			+= lib-sha1.o
+obj-$(CONFIG_SECURE_LAUNCH)	+= $(slaunch-objs)
+
 pi-objs				:= $(patsubst %.o,$(obj)/%.o,$(obj-y))
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
diff --git a/arch/x86/boot/startup/lib-sha1.c b/arch/x86/boot/startup/lib-sha1.c
new file mode 100644
index 000000000000..8d679d12f6bf
--- /dev/null
+++ b/arch/x86/boot/startup/lib-sha1.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ */
+
+#include "../../../../lib/crypto/sha1.c"
-- 
2.47.3


