Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C722FED9E3
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fTX9lOpgs7xuXSS5gDWzE3JLQ2v7RBq/koHSsVLD59M=; b=mjAH/L0v5gd19HJvxwAv983G57
	uG1xIx2kQBk2ixiS/wW5LqyBEgsTwnynp2NESS9rmN14sfXfQbbU5FHuXHjsTM7VfmEvpMDZOhn9b
	XB2tOGo0tRarnRvAmZpTY4n4iH05wBjAbcfsiAH/vCP2/JsQiItWYfPxEUWJPfcw+qAHhl7UA7pCE
	dfnwCbuITUmEFhaqRQiyL8NK0zKynQJyHknszGl9JlQNxA2oQFCexB/j4MCvuTlJ48wQi6aXwXWSv
	9+0LH/QCq4TpNUWX30ljrnc5rlt3YPExssDEaz6u8B5fiJL3NB4DOxmPHNWDF8y8bd5yRIQP4tzre
	onp+7oSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W2s-00000006h1P-4AFM;
	Tue, 17 Mar 2026 15:09:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W2q-00000006gzX-1WHJ
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 15:09:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773760159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTX9lOpgs7xuXSS5gDWzE3JLQ2v7RBq/koHSsVLD59M=;
	b=NiFwkkvMb4uBO+SO+DQ3miz+9q4aiZzPeo29KfEW7ZAvhHlmK++9tgG95O4C3NUYcm9nCV
	cK3gagrks7+Vyue7INrW+ctLGPcsjslTZwdDtMcwDoIdorQsGy8FS0gm/z/OwDiAhMGoZ2
	1ivoD3hnBmuMhVybAou8ekKefgAOSSQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-o42VOgdINP2o4zCncNhQXQ-1; Tue, 17 Mar 2026 11:09:17 -0400
X-MC-Unique: o42VOgdINP2o4zCncNhQXQ-1
X-Mimecast-MFC-AGG-ID: o42VOgdINP2o4zCncNhQXQ_1773760156
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82a6906e35fso74698b3a.0
        for <kexec@lists.infradead.org>; Tue, 17 Mar 2026 08:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773760156; x=1774364956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fTX9lOpgs7xuXSS5gDWzE3JLQ2v7RBq/koHSsVLD59M=;
        b=Bbn9q4xvtp3IDbpI+GBBHzH8xDfcWQHEZ30u1tA1urutUaMpgY8A2LjFg0vTVtEY15
         tg2Mzixm003Oyqj/Cy0qXmYonFa8uemLmxc4q7jBWT0r8Im4LOza95jRiHD2ae5L0b4n
         qb7CbSBcooFrKLr/D7gfPYBahea9ttNtZpfjmdx/8oV6W+mwJXpGA2epTJGyCGB2GZPN
         teg2hPu4mIxL4l/ESZT5p0ko4uCy2Bp6oEkMZbR4Q16GKh+a3+pEO8mnJyZpYSve09HU
         hS8NWXgSUURDjuEj4JZfekY1bVvhK9w9ElsSqvdoe+KyIuuJOyFGFjdtyPs0/p1Sokp/
         DEHw==
X-Forwarded-Encrypted: i=1; AJvYcCVxK0KclkblyQCIeZ7KlH5BA/+eDLXdFsjK3K00xecnLzQDUB6dXplN1cI6mtr5LUs5V7dsxA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzZmaGGC3vvn8cXqH/Z0NrplAxHgZ/4YYBNKC3T+qN+DaB1fC07
	50CtSDhSXpwoQWjiGQ7VUheZdXWEuWm9qCUpjlIeELzwVlBRDKjdEAVnVbxZKvLQLKklQu2JqFL
	NaC8JTv3pk4xehtwCNFTdLNf0ZMiE4j8ALORe8bnKG/qWHp0zFWR30WJ+29casg==
X-Gm-Gg: ATEYQzzXL0Xu74BZgb/hc7ctyZGciVK4aQ+CA4KF03NO8A74In3n3aFiAEoRz1XB4/4
	qsVxri3Pmgr9bJkhpMXbr2XO27w4x0/1ySVK0u2oubdrkvCjIO2vvJ/lufu0z4hrphJJjwc3K7Z
	3wTR+QMt/e4FTUyBkJHhJtX7FaqReFxZMBB65k9j/75YEOzdJLsvdDQPF8eyN018mlGpZ0YNDD0
	0xHdc71rMVHRW5kyHodpZ68KPXL6siLUgGGtroMsOCzSCY2QdLGjsAIKqfyrHQbm8bW3aFosjLP
	u4B7ek3hepphrT7t9pNdopXPSPDMgf8x701eeFpbpfzS6KKo1GwNU5xY47Ad51QchGxbcz1xEeZ
	P4pjN8ryMXO7iZ/ET9GnD0hxWgKMeBJjNUA==
