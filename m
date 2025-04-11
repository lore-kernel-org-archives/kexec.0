Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5FFC36010
	for <kexec@archiver.kernel.org>; Fri, 11 Apr 2025 05:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R+F5ZVtp8VQ2jTtukTzm1g0sjnjetiGa2oNQPDhGJdk=; b=GJHpki32s3sElwsw+snbToDYdO
	X5zgKYi29t4HIwgm2SIG9Md3DpjMLyjln9Cjrlz/RiDdbg+PEPy57ELdENbb1KNyzZNXMbgT2VQd1
	jJCe+laKSiUnxdORPICHY6H0xoUZHsI9f8iBzVOn8y5mtZhq1OEgIHuIBT5qRY4DQDlTh/r19eG2B
	Ik9YZs0s3VVq/dkoEeSwPSD1pBGM0n1tszd6NAwgIKYdCDbzxfzOrwIi0xK54owNBPgfEpFtguHxB
	CGcd3WYMZXCVQzRvKDMz6jV2BFgIekMTmmNAkULNSkn/KteITrC8XTmbnBDOovmk6CJxqFb8fqWUn
	MW2vqwWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u37IP-0000000CcEE-3gOq;
	Fri, 11 Apr 2025 05:51:21 +0000
Received: from mail-oa1-x49.google.com ([2001:4860:4864:20::49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3762-0000000CYWr-3XLc
	for kexec@lists.infradead.org;
	Fri, 11 Apr 2025 05:38:36 +0000
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-2c8786a89d3so426972fac.0
        for <kexec@lists.infradead.org>; Thu, 10 Apr 2025 22:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744349913; x=1744954713; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+F5ZVtp8VQ2jTtukTzm1g0sjnjetiGa2oNQPDhGJdk=;
        b=ZeOvR5Brk7ttV4VtMuPjpUqprhpakuxN+l5DTv4uga2K5yHEcLTP1vrE90Sl74yRzv
         MY9OOInuOdSSCj3nSz8LEkjCteL3EnjGfXQ/9xYUx6wiA/niMNigAkLBtfozYyrfRFAU
         GP0NOp9ipITK0Hil40bF+nOpZ3OqC2Q2HD8cwzCg9IjXc/rJKM/eW4kS4Da/Rnj0y9J/
         9fipopKBePOAr+5/wI4Lt9cS0gRDEyJeHIFdPemY+rHZiOgn2R3wSXTOA6d6TyGNqrR+
         DYBUBU4mt9/GruvAptUtQ7k4lcsKeFrtZuCdGaCv/C2IuRq5nfqt/2nwZvn0G8V6VHxQ
         fRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744349913; x=1744954713;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+F5ZVtp8VQ2jTtukTzm1g0sjnjetiGa2oNQPDhGJdk=;
        b=A/oTb0ek70v7W+RFPpvO/qopRFeysmxMqHCUJVIE36EKq/7Arnry3qjGRY+78fvpKO
         T8wcPEB58dwRuTRjeDk4cqyt9iL+t86BMTklHM0eL/MRwaC/bTUwUkou7YC7uOl42Qvz
         SvMBJ9XNppyDNLmLd6gs2/ufB85pGj/QICu2sGBGme9p6eE5+krcIt8+ZGumKvjFSwlH
         ARLiFMP5lm1l8PcF//paqamDCFKlWlBqlU+9pDsieRz/ELc+h8GXy4Hq0+dynqVUFhEz
         qGKlktBCiYLS37b3TC42UZ0mC+pF4F5hoTOWsnJ+gYY5nnQ3aqQLEL8zV7Bo6FOJvzwR
         WwkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZUeqb4UPon+193GtEwiRH1cipGFAmRAMus/dLAmFAxBH8mJUFG3U1SELzCrY4gYE9mWeFBw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzlvR27EK6/ztHnnyK+QhDSbrmMpLsCNBJJuoagagawi089Qp2q
	Rmi9T/h0Fd/Z/1/QPB33bjW1GSWbOBAorqd0KFeXaSVWSLdzJ86KTLLXpW+u4WXMNq1ivwVYweP
	vsDFdfmMoce3ST9MwDQ==
X-Google-Smtp-Source: AGHT+IEjpGd8eC8T8F34QaHuVI3jNyHvNCtvTu5MIil37ui6UPNb1k9rZZ5tsoZfvaAkADx2c261Byn0pKs5T0Sn
X-Received: from oabwh16.prod.google.com ([2002:a05:6871:a690:b0:2c2:13d6:cf76])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:7a8b:b0:2c1:650b:fc86 with SMTP id 586e51a60fabf-2d0d5c2ef03mr764210fac.1.1744349913649;
 Thu, 10 Apr 2025 22:38:33 -0700 (PDT)
Date: Thu, 10 Apr 2025 22:37:39 -0700
In-Reply-To: <20250411053745.1817356-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250411053745.1817356-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411053745.1817356-9-changyuanl@google.com>
Subject: [PATCH v6 08/14] kexec: add config option for KHO
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com, 
	graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com, 
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de, robh@kernel.org, 
	rostedt@goodmis.org, rppt@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	will@kernel.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_223834_889130_D5723B02 
X-CRM114-Status: GOOD (  10.52  )
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

From: Alexander Graf <graf@amazon.com>

We have all generic code in place now to support Kexec with KHO. This
patch adds a config option that depends on architecture support to
enable KHO support.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 kernel/Kconfig.kexec | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 4d111f8719516..4fa212909d699 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -95,6 +95,20 @@ config KEXEC_JUMP
 	  Jump between original kernel and kexeced kernel and invoke
 	  code in physical address mode via KEXEC
 
+config KEXEC_HANDOVER
+	bool "kexec handover"
+	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
+	select MEMBLOCK_KHO_SCRATCH
+	select KEXEC_FILE
+	select DEBUG_FS
+	select LIBFDT
+	select CMA
+	help
+	  Allow kexec to hand over state across kernels by generating and
+	  passing additional metadata to the target kernel. This is useful
+	  to keep data or state alive across the kexec. For this to work,
+	  both source and target kernels need to have this option enabled.
+
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	default ARCH_DEFAULT_CRASH_DUMP
-- 
2.49.0.604.gff1f9ca942-goog


