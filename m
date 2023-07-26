Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C753C0015E
	for <kexec@archiver.kernel.org>; Wed, 26 Jul 2023 09:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fNiE7yw+Sqd+iCki70JzY+NOLmaua11mUdwuGiHNSZ4=; b=hy4/eoNKzuaKwm
	qXyeJ68CZgpUeyFTTFFdySSQuGG+JsRWMziB2q42lVWPAJ150ODMyzzEZ8XC3FQNJ+axU/jeU0GCD
	LRvN+83wJuMGGMcFCYiP0KHgCi6I0lKF1Ad/KFNbrGt6DAHiSQn/hM9y84mPQkeCpR07KTBU199XH
	XY8GiedSG+qSZOm3WeJpYERDYozpqB+PZAm/GDMvDDHhGkHsMKmPTTS6Yabf7Ap3mS3ZOgprkyAiU
	fv2QMqVE8SKoWfRq2uSC2kvy4VN9r2ztO4mhf6N0Mlx1YR+9tUS54PBp+mt9+JboZdGrDKdm1x8SO
	INi0oBMBJ+hfxryiYkiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qObEL-009pD5-2s;
	Wed, 26 Jul 2023 09:54:53 +0000
Received: from [14.137.139.46] (helo=frasgout13.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qObEH-009p9u-2m;
	Wed, 26 Jul 2023 09:54:52 +0000
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4R9pqW2Krqz9ttD6;
	Wed, 26 Jul 2023 17:43:19 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.211.226])
	by APP1 (Coremail) with SMTP id LxC2BwBHo95C7cBk+WYTBQ--.33492S2;
	Wed, 26 Jul 2023 10:54:22 +0100 (CET)
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
Subject: [PATCH v2 0/3] RISC-V: Fix a few kexec_file_load(2) failures
Date: Wed, 26 Jul 2023 11:53:58 +0200
Message-Id: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwBHo95C7cBk+WYTBQ--.33492S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw1fGr48Cw17uFW3XFWrKrg_yoWkWrg_WF
	W8ta1Dtw4IqFs5JF47tw1rtFWFkF1xtryDCwnxtrW7Gr9xWFy5JanYkrsrZw10qFsaq3sx
	XFZ8X34ftw47WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbh8FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnF4iUUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_025450_033606_A8C4DF34 
X-CRM114-Status: UNSURE (   8.08  )
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

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

The kexec_file_load(2) syscall does not work at least in some kernel
builds. For details see the relevant section in this blog post:

https://sigillatum.tesarici.cz/2023-07-21-state-of-riscv64-kdump.html

This patch series handles an additional relocation types, removes the need
to implement a Global Offset Table (GOT) for the purgatory and fixes the
placement of initrd.

Changelog
=========

Changes from v1:
- Replace memcmp() with a for loop.
- Drop handling of 16-bit add/subtract relocations. They were used only
  by alternatives in strcmp(), which was referenced only by string.o.
- Add the initrd placement fix.

Petr Tesarik (1):
  riscv/purgatory: do not link with string.o and its dependencies

Torsten Duwe (2):
  riscv/kexec: handle R_RISCV_CALL_PLT relocation type
  riscv/kexec: load initrd high in available memory

 arch/riscv/kernel/elf_kexec.c    |  3 ++-
 arch/riscv/purgatory/Makefile    | 26 +-------------------------
 arch/riscv/purgatory/purgatory.c |  6 ++++--
 3 files changed, 7 insertions(+), 28 deletions(-)

-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
