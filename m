Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NdRQn-00085d-DA
	for kexec@lists.infradead.org; Fri, 05 Feb 2010 16:53:26 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o15GrJRx017470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Fri, 5 Feb 2010 11:53:19 -0500
Received: from mail05.corp.redhat.com (zmail05.collab.prod.int.phx2.redhat.com
	[10.5.5.46])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id o15GrI1p027894
	for <kexec@lists.infradead.org>; Fri, 5 Feb 2010 11:53:18 -0500
Date: Fri, 5 Feb 2010 11:53:18 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <773792816.1109361265388798774.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <539140123.1108061265388145735.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
Subject: FYI: x86_64 bug when using gdb with vmcore
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
To: kexec@lists.infradead.org


The kexec/arch/x86_64/crashdump-x86_64.h file contains a
stale PAGE_OFFSET value.  In 2.6.27 it was changed from
0xffff810000000000UL to 0xffff880000000000UL.  This is
only a problem when using gdb with the vmlinux/vmcore
pair, because gdb relies upon the PT_LOAD segment's p_vaddr
values in the ELF header to be correct.

Anyway, in the RHEL6 kexec-tools, this simple patch 
was made:

-#define PAGE_OFFSET            0xffff810000000000UL
+#define PAGE_OFFSET            0xffff880000000000UL

which is OK since the RHEL6 version of kexec-tools
will only be used with RHEL6 kernels.  

But for backwards compatibility, the better way to do 
it would be to check the utsname of the running kernel, 
and use the right value.

But again, this is only required for gdb usage.  The 
crash utility (and makedumpfile) make kernel version checks 
to determine which x86_64 PAGE_OFFSET value is applicable,
and don't rely on the ELF header p_vaddr values for
the unity-mapped regions.  

Dave Anderson

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
