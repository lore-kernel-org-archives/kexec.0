Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C00BCA5FA1
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 18:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:Reply-To:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:In-Reply-To
	:To:Subject:From:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Em6qkKYb+gUcvRKeEmVxlAsqhkqcC0JJ8qJlMwTzxyE=; b=APFMzueLZFmpJ724W1rM1nZUDD
	1EYze+4on4bQI1Bp67gb9HAjGQ62nGVl+maAtkyvy9LL7tN0EMFKaCDHcVtFREESmTkInnX9rBmZU
	Bzl2vCOfgEDB90BPy8UcRPM3Wo9RuI95pvMF/UIm/S89dDVnXd1cBRHQtoS/H9o3S0kxUJbSxhDZd
	UMsNjbbb1WADSlT7axuUc6zJN+8dCCCZ4u2KZDznjWRiIaAUkt02ygnRxdl3XBtPSvgqNhf5Kd2m9
	m8uzGpwpOZv8x2jx4wPnQrqnJCjOXkC+ImX0tR9kR0AC5huJW4BEMVEDZwj6nMmxT+PoswRqwi0lB
	EsiBi73w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFhV-00000001GSW-1sHE;
	Mon, 28 Sep 2026 18:03:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFhT-00000001GS4-3ubb
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 18:03:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 67837423C9;
	Mon, 28 Sep 2026 18:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9CE1F000FF;
	Mon, 28 Sep 2026 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618619;
	bh=Em6qkKYb+gUcvRKeEmVxlAsqhkqcC0JJ8qJlMwTzxyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rn6zrALhktzX3F+Qlx/sCblhKYPW7bRfEE6BJ6xnmgqwaOWPYFxo3ixhEbhKg+r6O
	 e+H0GV5kzwq5abYap6EhWyHAJC1ciZuD2u0jDx9k44qyxiXPne3k2fpLGlOgSPsAvj
	 OwM397eqZzSNjsfzqndd+jf/KLESRjltxZU/R1iVbMDCCWbu/p93B+z3mO8ywoG57y
	 xzafkjNjqPMxcRwwOFpja7N2v1AIZyxgkL4Swwhv1YzEVOo8jIp6dyaAvh4X2Re4Uy
	 hepOuRZUAcK5Ws1/P2ZRnr9lfpFOMkIu3O07XVV7l6pIWnXLAT/YBnrAqtYoAK0XpE
	 XEhnD18itDbdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] x86/vmware: Report guest crashes after kmsg
 dumpers
To: "Zack Rusin" <zack.rusin@broadcom.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Petr Mladek" <pmladek@suse.com>
In-Reply-To: <996d3ceefd98ed9a7c40508e6f62039ba5a15325.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <996d3ceefd98ed9a7c40508e6f62039ba5a15325.1790014793.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:03:36 +0000
Message-Id: <20260928180337.6F9CE1F000FF@smtp.kernel.org>
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
Cc: x86@kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen
 Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Jonathan
 Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, linux-doc@vger.kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Eugenio
 Perez <eperezma@redhat.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay
 Kaher <ajay.kaher@broadcom.com>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz
 Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael
 Kelley <mhklinux@outlook.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian
 Forbes <ian.forbes@broadcom.com>, Thomas
 Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> VMware accepts a structured guest-crash event, but a host configured with
> backdoor.coredumpOnCrash may terminate the VM before the hypercall
> returns. Keep this event separate from the pre-kdump log sender.
>=20
> Register a panic-only kmsg dumper with late_initcall_sync(), after built-=
in
> dumpers registered by then. Skip the event while a crash kernel is loaded
> so the host cannot terminate the guest before kdump saves its vmcore.
>=20
> Issue the event at most once. With CONFIG_PRINTK=3Dn, use a late INT_MIN
> panic notifier. An unexpected dumper registration failure with printk
> enabled leaves reporting disabled rather than overtaking working dumpers.
>=20
> Link: https://lore.kernel.org/r/20260309235250.2611115-4-alexey.makhalov@=
broadcom.com
> Co-developed-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
> Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
> Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790014793.gi=
t.zack.rusin@broadcom.com?part=3D6


