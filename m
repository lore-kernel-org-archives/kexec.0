Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA693D47CD0
	for <kexec@archiver.kernel.org>; Fri, 16 Jan 2026 10:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NICP4udlwrmMS68GJYU+R7hTt3v3sBaqdEnclzIl9IQ=; b=xATV+31ENSYoPAO35NujFBjUKc
	Jj0s+/Z9L5vvA9ZtOBuDN14kSFeYOLWVQHHdoxN2ocYYj2wnFAX1xj3uTr+1R2SsfWST6uBk9ZuSB
	BgC39qnEdxweRNVMsi4Txlw+NHvlsZfwKywkOKHafYXWF8s1B1OLOsF95UN/nIW9Sf5/vRGsZLiZi
	K4HqwDxk2llLIEJLh2q2X4/gn3OK9ZMD9ymQygc4j3vhRQ8CcFhtinu6Qe2WVVqN/KIkXB/8CMk8+
	KiLnulMK9T3tB7l94aU4en+yPl0j/KtXFxUebywPbpALFOXHlMwJ1trd5HG4XF6iXQTJANCF3+5Tm
	Cd9afxOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgh9U-0000000Dxoj-3TNB;
	Fri, 16 Jan 2026 10:34:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgh9R-0000000DxoE-2Jhz
	for kexec@lists.infradead.org;
	Fri, 16 Jan 2026 10:33:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768559635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NICP4udlwrmMS68GJYU+R7hTt3v3sBaqdEnclzIl9IQ=;
	b=h5on5zJq0Pgl+wd9xUhNyeL6D6hWVoliJ1HdqrYXPU6FWeGIcKQnVst2Ag52GzezN1nFtc
	n31Lh2gzPp0qvHbGBUeRIpGUhg+yUVzAFrhJLVVmYJuRnKWFggvHogiG7LT/ctvNtR6lYe
	+7mvRD0X0SpytnDK88durhPZsVm6ZBs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-8DWoMF12PqaA6iCBZD_UJQ-1; Fri, 16 Jan 2026 05:33:53 -0500
X-MC-Unique: 8DWoMF12PqaA6iCBZD_UJQ-1
X-Mimecast-MFC-AGG-ID: 8DWoMF12PqaA6iCBZD_UJQ_1768559633
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c6cda4a92so1615040a91.3
        for <kexec@lists.infradead.org>; Fri, 16 Jan 2026 02:33:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768559632; x=1769164432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NICP4udlwrmMS68GJYU+R7hTt3v3sBaqdEnclzIl9IQ=;
        b=LMi0jBAgn4NIWWAYlhCUHpE/akLUQ+jtbRpmSUoKdtNoKMVwTNhM8/VyjMq/Pr18LC
         48JEWyW5KamG+ny2fd9wV0vqXq2DUwO4+6zi0lhQ52mdthwPrJelAg616Q1IdE0g43kV
         7wfgZXSKS6XvUfuXx5plwoJ5y0ag2e8Cy93mWYoJyqcPRrW/5K6OvKPuRizlyb/aKw7B
         DnDsYb5oXS4EcF+7hPRONp1sGi2fnjTlfR8V5rF28N1IpqOS2D+9orXdfI9SOf7MdEuw
         Jm5DomouB12WwaxaKBKaS9HxJ2c8oyMOAtJc0fQ87JJhi6aNa7uPKUnHFDbjiFHFAipx
         YtoQ==
X-Gm-Message-State: AOJu0YzvHS50O7qLXckag0AHZPNnZMVBTa5VYTzGuWC8D93SfiGfUBY+
	7ZooofJl15owsO30UQGUAjHTrVJ7lGkQZTnEXk/DMWU5TyLOhuL7sjBzsHgkFDuTKOmRfy5eA48
	MSUIJrrOQSOtRSYhWdNytbc2ZKQxCngcdN+9dBcFaznPhAMb0F6EnhSOOEEiuNPqlzJV7D3EZe7
	sg0jptARRoNz9hCwxmuKiIu8uJZlwK4sH5xBarUPIiv+Q=
X-Gm-Gg: AY/fxX4BQjZ49ReoT2qOL8wWevVcHGIeEMxwIIZtHAdL7nXNYcD2ar/KGrY7EGCpUh7
	yjwj4t0CdB9gZMn4yd/n5NcRHOKoNH90jkWVUSDZm9GbnrNEh51vHxYSrMUZYWIEFWeBv4gIkrS
	JmPfFS5QO6Ay4cfkRAm1ZToDoCNzlZMHrkYy2AHyPhlmfFgSh5CdUEklSJzArXYHRVNHqCgRs5S
	Km27VwMHFr+yLXC0isyVmTvrsmLLPySCaZe/Zc7m8TZ/rn2dME0LEPlyAG/Ihp0p2g7raBbEnzZ
	pE2qJdUP6w0SPMjGmeUoFMrDbEtFbXAhSy1m7dczW6CObYhCGsmGFj8Ir/xkBqmTPt/HxxmQNq+
	Q
