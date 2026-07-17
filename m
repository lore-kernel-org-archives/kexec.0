Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A2EC4451C
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AwD3uL+AAVQiRMtendf4o0KrWxG2CpQ1isuuZXC/FbQ=; b=zlCiTKiJsjTF+Ji7hNuTnXZ+8m
	sQ8XSp414TCKXY38zu81I6L4IvOTKnHG63WAxLr/7IQ8V146us605COfacW9avPc+2ToEbc6AC48f
	gJwJM8mE0cDu+zmFcEwUuVWD6ZHfxcetnzdGk9gtCWYvJaMxkkR2PkEJdz3kTNKtu0A+r6wBiz2Qg
	iOHYQoh3yN+dlHf0KLcfN0It5l1eXWX6w6zvLoS1ZiOVcnm8GvuMSHPTGGJzLH4FCX8MpR4hf/FD+
	sz3H6c5FJF4m08a+XYC4K6ry89sssR14+ge/PKrVxskTCiYTgTJasCEydmKujZtzStT8MA3Ue8Kq0
	V8DsK6lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkiGl-00000002MUi-2iKo;
	Fri, 17 Jul 2026 13:06:23 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkiGj-00000002MU7-2CFZ
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 13:06:22 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-47de0093c42so3619275f8f.3
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784293579; x=1784898379; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AwD3uL+AAVQiRMtendf4o0KrWxG2CpQ1isuuZXC/FbQ=;
        b=HRKZNl2seyFM6eIlC2dCn5LrT8iDq3Hitr54qO+wZlScgTezQ7DrqQGYUghkSgrcV2
         PLoW1CIAoApPSmpySRuCL2QI0qAJEp97CdHQARR4VChDpOypt69PIURV6JX73ZWa7jX1
         fhG+iCqY+cyZpmox8iOCVJOzqOLOnYkYwgmc+wb3ob0SAc2Z7dj7NoVcdYXE3bR5VzOG
         NYxl/QT3HaFNS5Y5JUNtxSWhEvSGWXgzf3/446BtPA03mcmMykO0rrp9ljDpNG/HMNCf
         v4rNkyH6D2oi8QVwWhIi7tjaAfGE1oPB2ybfbN8hkz8+DIEyZksLRjXtIX5VdjtiBLMM
         6WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293579; x=1784898379;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AwD3uL+AAVQiRMtendf4o0KrWxG2CpQ1isuuZXC/FbQ=;
        b=ftT9FkbsZUh+JuGQ73vz4BpSzCg1TLrYG1KvFT6julNBvjanWFJPE4zytd7jQDTpVn
         j9pZNI1/UdMDC6zw8EiUDFXQvI7o2zZakgiWGFVn3Qry0gIY8e/nn1fNCpC7cYaiBK++
         MITxLyGfwgSgS/b6hOKgRVt4FZJaK6+0z1Hrb8B8J+ez9XvO1qSLIHI0nsm4zJQGKur8
         8EKqtopn8J9R9hrmZRO8U1iQ+Gjzogc+hxUt7pME1mediRYTD2u05znYaRZ+l1IyBszH
         6QodDsZ5/jQdIiKI7+iYUcfMYkSjWook4GwR+hIKN5FSDnwszwwlHTtonJsBuBGdXGDr
         Agfg==
X-Forwarded-Encrypted: i=1; AHgh+RohpIAEQjuoChGzSZHn8hAfeYY3DbZO8ZBjbcxhMVOvUbXNfnrApFOLDL+apnFr6d3/cm1Qgg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxkrLs4Z52IBws6SnkNZRJ7WSBaqFASxel21e/DryVBXvIsqvIF
	ejPLiLJwxQi/PkkheKaflqEv8S9IMjI3C8WHOZoIlEwluZXqHgo8ZgdI1QQhb4GOWAw=
