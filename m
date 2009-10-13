Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by casper.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MxiXF-00081i-Qd
	for kexec@lists.infradead.org; Tue, 13 Oct 2009 14:39:40 +0000
Date: Tue, 13 Oct 2009 10:39:21 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <356335727.118701255444761636.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1053635400.117951255444447388.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
Subject: Re: VMCore from makedumpfile -d 2 Failed to be Read by Crash
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
To: Neil Horman <nhorman@redhat.com>
Cc: oomichi@mxs.nes.nec.co.jp, tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org, CAI Qian <caiqian@redhat.com>


----- "Dave Anderson" <anderson@redhat.com> wrote:

> ----- "Neil Horman" <nhorman@redhat.com> wrote:
> 
> > On Sat, Oct 10, 2009 at 10:56:32AM +0800, CAI Qian wrote:
> > > Hallo!
> > >
> > > The crash utility failed to initialize when read the VMCore from
> > > makedumpfile -d 2.
> > >
> > > # crash -d 7 vmlinux vmcore.2
> > >
> > > <readmem: ffffffff818ba450, KVADDR, "__per_cpu_offset", 32768, (FOE), a31fc8>
> > > GNU_GET_DATATYPE[runqueue]: returned via gdb_error_hook (1 buffer i use)
> > > GNU_GET_DATATYPE[runqueue]: returned via gdb_error_hook (1 buffer in use)
> > > GNU_GET_DATATYPE[prio_array]: returned via gdb_error_hook (1 buffer in use)
> > > GNU_GET_DATATYPE[prio_array]: returned via gdb_error_hook (1 buffer in use)
> > > GNU_GET_DATATYPE[prio_array]: returned via gdb_error_hook (1 buffer in use)
> > > <readmem: ffff88000c60e2f8, KVADDR, "cpu number (per_cpu)", 4, (FOE), 7fff04f30c1c>
> > > <readmem: ffff88000c7ed2f8, KVADDR, "cpu number (per_cpu)", 4, (FOE), 7fff04f30c1c>
> > > <readmem: ffffffff818d92f8, KVADDR, "cpu number (per_cpu)", 4, (FOE), 7fff04f30c1c>
> > > crash: page excluded: kernel virtual address: ffffffff818d92f8 type: "cpu number (per_cpu)"
> > -d 2 is exclude cached pages, I don't rightly see how any of these data structures
> > can be in pagecache.  Not sure if that means that makedumpfile filtered them
> > inappropriately, or if crash is looking for them in the wrong place.
> >
> > Neil
> 
> Given that the full vmcore shows that there are 2 cpus, and that the
> failure above is on an attempt to read/verify a 3rd cpu, it's pretty
> clear that this is a crash bug.  There have been a few of these type
> of bugs that have recently been discovered due to the movement of the
> the x8664_pda data structures to per-cpu data variables in 2.6.30.
> Unfortunately, the x86_64_per_cpu_init() is trying to figure out
> how many cpus are there, and it's currently doing a "read-and-verify"
> kind of thing, but will need to be changed to recognize a readmem failure
> as the end of the line.
> 
> I'll be back on Tuesday -- Cai, can you contact me offline and
> make the vmcore/vmlinux pair available?

This will be fixed in the next upstream crash utility release.

In the meantime, "page excluded" errors can be worked around by using 
the --zero_excluded command line option, as in:

 # crash --zero_excluded vmlinux vmcore.2

Dave





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
