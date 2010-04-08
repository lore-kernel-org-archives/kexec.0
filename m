Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1Nzusc-0000MU-QK
	for kexec@lists.infradead.org; Thu, 08 Apr 2010 16:46:59 +0000
Date: Thu, 8 Apr 2010 12:46:44 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH] kexec: fix 64Gb limit on x86 w/ PAE
Message-ID: <20100408164644.GB16868@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, anderson@redhat.com, vgoyal@redhat.com

Fix up x86 kexec to exclude memory on i686 kernels beyond 64GB limit

We found a problem recently on x86 systems.  If a 32 bit PAE enabled system
contains more then 64GB of physical ram, the kernel will truncate the max_pfn
value to 64GB.  Unfortunately it still leaves all the physical memory regions
present in /proc/iomem.  Since kexec builds its elf headers based on
/proc/iomem the elf headers indicate the size of memory is larger than what the
kernel is willing to address.  The result is that, during a copy of
/proc/vmcore, a read will return -EFAULT when the requested offset is beyond the
64GB range, leaving the seemingly truncated vmcore useless, as the elf headers
indicate memory beyond what the file contains.

The fix for it is pretty straightforward, just ensure that, when on x86 systems,
we don't record any entries in the memory_range array that cross  the 64Gb mark.
This keeps us in line with the kernel and lets the copy finish sucessfully,
providing a workable core

Tested successfully by myself
Originally-authored-by: Dave Anderson <anderson@redhat.com>
Signed-off-by: Neil Horman <nhorman@tuxdriver.com>

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 9d37442..85879a9 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -114,6 +114,15 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 		if (end <= 0x0009ffff)
 			continue;
 
+		/*
+		 *  Exclude any segments starting at or beyond 64GB, and
+		 *  restrict any segments from ending at or beyond 64GB.
+		 */
+		if (start >= 0x1000000000)
+			continue;
+		if (end >= 0x1000000000)
+			end = 0xfffffffff;
+
 		crash_memory_range[memory_ranges].start = start;
 		crash_memory_range[memory_ranges].end = end;
 		crash_memory_range[memory_ranges].type = type;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