X-Gm-Gg: AfdE7cn1fYOU5nJKNPq5V85RTINx9TQ6TvJQkrKKzlxSlvajv4yJzARCITl+w8Gx5cB
	0XCHHLX5i+OS6CQ6Ka/5VF93ITjwuVxTAiWi2moYHgNJ8//W+BlVn89OYqDcZiDTjap1Jwm9Jok
	Pj0CV1WVQFX7r704D8I/xppxzzC0D+XMPlizAoSCZ4H6nXaw1/GYFVTmYQt/aJ755fDMVPWa7oL
	Vg8hFvxoOwccZ5f+hqsafCrYnzk6Ie2gJYhcB3YuLVpx26PWKSxihcxp9/RksXZN5tu7E2zSp1x
	raiEttIsSBKiSzcWjdnCQ+ZP5fXXW9kFgTgePLcyHYlTN/Q0Y8Robnk9WRbfXCzd2aC5/zfpogf
	0sI8asJ704x4RZmfCxySqEK8vFvLQCdeB7dNJskT10YQUXrYJUG98gDu8JkGUCYEnggOt8c5dA2
	d4YVBm
X-Received: by 2002:a05:600c:3154:b0:493:ee2b:c8c7 with SMTP id 5b1f17b1804b1-4954a3e6e4bmr27741575e9.4.1784293577105;
        Fri, 17 Jul 2026 06:06:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e075d4sm38407825e9.1.2026.07.17.06.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:06:16 -0700 (PDT)
Date: Fri, 17 Jul 2026 15:06:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Subject: Re: [RFC PATCH 1/4] panic: add a pre kdump notifier list
Message-ID: <alooxg8FoExekPKZ@pathway.suse.cz>
References: <20260711002253.1115-1-include@grrlz.net>
 <20260711002253.1115-2-include@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711002253.1115-2-include@grrlz.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_060621_599473_4E1B9671 
X-CRM114-Status: GOOD (  22.14  )
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

On Sat 2026-07-11 00:22:50, Bradley Morgan wrote:
> When a crash kernel is loaded, panic() jumps to it before the panic
> notifiers run. A hypervisor or firmware therefore never learns that
> the guest panicked: the Hyper-V host never receives the crash
> registers, a Google gsmi firmware log entry is dropped, a pvpanic
> device never signals the host, and an AMD SEV-SNP guest skips the
> firmware and IOMMU shutdown. Fleet alerting, availability tracking,
> and crash logging all miss the event.
> 
> The only escape hatch today is crash_kexec_post_notifiers, but it runs
> the entire legacy notifier list before the kdump. That list carries
> slow callbacks, IPMI being the obvious one because it talks to a BMC,
> so enabling it delays every crash dump on the machine. Hyper-V forces
> it on anyway and penalizes every kdump for the sake of one upcall;
> this series also removes the forcing that SEV-SNP added for the same
> reason, giving SNP hosts the normal early crash kexec back.
> 
> Add a small dedicated list that always runs before crash kexec. The
> list head stays private and registration goes through a function,
> because the callbacks on this list have a strict contract and an API
> is how you enforce one. The list lives in its own file, not in panic.c,
> so the contract can carry a MAINTAINERS entry and the existing panic
> code does not have to move.
> 
> Priorities order the list like any atomic notifier chain. The header
> documents that they are reserved for callbacks that must run last, for
> example because they may not return or because they tear down a
> transport that other callbacks still need.
> 
> The notify path walks the chain by hand and names each callback on the
> console before invoking it. Running anything before the crash kexec is
> a reliability trade, if an upcall hangs or faults and costs us the
> crash dump, the console identifies the culprit instead of leaving a
> machine that silently never rebooted into the kdump kernel. Callback
> return values are deliberately ignored, and a nested panic resumes the
> walk after the callback that was running instead of refaulting on it.

This is a long blob of text. I refuse to find the details there.
I miss a clear summary how this list is different from
atomic_notifier_chain and why we need it.

My understanting is that there two "main" differences. The new list:

  + ignores errors. But this might be achieved by requesting
    that panic() notifiers should always return 0.

  + skips already proceed notifiers during a nested panic.
    But this is a rather theoretical corner case.

IMHO, it not worth the effort.

Did I miss anything, please?

Best Regards,
Petr

