Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qdmem-0001dZ-6y
	for kexec@lists.infradead.org; Mon, 04 Jul 2011 17:10:02 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p64H9tuV027621
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 17:09:55 GMT
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
	[9.149.37.217])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p64H9th22212064
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 18:09:55 +0100
Received: from d06av06.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p64H9tIn031571
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 11:09:55 -0600
Message-Id: <20110704170959.054287190@linux.vnet.ibm.com>
Date: Mon, 04 Jul 2011 19:09:25 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch 3/9] kdump: Make kimage_load_crash_segment() weak
References: <20110704170922.976299676@linux.vnet.ibm.com>
Content-Disposition: inline;
	filename=03-s390-kdump-common-load_crash_segment.patch
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

On s390 we do not create page tables at all for the crashkernel memory.
This requires a s390 specific version for kimage_load_crash_segment().
Therefore this patch declares this function as "__weak". The s390 version is
very simple. It just copies the kexec segment to real memory without using
page tables:

int kimage_load_crash_segment(struct kimage *image,
                              struct kexec_segment *segment)
{
        return copy_from_user_real((void *) segment->mem, segment->buf,
                                   segment->bufsz);
}

There are two main advantages of not creating page tables for the
crashkernel memory:

a) It saves memory. We have scenarios in mind, where crashkernel
   memory can be very large and saving page table space is important.
b) We protect the crashkernel memory from being overwritten.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kernel/kexec.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -842,8 +842,8 @@ out:
 	return result;
 }
 
-static int kimage_load_crash_segment(struct kimage *image,
-					struct kexec_segment *segment)
+int __weak kimage_load_crash_segment(struct kimage *image,
+				     struct kexec_segment *segment)
 {
 	/* For crash dumps kernels we simply copy the data from
 	 * user space to it's destination.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
