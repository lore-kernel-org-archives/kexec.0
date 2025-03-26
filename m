Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC017C36011
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JaIDfjF+PFG59ZudOfy9O7MI92EP5Qgm2ea3MkLjJiI=; b=E2AoXpabmaU5t45x18cMS3n2AI
	JVaELGwE8VfO/djntmAYhEqRNl2EphA3+xEG08w7Mp7E+jNpYGDGWM+W0/jOBIscaF7oY+KHTmxGP
	Kpj3cu6llQ2AZSaIkbcv2QRherCR5YRE7Y88RVjQgAwxc0pwbLXgFp1y72v6s1LVYWOiwXWcA2py5
	rtMKvtuxG2hmSKK/xaDwBiX7Rf0uPjD4wq8L95k7iQSsO8MjWRJrMf1CM3LtFgi5S8wLl+GNKHvY2
	UdXZ1N/VuVieTKhAIP7JJHYqtLwcH/ywtEtH+XLbih4ix39Ks5ym2qWlr13nCTcrC101qxR1SlGSh
	NjEfIWxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnU0-0000000B6FG-1lJG;
	Thu, 27 Mar 2025 13:41:20 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txPXa-00000008QFD-1U1c;
	Wed, 26 Mar 2025 12:07:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6398EA41105;
	Wed, 26 Mar 2025 12:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BC6C4CEED;
	Wed, 26 Mar 2025 12:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742990845;
	bh=MfJ0FXYJCv8THmu44KFWCJKW5Y6BQslOAVgSU6DpjPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4AjXU5UbkAQx5aYar7PCRjCmarMZeYXZZkrMlCatQoWK5Vt4UvNZUDT6N/8RNsTZ
	 7o5Uxs8c15urYeBLkON6Vo+a/MWPcWMcSWDzJDC7U/kxmVCl4X3jmNI9XSk2Lypjuj
	 Q5b9Qy1JR/Y+stStQg60BmTHSgU4Ma1/0fWEyqpudzP/0aUueElJ4ot+DcUUMTbuYr
	 9C09LODiWWoP6DYgnYWcFcVBxLrb2hOz3xJiCc9Ffrxdf7OQs5rJ0TAY0gOfwc295v
	 P9J6rYku7UtdVF/dK6zoP0E9eWJm0EkggPLgNL1NqZ/b3BX8aJ/V4x18OQn4+KJYqA
	 KXKzGSk4uhW/w==
Date: Wed, 26 Mar 2025 08:07:19 -0400
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org,
	robh@kernel.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org,
	tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <Z-Pt9yLP0cMR23cJ@kernel.org>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-10-changyuanl@google.com>
 <20250321134629.GA252045@nvidia.com>
 <Z98Lmo50h5RboFXq@kernel.org>
 <Z+BZOKSpyPA1Pyu+@nvidia.com>
 <Z-Gh-t9xB21UNGU2@kernel.org>
 <Z+G7iHUdRZGv1Ose@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+G7iHUdRZGv1Ose@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250326_050726_448085_684E671A 
X-CRM114-Status: GOOD (  17.20  )
X-Mailman-Approved-At: Thu, 27 Mar 2025 06:41:08 -0700
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

On Mon, Mar 24, 2025 at 05:07:36PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 24, 2025 at 02:18:34PM -0400, Mike Rapoport wrote:
> > On Sun, Mar 23, 2025 at 03:55:52PM -0300, Jason Gunthorpe wrote:
> > > On Sat, Mar 22, 2025 at 03:12:26PM -0400, Mike Rapoport wrote:
> > >  
> > > > > > +		page->private = order;
> > > > > 
> > > > > Can't just set the page order directly? Why use private?
> > > > 
> > > > Setting the order means recreating the folio the way prep_compound_page()
> > > > does. I think it's better to postpone it until the folio is requested. This
> > > > way it might run after SMP is enabled. 
> > > 
> > > I see, that makes sense, but also it could stil use page->order..
> > 
> > But there's no page->order :)
> 
> I mean this:
> 
> static inline unsigned int folio_order(const struct folio *folio)
> {
>         if (!folio_test_large(folio))
>                 return 0;
>         return folio->_flags_1 & 0xff;
> }

I don't think it's better than page->private, KHO will need to
prep_compound_page() anyway so these will be overwritten there.
And I don't remember, but having those set before prep_compound_page()
might trigger VM_BUG_ON_PGFLAGS().
  
> Jason

-- 
Sincerely yours,
Mike.

