Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44A7C433EF
	for <kexec@archiver.kernel.org>; Mon, 25 Jul 2022 08:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FU4Zh4rRQrG3M2ga4uY3STEswCWIJOB8QX3Ryd4cKw4=; b=lYNf0F3J3+8Mo7
	cXXZ7PSuIjiyj/Gpj+vwBBX+sprFhNLjSPndV8w8KmUarDnGsm5jfmu8P00P9bNlIM6lg/F45z5ro
	BE6DkC96w6ru0kXibfRFtOHqWFw7tj4+tOlygdDnEq9Oh3Th9eRDTvZkJAlDIjnEqZHyqqfxPFC3m
	Cve19/ks8kPNYyJF+ANVWZvon+IL7TTrA9P/nh0T8lXS+QtvGn2M5SMV8qLIYGmBNjqf3avMQU30+
	XEZwR6xwG7E7GakMyY0CPF6y/MB1vdEGwvX/lciMoRm4fBxInBnUlWXEMsmFn4DIRll5bIkgDsw4I
	8OhfkIfh5riLJYnFKCQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFtdH-0072vg-KO; Mon, 25 Jul 2022 08:40:07 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFtdF-0072rO-A9
	for kexec@lists.infradead.org; Mon, 25 Jul 2022 08:40:06 +0000
Received: by mail-pl1-x632.google.com with SMTP id g17so9792098plh.2
        for <kexec@lists.infradead.org>; Mon, 25 Jul 2022 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kHG5WLJXoefEp1rBIYi3cGiQrYB7FX8IJTWGZ213f6w=;
        b=oKvYNiy1a+B/y9HqhMS1eeDAuKnP/B7jW4Edzu3YQyc2TAbENzdFRYsH/9lNY8kWnv
         mDlx1UTjYca33UMNa2+p/+myi0hxsLQCasyKkMq1x8zl+YEaPYMhwxaMj58FfiJQkuem
         oY7MdUKQxELSYp92yDUBkKgkRKS8izlCQYk+7v76P0U8k8YBea+7YQXsWcTyurNEw6+h
         g7Hjv+yxgV99jZT+HZxNmp1iEIFgYtKfT6SxHsrN3SkrcdYdnshla+dW249GJ/IUi3U+
         WuJc6bRxEjWXYuxp5MZLGXyU+w+1HAYCMZ0gYpDElGaSKspUa6sKF1m4l4DG677dRYU2
         G8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kHG5WLJXoefEp1rBIYi3cGiQrYB7FX8IJTWGZ213f6w=;
        b=bZql5wu7vr/l+21eZ0zTKw30vcpyZ4NIdlRRFvY4/1I3VY9Jgb3dTktBNvGdKKKsCZ
         1bwDSowyYkW2D15rexk/TnHwpDZgDtelX5ACeU7ovWAfTxPhhfgme9BzbqlGTwQZSQo4
         fCajZGxb+Nmx43JXzlbD1eQsoDzdZNF9yTdo52nz3ojNsK4IVIpaa/ZKA7Byd6kTQzS9
         kjf4TAiUJfjMMq8yYvfU50m79vNzRDounlz3nqLBjpHTc6kuESMjfMBgNUnQgZM114FF
         Wz/hG3yXXGEKH1929dLhqzKNFMUDwxo3+Sj0VjGEf+WyiPLfxfRJKjsIJyrz2ZGOfdPv
         FqTw==
X-Gm-Message-State: AJIora/zfAeHjdljN4ZKGI2xAEYlfvF5fqMjNxB+dYewMQF1lVL1h3R7
	O8P6v+qmGY4leXG1WkammbQ6jg==
X-Google-Smtp-Source: AGRyM1sbSkqOWAM8qvsfiZmn6OqYnP2aJAsp+Ac/PTrZCoO3LlsIuCdT88SmUqcbCQVOLPgNlQ5J8g==
X-Received: by 2002:a17:90a:c4f:b0:1df:a178:897f with SMTP id u15-20020a17090a0c4f00b001dfa178897fmr13156990pje.19.1658738403592;
        Mon, 25 Jul 2022 01:40:03 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 128-20020a621886000000b0052abc2438f1sm8893479pfy.55.2022.07.25.01.39.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 01:40:03 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: 
Cc: "huangjie.albert" <huangjie.albert@bytedance.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Michal Marek <michal.lkml@markovi.net>,
	Nick Desaulniers <ndesaulniers@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Joerg Roedel <jroedel@suse.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH 2/4] kexec: add CONFING_KEXEC_PURGATORY_SKIP_SIG
Date: Mon, 25 Jul 2022 16:38:54 +0800
Message-Id: <20220725083904.56552-3-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220725083904.56552-1-huangjie.albert@bytedance.com>
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_014005_360853_22AD1851 
X-CRM114-Status: GOOD (  14.39  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: "huangjie.albert" <huangjie.albert@bytedance.com>

the verify_sha256_digest may cost 300+ ms in my test environment:
bzImage: 53M initramfs:28M

We can add a macro to control whether to enable this check. If we
can confirm that the data in this will not change, we can turn off
the check and get a faster startup.

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 arch/x86/Kconfig               | 9 +++++++++
 arch/x86/purgatory/purgatory.c | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 52a7f91527fe..adbd3a2bd60f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2052,6 +2052,15 @@ config KEXEC_BZIMAGE_VERIFY_SIG
 	help
 	  Enable bzImage signature verification support.
 
+config KEXEC_PURGATORY_SKIP_SIG
+	bool "skip kexec purgatory signature verification"
+	depends on ARCH_HAS_KEXEC_PURGATORY
+	help
+	  this options makes the kexec purgatory do  not signature verification
+	  which would get hundreds of milliseconds saved during kexec boot. If we can
+	  confirm that the data of each segment loaded by kexec will not change we may
+	  enable this option
+
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	depends on X86_64 || (X86_32 && HIGHMEM)
diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
index 7558139920f8..b3f15774d86d 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -20,6 +20,12 @@ u8 purgatory_sha256_digest[SHA256_DIGEST_SIZE] __section(".kexec-purgatory");
 
 struct kexec_sha_region purgatory_sha_regions[KEXEC_SEGMENT_MAX] __section(".kexec-purgatory");
 
+#ifdef CONFIG_KEXEC_PURGATORY_SKIP_SIG
+static int verify_sha256_digest(void)
+{
+	return 0;
+}
+#else
 static int verify_sha256_digest(void)
 {
 	struct kexec_sha_region *ptr, *end;
@@ -39,6 +45,7 @@ static int verify_sha256_digest(void)
 
 	return 0;
 }
+#endif
 
 void purgatory(void)
 {
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
