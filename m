Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC71CD8C88
	for <kexec@archiver.kernel.org>; Sun,  7 Jun 2026 05:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b7TWqZpXo9m0twdnETZaCSpwwDJItYnjhbOEas7Kni4=; b=tpkBDghWYcXT3v4DSDgBP89xlW
	lkghFzWC+Rz/VDqqXHWvV50zMk0Epn6cMKuIQkMW/UfoCAnShtzt7kHs+iEfnwMhVWIIMlAtjR26E
	VXbtykxttU17NquxuHoKDsSt7wjnO06dfTMYuc0pZ4ooODPfDTAGdxn4oGPk2ARuqWXty2L+WStzh
	HRaSVqsklrKIcqpXyC+clfsuEnHr0we9lrRp4IOSm589a7eFyO74mVGDgX605RAGNWB4Es5twoAwi
	IWzwk4YMMEoPsppmi7MwOM+5Jz7Z7FLa+I44DCD00uRgUX3YnjKsH2Zh2D2BJk4T1DtgLVP+PEPXF
	3rNybO9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wW6Fl-000000022dE-3RA1;
	Sun, 07 Jun 2026 05:40:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wW6Fk-000000022d6-1Sik
	for kexec@lists.infradead.org;
	Sun, 07 Jun 2026 05:40:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BABB943E78;
	Sun,  7 Jun 2026 05:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F5D1F00893;
	Sun,  7 Jun 2026 05:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780810855;
	bh=b7TWqZpXo9m0twdnETZaCSpwwDJItYnjhbOEas7Kni4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OH0fXT4aexoxL3cc0AMzNVuAHnv6cvmkPt20x0NyrjUPQLqk1L+BAVTJ+XfN+0gkP
	 OMfb8ALvfRO53XRZKW1gb2RHvwJSs4TpHDH3aD3eiIHlHyhmP/L0RpKxwUG+v4mjOa
	 jBiVUXsoYKVwZ4m8SA7wIIVPtFiXuszclruaUm+RHQGlWtS8gYsBuGws5Tn9kokFg/
	 fPbtUGHWsI83SxsbpnlKOCzhKDSzYyO8Lmat+pT96B7XebVYgAWIkDOdA18++vPBFQ
	 xvFFWZTbKT7t5rXBxz/qwQzsLim5nWZ69nDWqV7nnKpUnoTE6D6M3mhxLZJ843BEf6
	 z0ppglrgK5LeA==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org
In-Reply-To: <20260605160645.3650271-1-pratyush@kernel.org>
References: <20260605160645.3650271-1-pratyush@kernel.org>
Subject: Re: [PATCH] docs: memfd_preservation: fix rendering of ABI
 documentation
Message-Id: <178081082228.1643309.7441148315833852918.b4-ty@b4>
Date: Sun, 07 Jun 2026 08:40:22 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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

On Fri, 05 Jun 2026 18:06:44 +0200, Pratyush Yadav wrote:
> docs: memfd_preservation: fix rendering of ABI documentation

Applied to next branch of liveupdate/linux.git tree, thanks!

[1/1] docs: memfd_preservation: fix rendering of ABI documentation
      commit: 3a358c78093f98a70d84c934b7054f636bc846f2

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: next

--
Sincerely yours,
Mike.



