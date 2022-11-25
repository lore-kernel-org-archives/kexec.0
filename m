Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D49C4332F
	for <kexec@archiver.kernel.org>; Fri, 25 Nov 2022 05:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vCv7JDLtQngqsWE+gbo/caEjs8NJksyeOn8No3fRuTw=; b=QanxRCkQADgx9L
	xmTWwS63OSTI/QNCfR3gXNWSa7Vd803Ca6jll63QL06ITqS25Epl8AaWBEgUhaovD9DcjMFYOG9IJ
	g4mv9Ub20CJ5pQ/ZTP/XPg8/QxEZxZh7x8AKl6yiMUT8BAnfeYU+Rk1nFfxOe+RtRXewhXGel2RFx
	U5yJSAdgUBvT6dY0rhLx5oscSoXTZN3QE7JbWhyt4kRWp1CBne4SrRdAZUWoBJg1oTyLbXI88sKpT
	IDbKXJKPbhhKUAkXRdP4QMg1xbUhrGpARl4uogTK8r53JG/gexe/ibpX02NxdL3yYBth7AFngErQD
	TzVdhU2H+IEo2ru+9SDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyReI-00DPGJ-21; Fri, 25 Nov 2022 05:53:18 +0000
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyReE-00DPDj-MT
	for kexec@lists.infradead.org; Fri, 25 Nov 2022 05:53:16 +0000
Received: by mail-io1-xd2e.google.com with SMTP id r81so2436266iod.2
        for <kexec@lists.infradead.org>; Thu, 24 Nov 2022 21:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=amPWWEFgQMUoD5tXmLx5llUvLdBnUG7bs8YG8SWtoRg=;
        b=RQNBCAq2S/xTo8MWnHo7e/TiCOfCQ4nI1ZMz1bX7kONWnjzFYQ20LTu1jhUBXdQpaY
         TKCFVjqV6UlFYcoP+2qt5WrtazvLB461HiCl/7Ilyo1w8PV/TQsj+kmUobr7Jpuw9tJM
         /MN7nJProEtKIIHbjsMBSDhfgT4xyN2L+SNfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amPWWEFgQMUoD5tXmLx5llUvLdBnUG7bs8YG8SWtoRg=;
        b=A4N9I3UtSYPTxrnAMeczLQDgeCx8rYWS2qzXhujnJsc+ZbNpe/fwWxCu2YnVc/eUSt
         oR/8Xf+wTXA4GqoZ1VB1NknZE2quLDT5pypUAHyISnfsq3hzVbGw4wCrMCQ+qGyyl4CZ
         ULUl1YTHSR789zD+OD5/8Hs2Eqna4U78ZlIqz6y7Lt/P0y4L4WKIhbWa0V8+0w4w0JHQ
         DRPoAruTQrHgofr73p4Jsxh6XQ/7NXBBlt+EIaci8xVcf2DVgWRclmFtus3vZ2vrHWxh
         IGGyk59KdJE70su2dl4d7f7HGwNHknIs7gFCJsJv1PhwSmPBBc2qABkldN2ZpXf23nTN
         b5MA==
X-Gm-Message-State: ANoB5pnH5j+ZqoxbD4eS/rEJTvjBF6gH6WNL0vNyOZs37WuLHRpWrhTU
	V7Oq+pjxMDCxpoNTpTT4cIcjechsJVRuGPqj
X-Google-Smtp-Source: AA0mqf7+5a4SR0EDSZcJ5XR/lpdXeOIK/3JmE2LzZOS0yk0meoXyD1/d7nKJ8qi6QP+vh4BNxjOKOg==
X-Received: by 2002:a05:6638:3475:b0:389:8572:7f61 with SMTP id q53-20020a056638347500b0038985727f61mr1269998jav.1.1669355592133;
        Thu, 24 Nov 2022 21:53:12 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id r4-20020a0566022b8400b006ccc36c963fsm1126694iov.43.2022.11.24.21.53.10
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 21:53:11 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id e189so2442725iof.1
        for <kexec@lists.infradead.org>; Thu, 24 Nov 2022 21:53:10 -0800 (PST)
X-Received: by 2002:a02:c897:0:b0:374:100a:b0c7 with SMTP id
 m23-20020a02c897000000b00374100ab0c7mr7889534jao.185.1669355590403; Thu, 24
 Nov 2022 21:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org> <Y4AvTEZiNXfFU1Wv@MiWiFi-R3L-srv>
In-Reply-To: <Y4AvTEZiNXfFU1Wv@MiWiFi-R3L-srv>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 25 Nov 2022 06:52:59 +0100
X-Gmail-Original-Message-ID: <CANiDSCsgFYvShoTo9xAPe0wqSJgTnB7ZgzXmNqD+L2cKdsVoRg@mail.gmail.com>
Message-ID: <CANiDSCsgFYvShoTo9xAPe0wqSJgTnB7ZgzXmNqD+L2cKdsVoRg@mail.gmail.com>
Subject: Re: [PATCH] kexec: Enable runtime allocation of crash_image
To: Baoquan He <bhe@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Philipp Rudo <prudo@redhat.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221124_215314_781334_12CB55AC 
X-CRM114-Status: GOOD (  37.31  )
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

Thanks for your review!

