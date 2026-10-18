Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A73CCF2CF
	for <kexec@archiver.kernel.org>; Sun, 18 Oct 2026 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vFOddHII9QlG0Yo7oJ9Fyf6IJ70eJag/SjOu44LBvf8=; b=RWmEZg8vcvlMcGGfCeR5q/BpHW
	2EDs7mlE1ep6V6RQIFHWMpgbOZf9tVuRExGhhwq7DUT2j+h2TbB0+67ClDE9mloaLlr2b2L3jIZOK
	0hg1bNdwWO7qdPuxy7DQQ6IhP1PVwPFjJaC7XCh4uQaU5ppgSigktPifv9tfHee4N1LJmU6FmIVuG
	qFwoC6aFMC1W9Xj87ufWZXpFlWy/1skY9TnTqGe0y//csZiZ04VBYhWmxjY2NJ7jg2vsGhzmze0mD
	qpLBoEHQGnjDjh4peFg6Ydk3dUCs4IwpSgNK9QM6Yf70jk430M/IIQC3aTeKIigxZCzLaRdGzSsvh
	NQCRCEgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIS98-00000005xMb-1NwS;
	Sun, 18 Oct 2026 14:45:58 +0000
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIS94-00000005xM6-2qWH
	for kexec@lists.infradead.org;
	Sun, 18 Oct 2026 14:45:56 +0000
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-5eac6c5f927so64775e0c.0
        for <kexec@lists.infradead.org>; Sun, 18 Oct 2026 07:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792334753; x=1792939553; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vFOddHII9QlG0Yo7oJ9Fyf6IJ70eJag/SjOu44LBvf8=;
        b=IR9PTMj8S189g0Wut64rrn2oYz7TgLunKWlMSzFfzUhSNfbQ1Wbphy1hLYWwP0mLI1
         Z727GDsdPelD47BumaDTAPv104eB8TOoT9MRu1mbQMDpsq0vnRFKjchjJXUulXSRFALf
         V9cCLMVUEIW3EABGY32jx1zIaV3SwSHtJcyQLq9pGz+U68Ci+VMKMowSeE0MPLPiEyFF
         fwGloW3G3maV6HzSQot3ds7I16qWO5GhvztQPAEEigUgJ0gEVaOi8oVvcUQfGFyr0VMz
         i90/2p1ORmnHyrBKaNSGdfiNz5CLu4igctdHcUt/lj7cjdln2XpIw2sbfHZOXNu6G4x+
         m4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792334753; x=1792939553;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vFOddHII9QlG0Yo7oJ9Fyf6IJ70eJag/SjOu44LBvf8=;
        b=BXeEzGBOZNqgQWrQV54tG/F0Fh+IBRi3eV62J3Z0LYLGln8yuS3HwvuT5cfRmQPHcS
         0lB/BW3ZYOIB/gQHl8c3oJ+NXEpDAG9e7eeP92s8bWCd56xvl46o1CcVIhesD6bmiuQh
         wR5bxuTgQfKb8nRMtPoeBceRKHIuYThCn4gLNtDDoCAaIM3t8OBz6/tVrp/jbskAooqL
         TGepN4hOkj5WLH/Hk1IxnQvnApQTONkJOkUX1me3vvQFTj9dV9+jt5iu0xa+hiRKCB6f
         Aj4H4JE8ZMr+bSU3wlq5X5yeUgqOcUYGIdZvI+fJwozUeWshs3zcbKeOPhZeXw06Lx3P
         LMpQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4tw78eC5Ndlvtsm7bk2L/kJbRNrqOP34441vjykJAN0vFAqp7fc8RtmHNQv78b5dOAScDJw==@lists.infradead.org
X-Gm-Message-State: AFq9FYI49hkw9QWMcWnFH76ucuP43gxo0o9FkTn8DwYar7XfEVH3lE0g
	Umlvvo9QdmllM40OnBQfgbiWTfIlaC6u7EJQRNbigjpRr/819SThAZYrbcyrygJ9g18=
