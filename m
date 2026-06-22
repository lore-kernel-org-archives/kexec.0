Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D401C5DF7F
	for <kexec@archiver.kernel.org>; Sat, 15 Aug 2026 07:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IjSWiRWMU9Ee27IawNNdMZlcd+pdKiRJTFL+L2RHmwk=; b=GRgwKsd7LwLMVE8hoZKLz5Pz6y
	hGSx38DFhIlnjHtWRY2k1vVjhuAl62d711ZkW5atvMS3unaw1AGbgoDUjjbYsGpcxIExYOv/dNClO
	d2f/DMEQFilu4uxTCyHhTV0CcsizTh0MLOqbFf4B94iOO44Bbxi6dibiOaw44+zpCel0m9UOuRcGg
	X0jxuo4EAur6Uvec+9QBWgL8UobQwpE1KJLM1XAS8pmbjgmoxlikogxW1stF9bieXBzvrL64qavRt
	P6KdynfS822xs0/PzgxLsK41rsLkprMCpQ5W28HHrj5imEi+ZKsryWeJ2e6qID9jdkhlw1SSXv/WQ
	Hp4D2HZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv95K-00000003cwu-3rKd;
	Sat, 15 Aug 2026 07:45:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbX6s-00000004RFL-32bn
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 05:22:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6F92E444F1;
	Mon, 22 Jun 2026 05:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378331F00A3F;
	Mon, 22 Jun 2026 05:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782105733;
	bh=IjSWiRWMU9Ee27IawNNdMZlcd+pdKiRJTFL+L2RHmwk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VPoPKF9kD8SQIQF6VNPVqYW4nAuqARtP874wgBw9ktl1VwB0bHFPLCbcXYj7HUMxH
	 Mj3NKz7moMW1j+SXZ5JmJDnOZXBZW5IRtgrf/R6VIt2WEKZCRvzJOEpijHbPfQq0b0
	 nm0TeCZgQXRR4HX/TRhbDsnY+V7xNwuVA9DRk2Y55c/zCXC+PjQS50Jq+EMuggkTRd
	 9oW5HaoUighBQ6x6uk8YcD6TgdtMpwCo25V+L/RnXeQZlOC/g45FDA5+g0tzRvIsbT
	 YyCpmQk1Wl7rkCzOR5GCrA3tMSulv6dAwtezT3ajTjhRDdDcAq0rBDJrWSlu6Ht97u
	 uxcDgxs29F2vw==
Content-Type: multipart/mixed; boundary="===============3341382443539626176=="
MIME-Version: 1.0
Message-Id: <a431d311fb11ec06b89a5986cbacf2ebe983bdaddc4a93076564d83799471cad@mail.kernel.org>
In-Reply-To: <20260622042811.31684-1-kaitao.cheng@linux.dev>
References: <20260622042811.31684-1-kaitao.cheng@linux.dev>
Subject: Re: [PATCH v3 5/7] kernel: Use mutable list iterators
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,paul@paul-moore.com,eparis@redhat.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,tj@kernel.org,hannes@cmpxchg.org,mkoutny@suse.com,dev@lankhorst.se,mripard@kernel.org,natalie.vock@gmx.de,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,mhiramat@kernel.org,oleg@redhat.com,oberpar@linux.ibm.com,akpm@linux-foundation.org,baoquan.he@linux.dev,rppt@kernel.org,pasha.tatashin@soleen.com,pratyush@kernel.org,naveen@kernel.org,jpoimboe@kernel.org,jikos@kernel.org,mbenes@suse.cz,pmladek@suse.com,will@kernel.org,boqun@kernel.org,mcgrof@kernel.org,petr.pavlu@suse.com,da.gomez@kernel.org,samitolvanen@google.com,steffen.klassert@secunet.com,daniel.m.jordan@oracle.com,rafael@kernel.org,dave@stgolabs.net,paulmck@kernel.org,josh@joshtriplett.org,frederic@kernel.org,neeraj.upadhyay@kernel.org,joelagnelf@nvidia.com,urezki@gmail.com
 ,juri.lelli@redhat.com,vincent.guittot@linaro.org,kees@kernel.org,bsingharora@gmail.com,anna-maria@linutronix.de,tglx@kernel.org,jstultz@google.com,kpsingh@kernel.org,mattbobrowski@google.com,nathan@kernel.org,martin.lau@linux.dev,song@kernel.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,dietmar.eggemann@arm.com,void@manifault.com,rostedt@goodmis.org
Cc: audit@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,cgroups@vger.kernel.org,dri-devel@lists.freedesktop.org,linux-perf-users@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kexec@lists.infradead.org,live-patching@vger.kernel.org,linux-modules@vger.kernel.org,linux-crypto@vger.kernel.org,linux-pm@vger.kernel.org,rcu@vger.kernel.org,sched-ext@lists.linux.dev,llvm@lists.linux.dev,chengkaitao@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 22 Jun 2026 05:22:12 +0000 (UTC)
X-Mailman-Approved-At: Sat, 15 Aug 2026 00:45:40 -0700
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

--===============3341382443539626176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
> index c4dfbc293bae..9e076106bee7 100644
> --- a/kernel/trace/trace_dynevent.c
> +++ b/kernel/trace/trace_dynevent.c

[ ... ]

> @@ -100,7 +100,7 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
>  		return -EINVAL;
>
>  	mutex_lock(&event_mutex);
> -	for_each_dyn_event_safe(pos, n) {
> +	for_each_dyn_event_safe(pos) {
>  		if (type && type != pos->ops)
>  			continue;
>  		if (!pos->ops->match(system, event,

Does this leave the variable n unused? Looking at the function
declaration around line 74, it still has:

	struct dyn_event *pos, *n;

but after this change n is no longer passed to for_each_dyn_event_safe().
The macro now hides the temporary cursor internally, so n appears to be
dead code. This would trigger -Wunused-variable warnings and break builds
with CONFIG_WERROR=y.

For comparison, the sibling change at line 219 (dyn_events_release_all)
correctly removed the *tmp variable from its declaration.

> diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
> index beee3f8d7544..a4dc0812284f 100644
> --- a/kernel/trace/trace_dynevent.h
> +++ b/kernel/trace/trace_dynevent.h
> @@ -115,10 +115,9 @@ int dyn_event_create(const char *raw_command, struct dyn_event_operations *type)
>  /*
>   * for_each_dyn_event	-	iterate over the dyn_event list safely
>   * @pos:	the struct dyn_event * to use as a loop cursor
> - * @n:		the struct dyn_event * to use as temporary storage
>   */
> -#define for_each_dyn_event_safe(pos, n)	\
> -	list_for_each_entry_safe(pos, n, &dyn_event_list, list)
> +#define for_each_dyn_event_safe(pos)	\
> +	list_for_each_entry_mutable(pos, &dyn_event_list, list)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27930295027
--===============3341382443539626176==--

