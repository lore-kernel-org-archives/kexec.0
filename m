Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02902C41513
	for <kexec@archiver.kernel.org>; Mon, 16 Oct 2023 10:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QjI7A322cj7RRp3DUbgkxsZUHMXaaM8YbCLFLwD9VcA=; b=448l2ChHDEeru8
	NZqtvMC70OjLlnjMChQk9RVfZyrsnxEZBFKRWWgKII00VIx+MFR1kdRqtt6glrpJCipedA5H9eWx3
	WqnNn/Ln+2ltH/W5oSOQdTMEYjPpubH8khJcVqNk6kYPX2U7Otbq/dM5vS4/g7TrZ+lo9gr2TgiF1
	+LQhO3cGzzXhK0aUQpIdFUooUUjhqsUQmQO4YzC22PXYW7Mdd/D3cyUVU4TE1WRHfzVZvM3//k7Px
	Wib1N2KZKW+fiAQY7FYb+dHo7FkCX/8Osu29jilZSzTw1qwsG3awxGJl8zIEgY+0FSeJFdHAoCPtz
	hwVYpZB1vFZn5nO9A+Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsKY0-0096U0-1D;
	Mon, 16 Oct 2023 10:10:04 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsKXx-0096Qs-1w
	for kexec@lists.infradead.org;
	Mon, 16 Oct 2023 10:10:03 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1697450990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lm/sCgLXyQJvjntNocjGInAVDmxpu8y10P7sSSOLEcw=;
	b=d0QLvGGBXR++0sfI7hBvbcjV/d5k1+J2F3u4glhEarSgkt9vMpcM0girfCj/uscrReqWUQ
	ieulS50IoYNvAOxpmp6Buns768cVVAfFn+Eytmfs5DuOTghok0KPkC0mfvn8llhVsd/XWj
	kQeSfZZkIV398R4FYmmnm2xz1G7e5RJC9JwFEBOQkbF/cgDSPiYsRegVkibN1UNlZww0J6
	qts9DZAaIvarXGutSrBW/NZBBcl14FaWuE8dslPDbZ1Q1i1LI1kvrcP/P0Hgv/KcVqEzB7
	USAYvXdq/nIs8PfzHRWWEbzOb07nrtrRO/Qd7dqIQgoUJlGLgtAL9lNuQ03KXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1697450990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lm/sCgLXyQJvjntNocjGInAVDmxpu8y10P7sSSOLEcw=;
	b=GqfycxaU1UC4UL17ePNW65pxcyj+LcCCc2oVXIXsfgRoFs1E67VckHwCp+X+akV3Kr9ovc
	XQzi0bUxm8wP+EDA==
To: Dave Young <dyoung@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, Linus Torvalds
 <torvalds@linuxfoundation.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org,
 bhe@redhat.com, prudo@redhat.com, ebiederm@xmission.com, vgoyal@redhat.com
Subject: Re: panic context: was: Re: [PATCH printk v2 04/11] printk: nbcon:
 Provide functions to mark atomic write sections
In-Reply-To: <ZSz7RFqv994u/Vt+@darkstar.users.ipa.redhat.com>
References: <ZRGvn4m2NGCn3Pef@alley> <87h6n5teos.fsf@jogness.linutronix.de>
 <ZSADUKp8oJ2Ws2vC@alley> <87il7hv2v2.fsf@jogness.linutronix.de>
 <ZSz7RFqv994u/Vt+@darkstar.users.ipa.redhat.com>
Date: Mon, 16 Oct 2023 12:15:42 +0206
Message-ID: <87il76ho9l.fsf@jogness.linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_031001_812835_0DC5F135 
X-CRM114-Status: GOOD (  12.40  )
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

Hi Dave,

On 2023-10-16, Dave Young <dyoung@redhat.com> wrote:
>> > Does anyone really want explicit flushes in panic()?
>> 
>> So far you are the only one speaking against it. I expect as time
>> goes on it will get even more complex as it becomes tunable (also
>> something we talked about during the demo).
>
> Flush consoles in panic kexec case sounds not good, but I have no deep
> understanding about the atomic printk series, added kexec list and
> reviewers in cc.

Currently every printk() message tries to flush immediately.

This series introduced a new method of first allowing a set of printk()
messages to be stored to the ringbuffer and then flushing the full
set. That is what this discussion was about.

The issue with allowing a set of printk() messages to be stored is that
you need to explicitly mark in code where the actual flushing should
occur. Petr's argument is that we do not want to insert "flush points"
into the panic() function and instead we should do as we do now: flush
each printk() message immediately.

In the end (for my upcoming v3 series) I agreed with Petr. We will
continue to keep things as they are now: flush each printk() message
immediately.

Currently consoles try to flush unsafely before kexec. With the atomic
printk series our goal is to only perform _safe_ flushing until all
other panic operations are complete. Only at the very end of panic()
would unsafe flushing be attempted.

John

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
