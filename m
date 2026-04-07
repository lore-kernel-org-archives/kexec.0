Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC7EFF510C
	for <kexec@archiver.kernel.org>; Tue,  7 Apr 2026 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qlJveMDYEKfKVQwJqQFhg400ubL5f912Md3XDsqP01E=; b=WQH1jcexUkVT+D97LhNYWKXZH2
	EGem4dlOrYzZKZadd1TAFKP/LpP66IyIMtPiNmawAWqYd5l6Lf3K90cUd0zlPwYGCsfKOCOf3wHhO
	NnCnNIv27TDyO7YOlhEQeVFCCBWZam/LHAVZjrl2qDarcTDxBnASRZDqbmSdKCY1jQr7ooGd4NyXO
	JT+U+KwZ1We4CFb3Ot5bEaorPSGzVFqF1np5edRQNMdTah4FHaofiTLpTL7RL3vs9JAn4VuWers3x
	VkktkSvfCVmcDBUgfRYAvk3wXtD5s7aapjsawTEJkBJ7DKG2uBbzIYpRTHXbBNqxSP2nZ0S6bKoEX
	bi7Bg9iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA8zN-00000006lrS-3gCE;
	Tue, 07 Apr 2026 16:09:17 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA8zM-00000006lqr-0NdG
	for kexec@lists.infradead.org;
	Tue, 07 Apr 2026 16:09:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A7D4143429;
	Tue,  7 Apr 2026 16:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54141C116C6;
	Tue,  7 Apr 2026 16:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775578155;
	bh=IZq3eFoH971hNaQ5fWFSLPAm17OKpP60ehLVeEyCFXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Zg0VQW9GzIUTKfH117MbdYQt2PE9Sc4Wr1nEsCmi3Da/xmvEFGTxKHShSUU0LWHX8
	 X2geS/H8OmV15mGL62gAEYxqx7j55Uw+TapBNrvWuX6xrpgmzbAhiTdKywdkj8tiaj
	 E8d54gLfpkyftc6CjHlXn3HGKymPd3h+4tFOlbQu2KoLSABJlooA6bzhKTwFTCOS+C
	 Tcq/vALCBfoRSHWjIakzvJMjPMt/SY2UfHf/23DhBbCo8lVzCiKXUmYheuxryZqLrT
	 NIPyhEcg9hC4LIqiCuL3J1wXroInDAn7coPgaBhrDN3N+2Mfww22UGKsEbj/VYHGRH
	 tGrftCCULKaCQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Michal Clapinski <mclapinski@google.com>,  Evangelos Petrongonas
 <epetron@amazon.de>,  Alexander Graf <graf@amazon.com>,  Samiullah Khawaja
 <skhawaja@google.com>,  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 1/3] kho: make kho_scratch_overlap usable outside
 debugging
