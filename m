Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF4BC88E77
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 19:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=; b=J4w7YGk26g7nFKRWLWBshl/QB5
	sL6+L/pRZCUALmLliorr9D4+lPGXicbDOdvB5G/xPbXwV+Da0NTJRyMshDDq2xjQMjZl0McnSLxd2
	rbCe2Ns35wOwIiRPS1GvcaZXrvU8L/xch2mKwFgrmOztP8X7JkcN50YbensmQWx+MhxEgGA8PXf7u
	xQJhJ3GcrGfOtl7gD4uw8jga2N3tEo3qCv19w00c7Wc+HkbvbRRnsRhbDBqSRO/QwtVRTcXqNCbUq
	KQwLCMi5sETwhcfJMg1z/W83KnMxgGSTeV0S9e4Olf+eshqpf+ujpe3V0qIRC2aw6TAwC1KUTALrd
	r4RnO0ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Yej-00000007qVX-2nnl;
	Tue, 15 Sep 2026 19:17:25 +0000
Received: from mail-lr2-x12.google.com ([2a00:1450:4864:38::12])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Yef-00000007qUi-2AhY
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 19:17:22 +0000
Received: by mail-lr2-x12.google.com with SMTP id 38308e7fff4ca-3a2ff174422so1324461fa.3
        for <kexec@lists.infradead.org>; Tue, 15 Sep 2026 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789499839; x=1790104639; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=EMBBlcEI4BEtzfUUS6WdOjpu3cb7O1MPMsC3O7/GBmXDNJ8J75jp9zcSarhVSW6pQX
         LM+Qt6WIzTzaKqy2oQFOYWaP+WLMKM8ZFhaoFSp9wJob7ZDfLzSOFky/HgUE2Kc9Dqda
         KkD9df3XEOUnDsl5bV390IimPPy+t4IzBZJaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499839; x=1790104639;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=MvSAFm7roXBJYci/CAzS1/jKkvkOUvhqGdb6j+sth2v0guvkEj918v50TjoZc4sdTh
         wcSshglFwoE+/uFtcPBytGi46sq1kGm1Y87aJ/vBbIrADm14JItU+q99K+Lv834g53vS
         OCwOqmOnV2q0RW9O8smYglBIhbbGhfv88dJYhhw870GjoLYzXrQMevL3Af31YZDYO5kq
         gmY8FMz703bzMkaNdKOtsJ3u4ZSJqnH2tJzTW3JPn2b67FLmgr6Lv0HyUAZtSNoe+7tp
         LQJBg7R8Pdi0NlF0yzccIWU58Kpn6xOjnRyNZeI0us0IN4CL8xYFRz2gHEw+Kcw+5Uq0
         lFQw==
X-Forwarded-Encrypted: i=1; AKwUvBzfCbFEzRcBdXsMqbYtrFcAcVfu+o6Gu2Av/uQobDUWJK1hOUiPfGLLnCp149E+9HwaehDw+Q==@lists.infradead.org
X-Gm-Message-State: AFuF++nzaZSQ8tYMdOCCFQLEScFWQS2F1tGWDzAZhvnwgubVvTF7NW5P
	/0eGfkpOLeDXh459fXJ++qbTueAsWMqg1DPB424x6FFtinfpHiJgTALCzj2w6bDX9QLmmwUjTEz
	DbsTSM+dpPK7I
X-Gm-Gg: AYBFou2WkAnNwr2GOq1wmfMzBt+8gdA3G8FmE5yX0AqKaAEIolzqqO/0NikReNqUZ3Q
	iGtl+rqW9HTNNliRDbaJq65blmZtLXe5WfKQVUEh6rawe2arDSLbSnZqacKhnred2/HknJ9F9xG
	AO/ZjSmY9KFmhD1kydOf5ZrCXgoW6MNrxO1O7qCnlfl3R7rfkxjzVEOuYohCkGo2b1qbqnqlkJy
	wTWxHr1fWTIPj7g883/s0tHrEqlZmnzwqqS9jD4+OMPA8PNVpJCwEVfQDzT7A0NQyLyfhYMMYR6
	VKVQjzgbIdsS2aL36u58o8xbUtXtWtJbKgu9hnP/zOHhHoriJsaPRRF/93YRLO6ZH2z5oqiSGaY
	FdZw7PUuDlKuo/B8vOq+PZJagYZVm/TCAUOEYiUrMpdhQdTy5OTa1flAOcvBvFCOTGeQ92pAm+r
	IEShdQ1gAdN6RD2TiZKpcMQhZUL6OfuqRsXpb1IoZlOi/h1loe5vz5EOIAT0IQZa67VD4i+KaK2
	XlhC+TtTPf9S+ny2tHVrFJfXaRN8gh9uHsHu8yiPSQkhcN3cg==
X-Received: by 2002:a05:6512:104b:b0:5b6:17b6:2224 with SMTP id 2adb3069b0e04-5b8ae6b724cmr4117840e87.23.1789499839375;
        Tue, 15 Sep 2026 12:17:19 -0700 (PDT)
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com. [74.125.229.204])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57edcacsm164226e87.81.2026.09.15.12.17.19
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 12:17:19 -0700 (PDT)
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b78so95544e87.2
        for <kexec@lists.infradead.org>; Tue, 15 Sep 2026 12:17:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz9RCagesrC6b4eAKh0ZoOO+dVfxlak+I/4AkMWSL5Ll0fdfJYjm850uaWmcjXu+JrSGHXGjg==@lists.infradead.org
X-Received: by 2002:a17:906:7309:b0:c25:47a4:fedc with SMTP id
 a640c23a62f3a-c29b839a057mr1176039766b.2.1789499355710; Tue, 15 Sep 2026
 12:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
In-Reply-To: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 12:08:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Gm-Features: AcwNN1VCm0LMG7z3Jned014oJh6WBcf4uOx0OBk98_hrtHKbrhcQiMMJ_A-fmB0
Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_121721_573542_6336FAF0 
X-CRM114-Status: GOOD (  17.01  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
>
> Is this mainly about stuff like "we installed a file descriptor and
> then the following put_user() failed"? Because if so, I think a nicer
> fix would be to have a policy of "if userspace provides unwritable
> memory to a syscall, just keep going and pretend the access worked",
> and maybe have a sysctl that kills the process when this happens to
> emphasize that userspace should not be doing this.

We've done that before, where we just ignore put_user() errors and the
user gets whatever the user gets.

It is maybe not optimal, but it's fine. You can find quite a lot of
unchecked put_user() calls with a pattern like

        git grep '^[[:space:]]*put_user(.*);'

and some of them are in core code - see the two in kernel/fork.c, for example.

One of them says "if userspace has not set up a proper pointer then
tough luck". The other one doesn't even bother with a comment.

The scheduler has two cases too, although one of them is admittedly
for another error case.

So yes, saying "if you pass bogus arguments, you get what you get" is
a valid model. It's perhaps not the *preferred* model, but it's not
wrong.

It *would* be wrong to take code that already has error handling and
remove the error handling, though.

                  Linus

