Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dY6PX-0005nA-B8
 for kexec@lists.infradead.org; Thu, 20 Jul 2017 08:02:17 +0000
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local
 (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
 by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id A0B9CAC0184
 for <kexec@lists.infradead.org>; Thu, 20 Jul 2017 17:01:42 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [Makedumpfile Patch v3 2/7] initial(): call cach_init() a bit
 early
Date: Thu, 20 Jul 2017 08:01:40 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20D32CF98@G01JPEXMBYT03>
References: <cover.1488443170.git.panand@redhat.com>
 <5121b3b3857e3f5710195b4983d7261549ef7fac.1488443170.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EF24AA@BPXM01GP.gisp.nec.co.jp>
 <1d801fe9-bc5e-3783-1dca-40a47ddeccc9@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EF2947@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EF2947@BPXM01GP.gisp.nec.co.jp>
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
To: 'Atsushi Kumagai' <ats-kumagai@wm.jp.nec.com>, Pratyush Anand <panand@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "dyoung@redhat.com" <dyoung@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>



> -----Original Message-----
> From: Atsushi Kumagai [mailto:ats-kumagai@wm.jp.nec.com]
> Sent: Thursday, July 20, 2017 3:54 PM
> To: Pratyush Anand <panand@redhat.com>
> Cc: dyoung@redhat.com; Hatayama, Daisuke
> <d.hatayama@jp.fujitsu.com>; kexec@lists.infradead.org; bhe@redhat.com
> Subject: RE: [Makedumpfile Patch v3 2/7] initial(): call cach_init() a bit
> early
> 
> >Hi Atsushi,
> >
> >On Wednesday 19 July 2017 01:16 PM, Atsushi Kumagai wrote:
> >> Hello Pratyush,
> >>
> >>> Call cach_init() before get_kcore_dump_loads(), because latter uses
> >>> cache_search().
> >>>
> >>> Call path is like this :
> >>> get_kcore_dump_loads() -> process_dump_load() -> vaddr_to_paddr() ->
> >>> vtop4_x86_64() -> readmem() -> cache_search()
> >>
> >> I found that the current cach_init() is too early, cache_init() should be
> >> called after fallback_to_current_page_size() for older kernel
> >> which doesn't have VMCOREINFO.
> >> Could you confirm that the patch below is fine with you ?
> >
> >Its fine and works.
> 
> Thanks, I'll merge this fix into v1.6.2.
> 

It looks good also to me.

Thanks.
HATAYAMA, Daisuke

> Regards,
> Atsushi Kumagai
> 
> >>
> >> Thanks,
> >> Atsushi Kumagai
> >>
> >> From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
> >> Date: Wed, 19 Jul 2017 15:05:58 +0900
> >> Subject: [PATCH] Fix the regression caused by moving cache_init() earlier
> >>
> >> info->page_size should be set before calling cache_init() since it
> >> allocates some buffers based on info->page_size. However, cache_init()
> >> was moved before fallback_to_current_page_size() while it set
> >> info->page_size for older kernel which doesn't have VMCOREINFO.
> >>
> >> This patch moves cache_init() after fallback_to_current_page_size()
> >> and reverts the commit: b98e6e0d2a(sadump: set info->page_size before
> cache_init())
> >>
> >> Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
> >> ---
> >>  makedumpfile.c | 28 ++++++++++++++++------------
> >>  1 file changed, 16 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/makedumpfile.c b/makedumpfile.c
> >> index a3f0697..f85003a 100644
> >> --- a/makedumpfile.c
> >> +++ b/makedumpfile.c
> >> @@ -3905,15 +3905,6 @@ initial(void)
> >>  	if (!get_value_for_old_linux())
> >>  		return FALSE;
> >>
> >> -	if (info->flag_sadump && !set_page_size(sadump_page_size()))
> >> -			return FALSE;
> >> -
> >> -	if (!is_xen_memory() && !cache_init())
> >> -		return FALSE;
> >> -
> >> -	if (info->flag_mem_usage && !get_kcore_dump_loads())
> >> -		return FALSE;
> >> -
> >>  	if (info->flag_refiltering) {
> >>  		if (info->flag_elf_dumpfile) {
> >>  			MSG("'-E' option is disable, ");
> >> @@ -3936,6 +3927,9 @@ initial(void)
> >>  			return FALSE;
> >>  		}
> >>
> >> +		if (!set_page_size(sadump_page_size()))
> >> +			return FALSE;
> >> +
> >>  		if (!sadump_initialize_bitmap_memory())
> >>  			return FALSE;
> >>
> >> @@ -3949,9 +3943,7 @@ initial(void)
> >>  		 * postponed until debug information becomes
> >>  		 * available.
> >>  		 */
> >> -
> >> -	} else if (!get_phys_base())
> >> -		return FALSE;
> >> +	}
> >>
> >>  out:
> >>  	if (!info->page_size) {
> >> @@ -3962,6 +3954,18 @@ out:
> >>  		if (!fallback_to_current_page_size())
> >>  			return FALSE;
> >>  	}
> >> +
> >> +	if (!is_xen_memory() && !cache_init())
> >> +		return FALSE;
> >> +
> >> +	if (info->flag_mem_usage && !get_kcore_dump_loads())
> >> +		return FALSE;
> >> +
> >> +	if (!info->flag_refiltering && !info->flag_sadump) {
> >> +		if (!get_phys_base())
> >> +			return FALSE;
> >> +	}
> >> +
> >>  	if (!get_max_mapnr())
> >>  		return FALSE;
> >>
> >>
> >
> >--
> >Regards
> >Pratyush
> 
> 
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
