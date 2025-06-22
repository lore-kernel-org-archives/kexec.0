Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4062C71157
	for <kexec@archiver.kernel.org>; Sun, 22 Jun 2025 00:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z+55KMe73ouJC14YUdXYrcucc5+cI3eagbiezCttkBQ=; b=eR3rQZNMz+oPsTMCqtulQ9E2gX
	qZJBsaSOStHKXm9fQB283ET7O9yxFUeEO6sWMlaYBdoeOkG0Of6dmBgxcn4yAl0We9K0ziOUlSmaL
	JWAb3/KfxxPeaMnxvJW2CJpYdDcFdO/DhpCJCWzJ+gO2NJmXRkd1dfT/at3/bdl5zf3QaFvdRYFxQ
	MAdp/gxtQx4n7yLCLCBp0gFQrIGIhCC5WJGXTo4bHH0pnzpj4Qr4W9Z8BksyAtWY2UaeHtA5s/ara
	68vR5ijSl+JMFhNiZwA8eDWetC4jqcWfn2Lec99LcLzeZEtmDCNwOAfc64CTHZSJqrl8KiwOa/Vsc
	NusmTtkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uT8Dg-00000000OEj-2xk9;
	Sun, 22 Jun 2025 00:06:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uT8Db-00000000OCJ-0JCK
	for kexec@lists.infradead.org;
	Sun, 22 Jun 2025 00:05:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750550751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+55KMe73ouJC14YUdXYrcucc5+cI3eagbiezCttkBQ=;
	b=VhWkB+4N58iqwy9tTqg++N1t9vjU401AjpRi3DbNHdNPeGrS9XucEuLw+fQyXTQhqseGJr
	bfUQwXpRdQPUpbbsGXK31yAcTeve0s4OzIg26EboLuuhgUUDhUbOdX9hFFNtMnHF10y493
	G76v8fEpu6EJAmT19SlpH21CBUtvKFw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-N1CmsiwuOOmw-o3vRrPT2Q-1; Sat, 21 Jun 2025 20:05:49 -0400
X-MC-Unique: N1CmsiwuOOmw-o3vRrPT2Q-1
X-Mimecast-MFC-AGG-ID: N1CmsiwuOOmw-o3vRrPT2Q_1750550749
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a6f6d07bb0so65042931cf.1
        for <kexec@lists.infradead.org>; Sat, 21 Jun 2025 17:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750550749; x=1751155549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+55KMe73ouJC14YUdXYrcucc5+cI3eagbiezCttkBQ=;
        b=wwiaUaOkCIqp6qjR/SSkOXPOc3hcqyjMx+hMKnXcDnoV03+l8VCDRITqJ/htL2cWsq
         6xQf1pJaE8b9aUBSNwnXnph2paq6AuZbMmcyYeFZKjv3c2zfkhfPhsz0z2ieW5UwvC+6
         BKGZfQGhiTdOKTCkZ0zWbQf8sNmlSh6XcFP1Ouvs37XhY16gazm2hcIQFypPv3QtScTW
         EGBKpcsnrdPiFsRiA/WwYLy+qHyEMFEV4GRkBK3snEGsBfo/irien5B1HfilAK1lq4lX
         epKey9zUZs4hHe89a6Z+BHCsh1cyNpUpHtGolfj219W0lb6/iHM2H1pzVv0emJk2wAEy
         T4dw==
X-Forwarded-Encrypted: i=1; AJvYcCXA+XpxO7ocDFWk95BTZ8hUiBgmGl2ERotGRRvzIe0X67emABVOeevo/xBD6s13hrkEYpAOVA==@lists.infradead.org
X-Gm-Message-State: AOJu0YybAuD8M07hcHYw3Qbya9/7xsoSNO7RF7XLkaraJtszB/0PuLd2
	eHq0N/HlvuwHA5Smeqrcfdq2xYp8UqcYIkNQ6XptDDgSzVSg+jN5SEb28pE8Wtr2X4WQEE9a3fo
	LMt0iLBspoCdbhfzw6x37xH/w11lxCZDouOyv92wcq+4xsDViMNmHpfsVz71fkvmVVCLe3dqrH8
	iknzlPWjU82oCOmvMFrajU5L3wRrsd/i3viTK7
X-Gm-Gg: ASbGncu8YR4VA4+2kfY7sGu8RwNUU9jfvIf7fnJe8s08eJkrGarYPuJCge7vG5/eVZZ
	x8G2NOfUeDuP3bM9R2B8PYeBkyOShkegY9+Is/gxScttfPdW7QPL+E/g1oZO/2hNOlK+9ttrmqX
	ZZlQ==
