Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC795CD4F4A
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 17:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d6iS5tqwOBllSkfooBf+2B/3ZUTiZ4Auk6sQyCW23RY=; b=qkqb8L80TkNWOhXSriCaQTPnlu
	50QAw/IX60htnNPrHQc576rxXxqF9rABiyn8VpHPqrm2f0CyjQ6iHYw7YcOVHqgYnGFxEyc3p9uIg
	qotsbkBuq/KMj2vqmCZ46jnqLCLt65rjvHVT+dP2Veym+T4sNORKq37eZrGWPumGjX4QfqD8R72af
	C2iEBjW3wxaYxrxpaK/eu91/QduzTnxtK7ISAL6ETAzueyrd/3L2XEYIjlEy2AlFdUvPPIwcb+GMd
	y/hAGATERXokGtpptxz94dxp59Zs6hUUBrswb843JZ9nX/93ZNsSEn08pPpaJnWazFwzs0tox4RFa
	VJb7F5Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfG7-0000000D6kr-3QHW;
	Sun, 17 May 2026 17:26:35 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfG6-0000000D6kY-1JiX
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 17:26:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BFF7B6020F;
	Sun, 17 May 2026 17:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C912EC2BCB8;
	Sun, 17 May 2026 17:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779038793;
	bh=lGKadVHrKNT6CmfLVM9JxMsWPtA5cHWet/JGmKOuSG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V14Teuym/BTICjj06GX/CguKshYW0qhHPZ8mASyUXBhZ+kn/vrv8I9k7og2EsFjsU
	 oE56s0i4z9OjB0cy8uThGQwgfkpB8ck5evKRR1NwuP6oCDKmGxm9MM/DzljbJ5zi9o
	 4UJS9phIW/XSrkxAuFw9j9UnM+VcfDmcZOoQRdjxkc78eqflUyH5ygIUEWcCbq1O7x
	 LcG+eiRefLnbIaAVe4zZbPwxZ11CeNCojW2ILF5inBqaGqRutMrwzY30q2kyIIefI0
	 QCM6/NHPVCxf09NczrpQ9fFai4sB6zOPdIjTI8eed5oo38NauriLcUSfhV7rdKv3fI
	 NQhO6ltep+iLA==
Date: Sun, 17 May 2026 20:26:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net, dmatlack@google.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com
Subject: Re: [PATCH v2 04/10] liveupdate: add support for linked-block
 serialization
Message-ID: <agn6QeIamoeMkesv@kernel.org>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
 <20260514222628.931312-5-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514222628.931312-5-pasha.tatashin@soleen.com>
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

On Thu, May 14, 2026 at 10:26:22PM +0000, Pasha Tatashin wrote:
> Introduce a linked-block serialization mechanism for LUO state.
> 
> Previously, LUO used contiguous memory blocks for serializing sessions
> and files, which imposed limits on the total number of items that could
> be preserved across a live update.
> 
> This commit adds the infrastructure for a more flexible, block-based
> approach where serialized data is stored in a chain of linked blocks.
> This is a preparatory step to allow an unlimited number of
> luo_sessions and luo_files to be preserved.

Shouldn't it be a part of KHO?
 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  Documentation/core-api/liveupdate.rst |   8 +
>  include/linux/kho/abi/luo.h           |  22 ++
>  kernel/liveupdate/Makefile            |   1 +
>  kernel/liveupdate/luo_block.c         | 388 ++++++++++++++++++++++++++
>  kernel/liveupdate/luo_internal.h      |  57 ++++
>  5 files changed, 476 insertions(+)
>  create mode 100644 kernel/liveupdate/luo_block.c

-- 
Sincerely yours,
Mike.

