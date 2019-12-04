Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
Subject: RE: [PATCH v2 2/2] efi: arm64: Introduce /proc/efi/memreserve to tell
 the persistent pages
Date: Wed, 4 Dec 2019 08:50:44 +0000
Message-ID: <OSBPR01MB400616833DA3511C46279AD3955D0@OSBPR01MB4006.jpnprd01.prod.outlook.com>
References: <20191203201410.28045-1-msys.mizuma@gmail.com>
 <20191203201410.28045-3-msys.mizuma@gmail.com>
In-Reply-To: <20191203201410.28045-3-msys.mizuma@gmail.com>
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: 'Masayoshi Mizuma' <msys.mizuma@gmail.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "m.mizuma@jp.fujitsu.com" <m.mizuma@jp.fujitsu.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Masayoshi Mizuma
> Sent: Wednesday, December 4, 2019 5:14 AM
> To: Ard Biesheuvel <ard.biesheuvel@linaro.org>;
> linux-arm-kernel@lists.infradead.org; linux-efi@vger.kernel.org
> Cc: Masayoshi Mizuma <msys.mizuma@gmail.com>; Mizuma, Masayoshi/水間 理仁
> <m.mizuma@jp.fujitsu.com>; linux-kernel@vger.kernel.org;
> kexec@lists.infradead.org; Hatayama, Daisuke/畑山 大輔
> <d.hatayama@fujitsu.com>; Eric Biederman <ebiederm@xmission.com>; Matthias
> Brugger <matthias.bgg@gmail.com>
> Subject: [PATCH v2 2/2] efi: arm64: Introduce /proc/efi/memreserve to tell the
> persistent pages
> 
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> kexec reboot stops in early boot sequence because efi_config_parse_tables()
> refers garbage data. We can see the log with memblock=debug kernel option:
> 
>   efi:  ACPI 2.0=0x9821790014  PROP=0x8757f5c0  SMBIOS 3.0=0x9820740000
> MEMRESERVE=0x9820bfdc58
>   memblock_reserve: [0x0000009820bfdc58-0x0000009820bfdc67]
> efi_config_parse_tables+0x228/0x278
>   memblock_reserve: [0x0000000082760000-0x00000000324d07ff]
> efi_config_parse_tables+0x228/0x278
>   memblock_reserve: [0xcc4f84ecc0511670-0x5f6e5214a7fd91f9]
> efi_config_parse_tables+0x244/0x278
>   memblock_reserve: [0xd2fd4144b9af693d-0xad0c1db1086f40a2]
> efi_config_parse_tables+0x244/0x278
>   memblock_reserve: [0x0c719bb159b1fadc-0x5aa6e62a1417ce12]
> efi_config_parse_tables+0x244/0x278
>   ...
> 
> That happens because 0x82760000, struct linux_efi_memreserve, is destroyed.
> 0x82760000 is pointed from efi.mem_reseve, and efi.mem_reserve points the
> head page of LPI pending table and LPI property table which are allocated by
> gic_reserve_range().
> 
> The destroyer is kexec. kexec locates the initrd to the area:
> 
>   ]# kexec -d -l /boot/vmlinuz-5.4.0-rc7 /boot/initramfs-5.4.0-rc7.img
> --reuse-cmdline
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
>         segment[0]: 0000000080480000 - 0000000082290000, 0x1e10000 bytes, 481
> pages
>         segment[1]: 0000000082290000 - 0000000085b20000, 0x3890000 bytes, 905
> pages
>         segment[2]: 0000000085b20000 - 0000000085b30000, 0x10000 bytes, 1
> pages
>         segment[3]: 0000000085b30000 - 0000000085b40000, 0x10000 bytes, 1
> pages
> 
> kexec searches the memory region to locate initrd through
> "System RAM" in /proc/iomem. The pending tables are included in
> "System RAM" because they are allocated by alloc_pages(), so kexec
> destroys the LPI pending tables.
> 
> Introduce /proc/efi/memreserve to tell the pages pointed by
> efi.mem_reserve so that kexec can avoid the area to locate initrd.
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  drivers/firmware/efi/efi.c | 75 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index d8157cb34..80bbe0b3e 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -325,17 +325,87 @@ static __init int efivar_ssdt_load(void)
>  static inline int efivar_ssdt_load(void) { return 0; }
>  #endif
> 
> +static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
> +
>  #ifdef CONFIG_PROC_FS
>  static struct proc_dir_entry *proc_efi;
> +#ifdef CONFIG_KEXEC
> +static int memreserve_show(struct seq_file *m, void *v)
> +{
> +	struct linux_efi_memreserve *rsv;
> +	phys_addr_t start, end;
> +	unsigned long prsv;
> +	int count, i;
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
> +			seq_printf(m, "%pa-%pa\n", &start, &end);
> +		}

It looks to me that we reach the same issue as sysfs if
memreserve_show() calls seq_printf multiple times this way.
Default buffer size of struct seq_file is also PAGE_SIZE.
We can configure default buffer size using single_open_size(),
but I think it better to do the same thing as /proc/iomem
(and /proc/mounts and many others) than choosing a certain
size as default value.

Looking into implementation of /proc/iomem, its show method, r_show(),
calls seq_printf() only once; in other words, r_show() is
called the number of lines of /proc/iomem, which is equal to
the number of resource objects. Then, there is no buffer size
issue because "%pa-%pa\n" consumes at most (16 + 16 + 2) bytes
per line.

How about doing as /proc/iomem?

> +		memunmap(rsv);
> +	}
> +
> +	return 0;
> +}
> +
> +static int memreserve_open(struct inode *inode, struct file *filp)
> +{
> +	return single_open(filp, memreserve_show, NULL);
> +}
> +
> +static const struct file_operations memreserve_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= memreserve_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static int __init efi_proc_memreserve(void)
> +{
> +	struct proc_dir_entry *pde;
> +
> +	if ((efi_memreserve_root == (void *)ULONG_MAX) ||
> +			(!efi_memreserve_root))
> +		return 0;
> +
> +	pde = proc_create("memreserve", 0444, proc_efi, &memreserve_fops);
> +	if (!pde) {
> +		pr_err("/proc/efi: Cannot create /proc/efi/memreserve
> file.\n");
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +#else
> +static inline int efi_proc_memreserve(void) { return 0; }
> +#endif /* CONFIG_KEXEC */
> +
>  static int __init efi_proc_init(void)
>  {
> +	int error = 1;
> +
>  	proc_efi = proc_mkdir("efi", NULL);
>  	if (!proc_efi) {
>  		pr_err("/proc/efi: Cannot create /proc/efi directroy.\n");
> -		return 1;
> +		return error;
>  	}
> 
> -	return 0;
> +	error = efi_proc_memreserve();
> +
> +	return error;
>  }
>  #else
>  static inline int efi_proc_init(void) { return 0; }
> @@ -986,7 +1056,6 @@ int efi_status_to_err(efi_status_t status)
>  }
> 
>  static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
> -static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
> 
>  static int __init efi_memreserve_map_root(void)
>  {
> --
> 2.18.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
