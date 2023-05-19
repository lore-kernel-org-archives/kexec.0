Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F3CC77B7A
	for <kexec@archiver.kernel.org>; Fri, 19 May 2023 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RvnCKkxm+WeRQJvfZQ/y4biaT+jl9nYzSIUwJuyNvSI=; b=MA658ybqDkM9td
	B6gDi5OYTBLt4jrmGfj08JfdUKBWh8J3u4GmKU/F08flNyb1ulylSLm8Ho5ONT2uEmO/vZhuHGtbG
	JayJ85dNfmm94738BHgLZCBtqQJgqFFk9oguyB7AEMPF4GuFR0XThdM4su5rrh9zXQPg+6nfCVU6I
	GdCfiNCE0biDdEYTKomD/y2R+RUzX512HWhsDzfPcUJ5uxs0EzzBN6eiymUuRJxaYnqeo0SjP/v1+
	qaCbh+R0qbSb8tQwKKYl0NtvwC/qWqrK18hef//6o7Sr34z6kIwmFo9qGujD93BdNRQH2I8jRYurm
	gLTiVrTQbo2q9waiyLbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q02Dz-00Gchh-2S;
	Fri, 19 May 2023 15:40:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q02Dx-00Gcgv-1x
	for kexec@bombadil.infradead.org;
	Fri, 19 May 2023 15:40:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=tXwbVblZO4SjZiyR2RJlU+1lPwt65C7sEIHn8p960bg=; b=eLz3/GdECePrjoTgMIo3+D7oUQ
	mghWn5P9fb5qWvBZbNXHjhRQMFaJ0UrIoXWEuqS82aONn/SS+lAAZQ3eWgm38e4f5XVDtZU83VK42
	xTK2iuUeqmHTEnddw41tpcXT1cmYiLyLWg/u3NrVuq/1iIfnImTPjvH/zc4wm5L3AiCYm7ySqCJcT
	tqz1pjznxsvoSjOXjObtJbIZT6zXyBWiHrisXU+F/MoQyKToknQp2n3xkymIHAW+OeHswiwbfmMT6
	kdJ0STEAT2o7LcVU7u0Rvq2CkxPrWGcOV/ha+wKB6VgwdhakUzmBoc0a4qUm/1g6Hdfg42nYCWn7G
	yBfCGkEg==;
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q01PC-00Fvxk-19
	for kexec@lists.infradead.org;
	Fri, 19 May 2023 14:48:32 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510d967249aso5088697a12.1
        for <kexec@lists.infradead.org>; Fri, 19 May 2023 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684507708; x=1687099708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXwbVblZO4SjZiyR2RJlU+1lPwt65C7sEIHn8p960bg=;
        b=VaD18pvaYOrPW92cQcoX/NEFyAia0fIgR3ptOsuxx7KqL2m3/Fogz3ohdrjtw8jIAf
         /EDDCPYx2T0p21USc97DaVoXS6yaR7TsMgEpNMeajTXb8D6rWvFbDapW+nC79TBs8v+N
         rMi14ZDfRFVBtp/DNGdIPfZ3+MAQ50UYsHPYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507708; x=1687099708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXwbVblZO4SjZiyR2RJlU+1lPwt65C7sEIHn8p960bg=;
        b=QAqWie9JbPELS/haiPhaQSWjrqB8JkYeePRbL00n+dRdH/7SlSoTQ+hVAuOQLgYf8D
         xYmmm+2ML2xi6OPyYQGEjk6zD+Q/bJw8Q8VCreo6MhD3q7QTb+TY//84ZNjH8nmzRAQS
         C3Sju7gI5zatbK+RMMSsYuyDCwR9EkpXsBtl+SRGa09AweOQ2zBn/OoxUDt+exjYSeSi
         U1Ttx5urH07T05SgC3mQTNjNvFA1kHZxeUNUqhVMj4dj5qvjHi1zDlEk4L/vzOjHSEeO
         tF1cbFjOS4I8tI/pim8Aawb7nkKfbkEQ1KalgYRz4EP28n6ToesiA8AgSodyVsE7KS0B
         n6Tw==
X-Gm-Message-State: AC+VfDxb71FVmLt0BQWyEE3ZkY3Kw00SaxOr5+09B01U6+xaJkLREh+1
	VvmVvNFd1+9uxP5dOggQbNc3ZA==
