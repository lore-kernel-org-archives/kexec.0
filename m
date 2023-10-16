Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E914CCDB465
	for <kexec@archiver.kernel.org>; Mon, 16 Oct 2023 08:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+Wm+yluoykXWi2OrU6UPdyPw3jqw63uR44A+5IOaujQ=; b=bxfgCieTEsKVoh
	9lhtJ8+TNZks7Pp094Xpp3Oo4aiDxLE/g0S8b9H+rJ7/OsJa3rPymSSAXjvZjYIOHjtCC/pgamKRM
	qoMkF95ACR8wt/PucBypARTRtBdxVSTtx1rzQGzMnIgIHysUWlx4O6tMOwCGSLcIGGjo2qjVmvbpV
	nJivVTXAZ7stWH2GXhaJWNJ5v83Cr6i6IKu/bLeIfWekCobqRSSXeFNIRmvGmvIX3FmFKUsTX5IcF
	ubLqmInn+CoMqNX5wQOpaXcTg961FfU2T6aOxtME8dU0sPe9jxIDet4f3IY1bLo8JEipoDBN0DFEt
	e94rQK+K1xvp1NvuzHsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsJRd-008uv2-1r;
	Mon, 16 Oct 2023 08:59:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsJRa-008utp-2D
	for kexec@lists.infradead.org;
	Mon, 16 Oct 2023 08:59:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697446760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2FeV+c5x33dv4l/xApcJjHfB6GACs9h2vGrZq3PHSdA=;
	b=A+19SbMwdTIA90gljNO3JSI2qiUsQbtmTFil5c9hQQLt3A7iR1kvbOgMe+bKLcxU3vQhZT
	WBaHjI8SDkBbXZYEbxUSynd/qRmUG7rl2gbmdWjjt28O+zHVgnlhKKf5J51tjJM5yh9pgn
	usP3pwXd4lpsryusALQtoB63jBcJToQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-r9IqWhbCOVaTIW264F0-0g-1; Mon, 16 Oct 2023 04:59:02 -0400
X-MC-Unique: r9IqWhbCOVaTIW264F0-0g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 640C285531B;
	Mon, 16 Oct 2023 08:59:01 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.112.177])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D5555492BFA;
	Mon, 16 Oct 2023 08:58:54 +0000 (UTC)
Date: Mon, 16 Oct 2023 16:58:44 +0800
From: Dave Young <dyoung@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kexec@lists.infradead.org, bhe@redhat.com, prudo@redhat.com,
	ebiederm@xmission.com, vgoyal@redhat.com
Subject: Re: panic context: was: Re: [PATCH printk v2 04/11] printk: nbcon:
 Provide functions to mark atomic write sections
Message-ID: <ZSz7RFqv994u/Vt+@darkstar.users.ipa.redhat.com>
References: <ZRGvn4m2NGCn3Pef@alley>
 <87h6n5teos.fsf@jogness.linutronix.de>
 <ZSADUKp8oJ2Ws2vC@alley>
 <87il7hv2v2.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87il7hv2v2.fsf@jogness.linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_015922_795556_8AEFDB5A 
X-CRM114-Status: GOOD (  38.92  )
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

[Added more people in cc]

On 10/08/23 at 12:19pm, John Ogness wrote:
> Hi Petr,
> 
> On 2023-10-06, Petr Mladek <pmladek@suse.com> wrote:
> >> During the demo at LPC2022 we had the situation that there was a large
> >> backlog when a WARN was hit. With current mainline the first line of the
> >> WARN is put into the ringbuffer and then the entire backlog is flushed
> >> before storing the rest of the WARN into the ringbuffer. At the time it
> >> was obvious that we should finish storing the WARN message and then
> >> start flushing the backlog.
> >
> > This talks about the "emergency" context (WARN/OOPS/watchdog).
> > The system might be in big troubles but it would still try to continue.
> >
> > Do we really want to defer the flush also for panic() context?
> 
> We can start flushing right after the backtrace is in the
> ringbuffer. But flushing the backlog _before_ putting the backtrace into
> the ringbuffer was not desired because if there is a large backlog, the
> machine may not survive to get the backtrace out. And in that case it
> won't even be in the ringbuffer to be used by other debugging
> tools.
> 
> > I ask because I was not on LPC 2022 in person and I do not remember
> > all details.
> 
> The LPC2022 demo/talk was recorded:
> 
> https://www.youtube.com/watch?v=TVhNcKQvzxI
> 
> At 55:55 is where the situation occurred and triggered the conversation,
> ultimately leading to this new feature.
> 
> You may also want to reread my summary:
> 
> https://lore.kernel.org/lkml/875yheqh6v.fsf@jogness.linutronix.de
> 
> as well as Linus' follow-up message:
> 
> https://lore.kernel.org/lkml/CAHk-=wieXPMGEm7E=Sz2utzZdW1d=9hJBwGYAaAipxnMXr0Hvg@mail.gmail.com
> 
> > But it is tricky in panic(), see 8th patch at
> > https://lore.kernel.org/r/20230919230856.661435-9-john.ogness@linutronix.de
> >
> >    + nbcon_atomic_exit() is called only in one code path.
> 
> Correct. When panic() is complete and the machine goes into its infinite
> loop. This is also the point where it will attempt an unsafe flush, if
> it could not get the messages out yet.
> 
> >    + nbcon_atomic_flush_all() is used in other paths. It looks like
> >      a "Whack a mole" game to me.
> 
> Several different outputs occur during panic(). The flush is everywhere
> where something significant has been put into the ringbuffer and now it
> would be OK to flush it.
> 
> >    + messages are never emitted by printk kthread either because
> >      CPUs are stopped or the kthread is not allowed to get the lock
> 
> Correct.
> 
> > I see only one positive of the explicit flush. The consoles would
> > not delay crash_exec() and the crash dump might be closer to
> > the point where panic() was called.
> 
> It's only about getting the critical messages into the ringbuffer before
> flushing. And since various things can go wrong during the many actions
> within panic(), it makes sense to flush in between those actions.
> 
> > Otherwise I see only negatives => IMHO, we want to flush atomic
> > consoles synchronously from printk() in panic().
> >
> > Does anyone really want explicit flushes in panic()?
> 
> So far you are the only one speaking against it. I expect as time goes
> on it will get even more complex as it becomes tunable (also something
> we talked about during the demo).

Flush consoles in panic kexec case sounds not good, but I have no
deep understanding about the atomic printk series, added kexec list and
reviewers in cc.

> 
> John
> 

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
