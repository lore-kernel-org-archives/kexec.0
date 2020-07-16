Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvssw-000139-JA
 for kexec@lists.infradead.org; Thu, 16 Jul 2020 01:40:31 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466095278.24747.9161591016931052627.stgit@hbathini.in.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 08/12] ppc64/kexec_file: setup the stack for purgatory
In-reply-to: <159466095278.24747.9161591016931052627.stgit@hbathini.in.ibm.com>
Date: Wed, 15 Jul 2020 22:40:13 -0300
Message-ID: <87wo348cg2.fsf@morokweng.localdomain>
MIME-Version: 1.0
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
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Pingfan Liu <piliu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>


Sorry, forgot to send one comment for this patch:

Hari Bathini <hbathini@linux.ibm.com> writes:

> @@ -898,10 +900,37 @@ int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
>  			goto out;
>  	}
>
> +	/* Setup the stack top */
> +	stack_buf = kexec_purgatory_get_symbol_addr(image, "stack_buf");
> +	if (!stack_buf)
> +		goto out;
> +
> +	val = (u64)stack_buf + KEXEC_PURGATORY_STACK_SIZE;
> +	ret = kexec_purgatory_get_set_symbol(image, "stack", &val, sizeof(val),
> +					     false);
> +	if (ret)
> +		goto out;
> +
>  	/* Setup the TOC pointer */
>  	val = get_toc_ptr(&(image->purgatory_info));
>  	ret = kexec_purgatory_get_set_symbol(image, "my_toc", &val, sizeof(val),
>  					     false);
> +	if (ret)
> +		goto out;
> +
> +	/* Setup OPAL base & entry values */
> +	dn = of_find_node_by_path("/ibm,opal");
> +	if (dn) {
> +		of_property_read_u64(dn, "opal-base-address", &val);
> +		ret = kexec_purgatory_get_set_symbol(image, "opal_base", &val,
> +						     sizeof(val), false);
> +		if (ret)
> +			goto out;
> +
> +		of_property_read_u64(dn, "opal-entry-address", &val);
> +		ret = kexec_purgatory_get_set_symbol(image, "opal_entry", &val,
> +						     sizeof(val), false);

You need to call of_node_put(dn) here and in the if (ret) case above.

> +	}
>  out:
>  	if (ret)
>  		pr_err("Failed to setup purgatory symbols");

--
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
