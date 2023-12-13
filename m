Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B962DC4332F
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 04:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vgvHwUA7KesyY1ZzEjizIJOlKAyOIBg3q+6vayTpEFg=; b=oYxOV2ltdZYxI0
	w/HBYVGGybpC/3NRaP2F/EUz3Hrl1VwL1fqoSYjEZCn+1R2hzd8k1QlFU8WL41JwtpfmSQu9bhDG0
	YuHFJcBy+iknoC8WML7ijUYPrTiL+QGrTR6AbVVz7XT9hf9bhTgkz0LmtfSlLTqeHd9YqXWZJMqhs
	wSFPQKBvUKEgb7XVodBe7veVDjWKpUUMgM4tgrPRIy/2ibyI7EaICt8/ZhR1zJAeuHuAJqLSxl5nh
	btwMvzs14+OY94LBR95l6LfMlRT/QvcBSfmobohUqyvbvg5UX8IRwmcAdVQU/44YBzPu5xVEeblxh
	7dz4aT3LK+K5PGAzvnWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDH6m-00DbgY-2u;
	Wed, 13 Dec 2023 04:44:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDH6k-00Dbg3-2M
	for kexec@lists.infradead.org;
	Wed, 13 Dec 2023 04:44:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702442667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/cTbycJ6+L1OUYZmWcVqrZarTlp5To90eqHIi055Fw=;
	b=CokQA9gg1R3lwn4PbawEWxdq+ND3v+XgQCxpQXHhnDYLyiJkG0abLv7AmUqb4UOHK45Zav
	wnPFOWT34udHLI3nCe2vYOYoCG6RtIMFckSUwkzyirr2Wz3xC+AbLfuMpDqPimqeprHb0o
	Cq8MoJztdBm1/BDzc3eTjeyERqmY7us=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-EdM98yRTMVyc2x2QONcNOw-1; Tue, 12 Dec 2023 23:44:25 -0500
X-MC-Unique: EdM98yRTMVyc2x2QONcNOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3040983106D;
	Wed, 13 Dec 2023 04:44:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.83])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B40251E3;
	Wed, 13 Dec 2023 04:44:24 +0000 (UTC)
Date: Wed, 13 Dec 2023 12:44:16 +0800
From: Baoquan He <bhe@redhat.com>
To: fuqiang wang <fuqiang.wang@easystack.cn>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Message-ID: <ZXk2oBf/T1Ul6o0c@MiWiFi-R3L-srv>
References: <20231127025641.62210-1-fuqiang.wang@easystack.cn>
 <ZWg9aZYoo0v+tCQ8@MiWiFi-R3L-srv>
 <e588c619-9b97-4627-bce1-b595c757e5c4@easystack.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e588c619-9b97-4627-bce1-b595c757e5c4@easystack.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_204430_863295_78AE460B 
X-CRM114-Status: GOOD (  26.42  )
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

Sorry for late reply.

I checked the code again, there seems to be cases out of bounds occur
very possiblly. We may need to enlarge the cmem array to avoid the risk.

In below draft code, we need add another slot to exclude the low 1M area
when preparing elfcorehdr. And to exclude the elf header region from
crash kernel region, we need create the cmem with 2 slots.

With these change, we can absolutely avoid out of bounds occurence.
What do you think?

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 1715e5f06a59..21facabcf699 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -147,10 +147,10 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 		return NULL;
 =

 	/*
-	 * Exclusion of crash region and/or crashk_low_res may cause
-	 * another range split. So add extra two slots here.
+	 * Exclusion of low 1M, crash region and/or crashk_low_res may
+	 * cause another range split. So add extra two slots here.
 	 */
-	nr_ranges +=3D 2;
+	nr_ranges +=3D 3;
 	cmem =3D vzalloc(struct_size(cmem, ranges, nr_ranges));
 	if (!cmem)
 		return NULL;
@@ -282,7 +282,7 @@ int crash_setup_memmap_entries(struct kimage *image, st=
ruct boot_params *params)
 	struct crash_memmap_data cmd;
 	struct crash_mem *cmem;
 =

-	cmem =3D vzalloc(struct_size(cmem, ranges, 1));
+	cmem =3D vzalloc(struct_size(cmem, ranges, 2));
 	if (!cmem)
 		return -ENOMEM;
 =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
