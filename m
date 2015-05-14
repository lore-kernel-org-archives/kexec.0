Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YsheJ-00087l-QJ
 for kexec@lists.infradead.org; Thu, 14 May 2015 01:09:21 +0000
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by yt-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6B5E8AC0552
 for <kexec@lists.infradead.org>; Thu, 14 May 2015 10:08:53 +0900 (JST)
Date: Thu, 14 May 2015 10:08:43 +0900 (JST)
Message-Id: <20150514.100843.320775105.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH 0/13] makedumpfile: Avoid two pass filtering by using
 bitmap file.
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701DAB6F8@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9701DAA325@BPXM01GP.gisp.nec.co.jp>
 <20150512.172035.461774614.d.hatayama@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DAB6F8@BPXM01GP.gisp.nec.co.jp>
Mime-Version: 1.0
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
To: ats-kumagai@wm.jp.nec.com
Cc: kexec@lists.infradead.org

From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 0/13] makedumpfile: Avoid two pass filtering by using bitmap file.
Date: Wed, 13 May 2015 08:04:27 +0000

>>> cyclic mode has to take a two-pass approach for filtering to save on the
>>> memory consumption, it's a disadvantage of the cyclic mode and it's basically
>>> unavoidable. However, even the cyclic mode can avoid two-pass filtering if free
>>> memory space is enough to store the whole 1st and 2nd bitmaps, but the current
>>> version doesn't it.
>>> The main purpose of this patch set is avoiding that useless filtering,
>>> but before that, I merged non-cyclic mode into cyclic mode as code clean up
>>> because the codes are almost the same. Instead, I introduce another way to
>>> guarantee one-pass filtering by using disk space.
>>>
>>
>>How about compromising progress information to some extent? The first
>>pass is intended to count up the exact number of dumpable pages just
>>to provide precise progress information. Is such prcision really
>>needed?
> 
> The first pass counts up the num_dumpable *to calculate the offset of
> starting page data region in advance*, otherwise makedumpfile can't start
> to write page data except create a sparse file. 
> 
>    7330 write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>    7331 {
>    7332         struct page_desc pd_zero;
>    7333         off_t offset_data=0;
>    7334         struct disk_dump_header *dh = info->dump_header;
>    7335         unsigned char buf[info->page_size];
>    7336         struct timeval tv_start;
>    7337
>    7338         /*
>    7339          * Reset counter for debug message.
>    7340          */
>    7341         pfn_zero = pfn_cache = pfn_cache_private = 0;
>    7342         pfn_user = pfn_free = pfn_hwpoison = 0;
>    7343         pfn_memhole = info->max_mapnr;
>    7344
>    7345         cd_header->offset
>    7346                 = (DISKDUMP_HEADER_BLOCKS + dh->sub_hdr_size + dh->bitmap_blocks)
>    7347                 * dh->block_size;
>    7348         cd_page->offset = cd_header->offset + sizeof(page_desc_t)*info->num_dumpable;
>    7349         offset_data = cd_page->offset;                                  ^^^^^^^^^^^^
> 
> 

I overlooked this, sorry.

Size of page description header is 24 bytes. This corresponds to 6 GB
per 1 TB. Can this become a big problem? Of course, I think it odd
that page description table could be larger than memory data part.

There's another aproach: construct the page description table at each
cycle separately over a dump file and connect them by a linked list.

This changes dump format and needs to add crash utility support; no
compatibility to current crash utility.

>>For example, how about another simple progress information:
>>
>>   pfn / max_mapnr
>>
>>where pfn is the number of a page frame that is currently
>>processed. We know max_mapnr from the beginning, so this is possible
>>within one pass. It's less precise but might be precise enough.
> 
> I also think it's enough for progress information, but anyway the 1st
> pass is necessary as above.
> 
> 
> Thanks
> Atsushi Kumagai
--
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
