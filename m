Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cl-3117.ham-01.de.sixxs.net ([2001:6f8:900:c2c::2]
	helo=mail.skyhub.de)
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RAyaa-00021z-3e
	for kexec@lists.infradead.org; Tue, 04 Oct 2011 06:34:53 +0000
Date: Tue, 4 Oct 2011 08:34:40 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111004063440.GB5723@liondog.tnic>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<m162k64c7w.fsf@fess.ebiederm.org>
	<20111003120336.GK2223@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111003120336.GK2223@in.ibm.com>
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

On Mon, Oct 03, 2011 at 05:33:36PM +0530, K.Prasad wrote:
> It's interesting...according to Intel's Software Developer Manual
> (quoting from Volume 3A, Chapter 15), the MCIP bit in IA32_MCG_STATUS
> MSR behaves as described below.
> 
> "MCIP (machine check in progress) flag, bit 2 Indicates (when set)
> that a machine-check exception was generated. Software can set or clear this
> flag. The occurrence of a second Machine-Check Event while MCIP is set will
> cause the processor to enter a shutdown state."
> 
> While in do_machine_check function, we enter the panic path (for
> unrecoverable errors) much before the IA32_MCG_STATUS MSR is reset and
> this is likely to dangerous.
> 
> 911 void do_machine_check(struct pt_regs *regs, long error_code)
> 912 {
> .............
> ................
> 1055         if (no_way_out && tolerant < 3)
> 1056                 mce_panic("Fatal machine check on current CPU", final, msg);
> .............
> ................
> 1073         mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
> 1074 out:
> 
> It'd be interesting to know the type of memory error (as classified by
> the processor) for which you're able to capture the memory dump.
> Maybe a dump of the various MCE status registers (and struct mce) would
> help us understand the behaviour on your system better.

Well, there are MCE types for which we need to panic but we don't
necessarily corrupt memory. Your approach is to unconditionally avoid
dumping core whenever we panic while you should look at the MCE
signature and decide then whether to capture crashed kernel memory or
not.

For example, if the MCE signature says UC DRAM error, then you can
be pretty sure that there is a landmine somewhere in the DRAM region
mapping the crashed kernel. If it is, say, a UC when doing data fills
from L2 to L1, that doesn't necessarily mean that DRAM is corrupted. But
even in the first case, you can evaluate the MCi_ADDR reported with the
UC DRAM error and simply skip that particular cacheline when dumping the
core instead of not capturing anything at all.

Btw, the doublefault example you give above - is this something you
experience on real hardware or just a theoretical thing?

Thanks.

-- 
Regards/Gruss,
    Boris.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
