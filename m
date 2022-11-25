Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1F7C433FE
	for <kexec@archiver.kernel.org>; Fri, 25 Nov 2022 07:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wBURg2og9HX8ynJLjimWFRv6V7jwLQp3YDpsHj1qY4U=; b=DM3tWZJq5dIvy/
	HE8hnR37PDxn3UPdhALud+UUUw3rRfNoVPhYYyC6x3cl+uP+NI4/3DHjz9/t5aK/RqaytmGEpTwaJ
	lak1xJK1WZrq1HX/goaeF2V5sATHg87ztFZeGt/qxkn2ysDvjAtK5BFHWroMoVsTWarKuPjkuIGIT
	huY7fyWSIIOWN7KBPVvZQWUrAZNzzv01W06pw3UTCSg2EeOcz06Q5dFOrs5H/V4e1GRvewMUPYLhi
	cJ4ToNWH8QV1VS14B4RzUMOBPcGXEGG4JGqSmkvSQ1iCt7Uf3uXNWo/NV3nQmt0MG+rjJgByaooR6
	YtLKeKvXL8FLT4J3uemg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyTOX-00EBir-Iv; Fri, 25 Nov 2022 07:45:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyTOU-00EBh3-B0
	for kexec@lists.infradead.org; Fri, 25 Nov 2022 07:45:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669362305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1aJL8yY2AvWtZ/kybolPnYAS/Vk3EAt7eDYyCnF3Z9c=;
	b=Sll5kgTPt5roXzzFpDVU+bzARGSeXNxEAQ2G9nqNLPBg+SagBxk+GzfcWJYbuTB9WecCFr
	KldnZUHEGqXHyqKnkR5HwydkJ4hZrhll0vepMw1yA8ZMqR10iCRyH16J26L8v7TYd8syE4
	YKe8arynPHe0NDtg2BHR8b+CMFem7po=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-OQo6rHxFM5W_JOoxCdjI4A-1; Fri, 25 Nov 2022 02:45:01 -0500
X-MC-Unique: OQo6rHxFM5W_JOoxCdjI4A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED3E03C0CD48;
	Fri, 25 Nov 2022 07:45:00 +0000 (UTC)
Received: from localhost (ovpn-12-208.pek2.redhat.com [10.72.12.208])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C8C58492B1F;
	Fri, 25 Nov 2022 07:44:59 +0000 (UTC)
Date: Fri, 25 Nov 2022 15:44:55 +0800
From: Baoquan He <bhe@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Philipp Rudo <prudo@redhat.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Enable runtime allocation of crash_image
Message-ID: <Y4Byd94oeoGCuTGq@MiWiFi-R3L-srv>
References: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org>
 <Y4AvTEZiNXfFU1Wv@MiWiFi-R3L-srv>
 <CANiDSCsgFYvShoTo9xAPe0wqSJgTnB7ZgzXmNqD+L2cKdsVoRg@mail.gmail.com>
 <Y4BrjfLSukrSbGn4@MiWiFi-R3L-srv>
 <CANiDSCueVsRMBjjmCDc+r5YjM0UzThLyFm10kp1cKZw4Pnv6kg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANiDSCueVsRMBjjmCDc+r5YjM0UzThLyFm10kp1cKZw4Pnv6kg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221124_234506_484338_98AF5E59 
X-CRM114-Status: GOOD (  50.44  )
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

On 11/25/22 at 08:26am, Ricardo Ribalda wrote:
> Hi Baoquan
> 
> On Fri, 25 Nov 2022 at 08:15, Baoquan He <bhe@redhat.com> wrote:
> >
> > On 11/25/22 at 06:52am, Ricardo Ribalda wrote:
> > > Hi Baoquan
> > >
> > > Thanks for your review!
> > >
> > > On Fri, 25 Nov 2022 at 03:58, Baoquan He <bhe@redhat.com> wrote:
> > > >
> > > > On 11/24/22 at 11:23pm, Ricardo Ribalda wrote:
> > > > > Usually crash_image is defined statically via the crashkernel parameter
> > > > > or DT.
> > > > >
> > > > > But if the crash kernel is not used, or is smaller than then
> > > > > area pre-allocated that memory is wasted.
> > > > >
> > > > > Also, if the crash kernel was not defined at bootime, there is no way to
> > > > > use the crash kernel.
> > > > >
> > > > > Enable runtime allocation of the crash_image if the crash_image is not
> > > > > defined statically. Following the same memory allocation/validation path
> > > > > that for the reboot kexec kernel.
> > > >
> > > > We don't check if the crashkernel memory region is valid in kernel, but
> > > > we do have done the check in kexec-tools utility. Since both kexec_load and
> > > > kexec_file_load need go through path of kexec-tools loading, we haven't
> > > > got problem with lack of the checking in kernel.
> > >
> > > Not sure if I follow you.
> > >
> > > We currently check if the crash kernel is in the right place at
> > > sanity_check_segment_list()
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kexec_core.c#n239
> >
> > Please check below code in kexec-tools utility, currently we have to use
> > kexec -p to enter into kexec_load or kexec_file_load system call. Before
> > entering system call, we have below code:
> 
> So your concern is that the current kexec-tools does not let you pass
> a crashkernel unless there is memory reserved for it?

