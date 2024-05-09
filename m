Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E1BC25B74
	for <kexec@archiver.kernel.org>; Thu,  9 May 2024 01:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VxS8qhz4AJJyhStC43WGoIhzos/Vo9FUpkqDcgD/qGg=; b=HjMmHQZxs6cYe9
	LaOf0cER5CYP0ul6DazHSGHFDI8yhqiYrjoq8q/dR3sXak7Nzn71oXSOE1UmD4FFHTl0tuHa+kkkJ
	UQR7qzXAUGbhkqYMM4TGdyjRR/glwrvupqVKK5diG7UwSCsEwoPwYVHW9EsubAv84tHZB7DUuDyIG
	Mwi9Um9rvs9SO/lhl9Cz7f9ds9hryxGyggrBChaqQvE8e/A4wBwLVDwBs9cC+Gr1oqPanclU4It9w
	Qdmc+5KjAu9xORw2e56SFlpD6Wzs71kYJaO9ynl7RF9F1zN6edPQLkqdMoRoyhtalMdLjZ+NdL9Q6
	PzgILJt2xHNEdGXm90Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4s8p-0000000HSwf-039q;
	Thu, 09 May 2024 01:00:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4s8l-0000000HSvX-3Y7D;
	Thu, 09 May 2024 01:00:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4637561A3C;
	Thu,  9 May 2024 01:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5827C113CC;
	Thu,  9 May 2024 01:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715216405;
	bh=9n6emzJJV1YX0cAHx4F9eAW5P1FzVQRtiGBpOCeJFX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D0za5rf8sBZLeTFfBwvH/5N1DEtRx4ddPaEKSxntYldtCZFiYr+kZfL/DPfTpd57y
	 FkhTonAdznnnMsG/Jp8zcJ/5PM+gP0HSB24OIa5SvzI6O66EgZUZWygQB8n3m664Vk
	 iw2gLzWak8zQqGD7NWJHmLYv7ayRF7VNeJDvoJQbuuL4ka1sD6Vgqp+3H5xH816G20
	 IgUv7nVLhAegE3iIM6ZwFEP1kfHbzk6yoOEt4uVmR2mApKLXHKB1BZi2CcWGV8jx04
	 kONXdu6CLktRjchT/w65rRI6tXLJZuu9lzLKHyav3WPKnjku1XOKMFyOYjqa3XcRWl
	 nEfGC6fd23pIg==
Date: Wed, 8 May 2024 18:00:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>, Luis
 Chamberlain <mcgrof@kernel.org>, Joel Granados <j.granados@samsung.com>,
 Eric Dumazet <edumazet@google.com>, Dave Chinner <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, kexec@lists.infradead.org,
 linux-hardening@vger.kernel.org, bridge@lists.linux.dev,
 lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
 linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <20240508180003.548af21b@kernel.org>
In-Reply-To: <202405080959.104A73A914@keescook>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
	<20240424201234.3cc2b509@kernel.org>
	<202405080959.104A73A914@keescook>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_180007_989377_BD1503D8 
X-CRM114-Status: UNSURE (   8.62  )
X-CRM114-Notice: Please train this message.
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

On Wed, 8 May 2024 10:11:35 -0700 Kees Cook wrote:
> > Split this per subsystem, please.  
> 
> I've done a few painful API transitions before, and I don't think the
> complexity of these changes needs a per-subsystem constification pass. I
> think this series is the right approach, but that patch 11 will need
> coordination with Linus. We regularly do system-wide prototype changes
> like this right at the end of the merge window before -rc1 comes out.

Right. I didn't read the code closely enough before responding.
Chalk my response up to being annoyed by the constant stream of
cross-tree changes in procfs without proper cover letter explaining 
how they will be merged :|

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
