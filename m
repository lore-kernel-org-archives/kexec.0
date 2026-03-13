Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4637105F784
	for <kexec@archiver.kernel.org>; Fri, 13 Mar 2026 09:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RJ5uTqUJ+QW1yUxvaliHmvxy05jN68XiBCO4RD+PoU8=; b=NIO9K3UO46QIB31EfXaBM9d6P0
	vekuqIBpQS/58z1W9cu5zwbXhig3HoEkCFatnE9CMc/qOrAAnjBlnebd9fv01XRs2IILdyYTlu2kO
	WnlY7L9wXYTjXEh4nMdrsy/vj7YIqT2x0L65yLAAiviW4Q1rmoT4Ji5w5q+CvQ+Ynj1izEX4LV9uY
	jClUP63iOaRLa031ioSfcIIhv6ahshBT3Fc5b6ubprhwPswH7aaIcVPQVy4ySvF+sQDHVKAoB7eHE
	dQiFtlDoyjJRJ4d4KPlFJF3aMoQysMur0DaVDkhJzKiEaes2h7EtdF0OI68v6CloRlr6drGRgVDDE
	8UFiFzRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0yuT-0000000HP1L-1oKE;
	Fri, 13 Mar 2026 09:34:21 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0yuS-0000000HP1D-26bY
	for kexec@lists.infradead.org;
	Fri, 13 Mar 2026 09:34:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EA2C76012B;
	Fri, 13 Mar 2026 09:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A62CC19421;
	Fri, 13 Mar 2026 09:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773394459;
	bh=v/rvjqqtoL58+wHyLrFv7Orx5p1Iqjy/QZxcEBCnMfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eKndTr+zLS0kx+l4EYxG79uG9nv3jRbABElRDZSfl3PzejboVWk4txr+URAEymiCE
	 oI8wPYfLSbwTnTBiWBTERSkqDS4/xYVrMx3PMsI1iL2FBrY4zaYOOsEiVmQYXyB4pf
	 Atrd7o9DmviyZdxVqWBWkfAzOFgfJan6xPI/q+GLeS6MQOCWfM71HguM4ikjk1Xlu5
	 IxcIL3Ew04pZ/aPp8lBl8Csjlq8S/NDzij9UYeuLJUKMIyBM9mHBUB2Kyziz/Pkmip
	 P5Fb3iWc5/jNJmCmg2FfY6WohAYufLClf11/B5WtkqvsD/ujgFcfIUEk36jI5O3pSf
	 FZoukOmskuQFw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  SeongJae Park <sj@kernel.org>,  kernel-team@meta.com
Subject: Re: [PATCH v8 6/6] kho: document kexec-metadata tracking feature
In-Reply-To: <20260309-kho-v8-6-c3abcf4ac750@debian.org> (Breno Leitao's
	message of "Mon, 09 Mar 2026 06:41:49 -0700")
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
	<20260309-kho-v8-6-c3abcf4ac750@debian.org>
Date: Fri, 13 Mar 2026 09:34:15 +0000
Message-ID: <2vxzy0jwf4yw.fsf@kernel.org>
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

On Mon, Mar 09 2026, Breno Leitao wrote:

> Add documentation for the kexec-metadata feature that tracks the
> previous kernel version and kexec boot count across kexec reboots.
> This helps diagnose bugs that only reproduce when kexecing from
> specific kernel versions.
>
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

