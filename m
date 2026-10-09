Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F61CA6019
	for <kexec@archiver.kernel.org>; Fri,  9 Oct 2026 10:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r3bmrxV+t3fPSMRAU/WJh+2ymAD55jqvxklsd7ARlac=; b=kDsyy5QOut77R4GbzVVRcYJwFz
	lST5qBTLSFtvsBniKl4Yd9kmVav/IpOB5G9WoNViuFstVDZY7kjlSzVaZfmUp1ZlozFjGxS8v35rK
	meOJEuZB2WbZjKCrVkdL8rq5ch2kcf66XLEOvGlIrON8xTdl0ZRKQhUP7zaZ82LRc2pBO7rp9r3yu
	1jifCR5tDqB7ForZTPPPuOT+KDTYkTZKo83aAILWWdfj+a8jewbOpu+ccIt49S+5RFaNLHeqpaDtD
	ulmtTKhpPRZgATw1btFyziD8Z68y/rstmNBG3spyEzpkGf17x5/oqNEItsk0ODyadaulX+8ghBebX
	BbdgOIug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF7zd-000000065Hm-28qj;
	Fri, 09 Oct 2026 10:38:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF7zc-000000065HU-08HN;
	Fri, 09 Oct 2026 10:38:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 77A3060534;
	Fri,  9 Oct 2026 10:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944041F000FF;
	Fri,  9 Oct 2026 10:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791542303;
	bh=r3bmrxV+t3fPSMRAU/WJh+2ymAD55jqvxklsd7ARlac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YlW+4jUDLiex4nL+P4RAOpxGR6Dod1U7kBIPCeYPqGluAcRfccw7qBl6o8mmCGGXP
	 p8Qgk+dTHggYIbeTCZSEWmLRjtVtvfN5T+Rr26hkf9mmoUnIKKQNV2ENhiz+v2oRdD
	 oVbKyZfOHw/QaUw9jZAAXiOetChEhWh6slfZJ9u/1XPBQ5oqUwgnLfIS8kzSx236VX
	 vIo3QBvO/orMMsVm+WhBEKAEYYpNFmibO2SOpSquyMIaH46xMFxClxTxgEaLK9ewhy
	 0onpnFuNEXmz4E68P89210wvyx/ArbFvi4+W/YopRFMy/xXcxC8s/twtjmv6Uz2x6F
	 vM2Uxql6ODdmg==
Message-ID: <sashiko-outbox-165245@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] Drivers: hv: Run VMBus kexec cleanup from
 syscore shutdown
To: catalin.marinas@arm.com, wei.liu@kernel.org, "Shradha Gupta" <shradhagupta@linux.microsoft.com>, mhklinux@outlook.com, baoquan.he@linux.dev
Cc: will@kernel.org, broonie@kernel.org, rppt@kernel.org, linux-hyperv@vger.kernel.org, kexec@lists.infradead.org, haiyangz@microsoft.com, pasha.tatashin@soleen.com, tglx@kernel.org, linux-kernel@vger.kernel.org, kees@kernel.org, kys@microsoft.com, hpa@zytor.com, brads@mainlining.org, akpm@linux-foundation.org, mark.rutland@arm.com, bp@alien8.de, namjain@linux.microsoft.com, longli@microsoft.com, mingo@redhat.com, pratyush@kernel.org, x86@kernel.org, maz@kernel.org, linux-arch@vger.kernel.org, dave.hansen@linux.intel.com, decui@microsoft.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20261009102250.3361076-1-shradhagupta@linux.microsoft.com>
References: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
 <20261009102250.3361076-1-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 10:38:21 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> ARM64 Hyper-V guests do not run the VMBus kexec cleanup before
> secondary CPUs are stopped. Consequently, the old VMBus connection
> and SynIC state remain active when the kexec kernel starts.
>=20
> Run the VMBus kexec handler from the existing VMBus syscore shutdown
> callback. syscore_shutdown() runs after device shutdown and before
> machine shutdown, while all CPUs needed by the SynIC CPU hotplug
> teardown are still available. Guard the callback with
> kexec_is_in_progress() so normal restart, halt, and poweroff paths are
> unchanged.
>=20
> Use the same path on x86 and remove the architecture-specific handler
> pointer and the weak setup/remove interfaces. VMBus teardown now
> precedes hv_stimer_global_cleanup() on x86.
>=20
> The new x86 ordering relies on commit be0cfab740e5 ("clocksource:
> hyper-v: Remove support for stimer interrupts in message mode"), which
> removed the synthetic timer's dependency on VMBus message delivery.
> Older kernels that retain message-mode stimer interrupts must preserve
> the existing x86 ordering and therefore require an ARM64-specific
> backport.
>=20
> Document the VMBus cleanup path and its position in shutdown ordering.
>=20
> Fixes: 9bbb888824e3 ("arm64: hyperv: Initialize hypervisor on boot")
> Link: https://lore.kernel.org/all/20260814093133.3191250-1-shradhagupta@l=
inux.microsoft.com/
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009102215.3360=
863-1-shradhagupta@linux.microsoft.com?part=3D2


