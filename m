Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RE1EI-0001gj-IO
	for kexec@lists.infradead.org; Wed, 12 Oct 2011 16:00:27 +0000
Date: Wed, 12 Oct 2011 11:59:02 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111012155902.GD12845@redhat.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<20111004140437.GA28306@redhat.com>
	<20111005071844.GB2235@in.ibm.com>
	<20111005152537.GB30146@redhat.com>
	<20111007161218.GA2297@in.ibm.com>
	<20111010070725.GB11577@liondog.tnic>
	<20111011184434.GB32316@in.ibm.com>
	<20111012104429.GA11983@gere.osrc.amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111012104429.GA11983@gere.osrc.amd.com>
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
To: Borislav Petkov <bp@alien8.de>
Cc: oomichi@mxs.nes.nec.co.jp, Nick Bowler <nbowler@elliptictech.com>, "Luck,
	Tony" <tony.luck@intel.com>, Valdis.Kletnieks@vt.edu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, "K.Prasad" <prasad@linux.vnet.ibm.com>, crash-utility@redhat.com

On Wed, Oct 12, 2011 at 12:44:29PM +0200, Borislav Petkov wrote:

[..]
> > > But, regardless, according to Vivek, the "makedumpfile" tool should be
> > > able to jump over poisoned pages and you don't need all the hoopla above
> > > at all, right?
> > >
> > 
> > In short, the answer is yes. We could add a new string, say
> > "CRASH_REASON=PANIC_MCE" to VMCOREINFO elf-note which can be parsed by
> > 'makedumpfile' and get away without adding the new NT_NOCOREDUMP
> > elf-note. Parsing through the log_buf to lookout for panic string from
> > inside 'makedumpfile' appears to be a clumsy solution though.
> 
> Why, 'makedumpfile' reportedly supports some dmesg parsing already -
> why would you need additional functionality when it can be done with
> in-house means already. Maybe Vivek should comment on whether this makes
> sense but I'm basically reiterating what he said.

makdumpfile can extarct kernel log buf but it does not parse it. So it
just extracts the logs and one can save it to a file and parsing it
is left to user.

So exporting one more string through VMCOREINFO to signal that PANIC_MCE
happened makes sense to me. Rest of it can go into makedumpfile.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
