Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9755FC433FE
	for <kexec@archiver.kernel.org>; Fri, 25 Nov 2022 08:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FYhoKngba1MYUtqZk/3ofw1o5kJxiE3exOWT7fj63p0=; b=iAX+3Bx5hO2VAS
	GoDbzeXR/P2WvICqYbiHFMwex63LF7j8TesFKe2ypuPFk7fGze1TKvfftP2rT08nE+rMxGE08JFTo
	wMBOtvr0+IzG+HReXSKBHjpnDgQtGSko9dLleP8N0ogl2uFZH9cqmGKUK2boUu+NQrOfOIjcFC19l
	dRfmVW2mvL/bm0bhhWpRFEScl6GTdkvGW+ToKsIQguqYckfqc2y0BfWUDr+dXWajBTKYFnhYLy+D2
	DE43lBzO89L9A807EfuzrlJoNdDp8SCsIgrgzQndzMM9yWBA60JA+GhfTJrOV89gZ13OeZ+JwvWxk
	bV6dzY5LKXPW34XuFgiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyTnB-00EOU5-9R; Fri, 25 Nov 2022 08:10:37 +0000
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyTn7-00EOPh-0Y
	for kexec@lists.infradead.org; Fri, 25 Nov 2022 08:10:35 +0000
Received: by mail-il1-x134.google.com with SMTP id f6so1674671ilu.13
        for <kexec@lists.infradead.org>; Fri, 25 Nov 2022 00:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FyoJ3wh1zU6rXnKtzOIFMV/jsmUS095GoAtKhXCHW70=;
        b=nV0bE+vJgfgD+catJc8ZhzBmWAaw4fNkDdyCwh33D/XTWEaXgmhKd9z4TQ3Z51YuKv
         hTPGv/A/IxHb5U4g/1ck7KstdnBWex0SrW8OAE/3KcRAcfppaFW3WjRx2DOcqUywEJ4t
         AJnZ1OpJ4FHmEg8O3FLPJv6Ae5xfI/pXeXPiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyoJ3wh1zU6rXnKtzOIFMV/jsmUS095GoAtKhXCHW70=;
        b=OHPXv9DvG5OYD/sKr7lzsJmq2ASLyUpwj5UQAdeIelELQkGHNAuhR+gB5/hJ4gnO+i
         lTrs/5PtsuC8KCUuURE4tiZvF3lQzZqtHfTZd05qyMbAgyGV4zNlNQb5U56BdCIf6qkI
         XC8zDusAN5rdsIwYxOBdV3NZk5+raMOuG64F2qCJySFXDU1ZBBWifZgbPfBjWYFKPhqa
         qmTbdmjMiFQe52p0vKoxIKmtsJgcxRkBsgJ2d+KseTIjTa+fT5LXgSfqC/n4Inam+NR2
         7VpRtpthngs3NnnFf460w8TlHfVX7+Ey6OfyIeFuMXTokH9Jln1FuXe0lY2ls885ywKG
         OAbQ==
X-Gm-Message-State: ANoB5pmJpsM1DAk9aCAcAMsVGJCDW6T+SRAoLpJzMYrI6Prez290ZCqr
	iIQYic20ii77YDFqtfQGErtxhbKu7t+cGjJp
X-Google-Smtp-Source: AA0mqf4+AaJyl91IQaOJ+I7Zt4CuzScGfT5dbOVDuY+9ajuMgivuFUHekoAvc8m7YsVk2DwAmc24Jw==
X-Received: by 2002:a92:c90d:0:b0:302:58fb:5676 with SMTP id t13-20020a92c90d000000b0030258fb5676mr16069323ilp.248.1669363830693;
        Fri, 25 Nov 2022 00:10:30 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id e18-20020a022112000000b0037465a1dd3fsm1184336jaa.156.2022.11.25.00.10.27
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 00:10:28 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id n188so2579707iof.8
        for <kexec@lists.infradead.org>; Fri, 25 Nov 2022 00:10:27 -0800 (PST)
