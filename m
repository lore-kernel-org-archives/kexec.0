Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W1gkj-0008O4-Np
 for kexec@lists.infradead.org; Fri, 10 Jan 2014 18:24:18 +0000
Date: Fri, 10 Jan 2014 12:23:55 -0600
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: [PATCH 0/2] makedumpfile: for large memories
Message-ID: <20140110182355.GC7498@sgi.com>
References: <E1Vy8l7-0004oL-7v@eag09.americas.sgi.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971D878F@BPXM01GP.gisp.nec.co.jp>
 <20140109002523.GA30797@sgi.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971DA820@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971DA820@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Fri, Jan 10, 2014 at 07:48:27AM +0000, Atsushi Kumagai wrote:
> On 2014/01/09 9:26:20, kexec <kexec-bounces@lists.infradead.org> wrote:
> > On Mon, Jan 06, 2014 at 09:27:34AM +0000, Atsushi Kumagai wrote:
> > > Hello Cliff,
> > > 
> > > On 2014/01/01 8:30:47, kexec <kexec-bounces@lists.infradead.org> wrote:
> > > > From: Cliff Wickman <cpw@sgi.com>
> > > > 
> > > > Gentlemen of kexec,
> > > > 
> > > > I have been working on enabling kdump on some very large systems, and
> > > > have found some solutions that I hope you will consider.
> > > > 
> > > > The first issue is to work within the restricted size of crashkernel memory
> > > > under 2.6.32-based kernels, such as sles11 and rhel6.
> > > > 
> > > > The second issue is to reduce the very large size of a dump of a big memory
> > > > system, even on an idle system.
> > > > 
> > > > These are my propositions:
> > > > 
> > > > Size of crashkernel memory
> > > >   1) raw i/o for writing the dump
> > > >   2) use root device for the bitmap file (not tmpfs)
> > > >   3) raw i/o for reading/writing the bitmaps
> > > >   
> > > > Size of dump (and hence the duration of dumping)
> > > >   4) exclude page structures for unused pages
> > > > 
> > > > 
> > > > 1) Is quite easy.  The cache of pages needs to be aligned on a block
> > > >   boundary and written in block multiples, as required by O_DIRECT files.
> > > > 
> > > >   The use of raw i/o prevents the growing of the crash kernel's page
> > > >   cache.

Today I posted V2 of both patches.  V2 of the first patch fixes a bug.
V2 of the second patch make some of the changes that you and Hatayama-san
requested.  But these updates don't address all of your points.

 
> > > There is no reason to reject this idea, please re-post it as a formal patch.
> > > If possible, I would like to know the benefit of only this.
> > 
> > The motivation for using raw i/o was purely to be able to conserve memory,
> > not for speed.

> OK, 1) is also for removing cyclic mode, right ?

I did disable cyclic mode for my testing.  I wanted to prove that makedumpfile
can work in a small memory without cyclic mode. 
I think this is an alternative to cyclic mode, but I don't know all the
issues.  This is a proof of concept only -- I hope that you guys who have
the big picture of all the dump-capture issues can fit it in properly.

> I think there is no need to conserve memory with 1) since 2) is enough to
> remove cyclic mode.
> (To be exact, there are some cases that we have to use cyclic mode as
>  Hatayama-san said, but I don't mention that in this mail.)
> 
> > However, I haven't noticed any significant degradation in speed.
> > Memory is in 'very' short supply on a large machine (ironically) and a 2.6 or 
> > 3.0 kernel.  We're constrained to the low 4GB, and the kernel is putting other
> > things in that memory that are related to memory size.
> > The obvious solution is cyclic mode, but that requires at least 2x the page
> > scans.  Once for the scan of unnecessary pages and several partial 
> > scans for the copy phase.
> > But it is tmpfs and kernel page cache that are using up available memory.
> > If we avoid those, a single page scan can work in about 350M of crashkernel
> > memory.
> > This is not a problem with 3.10+ kernels as we're not constrained to low 4G.
> 
> Even if we can use 350M fully, 5TB is the limit system memory size
> in non-cyclic mode unless 2), since the bitmap file requires 64MB
> per 1TB RAM. So, I can't find an importance of 1).

1) raw i/o for writing the dump
2) use root device for the bitmap file (not tmpfs)
3) raw i/o for reading/writing the bitmaps
Non-raw i/o for either of theses files is going to enlarge kernel page
cache.  There doesn't seem to be any way to ask the kernel to limit
that growth.  And writing to tmpfs is consuming memory.  The one file
is much larger than the other, but to be consistent and not let i/o
consume memory I think we have to do all three.
 
