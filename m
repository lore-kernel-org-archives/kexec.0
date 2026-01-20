Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD72D2ED0F
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 03:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9+hSevvc4D3COr5J1+esphuUGaXmI53ZhLToHWTFc3c=; b=QjtvYwMTDyaYqEW5LM/PYunQuU
	eJcZpQJLALTRkQ6UglxUh6LlIjVhBBLvRJnM/VkslC/pvgadVXZZ0ti5c7z9vgyT47PFF7pdNd5ak
	1kOqVTbHytBPWLeRBAG1/LfSOpmMCiDopQVjSdSaW7tgIFx2/9g0Cr+JuRLL3zbqFAyHMQYXhQw42
	ReefP3QdouCRletbeuYaxT8t9ZP52aUUP3AZMfVKIb+4JWgvQn0/yFpZbF6+DhZPSVRTwL4/OsUNH
	TgC6mMaj3NZVyMnkNWiT2GrDPRpjDiYm++Q/4bfPIrriSWIMTYfkV8m73yRpyqqFWvIT+1J9qP7gS
	kBW+QEcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2al-000000038AV-1fVb;
	Tue, 20 Jan 2026 03:39:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2ah-0000000387w-1L9l
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 03:39:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768880378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9+hSevvc4D3COr5J1+esphuUGaXmI53ZhLToHWTFc3c=;
	b=D0VSEsFS6nDtBNSLFbDpo7kvpAZTXdvSEf96TvlQkQ2A6Dk8KQ/O/+lZFg5brCVus8NkRh
	QCvNPPHhpHwRbgBgkgXd6+caWc57+s9aIM1bpFhqqtCQxLRkPWlhVfhbOqq/saCT1RZLbT
	0COlGN301i0wf07UhykCc4F/pBKDD6s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-BJXVlf2hOn2No-clyHw5Cw-1; Mon, 19 Jan 2026 22:39:31 -0500
X-MC-Unique: BJXVlf2hOn2No-clyHw5Cw-1
X-Mimecast-MFC-AGG-ID: BJXVlf2hOn2No-clyHw5Cw_1768880371
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ab459c051so10097755a91.0
        for <kexec@lists.infradead.org>; Mon, 19 Jan 2026 19:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768880371; x=1769485171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9+hSevvc4D3COr5J1+esphuUGaXmI53ZhLToHWTFc3c=;
        b=endlcMmmGUmaDs5KDNg8uOH5iJp/nRnwnNxhMByVy34YTpx3BreitheB9kWdbrtYUA
         cHQsG3E8ktCEibN2NksNfTaHMV/y+kAmyp1rERVy1KWDKvgMUMl7SM9PcIKI35paq9c/
         UX9yfPV1McMqftfX6BZxJCN/Z1CDQ/43NtWoEYsZX/COyUee4vWpKbIMfXjIY31LBktE
         lOBjaq7SSNxzTmATlLeXoQib6tvEnz8b3476ptmcKB9LqyrmY95NCzhEtISSVLz6uj9P
         IQ7koFaa15wzkCjDv2FErPfru6cJde0my1TUGl85gl+f+gR7jSazlcoMhOv3ysk1kGrd
         Z1kw==
X-Forwarded-Encrypted: i=1; AJvYcCU0HfZfnNR7Tyl0Cdzzow/IWFBtndOu3tySUaDeTcdNAcu5zKq4S+fmkjMZ/isEmSEF63fEHA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyOBSPD2Lrku1ntdWFaP/6X9h+MgFJUvZ0+7Q6DIB6rK+HaKxMe
	IlSntgblFzJyqzKEggkif9HQRfSSjqsxbq2LbHw0jRCe1UZ4ZDOLrl3OVRf/Lwu0j/wM4CAvo+G
	rTmuwlld0raNTPWIMRWfE7yD3puek1dDpMPVF768kvIH9C3leFyjnmK0JzDfpfg==
X-Gm-Gg: AZuq6aLP6bvXGxI++K+Lcf6nkUX/XuTCN7UhB+mhZEy0iiTKSIuK+DWSiL6SZ4slPPA
	HDi67ngrk66JJWpdDdlwNspPL2ee7ZcbRGBfe79+bhGQP9e7MU/Tml3opt8cdGYbcXawI+lOUHi
	FmETWmsHiZqsu/61XrwOiL7NZ3VGlugEw4Q+WT7KPTH/IJ2y+WoEVzVFiXsRVKo+OkfW3drCDwx
	OCVAD43oYbgo7klrYj49tFEqHbdj1MtzQyjR0Fhdv/dTcnKLq3MuA6ETUkl78w4auMJzVqDuybS
	nT94Lm/fXcyUmiPPR0xflCnOMazQh6du3ZqU/cVH54GBObYUbP+eAojL2lkVcabby3meXF+bsCo
	H8UY4VO5g698zsCG7vw==
X-Received: by 2002:a17:90b:4c12:b0:352:c762:8c2e with SMTP id 98e67ed59e1d1-352c7629112mr495089a91.13.1768880370648;
        Mon, 19 Jan 2026 19:39:30 -0800 (PST)
X-Received: by 2002:a17:90b:4c12:b0:352:c762:8c2e with SMTP id 98e67ed59e1d1-352c7629112mr495081a91.13.1768880370320;
        Mon, 19 Jan 2026 19:39:30 -0800 (PST)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678c6a3dsm13375935a91.13.2026.01.19.19.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 19:39:29 -0800 (PST)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v3 5/8] Add makedumpfile extension support
