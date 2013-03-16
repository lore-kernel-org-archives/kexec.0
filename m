Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHmJZ-00056l-Ug
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 02:30:16 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id A3D383EE0C7
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:10 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8548645DEBE
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:10 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6BEED45DEBB
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:10 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2568F1DB803C
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:10 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id C253AE18007
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:09 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v3 02/21] vmcore: clean up by removing unnecessary variable
Date: Sat, 16 Mar 2013 13:00:58 +0900
Message-ID: <20130316040058.15064.35158.stgit@localhost6.localdomain6>
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

The variable j has int type but it's compared with u64 type.

Also, the purpose of the variable j is exactly what the variable
real_sz is used for now. Replace the variable j by the variable
real_sz and remove the variable j.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 163281e..94743d2 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -261,7 +261,6 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 	ehdr_ptr = (Elf64_Ehdr *)elfptr;
 	phdr_ptr = (Elf64_Phdr*)(elfptr + ehdr_ptr->e_phoff);
 	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
-		int j;
 		void *notes_section;
 		struct vmcore *new;
 		u64 offset, max_sz, sz, real_sz = 0;
@@ -279,7 +278,7 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 			return rc;
 		}
 		nhdr_ptr = notes_section;
-		for (j = 0; j < max_sz; j += sz) {
+		while (real_sz < max_sz) {
 			if (nhdr_ptr->n_namesz == 0)
 				break;
 			sz = sizeof(Elf64_Nhdr) +
@@ -342,7 +341,6 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
 	ehdr_ptr = (Elf32_Ehdr *)elfptr;
 	phdr_ptr = (Elf32_Phdr*)(elfptr + ehdr_ptr->e_phoff);
 	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
-		int j;
 		void *notes_section;
 		struct vmcore *new;
 		u64 offset, max_sz, sz, real_sz = 0;
@@ -360,7 +358,7 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
 			return rc;
 		}
 		nhdr_ptr = notes_section;
-		for (j = 0; j < max_sz; j += sz) {
+		while (real_sz < max_sz) {
 			if (nhdr_ptr->n_namesz == 0)
 				break;
 			sz = sizeof(Elf32_Nhdr) +


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
