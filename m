Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43B4C4451C
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uFzfVcYgDKfNQdQttDIrXNQpy6cqxkNgJR+Y4zG6BXU=; b=EOQlhHcV07ouaNxtMKHTSpS6YF
	uA8eDwOxDhCNMwoIXstIRqzAQYD3OC69MjrlqvsUwcN8dUiOv6oWu6Xbrjutmbv8pK723oYXlOq+z
	+pwo2AXR/yB3Hb/idp2kY9Z9PXcYHbmq95FV+b+wRc6zVauKOrgmoYr1Hz6bQ6Di/rijokL7h+iJK
	k2lPmzyH4+1Lwumnd8L9qT2MS3IphMIV1xw/me9+qgvqQ8UCuGwoUn89vS2wtKQmRb/NA7Bgqycc1
	XH84ydaQff1lNG4EF6ObKcD0PWcRE6b/YZqTHdURmAkGAJUvMQeR2or7gSnU8MG+B0HD8Ozvn/5tm
	QvbWiPDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wki77-00000002Kzj-1UsV;
	Fri, 17 Jul 2026 12:56:25 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wki72-00000002Kyz-1Hvv
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 12:56:21 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso7245345e9.3
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 05:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784292978; x=1784897778; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uFzfVcYgDKfNQdQttDIrXNQpy6cqxkNgJR+Y4zG6BXU=;
        b=fIoi4uuQnq2BYeBkKQpNf6JYgiXjx83OpRks4TePbYpWbwYyYnsV20RGm4SH0MfJmT
         mL89U+k6ppRpLu9IODRJR5Ox5gFcFaEnN4RBekkeLs1MWjQ1Az6vf8+eUCrHfV+Dct7H
         XLm50ZMh5JUQCnw6M05I/L3Gi5SmNIcDvNWkY/tVzrxa4dmsD3s73CTL6pri3PqCl4JO
         HzRvu6mBdfr0k+3V2cD3zAyZMe4DlvmMd1YawvANSihQS6jOKrDvb8cq8P7ELCL0CDTg
         7w+zBY3OFPxLcqvT7PG1gtXYHCxfATHnCIFS3JNHQVhaLUet3fzbyqhLLPQ8q7wPlVrx
         BhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784292978; x=1784897778;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uFzfVcYgDKfNQdQttDIrXNQpy6cqxkNgJR+Y4zG6BXU=;
        b=FSlHziuEsFFfuDqSYDrBPNuBdeRF8Xe4j/2hs7O4KUootJvxiwmfjUUPvcebciUlbS
         jLuEbbV3ugy32/27V0ioYo0h+heOBLthUe+HplQFezvDTC4FWDqijIhnB+Qv/yM/g/x9
         ySZWuHhiC8prfZ4EcKSCJ/SjgTrKSGKjOn2pc6jLc4qiRIpEMhfE7l6VXn4WfEbT4slL
         PrO3p57otBFiw8US7f//fvx9KfivKqzNjo1NI+/Hyv42sLTBUf/7lKWb6GGphNNB5E7v
         Z8BtmbOwDBDeHATfxMJKu6YgupRpuCqPhcwQP5GXjScu3kmyN7Z82pzrAYj6ZHUfIz1e
         ZsTQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro333cHCVzksr95N2xJTSRdPIPRq2SAOtqFHtLxCliYKDqRsbNTdB5ggnSCjAl+8r2x5GBUuw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxfHwjf275dG1dqmcu56MV7fvFZ5Xn1f6BRzJ98fvWM0yP+HFca
	yu5PcZhAtJPBNdyqQyBPNrTcs1T2M8MvaAf11qLKHqQT6W0U5Vj2KLIiuq3YF6/97Jzu9kz8zl1
	QQBFxyKQ=
X-Gm-Gg: AfdE7cmZdTPcY4Lw3HKJAe0w5FB4D2MEEhHAzqPeIwMOvoaqFAo8WjtB+5PRn0O4ZvL
	Eswm7WUtMfMdPmvLi25uLgDWovTd0PxFoGlaJ4eccJTNKepGDAuSaLbrWQDzlEF8vcWXcePB39z
	CugVB5bzvZV/6jCoQx7qdDXm9thJtxZj4SMkAvYiChzZpzakb1r4TSUOgV0+1imgbvJ32W+Gf1t
	cse5Y0GQRz6A3FVgr1QqvG/kX+rHhi7yE3c2RxJgU3pCndWKFohUg2y0caQdaHv0kTlqb6v9xUf
	6m8iCrGZXgiwaqxj+wdX7+vn+WDq0Mnve8Evfrzu16nIpzaQE/KPjJJDAHUz8Fxg3zn2rbXtmSR
	25UXzw6n4i8OF+lQg0PwhUuwjlOYaLDoKYLc2oo7tVpI6KcDZ3OLZQCWhl+aTppEIyqMrHkBKi9
	EB0lOW
X-Received: by 2002:a05:600c:4ec6:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-4954d5c913dmr9006345e9.7.1784292978424;
        Fri, 17 Jul 2026 05:56:18 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2eddb8sm95667855e9.14.2026.07.17.05.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 05:56:18 -0700 (PDT)
