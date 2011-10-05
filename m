Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RBNiS-0007CF-Fn
	for kexec@lists.infradead.org; Wed, 05 Oct 2011 09:25:00 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp07.in.ibm.com (8.14.4/8.13.1) with ESMTP id p959Nrfr002527
	for <kexec@lists.infradead.org>; Wed, 5 Oct 2011 14:53:53 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p959Nqrq1085580
	for <kexec@lists.infradead.org>; Wed, 5 Oct 2011 14:53:52 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p959NqQl000651
	for <kexec@lists.infradead.org>; Wed, 5 Oct 2011 20:23:52 +1100
Date: Wed, 5 Oct 2011 14:53:50 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111005092350.GA7485@in.ibm.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<20111004140437.GA28306@redhat.com>
	<20111005071844.GB2235@in.ibm.com>
	<20111005073313.GB13478@liondog.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111005073313.GB13478@liondog.tnic>
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
To: Borislav Petkov <bp@alien8.de>, Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org, crash-utility@redhat.com, kexec@lists.infradead.org, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, anderson@redhat.com, tachibana@mxm.nes.nec.co.jp, oomichi@mxs.nes.nec.co.jp

On Wed, Oct 05, 2011 at 09:33:13AM +0200, Borislav Petkov wrote:
> On Wed, Oct 05, 2011 at 12:48:44PM +0530, K.Prasad wrote:
> > On Tue, Oct 04, 2011 at 10:04:37AM -0400, Vivek Goyal wrote:
> > > On Mon, Oct 03, 2011 at 01:02:03PM +0530, K.Prasad wrote:
> > > > There are certain types of crashes induced by faulty hardware in which
> > > > capturing crashing kernel's memory (through kdump) makes no sense (or sometimes
> > > > dangerous).
> > > > 
> > > > A case in point, is unrecoverable memory errors (resulting in fatal machine
> > > > check exceptions) in which reading from the faulty memory location from the
> > > > kexec'ed kernel will cause double fault and system reset (leaving no
> > > > information for the user).
> > > 
> > > Prasad,
> > > 
> > > I am just trying to remember what was wrong with Andi's approach of
> > > disable MCE while copying the dump?
> > >
> > 
> > Hi Vivek,
> > 	The behaviour upon a read operation on an UC memory location is
> > undefined and so we want to avoid it (previously discussed here:
> > http://article.gmane.org/gmane.linux.kernel/1146799). When we disable
> > MCE and copy the dump, we will invariably read the faulty memory
> > location.
> 
> Right, from the message above:
> 
> "- To disable MCE exceptions as done by the patches cited above. However
>   the result of a read operation on corrupted memory is unknown and the
>   system behaviour is undefined. We're unsure if this is a safe thing to
>   do."
> 
> Can you elaborate more on that? Are we talking poisoned memory here or
> undetected and uncorrectable memory errors?
>

It refers to uncorrected memory errors that are not consumed and the
corresponding 'struct page's are marked PG_hwpoison. Typically the SRAO
type errors that are handled in mm/memory-failure.c.

If MCE is enabled, during a kdump, we will deliberately trigger a read
operation over the poisoned memory and make the UCE fatal. It is not
clear what would happen if MCE is disabled in the above case.

Thanks,
K.Prasad


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
