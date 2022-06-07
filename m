Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D949C43334
	for <kexec@archiver.kernel.org>; Tue,  7 Jun 2022 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0wbKHtWAzmux8/pbhGr8YxXbddXOfqdjoZGioMlnCOc=; b=Ht6IZENr5f8njY
	lSos1ignSi9p7wAxr4yXh8N3JYUnjI6GdWHfKr7KsIOUGEEXiFaZBoPYjLCac56ar3uVH0boZKaMO
	msdkly/HIfEyF6GWbn3bmV2OK+6gXXTtM2vzCNgoDkSH6TBjmNq8rjQJkSvSieSZjw6goWP3QzL3d
	bpajGJXzg7aARHzHYn7/lBrSNiUEARQEtv/cWQp6uV7e7c3OfaJ0cHK9Fs+/luNnL4ZmZj7A2YJLi
	Ysovo0llUKxp4jd805g7uTTlq9rypAo5SH51UPqtMprPiFDi8kPWkHsYVXOSFNtq7psIt+Yy6HDXI
	8tRNs79lQlKC6jYYWGcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nybVx-008Lav-Ez; Tue, 07 Jun 2022 15:53:05 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nybVu-008LYf-EV
	for kexec@lists.infradead.org; Tue, 07 Jun 2022 15:53:04 +0000
Received: by mail-ej1-x62c.google.com with SMTP id h23so25005644ejj.12
        for <kexec@lists.infradead.org>; Tue, 07 Jun 2022 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pufS40r/uX2ZtSB9s8FIZ6SlwwrSkU1jYicxPJP0Dvk=;
        b=EI/3FnfDm7xULUdj70TuQ6pbIIND9Ooo8uGbWhUrAbDTViCBtm4wpTdixdKFNo4aCK
         f1yE8jNnKNNOTXbuS4EI/9GbcqVUEVRKTQAMSj3vIvvF7eKo91aVzAsh+nLIzVm54tDG
         z01TQWwsfS6Mcq+/5BW/nW49mcHHd4TAfDhm5S3Bd3Ge5bxjx8cLjrLZ2URBEjFD9ZrX
         ZQ+oyGHvCBvbSRIasswi2yzcD8CmeiaKpp1BdunZwyBJmGWKE5c8hKDc4LWDi+6Wy66h
         urZhDietLh4l7fsCWLfQixf/BNyrrizYPXwqKUq0kF6CmoqighGAY+ed/Cz//ADdglzR
         FC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pufS40r/uX2ZtSB9s8FIZ6SlwwrSkU1jYicxPJP0Dvk=;
        b=VkXCdBVVC5U3cq1G8qsesMwAbw7ATkPb355o0P+07pwKkFe66PKRGdqv0i3jUMbFem
         5EfchDMhaKsHohqiX6w2JVfGb1eFDMOdI/RzQuA95v4usrOqmmjL4UKfMNbxgqyRQk1f
         R63/K4Vhta9dZVm2t8cge4BWgX83Vir0F10knzTQcILLKYwza0Dl68XXoQwjPs1ByQzP
         p56c7r9cTuj0lkJIvYn1frnZbOwCZrhLawrmu8zh/k5AoJSaSggoCH3JNwq9P3InrhTo
         MuXVpRPTSpixJYABqnm3d4pB3TDmzNMKtmgaO9mFRdWf+nHf4JpoIz0iMoZ3554kRg4c
         E4fA==
X-Gm-Message-State: AOAM531V1wzqoiJ977ZHKJuamau2U4JVFVMm5zxM+Sm3Y3M7gGh9TuqS
	6+DhYzciuv9ggs+dmjZJltA28srS2Xq6wcQT4f0oBQ==
