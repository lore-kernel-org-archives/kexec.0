Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB8EC433FE
	for <kexec@archiver.kernel.org>; Fri, 25 Nov 2022 07:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vmop0hyl9wXQauXuywwhqy70Sq+OLKL+PysK5bKb1hM=; b=RLJ00eFy6x64lF
	4osGc3++KJmSg4hkcqNCxi4XmA15EJrSC19miEt/2uS8YXiaHdm3g4XY1Vmx32BIsYXQWQwO+00XT
	UubBt0GEE8ZVsWTSSKZXUvs9ynwwIE0Ub7PSrnUKFPluQzoMiLZ0Oo+kCrIGYTMmAZHWqzmMLwuvm
	tsinMq2kqGWYa9v0mrMECSApkwxsIwDBH38nzYEJ/9kIvScYWt5AIQbtVJX0vKGm2IDWzAoTdJNkP
	vTDOfVorCHpnGdaLafbpD1B4IFeglgFFj+FaJvS55fy3NzWGLp3e4tajLLTBUQDYGBSwZM3PDaPt5
	ytecjOUu1QA0YiUIZjuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyTBH-00E5Qt-3m; Fri, 25 Nov 2022 07:31:27 +0000
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyTBE-00E5Ov-Ba
	for kexec@lists.infradead.org; Fri, 25 Nov 2022 07:31:26 +0000
Received: by mail-io1-xd29.google.com with SMTP id d123so2535127iof.7
        for <kexec@lists.infradead.org>; Thu, 24 Nov 2022 23:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KrLjnZXippJMG/lNCJKnflO972Pkf957aUOtnF5EOhQ=;
        b=haYHYH2nF8mUWRPOyArS9Lquo1Kww6HkzfwKoZLO9HaWDCC4WGiPLe2Ir1dd4DjIYB
         U9Mj8dysCSNO7rNruG4n361D5cH85BnYslX6+OcWc4qUrQtITpvPfMjd5mxGCfe3YAti
         IQpsxRIQL0pbExdHgsh5XrHdk/C1RbLJ+RX1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrLjnZXippJMG/lNCJKnflO972Pkf957aUOtnF5EOhQ=;
        b=yQ4lmucaHQFNwmyHSCfgXtW1AWzp8tUUNUf0UdBQvgAHYWbSIxpJZER7LykvdesXTQ
         e1rTuxK6Bizr8xKJhY1eYw7j5Klmn3rQNA1xuSyDm2b/FQ0TPbXeOdnX3KrSB0Rasj2N
         vKKcPqlZ58Ne75bqNYYkuWsMtVd1JV/rFw9/W9jopv1WLEkl725E3nhwk4BkatXxCiHp
         j/JDBDto5QHCIkA0URK/gsY7C0hCNWHXsUTd4+TLI/J+uG7o/+Od7miODBxPy8wWDZZ5
         S8jswxhnO28NPDYlXGxlft1qTsbMSm9uu0pP8pF8FWhIXuyYiaCh0j3vj5V6wqey8Goj
         lxUA==
X-Gm-Message-State: ANoB5pn6NDTqap99/AMYb/3GI7wu5ry9+cH/wH4H2DBsnR/MMa8/Kc3f
	NJcv7lyp2XWR7lUI74s1nubQ+RA9oZDjNmDU
X-Google-Smtp-Source: AA0mqf7gkvo8Hwvs9jokd/4SULWpydBZU6yeERbxzfxYM7WDYa86cAPd4o2etonHBeK5q51Q7F88Lg==
X-Received: by 2002:a05:6638:42ce:b0:377:ecee:7993 with SMTP id bm14-20020a05663842ce00b00377ecee7993mr817229jab.305.1669361479571;
        Thu, 24 Nov 2022 23:31:19 -0800 (PST)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id x13-20020a056602160d00b006bb7764890dsm1202285iow.45.2022.11.24.23.31.18
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 23:31:18 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id h17so1654314ila.6
        for <kexec@lists.infradead.org>; Thu, 24 Nov 2022 23:31:18 -0800 (PST)
X-Received: by 2002:a92:cb85:0:b0:302:624e:e49b with SMTP id
 z5-20020a92cb85000000b00302624ee49bmr15840843ilo.172.1669361477866; Thu, 24
 Nov 2022 23:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org>
 <Y4AvTEZiNXfFU1Wv@MiWiFi-R3L-srv> <CANiDSCsgFYvShoTo9xAPe0wqSJgTnB7ZgzXmNqD+L2cKdsVoRg@mail.gmail.com>
 <Y4BubEVKt78k8xaC@MiWiFi-R3L-srv>
In-Reply-To: <Y4BubEVKt78k8xaC@MiWiFi-R3L-srv>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 25 Nov 2022 08:31:06 +0100
X-Gmail-Original-Message-ID: <CANiDSCuy-uZ4r2x6xujiPGTowzN8JuOvTXh3r0Rc7J+YmpqZiw@mail.gmail.com>
Message-ID: <CANiDSCuy-uZ4r2x6xujiPGTowzN8JuOvTXh3r0Rc7J+YmpqZiw@mail.gmail.com>
Subject: Re: [PATCH] kexec: Enable runtime allocation of crash_image
To: Baoquan He <bhe@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Philipp Rudo <prudo@redhat.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221124_233124_419755_9CA5CE0E 
X-CRM114-Status: GOOD (  24.65  )
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

Hi

On Fri, 25 Nov 2022 at 08:27, Baoquan He <bhe@redhat.com> wrote:
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
> And it's not checking if crashkernel memory is valid in
> sanity_check_segment_list(), right? It's checking if the segments
> are placed correctly.

If it is not valid, then this condition is not met.

/* Ensure we are within the crash kernel limits */
if ((mstart < phys_to_boot_phys(crashk_res.start)) ||
    (mend > phys_to_boot_phys(crashk_res.end)))
          return -EADDRNOTAVAIL;


>


-- 
Ricardo Ribalda

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
