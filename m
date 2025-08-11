Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE45CA0ED1
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 22:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=awL0JISook8hWw9o6aqgJ55OTTrQ762wx6oz1JCvYrA=; b=SAOKSshS+/JZucV78gnWZZovdD
	TdZIUl34HRfNm3L+cSR19RDfECc7/Qo6qlol8CxPu7z5f+450ZIDuPu/UDIPw8P/4FyrZAjWFeqIx
	UrLzA8oh9SnpN1nAJTlqWnLaFkCZ6NMorhXdQthJkdSDYSVxalKZi59VxS9ermnPjhbsuoA/1eWgJ
	wvT282E+quybZeXHdwxmu7FHUzmfWEy2dK+isX4JcWUxXXOtsjJq8FtjV7KSPX45d7dpoUvMNoRpI
	TDajJOQGFuOcdcpl7G8SL+zYt/4BAZSugqwJtlbNuWEF3fJOIuU8YOVtsuqUMfKpNcyQHXVB92DES
	cc0RaHIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulaav-000000099oK-1e9z;
	Mon, 11 Aug 2025 22:02:17 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulVGz-00000008Nqk-2kSK
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 16:21:23 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4af1c1b5b38so54219421cf.1
        for <kexec@lists.infradead.org>; Mon, 11 Aug 2025 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754929280; x=1755534080; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awL0JISook8hWw9o6aqgJ55OTTrQ762wx6oz1JCvYrA=;
        b=eclJ0K0o1Rt2g6Rqq1gFWRguutLTFkqiun9dnCbhFTCMuG4koyngIW/m0UwGrUn3Uv
         z2uf7nyT66lcRnrorITKEW04Rxotn6xSg56uAVXZ+Kh5Mbzz+xhr0GxqY2kFEbPhShkl
         yLAowYZnKsur8jQj5FogN5m7IdWQWJ3pVCVbbUJcov4fAmlWLXpLNFrAuDD0qfwSx73b
         T1PmRMdLR/l2xhF9o8AjYAgKnfUnXaflB4o/aDuXW0k2X1dc9oJTxuPm4aWo53jUs2Ac
         n0sLrOzS+W12g8Al+t+6GijIwB1e5CpvjGuS2m7WUZ96Gl6AVhgcpXh2J85yGxzsglMH
         pLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754929280; x=1755534080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awL0JISook8hWw9o6aqgJ55OTTrQ762wx6oz1JCvYrA=;
        b=KKzAZTLnpEVpiQac/pvDFxyfqpmfqg0RUeb4z920nYPhNRnl23Fy3KTZcADkfyYXIp
         exbfDvf9pzJj8HXkMZok+mmh3xHeo58ZCwGzWry286AwHTk50ZaycqcQ9mOHIshM5E7X
         RurADHMbjbSlwa8CKIpARv5qJRnKWpxQorv09fUyZ1H2Bj6YWYjWSyekZtQL3wX9Mo7/
         3zkIAKItl38Bi9HdpIftcaYqFKQBS1CvhoYJZfpOxqqIqQEu46ZTDaUbQJWquoNDFJq+
         CZ2cF27Mbh3tBKA15/Bag/o1xbrlzyIQz53CQ7LkGXxuq9lDYpUSZp1h7lVooK3Hc428
         AEuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL/nFzw9uUWqyqqE+Z6mJq3FPOGjXUub+dHT9x95d1XlSIJe1yyyoqlKZQLHTJtGJFnnPP7g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxVbWZ44UpEsj7xfLYcAnTjLHizXgZFVtU5UxMxG6PfpwDybF+K
	sviSrafRImrrvY95gqytEtdx0hzfkR5DgVKZJMixappgHkXDr3H7hNMnukfYSgnczoxo1FTmmaL
	Oelt8EoZYJVc3XZcQJ69x5xIrFw3qnL0=
