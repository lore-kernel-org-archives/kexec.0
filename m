Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F145C282C5
	for <kexec@archiver.kernel.org>; Thu, 27 Feb 2025 19:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IFFmvepbAHGIi4eE+7E83mJ3vWJaaygsrq8wQ5ZcdZA=; b=gA2pzjnR9kyFgmgjgFI48Dnaum
	bU6VEc3ik0cuqAdpvoXzS24KXLU94zTkP9vMqTtiB3LFYtK5LiZ86/gUGv4UnYRDVTJtsY9dRuWRY
	8bzAQeBJHtXD6L8fP8H0kBcJMCPzGq86VS76FiezQcW1j34AZ4Zbzilo1mbJTWCEoSmTItJfAKbIv
	62lxQcmJ2DJgOC9M1kVaL1/BbrDZBNOb2X8mYJ5Iy9KtCdMxMT3L91+NWONEubYZohyCuLNcCjpeF
	WYP/XVx7l6jUpLPMG2Mbf3tiHtDMZYNgYmVVETlmldF8sOGKOHeYiLzH6D7fT45VrrdrdjfR9aUa3
	cVdpdHIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnjha-00000008UYv-0i5f;
	Thu, 27 Feb 2025 19:37:46 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnfqK-00000007uWg-185C
	for kexec@lists.infradead.org;
	Thu, 27 Feb 2025 15:30:33 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740670227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFFmvepbAHGIi4eE+7E83mJ3vWJaaygsrq8wQ5ZcdZA=;
	b=e5l6V4qmYG4H0zM87CUzcBa5SIGuUCm2KMFYJn+AjPhI5lG+zuTBV1dqlvDj66MuqLj7Xj
	ycSdw2YXLtaxpaqPNsxIupGBOAig8PexZbOhmtktwOpcuwOdqKnOZp5Mcl3onjvz4LJ2bk
	gX5zlTb77PuYbmzzbEAFKPScY53Axe5M7NTSnvFq3wRXivj4BxFGG2lKvg7vATHNz4NShI
	uxZ20GcDKBuESiUWhf3tkvzra9iJvT0OE0BZxAPBIvHyiPnqfKJxTDpS3chEj9/IRZUycL
	3h8Y3eSlgoJQFnShHQkC45oqsm6C5RdSFeA+ZHDDNQAltVfptK49Ka9BcOi9qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740670227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFFmvepbAHGIi4eE+7E83mJ3vWJaaygsrq8wQ5ZcdZA=;
	b=m18xiogJlgB17Q9YWLFgqD0iKxg/sqwt/cdC+kwED0mwXbfxesRAYhUqN4K6DI1O/F2d8v
	qC/Z5h/HYN0TOFAg==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Eric Biederman <ebiederm@xmission.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Todd E Brandt <todd.e.brandt@linux.intel.com>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Marcos Paulo de
 Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 0/5] printk: renaming some suspend/resume functions and
 one fix for unblanking
In-Reply-To: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
References: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
Date: Thu, 27 Feb 2025 16:36:26 +0106
Message-ID: <84cyf376ct.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_073032_447506_A0058E02 
X-CRM114-Status: GOOD (  11.42  )
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

On 2025-02-26, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> Hello, I've being working on some patches that help to clarify the suspend/resume
> of printk machinery. The last patch on this patchset address one issue regarding
> suspended consoles and blanking.
>
> This is a part one patchset that I would like to see merged before I send more patches
> that will rework the suspend flag (a global suspend flag istead of per console) and
> the removal of CON_ENABLED flag later on (I've created a function that will forcibly)
> register the console instead of using this flag.
>
> Please review!
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

The series looks good (adding the spellchecking that Jiri
mentioned). Thanks!

Reviewed-by: John Ogness <john.ogness@linutronix.de>

I think it is worth mentioning that the series was motivated by this [0]
discussion. And since I just mentioned it, that is probably mention
enough. ;-)

John Ogness

[0] https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.suse.cz

