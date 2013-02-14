Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U5vnZ-0002zc-Ne
 for kexec@lists.infradead.org; Thu, 14 Feb 2013 10:12:14 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 1A8A63EE0BC
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:12 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id EB7E945DD74
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:11 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id D117E45DD78
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:11 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id BC07FE08003
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:11 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 718451DB8038
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:11 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 05/13] vmcore: modify ELF32 code according to new type
Date: Thu, 14 Feb 2013 19:12:10 +0900
Message-ID: <20130214101210.22466.36330.stgit@localhost6.localdomain6>
In-Reply-To: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
References: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ebiederm@xmission.com, vgoyal@redhat.com, cpw@sgi.com, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On elf32 mmap() is not supported. All vmcore objects are in old
memory.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 43d338a..7e3f922 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -389,6 +389,7 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
 			kfree(notes_section);
 			return -ENOMEM;
 		}
+		new->type = VMCORE_OLD_MEMORY;
 		new->paddr = phdr_ptr->p_offset;
 		new->size = real_sz;
 		list_add_tail(&new->list, vc_list);
@@ -486,6 +487,7 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 		new = get_new_element();
 		if (!new)
 			return -ENOMEM;
+		new->type = VMCORE_OLD_MEMORY;
 		new->paddr = phdr_ptr->p_offset;
 		new->size = phdr_ptr->p_memsz;
 		list_add_tail(&new->list, vc_list);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
