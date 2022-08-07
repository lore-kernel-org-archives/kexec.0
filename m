Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F403C00140
	for <kexec@archiver.kernel.org>; Mon, 15 Aug 2022 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CWExqqQIRdgrJYTt47NnmsmjxsX/0laXRthB9gSI2W0=; b=OWB/lSL3qI3DXU
	z3Gij0/VvT39YxgqYdQnbkUgD/cj01m0QNDu3QLsfiPs7T2StjVVv2x2KwOt2d42DjdGYn9rvujfZ
	k5Vh7XkgOD/n8gXUALcUK9FdeooloHWTVH0ehv3jKHV5L9IqcW96LkS1dqPkBvLVbGWWkuD2l8wHw
	GeZBI8H8DaxxZDR1oWUhcR7sWnYpdyv59XmERAV/QrpSrhUXgga234AN0VG0m235VV/Ln02a1dJ7J
	iv/nxnaUP4Gl6FFoKLZTo5UwILaL3rDCSJ7vwE05JKG+N944h5VHZGnrWXj30iqBRofBLueB/WQ1Y
	7hePRodQuWZuaPojoipg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNdh7-0028dS-8x; Mon, 15 Aug 2022 17:16:05 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKiKs-00FCNO-KV; Sun, 07 Aug 2022 15:37:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l55pJQcZ1NtSw92ANqP6zdKYAHPUxRJf02byqPAHpeU=; b=J41lFEvKvGWs40UEuQ3L9XZjX9
	0qgdt79wCDmsaIgb0pFUl3+A5LSvtbQq2Sr6agU2ozxeFF0C4fcJGnnGXT4jj69p+z6jglRBoPVOD
	ARccBb4jXL6eFywTBIwUncZHajIY/5M7JjAm2w/RY1KQzj1hMm35Eu+eIAFLqwaGwVr+Kq7J06JOW
	Sgdb6BmP5a43VejM51kP1wj/janEK2e6BRT3a+uKEGvqGreEsrJqrbOnSGxRITccwNju33yHhdOZQ
	Bm2aj+RIUHvJa5EkUFnTQDtMrJA6EKxcIbg5//OVfNyFfIQITA1+hC1Pml2hGRkwkNWrrDrtZDVRe
	SxKiUOoQ==;
Received: from [187.56.70.103] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oKiKD-0011fz-IR; Sun, 07 Aug 2022 17:36:21 +0200
Message-ID: <5b1805ff-eb9f-8575-ceb0-9d2e768f3589@igalia.com>
Date: Sun, 7 Aug 2022 12:35:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 01/13] ARM: Disable FIQs (but not IRQs) on CPUs
 shutdown paths
Content-Language: en-US
To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Marc Zyngier <maz@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: bhe@redhat.com, pmladek@suse.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com,
 alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
 arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com,
 dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com,
 gregkh@linuxfoundation.org, mikelley@microsoft.com,
 hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de,
 keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-2-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220719195325.402745-2-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220807_083702_727268_E75E8340 
X-CRM114-Status: GOOD (  18.90  )
X-Mailman-Approved-At: Mon, 15 Aug 2022 10:10:47 -0700
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

On 19/07/2022 16:53, Guilherme G. Piccoli wrote:
> Currently the regular CPU shutdown path for ARM disables IRQs/FIQs
> in the secondary CPUs - smp_send_stop() calls ipi_cpu_stop(), which
> is responsible for that. IRQs are architecturally masked when we
> take an interrupt, but FIQs are high priority than IRQs, hence they
> aren't masked. With that said, it makes sense to disable FIQs here,
> but there's no need for (re-)disabling IRQs.
> 
> More than that: there is an alternative path for disabling CPUs,
> in the form of function crash_smp_send_stop(), which is used for
> kexec/panic path. This function relies on a SMP call that also
> triggers a busy-wait loop [at machine_crash_nonpanic_core()], but
> without disabling FIQs. This might lead to odd scenarios, like
> early interrupts in the boot of kexec'd kernel or even interrupts
> in secondary "disabled" CPUs while the main one still works in the
> panic path and assumes all secondary CPUs are (really!) off.
> 
> So, let's disable FIQs in both paths and *not* disable IRQs a second
> time, since they are already masked in both paths by the architecture.
> This way, we keep both CPU quiesce paths consistent and safe.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Michael Kelley <mikelley@microsoft.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V2:
> - Small wording improvement (thanks Michael Kelley);
> - Only disable FIQs, since IRQs are masked by architecture
> definition when we take an interrupt. Thanks a lot Russell
> and Marc for the discussion [0].
> 
> Should we add a Fixes tag here? If so, maybe the proper target is:
> b23065313297 ("ARM: 6522/1: kexec: Add call to non-crashing cores through IPI")
> 
> [0] https://lore.kernel.org/lkml/Ymxcaqy6DwhoQrZT@shell.armlinux.org.uk/
> 
>  arch/arm/kernel/machine_kexec.c | 2 ++
>  arch/arm/kernel/smp.c           | 5 ++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> [...]

Hi Mark / Russell, do you think this one is good enough or is there room
for improvement?

Appreciate the reviews!
Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
