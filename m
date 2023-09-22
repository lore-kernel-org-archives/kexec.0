Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB83E7D0C7
	for <kexec@archiver.kernel.org>; Fri, 22 Sep 2023 03:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IHO46Quc8+98dbw9es0bdPSoh6jCC4kE730F0qEDwd0=; b=cSpogofAEAAPMj
	01LiRtKOuT0tIkx0M4Yc2Iye4wHMNT4JufYZu3dl44bYelU5rdkqOZ543II2bfETBFTJuXzQ0Jy8M
	6CW0oEqIoAjHKiUkvCnBeungVyn7T2MWiIlm95rtjWYeljsv4tEYrxbpcDZ7BHl1PJYrxiaTJw4eO
	i0b4GX/RXPyqxnWKx/z6eENfp0rmMaP3k37mzpV02EhLEsSdcrR6oTTpBqi7iBuKXNQhVO/WBud9Y
	P1qpHWHV2DyKFm6mFD34eNYcrzUEiIrzq0EDqqNrFkk54xcb2qey41/tuUonEISdAc+R2ybset0TB
	jOummwiFENnyFEdnYdhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjWy3-007jfM-1a;
	Fri, 22 Sep 2023 03:36:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjWy0-007jeR-0H
	for kexec@lists.infradead.org;
	Fri, 22 Sep 2023 03:36:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695353784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5nbtnSihkcdolMiH6OLWMgReuYGl7Aj3pvBnJBnB6gY=;
	b=A/Vg8kgtPiF0Cy0YKvUyrlEge69tPi8FdaT/tn4KYHFluSyreKWgO+NNAFh1eOw/DLq/V4
	GIVg3b2BS8dkvEmVJoH3jqIiKxJZVhYyu5WeU3rVMi/2rlMfnBEcJQc/y7mtQ66n5frYqR
	DxjFJjVRIs4R3V/+xUrbUWQKlffxgns=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-RRtHI842OKqqBD-XBX_dLA-1; Thu, 21 Sep 2023 23:36:23 -0400
X-MC-Unique: RRtHI842OKqqBD-XBX_dLA-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-79f9c9df10dso3953739f.0
        for <kexec@lists.infradead.org>; Thu, 21 Sep 2023 20:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695353782; x=1695958582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nbtnSihkcdolMiH6OLWMgReuYGl7Aj3pvBnJBnB6gY=;
        b=snObZ2EYe/99/qkT6yvj9eQc3dKd3oqD2Ijgw5ViwlDQEvju1qqA5wypNw9wQ0D90v
         W/+b3EyXQuove+OPtmOJxVvCeCXn7vfXbaYvdCtHxB7UOPRTBUmCAqmZ1jKlvVHhreSc
         sFmtPy3Yw4Ybm8+rZHyVhtXDofw6S8xdznfRRjxuB+fUtvrI0ySsZ+A9PFzygVchO4ED
         E7wqG0wMlYaPDdzgkyczYHzU+qdJoCyO4RyAzSWHUK2xCWhXH+tbay8stcsketMEb07H
         GIIWipOD/FYRw933UHQ2E9q1wvomDhLzYT6Tccc3+ct6jnlZ2rFF9rryF5P11Zwapiql
         l5aA==
X-Gm-Message-State: AOJu0YzPla4gsNh5Fwe1i+grmiYvJaYm6u3nsnJt436hWeNVT0VORT7s
	/JXw2A0JEJllYUxQIe0bNIgeT+egFymhFYiW4M4HQLEw7YxonYp/vncoY7hYzrjMIDflYTbqnFH
	w73S1yZsZ97ZY+fW43qGkidL9RncRjY5XFIYi
X-Received: by 2002:a92:cd8e:0:b0:351:c27:a1c2 with SMTP id r14-20020a92cd8e000000b003510c27a1c2mr3955910ilb.0.1695353782494;
        Thu, 21 Sep 2023 20:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+wXOxZp+cOJi5q0r1FJ+tMW1VhF0SJ5aK5yaBGea3mqLJba7UHScI/tl90ya7JYMNU2smJlyjpD3d+ScyYO0=
