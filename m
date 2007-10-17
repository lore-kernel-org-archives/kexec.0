From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 16 Oct 2007 22:27:44 -0700
Subject: [PATCH 2/3] [kexec-tools] Pass vmcoreinfo's address and size
In-Reply-To: <47159AA3.10305@mxs.nes.nec.co.jp>
References: <20070822210838oomichi@mail.jp.nec.com>
	<20070822211339oomichi@mail.jp.nec.com>
	<20071017023305.GC6709@verge.net.au>
	<47159AA3.10305@mxs.nes.nec.co.jp>
Message-ID: <20071016222744.a8f4b987.akpm@linux-foundation.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, 17 Oct 2007 14:16:19 +0900 "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp> wrote:

> Simon Horman wrote:
> > On Wed, Aug 22, 2007 at 09:13:39PM +0900, Ken'ichi Ohmichi wrote:
> >> [2/3] [kexec-tools] Pass vmcoreinfo's address and size
> >> The patch is for kexec-tools-testing-20070330.
> >> (http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/)
> >> kexec command gets the address and size of the vmcoreinfo data from
> >> /sys/kernel/vmcoreinfo, and passes them to the second kernel through
> >> ELF header of /proc/vmcore. When the second kernel is booting, the
> >> kernel gets them from the ELF header and creates vmcoreinfo's PT_NOTE
> >> segment into /proc/vmcore.
> > 
> > Sorry for the long delay, I completely missed this patch.
> > 
> > The kexec-tools change seems ok to me. What is the status of
> > the kernel portion of the change?
> 
> The kernel portion is merged into linux-2.6.23-mm1.
> According to Andrew's mail "-mm merge plans for 2.6.24",  its status is
> "The infamous misc.  Will re-review and will merge basically all of them".

It's all in this evening's batch, which is going through final QA (heh)
now.  Is looking OK.


