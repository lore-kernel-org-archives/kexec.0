Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB18AC369D9
	for <kexec@archiver.kernel.org>; Wed, 30 Apr 2025 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3590ZTEs1KQBIn7/bUpltm0Rsj0OLuG8mGosQsAgt0M=; b=sfLXk7rRmdEb9T5wX6wopfB0Qp
	71eQR/wkGOIaolkSW3w8rU5gNnz8H7KtUA3jSlpnx2Uh4b/GaFkBc8c5SNZ1ySwPBbk96Jxoy55qL
	BuZQRNiQya3RP1Cg3Zae3+asZLBp9DLHrbuwF2Qd+2fkgOmzYlEF/b9NcUOJoah5kTpJyk2mNH5TL
	J7SHoHqVMF5S6qz7XRYZ7utpnwvzIcbJciyEWP7PNXMOjOLlFXNQC72MnkMp4VxBbdxGuHgrcmljA
	gR+q0NbI7tsD5qzscARnRp+kVrnCkudii2iV9iysALUP8NP3GHNBNfwEHfL3kZcJSBATt5cPpEkjh
	tW31W7PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAA8h-0000000DPTi-2Wp0;
	Wed, 30 Apr 2025 16:18:27 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAA74-0000000DPDG-0uRc
	for kexec@lists.infradead.org;
	Wed, 30 Apr 2025 16:16:47 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso5736696f8f.2
        for <kexec@lists.infradead.org>; Wed, 30 Apr 2025 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746029804; x=1746634604; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3590ZTEs1KQBIn7/bUpltm0Rsj0OLuG8mGosQsAgt0M=;
        b=jvbNrqKJVIN/TPweNbRBYsJKr+ZtOYNKziIapreR7aaJwFLUJOwLhYqV0VKBhBuSiY
         N3z3OfgWJOSA9wZ6D7xVzzD8CT8eWDGGfT+3D/okNrmoPIFfS+P1nvJFEcGOmpBl4WuT
         llTU5i6YKBngrTut7Z55DliOFLyS9i4Uk8H46s3kK1MDNJKfF/NQWudW+NF4PxfGe3WF
         5sm9ZUcBomEx78l5zaKxNkAudRR+/capeyxR++pKhCuvS4vz+GdFp8+CAr9TDKBArELe
         mvhv1MRkg1j2pOa4bTmcm1azVDhlMIRDhLeeEW5v61EEEtf4vtX4Ryph7SeiO3dGkq0i
         jn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746029804; x=1746634604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3590ZTEs1KQBIn7/bUpltm0Rsj0OLuG8mGosQsAgt0M=;
        b=Bh/X6YkSXor2tpf8ucFf5NEo1U0RRlLmH/7ahHcTf9YVtO7hKDnaKPbRFUOQwPZiTt
         vlDV7zXyEgaucNGgdV7vqZR2ymEKbYo+eh8GxEMupRA6Ad6ZOM6SHcpdU3CVh/GfwSGe
         2CbHc1pnvXjjOKWd+L3bn+MzmSIdcrFe2hBxU9w3UKUbWq4XANqv2qbd0Cble3suGhVE
         xgpR0qVHDO4MFBYQDa6mSgcq+AK08dqgaYfdEYxV25rCsWP5AX+U0UQiIYdU90/cD24Z
         b9jEciplkLJxB61tCGzqGqb6xTYrjPk5k2+8KnR7uDcEYUV5D5FCKbGwew1AGxDMzYEt
         S6Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUwlHeQ8j/RfS6galPdUM7zbXVGrORVoZJVwVQj3vFNPU+e9hoszrmcKoIFnqhhS8IX0GodCg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwM15YDSLJCqUsTSBQi/UregmiaLdewcxZMtWIZAazLrCYFlFqP
	ZMW8sE5izhfW2artpQ8DYjJHXpbAFLY3IP5y+DC0qWd9274UthIXTmqf021Ax4QF5ZJWrB1LsZ8
	JsRIEF0bNXosmF6lUc3uRvRtuIZM3cNxW
X-Gm-Gg: ASbGncsQsaOHczSDrUUauPiwBhc39DeMdXqm8WaWVoX2+RD4zYobwg7tsdvBnnCBcau
	qBkoMOftDwoa02QvzwmqRJfukgkcLP+IhIE+RQuNjbeXHmZqt/7vHjGLFSXiu6NdE39Qbb2r67U
	Isr61QaEqavZh1sI7WbdCC65ovuo3eUaZVBtqPLw==
X-Google-Smtp-Source: AGHT+IFa3hD6lwquR+V15y8m8bVYpmDiRkw0CRecmk957X0nkqCeaL9RjOVg6KsxGxdhNb7J8rf28XKNzRHVMnQoRmM=
X-Received: by 2002:a05:6000:184b:b0:39c:2688:612b with SMTP id
 ffacd0b85a97d-3a08f75379fmr3711555f8f.7.1746029804276; Wed, 30 Apr 2025
 09:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250429041214.13291-1-piliu@redhat.com> <20250429041214.13291-5-piliu@redhat.com>
 <CAADnVQKTSubuisSBap_J=tgO15fCdtwF-NDY_1HLP_m6o28mhw@mail.gmail.com> <CAF+s44QM55AtGyquKvj0XAzZAjOii7VJYWsGD50iK3+r6GZSmg@mail.gmail.com>
