Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAD5C43458
	for <kexec@archiver.kernel.org>; Wed,  1 Jul 2026 03:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YoMJdx5zn+YGKPIJdZfuaw6N0IusaD8A3j1a7ig86wQ=; b=ZUS8joqVyLVRNfxglWKGFK2p1t
	U4F/pAAZjtkKmpI3soVx2Ebl5CL0XzuoFQemfgWNgRJ/F0RYwmZdA0RWDPHfL9kAEmluimhfzGDzV
	Nwmzk62a1SJSyDQqxS5tsfrOloXrNz5XLzAp1kIQp48LmIc7U593RuXa8Qq9ru555N9zrwkkqH8Vv
	K5jGFbqR7VzAOLEVl4IqL07cbdIZTYSf3mQMy7acblMQ91MhfOuYFGXs/CznE8htvGedA6XLAlFuG
	FJt3BDO/RNPd34nS38Yf4zFH0e+jtx6BKE2WQkkj8DhJw9qLZnKr0YgiTVQAizGQ5yY6yG3cHXzwt
	Css4sr1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1welei-00000000aMO-4464;
	Wed, 01 Jul 2026 03:30:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weled-00000000aLC-1gFf
	for kexec@lists.infradead.org;
	Wed, 01 Jul 2026 03:30:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782876626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YoMJdx5zn+YGKPIJdZfuaw6N0IusaD8A3j1a7ig86wQ=;
	b=Hr6h4hZC38QkoCQQ31vMEMKuwFQwzuWHRSMnaofauBpJhlcNwmnM4LycSbpPfysmdISteW
	a4ngr7fjl08whH4LxwbeHsirGSYM1qfDprlCiQpMKH+WQspxvxZQD7ED19bMjDBhePz56u
	xCn81YQrQkJXd5FwKt8r9j3VKP4n3cg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-euHPjotLMBW6VbGCJVMdEg-1; Tue, 30 Jun 2026 23:30:24 -0400
X-MC-Unique: euHPjotLMBW6VbGCJVMdEg-1
X-Mimecast-MFC-AGG-ID: euHPjotLMBW6VbGCJVMdEg_1782876624
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8e97889ac8aso2828396d6.3
        for <kexec@lists.infradead.org>; Tue, 30 Jun 2026 20:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782876624; x=1783481424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YoMJdx5zn+YGKPIJdZfuaw6N0IusaD8A3j1a7ig86wQ=;
        b=icksKRotf9iiwAMsH8eOxzeqo9fQV1V1XuZZhnTpKgUFFGyNyHrKUsOtULQdv3iOoo
         BWG+8zDFIDDF44VJefBqD2kfM03Gjx8JSBeSCctC6JwqWoVOdf2FiPHO7xgC+tTYXpoi
         MiQTWhXNG6652WbfiTeJDiimt34quE+lFJKieUR/qxFof7UVJtCBmJOVXa7sp3s9qYfx
         xYNo6WNraCCzIEcuRu0hT2yPU4fVRWOPhiIs3HivGAXfdQdKp73xVfKy9ssJHvUh2YjE
         8ZFaOJ/TRS0pFWgb+B8AVaGFiud3e/MPDqGiYS1xTxatMZPxaE3dNleRZaqRi2MfFHs5
         P6Ag==
X-Forwarded-Encrypted: i=1; AFNElJ/hntDkYcnNTEvSBQMKJ9D/SmTzNmmJ7W6DjF8yHU0q2VABdQF6sFQH/wL+hpYPs+iE+hpURg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzXapMEAc9jslZLHd+OD+9k6dwqqVoW9V33FriX70mNGxwna/ch
	cEGC98nVLhF2O2i5SYCGF/f5iW2S3nbYVPZlnu+pSdFz0SZNPtH1kiGSm4KRAO8dcZWJvlmslPf
	6PatS9+MfzVBsTeFCfX34PBq+aiJntz0BJ9OPia2c8YbWgzSBeNRC5fosG4lJQWhT6ssG3BPkX7
	Pqbme73xqqtXknQrAsUv9PgAmSW6LDS/vFt1jk
X-Gm-Gg: AfdE7clWlv1NLUdZ1GMx3VKquw4y9qQjyEvZiWuzdzecrqI7W9e6Kt8PNfH4Md65D3c
	ebEcloJWu4+I/Oy18Z1YA+g63rhHwJqNueEfwUUmra7DDKPQYuAh4WtTRP4dNjvPaVhtFAvDG4T
	9B3wFPBqEs1aKP+JSj0uxIXpP3z3Anl+nyiNJRg1cn1ATxsk+gRfZZocspmTNsTIGstw==
