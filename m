Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18614C433FE
	for <kexec@archiver.kernel.org>; Tue, 29 Nov 2022 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aVDHjrv21qJNpZuJQBkgqA27FzceASO9IjwD0F10HkU=; b=XSxYs97y+Hql9/
	vypf+6H0z1hCqsQrcQMWAw1ojoUKG4PsQbMhewDk3HYdZavua6w+LuYjWLN4PuHQLKtx9oVhZkAIL
	JFPvMXDxHFmVxc88qeyE14DhLfMWc7jy6AuZ6lIU0hXAQI3vdKw9RrloqCXZV2XK9EoaxsGHqiZr4
	g/datzU3sd3IZiG2wDgUgIX81zklEqevJyhEa3kh4BVowN7dKum9j7XcsQ2uwPNRGQWEFcHKeoiPh
	KU78UI2/tQX1LkVwressJGyN1JNYxlYOhVVHddGOsz71idVzH97uD70dZ6YwkWR3VLTVtHVVCNjza
	MwptNpAIyIu+CgRA/cow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p02I8-009cjr-IV; Tue, 29 Nov 2022 15:13:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p02I5-009cgw-BR
	for kexec@lists.infradead.org; Tue, 29 Nov 2022 15:13:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669734774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+0yRb77ltoQSc2X37cXpOsUdhALm0i+PbnCV2ZbJ+8=;
	b=EgkNxd2pJEnPDS6nDM/o7C67lT5dho6Bk+hIjhdE27KG+XlL5kuq37pMlC24Op3GmBLMkn
	pe8Nuos1n1rrKwAMAGFT9VcimcVYjo55ov39hAZ8Uc1ORLPdH9Euzdb1wxHcR8MGLHOukL
	415QUlEStqbWKPm9f071qpHOq8KA5VM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-rQxRq_AMN3S0SPWQ2cOZTQ-1; Tue, 29 Nov 2022 10:12:51 -0500
X-MC-Unique: rQxRq_AMN3S0SPWQ2cOZTQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C27638339C6;
	Tue, 29 Nov 2022 15:12:50 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 86063492B07;
	Tue, 29 Nov 2022 15:12:48 +0000 (UTC)
Date: Tue, 29 Nov 2022 16:12:44 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Ross Zwisler
 <zwisler@kernel.org>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Enable runtime allocation of crash_image
Message-ID: <20221129161244.7ecf59e5@rotkaeppchen>
In-Reply-To: <CANiDSCuwE8_bVErcKV0UcvaPjMx4vbgXzhw2dY69_x2GcB0VxQ@mail.gmail.com>
References: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org>
	<20221128180003.49747650@rotkaeppchen>
	<CANiDSCuwE8_bVErcKV0UcvaPjMx4vbgXzhw2dY69_x2GcB0VxQ@mail.gmail.com>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_071257_513172_C0618CD3 
X-CRM114-Status: GOOD (  50.89  )
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

Ricardo,

On Mon, 28 Nov 2022 18:07:06 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Hi Philipp
> 
> 
> Thanks for your review.
> 
> 
> On Mon, 28 Nov 2022 at 18:00, Philipp Rudo <prudo@redhat.com> wrote:
> >
> > Hi Ricardo,
> >
> > On Thu, 24 Nov 2022 23:23:36 +0100
> > Ricardo Ribalda <ribalda@chromium.org> wrote:
> >  
> > > Usually crash_image is defined statically via the crashkernel parameter
> > > or DT.
> > >
> > > But if the crash kernel is not used, or is smaller than then
> > > area pre-allocated that memory is wasted.
> > >
> > > Also, if the crash kernel was not defined at bootime, there is no way to
> > > use the crash kernel.
> > >
> > > Enable runtime allocation of the crash_image if the crash_image is not
> > > defined statically. Following the same memory allocation/validation path
> > > that for the reboot kexec kernel.
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>  
> >
> > I don't think this patch will work as intended. For one you omit
> > setting the image->type to KEXEC_TYPE_CRASH. But when you grep for that
> > type you will find that there is a lot of special handling done for it.
> > I don't believe that this can simply be skipped without causing
> > problems.
> >
> > Furthermore I think you have missed one important detail. The memory
> > reserved for the crash kernel is not just a buffer for the image but
> > the memory it runs in! For that it has to be a continuous piece of
> > physical memory with usually some additional arch specific limitations.
> > When allocated dynamically all those limitations need to be considered.
> > But a standard kexec doesn't care about those limitations as it doesn't
> > care about the os running before itself. It can simply overwrite the
> > memory when booting. But if the crash kernel does the same it will
> > corrupt the dump it is supposed to generate.  
> 
> Right now, I do not intend to use it to fetch a kdump, I am using it
> as the image that will run when the system crashes.

the crash_image is currently all about creating a dump. If you want to
change that you need to discuss the new behavior in the commit message!
Please update the commit message.

