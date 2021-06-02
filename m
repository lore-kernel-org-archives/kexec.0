Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 0/2] arm64: kexec_file_load vs memory reservations
References: <20210429133533.1750721-1-maz@kernel.org>
From: James Morse <james.morse@arm.com>
Message-ID: <edb33645-864f-6a2d-ce57-c542f8b79209@arm.com>
Date: Wed, 2 Jun 2021 15:22:00 +0100
MIME-Version: 1.0
In-Reply-To: <20210429133533.1750721-1-maz@kernel.org>
Content-Language: en-GB
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
To: Marc Zyngier <maz@kernel.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Eric Biederman <ebiederm@xmission.com>, Bhupesh Sharma <bhsharma@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kernel-team@android.com

Hi Marc,

On 29/04/2021 14:35, Marc Zyngier wrote:
> It recently became apparent that using kexec with kexec_file_load() on
> arm64 is pretty similar to playing Russian roulette.
> 
> Depending on the amount of memory, the HW supported and the firmware
> interface used, your secondary kernel may overwrite critical memory
> regions without which the secondary kernel cannot boot (the GICv3 LPI
> tables being a prime example of such reserved regions).
> 
> It turns out that there is at least two ways for reserved memory
> regions to be described to kexec: /proc/iomem for the userspace
> implementation, and memblock.reserved for kexec_file. 

One is spilled into the other by request_standard_resources()...


> And of course,
> our LPI tables are only reserved using the resource tree, leading to
> the aforementioned stamping.

Presumably well after efi_init() has run...

> Similar things could happen with ACPI tables as well.

efi_init() calls reserve_regions(), which has:
|	/* keep ACPI reclaim memory intact for kexec etc. */
|	if (md->type == EFI_ACPI_RECLAIM_MEMORY)
|		memblock_reserve(paddr, size);

This is also what stops mm from allocating them, as memblock-reserved gets copied into the
PG_Reserved flag by free_low_memory_core_early()'s calls to reserve_bootmem_region().

Is your machines firmware putting them in a region with a different type?

(The UEFI spec has something to say: see 2.3.6 "AArch64 Platforms":
| ACPI Tables loaded at boot time can be contained in memory of type EfiACPIReclaimMemory
| (recommended) or EfiACPIMemoryNVS

NVS would fail the is_usable_memory() check earlier, so gets treated as nomap)


Thanks,

James

> On my 24xA53 system artificially limited to 256MB of RAM (yes, it
> boots with that little memory), trying to kexec a secondary kernel
> failed every times. I can only presume that this was mostly tested
> using kdump, which preserves the entire kernel memory range.
> 
> This small series aims at triggering a discussion on what are the
> expectations for kexec_file, and whether we should unify the two
> reservation mechanisms.
> 
> And in the meantime, it gets things going...
> 
> Marc Zyngier (2):
>   firmware/efi: Tell memblock about EFI reservations
>   ACPI: arm64: Reserve the ACPI tables in memblock
> 
>  arch/arm64/kernel/acpi.c   |  1 +
>  drivers/firmware/efi/efi.c | 23 ++++++++++++++++++++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