In-Reply-To: <CAF+s44QM55AtGyquKvj0XAzZAjOii7VJYWsGD50iK3+r6GZSmg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 30 Apr 2025 09:16:32 -0700
X-Gm-Features: ATxdqUGB48vHpPeEdU_NX4frkjCUrtyGmy_6ByixlEaL_MFEjQG9XKezXmBp5zs
Message-ID: <CAADnVQKKr7C+eRin=efg5umLumghGfYJst2MwDwpB5bEtt4rSA@mail.gmail.com>
Subject: Re: [RFCv2 4/7] bpf/kexec: Introduce three bpf kfunc for kexec
To: Pingfan Liu <piliu@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_091646_255877_7D577200 
X-CRM114-Status: GOOD (  24.71  )
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

On Wed, Apr 30, 2025 at 3:47=E2=80=AFAM Pingfan Liu <piliu@redhat.com> wrot=
e:
>
> On Wed, Apr 30, 2025 at 8:04=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Apr 28, 2025 at 9:13=E2=80=AFPM Pingfan Liu <piliu@redhat.com> =
wrote:
> >  +__bpf_kfunc struct mem_range_result *bpf_kexec_decompress(char
> > *image_gz_payload, int image_gz_sz,
> > > +                       unsigned int expected_decompressed_sz)
> > > +{
> > > +       decompress_fn decompressor;
> > > +       //todo, use flush to cap the memory size used by decompressio=
n
> > > +       long (*flush)(void*, unsigned long) =3D NULL;
> > > +       struct mem_range_result *range;
> > > +       const char *name;
> > > +       void *output_buf;
> > > +       char *input_buf;
> > > +       int ret;
> > > +
> > > +       range =3D kmalloc(sizeof(struct mem_range_result), GFP_KERNEL=
);
> > > +       if (!range) {
> > > +               pr_err("fail to allocate mem_range_result\n");
> > > +               return NULL;
> > > +       }
> > > +       refcount_set(&range->usage, 1);
> > > +
> > > +       input_buf =3D vmalloc(image_gz_sz);
> > > +       if (!input_buf) {
> > > +               pr_err("fail to allocate input buffer\n");
> > > +               kfree(range);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       ret =3D copy_from_kernel_nofault(input_buf, image_gz_payload,=
 image_gz_sz);
> > > +       if (ret < 0) {
> > > +               pr_err("Error when copying from 0x%px, size:0x%x\n",
> > > +                               image_gz_payload, image_gz_sz);
> > > +               kfree(range);
> > > +               vfree(input_buf);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       output_buf =3D vmalloc(expected_decompressed_sz);
> > > +       if (!output_buf) {
> > > +               pr_err("fail to allocate output buffer\n");
> > > +               kfree(range);
> > > +               vfree(input_buf);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       decompressor =3D decompress_method(input_buf, image_gz_sz, &n=
ame);
> > > +       if (!decompressor) {
> > > +               pr_err("Can not find decompress method\n");
> > > +               kfree(range);
> > > +               vfree(input_buf);
> > > +               vfree(output_buf);
> > > +               return NULL;
> > > +       }
> > > +       //to do, use flush
> > > +       ret =3D decompressor(image_gz_payload, image_gz_sz, NULL, NUL=
L,
> > > +                               output_buf, NULL, NULL);
> > > +
> > > +       /* Update the range map */
> > > +       if (ret =3D=3D 0) {
> > > +               range->buf =3D output_buf;
> > > +               range->size =3D expected_decompressed_sz;
> > > +               range->status =3D 0;
> > > +       } else {
> > > +               pr_err("Decompress error\n");
> > > +               vfree(output_buf);
> > > +               kfree(range);
> > > +               return NULL;
> > > +       }
> > > +       pr_info("%s, return range 0x%lx\n", __func__, range);
> > > +       return range;
> > > +}
> >
> > These kfuncs look like generic decompress routines.
> > They're not related to kexec and probably should be in kernel/bpf/helpe=
rs.c
> > or kernel/bpf/compression.c instead of kernel/kexec_pe_image.c.
> >
>
> Thanks for your suggestion. I originally considered using these kfuncs
> only in kexec context (Later, introducing a dedicated BPF_PROG_TYPE
> for kexec).

We do not add new prog types anymore.
They're frozen just like the list of helpers.

> They are placed under a lock so that a malice attack can
> not exhaust the memory through repeatedly calling to the decompress
> kfunc.

attack? This is all root only anyway and all memory is counted
towards memcg.
Make sure to use GFP_KERNEL_ACCOUNT and something similar
to bpf_map_get_memcg.

> To generalize these kfunc, I think I can add some boundary control of
> the memory usage to prevent such attacks.

Don't reinvent the wheel. memcg is the mechanism.

> > They also must be KF_SLEEPABLE.
> > Please test your patches with all kernel debugs enabled.
> > Otherwise you would have seen all these "sleeping while atomic"
> > issues yourself.
> >
>
> See, I will have all these debug options for the V3 test.
>
> Appreciate your insight.
>
> Regards,
>
> Pingfan
>

