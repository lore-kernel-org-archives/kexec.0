Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WaNB7-0001ew-93
 for kexec@lists.infradead.org; Wed, 16 Apr 2014 10:34:54 +0000
Date: Wed, 16 Apr 2014 18:33:06 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Fwd: [PATCH] acpi: try to trust cpu_index from x86_cpu_to_apicid
Message-ID: <20140416103306.GD8084@dhcp-16-105.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org
Cc: d.hatayama@jp.fujitsu.com

Forward this to kexec mailing list.

Hi HATAYAMA,

Since you are very familiar with boot_cpu_physical_apicid and its change
related to kdump, could you help review this patch?

Thanks
Baoquan

> Date: Tue, 15 Apr 2014 07:55:54 +0800
> From: Baoquan He <bhe@redhat.com>
> To: linux-kernel@vger.kernel.org
> Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, jiang.liu@linux.intel.com, vgoyal@redhat.com, Baoquan He <bhe@redhat.com>
> Subject: [PATCH] acpi: try to trust cpu_index from x86_cpu_to_apicid
> 
> In smp with multi cpus, when enter into kdump kernel with only 1 cpu,
> a warning message is printed out:
> 
> acpi LNXCPU:0a: BIOS reported wrong ACPI id 0 for the processor
> 
> In this case kdump kernel use the same ACPI tables as 1st kernel,
> means lapic information is got from MADT. The acpi_id related to
> this cpu index and lapic_id may not be 0, so the code to assign
> value to cpu_index is not correct in this case per cpu0_initialized.
> cpu index stored in x86_cpu_to_apicid need be respected.
> 
> Now fix it in this patch per boot_cpu_physical_apicid. When cpu index
> related to boot_cpu_physical_apicid is not stored in x86_cpu_to_apicid,
> then we can say this is UP system running SMP kernel with no LAPIC in MADT
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  drivers/acpi/acpi_processor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index c29c2c3..1ae460c 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -267,7 +267,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>  	pr->apic_id = apic_id;
>  
>  	cpu_index = acpi_map_cpuid(pr->apic_id, pr->acpi_id);
> -	if (!cpu0_initialized) {
> +	if (!cpu0_initialized && (boot_cpu_physical_apicid == pr->apic_id)) {
>  		cpu0_initialized = 1;
>  		/* Handle UP system running SMP kernel, with no LAPIC in MADT */
>  		if ((cpu_index == -1) && (num_online_cpus() == 1))
> -- 
> 1.8.5.3
> 

----- End forwarded message -----

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
