Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAA3EE4989
	for <kexec@archiver.kernel.org>; Tue, 30 Dec 2025 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2TX26TM650mDKkRro/fXnbl+XLoQ1USQ4BfmC9rVVJw=; b=O3OAy2TaSRw6znY8yK1BszpB+q
	HlGSKxeWWmyQGbccPZv6m5EjiU2YtXSFTnaLYPymreRtdOufsM5QZJzvZ6Wn93sRaOZkYGN+FRPrL
	J2isG50mR7O+5tVflAayjBzouw1a5Qwgv8u8jGOv0s5ErB8Vga7wEBayCQQPqV6OkAysqoRjQget8
	GUVQKKJFEqd+QG/FTEGNc3YkAh0tPXHd2FAlwKNrxyUMxi4/h+IQLbF0IRjtyQD7Egd5V4OcpIbTa
	LTrmSked372yBUSWQ4c6KVwVzjSPZNkTBumWtD26Ap+DM5wa7l8A26UKTUifhzMKV2t1KzQU3WHLt
	+7+Z2p+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vacOI-000000052sv-3kc5;
	Tue, 30 Dec 2025 16:16:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vacOG-000000052rs-2BuB
	for kexec@lists.infradead.org;
	Tue, 30 Dec 2025 16:16:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D4577405D6;
	Tue, 30 Dec 2025 16:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A5FC4CEFB;
	Tue, 30 Dec 2025 16:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767111367;
	bh=HlcNLtyf8O/u0mMEhZMir3AIamz/dUTwsMWTaLGExRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cG1OD7UHqRWnRx0c3h5AWJz/OZ1xiYrNSHTEElBM2TXQmtHr7iXURNccCaodth9rG
	 5xiCAPvXL10s98nPJB76VFOlqFQTDARqp0lgbAbcfHwEx6nz0akAxOV+TAiNP3eyUK
	 in6KMbJe/REScuCQ2skG7shtIuHzorsMdmbi64HmatTw+SlSFYP/UDLQCL4ittiUNA
	 Zq60DhS0GLjGM8Vv21SwVWzC3p8hVztq+yqkrniB/3rvAtg0uimL+/HUuMsXRavNYf
	 R3qWNUI/KAimLiCv2xu+h7K0m92N5pDO8TosTzLnzw6QN9AeTo3W0+g+3YzfYn5C4v
	 QElwDP1hpWUJg==
Date: Tue, 30 Dec 2025 18:16:00 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Evangelos Petrongonas <epetron@amazon.de>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	nh-open-source@amazon.com
Subject: Re: [PATCH] kho: add support for deferred struct page init
Message-ID: <aVP6wBYoHJQsplIl@kernel.org>
References: <aUUYprAotKYMiEs0@kernel.org>
 <CA+CK2bD101cSC_7+OWkMei2QvUVjSaRLy+LboLe8Sz7KS3by4g@mail.gmail.com>
 <861pkpkffh.fsf@kernel.org>
 <CA+CK2bA1kYCf0BwhX3Sg9Ur82nK-7HPzs0sg6xbVWFAJaZLhpw@mail.gmail.com>
 <86jyyecyzh.fsf@kernel.org>
 <CA+CK2bDxnTEe9Ohq5zLuyF-jqgD0DPhfdq6z=yztUsXU5p5fSQ@mail.gmail.com>
 <863452cwns.fsf@kernel.org>
 <CA+CK2bCjJWZG_rPoPsHWSxirmUCTOuFQzTCss2AKf9UqpThrdw@mail.gmail.com>
 <864ip99f1a.fsf@kernel.org>
 <CA+CK2bDDEZ5a+LJNDVMtKFtQ1D9rP6rJqU064eoru=a9eHpaAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDDEZ5a+LJNDVMtKFtQ1D9rP6rJqU064eoru=a9eHpaAQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251230_081608_577050_992413A2 
X-CRM114-Status: GOOD (  14.94  )
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

On Tue, Dec 30, 2025 at 11:05:05AM -0500, Pasha Tatashin wrote:
> On Mon, Dec 29, 2025 at 4:03 PM Pratyush Yadav <pratyush@kernel.org> wrote:
> >
> > The magic is purely sanity checking. It is not used to decide anything
> > other than to make sure this is actually a KHO page. I don't intend to
> > change that. My point is, if we make sure the KHO pages are properly
> > initialized during MM init, then restoring can actually be a very cheap
> > operation, where you only do the sanity checking. You can even put the
> > magic check behind CONFIG_KEXEC_HANDOVER_DEBUG if you want, but I think
> > it is useful enough to keep in production systems too.
> 
> It is part of a critical hotpath during blackout, should really be
> behind CONFIG_KEXEC_HANDOVER_DEBUG

Do you have the numbers? ;-)

-- 
Sincerely yours,
Mike.

