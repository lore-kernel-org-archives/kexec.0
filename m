Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB355CD98C5
	for <kexec@archiver.kernel.org>; Sun, 14 Jun 2026 12:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GWSdtbQlJqxP48YULvGZFlse5tTUXxbf+XtbPMjiKPY=; b=LPuta4TOvE73/KOpV6id8/rLtv
	fOR4o12vuqY5kQrjigYNGKQHcrc4yZpBnfP9eX8RlBaYUqdOfiwFbFaIzp+U93pvnPNRoHYdLWssL
	89YHq3+QDEKbgkhRDM/hehyujHRq7mQfJ9FI+p1LNITa+/neTA0gCnPsYdt126jHnIqwHaIE8YRm/
	KeTc0g3gupsPMP56gP1+MyHBrkootM/Blufzl/l4WTEYOl0VNmioJLYLEWZEUea9EpgVMiWEJIGsT
	VgBW0a6geM8huFwIp3ITz8zQ065NploKAE1jqusmLu/ndg9ftbPCqJuOAs7mCmTTDI3oKDUf//KeW
	BxokhbAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYjY0-0000000CwnU-3PrW;
	Sun, 14 Jun 2026 12:02:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYjY0-0000000CwnA-19Qo
	for kexec@lists.infradead.org;
	Sun, 14 Jun 2026 12:02:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 63AD06008A;
	Sun, 14 Jun 2026 12:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190C31F000E9;
	Sun, 14 Jun 2026 12:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781438559;
	bh=GWSdtbQlJqxP48YULvGZFlse5tTUXxbf+XtbPMjiKPY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=RgRL+DHG+pbx6FyKuwK64FgghxEPzcl5tUxL5BTUMlsHB0LchxHi1fxfSVJrW2SHH
	 GYZR02kBSzZjr5QDD9fIwz3Wi9RVXgytCPB3HF7t1+AC5aNRVRBMT8KxB/OuXo0eFK
	 /xmAhTC9vpOFf55oqpl5NLhtIQH01A1L+3FnGLzh2LfEA+m3s9fRLXNYSe8v1fG8Xz
	 wypsOwAUwy9fbfkWrbJfgKrwkQN7mQbWXavpSt5w0WfxgQGDq51Ggn6B3C1rvhtifW
	 Y/4m0rlF6IiJQNas4nmS+diqEc8H2xF6oCdqnPzxELGmYhE2Z6pf1anaHBR2GYyQj7
	 iB1cccqHPfdbA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 00/18] kho: make boot time huge page allocation work
 nicely with KHO
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
 Jork Loeser <jloeser@linux.microsoft.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260605183501.3884950-1-pratyush@kernel.org>
References: <20260605183501.3884950-1-pratyush@kernel.org>
Date: Sun, 14 Jun 2026 15:02:31 +0300
Message-Id: <178143855109.2123877.12981752740377469952.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Fri, 05 Jun 2026 20:34:33 +0200, Pratyush Yadav <pratyush@kernel.org> wrote:

Hi,

> [...]
> allocated from scratch, they will fail to be preserved with the upcoming
> hugetlb preservation series [0].
> 
> Fix this by introducing the concept of extended scratch areas. They are
> areas that the kernel discovers on boot by walking the radix tree and
> finding free memory ranges. See patch 10 for more details.

Overlall LGTM.

I have some small comments here and there for now as I din't get into
all the details yet.

-- 
Sincerely yours,
Mike.


