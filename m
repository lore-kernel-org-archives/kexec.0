Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jylaM-0004Cz-7G
 for kexec@lists.infradead.org; Fri, 24 Jul 2020 00:29:15 +0000
References: <159524918900.20855.17709718993097359220.stgit@hbathini.in.ibm.com>
 <159524964786.20855.15850644504721928289.stgit@hbathini.in.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v4 09/12] ppc64/kexec_file: setup backup region for kdump
 kernel
In-reply-to: <159524964786.20855.15850644504721928289.stgit@hbathini.in.ibm.com>
Date: Thu, 23 Jul 2020 21:28:55 -0300
Message-ID: <874kpx69iw.fsf@morokweng.localdomain>
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
Cc: kernel test robot <lkp@intel.com>, Pingfan Liu <piliu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>


Hari Bathini <hbathini@linux.ibm.com> writes:

> Though kdump kernel boots from loaded address, the first 64K bytes
> of it is copied down to real 0. So, setup a backup region to copy
> the first 64K bytes of crashed kernel, in purgatory, before booting
> into kdump kernel. Also, update reserve map with backup region and
> crashed kernel's memory to avoid kdump kernel from accidentially
> using that memory.
>
> Reported-by: kernel test robot <lkp@intel.com>
> [lkp: In v1, purgatory() declaration was missing]
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Just one minor comment below:

> @@ -1047,13 +1120,26 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
>  			goto out;
>  		}
>
> -		/* Ensure we don't touch crashed kernel's memory */
> -		ret = fdt_add_mem_rsv(fdt, 0, crashk_res.start);
> +		/*
> +		 * Ensure we don't touch crashed kernel's memory except the
> +		 * first 64K of RAM, which will be backed up.
> +		 */
> +		ret = fdt_add_mem_rsv(fdt, BACKUP_SRC_SIZE,

I know BACKUP_SRC_START is 0, but please forgive my pedantry when I say
that I think it's clearer if the start address above is changed to
BACKUP_SRC_START + BACKUP_SRC_SIZE...

> +				      crashk_res.start - BACKUP_SRC_SIZE);
>  		if (ret) {
>  			pr_err("Error reserving crash memory: %s\n",
>  			       fdt_strerror(ret));
>  			goto out;
>  		}
> +
> +		/* Ensure backup region is not used by kdump/capture kernel */
> +		ret = fdt_add_mem_rsv(fdt, image->arch.backup_start,
> +				      BACKUP_SRC_SIZE);
> +		if (ret) {
> +			pr_err("Error reserving memory for backup: %s\n",
> +			       fdt_strerror(ret));
> +			goto out;
> +		}
>  	}
>
>  out:

--
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
