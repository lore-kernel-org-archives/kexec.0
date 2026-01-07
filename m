Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3946DCD5829
	for <kexec@archiver.kernel.org>; Wed,  7 Jan 2026 10:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iu97QiSq3ywxpCKSUp2nAd+CATJG7zJQBoHGp1JnF/o=; b=VwA4l532zrCXgZiHJSEpiJmQLK
	cShOxQNV5cidR7Y9km2SfD3A86sr+pKCJXoKG3lasnVk5hViko9SCutuSxSjhWCoxhxxZCd2tZ5fI
	urM42fi+xybpL+SdQfnWO7jm6Gf9a1XY+aVKftKW0yFQRt8/DJbNFjTIO4aOkVibfeKNe94ot7VFh
	446wLZkHMEfdWbtpxI+/0whBq8ynEnu0+4c4jdphkxNr2shYvNZgssR/VzaZWsOUkBULMBjyJOlYi
	YEdJs1dcRLUsLcJjYLV7L844Kn34fwjU9Y339f/WKg3mQ0ClSrBHKYebGjfwbodABXtsUZiUJfiZU
	ZKHbghuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdQPv-0000000Ee0E-2PDl;
	Wed, 07 Jan 2026 10:05:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdQPn-0000000EdyY-3b4F
	for kexec@lists.infradead.org;
	Wed, 07 Jan 2026 10:05:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 76AA6418AD;
	Wed,  7 Jan 2026 10:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09118C4CEF7;
	Wed,  7 Jan 2026 10:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767780318;
	bh=6b0Ia4FBMtdG/AVptJiOoygDqWfM74AUH10sV2SFuBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdYAnRH85O6gLzZy0zTYi4YShlSfdLMpLTdb46LuuNIU5TtN/SRGIccbCW+Ua6B44
	 QPVCE9xS2DyUniq/VxcP0bA5RvJTafU/iIoFzPk68pxPpZkVVYD7VKVFjKLJnLwZ01
	 AhW2b7IP0F7xiCs0OsoOXLdNp55g1u68WNf7QDnTuf9+5T7ThLBZB6MMKkFG+SaUyG
	 8s1sPI5lWGc4jrhkfHBPeBWkI8acQXbY4J4L5TyKeMu5hawjtT7QOWEyQJPnMqGGtt
	 nW7G8XzNQoSMIA7Jmr5NCO2lyuXBsCKxkeOJBEW135kliJD69SG3y8CSDQCLIZxAOl
	 Vg88HMlZeMzAQ==
Date: Wed, 7 Jan 2026 12:05:11 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in MEMBLOCK AND MEMORY
 MANAGEMENT INITIALIZATION
Message-ID: <aV4v18hvu1OublI_@kernel.org>
References: <20260107090438.22901-1-lukas.bulwahn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107090438.22901-1-lukas.bulwahn@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_020519_922316_B8FBD2AB 
X-CRM114-Status: GOOD (  17.31  )
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

On Wed, Jan 07, 2026 at 10:04:38AM +0100, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit e8d87911a204 ("kho/abi: add memblock ABI header") removes the files

The commit sha will change because it's on an unstable branch

> in Documentation/core-api/kho/bindings/memblock/ and adds the corresponding
> content in include/linux/kho/abi/memblock.h, but misses to adjust the file
> entry in the MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION section of the
> MAINTAINERS file.
> 
> Adjust the file entry in accordance with the changes of the commit above.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b28650893f2b..1ec85c68dd4f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16454,7 +16454,7 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git for-next
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git fixes
>  F:	Documentation/core-api/boot-time-mm.rst
> -F:	Documentation/core-api/kho/bindings/memblock/*
> +F:	include/linux/kho/abi/memblock.h
>  F:	include/linux/memblock.h
>  F:	mm/bootmem_info.c
>  F:	mm/memblock.c
> -- 
> 2.52.0
> 

-- 
Sincerely yours,
Mike.

