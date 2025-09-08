Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44695CAC588
	for <kexec@archiver.kernel.org>; Mon,  8 Sep 2025 12:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nj/9PKodVE1YVERRmKb3nrlYWg0VbRWhzb/HqKXZFEk=; b=ho9Ljfbv/jOnywY/1JDZXqLaJ4
	WO467c0RlAW0VnAYC+UFQp3cf5+2kCygC32NhWJBfKgoVRIrBhluIVrzGmntqKvPkYtOz0w0RDlBz
	i7N0tT94L4xuIFVuFwuVsUcFWN1lyl3L5i1HRkt9hwQyduEFZukqalISkHjYBgfbuYTgYlEWA1bpe
	w+QDQ1Mc60J5uyAaaqTzuYM8kiUaOiHq6xFAzPbOhHhXe5MQke2PI8Y5GTWQAxUXJen+K7QmQNXJZ
	NPcTCPqFPyaddYAUkgxZPxSBfc/egLpbSXhgV4D9EUKIlwRG4XElI3TGOe+pw3oTsfOvWKJYu8BWm
	iZw15LwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvacQ-0000000GrXe-1Z1a;
	Mon, 08 Sep 2025 12:05:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvZDD-0000000GOUl-1ziF
	for kexec@lists.infradead.org;
	Mon, 08 Sep 2025 10:35:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B9386601BD;
	Mon,  8 Sep 2025 10:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7473C4CEF1;
	Mon,  8 Sep 2025 10:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757327702;
	bh=ezzayDxZ/eh5ilJqIeWgMDYws3Vth7AuzHHdrl/M/sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szeDtN1Hy2mboR7182GvWrEih1Lqvgrh7pESUmR/yxOa4iGH7GLgRDPaODJaaE42E
	 Q+mUqvDPSjsg56jvX+7rgJ1+wuPyUugI4QU/jpJZlt8NSRls1xYbHigLf8KA27pGV+
	 LiE1RsPffr5SnYhj3RJQ8MfSiAYdO3wvehZpTQO0AoNc+ro1RudQcLbP8Uiik3qY4D
	 UEl+ngboJUpZcyvGg3dJ9kw0qNnqJsNzQejNlMtzWf9q2PGHr/0aoS2I29IdueHFZe
	 MpfEcwSK+HrwPgxcHuYeJBngcROm/G86N0o3yCi9jpH9ZwG3tQ8HANOL+ZWT3ymxVt
	 cEb+lKQGlJtxg==
Date: Mon, 8 Sep 2025 13:34:56 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <aL6xUMlRFSYm41uS@kernel.org>
References: <20250907070022.2177974-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907070022.2177974-1-rppt@kernel.org>
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

Argh, I've messed up the posting :(
Sorry for the noise.

On Sun, Sep 07, 2025 at 10:00:17AM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Hi,
> 
> Following the discussion about preservation of memfd with LUO [1] these
> patches add support for preserving vmalloc allocations.
> 
> Any KHO uses case presumes that there's a data structure that lists
> physical addresses of preserved folios (and potentially some additional
> metadata). Allowing vmalloc preservations with KHO allows scalable
> preservation of such data structures.
> 
> For instance, instead of allocating array describing preserved folios in
> the fdt, memfd preservation can use vmalloc:
> 
>         preserved_folios = vmalloc_array(nr_folios, sizeof(*preserved_folios));
>         memfd_luo_preserve_folios(preserved_folios, folios, nr_folios);
>         kho_preserve_vmalloc(preserved_folios, &folios_info);
> 
> [1] https://lore.kernel.org/all/20250807014442.3829950-30-pasha.tatashin@soleen.com
> 
> v2 changes:
> * support preservation of vmalloc backed by large pages
> * add check for supported vmalloc flags and preserve the flags to be
>   able to identify incompatible preservations
> * don't use kho_preserve_phys()
> * add kernel-doc
> 
> v1: https://lore.kernel.org/all/20250903063018.3346652-1-rppt@kernel.org
> 
> Mike Rapoport (Microsoft) (2):
>   kho: add support for preserving vmalloc allocations
>   lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt
> 
>  include/linux/kexec_handover.h |  12 ++
>  kernel/kexec_handover.c        | 200 +++++++++++++++++++++++++++++++++
>  lib/test_kho.c                 |  30 +++--
>  3 files changed, 235 insertions(+), 7 deletions(-)
> 
> 
> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
> -- 
> 2.50.1
> 

-- 
Sincerely yours,
Mike.

