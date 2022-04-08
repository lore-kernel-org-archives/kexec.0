From: HAGIO KAZUHITO=?unknown-8bit?b?6JCp5bC+IOS4gOS7gQ==?= <k-hagio-ab@nec.com>
Date: Fri, 8 Apr 2022 03:00:45 +0000
Subject: [PATCH 2/2] makedumpfile: break loop after last dumpable page
In-Reply-To: <20220407145014.2785147a@rhtmp>
References: <20220404155050.6898-1-prudo@redhat.com>
 <20220404155050.6898-3-prudo@redhat.com>
 <TYYPR01MB6777476C26FE1B8F2E618E4FDDE69@TYYPR01MB6777.jpnprd01.prod.outlook.com>
 <20220407145014.2785147a@rhtmp>
Message-ID: <TYYPR01MB6777BD75C24DBC1A33F4308FDDE99@TYYPR01MB6777.jpnprd01.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

-----Original Message-----
> Hi Kazu,
> 
> On Thu, 7 Apr 2022 06:43:00 +0000
> HAGIO KAZUHITO(?????) <k-hagio-ab@nec.com> wrote:
> 
> > -----Original Message-----
> > > Once the last dumpable page was processed there is no need to finish the
> > > loop to the last page. Thus exit early to improve performance.
> > >
> > > Signed-off-by: Philipp Rudo <prudo@redhat.com>
> > > ---
> > >  makedumpfile.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/makedumpfile.c b/makedumpfile.c
> > > index 2ef3458..c944d0e 100644
> > > --- a/makedumpfile.c
> > > +++ b/makedumpfile.c
> > > @@ -8884,6 +8884,12 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
> > >
> > >  	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> > >
> > > +		/*
> > > +		 * All dumpable pages have been processed. No need to continue.
> > > +		 */
> > > +		if (num_dumped == info->num_dumpable)
> > > +			break;
> >
> > This patch is likely to increase the possibility of failure to capture
> > /proc/kcore, although this is an unofficial functionality...
> >
> >   # makedumpfile -ld31 /proc/kcore kcore.snap
> >   # crash vmlinux kcore.snap
> >   ...
> >   crash: page incomplete: kernel virtual address: ffff916fbeffed00  type: "pglist node_id"
> >
> > In cyclic mode, makedumpfile first calculates only info->num_dumpable [1] and
> > frees the used bitmap, and later creates 2nd bitmap again [2] at this time.
> >
> >   create_dumpfile
> >     create_dump_bitmap
> >       info->num_dumpable = get_num_dumpable_cyclic()  <<-- [1]
> >     writeout_dumpfile
> >       write_kdump_pages_and_bitmap_cyclic
> >         foreach cycle
> >           create_2nd_bitmap  <<-- [2]
> >           write_kdump_pages_cyclic
> >
> > So with live system, num_dumped can exceed info->num_dumpable.
> > If it stops at info->num_dumpable, some necessary data can be missed.
> 
> thanks for the explanation! I haven't considered that case and assumed
> info->num_dumpable is constant.
> 
> > Capturing /proc/kcore is still fragile and not considered enough, but
> > sometimes useful... when I want to capture a snapshot of memory.
> >
> > (the bitmap is allocated as block, so probably it's working as some buffer?)
> >
> > So I will merge the 1/2 patch, but personally would not like to merge
> > this patch.  How necessary is this?
> 
> I don't think this patch is absolutely necessary. It's only a small
> performance improvement but shouldn't have a huge impact. If you like
> you can drop the patch.

ok, drop it at present.

Applied the 1/2 patch.
https://github.com/makedumpfile/makedumpfile/commit/3318c51c3c60ed192519cef6f6e72178151f88a8

Thanks!
Kazu


