Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UfO2E-0001MQ-QT
 for kexec@lists.infradead.org; Thu, 23 May 2013 05:25:55 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id CA0FC3EE0CB
 for <kexec@lists.infradead.org>; Thu, 23 May 2013 14:25:37 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id B978245DEBC
 for <kexec@lists.infradead.org>; Thu, 23 May 2013 14:25:37 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id A1AC245DEB7
 for <kexec@lists.infradead.org>; Thu, 23 May 2013 14:25:37 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8D9981DB8038
 for <kexec@lists.infradead.org>; Thu, 23 May 2013 14:25:37 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3682E1DB803C
 for <kexec@lists.infradead.org>; Thu, 23 May 2013 14:25:37 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v8 7/9] vmcore: Allow user process to remap ELF note segment
 buffer
Date: Thu, 23 May 2013 14:25:36 +0900
Message-ID: <20130523052536.13864.67507.stgit@localhost6.localdomain6>
In-Reply-To: <20130523052421.13864.83978.stgit@localhost6.localdomain6>
References: <20130523052421.13864.83978.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: vgoyal@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org
Cc: riel@redhat.com, hughd@google.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, zhangyanfei@cn.fujitsu.com, kosaki.motohiro@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, walken@google.com, cpw@sgi.com, jingbai.ma@hp.com

Now ELF note segment has been copied in the buffer on vmalloc
memory. To allow user process to remap the ELF note segment buffer
with remap_vmalloc_page, the corresponding VM area object has to have
VM_USERMAP flag set.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 937709d..9de4d91 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -375,6 +375,7 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 	Elf64_Ehdr *ehdr_ptr;
 	Elf64_Phdr phdr;
 	u64 phdr_sz = 0, note_off;
+	struct vm_struct *vm;
 
 	ehdr_ptr = (Elf64_Ehdr *)elfptr;
 
@@ -391,6 +392,12 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 	if (!*notes_buf)
 		return -ENOMEM;
 
+	/* Allow users to remap ELF note segment buffer on vmalloc
+	 * memory using remap_vmalloc_range. */
+	vm = find_vm_area(*notes_buf);
+	BUG_ON(!vm);
+	vm->flags |= VM_USERMAP;
+
 	rc = copy_notes_elf64(ehdr_ptr, *notes_buf);
 	if (rc < 0)
 		return rc;
@@ -554,6 +561,7 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
 	Elf32_Ehdr *ehdr_ptr;
 	Elf32_Phdr phdr;
 	u64 phdr_sz = 0, note_off;
+	struct vm_struct *vm;
 
 	ehdr_ptr = (Elf32_Ehdr *)elfptr;
 
@@ -570,6 +578,12 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
 	if (!*notes_buf)
 		return -ENOMEM;
 
+	/* Allow users to remap ELF note segment buffer on vmalloc
+	 * memory using remap_vmalloc_range. */
+	vm = find_vm_area(*notes_buf);
+	BUG_ON(!vm);
+	vm->flags |= VM_USERMAP;
+
 	rc = copy_notes_elf32(ehdr_ptr, *notes_buf);
 	if (rc < 0)
 		return rc;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
