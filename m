Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF686C32773
	for <kexec@archiver.kernel.org>; Tue, 16 Aug 2022 16:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WCAPY1oJUDYfkrGLFJK5pQcsg/4q5w7DFNbEvG/2oDg=; b=4SRc7Ta6YZH1V1
	LYX+ES/ts5c2yQyaTOXF3HefOPsjQaKzDjWl7AjKdYiyOGVzn1amfEZ/cWmdVkfz/ivqtUhWcyE6R
	m+ufZkIrKq9FXVId2/9My2rKP+zNZP0SQWdSC7MJXvHUvQk8zcdfCkKJaVYQmvD5zB/J29NNmZMgF
	bn2maOFf8KvchL/GOifAP9pX69G7YcpxunUl8B1W2jVzWZsH2275Iam/sCVC86qqoP3ECa1ILa1nO
	Y6qGxQG7CbD/v5Xh6GKK56A+b+mUtT5JylHI7DccdbOuzNedFwuSScyplQGBcaWKTn5QyXp94So4R
	ymOgJFuSv6m56NU6IOOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNzgL-004n8m-1c; Tue, 16 Aug 2022 16:44:45 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNys7-004Bn4-6w
	for kexec@lists.infradead.org; Tue, 16 Aug 2022 15:52:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id CCCF8CE19D2;
	Tue, 16 Aug 2022 15:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43ABC433C1;
	Tue, 16 Aug 2022 15:52:41 +0000 (UTC)
Date: Tue, 16 Aug 2022 11:52:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 08/13] tracing: Improve panic/die notifiers
Message-ID: <20220816115249.66cf8f15@gandalf.local.home>
In-Reply-To: <YvuwUAGi6PvY5kmR@rowland.harvard.edu>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
	<20220719195325.402745-9-gpiccoli@igalia.com>
	<20220816101445.184ebb7c@gandalf.local.home>
	<YvuwUAGi6PvY5kmR@rowland.harvard.edu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220816_085251_452603_692DB81A 
X-CRM114-Status: GOOD (  12.95  )
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

On Tue, 16 Aug 2022 10:57:20 -0400
Alan Stern <stern@rowland.harvard.edu> wrote:

> > static int trace_die_panic_handler(struct notifier_block *self,
> > 				unsigned long ev, void *unused)
> > {
> > 	if (!ftrace_dump_on_oops)
> > 		return NOTIFY_DONE;
> > 
> > 	/* The die notifier requires DIE_OOPS to trigger */
> > 	if (self == &trace_die_notifier && ev != DIE_OOPS)
> > 		return NOTIFY_DONE;
> > 
> > 	ftrace_dump(ftrace_dump_on_oops);
> > 
> > 	return NOTIFY_DONE;
> > }  
> 
> Or better yet:
> 
> 	if (ftrace_dump_on_oops) {
> 
> 		/* The die notifier requires DIE_OOPS to trigger */
> 		if (self != &trace_die_notifier || ev == DIE_OOPS)
> 			ftrace_dump(ftrace_dump_on_oops);
> 	}
> 	return NOTIFY_DONE;
> 

That may be more consolidated but less easy to read and follow. This is far
from a fast path.

As I maintain this bike-shed, I prefer the one I suggested ;-)

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
