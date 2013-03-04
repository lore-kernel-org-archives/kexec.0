Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDQs0-0007cz-TD
 for kexec@lists.infradead.org; Thu, 07 Mar 2013 02:47:51 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 55DA53EE081
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:47 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 377F445DE4D
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:47 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1844745DD78
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:47 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 02EB1E08007
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:47 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9B2EC1DB803A
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:46 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 3/3] elf: distinguish ELF note types by ELF note name space
Date: Mon, 04 Mar 2013 13:18:40 +0900
Message-ID: <20130304041840.16856.37483.stgit@localhost6.localdomain6>
In-Reply-To: <20130304041724.16856.19272.stgit@localhost6.localdomain6>
References: <20130304041724.16856.19272.stgit@localhost6.localdomain6>
MIME-Version: 1.0
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

In ELF, the same integers for two note type represent different
meanings if the names they belong to are different. However,
get_pt_note_info() doesn't distinguish note types by name space, due
to which, for example, any new note type in "VMCOREINFO" name space is
wrongly interpretted as NT_PRSTATUS or the unique note type in
"VMCOREINFO" name space. This patch checks first ELF note names
explicitly and then ELF note types.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 elf_info.c |   76 +++++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index f9c554d..9bd8cd0 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -254,6 +254,23 @@ note_type(void *note)
 }
 
 static int
+note_namesz(void *note)
+{
+	int size;
+	Elf64_Nhdr *note64;
+	Elf32_Nhdr *note32;
+
+	if (is_elf64_memory()) {
+		note64 = (Elf64_Nhdr *)note;
+		size = note64->n_namesz;
+	} else {
+		note32 = (Elf32_Nhdr *)note;
+		size = note32->n_namesz;
+	}
+	return size;
+}
+
+static int
 note_descsz(void *note)
 {
 	int size;
@@ -290,7 +307,7 @@ offset_note_desc(void *note)
 static int
 get_pt_note_info(void)
 {
-	int n_type, size_desc;
+	int n_type, size_name, size_desc;
 	off_t offset, offset_desc;
 	char buf[VMCOREINFO_XEN_NOTE_NAME_BYTES];
 	char note[MAX_SIZE_NHDR];
@@ -308,40 +325,51 @@ get_pt_note_info(void)
 			    name_memory, strerror(errno));
 			return FALSE;
 		}
+
+		n_type = note_type(note);
+		size_name = note_namesz(note);
+		size_desc   = note_descsz(note);
+		offset_desc = offset + offset_note_desc(note);
+
+		if (!size_name || size_name >= sizeof(buf))
+			goto next_note;
+
 		if (read(fd_memory, &buf, sizeof(buf)) != sizeof(buf)) {
 			ERRMSG("Can't read the dump memory(%s). %s\n",
 			    name_memory, strerror(errno));
 			return FALSE;
 		}
-		n_type = note_type(note);
 
-		if (n_type == NT_PRSTATUS) {
-			nr_cpus++;
-			offset += offset_next_note(note);
-			continue;
-		}
-		offset_desc = offset + offset_note_desc(note);
-		size_desc   = note_descsz(note);
+		if (!strncmp(KEXEC_CORE_NOTE_NAME, buf,
+			     KEXEC_CORE_NOTE_NAME_BYTES)) {
+			if (n_type == NT_PRSTATUS) {
+				nr_cpus++;
+			}
 
-		if (!strncmp(VMCOREINFO_NOTE_NAME, buf,
-		    VMCOREINFO_NOTE_NAME_BYTES)) {
-			set_vmcoreinfo(offset_desc, size_desc);
+		} else if (!strncmp(VMCOREINFO_NOTE_NAME, buf,
+				    VMCOREINFO_NOTE_NAME_BYTES)) {
+			if (n_type == 0) {
+				set_vmcoreinfo(offset_desc, size_desc);
+			}
 		/*
 		 * Check whether /proc/vmcore contains vmcoreinfo,
 		 * and get both the offset and the size.
 		 */
 		} else if (!strncmp(VMCOREINFO_XEN_NOTE_NAME, buf,
-		    VMCOREINFO_XEN_NOTE_NAME_BYTES)) {
-			offset_vmcoreinfo_xen = offset_desc;
-			size_vmcoreinfo_xen   = size_desc;
+				    VMCOREINFO_XEN_NOTE_NAME_BYTES)) {
+			if (n_type == 0) {
+				offset_vmcoreinfo_xen = offset_desc;
+				size_vmcoreinfo_xen   = size_desc;
+			}
 		/*
 		 * Check whether /proc/vmcore contains xen's note.
 		 */
-		} else if (n_type == XEN_ELFNOTE_CRASH_INFO) {
-			flags_memory |= MEMORY_XEN;
-			offset_xen_crash_info = offset_desc;
-			size_xen_crash_info   = size_desc;
-
+		} else if (!strncmp("Xen", buf, 4)) {
+			if (n_type == XEN_ELFNOTE_CRASH_INFO) {
+				flags_memory |= MEMORY_XEN;
+				offset_xen_crash_info = offset_desc;
+				size_xen_crash_info   = size_desc;
+			}
 		/*
 		 * Check whether a source dumpfile contains eraseinfo.
 		 *   /proc/vmcore does not contain eraseinfo, because eraseinfo
@@ -349,9 +377,13 @@ get_pt_note_info(void)
 		 *   create /proc/vmcore.
 		 */
 		} else if (!strncmp(ERASEINFO_NOTE_NAME, buf,
-		    ERASEINFO_NOTE_NAME_BYTES)) {
-			set_eraseinfo(offset_desc, size_desc);
+				    ERASEINFO_NOTE_NAME_BYTES)) {
+			if (n_type == 0) {
+				set_eraseinfo(offset_desc, size_desc);
+			}
 		}
+
+	next_note:
 		offset += offset_next_note(note);
 	}
 	if (is_xen_memory())


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
