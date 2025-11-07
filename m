Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF05CCFA05
	for <kexec@archiver.kernel.org>; Fri,  7 Nov 2025 00:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kp5HgcyuPKN0uJBMCjkC48uOKkYlSTwaJ1a+wngNQsA=; b=k0dcYgQt3MJS3sAxkPriUJ+49Q
	lHy12CC/BEh9VyCs020lTGBIhkm4lNX5mcsB5Kwgd96AUdNIosY8jbL33jmuG+V4I6FAd75tC92gC
	MQDpv0Ommg8BrTcQ8gnW+shu8e/KUlDvEEAAH6kYxQyFQGUfdoKVO2ej5aqvGfK3OGQyQsURdlVCi
	Lmospn6Cu9VWpqyI1YJQvU/r1r+rI/ibDc579Dh8yiT518Zyg03CzVDW3DqbTLT1H6A/usa3oEBGB
	KmvuxBygBvoDFjPSTwWSeKoW37VFMK7CxJlHZAICZBhRC4tSIRV/dtUfuN8BPJ3IPXE0rN0qfe/Y9
	R3T1NTbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHAas-0000000GSrW-1flI;
	Fri, 07 Nov 2025 00:44:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHAaq-0000000GSrO-3rY1
	for kexec@lists.infradead.org;
	Fri, 07 Nov 2025 00:44:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EA902601A9;
	Fri,  7 Nov 2025 00:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4DAC4CEF7;
	Fri,  7 Nov 2025 00:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762476283;
	bh=FNNCunyUX0kB5m9NXDlr3Oe0w0tL0R99MwjN2aO0MOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=klfNDB+xoOmbhTMaQHdVe84uRgh4JR1UTkHpwV1D2Pag+idktoUa8DQJDR+c6/zZe
	 uqLtvvCNrDyY7fE8Igl8LSiqnEoACcQXDBBaUMvEGj2b2fit1uNLaSYbeMpwmMi1x6
	 OjR7To/ktTFY6YDXMHePh9nvgxVW209MBaYD7X+Y=
Date: Thu, 6 Nov 2025 16:44:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, Baoquan He
 <bhe@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, Steven Chen
 <chenste@linux.microsoft.com>
Subject: Re: [PATCH 2/2] kernel/kexec: Fix IMA when allocation happens in
 CMA area
Message-Id: <20251106164442.f0158876667a18d0f31a127a@linux-foundation.org>
In-Reply-To: <CAF+s44Qoai54qUDqmVQoqWspneuuYF=SLYezoew_EHb_0By77w@mail.gmail.com>
References: <20251105130922.13321-1-piliu@redhat.com>
	<20251105130922.13321-2-piliu@redhat.com>
	<20251105161432.98eb69f87f30627a9067e78e@linux-foundation.org>
	<CAF+s44Qoai54qUDqmVQoqWspneuuYF=SLYezoew_EHb_0By77w@mail.gmail.com>
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

On Thu, 6 Nov 2025 10:57:33 +0800 Pingfan Liu <piliu@redhat.com> wrote:

> > > This is caused by the fact that kexec allocates the destination directly
> > > in the CMA area. In that case, the CMA kernel address should be exported
> > > directly to the IMA component, instead of using the vmalloc'd address.
> >
> > This is something we should backport into tearlier kernels.
> >
> > > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > Cc: Alexander Graf <graf@amazon.com>
> > > Cc: Steven Chen <chenste@linux.microsoft.com>
> > > Cc: linux-integrity@vger.kernel.org
> > > To: kexec@lists.infradead.org
> >
> > So I'm thinking we should add
> >
> > Fixes: 0091d9241ea2 ("kexec: define functions to map and unmap segments")
> Should be:
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> 
> Because 07d24902977e came after 0091d9241ea2 and introduced this issue.

Thanks, I updated the mm.git copy of this patch.


