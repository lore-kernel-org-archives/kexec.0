Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E468C71147
	for <kexec@archiver.kernel.org>; Wed, 11 Jun 2025 17:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ccGrVDJ+WUSoLiOk5obSbpSOZ6sdQYkWk94+LyD+iS8=; b=VD0UzsHXFAHpXyUQDG009XWqR2
	UuDM2UGcm/h2hvydQqm5W9GcwZpOMJ5uENvo3TfQrzJ2bPFXoNQO+ut33aMgVtwBIfFtR/wFU6w12
	CTrA1x0RjhzBOzBx2w7dvbbFv7RsKZhsQ4VmTmkJgijOei3LXdyBc2z5QcCcMdTfPJ534PDYMHBD1
	Bv6krh2LCIHhFNwOSeZzQCfRXr7t845+CARZ6Z5Tb8HSQUw18NEyCGxU8pggKpvVcuPRGueuMFjpb
	oxES3/Bixx/sr1Ddv1bYXNkiiXH186gkGMlexmeedqgctL52MI8MYnV+5ODJAC1hfuOI7qN3HgxFR
	DlE6CzWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPPjq-0000000Am48-0ePQ;
	Wed, 11 Jun 2025 17:59:50 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPLf9-00000009zDt-3aeM
	for kexec@lists.infradead.org;
	Wed, 11 Jun 2025 13:38:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1AA824499E;
	Wed, 11 Jun 2025 13:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8E5C4CEEE;
	Wed, 11 Jun 2025 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749649123;
	bh=ApP+He8rbDgY3eull1tpS3JNL84wa6c46rgsr+2B2rI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=H3/0dNW+kMGwcGMHzgalbsTXgIMCO2rpJ0js9L+r0AThN/s0Eyx4qH+i17Kd4dl3F
	 qxBriuvT1ZnnD00+VWINeYWuC3MtvOwVf2fxao9E6cps2zCYCB/h4MXBozMab3NUEy
	 uHKXJKjo3HPfm+dOf1Rb4cjsWvIK29aW5bR+pjLvMZv+iSL6871EgZj1odwsQnbUOM
	 AJbYohWEZceQJotFEgGY8JrKBTx8UeaYh8Q51p+FJ7c6P1E/cw0dJCNHsyqQVsMYaJ
	 Knk1gpQRSORDWJPwkkVDgYME3NsaVSNIwK2K6TUzcKHlFCtzKGOzPEz/2scBaHfqpd
	 gn/6dHrCoAAAQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Changyuan Lyu <changyuanl@google.com>,
  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,
  kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  Michal Clapinski <mclapinski@google.com>
Subject: Re: [PATCH] kho: initialize tail pages for higher order folios
 properly
In-Reply-To: <CA+CK2bBoMfJuUCV6sL80kwzYPnENnt7fDk2jRMPV0iPn1jCJdw@mail.gmail.com>
References: <20250605171143.76963-1-pratyush@kernel.org>
	<aEKhF3HcrvG77Ogb@kernel.org> <mafs0jz5osutx.fsf@kernel.org>
	<aEc30BoLE9HRxiZm@kernel.org>
	<CA+CK2bAAbZjS2Og79xxLcDtNf-eM0up-8fwhd4fg_dp0j_TahA@mail.gmail.com>
	<aEfGTXrsEL5-DuF1@kernel.org>
	<CA+CK2bDXOWzrTsNtbCCK2rabNysf0JFQT5VfAjYrX5oSoiLmSQ@mail.gmail.com>
	<aEhgNU80Dr9iRwoD@kernel.org>
	<CA+CK2bD3n=JDuSsMGvsyMnVbPhGdhdf6zWFDa3KpzRGEXygdgQ@mail.gmail.com>
	<mafs0qzzqo2bg.fsf@kernel.org>
	<CA+CK2bBoMfJuUCV6sL80kwzYPnENnt7fDk2jRMPV0iPn1jCJdw@mail.gmail.com>
Date: Wed, 11 Jun 2025 15:38:40 +0200
Message-ID: <mafs0msaeo0tb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_063843_935155_EB148B6E 
X-CRM114-Status: GOOD (  23.36  )
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

On Wed, Jun 11 2025, Pasha Tatashin wrote:

> On Wed, Jun 11, 2025 at 9:06=E2=80=AFAM Pratyush Yadav <pratyush@kernel.o=
rg> wrote:
>>
>> On Tue, Jun 10 2025, Pasha Tatashin wrote:
[...]
>> >> > > We could, but with that would mean we'll run this before SMP and =
it's not
>> >> > > desirable. Also, init_deferred_page() for a random page requires
>> >> >
>> >> > We already run KHO init before smp_init:
>> >> > start_kernel() -> mm_core_init() -> kho_memory_init() ->
>> >> > kho_restore_folio() -> struct pages must be already initialized her=
e!
>> >> >
>> >> > While deferred struct pages are initialized:
>> >> > start_kernel() -> rest_init() -> kernel_init() ->
>> >> > kernel_init_freeable() -> page_alloc_init_late() ->
>> >> > deferred_init_memmap()
>> >> >
>> >> > If the number of preserved pages that is needed during early boot is
>> >> > relatively small, that it should not be an issue to pre-initialize
>> >> > struct pages for them before deferred struct pages are initialized.=
 We
>> >> > already pre-initialize some  "struct pages" that are needed during
>> >> > early boot before the reset are initialized, see deferred_grow_zone=
()
>> >>
>> >> deferred_grow_zone() takes a chunk in the beginning of uninitialized =
range,
>> >> with kho we are talking about some random pages. If we preinit them e=
arly,
>> >> deferred_init_memmap() will overwrite them.
>> >
>> > Yes, this is why I am saying that we would need to skip the KHO
>> > initialized "struct pages" somehow during deferred initialization. If
>> > we create an ordered by PFN list of early-initialized KHO struct
>> > pages, skipping during deferred initialization could be done
>> > efficiently.
>>
>> Or keep things simple and don't use any KHO struct pages during early
>> init. You can access the page itself, just don't use its struct page.
>>
>> Currently the only user of kho_restore_folio() during init is
>> kho_memory_init(). The FDT is accessed by doing
>> phys_to_virt(kho_in.fdt_phys) anyway, so there is really no need for
>> restoring the folio so early. It can be done later, for example when LUO
>> does the finish event, to clean up and free the folio.
>
> Good suggestion, however, KHO does not have any sophisticated users
> that we are going to be adding as part of the live update work in the
> future: IR, KVM, early VCPU threads, and so on. So, while today, this
> might work, in the future, I am not sure if we should expect struct
> pages are not accessed until after deferred initialization or simply
> fix it once and for all.

Right. We might end up needing it down the line. But from a quick look,
it doesn't seem to be trivial to solve, so IMO we should solve it when
those use cases actually show up, and keep things simple for now.

--=20
Regards,
Pratyush Yadav

