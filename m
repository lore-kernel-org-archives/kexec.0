Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20211030031832.165457-1-liaochang1@huawei.com>
 <20211030031832.165457-3-liaochang1@huawei.com>
Date: Fri, 29 Oct 2021 22:49:09 -0500
In-Reply-To: <20211030031832.165457-3-liaochang1@huawei.com> (Liao Chang's
 message of "Sat, 30 Oct 2021 11:18:31 +0800")
Message-ID: <87ee83goju.fsf@disp2133>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] RISC-V: use memcpy for kexec_file mode
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
To: Liao Chang <liaochang1@huawei.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, mick@ics.forth.gr, jszhang@kernel.org, guoren@linux.alibaba.com, penberg@kernel.org, sunnanyong@huawei.com, wangkefeng.wang@huawei.com, changbin.du@intel.com, alex@ghiti.fr, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org

Liao Chang <liaochang1@huawei.com> writes:

> The pointer to buffer loading kernel binaries is in kernel space for
> kexec_fil mode, When copy_from_user copies data from pointer to a block
> of memory, it checkes that the pointer is in the user space range, on
> RISCV-V that is:
>
> static inline bool __access_ok(unsigned long addr, unsigned long size)
> {
> 	return size <= TASK_SIZE && addr <= TASK_SIZE - size;
> }
>
> and TASK_SIZE is 0x4000000000 for 64-bits, which now causes
> copy_from_user to reject the access of the field 'buf' of struct
> kexec_segment that is in range [CONFIG_PAGE_OFFSET - VMALLOC_SIZE,
> CONFIG_PAGE_OFFSET), is invalid user space pointer.
>
> This patch fixes this issue by skipping access_ok(), use mempcy() instead.

I am a bit confused.

Why is machine_kexec ever calling copy_from_user?  That seems wrong in
all cases.

Even worse then having a copy_from_user is having data that you don't
know if you should call copy_from_user on.

There is most definitely a bug here.  Can someone please sort it out
without making the kernel guess what kind of memory it is copying from.

Eric



> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/riscv/kernel/machine_kexec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> index e6eca271a4d6..4a5db856919b 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -65,7 +65,9 @@ machine_kexec_prepare(struct kimage *image)
>  		if (image->segment[i].memsz <= sizeof(fdt))
>  			continue;
>  
> -		if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
> +		if (image->file_mode)
> +			memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
> +		else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
>  			continue;
>  
>  		if (fdt_check_header(&fdt))

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
