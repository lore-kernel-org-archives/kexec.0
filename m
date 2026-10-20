Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5C606A31A
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 01:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vBgg1UCO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdB4N2SO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BbfVyiLzAYz1jww3q4dZuBThU7PqcGq6KA0OFEb1pwU=; b=vBgg1UCOES5yMG8UYBBPMjESeL
	UkbubeHplUBJ7HZBS/cxwIH0P4+akOTV6PCtv7VWVIbR9EgIIp2EE6xfGTVMPg964IIbX2EdTO9hq
	/egFl5/It8iSbI3E48U+iDuMVTJmxA+v8tjOxvLxl/N0IwIwEKZkwrdAix0htdJcJAvFo5kqcgWuo
	h4dUWU0/LmIis2PBbNiI88uyjY42+ksi6O5r7+k374B4ASTLVfaDojxXuXQ+6Qw15vNDVHEIUB4w1
	D2bXAdREKZKDGjOIAV2LPdhYS//kPPPFgFoCcUv4zGuLov+3B9KBbAs5diA4VBk9DnTgWbKqyz305
	xD+1y1TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIySD-00000008bI7-34ec;
	Tue, 20 Oct 2026 01:15:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIySC-00000008bHY-1FQ6
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 01:15:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 27DA543D14;
	Tue, 20 Oct 2026 01:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21B31F000C4;
	Tue, 20 Oct 2026 01:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792458947;
	bh=BbfVyiLzAYz1jww3q4dZuBThU7PqcGq6KA0OFEb1pwU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kdB4N2SOIqUWpm0JJ3MUocWUhSoZePEBg6SIgOxt+p+I11HqdgsBKzHL3Vlq/Eqwo
	 ZePzu913xUp+oUIweXZEp1wKjPW37qkJBdR/c13yVt/8vnbfRopwfuOxwM7Q/+ENNw
	 ZDSFyDSy6u0kIoIZOKbWFlfKDTB7nqs1tufl2SaDe5WOXsGBlBAKkRbYSYKCaNct76
	 7pvDRhLY6OF4/3x+QRzmTb5I71VE//C3fnWNKqo/RmRCYMw7I5aVnXFZsiF3Bulk66
	 IhyAUYDeD4PRxdHL+RU4s97Ne9PQTXiP1p446uxB7/O1hph48TJVELyx6T1nIrDXop
	 69qxbguaUyltw==
Message-ID: <sashiko-outbox-178403@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] x86/smp: Remove unnecessary WBINVD from
 mwait_play_dead()
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, kees@kernel.org, rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com, tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com, vincent.guittot@linaro.org, bp@alien8.de, jpoimboe@kernel.org, tony.luck@intel.com, david@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org, seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com, vbabka@kernel.org, peterz@infradead.org, surenb@google.com, hpa@zytor.com, x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com, kexec@lists.infradead.org, pratyush@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org, gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de, graf@amazon.com, liam@infradead.org, ridong.chen@linux.dev, blum@kernel.org, longman@redhat.com, bsegall@google.com
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261019011446.834487-3-pasha.tatashin@soleen.com>
References: <20261019011446.834487-1-pasha.tatashin@soleen.com>
 <20261019011446.834487-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 01:15:44 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/smp: skipping wbinvd() in mwait_play_dead() breaks KVM wbinvd_=
dirty_mask
--

commit 52dafb51edf021a7aaa6017af5d2ddd2b493e51b
Author: Pasha Tatashin <pasha.tatashin@soleen.com>

x86/smp: Remove unnecessary WBINVD from mwait_play_dead()

This commit skips the wbinvd() call in mwait_play_dead() when entering an
MWAIT C-state deeper than C1/C1E while another CPU sharing the same
package and LLC remains online.

> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index ba01a9e919b78..0dccd2f927bb6 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1414,10 +1414,28 @@ void play_dead_common(void)
>  	local_irq_disable();
>  }
> =20
> -/*
> - * We need to flush the caches before going to sleep, lest we have
> - * dirty data in our caches when we come back up.
> - */
> +static bool mwait_play_dead_needs_wbinvd(unsigned int eax_hint)
> +{
> +	unsigned int cpu =3D smp_processor_id();
> +	u32 pkg_id =3D topology_physical_package_id(cpu);
> +	u32 llc_id =3D per_cpu_llc_id(cpu);
> +	unsigned int i;
> +
> +	if (cpuhp_tasks_frozen || MWAIT_HINT2CSTATE(eax_hint) < 2 ||
> +	    llc_id =3D=3D BAD_APICID || this_cpu_read(cache_state_incoherent)) {
> +		return true;
> +	}
> +
> +	for_each_online_cpu(i) {
> +		if (topology_physical_package_id(i) =3D=3D pkg_id &&
> +		    per_cpu_llc_id(i) =3D=3D llc_id) {
> +			return false;
> +		}
> +	}

[Severity: High]
Can skipping wbinvd() in mwait_play_dead_needs_wbinvd() when another CPU in
the same LLC is online leave a KVM guest's dirty cache lines unflushed in
the shared LLC when emulating guest WBINVD?

For KVM vCPUs with non-coherent DMA enabled (need_emulate_wbinvd(vcpu)),
KVM does not use wbinvd_on_all_cpus(). Instead, kvm_arch_vcpu_load() tracks
only the specific physical CPU where the vCPU ran in
vcpu->arch.wbinvd_dirty_mask (or flushes vcpu->cpu via wbinvd_on_cpu()):

arch/x86/kvm/x86.c:kvm_arch_vcpu_load() {
    ...
	if (need_emulate_wbinvd(vcpu)) {
		if (kvm_x86_call(has_wbinvd_exit)())
			cpumask_set_cpu(cpu, vcpu->arch.wbinvd_dirty_mask);
		else if (vcpu->cpu !=3D -1 && vcpu->cpu !=3D cpu)
			wbinvd_on_cpu(vcpu->cpu);
	}
    ...
}

When the guest later executes WBINVD, kvm_emulate_wbinvd_noskip() flushes
only the CPUs recorded in vcpu->arch.wbinvd_dirty_mask and clears the mask:

arch/x86/kvm/x86.c:kvm_emulate_wbinvd_noskip() {
    ...
	if (kvm_x86_call(has_wbinvd_exit)()) {
		int cpu =3D get_cpu();

		cpumask_set_cpu(cpu, vcpu->arch.wbinvd_dirty_mask);
		wbinvd_on_cpus_mask(vcpu->arch.wbinvd_dirty_mask);
		put_cpu();
		cpumask_clear(vcpu->arch.wbinvd_dirty_mask);
	} else
		wbinvd();
    ...
}

wbinvd_on_cpus_mask() calls on_each_cpu_mask() ->
smp_call_function_many_cond(), which filters the target mask against
cpu_online_mask:

kernel/smp.c:smp_call_function_many_cond() {
    ...
	if (cpumask_any_and_but(mask, cpu_online_mask, this_cpu) < nr_cpu_ids) {
		cpumask_and(cpumask, mask, cpu_online_mask);
    ...
}

If a vCPU runs on physical CPU A (in LLC 0), migrates to CPU B (in LLC 1),
and CPU A goes offline via mwait_play_dead() while sibling CPU C in LLC 0
remains online, CPU A will now skip wbinvd() and only flush its core
caches into LLC 0 (or leave lines in shared L1/L2 if CPU C is an SMT
sibling).

If the vCPU never ran on CPU C, CPU C is not in
vcpu->arch.wbinvd_dirty_mask. When the guest subsequently executes WBINVD,
wbinvd_on_cpus_mask() ignores the offline CPU A and never sends an IPI to
CPU C, leaving the guest's dirty lines in LLC 0 unflushed to DRAM before
clearing vcpu->arch.wbinvd_dirty_mask.

> +
> +	return true;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019011446.8344=
87-1-pasha.tatashin@soleen.com?part=3D2

