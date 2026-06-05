Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25D8CD6E7C
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 21:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1+3OWqiUrkFxJENq9oUtcFjYhrvK0bni0JrOu1K6jSU=; b=GNjjhi8gQs1RaKM0BLiIPupCBR
	cTiLFHYN7raeW5a1u/TnU99ddLad6igfz/0eW7Pi8w7NZFyi2FpPsC5ZJexbG87g/BMrunJP0p/hG
	Jw1rVS/y4vRfso+zTyJr5u/IPltn/7UURBRzOI/uHSWMaFy4atmVhFIO2TJU9a50gV6AUCJ8Z0jPd
	kwa35mysoLL556GPD/mNRMGkK8E+PJLzTrwokrJQdf7rGSazpKuT6ow6zuH959w4dR5ODd7VVn2pH
	XZ1ePMgVKOJ4a5ejD1D0B/2UZhax6+OhJi22RJT4uX/VPRZNOJyJXxjCtBHaNZ+yjhkbblwdJOMfp
	sqOP6rqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVcMp-00000001D7M-1qh3;
	Fri, 05 Jun 2026 21:46:15 +0000
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVcMm-00000001D6q-3X3a;
	Fri, 05 Jun 2026 21:46:14 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 71CB9EC01CE;
	Fri,  5 Jun 2026 17:46:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 05 Jun 2026 17:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780695971; x=
	1780782371; bh=1+3OWqiUrkFxJENq9oUtcFjYhrvK0bni0JrOu1K6jSU=; b=2
	3cjWCnCrrBfr26y/w07U1sneFXm6ziJuzaNuwTTTxQSKZBSsHr8/dyT6HM/F0lZQ
	S2Qb7wDh2EVuuZT9ux9gW3iKG4BgG1E3IGA5GH10BUy0Ii8KoJejmqK7Dcz6xuk5
	HG5OhGATGZzKadzXxJkxWyfkXexNFIhkwUCgFrvAIItmosD4DqCYByo/zMHKlApr
	vi0p/vneA3rxr4rvdbDcrG1zZG1T4YL2MihtA0xIhE4fp+NyouDSYU0KrO3PCCry
	JlSIVBzf45YPtDgUzP0JQgjF9GrC3Pu1prIgQbTcUIuVCND/AU3Ivc8uTekoQ7qQ
	FYjXvD5msA8/nCEXmvJLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780695971; x=1780782371; bh=1+3OWqiUrkFxJENq9oUtcFjYhrvK0bni0Jr
	Ou1K6jSU=; b=jTVlvPX94K+KWtwzY3+9glRSSHe5SvcpYomzsQ+C2pgFvNyhjZ4
	n3005XfkIrBU/T0U2UA/qIzgaEnLNMXa8aRwYxljVcLJiyyNz2vfI+fGCWejCJsu
	Rpgpy8Wph10VmjnbZuWlywQWYAZcJHnD6z3YQuEdyMLHKfCSXDLnphYlSFfaGeUv
	fx5sy3Uu5v8c2/dnouVfvq+7hSHguaoyK0tl5UdfQyQrO2dsyIcG6/FenVmVyQhD
	Xzr8pSXi++6wx8UhyYdjmbatsB1Sz06pE2MJwaH0uvqBRepNVYTX0kgVytNaSPcA
	c78coD/3+0ZBY733VAEpb976JMg56gr/PMQ==
X-ME-Sender: <xms:okMjarnvES_ZxKOnz9fMITLoYbS6fOccjjCBk4EcXDJYW5FQww4ndA>
    <xme:okMjah9Ks2eh-I2IN7-TQP5DVgWJDI99XcnDby7BGVQh8JnQhTQ9alVwPXaz3a41W
    pPLYDWPp6wlwSTd_qSaIauaB_YkPeLwyYRE0iF815hge6mHc4CAkAwn>
