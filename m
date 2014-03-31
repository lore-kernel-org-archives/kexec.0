Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WUYqt-0003FH-Ba
 for kexec@lists.infradead.org; Mon, 31 Mar 2014 09:50:01 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH 2/2] makedumpfile: Use max_pfn from mem_map array
Date: Mon, 31 Mar 2014 09:48:05 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971FB6BA@BPXM01GP.gisp.nec.co.jp>
References: <20140325171420.6b558576@holzheu>
 <20140326.105507.429853525.d.hatayama@jp.fujitsu.com>
 <20140326185426.5e2e5fc4@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971FA0EC@BPXM01GP.gisp.nec.co.jp>
 <20140327145441.4c956989@holzheu> <20140328120047.24a056ea@hananiah.suse.cz>
 <20140328174622.2896296e@holzheu> <20140328175303.2ed0232a@holzheu>
In-Reply-To: <20140328175303.2ed0232a@holzheu>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "ptesarik@suse.cz" <ptesarik@suse.cz>, "holzheu@linux.vnet.ibm.com" <holzheu@linux.vnet.ibm.com>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

[snip]

>> > That's because the bitmap length is calculated in prepare_bitmap_buffer
>> > using info->max_mapnr, but create_1st_bitmap() still loops over all
>> > PT_LOAD segments, calling set_bit_on_1st_bitmap() for each PFN. The
>> > offset may easily fall beyond the bitmap size.
>>
>> What about the following patch. It works for me when I specify
>> the "--non-cyclic" option.
>>
>> Michael
>> ---
>> [PATCH] makedumpfile: Fix bitmap create for adjusted info->max_mapnr
>>
>> If info->max_mapnr has been adjusted, for example because the dumped
>> system has specified the "mem=" kernel parameter, makedumpfile writes
>> the following error messages for Xen dumps or when the "--non-cyclic"
>> option has been specified:
>>
>> set_bitmap: Can't read the bitmap(/tmp/kdump_bitmap96s9V8). Success
                                                               ^^^^^^^^
This looks confusing, is it an actual message ?
I suppose it must be "Invalid argument" like Petr's log.

>>
>> Fix this and consider "info->max_mapnr" in the create bitmap functions.
>>
>> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
>> ---
>
>[snip]
>
>> @@ -7575,6 +7581,9 @@ exclude_xen4_user_domain(void)
>>  		pfn     = paddr_to_pfn(phys_start);
>>  		pfn_end = paddr_to_pfn(phys_end);
>>  		size    = pfn_end - pfn;
>> +		if (pfn > info->max_mapnr)
>> +			continue;
>> +		pfn_end = MIN(phys_end, info->max_mapnr);
>
>Hmm, probably time for weekend. Of course this should be:
>
>pfn_end = MIN(pfn_end, info->max_mapnr);
>
>Here the updated patch:

I found another issue of truncating max_mapnr for Xen.

The bitmap manages MFN(machine frame number) for Xen
while __exclude_unnecessary_pages() treats PFN(guest-physical frame number).
__exclude_unnecessary_pages() expects that all bits of PFNs
are mapped in the bitmap even if it was reduced by truncated 
max_mapnr. However, PtoM mapping isn't linear(probably...),
there is no guarantee that a set of continuous PFNs is mapped
in a set of continuous MFNs.
So the actual I/O offset can exceed the bitmap size when the
bitmap size is reduced.

In the first place, we shouldn't truncate max_mapnr
based on dom0's mem_section since there are some domU's
memories on Xen dumps. Now, I think a better way for Xen
is just leaving max_mapnr as it is.

Do you agree with my view ?


Thanks
Atsushi Kumagai

>---
>[PATCH] makedumpfile: Fix bitmap create for adjusted info->max_mapnr
>
>If info->max_mapnr has been adjusted, for example because the dumped
>system has specified the "mem=" kernel parameter, makedumpfile writes
>the following error messages for Xen dumps or when the "--non-cyclic"
>option has been specified:
>
>set_bitmap: Can't read the bitmap(/tmp/kdump_bitmap96s9V8). Success
>
>Fix this and consider "info->max_mapnr" in the create bitmap functions.
>
>Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
>---
> makedumpfile.c |    9 +++++++++
> 1 file changed, 9 insertions(+)
>
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -4402,6 +4402,9 @@ create_1st_bitmap(void)
>
> 		pfn_start = paddr_to_pfn(phys_start);
> 		pfn_end   = paddr_to_pfn(phys_end);
>+		if (pfn_start > info->max_mapnr)
>+			continue;
>+		pfn_end = MIN(pfn_end, info->max_mapnr);
>
> 		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
> 			set_bit_on_1st_bitmap(pfn);
>@@ -7511,6 +7514,9 @@ exclude_xen3_user_domain(void)
> 		pfn     = paddr_to_pfn(phys_start);
> 		pfn_end = paddr_to_pfn(phys_end);
> 		size    = pfn_end - pfn;
>+		if (pfn > info->max_mapnr)
>+			continue;
>+		pfn_end = MIN(pfn_end, info->max_mapnr);
>
> 		for (j = 0; pfn < pfn_end; pfn++, j++) {
> 			print_progress(PROGRESS_XEN_DOMAIN, j + (size * i),
>@@ -7575,6 +7581,9 @@ exclude_xen4_user_domain(void)
> 		pfn     = paddr_to_pfn(phys_start);
> 		pfn_end = paddr_to_pfn(phys_end);
> 		size    = pfn_end - pfn;
>+		if (pfn > info->max_mapnr)
>+			continue;
>+		pfn_end = MIN(pfn_end, info->max_mapnr);
>
> 		for (j = 0; pfn < pfn_end; pfn++, j++) {
> 			print_progress(PROGRESS_XEN_DOMAIN, j + (size * i),
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
