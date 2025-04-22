Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A7FC369D7
	for <kexec@archiver.kernel.org>; Tue, 22 Apr 2025 15:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AjBmk57CvuILBNnT2nxoWhyzSKjUh5YgKH0GIgP9Vk0=; b=qKT4B7I1nuxygT5zH6T5IugQLY
	75rT/buvSnXPQ8h0p8niPpICDjsIixWHHjkCn4mGmnl5vVp12xPLs3fbVep/Sy0xAXB5C24Y/WHRw
	rs0eMe7Lgv9jzlKM5RTRQUy9sgeHfYVLSjA1sZRzjiUYUtyOsnHTfqzyfLHtCs6iV5abUjPxPmR5f
	pMSgUx0/PwpqZR00AwnMtH755atg+wt6Vapt1RUhgrOZaGqSVaBVdGkhJdNCRhbfAOIIj+qbFRp7M
	tMojtyNZo/Fj63kJSrbc+9rqDrnHnPAB8vIQsY7BU8JMMoDn8KtBd8Vbn+F8f3nOoAwzbukBQWhga
	439jJS/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7FHp-00000007ebq-0ufk;
	Tue, 22 Apr 2025 15:11:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7E4h-00000007Ni1-06Ji;
	Tue, 22 Apr 2025 13:54:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 46F165C4988;
	Tue, 22 Apr 2025 13:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112D6C4CEE9;
	Tue, 22 Apr 2025 13:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745330050;
	bh=6Wzq1iekPqXgmnP7Gba156hgO+tNrROaqfH6jIM9C+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oHgFR2Z2QdQVkG89FDiYTSejqFFaZootQW1RLTlN4VTS9BT6mUz4xIEB+cE98i+oi
	 7Z1k1H85b+uCtX4fxh99lyZ6+OCosJHgM3Bu2VgoxxT6UwJJnVuve/a0LX4xG1OOe8
	 ApiHlU+IMBXLC+OA+WptKVc50ivzFAtMV/odKkrDVrrjnNflpzhnSE5UI5Obuz5rVt
	 tJyzYEisW+ZUB0GZpz3y5iuRUsQwOvlJn2yr7No/v2ymlz9pSstsc+mXQBWM+Gu74n
	 1kk6YPy+PNDA0e+R6DJOYvUWWv1XbjRynHTUvxi/NBh+8bZnV9dIC6CBNesZFRCHAz
	 SbtPPt7cEoKhQ==
Date: Tue, 22 Apr 2025 14:54:05 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Nick Kossifidis <mick@ics.forth.gr>,
	Song Shuai <songshuaishuai@tinylab.org>,
	Li Zhengyu <lizhengyu3@huawei.com>, kexec@lists.infradead.org,
	Dave Young <dyoung@redhat.com>, Yixun Lan <yixun.lan@gmail.com>,
	Xianting Tian <xianting.tian@linux.alibaba.com>,
	linux-riscv@lists.infradead.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH 1/4] RISC-V: Add support for riscv kexec/kdump on
 kexec-tools
Message-ID: <20250422135405.GA2948814@horms.kernel.org>
References: <20250409201428.648717-1-bjorn@kernel.org>
 <20250409201428.648717-2-bjorn@kernel.org>
 <20250422104825.GT2789685@horms.kernel.org>
 <87bjso5ri7.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjso5ri7.fsf@all.your.base.are.belong.to.us>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_065411_133709_621B1B1A 
X-CRM114-Status: GOOD (  14.45  )
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

On Tue, Apr 22, 2025 at 02:07:28PM +0200, Björn Töpel wrote:
> Simon!
> 
> Simon Horman <horms@kernel.org> writes:
> 
> > Thanks Björn,
> >
> > Overall I am happy with this patchset. But there are a few minor points
> > I'd like addressed, which relate strictly to build coverage and the CI.
> > I can handle these myself if you prefer.
> 
> It's really up to you! What do you prefer? I can spin a v2 if that's
> easier for you (and then I'll try to address all the things you pointed
> out below)!

Hi Björn,

A v2 would be perfect for me.

If you are so inclined and you push the patches to a Github repo
then the workflow should run. It is what picked up the minor problems
I've highlighted.

But in any case, let's stick to the email based workflow
for patch submissions (for now).

