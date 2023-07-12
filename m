Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8436EB64DC
	for <kexec@archiver.kernel.org>; Wed, 12 Jul 2023 02:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mpPbfFYkciOrw3x/2S9XU6qqYocwUUefrbw8t3HEe98=; b=3ufvOxadnVpY5w
	l5nXFjGq+M/OE3XMiht4/tLot2IYKyeTpLVn/6HDWMQVyxNhnSk6Kg06TD+rShYFnG6NA9nMXlqc5
	VNv49ndVeJ33nHYR67JKctDsRlAu1CBY9PGrDFu5KRUY+PFXuVhm2BEx2BgSO1DTqsbV+XiU1BnHN
	talVU3D/LVbpGrvVX1HF4U0R6nj4ZTIU4V/zP8+Fa/aryaK2eP456VX/Bld/X7eRpwGX8Hcj56yhK
	1x3Oelfey/ZB2LkAgYnvTTwI6hhaWNarvr7/5/jOZrJtx8p+HqzZftpI9F314+mOO9hYh3YyDV5eA
	SWiuvPE7ZhZ/xDnljbCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJQ4a-00GLIm-1a;
	Wed, 12 Jul 2023 02:59:24 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJQ4Z-00GLIA-0j
	for kexec@bombadil.infradead.org;
	Wed, 12 Jul 2023 02:59:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ocNLmvGR7kxVxI6dJrp51pqGUF67GQOJCx01vsa/B+E=; b=j1kqCy6+OHjoPi41kvNY2v8OpR
	ifbzy/OfY+HqYH9+T49NRADcVU+zNxMRzOHveVEeuqEdtOgIFs/zDE3Qd+2qYfEgQ2kCBZP8NqZ/Q
	Qkn/k16vZS+wf+OpLYm4UZdqxIP4FRIjzTs9gKR3yfuOey+5RANc9ouIwbwZGAgYd8GfYKhG+LCph
	l6YC8sbsDe+MFmcN5qlq/UY5fYJvcNTmfZuMmZrG8qsEOPS0nyt7Uz0GBM/NBDN9cKgkqYQZ5xP3d
	7ddR/NKgv1SdurzcWv+FOcyi11bdfOwkkQvp0IxPtNqwqgmL8v9kxpOcN8MYN9wwzaq9i7DEpPSGI
	WeAxUeNg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJOel-002ZjG-06
	for kexec@lists.infradead.org;
	Wed, 12 Jul 2023 01:28:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689125311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocNLmvGR7kxVxI6dJrp51pqGUF67GQOJCx01vsa/B+E=;
	b=fBCMYpZKKWLYclSC/BnE4SMG5AvFk781xVugCZaXFrgfEx9+vY/ZHnoFNvZfVkTtXZopNQ
	5GfbIj+B+0qMJh/S3QzPlffSruKQ+9aK233Wi1rM2RmHRJjhAqEPbHrrr0n2VBQOSTmSL9
	PR43U8p59sCstH32u8bFUKselz6A5OM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689125311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocNLmvGR7kxVxI6dJrp51pqGUF67GQOJCx01vsa/B+E=;
	b=fBCMYpZKKWLYclSC/BnE4SMG5AvFk781xVugCZaXFrgfEx9+vY/ZHnoFNvZfVkTtXZopNQ
	5GfbIj+B+0qMJh/S3QzPlffSruKQ+9aK233Wi1rM2RmHRJjhAqEPbHrrr0n2VBQOSTmSL9
	PR43U8p59sCstH32u8bFUKselz6A5OM=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-XPBNZfr6P1iVA1IvfVdQEw-1; Tue, 11 Jul 2023 21:27:03 -0400
X-MC-Unique: XPBNZfr6P1iVA1IvfVdQEw-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3465508c267so3347675ab.1
        for <kexec@lists.infradead.org>; Tue, 11 Jul 2023 18:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689125223; x=1689730023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ocNLmvGR7kxVxI6dJrp51pqGUF67GQOJCx01vsa/B+E=;
        b=SGB1FVCR+J0mNWGTNwDYfK4QRsIhsorOjIoGLJHkXF3vY62aHHF1fg7YMeug9xLYCJ
         XiOkWqeGIuJzJMFEZ+tuDX8YIKTTe7rLSoy6lxChSVSdCutmdoKPmmqAZz6KpVlLO6qZ
         waq9GNWcDeD8p5ldsJ19s8urOj56U31thhF+qrHWCLZt1QFWg1kNUPv+mUJaJXfulL5a
         viC4bPDvPnM6cOn7S61pdQNaXsr7vzhTh+D/6wbmg+G84XT4zXB2qZqngGNVPEzcmaDJ
         I5RFOByPek3W8gz1ViAyJ+8gVDt7mG6UEuc1rgYFXXJk5o5C55H1kvVwl8lxtCxVzKOt
         cEnw==
X-Gm-Message-State: ABy/qLZpxA3hMwL5pYLY/VphweAFc8pA0r6zr5UqhtYKZ2/Qy4cxo2vQ
	gv5+op9+F/iS47FWerRhzwhnSVTQo4lddgXpQJtONGSzYRYjBoYkn1bUo+oSvPL5OG+B6ZIqwGI
	70iK5P6cYJnMYhW5NZ8Adi0aCTQok7Ie6F6wU
