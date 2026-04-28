Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8356EFF885D
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 13:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rwJsUZuQEfnbiJ4PSO8F5D48hRBd/OtXtSTea26CRzs=; b=joPxPHBxfo4at93idIFnjZS/n9
	F0SyhGGHoy8kAekoCz6wixkUJm5OGAuaWeJnUIAcy5imr4IHxHmFMjQoD+QdbqibOCSHllFAS+gMU
	H9kvN1b63eTL8+vKfg1j6+OHWSBebY3BgHZzxWUf1wxUpo9XqI1zNlVdw+GYBrHni6mGrpJozpXdZ
	D6y0RFviZevEWOOU/TBIcEV7TBr+aEQU8ziXgfsXiMGQ/sCD1DXHRhtwNEzuBHEHFs1qVRmQuzwCQ
	JfeCjK3/EnwoGaFDeuZmhUm2Wmb4SuNeWUXVAo7Q+8qIjdQmiE8c308w3OHwFhK4Ptc57pLvSKTsr
	RVwSf9zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHiK6-00000001WJm-43cv;
	Tue, 28 Apr 2026 13:17:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHiK6-00000001WJV-2AtO
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 13:17:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DB76261119;
	Tue, 28 Apr 2026 13:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81192C2BCB7;
	Tue, 28 Apr 2026 13:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777382277;
	bh=qwf4EHuzt7QWo92n3l8Ao6eD0JUFXLkqW3rvrM+bLGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Et14bSABh5ySZ8yuOioeRNFH3wAvM5Kvw4tCL62WlhkTS/OGXQSYwmJ5Dq9ZEt7ac
	 R5trj+BIGdBpT6kSCAcM1DARqqqW83QhKKP42LwLdDKhoL8/TwDBHTOkqmRQA9Z2BL
	 K1pjj7avUcYiukEhDtTE0w19t46q1z4hEZHlE99KMNqMnTpgyF+MkkVdUsGwY+abNe
	 mUNQbM2RTDMo1m0axSkV85w5UMaQ1uBC0TjbBcOGNqG6lHtY4vlzqreA40ZbiRurO0
	 tMnMnZPj+VZ7SEe8w7ekQakzPt14tC3Q46iCBbQzo6xFncdJCKl6BQUYvaLuIAqFf4
	 +LWduvCuZfokg==
From: Mike Rapoport <rppt@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Evangelos Petrongonas <epetron@amazon.de>
Cc: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	nh-open-source@amazon.com,
	Saravana Kannan <saravanak@kernel.org>
Subject: Re: [PATCH v2] kho: skip KHO for crash kernel
Date: Tue, 28 Apr 2026 16:17:31 +0300
Message-ID: <177738223126.1904167.3186811087427171016.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410011609.1103-1-epetron@amazon.de>
References: <20260410011609.1103-1-epetron@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Fri, 10 Apr 2026 01:16:05 +0000, Evangelos Petrongonas wrote:
> kho_fill_kimage() unconditionally populates the kimage with KHO
> metadata for every kexec image type. When the image is a crash kernel,
> this can be problematic as the crash kernel can run in a small reserved
> region and the KHO scratch areas can sit outside it.
> The crash kernel then faults during kho_memory_init() when it
> tries phys_to_virt() on the KHO FDT address:
> 
> [...]

Applied to fixes branch of liveupdate/linux.git tree, thanks!

[1/1] kho: skip KHO for crash kernel
      commit: a6715d7ec472a476db17787697a4abda62962284

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: fixes

--
Sincerely yours,
Mike.


