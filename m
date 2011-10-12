Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cl-3117.ham-01.de.sixxs.net ([2001:6f8:900:c2c::2]
	helo=mail.skyhub.de)
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RDwIf-0005Zq-BW
	for kexec@lists.infradead.org; Wed, 12 Oct 2011 10:44:38 +0000
Date: Wed, 12 Oct 2011 12:44:29 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111012104429.GA11983@gere.osrc.amd.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<20111004140437.GA28306@redhat.com>
	<20111005071844.GB2235@in.ibm.com>
	<20111005152537.GB30146@redhat.com>
	<20111007161218.GA2297@in.ibm.com>
	<20111010070725.GB11577@liondog.tnic>
	<20111011184434.GB32316@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111011184434.GB32316@in.ibm.com>
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
Cc: oomichi@mxs.nes.nec.co.jp, Nick Bowler <nbowler@elliptictech.com>, "Luck,
	Tony" <tony.luck@intel.com>, Valdis.Kletnieks@vt.edu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, crash-utility@redhat.com

On Wed, Oct 12, 2011 at 12:14:34AM +0530, K.Prasad wrote:
> The MC4_CTL_MASK doesn't appear to be defined in the kernel. Looking at
> http://support.amd.com/us/Processor_TechDocs/26094.PDF, Page 196, it
> states that "This register is typically programmed by BIOS and not by
> the Kernel software".

Oh, this is K8 BKDG, thus pretty old. For AMD docs, you could use
developer.amd.com, and more specifically

http://developer.amd.com/documentation/Pages/default.aspx

So if we look at the F10h manual:

http://support.amd.com/us/Processor_TechDocs/31116.pdf

there's this section "2.12.1.2.1 Machine Check Error Logging and
Reporting" on p. 167 which explains all the modalities around switching
MCE on/off.

And if you clear CR4.MCE, the machine would shutdown on a fatal MCE as
an additional precation when running software which doesn't support
MCE (fully) but you still don't want to corrupt your data: "If error
reporting is enabled but CR4.MCE is disabled, a reportable error will
cause the system to enter shutdown."

Thus clearing the MCi_CTL_MASK bit should help you.

> So, in any case we may not be able to disable machine-check exceptions
> (MCEs) only within the context of kexec'ed kernel. Let me know if I've
> missed something here.

I'm not sure it is advisable to completely disable MCA for the whole
duration of the image dumping, especially on a system which has already
booted into the second kernel due to an MCE.

> > But, regardless, according to Vivek, the "makedumpfile" tool should be
> > able to jump over poisoned pages and you don't need all the hoopla above
> > at all, right?
> >
> 
> In short, the answer is yes. We could add a new string, say
> "CRASH_REASON=PANIC_MCE" to VMCOREINFO elf-note which can be parsed by
> 'makedumpfile' and get away without adding the new NT_NOCOREDUMP
> elf-note. Parsing through the log_buf to lookout for panic string from
> inside 'makedumpfile' appears to be a clumsy solution though.

Why, 'makedumpfile' reportedly supports some dmesg parsing already -
why would you need additional functionality when it can be done with
in-house means already. Maybe Vivek should comment on whether this makes
sense but I'm basically reiterating what he said.

> i) Scenario1: System crashes because of a fatal MCE
> 
> Proposed Solution: Add a new string in the VMCOREINFO elf-note from
> within the MCE panic path to indicate cause of crash. 'makedumpfile'
> recognises this string to collect a slimdump instead of the normal dump.

see above.

> ii) Scenario2: System with PG_hwpoison (or landmine!) pages crashes because
> of a software bug. In this case, kexec kernel would normally reboot because
> of reading the PG_poison page. I'll soon get a new version of the patchset
> implementing this.
> 
> Solution: Maintain a linked list of PFNs when the corresponding 'struct page'
> has been marked PG_hwpoison. We could export/put this list to use in
> quite a few ways.

Let me stop you right there: again, according to Vivek:

http://marc.info/?l=kexec&m=131805679405076&w=2

makedumpfile can iterate over the struct page arrays and skip over
PG_hwpoison pages. I think this should be enough of functionality....

-- 
Regards/Gruss,
Boris.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
