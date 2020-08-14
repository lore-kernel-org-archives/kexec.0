Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6TIn-0004iv-VR
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 06:34:59 +0000
Date: Fri, 14 Aug 2020 14:34:39 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono, boot
 and real
Message-ID: <20200814063439.GA18058@dhcp-128-65.nay.redhat.com>
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
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
To: Orson Zhai <orsonzhai@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Petr Mladek <pmladek@suse.com>, Orson Zhai <orson.zhai@unisoc.com>, Baoquan He <bhe@redhat.com>, Stephen Boyd <sboyd@kernel.org>, zhang.lyra@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, John Stultz <john.stultz@linaro.org>, ruifeng.zhang1@unisoc.com, cixi.geng1@unisoc.com, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

On 08/11/20 at 12:40pm, Orson Zhai wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Timestamps printed in kernel log are retrieved by local_clock which reads
> jiffies as a referrence clock source.
> But it is diffcult to be synchronized with logs generated out of kernel,
> say some remote processors (Modem) in the Soc of mobile phones. 
> Jiffies will be unchanged when system is in suspend mode but Modem will
> not.
> 
> So timestamps are required to be compensated with suspend time in some
> complecated scenarios especially for Android system. As an initial
> implementation was rejected by Linus, Thomas made this patch [1] 2 yeas
> ago to replace ts_nsec with a struct ts that consists 3 types of time:
> mono, boot and real.
> 
> This is an updated version which comes from patch [1] written by Thomas
> and suggestion [2] about VMCORE_INFO given by Linus.
> 
> It provides the prerequisite code to print kernel logs with boot or real
> timestamp in the future.
> 
> [1] https://lore.kernel.org/lkml/alpine.DEB.2.20.1711142341130.2221@nanos/
> [2] https://lore.kernel.org/lkml/CA+55aFz-VvPBoW0RvDW4eN5YhwaUzcMvsYzrqEC41QdfOdiF4Q@mail.gmail.com/
> 
> Cc. Thomas Gleixner <tglx@linutronix.de>
> Cc. Linus Torvalds <torvalds@linux-foundation.org>
> Cc. Prarit Bhargava <prarit@redhat.com>
> Cc. Petr Mladek <pmladek@suse.com>
> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> Tested-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
> This patch has been tested in qemu-x86-system. One problem is the timestamp
> in kernel log will be printed [    0.000000] for longer time than before. 
> 
> 1 [    0.000000] microcode: microcode updated early to revision 0x28, date = 2019-11-12 
> 2 [    0.000000] Linux version 5.8.0+ (root@spreadtrum) (gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0, GNU ld (GNU Binutils for Ubuntu) 2.30) #2 SMP Fri Aug 7 21:30:51 CST 2020
> 3 [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.8.0+ root=UUID=4d889bca-be18-433d-9b86-c1c1714cc293 ro quiet splash vt.handoff=1
> 4 [    0.000000] KERNEL supported cpus: 
> 5 [    0.000000]   Intel GenuineIntel
> ....
> 223 [    0.000000]  Tracing variant of Tasks RCU enabled. 
> 224 [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies. 
> 225 [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4 
> 226 [    0.000000] NR_IRQS: 524544, nr_irqs: 456, preallocated irqs: 16 
> 227 [    0.059662] random: crng done (trusting CPU's manufacturer) 
>          ^^^^^^^^
> 228 [    0.059662] Console: colour dummy device 80x25 
> 229 [    0.059662] printk: console [tty0] enabled 
> 230 [    0.059662] ACPI: Core revision 20200528 
> 
> compared to old log:
> 
> 69 [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000021fdfffff] usable
> 70 [    0.000000] efi: EFI v2.31 by American Megatrends
> 71 [    0.000000] efi: ESRT=0xdbf69818 ACPI=0xdaef8000 ACPI 2.0=0xdaef8000 SMBIOS=0xf0480
> 72 [    0.000000] SMBIOS 2.8 present.
> 73 [    0.000000] DMI: LENOVO ThinkCentre M4500t-N000/, BIOS FCKT58AUS 09/17/2014
> 74 [    0.000000] tsc: Fast TSC calibration using PIT
> 75 [    0.000000] tsc: Detected 3292.477 MHz processor
> 76 [    0.000503] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
>         ^^^^^^^^
> 77 [    0.000504] e820: remove [mem 0x000a0000-0x000fffff] usable
> 78 [    0.000510] last_pfn = 0x21fe00 max_arch_pfn = 0x400000000
> 79 [    0.000513] MTRR default type: uncachable
>  
>  include/linux/crash_core.h  |  6 ++++--
>  include/linux/timekeeping.h | 15 +++++++++++++++
>  kernel/printk/printk.c      | 34 +++++++++++++++++++---------------
>  kernel/time/timekeeping.c   | 36 +++++++++++++++++++++++++-----------
>  4 files changed, 63 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 525510a..85b96cd 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -50,9 +50,11 @@ phys_addr_t paddr_vmcoreinfo_note(void);
>  #define VMCOREINFO_STRUCT_SIZE(name) \
>  	vmcoreinfo_append_str("SIZE(%s)=%lu\n", #name, \
>  			      (unsigned long)sizeof(struct name))
> -#define VMCOREINFO_OFFSET(name, field) \
> +#define VMCOREINFO_FIELD_OFFSET(name, field, offset) \
>  	vmcoreinfo_append_str("OFFSET(%s.%s)=%lu\n", #name, #field, \
> -			      (unsigned long)offsetof(struct name, field))
> +			      (unsigned long)offsetof(struct name, offset))
> +#define VMCOREINFO_OFFSET(name, field) \
> +	VMCOREINFO_FIELD_OFFSET(name, field, field)

We do not regard the VMCOREINFO* as a strict ABI,  makedumpfile and
crash tool can update to check the new field first then fallback to the old name.

These crash dump tools are not usual userspace applications, although we
try not to break them, but if we have to and a tool update can make it
work again then I suggest we go with the change instead of doing the
trick.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