X-Google-Smtp-Source: ABdhPJzJd85uN4waRQ5S7rEJKLXqx9BZbE/tIhMePQ2Jb2RkKVtxHLi3crqOpmq8r60CdWOGHPfuTeN5wRlBGvmHDeo=
X-Received: by 2002:a17:907:90c8:b0:711:c8e1:7109 with SMTP id
 gk8-20020a17090790c800b00711c8e17109mr12331055ejb.492.1654617176082; Tue, 07
 Jun 2022 08:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
 <20220527025535.3953665-2-pasha.tatashin@soleen.com> <Yp1qO70pdxLx4h1H@MiWiFi-R3L-srv>
In-Reply-To: <Yp1qO70pdxLx4h1H@MiWiFi-R3L-srv>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 7 Jun 2022 11:52:18 -0400
Message-ID: <CA+CK2bACmbW9saepkMy6G5FtssBhCv2NsoLGeFdF0XosKg5A-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fs/kernel_read_file: Allow to read files up-to ssize_t
To: Baoquan He <bhe@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, rburanyi@google.com, 
	Greg Thelen <gthelen@google.com>, viro@zeniv.linux.org.uk, 
	kexec mailing list <kexec@lists.infradead.org>, linux-fsdevel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_085302_640040_E69073F2 
X-CRM114-Status: GOOD (  24.38  )
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

On Sun, Jun 5, 2022 at 10:45 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 05/27/22 at 02:55am, Pasha Tatashin wrote:
> > Currently, the maximum file size that is supported is 2G. This may be
> > too small in some cases. For example, kexec_file_load() system call
> > loads initramfs. In some netboot cases initramfs can be rather large.
> >
> > Allow to use up-to ssize_t bytes. The callers still can limit the
> > maximum file size via buf_size.
>
> If we really met initramfs bigger than 2G, it's reasonable to increase
> the limit. While wondering why we should take sszie_t, but not size_t.

ssize_t instead of size_t so we can return errors as negative values.

Pasha

