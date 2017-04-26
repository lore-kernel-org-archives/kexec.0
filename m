Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1d3KW7-00027V-DG
 for kexec@lists.infradead.org; Wed, 26 Apr 2017 10:49:53 +0000
Date: Wed, 26 Apr 2017 12:49:24 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] memmap: Parse "Reserved" together with "reserved"
Message-ID: <20170426104924.GA23556@verge.net.au>
References: <20170426005526.27313-1-yinghai@kernel.org>
 <20170426062247.fbl62xrkrm7tvnga@gmail.com>
 <20170426072846.GA7344@dhcp-128-65.nay.redhat.com>
 <20170426073148.GA7367@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170426073148.GA7367@dhcp-128-65.nay.redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org

On Wed, Apr 26, 2017 at 03:31:48PM +0800, Dave Young wrote:
> On 04/26/17 at 03:28pm, Dave Young wrote:
> > On 04/26/17 at 08:22am, Ingo Molnar wrote:
> > > 
> > > * Yinghai Lu <yinghai@kernel.org> wrote:
> > > 
> > > > For x86 with recent kernel after
> > > >  commit 640e1b38b0 ("x86/boot/e820: Basic cleanup of e820.c")
> > > > change "reserved" to "Reserved" in /sys firmware memmap and /proc/iomem.
> > > > 
> > > > So here, we add handling for that too.
> > > > 
> > > > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> > > > 
> > > > ---
> > > >  kexec/arch/i386/crashdump-x86.c |    2 ++
> > > >  kexec/arch/ia64/kexec-ia64.c    |    2 ++
> > > >  kexec/arch/mips/kexec-mips.c    |    2 ++
> > > >  kexec/firmware_memmap.c         |    2 ++
> > > >  4 files changed, 8 insertions(+)
> > > 
> > > I'd rather fix the bug I introduced and undo the reserved->Reserved string change 
> > 
> > This patch parses both 'reserved' and 'Reserved' it should be fine, but
> > reverting the change in kernel sounds better..
> 
> Hmm, after press sending I noticed old kexec-tools with new kernel, it
> is still a problem, so we'd better to revert the kernel changes.

FWIW, if the kernel change hasn't hit a release then reverting (the
reserved->Reserved portion of) it would be my preference.

> > > in e820.c: I didn't realize that it's exposed in sysfs and had quasi-ABI 
> > > consequences for kexec.
> > > 
> > > Agreed?
> > > 
> > > Thanks,
> > > 
> > > 	Ingo
> > > 
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> > Thanks
> > Dave
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
