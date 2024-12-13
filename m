Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1025BE7717D
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 12:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5/cUb9EXCmvkwk1YD2pVYN1OsHlQlRssug7uzeFSNpE=; b=SZLrzEwmD3Y2UhUwT3RZ55bthn
	EDe73DeVSUCeG1vW51DfUNW+QncyRbnz89UfoAj+ZSLXtQ+ghEefhS0qyvHM4Cab9rANN2NaYGupC
	Pj08Vz8nlkpUFZvAu91YgNy/Xip+hD+oY29eetiDhRkiwZHfCwFnxYkCcE+wLW6O5lK2oR2Yi+V4W
	oexI09ILAKNk+GfIwR/1fzBRfvP8QuhJlsr6DCzBlSuctwjxoTJubH+d5L+DzYVKIqQ8boBcZsxAl
	dZ5j3glMzbYJDFOanHNmrTeGUquaz+EURx8ru8QQ9A5iw6mpBWts4ich/YuSN9xKC5zFxrj5UqRwP
	lnl866HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM514-00000003kYi-2xt0;
	Fri, 13 Dec 2024 12:43:34 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM511-00000003kXl-3xQN
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 12:43:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1C8AF5C68FD;
	Fri, 13 Dec 2024 12:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6232BC4CED0;
	Fri, 13 Dec 2024 12:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734093811;
	bh=0ccmnE6bPUuW0SpqbzF+rXta7c6B+RofMABWCBlIgwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MClqXLdxHKlxqPJ4wekisXpvdk/9n6YFl0wtrnUM/aO3ss+8OekJ1zKQYaBy5Gmaq
	 XovLUt/6VafDFvsZ5HKTq0hQNG5XqZ4Q8tToZ9fX03VVcQdL0wKagsK4vvkEQFMiBq
	 wANe1hoo04Lt1Lclgd7y/mg1np748hFnbjQkrky0gmhs5l8bs7l2Fg2Roa7KbkbS4I
	 F2iJR+TygVbs85nyTmb6NA43WM5482E5Ebwq0btmN+sCLQN21uETcVBJ/qBoPrrQhk
	 2/6lkw4jqT/3V3vmB1TIKuiDj794mBv8zxJMxyMzWZJj+3TvfbpC4VR+lzdoKgOMac
	 gC2DWkVzgDWLw==
Date: Fri, 13 Dec 2024 12:43:28 +0000
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] PE: Extract get_pehdr_offset() for reuse
Message-ID: <20241213124328.GW2110@kernel.org>
References: <20241206024445.10442-1-piliu@redhat.com>
 <20241206024445.10442-2-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206024445.10442-2-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_044332_022768_A6A2978A 
X-CRM114-Status: UNSURE (   8.19  )
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

On Fri, Dec 06, 2024 at 10:44:42AM +0800, Pingfan Liu wrote:
> The get_pehdr_offset() function helps skip the DOS stub in a PE file to
> locate the start of the PE header. Since it can be used in multiple C
> files, it is being moved to a header file.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>

Thanks, applied.