> > > > 2) Is also quite easy.  My patch finds the path to the crash
> > > >   kernel's root device by examining the dump pathname. Storing the bitmaps
> > > >   to a file is otherwise not conserving memory, as they are being written
> > > >   to tmpfs.
> > > 
> > > Users will expect that the size of dump file is the same as the size of
> > > RAM at most, they will prepare a disk which fit to save that.
> > > But 2) breaks this estimation, I worry about it a little.
> > 
> > The bit map file is very small compared to the dump. And the dump should be
> > much smaller than RAM.  Particularly with 4), the excluding of unused page structures.
> > > 
> > > Of course, I don't reject this idea just only for that reason,
> > > but I would like to know the definite advantage of this.
> > > I suppose that the improvement showed in your benchmarks may be came
> > > from 1) and 4) mostly, so could you let me know that only 2) and 3)
> > > can perform much faster than the current cyclic mode ?
> > 
> > 2) and 3), the handling of the bitmap, are small contributors to the
> > memory shortage issue.  They are a bigger issue the bigger the system.
> > It's just that if we consistently avoid enlarging page cache and
> > tmpfs we can avoid the 2nd page scan altogether.
> > True, my benchmarks show only .2 min. and 1.1 min. improvements
> > for 2TB and 8TB (2.0 vs 1.8, and 6.6 vs 5.5).
> > But that's an improvement, not a loss.  And we're absolutely
> > not going to run out of memory as the scan and copies proceed.
> > This is important on these old kernels with minimal memory available.
> 
> Does just changing TMPDIR to a disk meet that purpose ?
> Is it necessary to add new codes ?
Perhaps.  But page cache is going to grow.
> 
> > > > 3) Raw i/o for the bitmaps, is accomplished by caching the
> > > >   bitmap file in a similar way to that of the dump file.
> > > > 
> > > >   I find that the use of direct i/o is not significantly slower than
> > > >   writing through the kernel's page cache.
> > > >
> > > > 4) The excluding of unused kernel page structures is very
> > > >   important for a large memory system.  The kernel otherwise includes
> > > >   3.67 million pages of page structures per TB of memory. By contrast
> > > >   the rest of the kernel is only about 1 million pages.
> > > 
> > > According to your and Dave's mails, 4) seems risky and unacceptable
> > > for now. I think we need more investigation for this.
I think we have addressed that with Dave and a patch to crash.
> > 
> > I've been working with Dave on a patch for crash.  It will warn the
> > user that certain kmem command options will fail.  But that is
> > only relevant to examinations of free memory and user memory, the
> > contents of which we're not capturing anyway.
> > 
> > Number 4), the exclusion of page structures for non-captured
> > pages is really the crux of the improvement.
> > A linux kernel should not be hugely bigger on a big machine than
> > on a small one.  Slightly bigger, yes, because of bigger slab
> > caches. 
> > But in practice the dumps of big memories are huge, and all
> > because of page structures.
> > To find the unneeded ones only takes a few seconds, but cuts
> > hours off the dumping process.  Without this a customer is just
> > not going to allow his very big system to be dumped.
> 
> I understand the benefit of this, but I still suspect that this
> feature is really required from users, it sounds too progressive
> to me.
> This is a big patch, so I want to make sure that this feature will
> be used in practice, any comments are welcome.

Agreed. Comments from developers of systems with big memories especially.
The second patch, regarding elimination of millions of pages of page
structures representing excluded pages is particularly important to being
able to dump a large system at all.
But shortening the scan of free and user pages is also helpful as the
memory size increases.

-Cliff
> 
> 
> Thanks
> Atsushi Kumagai
> 
> > -Cliff
> > > 
> > > 
> > > Thanks
> > > Atsushi Kumagai
> > > 
> > > > Test results are below, for systems of 1TB, 2TB, 8.8TB and 16TB.
> > > > (There are no 'old' numbers for 16TB as time and space requirements
> > > >  made those effectively useless.)
> > > > 
> > > > Run times were generally reduced 2-3x, and dump size reduced about 8x.
> > > > 
> > > > All timings were done using 512M of crashkernel memory.
> > > > 
> > > >    System memory size
> > > >    1TB                     unpatched    patched
> > > >      OS: rhel6.4 (does a free pages pass)
> > > >      page scan time           1.6min    1.6min
> > > >      dump copy time           2.4min     .4min
> > > >      total time               4.1min    2.0min
> > > >      dump size                 3014M      364M
> > > > 
> > > >      OS: rhel6.5
> > > >      page scan time            .6min     .6min
> > > >      dump copy time           2.3min     .5min
> > > >      total time               2.9min    1.1min
> > > >      dump size                 3011M      423M
> > > > 
> > > >      OS: sles11sp3 (3.0.93)
> > > >      page scan time            .5min     .5min
> > > >      dump copy time           2.3min     .5min
> > > >      total time               2.8min    1.0min
> > > >      dump size                 2950M      350M
> > > > 
> > > >    2TB
> > > >      OS: rhel6.5           (cyclicx3)
> > > >      page scan time           2.0min    1.8min
> > > >      dump copy time           8.0min    1.5min
> > > >      total time              10.0min    3.3min
> > > >      dump size                 6141M      835M
> > > > 
> > > >    8.8TB
> > > >      OS: rhel6.5           (cyclicx5)
> > > >      page scan time           6.6min    5.5min
> > > >      dump copy time          67.8min    6.2min
> > > >      total time              74.4min   11.7min
> > > >      dump size                 15.8G      2.7G
> > > > 
> > > >    16TB
> > > >      OS: rhel6.4
> > > >      page scan time                   125.3min
> > > >      dump copy time                    13.2min
> > > >      total time                       138.5min
> > > >      dump size                            4.0G
> > > > 
> > > >      OS: rhel6.5
> > > >      page scan time                    27.8min
> > > >      dump copy time                    13.3min
> > > >      total time                        41.1min
> > > >      dump size                            4.1G
> > > > 
> > > > Page scan time is greatly affected by whether or not the
> > > > kernel supports mmap of /proc/vmcore.
> > > > 
> > > > The choice of snappy vs. zlib compression becomes fairly irrelevant
> > > > when we can shrink the dump size dramatically.  The above
> > > > were done with snappy compression.
> > > > 
> > > > I am sending my 2 working patches.  
> > > > They are kludgy in the sense that they ignore all forms of
> > > > kdump except the creation of a disk dump, and all architectures
> > > > except x86_64.
> > > > But I think they are sufficient to demonstrate the sizable
> > > > time, crashkernel space and disk space savings that are possible.
> > > > 
> > > > _______________________________________________
> > > > kexec mailing list
> > > > kexec@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> > -- 
> > Cliff Wickman
> > SGI
> > cpw@sgi.com
> > (651) 683-3824
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec

-- 
Cliff Wickman
SGI
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
