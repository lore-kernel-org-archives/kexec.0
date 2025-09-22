Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0AECAC5A8
	for <kexec@archiver.kernel.org>; Mon, 22 Sep 2025 13:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+iYBD8SMIk9k/4TXRQEY/8FtrovpCG2qHec/AObdXDc=; b=dEy57/fVKmg+GmecStMDGS4SOA
	vv9FZJeprsjfVXqDQsv8sJ2tsAhXZXSRmDbqL/gBwz9MK7XEPNWgYI9XPoLIHG0ogE2LjOu/t4yDO
	PcQTI+Ifv89rP01fhcZQxm7Ekq/j7TLQfpyDW0hxZqt/bekB/GqW42BKCJUNdWec8VF0WmdX18qDj
	cyG7OEH3dCo+DA+lBLnuCJipOmp6WouN1WL4Bey218lTuVjs4dMC8sXCy51Ex8g1+2I9+qMfC3BkS
	DG3SIjUlFedd/5rLmmVW9DzFnEi7K9TDe3Wr7I5S2TNP17U3aBzkgpFneD8oi5iSNpKWQsmR3QHN6
	4FY79Vhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0gwO-0000000AZpa-3sTu;
	Mon, 22 Sep 2025 13:50:52 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0gwM-0000000AZpF-0Ikm
	for kexec@lists.infradead.org;
	Mon, 22 Sep 2025 13:50:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C4E9343816;
	Mon, 22 Sep 2025 13:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75E3C4CEF0;
	Mon, 22 Sep 2025 13:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758549049;
	bh=d8t+hPlDB0nO1VCV/5JqDtENUCr2tcakVRrmCSOG4Ac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kHXRzKknA3A9aDX+Xz4lbLB90q+PBv33eJfoQmsaLhGOv1tahF6UtQxvL4LPgamsz
	 t5rltBbjHiXOXBaIQ8GXVHEFuNa4IUu6hHP55+CClRyl9Jw9qBab7s+lj2ZLSzSwE0
	 2nVOz1InhfwHxtwZShWt9xa36LxkWLfKVBmhuogVea0VBtzaEoSCScVdh9pM8AOqlz
	 YDAPPY3zBoEUwLTXr7Vzl0RDcIzG0jf3tcO8mz+pWJ8x4ZFRN5eEfZk2Meog34jjTm
	 0hgRJoKPS0hhuNJDPgtvie5eQX1nGMYKMFqk0ZG0V091QLWQPTYjmQDB9nrEPj3vx8
	 U8HP7CeoJb1NA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc allocations
In-Reply-To: <20250921054458.4043761-4-rppt@kernel.org>
References: <20250921054458.4043761-1-rppt@kernel.org>
	<20250921054458.4043761-4-rppt@kernel.org>
Date: Mon, 22 Sep 2025 15:50:46 +0200
Message-ID: <mafs0tt0ufvex.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_065050_127619_74D843AE 
X-CRM114-Status: UNSURE (   9.25  )
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

On Sun, Sep 21 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> A vmalloc allocation is preserved using binary structure similar to
> global KHO memory tracker. It's a linked list of pages where each page
> is an array of physical address of pages in vmalloc area.
>
> kho_preserve_vmalloc() hands out the physical address of the head page
> to the caller. This address is used as the argument to
> kho_vmalloc_restore() to restore the mapping in the vmalloc address
> space and populate it with the preserved pages.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

For the new kho_restore_pages() as well:

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Thanks for working on this series!

[...]

-- 
Regards,
Pratyush Yadav