X-Received: by 2002:a05:622a:489:b0:4a4:3d13:7d21 with SMTP id d75a77b69052e-4a77a2ae472mr125547371cf.47.1750550748804;
        Sat, 21 Jun 2025 17:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExCDQvftnWzfzmjUkoZO8KBPKQJEqLoj0mYfcL2iODYM2ITHjWVeMrV80XTm3VRB1CuD2sgjOl1Zm6ul140Ls=
X-Received: by 2002:a05:622a:489:b0:4a4:3d13:7d21 with SMTP id
 d75a77b69052e-4a77a2ae472mr125547051cf.47.1750550748386; Sat, 21 Jun 2025
 17:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250618235644.22589-2-ltao@redhat.com> <72d9e399-74ce-4882-b219-30ab70e17b06@linux.ibm.com>
In-Reply-To: <72d9e399-74ce-4882-b219-30ab70e17b06@linux.ibm.com>
From: Tao Liu <ltao@redhat.com>
Date: Sun, 22 Jun 2025 12:05:12 +1200
X-Gm-Features: AX0GCFsKNcBQHR6yzyGayFu8en7RbDUqncOMMu8zkSHTpSB2NebZt2ksISmDEZY
Message-ID: <CAO7dBbUO8GPzCJvksMVtFWQB2DDP-0dzLa8XXhE-V8H8S0bVrQ@mail.gmail.com>
Subject: Re: [PATCH][makedumpfile] Fix a data race in multi-threading mode (--num-threads=N)
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yzZ1RZzijpGWyX6GioiSz3nttU_SuUF5MM7WO_tgnC8_1750550749
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250621_170555_187144_F125FDA4 
X-CRM114-Status: GOOD (  36.46  )
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

Hi Sourabh,