X-Received: by 2002:a05:6638:3d03:b0:373:9d0a:33a0 with SMTP id
 cl3-20020a0566383d0300b003739d0a33a0mr7887998jab.286.1669363826467; Fri, 25
 Nov 2022 00:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org>
 <Y4AvTEZiNXfFU1Wv@MiWiFi-R3L-srv> <CANiDSCsgFYvShoTo9xAPe0wqSJgTnB7ZgzXmNqD+L2cKdsVoRg@mail.gmail.com>
 <Y4BrjfLSukrSbGn4@MiWiFi-R3L-srv> <CANiDSCueVsRMBjjmCDc+r5YjM0UzThLyFm10kp1cKZw4Pnv6kg@mail.gmail.com>
 <Y4Byd94oeoGCuTGq@MiWiFi-R3L-srv>
In-Reply-To: <Y4Byd94oeoGCuTGq@MiWiFi-R3L-srv>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 25 Nov 2022 09:10:15 +0100
X-Gmail-Original-Message-ID: <CANiDSCvtLNBUF_tJQUak-6LB92q=JnCGyAQ5ekKyQ-cG6_UHeg@mail.gmail.com>
Message-ID: <CANiDSCvtLNBUF_tJQUak-6LB92q=JnCGyAQ5ekKyQ-cG6_UHeg@mail.gmail.com>
Subject: Re: [PATCH] kexec: Enable runtime allocation of crash_image
To: Baoquan He <bhe@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Philipp Rudo <prudo@redhat.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221125_001033_119395_F577AD6D 
X-CRM114-Status: GOOD (  54.23  )
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

On Fri, 25 Nov 2022 at 08:45, Baoquan He <bhe@redhat.com> wrote:
>
> On 11/25/22 at 08:26am, Ricardo Ribalda wrote:
> > Hi Baoquan
> >
> > On Fri, 25 Nov 2022 at 08:15, Baoquan He <bhe@redhat.com> wrote:
> > >
> > > On 11/25/22 at 06:52am, Ricardo Ribalda wrote:
> > > > Hi Baoquan
> > > >
> > > > Thanks for your review!
> > > >
> > > > On Fri, 25 Nov 2022 at 03:58, Baoquan He <bhe@redhat.com> wrote:
> > > > >
> > > > > On 11/24/22 at 11:23pm, Ricardo Ribalda wrote:
> > > > > > Usually crash_image is defined statically via the crashkernel parameter
> > > > > > or DT.
> > > > > >
> > > > > > But if the crash kernel is not used, or is smaller than then
> > > > > > area pre-allocated that memory is wasted.
> > > > > >
> > > > > > Also, if the crash kernel was not defined at bootime, there is no way to
> > > > > > use the crash kernel.
> > > > > >
> > > > > > Enable runtime allocation of the crash_image if the crash_image is not
> > > > > > defined statically. Following the same memory allocation/validation path
> > > > > > that for the reboot kexec kernel.
> > > > >
> > > > > We don't check if the crashkernel memory region is valid in kernel, but
> > > > > we do have done the check in kexec-tools utility. Since both kexec_load and
> > > > > kexec_file_load need go through path of kexec-tools loading, we haven't
> > > > > got problem with lack of the checking in kernel.
> > > >
> > > > Not sure if I follow you.
> > > >
> > > > We currently check if the crash kernel is in the right place at
> > > > sanity_check_segment_list()
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kexec_core.c#n239
> > >
> > > Please check below code in kexec-tools utility, currently we have to use
> > > kexec -p to enter into kexec_load or kexec_file_load system call. Before
> > > entering system call, we have below code:
> >
> > So your concern is that the current kexec-tools does not let you pass
> > a crashkernel unless there is memory reserved for it?
>
> No, my concern is why we have to do the check in kernel if we have done
> that in kexec-tools utility. You didn't say your kexec-lite need this
> until now. I think it's fine to add the check in kernel if you prefer to
> do the check in kernel, but not in kexec-lite.
>
> The motivation or reason you want to make the change is very important.

kexec-lite is just to test the kernel code. It is easier to follow
than kexec-utils and supports 32bit userspace on a 64bit kernel.


I think it was clear. The motivation is to enable the use of
crashkernel when it is not statically predefined.

