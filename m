Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 3 May 2021 11:57:42 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: arm64: Reserve the ACPI tables in memblock
Message-ID: <YJBHpjvlIsSO5bOD@epycbox.lan>
References: <20210429133533.1750721-1-maz@kernel.org>
 <20210429133533.1750721-3-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210429133533.1750721-3-maz@kernel.org>
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
To: Marc Zyngier <maz@kernel.org>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Eric Biederman <ebiederm@xmission.com>, Bhupesh Sharma <bhsharma@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kernel-team@android.com

Marc,

On Thu, Apr 29, 2021 at 02:35:33PM +0100, Marc Zyngier wrote:
> Just like the EFI reservations, ACPI tables can be stamped over
> by kexec_file_load(), and the secondary kernel will be unable to
> recover from such corruption.
> 
> It looks like our x86 friends have been there before, and have
> recently added some infratructure that does what we need since
> 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by ACPI
> tables"), though it appears to exist for different reasons.
> 
> Let's call into acpi_reserve_initial_tables() early so that
> our tables are protected from the big bad kexec.
> 

Feel free to add (and/or):

Tested-by: Moritz Fischer <mdf@kernel.org>
Reported-by: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kernel/acpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index cada0b816c8a..5b5406c92ee4 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -233,6 +233,7 @@ void __init acpi_boot_table_init(void)
>  		if (earlycon_acpi_spcr_enable)
>  			early_init_dt_scan_chosen_stdout();
>  	} else {
> +		acpi_reserve_initial_tables();
>  		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
>  		if (IS_ENABLED(CONFIG_ACPI_BGRT))
>  			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
> -- 
> 2.29.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Thanks,
Moritz

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
