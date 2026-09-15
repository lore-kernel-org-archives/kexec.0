Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD097C982C1
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 16:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=; b=cziW3+TIJ6BDjTkUcpBMCtnn6s
	kb89DfzsbsBX7bvYshiD6WjGRgJ/HQitkIgCdgZu0Hw18D40ucjLEvU4OjirYwHADH+iJLp941b68
	Frsfy910gx4mcsJJbdqRdURb8Q1hIlne+hHqKEEtyJH8Df/6dIr/xZEHH8hCWWlkxNdgPFhyryKsK
	n8xg6vTkwRrUm9LITbtFmlCWaj8narOH8mCPMuL3bjUBxIF2ZPPSqQpBPHtBa+w99E/2IHVr3TvOe
	wRxjMSY1AMYQx/Sl9KBTuV9MscjUgRgclTfGFcIxF13Bn4Rg1xSAjI5r/tDbz7Qefd3V2HT+MSi+X
	xeG/S84g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Vch-00000007LsZ-2Nsg;
	Tue, 15 Sep 2026 16:03:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6VcU-00000007Lfu-32ou
	for kexec@bombadil.infradead.org;
	Tue, 15 Sep 2026 16:02:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=; b=n7ZSiHt/TAcoBBfAguqGm8+/4Q
	0bc78LdkQY9pqED8RQmXuaQt+kfPHSX3UcBZTs4t6s6/f6I8a+aC67N+HJl3tchgpa0o50BtMyTOU
	qFbjYhlIvluugwLFlXKWNeY8OJm0feyOqkl1BP4HtBBavl13WiXtjlvFXDq2Q5l+CQJNqR52afGn/
	y98yn1EEevEk6FvWk9bVh7CdfL4zT79vZ0bzqlAqkE2N0vxymU04BdFj8qcd0F/YX1OPgDUfcmrpr
	bu23nSmnabUnet7SUL2RoL2Qn65JY4lwRvXfPASIoZ40AYzn7AEZTD1Xy1omaeLGOuoFjFzH7MlRp
	h+gRCumg==;
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6VcR-00000006zo1-2rrx
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 16:02:53 +0000
Received: by mail-ej2-x10.google.com with SMTP id a640c23a62f3a-c254fa4c24cso537085966b.2
        for <kexec@lists.infradead.org>; Tue, 15 Sep 2026 09:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789488170; x=1790092970; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=ApZoUdZfoVt8xfmGzLTaBUkwtHbuVsCtAhFNtiGB1oggTwbZB4NI0kuFUcioZ3paPR
         toLovb4ybxWimN3XFa9bVyedKXKB3k7JagraPAe4nThTBrw/X52lTR/ghggSY5EWLLkB
         dzR2xJ1NUnR6mhsTGO787L2cFNWT82kFndv54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488170; x=1790092970;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=2Jrtx6NvT2JiOkNR8sTHqG5TYQuUiPbYl2StG206aGvwajklbN5s4ht8/XEb2mOnTO
         kNhymOteMKXk85R2Pdsl+Fg3pEeekQFO/vHnH1iVTI7imcKKkIpjuUehLBc8Mr28ufde
         oZEYYQBKfl5dKhDZbkQPtWptnQigwwPrvstIVTCEFwdX/mVQfmwcRTE6aovHNYtY+KXx
         5/FMRY//2e0CUZyNv7DG//pL8fDrFuOTYAqPccqEOXx3NSzz04Fqu/IHoZusw6m2ph08
         b3UHOxQ7rTHhiZ+orJO8Qx0/+dU9dpwWIxFwHCfrVCNeINTLnAE1ju0MSg0a7DVjEmki
         uetA==
X-Forwarded-Encrypted: i=1; AKwUvBzVPd+QUSUTWVjt7UohQL7LK2Rf4Yjf0bYRAR8eKi+WjPDsIOmYLJI9weooh71DDw+FjPoSdQ==@lists.infradead.org
X-Gm-Message-State: AFuF++nxjKZI35C/RG5wPozPFzKMEk32m+UCkda8yGIyT54LeaPHTR9c
	h+FLJO2udGFOKMDD6LB6cRMpb/j31PmcFXcsUSaxRDFnR0fsbDTNY2+/MlGaGxTJhVjeZoZvSNU
	4e95LSqg=
