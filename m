Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD57C5B56A
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 19:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+uiiP5F3lsr2NVoL/RaZc+Y6YQhERqKSQ2XX6+ZpE3I=; b=ED/FCtXLWzZvC9QrR+4/VhCAjY
	jYO8hmOdxg41w7WMBSm6BhW5IB/zIfrifvKRsE83OfP3rL2GW1OC0YXHzJcjlb+iFKdsE/0gGe2bv
	OLqkhAOv5lqXOS/hnIS6E1m2x7GGfOEXW6Ep272jxKoGSu6Ks3++WoQ87XtVPx0SNwyWMr2IduHCa
	Utxni+Dp+AjZ0k/XVvwoLdlJXp8h6TuqJIgvx+GDsZ8U+c3Dopr3gElXwx2w1uc9/WoOVFOHc0aK+
	CjuCR2DBy8RiNGecD2Y48aOuo9Onkdf5v6KWsFo5+mmbjwDQ5vELfjkjZgReKAQ3tH6sRNWMg3bYe
	kEEdDAGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wts0L-0000000Ep9L-0JyM;
	Tue, 11 Aug 2026 19:19:17 +0000
Received: from mail-ed1-x545.google.com ([2a00:1450:4864:20::545])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wts0I-0000000Ep8X-1TEj
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 19:19:15 +0000
Received: by mail-ed1-x545.google.com with SMTP id 4fb4d7f45d1cf-698a99b6140so145406a12.1
        for <kexec@lists.infradead.org>; Tue, 11 Aug 2026 12:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786475952; x=1787080752; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+uiiP5F3lsr2NVoL/RaZc+Y6YQhERqKSQ2XX6+ZpE3I=;
        b=Zif3tXPSG+H548JePD2EBzknfBKPPATMTClivWUNk2cju1ebs+f/aI4ysOihWTL0Xy
         FXoB+VBAoW5gPMT6D5lThobfC0wnFa8UKggXIY810VPpefLF4MRKbpHcHkysqt+WPHvT
         9K7ysT+++s8w1GxIv8Qy9aywsB4+DgtNkktnKLShkwsK3E73pls7SYwASmHvL5COqC/6
         jJzQEsmx9wMPTz3qnKD0sO64XxP9MiCUYu+UUZVkmk4kiAzaed7kRVIMUUgWjqCC+w7M
         Q+sikMS7ijsEtC6GxofJmgOOyqi/2xrORmOPUINAab5iQJOf6DSrupv3wufIQm7kh35O
         NnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786475952; x=1787080752;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+uiiP5F3lsr2NVoL/RaZc+Y6YQhERqKSQ2XX6+ZpE3I=;
        b=TYc+0UDWP2U27hMBS/SGNBODQHUBepDLwZC7w2R7Rrnzq/uaC3iDE1tNnDvmgURKJz
         55AkkZgWxGepXIFHJ58XLRksnReTpVG3BPMmbSS6wMXsGfVyofZMIHq9QvwttWPAhRsL
         KD2B23gqjAkNPqcwlqlnZnrjC7bFbvBr/vxXdVpGxSB7Fze81/5VBGoGxQgDz2/yl/kA
         Cvh22wkNClhUimCRizYh7YwCn20wVHqng7JSTFRS7g+fUoG4mq7pTgcdvOHaacbam62C
         2EqyuN4m64cMmvQkl9OeLbL4sZhwyMD60uExeQSVprwdEawSbNouqyd6qLjImuANwHSS
         rI/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr4hNifPgpLnyYc6fn3o9R3ZzyGxihQJk8KfCHaFvkYbCjrvXGTXNBJSKvGdvvZxoUkBBGTxg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz2+pPr5/k/p9KsCChm/SoW6JaMvJ5YKuREKrHTyol3eL2Nmkv1
	c/4zjdsU6oZfwFDi9cBeOJHL6AcxD/D4eQSOrHlRF9HWWWYem+bUhVeNgUyK+DCb/kD1w+SC/qX
	7XRZ3nRXZU4b/OIv87w==
X-Received: from edt14.prod.google.com ([2002:a05:6402:454e:b0:6a0:4d21:a35e])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:458e:b0:6a0:c763:89e5 with SMTP id 4fb4d7f45d1cf-6a36c890c5dmr1312878a12.19.1786475951534;
 Tue, 11 Aug 2026 12:19:11 -0700 (PDT)
Date: Tue, 11 Aug 2026 19:19:11 +0000
Mime-Version: 1.0
Message-ID: <9huzldaczcr4.fsf@tarunix.c.googlers.com>
Subject: QNS: ARM64: Cache coherency while doing Kexec for KHO
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, will@kernel.org, changyuanl@google.com, 
	Alexander Graf <graf@amazon.com>, mark.rutland@arm.com, jgg@nvidia.com
Cc: linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_121914_392151_34CEEEB2 
X-CRM114-Status: UNSURE (   6.17  )
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


Hi,

I have a question regarding cache maintenance for Kernel Handover (KHO)
preserved memory across kexec reboots on arm64.

During kexec, all other CPUs gets hot-unplugged where they flush all
of their caches so there will be no issues with any KHO data preserved
having caches on these CPUs.

But CPU0 still has not been flushed its D-cache (Is this correct?) and
it will only do flushing for specific area by kexec_segment_flush().

So for KHO preserved memory, if its caches still marked dirty on CPU0
they will not be flushed?

Is my understanding correct? or AM I missing something?
Also if this true, This will be a problem?

PS: Pardon my less knowledge on ARM64 cache coherency.

~Tarun

