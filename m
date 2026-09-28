Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9849CA5FA1
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 18:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:Reply-To:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:In-Reply-To
	:To:Subject:From:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=al5fOqCdsYQeSS5YhK0c2oDQh/mMiyymN0ye+N+SIYw=; b=T5NSAD4tvPlj3gZmeKyq67LGWu
	On1IBfSXRi5AgI+bwDu8mun8mEcKqTsz20CI4T3w5T7wIsiWBzWc49wcqflJGpPhA49WQ8vgCRVx6
	9sCEu7PVqGPjfgjKzRv4fJFmTIPctWgVt7MSaBrlXTGwZ3QBhoHRCeyfMvFO1JYnyDzWJdijbwau/
	xwsmNZUIXUfpXM5q2ag1VBNolBX+ubV04PLiDNeLguo7Dac0z0KPNZA0sLptNSf2yWLHxV+a52rs3
	UztExkDU6eaZd2HF4dTbkcYkHMJuX7WYAtkAylax++8IiVY543bLWzyqaYxGTcPJLXTzuN0LHSMBP
	GSbmuA7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFi5-00000001GaM-38MJ;
	Mon, 28 Sep 2026 18:04:17 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFi4-00000001GZP-3f2G
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 18:04:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DB61C601FA;
	Mon, 28 Sep 2026 18:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC69C1F00893;
	Mon, 28 Sep 2026 18:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618655;
	bh=al5fOqCdsYQeSS5YhK0c2oDQh/mMiyymN0ye+N+SIYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G4PSbg2+N60B6P8KENLHuAe5rydDTlgDt3aKAW2qnRptKCvy7WVOcGHdRV3gZOI8f
	 XpLPUVvGZ8rR1my31rZrhY2rwGBE20oyfhOVVPVfqT99La7PZUG1QR2JH5XsUyz14P
	 7Y+AgUM9Vi4uEWghrq8XpfqegdOJ5JdXoNdwHBokYv/bNmlCr+xRbdR+i6x9jm3SKB
	 Dzxo23JJPfIQIRXh/8AX+O92iR4OgGgsk2prLVp9Lu5jfdrbzQDCN6h2rwSMNlHle+
	 qYyKYGoGRV2SkrWRRMqsf1CDweb3eQu+XO/PS9c5uQ37mCNscaASH5prcRvpNKqiwB
	 atrsYhNo5wEhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] panic: Allow postponing pre-kdump notifiers
To: "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan He" <baoquan.he@linux.dev>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>, "Zack
 Rusin" <zack.rusin@broadcom.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Petr Mladek" <pmladek@suse.com>
In-Reply-To: <52183acf25209275a9a57fe5d746f82d3b7efc3c.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <52183acf25209275a9a57fe5d746f82d3b7efc3c.1790014793.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:04:13 +0000
Message-Id: <20260928180413.BC69C1F00893@smtp.kernel.org>
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
Cc: linux-doc@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen
 Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Eugenio
 Perez <eperezma@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay
 Kaher <ajay.kaher@broadcom.com>, John
 Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven
 Rostedt <rostedt@goodmis.org>, Maaz
 Mombasawala <maaz.mombasawala@broadcom.com>, Borislav
 Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Thomas
 Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> Provide an escape hatch for debugging kdump failures that may involve
> pre-kdump callbacks. Add panic_pre_kdump_postpone to skip their early
> invocation in crash core without consuming the once-only guard.
>=20
> When enabled, the chain runs before kdump only when
> crash_kexec_post_notifiers is also enabled. Leave the late panic call
> unchanged so callbacks remain eligible if that path is reached.
> Skipping the callbacks may prevent hypervisor crash handling.
>=20
> Suggested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Link: https://lore.kernel.org/r/bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igal=
ia.com
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790014793.gi=
t.zack.rusin@broadcom.com?part=3D3


