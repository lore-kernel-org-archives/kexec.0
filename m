From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Mon, 11 Apr 2022 07:33:02 +0200
Subject: [PATCH v2 1/1] check that order of free pages falls within
 valid range
In-Reply-To: <TYYPR01MB67772D95131EB619CFFE897CDDEA9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <20220408085259.184465-1-egorenar@linux.ibm.com>
 <87bkxbg0pn.fsf@oc8242746057.ibm.com>
 <TYYPR01MB67772D95131EB619CFFE897CDDEA9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
Message-ID: <87bkx8tca9.fsf@oc8242746057.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org


Hi Kazu,

HAGIO KAZUHITO(?????)	<k-hagio-ab@nec.com> writes:

> Hi Alex,
>
> thanks for the patch,
>
> -----Original Message-----
>> Alexander Egorenkov <egorenar@linux.ibm.com> writes:
>> 
>> > This change makes __exclude_unnecessary_pages() more robust by
>> > verifying that the order of a free page is valid before computing the size
>> > of its memory block in the buddy system.
>> >
>> > The order of a free page cannot be larger than (MAX_ORDER - 1) because
>> > the array 'zone.free_area' is of size MAX_ORDER.
>> >
>> > This situation is reproducible with some s390x dumps:
>> >
>> > __exclude_unnecessary_pages: Invalid free page order: pfn=2690c0, order=52, max order=8
>> >
>> > References:
>> > - https://listman.redhat.com/archives/crash-utility/2021-September/009204.html
>> > - https://www.kernel.org/doc/gorman/html/understand/understand009.html
>> >
>> > Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
>> > ---
>> >  makedumpfile.c | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/makedumpfile.c b/makedumpfile.c
>> > index 2ef345879524..56aa026e7b34 100644
>> > --- a/makedumpfile.c
>> > +++ b/makedumpfile.c
>> > @@ -6457,6 +6457,12 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>> >  		else if ((info->dump_level & DL_EXCLUDE_FREE)
>> >  		    && info->page_is_buddy
>> >  		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
>> > +			if (private >= ARRAY_LENGTH(zone.free_area)) {
>> > +				ERRMSG("Invalid free page order: pfn=%llx, order=%lu, max order=%lu\n",
>> > +				       pfn, private, ARRAY_LENGTH(zone.free_area) - 1);
>> > +				free(page_cache);
>> > +				return FALSE;
>> > +			}
>> >  			nr_pages = 1 << private;
>> >  			pfn_counter = &pfn_free;
>> >  		}
>> > --
>> > 2.34.1
>> >
>> >
>> > _______________________________________________
>> > kexec mailing list
>> > kexec at lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/kexec
>> 
>> I found out when this can happen.
>> 
>> If e.g. a driver calls free_pages() and gives an order > max page order,
>> then __free_one_page() stores the given invalid page order in the
>> 'private' member of struct page and gives it back to the buddy
>> allocator.
>> 
>> This is what actually happened in the dump i used to reproduce this issue
>> with makedumpfile.
>
> Good catch, though I could not reproduce it so far..
>
> but I wonder whether we have no other choice than returning FALSE?
> in other words, can't we skip (include) the invalid page with a
> warning message?
>
> As I said before, I think that capturing more pages than expected
> will be better than not capturing a dump, and that is "robust"
> against unexpected values.

I chose failing to an recover attempt because i was not sure
that it won't have negative effects on other pages.
Your suggestion is replacing ERRMSG with a warning and then just
continue ? I can rework the patch.

Thanks
Regards
Alex

