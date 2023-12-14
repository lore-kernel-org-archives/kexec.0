Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA092C4332F
	for <kexec@archiver.kernel.org>; Thu, 14 Dec 2023 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l5mAQB5VHE/s9wcH9bxan5XYX01rKBwq45y5tzNpuIc=; b=RroukKQsWKFzNr
	S7KZqtnhWRbfm6VoZqDblo8Kh0OklsrSzZ0V8g0USXdYpcBWo+DL6APm4jyxpHfCdQ40D0dFOdylZ
	1NLUVgg9KPpOw2koiHIRQKPQTQQqYYTOWUYnD+siqf667mdFn80nk97gs0NvbB/PwJg4lXg42lrsK
	0pNVOyGeNXllA/dpH1yf2/AEAq6vS5Od570lYR52rSfcJ1e4DKNZJafdxH7dWOvpi9cvX+IAgPRis
	lcNlT5kr1VCK+eSAEGUsCj764ncrHrhKFa5bvhEQD6Ronxbt5zODK0w2+qSFQm4Y7a2XBqT0eA1HB
	dW2EFzEgIF9Y6aifNliw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDixu-00HTWK-2l;
	Thu, 14 Dec 2023 10:29:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDixp-00HTVw-3D
	for kexec@lists.infradead.org;
	Thu, 14 Dec 2023 10:29:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702549748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEGnuAcA6vcyz/hnSV1HfLQ52Yc/OzlpLIbZnnIF9xo=;
	b=LYtNkeeviHlxPafvma9BTHbdjfRDFw9xGdqvok9ku27K176f0uUN3hN4ZqdKYNV9L+KdGF
	MY9dcWnCCiFGSJlDBcuwcae0ue0HN5sod8ATEVuNsz7LyR5Y4P4Th1TvUaCw7x+5TO13kG
	WJbqVCNeJlflnUCuKuDCroMHwyuTmOA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-saQwzr8LNLeC1X0oZg-3ow-1; Thu, 14 Dec 2023 05:29:05 -0500
X-MC-Unique: saQwzr8LNLeC1X0oZg-3ow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10B6885A58A;
	Thu, 14 Dec 2023 10:29:05 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AC703C25;
	Thu, 14 Dec 2023 10:29:03 +0000 (UTC)
Date: Thu, 14 Dec 2023 18:29:01 +0800
From: Baoquan He <bhe@redhat.com>
To: fuqiang wang <fuqiang.wang@easystack.cn>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Message-ID: <ZXrY7QbXAlxydsSC@MiWiFi-R3L-srv>
References: <20231127025641.62210-1-fuqiang.wang@easystack.cn>
 <ZWg9aZYoo0v+tCQ8@MiWiFi-R3L-srv>
 <e588c619-9b97-4627-bce1-b595c757e5c4@easystack.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e588c619-9b97-4627-bce1-b595c757e5c4@easystack.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_022910_107484_598BED9F 
