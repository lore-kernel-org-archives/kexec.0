Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFA01094489
	for <kexec@archiver.kernel.org>; Sat, 21 Mar 2026 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JVGXH1SxJj8dD8zmZ+WAQEA2CbNwgUcMHntU25B5dXE=; b=jl7fQtxaQwKy4faiJbVfZ8XmSc
	z7HgnMIU6O0wVsu5npM3SZRy8byHsx8CEWrQX0isU8UnfDaaa3Erps+ddolaCvn8dHuTW31jx8mvh
	Q7Ik4TQo2adhmY39Zo4RwKKBbOmLVnzbXHaZilXpmT9HpvvrLfMNWEIHPgi1tP7sj7pVU7U+pltKU
	9eGSVaZl7T0j8FPUyg00YVZRyTzMzuW8K1/PR/FVBKllH6BIdO493ivO+yj044EGkxpg9hnb8t1JD
	Y4G90t+WwLIN6U7zzGg+UlBE+TQEAumhI/AvgpmAMuS6pMJ6g1wFmbeT3TSw9rXCPCDsFdHEfEmED
	CowbrZZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w40OB-0000000EgtT-3oVj;
	Sat, 21 Mar 2026 17:45:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w40O3-0000000EgtJ-2DqF
	for kexec@lists.infradead.org;
	Sat, 21 Mar 2026 17:45:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5DD7960097;
	Sat, 21 Mar 2026 17:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C5FC19421;
	Sat, 21 Mar 2026 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774115122;
	bh=b09dUEiuJZvqLTVdlTgn9/rX1kYJB0cx3MYC05H7O18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2eggLpm4YaEuXpxVeTrzh145/QggoL5VcJ7Mksr7anH6AU6oQX0s99X2FXLqL58iX
	 om12fFB7CnTxAzjmTikgUovArDr5gHs8ArW0BHReXqh7H0hse4uptdNR37FXj6kwup
	 UIXvqEdSPhk4fynERqS/2ahjE8n5unx08ZJOahZo=
Date: Sat, 21 Mar 2026 10:45:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport
 <rppt@kernel.org>, Baoquan He <bhe@redhat.com>, Pratyush Yadav
 <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/5] liveupdate: block outgoing session updates
 during reboot
Message-Id: <20260321104520.5e9aa4768df0520d7d6588f4@linux-foundation.org>
In-Reply-To: <20260321143642.166313-1-oskar@gerlicz.space>
References: <20260321143642.166313-1-oskar@gerlicz.space>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sat, 21 Mar 2026 15:36:38 +0100 Oskar Gerlicz Kowalczuk <oskar@gerlicz.space> wrote:

> kernel_kexec() serializes outgoing sessions before the reboot path
> freezes tasks, so close() and session ioctls can still mutate a
> session while handover state is being prepared. The original v2 code
> also let incoming lookups keep a bare session pointer after dropping
> the list lock.
> 
> That leaves two correctness problems in the reboot path: outgoing state
> can change after serialization starts, and incoming sessions can be
> freed while another thread still holds a pointer to them.
> 
> Add refcounted session lifetime management, track in-flight outgoing
> close() paths with an atomic closing counter, and make serialization
> wait for closing to drain before setting rebooting. Reject phase-invalid
> ioctls, keep incoming release on a common cleanup path, and make the
> release wait freezable without spinning.

A [0/N] cover letter would be appropriate.

Please have a think about which patches should be backported into
-stable kernels.  Possibly "none", given how new LUO is.

If there are any backportable patches, please ensure that they are at
the start-of-series, or separate them out into a separate series,
against current mainline.

AI review hasn't completed yet, but it has things to say:
	https://sashiko.dev/#/patchset/20260321143642.166313-1-oskar@gerlicz.space

