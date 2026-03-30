Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198FCD39421
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nbn+1wU01z27PHPiB6pyjlcWzi6QRevgboBAEreZK0g=; b=zMhI92LbulkpdfCeKfcQq4r3lD
	X6U33hFlp5U5hdSA8P3GLAGK6gqQBt0su4ibeLotjS1St4YaXY1ZtRFpfcDjf7gvUsL3a8gqmNMAk
	IiHP7tXJ/gXYuwLu673Vq0qrmJt+Lxd81nTVCyqdNI5JV6uAjMwCjiw1QWzB0ddxrWCxdqFFImtu1
	n4s1JR97kU7x+SRKnG7ZE5FgJ9B7xULzlPu3/uQqBqgp2SqbUNxL1hzENjN5wnMl2A6Na+fvwKAD0
	i1k9KvxmQOAhIbAHCxH/GeFeoHFo8I+UG9eKksZpbGbucaapHthDAoDrTffGlA2bULsQ7NAzI9NmQ
	8l00mllA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HG8-000000004e6-3YJr;
	Thu, 02 Apr 2026 12:34:52 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w73bO-0000000AZKz-1w0u
	for kexec@lists.infradead.org;
	Mon, 30 Mar 2026 03:47:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1C47E41A07
	for <kexec@lists.infradead.org>; Mon, 30 Mar 2026 03:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01EFC2BCB2
	for <kexec@lists.infradead.org>; Mon, 30 Mar 2026 03:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774842465;
	bh=nbn+1wU01z27PHPiB6pyjlcWzi6QRevgboBAEreZK0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Scb0MZjy9cW04DoU9XXgbCQXHVOKa8DZVHDYfIiIKz2Fqgl3FbLxeTL5wH1FsnBpY
	 bDiVv31JMHV56ZOzGCkfJIHGhtdSgwDDoOdmQZHEVQJr0OiUIlyPhAzciiHFsWHUE5
	 yOl5buCFMT8PBAhOjjBMBO9ikE5Iebn/0Ej0dSz4tPpx94aoiMHtf1yBtqO3rFwQOq
	 7F3RSd6YK57Ou0xLcJTTjr8bkmKSvHsISlzMFKdyUGKweTQfm0r1NvzqhVLExwzHGA
	 TF+qUuaMfIQSuIAcVONoEBik/na74YLUlofcP75mpWWxJS29GiNl6QhjqFIjVRgmQm
	 EvkNHCPAr+0FQ==
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486fe36cfabso24250945e9.1
        for <kexec@lists.infradead.org>; Sun, 29 Mar 2026 20:47:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGCGsEma9AD3ta0GfBaid4DaJBrwbSAdJ1nPRVDrK/Tw4vjq6XqnHYBnru7ngJkXbv6tGlcA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwbfOha1EjmfhZd9TCJhUliXBzpV6/PsTmjNUWiaiNe3TXgBXF2
	f9OkSeyagNU7jDDgKl9ZoISCb3ZyrqfVq8qpM0gM8M3tRDkd7EhOwqqxUKTS9htzHwy6Cd64dRv
	W9JtJwQKGzTQKx/H0t3jngwy3xcy5SZM=
X-Received: by 2002:a05:6000:1a8e:b0:43b:45c6:7ad with SMTP id
 ffacd0b85a97d-43b97a90decmr23305904f8f.29.1774842462488; Sun, 29 Mar 2026
 20:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260328074013.3589544-1-ruanjinjie@huawei.com> <20260328074013.3589544-6-ruanjinjie@huawei.com>
In-Reply-To: <20260328074013.3589544-6-ruanjinjie@huawei.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 30 Mar 2026 11:47:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQu0ekP6Emz=F3uEhPsyqNvH_PwwJU5yOADbR9poQ4noQ@mail.gmail.com>
X-Gm-Features: AQROBzBPJeJ2Q-LIGCNdFWKdGbP9VQWOujey1zE68GwImpeUgj1lBD6fgh2uH4Y
Message-ID: <CAJF2gTQu0ekP6Emz=F3uEhPsyqNvH_PwwJU5yOADbR9poQ4noQ@mail.gmail.com>
Subject: Re: [PATCH v11 05/11] riscv: kexec_file: Fix potential buffer
 overflow in prepare_elf_headers()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org, 
	saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com, 
	vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org, 
	peterz@infradead.org, feng.tang@linux.alibaba.com, 
	pawan.kumar.gupta@linux.intel.com, dapeng1.mi@linux.intel.com, 
	kees@kernel.org, elver@google.com, paulmck@kernel.org, lirongqing@baidu.com, 
	rppt@kernel.org, leitao@debian.org, ardb@kernel.org, cfsworks@gmail.com, 
	osandov@fb.com, jbohac@suse.cz, tangyouling@kylinos.cn, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, eajames@linux.ibm.com, 
	songshuaishuai@tinylab.org, kevin.brodsky@arm.com, vishal.moola@gmail.com, 
	junhui.liu@pigmoral.tech, coxu@redhat.com, fuqiang.wang@easystack.cn, 
	liaoyuanhong@vivo.com, chenjiahao16@huawei.com, hbathini@linux.ibm.com, 
	takahiro.akashi@linaro.org, james.morse@arm.com, lizhengyu3@huawei.com, 
	x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260329_204746_547058_90C11CBD 
X-CRM114-Status: UNSURE (   7.77  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Thu, 02 Apr 2026 05:34:24 -0700
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

On Sat, Mar 28, 2026 at 3:41=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> There is a race condition between the kexec_load() system call
> (crash kernel loading path) and memory hotplug operations that can lead
> to buffer overflow and potential kernel crash.
riscv left no margin for hotplug in prepare_elf_headers(). Actually,
this check has been in crash_exclude_mem_range(); this patch makes it
happen earlier.

Although this patch has no real effect for riscv for the current. I
still give an acked-by, because it's a proper check step in this
callback.

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

