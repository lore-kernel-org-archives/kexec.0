Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RBM6c-00057y-Jg
	for kexec@lists.infradead.org; Wed, 05 Oct 2011 07:41:32 +0000
Received: from /spool/local by au.ibm.com with XMail ESMTP
	for <kexec@lists.infradead.org> from <prasad@linux.vnet.ibm.com>;
	Wed, 5 Oct 2011 08:37:07 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p957fNNL2244798
	for <kexec@lists.infradead.org>; Wed, 5 Oct 2011 18:41:23 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p957fMk3007611
	for <kexec@lists.infradead.org>; Wed, 5 Oct 2011 18:41:23 +1100
Date: Wed, 5 Oct 2011 13:11:16 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111005074116.GC2235@in.ibm.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<20111004143012.GB28306@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111004143012.GB28306@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
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
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Borislav Petkov <bp@alien8.de>, crash-utility@redhat.com

On Tue, Oct 04, 2011 at 10:30:12AM -0400, Vivek Goyal wrote:
> On Mon, Oct 03, 2011 at 01:02:03PM +0530, K.Prasad wrote:
> > There are certain types of crashes induced by faulty hardware in which
> > capturing crashing kernel's memory (through kdump) makes no sense (or sometimes
> > dangerous).
> > 
> > A case in point, is unrecoverable memory errors (resulting in fatal machine
> > check exceptions) in which reading from the faulty memory location from the
> > kexec'ed kernel will cause double fault and system reset (leaving no
> > information for the user).
> > 
> > This patch introduces a framework called 'slimdump' enabled through a new
> > elf-note NT_NOCOREDUMP. Any error whose cause cannot be attributed to a
> > software error and cannot be detected by analysing the kernel memory may
> > decide to add this elf-note to the vmcore and indicate the futility of
> > such an exercise. Tools such as 'kexec', 'makedumpfile' and 'crash' are
> > also modified in tandem to recognise this new elf-note and capture
> > 'slimdump'.
> > 
> > The physical address and size of the NT_NOCOREDUMP are made available to the
> > user-space through a "/sys/kernel/nt_nocoredump" sysfs file (just like other
> > kexec related files).
> 
> Even if kernel has to signal to user space the reason for crash, why not
> add this info to existing vmcoreinfo note. Something like another filed.
> PANIC_MCE=1.
> 
> Secondly, the note name NT_NOCOREDUMP itself sounds binding. Kernel can
> export the reason of panic and then it is up to user space what do they
> want to do with it.
> 

Like I mentioned here:
http://article.gmane.org/gmane.linux.kernel/1199466, we can bring in fine-grained
message headers or note-types based on other users of this framework.

> So to me,  
> 
> > 
> > Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> > ---
> >  arch/x86/kernel/cpu/mcheck/mce.c |   28 ++++++++++++++++++++++++++++
> >  include/linux/elf.h              |   18 ++++++++++++++++++
> >  include/linux/kexec.h            |    1 +
> >  kernel/kexec.c                   |   11 +++++++++++
> >  kernel/ksysfs.c                  |   10 ++++++++++
> >  5 files changed, 68 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> > index 08363b0..483b2fc 100644
> > --- a/arch/x86/kernel/cpu/mcheck/mce.c
> > +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> > @@ -238,6 +238,34 @@ static atomic_t mce_paniced;
> >  static int fake_panic;
> >  static atomic_t mce_fake_paniced;
> >  
> > +void arch_add_nocoredump_note(u32 *buf)
> > +{
> > +	struct elf_note note;
> > +	const char note_name[] = "PANIC_MCE";
> > +	const char desc_msg[] = "Crash induced due to a fatal machine "
> > +				"check error";
> > +
> 
> Again, note_name and desc_msg seem to be only two exports. Frankly desc
> string seems pretty obivious and we should be able to ignore it. So just
> exporting PANIC_MCE=true or something like that in case of MCE. 
>

Yes, adding a new field to the VMCOREINFO note would have been much
simpler but there's a second part to the kdump + fatal MCE problem which
will need a new elf-note to solve.

On a system containing 'poisoned' pages (generated as a result of
detecting UC errors which haven't been 'consumed'), if a software bug results
in crashing the machine, the ensuing kdump operation will read from the
faulty memory location. This will trigger a new crash within the context
of the kexec'ed kernel and we want to avoid this.

The plan is to pass-down the list of poisoned memory pages to the second
kernel using an elf-note so that these pages are left untouched during
dump capture. I'm working on an implementation of the same and should
have patches soon.

Thanks,
K.Prasad


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