On Sat, Jun 21, 2025 at 12:25=E2=80=AFAM Sourabh Jain <sourabhjain@linux.ib=
m.com> wrote:
>
> Hello Tao,
>
> On 19/06/25 05:26, Tao Liu wrote:
> > A vmcore corrupt issue has been noticed in powerpc arch [1]. Although t=
he
> > original issue was closed, but it still can be reproduced with upstream
> > makedumpfile.
> >
> > With --num-threads=3DN enabled, there will be N sub-threads created. Al=
l
> > sub-threads are producers which responsible for mm page processing, e.g=
.
> > compression. The main thread is the consumer which responsible for
> > writing the compressed data into file. page_flag_buf->ready is used to
> > sync main and sub-threads. When a sub-thread finishes page processing,
> > it will set ready flag to be FLAG_READY. In the meantime, main thread
> > looply check all threads of the ready flags, and break the loop when
> > find FLAG_READY.
> >
> > page_flag_buf->ready is read/write by main/sub-threads simultaneously,
> > but it is unprotected and unsafe. I have tested both mutex and atomic_r=
w
> > can fix this issue. This patch takes atomic_rw for its simplicity.
> >
> > [1]: https://github.com/makedumpfile/makedumpfile/issues/15
> >
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> >   makedumpfile.c | 21 ++++++++++++++-------
> >   1 file changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index 2d3b08b..bac45c2 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -8621,7 +8621,8 @@ kdump_thread_function_cyclic(void *arg) {
> >
> >               while (buf_ready =3D=3D FALSE) {
> >                       pthread_testcancel();
> > -                     if (page_flag_buf->ready =3D=3D FLAG_READY)
> > +                     if (__atomic_load_n(&page_flag_buf->ready,
> > +                                     __ATOMIC_SEQ_CST) =3D=3D FLAG_REA=
DY)
> >                               continue;
> >
> >                       /* get next dumpable pfn */
> > @@ -8637,7 +8638,8 @@ kdump_thread_function_cyclic(void *arg) {
> >                       info->current_pfn =3D pfn + 1;
> >
> >                       page_flag_buf->pfn =3D pfn;
> > -                     page_flag_buf->ready =3D FLAG_FILLING;
> > +                     __atomic_store_n(&page_flag_buf->ready, FLAG_FILL=
ING,
> > +                                     __ATOMIC_SEQ_CST);
> >                       pthread_mutex_unlock(&info->current_pfn_mutex);
> >                       sem_post(&info->page_flag_buf_sem);
> >
> > @@ -8726,7 +8728,8 @@ kdump_thread_function_cyclic(void *arg) {
> >                       page_flag_buf->index =3D index;
> >                       buf_ready =3D TRUE;
> >   next:
> > -                     page_flag_buf->ready =3D FLAG_READY;
> > +                     __atomic_store_n(&page_flag_buf->ready, FLAG_READ=
Y,
> > +                                     __ATOMIC_SEQ_CST);
> >                       page_flag_buf =3D page_flag_buf->next;
> >
> >               }
> > @@ -8855,7 +8858,8 @@ write_kdump_pages_parallel_cyclic(struct cache_da=
ta *cd_header,
> >                        * current_pfn is used for recording the value of=
 pfn when checking the pfn.
> >                        */
> >                       for (i =3D 0; i < info->num_threads; i++) {
> > -                             if (info->page_flag_buf[i]->ready =3D=3D =
FLAG_UNUSED)
> > +                             if (__atomic_load_n(&info->page_flag_buf[=
i]->ready,
> > +                                             __ATOMIC_SEQ_CST) =3D=3D =
FLAG_UNUSED)
> >                                       continue;
> >                               temp_pfn =3D info->page_flag_buf[i]->pfn;
> >
> > @@ -8863,7 +8867,8 @@ write_kdump_pages_parallel_cyclic(struct cache_da=
ta *cd_header,
> >                                * count how many threads have reached th=
e end.
> >                                */
> >                               if (temp_pfn >=3D end_pfn) {
> > -                                     info->page_flag_buf[i]->ready =3D=
 FLAG_UNUSED;
> > +                                     __atomic_store_n(&info->page_flag=
_buf[i]->ready,
> > +                                             FLAG_UNUSED, __ATOMIC_SEQ=
_CST);
> >                                       end_count++;
> >                                       continue;
> >                               }
> > @@ -8885,7 +8890,8 @@ write_kdump_pages_parallel_cyclic(struct cache_da=
ta *cd_header,
> >                        * If the page_flag_buf is not ready, the pfn rec=
orded may be changed.
> >                        * So we should recheck.
> >                        */
> > -                     if (info->page_flag_buf[consuming]->ready !=3D FL=
AG_READY) {
> > +                     if (__atomic_load_n(&info->page_flag_buf[consumin=
g]->ready,
> > +                                     __ATOMIC_SEQ_CST) !=3D FLAG_READY=
) {
> >                               clock_gettime(CLOCK_MONOTONIC, &new);
> >                               if (new.tv_sec - last.tv_sec > WAIT_TIME)=
 {
> >                                       ERRMSG("Can't get data of pfn.\n"=
);
> > @@ -8927,7 +8933,8 @@ write_kdump_pages_parallel_cyclic(struct cache_da=
ta *cd_header,
> >                               goto out;
> >                       page_data_buf[index].used =3D FALSE;
> >               }
> > -             info->page_flag_buf[consuming]->ready =3D FLAG_UNUSED;
> > +             __atomic_store_n(&info->page_flag_buf[consuming]->ready,
> > +                             FLAG_UNUSED, __ATOMIC_SEQ_CST);
> >               info->page_flag_buf[consuming] =3D info->page_flag_buf[co=
nsuming]->next;
> >       }
> >   finish:
>
>
> I also observed this issue, and it is easily reproducible on Power
> systems with large memory configurations around 64TB.
> In my case the crash tool printed following error message when running
> to debug the corrupted vmcore.
>
> ```
> crash: compressed kdump: uncompress failed: 0
> crash: read error: kernel virtual address: c0001e2d2fe48000  type:
> "hardirq thread_union"
> crash: cannot read hardirq_ctx[930] at c0001e2d2fe48000
> crash: compressed kdump: uncompress failed: 0
> ```
>
> Should we include the above crash logs or the you observed in this
> commit message for easy reference?

In fact I didn't test the vmcore by crash. I generated 2 vmcores from
one single vmcore, and one is generated with "--num-threads=3DN" and the
other without. If multi-thread makedumpfile works fine, the 2 vmcores
should be exactly the same. However the cmp reports there are bytes
different. Anyway both cmp and crash give the same result,
multi-thread makedumpfile does have bugs.

I will add the crash error message into the v2 commit log for easy referenc=
e.

>
> I tested this fix on high-end Power systems with 64TB of RAM as well as
> on systems with lower memory, and everything is
> working fine in both cases.
>
> Thanks for the fix.
> Tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thanks a lot for your testing!

Thanks,
Tao Liu

>
> - Sourabh Jain
>


