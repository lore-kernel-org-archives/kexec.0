Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CDCC4332F
	for <kexec@archiver.kernel.org>; Fri, 25 Nov 2022 07:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rpI1eizDzqLdbIORGm+wJrVrKBu1syyD1Y7q9qlbhnA=; b=yxiBpl3NfWHbCK
	d2OxUa/iz4hiMPuXy6OIyJWNXGfWuXM270MHyPUnByxnCY6WDiBlSF8A3is+2BJZ3s7AJVXeHL95I
	yxDJQZ5/qiZhmyuf9jIrK4RM/6FMcd7mkB8NDEz/byQ76BsIj657LF3P3VAbGeDGLNtkoaVDduA3D
	Y4IWbYSXp9SpsTraaltwxpH15JJoq4HRvniN2oWhDmX3j0Fv79t+/tSNQ8hq0Izb0gyQGrWMdlq+d
	yayajO8sFggQtM2ExcpP4PaZEi3ePUle40ncq4COpP0Qmy49wgUgEOYz7rWEPdaR1Do26ZfmVWHSt
	5k44z74AhijJ03aQlOXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyT6X-00E3zP-7O; Fri, 25 Nov 2022 07:26:33 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyT6T-00E3ww-A9
	for kexec@lists.infradead.org; Fri, 25 Nov 2022 07:26:31 +0000
Received: by mail-io1-xd35.google.com with SMTP id n188so2525168iof.8
        for <kexec@lists.infradead.org>; Thu, 24 Nov 2022 23:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xOXk4lCUYoouX6nn+zvnuXLeTTpo+x2XXG4tCRFIhrI=;
        b=DbIYC1nPguo/cUcch+jXoQcvwzlVhAWy29HS8t2wtdWwaZS646cbgwpEcGlmH0900S
         GtKKwl+4q5e2/JBjxgwCaXYoC82xNmS8Qfox+YuX+khFuWAhlBxPp8W1q0YWfPvK+wbp
         0R032MmrmsrdmA4QJryqPXJKS+7+Vgxyk09E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOXk4lCUYoouX6nn+zvnuXLeTTpo+x2XXG4tCRFIhrI=;
        b=F+flcYwucIGEJOvu6doepY+CZP3bed+mHMaoXZs8eSiavdou8RAriKGZZjfeS12ocG
         VRq0o+YaPziLdkFzuYbSX1CCT7RNFiKQQZUcOn542WV1++4SI+/0omV9i/2XZCjR+Qzr
         KIMRVzpfrezcz2ijpM67KfWBcbKjC3jk9zJqNyxZr33VNY+LstUabPje+qBRrbdSXKqV
         DCOWx7j4h+oVa6d8vwH833b+sYEmXPT73xo/x16vqAMLlfMwXlZG+ljgy9m0iMx11di8
         6XEf6sQjcJkiHWrueTLAZI8RWLSzDUBcytjRgry7cq3o1ai3hB01RLSBpmen7EC4rD0w
         49/A==
X-Gm-Message-State: ANoB5plucIQFGDV4ZY3Kze+AOZ8C+AdqxN1JX5PQ2by1RKE91fuJtcpr
	yf9bbB7I8/CdbMl16duTcAWzaR2z5cYKUOqS
X-Google-Smtp-Source: AA0mqf55PpvdtMvUUYdkAIB8857ESUmO1NbvHoSca+PMSzFc5aWI9OMY+XcyFAO7ENaood7VmjOp+A==
X-Received: by 2002:a5d:93c2:0:b0:6de:3107:a863 with SMTP id j2-20020a5d93c2000000b006de3107a863mr7386124ioo.129.1669361186565;
        Thu, 24 Nov 2022 23:26:26 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id z28-20020a056638215c00b00363753f4730sm1150345jaj.91.2022.11.24.23.26.25
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 23:26:25 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id p141so2532574iod.6
        for <kexec@lists.infradead.org>; Thu, 24 Nov 2022 23:26:25 -0800 (PST)
X-Received: by 2002:a02:c897:0:b0:374:100a:b0c7 with SMTP id
 m23-20020a02c897000000b00374100ab0c7mr8004072jao.185.1669361185189; Thu, 24
 Nov 2022 23:26:25 -0800 (PST)
MIME-Version: 1.0
References: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org>
 <Y4AvTEZiNXfFU1Wv@MiWiFi-R3L-srv> <CANiDSCsgFYvShoTo9xAPe0wqSJgTnB7ZgzXmNqD+L2cKdsVoRg@mail.gmail.com>
 <Y4BrjfLSukrSbGn4@MiWiFi-R3L-srv>
