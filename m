Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F3ACCF2CF
	for <kexec@archiver.kernel.org>; Sun, 18 Oct 2026 14:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=briTVmjslxeUx0FiA5Z2sKc9bXZYk9yUUpEJ168UtpQ=; b=GoL/5GfsGoK8pixEglfRoonOXZ
	Eq89HWw9tmSV5UfMZAgmOMobgb1xBCz+jwz7c4B6JboYxLprC07ONxZRxO6wQJeUYjMmwKV0geW+f
	CdkaxdsyuSUvMISfXM0CqO3RoQJA6P4ccaalKyyoqBfNN/rsuTL57Nczib9OozJ6oZxrO2AmEk1Lq
	XG2IGmOjjooHoFcqKXiZAuIMXx+DbGCmWsacJS/ptn3YTevxzLqW1hepGqAMNnvaXnvBcsbaNR2vV
	nYjApIpaGiAF0lv1F+D8Ffk2WBwQAC9u2QxG0/QIVA9ebB2Y+wUtMmOmG9mj1ZU7iiGELdwaxdKgP
	KDGGMKtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIRyw-00000005wco-3K4Q;
	Sun, 18 Oct 2026 14:35:26 +0000
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIRyt-00000005wcT-1HtL
	for kexec@lists.infradead.org;
	Sun, 18 Oct 2026 14:35:24 +0000
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-5eaa1b5b84aso1822702e0c.0
        for <kexec@lists.infradead.org>; Sun, 18 Oct 2026 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792334122; x=1792938922; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=briTVmjslxeUx0FiA5Z2sKc9bXZYk9yUUpEJ168UtpQ=;
        b=A6u5+JLAyRo5q8hz29MDjcBlvJqIbeA5+YNjdFXJFmFpIlnjL+ZTwzfQVShmhyDSTG
         944mZoUpL1erKRdpx3MjISetxp75wl/441sp6b1sVI5SmZjO39RAZnwh+LwZOQgeoGhO
         G998HG1ibqSbD8gxlsqPD2euqfX0QNaMBg2B3vARnUX8arI7prgTFZw8WXNHlzMu9qfJ
         y0JUCklM9UBxl0+QNvsHIkf8e0kfpRtU3JJ1r0ODRgNHY5skPLc96L3byugKZyMlXtCU
         /UBwQHDsuMUKLDln+lS9bHbqPlzwN50O5A1EbmrBQJAjKMgNyY5C6jxySu9E8TuhE1yJ
         /HBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792334122; x=1792938922;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=briTVmjslxeUx0FiA5Z2sKc9bXZYk9yUUpEJ168UtpQ=;
        b=qzphual4KdA4wFkgmkftbommPl7lIyzaszM8wHgErMC3OyS36tTrk+p49WlTHvjUPD
         o82Sky0CN7c056h8xh5/u65UygSDjQSXT8JbuiTXwvQBzaI3TN38CHMy73Sg+LmfwXTV
         zAWX7QzrZ/eYd2htTIJC6ZBtbt8Lh5Ag8vCTjJj0Rz9TRvotB65XYENaFFejiA/0qzf4
         ccN13QlazNao+FSJ3vnzpBhDceT6n8MMqaD8xn9wLDM4wZ6GTF4BydsUKbySCcY/DOje
         pTZ3LS+7dFup2ovA7ibmw8iyp1XrfpUV0/HC1UbF3B+z5OD4uuWa5U3N5gJVZ3dDSzAW
         rMdA==
X-Forwarded-Encrypted: i=1; AKwUvByLqtFZXpQ3vzxr21EZN1YEtFu8+rVF40lCAtesM2F8Wk1svdPXP5+TQWTDZhopvh3vIalbSw==@lists.infradead.org
X-Gm-Message-State: AFq9FYJlFoeO90Ac2NkRhjIRNfi+Lo9M4au78m7d4ar03pxieLSqZw3B
	zkpQkcj444elGZX2cUlykzn6YJTIXvTky4FpG6XLxaeL136xTsnfyakAR9kq3OsTIN8=
X-Gm-Gg: AYBFou3Ok9AQQuXrXpwuEQWY1UF8GaK8E+5jJJmECp3PnUk8wmJ5sIREH8TMBncDw33
	p+M9hpUWyiNRnKg2wMqQufzsrqxCYczat/FvUTTuPYn+KsM6bRINdwg5qZLM8rvU1hUQ1aMuVWe
	HZoS3FlmnTPSRVwm6945/+NSYzE7/P01Dbevf94orP8w8gq2W6l3lIRbPDD6j5+17turIxW00sD
	E9ZBH8cv2DW6rhDCYeQqOm+WM3geDrdjMvzO4p1swA/UKxg8xfau/42LICV94ReII3SeDI3PxP+
	uP38WJ9lUThACxYl8O7BNrfevZhicyl+UmL6OWDtrzAtmk6mZ45shm5ZYDbl5BDlOVXLlgtrHmD
	lkZgHzD3fKQllzar7g3M+mm2HmdpArF1f6SVhAURu8cqvT4Q4ZKH/T/0lkNxWm+JJ438qgGJfP1
	qQC6Z/grK3Kgg5PJh3X2zwXt3MMPugjP/e7nbKJ3RXT7/+Elr/Z6hcFzTJHF09U4YKcb/yBZGfR
	gtoDCbcrbL67ENHm6DY/aoOb0SCGx/40lAJRy5MqVrn3PhDxW1d3DH4pchw/Tly9DhX2BfjZC8=
