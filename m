Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SUZ3j-00087i-8H
 for kexec@lists.infradead.org; Wed, 16 May 2012 07:54:13 +0000
Message-ID: <4FB35CD4.3080801@cn.fujitsu.com>
Date: Wed, 16 May 2012 15:52:52 +0800
From: zhangyanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v2 1/5] x86: Add helper variables and functions to hold
 VMCSINFO
References: <4FB35C48.30708@cn.fujitsu.com>
In-Reply-To: <4FB35C48.30708@cn.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Avi Kivity <avi@redhat.com>, mtosatti@redhat.com
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com, Greg KH <gregkh@linuxfoundation.org>

This patch provides a set of variables to hold the VMCSINFO and also
some helper functions to help fill the VMCSINFO.

Signed-off-by: zhangyanfei <zhangyanfei@cn.fujitsu.com>
---
 arch/x86/include/asm/vmcsinfo.h |   34 +++++++++++++++++
 arch/x86/kernel/Makefile        |    2 +
 arch/x86/kernel/vmcsinfo.c      |   79 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100644 arch/x86/include/asm/vmcsinfo.h
 create mode 100644 arch/x86/kernel/vmcsinfo.c

diff --git a/arch/x86/include/asm/vmcsinfo.h b/arch/x86/include/asm/vmcsinfo.h
new file mode 100644
index 0000000..1ca140b
--- /dev/null
+++ b/arch/x86/include/asm/vmcsinfo.h
@@ -0,0 +1,34 @@
+#ifndef _ASM_X86_VMCSINFO_H
+#define _ASM_X86_VMCSINFO_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+#include <linux/elf.h>
+
+/*
+ * Currently, 1 page is enough for vmcsinfo.
+ */
+#define VMCSINFO_BYTES             (4096)
+#define VMCSINFO_NOTE_NAME         "VMCSINFO"
+#define VMCSINFO_NOTE_NAME_BYTES   ALIGN(sizeof(VMCSINFO_NOTE_NAME), 4)
+#define VMCSINFO_NOTE_HEAD_BYTES   ALIGN(sizeof(struct elf_note), 4)
+#define VMCSINFO_NOTE_SIZE         (VMCSINFO_NOTE_HEAD_BYTES*2 \
+				    + VMCSINFO_BYTES \
+				    + VMCSINFO_NOTE_NAME_BYTES)
+
+extern size_t vmcsinfo_size;
+extern size_t vmcsinfo_max_size;
+extern unsigned char vmcsinfo_data[VMCSINFO_BYTES];
+
+extern void update_vmcsinfo_note(void);
+extern void vmcsinfo_append_id(u32);
+extern void vmcsinfo_append_field(u32, u64);
+extern unsigned long paddr_vmcsinfo_note(void);
+
+#define VMCSINFO_REVISION_ID(id) \
+	vmcsinfo_append_id(id)
+#define VMCSINFO_FIELD(field, offset) \
+	vmcsinfo_append_field(field, offset)
+
+#endif /* __ASSEMBLY__ */
+#endif /* _ASM_X86_VMCSINFO_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 532d2e0..63edf33 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -102,6 +102,8 @@ obj-$(CONFIG_X86_CHECK_BIOS_CORRUPTION) += check.o
 obj-$(CONFIG_SWIOTLB)			+= pci-swiotlb.o
 obj-$(CONFIG_OF)			+= devicetree.o
 
+obj-y					+= vmcsinfo.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/vmcsinfo.c b/arch/x86/kernel/vmcsinfo.c
new file mode 100644
index 0000000..8d0ab3f
--- /dev/null
+++ b/arch/x86/kernel/vmcsinfo.c
@@ -0,0 +1,79 @@
+/*
+ * Architecture specific (i386/x86_64) functions for storing vmcs
+ * field information.
+ *
+ * Created by: zhangyanfei (zhangyanfei@cn.fujitsu.com)
+ *
+ * Copyright (C) Fujitsu Corporation, 2012. All rights reserved.
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <asm/vmcsinfo.h>
+#include <linux/module.h>
+#include <linux/elf.h>
+
+unsigned char vmcsinfo_data[VMCSINFO_BYTES];
+static u32 vmcsinfo_note[VMCSINFO_NOTE_SIZE/4];
+size_t vmcsinfo_max_size = sizeof(vmcsinfo_data);
+size_t vmcsinfo_size;
+EXPORT_SYMBOL_GPL(vmcsinfo_size);
+
+void update_vmcsinfo_note(void)
+{
+	u32 *buf = vmcsinfo_note;
+	struct elf_note note;
+
+	if (!vmcsinfo_size)
+		return;
+
+	note.n_namesz = strlen(VMCSINFO_NOTE_NAME) + 1;
+	note.n_descsz = vmcsinfo_size;
+	note.n_type   = 0;
+	memcpy(buf, &note, sizeof(note));
+	buf += (sizeof(note) + 3)/4;
+	memcpy(buf, VMCSINFO_NOTE_NAME, note.n_namesz);
+	buf += (note.n_namesz + 3)/4;
+	memcpy(buf, vmcsinfo_data, note.n_descsz);
+	buf += (note.n_descsz + 3)/4;
+
+	note.n_namesz = 0;
+	note.n_descsz = 0;
+	note.n_type   = 0;
+	memcpy(buf, &note, sizeof(note));
+}
+EXPORT_SYMBOL_GPL(update_vmcsinfo_note);
+
+void vmcsinfo_append_id(u32 id)
+{
+	size_t r;
+
+	r = sizeof(id);
+	if (r + vmcsinfo_size > vmcsinfo_max_size)
+		return;
+
+	memcpy(&vmcsinfo_data[vmcsinfo_size], &id, r);
+	vmcsinfo_size += r;
+}
+EXPORT_SYMBOL_GPL(vmcsinfo_append_id);
+
+void vmcsinfo_append_field(u32 field, u64 offset)
+{
+	size_t r;
+
+	r = sizeof(field) + sizeof(offset);
+	if (r + vmcsinfo_size > vmcsinfo_max_size)
+		return;
+
+	memcpy(&vmcsinfo_data[vmcsinfo_size], &field, sizeof(field));
+	vmcsinfo_size += sizeof(field);
+	memcpy(&vmcsinfo_data[vmcsinfo_size], &offset, sizeof(offset));
+	vmcsinfo_size += sizeof(offset);
+}
+EXPORT_SYMBOL_GPL(vmcsinfo_append_field);
+
+unsigned long paddr_vmcsinfo_note(void)
+{
+	return __pa((unsigned long)(char *)&vmcsinfo_note);
+}
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
