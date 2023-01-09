Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917C9C54EBD
	for <kexec@archiver.kernel.org>; Mon,  9 Jan 2023 22:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mqbUUXJEfjqnNBHecy1OJ2l3/jpiVmOtFF9Mt8YoX2E=; b=O4JTmDJdhXiFYJ
	0q6YNHx+9aBMfc5a53vIcvzP2GsHOh5rqam3Tx1ypj3zbY1angEO9geWVmI4lqBZa7bNjIJgmg4di
	8CZ/iwS8bRs3CkXt2MCb5lsPUtBPuZQN2QXuG4ApCt4SIYW2nmB5L2vorqUB+necwGRkGOLaf7Bzk
	xMaOIVEqYoqpenhOECpsw3eov3Y2h8vTTJW4FjCfmkypmy4lD0uHWa1M1spW7r4NiUCTSuArKNoau
	R124hV085iJ6A9oEm7USmj49sdTyo/5rc2swpVLNvy1aD/qHvCLcEubtrBCq+KWqBWZYp3qAEPQ42
	wa2clsx44LeXnSEZJzHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF0DY-004Pi7-50; Mon, 09 Jan 2023 22:02:08 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF0Au-004Oi0-Lc
	for kexec@lists.infradead.org; Mon, 09 Jan 2023 21:59:26 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1673301558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lJsii4i71+hR/Zow3BBmUJvSKWIMnBCHJnVycxvMCzM=;
	b=xIQj6zSVzeqQxUTaQvalDfoNTQ453GHzjvIEJnNxiVZf0JtoTLmLxUj8M1e3A5RJhSUB9s
	C5Chc2nqMfxqqaje5+6s2bV6JvWq3SyhJFe6jYLoAL5cvSkM6TsVcun3zvSr0TRokvlVAy
	cTPQjneadv5SVL6Oxdjjzu+YLcq4d6NcTTpbMa8swohYbK6X84rZVpwdWlaAXqFlCmU3DS
	5cyqb2eKJMZfGbJjQx/w+qiBeYnwNAFlOt335DaN6HTIUPhKOqOGhXAXqxjhX8HjmGzNaW
	OiiEialLAL8ACh7/M0q9x/ODwG3+7WIKHYIZ4EFKB3GSndvukqekstQtgzNkgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1673301558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lJsii4i71+hR/Zow3BBmUJvSKWIMnBCHJnVycxvMCzM=;
	b=MKTZ/bzP0Jfe2h+PAPjit+oxHv+LtBpRpU0Cs91Uel3zTGEWUnQt+tafNRIckgmGwf0ZxS
	CN5YNRNrn4x2E1DQ==
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] Revert "x86/apic/x2apic: Implement IPI shorthands support"
In-Reply-To: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
Date: Mon, 09 Jan 2023 22:59:18 +0100
Message-ID: <87k01vjrnt.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_135924_878280_250712F3 
X-CRM114-Status: UNSURE (   7.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Dec 20 2022 at 13:34, Baoquan He wrote:
> This reverts commit 43931d350f30c6cd8c2f498d54ef7d65750abc92.
>
> On kvm guest with 4 cpus deployed, when adding 'nr_cpus=2' to normal
> kernel's cmdline, and triggering crash to jump to kdump kernel, kdump
> kernel will stably hang. Reverting commit 43931d350f30 ("x86/apic/x2apic:
> Implement IPI shorthands support") can fix it.

Is there any output on the early console or hangs it silently?

If the latter, can you attach GDB to the guest and figure out where it
is stuck?

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
