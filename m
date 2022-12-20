Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A84BC4332F
	for <kexec@archiver.kernel.org>; Tue, 20 Dec 2022 11:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=USvWLFWQUXbgTelTGfw5yMDPCPB9fMZaBdG2clwOltQ=; b=FztXixvM6vEgxV
	oq2SCi/Aa6Vap2fRioT7orAym+EUFjjGqN70NCzUmR1/IycyeEVhkZkwSe+jzz7MCMsFliccFe3O1
	Q4a+F5K5fsEqZZgh9va0DTlHyTrniD3XU2cQYM+UFd0hsy4M378yPffeb6Qa0gWYXawh7fwYQNx8m
	NNIxJhFGn9szaX/c9+q5FawUMv2PbP5an6RisPU56naigWwWU3L30lS1IFsQepCFu0DQ0yIh7m8Yx
	ruotI2mX6dU3ODMHIkjDGyCM5hWGRaSmQUnEU4h/rfv47gv4O6OkbGngS7E20HYNES4S5GJd2/nP3
	bdd7cenXmqWdUWdReV9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7axf-00DxeN-CB; Tue, 20 Dec 2022 11:39:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7axQ-00DxVh-AG
	for kexec@bombadil.infradead.org; Tue, 20 Dec 2022 11:38:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t89MKrBwUBLS+ByzcZGzZZQEQJcYQVoYJCazuvi3KIQ=; b=EAe87txzRGIH62QagEKuf9gafY
	x965J8pybTHj1rp6tKY8G9ajKrYYFbG3HvN7WsDG7U61sApoWul5/WISscm0GoO4jK0XNyAnH1nC4
	3oIZ85eNPc/j2mSW+Fbm/1O9Im+FtlHNIizu7LMNQQ6QMIeKOafsReKYwdUIniMC1/BCdYFgJTsdZ
	OaTFDf5b8up5FSRNCSs1FSA0inFoQlbD6V2miDtEsND2LAQgZBpBohUKPy92lE6FT1WkrJIWODbAF
	sFrhCxHFrzdsawFQdaXbnY+d7VxoLG5VcHTUP+KlQOXmZky+C2KHJI2np255QxfjQQXnmc9HzTD2p
	pjxiN2Cg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7axW-001kai-Jc; Tue, 20 Dec 2022 11:38:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 31E54300E86;
	Tue, 20 Dec 2022 12:38:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 12EAE20B0F896; Tue, 20 Dec 2022 12:38:47 +0100 (CET)
Date: Tue, 20 Dec 2022 12:38:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] Revert "x86/apic/x2apic: Implement IPI shorthands
 support"
Message-ID: <Y6GextAcO4OZig3Y@hirez.programming.kicks-ass.net>
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
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

On Tue, Dec 20, 2022 at 01:34:58PM +0800, Baoquan He wrote:
> This reverts commit 43931d350f30c6cd8c2f498d54ef7d65750abc92.
> 
> On kvm guest with 4 cpus deployed, when adding 'nr_cpus=2' to normal
> kernel's cmdline, and triggering crash to jump to kdump kernel, kdump
> kernel will stably hang. Reverting commit 43931d350f30 ("x86/apic/x2apic:
> Implement IPI shorthands support") can fix it.
> 
> The problem will disappear if removing 'nr_cpus=2' from normal kerne's
> cmdline.

And the root cause for this is... ? Does the kvm x2apic emulation
somehow get upset when we shorthand CPUs that haven't been initialized?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
