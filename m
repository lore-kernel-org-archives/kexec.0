Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC9CC001DE
	for <kexec@archiver.kernel.org>; Mon, 24 Jul 2023 10:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aV2AMg43mrSi6nwfpFw9xPd7nMtjbOJJdp2j1yYKTOI=; b=0vqU2hhcGDj3cm
	iRKb3TYe4mEx3nE1KZ7qxHwem5T1VJrQk/m538puKu0Y8K7/9HAnLlruUXENNOkdIf5GbGh10h67x
	zwRXdeR/2Hnwm/8XzV2fwi0qbmp3pWytCPUG2cfV/rzm2RX6/+CNyCV1WpauQoaIBXbi40GC2Wrou
	AIQHX1ngGCpRoxId+liZmM49vVosyyNPMKhzGWTRVu3BQCaILCQEC7lZVrgL88pvAjVk4brpCPU07
	beu2CizO52h3Qxj/XSdSZ5tKC7iNRXjTFD+WTuy81Lmimm7jwGoYRO8Us9reiKkkZEnAYl/UBjfY+
	VsLnFX18NiMq8OiQBBEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNsVj-003bOk-1S;
	Mon, 24 Jul 2023 10:09:51 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNsVh-003bNb-14;
	Mon, 24 Jul 2023 10:09:50 +0000
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34642952736so24034265ab.3;
        Mon, 24 Jul 2023 03:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690193387; x=1690798187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vwxb4dr9ed/m5CEyUxwJ1RrHPJUl/WASFTIF6qacv2g=;
        b=VD0NxzawoiPeT3noLpC6aX3MxiFFLuHuf3NInzssCr435rIpjai1Q9BKajTHw377io
         aXSypTdyUU+RFfzj2Zr9fY4+fYt5SJX0e+Vyy+XxqgO3jmXJEByYRFRtziGQzbao7+EF
         lA6e/r7AXXdNRbfFEaN7L4pzWHV9yf3b4SstMGls2JQpxcPFJZZPqG4VrKwfmUQkRsRr
         oTtZ4iW7aj1br5A6e/Y/BP1G4KeI4pUH+Pahde61X+gUa/GdrUCSMcFV6VgBciamhSP2
         z/1aqxOd8/QuVJJsh34jNZnDBMwHRpa4bgSn/smjgD3YFNYeixnDN1ipAKBxBFRwj+TT
         kMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193387; x=1690798187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vwxb4dr9ed/m5CEyUxwJ1RrHPJUl/WASFTIF6qacv2g=;
        b=Cy9oLrcclUpYs/IpBvOk0eKrvjJxVz6p8g4ydOnu5rCcfWArofOA/4DI9KZVFvGPk/
         Fc/m1MbSGzUev3L5lGFHUJM9O814xz7rueSYT2MbHU8Bgmg29s3oi23Cd7p59oFEnQCP
         2nZ7lkV1ZScV9+ZKRmxfAI4EduchSlNP9+wDa+wTJQVnDHbiFCebDHy8v5nQ+m4akAam
         XFjnV4iGDfymqS3f6mBtPdbofICdTRv85+GpNivv0eGWnxpsINUuJ0DC/ciJ7xZRF0MP
         ZC/makHRVQmYa+DFChCPcPz7kFxYH5QCs5ILUcOhTMjCyYwK4CIHmMcL8O/jtZhipw4p
         STNg==
X-Gm-Message-State: ABy/qLaiwmswyCEUsHuug6leMK5GpSnHzKkXjayNeCQDomUHeDLEFmav
	6eLyzUKOBVL0n12NtUxyF3M=
X-Google-Smtp-Source: APBJJlHJ5PE83v9b1yIa2tiwwMnAmbYros48TQ/r/GuSfcXorXE/PyaC9/EV9Q/TEW8XN+CxxXkwYw==
X-Received: by 2002:a05:6e02:20e1:b0:346:e96:7cbb with SMTP id q1-20020a056e0220e100b003460e967cbbmr9064158ilv.30.1690193387442;
        Mon, 24 Jul 2023 03:09:47 -0700 (PDT)
Received: from localhost.localdomain ([2408:843e:c90:2347:5782:34b7:c2b6:16d2])
        by smtp.gmail.com with ESMTPSA id t29-20020a63b25d000000b0051b8172fa68sm8272826pgo.38.2023.07.24.03.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:09:47 -0700 (PDT)
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
Subject: [RESEND PATCH -fixes 2/2] Documentation: kdump: Add va_kernel_pa_offset for RISCV64
Date: Mon, 24 Jul 2023 18:09:17 +0800
Message-Id: <20230724100917.309061-2-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230724100917.309061-1-suagrfillet@gmail.com>
References: <20230724100917.309061-1-suagrfillet@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_030949_369871_074E6289 
X-CRM114-Status: UNSURE (   8.44  )
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

RISC-V Linux exports "va_kernel_pa_offset" in vmcoreinfo to help
Crash-utility translate the kernel virtual address correctly.

Here adds the definition of "va_kernel_pa_offset".

Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
Link: https://lore.kernel.org/linux-riscv/20230724040649.220279-1-suagrfillet@gmail.com/
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index c18d94fa6470..f8ebb63b6c5d 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -624,3 +624,9 @@ Used to get the correct ranges:
   * VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
   * VMEMMAP_START ~ VMEMMAP_END : vmemmap space, used for struct page array.
   * KERNEL_LINK_ADDR : start address of Kernel link and BPF
+
+va_kernel_pa_offset
+-------------------
+
+Indicates the offset between the kernel virtual and physical mappings.
+Used to translate virtual to physical addresses.
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
