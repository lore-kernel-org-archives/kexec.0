Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RBTQz-0001ug-Vc
	for kexec@lists.infradead.org; Wed, 05 Oct 2011 15:31:03 +0000
Date: Wed, 5 Oct 2011 11:30:40 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111005153040.GC30146@redhat.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<m162k64c7w.fsf@fess.ebiederm.org>
	<20111003120336.GK2223@in.ibm.com>
	<20111004063440.GB5723@liondog.tnic>
	<20111005070728.GA2235@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111005070728.GA2235@in.ibm.com>
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
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, anderson@redhat.com, crash-utility@redhat.com

On Wed, Oct 05, 2011 at 12:37:28PM +0530, K.Prasad wrote:
> On Tue, Oct 04, 2011 at 08:34:40AM +0200, Borislav Petkov wrote:
> > On Mon, Oct 03, 2011 at 05:33:36PM +0530, K.Prasad wrote:
> > > It's interesting...according to Intel's Software Developer Manual
> > > (quoting from Volume 3A, Chapter 15), the MCIP bit in IA32_MCG_STATUS
> > > MSR behaves as described below.
> > > 
> > > "MCIP (machine check in progress) flag, bit 2 Indicates (when set)
> > > that a machine-check exception was generated. Software can set or clear this
> > > flag. The occurrence of a second Machine-Check Event while MCIP is set will
> > > cause the processor to enter a shutdown state."
> > > 
> > > While in do_machine_check function, we enter the panic path (for
> > > unrecoverable errors) much before the IA32_MCG_STATUS MSR is reset and
> > > this is likely to dangerous.
> > > 
> > > 911 void do_machine_check(struct pt_regs *regs, long error_code)
> > > 912 {
> > > .............
> > > ................
> > > 1055         if (no_way_out && tolerant < 3)
> > > 1056                 mce_panic("Fatal machine check on current CPU", final, msg);
> > > .............
> > > ................
> > > 1073         mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
> > > 1074 out:
> > > 
> > > It'd be interesting to know the type of memory error (as classified by
> > > the processor) for which you're able to capture the memory dump.
> > > Maybe a dump of the various MCE status registers (and struct mce) would
> > > help us understand the behaviour on your system better.
> > 
> > Well, there are MCE types for which we need to panic but we don't
> > necessarily corrupt memory. Your approach is to unconditionally avoid
> > dumping core whenever we panic while you should look at the MCE
> > signature and decide then whether to capture crashed kernel memory or
> > not.
> > 
> > For example, if the MCE signature says UC DRAM error, then you can
> > be pretty sure that there is a landmine somewhere in the DRAM region
> > mapping the crashed kernel. If it is, say, a UC when doing data fills
> > from L2 to L1, that doesn't necessarily mean that DRAM is corrupted. But
> > even in the first case, you can evaluate the MCi_ADDR reported with the
> > UC DRAM error and simply skip that particular cacheline when dumping the
> > core instead of not capturing anything at all.
> > 
> 
> True. Like stated by me earlier, there could be two possible outcomes
> from capturing memory dump in such cases - they're either dangerous or
> doesn't make sense. It is best to avoid a normal kdump in both cases,
> although the elf-note doesn't distinguish between the two.
> 
> NT_NOCOREDUMP, in my opinion, is just the first step towards introducing
> a framework where different code paths that lead to panic() can
> 'opt-out' from kdump by adding an elf-note.
> 
> We can modify this to add more fine-grained messages using different elf-note
> types (or use the elf-note name under the NT_NOCOREDUMP type) to
> indicate the cause/type of crash.

Which could be found by looking at log buffers too? So looks like that
you want to put all the MCE related info in an ELF note and don't want
user to poke at vmcore. (Though there are no gurantees that writing to
MCE note location is safe or not). So assumption here would be that
reading an ELF note is safer than trying to extract kernel log buffers.

> 
> I'd like to hear further from you and the rest of the community to see if
> there's a need felt for such a change.

I feel that we are trying to solve a theoritical problem at this point
of time. You have never run into any issues, just that you are reading
the documentation and then trying to add a framework. I will be little
wary of that.

Having said that I do think that adding a way to let user space know some
additional information about panic is not a bad idea. For example, an
additional field in vmcoreinfo to let user space know that it was
MCE panic.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
