Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QRpQS-0000Rv-VH
	for kexec@lists.infradead.org; Wed, 01 Jun 2011 17:41:49 +0000
Date: Wed, 1 Jun 2011 13:41:34 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <292370127.12181.1306950094350.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20110601172326.GA17449@redhat.com>
Subject: Re: [RFC Patch 4/6] PANIC_MCE: Introduce a new panic flag for fatal
	MCE, capture related information
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Eric W. Biederman" <ebiederm@xmission.com>, prasad@linux.vnet.ibm.com



----- Original Message -----
> On Wed, Jun 01, 2011 at 01:18:16PM -0400, Dave Anderson wrote:
> > FWIW, unlike mcelog, it really doesn't have to be maintained in the crash
> > utility. It's just another kernel data structure whose contents can be
> > determined dynamically during runtime:
> >
> 
> That's what I was wondering. Why can't we simple extract the contents
> of this structure from /proc/vmcore and save it, instead of trying to
> export it by appending additional elf notes to vmcore.

Actually I take that back -- Prasad's patch looks at the ELF header
contents and exits before the crash utility invokes the embedded gdb, 
so the structure contents are unavailable at that time.  It doesn't even 
use the vmlinux file.  

Dave 

> 
> Thanks
> Vivek
> 
> >   crash> struct mce
> >   struct mce {
> >       __u64 status;
> >       __u64 misc;
> >       __u64 addr;
> >       __u64 mcgstatus;
> >       __u64 ip;
> >       __u64 tsc;
> >       __u64 time;
> >       __u8 cpuvendor;
> >       __u8 inject_flags;
> >       __u16 pad;
> >       __u32 cpuid;
> >       __u8 cs;
> >       __u8 bank;
> >       __u8 cpu;
> >       __u8 finished;
> >       __u32 extcpu;
> >       __u32 socketid;
> >       __u32 apicid;
> >       __u64 mcgcap;
> >   }
> >   SIZE: 88
> >   crash>
> >
> > Dave
> >
> > > If you think that this complicates the patch, I'll start with a
> > > much
> > > 'slimmer' version (!) of the slimdump and the improvements may be
> > > contemplated iteratively.
> > >
> > > Thanks,
> > > K.Prasad

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
