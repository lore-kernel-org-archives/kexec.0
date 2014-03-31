Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WUTjt-0007NO-Ek
 for kexec@lists.infradead.org; Mon, 31 Mar 2014 04:22:26 +0000
Message-ID: <5338ED60.7080101@hp.com>
Date: Mon, 31 Mar 2014 12:21:52 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: Fix a segment fault in dumping small ELF
 segment
References: <20140328122633.11362.51287.stgit@k.asiapacific.hpqcorp.net>
 <20140331.101633.456534574.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20140331.101633.456534574.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com, jingbai.ma@hp.com

On 03/31/2014 09:16 AM, HATAYAMA Daisuke wrote:
> From: Jingbai Ma <jingbai.ma@hp.com>
> Subject: [PATCH] makedumpfile: Fix a segment fault in dumping small ELF segment
>
> ``small ELF segment'' is wrong. This issue occurs if the starting or
> ending address of the ELF segment is not aligned to multiple of 8
> pages. Could you correct the subject?
>

Will change.

> Date: Fri, 28 Mar 2014 20:26:34 +0800
>
>> This patch fixs a bug if the size of an ELF segment less than 8 pages.
>>
>
> Could you show me /proc/iomem and an output of readelf -l of the ELF
> vmcore? I'm interested in the segment.

Please see the output below.

>
>> In function create_1st_bitmap_cyclic() and initialize_2nd_bitmap_cyclic(),
>> there are the same code:
>>
>>                  pfn_start_roundup = roundup(pfn_start, BITPERBYTE);
>>                  pfn_end_round = round(pfn_end, BITPERBYTE);
>>
>>                  for (pfn = pfn_start; pfn < pfn_start_roundup; pfn++) {
>>                          if (set_bit_on_1st_bitmap(pfn))
>>                                  pfn_bitmap1++;
>>                  }
>>
>> In case:
>> pfn_start=0xe762c, pfn_start_roundup=0xe7630
>> pfn_end=0xe762d, pfn_end_round=0xe7628
>> This code will set incorrect bits in the bitmap.
>> In function readpage_elf():
>>
>>          if (!offset1) {
>>                  phys_start = page_head_to_phys_start(paddr);
>>                  offset1 = paddr_to_offset(phys_start);
>>                  frac_head = phys_start - paddr;
>>                  memset(bufptr, 0, frac_head);
>>          }
>>
>> The invalid paddr couldn't be found, so phys_start will be zero, and frac_head
>> will be negative, then memset will cause a segment fault.
>>
>> Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
>> ---
>>   makedumpfile.c |   26 +++++++++++++++-----------
>>   1 files changed, 15 insertions(+), 11 deletions(-)
>>
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index ef08d91..21330b7 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -4424,8 +4424,9 @@ create_1st_bitmap_cyclic()
>>   		if (pfn_start >= pfn_end)
>>   			continue;
>>
>> -		pfn_start_roundup = roundup(pfn_start, BITPERBYTE);
>> -		pfn_end_round = round(pfn_end, BITPERBYTE);
>> +		pfn_start_roundup = MIN(roundup(pfn_start, BITPERBYTE),
>> +			pfn_end);
>
> Please add two more tabs in the line of the second argument of MIN()
> like this for readability:
>
> +		pfn_start_roundup = MIN(roundup(pfn_start, BITPERBYTE),
> +					pfn_end);
>

Will fix.

>> +		pfn_end_round = MAX(round(pfn_end, BITPERBYTE), pfn_start);
>>
>>   		for (pfn = pfn_start; pfn < pfn_start_roundup; pfn++) {
>>   			if (set_bit_on_1st_bitmap(pfn))
>> @@ -4443,10 +4444,11 @@ create_1st_bitmap_cyclic()
>>   			pfn_bitmap1 += (pfn_end_byte - pfn_start_byte) * BITPERBYTE;
>>   		}
>>
>> -		for (pfn = pfn_end_round; pfn < pfn_end; pfn++) {
>> -			if (set_bit_on_1st_bitmap(pfn))
>> -				pfn_bitmap1++;
>> -		}
>> +		if (pfn_end_round > pfn_start)
>> +			for (pfn = pfn_end_round; pfn < pfn_end; pfn++) {
>> +				if (set_bit_on_1st_bitmap(pfn))
>> +					pfn_bitmap1++;
>> +			}
>
> Please add { ... } for the outer if to encolose the for statement like this:
>
> +		if (pfn_end_round > pfn_start) {
> +			for (pfn = pfn_end_round; pfn < pfn_end; pfn++) {
> +				if (set_bit_on_1st_bitmap(pfn))
> +					pfn_bitmap1++;
> +			}
> +		}
>

Will fix.

>>   	}
>>   	pfn_memhole -= pfn_bitmap1;
>>
>> @@ -4532,8 +4534,9 @@ initialize_2nd_bitmap_cyclic(void)
>>   		if (pfn_start >= pfn_end)
>>   			continue;
>>
>> -		pfn_start_roundup = roundup(pfn_start, BITPERBYTE);
>> -		pfn_end_round = round(pfn_end, BITPERBYTE);
>> +		pfn_start_roundup = MIN(roundup(pfn_start, BITPERBYTE),
>> +			pfn_end);
>
> Similr.
>

Will fix.