X-CRM114-Status: GOOD (  35.09  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 11/30/23 at 09:20pm, fuqiang wang wrote:
> =

> On 2023/11/30 15:44, Baoquan He wrote:
> > On 11/27/23 at 10:56am, fuqiang wang wrote:
> > > When the split happened, judge whether mem->nr_ranges is equal to
> > > mem->max_nr_ranges. If it is true, return -ENOMEM.
> > > =

> > > The advantage of doing this is that it can avoid array bounds caused =
by
> > > some bugs. E.g., Before commit 4831be702b95 ("arm64/kexec: Fix missing
> > > extra range for crashkres_low."), reserve both high and low memories =
for
> > > the crashkernel may cause out of bounds.
> > > =

> > > On the other hand, move this code before the split to ensure that the
> > > array will not be changed when return error.
> > If out of array boundary is caused, means the laoding failed, whether
> > the out of boundary happened or not. I don't see how this code change
> > makes sense. Do I miss anything?
> > =

> > Thanks
> > Baoquan
> > =

> Hi baoquan,
> =

> In some configurations, out of bounds may not cause crash_exclude_mem_ran=
ge()
> returns error, then the load will succeed.
> =

> E.g.
> There is a cmem before execute crash_exclude_mem_range():
> =

> =A0 cmem =3D {
> =A0=A0=A0 max_nr_ranges =3D 3
> =A0=A0=A0 nr_ranges =3D 2
> =A0=A0=A0 ranges =3D {
> =A0=A0=A0=A0=A0=A0 {start =3D 1,=A0=A0=A0=A0=A0 end =3D 1000}
> =A0=A0=A0=A0=A0=A0 {start =3D 1001,=A0=A0=A0 end =3D 2000}
> =A0=A0=A0 }
> =A0 }
> =

> After executing twice crash_exclude_mem_range() with the start/end params
> 100/200, 300/400 respectively, the cmem will be:
> =

> =A0 cmem =3D {
> =A0=A0=A0 max_nr_ranges =3D 3
> =A0=A0=A0 nr_ranges =3D 4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 <=3D=3D nr_ranges > max_nr_ranges
> =A0=A0=A0 ranges =3D {
> =A0=A0=A0=A0=A0 {start =3D 1,=A0=A0=A0=A0=A0=A0 end =3D 99=A0 }
> =A0=A0=A0=A0=A0 {start =3D 201,=A0=A0=A0=A0 end =3D 299 }
> =A0=A0=A0=A0=A0 {start =3D 401,=A0=A0=A0=A0 end =3D 1000}
> =A0=A0=A0=A0=A0 {start =3D 1001,=A0=A0=A0 end =3D 2000}=A0 <=3D=3D OUT OF=
 BOUNDS
> =A0=A0=A0 }
> =A0 }

Let me borrow your example and copy them here, but I will switch the
order of start/end params 100/200, 300/400 executing at below:

There is a cmem before execute crash_exclude_mem_range():

=A0 cmem =3D {
=A0=A0=A0 max_nr_ranges =3D 3
=A0=A0=A0 nr_ranges =3D 2
=A0=A0=A0 ranges =3D {
=A0=A0=A0=A0=A0=A0 {start =3D 1,=A0=A0=A0=A0=A0 end =3D 1000}
=A0=A0=A0=A0=A0=A0 {start =3D 1001,=A0=A0=A0 end =3D 2000}
=A0=A0=A0 }
=A0 }

After executing twice crash_exclude_mem_range() with the start/end params
300/400, the cmem will be:

=A0 cmem =3D {
=A0=A0=A0 max_nr_ranges =3D 3
=A0=A0=A0 nr_ranges =3D 3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 <=3D=3D nr_ranges =3D=3D max_nr_ranges
=A0=A0=A0 ranges =3D {
=A0=A0=A0=A0=A0 {start =3D 1,=A0=A0=A0=A0=A0=A0 end =3D 299=A0 }  i=3D0
=A0=A0=A0=A0=A0 {start =3D 401,=A0=A0=A0=A0 end =3D 1000}   i=3D1
=A0=A0=A0=A0=A0 {start =3D 1001,=A0=A0=A0 end =3D 2000}=A0  i=3D2
=A0=A0=A0 }
=A0 }
When it's executing the 100/200 excluding, we have:

=A0 cmem =3D {
=A0=A0=A0 max_nr_ranges =3D 3
=A0=A0=A0 nr_ranges =3D 4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 <=3D=3D nr_ranges > max_nr_ranges
=A0=A0=A0 ranges =3D {
=A0=A0=A0=A0=A0 {start =3D 1,=A0=A0=A0=A0=A0=A0 end =3D 99=A0 }   i=3D0
=A0=A0=A0=A0=A0 {start =3D 401,=A0=A0=A0=A0 end =3D 1000}
=A0=A0=A0=A0=A0 {start =3D 1001,=A0=A0=A0 end =3D 2000}=A0 =

=A0=A0=A0 }
=A0 }

Then splitting happened, i =3D=3D 0, then for loop is broken and jump out.
Then we have the condition checking here:

	/* Split happened */
        if (i =3D=3D mem->max_nr_ranges - 1)
                return -ENOMEM;

Obviously the conditonal checking is incorrect (given the i =3D=3D 0 in
above case), it should be =


	/* Split happened */
	if (mem->nr_ranges =3D=3D mem->max_nr_ranges)
                return -ENOMEM;

So, now there are two things which need be combed up in
crash_exclude_mem_range():

1) the above conditional check is incorrect, need be fixed;
2) whether we need have the cmem->ranges[] partly changed, or keep it
unchanged when OOB happened;

And also the incorrect handling in crash_setup_memmap_entries():
1) the insufficient array slot in crash_setup_memmap_entries();
2) the uninitialized cmem->max_nr_ranges;


> =

> When an out of bounds occurs during the second execution, the function wi=
ll not
> return error.
> =

> Additionally, when the function returns error, means the load failed. It =
seems
> meaningless to keep the original data unchanged. But in my opinion, this =
will
> make this function more rigorous and more versatile. (However, I am not s=
ure if
> it is self-defeating and I hope to receive more suggestions).
> =

> Thanks
> fuqiang
> =

> =

> > > Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
> > > ---
> > >   kernel/crash_core.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > =

> > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > index efe87d501c8c..ffdc246cf425 100644
> > > --- a/kernel/crash_core.c
> > > +++ b/kernel/crash_core.c
> > > @@ -611,6 +611,9 @@ int crash_exclude_mem_range(struct crash_mem *mem,
> > >   		}
> > >   		if (p_start > start && p_end < end) {
> > > +			/* Split happened */
> > > +			if (mem->nr_ranges =3D=3D mem->max_nr_ranges)
> > > +				return -ENOMEM;
> > >   			/* Split original range */
> > >   			mem->ranges[i].end =3D p_start - 1;
> > >   			temp_range.start =3D p_end + 1;
> > > @@ -626,9 +629,6 @@ int crash_exclude_mem_range(struct crash_mem *mem,
> > >   	if (!temp_range.end)
> > >   		return 0;
> > > -	/* Split happened */
> > > -	if (i =3D=3D mem->max_nr_ranges - 1)
> > > -		return -ENOMEM;
> > >   	/* Location where new range should go */
> > >   	j =3D i + 1;
> > > -- =

> > > 2.42.0
> > > =

> > > =

> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> > > =

> =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
