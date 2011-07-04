Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qdmem-0001dc-6h
	for kexec@lists.infradead.org; Mon, 04 Jul 2011 17:10:01 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p64H9uea008157
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 17:09:56 GMT
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
	[9.149.37.247])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p64H9t2E2461928
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 18:09:55 +0100
Received: from d06av12.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p64H9tAm021539
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 11:09:55 -0600
Message-Id: <20110704170959.217980739@linux.vnet.ibm.com>
Date: Mon, 04 Jul 2011 19:09:26 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch 4/9] kdump: Initialize vmcoreinfo note at startup
References: <20110704170922.976299676@linux.vnet.ibm.com>
Content-Disposition: inline; filename=04-s390-kdump-common-vmcoreinfo.patch
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

Currently the vmcoreinfo note is only initialized in case of kdump. On s390
it is possible to create kernel dumps with other dump mechanisms than kdump
(e.g. via hypervisor dump or stand-alone dump tools). For those dumps it
would also be desirable to include the vmcoreinfo data. To accomplish this,
with this patch the vmcoreinfo ELF note is always initialized, not only in
case of a (kdump) crash.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kernel/kexec.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1388,24 +1388,23 @@ int __init parse_crashkernel(char 		 *cm
 }
 
 
-
-void crash_save_vmcoreinfo(void)
+static void update_vmcoreinfo_note(void)
 {
-	u32 *buf;
+	u32 *buf = (u32 *) vmcoreinfo_note;
 
 	if (!vmcoreinfo_size)
 		return;
-
-	vmcoreinfo_append_str("CRASHTIME=%ld", get_seconds());
-
-	buf = (u32 *)vmcoreinfo_note;
-
 	buf = append_elf_note(buf, VMCOREINFO_NOTE_NAME, 0, vmcoreinfo_data,
 			      vmcoreinfo_size);
-
 	final_note(buf);
 }
 
+void crash_save_vmcoreinfo(void)
+{
+	vmcoreinfo_append_str("CRASHTIME=%ld", get_seconds());
+	update_vmcoreinfo_note();
+}
+
 void vmcoreinfo_append_str(const char *fmt, ...)
 {
 	va_list args;
@@ -1491,6 +1490,7 @@ static int __init crash_save_vmcoreinfo_
 	VMCOREINFO_NUMBER(PG_swapcache);
 
 	arch_crash_save_vmcoreinfo();
+	update_vmcoreinfo_note();
 
 	return 0;
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