No, my concern is why we have to do the check in kernel if we have done
that in kexec-tools utility. You didn't say your kexec-lite need this
until now. I think it's fine to add the check in kernel if you prefer to
do the check in kernel, but not in kexec-lite. 

The motivation or reason you want to make the change is very important.


> 
> Once the changes land in the kernel I can make a patch for that. I am
> currently using this to test the code:
> 
> https://chromium-review.googlesource.com/c/chromiumos/platform2/+/3953579/4/kexec-lite/kexec-lite.c
> 
> >
> > https://kernel.googlesource.com/pub/scm/utils/kernel/kexec/kexec-tools.git/+/refs/heads/master/kexec/kexec.c
> >
> > int main(int argc, char *argv[])
> > {
> > ......
> >                 if (do_load &&
> >             ((kexec_flags & KEXEC_ON_CRASH) ||
> >              (kexec_file_flags & KEXEC_FILE_ON_CRASH)) &&
> >             !is_crashkernel_mem_reserved()) {
> >                 die("Memory for crashkernel is not reserved\n"
> >                     "Please reserve memory by passing"
> >                     "\"crashkernel=Y@X\" parameter to kernel\n"
> >                     "Then try to loading kdump kernel\n");
> >         }
> >
> > ......
> > }
> >
> > >
> > >
> > > >
> > > > However, even though we want to do the check, doing like below is much
> > > > easier and more reasonable.
> > > >
> > > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > index 45637511e0de..4d1339bd2ccf 100644
> > > > --- a/kernel/kexec_file.c
> > > > +++ b/kernel/kexec_file.c
> > > > @@ -344,6 +344,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > >
> > > >         dest_image = &kexec_image;
> > > >         if (flags & KEXEC_FILE_ON_CRASH) {
> > > > +               if (!crash_memory_valid())
> > > > +                       return -EINVAL;
> > > >                 dest_image = &kexec_crash_image;
> > > >                 if (kexec_crash_image)
> > > >                         arch_kexec_unprotect_crashkres();
> > > >
> > > > So, I am wondering if there is an issue encountered if we don't do the
> > > > check in kernel.
> > > >
> > > > Thanks
> > > > Baoquan
> > > >
> > > > >
> > > > > ---
> > > > >
> > > > > To: Eric Biederman <ebiederm@xmission.com>
> > > > > Cc: kexec@lists.infradead.org
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Cc: Ross Zwisler <zwisler@kernel.org>
> > > > > Cc: Philipp Rudo <prudo@redhat.com>
> > > > > Cc: Baoquan He <bhe@redhat.com>
> > > > > ---
> > > > >  include/linux/kexec.h | 1 +
> > > > >  kernel/kexec.c        | 9 +++++----
> > > > >  kernel/kexec_core.c   | 5 +++++
> > > > >  kernel/kexec_file.c   | 7 ++++---
> > > > >  4 files changed, 15 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > > > index 41a686996aaa..98ca9a32bc8e 100644
> > > > > --- a/include/linux/kexec.h
> > > > > +++ b/include/linux/kexec.h
> > > > > @@ -427,6 +427,7 @@ extern int kexec_load_disabled;
> > > > >  extern bool kexec_in_progress;
> > > > >
> > > > >  int crash_shrink_memory(unsigned long new_size);
> > > > > +bool __crash_memory_valid(void);
> > > > >  ssize_t crash_get_memory_size(void);
> > > > >
> > > > >  #ifndef arch_kexec_protect_crashkres
> > > > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > > > index cb8e6e6f983c..b5c17db25e88 100644
> > > > > --- a/kernel/kexec.c
> > > > > +++ b/kernel/kexec.c
> > > > > @@ -28,7 +28,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> > > > >       struct kimage *image;
> > > > >       bool kexec_on_panic = flags & KEXEC_ON_CRASH;
> > > > >
> > > > > -     if (kexec_on_panic) {
> > > > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > > > >               /* Verify we have a valid entry point */
> > > > >               if ((entry < phys_to_boot_phys(crashk_res.start)) ||
> > > > >                   (entry > phys_to_boot_phys(crashk_res.end)))
> > > > > @@ -44,7 +44,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> > > > >       image->nr_segments = nr_segments;
> > > > >       memcpy(image->segment, segments, nr_segments * sizeof(*segments));
> > > > >
> > > > > -     if (kexec_on_panic) {
> > > > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > > > >               /* Enable special crash kernel control page alloc policy. */
> > > > >               image->control_page = crashk_res.start;
> > > > >               image->type = KEXEC_TYPE_CRASH;
> > > > > @@ -101,7 +101,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > > > >
> > > > >       if (flags & KEXEC_ON_CRASH) {
> > > > >               dest_image = &kexec_crash_image;
> > > > > -             if (kexec_crash_image)
> > > > > +             if (kexec_crash_image && __crash_memory_valid())
> > > > >                       arch_kexec_unprotect_crashkres();
> > > > >       } else {
> > > > >               dest_image = &kexec_image;
> > > > > @@ -157,7 +157,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > > > >       image = xchg(dest_image, image);
> > > > >
> > > > >  out:
> > > > > -     if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
> > > > > +     if ((flags & KEXEC_ON_CRASH) && kexec_crash_image &&
> > > > > +         __crash_memory_valid())
> > > > >               arch_kexec_protect_crashkres();
> > > > >
> > > > >       kimage_free(image);
> > > > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > > > index ca2743f9c634..77083c9760fb 100644
> > > > > --- a/kernel/kexec_core.c
> > > > > +++ b/kernel/kexec_core.c
> > > > > @@ -1004,6 +1004,11 @@ void crash_kexec(struct pt_regs *regs)
> > > > >       }
> > > > >  }
> > > > >
> > > > > +bool __crash_memory_valid(void)
> > > > > +{
> > > > > +     return crashk_res.end != crashk_res.start;
> > > > > +}
> > > > > +
> > > > >  ssize_t crash_get_memory_size(void)
> > > > >  {
> > > > >       ssize_t size = 0;
> > > > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > > index 45637511e0de..0671f4f370ff 100644
> > > > > --- a/kernel/kexec_file.c
> > > > > +++ b/kernel/kexec_file.c
> > > > > @@ -280,7 +280,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
> > > > >
> > > > >       image->file_mode = 1;
> > > > >
> > > > > -     if (kexec_on_panic) {
> > > > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > > > >               /* Enable special crash kernel control page alloc policy. */
> > > > >               image->control_page = crashk_res.start;
> > > > >               image->type = KEXEC_TYPE_CRASH;
> > > > > @@ -345,7 +345,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > > >       dest_image = &kexec_image;
> > > > >       if (flags & KEXEC_FILE_ON_CRASH) {
> > > > >               dest_image = &kexec_crash_image;
> > > > > -             if (kexec_crash_image)
> > > > > +             if (kexec_crash_image && __crash_memory_valid())
> > > > >                       arch_kexec_unprotect_crashkres();
> > > > >       }
> > > > >
> > > > > @@ -408,7 +408,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > > >  exchange:
> > > > >       image = xchg(dest_image, image);
> > > > >  out:
> > > > > -     if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
> > > > > +     if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image &&
> > > > > +         __crash_memory_valid())
> > > > >               arch_kexec_protect_crashkres();
> > > > >
> > > > >       kexec_unlock();
> > > > >
> > > > > ---
> > > > > base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> > > > > change-id: 20221124-kexec-noalloc-3cab3cbe000f
> > > > >
> > > > > Best regards,
> > > > > --
> > > > > Ricardo Ribalda <ribalda@chromium.org>
> > > > >
> > > >
> > >
> > >
> > > --
> > > Ricardo Ribalda
> > >
> >
> 
> 
> -- 
> Ricardo Ribalda
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
