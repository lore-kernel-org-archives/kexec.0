From: Omar Sandoval <osandov@osandov.com>
Date: Wed, 6 Apr 2022 13:16:06 -0700
Subject: [PATCH] mm/vmalloc: fix spinning drain_vmap_work after reading
 from /proc/vmcore
In-Reply-To: <Yk1kmfrM0PjgJiNK@MiWiFi-R3L-srv>
References: <75014514645de97f2d9e087aa3df0880ea311b77.1649187356.git.osandov@fb.com>
 <20220406044244.GA9959@lst.de> <Yk1Zrd5BLeQAU+vn@pc638.lan>
 <Yk1kmfrM0PjgJiNK@MiWiFi-R3L-srv>
Message-ID: <Yk31Bs06E1nFTelX@relinquished.localdomain>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Apr 06, 2022 at 05:59:53PM +0800, Baoquan He wrote:
> On 04/06/22 at 11:13am, Uladzislau Rezki wrote:
> > > On Tue, Apr 05, 2022 at 12:40:31PM -0700, Omar Sandoval wrote:
> > > > A simple way to "fix" this would be to make set_iounmap_nonlazy() set
> > > > vmap_lazy_nr to lazy_max_pages() instead of lazy_max_pages() + 1. But, I
> > > > think it'd be better to get rid of this hack of clobbering vmap_lazy_nr.
> > > > Instead, this fix makes __copy_oldmem_page() explicitly drain the vmap
> > > > areas itself.
> > > 
> > > This fixes the bug and the interface also is better than what we had
> > > before.  But a vmap/iounmap_eager would seem even better.  But hey,
> > > right now it has one caller in always built ?n x86 arch code, so maybe
> > > it isn't worth spending more effort on this.
> > >
> > IMHO, it just makes sense to remove it. The set_iounmap_nonlazy() was
> > added in 2010 year:
> > 
> > <snip>
> > commit 3ee48b6af49cf534ca2f481ecc484b156a41451d
> > Author: Cliff Wickman <cpw@sgi.com>
> > Date:   Thu Sep 16 11:44:02 2010 -0500
> > 
> >     mm, x86: Saving vmcore with non-lazy freeing of vmas
> > 
> >     During the reading of /proc/vmcore the kernel is doing
> >     ioremap()/iounmap() repeatedly. And the buildup of un-flushed
> >     vm_area_struct's is causing a great deal of overhead. (rb_next()
> >     is chewing up most of that time).
> > 
> >     This solution is to provide function set_iounmap_nonlazy(). It
> >     causes a subsequent call to iounmap() to immediately purge the
> >     vma area (with try_purge_vmap_area_lazy()).
> > 
> >     With this patch we have seen the time for writing a 250MB
> >     compressed dump drop from 71 seconds to 44 seconds.
> > 
> >     Signed-off-by: Cliff Wickman <cpw@sgi.com>
> >     Cc: Andrew Morton <akpm@linux-foundation.org>
> >     Cc: kexec at lists.infradead.org
> >     Cc: <stable@kernel.org>
> >     LKML-Reference: <E1OwHZ4-0005WK-Tw@eag09.americas.sgi.com>
> >     Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > <snip>
> > 
> > and the reason was the "slow vmap" code, i.e. due to poor performance
> > they decided to drop the lazily ASAP. Now we have absolutely different
> > picture when it comes to performance and the vmalloc/vmap code.
> 
> I would vote for the current code change, removing it. As pointed out by
> Christoph, it's only used by x86, may not be so worth to introduce a new
> interface.

I did a quick benchmark to see if this optimization is still needed.
This is on a system with 32GB RAM. I timed
`dd if=/proc/vmcore of=/dev/null` with 4k and 1M block sizes on 5.17,
5.18 with this fix, and 5.18 with the non-lazy cleanup removed entirely.
It looks like Uladzislau has a point, and this "optimization" actually
slows things down now:

  |5.17  |5.18+fix|5.18+removal
4k|40.86s|  40.09s|      26.73s
1M|24.47s|  23.98s|      21.84s

I'll send a v2 which removes set_iounmap_nonlazy() entirely.

