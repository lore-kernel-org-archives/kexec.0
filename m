Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC386606A326
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bdTi4Kvh;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VVKuxieD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qA3iBaIijakHB1QdN+Ns5adqey4iVefqmbVMKWtw4sQ=; b=bdTi4KvhvgZROr
	t5eT0E/OTxuGihd93Fp9EfaQ5zilEN3JmeELRmP/ZOCb0F4BNk3XRWlkRfhWBCLieKgFPxPHj4tas
	kmoy9EnNlQ0Evb9a3HGZvMZXczrgleEjGCzv1FLEN/cZinHqQr+98w7xQWIIg+9UQ2WjJf6lOP4A6
	WWYeZPmz5yx1YMKW1gCWf8EJB/+Spy8LxXkVR8xJx+hbkRlWXVL1U8sOPAngUdDpOJsvv5TwDSQjQ
	nKAySUaMUeQLopsIH6G1iv7eU5P7fz48sn/RYBD3uLa2GDy6+Jnfu1Tm0KikIqRO5Bf5QFVE7/T6w
	2hKCLzEhLdAbKbfM6DvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOW8M-00000004gFV-1T7z;
	Wed, 04 Nov 2026 08:14:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOW8J-00000004gEl-0QCT
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 08:14:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793780048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qA3iBaIijakHB1QdN+Ns5adqey4iVefqmbVMKWtw4sQ=;
	b=VVKuxieDICgVV3B4nJooiXaIn/1q4TULaLbjBh/4XOSc4CoZ6wk7iay36yBurte4hTwqUf
	xyoYpNHThmyeyMZ36RiUIbGpG5Zyi8xBf7TjzUTwgps1H2OVpXQJVWLmsyG8PWN3e0Fmmx
	GM7AwBWC0fP1HT6Q8DYKb+K1RQ1qDQw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-p6z9OuWGP7W2ZcvN7mEKFg-1; Wed, 04 Nov 2026 03:14:07 -0500
X-MC-Unique: p6z9OuWGP7W2ZcvN7mEKFg-1
X-Mimecast-MFC-AGG-ID: p6z9OuWGP7W2ZcvN7mEKFg_1793780047
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89e05d31e54so420758b3a.1
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 00:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793780046; x=1794384846;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qA3iBaIijakHB1QdN+Ns5adqey4iVefqmbVMKWtw4sQ=;
        b=f/dIEia863jr8wKYCdPXgbGt2nynAAxuwzdZ5Cqg+fJ/z211teBpuZAq+t/ZWUSr2n
         aZgpRwBC2JIpl0EvdkGx0DdWLXccbg+AaI8b8a7w4PBVr8ckL662aE0/UGQ5m3MMwlEd
         AtTtR3t9Rm3nZ1oqr4L+64u7BCpzVhQ2n3cCxrQ+iPupTKB3ft3INj58rUPXULzfO2bI
         ATiFxieZVWEyYY7SadzUFr/TXVqEI5BLPjqFpRDW7IxHk7Rhp0SHj6gYGr0il7EwrkJa
         CRKEgReUbiN8fRGrPDLB8fcUP9xXZchyje8c7wmQ0G5HVoj2D0X+00tMPY0S3RCqWZAS
         Ezfw==
X-Forwarded-Encrypted: i=1; AKwUvBxMS5uIkGtcce4XrP9RGXBvlAPlQHesEy93ho6g+jIc+7nVVCVsTfEUxy/RUB9j4qU+CFYuZg==@lists.infradead.org
X-Gm-Message-State: APuU4Z8ZY7bvP5RDty3AopwvGqrKkPIn47ZpfVKEryeuUx/r+OD0HWT+
	B/7iv53SrcRAyjSxX33FQQlHLqMrv2dYhFm5RkrvPAbraakoCI2JGVR+mEtA0iE0z9eKiXJy/bl
	Wn9RL+LGkWH9gKGJXB19bmTVef8XcEq5SdldCbzSMpPhFVtYnhDF9t3oJzQ51vA==
X-Gm-Gg: AYBFou0v4WqRCPS7A1WKStkPFE0LBANtAUxA4Wb1A+4UiZlqHJAMLTJwj0DhVZq48Ck
	I9yraOYaVklKaWrHrH4lfYmROb2HHIxGWk+ov6TZDrWoHi9T2CKM6WIs/vinspxSw6nq6uAQ/2b
	CiThvo6hv4mU5Ic4SSM7Tk0WzGJbLNDFh+PT9/BgFDubMroDT3kB0T7sqZtyHukx0ZlnCjH4Eat
	YSwolQB6h6IE/PJpy9qVFn8h+HOO6rP4Ma1RqVVh3+iTJnP2NEGAlD7uvaTwmBCN4E9Og2KadTj
	H8gRiqWyAP8ip6O0HBdpGevXGmkkeCkm46Cfk2ImNz+0GJ1nhWFU0BA9xctrDtV33P9dqBWHQyX
	PhKxrBhZKtFHTXXBbUV93SyagsKgEd6WUFXBrw5AYhbIIgtk3jwxWt3lg249HZR4vTfhSYKx7ea
	sUyJ1QqDAh/US10Jd7VX+7pyzEz+IyYmhvAAAYd3o0SHc=
