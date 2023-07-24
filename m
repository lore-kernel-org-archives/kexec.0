Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FE2C001B0
	for <kexec@archiver.kernel.org>; Mon, 24 Jul 2023 10:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=l0Umkkxox4ybT7pt/exMGZAZp9OpNohT8XpgQryxRAc=; b=ncyhQSPJwG0Xu7
	SIGaGcr8NzNBJB16/peq9h/5upEo0YIyijjgLe/ymDVbk4KLfLQFSEbbKG9VMxLzeRq1V3KGWU7Z6
	jgDTwATG/AXsBlakGVoGrZm6V1QhotSU9UJsk16ID64CBANbyDS95WpwDk9NAFQM8SrJvDxan6vD2
	qj5X0LtbHqnAetV6af7AEw13PUMxgNjRSaQ8YRn2Lnm1tAybfbf4qimQhg+V7OhNfIQkHQRgGSWnL
	OMqGFwtsFYa+5Qp3bFy6TsbTorn/WCfSpjf4qF8KOZ6YFTRBEirLNDFpYf9s5UnfFxvQVnsYUXkp2
	xC/3lQWuGl3HN9eVPO8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNsVZ-003bLg-0Y;
	Mon, 24 Jul 2023 10:09:41 +0000
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNsVV-003bKV-1k;
	Mon, 24 Jul 2023 10:09:39 +0000
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-56368c40e8eso2553056eaf.0;
        Mon, 24 Jul 2023 03:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690193375; x=1690798175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RDlfftCqHuUNq6LkkwKxzRiSDkmFGSCz0/vq6oh3T+s=;
        b=hrex/GaUVfMUNZRWvZGpegE4riCW/oOM8uo1UlMmZrlwQR1Y5g9p5yiEY70tHm1Nzn
         Kr5sAEgXdRnmXkRixZ7uSFsyu3mNjkPZQedetliik0YCgA1z5anwyhWO9wgDZJyycz8L
         bqVnG2/rUHzputkQE2I8YmX+z8H53N83YyFIUqLlAn9cJmQ4l5FtwSeir3YT0mCh/CG7
         JEi1SSLS+YGBbkTVOq9MO8LWjBph4mBH+cWBfdLJUhXU6fvKZdialD83Hcug1zFLoGt6
         BHhQtXdk8mLSMT19jnYSRQvWcdarZMfp3CBtw3bGQxqh6FJqAgde0fb2q24nvFcehQ0V
         1Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193375; x=1690798175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDlfftCqHuUNq6LkkwKxzRiSDkmFGSCz0/vq6oh3T+s=;
        b=OSiOio0GzxAZ+SnDpf+oVmuIaXBgghPzX2X4Gm5t2C2xzpxL3LltfPISwy1HSqO0oK
         lX6jR+Q0A7UboYMfaycVC5ZnkAKgYcqhfopt7Ux3snz2Kl7dONoktOoU3N9Zipr8fFye
         4s6licJkoTEM/D27XhbgxCmTiBoB45YMtw8Gr+x39jWURVG8/Rq4HIYe4WQzdOipur3K
         NmvSIIi58ns1pRjnZAQmlA4TvlXBwcpQfnPi1Yukr8pqQ9jyrdjtX7Ob/mBCP0KfcJuw
         bvbrcFSCfQhKJ+9YgmZM7iNkn4nNg57RMqI39sggDxIiDtmyidCNSa/GM4EBTIWBKEL2
         hSkA==
X-Gm-Message-State: ABy/qLa5sxImRvugKsZyXCHL7NYhySSi//x+TVu72fsT0h0RK5dEnsew
	efG0UZ0bL12/0RzORxR87Zg=
X-Google-Smtp-Source: APBJJlHdgdC3rG6LO2coONZP/kkI0Ylc1MgH/PIQ2Zz6Htck/GwFgmmgxR6G3vTB6BKFwu4lvsrr9w==
X-Received: by 2002:a05:6808:1410:b0:3a3:5fc6:3ba6 with SMTP id w16-20020a056808141000b003a35fc63ba6mr12452468oiv.42.1690193375682;
        Mon, 24 Jul 2023 03:09:35 -0700 (PDT)
Received: from localhost.localdomain ([2408:843e:c90:2347:5782:34b7:c2b6:16d2])
        by smtp.gmail.com with ESMTPSA id t29-20020a63b25d000000b0051b8172fa68sm8272826pgo.38.2023.07.24.03.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:09:35 -0700 (PDT)
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
Subject: [RESEND PATCH -fixes 1/2] riscv: Export va_kernel_pa_offset in vmcoreinfo
Date: Mon, 24 Jul 2023 18:09:16 +0800
Message-Id: <20230724100917.309061-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_030937_578352_46E6BFF8 
X-CRM114-Status: UNSURE (   8.46  )
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
