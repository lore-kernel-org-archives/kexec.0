Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD09BC47BC3
	for <kexec@archiver.kernel.org>; Tue,  6 Jan 2026 07:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T2K+6XYuDT2faPkgFNRf0MMgXkPW9/hzNvicOemZ75A=; b=TvjbTmU2ZD1nJy57z/U6gS9FQD
	0UM+hbzpCpmLtnVEzkLbALC4CkvfzFXvZk33/wMeRezk2Ws4Hfn167jJO+1Jd8Un9YDr3oTmlWRBj
	941uuWnAX7J6puRczXbMavOj72C6fXj8kzFdHzp5zPfplBvTfuE5aT7qHMNYj4YI94uYJrV3Qxj/e
	e9LYHT60vZWqCgdyFuj4T69WcSuEpTiX8mkuW3tHk4gJDmH9chLwuCI6TPWs9blss2Ue3BYO9agyp
	QwYfS2ilHiPC4jGV99S8GKmzhBRBuyr8G2GQ7DOacGQIrDMIAKvGEmhuDU3SzrO6jIAfWRYtkvq/u
	IM9ToORA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd1gV-0000000CXID-2mC2;
	Tue, 06 Jan 2026 07:40:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd1gQ-0000000CXHM-1N3f
	for kexec@lists.infradead.org;
	Tue, 06 Jan 2026 07:40:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767685249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2K+6XYuDT2faPkgFNRf0MMgXkPW9/hzNvicOemZ75A=;
	b=BcM9BoovQyINJagu03E8JUhkKFKTvlnHKE2jjKZClP4fS3hyEgWJXjWwHGkNaRxL2/yWww
	J2wv+EjrNEYuGxJOhL0DRcgiXM9DUvugXt8e45vuUhwOXd53s/k268EE10MOvasFtpjYpH
	rh2jJtkUHWEw3C8KS0kLD19kauzntD8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-A6QJLT7BObaFSUhPnXanyA-1; Tue, 06 Jan 2026 02:40:45 -0500
X-MC-Unique: A6QJLT7BObaFSUhPnXanyA-1
X-Mimecast-MFC-AGG-ID: A6QJLT7BObaFSUhPnXanyA_1767685245
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7c240728e2aso2009873b3a.3
        for <kexec@lists.infradead.org>; Mon, 05 Jan 2026 23:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767685244; x=1768290044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T2K+6XYuDT2faPkgFNRf0MMgXkPW9/hzNvicOemZ75A=;
        b=rS8pmnSpj+Va5yt//GBQ0rw/CZYm+Tuj0yoZJikpTfca3q1xpUvakhvOsUjkhNXZMF
         OzAnBduplOA1VwoQ+R2sQpn0ANP0h7ld5gjDMMcvo+EvGSAGWekYnvW7RPT+akIq3Lco
         UPVFgGbcx1AnIzJC8mSNviXCL5B8pjCetD2eEEsYclJAp3qQQHJO4hgIDr6KR7v09XYi
         adJXGn12ucW0UW+KXjIuZDsgFIlknSKenCoaSHDM1Q/Q37tLYKcPsCfOLpRI80y7RZTF
         Ig1pEZBgUpUJJMak7PeI+46V4NcQ9OW2jExXHWuytz2W1vFKqPHsxoDJIbkXC1Eqiy//
         bV1Q==
X-Gm-Message-State: AOJu0YznNmQLRySTA8If+JJmq/OGvEN+vliG1ChfiWVkFIMsX8s8zNcB
	KZrWb1PKPkjInobotWR/z11bMpphV/f6ZI9gj+Ft2PJs3fFFGPYimxQykkJUP+Hr0s8y26x65+u
	2iJjVU62Xh3lKKvxUy5sokXLdQGVkmy9w9DoLWUwq3b92rsh1jjLf/KjlzbfZFVKAlowZD+rUBX
	m0YorK239S5RKO/VXI7Ikd+lGKB+xrkoHwBByaV9M5uLM=
X-Gm-Gg: AY/fxX5AgZBEMwb55wH2421T0FE8FGfWnTGoWhxr3Sd0yUy5/jC92YtfIqchbftvZY3
	5NdqL0rDjo4dgOJb9+xjZ7fOKv2mq4Inqm3NrXH9+5PPkd8qrQ9Ap387iMxUVLtdgXz3GvDq7xi
	AoyG3aCcSKch/8sie9KZi5XTHYY+qcphnqFspk8GsBW3qrYpwKZnLkaSWvDzByU8diwz00if6k4
	VL4/nrnAwf0ljI9oa/mAAjGif9A8KDOk8ZJcbLTNB516gL4zbajNe0QrH6evFP6sTEzUw0llGZb
	mIHW5OxpP260H7wqhjxlshAdvlwuNij77bqrjIVFlzwDRU+9zwXLu0pLN04YG+e1G7a61WQXyxw
	D