X-Gm-Gg: AYBFou1Z9FoidG8HFFNrndkHNGTP0Rhk6JzXir6QnY1CqqRNp+TUkUZI/p5me6yvXUz
	o12nLCFB+qQdrWHZsvY7jd6CVJtlwxC3SqfDmCaEcLo5iimycZ5iVyMp4J6RuPqJScemroel446
	xO+uE7yUObGENTnQwWTNrmVFUcSzE1MxTG0Mde6e0EbozdyDKKRrKIcc+W4ukVcI1vXMlO3oIyX
	nu2fcDghMo3UrRNSsxmUokMlkQXRc3ABxaAfaxcTBFAdnyP6VHhwnyx5LZelcaMTdJkfiBeu33Q
	FgmMevES554rEznsIzBiiMVB6HbBone4GG2f2NTIT7Yfgw5bHAXVwt+S4Ly6ZY5B9XQSZ2ootkf
	IA3iYoKVKeMA7jwQxxcq9v73HD1Snp+LTCBy0vNq4iohKloUzPIXWHiviSb7ibexyJnWU50IJ5k
	PdHfg8nPAQDhLuxu4/t+Mz5BnyenTC6PnEHesSWfp8NyEcl2O5UmbaGL0UjTnjEt1HFtPID3xCQ
	5mNRjjIjq8binrqJBkVkW7W3DT3c8LmxrqjOp4PaeHbL8O6XNghRoKurJC6eIMGPJgU/3Zx4B8=
X-Received: by 2002:a05:6122:548:b0:5ea:c6c1:8dd4 with SMTP id 71dfb90a1353d-5eac6c19257mr145098e0c.5.1792334752976;
        Sun, 18 Oct 2026 07:45:52 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eaca7cc59asm244808e0c.5.2026.10.18.07.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 07:45:52 -0700 (PDT)
Date: Sun, 18 Oct 2026 10:45:51 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, kees@kernel.org,
	rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com,
	tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com,
	vincent.guittot@linaro.org, bp@alien8.de, thorsten.blum@linux.dev,
	cgroups@vger.kernel.org, tony.luck@intel.com, david@kernel.org,
	mingo@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
	seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn,
	dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com,
	tj@kernel.org, vbabka@kernel.org, linux-kernel@vger.kernel.org,
	peterz@infradead.org, surenb@google.com, hpa@zytor.com,
	x86@kernel.org, dmatlack@google.com, kexec@lists.infradead.org,
	pratyush@kernel.org, dave.hansen@linux.intel.com,
	rostedt@goodmis.org, gmonaco@redhat.com, jgross@suse.com,
	mgorman@suse.de, graf@amazon.com, linux-edac@vger.kernel.org,
	liam@infradead.org, ridong.chen@linux.dev, longman@redhat.com,
	bsegall@google.com
Subject: Re: [PATCH v1 7/8] sched/topology: Avoid redundant percpu
 allocations and bitmap walks in build_sched_domains()
Message-ID: <atTbn7WhHtK52vCi@google.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
 <20261015153331.1872641-8-pasha.tatashin@soleen.com>
 <1ec1aab8eabdad173ddef7483a940bfa3f6c3238.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ec1aab8eabdad173ddef7483a940bfa3f6c3238.camel@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_074555_458380_E3847B9A 
X-CRM114-Status: GOOD (  30.53  )
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

