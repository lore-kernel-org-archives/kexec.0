Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E62C43334
	for <kexec@archiver.kernel.org>; Wed, 22 Jun 2022 05:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+7tzXeKBb4TABBuC3boqEgkT7/uaNNhjcRSHniVVgxg=; b=eBuTw7kpG9TFsh
	y+nEjN/Yh2uHrbhQX9OJtde3Nbo52LBbRevJLHCyD4+gdmSmMSTaKoumpqLzBMsWAuKZt8tZSakFb
	SIddKuYDEXIYbS5RG5kyWgJMX2HkiaMLA2KCTDQzLBlyh3whnuMuXF2dAt+C+nfpwMQQA8+YDKbID
	ZejBxT4IDHsxHyaFvSXqlQLcrkUvJ9S2lAxlNirHvrjDDh72POwGIzfLweWaYdPsegonyJqWbDI/s
	GtBlEzlHmMjmCp0IJiZ3EEUmB0oTZTRcaPaqyUwqksgakCG/SefbK+aCioTD4Q5b0nc6W9OtMiURb
	jZxxa/CUrC/NnTdUpCTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3tDb-008eEl-GL; Wed, 22 Jun 2022 05:47:59 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o17eI-009ybf-Q4; Tue, 14 Jun 2022 14:36:09 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 8286121B97;
	Tue, 14 Jun 2022 14:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1655217363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7h6hH0gYTond1cgiS/uMW2G4mVmL8aIozW74ouv+gK4=;
	b=B9wTA4hA6Qxez4dhaQq2jaLjcRQqv8/C1d0oKbtJxHWYl3duIpfM3QjZ2J2ZIG1jByzjIk
	ObTWFZbyZcppMylTomPCNwhynw9TlYQGEMrmiuv4k8IcEezBoIE3JYy9Oiijt3mtdocbSR
	YntR36rSYs/Otfz0SDXm/BOtVHJZFAE=
Received: from suse.cz (unknown [10.100.201.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 0C0ED2C142;
	Tue, 14 Jun 2022 14:36:01 +0000 (UTC)
Date: Tue, 14 Jun 2022 16:36:01 +0200
From: Petr Mladek <pmladek@suse.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: bhe@redhat.com, d.hatayama@jp.fujitsu.com,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Mark Rutland <mark.rutland@arm.com>, mikelley@microsoft.com,
	vkuznets@redhat.com, akpm@linux-foundation.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
	netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
	rcu@vger.kernel.org, sparclinux@vger.kernel.org,
	xen-devel@lists.xenproject.org, x86@kernel.org,
	kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com,
	fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com,
	andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
	corbet@lwn.net, dave.hansen@linux.intel.com, dyoung@redhat.com,
	feng.tang@intel.com, gregkh@linuxfoundation.org,
	hidehiro.kawai.ez@hitachi.com, jgross@suse.com,
	john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org,
	mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
	stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com,
	will@kernel.org
Subject: Re: [PATCH 24/30] panic: Refactor the panic path
Message-ID: <Yqic0R8/UFqTbbMD@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-25-gpiccoli@igalia.com>
 <87fskzuh11.fsf@email.froward.int.ebiederm.org>
 <0d084eed-4781-c815-29c7-ac62c498e216@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0d084eed-4781-c815-29c7-ac62c498e216@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220614_073607_035996_14D36392 
X-CRM114-Status: GOOD (  25.81  )
X-Mailman-Approved-At: Tue, 21 Jun 2022 22:47:55 -0700
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

On Thu 2022-05-26 13:25:57, Guilherme G. Piccoli wrote:
> OK, so it seems we have some points in which agreement exists, and some
> points that there is no agreement and instead, we have antagonistic /
> opposite views and needs. Let's start with the easier part heh
>
> It seems everybody agrees that *we shouldn't over-engineer things*, and
> as per Eric good words: making the panic path more feature-full or
> increasing flexibility isn't a good idea. So, as a "corollary": the
> panic level approach I'm proposing is not a good fit, I'll drop it and
> let's go with something simpler.

Makes sense.

> Another point of agreement seems to be that _notifier lists in the panic
> path are dangerous_, for *2 different reasons*:
> 
> (a) We cannot guarantee that people won't add crazy callbacks there, we
> can plan and document things the best as possible - it'll never be
> enough, somebody eventually would slip a nonsense callback that would
> break things and defeat the planned purpose of such a list;

It is true that notifier lists might allow to add crazy stuff
without proper review more easily. Things added into the core
code would most likely get better review.

But nothing is error-proof. And bugs will happen with any approach.


> (b) As per Eric point, in a panic/crash situation we might have memory
> corruption exactly in the list code / pointers, etc, so the notifier
> lists are, by nature, a bit fragile. But I think we shouldn't consider
> it completely "bollocks", since this approach has been used for a while
> with a good success rate. So, lists aren't perfect at all, but at the
> same time, they aren't completely useless.

I am not able to judge this. Of course, any extra step increases
the risk. I am just not sure how much more complicated it would
be to hardcode the calls. Most of them are architecture
and/or feature specific. And such code is often hard to
review and maintain.

> To avoid using a 4th list,

4th or 5th? We already have "hypervisor", "info", "pre-reboot", and "pre-loop".
The 5th might be pre-crash-exec.

> especially given the list nature is a bit
> fragile, I'd suggest one of the 3 following approaches - I *really
> appreciate feedbacks* on that so I can implement the best solution and
> avoid wasting time in some poor/disliked solution:

Honestly, I am not able to decide what might be better without seeing
the code.

Most things fits pretty well into the 4 proposed lists:
"hypervisor", "info", "pre-reboot", and "pre-loop". IMHO, the
only question is the code that needs to be always called
even before crash_dump.

I suggest that you solve the crash_dump callbacks the way that
looks best to you. Ideally do it in a separate patch so it can be
reviewed and reworked more easily.

I believe that a fresh code with an updated split and simplified
logic would help us to move forward.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
