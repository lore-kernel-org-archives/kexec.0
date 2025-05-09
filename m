Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACA1C3ABC3
	for <kexec@archiver.kernel.org>; Fri,  9 May 2025 08:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y0ylSxYIXWVF0HWz4x+lkfWER0XsKyy8d2lPgWpj2uQ=; b=xD8rVFrScmqSE9P8vRDiPelkJx
	22+K5tRahY052XmwKPzWPmnooJ6HOnSL6YiYFrFA02ZF+jEnujewJJu501P8LeomjN6HuwsPM2mBj
	8bc3bCJfbAiCxPazOaRFzTZyxYCKP6uDWGxZmOTvSD4mW3D2REE2DXolC0tIbfBBauvw6441XMzcq
	PdIrP73N9Ogu0lg1Ix1/Oc/lJA2DBIZhj1atOaVIZb7X+1IgaFDjEI4oenNXQC4hOexFj3Zzfou/a
	X9h5nlLqszmqqLLnGe6z//k8zJ0qHeOrKaNrEXAjUTBK/73vkszO4jjxwI3hr8otCO8QXn3lrp1/T
	tBoPwHlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDIvM-00000002tmH-03md;
	Fri, 09 May 2025 08:17:40 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDIS9-00000002nuB-3vCE
	for kexec@bombadil.infradead.org;
	Fri, 09 May 2025 07:47:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y0ylSxYIXWVF0HWz4x+lkfWER0XsKyy8d2lPgWpj2uQ=; b=Qx71+NjKqbmjja2qMyGGZwQiIa
	BEY6lZyCbaJswGakZyBBe0DFignBM7tPmbIahsNJ/0QKih+D4+MImr4Mcq2hG66qZ5urHBXa/1BhO
	LrPxBoaJrlbh/vbAioqw/WVZxIKhKXejuzcfepl0lixQcTIARggbBxJGq8zLGOsN6Zc9rulFLXfkf
	K5Wso6Upq7LhEF7fhliMHlLl/+EYj6+bO/NIJ7oaCGA+iQeFOwx4kk+KbIsnC7KHqlkmisReg3fvy
	zCq3ePZh1HItNqDNv/zubLpUJx0OSMGqxxJa6o0FSNHzdVfyg8fXqQg8uHu7QSKVp8VN3uH6NHbK1
	4EghZxtw==;
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uDIRv-0000000GEfD-0ni7
	for kexec@lists.infradead.org;
	Fri, 09 May 2025 07:47:24 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-30c371c34e7so940346a91.1
        for <kexec@lists.infradead.org>; Fri, 09 May 2025 00:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746776829; x=1747381629; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0ylSxYIXWVF0HWz4x+lkfWER0XsKyy8d2lPgWpj2uQ=;
        b=fY+pBBSavQm0cW+5oYEdcRGDrbu5bSqYNLuXu+J1kUia+kzv22RUmlTPYolLXgQMUs
         NUeR8wllHKCoScA37xtnwg1Zgyr6YCE7J0dz1WXtnMVQHicGm+2pli3oM8a2FpfgH6Qm
         BQ1wgvNHo2DcKkMXCIueLoCQsJk8r+5SIfB9C+iVGlfDBsdZBldMBEBpHyYeNYlNuSjK
         X26TjnfP/o2SmNoLX/6WUJ5YnV+9voZ1EKyObrOmeO94xVsd3yqiamvPLlfj0u/3IdQ5
         CRHADlM+fGsILzOkiXjZxOCMFn3vPzCnPHmW3DKGYrwvoEniJxTMkJQ0+pTH5Tq3gSAg
         31dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746776829; x=1747381629;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0ylSxYIXWVF0HWz4x+lkfWER0XsKyy8d2lPgWpj2uQ=;
        b=fVC2bVmUZ8H38KAZYQsN9AwYXm8YbBnxKDELX1mfY8sMHTYwHNdyPypyc4ujzrtTqn
         FZ1qKL78Yr0e7lRBcZ1F2YwjOYXu55tKvcT6EGRijSu8PeJjvAQH/MjBPnUpQ58/XQ6N
         NOGj8KTKjLMItoiqkMiENW4eOyMmvJlJBrkKiFsHG8zDYPGQI+52c5PcFw43NT+bZY6L
         5bgEETbEvf+4ejQTQ+2WyH3HjcTWd99bZ7LUT1vO7zEDDH1wCyzJKnf70MhmXEE7F9G0
         6LtJILDwylRk/cKFV9EDA1wzFXSKbkun3EpKh/fCopHSQ2wZxjK/yvHKhROuymgHrlzG
         159Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtxmgzhvVm75e1f6vEUMKpUiHmiAjGVasJ90y/qUPr2i1Msp3R9a4eldAWqyTcgxap4kp7lw==@lists.infradead.org
X-Gm-Message-State: AOJu0YywxVt/ZBUQKnXVSIUeN0FauKXieUsBL9EhnoAVjIqy9pNDOxaX
	96s8XdIl7SQ4HPYsuPnslJ96QqWmSSsgseM9QeNdDJRiW3f9j0kCImeZclST+g/pLWrwe3f5FOx
	Ve7/sR4usRre2juTR5A==
X-Google-Smtp-Source: AGHT+IFcU+yi4lxCzXOaIz4vfStLTel++2NEV8ETDNWjCPUfioyFnhkypPSIgZhYN5NQ0+YhGSBWxvTzxUTVFzWV
X-Received: from plez17.prod.google.com ([2002:a17:902:ccd1:b0:220:e022:1e84])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e744:b0:22d:b240:34c9 with SMTP id d9443c01a7336-22fc91a9093mr42800435ad.53.1746776829073;
 Fri, 09 May 2025 00:47:09 -0700 (PDT)
Date: Fri,  9 May 2025 00:46:26 -0700
In-Reply-To: <20250509074635.3187114-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250509074635.3187114-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250509074635.3187114-9-changyuanl@google.com>
Subject: [PATCH v8 08/17] kexec: add config option for KHO
From: Changyuan Lyu <changyuanl@google.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, 
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, 
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org, 
	Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_084721_338594_D53F6740 
X-CRM114-Status: GOOD (  11.03  )
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
2.49.0.1015.ga840276032-goog


