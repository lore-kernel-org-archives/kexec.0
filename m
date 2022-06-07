Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F8BCCA47C
	for <kexec@archiver.kernel.org>; Tue,  7 Jun 2022 16:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HSps0rOm3PeenhQW75s77RX+X++jvFlZ0Q9oY01s4jk=; b=ishMA2SNRbrTwL
	nTWuz9olCpZe9165u/eMnzk2cwpWBrZAVwEinJuFeZeNZf9Nq2blcga1KqzTy5yFJA4BnBREykWe9
	oeBMPYI757lw5FHPBtKQHx59l0sS0rkjWGNn7Yp9ptSD+u4sLzemm98UQTEMW8WWr9OMzt68ECdeT
	k7JXyCi42YSrHHfgaIZJfxb+dq+tchb2hh2P/5ffT0Tnlk3c34SXeZgmXYUXcWfB/3ooYKjib/lyU
	a7zzvsxs9eick4tVbMIhzs598t5nU+1V3CREZU1RO6Pzgcs90X/IplqODhR3xBTpqO49BAzi8vobW
	UxQr+z96JCk62kOkl7Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nybfP-008NBk-8I; Tue, 07 Jun 2022 16:02:51 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nybfM-008NAL-Gm
	for kexec@lists.infradead.org; Tue, 07 Jun 2022 16:02:49 +0000
Received: by mail-ed1-x52e.google.com with SMTP id n28so23610524edb.9
        for <kexec@lists.infradead.org>; Tue, 07 Jun 2022 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UkNsdE3B6C69qG7xj8QZJZKYTbkZOuyj1Q7mTmi6Dgc=;
        b=Z/Kh8Wh2nk+fd9Wk7zMUsNy3u2A1+k+peW4JYUIvcwhU56kfjQa4aZM/G+o+jAXFpO
         4z8lDsEwFBXRJBOhkTVcTzl6qWlzuO0yEKeKnd8z1aWwSd0cQ1SKGRJmxN6H5nc1i75K
         PwGb7QkspkiCB4E43I7emWiHXjLal25L7diUV8BPhBWHM2AWa/UQ+dCj+5TF5JrqAtQM
         LIbUjLa0q+m8BO7BFawZokeLzqgZbOHJ+8qhfqHSWbDt1ibejZlygPmxYsagvyfnxx/i
         SLboHlhJTnEWT9RJnfql4AY1RyqF1HibWdcPVi96zWrqlFzPwP/60EU9eQtkm9+DrGvH
         EHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UkNsdE3B6C69qG7xj8QZJZKYTbkZOuyj1Q7mTmi6Dgc=;
        b=A+T38uppSFL0jPyC1oAMVqVeQgdzty9UCdDnnQHdunqgb+oDQokni6Hmn7EKCrYlWD
         SmhWkC0IXu5yHhOXjyHsbN7TH2yKMNMl8dmlF11XDKvvx0JEaeU569GMVGmVy3iujfaV
         crc3DI86DNB1ljvDRWK44bjaEz5Ok3szSKHrZB6CK7+UeKKXWJEe8VJrd1H1MjyPZc70
         tnvS3awI283+HuTyGCYLOikuayvSGDw/dKuSrJYxXWx5gmNO1DfUxUfc/0khUSCMDSIA
         CYHbmrS5yChbPCsplyCjv+zD4XWPa+e6c5nsXxPEZBMXiZaxTbUbmQdoQ+/X4eCF6z0M
         V43Q==
X-Gm-Message-State: AOAM530JcoplMO0cJ/wlkzpXhkAApe/y/OjNm2nSxWF3SmM17VtVwHtc
	qXshD3phEhsDnEsoAcuK9FTgE8po66JAnolgOy4YSA==
X-Google-Smtp-Source: ABdhPJxOul8yZmpxwHNojhicL57daDh/YnV4uK/ODTuY4C1op7IlnAgaeC7wcXe2TABjcPdtiW9zxPSwo4Ra0OocE5c=
X-Received: by 2002:a05:6402:34c2:b0:42f:79c0:334b with SMTP id
 w2-20020a05640234c200b0042f79c0334bmr25329803edc.88.1654617762674; Tue, 07
 Jun 2022 09:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
 <20220527025535.3953665-3-pasha.tatashin@soleen.com> <Yp1s2c0hyYzM4hbz@MiWiFi-R3L-srv>
