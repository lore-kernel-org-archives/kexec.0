Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02672C48BF6
	for <kexec@archiver.kernel.org>; Mon, 26 Feb 2024 19:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/JsNNjW3SgRXP4FGRZr2FD9hSvo7vwErw/5ewGFd/jY=; b=HNNo5pBQs1bqZy
	+xgXfOsP/oJpiYCZmvhHE/Hi5fORNPppzUrbEyu+SPTKFeMy+XhuQJdRvuKbBe8kJ8QEm8vTJAQnQ
	hqBFBsyCKgks2XzJ4rYkPnjYgvEAtC5CBf3xk0BNBBRJohhaRDtAB+TO3ulInKXCBsJ48GZ/zlYtT
	Jjx3PKa/oKlpHpJ2zC+ReEIR4v+zez0sWxR8LKtAc4U97NUEnUc486i164ohZOMkmWOV+nTPEBLQ8
	pkgf0j+i1H6zAUmGCB7pAyvaAv2BCAnyvej0/jMAM8JQa9QMhE5vnb1MfBFdssPeHkhT+DWQcoInp
	Bh7Gkr9rXEi3py2r42XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1regNA-00000002KHi-07mo;
	Mon, 26 Feb 2024 19:10:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1regN5-00000002KGt-2348
	for kexec@lists.infradead.org;
	Mon, 26 Feb 2024 19:10:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A5CE7612DC;
	Mon, 26 Feb 2024 19:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C885DC433F1;
	Mon, 26 Feb 2024 19:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708974638;
	bh=Q8kPJtYHk31pouePvzRSVpdUlZrGVNhgF7qIYjO68v4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d/H/EtMIF5j8Idssk8RxnYd22THuWd4EEoIOthl/LQv2e+rMTbCQg8TRIKqVNbSyp
	 P2bTi302j/4k3dle+SB6NnzxNHA4RDE/xC+3MxD/o8CtVaBxCuCr7VQyVkHjSBbfgF
	 +1pL4pm8YWk74NTf6HuTGHTXrcrV+fUMGB42LeQU=
Date: Mon, 26 Feb 2024 11:10:37 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: bhe@redhat.com, patches@amperecomputing.com, vgoyal@redhat.com,
 dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 k-hagio-ab@nec.com, lijiang@redhat.com
Subject: Re: [PATCH RESEND] crash_core: export vmemmap when
 CONFIG_SPARSEMEM_VMEMMAP is enabled
Message-Id: <20240226111037.d76d299db1b26673b876e83a@linux-foundation.org>
In-Reply-To: <20240226020433.3353-1-shijie@os.amperecomputing.com>
References: <20240226020433.3353-1-shijie@os.amperecomputing.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_111039_607468_AADF7CFA 
X-CRM114-Status: GOOD (  10.69  )
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

On Mon, 26 Feb 2024 10:04:33 +0800 Huang Shijie <shijie@os.amperecomputing.com> wrote:

> In memory_model.h, if CONFIG_SPARSEMEM_VMEMMAP is configed,
> kernel will use vmemmap to do the __pfn_to_page/page_to_pfn,
> and kernel will not use the "classic sparse" to do the
> __pfn_to_page/page_to_pfn.
> 
> So export the vmemmap when CONFIG_SPARSEMEM_VMEMMAP is configed.
> This makes the user applications (crash, etc) get faster
> pfn_to_page/page_to_pfn operations too.

This is significantly out of sync with development trees.  Please take
a look at linux-next and redo the patch if still needed?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
