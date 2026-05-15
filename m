Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51873CD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h8RkPwRSQGNgtwFGhMa45mhqNtBX9nLmlB3IzWi1i0E=; b=ae8C8tcaENe5QSUeDn8FQgXk6Y
	loCE2w5wwzuLfnWgSKA3rcUrb7P+go53F+ebmzNXvrry62Pkfn9u2YlUG1W5SMkhcqWqgN9iqfjF6
	UyVg99B2FkypLZoyy5O0OscMxm7mhn3pGn5wazFSqT3GUzcFb2PsV/9hhAqchWiDXsmgoQT9dII7J
	UdLdz+n8hEVsRi6jNReJziL3GGJ3ofM+PdnNYgPsy4Izk4LqdGzq7HsAzu92vzrLzw6DTx62Ysz0L
	RRBEUdhzEze4ZAeFFQAcQcp/Xl2Uy9QML5h+mHOAEPReHKVWV0pJnMCWdABGMat/OZw71g/9l14Q0
	MPFUnHRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzz3-00000009VYW-43lH;
	Fri, 15 May 2026 21:22:13 +0000
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzz1-00000009VXu-2AJj
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:22:12 +0000
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so1384202eec.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778880130; x=1779484930; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8RkPwRSQGNgtwFGhMa45mhqNtBX9nLmlB3IzWi1i0E=;
        b=IpemdFWDkDLoL8WhJVYFmd9Oweje/4CRe8sfVUIkYL1J+XKM2ieCtA3sbvQTWzJWG2
         G/Fe/l+eQPu8rIxz5bBCjTxFQxTSzMGJKYtj0xfXgqrL7Uhtccfs9z0fu3RQDZ26FWvM
         5QamNfo/aoeTSt85ASU+yJTuG6z9gkLIo605xj7GwtSGxCW/Hu3OZ8tEh1FDg/riezl4
         jS/DbroBpcenyHIJxrHwANsRdWPl1533Vt0v/i0XNjNafl3mIwBuzNDMvqMq2R/6fTQC
         O6cUq05ajcxpaLle86Wefu/HXXuH6x8pekan4ynEqLooQkeL/zLu4LyeNfLUs8u2WYR6
         GEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778880130; x=1779484930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8RkPwRSQGNgtwFGhMa45mhqNtBX9nLmlB3IzWi1i0E=;
        b=I9cwCk1/qZfv7+aDKpMHLhl1lMJ0gHiuiLtUXlZ8+tK1PaNQLiuYQnjoBmmxbR2skA
         sNslXqoHctyfECePKASwe7CkYJn0kZxwOHnGTHUHNS2OTc14K9X5k395EkH40WINcZ8H
         cFd+N2sZDOstUFGkpcXu1slN6vSJDH/gtYDPNJflt8Dv/jCu5CBRp7DNywInXxZOWJa2
         g+vn9XotMhW1WBDuvitoFOyRsVkK1d3DrizoQOD1jio98q5/fc/8MFpg+inPp8GTbALn
         Uc/V+S2FDVUu9ixVjKcpdlZmKvC4iDCN2wkOww4UsBpk0mZE/Y1IG7em0qjNpyLdmGw0
         x23w==
X-Forwarded-Encrypted: i=1; AFNElJ/huBZYQj0a6yUGUDrXrcGrzp2vcJDlABNeBCgZJUYC+DRF9Hb6bIYx/tRwN8KRULLw2FEkcw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxzNsYu4HYx2iH/YbT5KfS2xkfqwsZjjJrbJiAbuenZD7CYyARB
	mxGEh0QaF7Wa/n5z3r+P+6Pyb4T5dcAxJ8O87vMCLq0TzIwIcXGKViSu8U0wZuSV
X-Gm-Gg: Acq92OE7gT8EovkyunJW+uJc3X/aKMx23hyxx4Ydow4f0MomF8OtqFqXgUpNH39FJFE
	e5hjIL/MvJpoQ96XWh+VlfdZMrFvtuVkGN7u7H7CIjZD6Ui5/yKzQABKJWH1H6qykzjPBY0yZDH
	jpjBJ5n813d1+mlewr9sZb+N+YJYp6hXW9GaxlBmt/gD+8jw5splM1QPrzg+/hzo0mWuLwTgp1f
	ItL0NKvVROC0kObOMFBRGNpxUWboUvp++d/IbXGuKt/rlYLooQC3WhIo3oxRa0zQrczdMtPBTWk
	gRzTJ2RpfXd2DQBOjGDv4bPny31fGuJ3TspdbuJL9+9j9SrMnz+Yrp4KOf/GWy4gvHwrHjZWlUG
	d7jWXHrH7U/8s/WqPUBLXsDKGP8EtAm/pjuIA8ktXE7LBSJ5L6BX9iblIvUVeaJ0tH97rO0pbyC
	z8nNKnJOasvqzRxJFDtPHbSngpvyuOKjcDeFfr37Fy2Q==
X-Received: by 2002:a05:7300:ad30:b0:2e7:5737:8364 with SMTP id 5a478bee46e88-303984e17ffmr3028118eec.15.1778879717789;
        Fri, 15 May 2026 14:15:17 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302947e917dsm8005268eec.12.2026.05.15.14.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:17 -0700 (PDT)
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
Subject: [PATCH v16 23/38] x86: Allow WARN_trap() macro to be included in pre-boot environments
Date: Fri, 15 May 2026 14:13:55 -0700
Message-ID: <20260515211410.31440-24-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_142211_559337_DE07D6EB 
X-CRM114-Status: GOOD (  10.13  )
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

For pre-boot environments, do not use the static call definition of the
WARN_trap() macro.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/include/asm/bug.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 80c1696d8d59..7899768ae644 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -138,8 +138,14 @@ do {									\
 #ifdef HAVE_ARCH_BUG_FORMAT_ARGS
 
 #ifndef __ASSEMBLER__
+
+#ifndef __DISABLE_EXPORTS
 #include <linux/static_call_types.h>
 DECLARE_STATIC_CALL(WARN_trap, __WARN_trap);
+#define WARN_trap(...)	static_call_mod(WARN_trap)(__VA_ARGS__)
+#else /* __DISABLE_EXPORTS */
+#define WARN_trap(...)	__WARN_trap(__VA_ARGS__)
+#endif /* __DISABLE_EXPORTS */
 
 struct pt_regs;
 struct sysv_va_list { /* from AMD64 System V ABI */
@@ -172,7 +178,7 @@ extern void *__warn_args(struct arch_va_list *args, struct pt_regs *regs);
 #define __WARN_print_arg(flags, format, arg...)				\
 do {									\
 	int __flags = (flags) | BUGFLAG_WARNING | BUGFLAG_ARGS ;	\
-	static_call_mod(WARN_trap)(__WARN_bug_entry(__flags, format), ## arg); \
+	WARN_trap(__WARN_bug_entry(__flags, format), ## arg);		\
 	asm (""); /* inhibit tail-call optimization */			\
 } while (0)
 
-- 
2.47.3


