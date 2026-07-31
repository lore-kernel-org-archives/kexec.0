Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB21EC5516F
	for <kexec@archiver.kernel.org>; Fri, 31 Jul 2026 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qgKGyimHWHWrS7GKqRrXGIY74zPdoBJNUqsWVCUzh6o=; b=w030CulUZtCuKtwn3rF+UN9uQl
	hrIXeRVEwAOLQbLQBaCaKhFNomMZ7uc5NiRSkEXWkI2mm3+m78AZGVKxwRdZwolsu+HRnEcnQrl34
	lrOph3sv5B16EFVPmW6t7laLGOy9xhGgMXKfOKZcAhLJnfW23htp07KVWdn6naY1/yihqMda8M/rV
	w866ZGdMyv6369brcfKdTZV3SQLKWLQDDpl1eNOQzbBT08TQVQtoxgQt1TGtS8y5xS7o6QvfyGfUe
	V7q91aWvf8bfrfNq/RfFZUdiOyITzjIRq2B4SfOIBLZy0gtFIuL8pLFR5d/uvzPHCrm+3wCxy4Fce
	Pidlo5Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wprhn-0000000DKdQ-3Pun;
	Fri, 31 Jul 2026 18:11:35 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wprhk-0000000DKc8-04VH
	for kexec@lists.infradead.org;
	Fri, 31 Jul 2026 18:11:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=qgKGyimHWHWrS7GKqRrXGIY74zPdoBJNUqsWVCUzh6o=; b=NpNsu0N7Nk2pB2+SdDRWLmEnhq
	d3V0f55YufscXQEl5pXVlXrTfe6VEv5enoXClU+UvZLUheXpGmD0icDh6+RDW+6brJmY0ykZN491y
	A1xHIWBiR1s1YFIYbocN/mYdIbECKTcNF0K/c4B7iVtFc3dauPPx6tHdq6bXLAK6kA1TlIljgzzkK
	ok49T3dq8jmWghghVW4C7/rKanX1I8nIEW4Qtj5xQXKPOzthngAqG9SnnflegVRWO1cyR+3NKVDXd
	u5H1EXCl1XIlFPTevZbJOftj4jCor++oYXF+qJLTcNlVhI2a1hSQKp/sYypSR7HMx8S5fOEvdcA5U
	qVi2hIlA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wprhK-00AD5R-2f;
	Fri, 31 Jul 2026 18:11:07 +0000
Date: Fri, 31 Jul 2026 11:11:01 -0700
From: Breno Leitao <leitao@debian.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, kernel-team@meta.com, 
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v2] kexec: keep the next kernel off hardware-poisoned
 pages
Message-ID: <amzkmjkJtLyYnE-y@gmail.com>
References: <20260730-kexec_posioned-v2-1-f92d18551f64@debian.org>
 <2vxzecgj6od4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2vxzecgj6od4.fsf@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_111132_072438_AE5DA1D6 
X-CRM114-Status: UNSURE (   8.71  )
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

On Fri, Jul 31, 2026 at 07:49:27PM +0200, Pratyush Yadav wrote:
> > + * return phys_addr_t, thus this "extra" parameter, instead of returning
> > + * the hit.
> > + */
> > +bool range_contains_hwpoison(phys_addr_t start, unsigned long size,
> > +			     phys_addr_t *poison)
> 
> Perhaps
> 
>     phys_addr_t range_last_hwpoison(phys_addr_t start, unsigned long size)  ?
> 
> And if no poisoned page lands here then a default of 0 or ~0UL?

That was my initial preference, but hypothetically phys_addr_t 0 could be
a poisoned page.

I hadn't considered ~0UL as a sentinel — that should work and is a good
suggestion. let me prototype.

Thanks for the review.
--breno