X-Received: by 2002:a05:6a00:e19:b0:7b8:acdd:23c3 with SMTP id d2e1a72fcca58-82a5603b41emr2794646b3a.11.1773760156080;
        Tue, 17 Mar 2026 08:09:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:e19:b0:7b8:acdd:23c3 with SMTP id d2e1a72fcca58-82a5603b41emr2794609b3a.11.1773760155571;
        Tue, 17 Mar 2026 08:09:15 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07340417sm16993404b3a.39.2026.03.17.08.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:09:15 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v4][makedumpfile 6/7] Add makedumpfile extensions support
Date: Wed, 18 Mar 2026 04:07:42 +1300
Message-ID: <20260317150743.69590-7-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260317150743.69590-1-ltao@redhat.com>
References: <20260317150743.69590-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IF0e4F3p4TwpP0zK9Ba2n1Cypfi1SekGRWW0I_-bQ20_1773760156
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_080920_556474_5E42154A 
X-CRM114-Status: GOOD (  27.51  )
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
filename is give, then "./extenisons" and "/usr/lib64/makedumpfile/extensions/"
will be searched.

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
syms/types which are defined via INIT_OPT(...) macro, these are optinal
syms/types, it won't fail at parsing step if any are missing, instead, they
need to be checked within extension_init() of each extensions; For         
syms/types which defined via INIT_(...) macro, these are must-have syms/types,
if any missing, the extension will fail at this step and as a result
this extension will be skipped.

After this step, required kernel symbol value and kernel types size/offset
are resolved, the extensions are ready to go.

Step 4: When makedumpfile doing page filtering, in addition to its
original filtering mechanism, it will call extensions callbacks for advice
whether the page should be included/excluded.

Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile            |   7 +-
 extension.c         | 300 ++++++++++++++++++++++++++++++++++++++++++++
 extension.h         |  12 ++
 extensions/Makefile |  10 ++
 makedumpfile.c      |  38 +++++-
 makedumpfile.h      |   2 +
 6 files changed, 363 insertions(+), 6 deletions(-)
 create mode 100644 extension.c
 create mode 100644 extension.h
 create mode 100644 extensions/Makefile

diff --git a/Makefile b/Makefile
index 320677d..1bb67d9 100644
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
index 0000000..35e2756
--- /dev/null
+++ b/extension.c
@@ -0,0 +1,300 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <dirent.h>
+#include <dlfcn.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include "kallsyms.h"
+#include "btf_info.h"
+#include "extension.h"
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
+	"/usr/lib64/makedumpfile/extensions/",
+	"./extensions/",
+};
+
+void add_extension_opts(char *opt)
+{
+	if (!add_to_arr((void ***)&extension_opts, &extension_opts_len,
+			&extension_opts_cap, opt))
+		/*
+		 * If fail, print error info and skip the extension.
+		*/
+		 fprintf(stderr, "%s: Fail to add extension %s\n", __func__, opt);
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
+			fprintf(stderr, "%s: Skip invalid extension: %s\n",
+				__func__, extension_opts[i]);
+			continue;
+		}
+
+		if (extension_opts[i][0] == '/') {
+			/* Path & filename */
+			snprintf(path, sizeof(path), "%s", extension_opts[i]);
+			handle = dlopen(path, RTLD_NOW);
+			if (!handle) {
+				fprintf(stderr, "%s: Failed to load %s\n",
+					__func__, dlerror());
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
+						fprintf(stderr, "%s: Failed to load %s\n",
+							__func__, dlerror());					
+				}
+			}
+			if (!handle && j >= sizeof(dirs) / sizeof(char *)) {
+				fprintf(stderr, "%s: Not found %s\n",
+					__func__, extension_opts[i]);
+				continue;				
+			}
+		}
+
+		if (dlsym(handle, "extension_init") == NULL) {
+			fprintf(stderr, "%s: Skip extension %s: No extension_init()\n",
+				__func__, path);
+			dlclose(handle);
+			continue;
+		}
+
+		if ((ehc = malloc(sizeof(struct extension_handle_cb))) == NULL) {
+			fprintf(stderr, "%s: Skip extension %s: No memory\n",
+				__func__, path);
+			dlclose(handle);
+			continue;			
+		}
+
+		ehc->handle = handle;
+		ehc->cb = dlsym(handle, "extension_callback");
+
+		if (!add_to_arr((void ***)&handle_cbs, &handle_cbs_len, &handle_cbs_cap, ehc)) {
+			fprintf(stderr, "%s: Failed to load %s\n", __func__,
+				extension_opts[i]);
+			free(ehc);
+			dlclose(handle);
+			continue;
+		}
+		printf("Loaded extension: %s\n", path);
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
+			fprintf(stderr, "Symbol %s in %s not found\n",
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
+				fprintf(stderr, "Member %s of struct %s in %s not found\n",
+					(*p)->member_name, (*p)->struct_name, (*p)->modname);
+			} else if ((*p)->struct_required) {
+				ret = false;
+				fprintf(stderr, "Struct %s in %s not found\n",
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
+			fprintf(stderr, "%s: Skip %dth extension\n",
+				__func__, i + 1);
+		}
+	}
+	return;
+fail:
+	fprintf(stderr, "%s: fail & skip all extensions\n", __func__);
+	cleanup_extensions();
+}
+
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
\ No newline at end of file
diff --git a/extension.h b/extension.h
new file mode 100644
index 0000000..dc5902e
--- /dev/null
+++ b/extension.h
@@ -0,0 +1,12 @@
+#ifndef _EXTENSION_H
+#define _EXTENSION_H
+
+enum {
+	PG_INCLUDE,	// Exntesion will keep the page
+	PG_EXCLUDE,	// Exntesion will discard the page
+	PG_UNDECID,	// Exntesion makes no decision
+};
+int run_extension_callback(unsigned long pfn, const void *pcache);
+void init_extensions(void);
+void cleanup_extensions(void);
+#endif /* _EXTENSION_H */
\ No newline at end of file
diff --git a/extensions/Makefile b/extensions/Makefile
new file mode 100644
index 0000000..b8bbfbc
--- /dev/null
+++ b/extensions/Makefile
@@ -0,0 +1,10 @@
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
\ No newline at end of file
diff --git a/makedumpfile.c b/makedumpfile.c
index dba3628..ef7468f 100644
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
@@ -8234,7 +8253,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	 */
 	if (info->flag_cyclic) {
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
-		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
+		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_extension = 0;
 		pfn_memhole = info->max_mapnr;
 	}
 
