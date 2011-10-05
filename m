Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cl-3117.ham-01.de.sixxs.net ([2001:6f8:900:c2c::2]
	helo=mail.skyhub.de)
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RBLwl-0004yr-W7
	for kexec@lists.infradead.org; Wed, 05 Oct 2011 07:31:21 +0000
Date: Wed, 5 Oct 2011 09:31:11 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111005073111.GA13478@liondog.tnic>
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
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, crash-utility@redhat.com

On Wed, Oct 05, 2011 at 12:37:28PM +0530, K.Prasad wrote:
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
> doesn't make sense.

Why, in the second example the only corruption is to the L2 cache so
your memory image is intact. Why wouldn't you want to capture a memory
dump then? It is business as usual in that case.

> It is best to avoid a normal kdump in both cases,
> although the elf-note doesn't distinguish between the two.
> 
> NT_NOCOREDUMP, in my opinion, is just the first step towards introducing
> a framework where different code paths that lead to panic() can
> 'opt-out' from kdump by adding an elf-note.
> 
> We can modify this to add more fine-grained messages using different elf-note
> types (or use the elf-note name under the NT_NOCOREDUMP type) to
> indicate the cause/type of crash.
> 
> I'd like to hear further from you and the rest of the community to see if
> there's a need felt for such a change.

I'd make this conditional on whether you have had memory corruption or
not by evaluating MCE signatures and acting accordingly.

> > Btw, the doublefault example you give above - is this something you
> > experience on real hardware or just a theoretical thing?
> >
> 
> Unfortunately, I still haven't been able to try injecting memory errors
> and study the behaviour (trying to get access to machine with
> appropriate firmware). I'll have a reply to this after some experiments
> with memory error injection.

Right, this might be much more helpful than theoretical discussions on
what to do. :-)

Thanks.

-- 
Regards/Gruss,
    Boris.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
