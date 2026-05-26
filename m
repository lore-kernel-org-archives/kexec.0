Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6F0CD5BDF
	for <kexec@archiver.kernel.org>; Tue, 26 May 2026 11:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I9m0CLQDknfiAeneqt3PWBznhhNqswQZNkUNQRNSnDs=; b=oyuMfrJ9xm/om+RYZ04fkatr0A
	k1z7aSFUwkqRYg1PnzzY8hOej4ZLnJFY1ewtDBXJrziB5uu60n6Mv8o7qRRTE4k8v+rrhYF2h1LSm
	+oVLgVvC4O6+4YfH2T3HCGHByPyHp/nXDEJ6TrMBrgUSh+oDqL3v7eVKWEGsxTUdcHa+BuuobNdzR
	0VpD/XuR9/RASY37ir8w3W2/X8V+4uYCDGsB1jtJsWYOgLoPtWkkwWnoPdAPzzaHZynQ04hO5vVCD
	zpJAShtRhIkKOCM8lg3FzX4WLi5BwKOLprrrOwII4AJh2JpoGfVY2y9wcsU7x/+PmmzhO60GOS5qY
	f1bNyV3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRpa1-00000001ipo-0E3t;
	Tue, 26 May 2026 11:04:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRpZy-00000001ioz-0oAV
	for kexec@lists.infradead.org;
	Tue, 26 May 2026 11:04:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 79EA5404CE;
	Tue, 26 May 2026 11:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6F71F000E9;
	Tue, 26 May 2026 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779793449;
	bh=I9m0CLQDknfiAeneqt3PWBznhhNqswQZNkUNQRNSnDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=BledWKORIsYZx8EQATerq2T2aQ/MISg1vd+EGuX8h30fyOjWgvrCRLDj5J97gJuoO
	 cnoR1BsHIiuJY5wjGaEnJ6gwcIdwB9U8gnG4u3Zp27KyKgjlkbaHN4PCr3EMlH8BQ/
	 +TyOuq6s0p0VXu35cN6h1cqlANcwKnqv/uWsPrlzDsGhwET7ajjDtJcW2dwNxycpXE
	 5oePNdUR7+BffCUcCUklRmzEcw+Ln/L9FEgH1t4ZSqT73lKUflFi/009nFng1qpdaG
	 owjLtt0sXK5rVvrbPNzkQhPG0VKjIPdthypS7xv3nydRK0Orm/dEO1a2IKq9Xh6s6B
	 vCucjzcqZrhsg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Alexander Graf <graf@amazon.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: always print scratch sizes
In-Reply-To: <ag9VrVW3E28UOsAt@plex> (Pasha Tatashin's message of "Thu, 21 May
	2026 19:07:47 +0000")
References: <20260519155324.2692594-1-pratyush@kernel.org>
	<ag9VrVW3E28UOsAt@plex>
Date: Tue, 26 May 2026 13:04:06 +0200
Message-ID: <2vxzqzmy4el5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_040410_273673_82BFB940 
X-CRM114-Status: GOOD (  22.74  )
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

On Thu, May 21 2026, Pasha Tatashin wrote:

> On 05-19 17:53, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>>=20
>> Currently, KHO only prints scratch sizes when the size is specified
>> by the command line. It prints nothing when the size is calculated
>> at runtime by counting RSRV_KERN.
>>=20
>> These prints are completely useless. When the user specified the size on
>> the command line, they already know how large the scratch areas are. And
>> that information is readily available by looking at the command line. It
>> is a lot more useful to know the sizes that are calculated at runtime
>> since they can vary by kernel version. Plus, if KHO fails to allocate
>> the scratch areas, the calculated scratch sizes are not available via
>> debugfs.
>>=20
>> Print the scratch sizes in kho_reserve_scratch(). Do it before making
>> the allocations. The size can provide hints for the failure reason.
>>=20
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> ---
>>  kernel/liveupdate/kexec_handover.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexe=
c_handover.c
>> index 33fcf848ef95..b030f53f2235 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -621,11 +621,6 @@ static int __init kho_parse_scratch_size(char *p)
>>  	scratch_size_pernode =3D sizes[2];
>>  	scratch_scale =3D 0;
>>=20=20
>> -	pr_notice("scratch areas: lowmem: %lluMiB global: %lluMiB pernode: %ll=
dMiB\n",
>> -		  (u64)(scratch_size_lowmem >> 20),
>> -		  (u64)(scratch_size_global >> 20),
>> -		  (u64)(scratch_size_pernode >> 20));
>> -
>>  	return 0;
>>  }
>>  early_param("kho_scratch", kho_parse_scratch_size);
>> @@ -691,6 +686,10 @@ static void __init kho_reserve_scratch(void)
>>  		goto err_disable_kho;
>>  	}
>>=20=20
>> +	pr_notice("scratch areas: lowmem: %lluMiB global: %lluMiB\n",
>> +		  (u64)(scratch_size_lowmem >> 20),
>> +		  (u64)(scratch_size_global >> 20));
>> +
>>  	/*
>>  	 * reserve scratch area in low memory for lowmem allocations in the
>>  	 * next kernel
>> @@ -725,6 +724,9 @@ static void __init kho_reserve_scratch(void)
>>  	 */
>>  	for_each_node_state(nid, N_MEMORY) {
>>  		size =3D scratch_size_node(nid);
>> +
>> +		pr_notice("scratch_areas: nid %d: %lluMiB\n", nid, size >> 20);
>
> Please use a space instead of an underscore to match the other string:=20
> "scratch areas". Keeping the prefix identical makes log parsing and=20
> filtering much cleaner.

Sure, will do.

>
> Unrelated to this patch=E2=80=94this is something I brought up to Pratyus=
h off-list,=20
> but I really dislike the 'KHO scratch' terminology.
>
> First, it isn't actually 'scratch' space, as the kernel relies on it to=20
> allocate crucial early boot memory, which it then uses permanently.=20
> Second, we cannot preserve anything within this specific region.=20
>
> Down the line, I'd like to rename this to something more descriptive that=
 clearly=20
> conveys both its importance to early boot and its non-preservable nature.=
 For=20
> now, the print adjustments themselves look good.
>
> I do not know it should be, but something like kho_bootstrap area sounds=
=20
> better than kho_sratch area.

Sure. I think we can land this patch now, and then update the string
when we agree on a better name. But I won't mind waiting either if you
want to reduce churn.

>
>> +
>>  		addr =3D memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,
>>  						0, MEMBLOCK_ALLOC_ACCESSIBLE,
>>  						nid, true);
>>=20
>> base-commit: 34e8f02817e31826e76bb2ded48bf28fe921f20b
>> --=20
>> 2.54.0.563.g4f69b47b94-goog
>>=20

--=20
Regards,
Pratyush Yadav

