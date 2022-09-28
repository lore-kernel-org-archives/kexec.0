Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298ADC6FA8E
	for <kexec@archiver.kernel.org>; Wed, 28 Sep 2022 02:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ntx+UJjdN0iqKSk2mrXR3Go7iYYNb4EuYzeafOrrUOo=; b=uWdJvzZarV+pon
	ZL5aVCOdycjC1BI6x9cTWhaJt6RAewBjNaweMcFoS1EtbbZyH0Ka07X5+AqTrcy/xzyN3qSYxOHHu
	G3bnpVnqWJnq2Rev8XIu+1ogZkIyLVTv0p5vcEeodpT2Eyx9soIGLJ9dcjTlJYdLgGf5B6IETH+QX
	ljUejWd5FWydIYDpJQjS0jKkASlIfitViz46mlVc3vqfvscxTNGLJImLsqfnxLIwk21gdm5tNLgBX
	/Puwnl8sXarZHvT0WduRqMdzmZ6zF2BxS9k8+HvyIZrfuHPgg2tm22rtRK0QyPol2LoEgGqw6v2gz
	hMXErkh+pkLfqiI4mZBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odMoV-00DaK1-1U; Wed, 28 Sep 2022 02:28:43 +0000
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odMoQ-00DaDL-4Z
	for kexec@lists.infradead.org; Wed, 28 Sep 2022 02:28:40 +0000
Received: from bogon.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOJKsTNjXAwjAA--.65269S7;
	Wed, 28 Sep 2022 10:28:30 +0800 (CST)
From: Youling Tang <tangyouling@loongson.cn>
To: horms@kernel.org
Cc: kexec@lists.infradead.org,
	Simon Horman <horms@verge.net.au>,
	Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 5/5] LoongArch: Remove redundant cmdline parameters when using --reuse-cmdline option
Date: Wed, 28 Sep 2022 10:28:26 +0800
Message-Id: <1664332106-4845-6-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1664332106-4845-1-git-send-email-tangyouling@loongson.cn>
References: <1664332106-4845-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8DxBOJKsTNjXAwjAA--.65269S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw43KrW7tw4DGw17tw1rXrb_yoW8Zw1fpr
	WxZF9xGw1rJ3ZFyry8JFs5uw1fX34DGr9Fqa12v3srJF4qqry8XryFqF1YvF1Yq3yrKFW2
	9r1FvrnYvF1xC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWx
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4UMxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUY1a0PUUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_192838_618480_67F4BA46 
X-CRM114-Status: UNSURE (   9.29  )
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

In LoongArch, when using the --reuse-cmdline option to reuse the current
command line, it may lead to redundancy (like kexec, initrd command line
arguments). In order to avoid the possible impact of initrd removal on other
architectures, remove_parameter will be called in a specific architecture
for processing.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 kexec/arch/loongarch/kexec-loongarch.c | 2 ++
 kexec/kexec.c                          | 2 +-
 kexec/kexec.h                          | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
index 3fdba01..4c7361c 100644
--- a/kexec/arch/loongarch/kexec-loongarch.c
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -219,6 +219,8 @@ int arch_process_options(int argc, char **argv)
 			break;
 		case OPT_REUSE_CMDLINE:
 			cmdline = get_command_line();
+			remove_parameter(cmdline, "kexec");
+			remove_parameter(cmdline, "initrd");
 			break;
 		case OPT_INITRD:
 			arch_options.initrd_file = optarg;
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 829a6ea..0e92d96 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1095,7 +1095,7 @@ static int k_status(unsigned long kexec_flags)
 /*
  * Remove parameter from a kernel command line. Helper function by get_command_line().
  */
-static void remove_parameter(char *line, const char *param_name)
+void remove_parameter(char *line, const char *param_name)
 {
 	char *start, *end;
 
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 8a05644..0d820ad 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -304,6 +304,7 @@ int arch_compat_trampoline(struct kexec_info *info);
 void arch_update_purgatory(struct kexec_info *info);
 int is_crashkernel_mem_reserved(void);
 int get_crash_kernel_load_range(uint64_t *start, uint64_t *end);
+void remove_parameter(char *line, const char *param_name);
 char *get_command_line(void);
 
 int kexec_iomem_for_each_line(char *match,
-- 
2.36.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
