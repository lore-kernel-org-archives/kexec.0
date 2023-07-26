Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9FFC0015E
	for <kexec@archiver.kernel.org>; Wed, 26 Jul 2023 09:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DVAbxyDlWo02LhZkiEd29pXROtAOLrX8AjWnGER0QeQ=; b=UNEghB4lm4N1rf
	Mj3ocN3fkJPGiJjEALnJA4pSvYd7MD6UF/2UlnbFahaeft2iSvZFi8K8vcQ3SxhrahoxXApM2jL3Z
	uwmhD60eFpsvObpbOIMlaX140ie7t9CgdNIPSlcukICOJ/KKhWV+NhuSXvjH5Q/IdeFP0BEgAejzo
	ZQOwyO024AbobMRcxPorkiWXGOwS5T14lmoocQO8sAz+wxGZW/KsgbfIhlGq89jDOFhC5DzlGBwVa
	DFB225oiduefacmtV9Mc9YcHoO2UUXHliMzBeXu8Q4X2CuDoMInwq0xtm6BtMNvBEy4G6LHFFjWpm
	nwYJXLoL494ThPByI9bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qObEV-009pIN-19;
	Wed, 26 Jul 2023 09:55:03 +0000
Received: from [14.137.139.154] (helo=frasgout12.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qObES-009pFw-32;
	Wed, 26 Jul 2023 09:55:02 +0000
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R9png08yTz9xFZZ;
	Wed, 26 Jul 2023 17:41:43 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.211.226])
	by APP1 (Coremail) with SMTP id LxC2BwBHo95C7cBk+WYTBQ--.33492S4;
	Wed, 26 Jul 2023 10:54:43 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Liao Chang <liaochang1@huawei.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Alyssa Ross <hi@alyssa.is>,
	Li Zhengyu <lizhengyu3@huawei.com>,
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org (open list)
Cc: Torsten Duwe <duwe@suse.de>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz
Subject: [PATCH v2 2/3] riscv/purgatory: do not link with string.o and its dependencies
Date: Wed, 26 Jul 2023 11:54:00 +0200
Message-Id: <2832b3e5ac781a0c0ade9d77b15a80e7f2fb4ab2.1690365011.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
References: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwBHo95C7cBk+WYTBQ--.33492S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAF47uFy3CF13tF15tr43Jrb_yoWrWF1fpa
	yxG34kK3yUAwn7Krn2y3WUWw45AayUKryFgF4j93y5CF45AF9Ikr93W3yqyFyUJryIk348
	CryFgFy5ta1FkwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUnxhLUUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_025501_260038_DD76D0AD 
X-CRM114-Status: GOOD (  12.72  )
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

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

Linking with this object file makes kexec_file_load(2) fail because of
multiple unknown relocation types:

- R_RISCV_ADD16, R_RISCV_SUB16: used by alternatives in strcmp()
- R_RISCV_GOT_HI20: used to resolve _ctype in strcasecmp()

All this hassle is needed for one single call to memcmp() from
verify_sha256_digest() to compare 32 bytes of SHA256 checksum.

Simply replace this memcmp() call with an explicit loop over those 32 bytes
and remove the need to link with string.o and all the other object files
that provide undefined symbols from that object file.

Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
Cc: Li Zhengyu <lizhengyu3@huawei.com>
Cc: stable@vger.kernel.org
---
 arch/riscv/purgatory/Makefile    | 26 +-------------------------
 arch/riscv/purgatory/purgatory.c |  6 ++++--
 2 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index dc20e166983e..00f50cd29310 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -1,39 +1,21 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD := y
 
-purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o
-purgatory-y += strcmp.o strlen.o strncmp.o
+purgatory-y := purgatory.o sha256.o entry.o memcpy.o memset.o
 
 targets += $(purgatory-y)
 PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
 
-$(obj)/string.o: $(srctree)/lib/string.c FORCE
-	$(call if_changed_rule,cc_o_c)
-
-$(obj)/ctype.o: $(srctree)/lib/ctype.c FORCE
-	$(call if_changed_rule,cc_o_c)
-
 $(obj)/memcpy.o: $(srctree)/arch/riscv/lib/memcpy.S FORCE
 	$(call if_changed_rule,as_o_S)
 
 $(obj)/memset.o: $(srctree)/arch/riscv/lib/memset.S FORCE
 	$(call if_changed_rule,as_o_S)
 
-$(obj)/strcmp.o: $(srctree)/arch/riscv/lib/strcmp.S FORCE
-	$(call if_changed_rule,as_o_S)
-
-$(obj)/strlen.o: $(srctree)/arch/riscv/lib/strlen.S FORCE
-	$(call if_changed_rule,as_o_S)
-
-$(obj)/strncmp.o: $(srctree)/arch/riscv/lib/strncmp.S FORCE
-	$(call if_changed_rule,as_o_S)
-
 $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
-CFLAGS_string.o := -D__DISABLE_EXPORTS
-CFLAGS_ctype.o := -D__DISABLE_EXPORTS
 
 # When profile-guided optimization is enabled, llvm emits two different
 # overlapping text sections, which is not supported by kexec. Remove profile
@@ -83,12 +65,6 @@ CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
 CFLAGS_REMOVE_sha256.o		+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_sha256.o			+= $(PURGATORY_CFLAGS)
 
-CFLAGS_REMOVE_string.o		+= $(PURGATORY_CFLAGS_REMOVE)
-CFLAGS_string.o			+= $(PURGATORY_CFLAGS)
-
-CFLAGS_REMOVE_ctype.o		+= $(PURGATORY_CFLAGS_REMOVE)
-CFLAGS_ctype.o			+= $(PURGATORY_CFLAGS)
-
 asflags-remove-y		+= $(foreach x, -g -gdwarf-4 -gdwarf-5, $(x) -Wa,$(x))
 
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
diff --git a/arch/riscv/purgatory/purgatory.c b/arch/riscv/purgatory/purgatory.c
index 80596ab5fb62..1d30103d2047 100644
--- a/arch/riscv/purgatory/purgatory.c
+++ b/arch/riscv/purgatory/purgatory.c
@@ -22,14 +22,16 @@ static int verify_sha256_digest(void)
 	struct kexec_sha_region *ptr, *end;
 	struct sha256_state ss;
 	u8 digest[SHA256_DIGEST_SIZE];
+	int i;
 
 	sha256_init(&ss);
 	end = purgatory_sha_regions + ARRAY_SIZE(purgatory_sha_regions);
 	for (ptr = purgatory_sha_regions; ptr < end; ptr++)
 		sha256_update(&ss, (uint8_t *)(ptr->start), ptr->len);
 	sha256_final(&ss, digest);
-	if (memcmp(digest, purgatory_sha256_digest, sizeof(digest)) != 0)
-		return 1;
+	for (i = 0; i < SHA256_DIGEST_SIZE; ++i)
+		if (digest[i] != purgatory_sha256_digest[i])
+			return 1;
 	return 0;
 }
 
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
