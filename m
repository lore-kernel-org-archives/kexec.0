Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410051.outbound.protection.outlook.com
 ([40.107.141.51] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltihX-008dGO-S0
 for kexec@lists.infradead.org; Thu, 17 Jun 2021 03:28:21 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [MAKEDUMPFILE PATCH] makedumpfile: elf_info: check for invalid
 physical address when finding max_paddr
Date: Thu, 17 Jun 2021 03:28:10 +0000
Message-ID: <TYYPR01MB677764675704385599719113DD0E9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <20210615102631.63775-1-coxu@redhat.com>
In-Reply-To: <20210615102631.63775-1-coxu@redhat.com>
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
To: Coiby Xu <coxu@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: Xiaoying Yan <yiyan@redhat.com>

-----Original Message-----
> 
> Kernel commit 464920104bf7adac12722035bfefb3d772eb04d8
> "/proc/kcore: update physical address for kcore ram and text" sets an
> invalid paddr (-1=0xffffffffffffffff) for PT_LOAD segments of not direct
> mapped regions,
>     $ readelf -l /proc/kcore
> 
>     Elf file type is CORE (Core file)
>     Entry point 0x0
>     There are 4 program headers, starting at offset 64
> 
>     Program Headers:
>       Type           Offset             VirtAddr           PhysAddr
>                      FileSiz            MemSiz              Flags  Align
>       NOTE           0x0000000000000120 0x0000000000000000 0x0000000000000000
>                      0x0000000000002320 0x0000000000000000         0x0
>       LOAD           0x1000000000010000 0xd000000000000000 0xffffffffffffffff
>                                                            ^^^^^^^^^^^^^^^^^^
>                      0x0001f80000000000 0x0001f80000000000  RWE    0x10000
>       LOAD           0x0000000000010000 0xc000000000000000 0x0000000000000000
>                      0x00000003f0000000 0x00000003f0000000  RWE    0x10000
>       LOAD           0x3000000000010000 0xf000000000000000 0xffffffffffffffff
>                                                            ^^^^^^^^^^^^^^^^^^
>                      0x0000000000fc0000 0x0000000000fc0000  RWE    0x10000
> 
> makedumple uses max_paddr to calculate the number of sections for sparse
> memory model thus wrong number is obtained based on max_paddr=-1. This
> error could lead to the failure of copying /proc/kcore for RHEL-8.5 on
> ppc64le machine [1],
>     $ uname -r
>     4.18.0-312.el8.ppc64le
>     $ makedumpfile /proc/kcore vmcore1
>     get_mem_section: Could not validate mem_section.
>     get_mm_sparsemem: Can't get the address of mem_section.
> 
>     makedumpfile Failed.

IIUC, makedumpfile has NOT been developed to filter /proc/kcore so far,
except for the --mem-usage option, and this is the first patch for it.

It might be more handy than crash's snap.so extension, so I applied this:
https://github.com/makedumpfile/makedumpfile/commit/38d921a2ef50ebd36258097553626443ffe27496

But please note that maybe filtering /proc/kcore with makedumpfile (and
also analyzing the dumpfile with crash) is still not mature enough for
field or production use.

Thanks,
Kazu

> 
> Let's check if the phys_start of the segment is a valid physical address
> to fix this problem.
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1965267
> 
> Reported-by: Xiaoying Yan <yiyan@redhat.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  elf_info.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/elf_info.c b/elf_info.c
> index e8affb7..9444847 100644
> --- a/elf_info.c
> +++ b/elf_info.c
> @@ -628,7 +628,7 @@ get_max_paddr(void)
> 
>  	for (i = 0; i < num_pt_loads; i++) {
>  		pls = &pt_loads[i];
> -		if (max_paddr < pls->phys_end)
> +		if (pls->phys_start != NOT_PADDR  && max_paddr < pls->phys_end)
>  			max_paddr = pls->phys_end;
>  	}
>  	return max_paddr;
> --
> 2.31.1
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
