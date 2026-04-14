Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BF2F9D0D2
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 14:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4AqPy0AMwjqvqg+exYoaCnTjV/qg8szmXavLM1Vzh9U=; b=5EM2HryfcUSANpBOeuM+DTZrvv
	odQXVfdgwQfVTbg1Xsaxbt1uGTXqcAMnbh8p2d8eFX8ygz/CHritxU5PFQvI6vYNRShkjxzkuSPVa
	OwiRU1qykmSacthfJEBUmkasK0moIVmD53EmIXCLbhjGcvUET9LLBuPHJeI+8JY9fsxneFNmTd2Uc
	87wuJ5kJM/fcOuQ9IPVOFHEHS/lrPEwMCuf4/SUd/fOBMfpGfRg9fEvX8h6o2RYJ+pR53dGozYald
	3Z0gUf6mPLhikfTk+wN8X7jJ38MVkXtZSR+MmCIqzD5+ylV371dtnxb3KdAUpXxYgvW0MvZ6ft2gu
	wUSutBgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCeLw-0000000HPz0-0zrD;
	Tue, 14 Apr 2026 14:02:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCeLs-0000000HPyu-3JmH
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 14:02:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EB6E260018;
	Tue, 14 Apr 2026 14:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C38C2BCB0;
	Tue, 14 Apr 2026 14:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776175371;
	bh=x7XJtLqXh17ZcImOlaVLyo5LTdL3i1fbBepv/qg5ZPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMGh5aJ9U11ND7fOu9C/bNwMLWIVbpAAaBVR/PGX4KZH7Fta8xBVgm9YdoX7tW+AH
	 Smw23T2oFCr6Pk/Ad1UGEdyCfJKCbmJOba+z7+onL+UJzEvsZ1YeQe3KOn6J8cl1gv
	 nGYMXhtpHtG06H000JrCqAvF55rTzyOZCwwyeUzIUnDrnfuG4s+p8Wd2XOzUMKuPWs
	 TiTmdGrikAJd58xtG99dwzYxNH0FHBPVTHMS7BKclCHeSl3lS+i6K/VH9rwloDbi8R
	 0I0GrIkHf2RQTohrjoPmULxhO4xT26PXX7syMEQMd5X7ohRx4/zVFjDha96OtAq6X4
	 JH9ahcyxcN3lA==
Date: Tue, 14 Apr 2026 17:02:45 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] MAINTAINERS: update KHO and LIVE UPDATE entries
Message-ID: <ad5JBQ-hxej1FNl3@kernel.org>
References: <20260414121752.1912847-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414121752.1912847-1-pratyush@kernel.org>
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

On Tue, Apr 14, 2026 at 12:17:17PM +0000, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> Hi,
> 
> This series contains some updates for the Kexec Handover (KHO) and Live
> update entries. Patch 1 updates the maintainers list and adds the
> liveupdate tree. Patches 2 and 3 clean up stale files in the list.
> 
> Regards,
> Pratyush Yadav
> 
> Pratyush Yadav (Google) (3):
>   MAINTAINERS: update KHO and LIVE UPDATE maintainers
>   MAINTAINERS: drop include/linux/kho/abi/ from KHO
>   MAINTAINERS: drop include/linux/liveupdate from LIVE UPDATE
> 
>  CREDITS     |  4 ++++
>  MAINTAINERS | 10 +++++-----
>  2 files changed, 9 insertions(+), 5 deletions(-)

For the series

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