X-Received: by 2002:a05:6e02:932:b0:346:10c5:2949 with SMTP id o18-20020a056e02093200b0034610c52949mr13794766ilt.1.1689125222783;
        Tue, 11 Jul 2023 18:27:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHlxdigAm+vrY+sQ9k08ownvSzVq2tBlBZb5YstpZDFEDJvAsu8IRjZ3+TTbxGF96c1r8l5QAxulq55I+ZKIOI=
X-Received: by 2002:a05:6e02:932:b0:346:10c5:2949 with SMTP id
 o18-20020a056e02093200b0034610c52949mr13794752ilt.1.1689125222485; Tue, 11
 Jul 2023 18:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-11-tusharsu@linux.microsoft.com> <CALu+AoQC101fcbJjLdJHD7QtqeXzt5uOZDgNYvob0U_NGyaqCQ@mail.gmail.com>
 <b4047d8d-2c7c-e357-1c1f-cc55978fd963@linux.microsoft.com>
In-Reply-To: <b4047d8d-2c7c-e357-1c1f-cc55978fd963@linux.microsoft.com>
From: RuiRui Yang <ruyang@redhat.com>
Date: Wed, 12 Jul 2023 09:28:33 +0800
Message-ID: <CALu+AoSWcEU7PfHvejYAuFWMEO6uGEWPnJMXuW2kNG-MUshFsw@mail.gmail.com>
Subject: Re: [PATCH 10/10] kexec: update kexec_file_load syscall to call ima_kexec_post_load
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com, 
	kexec@lists.infradead.org, linux-integrity@vger.kernel.org, code@tyhicks.com, 
	nramas@linux.microsoft.com, paul@paul-moore.com, 
	Eric Biederman <ebiederm@xmission.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_022839_447839_B78D5980 
X-CRM114-Status: GOOD (  33.22  )
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

On Wed, 12 Jul 2023 at 03:15, Tushar Sugandhi
<tusharsu@linux.microsoft.com> wrote:
>
>
> On 7/7/23 01:20, RuiRui Yang wrote:
> > On Tue, 4 Jul 2023 at 05:58, Tushar Sugandhi
> > <tusharsu@linux.microsoft.com> wrote:
> >> The kexec_file_load syscall is used to load a new kernel for kexec.
> >> The syscall needs to update its function to call ima_kexec_post_load, which
> >> was implemented in a previous patch.  ima_kexec_post_load takes care of
> >> mapping the measurement list for the next kernel and registering a reboot
> >> notifier if it's not already registered.
> >>
> >> Modify the kexec_file_load syscall to call ima_kexec_post_load after the
> >> image has been loaded and prepared for kexec.  This ensures that the IMA
> >> measurement list will be available to the next kernel after a kexec reboot.
> >> This also ensures the measurements taken in the window between kexec load
> >> and execute are captured and passed to the next kernel.
> >>
> >> Declare the kimage_file_post_load function in the kernel/kexec_internal.h,
> >> so it can be properly used in the syscall.
> >>
> >> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> >> ---
> >>   kernel/kexec_file.c     | 7 +++++++
> >>   kernel/kexec_internal.h | 1 +
> >>   2 files changed, 8 insertions(+)
> >>
> >> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> >> index f989f5f1933b..efe28e77280c 100644
> >> --- a/kernel/kexec_file.c
> >> +++ b/kernel/kexec_file.c
> >> @@ -184,6 +184,11 @@ kimage_validate_signature(struct kimage *image)
> >>   }
> >>   #endif
> >>
> >> +void kimage_file_post_load(struct kimage *image)
> >> +{
> >> +       ima_kexec_post_load(image);
> >> +}
> >> +
> >>   /*
> >>    * In file mode list of segments is prepared by kernel. Copy relevant
> >>    * data from user space, do error checking, prepare segment list
> >> @@ -399,6 +404,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> >>
> >>          kimage_terminate(image);
> >>
> >> +       kimage_file_post_load(image);
> > I think it should be only done for the reboot case,  please just
> > exclude the kdump case here..
> >
> Thanks for the feedback RuiRui.  Appreciate it.
>
> Conceptually I agree with you that this needs to be done only for reboot.
> I need to figure out how to do it implementation wise.
>
> If you can give me pointers/suggestions, that would help.

Hi Tushar,

You can check the flags argument in the function
if (flags & KEXEC_FILE_ON_CRASH) is true then this is a kdump kernel
loading, just skip the kimage_file_post_load in that case?

>
> ~Tushar
> >> +
> >>          ret = machine_kexec_post_load(image);
> >>          if (ret)
> >>                  goto out;
> >> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> >> index 74da1409cd14..98dd5fcafaf0 100644
> >> --- a/kernel/kexec_internal.h
> >> +++ b/kernel/kexec_internal.h
> >> @@ -30,6 +30,7 @@ static inline void kexec_unlock(void)
> >>
> >>   #ifdef CONFIG_KEXEC_FILE
> >>   #include <linux/purgatory.h>
> >> +void kimage_file_post_load(struct kimage *image);
> >>   void kimage_file_post_load_cleanup(struct kimage *image);
> >>   extern char kexec_purgatory[];
> >>   extern size_t kexec_purgatory_size;
> >> --
> >> 2.25.1
> >>
> >>
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec
> >>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