Thanks
Philipp

> 
> It seems to work fine on the two devices that I am using for tests.
> 
> >
> > Thanks
> > Philipp
> >  
> > > ---
> > > kexec: Enable runtime allocation of crash_image
> > >
> > > To: Eric Biederman <ebiederm@xmission.com>
> > > Cc: kexec@lists.infradead.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: Ross Zwisler <zwisler@kernel.org>
> > > Cc: Philipp Rudo <prudo@redhat.com>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > ---
> > >  include/linux/kexec.h | 1 +
> > >  kernel/kexec.c        | 9 +++++----
> > >  kernel/kexec_core.c   | 5 +++++
> > >  kernel/kexec_file.c   | 7 ++++---
> > >  4 files changed, 15 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > index 41a686996aaa..98ca9a32bc8e 100644
> > > --- a/include/linux/kexec.h
> > > +++ b/include/linux/kexec.h
> > > @@ -427,6 +427,7 @@ extern int kexec_load_disabled;
> > >  extern bool kexec_in_progress;
> > >
> > >  int crash_shrink_memory(unsigned long new_size);
> > > +bool __crash_memory_valid(void);
> > >  ssize_t crash_get_memory_size(void);
> > >
> > >  #ifndef arch_kexec_protect_crashkres
> > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > index cb8e6e6f983c..b5c17db25e88 100644
> > > --- a/kernel/kexec.c
> > > +++ b/kernel/kexec.c
> > > @@ -28,7 +28,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> > >       struct kimage *image;
> > >       bool kexec_on_panic = flags & KEXEC_ON_CRASH;
> > >
> > > -     if (kexec_on_panic) {
> > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > >               /* Verify we have a valid entry point */
> > >               if ((entry < phys_to_boot_phys(crashk_res.start)) ||
> > >                   (entry > phys_to_boot_phys(crashk_res.end)))
> > > @@ -44,7 +44,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> > >       image->nr_segments = nr_segments;
> > >       memcpy(image->segment, segments, nr_segments * sizeof(*segments));
> > >
> > > -     if (kexec_on_panic) {
> > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > >               /* Enable special crash kernel control page alloc policy. */
> > >               image->control_page = crashk_res.start;
> > >               image->type = KEXEC_TYPE_CRASH;
> > > @@ -101,7 +101,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > >
> > >       if (flags & KEXEC_ON_CRASH) {
> > >               dest_image = &kexec_crash_image;
> > > -             if (kexec_crash_image)
> > > +             if (kexec_crash_image && __crash_memory_valid())
> > >                       arch_kexec_unprotect_crashkres();
> > >       } else {
> > >               dest_image = &kexec_image;
> > > @@ -157,7 +157,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > >       image = xchg(dest_image, image);
> > >
> > >  out:
> > > -     if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
> > > +     if ((flags & KEXEC_ON_CRASH) && kexec_crash_image &&
> > > +         __crash_memory_valid())
> > >               arch_kexec_protect_crashkres();
> > >
> > >       kimage_free(image);
> > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > index ca2743f9c634..77083c9760fb 100644
> > > --- a/kernel/kexec_core.c
> > > +++ b/kernel/kexec_core.c
> > > @@ -1004,6 +1004,11 @@ void crash_kexec(struct pt_regs *regs)
> > >       }
> > >  }
> > >
> > > +bool __crash_memory_valid(void)
> > > +{
> > > +     return crashk_res.end != crashk_res.start;
> > > +}
> > > +
> > >  ssize_t crash_get_memory_size(void)
> > >  {
> > >       ssize_t size = 0;
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index 45637511e0de..0671f4f370ff 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -280,7 +280,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
> > >
> > >       image->file_mode = 1;
> > >
> > > -     if (kexec_on_panic) {
> > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > >               /* Enable special crash kernel control page alloc policy. */
> > >               image->control_page = crashk_res.start;
> > >               image->type = KEXEC_TYPE_CRASH;
> > > @@ -345,7 +345,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > >       dest_image = &kexec_image;
> > >       if (flags & KEXEC_FILE_ON_CRASH) {
> > >               dest_image = &kexec_crash_image;
> > > -             if (kexec_crash_image)
> > > +             if (kexec_crash_image && __crash_memory_valid())
> > >                       arch_kexec_unprotect_crashkres();
> > >       }
> > >
> > > @@ -408,7 +408,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > >  exchange:
> > >       image = xchg(dest_image, image);
> > >  out:
> > > -     if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
> > > +     if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image &&
> > > +         __crash_memory_valid())
> > >               arch_kexec_protect_crashkres();
> > >
> > >       kexec_unlock();
> > >
> > > ---
> > > base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> > > change-id: 20221124-kexec-noalloc-3cab3cbe000f
> > >
> > > Best regards,  
> >  
> 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
