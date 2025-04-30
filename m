Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9746C369D9
	for <kexec@archiver.kernel.org>; Wed, 30 Apr 2025 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cWnivOs9W4+XLyEImwujBJd1shwdicbALn9+s1Jc+yg=; b=1eVKSsEnOyD2F4lDixEPrk3toy
	5azhmgT4/3PAjb4Q0xlfo0SgJoJcBebArIzDBgks+4aghLfoYZQQN2Nl0GRJJZUtDK76Hv4YzUeZD
	yI2619pF1sWDXgKbiFUFgapfgSOLSf+hFvmqNUy+BUdqtZc6idLFYszp1T+cI1hmrrFf0rVmyag//
	o19f7UBaxzwc7WKSzSrGNsgCEpBCjN34PK7FcMCWj/O+aXBqMX9AMnGU3YExZGQfCmaNQlZxyqp4+
	WPRocMM6bPUvFrjUEyXglf4LsiUQwFYd16xYZV8hZB+N9GZKlgTD/U4yfWVVQsS7hce47/+bAuCP3
	MrUF8Jcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA5gl-0000000ChUR-1f43;
	Wed, 30 Apr 2025 11:33:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA4yI-0000000CaTU-2NJf
	for kexec@lists.infradead.org;
	Wed, 30 Apr 2025 10:47:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746010039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWnivOs9W4+XLyEImwujBJd1shwdicbALn9+s1Jc+yg=;
	b=RekcL09BJB5ldj8D/V1cU+Dj6HOUBqi3Y17l3bT1StDz2SGw8e+CvW+0IJdCESvfNcOuBw
	DQRzpZIy4CCRuyTtFNODdiSTVfYPJf6lbH3EmjiYHDfwwvgIzAmd7jtdonu2pSYaBGRtQD
	BFxVpwZVlqFjDskXuvOclDgbNzuQV/I=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-XAILIWrROYKogY0kqAxVhw-1; Wed, 30 Apr 2025 06:47:18 -0400
X-MC-Unique: XAILIWrROYKogY0kqAxVhw-1
X-Mimecast-MFC-AGG-ID: XAILIWrROYKogY0kqAxVhw_1746010037
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b0e0c573531so4329562a12.3
        for <kexec@lists.infradead.org>; Wed, 30 Apr 2025 03:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746010037; x=1746614837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWnivOs9W4+XLyEImwujBJd1shwdicbALn9+s1Jc+yg=;
        b=TrDehc/up6/754ouXVkc515OTJz6YQL+vzNRUdIY/Oz9vwPQ5NggqFyqQSB2jfMP9o
         ZWFvbDp4lODEgrAkwasKcn0d5N7UeHOyAw0HnayV+JanZv5sfZRuKrAlVV0gUhWU0exV
         f6xqtqdDD9XZ/u1i25hlH2bw+EehGd2oJ207ylir7zXp1QVp/pV1G9WCNT6ASmAbf9rQ
         gRic/7EFaumGdFy8jUgIlStWaWdNmV0ZQ4URBOwHaV9V/0BAQGvWnVGP4RlHoXLVjaBr
         Dwaakj9eJ8lVv92aucl+OKt2V/0EOl+n5zevXIbSVxj+xI6fEDPLcj3cBKZ/vdmUrpcO
         Qm6w==
X-Forwarded-Encrypted: i=1; AJvYcCXefBp/3nwKWAKUm9vJOyAEh+jxyVllIQWIiW54EyPXcL0T8pzLkSKVBU7l4B4mfCLCCvZZ6A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxZW+Nfa9lYHoVtf73lZpYKd04N++J6bDPrdenzQpxABFkSzipT
	xQ7S/IHa/jKFr87NasWqN+qiPfxlXYrlWXwki9wI2KlSPcHfQyVVyNvUB452FnprhlEFkzEl2I9
	NmXKRJVNHdWmwIyKDwTDLg9aEr7iNtuNysaEkX1yfXJhKHS4Xz7+KBJlZGQZoChDYPyhOSVHaEv
	la9Ep0QO1hoqG3lnfDtKHtEYwFcYxj0Ozw
X-Gm-Gg: ASbGncv7GoXQ9RDslFJfe35Z3sOc75KRZUU2dvl5XItXr+ZKhOzuiPixleSnJlO7ixb
	AW/1B0jvSBOoivnm7RY4i5x02m6OvYAPv7+xV0zqGWkXVKuvtJhfozJswihlX2yFC+gpXxw==
X-Received: by 2002:a17:90b:1cc8:b0:30a:fe:140f with SMTP id 98e67ed59e1d1-30a3335f481mr3880084a91.28.1746010037366;
        Wed, 30 Apr 2025 03:47:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5jQrm0WkaSuZ2pViWj2b9YtpHy88CCKCiVNRceMWGHYFLhtTmS/1fHotBLW4tYXZnPDikg1DTTIqp4/y5PJk=
