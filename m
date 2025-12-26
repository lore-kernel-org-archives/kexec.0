Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F6EE8FDA3
	for <kexec@archiver.kernel.org>; Fri, 26 Dec 2025 14:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y8CRsSUdURwt+1GZdBpSW/7VDn07syF3EYe9jZf8o5o=; b=PKTHMTvqtm6rKQX9d3D3cuTCXp
	qIKTkcSJS5uBwtoi2qO4K+4LpUPjkCtOvZnWB7r2jd25MRq5QvD1wOKrNJLkju0XoSNzRJUculzcX
	A5zI7lhRwnku2ljgiuPwZcpPU/5SLGZH58m9KMv+Cemei9oDARrcLA0nC3N2Av0OZ3dxMm6FMwC/8
	aXANJzHeMdECkF6kJZm+nyvmXT1JwZeJi0P1oVWmcRGjDeba7FMLMNVwINy1z+JD7wTlutRY6ttoN
	24i+VA3xIsW5PrUKl+lnfeqL4xhDm3Yfh5IVUHwNHLhQAsxgNIeT6bjcoSLWV7Zud/H1oqDjkXBL7
	5gR8/GsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZ8T1-00000001ELn-1ub4;
	Fri, 26 Dec 2025 14:06:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZ8St-00000001EKx-1kcn
	for kexec@lists.infradead.org;
	Fri, 26 Dec 2025 14:06:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766758004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y8CRsSUdURwt+1GZdBpSW/7VDn07syF3EYe9jZf8o5o=;
	b=FfKHqvymURWg9SNSOg9jwjb5EUllVX9l34Ft0/snPaRpcXB6mO274MlwC4nx3a/PREqepw
	R+D8kebzjLsVN1AFPTx1SBEsrIQ6E7Vh3z2T3xDP1QYlIuC+TnMKe1mnVT+P1723hWE/lT
	1zneCO9eBBshvvBiTqjB9bxu7ga/EU4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-5uBJZFeoOdK3yF7NjnWIqw-1; Fri, 26 Dec 2025 09:06:41 -0500
X-MC-Unique: 5uBJZFeoOdK3yF7NjnWIqw-1
X-Mimecast-MFC-AGG-ID: 5uBJZFeoOdK3yF7NjnWIqw_1766758001
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b9c91b814cso15791650b3a.2
        for <kexec@lists.infradead.org>; Fri, 26 Dec 2025 06:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766758000; x=1767362800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8CRsSUdURwt+1GZdBpSW/7VDn07syF3EYe9jZf8o5o=;
        b=wpMWnVmxYMhtMQotw/KGCThK7ksYNWMlCNvyoVsS0BqqRbcX9v2IGEqp0O/H/vKVm7
         aJtPGQKwaMKOnPAlNFNHy/Tcty9e70CBeY1ijKfFX0ybzU8Rudb54ger1BNdACoCuxbX
         MBbnqzPjsOdV2MnYRHj7YEeGxLitx8S5nASohaJHVNqQYBlg3I5pAQtyLYQOUoiR9pCj
         Bi+kEm8DG6QL1HoOgA0YhdfJkqOnjyrVx+CjaM5jEup14FOIpujD5UPxujrwmYrOQpi1
         C3UiQPxZTx0UfDWE8KeVou6xqn2oPv9G3XT2S+95xLRRM4UZ5NYHvtW5eFdSJFeFuEUy
         9h/A==
X-Gm-Message-State: AOJu0YwWgogxoIIhEAY+5yadiMR1hdg9bbTtvgvDB+3x3FLxm3yDed+V
	JNRb1lvxHqT3WGb9DR1lY27FBtmeKo9r3Q3GYXpuFIY77huO/PHIl/D4JQ7oneHNwcKwTlVEhCA
	dUSorw2sOMbXcUTDHXUTelj1x6Fekoqin6OAXSj8JANFFxSW/aFkEAz3qd1O9V18IhqbkszhiL2
	yHC3xpKABuLtdQ2MuvxOIh0PKebK3K0ZXxGLnqTBux5eM=
X-Gm-Gg: AY/fxX5fO/wxKEu5L2CPOIcV5lAiIDo4gK5aTb9o4cjRuYy36iuFXssKHgGaiKfoYmm
	4LUBUjsVKVwhI7bFCN6LyErWRsDXPTXfGvmeZ/eonxq1Z4Ji+xgo1XucVWF1n4iTtSrPWBZ9SfB
	+W4ffIkuGNHidRseDnqlDxDGiZUK30aO+1Yn4aIk9vT/gsZU1ILKmLHAHmrGLkXwLRAr2Gip42I
	LHOz3W2DnwKTW0/Jj4cd7JD2EBPsORieH8kf7Cbtg1YUv/BvFiLtfOzAaS7wOZ5jYfURhVwsc+W
	ngvhxO7VdRw1nqbTq9tJnqs4v+J3ENP0LV/crUEdkwvrKgWFy2Z1rrhPhcUrYT+n0HKPqqR7hjx
	D
X-Received: by 2002:a05:6a00:1d12:b0:7b8:16af:3bbc with SMTP id d2e1a72fcca58-7ff650ce054mr23365531b3a.31.1766758000434;
        Fri, 26 Dec 2025 06:06:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEq+tXbblae0dYr+YzPkKL41WZvOiKNnm8s7B4kCO2PLoNLBs1kWxXZWgS2A7pofhp162TWMw==
X-Received: by 2002:a05:6a00:1d12:b0:7b8:16af:3bbc with SMTP id d2e1a72fcca58-7ff650ce054mr23365480b3a.31.1766757999833;
        Fri, 26 Dec 2025 06:06:39 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f3d7sm22379085b3a.51.2025.12.26.06.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 06:06:39 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Thomas Staudt <tstaudt@de.ibm.com>,
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
	Baoquan he <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc/kdump: pass dm-crypt keys to kdump kernel