In-Reply-To: <Yp1s2c0hyYzM4hbz@MiWiFi-R3L-srv>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 7 Jun 2022 12:02:04 -0400
Message-ID: <CA+CK2bC5U5j1xkZKuOETANo1=PPpbJn2mKYOa2fK1GLFib0ibw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kexec_file: Increase maximum file size to 4G
To: Baoquan He <bhe@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, rburanyi@google.com, 
	Greg Thelen <gthelen@google.com>, viro@zeniv.linux.org.uk, 
	kexec mailing list <kexec@lists.infradead.org>, linux-fsdevel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_090248_603854_7642DD83 
X-CRM114-Status: GOOD (  33.01  )
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

On Sun, Jun 5, 2022 at 10:56 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 05/27/22 at 02:55am, Pasha Tatashin wrote:
> > In some case initrd can be large. For example, it could be a netboot
> > image loaded by u-root, that is kexec'ing into it.
> >
> > The maximum size of initrd is arbitrary set to 2G. Also, the limit is
> > not very obvious because it is hidden behind a generic INT_MAX macro.
> >
> > Theoretically, we could make it LONG_MAX, but it is safer to keep it
> > sane, and just increase it to 4G.
>
> Do we need to care about 32bit system where initramfs could be larger
> than 2G? On 32bit system, SSIZE_MAX is still 2G, right?

Yes, on 32-bit SSIZE_MAX is still 2G, so we are safe to keep 32-bit
systems run exactly as today.

#define KEXEC_FILE_SIZE_MAX    min_t(s64, 4LL << 30, SSIZE_MAX)
Is meant to protect against running over the 2G limit on 32-bit systems.

>
> Another concern is if 2G is enough. If we can foresee it might need be
> enlarged again in a near future, LONG_MAX certainly is not a good
> value, but a little bigger multiple of 2G can be better?

This little series enables increasing the max value above 2G, but
still keeps it within a sane size i.e. 4G, If 4G seems too small, I
can change it to 8G or 16G instead of 4G.

Thanks,
Pasha

>
> >
> > Increase the size to 4G, and make it obvious by having a new macro
> > that specifies the maximum file size supported by kexec_file_load()
> > syscall: KEXEC_FILE_SIZE_MAX.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/kexec_file.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 8347fc158d2b..f00cf70d82b9 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -31,6 +31,9 @@
> >
> >  static int kexec_calculate_store_digests(struct kimage *image);
> >
> > +/* Maximum size in bytes for kernel/initrd files. */
> > +#define KEXEC_FILE_SIZE_MAX  min_t(s64, 4LL << 30, SSIZE_MAX)
> > +
> >  /*
> >   * Currently this is the only default function that is exported as some
> >   * architectures need it to do additional handlings.
> > @@ -223,11 +226,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
> >                            const char __user *cmdline_ptr,
> >                            unsigned long cmdline_len, unsigned flags)
> >  {
> > -     int ret;
> > +     ssize_t ret;
> >       void *ldata;
> >
> >       ret = kernel_read_file_from_fd(kernel_fd, 0, &image->kernel_buf,
> > -                                    INT_MAX, NULL, READING_KEXEC_IMAGE);
> > +                                    KEXEC_FILE_SIZE_MAX, NULL,
> > +                                    READING_KEXEC_IMAGE);
> >       if (ret < 0)
> >               return ret;
> >       image->kernel_buf_len = ret;
> > @@ -247,7 +251,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
> >       /* It is possible that there no initramfs is being loaded */
> >       if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
> >               ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,
> > -                                            INT_MAX, NULL,
> > +                                            KEXEC_FILE_SIZE_MAX, NULL,
> >                                              READING_KEXEC_INITRAMFS);
> >               if (ret < 0)
> >                       goto out;
> > --
> > 2.36.1.124.g0e6072fb45-goog
> >
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
