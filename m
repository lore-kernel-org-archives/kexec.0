Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D26C53200
	for <kexec@archiver.kernel.org>; Mon, 27 Jul 2026 03:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TJ8JOsuNS9FMz8gDaGLvGpLiuqBJLsoGeu7gSP3kDic=; b=gzunVoHI2flVGcMt9HXIxO2VD5
	2KZPGa0jNj73XXx240Ag41YVvHsMH9L5ogTXMPR4NYhLEIgDu3GV7VzLLJQ3V9v3p6zjj7ovXbLeG
	UMmlh0oKkMVNY8M/L2gJQWfILijdLnw7fxXHVANIczClMgLTDUurOs/chPJqJ9a4pPYIEqV+N0oTT
	RvHW+Vts1zwJYjRym6kw38a203T3YIeNrlRGFXImHN9PgWjkZN2m4WOwWrqH82KCbvEMYFbtWQbSi
	3RE99QK7RGgGXuYeMiqsNkpXNy3G8y5hmY4ucRbFdi/OlHHOjl80nhKBwXjUaHv0R4iOJsZgLhvaW
	UK/ZHwtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woCG2-00000001tVy-2RIW;
	Mon, 27 Jul 2026 03:44:02 +0000
Received: from out-181.mta0.migadu.com ([91.218.175.181])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woCFz-00000001tVB-3O7L
	for kexec@lists.infradead.org;
	Mon, 27 Jul 2026 03:44:01 +0000
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785123834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJ8JOsuNS9FMz8gDaGLvGpLiuqBJLsoGeu7gSP3kDic=;
	b=aRf46QzBuKyHK/EkkiGdLyqu3uYLO/+lJA2GEDL1PfdcBnFNIg1VpQoyyJOnJaFRz3YSba
	fkneCqeuAliZ5vn0sVTXpPF6Y5NRRSVUsjamfFhcO/DMRsPftOu9WOtC8Cx77uIWmet/RB
	TdRx9ZazWk2gsfdKm7lB6eFaIox1tuo=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v4 16/21] mm/mm_init: simplify deferred_free_pages()
 migratetype init
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260726202522.e55861cc87fc3e0c6d030e1f@linux-foundation.org>
Date: Mon, 27 Jul 2026 11:43:31 +0800
Cc: Mike Rapoport <rppt@kernel.org>,
 Pratyush Yadav <pratyush@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Alexander Graf <graf@amazon.com>,
 Oscar Salvador <osalvador@suse.de>,
 Jason Miu <jasonmiu@google.com>,
 Jork Loeser <jloeser@linux.microsoft.com>,
 kexec@lists.infradead.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Muchun Song <songmuchun@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <92E24479-07A8-4998-9607-87420A8BE04E@linux.dev>
References: <20260725172133.4018491-1-pratyush@kernel.org>
 <20260725172133.4018491-17-pratyush@kernel.org> <amXelr2DcRRyZDY4@kernel.org>
 <20260726202522.e55861cc87fc3e0c6d030e1f@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260726_204400_142022_F3188A7A 
X-CRM114-Status: GOOD (  18.58  )
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



> On Jul 27, 2026, at 11:25, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Sun, 26 Jul 2026 13:16:54 +0300 Mike Rapoport <rppt@kernel.org> =
wrote:
>=20
>> On Sat, Jul 25, 2026 at 07:21:16PM +0200, Pratyush Yadav wrote:
>>> From: Muchun Song <songmuchun@bytedance.com>
>>>=20
>>> deferred_free_pages() open-codes two loops to initialize the =
pageblock
>>> migratetype for a range of pages.
>>>=20
>>> Replace them with pageblock_migratetype_init_range() to remove the
>>> duplication and make the code clearer (Note that =
deferred_free_pages() may
>>> be called from atomic context).
>>>=20
>>> Link: =
https://lore.kernel.org/20260612035903.2468601-6-songmuchun@bytedance.com
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> Acked-by: Oscar Salvador <osalvador@suse.de>
>>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>>> ---
>>>=20
>>> Notes:
>>>    This patch is taken from Muchun's series [0]. The patch as of =
today is
>>>    in mm-unstable.
>>=20
>> @Andrew,
>>=20
>> It looks like it'll take some time for this patch to get into =
mm-stable so
>> we can't base this work on a branch in the mm tree :(
>=20
> I didn't know anyone was using mm-stable :(
>=20
> Series is adequately reviewed and is near head-of-queue so I can move
> it into mm-stable a few days hence if that helps?
>=20
>> I'd like to expose the KHO scratch extension to linux-next ASAP so =
I'm
>> inclined to take this patch as a part of this series and live for a =
while
>> with a duplicated commit in linux-next. Once this patch would be in
>> mm-stable we can rebase kho-scratch work on top of mm-stable and =
hopefully
>> there will be enough time for it to live in linux-next so that Linus =
won't
>> get angry at us :)=20
>>=20
>> How does that sound to you?
>=20
> That's fine - let me know what you choose to do and I'll adapt to it.
>=20
> An unknown (to me) is whether Muchun's series "mm: Refactor bootmem
> gigantic hugepage allocation, v4" still works with this patch removed. =
 Everything
> applies OK for what that's worth.

Hi Andrew,

I'd like to confirm that this is a completely independent cleanup patch,
so it can be merged on its own.

Thanks.