Date: Fri, 26 Dec 2025 22:06:35 +0800
Message-ID: <20251226140636.1378505-1-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q5ElyQoFXv0Rzn6SSXG1lWvMkPcGSwRUdlo3cfpEjss_1766758001
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251226_060647_543775_E0C04D87 
X-CRM114-Status: GOOD (  19.27  )
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

Based on the CONFIG_CRASH_DM_CRYPT feature, this patch adds
LUKS-encrypted device dump target support to PowerPC by addressing two
challenges [1],
 - Kdump kernel may not be able to decrypt the LUKS partition. For some
   machines, a system administrator may not have a chance to enter the
   password to decrypt the device in kdump initramfs after the 1st kernel
   crashes

 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump.

1st kernel will build up the kernel command parameter dmcryptkeys as
similar to elfcorehdr to pass the memory address of the stored info of
dm-crypt keys to the kdump kernel.

[1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/

Cc: Thomas Staudt <tstaudt@de.ibm.com>
Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
Cc: Baoquan he <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/powerpc/include/asm/kexec.h |  3 ++-
 arch/powerpc/kexec/elf_64.c      | 26 +++++++++++++++++++++++++-
 arch/powerpc/kexec/file_load.c   | 19 +++++++++++--------
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index bd4a6c42a5f3..f3d098d543b4 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -80,7 +80,8 @@ struct kimage_arch {
 };
 
 char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
-			  unsigned long cmdline_len);
+			  unsigned long cmdline_len,
+			  char *name, unsigned long addr);
 int setup_purgatory(struct kimage *image, const void *slave_code,
 		    const void *fdt, unsigned long kernel_load_addr,
 		    unsigned long fdt_load_addr);
diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index 5d6d616404cf..57cb3361d91b 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -81,13 +81,37 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 
 		/* Setup cmdline for kdump kernel case */
 		modified_cmdline = setup_kdump_cmdline(image, cmdline,
-						       cmdline_len);
+						       cmdline_len,
+						       "elfcorehdr",
+						       image->elf_load_addr);
 		if (!modified_cmdline) {
 			pr_err("Setting up cmdline for kdump kernel failed\n");
 			ret = -EINVAL;
 			goto out;
 		}
 		cmdline = modified_cmdline;
+		cmdline_len = strlen(cmdline) + 1;
+
+		ret = crash_load_dm_crypt_keys(image);
+		if (ret == -ENOENT) {
+			kexec_dprintk("No dm crypt key to load\n");
+		} else if (ret) {
+			pr_err("Failed to load dm crypt keys\n");
+			return ERR_PTR(ret);
+		}
+
+		if (image->dm_crypt_keys_addr != 0) {
+			modified_cmdline = setup_kdump_cmdline(image, cmdline,
+							       cmdline_len,
+							       "dmcryptkeys",
+							       image->dm_crypt_keys_addr);
+			if (!modified_cmdline) {
+				pr_err("Setting up cmdline for kdump kernel failed\n");
+				ret = -EINVAL;
+				goto out;
+			}
+			cmdline = modified_cmdline;
+		}
 	}
 
 	if (initrd != NULL) {
diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
index 4284f76cbef5..e1c08050286d 100644
--- a/arch/powerpc/kexec/file_load.c
+++ b/arch/powerpc/kexec/file_load.c
@@ -23,38 +23,41 @@
 #define SLAVE_CODE_SIZE		256	/* First 0x100 bytes */
 
 /**
- * setup_kdump_cmdline - Prepend "elfcorehdr=<addr> " to command line
+ * setup_kdump_cmdline - Prepend "<name>=<addr> " to command line
  *                       of kdump kernel for exporting the core.
  * @image:               Kexec image
  * @cmdline:             Command line parameters to update.
  * @cmdline_len:         Length of the cmdline parameters.
+ * @name:                Name e.g elfcorehdr.
+ * @addr:                Memory address.
  *
  * kdump segment must be setup before calling this function.
  *
  * Returns new cmdline buffer for kdump kernel on success, NULL otherwise.
  */
 char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
-			  unsigned long cmdline_len)
+			  unsigned long cmdline_len,
+			  char *name, unsigned long addr)
 {
-	int elfcorehdr_strlen;
+	unsigned long parameter_len;
 	char *cmdline_ptr;
 
 	cmdline_ptr = kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
 	if (!cmdline_ptr)
 		return NULL;
 
-	elfcorehdr_strlen = sprintf(cmdline_ptr, "elfcorehdr=0x%lx ",
-				    image->elf_load_addr);
+	parameter_len = sprintf(cmdline_ptr, "%s=0x%lx ", name, addr);
 
-	if (elfcorehdr_strlen + cmdline_len > COMMAND_LINE_SIZE) {
-		pr_err("Appending elfcorehdr=<addr> exceeds cmdline size\n");
+	if (parameter_len + cmdline_len > COMMAND_LINE_SIZE) {
+		pr_err("Appending %s=<addr> exceeds cmdline size\n", name);
 		kfree(cmdline_ptr);
 		return NULL;
 	}
 
-	memcpy(cmdline_ptr + elfcorehdr_strlen, cmdline, cmdline_len);
+	memcpy(cmdline_ptr + parameter_len, cmdline, cmdline_len);
 	// Ensure it's nul terminated
 	cmdline_ptr[COMMAND_LINE_SIZE - 1] = '\0';
+	kfree(cmdline);
 	return cmdline_ptr;
 }
 

base-commit: ccd1cdca5cd433c8a5dff78b69a79b31d9b77ee1
-- 
2.52.0


