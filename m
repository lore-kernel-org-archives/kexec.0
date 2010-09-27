Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1P03fY-0006m0-Vz
	for kexec@lists.infradead.org; Mon, 27 Sep 2010 02:42:22 +0000
Date: Sun, 26 Sep 2010 22:42:09 -0400 (EDT)
From: caiqian@redhat.com
Message-ID: <870873343.2003871285555329846.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1346740216.2003261285553562018.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: kexec load failure introduced by "x86, memblock: Replace
	e820_/_early string with memblock_"
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-next <linux-next@vger.kernel.org>, kexec <kexec@lists.infradead.org>, "H. Peter Anvin" <hpa@zytor.com>


----- "Yinghai Lu" <yinghai@kernel.org> wrote:

> On 09/26/2010 07:47 AM, caiqian@redhat.com wrote:
> > 
> > ----- "Yinghai Lu" <yinghai@kernel.org> wrote:
> > 
> >> On 09/25/2010 11:55 PM, CAI Qian wrote:
> >>>>
> >>>> are you kexec from 2.6.35+ to 2.6.36-rc3+?
> >>> No, both kernels were the same version. I am sorry the above logs
> >> were misleading that were copy-and-pasted from different kernel
> >> versions.
> >>
> >> can you check tip instead of next tree?
> > No dice,
> > # /sbin/kexec -p '--command-line=ro
> root=/dev/mapper/VolGroup-lv_root rd_LVM_LV=VolGroup/lv_root
> rd_LVM_LV=VolGroup/lv_swap rd_NO_LUKS rd_NO_MD rd_NO_DM
> LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us
> rhgb quiet console=tty0 console=ttyS0,115200 crashkernel=128M irqpoll
> maxcpus=1 reset_devices cgroup_disable=memory '
> --initrd=/boot/initrd-2.6.36-rc5-tip+kdump.img
> /boot/vmlinuz-2.6.36-rc5-tip+
> > Could not find a free area of memory of a000 bytes...
> > locate_hole failed
> 
> looks like you need to update your kexec-tools package.
Same results using the latest kexec-tools git version.
> 
> please run following scripts in first kernel.
> 
> cd /sys/firmware/memmap
> for dir in * ; do
>   start=$(cat $dir/start)
>   end=$(cat $dir/end)
>   type=$(cat $dir/type)
>   printf "%016x-%016x (%s)\n" $start $[ $end +1] "$type"
> done
0000000000000000-000000000009f400 (System RAM)
000000000009f400-00000000000a0000 (reserved)
00000000000f0000-0000000000100000 (reserved)
0000000000100000-00000000dfffb000 (System RAM)
00000000dfffb000-00000000e0000000 (reserved)
00000000fffbc000-0000000100000000 (reserved)
0000000100000000-0000000ca0000000 (System RAM)
> 
> also enable kexec debug to see what memmap kexec parse.
-d did not help here.
# /sbin/kexec -p -d '--command-line=ro root=/dev/mapper/VolGroup-lv_root rd_LVM_LV=VolGroup/lv_root rd_LVM_LV=VolGroup/lv_swap rd_NO_LUKS rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us rhgb quiet console=tty0 console=ttyS0,115200 crashkernel=128M irqpoll maxcpus=1 reset_devices cgroup_disable=memory ' --initrd=/boot/initrd-2.6.36-rc5-tip+kdump.img /boot/vmlinuz-2.6.36-rc5-tip+
Could not find a free area of memory of a000 bytes...
locate_hole failed
> 
> > 
> > After reverted the whole memblock commits, it was working again,
> > 7950c407c0288b223a200c1bba8198941599ca37
> > fb74fb6db91abc3c1ceeb9d2c17b44866a12c63e
> > f88eff74aa848e58b1ea49768c0bbb874b31357f
> > 27de794365786b4cdc3461ed4e23af2a33f40612
> > 9dc5d569c133819c1ce069ebb1d771c62de32580
> > 4d5cf86ce187c0d3a4cdf233ab0cc6526ccbe01f
> > 88ba088c18457caaf8d2e5f8d36becc731a3d4f6
> > edbe7d23b4482e7f33179290bcff3b1feae1c5f3
> > 6bcc8176d07f108da3b1af17fb2c0e82c80e948e
> > b52c17ce854125700c4e19d4427d39bf2504ff63
> > e82d42be24bd5d75bf6f81045636e6ca95ab55f2
> > 301ff3e88ef9ff4bdb92f36a3e6170fce4c9dd34
> > 72d7c3b33c980843e756681fb4867dc1efd62a76
> > a9ce6bc15100023b411f8117e53a016d61889800
> > a587d2daebcd2bc159d4348b6a7b028950a6d803
> > 6f2a75369e7561e800d86927ecd83c970996b21f
> > 
> > If used crashkernel=128M, the /proc/iomem looks like this. It used a
> huge offset.
> > 00000000-00000fff : reserved
> > 00001000-0009f3ff : System RAM
> > 0009f400-0009ffff : reserved
> > 000f0000-000fffff : reserved
> > 00100000-dfffafff : System RAM
> >   01000000-0149a733 : Kernel code
> >   0149a734-01afc46f : Kernel data
> >   01d9c000-022b18f7 : Kernel bss
> > dfffb000-dfffffff : reserved
> > f0000000-f1ffffff : 0000:00:02.0
> > f2000000-f2000fff : 0000:00:02.0
> > f2010000-f201ffff : 0000:00:02.0
> > f2020000-f20200ff : 0000:00:03.0
> >   f2020000-f20200ff : 8139cp
> > f2030000-f203ffff : 0000:00:03.0
> > fec00000-fec003ff : IOAPIC 0
> > fee00000-fee00fff : Local APIC
> > fffbc000-ffffffff : reserved
> > 100000000-c9fffffff : System RAM
> >   c98000000-c9fffffff : Crash kernel
> > 
> > On kernels that are working, it automatically found the offset at
> 32M.
> > 00000000-0000ffff : reserved
> > 00010000-0009f3ff : System RAM
> > 0009f400-0009ffff : reserved
> > 000f0000-000fffff : reserved
> > 00100000-dfffafff : System RAM
> >   01000000-014250bf : Kernel code
> >   014250c0-018aca8f : Kernel data
> >   01b1f000-01ff7c07 : Kernel bss
> >   02000000-09ffffff : Crash kernel
> > dfffb000-dfffffff : reserved
> > f0000000-f1ffffff : 0000:00:02.0
> > f2000000-f2000fff : 0000:00:02.0
> > f2010000-f201ffff : 0000:00:02.0
> > f2020000-f20200ff : 0000:00:03.0
> >   f2020000-f20200ff : 8139cp
> > f2030000-f203ffff : 0000:00:03.0
> > fec00000-fec003ff : IOAPIC 0
> > fee00000-fee00fff : Local APIC
> > fffbc000-ffffffff : reserved
> > 100000000-c9fffffff : System RAM
> > 
> > If specified a fixed offset like crashkernel=128M@32M, it failed
> reservation.
> > initial memory mapped : 0 - 20000000
> > init_memory_mapping: 0000000000000000-00000000dfffb000
> >  0000000000 - 00dfe00000 page 2M
> >  00dfe00000 - 00dfffb000 page 4k
> > kernel direct mapping tables up to dfffb000 @ 1fffa000-20000000
> > init_memory_mapping: 0000000100000000-0000000ca0000000
> >  0100000000 - 0ca0000000 page 2M
> > kernel direct mapping tables up to ca0000000 @ dffc7000-dfffb000
> > RAMDISK: 37599000 - 37ff0000
> > crashkernel reservation failed - memory is in use.
> > 
> > After reverted those commits, it looks like this,
> > init_memory_mapping: 0000000000000000-00000000dfffb000
> >  0000000000 - 00dfe00000 page 2M
> >  00dfe00000 - 00dfffb000 page 4k
> > kernel direct mapping tables up to dfffb000 @ 16000-1c000
> > init_memory_mapping: 0000000100000000-0000000ca0000000
> >  0100000000 - 0ca0000000 page 2M
> > kernel direct mapping tables up to ca0000000 @ 1a000-4e000
> > RAMDISK: 375c9000 - 37ff0000
> > Reserving 128MB of memory at 32MB for crashkernel (System RAM:
> 51712MB)
> 
> yes, default memblock find_range is top_down.
> 
> old early_res is from bottom_up.
> 
> during the convecting, we do have one x86 find_range from bottom_up,
> but later
> it seems top_down was working on all test cases. ( 32bit etc)
> 
> Subject: [PATCH] x86, memblock: Add x86 version of
> memblock_find_in_range()
Yes, this patch did help.
Reserving 128MB of memory at 32MB for crashkernel (System RAM: 51712MB)
> 
> Generic version is going from high to low, and it seems it can not
> find
> right area compact enough.
> 
> the x86 version will go from goal to limit and just like the way We
> used
> for early_res
> 
> use ARCH_FIND_MEMBLOCK_AREA to select from them.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  arch/x86/Kconfig       |    8 +++++++
>  arch/x86/mm/memblock.c |   54
> +++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/memblock.c          |    2 -
>  3 files changed, 63 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/arch/x86/mm/memblock.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/mm/memblock.c
> +++ linux-2.6/arch/x86/mm/memblock.c
> @@ -352,3 +352,57 @@ u64 __init memblock_x86_hole_size(u64 st
>  
>  	return end - start - ((u64)ram << PAGE_SHIFT);
>  }
> +
> +#ifdef CONFIG_ARCH_MEMBLOCK_FIND_AREA
> +/* Check for already reserved areas */
> +static inline bool __init check_with_memblock_reserved(u64 *addrp,
> u64 size, u64 align)
> +{
> +	u64 addr = *addrp;
> +	bool changed = false;
> +	struct memblock_region *r;
> +again:
> +	for_each_memblock(reserved, r) {
> +		if ((addr + size) > r->base && addr < (r->base + r->size)) {
> +			addr = round_up(r->base + r->size, align);
> +			changed = true;
> +			goto again;
> +		}
> +	}
> +
> +	if (changed)
> +		*addrp = addr;
> +
> +	return changed;
> +}
> +
> +/*
> + * Find a free area with specified alignment in a specific range.
> + */
> +u64 __init memblock_find_in_range(u64 start, u64 end, u64 size, u64
> align)
> +{
> +	struct memblock_region *r;
> +
> +	for_each_memblock(memory, r) {
> +		u64 ei_start = r->base;
> +		u64 ei_last = ei_start + r->size;
> +		u64 addr, last;
> +
> +		addr = round_up(ei_start, align);
> +		if (addr < start)
> +			addr = round_up(start, align);
> +		if (addr >= ei_last)
> +			continue;
> +		while (check_with_memblock_reserved(&addr, size, align) &&
> addr+size <= ei_last)
> +			;
> +		last = addr + size;
> +		if (last > ei_last)
> +			continue;
> +		if (last > end)
> +			continue;
> +
> +		return addr;
> +	}
> +
> +	return MEMBLOCK_ERROR;
> +}
> +#endif
> Index: linux-2.6/arch/x86/Kconfig
> ===================================================================
> --- linux-2.6.orig/arch/x86/Kconfig
> +++ linux-2.6/arch/x86/Kconfig
> @@ -569,6 +569,14 @@ config PARAVIRT_DEBUG
>  	  Enable to debug paravirt_ops internals.  Specifically, BUG if
>  	  a paravirt_op is missing when it is called.
>  
> +config ARCH_MEMBLOCK_FIND_AREA
> +	default y
> +	bool "Use x86 own memblock_find_in_range()"
> +	---help---
> +	  Use memblock_find_in_range() version instead of generic version,
> it get free
> +	  area up from low.
> +	  Generic one try to get free area down from limit.
> +
>  config NO_BOOTMEM
>  	def_bool y
>  
> Index: linux-2.6/mm/memblock.c
> ===================================================================
> --- linux-2.6.orig/mm/memblock.c
> +++ linux-2.6/mm/memblock.c
> @@ -165,7 +165,7 @@ static phys_addr_t __init_memblock membl
>  /*
>   * Find a free area with specified alignment in a specific range.
>   */
> -u64 __init_memblock memblock_find_in_range(u64 start, u64 end, u64
> size, u64 align)
> +u64 __init_memblock __weak memblock_find_in_range(u64 start, u64 end,
> u64 size, u64 align)
>  {
>  	return memblock_find_base(size, align, start, end);
>  }
> 
> 
> > 
> > I can't tell where the memory at 32MB was used, but after reverted
> those commits I can see those early reservations information,
> > Subtract (76 early reservations)
> >   #1 [0001000000 - 0001ff7c08]   TEXT DATA BSS
> >   #2 [00375c9000 - 0037ff0000]         RAMDISK
> >   #3 [0001ff8000 - 0001ff8079]             BRK
> >   #4 [000009f400 - 00000f7fb0]   BIOS reserved
> >   #5 [00000f7fb0 - 00000f7fc0]    MP-table mpf
> >   #6 [00000f822c - 0000100000]   BIOS reserved
> >   #7 [00000f7fc0 - 00000f822c]    MP-table mpc
> >   #8 [0000010000 - 0000012000]      TRAMPOLINE
> >   #9 [0000012000 - 0000016000]     ACPI WAKEUP
> >   #10 [0000016000 - 000001a000]         PGTABLE
> >   #11 [000001a000 - 0000049000]         PGTABLE
> >   #12 [0002000000 - 000a000000]    CRASH KERNEL
> > 
> > But after those commits, those information was gone.
> 
> memblock could merge reserved area, so can not keep tags with it.
> 
> I have local patchset that could print those name tags...
> please check
Looks like so.
> 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-2.6-yinghai.git
> memblock
> 
> Yinghai
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
