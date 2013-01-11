Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TthHq-0005To-M2
 for kexec@lists.infradead.org; Fri, 11 Jan 2013 16:16:55 +0000
Received: by mail-bk0-f47.google.com with SMTP id j4so1021971bkw.6
 for <kexec@lists.infradead.org>; Fri, 11 Jan 2013 08:16:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201301111333.49238.trenn@suse.de>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
 <1586060.uJlkOEQfVW@hammer82.arch.suse.de>
 <CAE9FiQVLVxj07TM1N6F2kmZdBYMUiS6Xz2bD-JZPtvps3a5-xw@mail.gmail.com>
 <201301111333.49238.trenn@suse.de>
Date: Fri, 11 Jan 2013 08:16:52 -0800
Message-ID: <CAE9FiQWPJdER++ZrkKx7cQpF0QvwBeghNjpFqK18pMNC0w20tw@mail.gmail.com>
Subject: Re: [PATCH] x86 e820: only void usable memory areas in
 memmap=exactmap case
From: Yinghai Lu <yinghai@kernel.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Thomas Renninger <trenn@suse.de>
Cc: horms@verge.net.au, Takao Indoh <indou.takao@jp.fujitsu.com>, MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

On Fri, Jan 11, 2013 at 4:33 AM, Thomas Renninger <trenn@suse.de> wrote:
>> yes, we have other user for debug  like simulating user memmap for some
>> bugs.
>> current problem for exactmap is that we don't scan that at first.
>> attached patch could help that.
>
> Yep, this is what I would have come up as well or similar. I looked
> at it, but I had no time for doing it and trying out.
>
> You may want to add:
> Reviewed-by: Thomas Renninger <trenn@suse.de>
> if someone reposts.

ok, I will add wrap it up and add changelog and test it then post it
with my for-x86-boot.

>
>    Thomas
>
> -------------------
> x86 e820: only void usable memory areas in memmap=exactmap case
>
> All unusable (reserved, ACPI, ACPI NVS,...) areas have to be
> honored in kdump case.
> Othwerise ACPI parts will quickly run into trouble when trying
> to for example early_ioremap reserved areas which are not
> declared reserved in kdump kernel.
> mmconf area must also be a reserved mem region.
> ...
>
> Passing unusable memory via memmap= is a design flaw as
> this information is already (exactly for this purpose) passed
> via bootloader structure.
> In kdump case (when memmap=exactmap is passed), only void
> (do not use) usable memory regions from the passed e820 table
> and use memory areas defined via memmap=X@Y boot parameter instead.
> But do still use the "unusable" memory regions from the original e820
> table.
>
> Signed-off-by: Thomas Renninger <trenn@suse.de>
>
> ---
>  arch/x86/kernel/e820.c |   19 ++++++++++++++++++-
>  1 files changed, 18 insertions(+), 1 deletions(-)
>
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index dc0b9f0..ae2d657 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -559,6 +559,19 @@ u64 __init e820_remove_range(u64 start, u64 size, unsigned old_type,
>         return real_removed_size;
>  }
>
> +static void __init e820_remove_range_type(u32 type)
> +{
> +       int i;
> +
> +       for (i = 0; i < e820.nr_map; i++) {
> +               struct e820entry *ei = &e820.map[i];
> +               if (ei->type == type) {
> +                       memset(ei, 0, sizeof(struct e820entry));
> +                       continue;
> +               }
> +       }
> +}
> +
>  void __init update_e820(void)
>  {
>         u32 nr_map;
> @@ -858,7 +871,11 @@ static int __init parse_memmap_one(char *p)
>                  */
>                 saved_max_pfn = e820_end_of_ram_pfn();
>  #endif
> -               e820.nr_map = 0;
> +               /*
> +                * Remove all usable memory (this is for kdump), usable
> +                * memory will be passed via memmap=X@Y parameter
> +                */
> +               e820_remove_range_type(E820_RAM);

We may need to keep exactmap intact.

but could add another one like exact_ram_map
or extend to have memmap=exactmap=ram or etc.

>                 userdef = 1;
>                 return 0;
>         }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