X-Received: by 2002:ac5:c64e:0:b0:5ea:ca0a:374d with SMTP id 71dfb90a1353d-5eaca0a3bd0mr42477e0c.17.1792334122018;
        Sun, 18 Oct 2026 07:35:22 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eac20d6aa6sm1663781e0c.7.2026.10.18.07.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 07:35:20 -0700 (PDT)
Date: Sun, 18 Oct 2026 10:35:19 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, kees@kernel.org,
	rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com,
	tglx@kernel.org, vschneid@redhat.com, vincent.guittot@linaro.org,
	bp@alien8.de, thorsten.blum@linux.dev, cgroups@vger.kernel.org,
	tony.luck@intel.com, david@kernel.org, mingo@redhat.com,
	akpm@linux-foundation.org, linux-mm@kvack.org, seanjc@google.com,
	ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com,
	mhocko@suse.com, vinicius.gomes@intel.com, tj@kernel.org,
	vbabka@kernel.org, linux-kernel@vger.kernel.org,
	peterz@infradead.org, surenb@google.com, hpa@zytor.com,
	x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com,
	kexec@lists.infradead.org, pratyush@kernel.org,
	dave.hansen@linux.intel.com, rostedt@goodmis.org,
	gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de,
	graf@amazon.com, linux-edac@vger.kernel.org, liam@infradead.org,
	ridong.chen@linux.dev, longman@redhat.com, bsegall@google.com
Subject: Re: [PATCH v1 5/8] sched/topology: Avoid redundant O(N^3) group
 capacity walks and unused allocations in build_sched_domains()
Message-ID: <atTZJ6Q3vTjvDjgG@google.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
 <20261015153331.1872641-6-pasha.tatashin@soleen.com>
 <b618f528-ba35-4fb3-881b-e0ca12bc9558@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b618f528-ba35-4fb3-881b-e0ca12bc9558@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_073523_674492_185E11B4 
X-CRM114-Status: GOOD (  31.90  )
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

