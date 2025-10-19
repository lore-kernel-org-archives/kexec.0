Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BF2CCD1B7
	for <kexec@archiver.kernel.org>; Sun, 19 Oct 2025 06:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ex4M6nG0U6c9sFi4kmswWQOXivj8cIJW5ADLbJTHFZo=; b=dDsxHLvZ7N6Rbsps+fzeQ3l21Y
	KkD0K+UPdAscQJ3kSYgwcQIoslCwrC9dye0WqpeF0HeSoku1+uNF+XoF/siAyKdY6uls67gTXvHwn
	TLJOfTeN67xOm1CaO+SKPuVneuNkWnSV9uGo3mzTXfXfDRVH2zjaZIrapggNrHP+BLIe9dakVPRT5
	MluD4NGa88BOXhI9yBsZ9lP+CYvHxZSzZfdQwYAOJzqVs6PXihtBTBZsBkt3H0PCgZ51j8gt9MSVH
	DWODEU43d/ROcc3beUx78pg0Q3yNpGxsTybMHhepjCikcpeRq6OMwJ5ygc8MLWea/cBBe+erXUV3I
	0RMT6hwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMix-0000000Aj2d-3ven;
	Sun, 19 Oct 2025 06:16:59 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMiv-0000000Aj0d-2ttM
	for kexec@lists.infradead.org;
	Sun, 19 Oct 2025 06:16:58 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-27ee41e0798so52959275ad.1
        for <kexec@lists.infradead.org>; Sat, 18 Oct 2025 23:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854617; x=1761459417; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ex4M6nG0U6c9sFi4kmswWQOXivj8cIJW5ADLbJTHFZo=;
        b=brVsfZzdDErvnIHoAukrsGc0aWiLSJ5mU8rxUrPXPCanHPcoV0CjlIwpW0CFw8RUWE
         BpQQv/SkLrjJUW1zxjYqEXEN9D8M+WpN5psD3nQSz/ZvR7XMjmfQmXymvPSl7gQPRNAH
         zrVWyXCGzFHD9aQgocAviCdqhPLCy7SA/FcOuAcgKF9fnER25iEMQSGXkiz1g7TD1szu
         pmOrBjVyVGHeQB+Q/luRdap7XlCon2IuGn7TbyfDFoEOxxR8BEHSidKobpHHM+35Pmjo
         2LfS3opQ2XA1VHz2VXO8DdKIGBpAGXhb26d5V9Xo2lOFHECjUYD+bWnDZL3hQfBlnZZW
         jKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854617; x=1761459417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ex4M6nG0U6c9sFi4kmswWQOXivj8cIJW5ADLbJTHFZo=;
        b=ew9eLLYRulNlis+M5rGwdTpduI1Honw+oBkZiwUESUgMsT8nONv2GJT3NW3iFZsVmr
         PjapVNmu+hp8chnsJ8RQ2BA5k9q4Z/9qjNi6zKXK/M2E34Q6bL18rxU6gQWYHwPbxOOq
         1Vmx/PJY5ZmVGziZ3MkEiSmE0zXtFBfkpTYQqwu8jqtSMUf4JUqVgiV2ycHkIrJ1bfsd
         BPK4l12D53GekFmjsZ0bCvC+nPIuNt/1araAH+1OBFlMVH8u/5mPkGixz0Rp4Z7RyNzx
         64+ks7PYe2ajlcrHDWSz9isEzPGvxRHNSykA64C9dpn++uLwxMWFTgl0l9Qs7uXIXLhd
         EceA==
X-Forwarded-Encrypted: i=1; AJvYcCXb/FOLGNTog1NkcW7taBpdOkwsn4/6apFcH8HkmV3m3/UoRuSJb9IdtviIGqQTh2hc+81ZWw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzH6j4jPuNnJSb8+NXlJkXIsNf28qmt13Jw8RkPCbrGeLSpVq/l
	y7EX7JLUhsTvzoVX/5AEQusqrwpKsaEpPvm99wPsYRzLZp+DeMQP3bCI
