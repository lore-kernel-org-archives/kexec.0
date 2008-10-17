Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kqs3F-00008m-15
	for kexec@lists.infradead.org; Fri, 17 Oct 2008 16:19:45 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m9HGJior006595
	for <kexec@lists.infradead.org>; Fri, 17 Oct 2008 12:19:44 -0400
Received: from mail02.corp.redhat.com (zmail02.collab.prod.int.phx2.redhat.com
	[10.5.5.42])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m9HGJind031899
	for <kexec@lists.infradead.org>; Fri, 17 Oct 2008 12:19:44 -0400
Date: Fri, 17 Oct 2008 12:19:44 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <306593678.1592141224260384037.JavaMail.root@zmail02.collab.prod.int.phx2.redhat.com>
Subject: kexec/kdump produces incomplete dump files with kernel 2.6.20 +
	CONFIG_HIGHMEM64G
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>

>
> Do you use the same kernel as the running kernel as capture kernel?
>
> Regards,
> Bernhard

If I may butt in here -- Kevin's capture kernel is "standard" 3GB/1GB
kernel, whereas his primary kernel is his 1GB/3GB kernel.

Also to clarify, since vmalloc memory is biased to be allocated
from highmem, in his 1GB/3GB kernel it comes from physical memory
above his kernel's 3GB "unity-mappable" range.  And his system happens
to have a 1GB chunk of physical memory from 4GB to 5GB physical, so
his vmalloc memory comes from the physical address 0x100000000 and
above.  Data is read OK on the live system from that region of memory,
but when read from the same physical address on the dumpfile, it always
returns zeroes.

Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
