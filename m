Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5143C43458
	for <kexec@archiver.kernel.org>; Tue,  7 Jul 2026 06:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yn/kZO4u9dWBVxPs71FKMvr7XU7SEACJ62k7H7NLLHk=; b=azZSGzLu1UEV9zSTz6O+Ns+Ffy
	oirV+kWFeQf7uLKAPRBQ+hUmWQCOl6DQyzWjcdkvH1YnN6VFLCEf4IonH7Tbp6urGKNCaPGYQtIji
	Ak+dAHz4UtkP0oAgJXQo26IpPnHm547XIhXtqWs2/cW0FvdyenaNoT2zF2W0qfvlcyrZ+rBhHdhGu
	lABBfsCR9XmYTghPaWZ+RKOfuRhxyXrQ+/ZfZZ9J6tIam0XnEcHvPfYN/9Tkt7E5jhbYgsUghUHo/
	XXD9OWmdE0aDBEogUROF485mUOH9doff1AmobhNwqEmELhpYtcGYstBGpCIpaHCX/VW+1vj5AV7YU
	IvFk+vkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgzC5-0000000ECVT-1cld;
	Tue, 07 Jul 2026 06:22:09 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgzC4-0000000ECVF-2PeM;
	Tue, 07 Jul 2026 06:22:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8463861897;
	Tue,  7 Jul 2026 06:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E881F00A3A;
	Tue,  7 Jul 2026 06:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783405327;
	bh=yn/kZO4u9dWBVxPs71FKMvr7XU7SEACJ62k7H7NLLHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KX6oQElB50riJguELkN1/oM9JSIx8kufrjmms3fiXJNuW5KspQJmZPSt5txAZwfZ2
	 qmwzwv32TZ5VQ3oVo86MzmGlBTLY0Bult2je9cYUNm2GumxPfXXh02U5/eP8vmHATh
	 l0yk6hi+eNbFC6j4Z2RJlqcTzZ7DOp8Uj1YjkWzycPc4UWvkIAm4v5o6S6kgQnsXsC
	 E5uOMqlHsQQayQziHVuprBAfwDQOqDDMnD6V8Q0bGxtuBz+B3iFjgb7Li8Vf9AlbpN
	 RpGXmnITZ7hRagUJHFpM3AfnuqLKeiy/VdtNQMbB8VYinItP9T+2lm4M+HfkO2i1RE
	 HQyPN68VjyoBw==
Date: Tue, 7 Jul 2026 09:21:58 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pnina Feder <pnina.feder@mobileye.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Dave Young <ruirui.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Alexandre Ghiti <alex@ghiti.fr>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/4] vmcore-tasks: export per-task metadata to vmcoreinfo
Message-ID: <akybBoCAm-kJbfHL@kernel.org>
References: <20260622211430.4008899-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622211430.4008899-1-pnina.feder@mobileye.com>
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

(adding new Baoquan's email)

Hi Pnina,
On Tue, Jun 23, 2026 at 12:14:26AM +0300, Pnina Feder wrote:
> This series extends vmcoreinfo with struct offsets and sizes needed by
> the vmcore-tasks userspace tool to extract per-task state from a vmcore
> dump without requiring kernel debug symbols (DWARF/BTF).
> 
> The vmcore-tasks tool reads /proc/vmcore (or a saved vmcore file) and
> reconstructs, for each task:
>   - task name, pid, state, flags
>   - VMA list (start, end, flags, backing file)
>   - user register state (saved on the kernel stack at kernel entry)
>   - user-space backtrace with VMA/filename mapping
>   - kernel dmesg buffer
> 
> This provides a lightweight post-mortem crash analysis capability for
> production environments where full debug info (DWARF/BTF) is not
> available.
> 
> The companion userspace tool is submitted to kexec-tools:
>   https://lore.kernel.org/all/20260622205550.1087163-1-pnina.feder@mobileye.com/

Sorry for the delay, this fell between the cracks somehow.

The kernel side looks fine overall, but to merge it there should be an agreement
from the userspace side maintainers that vmcore-tasks is something they are
wishing to accept.

-- 
Sincerely yours,
Mike.

