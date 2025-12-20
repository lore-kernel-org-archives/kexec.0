Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46A4E66886
	for <kexec@archiver.kernel.org>; Sat, 20 Dec 2025 03:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a4+Amfyrox8uas0sWao73yoqMJGIxvV4pb6+PRCdA3s=; b=f2ibW1OtrWHAdZkw6Ft6wpBiPc
	qIwYfPQCf3vAH2Q3GouBuUut5X/uDEEVLDZ9p5NvLLWD63YHr6fSnZTfsLgh3t3UX6MFVIVf8n3Nv
	mIuRuesS+sWvgaus0sst4hSc4UtlsFMpbU7w/FvFCSMLiUs0X6CRv2HvflWdChgNT+NO4KphoxM/R
	QcZ/YMRrIgWfHRp7WNTv9kqW8P2tbmCHG7y4J5Bq291+nQymiGmWsRqP2/LCZJvEp1lNjF93QNOcR
	OQax7/ImmFHtPvTSAt/XDN8aZHOx+w6e79kdqOu/w5JApp4UlvrArLtcyZXLsb85DNKngjBj6gLWc
	v10l4qvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWnbo-0000000BF0Z-03uP;
	Sat, 20 Dec 2025 03:26:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWnbk-0000000BF04-18lt
	for kexec@lists.infradead.org;
	Sat, 20 Dec 2025 03:26:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 55C084437A;
	Sat, 20 Dec 2025 03:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15A2C4CEF5;
	Sat, 20 Dec 2025 03:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766201175;
	bh=EnAo8tjl0LeLPwSTVsKJgQguKuTTfJq16l9GOU0BmgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=phms4Nd6aQSaSqIIrs7tdFGtUthysBdYR/4KUwsLEko27qXKr9jeITU/Y660l86gX
	 dnDJBEWToNz9fEG6IGkuV7uKzIcIKzTF5pnuo52ubwmGMfSHDV4Ab5LQetAx4dhYLU
	 DQCPur2SWniNGSj6O0YbWfGGYPomemOaisSZyoDKGQhG5uF6ymmvwXdf4cdLCrYrFe
	 gUtTS33mU/WNSQKk+AeI/8T1+lFeukh+B5DmNx6bFr1a6ihStU+lxVih2azmbAVTie
	 hS9hWVFX2ObIMZWnGz4wektpS41jHSJ8W+XdOE2HhKwLgZcUrfbZI7EeUm7LkphO5S
	 Y5ZiABDTgnitQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@kernel.org>,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  "Liam
 R. Howlett" <Liam.Howlett@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko <mhocko@suse.com>,
  Jonathan Corbet <corbet@lwn.net>,  Thomas Gleixner <tglx@linutronix.de>,
  Ingo Molnar <mingo@redhat.com>,  Borislav Petkov <bp@alien8.de>,  Dave
 Hansen <dave.hansen@linux.intel.com>,  x86@kernel.org,  "H. Peter Anvin"
 <hpa@zytor.com>,  Muchun Song <muchun.song@linux.dev>,  Oscar Salvador
 <osalvador@suse.de>,  Alexander Graf <graf@amazon.com>,  David Matlack
 <dmatlack@google.com>,  David Rientjes <rientjes@google.com>,  Jason
 Gunthorpe <jgg@nvidia.com>,  Samiullah Khawaja <skhawaja@google.com>,
  Vipin Sharma <vipinsh@google.com>,  Zhu Yanjun <yanjun.zhu@linux.dev>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org,  kexec@lists.infradead.org
Subject: Re: [RFC PATCH 04/10] liveupdate: flb: allow getting FLB data in
 early boot
In-Reply-To: <CA+CK2bAV1y_LySjyj-wcn1cdSuVBdC+r+zQL7AQTY64nk3OxuQ@mail.gmail.com>
	(Pasha Tatashin's message of "Thu, 18 Dec 2025 13:25:32 -0500")
References: <20251206230222.853493-1-pratyush@kernel.org>
	<20251206230222.853493-5-pratyush@kernel.org>
	<CA+CK2bAV1y_LySjyj-wcn1cdSuVBdC+r+zQL7AQTY64nk3OxuQ@mail.gmail.com>
Date: Sat, 20 Dec 2025 12:26:05 +0900
Message-ID: <86wm2hj0ky.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_192616_381568_B109BE9D 
X-CRM114-Status: GOOD (  25.12  )
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

On Thu, Dec 18 2025, Pasha Tatashin wrote:

> On Sat, Dec 6, 2025 at 6:03=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>>
>> To support hugepage preservation using LUO, the hugetlb subsystem needs
>> to get liveupdate data when it allocates the hugepages to find out how
>> many pages are coming from live update. This data is preserved via LUO
>> FLB.
>>
>> Since gigantic hugepage allocations happen before LUO (and much of the
>> rest of the system) is initialized, the usual
>> liveupdate_flb_get_incoming() can not work.
>>
>> Add a read-only variant that fetches the FLB data but does not trigger
>> its retrieve or do any locking or reference counting. It is the caller's
>> responsibility to make sure there are no side effects of using this data
>> to the proper retrieve call that would happen later.
>>
>> Refactor the logic to find the right FLB in the serialized data in a
>> helper that can be used from both luo_flb_retrieve_one() (called from
>> luo_flb_get_incoming()), and from luo_flb_get_incoming_early().
>>
>> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
>> ---
>>  include/linux/liveupdate.h  |  6 ++++
>>  kernel/liveupdate/luo_flb.c | 69 +++++++++++++++++++++++++++++--------
>>  2 files changed, 60 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
>> index 78e8c529e4e7..39b429d2c62c 100644
>> --- a/include/linux/liveupdate.h
>> +++ b/include/linux/liveupdate.h
>> @@ -232,6 +232,7 @@ int liveupdate_unregister_flb(struct liveupdate_file=
_handler *fh,
>>
>>  int liveupdate_flb_get_incoming(struct liveupdate_flb *flb, void **objp=
);
>>  int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb, void **objp=
);
>> +int liveupdate_flb_incoming_early(struct liveupdate_flb *flb, u64 *data=
p);
>
> Hi Pratyush,
>
> [Follow-up from LPC discussion]
>
> This patch is not needed, you can use liveupdate_flb_get_incoming()
> directly in early boot. The main concern is that we take mutex in that
> function, but that I think is safe. The might_sleep() has the proper
> handling to be called early in boot, it has "system_state =3D=3D
> SYSTEM_BOOTING" check to silence warning during boot.

Right. I will give it a try. For hugetlb, this works fine since it
doesn't really need to do much in FLB retrieve anyway, it just needs to
parse some data structures.

If other subsystems end up needing a two-part retrieve, one in early
boot and one later, then I think it would be a good idea to model that
properly instead of leaving it up to the subsystem to manage it.

Anyway, that isn't a real problem today so let's look at it when it does
show up.

--=20
Regards,
Pratyush Yadav