>> +		pfn_end_round = MAX(round(pfn_end, BITPERBYTE), pfn_start);
>>
>>   		for (pfn = pfn_start; pfn < pfn_start_roundup; ++pfn)
>>   			if (!set_bit_on_2nd_bitmap_for_kernel(pfn))
>> @@ -4548,9 +4551,10 @@ initialize_2nd_bitmap_cyclic(void)
>>   			       pfn_end_byte - pfn_start_byte);
>>   		}
>>
>> -		for (pfn = pfn_end_round; pfn < pfn_end; ++pfn)
>> -			if (!set_bit_on_2nd_bitmap_for_kernel(pfn))
>> -				return FALSE;
>> +		if (pfn_end_round > pfn_start)
>> +			for (pfn = pfn_end_round; pfn < pfn_end; ++pfn)
>> +				if (!set_bit_on_2nd_bitmap_for_kernel(pfn))
>> +					return FALSE;
>
> Similar.
>

Will fix.

>>   	}
>>
>>   	return TRUE;
>>
>
> ==
> Thanks.
> HATAYAMA, Daisuke
>

It's a HP BL280c G6 Blade server with 32GB RAM:
cat /proc/iomem
00000000-0000ffff : reserved
00010000-00097bff : System RAM
00097c00-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cafff : Video ROM
000cb000-000cbfff : Adapter ROM
000f0000-000fffff : reserved
   000f0000-000fffff : System ROM
00100000-e761efff : System RAM
   01000000-014684b3 : Kernel code
   014684b4-01bd9f7f : Kernel data
   01d34000-01fe5fff : Kernel bss
   26000000-35ffffff : Crash kernel
e761f000-e762bfff : ACPI Tables
e762c000-e762cfff : System RAM
e762d000-ebffffff : reserved
   e8000000-ebffffff : PCI MMCONFIG 0000 [bus 00-3f]
     e8000000-ebffffff : pnp 00:01
ef000000-fbffffff : PCI Bus 0000:00
   ef000000-ef0fffff : PCI Bus 0000:02
     ef000000-ef01ffff : 0000:02:00.0
     ef020000-ef03ffff : 0000:02:00.1
   efffe000-efffffff : pnp 00:01
   f0000000-f7ffffff : PCI Bus 0000:01
     f0000000-f7ffffff : 0000:01:03.0
   fbcf0000-fbcf03ff : 0000:00:1d.7
     fbcf0000-fbcf03ff : ehci_hcd
   fbd00000-fbefffff : PCI Bus 0000:01
     fbd00000-fbd1ffff : 0000:01:03.0
     fbd20000-fbd2ffff : 0000:01:04.2
     fbdf0000-fbdf00ff : 0000:01:04.6
       fbdf0000-fbdf0001 : ipmi_si
     fbe00000-fbe7ffff : 0000:01:04.2
       fbe00000-fbe7ffff : hpilo
     fbec0000-fbec3fff : 0000:01:04.2
       fbec0000-fbec3fff : hpilo
     fbed0000-fbed07ff : 0000:01:04.2
       fbed0000-fbed07ff : hpilo
     fbee0000-fbee01ff : 0000:01:04.0
     fbef0000-fbefffff : 0000:01:03.0
   fbf00000-fbffffff : PCI Bus 0000:02
     fbf00000-fbf1ffff : 0000:02:00.0
     fbf20000-fbf3ffff : 0000:02:00.0
     fbf50000-fbf53fff : 0000:02:00.1
       fbf50000-fbf53fff : igb
     fbf60000-fbf7ffff : 0000:02:00.1
       fbf60000-fbf7ffff : igb
     fbf80000-fbf9ffff : 0000:02:00.1
       fbf80000-fbf9ffff : igb
     fbfb0000-fbfb3fff : 0000:02:00.0
       fbfb0000-fbfb3fff : igb
     fbfc0000-fbfdffff : 0000:02:00.0
       fbfc0000-fbfdffff : igb
     fbfe0000-fbffffff : 0000:02:00.0
       fbfe0000-fbffffff : igb
fe000000-febfffff : pnp 00:01
fec00000-fee0ffff : reserved
   fec00000-fec003ff : IOAPIC 0
   fec80000-fec803ff : IOAPIC 1
   fed00000-fed44fff : PCI Bus 0000:00
     fed00000-fed003ff : HPET 0
   fee00000-fee00fff : Local APIC
ff800000-ffffffff : reserved
100000000-817ffefff : System RAM
817fff000-817ffffff : RAM buffer


readelf -l vmcore

Elf file type is CORE (Core file)
Entry point 0x0
There are 7 program headers, starting at offset 64

Program Headers:
   Type           Offset             VirtAddr           PhysAddr
                  FileSiz            MemSiz              Flags  Align
   NOTE           0x0000000000001000 0x0000000000000000 0x0000000000000000
                  0x0000000000001110 0x0000000000001110         0
   LOAD           0x0000000000003000 0xffffffff81000000 0x0000000001000000
                  0x0000000001006000 0x0000000001006000  RWE    0
   LOAD           0x0000000001009000 0xffff880000010000 0x0000000000010000
                  0x0000000000087c00 0x0000000000087c00  RWE    0
   LOAD           0x0000000001091000 0xffff880000100000 0x0000000000100000
                  0x0000000025f00000 0x0000000025f00000  RWE    0
   LOAD           0x0000000026f91000 0xffff880036000000 0x0000000036000000
                  0x00000000b161f000 0x00000000b161f000  RWE    0
   LOAD           0x00000000d85b0000 0xffff8800e762c000 0x00000000e762c000
                  0x0000000000001000 0x0000000000001000  RWE    0
   LOAD           0x00000000d85b1000 0xffff880100000000 0x0000000100000000
                  0x0000000717fff000 0x0000000717fff000  RWE    0

-- 
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
