Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B53BC3ABA5
	for <kexec@archiver.kernel.org>; Wed, 30 Apr 2025 00:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U1KeXJR1hOzBjZTqW+K21z7sqJwFRtjxFIgXNhmbOqs=; b=wwLtXqt4Ban4PHWft15i0ry7O9
	qK7W+vCYikvbT97cTBVEinsnaw/qZJ44e064cFIiChabKsJvCqy6CFoiqYBmdQbBlnCc5X7v37vbB
	Mu2Bl5EOeqEt1upAkO6Mby56hZlQWJy7sZ6eAI6hQGAH0WYg7hDwFJ+M/fAh6o4/4ux7+H3TnvVoW
	dkb4Z6pJ/+jLIivrqXrtsLD9aeXi6SrIS9A/2T0+0L6Us5kbaS3P4pHL8B0VD/al9K4+ZkdYIcWfT
	PouPL8NwO6XH0rP8bbNNzuWocXDu+Llkm6GoNUKkgATHQifyC88CzFIkKszgyiyeZ0YiTu7bODBsc
	woEk1BJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9uvv-0000000BD1F-2SLy;
	Wed, 30 Apr 2025 00:04:15 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9uvt-0000000BCzv-2GBl
	for kexec@lists.infradead.org;
	Wed, 30 Apr 2025 00:04:14 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-39c14016868so6879269f8f.1
        for <kexec@lists.infradead.org>; Tue, 29 Apr 2025 17:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745971451; x=1746576251; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1KeXJR1hOzBjZTqW+K21z7sqJwFRtjxFIgXNhmbOqs=;
        b=inmr85DE4tZDTIlweeuen1BVQYUU75eWrThfAN6mxGgjDPebEmGtElJG68BjfJZ3Ya
         nzMVJ8qddjz3h60MeizY/DnBcGnsPPkrvNfDjcYsBPhpXZMz0+eb9QD5Tg6BnnNBHtN6
         0SJChZoWPUGIjCwGykT3gQ7AxAH/dlpBsQgxpZH0qkd1shbrV+JN2B6xp4lMAzg//3q4
         pjeEGD/gzlgtQulgUUj0t7ZpJRYlLSFp7ld/IBrXUJx1VScNEllsoJEWIj00yid1iV6+
         ze2GRHlWJZL1wt7UMsShqmNuflgaysmjF7zJFxKhG7g9hRvu7RhAfRjdHdtBcH5nYASv
         n3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971451; x=1746576251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1KeXJR1hOzBjZTqW+K21z7sqJwFRtjxFIgXNhmbOqs=;
        b=E2qje7RuPATipRNyAnDpX4syW9k/FCqvWE65h6BtmQsZcxZ/dBc1+TWC6zJc/aN0BM
         7oBbhbcNXaweKz2Y+Acn62hesRWVWOWRVWQ6d2j7oRZvMQPB9vEtwtKBatg3lBNI/CBa
         LG1aF20rgKLGfpnc8/2cTjYoOOM6aqZexUVspiYI1i+q8smQFR/uy/EAcf0FdXFNBvfv
         PKm+p8YK0wSkoliMfojMnmuNjQIE+NWTQOMWN9fBG7xPVN9XxcBZCXC3SdeJQ92jY0k6
         mkDxFCn1v0C5eIR6JpozsU4kozDk633ww172xsy3w9xj99SbReyP1BIp8hYrqRadG1iO
         +deg==
X-Forwarded-Encrypted: i=1; AJvYcCUqZ83vdPfTHUaE+31VsJ66CMH9FecvJq/cm4XLaE8LBrUtKRsVgsBX4ZeDaTWL3eDSSb8c+w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6K1PjZYUZ9QOBmFXXTpsTOjKF0fm6rhSE4ktUvqVIlWHLRLfm
	B1VrLDFkjpV6uoXTqCQBkh/4i7b9UO9UC1JJUe7ly8foyyNMN0pXDBx1nnJXZcS4+g3QlKZhUc0
	5K4tl5+fWWdkq4OZCYNG58lsCUk8=
X-Gm-Gg: ASbGncvtGdfWriZuI8G1/fa391CGn2qQZT5PERviC0lY3o0JhdFJOhxIBH5FWhhlzcc
	7m9o40aPDqxXFPs2VktHRuyO+/ob/sNV0vxP2Mbi13sgD6Wpz43kq37H6+7XMIz97rXwAifMpEI
	nAYTREOBIGqLrYY25v2QXuRRfhUnxSJJsS0Hhtew==
