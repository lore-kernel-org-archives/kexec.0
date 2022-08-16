Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B58C2BB41
	for <kexec@archiver.kernel.org>; Tue, 16 Aug 2022 16:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s0DH9/bOdYMmSOVw7OBQqOT7tTL7HwE9npeg/FKKKVc=; b=Cc1+k7fMOxOVTk
	HczyP27y/dhtb4M7XplADjodyDk3gOc3tjN677TUcbmTSH8kvs8JqNkhVddtPoQThTkrfjvbJM4rd
	Vo1euyDKhvvqmRO9ruImjfOtSWwYvR3w6qRBQ2PaMPFDDzf845YurbTj0xRaLZ/teIvlXQ0sigSqQ
	oOzsLn5oBS+DpNd5pl/8hlGRWvisV32E/rgM2WEuKnJLqbIE6ksUflNsdBg/FvQsd5sVGdX02Txgu
	0S1J21UTi42wRP0aNN3wH5hzltA5KLp/eRoOzhKgzq/4RZBJmH6aU8mbM3ukVHCV/sZPEcU/VaLVe
	0lNCMwT3NHJ2Z33sVt+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNzgJ-004n7m-Np; Tue, 16 Aug 2022 16:44:43 +0000
Received: from netrider.rowland.org ([192.131.102.5])
	by bombadil.infradead.org with smtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNy0V-003e3d-EV
	for kexec@lists.infradead.org; Tue, 16 Aug 2022 14:57:29 +0000
Received: (qmail 131232 invoked by uid 1000); 16 Aug 2022 10:57:20 -0400
Date: Tue, 16 Aug 2022 10:57:20 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 08/13] tracing: Improve panic/die notifiers
Message-ID: <YvuwUAGi6PvY5kmR@rowland.harvard.edu>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-9-gpiccoli@igalia.com>
 <20220816101445.184ebb7c@gandalf.local.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220816101445.184ebb7c@gandalf.local.home>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220816_075727_717719_8185369E 
X-CRM114-Status: GOOD (  14.37  )
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
Cc: linux-hyperv@vger.kernel.org, halves@canonical.com, peterz@infradead.org, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, will@kernel.org, john.ogness@linutronix.de, bhe@redhat.com, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, x86@kernel.org, mingo@redhat.com, dyoung@redhat.com, vgoyal@redhat.com, pmladek@suse.com, alejandro.j.jimenez@oracle.com, keescook@chromium.org, arnd@arndb.de, senozhatsky@chromium.org, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, vkuznets@redhat.com, jgross@suse.com, netdev@vger.kernel.org, kernel@gpiccoli.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, d.hatayama@jp.fujitsu.com, Sergei Shtylyov <sergei.shtylyov@gmail.com>, mhiramat@kernel.org, kernel-dev@igalia.com, gregkh@linuxfoundation.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Aug 16, 2022 at 10:14:45AM -0400, Steven Rostedt wrote:
> On Tue, 19 Jul 2022 16:53:21 -0300
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> 
> 
> Sorry for the late review, but this fell to the bottom of my queue :-/
> 
> > +/*
> > + * The idea is to execute the following die/panic callback early, in order
> > + * to avoid showing irrelevant information in the trace (like other panic
> > + * notifier functions); we are the 2nd to run, after hung_task/rcu_stall
> > + * warnings get disabled (to prevent potential log flooding).
> > + */
> > +static int trace_die_panic_handler(struct notifier_block *self,
> > +				unsigned long ev, void *unused)
> > +{
> > +	if (!ftrace_dump_on_oops)
> > +		goto out;
> > +
> > +	if (self == &trace_die_notifier && ev != DIE_OOPS)
> > +		goto out;
> 
> I really hate gotos that are not for clean ups.
> 
> > +
> > +	ftrace_dump(ftrace_dump_on_oops);
> > +
> > +out:
> > +	return NOTIFY_DONE;
> > +}
> > +
> 
> Just do:
> 
> static int trace_die_panic_handler(struct notifier_block *self,
> 				unsigned long ev, void *unused)
> {
> 	if (!ftrace_dump_on_oops)
> 		return NOTIFY_DONE;
> 
> 	/* The die notifier requires DIE_OOPS to trigger */
> 	if (self == &trace_die_notifier && ev != DIE_OOPS)
> 		return NOTIFY_DONE;
> 
> 	ftrace_dump(ftrace_dump_on_oops);
> 
> 	return NOTIFY_DONE;
> }

Or better yet:

	if (ftrace_dump_on_oops) {

		/* The die notifier requires DIE_OOPS to trigger */
		if (self != &trace_die_notifier || ev == DIE_OOPS)
			ftrace_dump(ftrace_dump_on_oops);
	}
	return NOTIFY_DONE;

Alan Stern

> Thanks,
> 
> Other than that, Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