X-Gm-Gg: ASbGncvz9XA26/bDqnnPidLfsKmg+yWfO6KktXvluP7Vw8Pu+c8H9RtJte247ZuV/Nn
	hd5tIoTCHmeGXavDLnj5GYfkJie2F9Iafpn5rcN8DPP150xO+BtMatVaEZEYFin0Pep6yRb8TFw
	AP8GWvi7NK/TRYfnLlRCH3H6RKUZYMbPqOFVH8DebHqW4lMcjgK185aawGhkDwwT+bJiTW8+ynE
	ly1oc4=
X-Google-Smtp-Source: AGHT+IEDpLTv7rwI0cAD28QFliIQ+yhsQyc/LNmqJsRa+8ZnXDomS0x3dmlWYN6EUAqJkku1zV2hhhFk3Xiacn8G2Ic=
X-Received: by 2002:a05:622a:246:b0:4b0:6d53:a0fc with SMTP id
 d75a77b69052e-4b0ecba90cdmr1727651cf.7.1754929260980; Mon, 11 Aug 2025
 09:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250811092659.14903-1-youling.tang@linux.dev>
In-Reply-To: <20250811092659.14903-1-youling.tang@linux.dev>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Mon, 11 Aug 2025 09:20:49 -0700
X-Gm-Features: Ac12FXzUld0iGaUsswbNzvqcYCLYuSpImt4hSWuMJKJTIUip4EMBCi_zM0pJ_tc
Message-ID: <CAK3+h2zXBcAgtWJLXhAzzTZQ6_7Epqc6HuOassm_o5JAftK+Gw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add kexec_file support for LoongArch
To: Youling Tang <youling.tang@linux.dev>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_092121_698699_A815BB39 
X-CRM114-Status: GOOD (  18.42  )
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

Hi Youling,

On Mon, Aug 11, 2025 at 2:28=E2=80=AFAM Youling Tang <youling.tang@linux.de=
v> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> This patchset implement kexec_file_load() support on LoongArch.
>
> This patch series enables us to load the LoongArch vmlinuz.efi or
> vmlinux.efi by specifying its file decriptor, instead of user-filled
> buffer via kexec_load() syscall.
>
> To use kexec_file_load() system call, instead of kexec_load(), at kexec
> command, '-s' options must be specified. kexec-tools needs to apply the
> corresponding patches. These patches can be found in repository [1] and
> will be submitted to the kexec-tools community later.
>
> The basic usage of kexec_file is:
> 1) Load second kernel image:
>  # kexec -s -l vmlinuz.efi --initrd=3Dinitrd.img --reuse-cmdline
>
> 2) Startup second kernel:
>  # kexec -e
>
> For kdump:
> 1) Load capture kernel image:
>  # kexec -s -p vmlinuz.efi --initrd=3Dinitrd.img --reuse-cmdline
>
> 2) Do something to crash, like:
>  # echo c > /proc/sysrq-trigger
>

I am new to this feature but I am interested to test this feature, How
do I get the second kernel or capture image vmlinux.efi and
initrd.img, do I need to build them separately and how?

> Link:
> [1] https://github.com/tangyouling/kexec-tools/commits/main/
>
> Youling Tang (6):
>   LoongArch: Add struct loongarch_image_header for kernel image
>   LoongArch: Add kexec_file support
>   LoongArch/kexec_file: Add initrd loading
>   LoongArch/kexec_file: Add crash dump support
>   LoongArch/kexec_file: Add "mem" parameter to limit memory usage of
>     kdump kernel
>   LoongArch: Enable CONFIG_KEXEC_FILE
>
>  arch/loongarch/Kconfig                     |   8 +
>  arch/loongarch/configs/loongson3_defconfig |   1 +
>  arch/loongarch/include/asm/image.h         |  58 +++++
>  arch/loongarch/include/asm/kexec.h         |  12 ++
>  arch/loongarch/kernel/Makefile             |   1 +
>  arch/loongarch/kernel/kexec_image.c        | 112 ++++++++++
>  arch/loongarch/kernel/machine_kexec.c      |  33 ++-
>  arch/loongarch/kernel/machine_kexec_file.c | 234 +++++++++++++++++++++
>  8 files changed, 448 insertions(+), 11 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/image.h
>  create mode 100644 arch/loongarch/kernel/kexec_image.c
>  create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
>
> --
> 2.34.1
>
>