X-Received: by 2002:a05:622a:1491:b0:51b:ec5a:ec0f with SMTP id d75a77b69052e-51c26a78b2cmr68701cf.27.1782876623907;
        Tue, 30 Jun 2026 20:30:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1491:b0:51b:ec5a:ec0f with SMTP id
 d75a77b69052e-51c26a78b2cmr68181cf.27.1782876623221; Tue, 30 Jun 2026
 20:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260529032739.13264-2-ltao@redhat.com> <CAO7dBbW+LEy8SBGAKcrxEDzK5Xctw-r7ztgnXuURa9g0xntbtQ@mail.gmail.com>
 <CAP_BRoQEM8Re1dT7JNQgO72o50GAnb2y7R1HWPd+E772GVYAJg@mail.gmail.com> <2vxzh5mlk3bd.fsf@kernel.org>
In-Reply-To: <2vxzh5mlk3bd.fsf@kernel.org>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 1 Jul 2026 15:29:44 +1200
X-Gm-Features: AVVi8CdKF1AKTpYGlqKLlXqBd2QuDG30_C7t77l5Ewf9c6uDhUVIB40R85nEe14
Message-ID: <CAO7dBbXzs2pMrVuJ3qUVT2KYNh9RysOOWy_HPTmCY3gYUh9LDQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix a NULL pointer reference in machine_kexec_prepare
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	linux-integrity@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wIlznaWIvBzcNHgLgTp2k3Ib0mkgl7BLOsW5jLdiM8I_1782876624
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_203028_022693_BA2BF642 
X-CRM114-Status: GOOD (  33.06  )
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

Hi Pratyush,

On Mon, Jun 29, 2026 at 11:13=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> +Cc IMA maintainers
>
> On Fri, Jun 26 2026, Baoquan He wrote:
>
> > Add kexec ML to CC.
> >
> > On Fri, Jun 26, 2026 at 7:46=E2=80=AFAM Tao Liu <ltao@redhat.com> wrote=
:
> >>
> >> Kindly ping, any comments?
> >>
> >> Thanks,
> >> Tao Liu
> >>
> >> On Fri, May 29, 2026 at 3:35=E2=80=AFPM Tao Liu <ltao@redhat.com> wrot=
e:
> >> >
> >> > A NULL pointer reference issue is noticed in riscv's machine_kexec_p=
repare,
> >> > where image->segment[i].buf might be NULL and copied unchecked.
> >> >
> >> > The NULL buf comes from security/integrity/ima/ima_kexec.c:
> >> > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> >> > but kbuf.buffer is NULL.
> >> >
> >> > Fix this by simply adding a check before copy.
> >> >
> >> > Signed-off-by: Tao Liu <ltao@redhat.com>
> >> > ---
> >> >  arch/riscv/kernel/machine_kexec.c | 3 +++
> >> >  1 file changed, 3 insertions(+)
> >> >
> >> > diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/m=
achine_kexec.c
> >> > index 2306ce3e5f22..d81d576f9cb5 100644
> >> > --- a/arch/riscv/kernel/machine_kexec.c
> >> > +++ b/arch/riscv/kernel/machine_kexec.c
> >> > @@ -41,6 +41,9 @@ machine_kexec_prepare(struct kimage *image)
> >> >                 if (image->segment[i].memsz <=3D sizeof(fdt))
> >> >                         continue;
> >> >
> >> > +               if (image->segment[i].buf =3D=3D NULL)
> >> > +                       continue;
> >> > +
> >
> > This is a good fix, maybe we can add code comments to explain it as
> > below, just for reference.
> >
> >                /*
> >                 * Some segments (e.g. IMA) reserve space but have no bu=
ffer
> >                 * loaded yet. Skip them as they cannot contain an FDT.
> >                 */
> > And is there any other place where the similar issue exists? e.g on Loo=
ngArch?
> >
> > Other than above concerns, this patch looks good to me:
> >
> > Acked-by: Baoquan He <bhe@redhat.com>
>
> Yeah, the patch LGTM to me too.
>
> Acked-by: Pratyush Yadav <pratyush@kernel.org>
>
> Although I think IMA can make this a bit easier to understand. First, in
> ima_add_kexec_buffer() it should set kbuf.buffer to NULL and kbuf.bufsz
> to 0 explicitly instead of using kexec_buffer and kexec_buffer_size
> which are initialized to NULL and 0, but never updated. Using the
> variables here adds an extra level of indirection.
>
> Also, perhaps we should add a comment in ima_add_kexec_buffer() about
> how this all works, since where the IMA buffer lives and where it gets
> updated it fairly complicated and took me some time to piece together.

Thanks for your patch review and suggestions! I agree with your point
on the IMA part, I was confused by the code too, e.g in
ima_add_kexec_buffer():

void *kexec_buffer =3D NULL;
kbuf.buffer =3D kexec_buffer;
ret =3D kexec_add_buffer(&kbuf);
if (ret) {
    pr_err("Error passing over kexec measurement buffer.\n");
    vfree(kexec_buffer);
    return;
}

Do we need to vfree(kexec_buffer)? When kexec_buffer is NULL and seems
never get updated.

I'm not familiar with IMA code, maybe there is a reason which I'm unaware o=
f...

Thanks,
Tao Liu



>
> --
> Regards,
> Pratyush Yadav
>


