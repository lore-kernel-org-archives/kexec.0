Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZrzb-0007AI-Rf
 for kexec@lists.infradead.org; Tue, 15 Apr 2014 01:16:56 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 990E13EE1B6
 for <kexec@lists.infradead.org>; Tue, 15 Apr 2014 10:16:30 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 86F2C45DFAE
 for <kexec@lists.infradead.org>; Tue, 15 Apr 2014 10:16:30 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.nic.fujitsu.com [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6785B45DFAC
 for <kexec@lists.infradead.org>; Tue, 15 Apr 2014 10:16:30 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5B2B11DB803B
 for <kexec@lists.infradead.org>; Tue, 15 Apr 2014 10:16:30 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 01A25E08006
 for <kexec@lists.infradead.org>; Tue, 15 Apr 2014 10:16:30 +0900 (JST)
Date: Tue, 15 Apr 2014 10:15:21 +0900 (JST)
Message-Id: <20140415.101521.297971437.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH] makedumpfile: fix a segmentation fault when pfn
 exceeds 2G boundary
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20140414103543.31935.28496.stgit@k.asiapacific.hpqcorp.net>
References: <20140414103543.31935.28496.stgit@k.asiapacific.hpqcorp.net>
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
To: jingbai.ma@hp.com
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com

From: Jingbai Ma <jingbai.ma@hp.com>
Subject: [PATCH] makedumpfile: fix a segmentation fault when pfn exceeds 2G boundary
Date: Mon, 14 Apr 2014 18:35:44 +0800

> This patch intend to fix a segmentation fault when pfn exceeds 2G boundary.
> 
> In function is_on(), if the pfn (i) is greater than 2G, it will be a negative
> value and will cause a segmentation fault.
> is_on(char *bitmap, int i)
> {
>         return bitmap[i>>3] & (1 << (i & 7));
> }
> 
> 
> Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
> ---
>  makedumpfile.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 3d270c6..03d35a8 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1591,7 +1591,7 @@ int get_xen_info_ia64(void);
>  #endif	/* s390x */
>  
>  static inline int
> -is_on(char *bitmap, int i)
> +is_on(char *bitmap, unsigned long long i)
>  {
>  	return bitmap[i>>3] & (1 << (i & 7));
>  }
> 

is_on is used at the following two places.

static inline int
is_dumpable(struct dump_bitmap *bitmap, unsigned long long pfn)
{
        off_t offset;
        if (pfn == 0 || bitmap->no_block != pfn/PFN_BUFBITMAP) {
                offset = bitmap->offset + BUFSIZE_BITMAP*(pfn/PFN_BUFBITMAP);
                lseek(bitmap->fd, offset, SEEK_SET);
                read(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP);
                if (pfn == 0)
                        bitmap->no_block = 0;
                else
                        bitmap->no_block = pfn/PFN_BUFBITMAP;
        }
        return is_on(bitmap->buf, pfn%PFN_BUFBITMAP);
}

PFN_BUFBTIMAP is constant 32 K. So, it seems that the 4 byte byte
length came here.

But right shift to signed integer is implementation defined. We should
not use right shift to signed integer. it looks gcc performs
arithmetic shift and this bahaviour is buggy in case of is_on().

static inline int
is_dumpable_cyclic(char *bitmap, unsigned long long pfn, struct cycle *cycle)
{
        if (pfn < cycle->start_pfn || cycle->end_pfn <= pfn)
                return FALSE;
        else
                return is_on(bitmap, pfn - cycle->start_pfn);
}

Simply, (pfn - cycle->start_pfn) could be (info->max_mapnr - 0). It's
possible to pass more than 2 Gi by using system with more than 8 TiB
physical memory space.

So,

- i must be unsigned in order to make right shift operation
  meaningful, and

- i must have 8 byte for systems with more than 8 TiB physical memory
  space.

BTW, to make this situation happen in cyclic mode, there needs to be
16 GiB free memory for bitmap to become large enough. I guess you
don't see this segmentation in the kdump 2nd kernel. Is this right?

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
