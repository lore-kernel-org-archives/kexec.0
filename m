Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D02AC072A2
	for <kexec@archiver.kernel.org>; Wed, 22 Nov 2023 08:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6vLbinN477L7AAgroLWQQ8L3KrY5rq2l6pbE4NQxPks=; b=k/9MjqbF9uXmyp
	/3d1QiSZPpYpSgDP/gVqZcwhnOPMLd38ixjibDHJyeHmKXoTF4SmqqcqMkpEnRtIypwx03SF5Q1Be
	x3MBLbfVA02RMPOE6RomlPYc6edbPRKX55KkxiMcqQYa2pyulIl4bqKqmDMJ2VbbQAD48AWKHsHYj
	2N/G2b2acOTWBU1t19xZ6aZzIRkgpaRclg9qErjWby26jPsWx1AK0hJHHQ8W7xEltoDV55z2k+7gr
	U2cm1ptZP2SgwT4qugRqOj2yxkLM8TR/bt4Pcn7E9FY7pP+CbqHf12BY3oTgdwNc2RdtdlQdr7oRP
	SuTfcv6tPfEASd9Kn47g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5iG7-0010RL-11;
	Wed, 22 Nov 2023 08:06:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5iG4-0010Qd-2J
	for kexec@lists.infradead.org;
	Wed, 22 Nov 2023 08:06:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700640410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MTL9eS606aR4jOsPXUpex7owGMXk2Et9Dz0AzsPRhrM=;
	b=U5a0aTJlo8VtHd/QqcuYYNiMJuF9qov2Gfo4jSGQBu2lBJygolQTmhrLT5e4nNsC5Tyli/
	qBF6w5spUJyE53I6LB231kmw0TnedUgCNxZnu5Nfdq2g5okjZ2HSkQerWpZhj+EYlrmVOX
	AUaYG+ke5UqzVsyiq+liOFoPCYaEHBI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-RLq--aGvM8SKDDM51CwVDA-1; Wed, 22 Nov 2023 03:06:47 -0500
X-MC-Unique: RLq--aGvM8SKDDM51CwVDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63FCF185A780;
	Wed, 22 Nov 2023 08:06:46 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 531AA36E2;
	Wed, 22 Nov 2023 08:06:42 +0000 (UTC)
Date: Wed, 22 Nov 2023 16:06:39 +0800
From: Baoquan He <bhe@redhat.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] kexec: Use atomic_try_cmpxchg in crash_kexec
Message-ID: <ZV22j+C+D7ZnKzqD@MiWiFi-R3L-srv>
References: <20231114161228.108516-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231114161228.108516-1-ubizjak@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_000652_848188_0AD9AA96 
X-CRM114-Status: GOOD (  17.35  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 11/14/23 at 05:12pm, Uros Bizjak wrote:
> Use atomic_try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> crash_kexec().  x86 CMPXCHG instruction returns success in ZF flag,
> so this change saves a compare after cmpxchg.
> 
> No functional change intended.

And code is simplified a little bit, so looks good to me,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Cc: Eric Biederman <ebiederm@xmission.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  kernel/kexec_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index be5642a4ec49..bc4c096ab1f3 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1063,9 +1063,10 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
>  	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
>  	 * may stop each other.  To exclude them, we use panic_cpu here too.
>  	 */
> +	old_cpu = PANIC_CPU_INVALID;
>  	this_cpu = raw_smp_processor_id();
> -	old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
> -	if (old_cpu == PANIC_CPU_INVALID) {
> +
> +	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
>  		/* This is the 1st CPU which comes here, so go ahead. */
>  		__crash_kexec(regs);
>  
> -- 
> 2.41.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
