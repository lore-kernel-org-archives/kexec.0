Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C29CC4345F
	for <kexec@archiver.kernel.org>; Tue, 23 Apr 2024 18:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=APeJEUiHjkbEN/ZuFxoVvRdNXkkih+30t0G4ndU/ZeA=; b=pthnKqjFrDCRYu
	9VzGuS/XeIZA1SaPIO0bwnuOCZCvDVOFU5ZGdkxc9sBI9b6wENRXFSeLD5qr3Vs69gi5Hz+uzDqdy
	trl/Nu3eYQlo0XptAC4DYW2tipGzVsSfCi2VfFKIuznx7r6HvrcABOmR3S72gQENO3uSbtVfCZeww
	gOgeVqIJ0oZVbarcRRhjIZmraIPRlut7j/4bRdfejaw2j6208iguLuMbHTO6roqYYiSQhJ/ECvLuH
	bbbw2dwGVZ9HTI85NRlrPAIO70awQh4ANcOmE4QVMUWoNJMqXFn7PMW/cCfZqnW6Z3NSD8qevGZqn
	c1+a+gZCmpX16gBcu+QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzKvk-000000018Wx-29Fk;
	Tue, 23 Apr 2024 18:31:48 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzKvd-000000018V6-22Td;
	Tue, 23 Apr 2024 18:31:41 +0000
Date: Tue, 23 Apr 2024 11:31:41 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Joel Granados <j.granados@samsung.com>,
	Kees Cook <keescook@chromium.org>,
	Eric Dumazet <edumazet@google.com>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev,
	lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <Zif-jf8Takojtq7x@bombadil.infradead.org>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Apr 23, 2024 at 09:54:35AM +0200, Thomas Wei=DFschuh wrote:
> * Patch 1 is a bugfix for the stack_erasing sysctl handler
> * Patches 2-10 change various helper functions throughout the kernel to
>   be able to handle 'const ctl_table'.
> * Patch 11 changes the signatures of all proc handlers through the tree.
>   Some other signatures are also adapted, for details see the commit
>   message.
> =

> Only patch 1 changes any code at all.
> =

> The series was compile-tested on top of next-20230423 for
> i386, x86_64, arm, arm64, riscv, loongarch, s390 and m68k.
> =

> The series was split from my larger series sysctl-const series [0].
> It only focusses on the proc_handlers but is an important step to be
> able to move all static definitions of ctl_table into .rodata.
> =

> [0] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-0-7a5060b11447@=
weissschuh.net/
> =

> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>

Cover letters don't need SOBS we only use them for patches.

But anyway:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