Date: Tue, 20 Jan 2026 15:54:57 +1300
Message-ID: <20260120025500.25095-6-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260120025500.25095-1-ltao@redhat.com>
References: <20260120025500.25095-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: or8dXZ9cuS0FPAsNH22zuig5ZY3Iw3o4oUKuwPynLC4_1768880371
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_193939_435651_A652B0A3 
X-CRM114-Status: GOOD (  22.51  )
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

This patch will add .so extension support to makedumpfile, similar to crash
extension to crash utility. Currently only "/usr/lib64/makedumpfile/extensions"
and "./extensions" are searched for extensions. Once found, kallsyms and btf
will be initialized so all extensions can benifit from it (Currently makedumpfile
doesn't use these info, we can move the kallsyms/btf init code else where later
if makedumpfile needs them).

The makedumpfile extension is to help users to customize mm page filtering upon
traditional mm page flag filtering, without make code modification on makedumpfile
itself.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile            |  7 +++-
 extension.c         | 82 +++++++++++++++++++++++++++++++++++++++++++++
 extensions/Makefile | 10 ++++++
 makedumpfile.c      |  4 +++
 4 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 extension.c
 create mode 100644 extensions/Makefile

diff --git a/Makefile b/Makefile
index f3f4da8..7e29220 100644
--- a/Makefile
+++ b/Makefile
@@ -45,7 +45,7 @@ CFLAGS_ARCH += -m32
 endif
 
 SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
-SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c
+SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c extension.c
 OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
 SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c arch/riscv64.c
 OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
@@ -126,6 +126,7 @@ eppic_makedumpfile.so: extension_eppic.c
 
 clean:
 	rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.8 makedumpfile.conf.5
+	$(MAKE) -C extensions clean
 
 install:
 	install -m 755 -d ${DESTDIR}/${SBINDIR} ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8
@@ -135,3 +136,7 @@ install:
 	mkdir -p ${DESTDIR}/usr/share/makedumpfile/eppic_scripts
 	install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/usr/share/makedumpfile/makedumpfile.conf.sample
 	install -m 644 -t ${DESTDIR}/usr/share/makedumpfile/eppic_scripts/ $(VPATH)eppic_scripts/*
+
+.PHONY: extensions
+extensions:
+	$(MAKE) -C extensions CC=$(CC)
\ No newline at end of file
diff --git a/extension.c b/extension.c
new file mode 100644
index 0000000..6ee7f4e
--- /dev/null
+++ b/extension.c
@@ -0,0 +1,82 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <dirent.h>
+#include <dlfcn.h>
+#include <stdbool.h>
+#include "kallsyms.h"
+#include "btf_info.h"
+
+static const char *dirs[] = {
+	"/usr/lib64/makedumpfile/extensions",
+	"./extensions",
+};
+
+/* Will only init once */
+static bool init_kallsyms_btf(void)
+{
+	static bool ret = false;
+	static bool has_inited = false;
+
+	if (has_inited)
+		goto out;
+	if (!init_kernel_kallsyms())
+		goto out;
+	if (!init_kernel_btf())
+		goto out;
+	if (!init_module_kallsyms())
+		goto out;
+	if (!init_module_btf())
+		goto out;
+	ret = true;
+out:
+	has_inited = true;
+	return ret;
+}
+
+static void cleanup_kallsyms_btf(void)
+{
+	cleanup_kallsyms();
+	cleanup_btf();
+}
+
+void run_extensions(void)
+{
+	DIR *dir;
+	struct dirent *entry;
+	size_t len;
+	int i;
+	void *handle;
+	char path[512];
+
+	for (i = 0; i < sizeof(dirs) / sizeof(char *); i++) {
+		if ((dir = opendir(dirs[i])) != NULL)
+			break;
+	}
+
+	if (!dir || i >= sizeof(dirs) / sizeof(char *))
+		/* No extensions found */
+		return;
+
+	while ((entry = readdir(dir)) != NULL) {
+		len = strlen(entry->d_name);
+		if (len > 3 && strcmp(entry->d_name + len - 3, ".so") == 0) {
+			/* Will only init when .so exist */
+			if (!init_kallsyms_btf())
+				goto out;
+
+			snprintf(path, sizeof(path), "%s/%s", dirs[i], entry->d_name);
+			handle = dlopen(path, RTLD_NOW);
+			if (!handle) {
+				fprintf(stderr, "%s: Failed to load %s: %s\n",
+					__func__, path, dlerror());
+				continue;
+			}
+			printf("Loaded extension: %s\n", path);
+			dlclose(handle);
+		}
+	}
+out:
+	closedir(dir);
+	cleanup_kallsyms_btf();
+}
\ No newline at end of file
diff --git a/extensions/Makefile b/extensions/Makefile
new file mode 100644
index 0000000..afbc61e
--- /dev/null
+++ b/extensions/Makefile
@@ -0,0 +1,10 @@
+CC ?= gcc
+CONTRIB_SO :=
+
+all: $(CONTRIB_SO)
+
+$(CONTRIB_SO): %.so: %.c
+	$(CC) -O2 -g -fPIC -shared -o $@ $^
+
+clean:
+	rm -f $(CONTRIB_SO)
diff --git a/makedumpfile.c b/makedumpfile.c
index dba3628..ca8ed8a 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -10847,6 +10847,8 @@ update_dump_level(void)
 	}
 }
 
+void run_extensions(void);
+
 int
 create_dumpfile(void)
 {
@@ -10884,6 +10886,8 @@ retry:
 	if (info->flag_refiltering)
 		update_dump_level();
 
+	run_extensions();
+
 	if ((info->name_filterconfig || info->name_eppic_config)
 			&& !gather_filter_info())
 		return FALSE;
-- 
2.47.0


