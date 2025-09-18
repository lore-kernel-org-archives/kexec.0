Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3E3CA1013
	for <kexec@archiver.kernel.org>; Thu, 18 Sep 2025 22:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZYY6rFeiN3Nd63QlR7gbViGMQddkJPo4uSa23B5h294=; b=rq9JKzo3imXNMDQT/XCKltK2UX
	KJdfkMJhdnJctUHKAn16Rd6Tutga0mClhHD59pqB6WWgbLC9cn5fJDy3q6Nzl5/VpzTqWmjSil84b
	ASgAIoNRyBpa1ob7Q1XPhqelxKxvo7KpWk2AX3FY//Pw+v24SlUzUWfi+OylyCIC395xcMmzOaCeC
	alx9eXgs0/EOlaNOtejyS7fXJSG4A8HjswmWHJalDrl+IOpVlyfz0KOOWoaoW0EcpxQ44RLEcPVRl
	7oGsEJC5y+WmV+YVWiEQLXE068gsmWk4DDqQfTRAoJmEss+PDoEqWE11hvjATSgNf2hrYoCweUMux
	Lzfmryxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzN5A-00000001KJV-1lea;
	Thu, 18 Sep 2025 22:26:28 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzN58-00000001KHF-24KA
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 22:26:27 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-77251d7cca6so1566031b3a.3
        for <kexec@lists.infradead.org>; Thu, 18 Sep 2025 15:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758234386; x=1758839186; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYY6rFeiN3Nd63QlR7gbViGMQddkJPo4uSa23B5h294=;
        b=bQh8+e6ENn+DJxhK98Z87ksjt2kU4+1DSeg91l7TXkPld5reYJ847NoJKim1+7cIFc
         1nliGs7CdImTYbAYHRBTv/aA7ZsM0sWCCHAcDKOowRNoV9CCptkxRyZef1EyqCJsb1hU
         11sXVLSvP8P9FC7dsSlKu15GtWJhCTL7NCPdndfZEL1IpBSV01UJ5Xc0fifZETNtaEsf
         VA7DYJ4Y/GnMNOttzJlARV8ChqWmbCYH9joQ49yjrkUWhU3rA967WzOEz6SMMihquQ/y
         6bNJo3piCHFJRSVvEmxrWyez/lYzattH7bsYk6sfo691LIiudZOkObWwRCa37Y9fTCRG
         to3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234386; x=1758839186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYY6rFeiN3Nd63QlR7gbViGMQddkJPo4uSa23B5h294=;
        b=F7LiQlaTdH8QPt6R9Y+fwjVfywDM2z9Z1Y1qzsU2ZGBHX0Ab2KO/j0AlbSQVYKQIKR
         0i1L60iIsvKxk26yNtKEH5YfgViWQYL2215ojFRt/T3CQUg+yhUUAGmU5UIAhgpRdHkn
         mKxKvbPUA/dcrBYVzljpKtCk3X3jKx2EyZLZ2f/dyufXn+nVtywX/lBboaGKGyOnwSHY
         h/XurnzfVaazPVOH6wSeGARmLkBdVj+J0RMfa+Fezj7za0MqsK35wtFAV8WSKcxO2591
         uh4E89j0cvn0grcFNOcRkmvgrLglgGXnKHPP5tW4O8H66GcJxOw/KmRh3lbiFMpQjHXx
         NlAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUG35mgNzAx7QZygW+MZgnmmYbQoxPT1T3PlpIPthaLtdqMNIzh6Sa/naaMBZwfM3HG/E3Cw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyxHTRudNyDSDDdc2EFjU07NwqIICVOLomsri66y20G1xHbrUOD
	Ol5eIWsqmTo/uhiC5b3Qme0pNOyA2PBpV9SqPkm2c/QQ4YgCgbQ6/Rjx
X-Gm-Gg: ASbGnctQeN3ICEa4b3RYRzITT5Jn3piMwV2LbDTqKVyraURZtQPgEdO3lWF4bOgKYpa
	8nFJS/s0QnlKZdBWCSHmp2zrwpbdLGazBbWpG4ZA1zOSw+/JsNvsLDklMO6pcKO/iCtNNr61zLe
	wFYJwX37L22/QPBoJvdAG0iJ5P8tx9kwUh71+gkCvZsrB80DTCLs2Gz/ib80raX4164Ba5sV8K7
	u6cS8UJbnxfDYSRABG13X1gy98XVKE1WpDgQZKmCRtMxUCMMVATUpgexhbSO1HDjdNytV29+KjA
	JEfcqfRIwmeCH2bi9QgwuD0ftZY/izaskdnOYGrNreSBmAu5YZ6PfGxr6QQe9TafW3hx4504a65
	IHiT2LTDzGtmI0LrkFo9qGlJz/EQwJR0Z9D1huXYODN7MPblsDkdNhdipKQ==
