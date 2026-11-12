Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E5C606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Bf5/ilM3;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSwYdb/H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GJ09uqYjRVaCurMfukDMPp2A0M6HiGjs+X7y4PKg5Dk=; b=Bf5/ilM3kf2d7cqC7husqeZ2fr
	DGGRU39RsLvAaWZV7lvlf/LL2PQBvPUZigUC0VoRN9FHaRZltEe8o6vxPzxQZ8k6fWT80CZ9iCayN
	YIKGp+Ti+T4kUraqhHbw4rixnLUzV+kQlGYHPKrpvAyEu1UxsiZBO4KOYq5eICkFElFTrYlMMCUNS
	u0XCpn5ebRznv2fDSH8Pm0BdgBXLWWh5O1iNLRQ3d7h+kIJA/iuInrPBbIX0HboLF1vRZUA/qym3Z
	L1lqgoQ3Tev79DYZOdI/cKPLAOCUdR+o1WZX4+qFd8sBBzFmexRdLJJSeE4oVV5oPapFN1gp7XNlY
	xGhlcZuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRZPB-0000000ArUi-17y8;
	Thu, 12 Nov 2026 18:20:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRZPA-0000000ArUV-0xX5
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 18:20:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 708F3436E3;
	Thu, 12 Nov 2026 18:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F93D1F000C6;
	Thu, 12 Nov 2026 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794507611;
	bh=GJ09uqYjRVaCurMfukDMPp2A0M6HiGjs+X7y4PKg5Dk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZSwYdb/Hyvb8grs1F5+3mmMgLNeae+GNQMMWDxEYa9DSdD7SCV7I6WWtYklhl2F4I
	 YhQt6q02MED9bO7no+rxfZ/gr/r4Zq2d6o0sbrWRL5AnfbInFIPE9dOpY34tDwvdW5
	 HcVx3+Jp/n9GxEbdovvdtd4GTbh+LKzYzJDVkp7OfMo3QDN/iY/vL4q+64F8T4sGbK
	 i3kTneLjTl0aw0cEmUkXVej/y27g68TYmas3QETNZmYc3R0D2D9o8q3i8Gr1NmmnPN
	 ++gzRFX3xNqW9osdPQ5pTJvcYG8C2l2YmXTtHZwvrd/SbeJxhBFvpLXqfdE3dV/IzM
	 VrtSiVBA87luQ==
Message-ID: <sashiko-outbox-211696@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH printk v2 5/6] printk: Add panic+kexec flush point
To: "John Ogness" <john.ogness@linutronix.de>, "Petr Mladek" <pmladek@suse.com>
Cc: "Sergey Senozhatsky" <senozhatsky@chromium.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Breno Leitao" <leitao@debian.org>, printk@lists.linux.dev, "Andrew
 Morton" <akpm@linux-foundation.org>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>, kexec@lists.infradead.org
In-Reply-To: <20261111181942.593695-6-john.ogness@linutronix.de>
References: <20261111181942.593695-1-john.ogness@linutronix.de>
 <20261111181942.593695-6-john.ogness@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 18:20:10 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] crash: printk_trigger_flush() in __crash_kexec() called with
  wrong panic_cpu
--

commit fef7b57cf45508b52c2322cc5354dee7d0cedbc1
Author: John Ogness <john.ogness@linutronix.de>

printk: Add panic+kexec flush point

This commit adds a call to printk_trigger_flush() in __crash_kexec() to
allow consoles with the panic flush policy to flush before booting into
the crash kernel.

> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index d0bd2d0cf8990..064b0af903c38 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -140,6 +140,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
> =20
>  			crash_setup_regs(&fixed_regs, regs);
>  			crash_save_vmcoreinfo();
> +			printk_trigger_flush(PR_FLUSH_RESTART);

[Severity: Medium]
Can printk_trigger_flush() be called here on CPU0 while panic_cpu still
holds a non-zero CPU number or its invalid initial value?

On Hyper-V root partitions, crash_nmi_callback() parks all non-zero CPUs
when a panic occurs on another CPU (or when the hypervisor itself crashes
with panic_cpu unset), while CPU0 disables the hypervisor and calls
hv_crash_handle() -> __crash_kexec() without updating panic_cpu:

arch/x86/hyperv/hv_crash.c:hv_crash_handle() {
    ...
	/* we are now fully in devirtualized normal kernel mode */
	__crash_kexec(NULL);
}

Because panic_on_this_cpu() is false on CPU0, nbcon_get_default_prio()
returns normal priority instead of panic priority.  printk_trigger_flush()
then skips atomic panic flushing and takes the offload path via
defer_console_output() -> irq_work_queue().  When the local tick is
stopped, raising the self-interrupt calls hv_send_ipi_self(), which
invokes a hypercall after the hypervisor has already been disabled,
faulting and aborting machine_kexec().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111181942.5936=
95-1-john.ogness@linutronix.de?part=3D5