In-Reply-To: <CA+CK2bCSoKGxfV+0QL46p_GqC=rj0YhcvP__bLrM2rVTgTNr=A@mail.gmail.com>
	(Pasha Tatashin's message of "Tue, 7 Apr 2026 10:18:24 -0400")
References: <20260317141534.815634-1-mclapinski@google.com>
	<20260317141534.815634-2-mclapinski@google.com>
	<abptg2AObfxkkxKf@kernel.org> <2vxz1pgravke.fsf@kernel.org>
	<CA+CK2bCSoKGxfV+0QL46p_GqC=rj0YhcvP__bLrM2rVTgTNr=A@mail.gmail.com>
Date: Tue, 07 Apr 2026 16:09:11 +0000
Message-ID: <2vxzse96ah20.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_090916_184056_1228F4C6 
X-CRM114-Status: GOOD (  24.77  )
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

On Tue, Apr 07 2026, Pasha Tatashin wrote:

> On Tue, Apr 7, 2026 at 6:55=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>>
>> On Wed, Mar 18 2026, Mike Rapoport wrote:
>>
>> > Hi Michal,
>> >
>> > On Tue, Mar 17, 2026 at 03:15:32PM +0100, Michal Clapinski wrote:
>> >> Also return false if kho_scratch is NULL.
>> >>
>> [...]
>> >> diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
>> >> index d2f779cbe279..dc352839ccf0 100644
>> >> --- a/kernel/liveupdate/Makefile
>> >> +++ b/kernel/liveupdate/Makefile
>> >> @@ -7,7 +7,6 @@ luo-y :=3D                                           =
                  \
>> >>              luo_session.o
>> >>
>> >>  obj-$(CONFIG_KEXEC_HANDOVER)                +=3D kexec_handover.o
>> >> -obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)  +=3D kexec_handover_debug.o
>> >>  obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)        +=3D kexec_handover_debu=
gfs.o
>> >>
>> >>  obj-$(CONFIG_LIVEUPDATE)            +=3D luo.o
>> >> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/k=
exec_handover.c
>> >> index 532f455c5d4f..c9b982372d6e 100644
>> >> --- a/kernel/liveupdate/kexec_handover.c
>> >> +++ b/kernel/liveupdate/kexec_handover.c
>> >> @@ -820,7 +820,8 @@ int kho_preserve_folio(struct folio *folio)
>> >>      const unsigned long pfn =3D folio_pfn(folio);
>> >>      const unsigned int order =3D folio_order(folio);
>> >>
>> >> -    if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << =
order)))
>> >> +    if (WARN_ON(kho_scratch_overlap_debug(pfn << PAGE_SHIFT,
>> >> +                                          PAGE_SIZE << order)))
>> >
>> > Can't say I'm fond of kho_scratch_overlap_debug(). How about we make it
>> >
>> >       if (IS_ENABLED(CONFIG_KEXEC_HANDOVER_DEBUG) &&
>> >           WARN_ON(kho_scratch_overlap(...))
>>
>> +1. And we can get rid of kexec_handover_debug.c, for now at least. We
>> can add it back when we have something else to put in there.
>
> Are you proposing moving kho_scratch_overlap() into kexec_handover.c?
> That would make it uglier to have #ifdefs in the C file. If you mean
> removing this function entirely, I think that is too dangerous because
> we have already had a memory corruption issue [1] that was challenging
> to root cause, and having this simple check prevents this from
> occurring going forward. The problem is that changes to defences such
> as kfence, kasan, and asi are happening outside of the core KHO code,
> and it is very easy to miss when something unexpectedly causes a
> preservation from the scratch area, as we have seen this with kfence.
> Worst of all, some of those mitigations use randomized or sampling
> approaches and might not be reproducible on every try, so having a
> CONFIG that tests it every time in a debug build is the only solid
> defense against that.

I think you miss the context here. This patchset uses
kho_scratch_overlap() during MM init to set the migrate type of
pageblocks. So it will no longer be gated by
CONFIG_KEXEC_HANDOVER_DEBUG, but by CONFIG_KEXEC_HANDOVER instead. So
there is no need for any #ifdefs. All we need to change is to have the
debug checks gated with a IS_ENABLED(CONFIG_KEXEC_HANDOVER_DEBUG).

So the function stays around, and so do the debug checks. Since core KHO
now uses this function, we just move it out to the main file. And since
kexec_handover_debug.c has nothing else, we can delete it for now.

Anyway, based on the discussion it looks like people want to ask
memblock directly and not use kho_scratch_overlap(), so the next version
might not have this patch at all.

>
> Pasha
>
> [1] https://lore.kernel.org/all/20251021000852.2924827-1-pasha.tatashin@s=
oleen.com
>
>>
>> >
>> >>              return -EINVAL;
>> >>
>> >>      return kho_radix_add_page(tree, pfn, order);
>> [...]
>>
>> --
>> Regards,
>> Pratyush Yadav

--=20
Regards,
Pratyush Yadav

