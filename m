Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DB4C5DF66
	for <kexec@archiver.kernel.org>; Mon, 17 Aug 2026 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wnsRgd67O5ijJMELnbh+i0cmgBbItG68MRY6qRnSMzA=; b=iKV3JJIrRcJziYetm5k8FADuZh
	PX0qHTuWG5ifxK7Wyjy2rBXMNiPW2idoDLAPlZeMCbdZEOkHHPmBYoeqOnWTYn2yEJQ+CQAGR4+Zq
	iTgRirg/s1tNeX6t1NSmG2u/T/wZABbf/+s33lkYVZ+6hyHOzN73KEHPOiNDs848Ye43gd5HtOm+5
	aLSWe9s9x8868s53h5n1PxJqA9+8UxcbKA2mDrXC4REQ6DlqOw8Do7DXrXHdBmTi7tbdt1MV5imRH
	IcQfXy3lz7iqnmnKh1DKWJgwLy6ibpIZjUVhvbkcXfMXne0Oi3reotQAynov1DwDIrXaBXxjr1I2N
	SsJqjGsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvyhY-00000006LYZ-3C0m;
	Mon, 17 Aug 2026 14:52:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvyhX-00000006LYR-3T30
	for kexec@lists.infradead.org;
	Mon, 17 Aug 2026 14:52:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 85389601E0;
	Mon, 17 Aug 2026 14:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F371F00A3A;
	Mon, 17 Aug 2026 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786978354;
	bh=wnsRgd67O5ijJMELnbh+i0cmgBbItG68MRY6qRnSMzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CBoIq9lLGcS1UGfR4RR+GyS2qSFm8aL5eb+9zilvIc89rv295t+J+1iuJ2RdNYN95
	 G25ofttDY+XuK1AH5qG92ZIzkAEkONWdMALeOvk0NT42gNuHCzqWLWd9KbVPWOCw5p
	 ur5Gu+9bLyhlnKL13dobkZAf0L4xSVlHOROg4JpvVPf87NF4JB3luCj1ItTd5YRhqD
	 irW7P5rpyC+dFSJrxnBWYO+S7tHEmLwA4OetakxSOUZC20faUsFylpFkqnW+VDbmHA
	 p+smz5BpBO2zuDaOYjkXj2gF6+Nz/EzxK2oHF75hOI3g7i2UrPEwzXA5il4kD7inkq
	 iNIMSvK5+lSDQ==
Date: Mon, 17 Aug 2026 09:52:31 -0500
From: Rob Herring <robh@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: Pratyush Yadav <pratyush@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Baoquan He <baoquan.he@linux.dev>,
	x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/4] kho: rename "scratch" to "bootmem"
Message-ID: <20260817145231.GA579285-robh@kernel.org>
References: <20260811162642.3504565-1-pratyush@kernel.org>
 <aoMdJ7hpr1GonLz8@gourry-fedora-PF4VCD3F>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoMdJ7hpr1GonLz8@gourry-fedora-PF4VCD3F>
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

On Mon, Aug 17, 2026 at 10:42:00AM -0400, Gregory Price wrote:
> On Tue, Aug 11, 2026 at 06:26:36PM +0200, Pratyush Yadav wrote:
> > From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> > 
> > The term "KHO scratch" is vague and overloaded. It does not accurately
> > describe what the memory is for. This was discussed previously at [0].
> > The conclusion was to rename "KHO scratch" to "KHO bootmem", since this
> > is memory passed by the previous kernel for early boot allocations.
> > 
> 
> This seems like a lot of churn to just rename some stuff, especially for
> a term "scratch" which is very much understood to mean "temporary
> working memory region" in common computing parlance.
> 
> The boot param name change would also cause breakage for existing
> systems that update and depend on the scratch parameter.
> 
> Is there a non-verbiage reason to justify these changes?  Living with
> "scratch" seems better than potentially breaking folks.

I don't think these are the first breaking changes. And if the changes 
are fine, then that means more breaking changes are fine, too. So why is 
this upstream at all until the design is settled?

Rob

