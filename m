Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9214D2D11B
	for <kexec@archiver.kernel.org>; Tue, 13 Jan 2026 14:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jSy7jBvC9nebYOjTwgO9FutvaOd0nj9PGpV6sjReCbI=; b=ge/RTJsX/MoTrdFAEg9g07G64w
	BwiJaBAxGzq5XTkJth8r5v348OoDOQ0gYdPYUUaWKsHHab8BRUvCefi4Tgh1ycvQv6VTtmw7gu3Su
	HAJCn3LKbh04OFxr1gPbgJctL6lsyPh4ihR/s6knnVNTuTA5g+ugf4m+w78Wf+6/PnIkI8TVJOSne
	DcgrCnC1UajNjnzFUXgNndrP4cJReRCu20lRhuGKn2cr7TlJ2lIIJa04tbofaOvrPsZG/xwqPZWUW
	H6LMlBfqOHn09vzW+ZGxbp7XNfidYjqBePDi49Za2qBvimNDSaZeo6oezUFsP+5sCHdQxDdF6w5ZX
	cvWmaR+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vffev-00000007HTr-3lly;
	Tue, 13 Jan 2026 14:46:13 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vffer-00000007HTS-3SAy
	for kexec@lists.infradead.org;
	Tue, 13 Jan 2026 14:46:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 211EE6001D;
	Tue, 13 Jan 2026 14:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77F2C116C6;
	Tue, 13 Jan 2026 14:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768315568;
	bh=4uCAucSurgWYYIfTPVGMA7hAEuKLq8ADMBBO1vAY/Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWF2snKTTWME68p5bqRoDMZp5nz+HXJ3bikIf6obk6LehQbfcBB89unOKo0echBdQ
	 FuaLneguObpC5wzEdpQ4rXKS7R+Ve5bjzkv3OLAU9ULW88251bOBr6hU6ADJ4kju8g
	 Ow6/uz65FMFNWthx0KS95LsdmFZZ89cakQFpXsZjmBoc6LAFAoBEQ9+wOqAOQ4UcHj
	 5J6wu98pb1caihXnGjUDkQ6+uXeDHWR1nEAKf56OwSj6TZZTGkxmse0ttEsihnjDqj
	 6MjG+RmsooY9V3L2ZPU8Fj55ZhiqPZ64NpuhkDFoZhEoO57LJvo6aI93ajbvqAI/OW
	 5jmKNED0nhbOw==
Date: Tue, 13 Jan 2026 16:46:01 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jason Miu <jasonmiu@google.com>, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 1/2] kho: Adopt radix tree for preserved memory
 tracking
Message-ID: <aWZaqcStRAK6VWLy@kernel.org>
References: <20260109001127.2596222-1-jasonmiu@google.com>
 <20260109001127.2596222-2-jasonmiu@google.com>
 <aWTJ2v9J-Aa6ykBf@kernel.org>
 <20260112143904.GA812923@nvidia.com>
 <aWYt0gBHxDCKqj9Q@kernel.org>
 <20260113130526.GE812923@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113130526.GE812923@nvidia.com>
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

On Tue, Jan 13, 2026 at 09:05:26AM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 13, 2026 at 01:34:42PM +0200, Mike Rapoport wrote:
> 
> > For example mshv intends to use kho_radix_tree to track the hypervisor
> > memory and there unpreserving will be a part of the normal flow.
> 
> I do not think this is a good idea.

Sorry I wasn't clear, mshv is not going to use KHO memory tracker but
another instance of kho_radix_tree data structure. 
I don't see a problem with that.
 
> Nothing should be touching KHO until a kexec sequence is started. KHO
> calls should WARN_ON prior to this point. If a kexec sequence aborts
> then the entire radix tree should be discarded and it should go back
> to WARN_ON'ing KHO calls.

The whole point of making KHO stateless was to decouple it from kexec
sequence and let userspace control when preservation happens and to allow
preserving as much as possible ahead of time to save cycles at
kexec-reboot.

> Jason

-- 
Sincerely yours,
Mike.

