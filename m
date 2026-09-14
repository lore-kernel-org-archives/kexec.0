Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C161EC982D8
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6YNBDNqtv3G7fIIrCWxRo+R7rFxECIiWXZYEw0TsCm8=; b=AQ57xP8jVvhReZPL3AtwrsLw6S
	TediL/QkV5qYepQUwKY7hAuRIMg5626YaFyoyZ2bidLMyJDXRgy9STm0aEInIZugKrff74j+2XrlM
	gZCTW59UqjM24yeBpOuocfshD4h8XEwlFnfhfeq/2rkmufDD7BthyyL8N6wZFIFbZvr45+SAcrByu
	hj5gLRlcFWwLjca3tflU+TOdiNTe7sdsp4P3J8xyNUOsnQ3bPsh52yCFRqTIT9/gy4VkY9cA1yQpV
	FCqnaHN8pp66XHe2fTHVPtvkLah26nq9BWorqbY3EGeXxF5WKaHtU/a9jD6ayqWcqk+kQkucRg6Ko
	x5pPVV3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4L-00000000MEu-1krV;
	Sun, 20 Sep 2026 20:23:25 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x68eQ-00000004AVJ-2KqA;
	Mon, 14 Sep 2026 15:31:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2734740124;
	Mon, 14 Sep 2026 15:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D7F1F00893;
	Mon, 14 Sep 2026 15:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789399882;
	bh=6YNBDNqtv3G7fIIrCWxRo+R7rFxECIiWXZYEw0TsCm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oafm7V4RKsPy/Q1nCVBWDqYf7CzIKQWwzaAUfYXO4K5blgVLNKT30EOhNjyiJ68b4
	 EmE0pg7kCS+rsBO2hQhqAcC1jDNgaAjoHfS35HWN3j5jboLSqfna8lVYkkpRTOVBLm
	 z7XrVJIhN7zqa0ZqIGC7moq0IJyRMgoMb82ImK4Ze2REEcVBWDrF/nBND+suW7cTj+
	 wRFmHT2zlonTyo+1brM1i34j0QTrbmA5FknqN7kXJ9bimmAF15wqhMttnovE1K17hY
	 mCHO/L8QQoVL9DoTMRTdTxGNm4LGmdWMH05qUrovm9ES8pb0mcHRy3YO183W8YwGVi
	 tCv3P8ki+lNgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B213924A79;
	Mon, 14 Sep 2026 15:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 00/14] Remove PG_private by using
 page/folio->private checks instead
From: patchwork-bot+f2fs@kernel.org
Message-Id: <178939981687.647967.15609695091265022344.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 15:30:16 +0000
References: <20260907-remove-pg_private-v3-0-6ae22f9d9272@nvidia.com>
In-Reply-To: <20260907-remove-pg_private-v3-0-6ae22f9d9272@nvidia.com>
To: Zi Yan <ziy@nvidia.com>
Cc: david@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
 muchun.song@linux.dev, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 baolin.wang@linux.alibaba.com, nico.pache@linux.dev, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 usama.arif@linux.dev, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, hannes@cmpxchg.org, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, kasong@tencent.com, mark.rutland@arm.com,
 irogers@google.com, jack@suse.cz, linux-doc@vger.kernel.org,
 amarkuze@redhat.com, peterz@infradead.org, kexec@lists.infradead.org,
 dave.hansen@linux.intel.com, ruirui.yang@linux.dev, adrian.hunter@intel.com,
 linux-mm@kvack.org, hongbohbli@tencent.com, hpa@zytor.com,
 guochunhai@vivo.com, skhan@linuxfoundation.org, ceph-devel@vger.kernel.org,
 baoquan.he@linux.dev, matthew.brost@intel.com, anna@kernel.org,
 sstabellini@kernel.org, zbestahu@gmail.com, rakie.kim@sk.com,
 minchan@kernel.org, richard@nod.at, x86@kernel.org, ebiggers@kernel.org,
 alexander.shishkin@linux.intel.com, mingo@redhat.com, slava@dubeyko.com,
 weixugc@google.com, yukuai@fygo.io, xen-devel@lists.xenproject.org,
 xiang@kernel.org, magiclinan@didiglobal.com, mhiramat@kernel.org,
 joshua.hahnjy@gmail.com, xiao@kernel.org, byungchul@sk.com,
 james.clark@linaro.org, acme@kernel.org, linux-raid@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, bp@alien8.de, rostedt@goodmis.org,
 linux-mtd@lists.infradead.org, axelrasmussen@google.com,
 jefflexu@linux.alibaba.com, namhyung@kernel.org, jaegeuk@kernel.org,
 yuanchu@google.com, idryomov@gmail.com, osalvador@suse.de, jgross@suse.com,
 pratyush@kernel.org, linux-nfs@vger.kernel.org, tytso@mit.edu,
 oleksandr_tyshchenko@epam.com, song@kernel.org, corbet@lwn.net,
 pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-perf-users@vger.kernel.org,
 senozhatsky@chromium.org, tglx@kernel.org, jolsa@kernel.org,
 linux-fsdevel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 trondmy@kernel.org
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:19 -0700
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

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 07 Sep 2026 22:56:07 -0400 you wrote:
> Hi all,
> 
> This patchset removes PG_private to make space for upcoming PG_folio
> (reserved as __PG_folio) for identifying pages from a folio (more details
> in Note below). Instead of checking PG_private, all code is changed to
> check page/folio->private != NULL instead.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,06/14] f2fs: stop using PG_private
    https://git.kernel.org/jaegeuk/f2fs/c/60105162524e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



