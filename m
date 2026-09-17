Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F75C982D0
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 09:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jxbi13ouQTHyRdtBDlCDYfBDO36J/sfcBmF9VRStXnQ=; b=FNz/q79pKOr4eXwx0i83ojL8OG
	IKu2UXE6WJl/E5MpgtgOArPC4Ln/PnhqJ3jKEOjHN9fPDyhwHNILLA0dxKJgXTua0Wot9oIW3QI0r
	yJJ4ayDx3oqsHZS2jZqlS6YfXDWOk3wnBsb1I7G0hmVsmpLMZimqMPi+NyR/OyjCVK85CQz4OQkE2
	d31a0Fbcdc5SuxIrY/Z4WAZOSLoR1tq91+CH9N3r/mxn4WQHrHYUp9l+JKpx+NylhXHHn+a/ZA0QQ
	jOgVFTDisdM1fv6sVGjTCy8sZk28LlWKIqgIiUm61cteLZKZWJTJBZpRQUWkEg2zpLy+UqOCLGBCw
	94wY25og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x785G-0000000AxF1-3YZm;
	Thu, 17 Sep 2026 09:07:10 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x785E-0000000AxE7-2Jhp
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 09:07:09 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso2360275e9.0
        for <kexec@lists.infradead.org>; Thu, 17 Sep 2026 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789636026; x=1790240826; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jxbi13ouQTHyRdtBDlCDYfBDO36J/sfcBmF9VRStXnQ=;
        b=JAj8CGgFiKh91lKlUgm2H7TX48GfbPmZN4tCEila15G25lJ+77ML4BLLEm9+ZWiZGU
         bYphb+XJ4IckJtOcIC0tsxTym4ciMmZgKbtKnNaezdH2L+PNZGoMZwgsVK1fYP08yCsz
         1IWtITkowm/fhtfChu42Fh9kQx5rWz1kHeEzLBTS3BvrbEXKH2Kk95ORU+P1vFatC4Ux
         tfWYSzzO1sF3Z8/211d42Wlexfdp61w+QmeCer0BSny8eM5Tro9FzTzyi8HKKoOgOyoH
         D/xpPaB6hz/HYe2jBp/mRlaFqlx/KLPqiqcyOUKpbjc5uRPoQUVKDBmXEyMKe/Ni3CKD
         Q3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789636026; x=1790240826;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jxbi13ouQTHyRdtBDlCDYfBDO36J/sfcBmF9VRStXnQ=;
        b=aQMv6TrHrP6ogtFb0yHDjHFiEoPnMfmmh/T3inXniQ2i6XTq/xWXjdkN4ZibJ4U2r1
         ahBXMw5rzC7SaCJQTW75M2YM90t8+CqEIssyVDj7fA5AGNmT4qJ2ZSLad4B6TZPmcTEJ
         d/dBS/q3H3HCC/z0u1qrlhZhKUJBJCXhaoPTqWkSzA2DZtKW7Pk9ZDvDOvmEA79bmsem
         +xhlbWkHZcMURNh22aQ58RbdiRVmqyuB1n4QZvr46rT5sb41P3bYLc1cHW4Qew6Olktr
         E+QMXNKLvWAHPOhV8jUankh8PMej9h7VkDe9OW01nSn9KvzhiYAeL4uFwm4FW/g8OI3d
         2cpg==
X-Forwarded-Encrypted: i=1; AKwUvBy9vd3tYSdUFZbG6A3if+lDXEGftWPLr3FUdu/A7obntIhj5BFQIS4Rtb4MQB4rVr/HF6XuAw==@lists.infradead.org
X-Gm-Message-State: AFuF++lQQQBYxs52fJRpVl3BrbEFZqKdRa6Nhyz50Z+kJHyxxE1LcCnI
	5ZCpOMlTU2D4yhVoPSunHGDqhQwOuzi5RsP0lsjEFEQQRQo7YIIf7DTs8SkLgTVbarE=
