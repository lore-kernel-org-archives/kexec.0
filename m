Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB73BCCF2D5
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 10:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O+H3ORQrwht0RhH+jV/nG3TxmFwVK7hnaHuDKuALH5U=; b=o0KgDXGxNbayptdw5LN2ccdh9F
	uB/HWK9tplezp2rvV8Qgky/vAhoRb4SH/kU3HSZNtZ6DE0YU7/JRnGaJ/oMmuqtKfMUFfkmhQkHqq
	anA/QKCs+wnLao7qSwQH/Xxe4xOUltvE9WXdJFbdcVtT/g4GbG0MZvIYVPhupZhRajDFGRxJ3ZHuF
	sADEyOd4rVXlZlWaMyhRbv7Ali9StdQ8y1CGXQKVdIGsrlpncPH5MxHOcOwm5ntooIuxn850WY4be
	8lkHotjOIDGMEWwG/mi+RlXKJ+PbATnc1pcR2DSKdeCyV3cxTM1JeXDLe/qJ8ufcgGVICtyy/EwHC
	brqnO3jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIkta-00000007ERl-3Eee;
	Mon, 19 Oct 2026 10:47:10 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIktY-00000007EQY-1GOh
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 10:47:09 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792406821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+H3ORQrwht0RhH+jV/nG3TxmFwVK7hnaHuDKuALH5U=;
	b=RJrgegDSh31nSEeRaJ40tX9/wCik01AUj23iNKFod8Vpe5ofRKiuMhcPTZ57MmiKpzCWTr
	XU4gMrQtGXzOXRjA88LaB+n2r4ogDkXj5oj63WGWgGObA+eFOxrV0KiZeRsdMsTOoiqkxP
	BELJw07TMmdrlW3wiMH3Qddl7ylj1edkuLs2gXy5SwdmiikCP2Z+uUaorINQKT3ar5rdvC
	WYNGsHTgatQw2BiLOzvd1r/2NIffMdC79bzZ/an4CjVR8p0heUzhn/ksRwNoAbC2KJDoaJ
	VpNQeXKcaejCw3h6CKqU4g6oJWZ2U0XmV0lsBFakoeL89CdlplLKVBb1Z3cGtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792406821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+H3ORQrwht0RhH+jV/nG3TxmFwVK7hnaHuDKuALH5U=;
	b=L3yq5glitizDFhda1Bh5+tTcD0rO1VcMiIZrlrRUvxqJJWdj3FfRuqPmo0KDmfK9TVGTwE
	I7vKDiEiUZZXqeDw==
To: Zack Rusin <zack.rusin@broadcom.com>, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 2/6] crash: Notify pre-kdump callbacks before
 switching kernels
In-Reply-To: <CABQX2QNHSjP+FFppUR1ohthwvCjWNA2ozOuZtnwwdNu7WGaV0g@mail.gmail.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <9ef573cdbbf5e659eea16fa23afeaf2488049198.1790014793.git.zack.rusin@broadcom.com>
 <20260928180829.3A3461F000FF@smtp.kernel.org>
 <CABQX2QNHSjP+FFppUR1ohthwvCjWNA2ozOuZtnwwdNu7WGaV0g@mail.gmail.com>
Date: Mon, 19 Oct 2026 12:53:00 +0206
Message-ID: <87v76yotln.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_034708_485630_557109FE 
X-CRM114-Status: GOOD (  11.41  )
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
Cc: x86@kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, linux-doc@vger.kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Eugenio Perez <eperezma@redhat.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Baoquan He <baoquan.he@linux.dev>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, "Michael S. Tsirkin" <mst@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 2026-09-28, Zack Rusin <zack.rusin@broadcom.com> wrote:
>> > @@ -139,6 +140,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>> >                       struct pt_regs fixed_regs;
>> >
>> >                       crash_setup_regs(&fixed_regs, regs);
>> > +                     panic_notify_pre_kdump(NULL);
>>
>> [Severity: Medium]
>> Will this cause pre-kdump notifiers to receive a NULL message pointer instead
>> of the expected panic message?
>>
>> If a system panic occurs and kexec is configured with the default setting of
>> crash_kexec_post_notifiers=0, vpanic() triggers __crash_kexec(NULL) before
>> reaching its own explicit panic_notify_pre_kdump(buf):
>>
>> kernel/panic.c:vpanic() {
>>     ...
>>     if (!_crash_kexec_post_notifiers)
>>         __crash_kexec(NULL);
>>     ...
>>     panic_notify_pre_kdump(buf);
>> }
>>
>> When this happens, __crash_kexec() will invoke panic_notify_pre_kdump() with
>> a NULL message pointer. This permanently consumes the once-per-boot guard,
>> and any callback relying on the documented msg parameter will experience
>> data loss or potential NULL dereferences, violating the API contract that
>> promises the panic message during a panic.
>
> afaict Sashiko gets tripped up here by the doc from the previous
> email. Nothing in this series dereferences the msg. The only callback
> is the VMware logger in patch 4, which ignores the argument. It reads
> the printk buffer, where vpanic() has already written the panic line.

If you are not using the argument, why are you providing it in your new
API? Just drop the argument. If any future pre_kdump panic notifiers
need additional information, they can adjust the API appropriately.

John Ogness

