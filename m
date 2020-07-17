Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwIGb-0002LA-O0
 for kexec@lists.infradead.org; Fri, 17 Jul 2020 04:46:38 +0000
Subject: Re: [PATCH v3 02/12] powerpc/kexec_file: mark PPC64 specific code
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466085652.24747.2414199807974963385.stgit@hbathini.in.ibm.com>
 <87v9io8c13.fsf@morokweng.localdomain>
From: Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <63d551a9-684b-768b-8b0f-2a0da68d7f11@linux.ibm.com>
Date: Fri, 17 Jul 2020 10:16:25 +0530
MIME-Version: 1.0
In-Reply-To: <87v9io8c13.fsf@morokweng.localdomain>
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
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Pingfan Liu <piliu@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, Nayna Jain <nayna@linux.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>



On 16/07/20 7:19 am, Thiago Jung Bauermann wrote:
> 
> I didn't forget about this patch. I just wanted to see more of the
> changes before comenting on it.
> 
> Hari Bathini <hbathini@linux.ibm.com> writes:
> 
>> Some of the kexec_file_load code isn't PPC64 specific. Move PPC64
>> specific code from kexec/file_load.c to kexec/file_load_64.c. Also,
>> rename purgatory/trampoline.S to purgatory/trampoline_64.S in the
>> same spirit.
> 
> There's only a 64 bit implementation of kexec_file_load() so this is a
> somewhat theoretical exercise, but there's no harm in getting the code
> organized, so:
> 
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> I have just one question below.

<snip>

>> +/**
>> + * setup_new_fdt_ppc64 - Update the flattend device-tree of the kernel
>> + *                       being loaded.
>> + * @image:               kexec image being loaded.
>> + * @fdt:                 Flattened device tree for the next kernel.
>> + * @initrd_load_addr:    Address where the next initrd will be loaded.
>> + * @initrd_len:          Size of the next initrd, or 0 if there will be none.
>> + * @cmdline:             Command line for the next kernel, or NULL if there will
>> + *                       be none.
>> + *
>> + * Returns 0 on success, negative errno on error.
>> + */
>> +int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
>> +			unsigned long initrd_load_addr,
>> +			unsigned long initrd_len, const char *cmdline)
>> +{
>> +	int chosen_node, ret;
>> +
>> +	/* Remove memory reservation for the current device tree. */
>> +	ret = delete_fdt_mem_rsv(fdt, __pa(initial_boot_params),
>> +				 fdt_totalsize(initial_boot_params));
>> +	if (ret == 0)
>> +		pr_debug("Removed old device tree reservation.\n");
>> +	else if (ret != -ENOENT) {
>> +		pr_err("Failed to remove old device-tree reservation.\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = setup_new_fdt(image, fdt, initrd_load_addr, initrd_len,
>> +			    cmdline, &chosen_node);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
>> +	if (ret)
>> +		pr_err("Failed to update device-tree with linux,booted-from-kexec\n");
>> +
>> +	return ret;
>> +}
> 
> For setup_purgatory_ppc64() you start with an empty function and build
> from there, but for setup_new_fdt_ppc64() you moved some code here. Is
> the code above 64 bit specific?

Actually, I was not quiet sure if fdt updates like in patch 6 & patch 9 can be
done after setup_ima_buffer() call. If you can confirm, I will move them back
to setup_purgatory()

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