On 10-16 11:53, K Prateek Nayak wrote:
> Hello Pasha,
> 
> On 10/15/2026 9:03 PM, Pasha Tatashin wrote:
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 0248227d983a7..02c38089a80c9 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -1259,32 +1259,49 @@ build_group_from_child_sched_domain(struct sched_domain *sd, int cpu)
> >         return sg;
> >  }
> > 
> > -static void init_overlap_sched_group(struct sched_domain *sd,
> > -                                    struct sched_group *sg)
> > +static int init_overlap_sched_group(struct sched_domain *sd,
> > +                                   struct sched_group *sg)
> >  {
> >         struct cpumask *mask = sched_domains_tmpmask2;
> >         struct sd_data *sdd = sd->private;
> > -       struct cpumask *sg_span;
> > -       int cpu;
> > +       struct cpumask *sg_span = sched_group_span(sg);
> > +       struct sched_group_capacity *sgc;
> > +       int cpu = cpumask_first(sg_span);
> > +       struct sched_domain *first_sd = *per_cpu_ptr(sdd->sd, cpu);
> > +
> > +       sgc = *per_cpu_ptr(sdd->sgc, cpu);
> > +       if (sgc && atomic_read(&sgc->ref) > 0 &&
> > +           first_sd && first_sd->child &&
> > +           cpumask_equal(sg_span, sched_domain_span(first_sd->child))) {
> > +               atomic_inc(&sgc->ref);
> > +               sg->sgc = sgc;
> > +               return 0;
> > +       }
> 
> 
> This insanely specific check perhaps can be something like:
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 06cc9f6397bd..a7d7a3b51c71 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1203,6 +1203,33 @@ int group_balance_cpu(struct sched_group *sg)
>   */
>  
>  
> +/* Find the group_balance_cpu() */
> +static int find_group_balance_cpu(struct sched_domain *sd, struct sched_group *sg)
> +{
> +	const struct cpumask *sg_span = sched_group_span(sg);
> +	struct sd_data *sdd = sd->private;
> +	struct sched_domain *sibling;
> +	int i;
> +
> +	for_each_cpu(i, sg_span) {
> +		sibling = *per_cpu_ptr(sdd->sd, i);
> +
> +		/*
> +		 * Can happen in the asymmetric case, where these siblings are
> +		 * unused. The mask will not be empty because those CPUs that
> +		 * do have the top domain _should_ span the domain.
> +		 */
> +		if (!sibling->child)
> +			continue;
> +
> +		/* If we would not end up here, we can't continue from here */
> +		if (cpumask_equal(sg_span, sched_domain_span(sibling->child)))
> +			return i;
> +	}
> +
> +	return nr_cpu_ids;
> +}
> +
>  /*
>   * Build the balance mask; it contains only those CPUs that can arrive at this
>   * group and should be considered to continue balancing.
> @@ -1212,17 +1239,19 @@ int group_balance_cpu(struct sched_group *sg)
>   * can fully construct this using the sched_domain bits (which are already
>   * complete).
>   */
> -static void
> -build_balance_mask(struct sched_domain *sd, struct sched_group *sg, struct cpumask *mask)
> +static void build_balance_mask(int group_balance_cpu,
> +			       struct sched_domain *sd,
> +			       struct sched_group *sg,
> +			       struct cpumask *mask)
>  {
>  	const struct cpumask *sg_span = sched_group_span(sg);
>  	struct sd_data *sdd = sd->private;
>  	struct sched_domain *sibling;
> -	int i;
> +	int i = group_balance_cpu;
>  
>  	cpumask_clear(mask);
>  
> -	for_each_cpu(i, sg_span) {
> +	for_each_cpu_from(i, sg_span) {
>  		sibling = *per_cpu_ptr(sdd->sd, i);
>  
>  		/*
> @@ -1281,7 +1310,17 @@ static int init_overlap_sched_group(struct sched_domain *sd,
>  	struct cpumask *sg_span;
>  	int cpu;
>  
> -	build_balance_mask(sd, sg, mask);
> +	cpu = find_group_balance_cpu(sd, sg);
> +	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
> +		return -ENOENT;
> +
> +	sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
> +	if (sg->sgc && atomic_read(&sg->sgc->ref)) {
> +		atomic_inc(&sg->sgc->ref);
> +		return 0;
> +	}
> +
> +	build_balance_mask(cpu, sd, sg, mask);
>  	cpu = cpumask_first(mask);
>  
>  	sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
> ---
> 
> We just find the first CPU and reuse the scg. Otherwise, build the
> balance mask.

Yes, this is cleaner, thank you.

> 
> With those changes ...
> 
> > 
> >         build_balance_mask(sd, sg, mask);
> >         cpu = cpumask_first(mask);
> > 
> > -       sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
> > -       if (atomic_inc_return(&sg->sgc->ref) == 1)
> > +       sgc = *per_cpu_ptr(sdd->sgc, cpu);
> > +       if (!sgc) {
> > +               sgc = kzalloc_node(sizeof(*sgc) + cpumask_size(),
> > +                                  GFP_KERNEL, cpu_to_node(cpu));
> > +               if (!sgc)
> > +                       return -ENOMEM;
> > +               sgc->id = cpu;
> > +               *per_cpu_ptr(sdd->sgc, cpu) = sgc;
> > +       }
> > +
> > +       sg->sgc = sgc;
> > +       if (atomic_inc_return(&sg->sgc->ref) == 1) {
> 
> ... we can be sure this is a new sgc and just do an
> atomic_set(&sg->sgc->ref, 1) here and initialize the rest of the
> fields.
> 
> Thoughts?

+1, Since sgc is lazily allocated on demand in this patch, reaching 
the slow path guarantees we are initializing it for the first time.

> >                 cpumask_copy(group_balance_mask(sg), mask);
> > -       else
> > +               sg->sgc->capacity = SCHED_CAPACITY_SCALE * cpumask_weight(sg_span);
> > +               sg->sgc->min_capacity = SCHED_CAPACITY_SCALE;
> > +               sg->sgc->max_capacity = SCHED_CAPACITY_SCALE;
> > +       } else {
> >                 WARN_ON_ONCE(!cpumask_equal(group_balance_mask(sg), mask));
> 
> Do note this check will be lost with the optimization for the
> fast-path case but that should be okay(?)

Yes, that is fine: find_group_balance_cpu() already verifies that 
sg_span equals sched_domain_span(sibling->child) for cpu.

I will fold this into v2.

Thanks,
Pasha

> 
> > +       }
> > 
> > -       /*
> > -        * Initialize sgc->capacity such that even if we mess up the
> > -        * domains and no possible iteration will get us here, we won't
> > -        * die on a /0 trap.
> > -        */
> > -       sg_span = sched_group_span(sg);
> > -       sg->sgc->capacity = SCHED_CAPACITY_SCALE * cpumask_weight(sg_span);
> > -       sg->sgc->min_capacity = SCHED_CAPACITY_SCALE;
> > -       sg->sgc->max_capacity = SCHED_CAPACITY_SCALE;
> > +       return 0;
> >  }
> -- 
> Thanks and Regards,
> Prateek
> 

