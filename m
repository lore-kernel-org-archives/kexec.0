Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A23606A31A
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=neklDISY;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=iLZ16PHK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2vIHfmH9PqQoENTr1ZAdbd1GcxgaoRPWjUm3ZBNsSks=; b=neklDISYOIB46T7svcHbXcWfR/
	3EoEJ+uwrRXI/Bozu2rvLQksk3wAy1BoFjG2n+R7UrnnNQI5kY27FmXqSRe4N+k14rExrahprstlV
	zro26Z+D0Ue2DJiM675YnzWXujWcs4Y9zVNZptXf+GR2vPnrzw4BlNJEyGFtMDVS3KzVvom3bjkZZ
	jTpMqbbThf8YMjwgmgGWSgisruux8pWu8W+vlEn4VDxpOtqSOeHv2ZpQcfcJRxn/l5pO/Gan/y7GG
	9d1txTMEsA4bvNDgf9p0cUqShLMFb8bo9cR3fhFMMrBpcjqjd4abE8wARUrEh8k4l+z9Q+3vt+5Tt
	1YvKGiIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIvUl-00000008Ro4-25Lv;
	Mon, 19 Oct 2026 22:06:15 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIvUj-00000008RnM-1K2U
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 22:06:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=2vIHfmH9PqQoENTr1ZAdbd1GcxgaoRPWjUm3ZBNsSks=; b=iLZ16PHKq46ADjPnJnMN7mnQJ4
	vDXohIpLz+a/oL8cF7KTuk3vIrqpDsP/wGnIAJ6tCgdjqD2SVzdTAWUWunGWrZrSZfv8AXAQA0kJ4
	Etn5AI0etjT+EC9ExguKQeG0AN6B7ZUc1J3YR8ga9qSauv9eWWCMT5tWrPP4LnnSVInl3ixjlk6la
	1nAJt7oY3mS477Y5TxrWzCfC4sk93Dxu/hAIvQvmkyUpMbzk+wKZO1GrUSCjr1JuqtIfw1qWYgWhE
	O176mNY/VZP8xGLibFuEMKAYXi7CF7Dad0Ln8E7/M2HvJGHX6DFJvz+a8EyeFWsA+BNHt33DcX864
	9/dB1Hzw==;
Received: from [177.189.74.83] (helo=[192.168.15.93])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xIvU4-003vDb-OM; Tue, 20 Oct 2026 00:05:32 +0200
Message-ID: <bc783856-9480-3944-67fb-675e4c11d8c2@igalia.com>
Date: Mon, 19 Oct 2026 19:05:21 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/6] panic: Add a notifier chain for pre-kdump
 callbacks
Content-Language: en-US
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Borislav Petkov <bp@alien8.de>, Petr Mladek <pmladek@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He
 <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, x86@kernel.org,
 Joel Granados <joel.granados@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
 Dave Young <ruirui.yang@linux.dev>, bcm-kernel-feedback-list@broadcom.com,
 linux-kernel@vger.kernel.org, John Ogness <john.ogness@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Pratyush Yadav <pratyush@kernel.org>, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>,
 Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Stephen Brennan <stephen.s.brennan@oracle.com>,
 Michael Kelley <mhklinux@outlook.com>, Ian Forbes <ian.forbes@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_150613_362002_F27B0CD5 
X-CRM114-Status: GOOD (  26.19  )
X-Spam-Score: -4.5 (----)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28/09/2026 14:55, Zack Rusin wrote:
> Selected crash callbacks should not require running every panic notifier
> before kdump. Add a separate atomic chain with an at-most-once dispatch
> helper, and invoke it before panic reaches the kmsg dumpers.
> 
> The helper permits another call from the crash path without repeating
> callbacks or recursing into them. Document that callbacks may run in NMI
> context, with other CPUs running and the kexec lock held.
> 
> Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
> New in v2: separate pre-kdump chain, with a set-once dispatch guard.
> 
>  include/linux/panic_notifier.h |  3 +++
>  kernel/panic.c                 | 26 ++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
> index 41e32483d7a7..3ad390764a41 100644
> --- a/include/linux/panic_notifier.h
> +++ b/include/linux/panic_notifier.h
> @@ -6,6 +6,9 @@
>  #include <linux/types.h>
>  
>  extern struct atomic_notifier_head panic_notifier_list;
> +extern struct atomic_notifier_head panic_pre_kdump_list;
> +
> +void panic_notify_pre_kdump(char *msg);
>  
>  extern bool crash_kexec_post_notifiers;
>  
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 213725b612aa..d78e90abb192 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -82,6 +82,10 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
>  
>  EXPORT_SYMBOL(panic_notifier_list);
>  
> +struct atomic_notifier_head panic_pre_kdump_list =
> +	ATOMIC_NOTIFIER_INIT(panic_pre_kdump_list);
> +EXPORT_SYMBOL_GPL(panic_pre_kdump_list);
> +
>  static void panic_print_deprecated(void)
>  {
>  	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
> @@ -567,6 +571,27 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
>  		crash_smp_send_stop();
>  }
>  
> +/**
> + * panic_notify_pre_kdump - invoke selected callbacks before kdump
> + * @msg: Panic message, or NULL for direct crash-kexec entry
> + *
> + * Dispatch at most once per boot, including recursive entry. Callbacks run
> + * with interrupts disabled, possibly in NMI context, before other CPUs have
> + * necessarily stopped. The kexec lock may be held. They must not sleep,
> + * allocate, wait for other CPUs, or call into kexec management operations.
> + * The message is read-only and may only be used during the callback.
> + */
> +void panic_notify_pre_kdump(char *msg)
> +{
> +	static atomic_t started = ATOMIC_INIT(0);
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	if (!atomic_xchg(&started, 1))
> +		atomic_notifier_call_chain(&panic_pre_kdump_list, 0, msg);
> +	local_irq_restore(flags);
> +}
> +
>  /**
>   * vpanic - halt the system
>   * @fmt: The text string to print
> @@ -682,6 +707,7 @@ void vpanic(const char *fmt, va_list args)
>  
>  	sys_info(panic_print);
>  
> +	panic_notify_pre_kdump(buf);
>  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
>  
>  	/*

Hi Zack, thanks for trying to improve this conundrum called panic
notifiers heh

I confess at first sight I got a bit confused, and only after reading
patch 1 and 2 twice, things made sense to me: you're hooking
__crash_kexec() directly!

So, in my head, 2 things that would make sense upfront: merge patches #1
and #2, and comment a bit about it in the code.


But more than this, IIUC (and please correct me if I'm wrong): in case
__crash_kexec() is called earlier, THAT call invokes
panic_notify_pre_kdump(). Now, if that call doesn't happen (for example,
'cause crash_kexec_post_notifiers=Y), then panic_notify_pre_kdump() is
called from vpanic(), *after* the regular panic notifiers!!? Is it
intentional?

If it is, why even call it here, if __crash_exec() will be called again,
in next line, in such case of crash_kexec_post_notifiers=Y? It could be
easily done outside of `if(kexec_crash_image)` [at __crash_kexec()].

Is it really correct/expected that such "early" notifiers will end-up
being the latest notifiers if crash_kexec_post_notifiers=Y? Maybe this
is aimed at collecting also the potential extra info dumped in some
regular panic notifier?
Thanks,


Guilherme

