Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g5t1625.atlanta.hp.com ([15.192.137.8])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WOE3i-0001Sj-9L
 for kexec@lists.infradead.org; Thu, 13 Mar 2014 22:25:02 +0000
Date: Thu, 13 Mar 2014 16:24:28 -0600
From: Linn Crosetto <linn@hp.com>
Subject: Re: [PATCH v3 4/4] x86: Pass memory range via E820 for kdump
Message-ID: <20140313222428.GW7672@oranje.fc.hp.com>
References: <1394464149-30384-1-git-send-email-chaowang@redhat.com>
 <1394464149-30384-5-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1394464149-30384-5-git-send-email-chaowang@redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de, vgoyal@redhat.com

Wang Chao,

On Mon, Mar 10, 2014 at 11:09:09PM +0800, WANG Chao wrote:
> command line size is restricted by kernel, sometimes memmap=exactmap has
> too many memory ranges to pass to cmdline. A better approach, to pass the
> memory ranges for crash kernel to boot into, is filling the memory
> ranges into E820.
> 
> boot_params only got 128 slots for E820 map to fit in, when the number of
> memory map exceeds 128, use setup_data to pass the rest as extended E820
> memory map.
> 
> kexec boot could also benefit from setup_data in case E820 memory map
> exceeds 128.
> 
> Now this new approach becomes default instead of memmap=exactmap.
> saved_max_pfn users can specify --pass-memmap-cmdline to use the
> exactmap approach.
> 
> Signed-off-by: WANG Chao <chaowang@redhat.com>
> ---
>  kexec/arch/i386/crashdump-x86.c   |  25 +++---
>  kexec/arch/i386/crashdump-x86.h   |   1 +
>  kexec/arch/i386/x86-linux-setup.c | 171 +++++++++++++++++++++++++-------------
>  3 files changed, 130 insertions(+), 67 deletions(-)
> 

[..]

> +static void setup_e820_ext(struct kexec_info *info, struct x86_linux_param_header *real_mode,
> +			   struct memory_range *range, int nr_range)
> +{
> +	struct setup_data *sd;
> +	struct e820entry *e820;
> +	int nr_range_ext;
> +
> +	nr_range_ext = nr_range - E820MAX;
> +	sd = malloc(sizeof(struct setup_data) + nr_range_ext * sizeof(struct e820entry));

You might check the return value from malloc().

> +	sd->next = 0;
> +	sd->len = nr_range_ext * sizeof(struct e820entry);
> +	sd->type = SETUP_E820_EXT;
> +
> +	e820 = (struct e820entry *) sd->data;
> +	dbgprintf("Extended E820 via setup_data:\n");
> +	add_e820_map_from_mr(real_mode, e820, range + E820MAX, nr_range_ext);
> +	add_setup_data(info, real_mode, sd);
> +}

[..]

I tested on a prototype system with 231 entries in the map with good results.
Everything succeeds when using kexec to initiate a fast reboot. For crash, it
works with and without --pass-memmap-cmdline when using noefi. I hit the
following panic when initiating a crash leaving EFI enabled in the crash kernel:

 ? __unmap_pmd_range+0x77/0x190
 unmap_pmd_range+0xcf/0x1c0
 populate_pgd+0x16d/0x250
 __cpa_process_fault+0x15/0xb0
 __change_page_attr+0x15e/0x2a0
 __change_page_attr_set_clr+0x59/0xc0
 kernel_map_pages_in_pgd+0x7a/0xb0
 __map_region+0x46/0x64
 ? early_idt_handlers+0x117/0x120
 efi_map_region_fixed+0xd/0xf
 efi_enter_virtual_mode+0x4c/0x476
 ? early_idt_handlers+0x117/0x120
 ? early_idt_handlers+0x117/0x120
 start_kernel+0x2e5/0x376
 ? repair_env_string+0x5b/0x5b
 ? memblock_reserve+0x49/0x4e
 x86_64_start_reservations+0x2a/0x2c
 x86_64_start_kernel+0x19f/0x1ae

However, I was able to reproduce this panic using an earlier version of
kexec-tools, so I believe it is unrelated to this patch.

For this patch:

Reviewed-by: Linn Crosetto <linn@hp.com>

For the series:

Tested-by: Linn Crosetto <linn@hp.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