>
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  fs/kernel_read_file.c            | 38 ++++++++++++++++----------------
> >  include/linux/kernel_read_file.h | 32 +++++++++++++--------------
> >  include/linux/limits.h           |  1 +
> >  3 files changed, 36 insertions(+), 35 deletions(-)
> >
> > diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> > index 1b07550485b9..5d826274570c 100644
> > --- a/fs/kernel_read_file.c
> > +++ b/fs/kernel_read_file.c
> > @@ -29,15 +29,15 @@
> >   * change between calls to kernel_read_file().
> >   *
> >   * Returns number of bytes read (no single read will be bigger
> > - * than INT_MAX), or negative on error.
> > + * than SSIZE_MAX), or negative on error.
> >   *
> >   */
> > -int kernel_read_file(struct file *file, loff_t offset, void **buf,
> > -                  size_t buf_size, size_t *file_size,
> > -                  enum kernel_read_file_id id)
> > +ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
> > +                      size_t buf_size, size_t *file_size,
> > +                      enum kernel_read_file_id id)
> >  {
> >       loff_t i_size, pos;
> > -     size_t copied;
> > +     ssize_t copied;
> >       void *allocated = NULL;
> >       bool whole_file;
> >       int ret;
> > @@ -58,7 +58,7 @@ int kernel_read_file(struct file *file, loff_t offset, void **buf,
> >               goto out;
> >       }
> >       /* The file is too big for sane activities. */
> > -     if (i_size > INT_MAX) {
> > +     if (i_size > SSIZE_MAX) {
> >               ret = -EFBIG;
> >               goto out;
> >       }
> > @@ -124,12 +124,12 @@ int kernel_read_file(struct file *file, loff_t offset, void **buf,
> >  }
> >  EXPORT_SYMBOL_GPL(kernel_read_file);
> >
> > -int kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
> > -                            size_t buf_size, size_t *file_size,
> > -                            enum kernel_read_file_id id)
> > +ssize_t kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
> > +                                size_t buf_size, size_t *file_size,
> > +                                enum kernel_read_file_id id)
> >  {
> >       struct file *file;
> > -     int ret;
> > +     ssize_t ret;
> >
> >       if (!path || !*path)
> >               return -EINVAL;
> > @@ -144,14 +144,14 @@ int kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
> >  }
> >  EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
> >
> > -int kernel_read_file_from_path_initns(const char *path, loff_t offset,
> > -                                   void **buf, size_t buf_size,
> > -                                   size_t *file_size,
> > -                                   enum kernel_read_file_id id)
> > +ssize_t kernel_read_file_from_path_initns(const char *path, loff_t offset,
> > +                                       void **buf, size_t buf_size,
> > +                                       size_t *file_size,
> > +                                       enum kernel_read_file_id id)
> >  {
> >       struct file *file;
> >       struct path root;
> > -     int ret;
> > +     ssize_t ret;
> >
> >       if (!path || !*path)
> >               return -EINVAL;
> > @@ -171,12 +171,12 @@ int kernel_read_file_from_path_initns(const char *path, loff_t offset,
> >  }
> >  EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
> >
> > -int kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
> > -                          size_t buf_size, size_t *file_size,
> > -                          enum kernel_read_file_id id)
> > +ssize_t kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
> > +                              size_t buf_size, size_t *file_size,
> > +                              enum kernel_read_file_id id)
> >  {
> >       struct fd f = fdget(fd);
> > -     int ret = -EBADF;
> > +     ssize_t ret = -EBADF;
> >
> >       if (!f.file || !(f.file->f_mode & FMODE_READ))
> >               goto out;
> > diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
> > index 575ffa1031d3..90451e2e12bd 100644
> > --- a/include/linux/kernel_read_file.h
> > +++ b/include/linux/kernel_read_file.h
> > @@ -35,21 +35,21 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
> >       return kernel_read_file_str[id];
> >  }
> >
> > -int kernel_read_file(struct file *file, loff_t offset,
> > -                  void **buf, size_t buf_size,
> > -                  size_t *file_size,
> > -                  enum kernel_read_file_id id);
> > -int kernel_read_file_from_path(const char *path, loff_t offset,
> > -                            void **buf, size_t buf_size,
> > -                            size_t *file_size,
> > -                            enum kernel_read_file_id id);
> > -int kernel_read_file_from_path_initns(const char *path, loff_t offset,
> > -                                   void **buf, size_t buf_size,
> > -                                   size_t *file_size,
> > -                                   enum kernel_read_file_id id);
> > -int kernel_read_file_from_fd(int fd, loff_t offset,
> > -                          void **buf, size_t buf_size,
> > -                          size_t *file_size,
> > -                          enum kernel_read_file_id id);
> > +ssize_t kernel_read_file(struct file *file, loff_t offset,
> > +                      void **buf, size_t buf_size,
> > +                      size_t *file_size,
> > +                      enum kernel_read_file_id id);
> > +ssize_t kernel_read_file_from_path(const char *path, loff_t offset,
> > +                                void **buf, size_t buf_size,
> > +                                size_t *file_size,
> > +                                enum kernel_read_file_id id);
> > +ssize_t kernel_read_file_from_path_initns(const char *path, loff_t offset,
> > +                                       void **buf, size_t buf_size,
> > +                                       size_t *file_size,
> > +                                       enum kernel_read_file_id id);
> > +ssize_t kernel_read_file_from_fd(int fd, loff_t offset,
> > +                              void **buf, size_t buf_size,
> > +                              size_t *file_size,
> > +                              enum kernel_read_file_id id);
> >
> >  #endif /* _LINUX_KERNEL_READ_FILE_H */
> > diff --git a/include/linux/limits.h b/include/linux/limits.h
> > index b568b9c30bbf..f6bcc9369010 100644
> > --- a/include/linux/limits.h
> > +++ b/include/linux/limits.h
> > @@ -7,6 +7,7 @@
> >  #include <vdso/limits.h>
> >
> >  #define SIZE_MAX     (~(size_t)0)
> > +#define SSIZE_MAX    ((ssize_t)(SIZE_MAX >> 1))
> >  #define PHYS_ADDR_MAX        (~(phys_addr_t)0)
> >
> >  #define U8_MAX               ((u8)~0U)
> > --
> > 2.36.1.124.g0e6072fb45-goog
> >
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