X-Received: by 2002:a17:90b:1a92:b0:34a:9d9a:3f67 with SMTP id 98e67ed59e1d1-35272fcae37mr2173941a91.33.1768559632222;
        Fri, 16 Jan 2026 02:33:52 -0800 (PST)
X-Received: by 2002:a17:90b:1a92:b0:34a:9d9a:3f67 with SMTP id 98e67ed59e1d1-35272fcae37mr2173914a91.33.1768559631566;
        Fri, 16 Jan 2026 02:33:51 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3527310210esm1757108a91.9.2026.01.16.02.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 02:33:51 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-s390@vger.kernel.org (open list:S390 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC] s390x/kdump: pass dm-crypt keys to kdump kernel
Date: Fri, 16 Jan 2026 18:33:46 +0800
Message-ID: <20260116103347.523747-1-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nJvocJWwyXG2IYEoXopDHJUMaWztno34CS59TpsIa_o_1768559633
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260116_023357_667676_4EAF5610 
X-CRM114-Status: GOOD (  22.22  )
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
device dump target by addressing two challenges [1][2],
 - Kdump kernel may not be able to decrypt the LUKS partition. For some
   machines, a system administrator may not have a chance to enter the
   password to decrypt the device in kdump initramfs after the 1st kernel
   crashes

 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump.

To also enable this feature for s390X, we only need to build up the
kernel command parameter dmcryptkeys=<addr> to pass the memory address
of the stored info of dm-crypt keys to kdump kernel. Unlike other
architectures e.g. x86_64, the memory storing the dm-crypt keys won't be
reserved automatically. So also pass the dmcryptkeys_size kernel
parameter to kdump kernel so the memory can be reserved.

Since dm-crypt keys are sensitive data, it will be more secure to place
them in a random way. However the only two ways I can find so far is to
put the keys inside the following two regions,
  1. [crashk_res.start + SZ_64M, crashk_res.start + SZ_64M + SZ_32M]
  2. [data->memsz + SZ_64M, data->memsz + SZ_64M + SZ_4M]

Placing the keys in other regions randomly as bellow can crash the KVM
machine immediately after triggering a kernel panic,

    [data->memsz, data->memsz + SZ_4M]
    [crashk_res.end - SZ_32M, crashk_res.end]

And calling kexec_add_buffer/ipl_report_add_component after loading
kernel image and initramfs doesn't help either.

So obviously I miss something about how
kexec_add_buffer/ipl_report_add_component work in S390. Any advice will
be appreciated! Thanks!

[1] https://lore.kernel.org/all/20250502011246.99238-8-coxu@redhat.com/T/#u
[2] "Write the dump file to encrypted disk volume", Documentation/admin-guide/kdump/kdump.rst

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/s390/kernel/crash_dump.c         |  9 ++++
 arch/s390/kernel/machine_kexec_file.c | 68 +++++++++++++++++++++++++--
 kernel/crash_dump_dm_crypt.c          | 54 +++++++++++++++------
 3 files changed, 114 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index d4839de8ce9d..d941d640c541 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -705,3 +705,12 @@ ssize_t elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 	*ppos += count;
 	return count;
 }
+
+ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos)
+{
+	void *src = __va((phys_addr_t)dm_crypt_keys_addr);
+
+	memcpy(buf, src, count);
+	*ppos += count;
+	return count;
+}
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index a36d7311c668..b881817aad2f 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -239,6 +239,65 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 	return ret;
 }
 
+#ifdef CONFIG_CRASH_DUMP
+static int setup_crash_dmcrypt(struct kimage *image, struct s390_load_data *data,
+			       unsigned long max_command_line_size)
+{
+	struct kexec_buf kexec_buf = { .random = true };
+	unsigned long temp_start, temp_end;
+	size_t cmd_buf_len;
+	char *cmd_buf;
+	int ret;
+
+	ret = crash_load_dm_crypt_keys(image);
+	if (ret == -ENOENT) {
+		kexec_dprintk("No dm crypt key to load\n");
+		return 0;
+	} else if (ret) {
+		pr_err("Failed to load dm crypt keys\n");
+		return -EINVAL;
+	}
+
+	kexec_buf.image = image;
+	kexec_buf.buffer = (void *)image->dm_crypt_keys_addr;
+	kexec_buf.bufsz = image->dm_crypt_keys_sz;
+	kexec_buf.memsz = kexec_buf.bufsz;
+
+	// Place dm-crypt keys randomly above crashk_res.start+SZ_64M
+	temp_start = crashk_res.start + SZ_64M;
+	temp_end = temp_start + SZ_32M;
+	kexec_random_range_start(temp_start, temp_end, &kexec_buf, &temp_start);
+	kexec_buf.mem = ALIGN_DOWN(temp_start, PAGE_SIZE);
+	ret = kexec_add_buffer(&kexec_buf);
+	if (ret)
+		return ret;
+
+	data->memsz = kexec_buf.mem - crashk_res.start;
+	data->memsz += kexec_buf.memsz;
+	ret = ipl_report_add_component(data->report, &kexec_buf, 0, 0);
+	if (ret)
+		return ret;
+
+	image->dm_crypt_keys_addr = kexec_buf.mem;
+	cmd_buf = kasprintf(GFP_KERNEL,
+			    "%s dmcryptkeys=0x%llx dmcryptkeys_size=%lu",
+			    image->cmdline_buf,
+			    kexec_buf.mem - crashk_res.start,
+			    image->dm_crypt_keys_sz);
+	cmd_buf_len = strlen(cmd_buf) + 1;
+
+	if (cmd_buf_len > max_command_line_size) {
+		kfree(cmd_buf);
+		return -ENOMEM;
+	}
+
+	kfree(image->cmdline_buf);
+	image->cmdline_buf_len = cmd_buf_len;
+	image->cmdline_buf = cmd_buf;
+	return 0;
+}
+#endif
+
 void *kexec_file_add_components(struct kimage *image,
 				int (*add_kernel)(struct kimage *image,
 						  struct s390_load_data *data))
