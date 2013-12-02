Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnUw7-0007ao-VZ
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 14:57:24 +0000
Date: Mon, 2 Dec 2013 09:56:41 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v8] x86, apic, kexec, Documentation: Add disable_cpu_apic
 kernel parameter
Message-ID: <20131202145641.GB18642@redhat.com>
References: <52969DA3.5070000@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52969DA3.5070000@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: "H. Peter Anvin" <hpa@linux.intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Fengguang Wu <fengguang.wu@intel.com>, Jingbai Ma <jingbai.ma@hp.com>

On Thu, Nov 28, 2013 at 10:34:27AM +0900, HATAYAMA Daisuke wrote:

[..]
>  int generic_processor_info(int apicid, int version)
>  {
>  	int cpu, max = nr_cpu_ids;
> -	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
> +	/*
> +	 * boot_cpu_physical_apicid is designed to have the apicid
> +	 * returned by read_apic_id(), i.e, the apicid of the
> +	 * currently booting-up processor. However, on some platforms,
> +	 * it is temporarilly modified by the apicid reported as BSP
> +	 * through MP table. Concretely:
> +	 *
> +	 * - arch/x86/kernel/mpparse.c: MP_processor_info()
> +	 * - arch/x86/mm/amdtopology.c: amd_numa_init()
> +	 * - arch/x86/platform/visws/visws_quirks.c: MP_processor_info()
> +	 *
> +	 * This function is executed with the modified
> +	 * boot_cpu_physical_apicid. So, disabled_cpu_apicid kernel
> +	 * parameter doesn't work to disable APs on kdump 2nd kernel.
> +	 *
> +	 * Since fixing handling of boot_cpu_physical_apicid requires
> +	 * another discussion and tests on each platform, we leave it
> +	 * for now and here we use read_apic_id() directly in this
> +	 * function, generic_processor_info().
> +	 */
> +	bool boot_cpu_detected = physid_isset(read_apic_id(),
>  				phys_cpu_present_map);
>  
> +	if (disabled_cpu_apicid != BAD_APICID &&
> +	    disabled_cpu_apicid != read_apic_id() &&
> +	    disabled_cpu_apicid == apicid) {
> +		int thiscpu = num_processors + disabled_cpus;
> +
> +		pr_warning("ACPI: Disabling requested cpu."
> +			   " Processor %d/0x%x ignored.\n",
> +			   thiscpu, apicid);
> +
> +		disabled_cpus++;
> +		return -ENODEV;
> +	}
> +
>  	/*
>  	 * If boot cpu has not been detected yet, then only allow upto
>  	 * nr_cpu_ids - 1 processors and keep one slot free for boot cpu
>  	 */
>  	if (!boot_cpu_detected && num_processors >= nr_cpu_ids - 1 &&
> -	    apicid != boot_cpu_physical_apicid) {
> +	    apicid != read_apic_id()) {

I thought of using read_apic_id() only for disabled_cpu_apicid case.
Existing code seems to be working fine with boot_cpu_physical_apicid.
Instead of converting rest of the code to read_apic_id() we should fix
notion of boot_cpu_physical_id in a separate cleanup patch series.

IOW, can we please use read_apic_id() only for the case of
disabled_cpu_apicid and leave rest of the code untouched. And handle all
the cleanup in separate patch series.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
