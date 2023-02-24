Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A71C677F1
	for <kexec@archiver.kernel.org>; Fri, 24 Feb 2023 09:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HhdCD9/S+IJdEk7FtratnEppoKxopEgl/EVOdUQksrc=; b=SyLFStHpIEmOQq
	FX9GdW92WtK3AA8hWQBB4Lxly4WxBNt49cpk+0MuT9HzHUNIe0p9pHky8dNHucH+hyNZ8d2uhjb2I
	yujxdhvMyndsRoBJeFbSIKfX9IK9oT+4RH+gbgaCn4vriQjsLSKBUl5QelIJkAwIGQi+cNPpwIvp2
	MowZNuOOMcpe5JaatA0wFRppa25iqZMNmSFuvmE7PkDSpvXHjENOAAgIfB2d0bfo50M1260jIY63U
	VNgCgxn3GtOXNy0PgFCZOnzLC5GtIYLkqbZGmq3YhOaMpZvCR+Y93POMSE+7Kipr83PL0BhVyJJtB
	Kq2YrA0KndcRhBSDr4lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVUjb-001kmi-12; Fri, 24 Feb 2023 09:51:23 +0000
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVUjW-001kj3-IS
	for kexec@lists.infradead.org; Fri, 24 Feb 2023 09:51:20 +0000
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx_82NiPhjkqIEAA--.3664S3;
	Fri, 24 Feb 2023 17:51:09 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxUuWNiPhjInw6AA--.5816S2;
	Fri, 24 Feb 2023 17:51:09 +0800 (CST)
From: Youling Tang <tangyouling@loongson.cn>
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org
Subject: [PATCH 1/2] kexec: Default __NR_kexec_file_load is set to undefined
Date: Fri, 24 Feb 2023 17:51:07 +0800
Message-Id: <1677232268-2451-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8DxUuWNiPhjInw6AA--.5816S2
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvdXoWrtryrtF4xXrWDZr48uw1rZwb_yoWftFb_Ka
	4xXrnF9ryjgF92yF4UKw4rtFyFqw17Wr45G34xWanrCa4UJw4DZr9IyFs8AF13Ga97tFy3
	CrZaqr4jvr45WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
	xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
	17kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
	AFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
	6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7
	xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
	0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
	W8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUUU
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230224_015119_059289_897DD37C 
X-CRM114-Status: UNSURE (   7.16  )
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

The initial reason is that after the merger of 29fe5067ed07
("kexec: make -a the default"), kexec cannot be used on LoongArch,
MIPS .etc architectures. We need to add "-c" for normal use. The
current kexec_file_load system call is not implemented in
architectures such as LoongArch, so it needs to pass kexec_load.
So we need to set __NR_kexec_file_load to undefined in unsupported
architectures. This will return EFALLBACK via is_kexec_file_load_implemented,
and then via kexec_load.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 kexec/kexec-syscall.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index be6ccd5..ea77936 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -59,9 +59,7 @@
 #endif
 #endif /*ifndef __NR_kexec_load*/
 
-#ifdef __arm__
 #undef __NR_kexec_file_load
-#endif
 
 #ifndef __NR_kexec_file_load
 
-- 
2.37.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