X-Google-Smtp-Source: ACHHUZ6IJYry1zbpAYrsb/Nt01gDEwYVyd3RcsdkRiDkcM4NVXli57Wi75rvrU+p/H5SVbhZnecZhA==
X-Received: by 2002:a17:906:5d09:b0:948:a1ae:b2c4 with SMTP id g9-20020a1709065d0900b00948a1aeb2c4mr2454616ejt.6.1684507708255;
        Fri, 19 May 2023 07:48:28 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:62fd:274b:c2ab:69bb])
        by smtp.gmail.com with ESMTPSA id a2-20020a17090680c200b0096a68648329sm2349437ejx.214.2023.05.19.07.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:48:27 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 19 May 2023 16:47:38 +0200
Subject: [PATCH v7 3/4] powerpc/purgatory: Remove PGO flags
MIME-Version: 1.0
Message-Id: <20230321-kexec_clang16-v7-3-b05c520b7296@chromium.org>
References: <20230321-kexec_clang16-v7-0-b05c520b7296@chromium.org>
In-Reply-To: <20230321-kexec_clang16-v7-0-b05c520b7296@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>, 
 Philipp Rudo <prudo@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>, 
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Ross Zwisler <zwisler@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Simon Horman <horms@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
 llvm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
 linux-riscv@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=nWZ2BYP6i2Y8oRo+uF2PHambNY95ZiGn4TiaTAGbKto=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkZ4wyHkNCHhezyfivzJzrNGMs0K4vUNQRc3pJJ
 kWHuaNU3qOJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZGeMMgAKCRDRN9E+zzrE
 iP+cEACcWHC3j1LmIzpKx/SEOuyu+T8juc3Qsp240gztvu/viz42y8/iBia84BlsRwErLK2OL0F
 3ajW94BvdF+hTyHozZEgIagItfSauWAbew6wVa0Qzfv2fr5mU42KfHptzq1l42en7K2rPbcBmLI
 I2P1/oqo/f6jOgRfm+rkNph26o3SqzcGwOrNJxLkICIjOt2ryabXBD6m79TkrzdPaB9SoChGJac
 O79LnGL81Pw+Yncu0mYsV4I5Rjw5ZeyFHdpQ7Fz5EA8wvSDDG6odoFxcqf4yE6+bmUv/49AELSz
 4dxJdTvbEKZro9lHA0iSPkRPv/S0GQJu/n8ilKFXAYPfqAfDYAN86mjt4xRWsDrK/m2U5bJyQDO
 y1Bsea8Nuec1BFMA7YRXUDVC9wxgK6i5U1QYeDdEOWjG8KsrN7aDk6FT7Vs5HVZVFlpaYzxI1Qy
 OuCwULJN4OB++Blq1pndCgv3Enk4iWEnD3tV8M5ZGZEkwnZmi1PxTzTAUZrdHBuiBcGUJURHEal
 /D5/1Q6A+bUxW980Yzwcu1tPuxwKe1lCW0boDcrNi3inwoNG0wyymcZvtfl/+IKzenjCXxuZ8c4
 54evV8xE1nlppSTiE5EscgwFuFxb6elq+Frz99s4912olrL9bjc84OFEQ1brCORAnz/ZbTuENqO
 ZuH2pEvCDHPT0rw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_154830_487418_DE85DFFF 
X-CRM114-Status: GOOD (  10.16  )
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

If profile-guided optimization is enabled, the purgatory ends up with
multiple .text sections.
This is not supported by kexec and crashes the system.

Cc: stable@vger.kernel.org
Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 arch/powerpc/purgatory/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/purgatory/Makefile b/arch/powerpc/purgatory/Makefile
index 6f5e2727963c..78473d69cd2b 100644
--- a/arch/powerpc/purgatory/Makefile
+++ b/arch/powerpc/purgatory/Makefile
@@ -5,6 +5,11 @@ KCSAN_SANITIZE := n
 
 targets += trampoline_$(BITS).o purgatory.ro
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined
 
 $(obj)/purgatory.ro: $(obj)/trampoline_$(BITS).o FORCE

-- 
2.40.1.698.g37aff9b760-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