In-Reply-To: <Y4BrjfLSukrSbGn4@MiWiFi-R3L-srv>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 25 Nov 2022 08:26:13 +0100
X-Gmail-Original-Message-ID: <CANiDSCueVsRMBjjmCDc+r5YjM0UzThLyFm10kp1cKZw4Pnv6kg@mail.gmail.com>
Message-ID: <CANiDSCueVsRMBjjmCDc+r5YjM0UzThLyFm10kp1cKZw4Pnv6kg@mail.gmail.com>
Subject: Re: [PATCH] kexec: Enable runtime allocation of crash_image
To: Baoquan He <bhe@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Philipp Rudo <prudo@redhat.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221124_232629_401837_D96F5B67 
X-CRM114-Status: GOOD (  45.70  )
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

Hi Baoquan

On Fri, 25 Nov 2022 at 08:15, Baoquan He <bhe@redhat.com> wrote:
>
> On 11/25/22 at 06:52am, Ricardo Ribalda wrote:
> > Hi Baoquan
> >
> > Thanks for your review!
> >
> > On Fri, 25 Nov 2022 at 03:58, Baoquan He <bhe@redhat.com> wrote:
> > >
> > > On 11/24/22 at 11:23pm, Ricardo Ribalda wrote:
> > > > Usually crash_image is defined statically via the crashkernel parameter
> > > > or DT.
> > > >
> > > > But if the crash kernel is not used, or is smaller than then
> > > > area pre-allocated that memory is wasted.
> > > >
> > > > Also, if the crash kernel was not defined at bootime, there is no way to
> > > > use the crash kernel.
> > > >
> > > > Enable runtime allocation of the crash_image if the crash_image is not
> > > > defined statically. Following the same memory allocation/validation path
> > > > that for the reboot kexec kernel.
> > >
> > > We don't check if the crashkernel memory region is valid in kernel, but
> > > we do have done the check in kexec-tools utility. Since both kexec_load and
> > > kexec_file_load need go through path of kexec-tools loading, we haven't
> > > got problem with lack of the checking in kernel.
> >
> > Not sure if I follow you.
> >
> > We currently check if the crash kernel is in the right place at
> > sanity_check_segment_list()
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kexec_core.c#n239
>
> Please check below code in kexec-tools utility, currently we have to use
> kexec -p to enter into kexec_load or kexec_file_load system call. Before
> entering system call, we have below code:

So your concern is that the current kexec-tools does not let you pass
a crashkernel unless there is memory reserved for it?

Once the changes land in the kernel I can make a patch for that. I am
currently using this to test the code:

https://chromium-review.googlesource.com/c/chromiumos/platform2/+/3953579/4/kexec-lite/kexec-lite.c

