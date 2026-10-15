Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AEECC6B38
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 23:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dU4UV7b10jQWXzZAx1LzF2HZTCcoK87Yy3TYJNTLgy0=; b=O/BGBmFp0TLNs2a7CqDhaPF875
	q6UJjwuWlpfMZA7htbaHutcSCXF7eny6BBF2nhyM9tNJZlFewsPG/03FkJem5cTSufxwb3irPjZE/
	ZhluYOrjhiNO50tI9eoOFoDThamLAFq/Y3wMwEBTKFkyAVeKHAJnqF9fkVkuTu7LPXyJ19pUCko0e
	yWjtwVUyTaPIC1yjdzV5jHbUt6GMvAuFsaoGEogw6IYo3rHxtBwSXZUgFIcc7nU2SPV+KS0Y2bzJx
	yT6XLYVo692gecaPwmyd/XenI3JMAs87i9SnuKKgwmPViWYh0mEWZxtoxQPQF5L1VVoF5/ZpCAuwq
	9R8rcGaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHUhv-00000001WeH-2PnB;
	Thu, 15 Oct 2026 23:17:55 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHUht-00000001Wds-2Rw4
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 23:17:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792106274; x=1823642274;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=Iich2VyA9Yl56RfAzD+pgFuU2K921AKcJLk7Up8k2OQ=;
  b=HVdg//wUtendD3P0ykTrxxacLPN9fPAlRa7kLTyCPwo6AaYtJap9RBzy
   cmNzwGKi3ar2Ut126Mvds/WRPbMms3h9d4qZSPoJssodyJ47ZjKRZSMLA
   IMyRbSTjMhrHt1lowkR/b1K79appsbJx1LGE+pYaS0LdA68Ly6cznKAfB
   ZSplddCrw0GGCvL+6MAU26bSHqI/WXi6Dsm1/5Qa27WloR2VCUsA0Lb00
   LrGpSgS0nQnOHZMxlZbtPdMie2udugtCqJ0v8HeJTXaEzoQ6v/zsHh4PT
   FmXDcgfju10Ytahyp+VXTwbRtEW8lTBH0ZZ/2j/u0E9UBp/0pQzdjkQ27
   g==;
