Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDQrv-0007YI-Kn
 for kexec@lists.infradead.org; Thu, 07 Mar 2013 02:47:45 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 032673EE0C2
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:42 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id DF62F45DEB7
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:41 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id C77B645DEB6
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:41 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id BB8271DB803B
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:41 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6FCBA1DB8038
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:41 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 2/3] elf: swap checking order of VMCOREINFO and VMCOREINFO_XEN
Date: Mon, 04 Mar 2013 13:18:35 +0900
Message-ID: <20130304041834.16856.83544.stgit@localhost6.localdomain6>
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

Currently, get_pt_note_info() checks ELF note in "VMCOREINFO_XEN" name
first and then in "VMCOREINFO" name to avoid the case where
"VMCOREINFO_XEN" is wrongly interpreted as "VMCOREINFO". However,
characters checked by strncmp() includes null character. The case
concerned about there can never happen. This patch swaps checking
order of VMCOREINFO and VMCOREINFO_XEN, which is natural in the sense
that the direction from general one to specific one is natural.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 elf_info.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index b0e45b5..f9c554d 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -323,22 +323,17 @@ get_pt_note_info(void)
 		offset_desc = offset + offset_note_desc(note);
 		size_desc   = note_descsz(note);
 
+		if (!strncmp(VMCOREINFO_NOTE_NAME, buf,
+		    VMCOREINFO_NOTE_NAME_BYTES)) {
+			set_vmcoreinfo(offset_desc, size_desc);
 		/*
 		 * Check whether /proc/vmcore contains vmcoreinfo,
 		 * and get both the offset and the size.
-		 *
-		 * NOTE: The owner name of xen should be checked at first,
-		 *       because its name is "VMCOREINFO_XEN" and the one
-		 *       of linux is "VMCOREINFO".
 		 */
-		if (!strncmp(VMCOREINFO_XEN_NOTE_NAME, buf,
+		} else if (!strncmp(VMCOREINFO_XEN_NOTE_NAME, buf,
 		    VMCOREINFO_XEN_NOTE_NAME_BYTES)) {
 			offset_vmcoreinfo_xen = offset_desc;
 			size_vmcoreinfo_xen   = size_desc;
-		} else if (!strncmp(VMCOREINFO_NOTE_NAME, buf,
-		    VMCOREINFO_NOTE_NAME_BYTES)) {
-			set_vmcoreinfo(offset_desc, size_desc);
-
 		/*
 		 * Check whether /proc/vmcore contains xen's note.
 		 */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
