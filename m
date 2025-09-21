Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D403DCAC59A
	for <kexec@archiver.kernel.org>; Sun, 21 Sep 2025 06:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eWcdAfkQu2Hk5PJzJfAjIeCbBCxsmDLxl1sT6vKhzQc=; b=aDpyUtLRM/F2YsyIJKD85IuA8L
	7KFqcbY4i16I3miYJkIudPfGhJ0ULt6LJVPawLlLF/OCxKTRhHPoCVI5PJ5DKS25aeLKUi7Nz+o6x
	twfvbNZebmzuXUnMZin+3d+HYv52CzKQKZAXMVh+pdhQKSM1rCPCMC/bsJ5fuqBjmtHfA+ES7QhV1
	TgAjub6FZJW1J+GvxQrx9L9nTrLWayzx+Hd6aiPgKqKfQP+WGozK7NjmfsvAhAuF0HMRp806RTKgO
	KPIKZvM2/MKcD69XhdvKDoaUom0IQSfsLdjHLnq7L4HlyKlARN7DxJo36nWW4Je9iFOBWZnH1craj
	ZMnbFfPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0DUl-00000006nbq-4Bio;
	Sun, 21 Sep 2025 06:24:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0DUj-00000006nb1-0tA0
	for kexec@lists.infradead.org;
	Sun, 21 Sep 2025 06:24:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4DE87446A9;
	Sun, 21 Sep 2025 06:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E26C4CEE7;
	Sun, 21 Sep 2025 06:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758435860;
	bh=7ncQyYZxpGQpoWZu4O4eeQ31bFZfa7Ff2+7sYzrfMf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mG5uWx77WE0EGnCrHbQasMsoBXvZLyPyefnHDo/kv1dErYEdI1ixpuJRy2SCwFJt8
	 lVCSDFtq2gEKcqR29ZP6JNVPZQobSCkg/IsOC4p/3Dgp6QvRkYbxJOtEqBxvkwxKsg
	 10gPrepuN9n3PonQTVtPdEmWnCGXSJxgx/6QAM9OQW7H/lFS1bG1wQ2xWQbcAfH1Ki
	 HU4G5KYrRpareJGa4IVC5HrYOZr13dvUQj0Br2epvj/QlOUPAltIoDZfvuotLTFxz2
	 9LLBuQKO+rYqzfoQBXQ5m3NcTW+TsUdsGScsXteM/3JKOYFOWJJDdDtIuILWqBPyq5
	 PSMCpgFOK7XZg==
Date: Sun, 21 Sep 2025 09:24:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jan Engelhardt <ej@inai.de>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com, Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <aM-aDAIbKqBMN2DQ@kernel.org>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <3ns36rp5-rp37-1nns-9q43-op05or6s26nq@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ns36rp5-rp37-1nns-9q43-op05or6s26nq@vanv.qr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250920_232421_275684_601902A4 
X-CRM114-Status: GOOD (  15.09  )
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

On Sun, Sep 21, 2025 at 07:54:31AM +0200, Jan Engelhardt wrote:
> 
> On Friday 2025-09-19 00:25, Cong Wang wrote:
> 
> >This patch series introduces multikernel architecture support, enabling
> >multiple independent kernel instances to coexist and communicate on a
> >single physical machine.
> >
> >Each kernel instance can run on dedicated CPU
> >cores while sharing the underlying hardware resources.
> 
> I initially read it in such a way that that kernels run without
> supervisor, and thus necessarily cooperatively, on a system.
> 
> But then I looked at
> <https://multikernel.io/assets/images/comparison-architecture-diagrams.svg>,

The diagram also oversimplifies containers, with system containers the "OS"
runs inside the container and only the kernel is shared.

It's interesting to hear how the multikernel approach compare to system
containers as well.

> saw that there is a kernel on top of a kernel, to which my reactive
> thought was: "well, that has been done before", e.g. User Mode Linux.
> While UML does not technically talk to hardware directly, continuing
> the thought "what's stopping a willing developer from giving /dev/mem
> to the subordinate kernel".
> 
> On second thought, a hypervisor is just some kind of "miniature
> kernel" too (if generalizing very hard).
> 

-- 
Sincerely yours,
Mike.

