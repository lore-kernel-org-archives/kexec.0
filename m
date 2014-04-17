Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WaeNa-00049Z-4E
 for kexec@lists.infradead.org; Thu, 17 Apr 2014 04:56:54 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: fix a segmentation fault when pfn exceeds
 2G boundary
Date: Thu, 17 Apr 2014 04:53:35 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE972049D1@BPXM01GP.gisp.nec.co.jp>
References: <20140414103543.31935.28496.stgit@k.asiapacific.hpqcorp.net>
 <20140415.101521.297971437.d.hatayama@jp.fujitsu.com>
 <20140415.170728.404561140.d.hatayama@jp.fujitsu.com>
 <534D0ADA.1060906@hp.com>
In-Reply-To: <534D0ADA.1060906@hp.com>
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
To: "jingbai.ma@hp.com" <jingbai.ma@hp.com>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "lisa.mitchell@hp.com" <lisa.mitchell@hp.com>

>>>> This patch intend to fix a segmentation fault when pfn exceeds 2G boundary.
>>>>
>>>> In function is_on(), if the pfn (i) is greater than 2G, it will be a negative
>>>> value and will cause a segmentation fault.
>>>> is_on(char *bitmap, int i)
>>>> {
>>>>          return bitmap[i>>3] & (1 << (i & 7));
>>>> }
>>>>
>>>>
>>>> Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
>>>> ---
>>>>   makedumpfile.h |    2 +-
>>>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/makedumpfile.h b/makedumpfile.h
>>>> index 3d270c6..03d35a8 100644
>>>> --- a/makedumpfile.h
>>>> +++ b/makedumpfile.h
>>>> @@ -1591,7 +1591,7 @@ int get_xen_info_ia64(void);
>>>>   #endif	/* s390x */
>>>>
>>>>   static inline int
>>>> -is_on(char *bitmap, int i)
>>>> +is_on(char *bitmap, unsigned long long i)
>>>>   {
>>>>   	return bitmap[i>>3] & (1 << (i & 7));
>>>>   }
>>>>
>>>
>>> is_on is used at the following two places.
>>>
>>> static inline int
>>> is_dumpable(struct dump_bitmap *bitmap, unsigned long long pfn)
>>> {
>>>          off_t offset;
>>>          if (pfn == 0 || bitmap->no_block != pfn/PFN_BUFBITMAP) {
>>>                  offset = bitmap->offset + BUFSIZE_BITMAP*(pfn/PFN_BUFBITMAP);
>>>                  lseek(bitmap->fd, offset, SEEK_SET);
>>>                  read(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP);
>>>                  if (pfn == 0)
>>>                          bitmap->no_block = 0;
>>>                  else
>>>                          bitmap->no_block = pfn/PFN_BUFBITMAP;
>>>          }
>>>          return is_on(bitmap->buf, pfn%PFN_BUFBITMAP);
>>> }
>>>
>>> PFN_BUFBTIMAP is constant 32 K. So, it seems that the 4 byte byte
>>> length came here.
>>>
>>> But right shift to signed integer is implementation defined. We should
>>> not use right shift to signed integer. it looks gcc performs
>>> arithmetic shift and this bahaviour is buggy in case of is_on().
>>>
>>> static inline int
>>> is_dumpable_cyclic(char *bitmap, unsigned long long pfn, struct cycle *cycle)
>>> {
>>>          if (pfn < cycle->start_pfn || cycle->end_pfn <= pfn)
>>>                  return FALSE;
>>>          else
>>>                  return is_on(bitmap, pfn - cycle->start_pfn);
>>> }
>>>
>>> Simply, (pfn - cycle->start_pfn) could be (info->max_mapnr - 0). It's
>>> possible to pass more than 2 Gi by using system with more than 8 TiB
>>> physical memory space.
>>>
>>> So,
>>>
>>> - i must be unsigned in order to make right shift operation
>>>    meaningful, and
>>>
>>> - i must have 8 byte for systems with more than 8 TiB physical memory
>>>    space.
>>>
>
>Yes, all your comments are correct. :)
>So would you like I send out a v2 patch with all your comments in it?

I'd like to merge this patch into v1.5.6 since it's a critical issue,
so could you send the v2 patch?


Thanks
Atsushi Kumagai

>>> BTW, to make this situation happen in cyclic mode, there needs to be
>>> 16 GiB free memory for bitmap to become large enough. I guess you
>>> don't see this segmentation in the kdump 2nd kernel. Is this right?
>>>
>>
>> This is my terrible careless miss... 256 MiB is correct. 16 GiB is
>> obviously too large. Then, the amount seems typical.
>>
>
>Correct, 2G >> 3 = 256M.
>
>
>> Thanks.
>> HATAYAMA, Daisuke
>>
>
>
>--
>Thanks,
>Jingbai Ma
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
