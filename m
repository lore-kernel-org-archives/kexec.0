Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D72C3ABBC
	for <kexec@archiver.kernel.org>; Tue,  6 May 2025 05:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Thda7S7fTrK58T1VG3G41HE8TXjtD6eOvBZWs1UCRo=; b=gytjXjxW1ke9nbZHl7+HpqAkcf
	ljLBCM2SlTYKpLVnk7AvFsK1yotSOxwuLraV1qdqVP17HDGTRhy4BS8N5HOgH6h3/9ZPbNoZ+hPZc
	P6ij2stXgCNgAIfZ7vN7xX0RGkOfIA0LNTo/evs8QM+HrrI4JWr1goNcLlgo9pPNBWVl/qFysu+uH
	gWJJTAFMYlZZF+JvSZFKin+nIczRv0JdKpYgsQ9r1v+dMgybu0KtnDFRk3ooAjvPTpM7WUDfuVMuk
	qkHjgjwK6STnt7QVQy4o8gIC6YzaCoJNUm7/gxiL6O2toVc9ZGBRS4A2cGFew2Co5FIB8ovQPIvaL
	4TOyYbaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCAco-0000000ANyZ-1atv;
	Tue, 06 May 2025 05:13:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC6K0-00000009KLM-1yq4
	for kexec@lists.infradead.org;
	Tue, 06 May 2025 00:38:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746491885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Thda7S7fTrK58T1VG3G41HE8TXjtD6eOvBZWs1UCRo=;
	b=WkhlNU5QVndDC7El/Halqpyc7S7sarii0ef2MKnioZEEv7iMyHaPrxEV1FgE7qUiF8tSrv
	XNuJ4aGVRQUKnxCOiSKcru5msu3dDTIgPw6fh4zyPyCgbj7HJTkVlmF8UIKvGMVaiBd3S/
	d402YGahYQ6J6VcdufpRgmjdAGeKwEQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-3xRPMHnwNT20hHUMG5wNsw-1; Mon, 05 May 2025 20:38:02 -0400
X-MC-Unique: 3xRPMHnwNT20hHUMG5wNsw-1
X-Mimecast-MFC-AGG-ID: 3xRPMHnwNT20hHUMG5wNsw_1746491882
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso4467000a91.2
        for <kexec@lists.infradead.org>; Mon, 05 May 2025 17:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746491881; x=1747096681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Thda7S7fTrK58T1VG3G41HE8TXjtD6eOvBZWs1UCRo=;
        b=jY+oAPMxEI9RwItmOreuZsMTXwXpwfux61SJW6ObHg0b7BfaW1iyZEk66egyYnl8z8
         qFvZKdJf61W0xIA9luHSFVIUCqYNJajWMkrKhrylocE/uOcVLtgK63/KL+T/v4qyMlP4
         o5CN7NaCfDfZhJtqEqQHMcUUG4OtAYF4MyEHKBayWhCglPtAUOYKaeo4dpqRQp3bMGtN
         ZY2nGg52QYPTwuq6wPd7ZrrpXXADYQPsuqO5HfdDOdalvXKzzH290Ps1Mo/nXuYs66j6
         DsRGjDfmxvOjNfZEGtZ/YyJQWXyl4/yvG+zpo0gfKfS8hj0pw0Ecoy2K+Y7tcap+IGYY
         Hucw==
X-Forwarded-Encrypted: i=1; AJvYcCURRhKm+Ex9VLo470k8jk1co9xXjADiI49LYizHdP/WJCG5Ow+PkG479fdG5qRpaZnBvRPACw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwEEmODxnyg9BPNONLN/IevAGisKffWMV0Ub4GgxipTw92RXhqy
	A+oPZYCIi/ufkwGYcEKeAID+N24RSUtqh8bQMh+EQDuTCoi78s3v65Uh+2IXpVD3t8e5zIrFKD7
	9Dy+fUcg4VQF6nkl4nM+NX/MV/7IO6OfhGqpref8MAMxlUH5mlxwcrV9AOR0ovgrdbgamFtXZz9
	FUG0W0CGzE2Rj2SKxrJjwzgZyEgYrgLtSI
