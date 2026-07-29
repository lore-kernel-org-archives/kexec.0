Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E5AC53219
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 06:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=caqnS6e4kiY3oUkt/HJWfEnD/2y5AMUZ+1hzT/P5Cy4=; b=KE7udlWUoEW/feAcSb07j6ATsX
	z96QzO6MdbRnY7RgiaHFxL7jhOqsUjlS+eiDKD3wpHWiGKLhR0DHqAfzvsNkA9U0mrdWBKK+rNTR4
	GmsLuFzFQTRcZCK+qFSLRfY+7JcALcKJiDeeSZ9hxuf08Myd2gwr1zfYj/YWYBQAdQaPdDih3V0vv
	hplojVRN+oG5wDHmfo8rnUxWGxEbSGGWnq5XMwF4LotgTHS8K164sM4G6E4qDvf5bbHtliq6XDsNc
	YfQ3RwG6qKJu2onw2QDe7v2qwXJkbRStiZHigKp7LlZOqAs/NtmcMYrfFAf9KHIWenGG87/HcEn/g
	cjGaBpCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woy1J-000000073Q9-2bMz;
	Wed, 29 Jul 2026 06:44:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woy1F-000000073Q3-0BaX
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 06:43:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5AAAF43EA4;
	Wed, 29 Jul 2026 06:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF831F000E9;
	Wed, 29 Jul 2026 06:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785307436;
	bh=caqnS6e4kiY3oUkt/HJWfEnD/2y5AMUZ+1hzT/P5Cy4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dvlQRu25NfTiF+5Ce8PRfJhxILSry53XqUXJ6ZP8ClrUQfOGtUFRdtGBLfkVubWfk
	 J/M+UDqVFOPPyrh1Pz2wZTwRpK/UxiKeNMAjkLOE6v3Gxtc7hd4Xc0aHq+qrdJpJZx
	 bAUirRJO5TTbeiE1C4429EyLrJ+QDiVHtfmMV7d4LELX72McLgOFbgV8KIeoYTtDkf
	 me/XZz4oyu4OO4/07X6qzonX+rBQg8H38JOatio7+Id9QfeercNt/kYelqV+0YtAgO
	 rcEjucc6Kq7sdJ7FW1aTUx5ZS77Yyd7yZPlRzhZ8q3dit23oB0Pp3mu6JII93WZRNa
	 xw90Lr0iSJLEw==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260727150240.889555-1-pratyush@kernel.org>
References: <20260727150240.889555-1-pratyush@kernel.org>
Subject: Re: [PATCH] kho: fix size calculation in
 kho_preserved_memory_reserve()
Message-Id: <178530738771.1195472.13332239668735060040.b4-ty@b4>
Date: Wed, 29 Jul 2026 09:43:07 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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

On Mon, 27 Jul 2026 17:02:39 +0200, Pratyush Yadav wrote:
> kho: fix size calculation in kho_preserved_memory_reserve()

Applied to fixes branch of liveupdate/linux.git tree, thanks!

[1/1] kho: fix size calculation in kho_preserved_memory_reserve()
      commit: 3a0b8fa2eb36afc88b62a95f33f0c77c71fa5ded

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: fixes

--
Sincerely yours,
Mike.