X-Gm-Gg: AYBFou0kXfGgpzA9IbqdYyTdKNs98ApR7D3SlBk9fFg3E3hAmqYd1Mmue/5oBpEaZ2M
	gwSs/H7g/CwNqdw/Nnxs6Xp/vLyknIu2SVWWy3goMVwwrpLFgR5h95grrtBzstJaA837T+QZpdI
	QZkEQgGZQXLg/HbdQxoPb4vd9gxGpFyhvOEFSyvbas0h/sSfIcwsUiHcpHvNg3QsZubr1/qQIpp
	Xu/8UHqIs+WuyT4Srpqpah8CEEAmB85XyH6KKkxS7OyvBZ3JjPjTIeNBpXiJUtzOm/A5UoNwUu5
	YDSuK7b6p4s0J8GpU33Pz2Tk3ppbsEyjxw2NM0FzIidmbzIZTFErqCBDVmvRz9VsRdtVB/xJOVi
	0nMitbjWVbmOIpzbGjWws/Bazc/l8pN1u1Fbm7Ioe86OR+PgTnpTaNS6wpFDSi98phAntPQgjHh
	+PAOw2xM1LfGHmqIELI+F0KafOtg8R9ueZ/QI5vY18+16+wQRIXjy/wsrWflgPiqU7STzd1C2Vj
	jd/z6liksibhkZJTOMENCv/yVtVs/ltNiVrRFgSPhBqCzL/bg==
X-Received: by 2002:a17:907:7b85:b0:c28:fb3f:fe20 with SMTP id a640c23a62f3a-c29b86f99d5mr565620766b.30.1789488169830;
        Tue, 15 Sep 2026 09:02:49 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de5baa11sm320966b.40.2026.09.15.09.02.48
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 09:02:48 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c293c683202so502087066b.3
        for <kexec@lists.infradead.org>; Tue, 15 Sep 2026 09:02:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzz4VE48GmMroSxs3IEaZ+bhIYxPjGE4i0xVNxduLYFhtUb6TdYmYT7U5Ip2f4+p6HDgGcheg==@lists.infradead.org
X-Received: by 2002:a17:907:cd0d:b0:c29:439b:d5c1 with SMTP id
 a640c23a62f3a-c29b86141b9mr553591866b.16.1789488168046; Tue, 15 Sep 2026
 09:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 09:02:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
X-Gm-Features: AcwNN1WK06t9f9BcKFBIanysXcyUXK4eRICuH4x14s60AdlpF6ijCATIYaYAAvQ
Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
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
X-CRM114-CacheID: sfid-20260915_170251_768141_60615892 
X-CRM114-Status: GOOD (  18.18  )
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

On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wrote:
>
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

Honestly, I am *not* a fan. At all.

I think this adds complexity rather than removing it.

The diffstat tells a story:

>  106 files changed, 962 insertions(+), 861 deletions(-)

in how this adds a hundred lines more than it deletes.

But to make things worse, it adds them in bad places: low-level
architecture assembly code.

Those extra lines are *not* making complicated code simpler. Quite the
reverse. They are taking fairly straightforward "just deal with errors
with normal cleanup in the place where it makes sense" and makes the
*straightforward* case simpler, while making the big picture more
complicated and subtle, and adding new code to places that are not
simple and just blindly do somethign that makes no sense in that
context.

IOW: it's more code, and it's more abstraction, and it DOES NOT HELP.

And yes, most of the well-maintained modern platforms (read: x86 and
arm64) use the generic infrastructure and they don't show that
low-level asm effect. So for those cases, it's mainly just  that added
conceptual complexity and a new odd rule - and makes a *successful*
system call go through that "extra work" and indirection phase that it
didn't use to go through.

So it just spreads out the work, and moves it to a less obvious place.

All for the very questionable advantage that you can now randomly add
a file descriptor without the few lines of fairly straightforward
rollback.

IOW, I do not see a single real upside to this, and I see immediate
downsides to it, and a more abstract complicated machinery.

I do *not* see why we woudl want to make this be a "every system call
exit" kind of thing. If there are places that think it's complicated
to do, they could have *their* local little stack of fd's pending. Why
force it onto the low-level system call entry for every system call
when there are only a small handful of actual real cases (the vfs
itself, and random ioctl's by odd driver subsystems).

              Linus

