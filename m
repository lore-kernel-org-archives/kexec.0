Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AB5C19F28
	for <kexec@archiver.kernel.org>; Wed,  3 Aug 2022 09:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k/INjy6b2P3y1xm6zZ3goWG8d0TxYglJ0r8Qje+pZfw=; b=Rr4qFDwo1sYevf
	VHwV9Az02qMaIwLRrfIfRj2PCjvXM6MsB5YhpwTyyU7Em+Znw+hHJIUfCccPKpmrfAqBl6GlqTsYK
	W1pwdKjB/DPf2Vkk/j7qTQEeaKC0FOG6cFH7lCUtNCnn8wpOxMaLYX/BDP+G0Rny90gRxryIHSCEv
	WCBwCz2vCC6Sx9kfQz+9XjYExH6fnI22zSxlOJOxl17SYC3QH/miqWXtJUMqQViK19saT74x/mS3n
	nFFNtuur9y6xlEdD2c7obZhnM07UmMKEkBlJHmTjRD0lUcsjHhop602WnTJWRcAdDgW76S8gI+APw
	UoT16Il212bMGaJak0NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJB5z-004XIS-9U; Wed, 03 Aug 2022 09:55:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJAoL-004O6V-1E
	for kexec@lists.infradead.org; Wed, 03 Aug 2022 09:37:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659519423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GPXAddURibjR5gNG74JLG3Yxvxf3ub55xbLwHgxY1zI=;
	b=hBjj1mtkTcOMbGynSMA54LjL++UvUM2W7Bp9HU5DXU8gXwO2X5F/zEEzi1gQ5vuaGNqxJ2
	c/TEnTv0EOR6G9IBmPNiWR+KCgyqO1TUU59TKWkZPa8UbksqnZxK0Sgs5inY9DkM8dao5x
	ireQU0mjr2iZep2uCGLeo1ECd+nBzHQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-E4qMBiBTNLunRNeqbJX5Zg-1; Wed, 03 Aug 2022 05:37:00 -0400
X-MC-Unique: E4qMBiBTNLunRNeqbJX5Zg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB2FD85A584;
	Wed,  3 Aug 2022 09:36:58 +0000 (UTC)
Received: from localhost (ovpn-13-216.pek2.redhat.com [10.72.13.216])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 913C540CFD0A;
	Wed,  3 Aug 2022 09:36:57 +0000 (UTC)
Date: Wed, 3 Aug 2022 17:36:54 +0800
From: Baoquan He <bhe@redhat.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
	kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com,
	alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
	arnd@arndb.de, bp@alien8.de, corbet@lwn.net,
	d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com,
	dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org,
	mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com,
	jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org,
	luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com,
	paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
	senozhatsky@chromium.org, stern@rowland.harvard.edu,
	tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com,
	will@kernel.org, Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: Re: [PATCH v2 08/13] tracing: Improve panic/die notifiers
Message-ID: <YupBtiVkrmE7YQnr@MiWiFi-R3L-srv>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-9-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220719195325.402745-9-gpiccoli@igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_023705_194459_8D068343 
X-CRM114-Status: GOOD (  28.30  )
X-Mailman-Approved-At: Wed, 03 Aug 2022 02:53:54 -0700
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

On 07/19/22 at 04:53pm, Guilherme G. Piccoli wrote:
> Currently the tracing dump_on_oops feature is implemented
> through separate notifiers, one for die/oops and the other
> for panic - given they have the same functionality, let's
> unify them.
> 
> Also improve the function comment and change the priority of
> the notifier to make it execute earlier, avoiding showing useless
> trace data (like the callback names for the other notifiers);
> finally, we also removed an unnecessary header inclusion.
> 
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V2:
> - Different approach; instead of using IDs to distinguish die and
> panic events, rely on address comparison like other notifiers do
> and as per Petr's suggestion;
> 
> - Removed ACK from Steven since the code changed.
> 
>  kernel/trace/trace.c | 55 ++++++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index b8dd54627075..2a436b645c70 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -19,7 +19,6 @@
>  #include <linux/kallsyms.h>
>  #include <linux/security.h>
>  #include <linux/seq_file.h>
> -#include <linux/notifier.h>
>  #include <linux/irqflags.h>
>  #include <linux/debugfs.h>
>  #include <linux/tracefs.h>
> @@ -9777,40 +9776,40 @@ static __init int tracer_init_tracefs(void)
>  
>  fs_initcall(tracer_init_tracefs);
>  
> -static int trace_panic_handler(struct notifier_block *this,
> -			       unsigned long event, void *unused)
> -{
> -	if (ftrace_dump_on_oops)
> -		ftrace_dump(ftrace_dump_on_oops);
> -	return NOTIFY_OK;
> -}
> +static int trace_die_panic_handler(struct notifier_block *self,
> +				unsigned long ev, void *unused);
>  
>  static struct notifier_block trace_panic_notifier = {
> -	.notifier_call  = trace_panic_handler,
> -	.next           = NULL,
> -	.priority       = 150   /* priority: INT_MAX >= x >= 0 */
> +	.notifier_call = trace_die_panic_handler,
> +	.priority = INT_MAX - 1,
>  };
>  
> -static int trace_die_handler(struct notifier_block *self,
> -			     unsigned long val,
> -			     void *data)
> -{
> -	switch (val) {
> -	case DIE_OOPS:
> -		if (ftrace_dump_on_oops)
> -			ftrace_dump(ftrace_dump_on_oops);
> -		break;
> -	default:
> -		break;
> -	}
> -	return NOTIFY_OK;
> -}
> -
>  static struct notifier_block trace_die_notifier = {
> -	.notifier_call = trace_die_handler,
> -	.priority = 200
> +	.notifier_call = trace_die_panic_handler,
> +	.priority = INT_MAX - 1,
>  };
>  
> +/*
> + * The idea is to execute the following die/panic callback early, in order
> + * to avoid showing irrelevant information in the trace (like other panic
> + * notifier functions); we are the 2nd to run, after hung_task/rcu_stall
> + * warnings get disabled (to prevent potential log flooding).
> + */
> +static int trace_die_panic_handler(struct notifier_block *self,
> +				unsigned long ev, void *unused)
> +{
> +	if (!ftrace_dump_on_oops)
> +		goto out;
> +
> +	if (self == &trace_die_notifier && ev != DIE_OOPS)
> +		goto out;

Although the switch-case code of original trace_die_handler() is werid, 
this unification is not much more comfortable. Just personal feeling
from code style, not strong opinion. Leave it to trace reviewers.

> +
> +	ftrace_dump(ftrace_dump_on_oops);
> +
> +out:
> +	return NOTIFY_DONE;
> +}
> +
>  /*
>   * printk is set to max of 1024, we really don't need it that big.
>   * Nothing should be printing 1000 characters anyway.
> -- 
> 2.37.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
