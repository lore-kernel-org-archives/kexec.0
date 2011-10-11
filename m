Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RDhJx-00066P-BC
	for kexec@lists.infradead.org; Tue, 11 Oct 2011 18:44:59 +0000
Received: from /spool/local by au.ibm.com with XMail ESMTP
	for <kexec@lists.infradead.org> from <prasad@linux.vnet.ibm.com>;
	Tue, 11 Oct 2011 19:40:20 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p9BIgLSd1998860
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 05:42:21 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p9BIihZS028279
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 05:44:44 +1100
Date: Wed, 12 Oct 2011 00:14:34 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111011184434.GB32316@in.ibm.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<20111004140437.GA28306@redhat.com>
	<20111005071844.GB2235@in.ibm.com>
	<20111005152537.GB30146@redhat.com>
	<20111007161218.GA2297@in.ibm.com>
	<20111010070725.GB11577@liondog.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111010070725.GB11577@liondog.tnic>
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
To: Borislav Petkov <bp@alien8.de>, Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org, crash-utility@redhat.com, kexec@lists.infradead.org, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, anderson@redhat.com, tachibana@mxm.nes.nec.co.jp, oomichi@mxs.nes.nec.co.jp, Valdis.Kletnieks@vt.edu, Nick Bowler <nbowler@elliptictech.com>

On Mon, Oct 10, 2011 at 09:07:25AM +0200, Borislav Petkov wrote:
> On Fri, Oct 07, 2011 at 09:42:19PM +0530, K.Prasad wrote:
> > The problem, as pointed out by Borislav Petkov in a different mail, is that
> > we might end up capturing a vmcore containing corrupted data when the
> > same is not required for analysing the cause of the crash.
> > 
> > Of course, all this is assuming that reading the faulty memory with MCE
> > disabled is harmless. However, the effect of a read operation in this
> > case is undefined.
> 
> Frankly, I don't think that it is undefined - you basically should be
> able to read DRAM albeit with the corrupted data in it. However, you
> probably best disable the whole DRAM error detection first by clearing
> a couple of bits in MC4_CTL_MASK (at least on AMD that should work, I
> dunno how Intel does that).
> 

The MC4_CTL_MASK doesn't appear to be defined in the kernel. Looking at
http://support.amd.com/us/Processor_TechDocs/26094.PDF, Page 196, it
states that "This register is typically programmed by BIOS and not by
the Kernel software".

So, in any case we may not be able to disable machine-check exceptions
(MCEs) only within the context of kexec'ed kernel. Let me know if I've
missed something here.

> But, regardless, according to Vivek, the "makedumpfile" tool should be
> able to jump over poisoned pages and you don't need all the hoopla above
> at all, right?
>

In short, the answer is yes. We could add a new string, say
"CRASH_REASON=PANIC_MCE" to VMCOREINFO elf-note which can be parsed by
'makedumpfile' and get away without adding the new NT_NOCOREDUMP
elf-note. Parsing through the log_buf to lookout for panic string from
inside 'makedumpfile' appears to be a clumsy solution though.

The suggestion to make NT_NOCOREDUMP to contain more fine-granular
information can be met by using meaningful strings for VMCOREINFO.

---

In this context, I wish to quickly recollect the issues we've discussed
thus far, their proposed solutions and re-evaluate the need for new elf-note.

i) Scenario1: System crashes because of a fatal MCE

Proposed Solution: Add a new string in the VMCOREINFO elf-note from
within the MCE panic path to indicate cause of crash. 'makedumpfile'
recognises this string to collect a slimdump instead of the normal dump.

ii) Scenario2: System with PG_hwpoison (or landmine!) pages crashes because
of a software bug. In this case, kexec kernel would normally reboot because
of reading the PG_poison page. I'll soon get a new version of the patchset
implementing this.

Solution: Maintain a linked list of PFNs when the corresponding 'struct page'
has been marked PG_hwpoison. We could export/put this list to use in
quite a few ways.

- Make it a policy in the kernel to not operate upon a 'read' request
  for such pages. Return '0' from copy_oldmem_page() function if the PFN
  is part of the PG_hwpoison list. I don't see a reason why anybody
  would be interested in reading the contents of a corrupt page, so
  making it standard kernel behaviour should be acceptable (or so I
  hope :-)).

  The list of PFNs must be exported (How? more on that below) to
  user-space, so that downstream tools such as 'crash' recognise that
  the vmcore (corresponding to PG_hwpoison memory regions) contains
  'distorted' data.

- Export the PG_hwpoison PFN list through a new elf-note. Given that
  the PFN list can be long and of indeterminate size (at compile time),
  I'm not sure if individually adding each PFN to the VMCOREINFO note
  would be a good idea and hence the new elf-note.

  Then teach 'makedumpfile' to recognise these PFNs (by exporting their
  VADDR or somesuch mechanism) and avoid reading those pages from
  /proc/vmcore. Also collect these PFNs and pass it down to 'crash' to
  help it identify the 'distorted' memory locations.

The system in kexec-ed kernel could still crash because of fatal MCEs in
its own memory region or new uncorrected memory errors in the old
kernel's memory (error happened after the crash) and can be potentially
'read' during memory copy operation. However the probability of these
occurrences is assumed to be small given the short lifetime of the
kexec-ed kernel.

While we don't actually need a new elf-note for i), I suspect
it might not be the case for resolving ii).

Kindly let me know your thoughts on this.

Thanks,
K.Prasad

P.S.: A quick definition of terms used above
-------------------------------------------
Fatal or unrecoverable MCE - A Machine Check Exception (MCE) that causes
the system to panic. The exception might be triggered due to a faulty
piece of memory in DIMM or cache. It is triggered due to 'consumption'
(read/write) of a memory location with uncorrected memory error.

PG_hwpoison - This is a page flag (marked in 'struct page') when an
uncorrected memory error is detected (through means such as memory
scrubbing) but is not 'consumed' yet. The page is flagged to prevent it
from re-entering the memory stream. Causes the system to crash when
the page with this flag is consumed.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
