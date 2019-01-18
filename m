Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkSIM-00027M-FR
 for kexec@lists.infradead.org; Fri, 18 Jan 2019 11:26:43 +0000
Date: Fri, 18 Jan 2019 12:26:28 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 2/3] acpi: store acpi_rsdp address for later kexec usage
Message-ID: <20190118112628.GC622@zn.tnic>
References: <20190118111310.29589-1-kasong@redhat.com>
 <20190118111310.29589-3-kasong@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118111310.29589-3-kasong@redhat.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: rafael.j.wysocki@intel.com, bhe@redhat.com, erik.schmauss@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robert.moore@intel.com, linux-acpi@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, fanc.fnst@cn.fujitsu.com, lenb@kernel.org

On Fri, Jan 18, 2019 at 07:13:09PM +0800, Kairui Song wrote:
> Currently we have acpi_os_get_root_pointer as the universal function
> to get RSDP address. But the function itself and some functions it
> depends on are in .init section and make it not easy to retrieve the
> RSDP value once kernel is initialized.
> 
> And for kexec, it need to retrive RSDP again if EFI is disabled, because
> the second kernel will not be able get the RSDP value in such case, so
> it expects either the user specify the RSDP value using kernel cmdline,
> or kexec could retrive and pass the RSDP value using boot_params.
> 
> This patch stores the RSDP address when initialized is done, and
> introduce an acpi_os_get_root_pointer_late for later kexec usage.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  drivers/acpi/osl.c   | 10 ++++++++++
>  include/linux/acpi.h |  3 +++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index f29e427d0d1d..6340d34d0df1 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -187,6 +187,16 @@ static int __init setup_acpi_rsdp(char *arg)
>  	return kstrtoul(arg, 16, &acpi_rsdp);
>  }
>  early_param("acpi_rsdp", setup_acpi_rsdp);
> +
> +acpi_physical_address acpi_os_get_root_pointer_late(void) {
> +	return acpi_rsdp;
> +}
> +
> +static int __init acpi_store_root_pointer(void) {
> +	acpi_rsdp = acpi_os_get_root_pointer();
> +	return 0;
> +}

No, this is getting completely nuts: there's a bunch of functions which
all end up returning boot_params's field except pvh_get_root_pointer().

And now you're adding a late variant. And the cmdline paramater
acpi_rsdp is in a CONFIG_KEXEC wrapper, and and...

Wait until Chao Fan's stuff is applied, then do your changes ontop
an drop all that ifdeffery. We will make this RDSP thing enabled
unconditionally so that there's no need for ifdeffery and function
wrappers.

Also, after Chao's stuff, you won't need to call
acpi_os_get_root_pointer() because the early code would've done that.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
