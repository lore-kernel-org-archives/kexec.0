Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCF6C35FFF
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UkcR0SU+CU01cj/UMVFVKIzr3SF+GMypT0ANn4wKrhE=; b=VjPNrZZ997RCMaUnNY8jm/F4Vs
	bs2vcg1gyGstfxvHMngkG56iIdWAl1pddmhVlyMGjMcLBht4mrcX8JDsvZ9lTcmZhhGnqFXaMumQT
	HvV4bRxHHNLLg2gn02EPwOYulxuqwXXpI/MZ8wgoMQBBQPSYCYPxFkqlc4Djubuhvq5Gq7HZkFHq+
	2PDtPz7hv8sVWS0dDbggkCyYw7lilJg2Dd9jtCP9M8zzq8vgo+4v7tDOi1+ZaWLlDzL5dD2UZq8No
	/MMxLdqmk8U23wxA4GWjOZGMenPFL7IpA3bHRMpSuYxsDd0q9kbM3psmFok3pTNtK1cDelhpJ5kyA
	1ijTIDkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHS4-0000000CUBo-45Bk;
	Thu, 20 Mar 2025 15:04:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv58y-0000000Akig-3VqW
	for kexec@bombadil.infradead.org;
	Thu, 20 Mar 2025 01:56:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UkcR0SU+CU01cj/UMVFVKIzr3SF+GMypT0ANn4wKrhE=; b=SR6KHlhEJ+p1piBZMUfisFpz9d
	8DHwJeGkyCe8mEoTU1iSHux9gZqqWirKAgpYPb5Fn/kc2q2lLkFPW2eohq2RDhOPc4duKlN2i47sl
	PcPl+Suy5Os9Aw9+ulyIyG8Ov9hB/FAob+B4CYNxQI1Dxc6nhW8OUiJybSUCgspd33+5PaL+e9L3N
	tzjVxcq1uxn8nFXK52r+Fkr4FVkKvL23trxic7DJ7bdLTfdGOXhPPA6uS2v29/qSnNpFN7s3cvIXW
	iB4RprOLM63i4awEj+Rvcv5CjR4hu/YHIVPvMJ6zd08qZ/UvtgMCp7SiNUENLVFuKLGr6e/BHG/ZS
	SPi3VhTQ==;
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv58v-000000043e3-2WjB
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 01:56:23 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2240a96112fso2886705ad.2
        for <kexec@lists.infradead.org>; Wed, 19 Mar 2025 18:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435777; x=1743040577; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UkcR0SU+CU01cj/UMVFVKIzr3SF+GMypT0ANn4wKrhE=;
        b=VEwm2nbOALa3ehfas/TZLnX78O3ou5qJFB4BBknixkcedGU0g8Ktzcfn7pxfgVAYC6
         iUzDOBdfFjOMUiZQqtIUnOBxVnG9Uf1fEdBOfJENEEMVd1KbAdCsLVgkq7T06zyAKkBc
         l9Z55qXli+yxuGM7aN9q4E9NmZwH7+slDG70950fweygNN21Hv3lItRRz1Fegdzzyw0k
         +ua0I8728mtm/zv6uJVPTwBwvHjQaBzQLqup/mnm1ZPiyghmFb41MYFM3fHnPNc0RSzY
         N8UV+jBC/L2MEAKrWEp4jhSOnhhhQPP6fKn9g1HMu8V37s0iIjfMIhyyvMMlNIc9PQRz
         jkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435777; x=1743040577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkcR0SU+CU01cj/UMVFVKIzr3SF+GMypT0ANn4wKrhE=;
        b=Jqr6IZ+i+ZxbyJ0kKo96c6n7aeAeJMLPISFOma7OPPHDE0pyTnivUmzkNvTAyFPmxC
         aZVmCa75Yz5QPRY3vJqPXEeiX5L1tGgi5l5VVXlNjRkcwGeOuiE/qve8PdSd+EkoHwbF
         jH7NKEv67wRE3YOvk0JCeGqczJzbCaEXYZk6/LhLiIVXS3LaNayx99tj4ujTAvMfIRst
         2kxjvOeEq8DRg0o5P+BOXBZg04zLd4NE9eX59gyxF8B/4insuhEBhR0kxIKuX3XWnyg4
         bX9J4v+Pn6kLyUndkLsEDqS/o2va0OBIU7QyFn/qrawcUX0Ga+DsgEDMo1JWXpMsUjH2
         AldA==
X-Forwarded-Encrypted: i=1; AJvYcCV0dxX8s5djFwmlvHSH4XgENXiCtzLzHpAZHSggluWCokEYd7dDXBDZ1sbLPvpRYNxNdwlUlA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy/LFkXINdT62jSa1PXtsEhlSB4jyU6227moZ1dUH/nao8QlNqR
	gve7/TJcsoxvTuw2nijdtktncX3Tx8rphw/l0zWgtGSOiEhprylnp1Hoy407fVJ9oT6rv1oMiCE
	IyMFEGXU8shTADR+V4w==
X-Google-Smtp-Source: AGHT+IEq833KvKiO9EApYrAEuf1UTsJySLJu5CjTMNPxyZpCp1rooyCfDuUQ3lxBHQoctugFxssTdHmFh/kEHnmc
X-Received: from plsq4.prod.google.com ([2002:a17:902:bd84:b0:223:3ab:e4a0])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e801:b0:21f:c67:a68a with SMTP id d9443c01a7336-22649a2ee71mr75511855ad.31.1742435777590;
 Wed, 19 Mar 2025 18:56:17 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:46 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-12-changyuanl@google.com>
Subject: [PATCH v5 11/16] kexec: add config option for KHO
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_015621_897072_5540F22D 
X-CRM114-Status: GOOD (  11.06  )
X-Mailman-Approved-At: Thu, 20 Mar 2025 08:04:44 -0700
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
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 kernel/Kconfig.kexec | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 4d111f871951..57db99e758a8 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -95,6 +95,21 @@ config KEXEC_JUMP
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
+	select XXHASH
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
2.48.1.711.g2feabab25a-goog


