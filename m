Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XoZQY-0006CF-DH
 for kexec@lists.infradead.org; Wed, 12 Nov 2014 15:01:47 +0000
Message-ID: <5463763D.6090700@redhat.com>
Date: Wed, 12 Nov 2014 16:01:17 +0100
From: Laszlo Ersek <lersek@redhat.com>
MIME-Version: 1.0
Subject: Re: uniquely identifying KDUMP files that originate from QEMU
References: <mailman.20827.1415774425.22890.kexec@lists.infradead.org>
 <2088242606.7090866.1415801374974.JavaMail.zimbra@redhat.com>
In-Reply-To: <2088242606.7090866.1415801374974.JavaMail.zimbra@redhat.com>
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
To: Dave Anderson <anderson@redhat.com>, kexec@lists.infradead.org
Cc: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Petr Tesarik <ptesarik@suse.cz>, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>

On 11/12/14 15:09, Dave Anderson wrote:
> 
> 
> ----- Original Message -----
>> From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>> To: ptesarik@suse.cz
>> Cc: lersek@redhat.com, kexec@lists.infradead.org
>> Subject: Re: uniquely identifying KDUMP files that originate from QEMU
>> Message-ID:
>> 	<20141112.120838.303682123986142686.d.hatayama@jp.fujitsu.com>
>> Content-Type: Text/Plain; charset=us-ascii
>>
>> From: Petr Tesarik <ptesarik@suse.cz>
>> Subject: Re: uniquely identifying KDUMP files that originate from QEMU
>> Date: Tue, 11 Nov 2014 13:09:13 +0100
>>
>>> On Tue, 11 Nov 2014 12:22:52 +0100
>>> Laszlo Ersek <lersek@redhat.com> wrote:
>>>
>>>> (Note: I'm not subscribed to either qemu-devel or the kexec list; please
>>>> keep me CC'd.)
>>>>
>>>> QEMU is able to dump the guest's memory in KDUMP format (kdump-zlib,
>>>> kdump-lzo, kdump-snappy) with the "dump-guest-memory" QMP command.
>>>>
>>>> The resultant vmcore is usually analyzed with the "crash" utility.
>>>>
>>>> The original tool producing such files is kdump. Unlike the procedure
>>>> performed by QEMU, kdump runs from *within* the guest (under a kexec'd
>>>> kdump kernel), and has more information about the original guest kernel
>>>> state (which is being dumped) than QEMU. To QEMU, the guest kernel state
>>>> is opaque.
>>>>
>>>> For this reason, the kdump preparation logic in QEMU hardcodes a number
>>>> of fields in the kdump header. The direct issue is the "phys_base"
>>>> field. Refer to dump.c, functions create_header32(), create_header64(),
>>>> and "include/sysemu/dump.h", macro PHYS_BASE (with the replacement text
>>>> "0").
>>>>
>>>> http://git.qemu.org/?p=qemu.git;a=blob;f=dump.c;h=9c7dad8f865af3b778589dd0847e450ba9a75b9d;hb=HEAD
>>>>
>>>> http://git.qemu.org/?p=qemu.git;a=blob;f=include/sysemu/dump.h;h=7e4ec5c7d96fb39c943d970d1683aa2dc171c933;hb=HEAD
>>>>
>>>> This works in most cases, because the guest Linux kernel indeed tends to
>>>> be loaded at guest-phys address 0. However, when the guest Linux kernel
>>>> is booted on top of OVMF (which has a somewhat unusual UEFI memory map),
>>>> then the guest Linux kernel is loaded at 16MB, thereby getting out of
>>>> sync with the phys_base=0 setting visible in the KDUMP header.
>>>>
>>>> This trips up the "crash" utility.
>>>>
>>>> Dave worked around the issue in "crash" for ELF format dumps -- "crash"
>>>> can identify QEMU as the originator of the vmcore by finding the QEMU
>>>> notes in the ELF vmcore. If those are present, then "crash" employs a
>>>> heuristic, probing for a phys_base up to 32MB, in 1MB steps.
>>>>
>>>> Alas, the QEMU notes are not present in the KDUMP-format vmcores that
>>>> QEMU produces (they cannot be),
>>>
>>> Why? Since KDUMP format version 4, the complete ELF notes can be stored
>>> in the file (see offset_note, size_note fields in the sub-header).
>>>
>>
>> Yes, the QEMU notes is present in kdump-compressed format. But
>> phys_base cannot be calculated only from qemu-side. We cannot do more
>> than the efforts crash utility does for workaround. So, the phys_base
>> value in kdump-sub header is now designed to have 0 now.
>>
>> Anyway, phys_base is kernel information. To make it available for qemu
>> side, there's need to prepare a mechanism for qemu to have any access
>> to it.
>>
>> One ad-hoc but simple way is to put phys_base value as part of
>> VMCOREINFO note information on kernel.
>>
>> Although there has already been a similar one in VMCOREINFO, like
>>
>> arch/x86/kernel/
>> ==
>> void arch_crash_save_vmcoreinfo(void)
>> {
>>         VMCOREINFO_SYMBOL(phys_base); <---- This
>>         VMCOREINFO_SYMBOL(init_level4_pgt);
>>
>> ...
>> ==
>>
>> this is meangless, because this value is a virtual address assigned to
>> phys_base symbol. To refer to the value of phys_base itself, we need
>> the phys_base value we are about to get now.
>>
>> So, instead, if we change this to save the value, not value of symbol
>> phys_base, we can get phys_base from the VMCOREINFO.
>>
>> The VMCOREINFO consists simply of string. So it's easy to search
>> vmcore for it e.g. using strings and grep like this:
>>
>> $ strings vmcore-3.10.0-121.el7.x86_64 | grep -E ".*VMCOREINFO.*" -A 100
>> VMCOREINFO
>> OSRELEASE=3.10.0-121.el7.x86_64
>> PAGESIZE=4096
>> ...
>> SYMBOL(phys_base)=ffffffff818e5010  <-- though this is address of phys_base
>> now...
>> SYMBOL(init_level4_pgt)=ffffffff818de000
>> SYMBOL(node_data)=ffffffff819f1cc0
>> LENGTH(node_data)=1024
>> CRASHTIME=1399460394
>> ...
>>
>> This should also be useful to get phys_base of 2nd kernel, which is
>> inherently relocated kernel from a vmcore generated using qemu dump.
>>
>> This is far from well-designed from qemu's point of view, but it would
>> be manually easier to get phys_base than now.
>>
>> Obviously, the VMCOREINFO is available only if CONFIG_KEXEC is
>> enabled. Other users cannot use this.
>>
>> --
>> Thanks.
>> HATAYAMA, Daisuke
> 
> I agree that the actual value of phys_base should be included in the vmcoreinfo.
> 
> However, it won't help in this case because the vmcoreinfo data is not
> copied into the compressed dumpfile header.  The offset_vmcoreinfo and
> size_vmcoreinfo fields are zero.  
> 
> Here's an example header dump of a QEMU-generated dumpfile:
>   
>   crash> help -n
>   makedumpfile header:
>             signature: "makedumpfile"
>                  type: 1
>               version: 1
>         all_flat_data:
>             num_array: 18695
>                 array: 7f484b760010
>             file_size: 0
>   
>   diskdump_data: 
>             filename: vmcore.ovmf.rhel7.kdump-snappy
>                flags: c6 (KDUMP_CMPRS_LOCAL|ERROR_EXCLUDED|LZO_SUPPORTED|SNAPPY_SUPPORTED) [FLAT]
>                  dfd: 3
>                  ofp: 3e441b1260
>         machine_type: 62 (EM_X86_64)
>   
>               header: 1a68fe0
>              signature: "KDUMP   "
>         header_version: 6
>                utsname:
>                  sysname: 
>                 nodename: 
>                  release: 
>                  version: 
>                  machine: x86_64
>               domainname: 
>              timestamp:
>                   tv_sec: 0
>                  tv_usec: 0
>                 status: 4 (DUMP_DH_COMPRESSED_SNAPPY)
>             block_size: 4096
>           sub_hdr_size: 1
>          bitmap_blocks: 76
>              max_mapnr: 1245184
>       total_ram_blocks: 0
>          device_blocks: 0
>         written_blocks: 0
>            current_cpu: 0
>                nr_cpus: 4
>         tasks[nr_cpus]: 0
>                         0
>                         0
>                         0
>   
>           sub_header: 0 (n/a)
>   
>     sub_header_kdump: 1a69ff0 
>              phys_base: 0
>             dump_level: 1 (0x1) (DUMP_EXCLUDE_ZERO)
>                  split: 0
>              start_pfn: (unused)
>                end_pfn: (unused)
>      offset_vmcoreinfo: 0 (0x0)
>        size_vmcoreinfo: 0 (0x0)
>            offset_note: 4200 (0x1068)
>              size_note: 3232 (0xca0)
>     num_prstatus_notes: 4
>              notes_buf: 1a6b000
>               notes[0]: 1a6b000
>               notes[1]: 1a6b164
>               notes[2]: 1a6b2c8
>               notes[3]: 1a6b42c
>     NT_PRSTATUS_offset: 1068
>                         11cc
>                         1330
>                         1494
>       offset_eraseinfo: 0 (0x0)
>         size_eraseinfo: 0 (0x0)
>           start_pfn_64: (unused)
>             end_pfn_64: (unused)
>           max_mapnr_64: 1245184 (0x130000)
>   
>          data_offset: 4e000
>           block_size: 4096
>          block_shift: 12
>               bitmap: 7f484b713010
>           bitmap_len: 311296
>            max_mapnr: 1245184 (0x130000)
>      dumpable_bitmap: 7f484b6c6010
>                 byte: 0
>                  bit: 0
>      compressed_page: 1a8c660
>            curbufptr: 1a7f650
> ...  
> 
> Note that QEMU does add self-generated register dumps above, but the special
> "QEMU" note that is added to ELF kdumps is not included. 
> 
> Also note that the kernel version information is also left zero-filled.
> 
> In any case, if either a QEMU note or a diskdump.data flag were added, I would
> be more than happy.

Looks like a new flag needs to be negotiated with many stake-holders,
but a QEMU note could be included even in the kdump format (not only the
ELF format) freely, and tools that don't recognize it would simply
ignore it. (And other tools that generate custom notes probably won't
clash with it.)

Is that correct? Because if it is, then (a) I didn't know it, (b) we
only need an agreement between "crash" and qemu.

Is the kdump format specified somewhere (as in, a PDF or text file)? I'd
like to look into this option if possible.

Also, is there a command line tool that dumps metadata from a kdump
file? (Quite like your "crash" invocation above, but I believe crash
won't even start without a matching symbol file.)

Thank you
Laszlo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
