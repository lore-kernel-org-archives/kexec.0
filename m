Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RBTaC-00020f-8B
	for kexec@lists.infradead.org; Wed, 05 Oct 2011 15:40:32 +0000
Date: Wed, 5 Oct 2011 11:40:11 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111005154011.GD30146@redhat.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<20111004143012.GB28306@redhat.com>
	<20111005074116.GC2235@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111005074116.GC2235@in.ibm.com>
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
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Borislav Petkov <bp@alien8.de>, crash-utility@redhat.com

On Wed, Oct 05, 2011 at 01:11:16PM +0530, K.Prasad wrote:

[..]
> > Again, note_name and desc_msg seem to be only two exports. Frankly desc
> > string seems pretty obivious and we should be able to ignore it. So just
> > exporting PANIC_MCE=true or something like that in case of MCE. 
> >
> 
> Yes, adding a new field to the VMCOREINFO note would have been much
> simpler but there's a second part to the kdump + fatal MCE problem which
> will need a new elf-note to solve.
> 
> On a system containing 'poisoned' pages (generated as a result of
> detecting UC errors which haven't been 'consumed'), if a software bug results
> in crashing the machine, the ensuing kdump operation will read from the
> faulty memory location. This will trigger a new crash within the context
> of the kexec'ed kernel and we want to avoid this.

I think in other mail you mentioned that it is not known what happens
if we try to read pages marked as "poisoned".

> 
> The plan is to pass-down the list of poisoned memory pages to the second
> kernel using an elf-note so that these pages are left untouched during
> dump capture. I'm working on an implementation of the same and should
> have patches soon.

I would say let us first figure out what happens while reading a poisoned
page and is this a problem before working on a solution.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