On 10-15 16:17, Tim Chen wrote:
> On Thu, 2026-10-15 at 11:33 -0400, Pasha Tatashin wrote:
> > During CPU hotplug, build_sched_domains() is invoked on every CPU
> > activation and deactivation. Profiling build_sched_domains() on a
> > 480-CPU Intel Xeon 6985P-C and a 512-CPU AMD EPYC 9B45 shows several
> > sources of avoidable O(N^2) and O(N) work per step:
> > 
> > 1. build_sched_groups() and build_overlap_sched_groups() iterate over
> >    every bit of sched_domain_span(sd) via for_each_cpu_wrap(i, span, cpu)
> >    and check cpumask_test_cpu(i, covered) one CPU at a time, even after
> >    entire child groups (e.g., 120-CPU NUMA nodes) have been added to
> >    covered. Instead, track the remaining uncovered CPUs
> >    (cpumask_copy(uncovered, span)), clear each built group's span with
> >    cpumask_andnot(), and advance directly to the next uncovered CPU.
> > 
> > 2. __visit_domain_allocation_hell() and __free_domain_allocs() allocate
> >    and free 3 * nr_levels + 2 temporary per-CPU pointer arrays via
> >    alloc_percpu() / free_percpu() on every domain rebuild. Reuse the
> >    per-CPU pointer arrays across domain rebuilds under
> >    sched_domains_mutex, clearing entries in __free_domain_allocs() and
> >    only freeing the topology-level arrays when sched_domain_topology is
> >    replaced in sched_init_numa() / sched_reset_numa().
> 
> sched_domains_mutex does not protect the free:
> 
> [snip]
> 
> >  #ifdef CONFIG_NUMA
> > +static void __sdt_free_percpu(void)
> > +{
> > +	struct sched_domain_topology_level *tl;
> > +
> > +	for_each_sd_topology(tl) {
> > +		struct sd_data *sdd = &tl->data;
> > +
> 
> sched_init_numa() and sched_reset_numa() are called from
> sched_update_numa(), which runs from sched_cpu_activate() and
> sched_cpu_deactivate() without sched_domains_mutex. The free is safe
> because every domain builder holds at least cpus_read_lock(), and
> sched_update_numa() runs under the hotplug write lock. 
> 
> Please fix the changelog and add lockdep_assert_cpus_held()
> in __sdt_free_percpu(), so a future caller cannot break this without a warning.

I will update the changelog to note that __sdt_free_percpu() is serialized 
against domain rebuilds by the CPU hotplug lock, and add
lockdep_assert_cpus_held() to __sdt_free_percpu().

> > +		free_percpu(sdd->sd);
> > +		sdd->sd = NULL;
> > +		free_percpu(sdd->sg);
> > +		sdd->sg = NULL;
> > +		free_percpu(sdd->sgc);
> > +		sdd->sgc = NULL;
> > +	}
> > +}
> > +
> >  static int cpu_numa_flags(void)
> >  {
> >  	return SD_NUMA;
> > @@ -2449,6 +2483,7 @@ void sched_init_numa(int offline_node)
> >  	/*
> >  	 * Copy the default topology bits..
> >  	 */
> > +	__sdt_free_percpu();
> >  	for (i = 0; sched_domain_topology[i].mask; i++)
> >  		tl[i] = sched_domain_topology[i];
> >  
> > @@ -2507,6 +2542,7 @@ static void sched_reset_numa(void)
> >  		kfree(masks);
> >  	}
> >  	if (sched_domain_topology_saved) {
> > +		__sdt_free_percpu();
> >  		kfree(sched_domain_topology);
> >  		sched_domain_topology = sched_domain_topology_saved;
> >  		sched_domain_topology_saved = NULL;
> > @@ -2708,17 +2744,23 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
> >  	for_each_sd_topology(tl) {
> >  		struct sd_data *sdd = &tl->data;
> >  
> > -		sdd->sd = alloc_percpu(struct sched_domain *);
> > -		if (!sdd->sd)
> > -			return -ENOMEM;
> > +		if (!sdd->sd) {
> > +			sdd->sd = alloc_percpu(struct sched_domain *);
> > +			if (!sdd->sd)
> > +				return -ENOMEM;
> > +		}
> >  
> > -		sdd->sg = alloc_percpu(struct sched_group *);
> > -		if (!sdd->sg)
> > -			return -ENOMEM;
> > +		if (!sdd->sg) {
> > +			sdd->sg = alloc_percpu(struct sched_group *);
> > +			if (!sdd->sg)
> > +				return -ENOMEM;
> > +		}
> >  
> > -		sdd->sgc = alloc_percpu(struct sched_group_capacity *);
> > -		if (!sdd->sgc)
> > -			return -ENOMEM;
> > +		if (!sdd->sgc) {
> > +			sdd->sgc = alloc_percpu(struct sched_group_capacity *);
> > +			if (!sdd->sgc)
> > +				return -ENOMEM;
> > +		}
> >  
> 
> Keeping the arrays also means every slot must be NULL when a build 
> starts. Patch 5 depends on that: get_group(), 
> init_overlap_sched_group() and init_sched_domain_shared() treat a NULL 
> slot as "not allocated yet", and the overlap fast path treats 
> "sgc->ref > 0" as "set up in this build". An old pointer would pass
> these checks and be used without a warning.
> 
> The rule holds today, but nothing says so. It also depends on builds
> never filling a slot outside cpu_map, because the clearing loops only
> visit cpu_map. Please write this down and check it, for example in
> __sdt_alloc():
> 
> 
> >  		for_each_cpu(j, cpu_map) {
> >  			struct sched_domain *sd;
> 
> Maybe add
> 
>         /*
>          * The slot arrays are kept between builds. Every slot for a CPU
>          * in cpu_map must be NULL here; lazy allocation treats NULL as
>          * "not allocated in this build". claim_allocations() and
>          * __sdt_free()/__sds_free() clear the slots, but only for
>          * cpu_map, so a build must not fill slots outside cpu_map.
>          */
>                 for_each_cpu(j, cpu_map) {
>                         struct sched_domain *sd;
> 
>                         WARN_ON_ONCE(*per_cpu_ptr(sdd->sd, j) ||
>                                      *per_cpu_ptr(sdd->sg, j) ||
>                                      *per_cpu_ptr(sdd->sgc, j));
> 

Sure, I will add the comment, and WARN_ON_ONCE.

> > @@ -2748,30 +2790,36 @@ static void __sdt_free(const struct cpumask *cpu_map)
> >  
> >  			if (sdd->sd) {
> >  				sd = *per_cpu_ptr(sdd->sd, j);
> > -				if (sd && (sd->flags & SD_NUMA))
> > -					free_sched_groups(sd->groups, 0);
> > -				kfree(*per_cpu_ptr(sdd->sd, j));
> > +				if (sd) {
> > +					if (sd->flags & SD_NUMA)
> > +						free_sched_groups(sd->groups, 0);
> > +					kfree(sd);
> > +					*per_cpu_ptr(sdd->sd, j) = NULL;
> > +				}
> >  			}
> >  
> > -			if (sdd->sg)
> > +			if (sdd->sg) {
> >  				kfree(*per_cpu_ptr(sdd->sg, j));
> > -			if (sdd->sgc)
> > +				*per_cpu_ptr(sdd->sg, j) = NULL;
> > +			}
> > +			if (sdd->sgc) {
> >  				kfree(*per_cpu_ptr(sdd->sgc, j));
> > +				*per_cpu_ptr(sdd->sgc, j) = NULL;
> > +			}
> >  		}
> > -		free_percpu(sdd->sd);
> > -		sdd->sd = NULL;
> > -		free_percpu(sdd->sg);
> > -		sdd->sg = NULL;
> > -		free_percpu(sdd->sgc);
> > -		sdd->sgc = NULL;
> >  	}
> >  }
> >  
> > +static struct sched_domain_shared * __percpu *sched_domains_sds;
> > +
> >  static int __sds_alloc(struct s_data *d, const struct cpumask *cpu_map)
> >  {
> 
> and maybe similar check 
> 
>         for_each_cpu(j, cpu_map)
>                 WARN_ON_ONCE(*per_cpu_ptr(d->sds, j));

I will add the comment and the WARN_ON_ONCE() checks in
both __sdt_alloc() and __sds_alloc() for v2.

Thanks,
Pasha