X-Gm-Gg: ASbGncuKUvhI4fcWuwczNv7cJW+CyNIuIIb95iSfkzJEbV4ZpOVxtjDSgjwOYLvIV1D
	82FFbmE6tGZQb6CcI9HVkHCkkGUY/w7wyPuZqXLWhqiDQzeb+UXNDUrgYD3ofTag4oztBwbOwdF
	WAHzno13EpnWmcYZCGI8SileQGgqkotUyG5BLi2S1EBT8w9mU72VTbkxEoTuThBclfQ7E+KvK1X
	PRrB+//KFOjcjgiqqWzRsUsL2UJZWhpLRUhOGydOUupvPrxTh7387clJ0rr6JyOv2aV+24DNS+e
	y/vo0HYFuNJkR+PRdVDCbOerR3y+xj0NRJkfLgE0qs4ie/GqRs5yD+zfAxmoO/zYl3BYpX0iAFW
	RWugNjiRq+WNjIBI24lMmd+N6HAtbgM8WD+YNCCt5ot9sCb1H200pcS7Q0UIdzpvEYnlDtIXutE
	s+lVtj
X-Google-Smtp-Source: AGHT+IEdPOvrEIcU1/OzXiLpdHh1uco8zhVpvekF8s3i7IZl2imw6bwzc3Kl4EuPcI0uzTvVtI4atA==
X-Received: by 2002:a17:902:d508:b0:28a:2e51:9272 with SMTP id d9443c01a7336-290cbc3f200mr124673875ad.48.1760854616812;
        Sat, 18 Oct 2025 23:16:56 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:16:56 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	stefanha@redhat.com,
	multikernel@lists.linux.dev,
	pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch v2 04/16] x86: Introduce MULTIKERNEL_VECTOR for inter-kernel communication
Date: Sat, 18 Oct 2025 23:16:18 -0700
Message-Id: <20251019061631.2235405-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251018_231657_738546_3AC1B6A0 
X-CRM114-Status: GOOD (  13.51  )
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
 arch/x86/include/asm/idtentry.h    | 3 +++
 arch/x86/include/asm/irq_vectors.h | 1 +
 arch/x86/kernel/idt.c              | 3 +++
 arch/x86/kernel/smp.c              | 8 ++++++++
 4 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index abd637e54e94..d2c3f1ca481a 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -703,6 +703,9 @@ DECLARE_IDTENTRY(RESCHEDULE_VECTOR,			sysvec_reschedule_ipi);
 DECLARE_IDTENTRY_SYSVEC(REBOOT_VECTOR,			sysvec_reboot);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_SINGLE_VECTOR,	sysvec_call_function_single);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_VECTOR,		sysvec_call_function);
+# ifdef CONFIG_MULTIKERNEL
+DECLARE_IDTENTRY_SYSVEC(MULTIKERNEL_VECTOR,			sysvec_multikernel);
+# endif
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
index f445bec516a0..5e6d03bb18b5 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -135,6 +135,9 @@ static const __initconst struct idt_data apic_idts[] = {
 	INTG(RESCHEDULE_VECTOR,			asm_sysvec_reschedule_ipi),
 	INTG(CALL_FUNCTION_VECTOR,		asm_sysvec_call_function),
 	INTG(CALL_FUNCTION_SINGLE_VECTOR,	asm_sysvec_call_function_single),
+#ifdef CONFIG_MULTIKERNEL
+	INTG(MULTIKERNEL_VECTOR,		asm_sysvec_multikernel),
+#endif
 	INTG(REBOOT_VECTOR,			asm_sysvec_reboot),
 #endif
 
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index b014e6d229f9..59658fcd9037 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -272,6 +272,14 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_call_function_single)
 	trace_call_function_single_exit(CALL_FUNCTION_SINGLE_VECTOR);
 }
 
+#ifdef CONFIG_MULTIKERNEL
+DEFINE_IDTENTRY_SYSVEC(sysvec_multikernel)
+{
+	apic_eoi();
+	inc_irq_stat(irq_call_count);
+}
+#endif /* CONFIG_MULTIKERNEL */
+
 static int __init nonmi_ipi_setup(char *str)
 {
 	smp_no_nmi_ipi = true;
-- 
2.34.1


