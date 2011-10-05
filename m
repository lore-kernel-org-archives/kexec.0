Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cl-3117.ham-01.de.sixxs.net ([2001:6f8:900:c2c::2]
	helo=mail.skyhub.de)
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RBQmj-0000MD-Ld
	for kexec@lists.infradead.org; Wed, 05 Oct 2011 12:41:18 +0000
Date: Wed, 5 Oct 2011 14:41:14 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111005124113.GB509@gere.osrc.amd.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<m162k64c7w.fsf@fess.ebiederm.org>
	<20111003120336.GK2223@in.ibm.com>
	<20111004063440.GB5723@liondog.tnic>
	<20111005070728.GA2235@in.ibm.com>
	<20111005073111.GA13478@liondog.tnic>
	<20111005094727.GB7485@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111005094727.GB7485@in.ibm.com>
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
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, crash-utility@redhat.com

On Wed, Oct 05, 2011 at 03:17:27PM +0530, K.Prasad wrote:
> We don't want to capture memory dump when the machine crashes due to
> faulty cache, because the end-user derives no benefit by receiving a
> bulky vmcore and running crash analysis tools over them. Instead a
> 'slimdump' that contains a meaningful message about the origin of crash
> (and which can be understood by his analysis tools) would be better, or
> so I thought.

Ok, this makes sense, a meaningful message along with the MCE decoded
properly in userfriendly language so that one can understand why the
system has not captured vmcore.

> There are possibly several hardware errors which cause system crash and
> the kdump would capture full vmcore, although it doesn't make sense (I
> wouldn't have cared about the second example, you cited, if they did not
> generate MCE, but a different exception). In an ideal situation, each of
> these error paths would 'subscribe' to slimdump and add a meaningful
> message in the NT_NOCOREDUMP note instead of letting the user-space copy
> the old kernel memory.

Yep, I see.

> Fine with me. I see that the various IA32_MCi_Status registers will hold
> information about the error and use that to classify MCEs.
> 
> I think the best way to go about is to retain NT_NOCOREDUMP for non-DRAM
> errors also, but use the note-name field in the elf-note and distinguish the
> various types of errors...say, by using names such as "PANIC_MCE_DRAM",
> "PANIC_MCE_CACHE", etc (similar to the error codes described in the Intel
> manual). The upstream tools like 'makedumpfile' and 'crash' will have to
> be taught to parse the elf-note name and act accordingly.

Right, so Valdis had the right question in the other mail, let me
generalize it here: does it ever make sense to save vmcore on a hardware
error?

With DRAM errors, you probably could use the additional info coming with
the MCE do decode to the physical address and map back to the DIMM and
swap it. Any other use cases?

Thanks.

-- 
Regards/Gruss,
Boris.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
