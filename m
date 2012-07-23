Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [148.87.113.117] (helo=rcsinet15.oracle.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1StOzZ-0000Yb-SP
 for kexec@lists.infradead.org; Mon, 23 Jul 2012 20:12:48 +0000
Date: Mon, 23 Jul 2012 22:10:59 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH] kexec-tools: Read always one vmcoreinfo file
Message-ID: <20120723201059.GA1848@host-192-168-1-59.local.net-space.pl>
References: <20120705121635.GA2007@host-192-168-1-59.local.net-space.pl>
 <201207231456.07783.ptesarik@suse.cz>
 <201207231530.55871.ptesarik@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201207231530.55871.ptesarik@suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: olaf@aepfle.de, horms@verge.net.au, kexec@lists.infradead.org, xen-devel@lists.xensource.com, konrad.wilk@oracle.com

Hi Petr,

On Mon, Jul 23, 2012 at 03:30:55PM +0200, Petr Tesarik wrote:
> Dne Po 23. ??ervence 2012 14:56:07 Petr Tesarik napsal(a):
> > Dne ??t 5. ??ervence 2012 14:16:35 Daniel Kiper napsal(a):
> > > vmcoreinfo file could exists under /sys/kernel (valid on baremetal only)
> > > and/or under /sys/hypervisor (valid when Xen dom0 is running).
> > > Read only one of them. It means that only one PT_NOTE will be
> > > always created. Remove extra code for second PT_NOTE creation.
> >
> > Hi Daniel,
> >
> > are you absolutely sure this is the right thing to do? IIUC these two
> > VMCORINFO notes are very different. The one from /sys/kernel/vmcoreinfo
> > describes the Dom0 kernel (type 'VMCOREINFO'), while the one from
> > /sys/hypervisor describes the Xen hypervisor (type 'XEN_VMCOREINFO'). If
> > you keep only the hypervisor note, then e.g. makedumpfile won't be able to
> > use dumplevel greater than 1, nor will it be able to extract the log
> > buffer.
>
> I've just verified this, and I'm confident we have to keep both notes in the
> dump file. Simon, please revert Daniel's patch to avoid regressions.
>
> I'm attaching a sample VMCOREINFO_XEN and VMCOREINFO to demonstrate the
> difference. Note that the VMCOREINFO_XEN note is actually too big, because Xen
> doesn't bother to maintain the correct note size in the note header, so it
> always spans a complete page minus sizeof(Elf64_Nhdr)...

[...]

The problem with /sys/kernel/vmcoreinfo under Xen is that it expose invalid
physical address. It breaks /proc/vmcore in crash kernel. That is why I proposed
that fix. Additionally, /sys/kernel/vmcoreinfo is not available under Xen Linux
Ver. 2.6.18. However, I did not do any makedumpfile tests. If you discovered any
issues with my patch please drop me more details about your tests (Xen version,
Linux Kernel version, makedumpfile version, command lines, config files, logs,
etc.). I will be more then happy to fix/improve kexec-tools and makedumpfile.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
