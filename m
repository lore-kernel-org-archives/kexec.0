Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9EAC28B2B
	for <kexec@archiver.kernel.org>; Tue, 16 Aug 2022 16:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DMKz5Ipl4r0MWMN96wdDu2H8esENGsJq1Eb/xWfie4E=; b=Oh8eyGZW8xGsF1
	a+b38Fk3M/TG7f4nkQqKlWyi6CquVMOPB+2ZHk/DCmJLaOsK7yeIFlpjxE59A7ocfSSIp14NlC8eX
	VedmtFob05XtxJOr4aG194LTJkTzql3A9pNJ9BYLwdwLMSIGxY2XtcyGaUp6atQvbgnILlm4wHkyj
	yPWp7QRMIpDK2kPoKDFAlrW7hmi0bjXGR4jemZCkXgUvCwqKKzXQB9wb3hD95+xr3MWFngy273T2t
	2+xyYMLUc8OHKwnRB2t13nNQQXqTIfj7svQl5jN6pKndeqJCm5hEMmB9xdzNAmmGJIILlO3ws9fRv
	edwYlaSg+sdCImcZ0Y3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNzgI-004n7W-I0; Tue, 16 Aug 2022 16:44:42 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNxLA-003GEy-Qe
	for kexec@lists.infradead.org; Tue, 16 Aug 2022 14:14:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id B6764B81A1A;
	Tue, 16 Aug 2022 14:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756B3C433C1;
	Tue, 16 Aug 2022 14:14:37 +0000 (UTC)
Date: Tue, 16 Aug 2022 10:14:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com,
 fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
 corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com,
 dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org,
 mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com,
 john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org,
 mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
 peterz@infradead.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com,
 will@kernel.org, Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: Re: [PATCH v2 08/13] tracing: Improve panic/die notifiers
Message-ID: <20220816101445.184ebb7c@gandalf.local.home>
In-Reply-To: <20220719195325.402745-9-gpiccoli@igalia.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
	<20220719195325.402745-9-gpiccoli@igalia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220816_071445_064955_E5CA4985 
X-CRM114-Status: GOOD (  14.86  )
X-Mailman-Approved-At: Tue, 16 Aug 2022 09:44:41 -0700
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

On Tue, 19 Jul 2022 16:53:21 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:


Sorry for the late review, but this fell to the bottom of my queue :-/

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

I really hate gotos that are not for clean ups.

> +
> +	ftrace_dump(ftrace_dump_on_oops);
> +
> +out:
> +	return NOTIFY_DONE;
> +}
> +

Just do:

static int trace_die_panic_handler(struct notifier_block *self,
				unsigned long ev, void *unused)
{
	if (!ftrace_dump_on_oops)
		return NOTIFY_DONE;

	/* The die notifier requires DIE_OOPS to trigger */
	if (self == &trace_die_notifier && ev != DIE_OOPS)
		return NOTIFY_DONE;

	ftrace_dump(ftrace_dump_on_oops);

	return NOTIFY_DONE;
}


Thanks,

Other than that, Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
