Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.171.30] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KicLm-0007VG-6B
	for kexec@lists.infradead.org; Wed, 24 Sep 2008 21:56:46 +0000
Message-ID: <48DAB79C.9050601@sgi.com>
Date: Wed, 24 Sep 2008 14:56:44 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: the exiting makedumpfile is almost there... :)
References: <48C85836.8080606@sgi.com>
	<20080911143226.GT29908@sgi.com>	<48C9D22A.5010404@mxs.nes.nec.co.jp>
	<48CA70CD.2090500@sgi.com>	<48CAC7DB.4090904@sgi.com>
	<48CAD340.7000701@redhat.com>	<48CAEB6A.8080405@sgi.com>
	<48D77E05.30504@mxs.nes.nec.co.jp> <48D90E13.3040202@redhat.com>
	<48D99351.7090804@mxs.nes.nec.co.jp> <48DA8738.2090207@sgi.com>
In-Reply-To: <48DA8738.2090207@sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0171143768=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Hedi Berriche <hedi@sgi.com>

--===============0171143768==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Jay Lan wrote:
> Ken'ichi Ohmichi wrote:
>> Hi Dave, Jay,
>>
>> Dave Anderson wrote:
>>> We just ran into a similar problem using an older version of makedumpfile,
>>> but looking at the latest makedumpfile code, it's seems that you could
>>> run into the same problem.
>>>
>>> In exclude_unnecessary_pages(), if a physical page is in a memory
>>> hole, then it skips the page and continues.  In our case, that happened,
>>> but when it started up again, the next legitimate pfn was well beyond
>>> the previously-read cache of 512 pages.  But since the new legit page
>>> wasn't modulo-512, it didn't refresh the page cache, and it ended up
>>> using stale page data (page->flags) and ended up excluding legitimate
>>> pages:
>>>
>>>                 for (; pfn < mmd->pfn_end;
>>>                     pfn++, mem_map += SIZE(page),
>>>                     paddr += info->page_size) {
>>>
>>>                         /*
>>>                          * Exclude the memory hole.
>>>                          */
>>>                         if (!is_in_segs(paddr))
>>>                                 continue;
>>>
>>>                         if ((pfn % PGMM_CACHED) == 0) {
>>>                                 if (pfn + PGMM_CACHED < mmd->pfn_end)
>>>                                         pfn_mm = PGMM_CACHED;
>>>                                 else
>>>                                         pfn_mm = mmd->pfn_end - pfn;
>>>                                 if (!readmem(VADDR, mem_map, page_cache,
>>>                                     SIZE(page) * pfn_mm))
>>>                                         goto out;
>>>                         }
>>>
>>> We fixed it by doing something like this:
>>>
>>>          if (!is_in_segs(paddr)) {
>>>                  reset_cache = 1;
>>>                  continue;
>>>          }
>>>
>>>          if (((pfn % PGMM_CACHED) == 0) || reset_cache) {
>>>                  reset_cache = 0;
>>>                  ...
>> Great, you are right.
>> Thank you for fixing it  :-) 
>>
>> Jay, could you try Dave's fixing like the attached patch ?
> 
> Yes. I applied your version of Dave's patch and tried again.
> It failed at a different pfn f600315:
> 
> 
> a4700rac:/mnt/sda9/diskdump # rm dump.cd31; /var/tmp/jlan/makedumpfile
> -cd31 -e 0xe0000f60031502f0 -x vmlinux.3 vmcore-cp.3 dump.cd31
> Excluding unnecessary pages        : [ 45 %]
> pfn=f600315 flags=3c000000001026c
> 
> PAGE(vaddr:e0000f60031502f0, pfn:f600315) is excluded as CACHE PAGE.
> 
> Copying data                       : [100 %]
> 
> The dumpfile is saved to dump.cd31.
> 
> makedumpfile Completed.
> 
> 
> Note the flags of pfn f600315. Crash checked on the pfn using the
> vmcore-cp.3 and showed different flags:
> 
> crash> kmem -p f60031502f0
>       PAGE         PHYSICAL      MAPPING       INDEX CNT FLAGS
> a07ffffc45d00498 f6003150000                0        0  1 3c0000000000400
> crash>
> 

I ran a testing on a 2-cpu  machine. The legitimate page got excluded
is:
   PAGE(vaddr:e00000300313fb70, pfn:300313) is excluded as CACHE PAGE

Values of some variables in the routine on processing that page are:
  pfn=300313 flags=3026c, page.flags=0
  page_cache=0x6000000000033f60, pcache=0x6000000000037b88

Hope these data help.

Thanks,
 - jay


>    
>>
>> Thanks
>> Ken'ichi Ohmichi
>>
> 



--===============0171143768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0171143768==--
