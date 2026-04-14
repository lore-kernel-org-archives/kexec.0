Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B23ED7B9A
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 10:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yAmmJoKjnToZ3BZiTEhpcGIqJ9YxBm3d19sROYLfw0E=; b=g59+A3P8DhKLOiAEsEkM9NzkWx
	5jR3MtfVP4wIYqIF21UQDDIQyPXcMQGvGPJMhfHWms+LDiBTIQRKIcA3YcQwfw850avYmvXJIbTjw
	p5jVtstTbOz5AdvhhmtFcO5oFUcdVn9AC9LLz4P441HFHtOxN7fHA3C1kL3e5MnNhnQNtS0d8F0c7
	PkmMauSE0hgFcIYWlvlB/wcLPOOoKE85UY6Wn/LgkIe8UwbEF0TVIKjxQnVj46k3RjRQ/TcMVpuLw
	AIcaxsAckkvfrH56ZAS9DhhhbIE6x3FQcFOf9QtoAz3rIHwqtouw3Pu8GjQnMMwCv/DuH7elQ1r+j
	2ruOBEpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazk-0000000H90t-28H5;
	Tue, 14 Apr 2026 10:27:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazh-0000000H8zI-2yOq
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 10:27:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776162464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAmmJoKjnToZ3BZiTEhpcGIqJ9YxBm3d19sROYLfw0E=;
	b=CdhoaHUpTYtuXf0z40ks+VRB8cumepOZ9ZZZj+UlCDkfxMY4pCWoMC9UZELQlduHrZeUuQ
	hCw07+9ZgbiiXORyVPCbtMHMbJwyBihS0X2uJEfqzsdAEq+krmrU7fAZ4quzcSWQhL/Ze9
	+ml2dctg+6i3kYYSSzgfqaTdjowr0NM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-WDvZIYmeMPy57bqklHyV9g-1; Tue, 14 Apr 2026 06:27:43 -0400
X-MC-Unique: WDvZIYmeMPy57bqklHyV9g-1
X-Mimecast-MFC-AGG-ID: WDvZIYmeMPy57bqklHyV9g_1776162462
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3568090851aso12308561a91.1
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 03:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162462; x=1776767262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yAmmJoKjnToZ3BZiTEhpcGIqJ9YxBm3d19sROYLfw0E=;
        b=rlOEx073Z6XNDuaQFgvpf55ZKXnDFq5KF2U+WSdDYijibOYHopIo3xGNd1gFV3U+Uo
         ZDCqddM6vesPTik53pNbfm2FhkiJA7VYrpMm9DiSqaaQxv9sogmwXHg6WSs+LC9ennNk
         NByCtW0BPI/zEgE5qySm0j3WsdTrYSEnyg6SikNO52LCMuouzyvkpSfyk+lQ561wcMtL
         uGhX4n6YGpcxweIAyw7tDudcmWWrsSCp3i0g8u19MVzkEZvGPpAbOegwT55GHdBdak44
         +aVfbvDXBg39FF4vtrw/azYxTbs7HBvOUjLHGkjj9vfifHaBK3JHyGJEZCzvLXccWIet
         Mglw==
X-Forwarded-Encrypted: i=1; AFNElJ9Ms9jphtFVOHxt4HOWG6lSmdqbr5r7bLovLhLc+uSWE/dHlllmhIIkWcNdTsK4SXCIIuczAA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxb7qxsyTpLoOeFNYDX3fWxyPhyzFyu28TtJZNLy/g07e9l0y/f
	o916eLQPfp9Vnn9Yfa5+QwFN5sxkWsk4+fGyq7RdjmcazAUfxf9Ry9zMtuNRdcRMS3BVBHlxQ3/
	Avd0yHXzl7FGNo3YcaJTan7gQSbM8GIUbH/CTqCBtfOCsKKArzQUOD/ejXWQKRQ==
X-Gm-Gg: AeBDieuo7XPLtpPi7NPInTQ3BhXGUOW00wGM+pNt9c0jPkpXYaRwlgt5zaqEFO8yr6p
	p1Y8BUFyhy0JqpzieswjLtCmJIDtP83kivtIMNuy0k+KQSvAuDAxRgEEFBzqkqgTTpkeFAlxJ8U
	6ki2ORWLqqMLShO8iymUJ4Iys8Abx7iLdL3e78y9VnKLsJa9vG4kVkfCZAJeOhy3yCaheIpMtXj
	GMMVFcmbOzkBUcCYwgTCBlZnc+WqW5XC/PMhZdIzgaiYE41x4IdTkrVME5sccP87C12+mdDfCfn
	IX8D/3oNLjzJT8QtwgaPtq2ardMY7eP67DdVENTept0T5hfrexSgoENNEyA2Fb+kMNwwP+C0u1o
	A0rE0kVhqT+uxT9fQp7RacG7cCht8TOuLmrmhjAyty5ozaB1OnuJDi0LpBqwH+biDPJQ+
