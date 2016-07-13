Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNFCB-0007Gm-GI
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 08:07:05 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 2/3] makedumpfile: Mark unstored ELF pages as filtered
Date: Wed, 13 Jul 2016 07:43:13 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E54DB1@BPXM01GP.gisp.nec.co.jp>
References: <20160210084737.3060fb5a@hananiah.suse.cz>
 <20160210084941.026830dc@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E44B52@BPXM01GP.gisp.nec.co.jp>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E49B8A@BPXM01GP.gisp.nec.co.jp>
 <20160712233835.20af3622@hananiah.suse.cz>
In-Reply-To: <20160712233835.20af3622@hananiah.suse.cz>
Content-Language: ja-JP
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
To: "ptesarik@suse.cz" <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Petr,

I'm happy to get your reply.

>On Tue, 7 Jun 2016 04:18:48 +0000
>Atsushi Kumagai <ats-kumagai@wm.jp.nec.com> wrote:
>
>> >>+static void
>> >>+exclude_nodata_pages(struct cycle *cycle)
>> >>+{
>> >>+	int i;
>> >>+	unsigned long long phys_start, phys_end;
>> >>+	off_t file_size;
>> >>+
>> >>+	i = 0;
>> >>+	while (get_pt_load_extents(i, &phys_start, &phys_end,
>> >>+				   NULL, &file_size)) {
>> >>+		unsigned long long pfn, pfn_end;
>> >>+
>> >>+		pfn = paddr_to_pfn(phys_start + file_size);
>> >>+		pfn_end = paddr_to_pfn(phys_end);
>> >
>> >Does this code exclude the first pfn of out of PT_LOAD even if there is
>> >no unstored pages ? pfn and pfn_end will point at the next pfn to the
>> >last pfn of PT_LOAD.
>
>Indeed, phys_end is in fact the first physical address that is _not_
>contained in the segment.
>
>Good catch!
>
>> >This will be problem for the environments which have a overlapped PT_LOAD
>> >segment like ia64.
>
>I think it's quite the opposite. Partial pages on IA64 are the only
>ones that were handled correctly with the old code.

I didn't take care partial pages, just considered the case below:

   pfn             1   2   3   4   5   6   7
------------------------------------------------
PT_LAOD(1)       |---+---+---+---|
PT_LAOD(2)               |---+---+---+---|

During checking PT_LOAD(1), the bit of pfn:5 will be dropped if
mem_size equals file_size, but practically the pfn is an used page
as PT_LAOD(2) shows.
If there is only PT_LOAD(1), pfn:5 must be on hole and the actual
harm doesn't occur.

>> >
>> >>+		if (pfn < cycle->start_pfn)
>> >>+			pfn = cycle->start_pfn;
>> >>+		if (pfn_end >= cycle->end_pfn)
>> >>+			pfn_end = cycle->end_pfn - 1;
>> >>+		while (pfn <= pfn_end) {
>> >
>> >Should we change this condition to "pfn < pfn_end" ?
>
>Better than nothing, but if the last page of a LOAD segment is not
>partial, it will not be excluded. Except for partial pages, end_pfn
>refers to the first PFN _after_ the current segment.

If mem_size equals file_size, the last page of a LOAD also shouldn't
be removed. However, the condition of "pfn <= pfn_end" can remove it
since end_pfn refers to the first PFN _after_ the current segment.
I just fixed it.

>> >
>> >>+			clear_bit_on_2nd_bitmap(pfn, cycle);
>> >>+			++pfn;
>> >>+		}
>> >>+		++i;
>> >>+	}
>> >>+}
>>
>> I fixed this as below for v1.6.0.
>> Of course your comment would still be helpful.
>
>It comes too late, I'm afraid.
>
>In all ia64 dumps with partial pages I have seen, the full content of
>the partial page is indeed stored in another segment, so the page would
>be marked incorrectly. OTOH I think the off-by-one bug you fixed
>affected all segments, even those without any partial pages; it would
>incorrectly mark the first PFN after the segment as filtered.
>
>The perfect solution is to round the starting PFN up instead of down to
>preserve partial pages, but I'll have to think about it some more
>before I can send a patch.

Again, I didn't consider partial page cases, I also should reconsider this.
Thank you for pointing it out.


Regards,
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
