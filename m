Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHrxg-0004jv-In
 for kexec@lists.infradead.org; Wed, 31 Oct 2018 14:59:14 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: sadump: fix failure of reading 640 KB
 backup region if at over 4GB location
Date: Wed, 31 Oct 2018 14:58:09 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0355EC6A@BPXM09GP.gisp.nec.co.jp>
References: <33710E6CAA200E4583255F4FB666C4E21B9EC3C9@G01JPEXMBYT03>
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E21B9EC3C9@G01JPEXMBYT03>
Content-Language: en-US
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
To: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Cc: "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>

On 10/29/2018 10:47 PM, Hatayama, Daisuke wrote:
> Currently, in function sadump_kdump_backup_region_init(), variable mem
> holding physical memory to read as a candidate of the ELF core header
> is of type unsigned int with just 4 byte length:
> 
>         for (i = 0; i < ARRAY_LENGTH(kimage.segment); ++i) {
>                 char e_ident[EI_NIDENT];
>                 unsigned mem;
> 
>                 mem=ULONG(buf+i*SIZE(kexec_segment)+OFFSET(kexec_segment.mem));
>                 if (!mem)
>                         continue;
> 
>                 if (!readmem(PADDR, mem, e_ident, SELFMAG)) {
>                         DEBUG_MSG("sadump: failed to read elfcorehdr buffer\n");
>                         return;
>                 }
> 
> Thus, if backup region for the first 640KB physical memory is located
> at over 4GB location thanks to crashkernel=size,high like:
> 
>     # grep crashkernel /proc/cmdline
>     BOOT_IMAGE=(hd0,gpt2)/vmlinuz-4.18 root=/dev/mapper/rhel-root ro crashkernel=512M,high
> 
>     # grep Crash /proc/iomem
>       06000000-15ffffff : Crash kernel
>       107f000000-109effffff : Crash kernel
> 
>     crash> rd -p 0x109ef5d000
> 	  109ef5d000:  00010102464c457f                    .ELF....
> 
> the upper 32-bit of the physical address in mem variable is dropped
> and readmem() fails while outputting the following debug message:
> 
>     # LANG=C ./makedumpfile --message-level 8 -f -l -d 31 -x ./vmlinux /dev/sdc vmcore-ld31
>     sadump: read dump device as single partition
>     sadump: single partition configuration
>     page_size    : 4096
>     sadump: timezone information is missing
>     sadump: idtr=fffffe0000000000
>     sadump: cr3=86b42e000
>     sadump: idtr(phys)=4c35cc000
>     sadump: devide_error(vmlinux)=ffffffff81a00c50
>     sadump: devide_error(vmcore)=ffffffffa0c00c50
>     sadump: cmdline vaddr: ffffffffa1bcf008
>     sadump: cmdline paddr: 4c35cf008
>     sadump: cmdline buf vaddr: ffff8ae89ffceec0
>     sadump: cmdline buf paddr: 109ffceec0
>     sadump: kaslr_offset=1f200000
>     sadump: phys_base=4a1a00000
>     sadump: online cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29
> 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59
>     sadump: nr_cpus: 60
> 
>     sadump: failed to read elfcorehdr buffer <--- This is the debug message indicating
>                                                   reading ELF core header fails
> 
> Then, the generated vmcore has invalid data in its first 640KB part.
> 
> The variable mem needs to have type of 64-bit length.
> 
> With this patch, kdump backup region is successfully found as follows:
> 
>     # LANG=C ./makedumpfile --message-level 31 -f -l -d 31 -x ./vmlinux /dev/sdc vmcore-ld31
>     sadump: read dump device as single partition
>     sadump: single partition configuration
>     page_size    : 4096
>     sadump: timezone information is missing
>     sadump: idtr=fffffe0000000000
>     sadump: cr3=86b42e000
>     sadump: idtr(phys)=4c35cc000
>     sadump: devide_error(vmlinux)=ffffffff81a00c50
>     sadump: devide_error(vmcore)=ffffffffa0c00c50
>     sadump: cmdline vaddr: ffffffffa1bcf008
>     sadump: cmdline paddr: 4c35cf008
>     sadump: cmdline buf vaddr: ffff8ae89ffceec0
>     sadump: cmdline buf paddr: 109ffceec0
>     sadump: kaslr_offset=1f200000
>     sadump: phys_base=4a1a00000
>     sadump: online cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29
> 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59
>     sadump: nr_cpus: 60
>     The kernel version is not supported.
>     The makedumpfile operation may be incomplete.
>     sadump: SRC_START: 0x00000000001000 SRC_SIZE: 0x0000000009f000 SRC_OFFSET: 0x0000109ef61000
>     sadump: kdump backup region used
>     ...<snip>...
> 
> By the way, before crashkernel=size,high was introduced, there was
> limitation that ELF core header resides at under 4GB location, so
> defining it as unsigned int was not entirely wrong at that time.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
>  sadump_info.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sadump_info.c b/sadump_info.c
> index dd50d48..a668dca 100644
> --- a/sadump_info.c
> +++ b/sadump_info.c
> @@ -2395,7 +2395,7 @@ sadump_kdump_backup_region_init(void)
>  	elfcorehdr_p = 0;
>  	for (i = 0; i < ARRAY_LENGTH(kimage.segment); ++i) {
>  		char e_ident[EI_NIDENT];
> -		unsigned mem;
> +		unsigned long mem;
> 
>  		mem=ULONG(buf+i*SIZE(kexec_segment)+OFFSET(kexec_segment.mem));
>  		if (!mem)
> --
> 2.18.0
> 
> 

Thanks Hatayama-san, applied to devel branch.

Kazu



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