X-Received: by 2002:a17:90b:1cc8:b0:30a:fe:140f with SMTP id
 98e67ed59e1d1-30a3335f481mr3880048a91.28.1746010036979; Wed, 30 Apr 2025
 03:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250429041214.13291-1-piliu@redhat.com> <20250429041214.13291-5-piliu@redhat.com>
 <CAADnVQKTSubuisSBap_J=tgO15fCdtwF-NDY_1HLP_m6o28mhw@mail.gmail.com>
In-Reply-To: <CAADnVQKTSubuisSBap_J=tgO15fCdtwF-NDY_1HLP_m6o28mhw@mail.gmail.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Wed, 30 Apr 2025 18:47:05 +0800
X-Gm-Features: ATxdqUHf-cFpaHNGaQnpHjY7Ol3gt6Pz5b1rkhWQt0CgtYPAvEmCJ_bnsVUsKMQ
Message-ID: <CAF+s44QM55AtGyquKvj0XAzZAjOii7VJYWsGD50iK3+r6GZSmg@mail.gmail.com>
Subject: Re: [RFCv2 4/7] bpf/kexec: Introduce three bpf kfunc for kexec
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kexec@lists.infradead.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aU7ZBQsx8F-R9KV6EsBzQTkMv9wdmT-elBnL-ulD2-M_1746010037
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_034722_691983_D45D185C 
X-CRM114-Status: GOOD (  19.71  )
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

On Wed, Apr 30, 2025 at 8:04=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 28, 2025 at 9:13=E2=80=AFPM Pingfan Liu <piliu@redhat.com> wr=
ote:
>  +__bpf_kfunc struct mem_range_result *bpf_kexec_decompress(char
> *image_gz_payload, int image_gz_sz,
> > +                       unsigned int expected_decompressed_sz)
> > +{
> > +       decompress_fn decompressor;
> > +       //todo, use flush to cap the memory size used by decompression
> > +       long (*flush)(void*, unsigned long) =3D NULL;
> > +       struct mem_range_result *range;
> > +       const char *name;
> > +       void *output_buf;
> > +       char *input_buf;
> > +       int ret;
> > +
> > +       range =3D kmalloc(sizeof(struct mem_range_result), GFP_KERNEL);
> > +       if (!range) {
> > +               pr_err("fail to allocate mem_range_result\n");
> > +               return NULL;
> > +       }
> > +       refcount_set(&range->usage, 1);
> > +
> > +       input_buf =3D vmalloc(image_gz_sz);
> > +       if (!input_buf) {
> > +               pr_err("fail to allocate input buffer\n");
> > +               kfree(range);
> > +               return NULL;
> > +       }
> > +
> > +       ret =3D copy_from_kernel_nofault(input_buf, image_gz_payload, i=
mage_gz_sz);
> > +       if (ret < 0) {
> > +               pr_err("Error when copying from 0x%px, size:0x%x\n",
> > +                               image_gz_payload, image_gz_sz);
> > +               kfree(range);
> > +               vfree(input_buf);
> > +               return NULL;
> > +       }
> > +
> > +       output_buf =3D vmalloc(expected_decompressed_sz);
> > +       if (!output_buf) {
> > +               pr_err("fail to allocate output buffer\n");
> > +               kfree(range);
> > +               vfree(input_buf);
> > +               return NULL;
> > +       }
> > +
> > +       decompressor =3D decompress_method(input_buf, image_gz_sz, &nam=
e);
> > +       if (!decompressor) {
> > +               pr_err("Can not find decompress method\n");
> > +               kfree(range);
> > +               vfree(input_buf);
> > +               vfree(output_buf);
> > +               return NULL;
> > +       }
> > +       //to do, use flush
> > +       ret =3D decompressor(image_gz_payload, image_gz_sz, NULL, NULL,
> > +                               output_buf, NULL, NULL);
> > +
> > +       /* Update the range map */
> > +       if (ret =3D=3D 0) {
> > +               range->buf =3D output_buf;
> > +               range->size =3D expected_decompressed_sz;
> > +               range->status =3D 0;
> > +       } else {
> > +               pr_err("Decompress error\n");
> > +               vfree(output_buf);
> > +               kfree(range);
> > +               return NULL;
> > +       }
> > +       pr_info("%s, return range 0x%lx\n", __func__, range);
> > +       return range;
> > +}
>
> These kfuncs look like generic decompress routines.
> They're not related to kexec and probably should be in kernel/bpf/helpers=
.c
> or kernel/bpf/compression.c instead of kernel/kexec_pe_image.c.
>

Thanks for your suggestion. I originally considered using these kfuncs
only in kexec context (Later, introducing a dedicated BPF_PROG_TYPE
for kexec). They are placed under a lock so that a malice attack can
not exhaust the memory through repeatedly calling to the decompress
kfunc.

To generalize these kfunc, I think I can add some boundary control of
the memory usage to prevent such attacks.

> They also must be KF_SLEEPABLE.
> Please test your patches with all kernel debugs enabled.
> Otherwise you would have seen all these "sleeping while atomic"
> issues yourself.
>

See, I will have all these debug options for the V3 test.

Appreciate your insight.

Regards,

Pingfan


