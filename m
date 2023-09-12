Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA3ECA0EC3
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 01:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=876aXnQnqP4V4OOefQOwA1lxUf7vKrDzMWuOJMSzQZo=; b=mGuAz47mZ+6iY8
	g8sLcc6ISswt4aUEMLOA6afi3SHBADiNuRGmmUYyhVeJLv3NjhCbcx2IGO5pKrU71zjuj7UJhk0F7
	xbSdc4IZPGqOp54UB0gDssmN3f4RM8sQ4Eq3iU1CbA4SLZP4SwhM24glEJ/zuj7ONVtDiKRAhntW4
	+9qP73eQYZKnhFznnMxQKjl4UZGQE2jl0MQmlKY44EE6m6NFkjy/ZKxYcS7UN2LFhuEgToalzIkRJ
	OWw6bZF5jqxuJNviHKgulf3V03cUj5utn0AAIJjh9c9Rxba1t+8RFcqwnU2wYZ8EMwRaLLEld9XE6
	LlaH8kOiA1nG2xgCoUXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfsC8-001jR9-2k;
	Tue, 12 Sep 2023 01:28:00 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfsC4-001jQR-2s
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 01:27:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B7811614C6;
	Tue, 12 Sep 2023 01:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1135AC116A1;
	Tue, 12 Sep 2023 01:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694482073;
	bh=i1OpMkK8nN3ugs7HSsHaoziL6+KbW09I3yNP+41/i54=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=coMndRYw55qf5oJQ4mYnWLWjpikXmT0btw0FXm928IRMwJjHPrV8RIjVgNnO6qoCw
	 JT3hvN9kCotKz/cGKyE+wS3Ei9Zwjbvbh5paGnFIT241HNCrBV6JwSsk7sgvWZdwrx
	 g6bohU08+jLacNfIRcHXNR05VIr4EviYjWIB+srXf1V5bplTmm9u/boTLm9f/LeY+/
	 vFcP4Qo/XhwDVgHhlC2oOKiXiBTfmI2kb/I83qwCxA7xUwacibfht0JwFwA/cLJh99
	 QVXYNV//NiaIcTvCjAhHRKRlnSyY34LnNunLnYVl07pdDJgFbAvpgncKRlFndex/0O
	 MsTnACCDqW6Sw==
Date: Mon, 11 Sep 2023 18:27:50 -0700
From: Kees Cook <kees@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>, Kees Cook <keescook@chromium.org>,
 Andy Shevchenko <andy@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 Christian Brauner <brauner@kernel.org>, David Disseldorp <ddiss@suse.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Siddh Raman Pant <code@siddh.me>,
 Nick Alcock <nick.alcock@oracle.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Zack Rusin <zackr@vmware.com>
CC: VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce new wrappers to copy user-arrays
User-Agent: K-9 Mail for Android
In-Reply-To: <cover.1694202430.git.pstanner@redhat.com>
References: <cover.1694202430.git.pstanner@redhat.com>
Message-ID: <CA1AA415-FDF0-4A7A-9BB0-FFF055803F77@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_182757_040861_4D2A8934 
X-CRM114-Status: GOOD (  16.54  )
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

On September 8, 2023 12:59:39 PM PDT, Philipp Stanner <pstanner@redhat.com> wrote:
>Hi!
>
>David Airlie suggested that we could implement new wrappers around
>(v)memdup_user() for duplicating user arrays.
>
>This small patch series first implements the two new wrapper functions
>memdup_array_user() and vmemdup_array_user(). They calculate the
>array-sizes safely, i.e., they return an error in case of an overflow.
>
>It then implements the new wrappers in two components in kernel/ and two
>in the drm-subsystem.
>
>In total, there are 18 files in the kernel that use (v)memdup_user() to
>duplicate arrays. My plan is to provide patches for the other 14
>successively once this series has been merged.
>
>
>Changes since v1:
>- Insert new headers alphabetically ordered
>- Remove empty lines in functions' docstrings
>- Return -EOVERFLOW instead of -EINVAL from wrapper functions
>
>
>@Andy:
>I test-build it for UM on my x86_64. Builds successfully.
>A kernel build (localmodconfig) for my Fedora38 @ x86_64 does also boot
>fine.
>
>If there is more I can do to verify the early boot stages are fine,
>please let me know!
>
>P.
>
>Philipp Stanner (5):
>  string.h: add array-wrappers for (v)memdup_user()
>  kernel: kexec: copy user-array safely
>  kernel: watch_queue: copy user-array safely
>  drm_lease.c: copy user-array safely
>  drm: vmgfx_surface.c: copy user-array safely
>
> drivers/gpu/drm/drm_lease.c             |  4 +--
> drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |  4 +--
> include/linux/string.h                  | 40 +++++++++++++++++++++++++
> kernel/kexec.c                          |  2 +-
> kernel/watch_queue.c                    |  2 +-
> 5 files changed, 46 insertions(+), 6 deletions(-)
>

Nice. For the series:

Reviewed-by: Kees Cook <keescook@chromium.org>



-- 
Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
