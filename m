Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1REiXk-0005lw-Tw
	for kexec@lists.infradead.org; Fri, 14 Oct 2011 14:15:27 +0000
Date: Fri, 14 Oct 2011 10:14:50 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111014141450.GB4142@redhat.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<20111004140437.GA28306@redhat.com>
	<20111005071844.GB2235@in.ibm.com>
	<20111005152537.GB30146@redhat.com>
	<20111007161218.GA2297@in.ibm.com>
	<20111010070725.GB11577@liondog.tnic>
	<20111011184434.GB32316@in.ibm.com>
	<20111012155144.GC12845@redhat.com>
	<20111014113025.GA20278@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111014113025.GA20278@in.ibm.com>
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
	Tony" <tony.luck@intel.com>, Valdis.Kletnieks@vt.edu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, anderson@redhat.com, crash-utility@redhat.com

On Fri, Oct 14, 2011 at 05:00:25PM +0530, K.Prasad wrote:
> On Wed, Oct 12, 2011 at 11:51:44AM -0400, Vivek Goyal wrote:
> > On Wed, Oct 12, 2011 at 12:14:34AM +0530, K.Prasad wrote:
> > > On Mon, Oct 10, 2011 at 09:07:25AM +0200, Borislav Petkov wrote:
> > > > On Fri, Oct 07, 2011 at 09:42:19PM +0530, K.Prasad wrote:
> [snipped]
> > > 
> > > ii) Scenario2: System with PG_hwpoison (or landmine!) pages crashes because
> > > of a software bug. In this case, kexec kernel would normally reboot because
> > > of reading the PG_poison page. I'll soon get a new version of the patchset
> > > implementing this.
> > > 
> > > Solution: Maintain a linked list of PFNs when the corresponding 'struct page'
> > > has been marked PG_hwpoison. We could export/put this list to use in
> > > quite a few ways.
> > 
> > What's the need of a list and why do we have to export anything. Can't
> > makedumpfile look at the struct page and then just not dump that page if
> > hwpoison flag is set.
> >
> 
> I'll respond to just this part of the comment for now, since I have a
> few conflicting thoughts crossing my mind regarding the above suggestion
> and thought I'll put it across to the community to get that clarified.
> 
> Using makedumpfile to actually identify and sidestep PG_hwpoison sounds
> a bit dangerous. Let's for a moment that makedumpfile has this
> capability, which is implemented as under.
> 
> - The list of nodes (pg_data_t) and all struct page's (through
>   node_mem_map) are sent to makedumpfile using VMCOREINFO_SYMBOL().
> 
> - makedumpfile would use this information to go to the old kernel's
>   memory, look at pg_data_t and then into each element of node_mem_map
>   to then lookout for PG_hwpoison inside 'struct page'->flags. (Well,
>   this method works for !SPARSEMEM. I'd like to know if I've overlooked
>   any other better method. pfn_to_page() wouldn't work either, as it will
>   give a 'struct page' of a PFN as seen by the kexec'd kernel and not
>   the crashed kernel).
> 
> - If PG_hwpoison flag for the corresponding page is clear, then it
>   will allow the copy operation.
> 
> - The problem comes when we actually land on a page with PG_hwpoison
>   while carrying out the above 3 steps. For instance, if the page
>   containing the pg_data_t and node_mem_map data structures themselves
>   are marked hw-poisoned.

I think it can happen and in that case we don't capture the dump. This
is similar to possibility of running into a accessing a poisoned page
while you are trying to same the final note which will contain the
MCE info or list of poisoned pages.

Even if you export the list successfuly and you find pd_data_t pages
are poisoned, what would you do? Not do filtering and save tera bytes
of dump.

I think you are just trying to solve every corner case which might
not even be required in practice. Kdump is our best effort to capture
the dump and there are so many corner cases where it will not work.

So I would suggest that lets us not make the whole thing too complicated
now. If the scenario you are describing becomes common enough that
it start bothering, we can look into exporting the poisoned pages list.

Thanks
Vivek 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
