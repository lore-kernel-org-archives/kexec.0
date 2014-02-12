Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ie0-x22a.google.com ([2607:f8b0:4001:c03::22a])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WDgQh-0000Ax-7v
 for kexec@lists.infradead.org; Wed, 12 Feb 2014 20:29:11 +0000
Received: by mail-ie0-f170.google.com with SMTP id lx4so1920930iec.29
 for <kexec@lists.infradead.org>; Wed, 12 Feb 2014 12:28:49 -0800 (PST)
Received: from t430.minyard.home (pool-173-57-152-84.dllstx.fios.verizon.net.
 [173.57.152.84])
 by mx.google.com with ESMTPSA id u1sm166103igm.8.2014.02.12.12.21.25
 for <kexec@lists.infradead.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 12 Feb 2014 12:21:25 -0800 (PST)
Message-ID: <52FBD7C3.4060304@acm.org>
Date: Wed, 12 Feb 2014 14:21:23 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
Subject: Tool for creating full vmcore
Reply-To: minyard@acm.org
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello,

I've written a tool that takes an coredump of physical kernel memory and
converts it to a coredump of virtual kernel memory that can be directly
used by gdb to debug a kernel.

I was trying to use /proc/vmcore, but that did not include any of
vmalloc memory or vmemmap, which made it kind of useless.  I thought
about adding all that to the vmcore, but that didn't seem like the
proper way to do things.

The tool is at https://github.com/cminyard/kdump-tool

It can create a physical memory coredump (like the kdump tool) and a
virtual memory coredump (either from a physical memory one, or directly
from /proc/vmcore and /dev/mem).

Two kernel patches are in the "kernel-patches" directory of the tool, on
the master branch:

One adds the valid physical memory ranges to the notes in the core
file.  Memory doesn't always start from zero, some systems have more
than one OS running on the same hardware,  and memory often has holes
and places that are bad to read from.  It seems prudent to pass in these
ranges so the coredump is only the memory required.  It also adds the
physical address of the kernel page directory to the notes, so it can
parse the page tables.

The other is MIPS specific.  You need a whole bunch of information about
the configuration to parse the MIPS page tables.

One cool thing this should be able to do is create a coredump for
userspace processes.  You can look into kernel memory to find the page
table and pass that in to the tool.  It should be able to extract the
process' resident memory from a physical coredump.  Of course, it will
only dump resident memory, anything on disk will not be there.

Is this interesting to the kdump community?  I'd like to include it in
kexec, if possible.

Thanks,

-corey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
