Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F4606A32A
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pVpi8KDA;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=C5vKx0Ow
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=J03hAPreVl/WdlY67XpnWOO6QMbJJDuPrc/TmqPAXow=; b=pVpi8KDATMz7tfalbSFWxmvnOE
	eF/sR1kRvnKcfQZZZGo3b0jY7FsZcZTlMC1pfYWRx6ie9yIb5D1N2admmQ5WQhnitEG88fG7pvJ7d
	hkxeATfx7QtDRObqE2EUpD/2cjInrjFKVllfHUMqfs6VwxTDmo+tkDdBh/L+x7jGuB0lk2AcLYI7p
	adS6rCpAk+p1gL0UDtTAgOJklA/uP+S3VVsN/YesVPTQ5RTGjeCHO5TRvDpgBKPMf21yVrzGGJAMe
	K1v9Gzje5Hc/yfkJ//ZvX/kAPT7/hyskjBkydc76KC3MDHPOpqVSDEvdedHLNmg0SbdsGG5839MML
	jSwhEsEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xULqC-0000000Eaz2-20K2;
	Fri, 20 Nov 2026 10:27:36 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xULq9-0000000EayK-16uC
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 10:27:34 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so2635045e9.3
        for <kexec@lists.infradead.org>; Fri, 20 Nov 2026 02:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795170451; x=1795775251; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J03hAPreVl/WdlY67XpnWOO6QMbJJDuPrc/TmqPAXow=;
        b=C5vKx0Ow03hqC0VXWnJ7EdpsA6NxDAgoQRvUskJd93iwZSNUMl3SMnymSEuRzNN2mZ
         sCqjgNYxMDJSy1Mgec5GLuOP6czu96NMAZFVdLo7GM24xlQ+2BZRflVYINdA1F29sMGW
         9oYCxZIhz4X8cmzZUDUPz6AMpgvvgzsz9K5D2LjWm+OTguUcyo+dVi5DmlB8BdUgmSPy
         FW/D5oYXpzDFxDhwU0D3dFOBqnVaAEQIyrY49BeWTaUgjpE8/t80vOwRjScJ7UkVINU6
         T3Ib3b1taFNrCvtDEAAexafw9jd/80+0MFh+hBF9lI1mu4mxBD0LLTdw5BBICArAcJs9
         ZtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170451; x=1795775251;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J03hAPreVl/WdlY67XpnWOO6QMbJJDuPrc/TmqPAXow=;
        b=sjBA59+GxyRbr70HNdYmfUjgVotQSvgaDxO653s70SENpioqkauac/JG5ItmWGpjAQ
         sAdAeTJBRNVOFI/HD1FJbz2nRPP1SMA0ai+fv02wNg1f5R1nYPRDkR9zgATvUhd/VksI
         MVdwT7bgGjdxvJWaq2U8Jv0Bjvv4uWJ+obw/0pIZTKth8uZ9zuNn5naXC62debGYxH3X
         xPjj7g1IFcLawXJtLWjZm1lvwzhTujDfbjOWpLPGhI1bsaiI2rNeFUJ92O1Uxshny46h
         yJ9t2dhM7crhstvlAUuwN8Qs1Ybm32aIn9qmceWr0azUs9/yhPNdXujJ1MAZLhzxqvVN
         gGEg==
X-Forwarded-Encrypted: i=1; AL+hErFBcxcvIuKFQds+hDqfov8Rqe0jRsXg2Tr/OkZP7AF/K0PS5qGnsSBYkVqtikNn7dPkkJG4/g==@lists.infradead.org
X-Gm-Message-State: APuU4Z+Yh7o6P12u1TUCth/2OfNYBQaYMepgk2lNca+oq9K5Y4orZo6e
	6dB5hsHM9zh9tK3LmcCy7wtVkAY4OsuL/OZkhA0Un1z8pfOKa4PkSxtXg4Kk1DGRIuU=
X-Gm-Gg: AYBFou20iuUGDLKaAQKeJSiNGNEQTIfkWurvTNJ2HWu3K2dpuiQjNTXD6WII8TNLFOt
	5B7ruZndSmfKGAh2PmI0GUXIiL0H6FA2Bgn0xsJBbLHlgbrKYn3ayW4NF2fvNHJ4enInf5a6of0
	okPPJNkAXXi4Q82Qd61FJv7ZbBzNm0kp7wTn/fa0pvexDYLqTz3BxjlL3fikn8G0S8oU88lzTrz
	6cWoQX/Fy8jpWPyOa3bpiCqyPDzE2YmdiJ1yJhgNuGOlIlzvNxxHoUdsJ2NItarGYLOpWGS7lXs
	0MTQXseViY/z1MhN/XAx42Z6SrIS8UD3VYvutBlaejl59tOvYplE2Q2jBMg30mevn5v6VxhHUKC
	2M9eVMdShryBJu+54hKxmfASvbNTlGEQufxe9a+SpwdOmBzL/WFLXFvVARgeuP6CzUNL/YYDLI9
	l5nRvPn0cAgKTiTUIeXTNF6wnsTECaq8h4NO9vj4gJzIvGiAiBd9uKtc6xVd+orebimDapt8O7q
	4rRu3Bb5yCv0+WjsYUbCgK+PK9Xx8Y9435x9M5c5ARxDBruncvSY+Jwdhi9lygz4RIKJ81l7h+B
	hDwflIrs3KhWKOBPh0mu
