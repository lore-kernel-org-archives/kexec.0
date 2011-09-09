Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R1yJ9-0007rB-AO
	for kexec@lists.infradead.org; Fri, 09 Sep 2011 10:27:40 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p89ARY7M023922
	for <kexec@lists.infradead.org>; Fri, 9 Sep 2011 10:27:35 GMT
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p89ARXRA2531436
	for <kexec@lists.infradead.org>; Fri, 9 Sep 2011 11:27:33 +0100
Received: from d06av08.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p89ARX5V019157
	for <kexec@lists.infradead.org>; Fri, 9 Sep 2011 11:27:33 +0100
Message-Id: <20110909102732.497569031@linux.vnet.ibm.com>
Date: Fri, 09 Sep 2011 12:27:00 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch 1/2] kdump: Initialize vmcoreinfo note at startup
References: <20110909102659.320220628@linux.vnet.ibm.com>
Content-Disposition: inline; filename=s390-kdump-common-vmcoreinfo-init.patch
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
To: vgoyal@redhat.com
Cc: linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Currently the vmcoreinfo note is only initialized in case of kdump. On s390
it is possible to create kernel dumps with other dump mechanisms than kdump
(e.g. via hypervisor dump or stand-alone dump tools). For those dumps it
would also be desirable to include the vmcoreinfo data. To accomplish this,
with this patch the vmcoreinfo ELF note is always initialized, not only in
case of a (kdump) crash. On s390 we will add an ABI defined pointer at
a well known address to vmcoreinfo so that dump analysis tools are able to
find this information.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kernel/kexec.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1392,24 +1392,23 @@ int __init parse_crashkernel(char 		 *cm
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
@@ -1495,6 +1494,7 @@ static int __init crash_save_vmcoreinfo_
 	VMCOREINFO_NUMBER(PG_swapcache);
 
 	arch_crash_save_vmcoreinfo();
+	update_vmcoreinfo_note();
 
 	return 0;
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
