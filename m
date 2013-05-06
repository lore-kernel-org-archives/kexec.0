Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UZLBS-000432-F3
 for kexec@lists.infradead.org; Mon, 06 May 2013 13:10:29 +0000
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 6 May 2013 14:06:04 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 515D71B08023
 for <kexec@lists.infradead.org>; Mon,  6 May 2013 14:10:00 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r46D9oKa50855954
 for <kexec@lists.infradead.org>; Mon, 6 May 2013 13:09:50 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r46D9x1E012076
 for <kexec@lists.infradead.org>; Mon, 6 May 2013 07:10:00 -0600
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH 4/4] kdump: Merge set_vmcore_list_offsets_elf64/elf32/newmem
Date: Mon,  6 May 2013 15:09:59 +0200
Message-Id: <1367845799-29125-5-git-send-email-holzheu@linux.vnet.ibm.com>
In-Reply-To: <1367845799-29125-1-git-send-email-holzheu@linux.vnet.ibm.com>
References: <1367845799-29125-1-git-send-email-holzheu@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Jan Willeke <willeke@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>

The three functions set_vmcore_list_offsets_elf64(),
set_vmcore_list_offsets_elf32(), and set_vmcore_list_offsets_newmem()
can be merged to a single fuction set_vmcore_list_offsets()

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 fs/proc/vmcore.c | 50 +++++---------------------------------------------
 1 file changed, 5 insertions(+), 45 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 71db4e6..3ddfc73 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -487,7 +487,7 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 }
 
 /* Sets offset fields of vmcore elements. */
-static void __init set_vmcore_list_offsets_newmem(struct list_head *vc_list)
+static void __init set_vmcore_list_offsets(struct list_head *vc_list)
 {
 	loff_t vmcore_off = elfcorebuf_sz;
 	struct vmcore *m;
@@ -498,46 +498,6 @@ static void __init set_vmcore_list_offsets_newmem(struct list_head *vc_list)
 	}
 }
 
-/* Sets offset fields of vmcore elements. */
-static void __init set_vmcore_list_offsets_elf64(char *elfptr,
-						struct list_head *vc_list)
-{
-	loff_t vmcore_off;
-	Elf64_Ehdr *ehdr_ptr;
-	struct vmcore *m;
-
-	ehdr_ptr = (Elf64_Ehdr *)elfptr;
-
-	/* Skip Elf header and program headers. */
-	vmcore_off = sizeof(Elf64_Ehdr) +
-			(ehdr_ptr->e_phnum) * sizeof(Elf64_Phdr);
-
-	list_for_each_entry(m, vc_list, list) {
-		m->offset = vmcore_off;
-		vmcore_off += m->size;
-	}
-}
-
-/* Sets offset fields of vmcore elements. */
-static void __init set_vmcore_list_offsets_elf32(char *elfptr,
-						struct list_head *vc_list)
-{
-	loff_t vmcore_off;
-	Elf32_Ehdr *ehdr_ptr;
-	struct vmcore *m;
-
-	ehdr_ptr = (Elf32_Ehdr *)elfptr;
-
-	/* Skip Elf header and program headers. */
-	vmcore_off = sizeof(Elf32_Ehdr) +
-			(ehdr_ptr->e_phnum) * sizeof(Elf32_Phdr);
-
-	list_for_each_entry(m, vc_list, list) {
-		m->offset = vmcore_off;
-		vmcore_off += m->size;
-	}
-}
-
 static int __init parse_crash_elf64_headers(void)
 {
 	int rc=0;
@@ -589,7 +549,7 @@ static int __init parse_crash_elf64_headers(void)
 		kfree(elfcorebuf);
 		return rc;
 	}
-	set_vmcore_list_offsets_elf64(elfcorebuf, &vmcore_list);
+	set_vmcore_list_offsets(&vmcore_list);
 	return 0;
 }
 
@@ -644,7 +604,7 @@ static int __init parse_crash_elf32_headers(void)
 		kfree(elfcorebuf);
 		return rc;
 	}
-	set_vmcore_list_offsets_elf32(elfcorebuf, &vmcore_list);
+	set_vmcore_list_offsets(&vmcore_list);
 	return 0;
 }
 
@@ -713,7 +673,7 @@ static int parse_crash_elf_headers_newmem(void)
 							  &vmcore_list);
 		if (rc)
 			goto fail;
-		set_vmcore_list_offsets_newmem(&vmcore_list);
+		set_vmcore_list_offsets(&vmcore_list);
 		vmcore_size = get_vmcore_size_elf64(elfcorebuf);
 	} else if (e_ident[EI_CLASS] == ELFCLASS32) {
 		rc = process_ptload_program_headers_elf32(elfcorebuf,
@@ -721,7 +681,7 @@ static int parse_crash_elf_headers_newmem(void)
 							  &vmcore_list);
 		if (rc)
 			goto fail;
-		set_vmcore_list_offsets_newmem(&vmcore_list);
+		set_vmcore_list_offsets(&vmcore_list);
 		vmcore_size = get_vmcore_size_elf32(elfcorebuf);
 	}
 	return 0;
-- 
1.8.1.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
