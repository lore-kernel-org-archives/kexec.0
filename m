Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2354C04E69
	for <kexec@archiver.kernel.org>; Mon, 24 Jul 2023 09:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=l0Umkkxox4ybT7pt/exMGZAZp9OpNohT8XpgQryxRAc=; b=1knM6fJP8gNtMQ
	ulPb2DpfpETIi5ZYcxtclMQg4Cr6bLMQXTpJrsS0LDi61lyvYWhLLb19FfTLJI8ySILtY55f86a/m
	sGpRZVghyhMZFXX1Ni3aqdgCmNS+Yadu4a9aWnTkOuvUHtAhqcp58/kZ2vmSe9xwS1qL4nR3N6zUt
	v21zDlNqdAxa/nQIRr9Aw3dg7P30FWB9KV1v6EUyYHMGagxc7ADzKFrRkzC47Ryr8HemnD5iiyq6E
	dmRvzKJzuCmyxKbrLCxMXRnjS+TSNhyTEltlI0OYhxYrZfBfd82kkFvvhN1sTSjgME/yOfW8aOWp1
	nmQZfODxqE8WSVqvcttg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNsLF-003Ya3-0u;
	Mon, 24 Jul 2023 09:59:01 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNsLC-003YYa-1L;
	Mon, 24 Jul 2023 09:58:59 +0000
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a5ad21a1f9so680949b6e.2;
        Mon, 24 Jul 2023 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690192735; x=1690797535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RDlfftCqHuUNq6LkkwKxzRiSDkmFGSCz0/vq6oh3T+s=;
        b=DSXykGWLjFrMqpPv66tlr93X7a0vmBHxz/80vR9k8v9lxYIlxldXX+1QWnvqrVQiPL
         T9Z0gIzVebVrJtp/2dD1t24vN029WXT4YJv6bfRGMsyfrY7Ev7oCdHj/SdtZ3eKyWxJ1
         qp1KSO0l/8QzlY8IcUxvUKiFg83LuDfw9+RP1+s/OGqqqy/Py0x9QGfKA9M186kkmNxK
         PsY/yS3fIWwz3Wa/OVWrLwpf8y9A0QALq0ODtl9acsl6mEWViFV/17vEYrEyFlXN0Mpn
         b5wly/Nqx3jOJrPhGkUvcatvS4JRzlZvhfIA4VyebxQJiDaXw3czDVbLLBv200CQBMbz
         S8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192735; x=1690797535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDlfftCqHuUNq6LkkwKxzRiSDkmFGSCz0/vq6oh3T+s=;
        b=LLsV9fVIFo5sZhcMiVdyf+RarY2ULs/sSoocxk277J+akYs7Lym7WUAbapZYSZZHif
         odReh4gbt4HMiMSWt8KIArUYHEe5ppbo8NyVJ1RIC+ucrWkI9XudAiO0Lnybk/z1ERbo
         gVjnC7PKJ/1yvfDmwOHRjtkA2wQrSEOmGO8Q3lm7C8tFlbnr5tDMVZ12XlPTrQFitAjM
         WJNCUZPNbo7rkYkSPw90ueDnQ7XLlcMikUy6+3VTrFCkXMuVAvcFLMehXpzNhuTbw0bN
         wuutG9Rwg6Z6t7tLZ3Kn3OSV3uqS2436Jfoa08qr7oE6Jc7rpFZ55Ms2aZtk/GO/7cZZ
         hKnw==
X-Gm-Message-State: ABy/qLYRjFH8lDaAIUt9dY8WkeTsCkfowAv/yMfBrkxfHY8GxeVh4g4q
	Sr07BWCadHHrmL8fW5J9iBPdEdLEFXgb1w==
X-Google-Smtp-Source: APBJJlHa0gbcqcComJDdQw8zIzYrXjx/3orq1WOFxcJ0mjEKBVzrS5YHzxRQ/Nvge46RN553XCHzQQ==
X-Received: by 2002:a05:6808:98c:b0:3a3:7ecd:7d32 with SMTP id a12-20020a056808098c00b003a37ecd7d32mr9466634oic.30.1690192735254;
        Mon, 24 Jul 2023 02:58:55 -0700 (PDT)
Received: from localhost.localdomain ([58.240.82.166])
        by smtp.gmail.com with ESMTPSA id d12-20020a63734c000000b0055acfd94c20sm8174380pgn.35.2023.07.24.02.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:58:54 -0700 (PDT)
From: Song Shuai <suagrfillet@gmail.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	corbet@lwn.net,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	xianting.tian@linux.alibaba.com,
	suagrfillet@gmail.com,
	anup@brainfault.org,
	robh@kernel.org,
	ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	conor.dooley@microchip.com
Cc: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH -fixes 1/2] riscv: Export va_kernel_pa_offset in vmcoreinfo
Date: Mon, 24 Jul 2023 17:57:44 +0800
Message-Id: <20230724095745.286695-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_025858_474138_9E510999 
X-CRM114-Status: UNSURE (   8.68  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Since RISC-V Linux v6.4, the commit 3335068f8721 ("riscv: Use
PUD/P4D/PGD pages for the linear mapping") changes phys_ram_base
from the physical start of the kernel to the actual start of the DRAM.

The Crash-utility's VTOP() still uses phys_ram_base and kernel_map.virt_addr
to translate kernel virtual address, that failed the Crash with Linux v6.4 [1].

Export kernel_map.va_kernel_pa_offset in vmcoreinfo to help Crash translate
the kernel virtual address correctly.

Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
Link: https://lore.kernel.org/linux-riscv/20230724040649.220279-1-suagrfillet@gmail.com/ [1]
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/kernel/crash_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
index b351a3c01355..55f1d7856b54 100644
--- a/arch/riscv/kernel/crash_core.c
+++ b/arch/riscv/kernel/crash_core.c
@@ -18,4 +18,6 @@ void arch_crash_save_vmcoreinfo(void)
 	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
 #endif
 	vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
+	vmcoreinfo_append_str("NUMBER(va_kernel_pa_offset)=0x%lx\n",
+						kernel_map.va_kernel_pa_offset);
 }
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
