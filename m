Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wahf2-0008Sd-Kv
 for kexec@lists.infradead.org; Thu, 17 Apr 2014 08:27:09 +0000
Date: Thu, 17 Apr 2014 10:26:16 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v2] makedumpfile: fix a segmentation fault when physical
 address exceeds 8TB boundary
Message-ID: <20140417102616.628ca505@hananiah.suse.cz>
In-Reply-To: <20140417075902.14515.26225.stgit@k.asiapacific.hpqcorp.net>
References: <20140417075902.14515.26225.stgit@k.asiapacific.hpqcorp.net>
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
To: Jingbai Ma <jingbai.ma@hp.com>
Cc: kexec@lists.infradead.org, d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com

On Thu, 17 Apr 2014 15:59:02 +0800
Jingbai Ma <jingbai.ma@hp.com> wrote:

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
>         return bitmap[i>>3] & (1 << (i & 7));
> }
> 
> Daisuke's detailed analysis:
> static inline int
> is_dumpable(struct dump_bitmap *bitmap, unsigned long long pfn)
> {
>         off_t offset;
>         if (pfn == 0 || bitmap->no_block != pfn/PFN_BUFBITMAP) {
>                 offset = bitmap->offset + BUFSIZE_BITMAP*(pfn/PFN_BUFBITMAP);
>                 lseek(bitmap->fd, offset, SEEK_SET);
>                 read(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP);
>                 if (pfn == 0)
>                         bitmap->no_block = 0;
>                 else
>                         bitmap->no_block = pfn/PFN_BUFBITMAP;
>         }
>         return is_on(bitmap->buf, pfn%PFN_BUFBITMAP);
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
>         if (pfn < cycle->start_pfn || cycle->end_pfn <= pfn)
>                 return FALSE;
>         else
>                 return is_on(bitmap, pfn - cycle->start_pfn);
> }
> 
> Simply, (pfn - cycle->start_pfn) could be (info->max_mapnr - 0). It's
> possible to pass more than 2 Gi by using system with more than 8 TiB
> physical memory space.
> 
> So, in function is_on()
> 
> - i must be unsigned in order to make right shift operation
>   meaningful, and
> 
> - i must have 8 byte for systems with more than 8 TiB physical memory
>   space.

While the patch is correct, the explanation is not precise, because it
does not explain why an unsigned long is not sufficient. In fact, it
would be enough on 64-bit systems, where an unsigned long is just as big
as an unsigned long long (both 64 bits). But on 32-bit systems, an
unsigned long is 32-bit, but physical memory can be larger (e.g. 36
bits with PAE).

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
