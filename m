Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F65FF8867
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 13:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hMc1htv/+iSCwUs5ewV46Q9E6Q/PUmSCkxy1WR/TJIw=; b=V7EE4G8Xi0B07N9R7MnHJYP6ji
	VIOJ2P0esIAASfLYq2rjdpWJze4lsX8DwU0slCu3aJxqU7DE9dzcI9rqM549dgUMJVrSpFnvaEaNU
	+O4w/EtmtHP55RN/qidHNGhQiUpvGOSRYtLfN03uGINvtPrux+4nmIOAnUChG0bMLWr9vfcshp/Gv
	weQfXINl3GCsWROEC2br4EmzQVwpHjlvZdz+t7FikIe/5MlbFulmY0MaVs1kAXj7V56MdUmGgedMc
	is346gZJP7HH/mzUPZLMxhk+uWtjOrv/QUbD3HdmFINMmWyCRrqQjY5kSLGhgjQbgCvjxu+JGln2x
	B7uChPDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI4Xs-00000003czB-040r;
	Wed, 29 Apr 2026 13:01:40 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI4Xq-00000003cz5-47Sm
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 13:01:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 35BD160018;
	Wed, 29 Apr 2026 13:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813DBC19425;
	Wed, 29 Apr 2026 13:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777467697;
	bh=2hL1FcBsKicUDBx48TcVwLl6yzTzP1tGOOTzGBuKZv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MhruX3iOC3MTWKw8Wwd8ENgtAevDREXt0AknYf8NnYkDDFSRiLoBOPmv3I6Sfl2eY
	 EooqxhVrwxiao+uZ7lShtVsA5XSf3GFFz6tTksUqhYl/ZnGPKIpa6DfSHZ/P6WJdNW
	 LnzPzlQ0bvPuerGlwmReelHWT1gekXOqZbGy5XGvRYyDYmXum6NoSB8BsYMVTWfFqR
	 FDUxcA+e3LQNrZWZR+M6uS5qfwIo8RxPLhvgeyMo6LF/JBXmTanScdFkTuFVHvPwpG
	 vVCqA7507sBg/txgsgT5DT/UtI4r5vYg/PRuI68MTj1sNrLIVR80Sb2eGxpBitbP9M
	 78ImhGOtZBPSw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Baoquan He
 <baoquan.he@linux.dev>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Dave Young
 <ruirui.yang@linux.dev>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] MAINTAINERS: update KEXEC, KDUMP and LIVE UPDATE
In-Reply-To: <20260428124833.1903302-1-rppt@kernel.org> (Mike Rapoport's
	message of "Tue, 28 Apr 2026 15:48:31 +0300")
References: <20260428124833.1903302-1-rppt@kernel.org>
Date: Wed, 29 Apr 2026 15:01:34 +0200
Message-ID: <2vxzik99539t.fsf@kernel.org>
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

On Tue, Apr 28 2026, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Hi,
>
> KHO and LiveUpdate team is going to pick kdump and kexec patches to
> their tree at
>     
> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
>
> Update MAINTAINERS to reflect this change and add kexec@ list to LIVE
> UPDATE entry.

Acked-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

