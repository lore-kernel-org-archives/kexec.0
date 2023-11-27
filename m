Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AF6C4167B
	for <kexec@archiver.kernel.org>; Mon, 27 Nov 2023 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ySZnaxEeBCYLQpqmYgafaN3/yhiOmkAW8pNeM1DWfoQ=; b=zxtSGvfLdoypPB
	W6iCEJ5fDP7aEIzlW5u3+fN4i3CrU28f/XeFlGlNbSDNkZa6DtTW+AEj6oYy2iPtOjHTznY372eSO
	BbWqsnoEy4CTj0ZRCq9x0ImpJ45SEDfzgsYVpLXENrhdLul6AV6bGrtQ4xdowqPhfV8cZafJ6qUco
	lvvUwIHqFKO2yDhekdcxiOn1J+16qqwSa4mjgETU98wWOQgptVVrzK1Dnpf9gNM9bNXiObDz2W8a/
	C4w/6nSQmqPT/iHVT02htuS4jrXaBptYpWAkJqPAEgPvjGtuZEgJvHUPtp9fj8cICNnUzjx4cRBhv
	sGEujPLrYskR6fV0TwJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7biw-002aN3-1J;
	Mon, 27 Nov 2023 13:32:30 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7biq-002aMC-0K
	for kexec@lists.infradead.org;
	Mon, 27 Nov 2023 13:32:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id B28C4B82910;
	Mon, 27 Nov 2023 13:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68078C433C9;
	Mon, 27 Nov 2023 13:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701091941;
	bh=utB4E3wsYoCqGsLXaFQ6DZBCsGGvOtsIIljB5lzz0oA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MO/Ye4DPODdgGgfWfIbnUYo0L9MHlBP4uRsNQUEUfr6ovjk8JUWQ/itBIN24LU0hW
	 +Gmzg4vOzECHem3ss4SsR1rPP2RhBFX5Cv7FExww5krDq1ppTmk4rL4wHt3EMJXvMB
	 nJwhDMjLCQEV37r0WGtM36R5G78Dyb/eCVeQ6VM8D6XAwcLB/cHgj4Lp2VsiXLUVcl
	 qPHdC8Fty3Z5UOcSqMflmrYmBpqmrOcDtK+4LrLNHRHRjOCnNb4VU4v9/d82IA447f
	 LZXG1lJDAzvGEGlhfs2LAgRF2IgLGuyNPIIiN9ttZyTB0/C5xNnrA2OoyPURzo/ce4
	 GHAdW5x5mW2hw==
Date: Mon, 27 Nov 2023 13:32:18 +0000
From: Simon Horman <horms@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH] kexec_file: add kexec_file flag to support debug printing
Message-ID: <20231127133218.GA3354982@kernel.org>
References: <20231114152030.240945-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231114152030.240945-1-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_053224_291778_CB3CFDE8 
X-CRM114-Status: GOOD (  10.34  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Nov 14, 2023 at 11:20:30PM +0800, Baoquan He wrote:
> This add KEXEC_FILE_DEBUG to kexec_file_flags so that it can be passed
> to kernel when '-d' is added with kexec_file_load interface. With that
> flag enabled, kernel can enable the debugging message printing.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Thanks,

this looks fine to me.
But perhaps the corresponding Kernel patch should land first?
Let me know what you think.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
