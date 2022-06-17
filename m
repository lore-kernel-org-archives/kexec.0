Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CFEC43334
	for <kexec@archiver.kernel.org>; Fri, 17 Jun 2022 15:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iZhFlmTwaY1+vzt2MbxtG0PWV7UmgFY66bZzAsU7G+Q=; b=Eh7hTiqzW+yKvP
	IOAZ8ky6FtRYys3qnjzHj1egUh6oaNfMFBNk35FGexq4bKgK9WwOyUSHlBuPvvu2UB8dv8lfLg/x2
	3RUFGdoINqd/sGrFaO52h99VAUebT6pNoaqVY64eswtnqnmKz5V3N+gP++1OcPiq2bkLWMRvo74n1
	DfqnaLM+olciydJFLIKNCvgk9heavtQ6wC6ytjvsWKIFj8m2VPbhdsJYgXWYnmQpZ2PRi74Gm1ScD
	Wb06N5loOoZ/b3ThQ0EYFji4HxEW+4qBVeM7V5coJXvkSnFL09pExu5BhBkNaVcEZgJOOHXN1LTZl
	YfPVAq1mWnC7uQ0UCHFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2Deo-0087Q0-FC; Fri, 17 Jun 2022 15:13:10 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2Del-0087Ob-M8
	for kexec@lists.infradead.org; Fri, 17 Jun 2022 15:13:09 +0000
Date: Fri, 17 Jun 2022 17:13:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1655478783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiu9PNjZtU75kIkIdHT6F9YTnsKXty0kUhXe7MZj/OY=;
	b=VWsUFRPGgm0fCvp7HHY7pbSwdK24YjbQEDDPhkEAbehRCbREWJMzfhCBrLLK5m6E5KAcg3
	s1imxbWmxgANfm+OdObHWUwrjG41h+XpIBjR/glouGvos/nuuA1c5mS8J+ORbVbD4vzgIe
	Y+K8U3lc5Zjv+RK0YaQAzd5tXQpZX9M3+RR2Bg9prOimxiSXzliW+S7eVR/G/Sq4B9WC6u
	6bbULRMq7dEuONqAlzPEzvy3OP2RboABzozdc/0jLYBgCEmMxAQQKdlEW6U6bXrGTDSFtm
	bhAr0zL+bTgMOtWoqk+BW/cGduuC/hexfOwfJs85yM66l4IK2tQ+sBScJs1mzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1655478783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiu9PNjZtU75kIkIdHT6F9YTnsKXty0kUhXe7MZj/OY=;
	b=5AJqEuLIJ5X0bNh+w9zDdl7BaWRhqliITi6SMcLGKXdiIjQ3+jnqt4RIpdbrpACZf5DNdE
	E2KAP1r1XKwMeBCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-rt-users@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
Message-ID: <YqyZ/Uf14qkYtMDX@linutronix.de>
References: <20220616123709.347053-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220616123709.347053-1-vschneid@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_081307_909970_BA9B96A4 
X-CRM114-Status: GOOD (  12.42  )
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

On 2022-06-16 13:37:09 [+0100], Valentin Schneider wrote:
> Regarding the original explanation for the WARN & return:
> 
> I don't get why 2) is a problem - if the lock is acquired by the trylock
> then the critical section will be run without interruption since it
> cannot sleep, the interrupted task may get boosted but that will not
> have any actual impact AFAICT.

boosting an unrelated task is considered wrong. I don't know how bad
it gets in terms of lock chains since a task is set as owner which did
not actually ask for the lock.

> Regardless, even if this doesn't sleep, the ->wait_lock in the slowpath
> isn't NMI safe so this needs changing.

This includes the unlock path which may wake a waiter and deboost.

> I've thought about trying to defer the kexec out of an NMI (or IRQ)
> context, but that pretty much means deferring the panic() which I'm
> not sure is such a great idea.

If we could defer it out of NMI on RT then it would work non-RT, too. If
the system is "stuck" and the NMI is the only to respond then I guess
that it is not a great idea.

Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
