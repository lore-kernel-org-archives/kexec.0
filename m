Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qdmem-0001da-6g
	for kexec@lists.infradead.org; Mon, 04 Jul 2011 17:10:05 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p64H9uUS008162
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 17:09:56 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p64H9uon1818874
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 18:09:56 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p64H9tgm002859
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 11:09:56 -0600
Message-Id: <20110704170959.567602717@linux.vnet.ibm.com>
Date: Mon, 04 Jul 2011 19:09:28 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch 6/9] kdump: Merge set_vmcore_list_offsets_elf_32/64()
References: <20110704170922.976299676@linux.vnet.ibm.com>
Content-Disposition: inline;
	filename=06-s390-kdump-common-vmcore-merge-set_vmcore_list_offsets.patch
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: ebiederm@xmission.com, vgoyal@redhat.com, hbabu@us.ibm.com, mahesh@linux.vnet.ibm.com
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, horms@verge.net.au, schwidefsky@de.ibm.com

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

The two functions set_vmcore_list_offsets_elf_32/64() are identical now
for 32 and 64 bit. Therefore this patch merges them into one
set_vmcore_list_offsets() function.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 fs/proc/vmcore.c |   28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -490,24 +490,8 @@ static int __init process_ptload_program
 }
 
 /* Sets offset fields of vmcore elements. */
-static void __init set_vmcore_list_offsets_elf64(char *elfptr,
-						struct list_head *vc_list)
-{
-	loff_t vmcore_off;
-	struct vmcore *m;
-
-	/* Skip Elf header and program headers. */
-	vmcore_off = elfcorebuf_sz;
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
+static void __init set_vmcore_list_offsets(char *elfptr,
+					   struct list_head *vc_list)
 {
 	loff_t vmcore_off;
 	struct vmcore *m;
@@ -573,7 +557,7 @@ static int __init parse_crash_elf64_head
 		kfree(elfcorebuf);
 		return rc;
 	}
-	set_vmcore_list_offsets_elf64(elfcorebuf, &vmcore_list);
+	set_vmcore_list_offsets(elfcorebuf, &vmcore_list);
 	return 0;
 }
 
@@ -629,7 +613,7 @@ static int __init parse_crash_elf32_head
 		kfree(elfcorebuf);
 		return rc;
 	}
-	set_vmcore_list_offsets_elf32(elfcorebuf, &vmcore_list);
+	set_vmcore_list_offsets(elfcorebuf, &vmcore_list);
 	return 0;
 }
 
@@ -701,7 +685,7 @@ static int __init parse_crash_elf_header
 							  &vmcore_list);
 		if (rc)
 			goto fail;
-		set_vmcore_list_offsets_elf64(elfcorebuf, &vmcore_list);
+		set_vmcore_list_offsets(elfcorebuf, &vmcore_list);
 		vmcore_size = get_vmcore_size_elf64(elfcorebuf);
 	} else if (e_ident[EI_CLASS] == ELFCLASS32) {
 		rc = process_ptload_program_headers_elf32(elfcorebuf,
@@ -709,7 +693,7 @@ static int __init parse_crash_elf_header
 							  &vmcore_list);
 		if (rc)
 			goto fail;
-		set_vmcore_list_offsets_elf32(elfcorebuf, &vmcore_list);
+		set_vmcore_list_offsets(elfcorebuf, &vmcore_list);
 		vmcore_size = get_vmcore_size_elf32(elfcorebuf);
 	}
 	return 0;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
