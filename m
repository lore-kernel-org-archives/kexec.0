Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xowgx-0000lj-QS
 for kexec@lists.infradead.org; Thu, 13 Nov 2014 15:52:17 +0000
Date: Thu, 13 Nov 2014 16:51:48 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] kexec-tools: Read always one vmcoreinfo file
Message-ID: <20141113165148.4343b45e@hananiah.suse.cz>
In-Reply-To: <20120724135410.GA2230@host-192-168-1-59.local.net-space.pl>
References: <20120705121635.GA2007@host-192-168-1-59.local.net-space.pl>
 <201207231530.55871.ptesarik@suse.cz>
 <20120723201059.GA1848@host-192-168-1-59.local.net-space.pl>
 <201207241018.35292.ptesarik@suse.cz>
 <20120724135410.GA2230@host-192-168-1-59.local.net-space.pl>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: olaf@aepfle.de, horms@verge.net.au, kexec@lists.infradead.org, xen-devel@lists.xensource.com, konrad.wilk@oracle.com

Hi all,

this thread got somehow forgotten because of vacations...
Anyway, read below.

On Tue, 24 Jul 2012 15:54:10 +0200
Daniel Kiper <daniel.kiper@oracle.com> wrote:

> On Tue, Jul 24, 2012 at 10:18:34AM +0200, Petr Tesarik wrote:
> > Dne Po 23. ??ervence 2012 22:10:59 Daniel Kiper napsal(a):
> > > Hi Petr,
> > >
> > > On Mon, Jul 23, 2012 at 03:30:55PM +0200, Petr Tesarik wrote:
> > > > Dne Po 23. ??ervence 2012 14:56:07 Petr Tesarik napsal(a):
> > > > > Dne ??t 5. ??ervence 2012 14:16:35 Daniel Kiper napsal(a):
> > > > > > vmcoreinfo file could exists under /sys/kernel (valid on baremetal
> > > > > > only) and/or under /sys/hypervisor (valid when Xen dom0 is running).
> > > > > > Read only one of them. It means that only one PT_NOTE will be always
> > > > > > created. Remove extra code for second PT_NOTE creation.
> > > > >
> > > > > Hi Daniel,
> > > > >
> > > > > are you absolutely sure this is the right thing to do? IIUC these two
> > > > > VMCORINFO notes are very different. The one from /sys/kernel/vmcoreinfo
> > > > > describes the Dom0 kernel (type 'VMCOREINFO'), while the one from
> > > > > /sys/hypervisor describes the Xen hypervisor (type 'XEN_VMCOREINFO').
> > > > > If you keep only the hypervisor note, then e.g. makedumpfile won't be
> > > > > able to use dumplevel greater than 1, nor will it be able to extract
> > > > > the log buffer.
> > > >
> > > > I've just verified this, and I'm confident we have to keep both notes in
> > > > the dump file. Simon, please revert Daniel's patch to avoid regressions.
> > > >
> > > > I'm attaching a sample VMCOREINFO_XEN and VMCOREINFO to demonstrate the
> > > > difference. Note that the VMCOREINFO_XEN note is actually too big,
> > > > because Xen doesn't bother to maintain the correct note size in the note
> > > > header, so it always spans a complete page minus sizeof(Elf64_Nhdr)...
> > >
> > > [...]
> > >
> > > The problem with /sys/kernel/vmcoreinfo under Xen is that it expose invalid
> > > physical address. It breaks /proc/vmcore in crash kernel. That is why I
> > > proposed that fix. Additionally, /sys/kernel/vmcoreinfo is not available
> > > under Xen Linux Ver. 2.6.18. However, I did not do any makedumpfile tests.
> > > If you discovered any issues with my patch please drop me more details
> > > about your tests (Xen version, Linux Kernel version, makedumpfile version,
> > > command lines, config files, logs, etc.). I will be more then happy to
> > > fix/improve kexec-tools and makedumpfile.
> >
> > Hi Daniel,
> >
> > well, Linux v2.6.18 does not have /sys/kernel/vmcoreinfo, simply because the
> > VMCOREINFO infrastructure was not present in 2.6.18. It was added later with
> 
> Yep.
> 
> > commit fd59d231f81cb02870b9cf15f456a897f3669b4e, which went into 2.6.24.
> 
> Hmmm... As I know 2.6.24 does not support kexec/kdump under Xen dom0. Correct?
> 
> > I tested with the following combinations:
> >
> > * xen-3.3.1 + kernel-xen-2.6.27.54 + kexec-tools-2.0.0 + makedumpfile-1.3.1
> > * xen-4.0.3 + kernel-xen-2.6.32.59 + kexec-tools-2.0.0 + makedumpfile-1.3.1
> > * xen-4.1.2 + kernel-xen-3.0.34 + kexec-tools-2.0.0 + makedumpfile-1.4.0
> >
> > These versions correspond to SLES11-GA, SLES11-SP1 and SLES11-SP2,
> > respectively. All of them work just fine and save both ELF notes into the
> > dump.
> 
> Could you test current kexec-tools development version and
> latest makedumpfile version on latest SLES version?

And indeed, I've just hit this regression with SLES12 GA (kernel 3.12.28,
kexec-tools 2.0.5, makedumpfile 1.5.6).

In the secondary kernel, makedumpfile complains that VMCOREINFO is not
stored in /proc/vmcore:

bash-4.2# makedumpfile -d 31 -X -E /proc/vmcore /kdump/mnt1/abuild/dumps/2014-11-13-13\:13/vmcore.elf
Switched running mode from cyclic to non-cyclic,
because the cyclic mode doesn't support Xen.
/proc/vmcore doesn't contain vmcoreinfo.
Specify '-x' option or '-i' option.
Commandline parameter is invalid.
Try `makedumpfile --help' for more information.

makedumpfile Failed.

Then I reverted commit 455d79f57e9367e5c59093fd74798905bd5762fc and
everything works just fine.

> > What do you mean by "invalid physical address"? I'm getting the correct
> > physical address under Xen. Obviously, it must be translated to machine
> > addresses if you need them from the secondary kernel.
> 
> Correct vmcoreinfo address should be established by calling
> HYPERVISOR_kexec_op(KEXEC_CMD_kexec_get_range, KEXEC_RANGE_MA_VMCOREINFO).

The addresses I get from /sys/kernel/vmcoreinfo and
from /sys/hypervisor/vmcoreinfo are machine addresses in both cases, so
when a non-Xen kernel is used for dumping, everything works as expected.

I am well aware that the Xen implementation in SLES differs
substantially from mainline, but it seems to me that:

  1. both VMCOREINFO and VMCOREINFO_XEN is required for dumpfile
     filtering, and
  2. both sysfs files should report machine addresses, because the current
     p2m mapping is lost forever when the hypervisor executes the secondary
     kernel, so physical addresses are pretty useless.

I'm reverting the patch for the SLES distro, but I'd like to reach some
kind of consensus with the community, too.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
