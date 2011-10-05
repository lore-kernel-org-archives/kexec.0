Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cl-3117.ham-01.de.sixxs.net ([2001:6f8:900:c2c::2]
	helo=mail.skyhub.de)
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RBQcs-0000Fc-JQ
	for kexec@lists.infradead.org; Wed, 05 Oct 2011 12:31:07 +0000
Date: Wed, 5 Oct 2011 14:31:02 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111005123102.GA509@gere.osrc.amd.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<m162k64c7w.fsf@fess.ebiederm.org>
	<20111003120336.GK2223@in.ibm.com>
	<20111004063440.GB5723@liondog.tnic>
	<20111005070728.GA2235@in.ibm.com>
	<20111005073111.GA13478@liondog.tnic>
	<26571.1317815746@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <26571.1317815746@turing-police.cc.vt.edu>
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
To: Valdis.Kletnieks@vt.edu
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, "K.Prasad" <prasad@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, crash-utility@redhat.com

On Wed, Oct 05, 2011 at 07:55:46AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 05 Oct 2011 09:31:11 +0200, Borislav Petkov said:
> > On Wed, Oct 05, 2011 at 12:37:28PM +0530, K.Prasad wrote:
> 
> > > True. Like stated by me earlier, there could be two possible outcomes
> > > from capturing memory dump in such cases - they're either dangerous or
> > > doesn't make sense.
> >
> > Why, in the second example the only corruption is to the L2 cache so
> > your memory image is intact. Why wouldn't you want to capture a memory
> > dump then? It is business as usual in that case.
> 
> I'll bite.  What's the use case for bothering to capture a memory dump when
> you're looking at an MCE that indicates L2 cache corruption?  What additional
> useful information could you possibly get from the dump?

This was just a hypothetical example to show that you need a more
finer-grained differentiation between fatal MCEs when deciding to dump
or not to dump :-) and not to unconditionally _not_ dump just because
we're going to panic.

-- 
Regards/Gruss,
Boris.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