X-Received: by 2002:a05:600c:4ecd:b0:4a3:12fb:1ef1 with SMTP id 5b1f17b1804b1-4bb8881e81cmr57015215e9.29.1795170451305;
        Fri, 20 Nov 2026 02:27:31 -0800 (PST)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm108779875e9.15.2026.11.20.02.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:27:30 -0800 (PST)
Date: Fri, 20 Nov 2026 11:27:28 +0100
From: Petr Mladek <pmladek@suse.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Subject: Re: [PATCH v4 4/4] x86/vmware: Report guest crashes after kmsg
 dumpers
Message-ID: <awAgkNoIKpFx764w@pathway>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <d0f9c1188b5f78bb20bb43737b3cf80c5c0f94f4.1794980455.git.zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0f9c1188b5f78bb20bb43737b3cf80c5c0f94f4.1794980455.git.zack.rusin@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_022733_335178_0DE9A6C6 
X-CRM114-Status: GOOD (  30.34  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Bradley Morgan <brads@mainlining.org>, Baoquan He <baoquan.he@linux.dev>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

this patch looks a bit messy, But maybe, I just do not know enough
about VMvare.

On Wed 2026-11-18 01:01:51, Zack Rusin wrote:
> VMware accepts a structured guest-crash event, but a host configured with
> backdoor.coredumpOnCrash may terminate the VM before the hypercall
> returns. Keep this event separate from the log sender, which runs
> earlier in panic.

I am a bit lost here ;-)

What exactly means the "structured guest-crash event"?
Which hypercall are we talking about?

Is this primary about synchronization of vmware_panic_log_notify()
against termination of the crashing guest by the host?
Or is this about something else?

What exactly does vmware_hypercall1(VMWARE_CMD_REPORTGUESTCRASH, 0)?
Does it _block_ or _trigger_ backdoor.coredumpOnCrash?

> Register a panic-only kmsg dumper with late_initcall_sync(), after built-in
> dumpers registered by then.

Is this ordering important?

> Skip the event while a crash kernel is loaded
> so the host cannot terminate the guest before kdump saves its vmcore.

This suggests that vmware_hypercall1(VMWARE_CMD_REPORTGUESTCRASH, 0)
actually triggers the external crash dump procedure made by the host.

> Issue the event at most once. With CONFIG_PRINTK=n, use a late INT_MIN
> panic notifier. An unexpected dumper registration failure with printk
> enabled leaves reporting disabled rather than overtaking working dumpers.

This is another mystery. What do you want to achieve when
CONFIG_PRINTK is not defined, please?

Note that printk() is a NOP when CONFIG_PRINTK is not defined.
There is nothing to dump in this case.

Honestly, I would not complicate the code by this.
I doubt that anyone is using kernel without CONFIG_PRINTK.

> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> +static int __init vmware_crash_report_init(void)
> +{
> +	int ret;
> +
> +	if (!hypervisor_is_type(X86_HYPER_VMWARE))
> +		return 0;
> +
> +	ret = kmsg_dump_register(&vmware_crash_report_dumper);
> +	if (!ret)
> +		return 0;
> +	if (IS_ENABLED(CONFIG_PRINTK)) {
> +		pr_err("failed to register crash report dumper: %d\n", ret);
> +		return 0;

This is weird. As I said, printk() is a NOP when CONFIG_PRINTK
is not defined. So, you would achieve the same with:

	ret = kmsg_dump_register(&vmware_crash_report_dumper);
	if (ret)
		pr_err("failed to register crash report dumper: %d\n", ret);
	return 0;

But wait, this means that the code below is never reached.

Ah, I see, you wanted to run the code below when CONFIG_PRINTK
was disabled. It was far from obvious. And I do not understand
the motivation much.

Anyway, it won't work because kmsg_dump_register() returns -EINVAL
when CONFIG_PRINTK is not defined. err != 0 ...

Let's take a step back.

Why do you want to use kmsg_dump infrastructure for notifying
host about the crash, please?

The kmsg_dump API should be used to dump the printk messages.
But this just notifies the host about the crash. It looks like
an API misuse.

> +	}
> +
> +	ret = atomic_notifier_chain_register(&panic_notifier_list,
> +					     &vmware_crash_report_nb);
> +	if (ret)
> +		pr_err("failed to register crash report notifier: %d\n", ret);
> +
> +	return 0;

IMHO, you either want to use the panic_notifier list.

Or you might even use the new panic_notifiers_platform_list
if you make sure that this is called as the last event
and you really want to stop the guest at this point.

My assumption is that the "host" will stop the "crashing guest"
when it gets notified about the crash.

> +}
> +late_initcall_sync(vmware_crash_report_init);
> +
>  #ifdef CONFIG_PARAVIRT
>  static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
>  static bool vmw_sched_clock __initdata = true;

Best Regards,
Petr

PS: It looks to me like Sashiko AI completely failed here. It did not
    mind if the commit message made sense. It did not see the big
    picture. And it even missed that the code did not work with
    CONFIG_PRINTK undefined.

