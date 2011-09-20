Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R61PD-00074u-Pu
	for kexec@lists.infradead.org; Tue, 20 Sep 2011 14:34:40 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p8KEYbZr022249
	for <kexec@lists.infradead.org>; Tue, 20 Sep 2011 14:34:37 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p8KEYb8O2293888
	for <kexec@lists.infradead.org>; Tue, 20 Sep 2011 15:34:37 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p8KEYa61018180
	for <kexec@lists.infradead.org>; Tue, 20 Sep 2011 08:34:36 -0600
Message-Id: <20110920143436.019045253@linux.vnet.ibm.com>
Date: Tue, 20 Sep 2011 16:34:01 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch 1/2] kdump: Initialize vmcoreinfo note at startup
References: <20110920143400.776127689@linux.vnet.ibm.com>
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
To: akpm@linux-foundation.org
Cc: linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org, vgoyal@redhat.com

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Currently the vmcoreinfo note is only initialized in case of kdump. On s390
it is possible to create kernel dumps with other dump mechanisms than kdump
(e.g. via hypervisor dump or stand-alone dump tools). For those dumps it
would also be desirable to include the vmcoreinfo data. To accomplish this,
with this patch the vmcoreinfo ELF note is always initialized, not only in
case of a (kdump) crash. On s390 we will add an ABI defined pointer at
a well known address to vmcoreinfo so that dump analysis tools are able to
find this information.

In particular on s390 we have a tool named zgetdump. With this tool it is
possible to convert dump formats on the fly using fuse. E.g. you can mount a
s390 stand-alone dump as ELF dump. When this is done, the tool finds the
vmcoreinfo in the stand-alone dump via the well known ABI defined address and
it creates the respective VMCOREINFO ELF note in the output ELF dump. This then
can be used e.g. by makedumpfile for dump filtering.  No more need for a
vmlinux file with debug information.

So this will look like the following:
$ zgetdump --mount standalone.dump -f elf /mnt
$ ls /mnt
  dump.elf
$ readelf -n /mnt/dump.elf
$ ...
  VMCOREINFO            0x00000474      Unknown note type: (0x00000000)
$ makedumpfile -c -d 31 /mnt/dump.elf dump.kdump

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
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
