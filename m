Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bA8Zi-000091-UV
 for kexec@lists.infradead.org; Tue, 07 Jun 2016 04:25:12 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 2/3] makedumpfile: Mark unstored ELF pages as filtered
Date: Tue, 7 Jun 2016 04:18:48 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E49B8A@BPXM01GP.gisp.nec.co.jp>
References: <20160210084737.3060fb5a@hananiah.suse.cz>
 <20160210084941.026830dc@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E44B52@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E44B52@BPXM01GP.gisp.nec.co.jp>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec mailing list <kexec@lists.infradead.org>

>>+static void
>>+exclude_nodata_pages(struct cycle *cycle)
>>+{
>>+	int i;
>>+	unsigned long long phys_start, phys_end;
>>+	off_t file_size;
>>+
>>+	i = 0;
>>+	while (get_pt_load_extents(i, &phys_start, &phys_end,
>>+				   NULL, &file_size)) {
>>+		unsigned long long pfn, pfn_end;
>>+
>>+		pfn = paddr_to_pfn(phys_start + file_size);
>>+		pfn_end = paddr_to_pfn(phys_end);
>
>Does this code exclude the first pfn of out of PT_LOAD even if there is
>no unstored pages ? pfn and pfn_end will point at the next pfn to the
>last pfn of PT_LOAD.
>This will be problem for the environments which have a overlapped PT_LOAD
>segment like ia64.
>
>>+		if (pfn < cycle->start_pfn)
>>+			pfn = cycle->start_pfn;
>>+		if (pfn_end >= cycle->end_pfn)
>>+			pfn_end = cycle->end_pfn - 1;
>>+		while (pfn <= pfn_end) {
>
>Should we change this condition to "pfn < pfn_end" ?
>
>>+			clear_bit_on_2nd_bitmap(pfn, cycle);
>>+			++pfn;
>>+		}
>>+		++i;
>>+	}
>>+}

I fixed this as below for v1.6.0.
Of course your comment would still be helpful.

--
Author: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Date:   Thu May 26 15:17:25 2016 +0900

    [PATCH] Fix boundary value bug for checking memory holes

    Now the next pfn to the last pfn of PT_LOAD is always excluded
    by boundary value bug.

         --------- PT_LOAD ----------|
         ----+-----------------------+---------------------+----
             |         pfn:N         |       pfn:N+1       | ...
         ----+-----------------------+---------------------+----
                                              ^ this pfn

    This will be problem in the environments which have a overlapped
    PT_LOAD segment like ia64 because the pfn excluded by this bug
    can be included in another PT_LOAD.

    Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>

diff --git a/makedumpfile.c b/makedumpfile.c
index 4f17686..8a80976 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4449,7 +4449,7 @@ exclude_nodata_pages(struct cycle *cycle)
                        pfn = cycle->start_pfn;
                if (pfn_end >= cycle->end_pfn)
                        pfn_end = cycle->end_pfn - 1;
-               while (pfn <= pfn_end) {
+               while (pfn < pfn_end) {
                        clear_bit_on_2nd_bitmap(pfn, cycle);
                        ++pfn;
                }

Thanks,
Atsushi Kumagai

>
>Thanks,
>Atsushi Kumagai
>
>>+
>> int
>> read_flat_data_header(struct makedumpfile_data_header *fdh)
>> {
>>@@ -6087,6 +6113,12 @@ create_2nd_bitmap(struct cycle *cycle)
>> 	}
>>
>> 	/*
>>+	 * If re-filtering ELF dump, exclude pages that were already
>>+	 * excluded in the original file.
>>+	 */
>>+	exclude_nodata_pages(cycle);
>>+
>>+	/*
>> 	 * Exclude cache pages, cache private pages, user data pages,
>> 	 * and hwpoison pages.
>> 	 */
>>
>>_______________________________________________
>>kexec mailing list
>>kexec@lists.infradead.org
>>http://lists.infradead.org/mailman/listinfo/kexec
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
