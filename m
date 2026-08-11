Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6927C5B56A
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 19:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BeGshA0Vgo+UzbU0fiiao63/SMTHgTeOeOGAfbCNRM8=; b=lg8rFYEFkodatKv4sY6i9h8HiP
	EtdgRBb1SELaxvh37ICbabemPQkOr0RrN3vO5et8FrxcYybTKdmDr4kklBExIXDojfFlRv+srXX5C
	kCoDVY97ChtY1HKs+K4ZxdYS73PZ6+tHuRZFFE1Hg2boeQEodKZ4F3BBMPFbF0B7izdcvUroaRJes
	8INKzrmDpfcEdbsOchD3MP1/OGdxV6T9U0EQDGG3wlJZtV9awSI16i96s1n0Gx/0LK/RbsZETGmiC
	xb7zpuNyTnfga9y0ZiaVTXBEM2FzAhwQCSuLHsqxOK/Xj0PuIO5WFPLmCJurF0l+p43vtCqBHLiGz
	/4V/t5MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wts4T-0000000EpZz-2q36;
	Tue, 11 Aug 2026 19:23:33 +0000
Received: from mail-ej1-x646.google.com ([2a00:1450:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wts4R-0000000EpZ0-3mLJ
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 19:23:32 +0000
Received: by mail-ej1-x646.google.com with SMTP id a640c23a62f3a-c15e6109f9aso10870166b.2
        for <kexec@lists.infradead.org>; Tue, 11 Aug 2026 12:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786476209; x=1787081009; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BeGshA0Vgo+UzbU0fiiao63/SMTHgTeOeOGAfbCNRM8=;
        b=L5fXKNV13wIwUXnY540gk1x7QqdlAyOCeuDCP6Yu7kp5bmgHhGl4WVNSA1Gco8Ybqk
         /LKeP7bKRzBKNx7IMuYAW0F11fZBpNL4hdynMPRuQBHOxYNeMN4+vHBZrPoCz1EnxiuP
         VJgs4h60RjG53KPwi5h/E79nvpNPr5nsG35jjQRin1WURr4QrYvcjpzIOIBKOWoxdbDK
         N6DDmLgkEjqO96mb+UoPUXSUApFK5zdf+hXnjPJf70KgiymX5e2z91n/Y1+dcL9WQqrZ
         Py1GCprLjlCI9mSMs9CL34cATZdhw1bysmXNuJNTi5F9ZJ/cKrl0W5hew2WQyS2MD2Uy
         9JbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786476209; x=1787081009;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BeGshA0Vgo+UzbU0fiiao63/SMTHgTeOeOGAfbCNRM8=;
        b=NMqeWyJouRTraboVKJrMZtAWcRGb85QBz+7C2qZQ9PnJGhP/Lvf/4klhKEHWLt/BWq
         7PDUiQj7a4WMc3zJ2o1IJSmENodoAyvgLRj/grbjEsWqzb6dJdEQB5GVwvEjWE18j3gd
         bm1p65smwTTYctlNY4kusSS810iogrI9WklbjaiDZbImXr6+jxl/P8FNDb1/83yEaTm5
         3W9nRXLNbni0FTw+wyGjy1rX1SU3zOQHNwReUB1a1UbMGF7uxyYjlgfkeI8jLR+ndBFg
         pfJSRtIMuY3QqBVJmr8U0T3n6CPVPQjDYwlllrKB6VGe15D3raYtVwhSYmZBGBARBM1W
         J4xw==
X-Forwarded-Encrypted: i=1; AHgh+RqzzDbzf5snYqWN61OEAzCt48XsAZUcVEUTLf7I6pSwu4MKNa7qqh0xfOIek9ZoQrjfuCoi5A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7+3tWe2MhPg+Q+5/7Zvr+SIYYiW8yarZdmGdFjfjdtCi7rM6Y
	CT1vdew8dkj2TzpQw7iXX2UKjp8qfFrBNHxKZOJlvIRqozzYLcP0IXWbdBq1Agf6NR+A05XegbU
	K9GXWsdoLmIz/nbYAbQ==
X-Received: from ejcyl12.prod.google.com ([2002:a17:907:bc8c:b0:c12:9029:1b1e])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c16:b0:c20:7cb1:9046 with SMTP id a640c23a62f3a-c20e6072f0fmr297617666b.8.1786476208788;
 Tue, 11 Aug 2026 12:23:28 -0700 (PDT)
Date: Tue, 11 Aug 2026 19:23:28 +0000
In-Reply-To: <9huzldaczcr4.fsf@tarunix.c.googlers.com>
Mime-Version: 1.0
References: <9huzldaczcr4.fsf@tarunix.c.googlers.com>
Message-ID: <9huzcxvotqa7.fsf@tarunix.c.googlers.com>
Subject: Re: QNS: ARM64: Cache coherency while doing Kexec for KHO
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, will@kernel.org, changyuanl@google.com, 
	Alexander Graf <graf@amazon.com>, mark.rutland@arm.com, jgg@nvidia.com, dmatlack@google.com, 
	skhawaja@google.com
Cc: linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_122331_938913_6B2DBF69 
X-CRM114-Status: GOOD (  12.23  )
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


+ Added more folks to the lists

Tarun Sahu <tarunsahu@google.com> writes:

> Hi,
>
> I have a question regarding cache maintenance for Kernel Handover (KHO)
> preserved memory across kexec reboots on arm64.
>
> During kexec, all other CPUs gets hot-unplugged where they flush all
> of their caches so there will be no issues with any KHO data preserved
> having caches on these CPUs.
>
> But CPU0 still has not been flushed its D-cache (Is this correct?) and
> it will only do flushing for specific area by kexec_segment_flush().
>
> So for KHO preserved memory, if its caches still marked dirty on CPU0
> they will not be flushed?
>
> Is my understanding correct? or AM I missing something?
> Also if this true, This will be a problem?
>
> PS: Pardon my less knowledge on ARM64 cache coherency.
>
> ~Tarun

