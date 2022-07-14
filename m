Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61BCC433EF
	for <kexec@archiver.kernel.org>; Thu, 14 Jul 2022 19:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AKzxYrihGto+te5EvSWjyKq+Ukzq/9oRbHSdc8OeQEs=; b=AOGZwXByQ04D8e
	gcZgNcSZXl3prGFV2d51dwgCvzY8D08pAVhd7nSgok1Bh9meZaEmwDIPXOa4u+XUTE3+VPqMdtqo4
	B1uKZijZv8LZH0cyXsy8/g07KWyF3KEM4tcYxQNc9tMXP6OBrPmlk5hhX9QniY+GQkYOQav9nI9bf
	NyVV0CzEQgBqyASxFi+gdyeR0IGkCFbzg6Pw3gx9OdC/6kYqOXVwWdAp8aIBBP7FH3HSgO3yyPGUr
	GyShzaY75G/BlW72ngkfEQj2uuze1kSptnH7jNHYQ0p6+3Z8zgwSzq4sUI+oirW+B0QkgDSFiMfUr
	M6YlrMIfuHZ+P09hQc9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC4cJ-000lx8-UQ; Thu, 14 Jul 2022 19:35:19 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC4cH-000kuk-7C
	for kexec@lists.infradead.org; Thu, 14 Jul 2022 19:35:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FRi6FX1mHfIDY8XJziHRe5A/6ngtGKMangsD1+ldoWY=; b=grq8cX6NN7Zndo+VE4Cg6W7oRd
	w1+eQbW+a/UX7G+VLEXLvx3Zo3qFAvjLt8eWNkuPlbuH1Lb11BNNJfVvRz8C9gaYVEIrwR3sI4dFO
	eM3GjT7ojx7wiQEBP4K5FMJWdlwA9yWeyuy78p6z0PqRbV2PKZMLet0ki/C31YBA1Kg9UBLCBOolp
	P+LmPzx4Ouv6RL/TioGnrb4P4zMWQcJf4vV7aAqg8nDmylbBnsV2CZpAJUFqD/HFntpzvCk27rSRk
	bhotmfsGYHTdd2JIOFdCBFR0olLgfhgj0a8j82ZtkGCte/I1DsA6OnBuSaaGWpNieRLxF1BHTEkbX
	3ghR/quw==;
Received: from 201-42-109-188.dsl.telesp.net.br ([201.42.109.188] helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oC4bk-00GmV3-G3; Thu, 14 Jul 2022 21:34:44 +0200
Message-ID: <bf57256f-127d-6f26-404a-b9cff6df70b3@igalia.com>
Date: Thu, 14 Jul 2022 16:34:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Unstable tsc caused soft lockup in kdump kernel
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>, jstultz@google.com, tglx@linutronix.de,
 sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org
References: <YrwokiIVX9E9kQIh@MiWiFi-R3L-srv>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YrwokiIVX9E9kQIh@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_123517_271200_B432FD81 
X-CRM114-Status: GOOD (  16.17  )
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

On 29/06/2022 07:25, Baoquan He wrote:
> Hi,
> 
> On a HP machine, after crash triggered via sysrq-c, kdump kernel will
> boot and get soft lockup as below. And this can be always reproduced.
> 
> From log, it seems that unreliable tsc was marked as unstable in
> clocksource_watchdog, then worker sched_clock_work was scheduled. And
> this tsc unstable marking always happened after sysrq-c is triggered.
> And the cpu where worker smp_call_function_many_cond is running won't
> be stopped and hang there and keep locks, even though the cpu should be
> stopped. While kdump kernel is running in a different cpu and boot, then
> soft lockup happened because other workers or the relevant threads are
> waiting for locks taken by the hang sched_clock_work worker.
> 
> Any idea or suggestion?
> 
> The normal kernel boot log and kdump kernel log, kernel config, are all
> attached, please check.
> 

Hi Baoquan, interesting issue! Do you happen to have a full kdump boot
log with the issue? Maybe collected through serial console, etc.
It seems the one attached is from a succeeding kdump by passing
"tsc=unstable" to the kdump kernel right?

Also, did you try to "forbid" tsc to get marked as unstable in the first
kernel, before kdump? I mean like a hack code change, just prevent
kernel doing that and seeing if it works. If that still fails, then it
seems the cause of the issue is the same as the cause of TSC getting
unstable - in other words, something would be causing both the kdump
kernel lockup AND the TSC unstable marking in the first kernel...

Cheers!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