X-Gm-Gg: ASbGncvU7O46cIWJz/IAWyOAweDQ3fEkIW2SsMRaxsp5v4+j8QZvCvRjfW1ufgWjk0J
	H0/Y0Tz5YW30bHtb2L61GBx+G8if3/7fbqfV6099uT0Q8sstzR0sv6UrYd9lQNMAqcfV/ug==
X-Received: by 2002:a17:90a:e706:b0:306:b78a:e22d with SMTP id 98e67ed59e1d1-30a619a1979mr13444689a91.20.1746491881638;
        Mon, 05 May 2025 17:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq92lKdPDOjXTASCfCpZmgjp6GAkt6aAzy0xoeRkNlGPRkJ1vsPpEtKqMuRudM0xPVKmHs5+Hmx/dzYXboDxY=
X-Received: by 2002:a17:90a:e706:b0:306:b78a:e22d with SMTP id
 98e67ed59e1d1-30a619a1979mr13444646a91.20.1746491881257; Mon, 05 May 2025
 17:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250429041214.13291-1-piliu@redhat.com> <20250429041214.13291-5-piliu@redhat.com>
 <CAADnVQKTSubuisSBap_J=tgO15fCdtwF-NDY_1HLP_m6o28mhw@mail.gmail.com>
 <CAF+s44QM55AtGyquKvj0XAzZAjOii7VJYWsGD50iK3+r6GZSmg@mail.gmail.com> <CAADnVQKKr7C+eRin=efg5umLumghGfYJst2MwDwpB5bEtt4rSA@mail.gmail.com>
In-Reply-To: <CAADnVQKKr7C+eRin=efg5umLumghGfYJst2MwDwpB5bEtt4rSA@mail.gmail.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 6 May 2025 08:37:50 +0800
X-Gm-Features: ATxdqUFuTVAhoinefB-V1imhTA7ZCVA5NjxlNSYorcyBkyCWXUw-XhLHlUTVcvc
Message-ID: <CAF+s44RC4UfSwckLR6tHJo=Owv8jvaBp-wN3PRGbYC3G3EoHYg@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: Lvp8kI8Oj--Y3ZbSOByWylG6VF8YgK4_1B0SiVXRIWc_1746491882
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_173808_583436_3A539CCF 
X-CRM114-Status: GOOD (  20.84  )
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

Hi Alexei,

Sorry to reply late since I just got back from holiday.

On Thu, May 1, 2025 at 12:16=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Apr 30, 2025 at 3:47=E2=80=AFAM Pingfan Liu <piliu@redhat.com> wr=
ote:
> >
> > On Wed, Apr 30, 2025 at 8:04=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
[...]

> >
> > Thanks for your suggestion. I originally considered using these kfuncs
> > only in kexec context (Later, introducing a dedicated BPF_PROG_TYPE
> > for kexec).
>
> We do not add new prog types anymore.
> They're frozen just like the list of helpers.
>

Got it.

> > They are placed under a lock so that a malice attack can
> > not exhaust the memory through repeatedly calling to the decompress
> > kfunc.
>
> attack? This is all root only anyway and all memory is counted
> towards memcg.
> Make sure to use GFP_KERNEL_ACCOUNT and something similar
> to bpf_map_get_memcg.
>

Your clarification makes sense. I will follow that guide.

> > To generalize these kfunc, I think I can add some boundary control of
> > the memory usage to prevent such attacks.
>
> Don't reinvent the wheel. memcg is the mechanism.
>

Sure. Thanks for your insight. It is helpful.

Best Regards,

Pingfan

> > > They also must be KF_SLEEPABLE.
> > > Please test your patches with all kernel debugs enabled.
> > > Otherwise you would have seen all these "sleeping while atomic"
> > > issues yourself.
> > >
> >
> > See, I will have all these debug options for the V3 test.
> >
> > Appreciate your insight.
> >
> > Regards,
> >
> > Pingfan
> >
>


