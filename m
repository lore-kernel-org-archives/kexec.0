Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16A6C43334
	for <kexec@archiver.kernel.org>; Wed, 22 Jun 2022 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:Subject:From:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qeAAbEtDo4M8t8mRFNZhDzXAL/v96PtbDp1sRw9g7Ds=; b=07Kosz5PwBxgz+
	J2T2m6ePg+P2Y0JPjmwAPyQZsLpPwuG32zWNKOz9+GUQThGNXyJF4oUn5v/FrfJcCT9UJXHY14vFi
	zKhZ7cWA+VTFRzIBC5HNM+HOpPN91PtT0jCtuMmXUao28E+W7ZnY7jfFIca8MnvA35EllJWCQ/bmu
	4Vlyn0UzKfIWz2SMm7OipeCDB4b2fHuWhn2fikkMRiO+m0UGXavaCWviGKyH2TTNxM7x/roKXDmSK
	c09DMMm4xRME9afS6cNN6CE+PEjIPUifgH4dVtxy2Ys6WCjwolIXjjZ4OhxHmtse3NQwkfl4+rgPI
	kuWLoNJ3AxKnFx5OUopA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o420z-00B87e-8W; Wed, 22 Jun 2022 15:11:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o420s-00B85a-LY
	for kexec@lists.infradead.org; Wed, 22 Jun 2022 15:11:30 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MEFxv4006100;
	Wed, 22 Jun 2022 15:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4aR/eqNzP7f6fEUmgs0DXFBtNfPaEooLM6+JvaooyiM=;
 b=RukTGax4mdcTaiZsGrUxIC7Oyrbyprif8g4I8aoKsN0569y7UDH5SJwFbiLWzAPvS0kN
 vzURL9D8f6PZn5SOHw8mQs858yvKbTgUf9pdJbJTx32JfiyAKMRHUMhyzdqm0CfUgVAj
 czRvmpggaKeMSH/tOPZcrm3pwmoXh1THmbeGNg7862wwg43Penaw916eQ6ve7lmV9M3G
 YHzdj9ZKE+d0du8nZfgkCp7D6m2huxeln3KQHuGuTjEzAodWAv7ECrVhz6W4AEP6cB1P
 N7Z/tJWomdbZ79EDtwCn3SUbQG1OGTbj9fftHo0IyPp4F3Bl5Yww05bns+PnG2rD1qhc rg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gv4pq9eyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jun 2022 15:11:19 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25MF6rRF030811;
	Wed, 22 Jun 2022 15:11:18 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gv4pq9ey3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jun 2022 15:11:18 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25MF5b9d002394;
	Wed, 22 Jun 2022 15:11:16 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma03ams.nl.ibm.com with ESMTP id 3gs6b8wu07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jun 2022 15:11:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25MFBDTT16908668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jun 2022 15:11:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CAEC5204E;
	Wed, 22 Jun 2022 15:11:13 +0000 (GMT)
Received: from [9.145.21.142] (unknown [9.145.21.142])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0B4B65204F;
	Wed, 22 Jun 2022 15:11:13 +0000 (GMT)
Message-ID: <17712acb-cf52-42c1-3ab2-b88acc95e7e8@linux.ibm.com>
Date: Wed, 22 Jun 2022 17:11:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
From: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v5 3/5] powerpc/crash hp: add crash hotplug support for
 kexec_file_load
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
References: <20220620070106.93141-1-sourabhjain@linux.ibm.com>
 <20220620070106.93141-4-sourabhjain@linux.ibm.com>
