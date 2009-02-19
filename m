Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wa-out-1112.google.com ([209.85.146.181])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LaDJx-0001Ih-Mc
	for kexec@lists.infradead.org; Thu, 19 Feb 2009 18:08:28 +0000
Received: by wa-out-1112.google.com with SMTP id j4so274411wah.2
	for <kexec@lists.infradead.org>; Thu, 19 Feb 2009 10:08:24 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 19 Feb 2009 10:08:24 -0800
Message-ID: <74ae4f6a0902191008w3387263cq7a72554380ed42a5@mail.gmail.com>
Subject: kexec/kdump crash kernel 10MB ZONE_DMA
From: SUJIT V <sujit.linux@gmail.com>
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
To: kexec@lists.infradead.org

On an x86_64 platform the crash kernel boot (32b kernel) panic's
during the boot during device initialization due to failed kmalloc()
and the the oom_killer() failing to free mem.

The memory that is setup for the crash kernel to use is 32MB. It was
working fine up until we added a new kernel module.  This seems to
have tipped the balance in memory allocations for kernel code, and the
ZONE allocater.

The addition of the kernel module cause the "init.ramfs" size encoded
in the header section of vmlinux to increases. So its observed that
the capture kernel boot was OK till the init.ramfs size was below some
threshold.


Its harder for us to bump up the 32MB to a higher value (although we
see that it seems to solve the problem). Instead, we tried reducing
the ZONE_DMA memory from 16MB to 10MB and things work fine.

What are your thoughts on going w/ this 10MB ZONE_DMA approach?  We
don't have any ISA devices w/ the 16MB dma addr limitations, etc. that
we care about in our system.

Pl let us know if you have any suggestions/thoughts, etc.


Thanks

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