X-Google-Smtp-Source: AGHT+IEp4MiLtY0qKxS6UrNJvJKT1oFoIU9/fZqZHU+KWT51EHruQ+vwvp7Oizo6pEuXIEHqkQtR0PijT/tOG5eXN8o=
X-Received: by 2002:a05:6000:2282:b0:39e:f9e8:d07d with SMTP id
 ffacd0b85a97d-3a08f764d93mr924789f8f.20.1745971451027; Tue, 29 Apr 2025
 17:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250429041214.13291-1-piliu@redhat.com> <20250429041214.13291-5-piliu@redhat.com>
In-Reply-To: <20250429041214.13291-5-piliu@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 29 Apr 2025 17:03:59 -0700
X-Gm-Features: ATxdqUFdIYrUp0QWhy9gP5VNKqfBVnewOUvIA7LbeFFyzs8budADNuJnnCReKHU
Message-ID: <CAADnVQKTSubuisSBap_J=tgO15fCdtwF-NDY_1HLP_m6o28mhw@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20250429_170413_575100_BB260E4A 
X-CRM114-Status: GOOD (  13.97  )
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

On Mon, Apr 28, 2025 at 9:13=E2=80=AFPM Pingfan Liu <piliu@redhat.com> wrot=
e:
 +__bpf_kfunc struct mem_range_result *bpf_kexec_decompress(char
*image_gz_payload, int image_gz_sz,
> +                       unsigned int expected_decompressed_sz)
> +{
> +       decompress_fn decompressor;
> +       //todo, use flush to cap the memory size used by decompression
> +       long (*flush)(void*, unsigned long) =3D NULL;
> +       struct mem_range_result *range;
> +       const char *name;
> +       void *output_buf;
> +       char *input_buf;
> +       int ret;
> +
> +       range =3D kmalloc(sizeof(struct mem_range_result), GFP_KERNEL);
> +       if (!range) {
> +               pr_err("fail to allocate mem_range_result\n");
> +               return NULL;
> +       }
> +       refcount_set(&range->usage, 1);
> +
> +       input_buf =3D vmalloc(image_gz_sz);
> +       if (!input_buf) {
> +               pr_err("fail to allocate input buffer\n");
> +               kfree(range);
> +               return NULL;
> +       }
> +
> +       ret =3D copy_from_kernel_nofault(input_buf, image_gz_payload, ima=
ge_gz_sz);
> +       if (ret < 0) {
> +               pr_err("Error when copying from 0x%px, size:0x%x\n",
> +                               image_gz_payload, image_gz_sz);
> +               kfree(range);
> +               vfree(input_buf);
> +               return NULL;
> +       }
> +
> +       output_buf =3D vmalloc(expected_decompressed_sz);
> +       if (!output_buf) {
> +               pr_err("fail to allocate output buffer\n");
> +               kfree(range);
> +               vfree(input_buf);
> +               return NULL;
> +       }
> +
> +       decompressor =3D decompress_method(input_buf, image_gz_sz, &name)=
;
> +       if (!decompressor) {
> +               pr_err("Can not find decompress method\n");
> +               kfree(range);
> +               vfree(input_buf);
> +               vfree(output_buf);
> +               return NULL;
> +       }
> +       //to do, use flush
> +       ret =3D decompressor(image_gz_payload, image_gz_sz, NULL, NULL,
> +                               output_buf, NULL, NULL);
> +
> +       /* Update the range map */
> +       if (ret =3D=3D 0) {
> +               range->buf =3D output_buf;
> +               range->size =3D expected_decompressed_sz;
> +               range->status =3D 0;
> +       } else {
> +               pr_err("Decompress error\n");
> +               vfree(output_buf);
> +               kfree(range);
> +               return NULL;
> +       }
> +       pr_info("%s, return range 0x%lx\n", __func__, range);
> +       return range;
> +}

These kfuncs look like generic decompress routines.
They're not related to kexec and probably should be in kernel/bpf/helpers.c
or kernel/bpf/compression.c instead of kernel/kexec_pe_image.c.

They also must be KF_SLEEPABLE.
Please test your patches with all kernel debugs enabled.
Otherwise you would have seen all these "sleeping while atomic"
issues yourself.