X-CSE-ConnectionGUID: F/fSqu2dRqKsxM2MJbUY3Q==
X-CSE-MsgGUID: FdvrSTgVSO2HEYCaRG8B9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="781042"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="781042"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 16:17:51 -0700
X-CSE-ConnectionGUID: QPDXIi4JQEuXWbbkvfN5YQ==
X-CSE-MsgGUID: KujZTx+hRAChXpirRYufLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1904693"
Received: from unknown (HELO [10.241.242.105]) ([10.241.242.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 16:17:49 -0700
Message-ID: <1ec1aab8eabdad173ddef7483a940bfa3f6c3238.camel@linux.intel.com>
Subject: Re: [PATCH v1 7/8] sched/topology: Avoid redundant percpu
 allocations and bitmap walks in build_sched_domains()
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, kees@kernel.org, 
	rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com,
 tglx@kernel.org, 	vschneid@redhat.com, kprateek.nayak@amd.com,
 vincent.guittot@linaro.org, 	bp@alien8.de, thorsten.blum@linux.dev,
 cgroups@vger.kernel.org, 	tony.luck@intel.com, david@kernel.org,
 mingo@redhat.com, akpm@linux-foundation.org, 	linux-mm@kvack.org,
 seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn, 
	dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com,
 tj@kernel.org, 	vbabka@kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org, 	surenb@google.com, hpa@zytor.com, x86@kernel.org,
 dmatlack@google.com, 	kexec@lists.infradead.org, pratyush@kernel.org,
 dave.hansen@linux.intel.com, 	rostedt@goodmis.org, gmonaco@redhat.com,
 jgross@suse.com, mgorman@suse.de, 	graf@amazon.com,
 linux-edac@vger.kernel.org, liam@infradead.org, 	ridong.chen@linux.dev,
 longman@redhat.com, bsegall@google.com
Date: Thu, 15 Oct 2026 16:17:48 -0700
In-Reply-To: <20261015153331.1872641-8-pasha.tatashin@soleen.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
	 <20261015153331.1872641-8-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_161753_732259_8E00F48A 
X-CRM114-Status: GOOD (  22.79  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, 2026-10-15 at 11:33 -0400, Pasha Tatashin wrote:
> During CPU hotplug, build_sched_domains() is invoked on every CPU
> activation and deactivation. Profiling build_sched_domains() on a
> 480-CPU Intel Xeon 6985P-C and a 512-CPU AMD EPYC 9B45 shows several
> sources of avoidable O(N^2) and O(N) work per step:
>=20
> 1. build_sched_groups() and build_overlap_sched_groups() iterate over
>    every bit of sched_domain_span(sd) via for_each_cpu_wrap(i, span, cpu)
>    and check cpumask_test_cpu(i, covered) one CPU at a time, even after
>    entire child groups (e.g., 120-CPU NUMA nodes) have been added to
>    covered. Instead, track the remaining uncovered CPUs
>    (cpumask_copy(uncovered, span)), clear each built group's span with
>    cpumask_andnot(), and advance directly to the next uncovered CPU.
>=20
> 2. __visit_domain_allocation_hell() and __free_domain_allocs() allocate
>    and free 3 * nr_levels + 2 temporary per-CPU pointer arrays via
>    alloc_percpu() / free_percpu() on every domain rebuild. Reuse the
>    per-CPU pointer arrays across domain rebuilds under
>    sched_domains_mutex, clearing entries in __free_domain_allocs() and
>    only freeing the topology-level arrays when sched_domain_topology is
>    replaced in sched_init_numa() / sched_reset_numa().

sched_domains_mutex does not protect the free:

[snip]

>  #ifdef CONFIG_NUMA
> +static void __sdt_free_percpu(void)
> +{
> +	struct sched_domain_topology_level *tl;
> +
> +	for_each_sd_topology(tl) {
> +		struct sd_data *sdd =3D &tl->data;
> +

sched_init_numa() and sched_reset_numa() are called from
sched_update_numa(), which runs from sched_cpu_activate() and
sched_cpu_deactivate() without sched_domains_mutex. The free is safe
because every domain builder holds at least cpus_read_lock(), and
sched_update_numa() runs under the hotplug write lock.=C2=A0

Please fix the changelog and add lockdep_assert_cpus_held()
in __sdt_free_percpu(), so a future caller cannot break this without a warn=
ing.



> +		free_percpu(sdd->sd);
> +		sdd->sd =3D NULL;
> +		free_percpu(sdd->sg);
> +		sdd->sg =3D NULL;
> +		free_percpu(sdd->sgc);
> +		sdd->sgc =3D NULL;
> +	}
> +}
> +
>  static int cpu_numa_flags(void)
>  {
>  	return SD_NUMA;
> @@ -2449,6 +2483,7 @@ void sched_init_numa(int offline_node)
>  	/*
>  	 * Copy the default topology bits..
>  	 */
> +	__sdt_free_percpu();
>  	for (i =3D 0; sched_domain_topology[i].mask; i++)
>  		tl[i] =3D sched_domain_topology[i];
> =20
> @@ -2507,6 +2542,7 @@ static void sched_reset_numa(void)
>  		kfree(masks);
>  	}
>  	if (sched_domain_topology_saved) {
> +		__sdt_free_percpu();
>  		kfree(sched_domain_topology);
>  		sched_domain_topology =3D sched_domain_topology_saved;
>  		sched_domain_topology_saved =3D NULL;
> @@ -2708,17 +2744,23 @@ static int __sdt_alloc(const struct cpumask *cpu_=
map)
>  	for_each_sd_topology(tl) {
>  		struct sd_data *sdd =3D &tl->data;
> =20
> -		sdd->sd =3D alloc_percpu(struct sched_domain *);
> -		if (!sdd->sd)
> -			return -ENOMEM;
> +		if (!sdd->sd) {
> +			sdd->sd =3D alloc_percpu(struct sched_domain *);
> +			if (!sdd->sd)
> +				return -ENOMEM;
> +		}
> =20
> -		sdd->sg =3D alloc_percpu(struct sched_group *);
> -		if (!sdd->sg)
> -			return -ENOMEM;
> +		if (!sdd->sg) {
> +			sdd->sg =3D alloc_percpu(struct sched_group *);
> +			if (!sdd->sg)
> +				return -ENOMEM;
> +		}
> =20
> -		sdd->sgc =3D alloc_percpu(struct sched_group_capacity *);
> -		if (!sdd->sgc)
> -			return -ENOMEM;
> +		if (!sdd->sgc) {
> +			sdd->sgc =3D alloc_percpu(struct sched_group_capacity *);
> +			if (!sdd->sgc)
> +				return -ENOMEM;
> +		}
> =20

Keeping the arrays also means every slot must be NULL when a build=20
starts. Patch 5 depends on that: get_group(),=20
init_overlap_sched_group() and init_sched_domain_shared() treat a NULL=20
slot as "not allocated yet", and the overlap fast path treats=20
"sgc->ref > 0" as "set up in this build". An old pointer would pass
these checks and be used without a warning.

The rule holds today, but nothing says so. It also depends on builds
never filling a slot outside cpu_map, because the clearing loops only
visit cpu_map. Please write this down and check it, for example in
__sdt_alloc():


>  		for_each_cpu(j, cpu_map) {
>  			struct sched_domain *sd;

Maybe add

        /*
         * The slot arrays are kept between builds. Every slot for a CPU
         * in cpu_map must be NULL here; lazy allocation treats NULL as
         * "not allocated in this build". claim_allocations() and
         * __sdt_free()/__sds_free() clear the slots, but only for
         * cpu_map, so a build must not fill slots outside cpu_map.
         */
                for_each_cpu(j, cpu_map) {
                        struct sched_domain *sd;

                        WARN_ON_ONCE(*per_cpu_ptr(sdd->sd, j) ||
                                     *per_cpu_ptr(sdd->sg, j) ||
                                     *per_cpu_ptr(sdd->sgc, j));



> @@ -2748,30 +2790,36 @@ static void __sdt_free(const struct cpumask *cpu_=
map)
> =20
>  			if (sdd->sd) {
>  				sd =3D *per_cpu_ptr(sdd->sd, j);
> -				if (sd && (sd->flags & SD_NUMA))
> -					free_sched_groups(sd->groups, 0);
> -				kfree(*per_cpu_ptr(sdd->sd, j));
> +				if (sd) {
> +					if (sd->flags & SD_NUMA)
> +						free_sched_groups(sd->groups, 0);
> +					kfree(sd);
> +					*per_cpu_ptr(sdd->sd, j) =3D NULL;
> +				}
>  			}
> =20
> -			if (sdd->sg)
> +			if (sdd->sg) {
>  				kfree(*per_cpu_ptr(sdd->sg, j));
> -			if (sdd->sgc)
> +				*per_cpu_ptr(sdd->sg, j) =3D NULL;
> +			}
> +			if (sdd->sgc) {
>  				kfree(*per_cpu_ptr(sdd->sgc, j));
> +				*per_cpu_ptr(sdd->sgc, j) =3D NULL;
> +			}
>  		}
> -		free_percpu(sdd->sd);
> -		sdd->sd =3D NULL;
> -		free_percpu(sdd->sg);
> -		sdd->sg =3D NULL;
> -		free_percpu(sdd->sgc);
> -		sdd->sgc =3D NULL;
>  	}
>  }
> =20
> +static struct sched_domain_shared * __percpu *sched_domains_sds;
> +
>  static int __sds_alloc(struct s_data *d, const struct cpumask *cpu_map)
>  {

and maybe similar check=20

        for_each_cpu(j, cpu_map)
                WARN_ON_ONCE(*per_cpu_ptr(d->sds, j));

> -	d->sds =3D alloc_percpu(struct sched_domain_shared *);
> -	if (!d->sds)
> -		return -ENOMEM;
> +	if (!sched_domains_sds) {
> +		sched_domains_sds =3D alloc_percpu(struct sched_domain_shared *);
> +		if (!sched_domains_sds)
> +			return -ENOMEM;
> +	}
> +	d->sds =3D sched_domains_sds;
> =20
>  	return 0;
>  }


Thanks.

Tim

