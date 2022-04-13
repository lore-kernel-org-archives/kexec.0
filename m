From: Omar Sandoval <osandov@osandov.com>
Date: Wed, 13 Apr 2022 09:24:28 -0700
Subject: [PATCH v2] mm/vmalloc: fix spinning drain_vmap_work after
 reading from /proc/vmcore
In-Reply-To: <Yk+l1/xLzhB02aIU@MiWiFi-R3L-srv>
References: <52f819991051f9b865e9ce25605509bfdbacadcd.1649277321.git.osandov@fb.com>
 <Yk72+9UFwsaFXoZe@chrisdown.name> <Yk+l1/xLzhB02aIU@MiWiFi-R3L-srv>
Message-ID: <Ylb5PLNDFIif6vZ2@relinquished.localdomain>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, Apr 08, 2022 at 11:02:47AM +0800, Baoquan He wrote:
> On 04/07/22 at 03:36pm, Chris Down wrote:
> > Omar Sandoval writes:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > Commit 3ee48b6af49c ("mm, x86: Saving vmcore with non-lazy freeing of
> > > vmas") introduced set_iounmap_nonlazy(), which sets vmap_lazy_nr to
> > > lazy_max_pages() + 1, ensuring that any future vunmaps() immediately
> > > purge the vmap areas instead of doing it lazily.
> > > 
> > > Commit 690467c81b1a ("mm/vmalloc: Move draining areas out of caller
> > > context") moved the purging from the vunmap() caller to a worker thread.
> > > Unfortunately, set_iounmap_nonlazy() can cause the worker thread to spin
> > > (possibly forever). For example, consider the following scenario:
> > > 
> > > 1. Thread reads from /proc/vmcore. This eventually calls
> > >   __copy_oldmem_page() -> set_iounmap_nonlazy(), which sets
> > >   vmap_lazy_nr to lazy_max_pages() + 1.
> > > 2. Then it calls free_vmap_area_noflush() (via iounmap()), which adds 2
> > >   pages (one page plus the guard page) to the purge list and
> > >   vmap_lazy_nr. vmap_lazy_nr is now lazy_max_pages() + 3, so the
> > >   drain_vmap_work is scheduled.
> > > 3. Thread returns from the kernel and is scheduled out.
> > > 4. Worker thread is scheduled in and calls drain_vmap_area_work(). It
> > >   frees the 2 pages on the purge list. vmap_lazy_nr is now
> > >   lazy_max_pages() + 1.
> > > 5. This is still over the threshold, so it tries to purge areas again,
> > >   but doesn't find anything.
> > > 6. Repeat 5.
> > > 
> > > If the system is running with only one CPU (which is typicial for kdump)
> > > and preemption is disabled, then this will never make forward progress:
> > > there aren't any more pages to purge, so it hangs. If there is more than
> > > one CPU or preemption is enabled, then the worker thread will spin
> > > forever in the background. (Note that if there were already pages to be
> > > purged at the time that set_iounmap_nonlazy() was called, this bug is
> > > avoided.)
> > > 
> > > This can be reproduced with anything that reads from /proc/vmcore
> > > multiple times. E.g., vmcore-dmesg /proc/vmcore.
> > > 
> > > It turns out that improvements to vmap() over the years have obsoleted
> > > the need for this "optimization". I benchmarked
> > > `dd if=/proc/vmcore of=/dev/null` with 4k and 1M read sizes on a system
> > > with a 32GB vmcore. The test was run on 5.17, 5.18-rc1 with a fix that
> > > avoided the hang, and 5.18-rc1 with set_iounmap_nonlazy() removed
> > > entirely:
> > > 
> > >  |5.17  |5.18+fix|5.18+removal
> > > 4k|40.86s|  40.09s|      26.73s
> > > 1M|24.47s|  23.98s|      21.84s
> > > 
> > > The removal was the fastest (by a wide margin with 4k reads). This patch
> > > removes set_iounmap_nonlazy().
> > > 
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > 
> > It probably doesn't matter, but maybe worth adding in a Fixes tag just to
> > make sure anyone getting this without context understands that 690467c81b1a
> > ("mm/vmalloc: Move draining areas out of caller context") shouldn't reach
> > further rcs without this. Unlikely that would happen anyway, though.
> > 
> > Nice use of a bug as an impetus to clean things up :-) Thanks!
> 
> Since redhat mail server has issue, the body content of patch is empty
> from my mail client. So reply here to add comment.
> 
> As replied in v1 to Omar, I think this is a great fix. That would be
> also great to state if this is a real issue which is breaking thing,
> then add 'Fixes' tag and Cc stable like "Cc: <stable@vger.kernel.org> # 5.17",
> or a fantastic improvement from code inspecting.
> 
> Concern this because in distros, e.g in our rhel8, we maintain old kernel
> and back port necessary patches into the kernel, those patches with
> 'Fixes' tag definitely are good candidate. This is important too to LTS
> kernel.
> 
> Thanks
> Baoquan

Hi, Baoquan,

Sorry I missed your replies. I'll answer your questions from your first
email.

> I am wondering if this is a real issue you met, or you just found it
> by code inspecting

I hit this issue with the test suite for drgn
(https://github.com/osandov/drgn). We run the test cases in a virtual
machine on various kernel versions
(https://github.com/osandov/drgn/tree/main/vmtest). Part of the test
suite crashes the kernel to run some tests against /proc/vmcore
(https://github.com/osandov/drgn/blob/13144eda119790cdbc11f360c15a04efdf81ae9a/setup.py#L213,
https://github.com/osandov/drgn/blob/main/vmtest/enter_kdump.py,
https://github.com/osandov/drgn/tree/main/tests/linux_kernel/vmcore).
When I tried v5.18-rc1 configured with !SMP and !PREEMPT, that part of
the test suite got stuck, which is how I found this issue.

> I am wondering how your vmcore dumping is handled. Asking this because
> we usually use makedumpfile utility

In production at Facebook, we don't run drgn directly against
/proc/vmcore. We use makedumpfile and inspect the captured file with
drgn once we reboot.

> While using makedumpfile, we use mmap which is 4M at one time by
> default, then process the content. So the copy_oldmem_page() may only
> be called during elfcorehdr and notes reading.

We also use vmcore-dmesg
(https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/vmcore-dmesg)
on /proc/vmcore before calling makedumpfile. From what I can tell, that
uses read()/pread()
(https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/util_lib/elf_info.c),
so it would also hit this issue.

I'll send a v3 adding Fixes: 690467c81b1a ("mm/vmalloc: Move draining
areas out of caller context"). I don't think a stable tag is necessary
since this was introduced in v5.18-rc1 and hasn't been backported as far
as I can tell.

Thanks,
Omar

