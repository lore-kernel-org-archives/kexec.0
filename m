Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CA6C43458
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 09:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ghnk+dbD6A1tyBxAoJ0s58GH07hqyxQ8En0ljy8NSzs=; b=BQxCRInXz/Cv/aKT27Twez8vUl
	wzAOLP/j3JmaQA+RJwethQCE6wkP5rXhVDOWov6VQ0i9H9iq2C/UNMzbW0ZNCGSMUxgMpRQeEJArR
	2zdp9myc4MhEwHSuz9SjTdJwYrw8s1GE6y0uClPJpyr/MelgKe9P/gz5fogWCq8IWXHXUDT2LOLZ1
	y4S/ogLIBRVnL6B5LRpy6Xne8DOYlDsBRPD43LRTc9A4l6qWGX0nrqB9RvMSjHHC5RWqrYbmFwpuQ
	HSx4c0dWvosKxZasufrgGTvcqGFc68KWoJ5VoOrHPVfPAzCSK9QZEmPHbEqLUsRkm7zS6f8bVIebQ
	q+O0M6Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi7za-00000004e9z-2I5o;
	Fri, 10 Jul 2026 09:57:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi7zZ-00000004e9r-2Lw8
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 09:57:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B0A526136C;
	Fri, 10 Jul 2026 09:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243BB1F00AC4;
	Fri, 10 Jul 2026 09:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783677476;
	bh=ghnk+dbD6A1tyBxAoJ0s58GH07hqyxQ8En0ljy8NSzs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=TGdSxBmCa3CX6xvbAEFyBmy54ptb092aSrGXAj0uHBoTNg0nhY6ta2T08zktnYTjy
	 RmwCy/53WzEom34Uzl6wWZnDMaiRiTOQrpzZamOPTxzbcut6EYwnzYUJRpo49K97yz
	 MvbMiEbs4MlqFZhrVE3VCZ9EsTKOC1FxkQ/EHiQGYUsw74pOoP/nQiqau3WK8TbG6O
	 a8YbSJuX4NwbYzQrMOKIj/rvDWY6d07c2ZSaGStju0F9xL+fbGqhhaUFyDcmmv57li
	 3bGqH1AAM4ddrbgCEcxvv+cRipBFYfEMlBOO2pl87lXttd3O7KEQSefABHBWi0FrVt
	 G2gDSfddFwVRw==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,  Andrew Morton
 <akpm@linux-foundation.org>,  Mike Rapoport <rppt@kernel.org>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>
Subject: Re: [PATCH 0/2] liveupdate: Small FLB fixes
In-Reply-To: <CALzav=diio783dFmPGYp9Uvov2HBWv_EQLoNjnM=qBWzwU5tCA@mail.gmail.com>
	(David Matlack's message of "Thu, 9 Jul 2026 13:51:40 -0700")
References: <20260528174140.1921129-1-dmatlack@google.com>
	<CALzav=diio783dFmPGYp9Uvov2HBWv_EQLoNjnM=qBWzwU5tCA@mail.gmail.com>
Date: Fri, 10 Jul 2026 11:57:53 +0200
Message-ID: <2vxzcxwvkvz2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jul 09 2026, David Matlack wrote:

> On Thu, May 28, 2026 at 10:41=E2=80=AFAM David Matlack <dmatlack@google.c=
om> wrote:
>>
>> This series has 2 small fixes to how FLBs are managed. First is to
>> increase the outgoing FLB refcount during liveupdate_flb_get_outgoing()
>> so it cannot be freed while the caller is using it, and to align with
>> the semantics of liveupdate_flb_get_incoming(). The second is to prevent
>> FLB retrieve() from being called multiple times if the first attempt
>> fails.
>>
>> Both of these changes are needed for the correctness of the PCI core
>> support for Live Update:
>>
>>   https://lore.kernel.org/linux-pci/20260522202410.3104264-1-dmatlack@go=
ogle.com/
>
> I'm wondering if we still want this series. After discussions with
> Pratyush and Sami (some on-list, some off-list) the v7 of the PCI
> series (which I haven't sent yet) does not depend on these changes for
> correctness.
>
> Patch 1: PCI core no longer calls get_outgoing() outside the scope of
> file handler callbacks. So there is no need to increment the reference
> count. We could still keep this to make get_outgoing behave the same
> way as get_incoming for consisteny at the cost of some extra
> complexity to manage outgoing FLB refcoutn.

I'm neutral on this one. I'll leave it up to Pasha's preference.

>
> Patch 2: PCI core panics if retrieve fails (proceeding without the PCI
> FLB can lead to memory corruption due to ongoing DMA). So the behavior
> of LUO on retrieve() errors does not matter.

This patch is useful for sure. Sure, PCI might panic, but other FLB
users like HugeTLB won't. And this patch fixes a real problem for those
cases.

The patch applies cleanly on liveupdate/next. So Mike, would you mind
applying patch 2/2 now? We can wait for Pasha to chime in for 1/2.

>
> Should we drop this series?

--=20
Regards,
Pratyush Yadav

