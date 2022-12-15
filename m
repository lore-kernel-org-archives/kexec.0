Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0569C4167B
	for <kexec@archiver.kernel.org>; Thu, 15 Dec 2022 18:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gFU7a/7lchjKOExlU/PhumTTPCJulpFdbLvrVabrhu8=; b=mMaRKuuJrw4iFA
	j/CkORXT1A3etrn84okfGdCQvRD5m2zZuPCfWUcwmrBDXlwLSYPsDlqCVsFZHKn6E37tBnmbPuI6K
	vRRTgEWs6dKKHFHNBo76vfMlrUxyjM4OJbcl2hhyDaPNAk3U0x2/+OeyOI+J8X20H8MLwHSFD51MP
	EJLdX1Ob8V2OAsxaJEKqHCw1Mc5+M8vsBd1LViC6kDlI3sajD2f11fV40EdSK+U7TKPqbTHk0nTXk
	01DfNf2LaPBisZMPb+M1iyRHO8B1l+n3RD4ojzf1vVqUi+O8yOTxNXilZjtHz7+QE5z7Hj7prsb9L
	a35B5x7+oRy+aio9Rfbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5stc-00AoV4-57; Thu, 15 Dec 2022 18:23:52 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5stZ-00AoSz-DI
	for kexec@lists.infradead.org; Thu, 15 Dec 2022 18:23:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id C6820B81C39;
	Thu, 15 Dec 2022 18:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AA7C433D2;
	Thu, 15 Dec 2022 18:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671128626;
	bh=b2movO2QDbJENwvsGD8QiYwsUZPp0zsJc8kXD8M/tfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hpSboetvljJzT63/IrlGiNOoqueazi0K6h+vUaIhfAanjtpjBAkBTKVgJJG/2RWQc
	 hiLxABCFF8bWCWPfpJPqwLg7hb258NlP2t951bgnQWjs5C5EtyGqiIoJKdq6glnQjO
	 aoyTTVFxNQdiMpaXRYuoMGBlBxcDDoKsqxmKXrWrPRnXy7PCGYffORUVHfCo/GrueN
	 5yDYYcD1RPbhUTVekdJBe/9+c4aCtRDItoFN8EjGv/xz8kt9V61Tsqy38PVNfj4JXk
	 l7xuVmhzhHHkm86E8wFqTwgZSMt4n9paAa/oivBrIw/6P6MKOj9IxhYINqy9n/KysN
	 P87CCcvHMoE8A==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] x86/kexec: Remove unnecessary arch_kexec_kernel_image_load()
Date: Thu, 15 Dec 2022 12:23:38 -0600
Message-Id: <20221215182339.129803-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215182339.129803-1-helgaas@kernel.org>
References: <20221215182339.129803-1-helgaas@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_102349_818697_554D7E83 
X-CRM114-Status: GOOD (  10.18  )
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

From: Bjorn Helgaas <bhelgaas@google.com>

The x86 implementation of arch_kexec_kernel_image_load() is functionally
identical to the generic arch_kexec_kernel_image_load().

Remove it and use the generic arch_kexec_kernel_image_load().  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/include/asm/kexec.h       |  3 ---
 arch/x86/kernel/machine_kexec_64.c | 11 -----------
 include/linux/kexec.h              |  2 --
 3 files changed, 16 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index a3760ca796aa..5b77bbc28f96 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -200,9 +200,6 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 				     const Elf_Shdr *symtab);
 #define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
 
-void *arch_kexec_kernel_image_load(struct kimage *image);
-#define arch_kexec_kernel_image_load arch_kexec_kernel_image_load
-
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
 #endif
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 0611fd83858e..1a3e2c05a8a5 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -374,17 +374,6 @@ void machine_kexec(struct kimage *image)
 /* arch-dependent functionality related to kexec file-based syscall */
 
 #ifdef CONFIG_KEXEC_FILE
-void *arch_kexec_kernel_image_load(struct kimage *image)
-{
-	if (!image->fops || !image->fops->load)
-		return ERR_PTR(-ENOEXEC);
-
-	return image->fops->load(image, image->kernel_buf,
-				 image->kernel_buf_len, image->initrd_buf,
-				 image->initrd_buf_len, image->cmdline_buf,
-				 image->cmdline_buf_len);
-}
-
 /*
  * Apply purgatory relocations.
  *
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 5dd4343c1bbe..c08d5d52223a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -207,12 +207,10 @@ static inline int arch_kimage_file_post_load_cleanup(struct kimage *image)
 }
 #endif
 
-#ifndef arch_kexec_kernel_image_load
 static inline void *arch_kexec_kernel_image_load(struct kimage *image)
 {
 	return kexec_image_load_default(image);
 }
-#endif
 
 #ifdef CONFIG_KEXEC_SIG
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
