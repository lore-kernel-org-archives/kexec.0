Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155F9C19F28
	for <kexec@archiver.kernel.org>; Wed,  3 Aug 2022 10:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7EiHgbH3OA921RWfXJg9nSj9jGkFiWOKuQBRKiQQkSQ=; b=FSOCvG1RXSq7VE
	dtHGIqSINkcB9rPL8E6SJmlogo3mvoKYZwXVPbpMQnQmxn0PtCyEcBeLvYcsZbcSU4NPCCfRcmlvH
	65i/gGctPjOdaLgtH2aOYuUWfeE0W7ziSF7iBnxeQEV6Te7XHnVCnRjQUFhsCQmNtm2jwF1t5+g6Z
	ttpODankL4Va5akuc37qV0TsYOblzQ30zxAg0fkcH8+p4s0AL6C3ZPehJkLqWMMESPJ4Wm1lMRfLb
	+kJRaDb1BI6i09pCL8MWyPsyNXEeqAJRNEhQIobtPSE9rpzY799UwWoSaTuvgW0nmg73ALXFBMTYe
	YN1qxdEX4H59J92izIdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJBHi-004dOL-4X; Wed, 03 Aug 2022 10:07:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJB3t-004W8v-7c
	for kexec@lists.infradead.org; Wed, 03 Aug 2022 09:53:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659520388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kc/D6eFmNXdc/PlI526NFHqk9sVSNen1MCJD2u5ZFKQ=;
	b=b4N88Pt8Stg0pOk1CKizWkZaWGPlwcBE1c7jpjbEZMGVZFw8b9+KFiXfHVmlwMca0HSxAT
	2AMJrhMPecYqYXzuKpSuoZg9Moh3/KZyuL9yUHtMTLIbdQ9rLHuddrXLqrCLEo0bQWbj1i
	UHKQQFI854b6+/S9X3G8asjEgt5XJCo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-VvdGeYMLPhaxQBkXtxi7Zw-1; Wed, 03 Aug 2022 05:53:03 -0400
X-MC-Unique: VvdGeYMLPhaxQBkXtxi7Zw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A5E185A584;
	Wed,  3 Aug 2022 09:53:01 +0000 (UTC)
Received: from localhost (ovpn-13-216.pek2.redhat.com [10.72.13.216])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F5EC2166B26;
	Wed,  3 Aug 2022 09:53:00 +0000 (UTC)
Date: Wed, 3 Aug 2022 17:52:57 +0800
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
Message-ID: <YupFeQ6AcfjUVpOW@MiWiFi-R3L-srv>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-9-gpiccoli@igalia.com>
 <YupBtiVkrmE7YQnr@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YupBtiVkrmE7YQnr@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_025309_395757_66132840 
X-CRM114-Status: GOOD (  34.23  )
X-Mailman-Approved-At: Wed, 03 Aug 2022 02:57:40 -0700
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

On 08/03/22 at 05:36pm, Baoquan He wrote:
> On 07/19/22 at 04:53pm, Guilherme G. Piccoli wrote:
> > Currently the tracing dump_on_oops feature is implemented
> > through separate notifiers, one for die/oops and the other
> > for panic - given they have the same functionality, let's
> > unify them.
> > 
> > Also improve the function comment and change the priority of
> > the notifier to make it execute earlier, avoiding showing useless
> > trace data (like the callback names for the other notifiers);
> > finally, we also removed an unnecessary header inclusion.
> > 
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> > 
> > ---
> > 
> > V2:
> > - Different approach; instead of using IDs to distinguish die and
> > panic events, rely on address comparison like other notifiers do
> > and as per Petr's suggestion;
> > 
> > - Removed ACK from Steven since the code changed.
> > 
> >  kernel/trace/trace.c | 55 ++++++++++++++++++++++----------------------
> >  1 file changed, 27 insertions(+), 28 deletions(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index b8dd54627075..2a436b645c70 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -19,7 +19,6 @@
> >  #include <linux/kallsyms.h>
> >  #include <linux/security.h>
> >  #include <linux/seq_file.h>
> > -#include <linux/notifier.h>
> >  #include <linux/irqflags.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/tracefs.h>
> > @@ -9777,40 +9776,40 @@ static __init int tracer_init_tracefs(void)
> >  
> >  fs_initcall(tracer_init_tracefs);
> >  
> > -static int trace_panic_handler(struct notifier_block *this,
> > -			       unsigned long event, void *unused)
> > -{
> > -	if (ftrace_dump_on_oops)
> > -		ftrace_dump(ftrace_dump_on_oops);
> > -	return NOTIFY_OK;
> > -}
> > +static int trace_die_panic_handler(struct notifier_block *self,
> > +				unsigned long ev, void *unused);
> >  
> >  static struct notifier_block trace_panic_notifier = {
> > -	.notifier_call  = trace_panic_handler,
> > -	.next           = NULL,
> > -	.priority       = 150   /* priority: INT_MAX >= x >= 0 */
> > +	.notifier_call = trace_die_panic_handler,
> > +	.priority = INT_MAX - 1,
> >  };
> >  
> > -static int trace_die_handler(struct notifier_block *self,
> > -			     unsigned long val,
> > -			     void *data)
> > -{
> > -	switch (val) {
> > -	case DIE_OOPS:
> > -		if (ftrace_dump_on_oops)
> > -			ftrace_dump(ftrace_dump_on_oops);
> > -		break;
> > -	default:
> > -		break;
> > -	}
> > -	return NOTIFY_OK;
> > -}
> > -
> >  static struct notifier_block trace_die_notifier = {
> > -	.notifier_call = trace_die_handler,
> > -	.priority = 200
> > +	.notifier_call = trace_die_panic_handler,
> > +	.priority = INT_MAX - 1,
> >  };
> >  
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
> Although the switch-case code of original trace_die_handler() is werid, 
> this unification is not much more comfortable. Just personal feeling
> from code style, not strong opinion. Leave it to trace reviewers.

Please ignore this comment.

I use b4 to grab this patchset and applied, and started to check patch
one by one. Then I realize it's all about cleanups which have got
consensus in earlier rounds. Hope it can be merged when other people's
concern is addressed, the whole series looks good to me, I have no
strong concern to them.

> 
> > +
> > +	ftrace_dump(ftrace_dump_on_oops);
> > +
> > +out:
> > +	return NOTIFY_DONE;
> > +}
> > +
> >  /*
> >   * printk is set to max of 1024, we really don't need it that big.
> >   * Nothing should be printing 1000 characters anyway.
> > -- 
> > 2.37.1
> > 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