On Fri, 25 Nov 2022 at 03:58, Baoquan He <bhe@redhat.com> wrote:
>
> On 11/24/22 at 11:23pm, Ricardo Ribalda wrote:
> > Usually crash_image is defined statically via the crashkernel parameter
> > or DT.
> >
> > But if the crash kernel is not used, or is smaller than then
> > area pre-allocated that memory is wasted.
> >
> > Also, if the crash kernel was not defined at bootime, there is no way to
> > use the crash kernel.
> >
> > Enable runtime allocation of the crash_image if the crash_image is not
> > defined statically. Following the same memory allocation/validation path
> > that for the reboot kexec kernel.
>
> We don't check if the crashkernel memory region is valid in kernel, but
> we do have done the check in kexec-tools utility. Since both kexec_load and
> kexec_file_load need go through path of kexec-tools loading, we haven't
> got problem with lack of the checking in kernel.

Not sure if I follow you.

We currently check if the crash kernel is in the right place at
sanity_check_segment_list()
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kexec_core.c#n239


>
> However, even though we want to do the check, doing like below is much
> easier and more reasonable.
>
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 45637511e0de..4d1339bd2ccf 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -344,6 +344,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>
>         dest_image = &kexec_image;
>         if (flags & KEXEC_FILE_ON_CRASH) {
> +               if (!crash_memory_valid())
> +                       return -EINVAL;
>                 dest_image = &kexec_crash_image;
>                 if (kexec_crash_image)
>                         arch_kexec_unprotect_crashkres();
>
> So, I am wondering if there is an issue encountered if we don't do the
> check in kernel.
>
> Thanks
> Baoquan
>
> >
> > ---
> >
> > To: Eric Biederman <ebiederm@xmission.com>
> > Cc: kexec@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Ross Zwisler <zwisler@kernel.org>
> > Cc: Philipp Rudo <prudo@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > ---
> >  include/linux/kexec.h | 1 +
> >  kernel/kexec.c        | 9 +++++----
> >  kernel/kexec_core.c   | 5 +++++
> >  kernel/kexec_file.c   | 7 ++++---
> >  4 files changed, 15 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index 41a686996aaa..98ca9a32bc8e 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -427,6 +427,7 @@ extern int kexec_load_disabled;
> >  extern bool kexec_in_progress;
> >
> >  int crash_shrink_memory(unsigned long new_size);
> > +bool __crash_memory_valid(void);
> >  ssize_t crash_get_memory_size(void);
> >
> >  #ifndef arch_kexec_protect_crashkres
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index cb8e6e6f983c..b5c17db25e88 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -28,7 +28,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> >       struct kimage *image;
> >       bool kexec_on_panic = flags & KEXEC_ON_CRASH;
> >
> > -     if (kexec_on_panic) {
> > +     if (kexec_on_panic && __crash_memory_valid()) {
> >               /* Verify we have a valid entry point */
> >               if ((entry < phys_to_boot_phys(crashk_res.start)) ||
> >                   (entry > phys_to_boot_phys(crashk_res.end)))
> > @@ -44,7 +44,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> >       image->nr_segments = nr_segments;
> >       memcpy(image->segment, segments, nr_segments * sizeof(*segments));
> >
> > -     if (kexec_on_panic) {
> > +     if (kexec_on_panic && __crash_memory_valid()) {
> >               /* Enable special crash kernel control page alloc policy. */
> >               image->control_page = crashk_res.start;
> >               image->type = KEXEC_TYPE_CRASH;
> > @@ -101,7 +101,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> >
> >       if (flags & KEXEC_ON_CRASH) {
> >               dest_image = &kexec_crash_image;
> > -             if (kexec_crash_image)
> > +             if (kexec_crash_image && __crash_memory_valid())
> >                       arch_kexec_unprotect_crashkres();
> >       } else {
> >               dest_image = &kexec_image;
> > @@ -157,7 +157,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> >       image = xchg(dest_image, image);
> >
> >  out:
> > -     if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
> > +     if ((flags & KEXEC_ON_CRASH) && kexec_crash_image &&
> > +         __crash_memory_valid())
> >               arch_kexec_protect_crashkres();
> >
> >       kimage_free(image);
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index ca2743f9c634..77083c9760fb 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1004,6 +1004,11 @@ void crash_kexec(struct pt_regs *regs)
> >       }
> >  }
> >
> > +bool __crash_memory_valid(void)
> > +{
> > +     return crashk_res.end != crashk_res.start;
> > +}
> > +
> >  ssize_t crash_get_memory_size(void)
> >  {
> >       ssize_t size = 0;
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 45637511e0de..0671f4f370ff 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -280,7 +280,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
> >
> >       image->file_mode = 1;
> >
> > -     if (kexec_on_panic) {
> > +     if (kexec_on_panic && __crash_memory_valid()) {
> >               /* Enable special crash kernel control page alloc policy. */
> >               image->control_page = crashk_res.start;
> >               image->type = KEXEC_TYPE_CRASH;
> > @@ -345,7 +345,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> >       dest_image = &kexec_image;
> >       if (flags & KEXEC_FILE_ON_CRASH) {
> >               dest_image = &kexec_crash_image;
> > -             if (kexec_crash_image)
> > +             if (kexec_crash_image && __crash_memory_valid())
> >                       arch_kexec_unprotect_crashkres();
> >       }
> >
> > @@ -408,7 +408,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> >  exchange:
> >       image = xchg(dest_image, image);
> >  out:
> > -     if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
> > +     if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image &&
> > +         __crash_memory_valid())
> >               arch_kexec_protect_crashkres();
> >
> >       kexec_unlock();
> >
> > ---
> > base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> > change-id: 20221124-kexec-noalloc-3cab3cbe000f
> >
> > Best regards,
> > --
> > Ricardo Ribalda <ribalda@chromium.org>
> >
>


--
Ricardo Ribalda

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
