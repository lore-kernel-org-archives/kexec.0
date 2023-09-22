Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD0FE7D0B4
	for <kexec@archiver.kernel.org>; Fri, 22 Sep 2023 05:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EmD0OePyPhbDc/CBgTean/pFAqM0ILy6vSa7W+xLCkk=; b=W8wKRC+pl446mU
	9r3xDwMECZ7X1OTwVJ4khrXeRfrGun9xImbHmy1Ejx63NIDPCubfiGVh6jI3C2wI2V9dZYTFatetq
	OdwAdygQ7Tlj+4Xiw8zqQmMVtd+Ka+ZpcjKJaVsAGDL8ZIx6PO+bFzQ1SYJPKDi4nbYKj1cRpNEFW
	GFaxOwwMmbuxmlCUNO3+RAAzVBfa/OOTL3rNayIm8dItP7uCiUnYnTsxP87oJnWZ4WGLeoA51msZ8
	Z3RLb9WYEEVYwaNwMsAVX2749KLbl2irJzXNh7UbT1BHP7mDdmmQ8sM0XSux2EOt2E78Ltx/bkNDj
	aSe9AakVhZGXBPSsojvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjYvI-007wQJ-0o;
	Fri, 22 Sep 2023 05:41:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjYvE-007wOg-2V
	for kexec@lists.infradead.org;
	Fri, 22 Sep 2023 05:41:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695361304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w1g43mhqJbkov4+o/9sy0UqgCm25IRVOc1Rtq6HxOfs=;
	b=Wq9C4/aiZZ3GjNdhyyiVCUu/hBWE3NNTxN2KKLx0iat5fdd8S7ZPgd2s4/eLH0h+gbJjel
	lLAc0fcK8JKjMWTPAA6p6kgGAZ5mEz8Jxm0+1uLciJ1w0OY6GgTv4u1AxOw4cFHPy9XM+F
	6yw5s0fYd1Hcp/hanxvBtEmaABRsfyI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-25gTRXVMPTCfruWTKgaxrA-1; Fri, 22 Sep 2023 01:41:43 -0400
X-MC-Unique: 25gTRXVMPTCfruWTKgaxrA-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-79f97da1589so12544539f.1
        for <kexec@lists.infradead.org>; Thu, 21 Sep 2023 22:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695361302; x=1695966102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1g43mhqJbkov4+o/9sy0UqgCm25IRVOc1Rtq6HxOfs=;
        b=T6IfLLiuOuQHc1rBOd1fNYY3z7/EEVIr0ezDn2KIIYqbUZx1YWFq6COBX/Sa3sNyuD
         r/IWJcmhueDU+8HhYXUM02Mp964cHPhvRmdfSqRbspXL1b/ovIKi6a27ABwkHORNRGaR
         382NvmpLsI9ki6k+5y/V/EU60G5iX6OS9Lv1dre+DtJt5MN31/sj3SeMoaDsZY2ja5iW
         A2E5rPTl/bKqCuF9FT8ZGoQ2vLS9QppyG8p6KAIFQDHI0iOEE8jXQ4vZIwfNt0uBNfEl
         vf8JhfHVnEGP1BZed1tmRRojgbm0cn6PeDEcWqcB3ebM/dKr1TmOc3VFLVhWXSElUOph
         Z71A==
X-Gm-Message-State: AOJu0YzIrvh1C8cB6GmNQiym+ZSMshn6SJIbIA6oyfHKM2OoTERPk4kA
	aPpaaqPMS/xfuiMOngNLb3Cghg6tORoZB3I7E3lMPX3E5Vk3q9RiwuO0fhoQZaxyJAu+sgoHQAZ
	a227Uh62p7OtcYOBC2seTvx9knMmWJLGoAvhC
X-Received: by 2002:a05:6e02:78e:b0:34e:2a69:883c with SMTP id q14-20020a056e02078e00b0034e2a69883cmr8337972ils.1.1695361302700;
        Thu, 21 Sep 2023 22:41:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7U4ewOt9pYuaiF1z9N4YP0emAqNw0+efBuWJO/E+lbDyczzOUW+FIWgqK+FH1Y4BNMPXHNG22j7U9dWvcSwI=
X-Received: by 2002:a05:6e02:78e:b0:34e:2a69:883c with SMTP id
 q14-20020a056e02078e00b0034e2a69883cmr8337962ils.1.1695361302436; Thu, 21 Sep
 2023 22:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230921133703.39042-1-kernelfans@gmail.com> <ZQ0j6Es88aR8cjRv@desktop>
In-Reply-To: <ZQ0j6Es88aR8cjRv@desktop>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 22 Sep 2023 13:41:22 +0800
Message-ID: <CALu+AoQHZOBcbCJJnhSyEcTyX6C3VttLxMKt2mdHgT7A6xHN9w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Sign the Image which is zboot's payload
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Pingfan Liu <kernelfans@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-efi@vger.kernel.org, kexec@lists.infradead.org, 
	Pingfan Liu <piliu@redhat.com>, Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, keyrings@vger.kernel.org, 
	Luca Boccassi <bluca@debian.org>, lennart@poettering.net, 
	Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, mjg59@google.com, 
	James.Bottomley@hansenpartnership.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_224148_893393_0679B7A8 
X-CRM114-Status: GOOD (  21.36  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Jan,

On Fri, 22 Sept 2023 at 13:19, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>
> Hi Pingfan!
>
> On 21 21:37:01, Pingfan Liu wrote:
> > From: Pingfan Liu <piliu@redhat.com>
> >
>
> > For security boot, the vmlinuz.efi will be signed so UEFI boot loader
> > can check against it. But at present, there is no signature for kexec
> > file load, this series makes a signature on the zboot's payload -- Image
> > before it is compressed. As a result, the kexec-tools parses and
> > decompresses the Image.gz to get the Image, which has signature and can
> > be checked against during kexec file load
>
> I missed some of the earlier discussion about this zboot kexec support.
> So just let me know if I'm missing something here. You were exploring
> these two options in getting this supported:
>
> 1. Making kexec_file_load do all the work.
>
> This option makes the signature verification easy. kexec_file_load
> checks the signature on the pe file and then extracts it and does the
> kexec.
>
> This is similar to how I'm approaching UKI support in [1].
>
> 2. Extract in userspace and pass decompressed kernel to kexec_file_load
>
> This options requires the decompressed kernel to have a valid signature on
> it. That's why this patch adds the ability to add that signature to the
> kernel contained inside the zboot image.
>
> This option would not make sense for UKI support as it would not
> validate the signature with respect to the initrd and cmdline that it
> contains.

Another possibility for the cmdline could be using the bootconfig
facility which was
introduced for boot time tracking:
Documentation/admin-guide/bootconfig.rst

So the initrd+cmdline can be signed as well.  Has this been discussed
before for UKI?

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