X-Google-Smtp-Source: AGHT+IHTdANHonYuStw4Z+dxwvWzRAP6qfwbsiUcPsTKHk0WpS2t8kUHQdGqTWKF8i2+XxV1lSVzNg==
X-Received: by 2002:a05:6a00:3c94:b0:772:871c:1e49 with SMTP id d2e1a72fcca58-77e4f48ee3fmr1082246b3a.29.1758234385633;
        Thu, 18 Sep 2025 15:26:25 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:c5c1:2e33:6cf2:beed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e5fe6de75sm407542b3a.19.2025.09.18.15.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:26:25 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch 3/7] x86: Introduce MULTIKERNEL_VECTOR for inter-kernel communication
Date: Thu, 18 Sep 2025 15:26:02 -0700
Message-Id: <20250918222607.186488-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_152626_546196_73B008C1 
X-CRM114-Status: GOOD (  12.39  )
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

From: Cong Wang <cwang@multikernel.io>

This patch adds a dedicated IPI vector (0xea) for multikernel
communication, enabling different kernel instances running on
separate CPUs to send interrupts to each other.

The implementation includes:

- MULTIKERNEL_VECTOR definition at interrupt vector 0xea
- IDT entry declaration and registration for sysvec_multikernel
- Interrupt handler sysvec_multikernel() with proper APIC EOI
  and IRQ statistics tracking
- Placeholder generic_multikernel_interrupt() function for
  extensible multikernel interrupt handling

This vector provides the foundational interrupt mechanism required
for implementing inter-kernel communication protocols in multikernel
environments, where heterogeneous kernel instances coordinate while
maintaining CPU-level isolation.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/x86/include/asm/idtentry.h    |  1 +
 arch/x86/include/asm/irq_vectors.h |  1 +
 arch/x86/kernel/idt.c              |  1 +
 arch/x86/kernel/smp.c              | 12 ++++++++++++
 4 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index a4ec27c67988..219ee36def33 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -708,6 +708,7 @@ DECLARE_IDTENTRY(RESCHEDULE_VECTOR,			sysvec_reschedule_ipi);
 DECLARE_IDTENTRY_SYSVEC(REBOOT_VECTOR,			sysvec_reboot);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_SINGLE_VECTOR,	sysvec_call_function_single);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_VECTOR,		sysvec_call_function);
+DECLARE_IDTENTRY_SYSVEC(MULTIKERNEL_VECTOR,			sysvec_multikernel);
 #else
 # define fred_sysvec_reschedule_ipi			NULL
 # define fred_sysvec_reboot				NULL
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 47051871b436..478e2e2d188a 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -102,6 +102,7 @@
  * the host kernel.
  */
 #define POSTED_MSI_NOTIFICATION_VECTOR	0xeb
+#define MULTIKERNEL_VECTOR		0xea
 
 #define NR_VECTORS			 256
 
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index f445bec516a0..063b330d9fbf 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -135,6 +135,7 @@ static const __initconst struct idt_data apic_idts[] = {
 	INTG(RESCHEDULE_VECTOR,			asm_sysvec_reschedule_ipi),
 	INTG(CALL_FUNCTION_VECTOR,		asm_sysvec_call_function),
 	INTG(CALL_FUNCTION_SINGLE_VECTOR,	asm_sysvec_call_function_single),
+	INTG(MULTIKERNEL_VECTOR,		asm_sysvec_multikernel),
 	INTG(REBOOT_VECTOR,			asm_sysvec_reboot),
 #endif
 
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index b014e6d229f9..028cc423a772 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -272,6 +272,18 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_call_function_single)
 	trace_call_function_single_exit(CALL_FUNCTION_SINGLE_VECTOR);
 }
 
+static void generic_multikernel_interrupt(void)
+{
+	pr_info("Multikernel interrupt\n");
+}
+
+DEFINE_IDTENTRY_SYSVEC(sysvec_multikernel)
+{
+	apic_eoi();
+	inc_irq_stat(irq_call_count);
+	generic_multikernel_interrupt();
+}
+
 static int __init nonmi_ipi_setup(char *str)
 {
 	smp_no_nmi_ipi = true;
-- 
2.34.1


