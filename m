Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DB7C4332F
	for <kexec@archiver.kernel.org>; Mon, 28 Nov 2022 17:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pvE5j5aaKvuv9ERbwEzkl090sO+S2smB03+UWsNEVHc=; b=2uOenaogilHsaG
	KI7K1146HV52m4UUGerRnk9xFtMSOJ+QaktXy2JH64xch6tZd/D8niJYKoVVsCVWksve6OKjRfwIb
	Rx+/WOUu/TZuIuudslvu/+DNV5A1QeJvMby3xCDv5dLHm0wSxw9n1uEbJQOE0I3R+kz/XtU3QqSJA
	xQteQBtW9ofBjcasBNAF7MvA+eQziqPEkDSnV7hDyK1jg9c0+qBS1Iu29AmR8Ggj8o1dgY/fdoS/t
	jfNWnpKSD2vjXUP6skNzdtJ9fFwhLFodN43oynk+4srGa2vSqdAlhrKQAsKtbnQdHG2dhhOba0I8k
	4GQ4KfTFlEC/2u0f0W9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozhbH-002zpW-RF; Mon, 28 Nov 2022 17:07:23 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozhbE-002zoF-SI
	for kexec@lists.infradead.org; Mon, 28 Nov 2022 17:07:22 +0000
Received: by mail-il1-x12c.google.com with SMTP id g7so5341248ile.0
        for <kexec@lists.infradead.org>; Mon, 28 Nov 2022 09:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GHJMh6Kwz/c8rDuMiqvdkoEztpfDMDpqxSBDvuVtmUw=;
        b=f3IgZyUh04bd/HrLhhDVNhrHJSGitfIszkqHV7HEpPgw2VGZWdc2kMSmIk30yzxQJ7
         di33kDapY4MdUgplczekFczkKFBlOVm1it32ldUPFgspl9eXMgV6Czr/IRlbZZylpVMg
         MfQvv/FkObcAePfhYAbqWCwoSPd6Oiqtc8jec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHJMh6Kwz/c8rDuMiqvdkoEztpfDMDpqxSBDvuVtmUw=;
        b=dPVEPrL5g6jxuqQpD2pGq8qdwvvyUVq2dYO0/12T0+jAOxc6E25yL7p3mke5rW8FKV
         4+t9D5qrPMHOKW1YNuDENbvEmz4LLlu2qy7FeVsojt3LJimfYuq75GII8F/a0ZK0Ke8s
         8FekUhrWedL8aK2GqQyoIlhu/duaDYX8jOXlCyOirGIUpaPxq7CxlO3RQ3gy6PzOQ8xP
         8mNEHGMwk1wbBiD0sZabXBXYKFV7mR+8LWo6rHYdoxJeDwV9mXPCM3F7jRwFKM/9LYRw
         Y9VjWEL+QMuunvV/dQdOeSL002TA0v12es8x5k/k2yuq7izcbin4+/ICK9S9FBDBBabU
         qPnA==
X-Gm-Message-State: ANoB5pk3BI0S/zWgejWYhljOo3rhb07WP2cPnanEGnM65xyNNGAoVKqA
	kn84yJGEbf9hnOYSt+GGMAUAuxFhkoXDxtkG
X-Google-Smtp-Source: AA0mqf7iFfLIcyllQHdYZ84bt9eEqjh3Bl8P6eyyevoo6GDdXRHhwytYzXCkwH0GdMYiiZxNZtWZyg==
X-Received: by 2002:a05:6e02:c86:b0:303:cc0:689d with SMTP id b6-20020a056e020c8600b003030cc0689dmr3351040ile.73.1669655238910;
        Mon, 28 Nov 2022 09:07:18 -0800 (PST)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id i14-20020a056e02054e00b003030e36d9bfsm1282088ils.46.2022.11.28.09.07.17
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 09:07:18 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id r81so8081890iod.2
        for <kexec@lists.infradead.org>; Mon, 28 Nov 2022 09:07:17 -0800 (PST)
X-Received: by 2002:a02:c994:0:b0:375:7eda:8c7e with SMTP id
 b20-20020a02c994000000b003757eda8c7emr18987027jap.27.1669655237043; Mon, 28
 Nov 2022 09:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org> <20221128180003.49747650@rotkaeppchen>
In-Reply-To: <20221128180003.49747650@rotkaeppchen>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 28 Nov 2022 18:07:06 +0100
X-Gmail-Original-Message-ID: <CANiDSCuwE8_bVErcKV0UcvaPjMx4vbgXzhw2dY69_x2GcB0VxQ@mail.gmail.com>
Message-ID: <CANiDSCuwE8_bVErcKV0UcvaPjMx4vbgXzhw2dY69_x2GcB0VxQ@mail.gmail.com>
Subject: Re: [PATCH] kexec: Enable runtime allocation of crash_image
To: Philipp Rudo <prudo@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_090720_941722_C97D044F 
X-CRM114-Status: GOOD (  42.54  )
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

Hi Philipp


Thanks for your review.


On Mon, 28 Nov 2022 at 18:00, Philipp Rudo <prudo@redhat.com> wrote:
>
> Hi Ricardo,
>
> On Thu, 24 Nov 2022 23:23:36 +0100
> Ricardo Ribalda <ribalda@chromium.org> wrote:
>
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
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> I don't think this patch will work as intended. For one you omit
> setting the image->type to KEXEC_TYPE_CRASH. But when you grep for that
> type you will find that there is a lot of special handling done for it.
> I don't believe that this can simply be skipped without causing
> problems.
>
> Furthermore I think you have missed one important detail. The memory
> reserved for the crash kernel is not just a buffer for the image but
> the memory it runs in! For that it has to be a continuous piece of
> physical memory with usually some additional arch specific limitations.
> When allocated dynamically all those limitations need to be considered.
> But a standard kexec doesn't care about those limitations as it doesn't
> care about the os running before itself. It can simply overwrite the
> memory when booting. But if the crash kernel does the same it will
> corrupt the dump it is supposed to generate.

Right now, I do not intend to use it to fetch a kdump, I am using it
as the image that will run when the system crashes.

It seems to work fine on the two devices that I am using for tests.

>
> Thanks
> Philipp
>
> > ---
> > kexec: Enable runtime allocation of crash_image
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
>


-- 
Ricardo Ribalda

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