>
> https://kernel.googlesource.com/pub/scm/utils/kernel/kexec/kexec-tools.git/+/refs/heads/master/kexec/kexec.c
>
> int main(int argc, char *argv[])
> {
> ......
>                 if (do_load &&
>             ((kexec_flags & KEXEC_ON_CRASH) ||
>              (kexec_file_flags & KEXEC_FILE_ON_CRASH)) &&
>             !is_crashkernel_mem_reserved()) {
>                 die("Memory for crashkernel is not reserved\n"
>                     "Please reserve memory by passing"
>                     "\"crashkernel=Y@X\" parameter to kernel\n"
>                     "Then try to loading kdump kernel\n");
>         }
>
> ......
> }
>
> >
> >
> > >
> > > However, even though we want to do the check, doing like below is much
> > > easier and more reasonable.
> > >
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index 45637511e0de..4d1339bd2ccf 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -344,6 +344,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > >
> > >         dest_image = &kexec_image;
> > >         if (flags & KEXEC_FILE_ON_CRASH) {
> > > +               if (!crash_memory_valid())
> > > +                       return -EINVAL;
> > >                 dest_image = &kexec_crash_image;
> > >                 if (kexec_crash_image)
> > >                         arch_kexec_unprotect_crashkres();
> > >
> > > So, I am wondering if there is an issue encountered if we don't do the
> > > check in kernel.
> > >
> > > Thanks
> > > Baoquan
> > >
> > > >
> > > > ---
> > > >
> > > > To: Eric Biederman <ebiederm@xmission.com>
> > > > Cc: kexec@lists.infradead.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: Ross Zwisler <zwisler@kernel.org>
> > > > Cc: Philipp Rudo <prudo@redhat.com>
> > > > Cc: Baoquan He <bhe@redhat.com>
> > > > ---
> > > >  include/linux/kexec.h | 1 +
> > > >  kernel/kexec.c        | 9 +++++----
> > > >  kernel/kexec_core.c   | 5 +++++
> > > >  kernel/kexec_file.c   | 7 ++++---
> > > >  4 files changed, 15 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > > index 41a686996aaa..98ca9a32bc8e 100644
> > > > --- a/include/linux/kexec.h
> > > > +++ b/include/linux/kexec.h
> > > > @@ -427,6 +427,7 @@ extern int kexec_load_disabled;
> > > >  extern bool kexec_in_progress;
> > > >
> > > >  int crash_shrink_memory(unsigned long new_size);
> > > > +bool __crash_memory_valid(void);
> > > >  ssize_t crash_get_memory_size(void);
> > > >
> > > >  #ifndef arch_kexec_protect_crashkres
> > > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > > index cb8e6e6f983c..b5c17db25e88 100644
> > > > --- a/kernel/kexec.c
> > > > +++ b/kernel/kexec.c
> > > > @@ -28,7 +28,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> > > >       struct kimage *image;
> > > >       bool kexec_on_panic = flags & KEXEC_ON_CRASH;
> > > >
> > > > -     if (kexec_on_panic) {
> > > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > > >               /* Verify we have a valid entry point */
> > > >               if ((entry < phys_to_boot_phys(crashk_res.start)) ||
> > > >                   (entry > phys_to_boot_phys(crashk_res.end)))
> > > > @@ -44,7 +44,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> > > >       image->nr_segments = nr_segments;
> > > >       memcpy(image->segment, segments, nr_segments * sizeof(*segments));
> > > >
> > > > -     if (kexec_on_panic) {
> > > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > > >               /* Enable special crash kernel control page alloc policy. */
> > > >               image->control_page = crashk_res.start;
> > > >               image->type = KEXEC_TYPE_CRASH;
> > > > @@ -101,7 +101,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > > >
> > > >       if (flags & KEXEC_ON_CRASH) {
> > > >               dest_image = &kexec_crash_image;
> > > > -             if (kexec_crash_image)
> > > > +             if (kexec_crash_image && __crash_memory_valid())
> > > >                       arch_kexec_unprotect_crashkres();
> > > >       } else {
> > > >               dest_image = &kexec_image;
> > > > @@ -157,7 +157,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > > >       image = xchg(dest_image, image);
> > > >
> > > >  out:
> > > > -     if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
> > > > +     if ((flags & KEXEC_ON_CRASH) && kexec_crash_image &&
> > > > +         __crash_memory_valid())
> > > >               arch_kexec_protect_crashkres();
> > > >
> > > >       kimage_free(image);
> > > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > > index ca2743f9c634..77083c9760fb 100644
> > > > --- a/kernel/kexec_core.c
> > > > +++ b/kernel/kexec_core.c
> > > > @@ -1004,6 +1004,11 @@ void crash_kexec(struct pt_regs *regs)
> > > >       }
> > > >  }
> > > >
> > > > +bool __crash_memory_valid(void)
> > > > +{
> > > > +     return crashk_res.end != crashk_res.start;
> > > > +}
> > > > +
> > > >  ssize_t crash_get_memory_size(void)
> > > >  {
> > > >       ssize_t size = 0;
> > > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > index 45637511e0de..0671f4f370ff 100644
> > > > --- a/kernel/kexec_file.c
> > > > +++ b/kernel/kexec_file.c
> > > > @@ -280,7 +280,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
> > > >
> > > >       image->file_mode = 1;
> > > >
> > > > -     if (kexec_on_panic) {
> > > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > > >               /* Enable special crash kernel control page alloc policy. */
> > > >               image->control_page = crashk_res.start;
> > > >               image->type = KEXEC_TYPE_CRASH;
> > > > @@ -345,7 +345,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > >       dest_image = &kexec_image;
> > > >       if (flags & KEXEC_FILE_ON_CRASH) {
> > > >               dest_image = &kexec_crash_image;
> > > > -             if (kexec_crash_image)
> > > > +             if (kexec_crash_image && __crash_memory_valid())
> > > >                       arch_kexec_unprotect_crashkres();
> > > >       }
> > > >
> > > > @@ -408,7 +408,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > >  exchange:
> > > >       image = xchg(dest_image, image);
> > > >  out:
> > > > -     if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
> > > > +     if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image &&
> > > > +         __crash_memory_valid())
> > > >               arch_kexec_protect_crashkres();
> > > >
> > > >       kexec_unlock();
> > > >
> > > > ---
> > > > base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> > > > change-id: 20221124-kexec-noalloc-3cab3cbe000f
> > > >
> > > > Best regards,
> > > > --
> > > > Ricardo Ribalda <ribalda@chromium.org>
> > > >
> > >
> >
> >
> > --
> > Ricardo Ribalda
> >
>


-- 
Ricardo Ribalda

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
