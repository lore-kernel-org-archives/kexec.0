Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9F7C3ABC3
	for <kexec@archiver.kernel.org>; Fri,  9 May 2025 08:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BTLAwJfpzTnDn2tZfb8KpMGtzN7vq08hC8THCvjwurw=; b=yn9Pxk4qaHkdiA0K7NB/nJZe41
	kIMMHVn+QXuk6HNtzWsB6/XVbZhqdXu5iKs0Xs+P1gONFnJr0BGEBBNvSaXsF7kPV5pdcq00pQ25Q
	V8oD9QnW35VcgYEPR40cRNLMsOtlyQGNeDJYc4yxD5jQX97Le1yIGvuObG//CmKecxe1pJTEcnGkA
	k+3Le2OUsBUN77rwStamHit5+2qFxHVqOiK95qhNZBIAaDA8V1iejnTOHLnsvoz2LTbUNrDVnwrLp
	lZGON2F6bjCdc0MBtLnoKW0m0oosGHyuQOtGhUcvIZor6T94skha9hjMWynQaoEFwql0lDwj2fyiF
	hPO6Xx7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDIld-00000002rqL-00kc;
	Fri, 09 May 2025 08:07:37 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDIS1-00000002nnC-3AsH
	for kexec@lists.infradead.org;
	Fri, 09 May 2025 07:47:23 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-af8e645a1d1so1298064a12.3
        for <kexec@lists.infradead.org>; Fri, 09 May 2025 00:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746776841; x=1747381641; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BTLAwJfpzTnDn2tZfb8KpMGtzN7vq08hC8THCvjwurw=;
        b=B66193OvxSdLgm6lnAbR1YkLxaZGphHgknamb9euXV1m5DkDNLcAotoYeZsa1s6lho
         BBWgDR0c9pgWz+5zHwY4QHT8f7zz+QnjlY5+pqnGCqKNkKrXcg+RbFobNAh6jyQ4yvKK
         WeDSexNFDRE2o2HuxHiLJS89kbz3JXMzR5H9wzFVJLYOw6aIbNScVgtl/QUf0vY1Jouh
         gNf+VElolBEbQDX0XaZhOmdYrBB87+ush3iVJElDw56dzkx/tG19IOjNnTcrwsPW9Qbl
         VF1jPa/+NcxLjpNqHSnu3jc9ohfKO9ranANxwtazq46XrZiCfodTDQhtxHrovHlhQQby
         lgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746776841; x=1747381641;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTLAwJfpzTnDn2tZfb8KpMGtzN7vq08hC8THCvjwurw=;
        b=uUi+4m3mxyrUpCmzzzdjeKbEx/BcDs1Nl0++h8wq8HkZEkuSgErEF7Zz18qz+1riOB
         NcR5eSD4untm3Aluvn/xuD6bN5QF+a4s76Yg70mq4i99nlJ0yFl6BOWGt4JYGpsOJyuo
         7WdNqQ9FkpUadp5giGIBZee7EEOSClMX4EGKDaxiP1VxGuYcrHeqiQmZd9eVm1lr5Ud/
         RurD0lx6gKhEmaKhV5VQYb39iDku4J9obbtLwHm0f4HoXZjibwu2JshwFJz2H8zenBMv
         NZUg7nSdKBHbl2JcL4JhXyc8reF6JqKgeMCrT+TUPUiu9tBWq5kPqiSTkgxlnxsci9Hm
         zUJw==
X-Forwarded-Encrypted: i=1; AJvYcCUxw1G74sodYv5eMY5KnHKLi0ieP28vtlbiC4dgezf4qbII/J0fNLh6ckebNtmpuDukbYb04w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz3wb3t/Bqi2xTe5HZLkahSEBSUy7vWYQEOUzDk2Z2HQQ/8UsAl
	8mwujyOfPxLGXSGTTEJfqU8L5Zc1dxiUoWadj/yyoj+RmXq/II0bjJ2Og6YZ3XTSewy0q3cH599
	H260fSxzev5dfDxTMCQ==
X-Google-Smtp-Source: AGHT+IEztQLwT7ajncZsBNt/V8Xiws9Mgn93m4FZrCV2u6FrzGGzzz/PUz6yE5EWUGsiWeksHLXg/JFNc4GUnrxd
X-Received: from pgmw23.prod.google.com ([2002:a63:9357:0:b0:b23:6a88:a54f])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9004:b0:1f5:55b7:1bb2 with SMTP id adf61e73a8af0-215ababa2afmr3522816637.6.1746776840848;
 Fri, 09 May 2025 00:47:20 -0700 (PDT)
Date: Fri,  9 May 2025 00:46:32 -0700
In-Reply-To: <20250509074635.3187114-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250509074635.3187114-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250509074635.3187114-15-changyuanl@google.com>
Subject: [PATCH v8 14/17] x86/Kconfig: enable kexec handover for 64 bits
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
X-CRM114-CacheID: sfid-20250509_004721_821585_2DEEEA29 
X-CRM114-Status: UNSURE (   8.23  )
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

From: Alexander Graf <graf@amazon.com>

Add ARCH_SUPPORTS_KEXEC_HANDOVER for 64 bits to allow enabling of
KEXEC_HANDOVER configuration option.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 arch/x86/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4b9f378e05f6b..d1fb81ffdaafa 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2029,6 +2029,9 @@ config ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG
 config ARCH_SUPPORTS_KEXEC_JUMP
 	def_bool y
 
+config ARCH_SUPPORTS_KEXEC_HANDOVER
+	def_bool X86_64
+
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool X86_64 || (X86_32 && HIGHMEM)
 
-- 
2.49.0.1015.ga840276032-goog


