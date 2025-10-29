Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F7ECCF9E9
	for <kexec@archiver.kernel.org>; Wed, 29 Oct 2025 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=esT651bRTLMfYO64YXGQAJOBt0V7qx7+gpXmLKe21Vg=; b=Le3YBPxBYWDhXYd9SML0TErgwF
	NG1mHZaz1uayXQ10ZDI8LEPz91NXVTHIARCTGjTYL3A0piQtgyO3WkfFYYMFgshChhlq3408+xpMO
	QtBbh8H1dpPrdi7ddBNjJag7kjQ/8ueJpUSI5Dge+GvvGdvU+uuXr6WbKLtVzYn7HSMKPSp68YzYP
	pu/T2PBeN8bR5HrBHeSmsCfsIir/T4gSYOa/7W8S2p4EhuOI24O+xAX5sHGf6J1f/HdliQfqOFWpp
	ppO0bOYsVN0TMNGryxngslX8cifesafm8hqzpYxlZCli/VS5aIrD1cL/5bT+X9FbO0yW9iy7NGJEd
	VWWS8nRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE53o-000000017Hw-3quz;
	Wed, 29 Oct 2025 12:13:52 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE53n-000000017H4-0Aia
	for kexec@lists.infradead.org;
	Wed, 29 Oct 2025 12:13:52 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761740027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esT651bRTLMfYO64YXGQAJOBt0V7qx7+gpXmLKe21Vg=;
	b=FNjg/KK3z43CBxdoBj4DiMOs6lEpaVT2c19t+sCcU5AnFVO//ILQqObKmdgVNHei83gaxh
	z9RxPcTXVixWGXfKVv6CO/prEPtQ38fEiG2sZEiHcpNexDuMUHydc8WO/9cVpIn9BMTUOL
	E1PFsRI3MNyAs2jMaXjU5fK1c0LW82/lHXZn3RtxqyT0cxzWpvgypVIYup8sRwglobt4ge
	xe33rDmF8gDrlitIgs7AFwCzwBXaZteHgvLktvsEUkToWNiEx15RjVwQyYIttgB+2sCLP4
	nyV92pk6a+XfkG621JknI8y5xftNJVuiQ+QLKqyqDBbqxWDrP3kqu2ECjGrwxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761740027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esT651bRTLMfYO64YXGQAJOBt0V7qx7+gpXmLKe21Vg=;
	b=GHI1xpu7ATaNuoTDBNyIGte1DBj98hRzidFOeQS/Z6SjdbJBBv14xsj9/Duna/GlphZwf2
	KelyW71TWP5MkEBw==
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Waiman Long
 <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Andrew
 Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, "Rafael
 J. Wysocki" <rafael.j.wysocki@intel.com>, Joel Granados
 <joel.granados@kernel.org>
Subject: Re: [RFC 2/3] kernel/cpu: Mark nonboot cpus as inactive when
 shutting down nonboot cpus
In-Reply-To: <aQH8KJ8RsnzbLfN2@fedora>
References: <20251022121345.23496-1-piliu@redhat.com>
 <20251022121345.23496-3-piliu@redhat.com> <877bwgw9yf.ffs@tglx>
 <aQAvnjVvJOUx78Nk@fedora> <87qzunuqqo.ffs@tglx> <aQH8KJ8RsnzbLfN2@fedora>
Date: Wed, 29 Oct 2025 13:13:46 +0100
Message-ID: <874irhvrb9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_051351_243012_CE3F328C 
X-CRM114-Status: UNSURE (   9.99  )
X-CRM114-Notice: Please train this message.
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Oct 29 2025 at 19:36, Pingfan Liu wrote:
> On Tue, Oct 28, 2025 at 01:59:11PM +0100, Thomas Gleixner wrote:
>> If you freeze stuff there is nothing to do. Hibernation works exactly
>> that way without any magic hacks in a particular scheduling class, no?
>> 
>
> There is a nuance: DL bandwidth represents a commitment, not necessarily
> the actual payload. Even a blocked DL task still occupies DL bandwidth.
> The system's DL bandwidth remains unchanged as long as the CPUs stay
> online, which is the case in hibernation.

No. Hibernation brings the non-boot CPUs down in order to create the
disk image.

Thanks,

        tglx

