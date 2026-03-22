Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AD01094481
	for <kexec@archiver.kernel.org>; Sun, 22 Mar 2026 03:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zRoYtoWMobhDxLBaF8G/BRL7/KalCQubI0jjWzgyfa4=; b=UBhSooSgs9KIy+tLHWt2Vii0Yq
	FZ//ZZIKWeMyhw5jdzojOuQAIgpnnfHw82gloGY3wX64awlGrIz5g+kVUZj0ZZxBCSERmx8wk9LeC
	D8xxeyEfZpP+Lcc0Hbx9xiKTvRsbdYD+5ze0bRn3RH2pUQEAssIPdBz31OkMsicQpJlSD7ce0azLK
	w16G89sMzFPDjDjQ+OTrAxGcbF82VQgVwbgmoxL8SJlVwcqgQrboilhuD3yyNNGWr8rADfwzMsid9
	kYa0NVT/N+2XdnuvQv5U+RwdfrQIX95FVFQ67ELdUO06TsNACDqhp1BiLERcJsf9ArbOi6UFXpJOj
	xvyql+YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w49Ls-0000000F0ne-10it;
	Sun, 22 Mar 2026 03:19:44 +0000
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w49Lo-0000000F0nE-2MtZ
	for kexec@lists.infradead.org;
	Sun, 22 Mar 2026 03:19:42 +0000
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowAAntwq8X79p5E8eCw--.19969S2;
	Sun, 22 Mar 2026 11:19:25 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: x86@kernel.org
Cc: pengpeng@iscas.ac.cn,
	kexec@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/kexec: bound bzImage64 setup header copy
Date: Sun, 22 Mar 2026 11:19:24 +0800
Message-ID: <20260322031924.58050-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAntwq8X79p5E8eCw--.19969S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1kKr4kJFy3Xw15JF1UWrg_yoW8CFW8pw
	srX340gw1DJr1Y93y8Zr48CFW3A397ta4agFWUG395tFs0g348KFWIgry29a1j9r4rKF1F
	qw1YyF1S93WkJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbtxhJ
	UUUUU==
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_201940_985019_02FBBCD4 
X-CRM114-Status: GOOD (  11.19  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

`bzImage64_load()` computes the size of the setup header from the image
header bytes and copies that amount into `params->hdr` without first
verifying that the derived size fits the destination `setup_header`.
Current in-tree images line up with the expected header length, but the
loader still trusts the image-derived byte and will happily copy a
larger header area from a malformed bzImage.

Reject setup headers larger than `struct setup_header` before copying
them into `boot_params`.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/x86/kernel/kexec-bzimage64.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 5630c7dca1f3..ac31bf092292 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -587,16 +587,20 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		kbuf.bufsz += sizeof(struct setup_data) +
 			      sizeof(struct kho_data);
 
+	/* Copy setup header onto bootparams. Documentation/arch/x86/boot.rst */
+	setup_header_size = 0x0202 + (unsigned char)kernel[0x0201] -
+			    setup_hdr_offset;
+	if (setup_header_size > sizeof(struct setup_header)) {
+		pr_err("bzImage setup header too large\n");
+		return ERR_PTR(-ENOEXEC);
+	}
+
 	params = kvzalloc(kbuf.bufsz, GFP_KERNEL);
 	if (!params)
 		return ERR_PTR(-ENOMEM);
 	efi_map_offset = params_cmdline_sz;
 	efi_setup_data_offset = efi_map_offset + ALIGN(efi_map_sz, 16);
 
-	/* Copy setup header onto bootparams. Documentation/arch/x86/boot.rst */
-	setup_header_size = 0x0202 + kernel[0x0201] - setup_hdr_offset;
-
-	/* Is there a limit on setup header size? */
 	memcpy(&params->hdr, (kernel + setup_hdr_offset), setup_header_size);
 
 	kbuf.buffer = params;
-- 
2.50.1 (Apple Git-155)


