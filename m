Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BCFD7494E
	for <kexec@archiver.kernel.org>; Wed, 30 Oct 2024 01:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0FwUQcwyhPTLQd+Xe5710wy1AuqTVBxU/04HxQNO6s8=; b=BSbZ/YRA4dcBmN
	wK3p96pCifY3eON/+Vo5i46s5MEzh6dGSZ5oRyagSgPmIsIJpOjXaF+DKvxuWTz5EFm0kHoQCents
	pC+c5LB4jrat3e27PxgQTvzBxp8Ujlb2snHwcDib+vwIHN+KnUr8yqzoZMcuyI4Y+c8dHW8r0t7Fq
	Mvysjz0swjHUACND+bQ7c0B27N1LLVjYa7h81EcWifd1J0mi4Kf2C+zf/ALuuyvXirFq1ntvglqRN
	77rjdeGYIjLUZX9CaGrb82f2jrzVY+ksrMa2ayMMwwfPqhJgSIeAX7xhmzfi9VUNtFYHwcWezvGPX
	Z0h1XGsujsr7e3c4xtfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5xQX-0000000GPTg-0UpL;
	Wed, 30 Oct 2024 01:23:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5xQS-0000000GPR6-3lCf
	for kexec@lists.infradead.org;
	Wed, 30 Oct 2024 01:23:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C63905C4BBE;
	Wed, 30 Oct 2024 01:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284B0C4CECD;
	Wed, 30 Oct 2024 01:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730251387;
	bh=9bbL58ucddYOxopOJZWP6bpXOgmfcOxllpK9hPeF74c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=brrR1smLI2xheqOjuQcdgtzKlJE20MygXvcdbzMzl9VuwNx6hdnuZaiLfV4BsrKEc
	 mfkMdNfQU6KiBgrt2hDARIH9ZZj9i6k3bQrcf1zjuyqDDdaG1UtnyCHm4ts5K6xwyR
	 xwNZpDp/GxwtZyXb5ADIAJcVxsfgDtQS9BtbpnIk=
Date: Tue, 29 Oct 2024 18:23:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
 dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
 lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 0/2] x86/mm/sme: fix the kdump kernel breakage on SME
 system when CONFIG_IMA_KEXEC=y
Message-Id: <20241029182306.04c3451808c8b76e5e96fdb4@linux-foundation.org>
In-Reply-To: <20240911081615.262202-1-bhe@redhat.com>
References: <20240911081615.262202-1-bhe@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_182309_019058_EFF5FA1B 
X-CRM114-Status: GOOD (  13.99  )
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

On Wed, 11 Sep 2024 16:16:13 +0800 Baoquan He <bhe@redhat.com> wrote:

> Currently, distros like Fedora/RHEL have enabled CONFIG_IMA_KEXEC by
> default. This makes kexec/kdump kernel always fail to boot up on SME
> platform because of a code bug. By debugging, the root cause is found
> out and bug is fixed with this patchset.

[1/1] is a cleanup.  [2/2] fixes a bug which appears to go all the way
back to 5.10.  The bugfix patch has a dependency on the cleanup, which
is unfortunate.

We could add the Fixes: to [1/1] and add cc:stable to both patches so
they get backported into -stable kernels together.  But I think it's
nicer to just concentrate on the single bugfix patch (with Fixes: and
cc:stable) and do the cleanup later, in the usual fashion.

So can I suggest a resend please?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
