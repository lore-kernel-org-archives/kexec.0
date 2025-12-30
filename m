Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56901EE020B
	for <kexec@archiver.kernel.org>; Tue, 30 Dec 2025 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GR1QVe+wka/wbm96OjOQm9NYaPe6PscdIySk4u41LOE=; b=gbEDKzSj9WkG+CywIpAvwJrxmz
	zzUZ4IInyJxek9OpkD6b6ddZY0UUXPTWum7n2VcCStilYx9iSpKiJ16gKvSyGMS75t1e/qq0CV+fI
	Gkqe5nZZm9n8TAmveFEcbfS4qCTgsohQzVAegLV6G4kbnWo5DOxk2Yifmsr8Cq1ZFpiLsd0zez0ul
	T4ah6ufDbvsNGF6Xx8f6dHboJEMc8ofbct8qZkDU/+I2dU6fkPyAB5k1hEzMW30J8FPw3/zig8Oeb
	rmiSVKUnEofE1dujoXUUyXJ44CSEaXZoy4vOnWrSKqJ6oIEUSqlCd9lT2KBpx15EluxaX3hv0Mcwy
	Vx13W7ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vabNi-00000004zGC-3pBR;
	Tue, 30 Dec 2025 15:11:30 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vabNf-00000004zFo-0KaH
	for kexec@lists.infradead.org;
	Tue, 30 Dec 2025 15:11:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=GR1QVe+wka/wbm96OjOQm9NYaPe6PscdIySk4u41LOE=; b=ugBg6T3I+BJ3MKYUEKnspUJTSy
	rbxtMwx/LPQ5E1SqEBZPlflmiwgZshPbBc7lJHejMx2jG3mLrN0fEIZmnvOOR7nPzSG/K4pH0wGyi
	/ZfB4v8wclmZ9mr6xcnPzQjhOh4Oww3BeOUKkr/VFWumIGbaL5/OByBRWnRSW4khQ9+5w3JLprLdz
	C+e2d4D471R28NNE6Ctm2S2eKZYDskKAg8IctqCmgg8WUVuBVcfRMi1/fC6tEPAirfmof/ki3gJPE
	DntY+B8OVrLNJ/01m4lvrOEapGeFSGWP8+8cHu3x5dZVJOf79/E/KEwZDpK41u1cmUherlzNU9S5e
	GKcfyS/Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vabNU-00C85X-AV; Tue, 30 Dec 2025 15:11:16 +0000
Date: Tue, 30 Dec 2025 07:11:10 -0800
From: Breno Leitao <leitao@debian.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
	riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH RFC] kexec: add option to print previous kernel release
 after kexec
Message-ID: <ljo3xdbpwa2kzx5thlki6fc74mpswuwtfqzdl4qyatqi3qjbwm@4prhagytf2ja>
References: <20251230-kho-v1-1-4d795a24da9e@debian.org>
 <CA+CK2bDCKQrK3+6832Lxw8fZx_yt+8z0fFPdugC59p1zdSeSZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDCKQrK3+6832Lxw8fZx_yt+8z0fFPdugC59p1zdSeSZQ@mail.gmail.com>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251230_071127_123903_624756F3 
X-CRM114-Status: GOOD (  25.17  )
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

Hello Pasha,


On Tue, Dec 30, 2025 at 10:03:38AM -0500, Pasha Tatashin wrote:
> On Tue, Dec 30, 2025 at 9:13 AM Breno Leitao <leitao@debian.org> wrote:
> >
> > Introduce a new Kconfig option, CONFIG_KEXEC_SHOW_PREVIOUS_RELEASE,
> 
> I don't think we need a config for this. Let's just show the previous
> kernel version unconditionally when KHO is enabled.
> 
> > which enables the storage and display of the previous kernel's release
> > version across kexec boots when using Kexec Handover (KHO).
> >
> > Motivation
> > ==========
> >
> > Kernel bugs that depend on the version of the previously running kernel
> > are not uncommon, especially in scenarios where a buggy kernel kexecs
> > into a new one and the issue only manifests in the subsequent kernel.
> >
> > Recent examples include:
> >
> >  * eb2266312507 ("x86/boot: Fix page table access in 5-level to 4-level paging transition")
> >  * 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption")
> >  * 64b45dd46e15 ("x86/efi: skip memattr table on kexec boot")
> >
> > As kexec-based reboots become more widespread among Linux users, these
> > issues are becoming increasingly prominent.
> >
> > When such crashes occur, correlating them to the previous kernel version
> > is challenging, especially at scale, where the problem may only appear in
> > specific cases and it is hard to correlate.
> >
> > With the introduction of Kexec Handover (KHO), we now have a reliable
> > mechanism to pass information between kernels. This presents an
> > opportunity to address the problem by carrying the previous kernel's
> > release version to the next kernel and printing it at boot time.
> 
> LUO added the number of times a machine has been live updated to help
> debugging problems that are related to live update, perhaps, in
> addition to the previous kernel version, we should also add a number
> of times the machine has been kexec'd. It is useful when a bug
> manifests only after a number of kexec's which is also sometimes a
> case.

Thanks for bringing this up, I am on the same page as you here.

In fact, this was on my TODO list, but I didn't want to send in this RFC
to avoid too much changes/code.

I will wait a bit more and add the number of kexec'ed kernels in the
next revision.

Thanks for your input,
--breno

