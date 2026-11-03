Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E16606EE8B
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nb2H8y+p;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ccOpwd2t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=yfddeYQH6ujsdtrqW+DK7nJG3jSGc85HvZV3WQ41HAI=; b=nb2H8y+pZ52LO9
	CiCP0JtMMU80vHUslFo2XXD/oh6yCvRF4G62iTdI9PgPrz7V5Twl09pUpTPWV+qrunjEnEsQUIETj
	FG7hfBkWH8KEa5smAZaDAkFBwgvA7oqNKuSYUbnLinZDt0u0hlPNeVWi5dWfJnivjGPr+2MZQtEVF
	a93F6gNgpa2f6G38L8E3fmv25qfEuDiXx9/+28inxsywRGIKwWAi2RAJgdzptWfMG0pGoV0jM7Mmj
	5FwZnrmSUW8KqvBP5qOUkv2gMrSIU3J1Gk4jj7yu809sdhc9KkP8mbUHUaBipbY+omEG/cQKYFrUC
	io6WBOeLwF2UZ4adNkTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFvB-00000002oZi-2H1u;
	Tue, 03 Nov 2026 14:55:33 +0000
Received: from smtprelay0016.hostedemail.com ([216.40.44.16] helo=relay.hostedemail.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFv8-00000002oZE-1p3H
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:55:31 +0000
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 9CF50A0427;
	Tue,  3 Nov 2026 14:55:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id C284720028;
	Tue,  3 Nov 2026 14:55:13 +0000 (UTC)
Date: Tue, 3 Nov 2026 09:55:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: pmladek@suse.com, john.ogness@linutronix.de, senozhatsky@chromium.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
 surenb@google.com, mhocko@suse.com, kees@kernel.org,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@kernel.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [RFC PATCH v2 4/5] printk, tracing: Support console flush
 suppression and tail pinning
Message-ID: <20261103095512.7b8c2d3f@gandalf.local.home>
In-Reply-To: <20261103024453.922373-5-atomlin@atomlin.com>
References: <20261103024453.922373-1-atomlin@atomlin.com>
	<20261103024453.922373-5-atomlin@atomlin.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nc4kisin8m3wyjdgtdpom7c1au41iqa3
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: C284720028
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18bF8bDrvU8IQ31ZfoMj2/1FBDtsGgnaNM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=yfddeYQH6ujsdtrqW+DK7nJG3jSGc85HvZV3WQ41HAI=; b=ccOpwd2tRjlDkvLbOszT0B1ym6UiYCfrRWT0qA4+g9GnoqpEdGbtdba9bNqnSGo8WEXhJAmxC0nC9r/jQRz0ydIwgnnbdbE+fkNtv7+eOe9CahVZ9Tf38wAfwDUrGkJffHQpfufHMkf6c76Qt5z5WupeU0bID+ji4KLPijQfrbw=
X-HE-Tag: 1793717713-47761
X-HE-Meta: U2FsdGVkX19lBMKb7T+S15I1bJ1yR/TpScDr1lLD4QbN59L8ZM4I0NZGtNhm2A8c1bmSxupnsLnRAsBUwVGiAfWzpLEfSX3Adc9DNtb6PKQ5qJNeVEATThLVWUurVwo9CE5t/iLx93jzKYVjROq1YZpyEKFbbFeS0fkiZcRmgC2kbjBnXH6i1894/YQUb3zmpt9AzD9eP/WJIIhyybCls1BbTVchuLjJ9gzzG6y6eMRLctFBr4SOmLD53JvLUC49y8ZRAywfuklEeeyZQgz1N8jIf42a2Jf292eBO4csSC2VZy7+hRLMlrdiX2PfR5HNPn57OrUIwJiwWiRoeehnpiHDKniSg9g5+r1a5FR/JVhzWytRVeYOTvnpX6+QVIy/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_065530_548685_74869700 
X-CRM114-Status: GOOD (  14.79  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon,  2 Nov 2026 21:44:52 -0500
Aaron Tomlin <atomlin@atomlin.com> wrote:

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e8c4efa8107b..35a56f04e9b3 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9519,6 +9519,9 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
>  	else
>  		iter.cpu_file = RING_BUFFER_ALL_CPUS;
>  
> +	if (printk_is_tail_full())
> +		goto out_enable;
> +
>  	if (tr == &global_trace)
>  		printk(KERN_TRACE "Dumping ftrace buffer:\n");
>  	else
> @@ -9537,10 +9540,13 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
>  	 * and then release the locks again.
>  	 */
>  
> -	while (!trace_empty(&iter)) {
> +	while (!trace_empty(&iter) && !printk_is_tail_full()) {

Wait? Is this to prevent overwriting the printk ring buffer? If so, this
is wrong here!

In your change log, you mention not losing the initial oops or registers.
But if someone is using ftrace_dump_on_oops, that's not what they are
after. They want to know what happened that lead to the crash. That output
is at the *end* of the trace.

By stopping the output of the ftrace buffer early, you just lost the
information you are looking for.

-- Steve


>  
> -		if (!cnt)
> +		if (!cnt) {
>  			printk(KERN_TRACE "---------------------------------\n");
> +			if (printk_is_tail_full())
> +				break;
> +		}
>  
>  		cnt++;
>  
> @@ -9551,19 +9557,25 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
>  			int ret;
>  
>  			ret = print_trace_line(&iter);
> +			trace_printk_seq(&iter.seq);
> +			if (printk_is_tail_full())
> +				break;
> +
>  			if (ret != TRACE_TYPE_NO_CONSUME)
>  				trace_consume(&iter);
> -
> -			trace_printk_seq(&iter.seq);
>  		}
>  		touch_nmi_watchdog();
>  	}
>  
> +	if (printk_is_tail_full())
> +		goto out_enable;
> +
>  	if (!cnt)
>  		printk(KERN_TRACE "   (ftrace buffer empty)\n");
>  	else
>  		printk(KERN_TRACE "---------------------------------\n");
>  
> +out_enable:
>  	tr->trace_flags |= old_userobj;
>  
>  	tracer_tracing_enable(tr);


