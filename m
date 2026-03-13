Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCBE105F783
	for <kexec@archiver.kernel.org>; Fri, 13 Mar 2026 09:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6BS5wCxsbt14XQH1hV1QT8cvWS9b+H4jerH3ozJzdek=; b=T3l4/Zdww21dbB3llJdDo/7YB0
	5KpU7Z4/WE7E3cNJfbHxRZXHeW9vLHmv+mEO4SfGLBVGpSNrF7akAnpyUbNuBKA0xDrgTDV8a2HjX
	inBkb+nFz9MG8bAqjlPkWT/8gTZ5jPg78ir5zFOweMBBfYCKO6sXIaNbMFXlSLwzp8K91GOTMwBSc
	k8NuEDa8H2VxbVKEriU6P1tjHEtLrgfMH3LiUfHxvud1fwenjK5jWOS3ID/mJgYuvZjTyMSxU0NWH
	VcuF46Ej/Zy2f03m1IStYLn1bg0XWUfXirLb5PIAYNRF9SfGbut+FM4XW2FAcmwcohqRlqBnLz1ge
	adFScwpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0ykD-0000000HNRx-0yo5;
	Fri, 13 Mar 2026 09:23:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0ykA-0000000HNRG-15Gs
	for kexec@lists.infradead.org;
	Fri, 13 Mar 2026 09:23:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8690C40C3E;
	Fri, 13 Mar 2026 09:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5B0C19424;
	Fri, 13 Mar 2026 09:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773393821;
	bh=sfucnBU6UEvHzvnIKr1NLtTw7aZJn+fBBWMo+TGZ9P4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iz5bb8xWvwi6aTIWIz/SOjOamX+g9mekNAGNj4x4HLLpeXleW/rcEC79ibN5lA3YK
	 VrD7yL2G7Xaa2p5qq8UFWEkqfswR1hrJEtVkB0FCcK9Dp3cBvBcSZSj4CfP+PxXkdf
	 Djdba4YoLsE4E9oTkOgxpjGgbnKptOZ8xtrTFnH5q4C3TAzyl6Jhdzx+vmFiWtyvkt
	 qqwd6rDZZjBq9kbrXPUOjSuILAekuryPOPukYdt6KBn2EAnmms/0Syzs+UMEK6QYDH
	 1tW1b2zfRJqED1pfZQ0m4VEHBEzkMb6qczPY3s/JYCGWgp6o/8q+tMykutUIFFZ7Bl
	 K57qsVt8Igoxw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  SeongJae Park <sj@kernel.org>,  kernel-team@meta.com
Subject: Re: [PATCH v8 4/6] kho: fix kho_in_debugfs_init() to handle non-FDT
 blobs
In-Reply-To: <20260309-kho-v8-4-c3abcf4ac750@debian.org> (Breno Leitao's
	message of "Mon, 09 Mar 2026 06:41:47 -0700")
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
	<20260309-kho-v8-4-c3abcf4ac750@debian.org>
Date: Fri, 13 Mar 2026 09:23:37 +0000
Message-ID: <2vxz7brggk12.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_022342_317610_A4F10701 
X-CRM114-Status: UNSURE (   7.87  )
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

On Mon, Mar 09 2026, Breno Leitao wrote:

> kho_in_debugfs_init() has two problems when displaying incoming
> sub-blobs in debugfs:
>
> 1. It uses the hardcoded property name "fdt" instead of
>    KHO_SUB_TREE_PROP_NAME ("preserved-data"), so it never finds
>    subtrees stored by the current kho_add_subtree().
>
> 2. It calls fdt_totalsize() to determine blob sizes, which assumes
>    all blobs are FDTs. This breaks for non-FDT blobs like struct
>    kho_kexec_metadata.
>
> Fix both issues by using KHO_SUB_TREE_PROP_NAME to find subtrees
> and reading the "blob-size" property from the FDT (persisted by
> kho_add_subtree()) instead of calling fdt_totalsize().
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

