Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A34606A31B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uTIpBaIR;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUJfm2yc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GIlQ2VvT2LAfPg0PCR5L09NY7XEmfwcF+cgluLtWyZ0=; b=uTIpBaIRa3hrYjp84B0d9zQapj
	UUA8Zlovwk7OIAqemS+xvFXswy7AuRzAVFHPh8vy+eg4j1vVOd/cQQbii1nvsmIgSh4ahR5ajcJQg
	XE9UI45JQ2BqH1C9a0fSGqjeUMF7Gmdbnfcmz124ieZaU6X4LxTVYqMIQjiA0NuVwucV+taIPBWZm
	t9ikWAhMhn9607Nc7B1AW65lf0vsv7zYyzcJcksXe2kUgRTXo+LguS7N7L8kVfDX0gqq5axBl51fb
	CuLa0CNzn+AU27gBx4ngN6mKZJJeHW6pnVmr981SpFXgtM9sJFrWQFrHu3SCnPYwE7YX4+ptupO+M
	BMC75X8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOTv8-00000004MeO-3Iys;
	Wed, 04 Nov 2026 05:52:26 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOTv7-00000004Me4-2ufd
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 05:52:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 28AFF41361;
	Wed,  4 Nov 2026 05:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE211F000C1;
	Wed,  4 Nov 2026 05:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793771545;
	bh=GIlQ2VvT2LAfPg0PCR5L09NY7XEmfwcF+cgluLtWyZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bUJfm2yc9VJCbJFfIPgIWTDdEXDNhfB7MRF9S1w49OHpjeAUDhrSi8dBhkKfn4RLi
	 dGwgHpC/E71AjK1uat9B4LANW3sblKPY4MW4+53iYKrLAnejBSCqKkbD0pbje7J1iC
	 h93GjzFbVIWchZj6bnB712/hTVtvi7+YkWN2cYNllrHuZjbbOTsXbBuTcZpdGpUiS6
	 Uoo+B6v4Gs8Q0up9qI5TOBUJlkzmEUweAeU5tEYHV5LlaeNklwuOoS7cZDh1qqD5iD
	 A/ntPHjpjocm5u7kuN5Gm5JIbzjvBfCp9lI4INRWhraY0EPm22yIj1xD133wE2sARv
	 JVMSJRGHTkFIg==
Message-ID: <sashiko-outbox-196696@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] powerpc/crash: Add only the onlined CPU's node to the
 crash FDT
To: "Vishal Chourasia" <vishalc@linux.ibm.com>, kexec@lists.infradead.org, x86@kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, sshegde@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, seanjc@google.com, samir@linux.ibm.com, sourabhjain@linux.ibm.com
In-Reply-To: <20261104053848.1381005-1-vishalc@linux.ibm.com>
References: <20261104053848.1381005-1-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 05:52:23 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] powerpc/crash: detached DLPAR CPU nodes accumulate in crash FDT in=
 update_crash_fdt()
- [High] powerpc/crash: incomplete CPU subnode left in FDT on fdt_setprop()=
 failure in update_crash_fdt()
--

commit f91f7035e04400925af984e21ed910579118bae0
Author: Vishal Chourasia <vishalc@linux.ibm.com>

powerpc/crash: Add only the onlined CPU's node to the crash FDT

This patch updates crash FDT handling on CPU online events to pass the onli=
ned
CPU number to arch_crash_handle_hotplug_event() and insert only that CPU's
device node into the crash FDT if it is not already present, rather than
rebuilding all CPU nodes via update_cpus_node().

> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index 775895f310379..ca37006bddeae 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
[ ... ]
> @@ -584,32 +585,71 @@ static int get_fdt_index(struct kimage *image)
>  }
> =20
>  /**
> - * update_crash_fdt - updates the cpus node of the crash FDT.
> + * update_crash_fdt - add the node of the onlined CPU to the crash FDT.
>   *
>   * @image: a pointer to kexec_crash_image
> + * @cpu: the CPU that was onlined
> + *
> + * The node is added as the first child of /cpus, the same position a no=
de
> + * attached to the live device tree takes. Nothing is done if the FDT al=
ready
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
> +	dn =3D of_get_cpu_node(cpu, NULL);
> +	if (!dn) {
> +		pr_err("No device node found for CPU %u\n", cpu);
> +		return;
> +	}
> =20
>  	fdt_index =3D get_fdt_index(image);
>  	if (fdt_index < 0) {
>  		pr_err("Unable to locate FDT segment.\n");
> -		return;
> +		goto put;
>  	}
> =20
>  	fdt =3D __va((void *)image->segment[fdt_index].mem);
> =20
> -	/* Temporarily invalidate the crash image while it is replaced */
> +	cpus_offset =3D fdt_path_offset(fdt, "/cpus");
> +	if (cpus_offset < 0) {
> +		pr_err("Malformed device tree: error reading /cpus node: %s\n",
> +		       fdt_strerror(cpus_offset));
> +		goto put;
> +	}
> +
> +	/* Node already present, e.g. an offlined CPU came back online */
> +	if (fdt_subnode_offset(fdt, cpus_offset, dn->full_name) >=3D 0)
> +		goto put;
> +
> +	/* Temporarily invalidate the crash image while it is updated */
>  	xchg(&kexec_crash_image, NULL);
> =20
> -	/* update FDT to reflect changes in CPU resources */
> -	if (update_cpus_node(fdt))
> -		pr_err("Failed to update crash FDT");
> +	node_offset =3D fdt_add_subnode(fdt, cpus_offset, dn->full_name);

