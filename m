Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0E8C982C4
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 17:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=; b=0ldyRNN4cbnfQybDfn05gMNfVO
	WRX2HvNTSgZ6S/RQZ2M3yzhy0zXaDtWacU/25UisUbcLlbpwR/5U0W913X090TTNg01P+MvDtrm1t
	xhOixDYV3mBrQC/oumbHcIwtSF3MU2rEj/NBwebBlmT1Gv1OthR9+pAiF1kBsrdYjt7xCg7Zksypd
	usHs2kIHmXjKCDT9C3A5DO4/kBfHOhLFtOLK/sj+vPh4jrZ2pGBOx3QNw5tfGICqmvWdAjROCy342
	Wl0sT0Q/Vgsib0CcoDFswdfuTDRU4BN6VzTTlx3Jhs7USa0tLD0TUxoZhrZMCz/oGGI6v0QST27QF
	2J48C9tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6XKG-00000007ehn-3bYN;
	Tue, 15 Sep 2026 17:52:12 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6XKF-00000007ehU-3Z4k
	for kexec@bombadil.infradead.org;
	Tue, 15 Sep 2026 17:52:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=; b=II1ZAWppOE+auBYxlIuMLW1rFC
	aoCpsM+BcHGgtXaVEqtJwsUEljXAwRAJYn0tAaSOtwYpAG7mHy62V3CPEughDeZgHtwx2CgHsgFr/
	qCC5f6WKgWqyXG1+Xk7sLVYa+vWrZPaO5gae2vLt3MyES30qqUa2c6KTyv8Y3QCngjET+mTEXEjlY
	2nFS0LYR1NyTA2yg4ZsPMu6NBH9tvt0Rn8S8qdhhAISaF1qR0L3Cp1A7W8QiN4+DNIbkQwyJHobUW
	uQFpwXr4xLtUK/vxufWgRUNxIYbD0dr8FiIzhgxehJe3aazG4TQL7LPbb24+XZwP63gHy+6upSC9V
	OIMIqgbw==;
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6XKD-000000076jn-0WpB
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 17:52:10 +0000
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2db425c9050so12125ad.0
        for <kexec@lists.infradead.org>; Tue, 15 Sep 2026 10:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494727; cv=none;
        d=google.com; s=arc-20260327;
        b=Pdughr9Ve0t0zjAeuuZEYj8G9AKF+CFdSiIUYZfNMDr5UWMYYy37jnMrvELOk4CIhU
         pbXb5R8phwv3+QZZEvgVVvIUa7kOS9q896qOwv1SpnGcEJAHviU8PmGMpsf3Q6/fEDzX
         YeAsftsN+0C1jiXVJr5Kg4lOjJIstpNTxu7ptRrIGPbAGQ9gxs12g6eTU7titd4U8YNj
         DnM6E0jJPzz/eYxNyJRNa41tXQ182qrXPofej8ovM3a6u/txzpSMFkqZwnJMobyAc6oS
         JIkRCVItimWdC6AiOQ3x/PYjKJupcBrMnWRPws/pu3NZGt5QLKDbQGawjmPrV68gxPr4
         u/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        fh=QtQNnHkq8Fun01+c8EDcbmjRPN07dqOT5+jII1YnI2g=;
        b=MCbV4c+8KHDxIcuDJkCEXKR8L6vkzR5ELu/jjKeJ5ZGyQrOrkFpFwiTAcr2qt24jp8
         K/qaW9YEtbtb3V7/LBLyA2d+L0rRjoyB2bLt2GTP+9oiD1m0U6zbztkjO5Qssz+Zw3NJ
         S++E22o598CBoLekQgcItqbHExOo+b6E1cAZ4sncOuwhwcXpKky/VFZ2oV4heQKLArG9
         JKmEeRH2waoWzQc4bPOR2iWUDY0KgokQ1zGeT2kBSALDXRqa2Xt1tmzq5i8jQiXSWwTp
         2sRrN+5o3OA/2DFfqrLRMxG25AtjQrSHDVOYr/WNqJgQGlOWTfGAADWd9AjkG6EOMs+A
         Vdig==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494727; x=1790099527; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=v+jO3VJgsnUifpclVFgNdjMcyvUQpnfqHupbIlBGRjnhWtWE97SE9rvGpSIP4pxkSe
         x+TvQSB6BHu7aEaHVF9i+Tkjn617UD9utZMuaCUc0LThFbRvTGBMXVgV2g0cwI0Knhbo
         hW3mOw6slYadATKIlham/UojDKkSqdscHxokQinPCKNPvQf6Bk92Oi1tMmd41AMbVFZM
         xuiw9lXEdvF382NtEcq3V0oehVbN+DF7OVLQeEIAL+ezLrt1HfUv+BOtS2uEKRtM0bXX
         f7OiH78VHG9JEHFH3s+FQmSvt5YdwToBiThIfGmvfkVqDbnj8R5JV7vxFzC2V52td+se
         gxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494727; x=1790099527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=UDST3u00Wj+Jg8XFXb1MR+TCFJPhZMaa3UbDe5EWpplXb46cyu/I74oHuV0vfFLuvH
         5quzAHSOItnzUBIJizKv8wbrB/juklgZNrz4fubeP3prwxehdh58DSN8zEqdbeM7rxA/
         l32Euj1yLSIjPPmpmKMsKAg0rCZNHbwC1kUNNjbQAqtWVNygNO8YW+T70CRcQdZ4NWv7
         4rjXfjVcNkDlvf2tO3fGUnOxt+0TIzEiE8wblSKyn5sw2Z6U30Y8CnlQ3NLyR9f9aTl+
         4QqoGU7VQ8JR0m9wYWDIqKZpfJ02ZpptZOi/9S/bTmdMxLOBkbosRLdgVJSZbeNm98Tf
         Efcw==
