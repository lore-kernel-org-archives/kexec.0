Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136E0CA5FA2
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:Reply-To:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:In-Reply-To
	:To:Subject:From:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WUr4DNIEp8vqgR+y+EucUuJJumlJdmOaA0wpDfnBg4M=; b=NQaroJ4yadxmkqEwt+wy91RQ/R
	k7KD2+L3qOWISoizE2PzGa+sBX5vL2f8cUN+8pHxivFTSNkiJcQvJ94ISE9AQ/JrVZobmqLIBcq8X
	8K0Bk7wAGz6SAM5JFBM+RUX2GO/gENWhIV638QLXFbaFNukO6lkvdZgEWsxKhIdJFEOixTOoDxRLt
	UqN17U2rK5iNEqc6MX/6uBP1DeE2S3VKxckqE5ynIqZAk4laBuvJm5kartYn34vv0lgoYLapLCTyV
	oycm/nYm+zyfPNEdLdHNCaagMJoFQyGak1VjNVh69dbuz578SmYFv195Ekp52EzyXHbNTFxTHUTp+
	xxgw7WCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFmF-00000001HAY-2JqC;
	Mon, 28 Sep 2026 18:08:35 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFmD-00000001HAA-38eB
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 18:08:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E6C6F600E2;
	Mon, 28 Sep 2026 18:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3461F000FF;
	Mon, 28 Sep 2026 18:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618912;
	bh=WUr4DNIEp8vqgR+y+EucUuJJumlJdmOaA0wpDfnBg4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BgFTbxNPFcXz6LSX4MLAxqXhEI3Ogbu+y2r9j0teZHuz/LNFhM56tuSTuG1QKMbAn
	 wNmeS1dZVeLgx14gogaR33nyrlxs052QlsSwV3O8C3k/2yr1YcCOJpzz6mKu78b63u
	 5PXcWBa8QdKK+HZA2/l/u62C2b4yfPTmpQzgVedkYjSoB3BbhqvBmAsZRk83hPuEy9
	 Pugfp3WQS/BrQ3kROsvl0hisrK67VTSbClkdohHx0VMN8f+Ql9rRBCzY10AY+iYSYz
	 5Bb6XrLVoYMRsN+hP48oUAZ5hVt7FfcM1ZpkW4H7PUSkkOtVa3/BRAhbJM3IJTgQqx
	 dQwNRTLrSR1PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] crash: Notify pre-kdump callbacks before
 switching kernels
To: "Petr Mladek" <pmladek@suse.com>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>, "Zack
 Rusin" <zack.rusin@broadcom.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>
In-Reply-To: <9ef573cdbbf5e659eea16fa23afeaf2488049198.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <9ef573cdbbf5e659eea16fa23afeaf2488049198.1790014793.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:08:28 +0000
Message-Id: <20260928180829.3A3461F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Cc: Randy
 Dunlap <rdunlap@infradead.org>, "Michael
 S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>, kexec@lists.infradead.org, Dave Hansen <dave.hansen@linux.intel.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo
 Gan <bo.gan@broadcom.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel
 Granados <joel.granados@kernel.org>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Eugenio
 Perez <eperezma@redhat.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, John
 Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven
 Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Ian
 Forbes <ian.forbes@broadcom.com>, Thomas Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] panic: Pre-kdump callbacks always receive NULL message in defaul=
t config
--

commit 8884313d127ae4b9734baebea7b4ba8dd25b38a5
Author: Zack Rusin <zack.rusin@broadcom.com>

crash: Notify pre-kdump callbacks before switching kernels

Fatal x86 oopses can call crash_kexec() without reaching panic(). Run the
pre-kdump chain from __crash_kexec() as well, after finding a loaded image
under the kexec lock and capturing the original registers.

Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz

>     the shared guard skips callbacks already invoked by panic().

[Severity: Medium]
Is this statement accurate?

During a standard panic-triggered kdump with crash_kexec_post_notifiers=3D0
(the default configuration), vpanic() calls __crash_kexec(NULL) before it
formats the panic message and calls its own explicit
panic_notify_pre_kdump(buf).

Because __crash_kexec(NULL) runs first, won't the new
panic_notify_pre_kdump(NULL) call consume the once-per-boot atomic guard,
rather than being skipped by it?

> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 2b36aa9fade06..5d9fe9e00f39f 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
[ ... ]
> @@ -139,6 +140,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>  			struct pt_regs fixed_regs;
> =20
>  			crash_setup_regs(&fixed_regs, regs);
> +			panic_notify_pre_kdump(NULL);

[Severity: Medium]
Will this cause pre-kdump notifiers to receive a NULL message pointer inste=
ad
of the expected panic message?

If a system panic occurs and kexec is configured with the default setting of
crash_kexec_post_notifiers=3D0, vpanic() triggers __crash_kexec(NULL) before
reaching its own explicit panic_notify_pre_kdump(buf):

kernel/panic.c:vpanic() {
    ...
    if (!_crash_kexec_post_notifiers)
        __crash_kexec(NULL);
    ...
    panic_notify_pre_kdump(buf);
}

When this happens, __crash_kexec() will invoke panic_notify_pre_kdump() with
a NULL message pointer. This permanently consumes the once-per-boot guard,
and any callback relying on the documented msg parameter will experience
data loss or potential NULL dereferences, violating the API contract that
promises the panic message during a panic.

>  			crash_save_vmcoreinfo();
>  			machine_crash_shutdown(&fixed_regs);
>  			crash_cma_clear_pending_dma();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790014793.gi=
t.zack.rusin@broadcom.com?part=3D2

