Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E64EC77B7F
	for <kexec@archiver.kernel.org>; Fri, 19 May 2023 15:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fRErpaFBvvi9IyXJ05OXvS/FvvepYXqkrVDL+nA2W4k=; b=R324cH1pZXxLQP
	t56/3OUcGnJWlm/trQUEmdKsb+tVMJ2pQQnc8Xxi8CfQtyI/h1vLR+B5B7XsKOqoiibnojw28Of7a
	H9dlbf6Y+shzxpeppsCFD3YrSx9tFvul0N6OEByJ+8el6ZZTfFYnvIQcWjjSTNsl8taCphn9oHbTp
	Ce/LbmxL9BZvmU8srL8I3LA528sMK3xQQPmISIdDq4xS/IX9na055IBqxOuo+e/e7D/HmAuAYQDhb
	/wCipWyWXcwHHYnMs8UGpPcBhHik0B8N8hpYNHc8y/HBUdDiLQAGs+vF11z5HBWg/BPrjBxQTszSC
	CPo9TFUD8S1WG587odUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q02E1-00GciR-2f;
	Fri, 19 May 2023 15:41:01 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q02Dz-00Gchc-1Y
	for kexec@bombadil.infradead.org;
	Fri, 19 May 2023 15:40:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=osK35APNMHUOM/vspbNmY4dm4o7cSGGXI42PTW0uu8s=; b=UkAWvba/DzjPbKNlE49eKfWeVT
	Al25PqyfPbKZCKz3U7lJPUivQhQNFQT7ygh0Xj6I5Dl/oqZWZpfOe6bze3D7AzIKdQHOQ3TTSKqN5
	pwWfbOwC1q74kcjlcLHOr5J/IjzIwf5xE5En37cHrpugcfcoMKl6IiQ9oiokBbwYbmNaJbpWSO5Vv
	FtumI4b1xOJGN9mQ0RV/dyY+XHvQYhpWBmxrubYStdimSocApRM2DlQUC9sczVRtQl0xXQHQHGNCH
	P+5hrvfa6NfkSwG/HMnVUFzklzDYXWAAblKCtbPg1DlG6gX1Eag4n4wn8gLgcu/ARcEtvTU4unk/3
	wrPSl6Rw==;
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q01PE-00FvyG-1Q
	for kexec@lists.infradead.org;
	Fri, 19 May 2023 14:48:34 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96f6e83e12fso99208166b.1
        for <kexec@lists.infradead.org>; Fri, 19 May 2023 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684507711; x=1687099711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osK35APNMHUOM/vspbNmY4dm4o7cSGGXI42PTW0uu8s=;
        b=ZYjh30K7khuwsHmxdTGgS+WoY9zJgx6/9/pcc1JbuvgcIEsldCdXXJbEp4NACjCKaD
         LMW1h53HHwQnKpmODQx7uXNQn0+JuBNgZS2Zh/7IejB20vSK2D1Unr6kMSuPVMXAFhiZ
         9ZeWiBl87aFZW9wBv1Nh3DLuN2movq9+fC554=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507711; x=1687099711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osK35APNMHUOM/vspbNmY4dm4o7cSGGXI42PTW0uu8s=;
        b=hEu/+vKsu+RP4ksNPN7bXkjpjcpkhQtxUKp6kVvqaRZ/1WZb+XNN3zNQwcT7aatjQM
         2EBJQVo6xRS9JWIuGflW+nWMCf5LuSU90CLswrgVqA7O2tpcMokpYVyeGl0tqZF7QNDe
         obUd4fyKY2uINHg717DpsvIIi0LdrEpSMRvfVek+j2sGVfAyhcQy+mqt/lnT9aj3ZXGv
         6qJfJwTj5m7N9Ss7Z8Rqph2kaLGGWMUs+BGE+xkaztzQTpli//5i8UEB2de8wl7TcZOY
         gSUAnhSJCJumyx89FVGZPOH90huz7f+sly720zeZSk6tvKsPqN91Tz10SKi3UlJodn3T
         cCaw==
X-Gm-Message-State: AC+VfDzeZ3IaGEOOHG4NFNVnSl1xt2+UiXBKuz7lEWCWAi56f/D8qMhO
	7HcKpQmy+Fhl5l8KOj/g/ft2yg==
X-Google-Smtp-Source: ACHHUZ4sIn6w3qgGaOnZt7gYsC2ndgI+MwJv4U/AftjTcUf/UQqUnAD4mNaTZk8Vvatu2vHjziPdfA==
X-Received: by 2002:a17:906:d54a:b0:94e:f738:514f with SMTP id cr10-20020a170906d54a00b0094ef738514fmr2090904ejc.13.1684507710607;
        Fri, 19 May 2023 07:48:30 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:62fd:274b:c2ab:69bb])
        by smtp.gmail.com with ESMTPSA id a2-20020a17090680c200b0096a68648329sm2349437ejx.214.2023.05.19.07.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:48:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 19 May 2023 16:47:39 +0200
Subject: [PATCH v7 4/4] riscv/purgatory: Remove PGO flags
MIME-Version: 1.0
Message-Id: <20230321-kexec_clang16-v7-4-b05c520b7296@chromium.org>
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
 stable@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1298; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=wdnk6GxBa5T/HIlvuq8XoXYQQFQFk4mx9eVuJiQf83M=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkZ4wzePFk89/IBhUZr9SWcIl2QkwFBFu2gEcYe
 /5y+YTRvGqJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZGeMMwAKCRDRN9E+zzrE
 iEJ9EACWgKvSdCRvRA4/lyxhvVHQgJQ0PCNnOhH3hpa3YJPoHyQLHQ8AWvcvBMla51KPtthYLTN
 RttNdzciI8SyWtWAc62LCy0wqaKDS+qbrbvVnUEYDgzqyCjq/gSxRky4clrjmFzUvY2wNCRfWMt
 yFLtWzm5iYd4N7d07L87XEKmPRitblqcy/VsPL9EMUutCQ5OQlaaSRto36SmkRf9nkrMPPzCH+2
 qNNS8PY2lNeGzUvTDAi7F00EDf/PLWQ7pXaKeJeU56IsYS8v1VUoNdkx04R/AIO8TBdqwsDZhhD
 UqPLLPRwecZmAks5n575AFj+ZFRtUPueG6J2aQ1ndVzS+8/OTyW1xxwogq6fkwr44uXalhe3YxJ
 aUOnvtCxh06L48mQLfdlx1JhUTlhZ1AtVysiezFN9EedPP27rIgxpSSgnEwsjDWJny3YJfbGJQN
 Zk7DDEwAQLAN3GaT+i/K2X8PEHG6+A5SkFE+wZe5WKERCdPLVGgWjIYwaqXDAvGK/5DfORHun85
 2qC2ReqZtGwpWhUfg6jJ4cFTsiNbkYy31b1T5/9BqXT5dBqfAuVU/QKYqg5qb4ciKtKesTLLV1H
 ZydnfO9MMJNG6tjvelUtgGQRPqf1ea9Lob19/0XoQrWh8oifHm8eWWisKYfQY/1ExftAFpZCeA5
 BmR9KbCqwO2lwOg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_154832_588194_2C8C08A4 
X-CRM114-Status: GOOD (  10.71  )
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
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 arch/riscv/purgatory/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index 5730797a6b40..bd2e27f82532 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -35,6 +35,11 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 CFLAGS_string.o := -D__DISABLE_EXPORTS
 CFLAGS_ctype.o := -D__DISABLE_EXPORTS
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib

-- 
2.40.1.698.g37aff9b760-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
