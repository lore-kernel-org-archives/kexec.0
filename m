Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0373CD4F3C
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 08:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EzecQ/QtGQEZ+qAdbwHm4mGPkwFh5J2GZbUW/RYc0Zs=; b=uLZ8EzkPgl5SNNYLK2Sgugr+D7
	cOlH894JEBJyBySxMGXUHYT2f3+o67WyJ0Xt8fVFsQog5z24fOXCvVk8n8dJPZZ5XN3sxOrd7zu8k
	26WdX+1p4Hya1l8X3ANCoZXXAiXn4s3Sk23Tn/JRBPbbAzYZ2Ic8VZKPSmXWJ5cjSuW8dx4+kR6dm
	IKnGQe6AXMDCWq+GC82S9RzBknTO1heehYDNTlugatjCgxb8AG1x+ZdURGvfBYKZSlifrlRSFnHBt
	zVhftuuaUw0NjCq6fAqw0Ra3dgQLhcFkXpp88UQFup7mox26CPGoJKByzcUlbQo0pThJUph2kCckZ
	v2A9igLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOtYt-0000000ErGP-35xj;
	Mon, 18 May 2026 08:42:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOtYr-0000000ErFJ-2uo8
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 08:42:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3677C41B34;
	Mon, 18 May 2026 08:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE998C2BCB7;
	Mon, 18 May 2026 08:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779093773;
	bh=fQxsP+H0CzMYiOI3uSoD/bFd1+14yuRg5hrwwnxCVN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoowVBopGP5vQQOFbG9DFBtnSU99i/HmpuEsNa5KNHAPlt6VthSIfafE4pvXx1pPf
	 ngyzpKRiEFB/uDE9ICip4KCDHzmIBpJS6Yy9bWOSTkX6zkj/fU4eXQ6HNasRu3dTAz
	 G6S5Q4FkoUTZYqQK1AWgZhxwl0/ZmwLZTVWgp9VgT4/D7Gs5y+GpUdiK8Hmbabo6Um
	 egxV7FZGBNfWA2JFuKJ3HlHLcw08jA+7aDHq95Kc9jhZGxd/kYIyVqpDCgdwtbXg8X
	 d1tttE9wGIESJ1P3WBpkdTl4CWHA46LaCCQCYMVqh74r8L6iuSYVhcviOgOUTeWTys
	 VYqdMXYg2UPNA==
Date: Mon, 18 May 2026 11:42:44 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: sourabhjain@linux.ibm.com, jbouron@amazon.com,
	akpm@linux-foundation.org, bhe@redhat.com,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	liaoyuanhong@vivo.com, rafael.j.wysocki@intel.com, piliu@redhat.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com, mario.limonciello@amd.com
Subject: Re: [PATCH v4 0/5] liveupdate: serialization safety and race fixes
Message-ID: <agrRBAY6cvQgDmIb@kernel.org>
References: <20260517192650.1019314-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517192650.1019314-1-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_014253_755359_9483B3D6 
X-CRM114-Status: GOOD (  11.07  )
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

On Sun, May 17, 2026 at 07:26:45PM +0000, Pasha Tatashin wrote:
> This series addresses several issues related to the synchronization
> between the reboot process and LUO session management.
> 
> Tree: git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git Branch:
> luo-reboot-sync/v4
> 
> Pasha Tatashin (5):
>   liveupdate: skip serialization for context-preserving kexec
>   liveupdate: fix TOCTOU race in luo_session_retrieve()
>   liveupdate: block session mutations during reboot
>   liveupdate: fix u-a-f in luo_file_unpreserve_files() and
>     luo_file_finish()
>   liveupdate: Remove unused ser field from struct luo_session

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

for the series, with a small comment in patch 3/5

>  kernel/kexec_core.c              |  8 ++++---
>  kernel/liveupdate/luo_file.c     |  5 +++--
>  kernel/liveupdate/luo_internal.h |  2 --
>  kernel/liveupdate/luo_session.c  | 38 ++++++++++++++++++++++++--------
>  4 files changed, 37 insertions(+), 16 deletions(-)
> 
> 
> base-commit: b1378127003b61930ce30064328640503ad3ef6d
> -- 
> 2.53.0

-- 
Sincerely yours,
Mike.

