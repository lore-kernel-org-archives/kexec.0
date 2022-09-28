Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8C4C6FA90
	for <kexec@archiver.kernel.org>; Wed, 28 Sep 2022 02:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=I+5bislGnSJA+hzajjQvTjgQ35SNMuJV5wHsx0GDJZg=; b=2Y8k6o/R5+mxTm
	wDnFd17GfMv1FixhiFxsaLnNX9LRcO/SyqLyRH3odjBD0qjBgQySAXn53VAsRG/R/+cit8k5pCA1Y
	DOKlL2ZN9yKpsXi8FCzcFCHFV1c+hKp0l/Deuy/w0hw1StAKBYsztMUhwyPlfB2C/MAwz67nK2Gwl
	mW0WFoaZc/VdLs2DegL5J1ssv9oMokjGn1Ol7ekLk6KURlja5V2bfgvnTwdgtbYNosaITxUdLEcmo
	CfeThBcKweOJ3Qyp/eZSWkQ3nZFehP7l0qEBoBr9dl+AHfx4u4GF89TaAGx5EMWmcn7q+3W1Q4u6r
	l2PONH0SztsV6NHZM8sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odMoX-00DaNf-U2; Wed, 28 Sep 2022 02:28:45 +0000
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odMoQ-00DaDB-4Z
	for kexec@lists.infradead.org; Wed, 28 Sep 2022 02:28:43 +0000
Received: from bogon.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOJKsTNjXAwjAA--.65269S2;
	Wed, 28 Sep 2022 10:28:26 +0800 (CST)
From: Youling Tang <tangyouling@loongson.cn>
To: horms@kernel.org
Cc: kexec@lists.infradead.org,
	Simon Horman <horms@verge.net.au>,
	Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 0/5] Add LoongArch port support
Date: Wed, 28 Sep 2022 10:28:21 +0800
Message-Id: <1664332106-4845-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8DxBOJKsTNjXAwjAA--.65269S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4UWr17ZryUKw1fXw1kZrb_yoW5Xr1kpa
	47Zrn8Jr4rWrn7tryktay5Xws8Jas7Gry2g3Wavry8uFWIqr1UZr18Xr9rZF13J3yrJrWI
	gr1rK3Wag3WUJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JV
	WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4UMxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5X0eJUUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_192838_648113_64C369BD 
X-CRM114-Status: UNSURE (   8.29  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

This patch series to support kexec/kdump (only 64bit).

Note: Kernel kexec/kdump support patch see link [1]:
Link [1]: https://lore.kernel.org/loongarch/711d53ae-197f-3c55-d09d-2f40e6886ad1@loongson.cn/T/#t

Youling Tang (5):
  LoongArch: Add LoongArch architecture support in config.guess and
    config.sub files
  LoongArch: Add kexec/kdump support
  LoongArch: PE format image loading support
  LoongArch: Add purgatory framework code
  LoongArch: Remove redundant cmdline parameters when using
    --reuse-cmdline option

 config/config.guess                           |   3 +
 config/config.sub                             |   1 +
 configure.ac                                  |   3 +
 include/elf.h                                 |   1 +
 include/image.h                               |   1 +
 kexec/Makefile                                |   1 +
 kexec/arch/loongarch/Makefile                 |  22 ++
 kexec/arch/loongarch/crashdump-loongarch.c    | 198 ++++++++++
 kexec/arch/loongarch/crashdump-loongarch.h    |  25 ++
 kexec/arch/loongarch/image-header.h           |  79 ++++
 kexec/arch/loongarch/include/arch/options.h   |  28 ++
 kexec/arch/loongarch/iomem.h                  |  10 +
 kexec/arch/loongarch/kexec-elf-loongarch.c    | 117 ++++++
 .../arch/loongarch/kexec-elf-rel-loongarch.c  |  42 ++
 kexec/arch/loongarch/kexec-loongarch.c        | 374 ++++++++++++++++++
 kexec/arch/loongarch/kexec-loongarch.h        |  60 +++
 kexec/arch/loongarch/kexec-pei-loongarch.c    | 117 ++++++
 kexec/kexec-syscall.h                         |   7 +
 kexec/kexec.c                                 |   2 +-
 kexec/kexec.h                                 |   1 +
 purgatory/Makefile                            |   1 +
 purgatory/arch/loongarch/Makefile             |  10 +
 purgatory/arch/loongarch/console-loongarch.c  |   7 +
 .../arch/loongarch/purgatory-loongarch.c      |   7 +
 .../arch/loongarch/purgatory-loongarch.h      |   6 +
 25 files changed, 1122 insertions(+), 1 deletion(-)
 create mode 100644 kexec/arch/loongarch/Makefile
 create mode 100644 kexec/arch/loongarch/crashdump-loongarch.c
 create mode 100644 kexec/arch/loongarch/crashdump-loongarch.h
 create mode 100644 kexec/arch/loongarch/image-header.h
 create mode 100644 kexec/arch/loongarch/include/arch/options.h
 create mode 100644 kexec/arch/loongarch/iomem.h
 create mode 100644 kexec/arch/loongarch/kexec-elf-loongarch.c
 create mode 100644 kexec/arch/loongarch/kexec-elf-rel-loongarch.c
 create mode 100644 kexec/arch/loongarch/kexec-loongarch.c
 create mode 100644 kexec/arch/loongarch/kexec-loongarch.h
 create mode 100644 kexec/arch/loongarch/kexec-pei-loongarch.c
 create mode 100644 purgatory/arch/loongarch/Makefile
 create mode 100644 purgatory/arch/loongarch/console-loongarch.c
 create mode 100644 purgatory/arch/loongarch/purgatory-loongarch.c
 create mode 100644 purgatory/arch/loongarch/purgatory-loongarch.h

-- 
2.36.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