X-Received: by 2002:a17:90b:3c0c:b0:35f:b9ea:8f9f with SMTP id 98e67ed59e1d1-35fb9ea912dmr6208219a91.16.1776162461651;
        Tue, 14 Apr 2026 03:27:41 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0c:b0:35f:b9ea:8f9f with SMTP id 98e67ed59e1d1-35fb9ea912dmr6208183a91.16.1776162460958;
        Tue, 14 Apr 2026 03:27:40 -0700 (PDT)
Received: from localhost.localdomain (122-63-70-7.mobile.spark.co.nz. [122.63.70.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f431c3sm136809165ad.79.2026.04.14.03.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:27:40 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v5][makedumpfile 6/9] Add makedumpfile extensions support
Date: Tue, 14 Apr 2026 22:26:53 +1200
Message-ID: <20260414102656.55200-7-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260414102656.55200-1-ltao@redhat.com>
References: <20260414102656.55200-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qQ49rlWfeCsRkemUrN3DIC96PgpOnhbWAMOA4aciWdw_1776162462
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_032745_902122_F2702C70 
X-CRM114-Status: GOOD (  28.57  )
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

The extensions can be specified by makedumpfile cmdline parameter as
"--extension", followed by extension's filename or absolute path. If
filename is give, then "./", "./extenisons" and
"/usr/lib64/makedumpfile/extensions/" will be searched.

The procedures of extensions are as follows:

Step 0: Every extensions will declare which kernel symbol/types they needed
during programming. This info will be stored within .init_ksyms/ktypes section.
Also extension will have a callback function for makedumpfile to call.

Step 1: Register .init_ksyms and .init_ktypes sections of makedumpfile
itself and extension's .so files, then tell kallsyms/btf subcomponent that which
kernel symbols/types will be resolved. And callbacks are also registered.

Step 2: Init kernel/module's btf/kallsyms on demand. Any un-needed kenrel
modules will be skipped.

Step 3: During btf/kallsyms parsing, the needed info will be filled. For
syms/types which are defined via INIT_MOD_OPT(...) macro, these are optinal
syms/types, it won't fail at parsing step if any are missing, instead, they
need to be checked within extension_init() of each extensions; Otherwise for
syms/types which defined via INIT_MOD(...) macro, these are must-have syms/types,
if any missing, the extension will fail at this step and as a result
this extension will be skipped.

After this step, required kernel symbol value and kernel types size/offset
are resolved, the extensions are ready to go.

Step 4: When makedumpfile doing page filtering, in addition to its
original filtering mechanism, it will call extensions callbacks for advices
whether the page should be included/excluded.

Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile            |  13 +-
 extension.c         | 338 ++++++++++++++++++++++++++++++++++++++++++++
 extension.h         |  16 +++
 extensions/Makefile |  11 ++
 makedumpfile.c      |  41 +++++-
 makedumpfile.h      |   1 +
 6 files changed, 413 insertions(+), 7 deletions(-)
 create mode 100644 extension.c
 create mode 100644 extension.h
 create mode 100644 extensions/Makefile

diff --git a/Makefile b/Makefile
index 690ef3e..061e8e1 100644
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
@@ -73,6 +73,11 @@ LIBS := -lzstd $(LIBS)
 CFLAGS += -DUSEZSTD
 endif
 
+ifeq ($(EXTENSION), on)
+LIBS := -lbpf $(LIBS)
+CFLAGS += -DEXTENSION
+endif
+
 ifeq ($(DEBUG), on)
 # Requires libasan
 CFLAGS += -fsanitize=address
@@ -126,6 +131,7 @@ eppic_makedumpfile.so: extension_eppic.c
 
 clean:
 	rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.8 makedumpfile.conf.5
+	$(MAKE) -C extensions clean
 
 install:
 	install -m 755 -d ${DESTDIR}/${SBINDIR} ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8
@@ -135,3 +141,8 @@ install:
 	mkdir -p ${DESTDIR}/usr/share/makedumpfile/eppic_scripts
 	install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/usr/share/makedumpfile/makedumpfile.conf.sample
 	install -m 644 -t ${DESTDIR}/usr/share/makedumpfile/eppic_scripts/ $(VPATH)eppic_scripts/*
+
+.PHONY: extensions
+extensions:
+	$(MAKE) -C extensions CC=$(CC)
+
diff --git a/extension.c b/extension.c
new file mode 100644
index 0000000..017c980
--- /dev/null
+++ b/extension.c
@@ -0,0 +1,338 @@
+#include <stdio.h>
+#include "extension.h"
+#include "makedumpfile.h"
+#ifdef EXTENSION
+#include <string.h>
+#include <dirent.h>
+#include <dlfcn.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include "kallsyms.h"
+#include "btf_info.h"
+
+typedef int (*callback_fn)(unsigned long, const void *);
+
+struct extension_handle_cb {
+	void *handle;
+	callback_fn cb;
+};
+
+/* Extension .so extension_handle_cb array */
+static struct extension_handle_cb **handle_cbs = NULL;
+static int handle_cbs_len = 0;
+static int handle_cbs_cap = 0;
+
+/* Extension option array */
+static char **extension_opts = NULL;
+static int extension_opts_len = 0;
+static int extension_opts_cap = 0;
+
+static const char *dirs[] = {
+	"./",
+	"./extensions/",
+	"/usr/lib64/makedumpfile/extensions/",
+};
+
+bool add_extension_opts(char *opt)
+{
+	if (!add_to_arr((void ***)&extension_opts, &extension_opts_len,
+			&extension_opts_cap, opt)) {
+		/*
+		 * If fail, print error info and skip the extension.
+		*/
+		ERRMSG("Fail to add extension %s\n", opt);
+		return false;
+	} else {
+		return true;
+	}
+}
+
+static bool init_kallsyms_btf(void)
+{
+	int count;
+	bool ret = false;
+	/* We will load module's btf/kallsyms on demand */
+	bool init_ksyms_module = false;
+	bool init_ktypes_module = false;
+
+	if (check_ksyms_require_modname("vmlinux", &count)) {
+		if (!init_kernel_kallsyms())
+			goto out;
+		if (count >= 2)
+			init_ksyms_module = true;
+	}
+	if (check_ktypes_require_modname("vmlinux", &count)) {
+		if (!init_kernel_btf())
+			goto out;
+		if (count >= 2)
+			init_ktypes_module = true;
+	}
+	if (init_ksyms_module && !init_module_kallsyms())
+		goto out;
+	if (init_ktypes_module && !init_module_btf())
+		goto out;	
+	ret = true;
+out:
+	return ret;
+}
+
+static void cleanup_kallsyms_btf(void)
+{
+	cleanup_kallsyms();
+	cleanup_btf();
+}
+
+static void load_extensions(void)
+{
+	char path[512];
+	int len, i, j;
+	void *handle;
+	struct extension_handle_cb *ehc;
+
+	for (i = 0; i < extension_opts_len; i++) {
+		handle = NULL;
+		if (!extension_opts[i])
+			continue;
+		if ((len = strlen(extension_opts[i])) <= 3 ||
+		    (strcmp(extension_opts[i] + len - 3, ".so") != 0)) {
+			ERRMSG("Skip invalid extension: %s\n", extension_opts[i]);
+			continue;
+		}
+
+		if (extension_opts[i][0] == '/') {
+			/* Path & filename */
+			snprintf(path, sizeof(path), "%s", extension_opts[i]);
+			handle = dlopen(path, RTLD_NOW);
+			if (!handle) {
+				ERRMSG("Failed to load %s\n", dlerror());
+				continue;
+			}
+		} else {
+			/* Only filename */
+			for (j = 0; j < sizeof(dirs) / sizeof(char *); j++) {
+				snprintf(path, sizeof(path), "%s", dirs[j]);
+				len = strlen(path);
+				snprintf(path + len, sizeof(path) - len, "%s",
+					extension_opts[i]);
+				if (access(path, F_OK) == 0) {
+					handle = dlopen(path, RTLD_NOW);
+					if (handle)
+						break;
+					else
+						ERRMSG("Failed to load %s\n", dlerror());
+				}
+			}
+			if (!handle && j >= sizeof(dirs) / sizeof(char *)) {
+				ERRMSG("Not found %s\n", extension_opts[i]);
+				continue;
+			}
+		}
+
+		if (dlsym(handle, "extension_init") == NULL) {
+			ERRMSG("Skip extension %s: No extension_init()\n", path);
+			dlclose(handle);
+			continue;
+		}
+
+		if ((ehc = malloc(sizeof(struct extension_handle_cb))) == NULL) {
+			ERRMSG("Skip extension %s: No memory\n", path);
+			dlclose(handle);
+			continue;
+		}
+
+		ehc->handle = handle;
+		ehc->cb = dlsym(handle, "extension_callback");
+
+		if (!add_to_arr((void ***)&handle_cbs, &handle_cbs_len, &handle_cbs_cap, ehc)) {
+			ERRMSG("Failed to load %s\n", extension_opts[i]);
+			free(ehc);
+			dlclose(handle);
+			continue;
+		}
+		MSG("Loaded extension: %s\n", path);
+	}
+}
+
+static bool register_extension_sections(void)
+{
+	char *start, *stop;
+	int i;
+	bool ret = false;
+
+	for (i = 0; i < handle_cbs_len; i++) {
+		start = dlsym(handle_cbs[i]->handle, "__start_init_ksyms");
+		stop = dlsym(handle_cbs[i]->handle, "__stop_init_ksyms");
+		if (!register_ksym_section(start, stop))
+			goto out;
+
+		start = dlsym(handle_cbs[i]->handle, "__start_init_ktypes");
+		stop = dlsym(handle_cbs[i]->handle, "__stop_init_ktypes");
+		if (!register_ktype_section(start, stop))
+			goto out;
+	}
+	ret = true;
+out:
+	return ret;
+}
+
+void cleanup_extensions(void)
+{
+	for (int i = 0; i < handle_cbs_len; i++) {
+		dlclose(handle_cbs[i]->handle);
+		free(handle_cbs[i]);
+	}
+	if (handle_cbs) {
+		free(handle_cbs);
+		handle_cbs = NULL;
+	}
+	handle_cbs_len = 0;
+	handle_cbs_cap = 0;
+	if (extension_opts) {
+		free(extension_opts);
+		extension_opts = NULL;
+	}
+	extension_opts_len = 0;
+	extension_opts_cap = 0;
+
+	cleanup_kallsyms_btf();
+}
+
+static bool check_required_ksyms_all_resolved(void *handle)
+{
+	char *start, *stop;
+	struct ksym_info **p;
+	bool ret = true;
+
+	start = dlsym(handle, "__start_init_ksyms");
+	stop = dlsym(handle, "__stop_init_ksyms");
+
+	for (p = (struct ksym_info **)start;
+	     p < (struct ksym_info **)stop;
+	     p++) {
+		if ((*p)->sym_required && !SYM_EXIST(*p)) {
+			ret = false;
+			ERRMSG("Symbol %s in %s not found\n",
+				(*p)->symname, (*p)->modname);
+		}
+	}
+
+	return ret;
+}
+
+static bool check_required_ktypes_all_resolved(void *handle)
+{
+	char *start, *stop;
+	struct ktype_info **p;
+	bool ret = true;
+
+	start = dlsym(handle, "__start_init_ktypes");
+	stop = dlsym(handle, "__stop_init_ktypes");
+
+	for (p = (struct ktype_info **)start;
+	     p < (struct ktype_info **)stop;
+	     p++) {
+		if (!TYPE_EXIST(*p)) {
+			if ((*p)->member_required) {
+				ret = false;
+				ERRMSG("Member %s of struct %s in %s not found\n",
+					(*p)->member_name, (*p)->struct_name,
+					(*p)->modname);
+			} else if ((*p)->struct_required) {
+				ret = false;
+				ERRMSG("Struct %s in %s not found\n",
+					(*p)->struct_name, (*p)->modname);
+			}
+		}
+	}
+
+	return ret;
+}
+
+static bool extension_runnable(void *handle)
+{
+	return check_required_ksyms_all_resolved(handle) &&
+		check_required_ktypes_all_resolved(handle);
+}
+
+void init_extensions(void)
+{
+	/* Entry of extension init */
+	void (*init)(void);
+
+	load_extensions();
+	if (!register_extension_sections())
+		goto fail;
+	if (!init_kallsyms_btf()) 
+		goto fail;
+	for (int i = 0; i < handle_cbs_len; i++) {
+		if (extension_runnable(handle_cbs[i]->handle)) {
+			init = dlsym(handle_cbs[i]->handle, "extension_init");
+			init();
+		} else {
+			ERRMSG("Skip %dth extension\n", i + 1);
+		}
+	}
+	return;
+fail:
+	ERRMSG("fail & skip all extensions\n");
+	cleanup_extensions();
+}
+
+/*
+ * For a single pfn/pcache, multiple extensions will decide whether to:
+ * 1) include the page (PG_INCLUDE), or
+ * 2) exclude the page (PG_EXCLUDE), or
+ * 3) make no decision to pass to others or fallback to traditional page-flags
+ *    based filtering (PG_UNDECID).
+ * 
+ * The arbitration is:
+ * 1) Include the page if anyone says PG_INCLUDE, and
+ * 2) Exclude the page if no one says PG_INCLUDE, but one or more say PG_EXCLUDE.
+ */
+int run_extension_callback(unsigned long pfn, const void *pcache)
+{
+	int result;
+	int ret = PG_UNDECID;
+
+	for (int i = 0; i < handle_cbs_len; i++) {
+		if (handle_cbs[i]->cb) {
+			result = handle_cbs[i]->cb(pfn, pcache);
+			if (result == PG_INCLUDE) {
+				ret = result;
+				goto out;
+			} else if (result == PG_EXCLUDE) {
+				ret = result;
+			}
+		}
+	}
+out:
+	return ret;
+}
+
+bool has_extension_loaded(void)
+{
+	return extension_opts_len > 0;
+}
+
+#else /* EXTENSION */
+
+void init_extensions(void) { }
+void cleanup_extensions(void) { }
+bool add_extension_opts(char *opt)
+{
+	ERRMSG("extension unsupported. Try `make EXTENSION=on` when building\n");
+	return false;
+}
+
+int run_extension_callback(unsigned long pfn, const void *pcache)
+{
+	return PG_UNDECID;
+}
+
+bool has_extension_loaded(void)
+{
+	return false;
+}
+
+#endif /* EXTENSION */
+
diff --git a/extension.h b/extension.h
new file mode 100644
index 0000000..972fcc8
--- /dev/null
+++ b/extension.h
@@ -0,0 +1,16 @@
+#ifndef _EXTENSION_H
+#define _EXTENSION_H
+#include <stdbool.h>
+
+enum {
+	PG_INCLUDE,	// Exntesion will keep the page
+	PG_EXCLUDE,	// Exntesion will discard the page
+	PG_UNDECID,	// Exntesion makes no decision
+};
+int run_extension_callback(unsigned long pfn, const void *pcache);
+void init_extensions(void);
+void cleanup_extensions(void);
+bool add_extension_opts(char *opt);
+bool has_extension_loaded(void);
+#endif /* _EXTENSION_H */
+
diff --git a/extensions/Makefile b/extensions/Makefile
new file mode 100644
index 0000000..b23f346
--- /dev/null
+++ b/extensions/Makefile
@@ -0,0 +1,11 @@
+CC ?= gcc
+CONTRIB_SO :=
+
+all: $(CONTRIB_SO)
+
+$(CONTRIB_SO): %.so: %.c
+	$(CC) -O2 -g -fPIC -shared -Wl,-T,../makedumpfile.ld -o $@ $^
+
+clean:
+	rm -f $(CONTRIB_SO)
+
diff --git a/makedumpfile.c b/makedumpfile.c
index dba3628..70badbc 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -28,6 +28,7 @@
 #include <assert.h>
 #include <zlib.h>
 #include "kallsyms.h"
+#include "extension.h"
 
 struct symbol_table	symbol_table;
 struct size_table	size_table;
@@ -102,6 +103,7 @@ mdf_pfn_t pfn_free;
 mdf_pfn_t pfn_hwpoison;
 mdf_pfn_t pfn_offline;
 mdf_pfn_t pfn_elf_excluded;
+mdf_pfn_t pfn_extension;
 
 mdf_pfn_t num_dumped;
 
@@ -6459,6 +6461,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 	unsigned int order_offset, dtor_offset;
 	unsigned long flags, mapping, private = 0;
 	unsigned long compound_dtor, compound_head = 0;
+	int filter_pg;
 
 	/*
 	 * If a multi-page exclusion is pending, do it first
@@ -6531,6 +6534,14 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 			pfn_read_end   = pfn + pfn_mm - 1;
 		}
 
+		/*
+		 * Include pages that specified by user via
+		 * makedumpfile extensions
+		 */
+		filter_pg = run_extension_callback(pfn, pcache);
+		if (filter_pg == PG_INCLUDE)
+			continue;
+
 		flags   = ULONG(pcache + OFFSET(page.flags));
 		_count  = UINT(pcache + OFFSET(page._refcount));
 		mapping = ULONG(pcache + OFFSET(page.mapping));
@@ -6687,6 +6698,14 @@ check_order:
 		else if (isOffline(flags, _mapcount)) {
 			pfn_counter = &pfn_offline;
 		}
+		/*
+		 * Exclude pages that specified by user via
+		 * makedumpfile extensions
+		 */
+		else if (filter_pg == PG_EXCLUDE) {
+			nr_pages = 1;
+			pfn_counter = &pfn_extension;
+		}
 		/*
 		 * Unexcludable page
 		 */
@@ -7173,13 +7192,14 @@ create_2nd_bitmap(struct cycle *cycle)
 
 	/*
 	 * Exclude cache pages, cache private pages, user data pages,
-	 * and hwpoison pages.
+	 * hwpoison pages and extension specified pages.
 	 */
 	if (info->dump_level & DL_EXCLUDE_CACHE ||
 	    info->dump_level & DL_EXCLUDE_CACHE_PRI ||
 	    info->dump_level & DL_EXCLUDE_USER_DATA ||
 	    NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER ||
-	    ((info->dump_level & DL_EXCLUDE_FREE) && info->page_is_buddy)) {
+	    ((info->dump_level & DL_EXCLUDE_FREE) && info->page_is_buddy) ||
+	    has_extension_loaded()) {
 		if (!exclude_unnecessary_pages(cycle)) {
 			ERRMSG("Can't exclude unnecessary pages.\n");
 			return FALSE;
@@ -8234,7 +8254,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	 */
 	if (info->flag_cyclic) {
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
-		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
+		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_extension = 0;
 		pfn_memhole = info->max_mapnr;
 	}
 
@@ -9579,7 +9599,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 		 * Reset counter for debug message.
 		 */
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
-		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
+		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_extension = 0;
 		pfn_memhole = info->max_mapnr;
 
 		/*
@@ -10528,7 +10548,7 @@ print_report(void)
 	pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
-	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
+	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_extension;
 
 	REPORT_MSG("\n");
 	REPORT_MSG("Original pages  : 0x%016llx\n", pfn_original);
@@ -10544,6 +10564,7 @@ print_report(void)
 	REPORT_MSG("    Free pages              : 0x%016llx\n", pfn_free);
 	REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoison);
 	REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offline);
+	REPORT_MSG("    Extension filter pages  : 0x%016llx\n", pfn_extension);
 	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
 	    pfn_original - pfn_excluded);
 
@@ -10584,7 +10605,7 @@ print_mem_usage(void)
 	pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
-	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
+	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_extension;
 	shrinking = (pfn_original - pfn_excluded) * 100;
 	shrinking = shrinking / pfn_original;
 	total_size = info->page_size * pfn_original;
@@ -10878,6 +10899,7 @@ create_dumpfile(void)
 	}
 
 	print_vtop();
+	init_extensions();
 
 	num_retry = 0;
 retry:
@@ -10921,6 +10943,7 @@ retry:
 	}
 	print_report();
 
+	cleanup_extensions();
 	clear_filter_info();
 	if (!close_files_for_creating_dumpfile())
 		return FALSE;
@@ -12130,6 +12153,7 @@ static struct option longopts[] = {
 	{"check-params", no_argument, NULL, OPT_CHECK_PARAMS},
 	{"dry-run", no_argument, NULL, OPT_DRY_RUN},
 	{"show-stats", no_argument, NULL, OPT_SHOW_STATS},
+	{"extension", required_argument, NULL, OPT_EXTENSION},
 	{0, 0, 0, 0}
 };
 
@@ -12317,6 +12341,11 @@ main(int argc, char *argv[])
 		case OPT_SHOW_STATS:
 			flag_show_stats = TRUE;
 			break;
+		case OPT_EXTENSION:
+			if (add_extension_opts(optarg))
+				break;
+			else
+				goto out;
 		case '?':
 			MSG("Commandline parameter is invalid.\n");
 			MSG("Try `makedumpfile --help' for more information.\n");
diff --git a/makedumpfile.h b/makedumpfile.h
index 0f13743..974b648 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -2747,6 +2747,7 @@ struct elf_prstatus {
 #define OPT_CHECK_PARAMS        OPT_START+18
 #define OPT_DRY_RUN             OPT_START+19
 #define OPT_SHOW_STATS          OPT_START+20
+#define OPT_EXTENSION           OPT_START+21
 
 /*
  * Function Prototype.
-- 
2.47.0


