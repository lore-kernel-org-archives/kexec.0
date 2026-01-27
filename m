Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DDBD25958
	for <kexec@archiver.kernel.org>; Tue, 27 Jan 2026 07:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qiY1VeY0GK0N/+CKEldnf2FHtmBlJfiHQKXOI0VOBdc=; b=DoK+ldgW/YLpU2ezmAGr5kaz+Y
	xFykc7n20+v/xHgz1P4A6W63cAKruv8DJ1nVn7ahTJKxsxpfZJ4a0wAJfrEqhHdMHDr4jUQMaVhja
	VSgoortCai04SY88XxkeZByaysZZRdosoaefBfUC2oSiFOlSktb4qCOiU8ZA+exd1j0dJsTJyfQvW
	IEkivBCo+u3NfRwmhFArjW1q39o95S9Id/6ARzJpZfsd/r+CWHqj3gThg2NqvNAlfjkbgEWA4QadJ
	GWZ1DMblhJu0mfpeVijmcYSaBLKKMx5NKfr+NhtwdPuNHaX+QgnSBLAVt+Bcf52iTOcImEdGQ8Am4
	+pbsB+UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkdTb-0000000DmNa-2qlH;
	Tue, 27 Jan 2026 07:27:03 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkdTa-0000000DmNT-2m55
	for kexec@lists.infradead.org;
	Tue, 27 Jan 2026 07:27:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C917D60097;
	Tue, 27 Jan 2026 07:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D68C116C6;
	Tue, 27 Jan 2026 07:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769498821;
	bh=2kiaOIVcsIwszKKFeZ5JCkrNsk0h0wj5t3pR7iEwX9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PWxtpAUFbQ76pTxzVPToj3w6NaJQsjdU+tedyUYSp+TFzVS5UtTRClnMJTMbLNI4z
	 LzDhiUZ6iwf+i1bC+4GcDsPKxfMhvUaRE7bFd81vD2Uviw1ds1eLmG/vrmL8RARMSZ
	 0NdCbbmYJsrqa6p6ttvdmXfP0DGRROpqsJJ85qq/pO0Hshvcxqxyff2n6QfNsCt6OF
	 O4ff/mNm1uBOzexHIhE3ZJNqLJhLzNAAb6S/8WlGbbmzVKqhfk8ban3FuJY/TrqeYy
	 8gKxXOXCA8UYnFvPPR0Z82zhNiFS6EsWTQyd7VOYQb8DFx91Lvdv1t8QjFBlwPsWyG
	 yCMWqhnsZ9gcA==
Date: Tue, 27 Jan 2026 09:26:52 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com,
	riel@surriel.com, SeongJae Park <sj@kernel.org>,
	kernel-team@meta.com
Subject: Re: [PATCH v5 2/4] kho: rename fdt parameter to blob in
 kho_add/remove_subtree()
Message-ID: <aXhovDdoLqcmSWVW@kernel.org>
References: <20260126-kho-v5-0-7cd0f69ab204@debian.org>
 <20260126-kho-v5-2-7cd0f69ab204@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-kho-v5-2-7cd0f69ab204@debian.org>
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

On Mon, Jan 26, 2026 at 08:07:24AM -0800, Breno Leitao wrote:
> Since kho_add_subtree() now accepts arbitrary data blobs (not just
> FDTs), rename the parameter from 'fdt' to 'blob' to better reflect
> its purpose. Apply the same rename to kho_remove_subtree() for
> consistency.
 
So if we are doing renames, let's take care of kho_debugfs_fdt_*() as well.

> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/kexec_handover.h     |  8 ++++----
>  kernel/liveupdate/kexec_handover.c | 18 +++++++++---------
>  2 files changed, 13 insertions(+), 13 deletions(-)

-- 
Sincerely yours,
Mike.