X-Received: by 2002:a05:6a21:6d98:b0:35d:c68e:1b07 with SMTP id adf61e73a8af0-389823e5d3fmr1735578637.54.1767685244371;
        Mon, 05 Jan 2026 23:40:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVUzWKzSkNqbLbBe+L/snCjJ0oavUrUixh1GN3s9rZlQu+O972p1pSFAutekovPq/olCdVFQ==
X-Received: by 2002:a05:6a21:6d98:b0:35d:c68e:1b07 with SMTP id adf61e73a8af0-389823e5d3fmr1735547637.54.1767685243733;
        Mon, 05 Jan 2026 23:40:43 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a2a3sm13338605ad.13.2026.01.05.23.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 23:40:43 -0800 (PST)
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
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] powerpc/kdump: pass dm-crypt keys to kdump kernel
Date: Tue,  6 Jan 2026 15:40:38 +0800
Message-ID: <20260106074039.564707-1-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251226140636.1378505-1-coxu@redhat.com>
References: <20251226140636.1378505-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QVzmM-tnloqZqKijvbPYrHsuy5uikDllOyV8BGKwfCA_1767685245
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_234050_447698_236FD67E 
X-CRM114-Status: GOOD (  23.49  )
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

CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
device dump target by addressing two challenges [1],
 - Kdump kernel may not be able to decrypt the LUKS partition. For some
   machines, a system administrator may not have a chance to enter the
   password to decrypt the device in kdump initramfs after the 1st kernel
   crashes

 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump.

To also enable this feature for PowerPC, we only need to let 1st kernel
build up the kernel command parameter dmcryptkeys as similar to
elfcorehdr to pass the memory address of the stored info of dm-crypt
keys to the kdump kernel.

Note to avoid a building failure [2] caused by undeclared function
crash_load_dm_crypt_keys when CONFIG_CRASH_DUMP is not enabled,
realign the function declaration with CONFIG_CRASH_DM_CRYPT.

[1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
[2] https://lore.kernel.org/oe-kbuild-all/202512272218.ghBaSjzO-lkp@intel.com/

Cc: Thomas Staudt <tstaudt@de.ibm.com>
Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
Cc: Baoquan he <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
v2:
- fix double kfree issue [Sourabh]
- corretly kfree old modified_cmdline
- use imperative mood for commit message
- fix a compiling error caught by kernel test robot

 arch/powerpc/include/asm/kexec.h |  3 ++-
 arch/powerpc/kexec/elf_64.c      | 27 ++++++++++++++++++++++++++-
 arch/powerpc/kexec/file_load.c   | 18 ++++++++++--------
 include/linux/crash_core.h       | 14 +++++++-------
 4 files changed, 45 insertions(+), 17 deletions(-)

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
index 5d6d616404cf..995d7e8e98e1 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -81,13 +81,38 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 
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
+			kfree(cmdline);
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
index 4284f76cbef5..9964c57785f5 100644
--- a/arch/powerpc/kexec/file_load.c
+++ b/arch/powerpc/kexec/file_load.c
@@ -23,36 +23,38 @@
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
 	return cmdline_ptr;
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index d35726d6a415..e128270c703f 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -34,13 +34,6 @@ static inline void arch_kexec_protect_crashkres(void) { }
 static inline void arch_kexec_unprotect_crashkres(void) { }
 #endif
 
-#ifdef CONFIG_CRASH_DM_CRYPT
-int crash_load_dm_crypt_keys(struct kimage *image);
-ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos);
-#else
-static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
-#endif
-
 #ifndef arch_crash_handle_hotplug_event
 static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
 #endif
@@ -96,4 +89,11 @@ static inline void crash_save_cpu(struct pt_regs *regs, int cpu) {};
 static inline int kimage_crash_copy_vmcoreinfo(struct kimage *image) { return 0; };
 #endif /* CONFIG_CRASH_DUMP*/
 
+#ifdef CONFIG_CRASH_DM_CRYPT
+int crash_load_dm_crypt_keys(struct kimage *image);
+ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos);
+#else
+static inline int crash_load_dm_crypt_keys(struct kimage *image) { return 0; }
+#endif
+
 #endif /* LINUX_CRASH_CORE_H */

base-commit: 7f98ab9da046865d57c102fd3ca9669a29845f67
-- 
2.52.0