Date: Fri, 17 Jul 2026 14:56:15 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Subject: Re: [RFC PATCH 0/4] panic: a pre kdump notifier list for hypervisor
 upcalls
Message-ID: <alomb3-GRqMOouAD@pathway.suse.cz>
References: <20260711002253.1115-1-include@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711002253.1115-1-include@grrlz.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_055620_402551_6DD37CD9 
X-CRM114-Status: GOOD (  29.55  )
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
Cc: baoquan.he@linux.dev, arnd@arndb.de, corbet@lwn.net, gregkh@linuxfoundation.org, rdunlap@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, feng.tang@linux.alibaba.com
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sat 2026-07-11 00:22:49, Bradley Morgan wrote:
> When a crash kernel is loaded, panic() jumps to it before the panic
> notifiers run, unless crash_kexec_post_notifiers is set. So the
> hypervisor or firmware never finds out the guest panicked. Hyper-V
> doesn't get the crash registers, gsmi drops its firmware log entry,
> pvpanic stays silent, SEV-SNP skips its firmware and IOMMU shutdown.
> Whatever's watching the machine, the host, the BMC, fleet, sees a
> clean reboot instead of a crash.
> 
> The only way around it today is crash_kexec_post_notifiers, but that
> runs the whole legacy notifier list before the kdump. That list has
> slow callbacks in it, IPMI being the obvious one since it talks to a
> BMC, so turning it on slows down every crash dump on the box. Hyper-V
> turns it on anyway and eats the cost for one callback. SNP did the
> same.

IMHO, it is not about speed at all. The main criteria are:

  + what has to be done at which stage
  + reliability

I see that there are 4 situations where crash_kexec_post_notifiers is
set to true:

$> git grep "crash_kexec_post_notifiers = true"
arch/powerpc/kernel/fadump.c:   crash_kexec_post_notifiers = true;
arch/x86/hyperv/hv_crash.c:     crash_kexec_post_notifiers = true;
arch/x86/virt/svm/sev.c:        crash_kexec_post_notifiers = true;
drivers/hv/hv_common.c:         crash_kexec_post_notifiers = true;

IMHO, these point to the notifiers have to be called before
kdump because otherwise something goes wrong.

The rest are users who do not care. They have happily worked
as post-kdump notifiers for years.

> This adds a separate list that runs before the crash kexec no matter
> what. Callbacks on it have to follow a contract: no locks, no
> allocation, no sleeping,

This is required by any code called in panic(). It is not special
to the pre-kdump notifiers.

> other CPUs may still be running

Good question. My upderstanding is that people prefer when kdump
catches the system when all CPUs are still running. But it also
complicates any lockless solution in the notifiers.

> and it has
> to tolerate being entered again if the panic path itself panics.

The panic-in-panic is a dark corner for me. I believe that it might
happen but I have never met it. And any panic() code should do
its best to avoid it in the first place.

By other words, panic-in-panic is a corner case. We should not
focus on it too much.

> This is the minimum: the list, the hook in the panic path, one driver
> converted so there's a real user, and the MAINTAINERS entry. pvpanic
> is the first one. Its callback is a self contained upcall that already
> takes its lock as a trylock, so it fits the contract as is.

> The rest
> (Hyper-V, Xen, gsmi, SNP) come in a follow on series. gsmi needs a
> rework to a trylock because its old deadlock guard assumed the other
> CPUs were stopped, which isn't true on this list. Once SNP's notifier
> is on the new list, the crash_kexec_post_notifiers forcing in
> snp_rmptable_init() goes away and SNP gets the early crash kexec back.
> Hyper-V keeps its forcing for now because its kmsg dump pass also needs
> to run before kdump. The register report just doesn't depend on it
> anymore.
>
> IPMI stays out. Its panic handling assumes the other CPUs have been
> stopped, and poking a BMC before the crash kexec would slow down every
> kdump on any box with a BMC. It stays on the legacy list, where kdump
> skips it like before.

I am not sure if I got it correctly.

IMHO, the ultimate plan should be to remove the
"crash_kexec_post_notifiers" option. It is a black magic. Someone
has to set it because otherwise crashdump does not work. Others
disable it because it breaks or might break crashdump.

Alternative solution would be to move the potentially dangerous
notifiers to some optional list, aka, panic_extra_debug_notifiers.

> The legacy list, its position in the panic path and
> crash_kexec_post_notifiers itself are untouched, so the remaining
> registrants see zero change and nothing is renamed.
> 
> This is on purpose. Piccoli's 2022 series tried to classify every
> panic notifier and the list split didn't go in. This does the one piece
> that fixes the kdump versus hypervisor conflict and stops.

I am fine with moving one notifier by one. But we first need
to make sure that the split, ordering, and naming makes sense.
The good thing about Piccoli's patchset was that we saw the whole
picture. And I believe that we need the whole picture to make
a reasonable move here.

> One alternative is splitting the legacy list by priority and calling the
> high priority half before the crash kexec.

I personally prefer two or more notifier lists. Different lists
make it clear that they are proceed at different stages. The names
might even help to decide which list is the right one. The priority
is much harder to maintain.

Best Regards,
Petr