[Severity: High]
What happens across DLPAR CPU removal and addition when update_crash_fdt()
only appends missing CPU nodes and never removes detached ones?

On pSeries, dlpar_cpu_remove() offlines the CPU threads (where
KEXEC_CRASH_HP_REMOVE_CPU is a no-op in arch_crash_handle_hotplug_event()),
pseries_cpuhp_detach_nodes() detaches the CPU device_node from /cpus in the
live device tree, and pseries_remove_processor() clears its bits in
cpu_present_mask so those logical CPU IDs can be reused.

Previously, update_cpus_node() deleted all existing cpu subnodes under /cpus
in the crash FDT and rebuilt them from the live /cpus tree, purging any
detached DLPAR CPU nodes. With this change, detached CPU subnodes remain in
the crash FDT indefinitely:

1. kdump_extra_fdt_size_ppc64() in arch/powerpc/kexec/file_load_64.c only
   budgets extra FDT space for possible_cpu_nodes concurrent CPU nodes:

	if (image->type =3D=3D KEXEC_TYPE_CRASH) {
		possible_cpu_nodes =3D num_possible_cpus() / threads_per_core;
		if (possible_cpu_nodes > cpu_nodes)
			extra_size +=3D (possible_cpu_nodes - cpu_nodes) * cpu_node_size();
	}

   When a CPU is DLPAR-removed and a CPU with a different DRC index is
   DLPAR-added, retaining the detached node alongside the newly added node
   exceeds possible_cpu_nodes and causes fdt_add_subnode() or fdt_setprop()=
 to
   fail with -FDT_ERR_NOSPACE.

2. Because detached nodes remain under /cpus in the crash FDT,
   smp_setup_cpu_maps() in the kdump kernel still iterates over them and
   assigns logical CPU IDs up to nr_cpu_ids, which can push valid present
   CPUs past nr_cpu_ids.

3. If the same DRC index is later DLPAR-added again via
   dlpar_configure_connector() with updated properties (such as
   ibm,associativity), fdt_subnode_offset(fdt, cpus_offset, dn->full_name) =
>=3D 0
   matches the stale node and skips updating its properties.

> +	if (node_offset < 0) {
> +		pr_err("Unable to add %s subnode: %s\n", dn->full_name,
> +		       fdt_strerror(node_offset));
> +		goto out;
> +	}
> =20
> +	for_each_property_of_node(dn, pp) {
> +		int ret =3D fdt_setprop(fdt, node_offset, pp->name, pp->value, pp->len=
gth);
> +
> +		if (ret < 0) {
> +			pr_err("Unable to add %s property: %s\n", pp->name,
> +			       fdt_strerror(ret));
> +			break;
> +		}
> +	}

[Severity: High]
If fdt_setprop() fails partway through copying the properties in
update_crash_fdt(), should node_offset be removed with fdt_del_node(fdt,
node_offset) before breaking out?

Leaving the partially populated subnode under /cpus has two consequences:

1. Any subsequent update_crash_fdt() call for sibling SMT threads of the sa=
me
   core (or a later re-online of the CPU) sees
   fdt_subnode_offset(fdt, cpus_offset, dn->full_name) >=3D 0 and returns e=
arly
   without populating the missing properties.

2. If the device_type =3D "cpu" property was written before fdt_setprop() f=
ailed
   on ibm,ppc-interrupt-server#s and reg, early_init_dt_scan_cpus() in
   arch/powerpc/kernel/prom.c will match the partial CPU node during kdump
   boot, get NULL for intserv with len left uninitialized, and dereference
   intserv[i]:

	intserv =3D of_get_flat_dt_prop(node, "ibm,ppc-interrupt-server#s", &len);
	if (!intserv)
		intserv =3D of_get_flat_dt_prop(node, "reg", &len);

	nthreads =3D len / sizeof(int);

	for (i =3D 0; i < nthreads; i++) {
		if (be32_to_cpu(intserv[i]) =3D=3D
			fdt_boot_cpuid_phys(initial_boot_params)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104053848.1381=
005-1-vishalc@linux.ibm.com?part=3D1

