Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE341CAC592
	for <kexec@archiver.kernel.org>; Mon, 22 Sep 2025 21:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fkzqONRP1JWZh8Hm3tY3m8ycHxfaI2bDYd+djXSxcQk=; b=arcTfkzDOAVocpSnct6lGPxdjW
	5N5J9mM5c7rj2o0LhuyJrWs3rEixc8uta39MoAlbxXhlS6atvY81OwP6Vy7Uif1ukKOX7JBFLVi+R
	I59A7xLpz+Q58R49N2cl0JYLDPZVmJDaRTUhCoIgWPj00Cp870+wXzoEz9/IgZDbq5Jes2aF/ZFRj
	iJHEWO37BofFO78PuMlviLXVym9ReRcb3+oym+zLBqj/T7Abcu3vYWT8dt6qZmLRrT5u+tRLejbDE
	0sjfIBWr2xzt+2jQOw7oDLguqFY6KbSTHcSZTDoHCa+ZphXKtfUuWcUgmoTXKflTGgSNVhmcceSfV
	GmYR8/YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0oAm-0000000BZX1-2bdV;
	Mon, 22 Sep 2025 21:34:12 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0oAk-0000000BZWh-12xn
	for kexec@lists.infradead.org;
	Mon, 22 Sep 2025 21:34:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B058A403B5;
	Mon, 22 Sep 2025 21:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B04BC4CEF0;
	Mon, 22 Sep 2025 21:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758576848;
	bh=eJ5VtR70eO4BCYnBNWbIL5V8RzRuhAmch8nOpB/p+w4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lD0HyuGAiwZT045i1LqSR7lGe85sOzhllEa5mANNVoQBlmcrWKihlL7PNnRI5ITQm
	 ayJAf7l5W/qL0Mm0zBsJHAHIQZuwhkR4wlQd9eerZM5G/5d0MWVyS+Uddor24T/2My
	 hOoSI+h02LD/otpDWssYUFft6+oM/zRtvMMahYv0=
Date: Mon, 22 Sep 2025 14:34:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, Chris
 Li <chrisl@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc
 allocations
Message-Id: <20250922143407.93e171f8b7c09eb21159a33e@linux-foundation.org>
In-Reply-To: <20250922131948.GX1391379@nvidia.com>
References: <20250921054458.4043761-1-rppt@kernel.org>
	<20250921054458.4043761-4-rppt@kernel.org>
	<20250922131948.GX1391379@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_143410_316031_980A1672 
X-CRM114-Status: UNSURE (   9.98  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, 22 Sep 2025 10:19:48 -0300 Jason Gunthorpe <jgg@nvidia.com> wrote:

> > +static void kho_vmalloc_free_chunks(struct kho_vmalloc *kho_vmalloc)
> > +{
> > +	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(kho_vmalloc->first);
> > +
> > +	while (chunk) {
> > +		struct kho_vmalloc_chunk *tmp = chunk;
> > +
> > +		kho_vmalloc_unpreserve_chunk(chunk);
> > +
> > +		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
> > +		kfree(tmp);
> 
> Shouldn't this be free_page()?

Or vfree()?

Not sure why this code works - I'll suspend the series from linux-next
for now.



