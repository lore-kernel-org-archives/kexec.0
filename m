Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bN5ON-0007bu-HD
 for kexec@lists.infradead.org; Tue, 12 Jul 2016 21:39:00 +0000
Date: Tue, 12 Jul 2016 23:38:35 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH 2/3] makedumpfile: Mark unstored ELF pages as filtered
Message-ID: <20160712233835.20af3622@hananiah.suse.cz>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E49B8A@BPXM01GP.gisp.nec.co.jp>
References: <20160210084737.3060fb5a@hananiah.suse.cz>
 <20160210084941.026830dc@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E44B52@BPXM01GP.gisp.nec.co.jp>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E49B8A@BPXM01GP.gisp.nec.co.jp>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

On Tue, 7 Jun 2016 04:18:48 +0000
Atsushi Kumagai <ats-kumagai@wm.jp.nec.com> wrote:

> >>+static void
> >>+exclude_nodata_pages(struct cycle *cycle)
> >>+{
> >>+	int i;
> >>+	unsigned long long phys_start, phys_end;
> >>+	off_t file_size;
> >>+
> >>+	i = 0;
> >>+	while (get_pt_load_extents(i, &phys_start, &phys_end,
> >>+				   NULL, &file_size)) {
> >>+		unsigned long long pfn, pfn_end;
> >>+
> >>+		pfn = paddr_to_pfn(phys_start + file_size);
> >>+		pfn_end = paddr_to_pfn(phys_end);
> >
> >Does this code exclude the first pfn of out of PT_LOAD even if there is
> >no unstored pages ? pfn and pfn_end will point at the next pfn to the
> >last pfn of PT_LOAD.

Indeed, phys_end is in fact the first physical address that is _not_
contained in the segment.

Good catch!

> >This will be problem for the environments which have a overlapped PT_LOAD
> >segment like ia64.

I think it's quite the opposite. Partial pages on IA64 are the only
ones that were handled correctly with the old code.

> >
> >>+		if (pfn < cycle->start_pfn)
> >>+			pfn = cycle->start_pfn;
> >>+		if (pfn_end >= cycle->end_pfn)
> >>+			pfn_end = cycle->end_pfn - 1;
> >>+		while (pfn <= pfn_end) {
> >
> >Should we change this condition to "pfn < pfn_end" ?

Better than nothing, but if the last page of a LOAD segment is not
partial, it will not be excluded. Except for partial pages, end_pfn
refers to the first PFN _after_ the current segment.

> >
> >>+			clear_bit_on_2nd_bitmap(pfn, cycle);
> >>+			++pfn;
> >>+		}
> >>+		++i;
> >>+	}
> >>+}
> 
> I fixed this as below for v1.6.0.
> Of course your comment would still be helpful.

It comes too late, I'm afraid.

In all ia64 dumps with partial pages I have seen, the full content of
the partial page is indeed stored in another segment, so the page would
be marked incorrectly. OTOH I think the off-by-one bug you fixed
affected all segments, even those without any partial pages; it would
incorrectly mark the first PFN after the segment as filtered.

The perfect solution is to round the starting PFN up instead of down to
preserve partial pages, but I'll have to think about it some more
before I can send a patch.

Thank you for your fix!

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