X-Received: by 2002:a92:cd8e:0:b0:351:c27:a1c2 with SMTP id
 r14-20020a92cd8e000000b003510c27a1c2mr3955893ilb.0.1695353782156; Thu, 21 Sep
 2023 20:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230921215938.2192-1-eric.devolder@oracle.com>
In-Reply-To: <20230921215938.2192-1-eric.devolder@oracle.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 22 Sep 2023 11:36:02 +0800
Message-ID: <CALu+AoRv_Y3e2SmyftTLcCPzPbfjshc4dwO+fFK9gwtsgWfyvQ@mail.gmail.com>
Subject: Re: [PATCH] kexec: change locking mechanism to a mutex
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, bhe@redhat.com, vgoyal@redhat.com, 
	ebiederm@xmission.com, kexec@lists.infradead.org, sourabhjain@linux.ibm.com, 
	konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, 
	Valentin Schneider <vschneid@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_203632_223205_0CBAD709 
X-CRM114-Status: GOOD (  43.45  )
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

[Cced Valentin Schneider as he added the trylocks]

On Fri, 22 Sept 2023 at 06:04, Eric DeVolder <eric.devolder@oracle.com> wrote:
>
> Scaled up testing has revealed that the kexec_trylock()
> implementation leads to failures within the crash hotplug
> infrastructure due to the inability to acquire the lock,
> specifically the message:
>
>  crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
>
> When hotplug events occur, the crash hotplug infrastructure first
> attempts to obtain the lock via the kexec_trylock(). However, the
> implementation either acquires the lock, or fails and returns; there
> is no waiting on the lock. Here is the comment/explanation from
> kernel/kexec_internal.h:kexec_trylock():
>
>  * Whatever is used to serialize accesses to the kexec_crash_image needs to be
>  * NMI safe, as __crash_kexec() can happen during nmi_panic(), so here we use a
>  * "simple" atomic variable that is acquired with a cmpxchg().
>
> While this in theory can happen for either CPU or memory hoptlug,
> this problem is most prone to occur for memory hotplug.
>
> When memory is hot plugged, the memory is converted into smaller
> 128MiB memblocks (typically). As each memblock is processed, a
> kernel thread and a udev event thread are created. The udev thread
> tries for the lock via the reading of the sysfs node
> /sys/devices/system/memory/crash_hotplug node, and the kernel
> worker thread tries for the lock upon entering the crash hotplug
> infrastructure.
>
> These threads then compete for the kexec lock.
>
> For example, a 1GiB DIMM is converted into 8 memblocks, each
> spawning two threads for a total of 16 threads that create a small
> "swarm" all trying to acquire the lock. The larger the DIMM, the
> more the memblocks and the larger the swarm.
>
> At the root of the problem is the atomic lock behind kexec_trylock();
> it works well for low lock traffic; ie loading/unloading a capture
> kernel, things that happen basically once. But with the introduction
> of crash hotplug, the traffic through the lock increases significantly,
> and more importantly in bursts occurring at roughly the same time. Thus
> there is a need to wait on the lock.
>
> A possible workaround is to simply retry the lock, say up to N times.
> There is, of course, the problem of determining a value of N that works for
> all implementations, and for all the other call sites of kexec_trylock().
> Not ideal.
>
> The design decision to use the atomic lock is described in the comment
> from kexec_internal.h, cited above. However, examining the code of
> __crash_kexec():
>
>         if (kexec_trylock()) {
>                 if (kexec_crash_image) {
>                         ...
>                 }
>                 kexec_unlock();
>         }
>
> reveals that the use of kexec_trylock() here is actually a "best effort"
> due to the atomic lock.  This atomic lock, prior to crash hotplug,
> would almost always be assured (another kexec syscall could hold the lock
> and prevent this, but that is about it).
>
> So at the point where the capture kernel would be invoked, if the lock
> is not obtained, then kdump doesn't occur.
>
> It is possible to instead use a mutex with proper waiting, and utilize
> mutex_trylock() as the "best effort" in __crash_kexec(). The use of a
> mutex then avoids all the lock acquisition problems that were revealed
> by the crash hotplug activity.
>
> Convert the atomic lock to a mutex.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  kernel/crash_core.c     | 10 ++--------
>  kernel/kexec.c          |  3 +--
>  kernel/kexec_core.c     | 13 +++++--------
>  kernel/kexec_file.c     |  3 +--
>  kernel/kexec_internal.h | 12 +++---------
>  5 files changed, 12 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 03a7932cde0a..9a8378fbdafa 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -749,10 +749,7 @@ int crash_check_update_elfcorehdr(void)
>         int rc = 0;
>
>         /* Obtain lock while reading crash information */
> -       if (!kexec_trylock()) {
> -               pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> -               return 0;
> -       }
> +       kexec_lock();
>         if (kexec_crash_image) {
>                 if (kexec_crash_image->file_mode)
>                         rc = 1;
> @@ -784,10 +781,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>         struct kimage *image;
>
>         /* Obtain lock while changing crash information */
> -       if (!kexec_trylock()) {
> -               pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> -               return;
> -       }
> +       kexec_lock();
>
>         /* Check kdump is not loaded */
>         if (!kexec_crash_image)
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 107f355eac10..a2f687900bb5 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -96,8 +96,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>          * crash kernels we need a serialization here to prevent multiple crash
>          * kernels from attempting to load simultaneously.
>          */
> -       if (!kexec_trylock())
> -               return -EBUSY;
> +       kexec_lock();
>
>         if (flags & KEXEC_ON_CRASH) {
>                 dest_image = &kexec_crash_image;
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 9dc728982d79..202e4590fc1c 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -47,7 +47,7 @@
>  #include <crypto/hash.h>
>  #include "kexec_internal.h"
>
> -atomic_t __kexec_lock = ATOMIC_INIT(0);
> +DEFINE_MUTEX(__kexec_lock);
>
>  /* Flag to indicate we are going to kexec a new kernel */
>  bool kexec_in_progress = false;
> @@ -1057,7 +1057,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>          * of memory the xchg(&kexec_crash_image) would be
>          * sufficient.  But since I reuse the memory...
>          */
> -       if (kexec_trylock()) {
> +       if (mutex_trylock(&__kexec_lock)) {
>                 if (kexec_crash_image) {
>                         struct pt_regs fixed_regs;
>
> @@ -1103,8 +1103,7 @@ ssize_t crash_get_memory_size(void)
>  {
>         ssize_t size = 0;
>
> -       if (!kexec_trylock())
> -               return -EBUSY;
> +       kexec_lock();
>
>         size += crash_resource_size(&crashk_res);
>         size += crash_resource_size(&crashk_low_res);
> @@ -1146,8 +1145,7 @@ int crash_shrink_memory(unsigned long new_size)
>         int ret = 0;
>         unsigned long old_size, low_size;
>
> -       if (!kexec_trylock())
> -               return -EBUSY;
> +       kexec_lock();
>
>         if (kexec_crash_image) {
>                 ret = -ENOENT;
> @@ -1229,8 +1227,7 @@ int kernel_kexec(void)
>  {
>         int error = 0;
>
> -       if (!kexec_trylock())
> -               return -EBUSY;
> +       kexec_lock();
>         if (!kexec_image) {
>                 error = -EINVAL;
>                 goto Unlock;
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index f9a419cd22d4..a4daaaab7fa7 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -341,8 +341,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>
>         image = NULL;
>
> -       if (!kexec_trylock())
> -               return -EBUSY;
> +       kexec_lock();
>
>         if (image_type == KEXEC_TYPE_CRASH) {
>                 dest_image = &kexec_crash_image;
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index 74da1409cd14..4fdae59767b6 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -18,15 +18,9 @@ int kimage_is_destination_range(struct kimage *image,
>   * NMI safe, as __crash_kexec() can happen during nmi_panic(), so here we use a
>   * "simple" atomic variable that is acquired with a cmpxchg().
>   */
> -extern atomic_t __kexec_lock;
> -static inline bool kexec_trylock(void)
> -{
> -       return atomic_cmpxchg_acquire(&__kexec_lock, 0, 1) == 0;
> -}
> -static inline void kexec_unlock(void)
> -{
> -       atomic_set_release(&__kexec_lock, 0);
> -}
> +extern struct mutex __kexec_lock;
> +#define kexec_lock() mutex_lock(&__kexec_lock)
> +#define kexec_unlock() mutex_unlock(&__kexec_lock)
>
>  #ifdef CONFIG_KEXEC_FILE
>  #include <linux/purgatory.h>
> --
> 2.39.3
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