Any suggestions on how I can make it more clear?



>
>
> >
> > Once the changes land in the kernel I can make a patch for that. I am
> > currently using this to test the code:
> >
> > https://chromium-review.googlesource.com/c/chromiumos/platform2/+/3953579/4/kexec-lite/kexec-lite.c
> >
> > >
> > > https://kernel.googlesource.com/pub/scm/utils/kernel/kexec/kexec-tools.git/+/refs/heads/master/kexec/kexec.c
> > >
> > > int main(int argc, char *argv[])
> > > {
> > > ......
> > >                 if (do_load &&
> > >             ((kexec_flags & KEXEC_ON_CRASH) ||
> > >              (kexec_file_flags & KEXEC_FILE_ON_CRASH)) &&
> > >             !is_crashkernel_mem_reserved()) {
> > >                 die("Memory for crashkernel is not reserved\n"
> > >                     "Please reserve memory by passing"
> > >                     "\"crashkernel=Y@X\" parameter to kernel\n"
> > >                     "Then try to loading kdump kernel\n");

Having that check ALSO is unserspace is fine. It lets kexec show a
more meaningful error message. But we should not rely on userspace
checks.

This patch is not about adding an extra check on the kernel, but to
enable extra functionaliry.

> > >         }
> > >
> > > ......
> > > }
> > >
> > > >
> > > >
> > > > >
> > > > > However, even though we want to do the check, doing like below is much
> > > > > easier and more reasonable.
> > > > >
> > > > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > > index 45637511e0de..4d1339bd2ccf 100644
> > > > > --- a/kernel/kexec_file.c
> > > > > +++ b/kernel/kexec_file.c
> > > > > @@ -344,6 +344,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > > >
> > > > >         dest_image = &kexec_image;
> > > > >         if (flags & KEXEC_FILE_ON_CRASH) {
> > > > > +               if (!crash_memory_valid())
> > > > > +                       return -EINVAL;
> > > > >                 dest_image = &kexec_crash_image;
> > > > >                 if (kexec_crash_image)
> > > > >                         arch_kexec_unprotect_crashkres();
> > > > >
> > > > > So, I am wondering if there is an issue encountered if we don't do the
> > > > > check in kernel.
> > > > >
> > > > > Thanks
> > > > > Baoquan
> > > > >
> > > > > >
> > > > > > ---
> > > > > >
> > > > > > To: Eric Biederman <ebiederm@xmission.com>
> > > > > > Cc: kexec@lists.infradead.org
> > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > > Cc: Ross Zwisler <zwisler@kernel.org>
> > > > > > Cc: Philipp Rudo <prudo@redhat.com>
> > > > > > Cc: Baoquan He <bhe@redhat.com>
> > > > > > ---
> > > > > >  include/linux/kexec.h | 1 +
> > > > > >  kernel/kexec.c        | 9 +++++----
> > > > > >  kernel/kexec_core.c   | 5 +++++
> > > > > >  kernel/kexec_file.c   | 7 ++++---
> > > > > >  4 files changed, 15 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > > > > index 41a686996aaa..98ca9a32bc8e 100644
> > > > > > --- a/include/linux/kexec.h
> > > > > > +++ b/include/linux/kexec.h
> > > > > > @@ -427,6 +427,7 @@ extern int kexec_load_disabled;
> > > > > >  extern bool kexec_in_progress;
> > > > > >
> > > > > >  int crash_shrink_memory(unsigned long new_size);
> > > > > > +bool __crash_memory_valid(void);
> > > > > >  ssize_t crash_get_memory_size(void);
> > > > > >
> > > > > >  #ifndef arch_kexec_protect_crashkres
> > > > > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > > > > index cb8e6e6f983c..b5c17db25e88 100644
> > > > > > --- a/kernel/kexec.c
> > > > > > +++ b/kernel/kexec.c
> > > > > > @@ -28,7 +28,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> > > > > >       struct kimage *image;
> > > > > >       bool kexec_on_panic = flags & KEXEC_ON_CRASH;
> > > > > >
> > > > > > -     if (kexec_on_panic) {
> > > > > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > > > > >               /* Verify we have a valid entry point */
> > > > > >               if ((entry < phys_to_boot_phys(crashk_res.start)) ||
> > > > > >                   (entry > phys_to_boot_phys(crashk_res.end)))
> > > > > > @@ -44,7 +44,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> > > > > >       image->nr_segments = nr_segments;
> > > > > >       memcpy(image->segment, segments, nr_segments * sizeof(*segments));
> > > > > >
> > > > > > -     if (kexec_on_panic) {
> > > > > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > > > > >               /* Enable special crash kernel control page alloc policy. */
> > > > > >               image->control_page = crashk_res.start;
> > > > > >               image->type = KEXEC_TYPE_CRASH;
> > > > > > @@ -101,7 +101,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > > > > >
> > > > > >       if (flags & KEXEC_ON_CRASH) {
> > > > > >               dest_image = &kexec_crash_image;
> > > > > > -             if (kexec_crash_image)
> > > > > > +             if (kexec_crash_image && __crash_memory_valid())
> > > > > >                       arch_kexec_unprotect_crashkres();
> > > > > >       } else {
> > > > > >               dest_image = &kexec_image;
> > > > > > @@ -157,7 +157,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > > > > >       image = xchg(dest_image, image);
> > > > > >
> > > > > >  out:
> > > > > > -     if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
> > > > > > +     if ((flags & KEXEC_ON_CRASH) && kexec_crash_image &&
> > > > > > +         __crash_memory_valid())
> > > > > >               arch_kexec_protect_crashkres();
> > > > > >
> > > > > >       kimage_free(image);
> > > > > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > > > > index ca2743f9c634..77083c9760fb 100644
> > > > > > --- a/kernel/kexec_core.c
> > > > > > +++ b/kernel/kexec_core.c
> > > > > > @@ -1004,6 +1004,11 @@ void crash_kexec(struct pt_regs *regs)
> > > > > >       }
> > > > > >  }
> > > > > >
> > > > > > +bool __crash_memory_valid(void)
> > > > > > +{
> > > > > > +     return crashk_res.end != crashk_res.start;
> > > > > > +}
> > > > > > +
> > > > > >  ssize_t crash_get_memory_size(void)
> > > > > >  {
> > > > > >       ssize_t size = 0;
> > > > > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > > > index 45637511e0de..0671f4f370ff 100644
> > > > > > --- a/kernel/kexec_file.c
> > > > > > +++ b/kernel/kexec_file.c
> > > > > > @@ -280,7 +280,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
> > > > > >
> > > > > >       image->file_mode = 1;
> > > > > >
> > > > > > -     if (kexec_on_panic) {
> > > > > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > > > > >               /* Enable special crash kernel control page alloc policy. */
> > > > > >               image->control_page = crashk_res.start;
> > > > > >               image->type = KEXEC_TYPE_CRASH;
> > > > > > @@ -345,7 +345,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > > > >       dest_image = &kexec_image;
> > > > > >       if (flags & KEXEC_FILE_ON_CRASH) {
> > > > > >               dest_image = &kexec_crash_image;
> > > > > > -             if (kexec_crash_image)
> > > > > > +             if (kexec_crash_image && __crash_memory_valid())
> > > > > >                       arch_kexec_unprotect_crashkres();
> > > > > >       }
> > > > > >
> > > > > > @@ -408,7 +408,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > > > >  exchange:
> > > > > >       image = xchg(dest_image, image);
> > > > > >  out:
> > > > > > -     if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
> > > > > > +     if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image &&
> > > > > > +         __crash_memory_valid())
> > > > > >               arch_kexec_protect_crashkres();
> > > > > >
> > > > > >       kexec_unlock();
> > > > > >
> > > > > > ---
> > > > > > base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> > > > > > change-id: 20221124-kexec-noalloc-3cab3cbe000f
> > > > > >
> > > > > > Best regards,
> > > > > > --
> > > > > > Ricardo Ribalda <ribalda@chromium.org>
> > > > > >
> > > > >
> > > >
> > > >
> > > > --
> > > > Ricardo Ribalda
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
