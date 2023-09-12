Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FC7CA0EC8
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 02:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1OYzpcsgc59tjWwfFcuXAPy39pNMLJSJaKJjkeXIrwY=; b=sA2WXWpBAVuRn0
	argV5qACrQ80/0swmRQAGIM56Mzm4LhQb1X+0it2zp5OLW/JDfoMZiPmHRhPdD+4f+48clTTiQP9G
	ObSpCTqQZEd6gHBJ2VaTiLfLxE+88gRzDPEpwdeEJyXt6T4FjPC5EbLKvEhEDfOj3Hqi/MVaIMjI+
	s8NneuAggHCH4MmeE8rSs5Ny3bC4lqMgAERiMIB7/Wh5/Vv2ygMCpR4Wm9Wr2bZUWgiojP3/JetNa
	V8SeicCOL71wjd9RylGZfk/wAGYCoU3hJ+GlVSLOCVOq8qHRCPfLX030ZWksCNKIGVJDEBTviGSaW
	julkGk0jhNWg9rWJP4yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qftCt-001xJx-0n;
	Tue, 12 Sep 2023 02:32:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qftCo-001xGF-1O
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 02:32:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E9BFA611D4;
	Tue, 12 Sep 2023 02:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2110DC433C9;
	Tue, 12 Sep 2023 02:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694485956;
	bh=f+UYYP/8zjflI4dU+udJaul1f6H1xPDyfB4LDPI/7MA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=NbcHqrPQk2Edwh4cpbNMe1+ElS2UAqqUNCfRMnFZEtbq0q1g+wV/fktJCSB4Hw1Nf
	 4GIqfC3JMO4RGCaQPhOExOd9cp+HIjh+qGEmK6WR3j1x4favGbL+6142W5uXRp0uGj
	 Rs4TwxlLuMU2qTN318UTNbPoKeguHD2TIWS5EbroO/OLw51xoaSP6o7wP+tBEtzDF2
	 JtLp40b0rsghjXkzJtP0P2m+DumKzRh3duOLzrU8YEs73t515+cIcT/jNRpo6HqGm3
	 UmMaWBCIdQQH7RAUYhkCVksYqnOnZTXn1YKv/IBhfgPFulm1TKQ0iLSE2WyPuvog3N
	 vgpoUsTlL6+3w==
Date: Mon, 11 Sep 2023 19:32:34 -0700
From: Kees Cook <kees@kernel.org>
To: Dave Airlie <airlied@gmail.com>
CC: Philipp Stanner <pstanner@redhat.com>, Kees Cook <keescook@chromium.org>,
 Andy Shevchenko <andy@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 Christian Brauner <brauner@kernel.org>, David Disseldorp <ddiss@suse.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Siddh Raman Pant <code@siddh.me>,
 Nick Alcock <nick.alcock@oracle.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce new wrappers to copy user-arrays
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPM=9txUQ64PMmN-KSXC6PG5ozhSB4eLQN8iAUMrv1R9F6Sm6Q@mail.gmail.com>
References: <cover.1694202430.git.pstanner@redhat.com> <CA1AA415-FDF0-4A7A-9BB0-FFF055803F77@kernel.org> <CAPM=9txUQ64PMmN-KSXC6PG5ozhSB4eLQN8iAUMrv1R9F6Sm6Q@mail.gmail.com>
Message-ID: <ACD75DAA-AF42-486C-B44B-9272EF302E3D@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_193247_875413_F499D7C5 
X-CRM114-Status: GOOD (  20.79  )
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

On September 11, 2023 6:55:32 PM PDT, Dave Airlie <airlied@gmail.com> wrote:
>On Tue, 12 Sept 2023 at 11:27, Kees Cook <kees@kernel.org> wrote:
>>
>> On September 8, 2023 12:59:39 PM PDT, Philipp Stanner <pstanner@redhat.com> wrote:
>> >Hi!
>> >
>> >David Airlie suggested that we could implement new wrappers around
>> >(v)memdup_user() for duplicating user arrays.
>> >
>> >This small patch series first implements the two new wrapper functions
>> >memdup_array_user() and vmemdup_array_user(). They calculate the
>> >array-sizes safely, i.e., they return an error in case of an overflow.
>> >
>> >It then implements the new wrappers in two components in kernel/ and two
>> >in the drm-subsystem.
>> >
>> >In total, there are 18 files in the kernel that use (v)memdup_user() to
>> >duplicate arrays. My plan is to provide patches for the other 14
>> >successively once this series has been merged.
>> >
>> >
>> >Changes since v1:
>> >- Insert new headers alphabetically ordered
>> >- Remove empty lines in functions' docstrings
>> >- Return -EOVERFLOW instead of -EINVAL from wrapper functions
>> >
>> >
>> >@Andy:
>> >I test-build it for UM on my x86_64. Builds successfully.
>> >A kernel build (localmodconfig) for my Fedora38 @ x86_64 does also boot
>> >fine.
>> >
>> >If there is more I can do to verify the early boot stages are fine,
>> >please let me know!
>> >
>> >P.
>> >
>> >Philipp Stanner (5):
>> >  string.h: add array-wrappers for (v)memdup_user()
>> >  kernel: kexec: copy user-array safely
>> >  kernel: watch_queue: copy user-array safely
>> >  drm_lease.c: copy user-array safely
>> >  drm: vmgfx_surface.c: copy user-array safely
>> >
>> > drivers/gpu/drm/drm_lease.c             |  4 +--
>> > drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |  4 +--
>> > include/linux/string.h                  | 40 +++++++++++++++++++++++++
>> > kernel/kexec.c                          |  2 +-
>> > kernel/watch_queue.c                    |  2 +-
>> > 5 files changed, 46 insertions(+), 6 deletions(-)
>> >
>>
>> Nice. For the series:
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>
>Hey Kees,
>
>what tree do you think it would best to land this through? I'm happy
>to send the initial set from a drm branch, but also happy to have it
>land via someone with a better process.

Feel free to take it via drm. Usually string.h doesn't get a lot of changes (and even then it's normally additive) so conflicts are rare/easy. :)

-Kees


-- 
Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
