Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cAF5N-00040G-7I
 for kexec@lists.infradead.org; Fri, 25 Nov 2016 11:54:34 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAPBs5DM043673
 for <kexec@lists.infradead.org>; Fri, 25 Nov 2016 06:54:12 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26xm6a2mge-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 25 Nov 2016 06:54:12 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 25 Nov 2016 21:54:10 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7D8C82CE8046
 for <kexec@lists.infradead.org>; Fri, 25 Nov 2016 22:54:07 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAPBs7eG36372528
 for <kexec@lists.infradead.org>; Fri, 25 Nov 2016 22:54:07 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAPBs6WC005208
 for <kexec@lists.infradead.org>; Fri, 25 Nov 2016 22:54:07 +1100
Subject: [PATCH v2 2/5] ia64: reuse append_elf_note() and final_note()
 functions
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 25 Nov 2016 17:24:03 +0530
In-Reply-To: <148007477669.1053.4107773905913128028.stgit@hbathini.in.ibm.com>
References: <148007477669.1053.4107773905913128028.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Message-Id: <148007484315.1053.12317233313990302812.stgit@hbathini.in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, ebiederm@xmission.com, Michael Ellerman <mpe@ellerman.id.au>, dyoung@redhat.com, vgoyal@redhat.com

Get rid of multiple definitions of append_elf_note() & final_note()
functions. Reuse these functions compiled under CONFIG_CRASH_CORE.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/ia64/kernel/crash.c   |   22 ----------------------
 include/linux/crash_core.h |    4 ++++
 kernel/crash_core.c        |    6 +++---
 kernel/kexec_core.c        |   28 ----------------------------
 4 files changed, 7 insertions(+), 53 deletions(-)

diff --git a/arch/ia64/kernel/crash.c b/arch/ia64/kernel/crash.c
index 2955f35..75859a0 100644
--- a/arch/ia64/kernel/crash.c
+++ b/arch/ia64/kernel/crash.c
@@ -27,28 +27,6 @@ static int kdump_freeze_monarch;
 static int kdump_on_init = 1;
 static int kdump_on_fatal_mca = 1;
 
-static inline Elf64_Word
-*append_elf_note(Elf64_Word *buf, char *name, unsigned type, void *data,
-		size_t data_len)
-{
-	struct elf_note *note = (struct elf_note *)buf;
-	note->n_namesz = strlen(name) + 1;
-	note->n_descsz = data_len;
-	note->n_type   = type;
-	buf += (sizeof(*note) + 3)/4;
-	memcpy(buf, name, note->n_namesz);
-	buf += (note->n_namesz + 3)/4;
-	memcpy(buf, data, data_len);
-	buf += (data_len + 3)/4;
-	return buf;
-}
-
-static void
-final_note(void *buf)
-{
-	memset(buf, 0, sizeof(struct elf_note));
-}
-
 extern void ia64_dump_cpu_regs(void *);
 
 static DEFINE_PER_CPU(struct elf_prstatus, elf_prstatus);
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 9a4f4b0..2ae20b1 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -61,6 +61,10 @@ extern u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
 extern size_t vmcoreinfo_size;
 extern size_t vmcoreinfo_max_size;
 
+u32 *append_elf_note(u32 *buf, char *name, unsigned int type,
+		     void *data, size_t data_len);
+void final_note(u32 *buf);
+
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 60a98fc..9223976 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -291,8 +291,8 @@ int __init parse_crashkernel_low(char *cmdline,
 				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
 }
 
-static u32 *append_elf_note(u32 *buf, char *name, unsigned int type,
-			    void *data, size_t data_len)
+u32 *append_elf_note(u32 *buf, char *name, unsigned int type,
+		     void *data, size_t data_len)
 {
 	struct elf_note note;
 
@@ -309,7 +309,7 @@ static u32 *append_elf_note(u32 *buf, char *name, unsigned int type,
 	return buf;
 }
 
-static void final_note(u32 *buf)
+void final_note(u32 *buf)
 {
 	struct elf_note note;
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3aa21f3..596cb32 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -988,34 +988,6 @@ int crash_shrink_memory(unsigned long new_size)
 	return ret;
 }
 
-static u32 *append_elf_note(u32 *buf, char *name, unsigned type, void *data,
-			    size_t data_len)
-{
-	struct elf_note note;
-
-	note.n_namesz = strlen(name) + 1;
-	note.n_descsz = data_len;
-	note.n_type   = type;
-	memcpy(buf, &note, sizeof(note));
-	buf += (sizeof(note) + 3)/4;
-	memcpy(buf, name, note.n_namesz);
-	buf += (note.n_namesz + 3)/4;
-	memcpy(buf, data, note.n_descsz);
-	buf += (note.n_descsz + 3)/4;
-
-	return buf;
-}
-
-static void final_note(u32 *buf)
-{
-	struct elf_note note;
-
-	note.n_namesz = 0;
-	note.n_descsz = 0;
-	note.n_type   = 0;
-	memcpy(buf, &note, sizeof(note));
-}
-
 void crash_save_cpu(struct pt_regs *regs, int cpu)
 {
 	struct elf_prstatus prstatus;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
