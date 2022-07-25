Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A42C43334
	for <kexec@archiver.kernel.org>; Mon, 25 Jul 2022 08:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PFj81kvnLhVNmbztMyzJwq5gS/+mlk04wDXO3FfNfeo=; b=NNYEHdRdWFZjMP
	mTi2jkcZt3nzu7nwOH6EZLIV1lFyZZVs5jhxO9+P5abFaSeLr3GVZjAqxmricNLX8evYHtvoqHa9I
	GXTqRQoCEOQwLMsdEIaTmFkpZrm5wXeDKvCu6WnkL8o+cJgD7FrkDqoEOeSP+N8Bb9j5QjoA49Qx0
	A6ZtSGK51ak1W/8ZVPGFzO+XkfJdu6KJrkxi4NFGUaZLZe3973Im/Bg9v6fGdsCLxWKjky1yXx0zL
	lcpZItkgHAYMGInNwWul5fQe6auK1UExaUl6MGSjbNfGLx2ZG9Q1odF+C66WV9mGZS2F1v6apqUjk
	S3mFiJTIivr/+sLsAJdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFtcp-0072Sb-BB; Mon, 25 Jul 2022 08:39:39 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFtci-0072Lw-92
	for kexec@lists.infradead.org; Mon, 25 Jul 2022 08:39:33 +0000
Received: by mail-pl1-x631.google.com with SMTP id i3so5321516pld.0
        for <kexec@lists.infradead.org>; Mon, 25 Jul 2022 01:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Amwcf3EAj1ZxcGutEEAzUz751/Dy5KvsTcGRq8AfA0Q=;
        b=jo8T+MgUl15kH1BqxkbwiWY/qbgoEYehBHZY0ciEJqcTGxiQvzgqHT3qYG64kZB09L
         Ldp30ym3utCxsNXD0V4cE/IQTpTcr9nRvBMD8Q7YAAWg3nuvXaPW8p0T+Ss6vm0Y/Yz2
         c3ItMQi8wGERX8KSJ2K/S66Eusd/msC+By5V0onbSOZucoh+78CE4Quq8eUB9G/ZjX/r
         VAcg/FmLu8rR5LtaIHTj5E1hEJjbErtRfjTCu/r8mUSjd3FlSVr66dNJmqOnSGXCzka7
         O4gm4SAldX1ww5OQz2FoSYCoBaXaUHuiE0sTeH4IAX89RZRT44a1VE2hEWrb87YYQU1t
         vaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Amwcf3EAj1ZxcGutEEAzUz751/Dy5KvsTcGRq8AfA0Q=;
        b=fuTj7iH4pbqKs9gxxrMxWGHNn5eKKB9wlvYAi2jiGW4/bYxYTOZl0UfnX7n38KXcy1
         D2R9eyEr3bLAzJUfi+RdJPWCjl198IDV0jqhWFtU5xm2ewBtEN6xeyrFl4Mu4VPgTira
         9K35v4Xk1yvbZQgCzWpSnOcHuzFpD9uqm6Os9VAL0PARUkwLmrBYI53JEZ/0jpY0Wl3n
         CIHvR6uAlcSsUL8/n31kOmn97D4/Fx88ZghUXlNmxoMfVenUGfKUoDkMpMK6zdQU5yYf
         Gt25b2hy1ySigudPT6B/aeOMl/A1f3bK+1/GwW8TimI/ED8iSDm/YRV40thnthTwS1Dp
         vI3w==
X-Gm-Message-State: AJIora8uEHEU+FdgM6KFZSL1PZhnYDIX4H8ffWtxdT0BVvxM0pv8PHGV
	AXjotKm33XDXG6ABSXt+W1FQAQ==
X-Google-Smtp-Source: AGRyM1vA3xEsnyiCOvmZ0T36BbcmH6gcseRwQ4GKU8Ef92TFiEimRCNdKBzLgFPlKmAJbKNRVTAXbw==
X-Received: by 2002:a17:90a:c907:b0:1ef:7655:98d7 with SMTP id v7-20020a17090ac90700b001ef765598d7mr12871560pjt.117.1658738368493;
        Mon, 25 Jul 2022 01:39:28 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 128-20020a621886000000b0052abc2438f1sm8893479pfy.55.2022.07.25.01.39.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 01:39:28 -0700 (PDT)
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
	Michael Roth <michael.roth@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Joerg Roedel <jroedel@suse.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH 0/4] faster kexec reboot
Date: Mon, 25 Jul 2022 16:38:52 +0800
Message-Id: <20220725083904.56552-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_013932_341446_A26793AA 
X-CRM114-Status: GOOD (  12.77  )
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

In many time-sensitive scenarios, we need a shorter time to restart 
the kernel. However, in the current kexec fast restart code, there 
are many places in the memory copy operation, verification operation 
and decompression operation, which take more time than 500ms. Through 
the following patch series. machine_kexec-->start_kernel only takes 15ms

How to measure time:

c code:
uint64_t current_cycles(void)
{
    uint32_t low, high;
    asm volatile("rdtsc" : "=a"(low), "=d"(high));
    return ((uint64_t)low) | ((uint64_t)high << 32);
}
assembly code:
       pushq %rax
       pushq %rdx
       rdtsc
       mov   %eax,%eax
       shl   $0x20,%rdx
       or    %rax,%rdx
       movq  %rdx,0x840(%r14)
       popq  %rdx
       popq  %rax
the timestamp may store in boot_params or kexec control page, so we can
get the all timestamp after kernel boot up.

huangjie.albert (4):
  kexec: reuse crash kernel reserved memory for normal kexec
  kexec: add CONFING_KEXEC_PURGATORY_SKIP_SIG
  x86: Support the uncompressed kernel to speed up booting
  x86: boot: avoid memory copy if kernel is uncompressed

 arch/x86/Kconfig                   | 10 +++++++++
 arch/x86/boot/compressed/Makefile  |  5 ++++-
 arch/x86/boot/compressed/head_64.S |  8 +++++--
 arch/x86/boot/compressed/misc.c    | 35 +++++++++++++++++++++++++-----
 arch/x86/purgatory/purgatory.c     |  7 ++++++
 include/linux/kexec.h              |  9 ++++----
 include/uapi/linux/kexec.h         |  2 ++
 kernel/kexec.c                     | 19 +++++++++++++++-
 kernel/kexec_core.c                | 16 ++++++++------
 kernel/kexec_file.c                | 20 +++++++++++++++--
 scripts/Makefile.lib               |  5 +++++
 11 files changed, 114 insertions(+), 22 deletions(-)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
