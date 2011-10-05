Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RBVlg-0004mC-4G
	for kexec@lists.infradead.org; Wed, 05 Oct 2011 18:00:33 +0000
Date: Wed, 05 Oct 2011 14:00:09 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <67cddd75-90d7-49b8-83ff-c677101b37b3@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20111005172912.GI30146@redhat.com>
MIME-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: oomichi@mxs.nes.nec.co.jp, Tony Luck <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "K.Prasad" <prasad@linux.vnet.ibm.com>, crash-utility@redhat.com



----- Original Message -----
> On Wed, Oct 05, 2011 at 07:20:37PM +0200, Borislav Petkov wrote:
> > On Wed, Oct 05, 2011 at 01:10:07PM -0400, Vivek Goyal wrote:
> > > On Wed, Oct 05, 2011 at 08:58:53AM -0700, Luck, Tony wrote:
> > > > > > The plan is to pass-down the list of poisoned memory pages
> > > > > > to the second
> > > > > > kernel using an elf-note so that these pages are left
> > > > > > untouched during
> > > > > > dump capture. I'm working on an implementation of the same
> > > > > > and should
> > > > > > have patches soon.
> > > > >
> > > > > I would say let us first figure out what happens while
> > > > > reading a poisoned
> > > > > page and is this a problem before working on a solution.
> > > > 
> > > > If the page is poisoned because of a real uncorrectable error
> > > > in memory
> > > > (reported as SRAO machine check today, or by SRAR
> > > > real-soon-now). Then
> > > > accessing the page from the processor while taking a memory
> > > > dump will
> > > > result in a machine check.
> > > > 
> > > > Note that a large memory system that had been running for a
> > > > long time
> > > > may have built up a small stash of these land-mine pages - and
> > > > we need
> > > > to worry about them even in the case where the panic is not
> > > > machine
> > > > check related (in fact especially in this case ... we are in a
> > > > case
> > > > where we actually do want the dump to diagnose the cause of the
> > > > panic,
> > > > and we don't want to risk losing the crash dump because we
> > > > aborted when
> > > > touching a page that the OS had safely avoided for
> > > > days/weeks/months).
> > > > 
> > > > So passing a list of poisoned pages from the old kernel to the
> > > > new kernel
> > > > is a good idea - and is independent of the cause of the crash
> > > > (except that
> > > > in the fatal machine check case due to memory error the list is
> > > > guaranteed
> > > > to be non-empty).
> > > 
> > > Whre is this poisoned page info stored? In struct page? If yes, then
> > > user space can walk through it and make sure not to touch poisoned pages.
> > > Anyway user space filtering utility "makedumpfile" walks through struct
> > > pages to filter out the pages. It should be able to filter out
> > > poisoned pages unconditionally. So there should be no need for kernel
> > > to export a list of these pages.
> > 
> > Does this utility work on a vmcore dump? If so, Tony refers to the
> > creation of the vmcore itself from the memory used by the first
> > kernel.
> 
> No, this utitlity can directly work on /proc/vmcore where first kernel's
> image is still in memory and not on disk.
> 
> > If there are poisoned pages, merely accessing that portion of DRAM
> > containing the poisoned data would cause further MCEs in the freshly
> > booted kernel so you won't be able to finish creating the dump.
> 
> As long as you can get to your struct page arrays, one should be able
> to filter out poisoned pages without saving the whole dump.

It's still going to require a minimal kernel change because the
PG_hwpoison flag's bit number differs depending upon the kernel
configuration, if it exists at all.  An additional vmcoreinfo item
probably...

Dave
  

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
