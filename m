Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHmKy-0005xC-9W
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 02:31:41 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 336A23EE0BC
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:35 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1979745DE5F
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:35 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id EE20645DE58
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:34 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id DE8651DB803F
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:34 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7B05B1DB8037
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:34 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v3 17/21] vmcore: check NT_VMCORE_PAD as a mark indicating the
 end of ELF note buffer
Date: Sat, 16 Mar 2013 13:02:23 +0900
Message-ID: <20130316040223.15064.77472.stgit@localhost6.localdomain6>
In-Reply-To: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
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
To: vgoyal@redhat.com, ebiederm@xmission.com, cpw@sgi.com, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com, heiko.carstens@de.ibm.com, akpm@linux-foundation.org
Cc: zhangyanfei@cn.fujitsu.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Modern kernel marks the end of ELF note buffer with NT_VMCORE_PAD type
note in order to make the buffer satisfy mmap()'s page-size boundary
requirement. This patch makes finishing reading each buffer if the
note type now being read is NT_VMCORE_PAD type.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index b252d17..2a0f885 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -258,12 +258,24 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 		}
 		nhdr_ptr = notes_section;
 		while (real_sz < max_sz) {
+			char *name;
+
+			/* Old kernel marks the end of ELF note buffer
+			 * with empty header. */
 			if (nhdr_ptr->n_namesz == 0)
 				break;
 			sz = sizeof(Elf64_Nhdr) +
 				((nhdr_ptr->n_namesz + 3) & ~3) +
 				((nhdr_ptr->n_descsz + 3) & ~3);
 			real_sz += sz;
+
+			/* Modern kernel marks the end of ELF note
+			 * buffer with NT_VMCORE_PAD type note. */
+			name = (char *)(nhdr_ptr + 1);
+			if (strncmp(name, VMCOREINFO_NOTE_NAME,
+				    sizeof(VMCOREINFO_NOTE_NAME)) == 0
+			    && nhdr_ptr->n_type == NT_VMCORE_PAD)
+				break;
 			nhdr_ptr = (Elf64_Nhdr*)((char*)nhdr_ptr + sz);
 		}
 
@@ -367,12 +379,24 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
 		}
 		nhdr_ptr = notes_section;
 		while (real_sz < max_sz) {
+			char *name;
+
+			/* Old kernel marks the end of ELF note buffer
+			 * with empty header. */
 			if (nhdr_ptr->n_namesz == 0)
 				break;
 			sz = sizeof(Elf32_Nhdr) +
 				((nhdr_ptr->n_namesz + 3) & ~3) +
 				((nhdr_ptr->n_descsz + 3) & ~3);
 			real_sz += sz;
+
+			/* Modern kernel marks the end of ELF note
+			 * buffer with NT_VMCORE_PAD type note. */
+			name = (char *)(nhdr_ptr + 1);
+			if (strncmp(name, VMCOREINFO_NOTE_NAME,
+				    sizeof(VMCOREINFO_NOTE_NAME)) == 0
+			    && nhdr_ptr->n_type == NT_VMCORE_PAD)
+				break;
 			nhdr_ptr = (Elf32_Nhdr*)((char*)nhdr_ptr + sz);
 		}
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
