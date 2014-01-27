Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W7bDX-0001Hi-Da
 for kexec@lists.infradead.org; Mon, 27 Jan 2014 01:42:29 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [v2 0/3] Introduce struct cycle to store cyclic region and
 clean up
Date: Mon, 27 Jan 2014 01:39:56 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971E2BFF@BPXM01GP.gisp.nec.co.jp>
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
To: Baoquan He <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>

Hello Baoquan,

On 2014/01/23 18:49:09, kexec <kexec-bounces@lists.infradead.org> wrote:
> v1->v2:
>     In first_cycle(), start_pfn assignation is not aligned to info->pfn_cyclic.
>     Now in v2 change this. Accordingly the pfn in write_elf_header() and
>     write_elf_pages_cyclic() need be adjusted to the real beginning of a
>     load segment, but not the cycle->start_pfn which may be lower after alignment.

Thanks for the self-correction, and I have another comment.

In [v2 2/3], a pfn range check is removed as below:

int
-set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val)
+set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val, struct cycle *cycle)
 {
        int byte, bit;

-       if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn <= pfn)
-               return FALSE;
-

However, "pfn" can be out of the range of cycles in the case of filtering
free pages with free_list, because we have to look up whole free_list every
cycle since free_list isn't sorted.

So this range check should be moved to reset_bitmap_of_free_pages().


Thanks
Atsushi Kumagai

> Baoquan He (3):
>   makedumpfile: introduce struct cycle to store the cyclic region
>   makedumpfile: use struct cycle to update cyclic region and clean up
>   makedumpfile: remove member variables representing cyclic pfn region
>     in struct DumpInfo
>
>  makedumpfile.c | 497 ++++++++++++++++++++++++++++-----------------------------
>  makedumpfile.h |  21 +--
>  sadump_info.c  |   4 +-
>  3 files changed, 259 insertions(+), 263 deletions(-)
>
> --
> 1.8.3.1
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
