Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VtoaS-0002Vd-1G
 for kexec@lists.infradead.org; Fri, 20 Dec 2013 01:09:09 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 712B33EE1E2
 for <kexec@lists.infradead.org>; Fri, 20 Dec 2013 10:08:38 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 63CBF45DD76
 for <kexec@lists.infradead.org>; Fri, 20 Dec 2013 10:08:38 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 454DC45DE4E
 for <kexec@lists.infradead.org>; Fri, 20 Dec 2013 10:08:38 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 0AB5BE3800B
 for <kexec@lists.infradead.org>; Fri, 20 Dec 2013 10:08:38 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7B6AC1DB8037
 for <kexec@lists.infradead.org>; Fri, 20 Dec 2013 10:08:37 +0900 (JST)
Message-ID: <52B39878.3030403@jp.fujitsu.com>
Date: Fri, 20 Dec 2013 10:08:08 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: memset() in cyclic bitmap initialization
 introduce segment fault
References: <20131218133402.GA23617@dhcp-17-89.nay.redhat.com>
In-Reply-To: <20131218133402.GA23617@dhcp-17-89.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: WANG Chao <chaowang@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org

(2013/12/18 22:34), WANG Chao wrote:
> We are using memset() to improve performance when creating 1st and 2nd
> bitmap. After doing round up the pfn_start and round down pfn_end, it's
> possible that pfn_start_roundup is greater than pfn_end_round. A segment
> fault could happen in that case because memset is taking roughly the
> value of (pfn_end_round << 3 - pfn_start_roundup << 3 ), which is
> negative, as its third argument.
>
> So we can skip the memset if start is greater than end. It's safe
> because we will set bit for the round up part and also round down part.
>
> Actually this happens on my EFI virtual machine:
>
> cat /proc/iomem:
> 00000000-00000fff : reserved
> 00001000-0009ffff : System RAM
> 000a0000-000bffff : PCI Bus 0000:00
> 000f0000-000fffff : System ROM
> 00100000-3d162017 : System RAM
>    01000000-015cab9b : Kernel code
>    015cab9c-019beb3f : Kernel data
>    01b4f000-01da9fff : Kernel bss
>    30000000-37ffffff : Crash kernel
> 3d162018-3d171e57 : System RAM
> 3d171e58-3d172017 : System RAM
> 3d172018-3d17ae57 : System RAM
> 3d17ae58-3dc10fff : System RAM
> 3dc11000-3dc18fff : reserved
> 3dc19000-3dc41fff : System RAM
> 3dc42000-3ddcefff : reserved
> 3ddcf000-3f7fefff : System RAM
> 3f7ff000-3f856fff : reserved
> [..]
>
> gdb ./makedumpfile core
> (gdb) bt full
> [..]
>   #1  0x000000000042775d in create_1st_bitmap_cyclic () at makedumpfile.c:4543
>          i = 0x5
>          pfn = 0x3d190
>          phys_start = 0x3d18ee58
>          phys_end = 0x3d18f018
>          pfn_start = 0x3d18e
>          pfn_end = 0x3d18f
>          pfn_start_roundup = 0x3d190
>          pfn_end_round = 0x3d188
>          pfn_start_byte = 0x7a32
>          pfn_end_byte = 0x7a31
> [..]
> (gdb) list makedumpfile.c:4543
> 4538					return FALSE;
> 4539
> 4540			pfn_start_byte = (pfn_start_roundup - info->cyclic_start_pfn) >> 3;
> 4541			pfn_end_byte = (pfn_end_round - info->cyclic_start_pfn) >> 3;
> 4542
> 4543			memset(info->partial_bitmap2 + pfn_start_byte,
> 4544			       0xff,
> 4545			       pfn_end_byte - pfn_start_byte);
> 4546
> 4547			for (pfn = pfn_end_round; pfn < pfn_end; ++pfn)
>
> Signed-off-by: WANG Chao <chaowang@redhat.com>
> ---
>   makedumpfile.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 23251a1..ef08d91 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -4435,11 +4435,13 @@ create_1st_bitmap_cyclic()
>   		pfn_start_byte = (pfn_start_roundup - info->cyclic_start_pfn) >> 3;
>   		pfn_end_byte = (pfn_end_round - info->cyclic_start_pfn) >> 3;
>
> -		memset(info->partial_bitmap1 + pfn_start_byte,
> -		       0xff,
> -		       pfn_end_byte - pfn_start_byte);
> +		if (pfn_start_byte < pfn_end_byte) {
> +			memset(info->partial_bitmap1 + pfn_start_byte,
> +			       0xff,
> +			       pfn_end_byte - pfn_start_byte);
>
> -		pfn_bitmap1 += (pfn_end_byte - pfn_start_byte) * BITPERBYTE;
> +			pfn_bitmap1 += (pfn_end_byte - pfn_start_byte) * BITPERBYTE;
> +		}
>
>   		for (pfn = pfn_end_round; pfn < pfn_end; pfn++) {
>   			if (set_bit_on_1st_bitmap(pfn))
> @@ -4540,9 +4542,11 @@ initialize_2nd_bitmap_cyclic(void)
>   		pfn_start_byte = (pfn_start_roundup - info->cyclic_start_pfn) >> 3;
>   		pfn_end_byte = (pfn_end_round - info->cyclic_start_pfn) >> 3;
>
> -		memset(info->partial_bitmap2 + pfn_start_byte,
> -		       0xff,
> -		       pfn_end_byte - pfn_start_byte);
> +		if (pfn_start_byte < pfn_end_byte) {
> +			memset(info->partial_bitmap2 + pfn_start_byte,
> +			       0xff,
> +			       pfn_end_byte - pfn_start_byte);
> +		}
>
>   		for (pfn = pfn_end_round; pfn < pfn_end; ++pfn)
>   			if (!set_bit_on_2nd_bitmap_for_kernel(pfn))
>

Acked-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>

Also, I'm interested in the memory map passed to from EFI in that

> cat /proc/iomem:
> 00000000-00000fff : reserved
> 00001000-0009ffff : System RAM
> 000a0000-000bffff : PCI Bus 0000:00
> 000f0000-000fffff : System ROM
> 00100000-3d162017 : System RAM
>    01000000-015cab9b : Kernel code
>    015cab9c-019beb3f : Kernel data
>    01b4f000-01da9fff : Kernel bss
>    30000000-37ffffff : Crash kernel
> 3d162018-3d171e57 : System RAM
> 3d171e58-3d172017 : System RAM
> 3d172018-3d17ae57 : System RAM
> 3d17ae58-3dc10fff : System RAM

this part is consecutive but somehow is divided into 4 entries.
You called your environment as ``EFI virtual machine'', could you tell
me precisely what it mean? qemu/KVM or VMware guest system? I do want
to understand how this kind of memory map was created. I think this
kind of memory mapping is odd and I guess this is caused by the fact
that the system is a virtual environment.

And for Vivek, this case is a concrete example of multiple RAM entries
appearing in a single page I suspected in the mmap failure patch,
although these entries are consecutive in physical address and can be
represented by a single entry by merging them in a single entry. But
then it seems to me that there could be more odd case that multiple
RAM entries but not consecutive. I again think this should be addressed
in the patch for the mmap failure issue. How do you think?

> 3dc11000-3dc18fff : reserved
> 3dc19000-3dc41fff : System RAM
> 3dc42000-3ddcefff : reserved
> 3ddcf000-3f7fefff : System RAM
> 3f7ff000-3f856fff : reserved
> [..]

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
