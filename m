Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35D8CD6119
	for <kexec@archiver.kernel.org>; Wed, 11 Oct 2023 08:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nf/a/VE2h/cfstsjZXiYU9AWaMxFX2F14je7PlSTBV4=; b=YjA42JyaGFDIB2
	ROIIfkuRfw8DmVwo6p1su+R6GCwVYJRwrOjRNgEdkX6TBvQxswjm7bcoom8xaD8XaimUqz2oL4hr6
	c6bUoDsFhFg4vSjILFZNV/V/JMHpRvBgm3+3n9n+KPUMgLD7MKhVv3bL6C3cFloHAAd+GQ5HguGYx
	j2xZ+VSCPa+7rNbaQWdLZ4jyZ2cpS4DirqgKYnpV00AWKGbyuMno4jcrbEkXfYTrkZBDMJhItIZZD
	T33cPwmFbTF8H7IN/ODmd3tBmam3qodjTVXoLTsKTUOgGv9yhmixc4bO8awoWr5mvNP6u6+4E2w/T
	04CLTBQQvkMULsFi9ATA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqUeV-00FEOW-0n;
	Wed, 11 Oct 2023 08:33:11 +0000
Received: from bg4.exmail.qq.com ([43.155.67.158])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqUeR-00FENv-1A
	for kexec@lists.infradead.org;
	Wed, 11 Oct 2023 08:33:09 +0000
X-QQ-mid: bizesmtp79t1697013121tlm25yi8
Received: from localhost.localdomain ( [58.240.82.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Oct 2023 16:31:58 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: C46Rb8GPIEdRSjq04tLpVIm4rBqIg5ZDlkNPqFv6Y1o3yJcnC8ZRmxn2xUPbG
	5aqHDTFlNXyfj9EkRqGPEVLCeEME8D4N5AzoJUCDAT3UjzV5Z0ci7+03OQwZkTZLsqT64MD
	T3ppIzbnyfGx1e8sgzAkoZrig0RpTYyQD70vxYnOf7jHBi+18d9R9W2t1SXwMwkehA42LUA
	epsjv/QxJYlIW/iExD63iNaVCDclscyD3+WHo4bG0As7W+VaJPI7hyDtJ8Oa8EPnaD3XSoS
	KixdppXwX0rrquohicpmRPgk0rYlV8M8UJVN2n6X81C8Q48pgjLEM90fTs3637yXkF2X+5w
	rwxmvRrV2vPyRNqALNrym8K18haX46uW0fzwoZlSB7pU00ib60YvCmV0srlyg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15077306528228941013
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
	alexghiti@rivosinc.com,
	schwab@suse.de
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH V2 0/2] riscv: kexec: cleanup and fixups
Date: Wed, 11 Oct 2023 16:31:30 +0800
Message-Id: <20231011083132.2428720-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_013307_722340_92996930 
X-CRM114-Status: UNSURE (   8.20  )
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

Changes since V1:
https://lore.kernel.org/linux-riscv/20230907103304.590739-1-songshuaishuai@tinylab.org/

- the old Patch2 in V1 had been merged to riscv/fixes, so take it out of this series  
- Patch1 : replace `.align 2` with `.balign 4` as Andreas suggested
- Patch2 : fix the conflict caused by commit a72ab0361110 ("riscv/purgatory: Disable CFI")


riscv: kexec: Cleanup riscv_kexec_relocate (Patch1)
==================================================

For readability and simplicity, cleanup the riscv_kexec_relocate code:

 - Re-sort the first 4 `mv` instructions against `riscv_kexec_method()`
 - Eliminate registers for debugging (s9,s10,s11) and storing const-value (s5,s6)
 - Replace `jalr` with `jr` for no-link jump

riscv: kexec: Remove -fPIE for PURGATORY_CFLAGS (Patch2 : the Patch3 in V1)
==========================================================================

With CONFIG_RELOCATABLE enabled, KBUILD_CFLAGS had a -fPIE option
and then the purgatory/string.o was built to reference _ctype symbol
via R_RISCV_GOT_HI20 relocations which can't be handled by purgatory.

As a consequence, the kernel failed kexec_load_file() with:

[  880.386562] kexec_image: The entry point of kernel at 0x80200000
[  880.388650] kexec_image: Unknown rela relocation: 20
[  880.389173] kexec_image: Error loading purgatory ret=-8

So remove the -fPIE option for PURGATORY_CFLAGS to generate
R_RISCV_PCREL_HI20 relocations type making puragtory work as it was.

Song Shuai (2):
  riscv: kexec: Cleanup riscv_kexec_relocate
  riscv: kexec: Remove -fPIE for PURGATORY_CFLAGS

 arch/riscv/kernel/kexec_relocate.S | 54 +++++++++++++-----------------
 arch/riscv/purgatory/Makefile      |  4 +++
 2 files changed, 28 insertions(+), 30 deletions(-)

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
