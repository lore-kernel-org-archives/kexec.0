Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E373DD2F02C
	for <kexec@archiver.kernel.org>; Tue, 27 Jan 2026 13:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iOKXG9Ip0SkC/9AL3ADC9BHQKfkdAPIL06Iyiewce+M=; b=rebX45V7638IUTxc2epw/8zEu8
	0XC0jOr75wtU3h3O2q32S1O34S31hrFco3Cv5K6pL8qFgcVmowl78Mp8nVgnELEtVY9DH9jgfBado
	IlhB4DfZJonD/So4ydxOOXDomcjQ12N+jMZYYeGvto7qxaDL3Oeryt65WsPb+HKRZ3LfTlZZbGrHW
	O8EcOFxKJ3Uw/Qa9ZAK/UwQaeLJVWtBzcyt84IQb4xaA0w/mtX66BZi2dYu0aYhd2ke6Tpp8snXa0
	woJQxaHNe3cr9+ZU/i6wkOQ84emqXp0h0qxnWIlCjz5Mq4dUIVUmDXWgWMUKE6csJlQj1yrKiAoYp
	vOpuV2mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkjKG-0000000EKJ9-3HMk;
	Tue, 27 Jan 2026 13:41:49 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkjK9-0000000EKHe-1ejP
	for kexec@lists.infradead.org;
	Tue, 27 Jan 2026 13:41:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iOKXG9Ip0SkC/9AL3ADC9BHQKfkdAPIL06Iyiewce+M=; b=XPV+iVx+ZIFtWaKrh6b6E4xDHB
	ZJyuVmOr0YljMY9/gmubl4zzEWzrCOkf8F+BEdjmncQKD24E6FWFbwJ3MSBEKe+gGAKKTjDHlGJ9u
	xWOSGU9lvjzX70n6bdidltR2U8VfJ6yfRNn0L0Wz4Ou82e5GmRhAnYnfpfBgXv4P5PrZBWWKKfp7p
	dvwtZtq1Hzwh8JSPjQWhAyC71zm7NIzojalrDW2hRDKRGMoBaBTeNOKYGYwKwoE8wky/Y8Z9ZAg1Q
	wPoV4ywJIEECerFpq3c4F17aazK0/1KL+zJJ6lxtd9sO44MWfnRdWDhO0lHVvJXHB5hyFmimjLn5g
	p6ozUb9Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkjJv-00H1lR-9u; Tue, 27 Jan 2026 13:41:27 +0000
Date: Tue, 27 Jan 2026 05:41:22 -0800
From: Breno Leitao <leitao@debian.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, riel@surriel.com, 
	SeongJae Park <sj@kernel.org>, kernel-team@meta.com
Subject: Re: [PATCH v5 2/4] kho: rename fdt parameter to blob in
 kho_add/remove_subtree()
Message-ID: <aXi_ppb4P1QFSqR7@gmail.com>
References: <20260126-kho-v5-0-7cd0f69ab204@debian.org>
 <20260126-kho-v5-2-7cd0f69ab204@debian.org>
 <aXhovDdoLqcmSWVW@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXhovDdoLqcmSWVW@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_054141_440219_8BCC1CB4 
X-CRM114-Status: UNSURE (   9.07  )
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

Helo Mike,

On Tue, Jan 27, 2026 at 09:26:52AM +0200, Mike Rapoport wrote:
> On Mon, Jan 26, 2026 at 08:07:24AM -0800, Breno Leitao wrote:
> > Since kho_add_subtree() now accepts arbitrary data blobs (not just
> > FDTs), rename the parameter from 'fdt' to 'blob' to better reflect
> > its purpose. Apply the same rename to kho_remove_subtree() for
> > consistency.
>  
> So if we are doing renames, let's take care of kho_debugfs_fdt_*() as well.

Sure. I am happy to do it. I will update the functions name as well,
basically s/fdt/blob in the function defition. 

Something like:

	kho_debugfs_blob_add(struct kho_debugfs *dbg, const char *name,
			const void *blob, size_t size, bool root)

	void kho_debugfs_blob_remove(struct kho_debugfs *dbg, void *blob);

Thanks for the review,
--breno

