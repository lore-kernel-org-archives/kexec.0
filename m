Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04D1CA0EC3
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 01:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ppBeN/VyspBgdPB1YtZcua4YAxUqN+0nq6UyJEu8+/I=; b=vw7wg1OmZY50YC
	2Z2iIV8IJaah3+uy5OdnGT7ui+wtIiBUPklcTCfmXkWlLMkracQNRnklD/kWJllZFHl8QJjuf0L8s
	vgELFTt/XZedS44wyrIriwcVKckXOMw6OP9lCD90tBkN3uG6W0AUe6W2lqgdndzvdKFzpStVc8AHZ
	3URcfOmC2ZQyeBUkwc+s/Ut6C+uXsM2t0UK7KsHY593GWt3BbegP3Bca4iQ39GWZdipEHPjgKqmFP
	mHFblcIZSJaTmm+TX+kGI8IXTexmgmwFfPTkiSiiLeBqv1hY+7fhrLrjFxgIbbJL7NmnDXhjBy9Wl
	1RBNzAUoX5DfHaB+lyvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfsd5-001mV1-2Q;
	Tue, 12 Sep 2023 01:55:51 +0000
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfsd2-001mRS-32
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 01:55:50 +0000
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-502a7e1bdc7so4570505e87.0
        for <kexec@lists.infradead.org>; Mon, 11 Sep 2023 18:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694483745; x=1695088545; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dfh8/mDNgK8vxrADw9UDg9zBqSEE3ndEwyQtmVmeyWM=;
        b=DRjBD8uZYWiJaqGW9nhIfr/7hYwfxdEaVUYhaTlEujyIKhOcaFLr4cXxRQhzM5YaQW
         FzVfIBEthsyTOCyIODkSzCFSI4GWx4bDRI/x4O/71ytwV5V8qcpd/C3Fzt7UWuI3/6Ja
         a4b5yhGMGPO7uzvQh5bJ/45uld4Zp8v6pBGWOiU6fQGT0thmBEyVvPIcYfxHtC3KTbS0
         xYE3wOpgscXKO2fbnr3qlllKpcRWjuPPzwtlnyUzIhjKGsHPoxVk7wUY456mnGP5rGzP
         O+KtZ16+UYU4faRZjlb6MeG5mng1BAVi4joqJchVpng7VcQsFS1LdYA3DHreYg1cgQzr
         FseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694483745; x=1695088545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dfh8/mDNgK8vxrADw9UDg9zBqSEE3ndEwyQtmVmeyWM=;
        b=Pwr0qASUVv4UqlFa7lbbCpwUrtcd6PLKFP0+2qy7VH9JV6KTu69XgYtsi92kiruNn/
         dq5EaPAUjtGLxXa93SEYXYrRWzGbRmygLWBftiB1AE4ZvnnK41ASbdxNeKqbaWcnnTzo
         6AqRcw7q4axr/yJe+n+GWIQj86TzwxClFkxKoo8HrowmxZ4DtJMkbxEYT82L9LAFaGFr
         T/db6EBL58SUGCGP7JwsRluV/vVq7yPmWJJ0ESyJpVDoAyHhNzYYtChFkkhvV5U/NpiK
         xAXuSCkx1zJ5MeY65SpiEqIFBUleGpDauAldrJCB0mFXeBMCjnsyXBxfnmPkjbOsu7bu
         w4jQ==
X-Gm-Message-State: AOJu0Yw1xb+/xzdEhQbcgT5UZALqdN982ZJo20/MASQvpQ5U/jQ3xU2v
	YPt3KSfyPLtVTus1XxpVrKxxK9UKsEd/Lj4DVto=
X-Google-Smtp-Source: AGHT+IHCiNJcSbNJ7RSxRhN3Yzlcqa52uNMH/Uq5EU5bd/OleEn/UkclTnAiq3uWYeQwY9zvyocqW9aSvAzI8CUXWrA=
X-Received: by 2002:a05:6512:2038:b0:500:75f1:c22e with SMTP id
 s24-20020a056512203800b0050075f1c22emr7814227lfs.40.1694483744716; Mon, 11
 Sep 2023 18:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694202430.git.pstanner@redhat.com> <CA1AA415-FDF0-4A7A-9BB0-FFF055803F77@kernel.org>
In-Reply-To: <CA1AA415-FDF0-4A7A-9BB0-FFF055803F77@kernel.org>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 12 Sep 2023 11:55:32 +1000
Message-ID: <CAPM=9txUQ64PMmN-KSXC6PG5ozhSB4eLQN8iAUMrv1R9F6Sm6Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Introduce new wrappers to copy user-arrays
To: Kees Cook <kees@kernel.org>
Cc: Philipp Stanner <pstanner@redhat.com>, Kees Cook <keescook@chromium.org>, 
	Andy Shevchenko <andy@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Christian Brauner <brauner@kernel.org>, David Disseldorp <ddiss@suse.de>, Luis Chamberlain <mcgrof@kernel.org>, 
	Siddh Raman Pant <code@siddh.me>, Nick Alcock <nick.alcock@oracle.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>, 
	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_185548_984029_E0ECEC08 
X-CRM114-Status: GOOD (  22.95  )
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

On Tue, 12 Sept 2023 at 11:27, Kees Cook <kees@kernel.org> wrote:
>
> On September 8, 2023 12:59:39 PM PDT, Philipp Stanner <pstanner@redhat.com> wrote:
> >Hi!
> >
> >David Airlie suggested that we could implement new wrappers around
> >(v)memdup_user() for duplicating user arrays.
> >
> >This small patch series first implements the two new wrapper functions
> >memdup_array_user() and vmemdup_array_user(). They calculate the
> >array-sizes safely, i.e., they return an error in case of an overflow.
> >
> >It then implements the new wrappers in two components in kernel/ and two
> >in the drm-subsystem.
> >
> >In total, there are 18 files in the kernel that use (v)memdup_user() to
> >duplicate arrays. My plan is to provide patches for the other 14
> >successively once this series has been merged.
> >
> >
> >Changes since v1:
> >- Insert new headers alphabetically ordered
> >- Remove empty lines in functions' docstrings
> >- Return -EOVERFLOW instead of -EINVAL from wrapper functions
> >
> >
> >@Andy:
> >I test-build it for UM on my x86_64. Builds successfully.
> >A kernel build (localmodconfig) for my Fedora38 @ x86_64 does also boot
> >fine.
> >
> >If there is more I can do to verify the early boot stages are fine,
> >please let me know!
> >
> >P.
> >
> >Philipp Stanner (5):
> >  string.h: add array-wrappers for (v)memdup_user()
> >  kernel: kexec: copy user-array safely
> >  kernel: watch_queue: copy user-array safely
> >  drm_lease.c: copy user-array safely
> >  drm: vmgfx_surface.c: copy user-array safely
> >
> > drivers/gpu/drm/drm_lease.c             |  4 +--
> > drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |  4 +--
> > include/linux/string.h                  | 40 +++++++++++++++++++++++++
> > kernel/kexec.c                          |  2 +-
> > kernel/watch_queue.c                    |  2 +-
> > 5 files changed, 46 insertions(+), 6 deletions(-)
> >
>
> Nice. For the series:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Hey Kees,

what tree do you think it would best to land this through? I'm happy
to send the initial set from a drm branch, but also happy to have it
land via someone with a better process.

Dave.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