X-ME-Received: <xmr:okMjavH6wpZq2tMz816XvGRe2wWXbh9CA0L13s-2kru8DWRUytPePC5EZK8iUQ>
X-ME-Proxy-Cause: dmFkZTFZ6rAbR2GMHTid5wNQ1HjyoZpQYbTjcFFBK/N5lbGTfynlRXMekiZKWNKb2tUotG
    bo9OCxe360C69aeh2/apMnYP5gTDbXtnQqf1kRmOXi86jFeg5DwhUW9SOCznLRo80VyDMV
    tDtHcIkLt1KJCvmXSZ2wSLythxmgF3+GaMJwohFlCSqyBugAtUct8QZf3IGsZucFLJH1za
    T2T/LmSRn5RsqnKVFgGmIT9VCqwJwO5RrhnjI0MrAZ75P2/vPU2jsFs01O7VBwTJGx+4NO
    jxYIZNglxQNdejWBHAZgliIvru8kj8HDbiICk40eeV4ad6KKJpKOJIReFFm2su4kjoLwpL
    Eb3llxKasvEjmqw9mJscZaqews3HoxUzxYDktcMh/paO3imJOlZbak87iepAixSNZe30wJ
    gh/J559gqZM0ARZA5LKwy72IlN9xbDUqgtW0PsLFcEI18+pG1tBtTqgeSZn7PUk2kvwgO7
    cXpuP2EFcM5A+ttbeqnR/M0rgP3l9514b9qnJFjn2XLRGuCcFcfdrVhrU1JRP49Vcb+4ep
    xC1d3sjJ987lUu7XiTUzPcCFiQekODFgnpDtbLSXkrarmXPhLwToCQZ/XcYTn3L9ZnWf6u
    UmAjYCQTXES+mmXH2OVKgihkIAzM6FnmbizrHoy3JxZb7a+/+Sl62ltawrkQ
X-ME-Proxy: <xmx:okMjaoLdx8FVPXJJnjBpSfsaVc8Rq20gnss0jBGC8ZVCg622BSZdPQ>
    <xmx:okMjaodK0T09EsAEHemFml2rlbfBl4dvHoqyARJWJj0P8n7RdMv_bg>
    <xmx:okMjagXpEB8YnT9JfkqPFFF4MqEvJZdlGAD5pPK6v-8aXo9rhimhIw>
    <xmx:okMjagBnW1yHabdj3RyflUUa_aO76g_8rekOq3YkiW51Z9N6XKrNIQ>
    <xmx:o0MjarJp02hP8BFOr6AqmTJxnq_6V_931MWvd0rnv6tnGCBk1tre1_p3>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 17:46:10 -0400 (EDT)
Date: Fri, 5 Jun 2026 22:46:09 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Doug Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Lecopzer Chen <lecopzer.chen@mediatek.com>, 
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: route crash_smp_send_stop() last resort
 through SDEI
Message-ID: <aiNCk2M0OlD7VaEs@thinkstation>
References: <cover.1780496779.git.kas@kernel.org>
 <54cb99db3c981dc39eb3031aff5caeaadb09e8b9.1780496779.git.kas@kernel.org>
 <CAD=FV=X5++c-6Wd6babajiPbn07cfPcG0uW3ZeepznXgSVO2+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=X5++c-6Wd6babajiPbn07cfPcG0uW3ZeepznXgSVO2+w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_144612_966054_770C1D84 
X-CRM114-Status: GOOD (  17.68  )
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

On Fri, Jun 05, 2026 at 01:42:57PM -0700, Doug Anderson wrote:
> > +       sdei_nmi_crash_smp_send_stop();
> 
> It feels weird to me that you're adding SDEI for "crash stop" but not
> for regular "stop". It feels like you should modify smp_send_stop() to
> fall back to SDEI if sending the NMI failed, instead of adding this
> separate path.

Fair. A wedged CPU ignores the reboot-path stop just the same, and the
escalation logic already lives in smp.c, so I'll restructure in v2.

One thing to sort out there: this patch parks the stopped CPU inside
its SDEI handler without completing the event, which is fine for the
crash case (nothing expects the CPU back before reset), but a generic
stop path probably wants SDEI_EVENT_COMPLETE_AND_RESUME into a parking
stub instead, so that e.g. a regular kexec can bring all CPUs back up
in the new kernel. I'll look into that as part of the rework.

> > +               cpu_park_loop();
> > +               /* unreachable */
> 
> Any chance we could avoid duplicating stuff from ipi_cpu_crash_stop()?

Yes -- falls out of the above. I will look into this.

Maybe pull the save/offline/park body into a shared helper that both the
IPI handler and the SDEI handler call.

> > +bool sdei_nmi_crash_smp_send_stop(void)
> > +{
> > +       unsigned int this_cpu, cpu, remaining;
> > +       unsigned long timeout;
> > +       cpumask_t mask;
> 
> The above will probably get you a yell. Putting "cpumask_t" on the
> stack is a no-no since it can be quite large under certain CONFIG
> options. This is why it's nearly always defined as "static".

Doh! Will make it static in v2 -- safe here since the path is serialized
by the crash_stop guard.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

