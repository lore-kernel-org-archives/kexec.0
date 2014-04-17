Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WahuC-0004yX-2j
 for kexec@lists.infradead.org; Thu, 17 Apr 2014 08:42:48 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id D57B33EE19D
 for <kexec@lists.infradead.org>; Thu, 17 Apr 2014 17:42:23 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id BC74545DF83
 for <kexec@lists.infradead.org>; Thu, 17 Apr 2014 17:42:23 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 9703645DF85
 for <kexec@lists.infradead.org>; Thu, 17 Apr 2014 17:42:23 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 834C81DB8040
 for <kexec@lists.infradead.org>; Thu, 17 Apr 2014 17:42:23 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 2D4A21DB8042
 for <kexec@lists.infradead.org>; Thu, 17 Apr 2014 17:42:23 +0900 (JST)
Message-ID: <534F93DF.5090606@jp.fujitsu.com>
Date: Thu, 17 Apr 2014 17:42:07 +0900
From: "HATAYAMA, Daisuke" <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] makedumpfile: fix a segmentation fault when physical
 address exceeds 8TB boundary
References: <20140417075902.14515.26225.stgit@k.asiapacific.hpqcorp.net>
In-Reply-To: <20140417075902.14515.26225.stgit@k.asiapacific.hpqcorp.net>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jingbai Ma <jingbai.ma@hp.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com



(2014/04/17 16:59), Jingbai Ma wrote:
> This patch intends to fix a segmentation fault when physical address exceeds
> 8TB boundary.
>
> Changelog:
> v2:
> - Add more comments from Daisuke HATAYAMA.
>
>
> In function is_on(), if the physical address higher than 8T, pfn (i) will
> greater than 2G, it will be a negative value and will cause a segmentation
> fault.
> is_on(char *bitmap, int i)
> {
>          return bitmap[i>>3] & (1 << (i & 7));
> }
>
> Daisuke's detailed analysis:
> static inline int
> is_dumpable(struct dump_bitmap *bitmap, unsigned long long pfn)
> {
>          off_t offset;
>          if (pfn == 0 || bitmap->no_block != pfn/PFN_BUFBITMAP) {
>                  offset = bitmap->offset + BUFSIZE_BITMAP*(pfn/PFN_BUFBITMAP);
>                  lseek(bitmap->fd, offset, SEEK_SET);
>                  read(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP);
>                  if (pfn == 0)
>                          bitmap->no_block = 0;
>                  else
>                          bitmap->no_block = pfn/PFN_BUFBITMAP;
>          }
>          return is_on(bitmap->buf, pfn%PFN_BUFBITMAP);
> }
>
> PFN_BUFBTIMAP is constant 32 K. So, it seems that the 4 byte byte
> length came here.
>
> But right shift to signed integer is implementation defined. We should
> not use right shift to signed integer. it looks gcc performs
> arithmetic shift and this bahaviour is buggy in case of is_on().
>
> static inline int
> is_dumpable_cyclic(char *bitmap, unsigned long long pfn, struct cycle *cycle)
> {
>          if (pfn < cycle->start_pfn || cycle->end_pfn <= pfn)
>                  return FALSE;
>          else
>                  return is_on(bitmap, pfn - cycle->start_pfn);
> }
>
> Simply, (pfn - cycle->start_pfn) could be (info->max_mapnr - 0). It's

More precisely, here should have been ((info->max_mapnr - 1) - 0) since info->max_mapnr doesn't belong to target physical memory space...

> possible to pass more than 2 Gi by using system with more than 8 TiB
> physical memory space.
>
> So, in function is_on()
>
> - i must be unsigned in order to make right shift operation
>    meaningful, and
>
> - i must have 8 byte for systems with more than 8 TiB physical memory
>    space.
>
>
> Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
> ---
>   makedumpfile.h |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 3d270c6..03d35a8 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1591,7 +1591,7 @@ int get_xen_info_ia64(void);
>   #endif	/* s390x */
>
>   static inline int
> -is_on(char *bitmap, int i)
> +is_on(char *bitmap, unsigned long long i)
>   {
>   	return bitmap[i>>3] & (1 << (i & 7));
>   }
>

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