Content-Language: fr
In-Reply-To: <20220620070106.93141-4-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9SNJJLbYf1QGdX6rawwV5DpBDaq0aErC
X-Proofpoint-GUID: lxldGJ8InGnCTVwvZpcjmBzb9dcuvdTN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_04,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206220075
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_081127_112856_9B4ADAB8 
X-CRM114-Status: GOOD (  46.55  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: eric.devolder@oracle.com, kexec@lists.infradead.org, bhe@redhat.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 20/06/2022, 09:01:04, Sourabh Jain wrote:
> Two major changes are done to enable the crash CPU hotplug handler.
> Firstly, updated the kexec load path to prepare kimage for hotplug
> changes, and secondly, implemented the arch specific crash hotplug
> handler.
> 
> On the kexec load path, the memsz allocation for the crash FDT segment
> is updated to ensure that it has sufficient buffer space to accommodate
> future hot add CPUs. Additionally, kimage_arch struct member fdt_index
             ^
           added ?
> is initialized with the index of FDT segment in kexec segment array.

May be you should mention that the index of FDT segment is recorded to not
fetch it at each hotplug operation.

> The crash hotplug handler updates the cpus node of crash FDT. While we
> update crash FDT the kexec_crash_image is marked invalid and restored
> after FDT update to avoid race.
> 
> Since memory crash hotplug support is not there yet the crash hotplug
> handler simply warns the user and returns.

It might be good to explain here why CPU hot remove operations are ignored.

> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/kexec/core_64.c      | 49 ++++++++++++++++++++
>  arch/powerpc/kexec/elf_64.c       | 74 +++++++++++++++++++++++++++++++
>  arch/powerpc/kexec/file_load_64.c |  5 +++
>  3 files changed, 128 insertions(+)
> 
> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
> index 65b3afb2169a..6d448b55dfad 100644
> --- a/arch/powerpc/kexec/core_64.c
> +++ b/arch/powerpc/kexec/core_64.c
> @@ -465,6 +465,55 @@ int update_cpus_node(void *fdt)
>  	return ret;
>  }
>  
> +#if defined(CONFIG_HOTPLUG_CPU)
> +
> +int crash_hotplug_support(void) { return 1; }
> +
> +/**
> + * arch_crash_hotplug_handler() - Handle hotplug kexec segements changes FDT, elfcorehdr
> + * @image: the active struct kimage
> + * @hp_action: the hot un/plug action being handled
> + * @cpu: when KEXEC_CRASH_HP_ADD/REMOVE_CPU, the cpu affected
> + *
> + * To accurately reflect CPU hot un/plug changes, the FDT
> + * must be updated with the new list of CPUs.
> + */
> +void arch_crash_handle_hotplug_event(struct kimage *image,
> +				     unsigned int hp_action, unsigned int cpu)
> +
> +{
> +	void *fdt;
> +
> +	/* No action needed for CPU hot-unplug */

Why?
I think your comment should explain why CPU hot-unplug operations are ignored?

> +	if (hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> +		return;
> +
> +	/* crash update on memory hotplug is not support yet */
> +	if (hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY || hp_action == KEXEC_CRASH_HP_ADD_MEMORY) {
> +		pr_info_once("crash hp: crash update is not supported with memory hotplug\n");
> +		return;
> +	}
> +
> +	/* Must have valid FDT index */
> +	if (!image->arch.fdt_index < 0) {

        if (image->arch.fdt_index >= 0) {

I think this is easier to read.

> +		pr_err("crash hp: unable to locate FDT segment");
> +		return;
> +	}
> +
> +	fdt = __va((void *)image->segment[image->arch.fdt_index].mem);
> +
> +	/* Temporarily invalidate the crash image while it is replaced */
> +	xchg(&kexec_crash_image, NULL);
> +
> +	/* update FDT to refelect changes to CPU resrouces */
> +	if (update_cpus_node(fdt))
> +		pr_err("crash hp: failed to update crash FDT");
> +
> +	/* The crash image is now valid once again */
> +	xchg(&kexec_crash_image, image);
> +}
> +#endif
> +
>  #ifdef CONFIG_PPC_64S_HASH_MMU
>  /* Values we need to export to the second kernel via the device tree. */
>  static unsigned long htab_base;
> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
> index eeb258002d1e..8ef18d6c3c32 100644
> --- a/arch/powerpc/kexec/elf_64.c
> +++ b/arch/powerpc/kexec/elf_64.c
> @@ -24,6 +24,68 @@
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  
> +#include <asm/kvm_book3s.h>
> +#include <asm/kvm_ppc.h>

Are these 2 KVM specifics headers really required?

> +
> +#if defined(CONFIG_HOTPLUG_CPU)
> +/**
> + * get_cpu_node_sz() - Calculate the space needed to store a CPU device
> + *		       type node in FDT. The calculation is done based on
> + *		       the existing CPU node in unflatten device tree. Loop
> + *		       through all the properties of the very first CPU type
> + *		       device node found in unflatten device tree and returns
> + *		       the sum of the property length and property string size
> + *		       of all properties of a CPU node.

This indentation style looks weird to me.

> + */
> +static int get_cpu_node_sz(void)
> +{
> +	struct device_node *dn = NULL;
There is no need to initialize dn here, it is assigned right after
> +	struct property *pp;
> +	int cpu_node_size = 0;
> +
> +	dn = of_find_node_by_type(NULL, "cpu");
> +
> +	if (!dn) {
> +		pr_warn("Unable to locate cpu device_type node.\n");
> +		goto out;
You could return 0 here, and remove the initialization of cpu_node_size.
> +	}
> +
> +	/* Every node in FDT starts with FDT_BEGIN_NODE and ends with
> +	 * FDT_END_NODE that takes one byte each.
> +	 */
> +	cpu_node_size = 2;
> +
> +	for_each_property_of_node(dn, pp) {
> +		/**
> +		 * For each property add two bytes extra. One for string null
> +		 * character for property name and other for FDT property start
> +		 * tag FDT_PROP.
> +		 */
> +		cpu_node_size = cpu_node_size + pp->length + strlen(pp->name) + 2;
                cpu_node_size += pp->length + strlen(pp->name) + 2;

This shortens a bit that line.

> +	}
> +
> +out:
> +	return cpu_node_size;
> +}
> +
> +/*
> + * get_crash_fdt_mem_sz() - calcuate mem size for crash kernel FDT
> + * @fdt: pointer to crash kernel FDT
> + *
> + * Calculate the buffer space needed to accommodate more CPU nodes in
> + * crash FDT post capture kernel load due to CPU hotplug events.
> + */
> +static unsigned int get_crash_fdt_mem_sz(void *fdt)
> +{
> +	int fdt_cpu_nodes_sz, offline_cpu_cnt;
> +
> +	offline_cpu_cnt = (num_possible_cpus() - num_present_cpus()) / MAX_SMT_THREADS;
> +	fdt_cpu_nodes_sz = get_cpu_node_sz() * offline_cpu_cnt;
> +
> +	return fdt_totalsize(fdt) + fdt_cpu_nodes_sz;
> +}
> +#endif
> +
>  static void *elf64_load(struct kimage *image, char *kernel_buf,
>  			unsigned long kernel_len, char *initrd,
>  			unsigned long initrd_len, char *cmdline,
> @@ -123,6 +185,18 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>  	kbuf.buf_align = PAGE_SIZE;
>  	kbuf.top_down = true;
>  	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +
> +#if defined(CONFIG_HOTPLUG_CPU)
> +	if (image->type == KEXEC_TYPE_CRASH) {
> +		kbuf.memsz = get_crash_fdt_mem_sz(fdt);

Why do you keep the previous assignment of kbuf.memsz few lines ago :

	kbuf.buffer = fdt;
	kbuf.bufsz = kbuf.memsz = fdt_totalsize(fdt);  <<<<<
	kbuf.buf_align = PAGE_SIZE;
	kbuf.top_down = true;
	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;

#if defined(CONFIG_HOTPLUG_CPU)
	if (image->type == KEXEC_TYPE_CRASH) {
		kbuf.memsz = get_crash_fdt_mem_sz(fdt);
		fdt_set_totalsize(fdt, kbuf.memsz);
		image->arch.fdt_index = image->nr_segments;
	} else
#endif
	{
		kbuf.memsz = fdt_totalsize(fdt);
	}

And what about kbuf.bufsz?


> +		fdt_set_totalsize(fdt, kbuf.memsz);
> +		image->arch.fdt_index = image->nr_segments;
> +	} else
> +#endif
> +	{
> +		kbuf.memsz = fdt_totalsize(fdt);

Why not setting image->arch.fdt_index to -1 here?

> +	}
> +
>  	ret = kexec_add_buffer(&kbuf);
>  	if (ret)
>  		goto out_free_fdt;
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index 57f991b0a9da..8345c4f5316d 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -1116,6 +1116,11 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
>  		return ret;
>  	}
>  
> +#if defined(CONFIG_HOTPLUG_CPU)
> +	/* Mark fdt_index invalid */
> +	image->arch.fdt_index = -1;

Why doing this here instead of elf64_load()?
I think your patch only applies to the ELF image format, isn't it?

Cheers,
Laurent.

> +#endif
> +
>  	return kexec_image_probe_default(image, buf, buf_len);
>  }
>  


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