X-Gm-Gg: AYBFou17MVA/V3SB6ufVp8Ok0uLmIvtlZtnohmLBCixb68NpTLdgzIqCCoCglsHdxGM
	Re4VCZybQHe8R8h0ShYdjnoFqJH/ysexuz6Svn6k2TfOpPTK6+4ErOh0k2NrvK4aVzFPr+GixYr
	ASPqhKSblb0mvZv02s+zuHFyfKT+xF3n42OtFHZQJy8NNAGiqaQxXacQX5yRdoc/4SmLDmPU4Hu
	PGWqqOj+G5XeW9hA/WMtMCAEvXiogIVvAxN1Lslrv5USowo+7WJn2Dw0kluP68yVUTcnWjcwedZ
	egZkCvDp5juzFbWTOVtsoOAYTF9CouH9z/FHxGW8uK/xuYoZbGisVy+qWfQrKujgy15f9kfk24x
	gOnquHN+Uig982W0FppMcRcjjr1WFAmLvyGH7/goYxnFxrHipeAl/ONBuUAQ8aT9M9JaJ13GK2x
	YximxSllSvKN+EuPAq5o29zhbprGbq+4q2biXk1MapvfNfP18hSUf7ncaJcquGZkqad3PkQ16E
X-Received: by 2002:a05:600c:e555:20b0:49d:27ee:79c9 with SMTP id 5b1f17b1804b1-49fbd1c4afamr25264695e9.8.1789636025806;
        Thu, 17 Sep 2026 02:07:05 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1fad3sm12476177f8f.12.2026.09.17.02.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 02:07:05 -0700 (PDT)
Date: Thu, 17 Sep 2026 11:07:02 +0200
From: Petr Mladek <pmladek@suse.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Subject: Re: [PATCH v1 4/4] x86/vmware: Run panic diagnostics before kdump by
 default
Message-ID: <aquttpMVKX8e6zGB@pathway.suse.cz>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
 <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_020708_612945_ECFC72B3 
X-CRM114-Status: GOOD (  18.58  )
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
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Bo Gan <bo.gan@broadcom.com>, "H . Peter Anvin" <hpa@zytor.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Baoquan He <baoquan.he@linux.dev>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>, Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Adding Guilherme G. Piccoli into Cc.

On Tue 2026-09-08 14:07:16, Zack Rusin wrote:
> The core panic path enters a loaded crash kernel before running kmsg
> dumpers, so the VMware logger cannot preserve the panic in the host log.
> Set crash_kexec_post_notifiers during VMware platform setup. setup_arch()
> runs before ordinary core parameters are parsed, so an explicit
> crash_kexec_post_notifiers=0 still overrides this default. The 0644
> parameter also remains writable at runtime.
> 
> VMware exposes no capability bit for this behavior, so the default changes
> for every VMware guest. Running the logger first adds work to the panic
> path and can reduce kdump reliability.

AFAIK, the quality of the notifiers is varying. Running all notifiers
might reduce the kdump reliability even more.

I do not like much the hack with crash_kexec_post_notifiers. It is
an all or nothing option.

Also it was introduced as a quick hack so that users could decide
what is more important for them. But it is not longer a "user"
decision when some platforms enforce the ordering because they
depend on the notifier.

panic() is problematic and it is about compromises. And we need
to balance what is important, what is safe, and what is optional.
This is why I suggested to introduce more notifiers some time ago,
see https://lore.kernel.org/lkml/YfPxvzSzDLjO5ldp@alley/

Guillermo implemented this, see
https://lore.kernel.org/all/20220427224924.592546-1-gpiccoli@igalia.com/
But it has stalled because it touched too many subsystems and it was
hard to get an agreement.

Maybe, we should start with something simple, and introduce
one more panic notifier as a start. It might be called either:

  + "panic_hypervisor_list" because "crash_kexec_post_notifiers = true"
    seems to be primary set on hypervisors.

But I would rather make it more generic and call it

  + panic_pre_crash_kexec or panic_pre_kdump because there might be
    more notifiers which are either 100% safe and useful or are worth
    the risk before calling crash dump.

We could put there x86/vmware notifiers as a start. And we could later
move there other important notifiers.

How does that sound, please?

> A full log transfer uses 1027 low-bandwidth hypercalls; three checkpoint
> attempts are bounded at 3077. In vmcall tests, a maximum-size transfer
> took at most 7.47 ms; three complete transfers comprising 3081 calls took
> at most 21.58 ms.
> 
> The crash report remains suppressed while a crash kernel is loaded because
> the host may terminate the VM inside that call. A future report from the
> crash kernel or kdump userspace can restore the event after saving the
> vmcore.

Best Regards,
Petr

