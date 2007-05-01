Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Him78-0007yK-ML
	for kexec@lists.infradead.org; Tue, 01 May 2007 07:45:32 +0100
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l416jLEv009405
	for <kexec@lists.infradead.org>; Tue, 1 May 2007 02:45:21 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l416jLAG163052
	for <kexec@lists.infradead.org>; Tue, 1 May 2007 00:45:21 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l416jKJX018617
	for <kexec@lists.infradead.org>; Tue, 1 May 2007 00:45:21 -0600
Date: Tue, 1 May 2007 12:14:44 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH 1/2] x86_64: Reflect the relocatability of the kernel in
	the ELF header.
Message-ID: <20070501064444.GA5579@in.ibm.com>
References: <m1slah6gm0.fsf@ebiederm.dsl.xmission.com>
	<200704301717.08230.ak@suse.de> <20070501035539.GA15472@in.ibm.com>
	<m14pmx18ey.fsf@ebiederm.dsl.xmission.com>
	<20070501050657.GA23111@in.ibm.com>
	<m1zm4pyuzp.fsf@ebiederm.dsl.xmission.com>
	<20070501062554.GT25929@bingen.suse.de>
	<m1r6q1ytpt.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1r6q1ytpt.fsf@ebiederm.dsl.xmission.com>
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Kexec Mailing List <kexec@lists.infradead.org>, Andi Kleen <ak@suse.de>, Jurriaan <thunder7@xs4all.nl>, Helge Hafting <helgehaf@aitel.hist.no>, Horms <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>

On Mon, Apr 30, 2007 at 11:54:22PM -0600, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > On Mon, Apr 30, 2007 at 11:26:50PM -0600, Eric W. Biederman wrote:
> >> Vivek Goyal <vgoyal@in.ibm.com> writes:
> >> 
> >> 
> >> >> At least without a core file it is working on with gdb 6.4.
> >> >>
> >> >
> >> > This seems to be a problem with gdb 6.5. I transferred the dump to a
> >> > different machine having GNU gdb 6.4, and it works fine there.
> >> 
> >> Ok.  The difference between those two symbols didn't seem to make
> >> any sense, so a gdb bug makes sense.
> >> 
> >> Cool.  Then the patch is good. :)
> >
> > It would still make any gdb 6.5 users unhappy. If no workaround can be found
> > I guess we'll need a CONFIG of some sort?
> 
> It is probably worth reproducing this bug with a PIE executable.
> But it looks very much like gdb got it wrong, or else there is some
> slight mismatch between our core dump and gdb.
> 
> Given that gdb 6.5 handles the vmlinux fine when it isn't in conjunction
> with a core dump I would not say the problem is in vmlinux.
> 
> Rather there seems to be something messed up when gdb 6.5 tries to match
> up the kernel core dump with the kernel.  The offset for the symbol
> Vivek gave was 0x7fff70e9. ???  Although that is almost 2M...
> 
> Vivek could we see the program headers of your core file?
> 

Hi Eric,

Following are program headers of my core file. They look sane.

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  NOTE           0x0000000000000190 0x0000000000000000 0x0000000000000000
                 0x0000000000000b20 0x0000000000000b20         0
  LOAD           0x0000000000000cb0 0xffffffff80200000 0x0000000000200000
                 0x0000000000742000 0x0000000000742000  RWE    0
  LOAD           0x0000000000742cb0 0xffff810000000000 0x0000000000000000
                 0x00000000000a0000 0x00000000000a0000  RWE    0
  LOAD           0x00000000007e2cb0 0xffff810000100000 0x0000000000100000
                 0x0000000000f00000 0x0000000000f00000  RWE    0
  LOAD           0x00000000016e2cb0 0xffff810009000000 0x0000000009000000
                 0x00000000c6f8dc80 0x00000000c6f8dc80  RWE    0
  LOAD           0x00000000c8670930 0xffff810100000000 0x0000000100000000
                 0x0000000130000000 0x0000000130000000  RWE    0

First PT_LOAD header is mapping kernel text/data and others just mapping
physical memory in kernel linear virtual address range.

> >From what I can tell what is left to figure out is do we have
> a bug in gdb 6.5 or do we have a bug in our core file generation.
> 

Given the fact it works well with gdb 6.4 as well as 6.1 (crash uses gdb 6.1
as backend and crash is working fine). I would think that it is gdb bug.

> Right now I'm inclined to believe that the fedora core 6? gdb 6.5 got it
> wrong.  I'm probably just burnt out with binutils problems whenever
> I try and do something interesting.  But I'm just not inclined that
> the bleeding edge tools are working properly while there kernel
> core dump mechanism would mess up with a two byte field change.
> 
> It does make sense to root cause this if we can.  If it's a gdb
> problem it should also apply to PIE executables, and should irritate
> a few users.
> 
> Regardless last I heard it was crash that was the primary analysis
> tool and not gdb anyway.  With gdb serving as the double check to make
> certain that the kernel core dump was in a reasonably standard format.

I would consider gdb to be equally important, especially because many
a times crash is broken with latest version of kernels (as some data
structures or some mechanism has changed) and gdb is the only one who
can open the dump.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
