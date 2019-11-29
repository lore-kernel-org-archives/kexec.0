Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH] efi: arm64: Introduce /sys/firmware/efi/memreserve to
 tell the persistent pages
References: <20191125184944.15556-1-msys.mizuma@gmail.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <c27b6f69-befc-0c88-24b9-7b89d4f6e5a6@gmail.com>
Date: Fri, 29 Nov 2019 13:25:36 +0100
MIME-Version: 1.0
In-Reply-To: <20191125184944.15556-1-msys.mizuma@gmail.com>
Content-Language: en-US
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
To: Masayoshi Mizuma <msys.mizuma@gmail.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, d.hatayama@fujitsu.com, Eric Biederman <ebiederm@xmission.com>



On 25/11/2019 19:49, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> kexec reboot stops in early boot sequence because efi_config_parse_tables()
> refers garbage data. We can see the log with memblock=debug kernel option:
> 
>   efi:  ACPI 2.0=0x9821790014  PROP=0x8757f5c0  SMBIOS 3.0=0x9820740000  MEMRESERVE=0x9820bfdc58
>   memblock_reserve: [0x0000009820bfdc58-0x0000009820bfdc67] efi_config_parse_tables+0x228/0x278
>   memblock_reserve: [0x0000000082760000-0x00000000324d07ff] efi_config_parse_tables+0x228/0x278
>   memblock_reserve: [0xcc4f84ecc0511670-0x5f6e5214a7fd91f9] efi_config_parse_tables+0x244/0x278
>   memblock_reserve: [0xd2fd4144b9af693d-0xad0c1db1086f40a2] efi_config_parse_tables+0x244/0x278
>   memblock_reserve: [0x0c719bb159b1fadc-0x5aa6e62a1417ce12] efi_config_parse_tables+0x244/0x278
>   ...
> 
> That happens because 0x82760000, struct linux_efi_memreserve, is destroyed.
> 0x82760000 is pointed from efi.mem_reseve, and efi.mem_reserve points the
> head page of LPI pending table and LPI property table which are allocated by
> gic_reserve_range().
> 
> The destroyer is kexec. kexec locates the initrd to the area:
> 
>   ]# kexec -d -l /boot/vmlinuz-5.4.0-rc7 /boot/initramfs-5.4.0-rc7.img --reuse-cmdline
>   ...
>   initrd: base 82290000, size 388dd8ah (59301258)
>   ...
> 
> From dynamic debug log. initrd is located in segment[1]:
>   machine_kexec_prepare:70:
>     kexec kimage info:
>       type:        0
>       start:       85b30680
>       head:        0
>       nr_segments: 4
>         segment[0]: 0000000080480000 - 0000000082290000, 0x1e10000 bytes, 481 pages
>         segment[1]: 0000000082290000 - 0000000085b20000, 0x3890000 bytes, 905 pages
>         segment[2]: 0000000085b20000 - 0000000085b30000, 0x10000 bytes, 1 pages
>         segment[3]: 0000000085b30000 - 0000000085b40000, 0x10000 bytes, 1 pages
> 
> kexec searches the memory region to locate initrd through
> "System RAM" in /proc/iomem. The pending tables are included in
> "System RAM" because they are allocated by alloc_pages(), so kexec
> destroys the LPI pending tables.
> 

Doesn't that mean that you haven't enough memory reserved so that you have to
fallback to allocate it via __get_free_page()?


> Introduce /sys/firmware/efi/memreserve to tell the pages pointed by
> efi.mem_reserve so that kexec can avoid the area to locate initrd.
> 

Doesn't that need a patch for kexec-tools to actually take this into account?

> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  drivers/firmware/efi/efi.c | 45 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index e98bbf8e5..0aa07cc09 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -141,6 +141,47 @@ static ssize_t systab_show(struct kobject *kobj,
>  
>  static struct kobj_attribute efi_attr_systab = __ATTR_RO_MODE(systab, 0400);
>  
> +static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
> +#ifdef CONFIG_KEXEC
> +static ssize_t memreserve_show(struct kobject *kobj,
> +			   struct kobj_attribute *attr, char *buf)
> +{
> +	struct linux_efi_memreserve *rsv;
> +	phys_addr_t start, end;
> +	unsigned long prsv;
> +	char *str = buf;
> +	int count, i;
> +
> +	if (!kobj || !buf)
> +		return -EINVAL;
> +
> +	if ((efi_memreserve_root == (void *)ULONG_MAX) ||
> +			(!efi_memreserve_root))
> +		return -ENODEV;
> +
> +	for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
> +		rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
> +		if (!rsv) {
> +			pr_err("Could not map efi_memreserve\n");
> +			return -ENOMEM;
> +		}
> +		count = atomic_read(&rsv->count);
> +		for (i = 0; i < count; i++) {
> +			start = rsv->entry[i].base;
> +			end = start + rsv->entry[i].size - 1;
> +
> +			str += sprintf(str, "%pa-%pa\n", &start, &end);

What happens if we provide a buf which is too small?

Regards,
Matthias

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
