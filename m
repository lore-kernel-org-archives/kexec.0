Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBBEC5B56A
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 14:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G8qxlsQGfocAVe55+yk0uJ2BiMt4CEd3bRCiLyYXCik=; b=CCFhGXoyLSss2eRcEHgyBMRA1m
	lheuV419G4mgk52c5DMewoizeTu5uqRoqnCtuHMbp20yVKy1WY765pu2gTuA+bOzY7GOIZukNMaKi
	LyuqyOCqnzX8VB95VqCqFJNi10t5ddoyo6vkjzUGK6a4xYioJ9hmn7oPpTTxhDSzLsgCNJGTbhqx3
	5QRRhq1ahOHSjQ309jk+5USJZTz1RbL3Yrr7joPqcNnxoZ6mOdhwRRPcvSoIo34VQXOtRZ3vzY3oT
	oZ0ZGKB0kNsguXonSPcROKL2cvk5deU90+5o7ttsta3cA9dAFMB4f2dv3PuUgmraBsAg3sLV+iBym
	abZUWXlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtRTE-0000000C874-2KYa;
	Mon, 10 Aug 2026 14:59:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtRTD-0000000C86e-1i4n
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 14:59:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E91E5408D4;
	Mon, 10 Aug 2026 14:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813AD1F00A3D;
	Mon, 10 Aug 2026 14:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786373958;
	bh=G8qxlsQGfocAVe55+yk0uJ2BiMt4CEd3bRCiLyYXCik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ed1az6VBryFOclUxePVQXHfbm8EkIKq0m531FGOOi35ufllzQL/hX7jG+ggcsnPNw
	 odnCpPptXhxfAUXYiDM4bJFRdmPtWX11Mx8NacoRw8aXN8wdedn0ckdcGF2KtBmKTp
	 rHNDR/ragt/P4AYm7YyNELZpN+Rp5s0uzsCPTTIAu66x52FeueOZr4vFSqIA6F4liV
	 JM5B9JhtCf88sJ8xHqB6Bxy5Bydi4NvKwbXcl1RY3NkPXzHemZ/2VIWN9YkBntSF0K
	 UvjXhV6zx9S5wL983zDyho3eMrwObwWVV2f96xXQ4GLfK5DXYcgAGVDqQg1uunv+Pr
	 HMjsJxhIympJQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id EC9F9198003A;
	Mon, 10 Aug 2026 10:59:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 10 Aug 2026 10:59:16 -0400
X-ME-Sender: <xms:QOd5atYziGy39K7iVg7BCTVaua7d8AREYBaHEMok9aa5uxmrqWnNGQ>
    <xme:QOd5ameZrEHNIyi6C31akh0OVg0TlBVRKJdXOtUYtKogdk2FPR7ivo1wiH23rWkgp
    XmrT1wrss15EKFhAMnGxxxDTSk7H0RKYHd5aZcvLcbCjNluv8h7q1aD>
X-ME-Received: <xmr:QOd5auHgGD5dXs669OKKu1Qgx6Q7b-GiPslvqPmRUw2g8EH4SwWfXQZ69nQ>
X-ME-Proxy-Cause: dmFkZTGLf/eoBsdkF5Bcv4i7XrYQoeSrK3kmL+XPu4kKdoH/000048y7ntGF27Bp8G86zJ
    61kFC93E0uHN1m8C0YxhAmgbvmZVRocMALRmYBeYMPOD1xgiHiinUgvyLh7d2AZ3Q5s93r
    URRyzhEjgZoCXP1+mEzRrrpgm2DtGIp1ZL6f0s1WZK8X5TYxrP+S3AkjBJcT0aQ3IgR0Td
    v/a4rW/kNt1q5C5wgy8OTpNWoHkcat9Qw++32800rNwaVCTlroIiVyydmZ+ZpUQ5KpFVZM
    KYCDYortVruTL+CpAbfIFB8R5NjDJ6U0KzbTk0B8VAgarQtGQqfjLQ8kqllbd+yTpVdseo
    KvpPzjwxGlsZW60IR2yM418qTAMpqFhNEg/tuy0Dn+XmEbRVMP6/+ZB3GuFfVvW++PbibM
    JOUkAnt18GAyHFmdEHjN2lMD6Frxz+kRwWuXhvFxrl9CqKYyCR4ca7LWvx9FVxRKr7IHgW
    vIPE90fcOUe6BQregpLdSkGMmHGRgUjR88QTSHZDZFw20ggV8Fmfh+K1iLvH6K5M06z5ZI
    Z/fHFkQMgVLtogPE8JyJS6geTi+w3zxwFP5YePeB3O/9wKpEyWWs8uIUIICrvEBMy8q2vC
    rMM/uDBA7WXR73QDimpl3mnzuLIexgWC5n96u/rOTsu0LryWZR++4rBxDdqw
X-ME-Proxy: <xmx:QOd5agla4-MDqvktXTsAEWhrqY_VgPi_52oV5X1zd5ipPgLWqrh-WQ>
    <xmx:QOd5alPJD7RWjEuZFR7z_kfin96XP3adnltkq_i3s4vklayBbMZj9g>
    <xmx:QOd5arFMQT--skaKz3KhiejvoDye-RZ4a_8JReHVFimEOD58Y1kDFw>
    <xmx:QOd5ahs_Ie_63ACJvelrLQRHe6L2f-seRoNTPaxxI40dSRZknG82JA>
    <xmx:QOd5amSf4FW-maIeeMu6GEMZR4IKIGHhWcKc06xqfJdYxvrqknRkq0lg>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 10:59:10 -0400 (EDT)
Date: Mon, 10 Aug 2026 15:59:00 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, 
	kernel-team@meta.com
Subject: Re: [PATCH v5] kexec: keep the next kernel off hardware-poisoned
 pages
Message-ID: <annnExUim_y99PrO@thinkstation>
References: <20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org>
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

On Mon, Aug 10, 2026 at 06:32:04AM -0700, Breno Leitao wrote:
> Memory failures (such as unrecoverable ECCs errors) are getting more and
> more common. The kernel knows how to handle it while running, marking it
> as poisoned (and SIGBUS user tasks).
> 
> Poisoned memory is removed from the buddy allocator, but, not from
> other places. A current problem is that kexec will load new kernel
> on top of a bad/poisoned memory, which is undesirable.
> 
> If the next kernel's image, initrd or purgatory lands on poisoned frame,
> the relocation copy writes to the bad memory and the machine checks
> during the kexec.
> 
> Skip hardware-poisoned frames when placing segments: check them in the
> kexec_file hole finder so it lays the next kernel down on good memory,
> and reject a poisoned destination in sanity_check_segment_list() for
> the kexec_load path, which cannot relocate.
> 
> The two hole finders walk in opposite directions, so each asks for the
> end of the poison it has to clear: the top-down walk for the first
> poisoned page in the window, the bottom-up walk for the last. A poisoned
> hugetlb folio counts in full, as hugetlb keeps the flag on the folio and
> the poisoned subpages on its raw hwpoison list.
> 
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