@@ -9579,7 +9598,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 		 * Reset counter for debug message.
 		 */
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
-		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
+		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_extension = 0;
 		pfn_memhole = info->max_mapnr;
 
 		/*
@@ -10528,7 +10547,7 @@ print_report(void)
 	pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
-	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
+	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_extension;
 
 	REPORT_MSG("\n");
 	REPORT_MSG("Original pages  : 0x%016llx\n", pfn_original);
@@ -10544,6 +10563,7 @@ print_report(void)
 	REPORT_MSG("    Free pages              : 0x%016llx\n", pfn_free);
 	REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoison);
 	REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offline);
+	REPORT_MSG("    Extension filter pages  : 0x%016llx\n", pfn_extension);
 	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
 	    pfn_original - pfn_excluded);
 
@@ -10584,7 +10604,7 @@ print_mem_usage(void)
 	pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
-	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
+	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_extension;
 	shrinking = (pfn_original - pfn_excluded) * 100;
 	shrinking = shrinking / pfn_original;
 	total_size = info->page_size * pfn_original;
@@ -10878,6 +10898,7 @@ create_dumpfile(void)
 	}
 
 	print_vtop();
+	init_extensions();
 
 	num_retry = 0;
 retry:
@@ -10888,8 +10909,11 @@ retry:
 			&& !gather_filter_info())
 		return FALSE;
 
-	if (!create_dump_bitmap())
+	if (!create_dump_bitmap()) {
+		cleanup_extensions();
 		return FALSE;
+	}
+	cleanup_extensions();
 
 	if (info->flag_split) {
 		if ((status = writeout_multiple_dumpfiles()) == FALSE)
@@ -12130,6 +12154,7 @@ static struct option longopts[] = {
 	{"check-params", no_argument, NULL, OPT_CHECK_PARAMS},
 	{"dry-run", no_argument, NULL, OPT_DRY_RUN},
 	{"show-stats", no_argument, NULL, OPT_SHOW_STATS},
+	{"extension", required_argument, NULL, OPT_EXTENSION},
 	{0, 0, 0, 0}
 };
 
@@ -12317,6 +12342,9 @@ main(int argc, char *argv[])
 		case OPT_SHOW_STATS:
 			flag_show_stats = TRUE;
 			break;
+		case OPT_EXTENSION:
+			add_extension_opts(optarg);
+			break;
 		case '?':
 			MSG("Commandline parameter is invalid.\n");
 			MSG("Try `makedumpfile --help' for more information.\n");
diff --git a/makedumpfile.h b/makedumpfile.h
index 0f13743..d880ae7 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -2747,6 +2747,7 @@ struct elf_prstatus {
 #define OPT_CHECK_PARAMS        OPT_START+18
 #define OPT_DRY_RUN             OPT_START+19
 #define OPT_SHOW_STATS          OPT_START+20
+#define OPT_EXTENSION           OPT_START+21
 
 /*
  * Function Prototype.
@@ -2777,5 +2778,6 @@ int write_and_check_space(int fd, void *buf, size_t buf_size,
 int open_dump_file(void);
 int dump_lockless_dmesg(void);
 unsigned long long memparse(char *ptr, char **retptr);
+void add_extension_opts(char *opt);
 
 #endif /* MAKEDUMPFILE_H */
-- 
2.47.0


