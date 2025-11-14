Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36957CEACD2
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 21:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UBXXOlQKwmeJSlViwyJErz12T8X429cOy/TdEoXEVPQ=; b=qw6HMkTInpGhHeuF/7Na8Mz1iq
	Z0GUFcjDeT0aPmrSqckceSxgKRfR24PNAKbkIiRMDJpbIPnMDjY6UxP9h9fT6zI5eoazQkuvX2Hca
	rXNNuyV8DPbOZ+2av/skcfP/wStWZrhaAhmH81/vLE+EdDhBLkv0EceWGD+qj3bY+aLZAk5gqCEXb
	soLKzaRz4bqDcRaYw+00VQ8k0ELkfIyF41YJMCe8FLVu62zTkK5bLd0q9N6UynIU19m0mAPaswNYb
	cdMaX89s98lAakzMAjdtfGjpv2A2kbo97y1kscJXOh58P7dSIhFpeEtod3wwgDK280H9GnknSE2x8
	Ycaa1GDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK1ax-0000000D97q-0sdZ;
	Fri, 14 Nov 2025 21:44:39 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK1av-0000000D97h-0bHN
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 21:44:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9CAE46018A;
	Fri, 14 Nov 2025 21:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E502FC4CEF8;
	Fri, 14 Nov 2025 21:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763156675;
	bh=hK73J41Dd+DBh3tuhlQDYlfJ7L5o8Oi4Zj+jZvMUiPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xlFobeIACPcN+LYAKFBWmjBsPZuJHPUSqfwySMP4x989WaZElUpU11aQN0JnKlsOd
	 kkWIhb7p5PfFI8XYwV3R/g2EpgHdTilNmDxbgzztOPtfAL/t1dhXLXsgBaG5wMuj65
	 EHb5+SRwO0tGNbhROhr8ibNEvhYXF2x8iPg0oCeM=
Date: Fri, 14 Nov 2025 13:44:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: bhe@redhat.com, rppt@kernel.org, jasonmiu@google.com, arnd@arndb.de,
 coxu@redhat.com, dave@vasilevsky.ca, ebiggers@google.com, graf@amazon.com,
 kees@kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v2 00/13] kho: simplify state machine and enable dynamic
 updates
Message-Id: <20251114134434.5375d085a6bdc1671351f243@linux-foundation.org>
In-Reply-To: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 14 Nov 2025 13:59:49 -0500 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> Andrew: This series applies against mm-nonmm-unstable, but should
> go right before LUOv5, i.e. on top of:
> "liveupdate: kho: use %pe format specifier for error pointer printing"
> 
> Changelog v2:
> - Addressed comments from Mike and Pratyush
> - Added Review-bys.
> 
> It also replaces the following patches, that once applied should be
> dropped from mm-nonmm-unstable:
> "liveupdate: kho: when live update add KHO image during kexec load"
> "liveupdate: Kconfig: make debugfs optional"
> "kho: enable KHO by default"
> 
> This patch series refactors the Kexec Handover subsystem to transition
> from a rigid, state-locked model to a dynamic, re-entrant architecture.
> It also introduces usability improvements.

OK.

Where are we with the series "Live Update Orchestrator, v5"?

I'm seeing a couple of review comments which I plan to circle back on:

https://lkml.kernel.org/r/aROZi043lxtegqWE@kernel.org
https://lkml.kernel.org/r/mafs0ms4tajcs.fsf@kernel.org

and a comment from yourself against
liveupdate-luo_core-integrate-with-kho.patch which indicates that you
plan to update that patch?