X-Forwarded-Encrypted: i=1; AKwUvBy/0UKOSLZAH3yVDeMtZlJtIG9wfMlxS19coG7RFacCqD4j8NFaUScw8oHCORwk13rfoouFkA==@lists.infradead.org
X-Gm-Message-State: AFuF++lqv/cAYvGb4lfHpDglLvIlQUCrh9ChETF+IOp+hv1B1unkQOhB
	3gEV/48YtXs7KOGg3zi4rntWEIWvDcVPlb8E+GR/5lbZBUQEY0dyWiD+dhMsl2HdUx/1pVvWzfq
	7gxILYqGy4MgkeCxR6ijfREaV/YavAt28+gG4tLEr
X-Gm-Gg: AYBFou2BWu39VPZbu2L3BbEBDNNq4ciYDNzrW/6J23rFe7HhXmqpwW2p8ccn6oIvs2u
	fShIuyuXT0alYzwJV7buU07+a9Kqljrxi97YjEo+bescAI+L4EuQsB7aDsFdUUnjdoIInr75Nzo
	PB0Tj1MKQg1/Vo4TtYc1EcQ/q+veV+VOVKhz238x6c6eza1g2eZQ4bJszPkzcSBKT4F5blEg8ss
	8J/znmve7v64uC3Jklbv9jr0IRHy4gdUIO976ZQ1E/HJxe+JF1lD9UosOQH16+DZZkmT8zM29zH
	+PyKaGnK9C+3X10wc1gEI361eyNYR4ZFQg01HwN/UzOc/e9CopMtoTW+VxVvhU2ABENtco6zbo7
	ru4hTuxIM+PKEH/i7MtoWd/lp2iu2xodmVDwK7pLuthcMn13Qtgg=
X-Received: by 2002:a17:902:f612:b0:2dd:5363:31ec with SMTP id
 d9443c01a7336-2dd89c0c38amr177395ad.14.1789494726332; Tue, 15 Sep 2026
 10:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:51:27 +0200
X-Gm-Features: AcwNN1Vhgv53PI2-XyXtJBbVzCNkGiiWjtvOE2b-8zHim7-UybJ3H2xniPj1VUE
Message-ID: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
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
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_185209_276677_E0D2E005 
X-CRM114-Status: GOOD (  15.18  )
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

On Tue, Sep 15, 2026 at 1:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

I'm not really a fan but I feel like if you want to do this, you
should be using task_work so you don't have to touch the entry/exit
paths directly? (And if task_work is too inefficient somehow, you
could tinker with the task_work implementation.)

> When the syscall returns success the exit path installs every staged
> file. When it returns an error it drops the descriptors and the files.

Is this mainly about stuff like "we installed a file descriptor and
then the following put_user() failed"? Because if so, I think a nicer
fix would be to have a policy of "if userspace provides unwritable
memory to a syscall, just keep going and pretend the access worked",
and maybe have a sysctl that kills the process when this happens to
emphasize that userspace should not be doing this.

