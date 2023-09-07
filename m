Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E25EE14DB
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 10:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bPJgZDN4cK0ELC+bhZ80dWD+8jnp/FcBGxDxorY0ilg=; b=rXXQYOwKI1vg60
	CUt+gFxMH/B5kTwrmgnR0G9vtTmgvSA5dSnKYFwUBl3A7VfzG7K8DRLskddjSmYmp18wwSOiS80sc
	Avinl8YKvUmJ9pznTv3aR7t9hBk4Ge1HRmhAIBv+lcK+Mop7nSO4+yhVml/HwJxBjQudqxPw8s/f3
	gS1Tyw6GbvvP79PIIG8yxYP+DZle89zWnxEcBqeF9PeRn+r9kTRNPl1MKaAQ8yOcrWaq2RBMbjC3+
	7Fl6Bkxd+6uIFua2uWKIfQ6OGh2BHRMlVDkn2eMOFkVieOs+Fz7SOA4vJs0opV51DHGKaeU+/FsVB
	6fn7KfimyYHROtCVKaNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeCMX-00BmyO-1W;
	Thu, 07 Sep 2023 10:35:49 +0000
Received: from bg2.exmail.qq.com ([114.132.197.227])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeCMT-00Bmxb-0g
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 10:35:47 +0000
X-QQ-mid: bizesmtp70t1694082821t9vdxql8
Received: from localhost.localdomain ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Sep 2023 18:33:38 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: IV30oiqrgAbRjbsQ2xTG3U+oXASeb795T9iEGg/BtJgKKP1ayiwtC9AwAbAye
	Imy7WukSD9U9FJZgUzx6C8cwIF1NmYAi564D9Kw7hDLFsFxIfTaeDULXDFd/KuHlzDrizgF
	2hUbx4STVpzjRE8S+n+hVrEe8EvVeDganBo7OJa+kSb8jo9e+hiLdJyrsxeA0aSs2fSjO4l
	wrseA9rqT4W4lp8vTXLmphY68VkB9X7U9oKHV3DPoTGYV2pHWA9tNcNrmPAPrAlXVpz5mUz
	BaJIxdO/ZEj7Y/MYC6HjYceJt6NBaYyTnsjQpCmwZpEAt+Ne6thxpik7FrBBm8Ss2MMgghT
	o3ce06a/2seY+DV9pXd99BgPSFexw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1207815438947823350
From: Song Shuai <songshuaishuai@tinylab.org>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	conor.dooley@microchip.com,
	lihuafei1@huawei.com,
	songshuaishuai@tinylab.org,
	petr.tesarik.ext@huawei.com,
	duwe@suse.de,
	ribalda@chromium.org,
	akpm@linux-foundation.org,
	keescook@chromium.org,
	hi@alyssa.is,
	heiko@sntech.de,
	lizhengyu3@huawei.com,
	alexghiti@rivosinc.com,
	schwab@suse.de
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH V1 0/3] riscv: kexec: cleanup and fixups
Date: Thu,  7 Sep 2023 18:33:01 +0800
Message-Id: <20230907103304.590739-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_033545_594086_58880454 
X-CRM114-Status: GOOD (  12.22  )
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

Hi,

I had posted 2 patches [1][2] for riscv/kexec, but there was no "effective"
response to them until now, so I merged them in this series with the 3rd fixup.

Anyway, this series contains a cleanup for riscv_kexec_relocate() and two fixups
for KEXEC_FILE and had passed the basic kexec test in my 64bit Qemu-virt. 

You can use this kexec-tools[3] to test the kexec-file-syscall and these patches.

riscv: kexec: Cleanup riscv_kexec_relocate (patch1)
==================================================

For readability and simplicity, cleanup the riscv_kexec_relocate code:

 - Re-sort the first 4 `mv` instructions against `riscv_kexec_method()`
 - Eliminate registers for debugging (s9,s10,s11) and storing const-value (s5,s6)
 - Replace `jalr` with `jr` for no-link jump

riscv: kexec: Align the kexeced kernel entry (patch2)
==================================================

The current riscv boot protocol requires 2MB alignment for RV64
and 4MB alignment for RV32.

In KEXEC_FILE path, the elf_find_pbase() function should align
the kexeced kernel entry according to the requirement, otherwise
the kexeced kernel would silently BUG at the setup_vm().

riscv: kexec: Remove -fPIE for PURGATORY_CFLAGS (patch3)
==================================================

With CONFIG_RELOCATABLE enabled, KBUILD_CFLAGS had a -fPIE option
and then the purgatory/string.o was built to reference _ctype symbol
via R_RISCV_GOT_HI20 relocations which can't be handled by purgatory.

As a consequence, the kernel failed kexec_load_file() with:

[  880.386562] kexec_image: The entry point of kernel at 0x80200000
[  880.388650] kexec_image: Unknown rela relocation: 20
[  880.389173] kexec_image: Error loading purgatory ret=-8

So remove the -fPIE option for PURGATORY_CFLAGS to generate
R_RISCV_PCREL_HI20 relocations type making puragtory work as it was.


Note that:

Sorry to Andreas Schwab, I just noticed your reply about the .align
directive in patch1 when writing this e-mail. It looks good to me to
replace `.align 2` with `.balign 4`, I will fix it in the next version.

[1]: https://lore.kernel.org/linux-riscv/20230830063435.1105726-1-songshuaishuai@tinylab.org/
[2]: https://lore.kernel.org/linux-riscv/20230906095817.364390-1-songshuaishuai@tinylab.org/
[3]: https://github.com/sugarfillet/kexec-tools/tree/fix-riscv 


Song Shuai (3):
  riscv: kexec: Cleanup riscv_kexec_relocate
  riscv: kexec: Align the kexeced kernel entry
  riscv: kexec: Remove -fPIE for PURGATORY_CFLAGS

 arch/riscv/kernel/elf_kexec.c      |  8 ++++-
 arch/riscv/kernel/kexec_relocate.S | 52 +++++++++++++-----------------
 arch/riscv/purgatory/Makefile      |  4 +++
 3 files changed, 34 insertions(+), 30 deletions(-)

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