X-Received: by 2002:a05:6a00:a219:b0:89a:5:92c1 with SMTP id d2e1a72fcca58-8a9bffd58e4mr11887838b3a.56.1793780046363;
        Wed, 04 Nov 2026 00:14:06 -0800 (PST)
X-Received: by 2002:a05:6a00:a219:b0:89a:5:92c1 with SMTP id d2e1a72fcca58-8a9bffd58e4mr11887807b3a.56.1793780045818;
        Wed, 04 Nov 2026 00:14:05 -0800 (PST)
Received: from ?IPV6:2401:4900:1f28:63e0:edae:927e:c670:b679? ([2401:4900:1f28:63e0:edae:927e:c670:b679])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09b56926csm585851b3a.38.2026.11.04.00.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 00:14:05 -0800 (PST)
Message-ID: <e2f4e63c-481c-4e25-bc77-e890fcfaad95@redhat.com>
Date: Wed, 4 Nov 2026 13:43:56 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/crash: Add only the onlined CPU's node to the
 crash FDT
To: Vishal Chourasia <vishalc@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, sshegde@linux.ibm.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
 seanjc@google.com, samir@linux.ibm.com, sourabhjain@linux.ibm.com
References: <20261104053848.1381005-1-vishalc@linux.ibm.com>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20261104053848.1381005-1-vishalc@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ThrXC08sm_N1w4smbJsIZIC2UadEPZ5H_4wvkKmlEcU_1793780047
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_001411_222673_4FD4272E 
X-CRM114-Status: GOOD (  41.72  )
X-Spam-Score: -2.8 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hi Vishal,
On 04/11/26 11:08 am, Vishal Chourasia wrote:
> A CPU coming online never changes the nodes that are already in the FDT,
> so add only the node of that CPU. update_crash_fdt() looks up the device
> node of the onlined CPU and does nothing if the FDT already has a node of
> that name, which is the case when an offlined CPU comes back online. Only
> when the node is missing, the crash image is invalidated while the node is
> created with fdt_add_subnode() and its properties are copied from the live
> device node with fdt_setprop(). All of this is done directly in
> update_crash_fdt().
> 
> fdt_add_subnode() inserts the node as the first child of /cpus, which is
> the same position a node attached to the live device tree takes, so the
> FDT keeps the order of the live tree.
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>  arch/powerpc/kexec/crash.c | 65 +++++++++++++++++++++++++++++++-------
>  arch/x86/kernel/crash.c    |  2 +-
>  kernel/crash_core.c        | 11 +++++--
>  3 files changed, 64 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index 775895f31037..ca37006bddea 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -18,6 +18,7 @@
>  #include <linux/types.h>
>  #include <linux/libfdt.h>
>  #include <linux/memory.h>
> +#include <linux/of.h>
>  
>  #include <asm/processor.h>
>  #include <asm/machdep.h>
> @@ -584,32 +585,71 @@ static int get_fdt_index(struct kimage *image)
>  }
>  
>  /**
> - * update_crash_fdt - updates the cpus node of the crash FDT.
> + * update_crash_fdt - add the node of the onlined CPU to the crash FDT.
>   *
>   * @image: a pointer to kexec_crash_image
> + * @cpu: the CPU that was onlined
> + *
> + * The node is added as the first child of /cpus, the same position a node
> + * attached to the live device tree takes. Nothing is done if the FDT already
> + * has the node, for example when an offlined CPU comes back.
>   */
> -static void update_crash_fdt(struct kimage *image)
> +static void update_crash_fdt(struct kimage *image, unsigned int cpu)
>  {
> +	struct device_node *dn;
> +	struct property *pp;
>  	void *fdt;
> -	int fdt_index;
> +	int fdt_index, cpus_offset, node_offset;
> +
> +	dn = of_get_cpu_node(cpu, NULL);
> +	if (!dn) {
> +		pr_err("No device node found for CPU %u\n", cpu);
> +		return;
> +	}
>  
>  	fdt_index = get_fdt_index(image);
>  	if (fdt_index < 0) {
>  		pr_err("Unable to locate FDT segment.\n");
> -		return;
> +		goto put;
>  	}
>  
>  	fdt = __va((void *)image->segment[fdt_index].mem);
>  
> -	/* Temporarily invalidate the crash image while it is replaced */
> +	cpus_offset = fdt_path_offset(fdt, "/cpus");
> +	if (cpus_offset < 0) {
> +		pr_err("Malformed device tree: error reading /cpus node: %s\n",
> +		       fdt_strerror(cpus_offset));
> +		goto put;
> +	}
> +
> +	/* Node already present, e.g. an offlined CPU came back online */
> +	if (fdt_subnode_offset(fdt, cpus_offset, dn->full_name) >= 0)
> +		goto put;
> +
> +	/* Temporarily invalidate the crash image while it is updated */
>  	xchg(&kexec_crash_image, NULL);
>  
> -	/* update FDT to reflect changes in CPU resources */
> -	if (update_cpus_node(fdt))
> -		pr_err("Failed to update crash FDT");
> +	node_offset = fdt_add_subnode(fdt, cpus_offset, dn->full_name);
> +	if (node_offset < 0) {
> +		pr_err("Unable to add %s subnode: %s\n", dn->full_name,
> +		       fdt_strerror(node_offset));
> +		goto out;
> +	}
>  
> +	for_each_property_of_node(dn, pp) {
> +		int ret = fdt_setprop(fdt, node_offset, pp->name, pp->value, pp->length);
> +
> +		if (ret < 0) {
> +			pr_err("Unable to add %s property: %s\n", pp->name,
> +			       fdt_strerror(ret));
> +			break;
> +		}
If a property copy fails the loop just breaks and the image is
re-validated leaving a partially populated CPU node in the FDT. The
next hotplug event then sees the node as already present and never
repairs it so either drop or roll back the node on failure instead.

> +	}
> +out:
>  	/* The crash image is now valid once again */
>  	xchg(&kexec_crash_image, image);
> +put:
> +	of_node_put(dn);
>  }
>  
>  int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
> @@ -625,10 +665,11 @@ int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
>   * arch_crash_handle_hotplug_event - Handle crash CPU/Memory hotplug events to update the
>   *				     necessary kexec segments based on the hotplug event.
>   * @image: a pointer to kexec_crash_image
> - * @arg: struct memory_notify handler for memory hotplug case and NULL for CPU hotplug case.
> + * @arg: struct memory_notify handler for memory hotplug case and pointer to the
> + *	 cpu number for CPU hotplug case.
>   *
>   * Update the kdump image based on the type of hotplug event, represented by image->hp_action.
> - * CPU add: Update the FDT segment to include the newly added CPU.
> + * CPU add: Add the node of the newly added CPU to the FDT segment, if missing.
>   * CPU remove: No action is needed, with the assumption that it's okay to have offline CPUs
>   *	       part of the FDT.
>   * Memory add/remove: No action is taken as this is not yet supported.
> @@ -636,13 +677,15 @@ int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
>  void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>  {
>  	struct memory_notify *mn;
> +	unsigned int cpu;
>  
>  	switch (image->hp_action) {
>  	case KEXEC_CRASH_HP_REMOVE_CPU:
>  		return;
>  
>  	case KEXEC_CRASH_HP_ADD_CPU:
> -		update_crash_fdt(image);
> +		cpu = *(unsigned int *)arg;
> +		update_crash_fdt(image, cpu);
>  		break;
>  
>  	case KEXEC_CRASH_HP_REMOVE_MEMORY:
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index e6f23933a6df..1660f26f3a44 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -441,7 +441,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>   * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>   * @image: a pointer to kexec_crash_image
>   * @arg: struct memory_notify handler for memory hotplug case and
> - *       NULL for CPU hotplug case.
> + *       pointer to the cpu number (unused here) for CPU hotplug case.
>   *
>   * Prepare the new elfcorehdr and replace the existing elfcorehdr.
>   */
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index d0bd2d0cf899..53d4f2c1760c 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -651,6 +651,9 @@ int crash_check_hotplug_support(void)
>   * NR_CPUS and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
>   * excluded from SHA verification by default if the architecture
>   * supports crash hotplug.
> + *
> + * @arg is a struct memory_notify pointer for memory hotplug events and a
> + * pointer to the unsigned int cpu number for CPU hotplug events.
>   */
>  static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu, void *arg)
>  {
> @@ -676,10 +679,14 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>  		goto out;
>  
>  	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> -		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> +		hp_action == KEXEC_CRASH_HP_REMOVE_CPU) {
>  		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
> -	else
> +		/* CPU events are raised with no argument, the CPU number is passed instead */
> +		WARN_ON(arg);
> +		arg = &cpu;
> +	} else {
>  		pr_debug("hp_action %u\n", hp_action);
> +	}
>  
>  	/*
>  	 * The elfcorehdr_index is set to -1 when the struct kimage

-- 
Regards,
Mukesh Pilaniya


