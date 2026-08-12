Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9C1C5B572
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 12:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ei39ELWB+Kc2pXETi/HNp7tTiIPtqt1tiDtMwuQJ9N8=; b=esp1qkX8aBFbLjcvBCsH5v15bP
	4x++okIBOqVV356LzbEq8/WcmoyQTYGoImLlXvja0qFyhCzUdiAA/YPgBbt0QF5Cel81bMnQXO/jR
	51fQWKM18Gvhu+bPBadJpCPZlIuEL1HExDfXV4GWhDrzbydOvSSVvsXxfq5qq5KM5i6hzZvxHpDVi
	6UTEJ83XqQOc33yA6jyYUNup5/H8rX19vgQ8/9WHsiN7TPZeXudq8OEzw7p3J5JrrTN81SXXmpIWt
	htiAzRov9Roliv4UNKArE+xGzKNaQiNGY9Yu3oLFnXJPktsRlnFYbry3r0sG/V/pNbb6ff++CXWFR
	K9q/yrdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu7kp-0000000G9g4-0Phj;
	Wed, 12 Aug 2026 12:08:19 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu7km-0000000G9fW-1aMB
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 12:08:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ei39ELWB+Kc2pXETi/HNp7tTiIPtqt1tiDtMwuQJ9N8=; b=jssfigmqnFP6RQjRsa95nGCxas
	STpZHA+b1aSnASOsdnq+4BF0SqVKtQekWaRPFD57vLFUqII0Bl9pp6l/xzit4V8StWxg7O+ojX3un
	SOWW/6/y2tNR714G1y/SuI0RPQ+sgzS93C3F0zUARseVO7wGYlI7sgkCIZ3qFHxCZ2kvLjw/4EWOC
	U9C1Mvy6R94Y1RRNGqKkCgJFN28nx7P06iuLC6JNzqalrL2eVO89EG/P/uyqIL06pVcGQtxt8QF7l
	DNEh5a8yUNyKOEnrh9zUQotJX7fup0S8DmFrM1/nQlowms9MWj79qR2YWZm+7odN2wttgQdKnsUw7
	vuS/sD2Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wu7kR-004KSI-0L;
	Wed, 12 Aug 2026 12:07:56 +0000
Date: Wed, 12 Aug 2026 05:07:49 -0700
From: Breno Leitao <leitao@debian.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, 
	kernel-team@meta.com, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v6 0/2] kexec: keep the next kernel off hardware-poisoned
 pages
Message-ID: <anxhWTKwMvkVHBPs@gmail.com>
References: <20260812-kexec_posioned-v6-0-e477887086f0@debian.org>
 <6D17A62B-3124-492F-9593-63F857DD475F@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6D17A62B-3124-492F-9593-63F857DD475F@grrlz.net>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_050816_459316_EB4FA99D 
X-CRM114-Status: UNSURE (   9.96  )
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

Hello Bradley,

On Wed, Aug 12, 2026 at 12:36:59PM +0100, Bradley Morgan wrote:
> On 12 August 2026 12:31:50 BST, Breno Leitao <leitao@debian.org> wrote:
> >Changes in v6:
> >- Split the pre-existing top-down underflow out into its own patch, and
> >  drop the "if (poison < kbuf->memsz)" guard from the hwpoison hunk now
> >  that the loop bail-out covers it. (Mike Rapoport, Sashiko)

<snip>

> >- Link to v5: https://patch.msgid.link/20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org
> 
> This is a two patch series with one patch, why?

This is a patch series with _two_ patches, isn't it?

	[PATCH v6 1/2] kexec_file: stop the top-down search before it underflows
	[PATCH v6 2/2] kexec: keep the next kernel off hardware-poisoned pages

If you asking why it was split, we decided to split the fix into
a separate patch, and keep the "feature" in separate patch. The
discussion happened in

https://lore.kernel.org/all/anskyrEVUlnTVEgF@kernel.org/

