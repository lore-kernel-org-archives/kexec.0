Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B6ECE8D5F
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 17:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jI5hPOPLIoKkXUKVIROmgZN8YwXJuNfqNLlBqLlPxr8=; b=exZlP437bZDecVxX3OLlrwX9z4
	jqGn4HBU1VCLCSD+BOkLA5Ih9u8Jkh6wwxkvGhfmu8hXOKB4aMSii3AUBMeF/DS9YmHwYf5zCnfst
	dvnpTlaFxhtC+v27wgOGOC/lW9Zc3DQUABcO/ve04Pj4SlzqCVc1gvJ1QBNSW1n/Yi3xvTmO544lQ
	Id28H1GTn1/rWLFBH0UtDIGbCmk7zxf62M6tbLjCZrHv/dge6w8+lpZnK1cdy9NcicNTQzn2+JJc4
	3cQyLd6mrHxqVJLjQFNB0YRdS2EIhZrFaZ5568s5v7dVFdFcWNdRQsfIN62HjUGAP2FsP1ooROO54
	dr7W6w3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxac-0000000CqVc-1sX4;
	Fri, 14 Nov 2025 17:28:02 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxab-0000000CqVH-3P7j
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 17:28:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C367B601E4;
	Fri, 14 Nov 2025 17:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87609C4CEF1;
	Fri, 14 Nov 2025 17:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763141280;
	bh=ulTWAOAR8z9do9SIRmHIYkiPa4c1m881M13St87xoQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dn0ywYFX7u1pMRmBB6mt3qOI+RoqX+gUyW3hryzuEn23rmHGfuVLx34qn3gdb7I7H
	 sN+fIgiXgJzEL+gSz1mj0HFq7lITtHxpI+gru7gqIffawp8FYnhfrNEFVhx0Lin4wB
	 eSbKoeJGcCs3KiiT0WR18L/2xpurvlBBH4UL6IYLGIpdUXqSFN+zw75W6qftHLAM58
	 O7XfUeBAQ5Twwq1DGqjDqssc8MacW9QvEKVbhiEvGXv2Mg8tAAG8XFsl0RJzOuDNMm
	 sNEbe+OBiF4o72N5YbKBfYVEXjLYJK+UCR3yqYg4wmcVJCChemVNnocLYFm0BKFqha
	 GbFfyXYii0QeA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  bhe@redhat.com,  rppt@kernel.org,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v1 09/13] kho: Update FDT dynamically for subtree
 addition/removal
In-Reply-To: <20251114155358.2884014-10-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 14 Nov 2025 10:53:54 -0500")
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
	<20251114155358.2884014-10-pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 18:27:57 +0100
Message-ID: <mafs08qg87cde.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Nov 14 2025, Pasha Tatashin wrote:

> Currently, sub-FDTs were tracked in a list (kho_out.sub_fdts) and the
> final FDT is constructed entirely from scratch during kho_finalize().
>
> We can maintain the FDT dynamically:
> 1. Initialize a valid, empty FDT in kho_init().
> 2. Use fdt_add_subnode and fdt_setprop in kho_add_subtree to
>    update the FDT immediately when a subsystem registers.
> 3. Use fdt_del_node in kho_remove_subtree to remove entries.
>
> This removes the need for the intermediate sub_fdts list and the
> reconstruction logic in kho_finalize(). kho_finalize() now
> only needs to trigger memory map serialization.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