@@ -273,9 +332,6 @@ void *kexec_file_add_components(struct kimage *image,
 	if (image->cmdline_buf_len >= max_command_line_size)
 		goto out;
 
-	memcpy(data.parm->command_line, image->cmdline_buf,
-	       image->cmdline_buf_len);
-
 #ifdef CONFIG_CRASH_DUMP
 	if (image->type == KEXEC_TYPE_CRASH) {
 		data.parm->oldmem_base = crashk_res.start;
@@ -293,6 +349,12 @@ void *kexec_file_add_components(struct kimage *image,
 	if (ret)
 		goto out;
 
+	if (setup_crash_dmcrypt(image, &data, max_command_line_size))
+		goto out;
+
+	memcpy(data.parm->command_line, image->cmdline_buf,
+	       image->cmdline_buf_len);
+
 	if (data.kernel_mem == 0) {
 		unsigned long restart_psw =  0x0008000080000000UL;
 		restart_psw += image->start;
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 401423ba477d..67b74d2d0987 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -5,6 +5,7 @@
 #include <linux/crash_dump.h>
 #include <linux/cc_platform.h>
 #include <linux/configfs.h>
+#include <linux/memblock.h>
 #include <linux/module.h>
 
 #define KEY_NUM_MAX 128	/* maximum dm crypt keys */
@@ -48,6 +49,26 @@ static int __init setup_dmcryptkeys(char *arg)
 
 early_param("dmcryptkeys", setup_dmcryptkeys);
 
+static int __init setup_dmcryptkeys_size(char *arg)
+{
+	size_t keys_size;
+	int ret;
+
+	if (dm_crypt_keys_addr == 0) {
+		pr_warn("dmcryptkeys=0\n");
+		return -EINVAL;
+	}
+
+	if (!arg)
+		return -EINVAL;
+
+	ret = kstrtoul(arg, 0, &keys_size);
+	memblock_reserve((phys_addr_t)dm_crypt_keys_addr, keys_size);
+	return 0;
+}
+
+early_param("dmcryptkeys_size", setup_dmcryptkeys_size);
+
 /*
  * Architectures may override this function to read dm crypt keys
  */
@@ -415,22 +436,27 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 			return r;
 	}
 
-	kbuf.buffer = keys_header;
-	kbuf.bufsz = get_keys_header_size(key_count);
+	if (!IS_ENABLED(CONFIG_S390)) {
+		kbuf.buffer = keys_header;
+		kbuf.bufsz = get_keys_header_size(key_count);
 
-	kbuf.memsz = kbuf.bufsz;
-	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
-	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-	r = kexec_add_buffer(&kbuf);
-	if (r) {
-		kvfree((void *)kbuf.buffer);
-		return r;
+		kbuf.memsz = kbuf.bufsz;
+		kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+		r = kexec_add_buffer(&kbuf);
+		if (r) {
+			kvfree((void *)kbuf.buffer);
+			return r;
+		}
+		image->dm_crypt_keys_addr = kbuf.mem;
+		image->dm_crypt_keys_sz = kbuf.bufsz;
+		kexec_dprintk(
+			"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
+			kbuf.bufsz, kbuf.memsz);
+	} else {
+		image->dm_crypt_keys_addr = (unsigned long)keys_header;
+		image->dm_crypt_keys_sz = get_keys_header_size(key_count);
 	}
-	image->dm_crypt_keys_addr = kbuf.mem;
-	image->dm_crypt_keys_sz = kbuf.bufsz;
-	kexec_dprintk(
-		"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
-		kbuf.bufsz, kbuf.memsz);
 
 	return r;
 }

base-commit: 7f98ab9da046865d57c102fd3ca9669a29845f67
-- 
2.52.0


