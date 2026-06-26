Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72EECD4F26
	for <kexec@archiver.kernel.org>; Fri, 26 Jun 2026 08:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/S2xp6uP+NnDpHnkVhvd3u/16+/JYV8Sjg9E05AV+CY=; b=Lb5bqH78ktXi21rUaFGmnBHlF4
	QajE0sXiqCMXwhYlxKU13DkVuvASoCJTCGhcG55LhWBEEbSUkS/gh0v6YGy+LH9I1CccPFRxXzhOo
	pscQDC2q6CoGjT7wfjnB3LPHROgLjq6EonN8Dkg3/8MXQEImf/OZp71N3jbfuwYLEjRetlbIubSI+
	e0ks2AnThI5gQSQK1vmsYdPnvrBqINQzMkE8k7ZDenjT6H7DUn0t/rObrN3mK63jJwcL1JZL9epkV
	7FNaMFHZ+ylrJTQXno0qheUFq+Z242YKw4Rz0R76UDdtvUwOTg3G3+NNhd79LQi/OFCEO0nhoWBdG
	Cwkr0E/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd2Et-0000000Aubf-2BPI;
	Fri, 26 Jun 2026 08:48:43 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd2Eq-0000000Aub3-3HXm;
	Fri, 26 Jun 2026 08:48:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/S2xp6uP+NnDpHnkVhvd3u/16+/JYV8Sjg9E05AV+CY=; b=rm3wMVYaU1oJmUW30/iLkgC8tW
	7+nUXiZkXvcke485Uvum75qA/elqGgphrlJfHTBzMEA1UvJ1Jf8WVju41IKgBn2hTxrEub4VTd3s0
	YL/4hcAOtKDB33Aj9WcSyQZfdSEz6TqK/GwHbiaUDotC6dBsyO//eJpotx7vqDie39FWM9Tzm4XHS
	D2Km03J/B1aVTtxyHzzIOVJ1uDq+A90eDG2BDt57WhAV8LOtj7pwlMYNA+K5q1AJc4VijF/okauZY
	iIAslLsevZHHzxRCb0XsyW3gPXJLVLGth3PyeKZ99biSJyk2rVPiZoEzcBZavQ00pi0Dr8TcrMybU
	li1RBlEA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd2Ea-003qhi-15;
	Fri, 26 Jun 2026 08:48:24 +0000
Date: Fri, 26 Jun 2026 01:48:17 -0700
From: Breno Leitao <leitao@debian.org>
To: Doug Anderson <dianders@chromium.org>, kernel-team@meta.com
Cc: Kiryl Shutsemau <kirill@shutemov.name>, Marc Zyngier <maz@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Petr Mladek <pmladek@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Julien Thierry <julien.thierry.kdev@gmail.com>, 
	Lecopzer Chen <lecopzer@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, paulmck@kernel.org, rmikey@meta.com
Subject: Re: [PATCH v4 0/4] arm64: cross-CPU NMI via SDEI
Message-ID: <aj46xP6jgZ6fmsPb@gmail.com>
References: <cover.1781709543.git.kas@kernel.org>
 <ajVLeseWOZn0XXY2@arm.com>
 <868q8asj1u.wl-maz@kernel.org>
 <ajk-Vge2qhaY-TwJ@thinkstation>
 <CAD=FV=UTcL1NVkvR8Fw_BXvHHk-vBtLSGoJrU-RFSt0yvGUjxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UTcL1NVkvR8Fw_BXvHHk-vBtLSGoJrU-RFSt0yvGUjxA@mail.gmail.com>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_014840_826086_AE40AA53 
X-CRM114-Status: UNSURE (   8.18  )
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

On Mon, Jun 22, 2026 at 09:52:40AM -0700, Doug Anderson wrote:
> Having them as a stop-gap until true NMI is available
> seems nice to me

I completely agree. Should these patches unfortunately not make it upstream,
my plan is to maintain them downstream at Meta kernels until the Meta fleet
no longer contains any non-FEAT_NMI hosts.

The trade-offs under consideration are:

	1) Accept the performance overhead from pseudo-NMI
	2) Lose debuggability by disabling NMI entirely
	3) Maintain downstream patches

Of these three options, carrying downstream patches appears to be the least
disruptive path for our business needs.

