Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from xenotime.net ([66.160.160.81])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IVEjK-0007kb-W8
	for kexec@lists.infradead.org; Tue, 11 Sep 2007 19:01:18 -0400
Received: from midway.site ([96.225.192.201]) by xenotime.net for
	<kexec@lists.infradead.org>; Tue, 11 Sep 2007 16:01:06 -0700
Date: Tue, 11 Sep 2007 16:01:05 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [Crash-utility] Re: [PATCH 0/2] vmcoreinfo support for dump
	filtering #2
Message-Id: <20070911160105.ba754749.rdunlap@xenotime.net>
In-Reply-To: <46E6DA70.8010408@redhat.com>
References: <20070907175746oomichi@mail.jp.nec.com>
	<20070910113521.755d0433.rdunlap@xenotime.net>
	<20070911035250.GA5053@in.ibm.com> <46E6A03F.4010208@redhat.com>
	<20070911092523.ddff998c.rdunlap@xenotime.net>
	<46E6DA70.8010408@redhat.com>
Mime-Version: 1.0
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
To: Dave Anderson <anderson@redhat.com>
Cc: vgoyal@in.ibm.com, kexec-ml <kexec@lists.infradead.org>, "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>

On Tue, 11 Sep 2007 14:12:00 -0400 Dave Anderson wrote:

> Randy Dunlap wrote:
> >
> > I have the vmcoreinfo patch applied.
> > Kernel is 2.6.23-rc3.
> > 
> > The crash debug output is below.  Please let me know if you'd like
> > me to test without the vmcoreinfo patch or anything else.
> > 
> > ---
[snipped]

> A few things come to mind.  Walking through the debug data above...
> 
> The very first readmem() from the dumpfile is from the kernel symbol 
> "kernel_config_data", where you can see that it found the CONFIG_HZ and
> CONFIG_NR_CPUS values.  The next readmem()'s are of "xtime" and then 
> "init_uts_ns".  We don't know what was read from the "xtime" location,
> but the utsname data from "init_uts_ns" gets displayed later on here:
> 
>  > utsname version: #19 SMP Tue Sep 4 09:52:06 PDT 2007
> 
> And then the "linux_banner" address of ffffffff80537000 is first
> checked for accessibility (OK), and then it is read successfully,
> and its contents are displayed here:
> 
>  > /proc/version:
>  > Linux version 2.6.23-rc3 (rddunlap@unicorn.site) (gcc version 4.1.1 20070105 
> (Red Hat 4.1.1-52)) #19 SMP Tue Sep 4 09:52:06 PDT 2007
> 
> The string above from the dumpfile is correlated against the
> linux_banner string in the vmlinux file, which is subsequently
> displayed here:
> 
>  > /boot/vmlinux-2.6.23-rc3:
>  > Linux version 2.6.23-rc3 (rddunlap@unicorn.site) (gcc version 4.1.1 20070105 
> (Red Hat 4.1.1-52)) #22 SMP Thu Sep 6 21:24:54 PDT 2007
> 
> The utsname data and the linux_banner string from the dumpfile
> are from "Tue Sep 4 09:52:06 PDT 2007", whereas the vmlinux file
> was built 2 days later at "Thu Sep 6 21:24:54 PDT 2007".  I don't
> know whether that's the issue or not.  Is there a reason that
> you are *not* using the same vmlinux that the dumpfile was created
> from?

Just sorry user error.  Sorry to use your time like that
and thanks for the intro-to-crash lesson.

It's working now as expected.  Thanks.

> But, for now let's suppose that the two kernels are identical except
> for the date in the linux_banner strings.  I don't have a 2.6.23
> kernel source tree handy, but at least as of 2.6.22-5, it was still
> declared statically like so:
> 
>    struct x8664_pda *_cpu_pda[NR_CPUS] __read_mostly;
> 
> Has that changed?

Nope.

> If not, it would be worth checking a dumpfile with no pages
> excluded with makedumpfile.  I wouldn't think the in-kernel
> part of the vmcoreinfo patches would make a difference, but
> I suppose anything's possible.

crash works (loads without error) with the vmcore file and one that
has all possible pages removed from it using 'makedumpfile'.

> But again -- the very first thing to do is make sure that you
> are using the exact same vmlinux as was booted/dumped.

Very true.

Thanks again.
---
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
