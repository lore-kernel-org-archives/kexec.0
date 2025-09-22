Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEADCAC5A7
	for <kexec@archiver.kernel.org>; Mon, 22 Sep 2025 04:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K2xyMNi2Q2Q5wM2sfS0Op+qeBofDwb8AwfrpUN3Rdgk=; b=TEe/BJ4n6BPQ4JE0+pecG8ASyG
	UvkYD0H3o8/yG7gSJ3g8CGaiEn39XEa3CgSjCoThVuOJrqn+F45C9OimugsKwjtcMCXxHU8s8mRbs
	Q7HapBEMHJjNxKZ1xw6bpTXwug9nNbF61db839D6fPEKfGkxfXPDV0eo5s6A3yiQJveSWi6nMzjoG
	2N0np5EcreOF2SGg7mE1zPByaY4ub7ERq3JhyyO7yWmyF2xCDa7QKj1bLgiN72bPV4kZCixYnOv7l
	m2mggtrTfodKSoqP/PkUq0uTPYWOU1U5UrjLHKTLVxaW027E+lcgXUtupsmCST5Um6MfiOXJAxSwe
	ccflznOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0YKO-00000008p0p-13nh;
	Mon, 22 Sep 2025 04:39:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0YKJ-00000008p0J-2SFK
	for kexec@lists.infradead.org;
	Mon, 22 Sep 2025 04:39:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758515936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2xyMNi2Q2Q5wM2sfS0Op+qeBofDwb8AwfrpUN3Rdgk=;
	b=UPT9CE6pHr1nkgQtwm2M5dha0Y0Gl1H/HmKSpm2cJBb0aKC6/iW/BrdlXkv26t13NwPbLk
	exDJUa7rM4HD4Z/jJ7hoVR436iTkQjX2civNM9qFnsHEg58oNnguHqSFd75wZAFyJzZSdN
	4sNClpc9XTE/hFkASP3HKeHjvFiAEsk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-ztl69ThLPCS0nbVbEX99_A-1; Mon, 22 Sep 2025 00:38:48 -0400
X-MC-Unique: ztl69ThLPCS0nbVbEX99_A-1
X-Mimecast-MFC-AGG-ID: ztl69ThLPCS0nbVbEX99_A_1758515927
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-269a2b255aaso74732775ad.3
        for <kexec@lists.infradead.org>; Sun, 21 Sep 2025 21:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758515927; x=1759120727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2xyMNi2Q2Q5wM2sfS0Op+qeBofDwb8AwfrpUN3Rdgk=;
        b=Yqodfg2hECYRKlGkaF8aYKuoScauIOKQXiMOZJay8iAAOuRhI6LdDfx8PehFqASHvn
         4JGKoKpfXFoK/CpdumTVMVYuS7g0l+5J3t+H26MOcZw6NmV/ilT84y/jSeTAoisNJUqd
         YaaT2BGbAep852cClVNI0/jG1HyFBjFdaO0+k3ZpTp5IaNdnbmHeTb+XfJpOifZInP/C
         vyxB1wKBtvnDrf5rOQKQ2m8JnoDMV3ksoiTJfUzx4W/1HsjbAKaLDzKW3unrfNi0BcHK
         PGjTPO50vI3A9Nqxt7PIO2Z6n151FYdCv0fB3eeXrb37nSmWE+QNTcMbLIyS6gHnA2J+
         d1fA==
X-Gm-Message-State: AOJu0YzIS+cJiitV7nEQCZ1ZIcjq5gYAMOFg5UDNaDzoZjOfMMB7I9rF
	PDgCK1XsHEa7KkF1gBdOakqSUefIGyBkdC/htTWa3cV+4tDxJP6+Jz6ynZ1KrDPVYxpSjtM+swy
	qRGYo58Nl17Z8C4ju397cKXhW66wq1Z4KO6wCy0DM61xt1EhiAbFilKFWrlJDd5HCrjdU+ecnFC
	38k7nF64Sf6xLdaL6UPQPvQxzgi39EecuSXZg4
X-Gm-Gg: ASbGncsJXzsQdkntBWyd2eRs2LuTT/IaZYFzNrat3SPCK0wujvj+JPw2pXqQeCH4QVp
	qDkiKrTcKvuuED7/t/q9Cmbbm/U8jqr2yU9IBXqiv8O8/SamYDgy/Phmk1WRFsIEoPTQn5MQXrQ
	xBOGguwa+8k/zp+8OFs/7bjA==
X-Received: by 2002:a17:902:f54b:b0:258:f033:3ff9 with SMTP id d9443c01a7336-269ba53568bmr150042415ad.48.1758515927310;
        Sun, 21 Sep 2025 21:38:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUG0ltaecDTkAraUEqz2+UKNcSY1Dj+Ovhjwa2UwYb0S9xG/FA08tHUW7+5r9hXUFYdsXCbrKmckJZdZHyxwY=
X-Received: by 2002:a17:902:f54b:b0:258:f033:3ff9 with SMTP id
 d9443c01a7336-269ba53568bmr150042035ad.48.1758515925068; Sun, 21 Sep 2025
 21:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250919073522.1840036-1-chenwandun@lixiang.com>
In-Reply-To: <20250919073522.1840036-1-chenwandun@lixiang.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Mon, 22 Sep 2025 12:38:34 +0800
X-Gm-Features: AS18NWCTfX8PjCyiNLB04UPeACi4fdsMVWX0lkPCp2qR7Mh962gGznO5sJRfvLs
Message-ID: <CAF+s44SDWTAkivXhh1=Nhw9wyp+mN8X+Z6OFUyy4mqayHcNukw@mail.gmail.com>
Subject: Re: [PATCH] arm64/crashdump-arm64: Fix makedumpfile error caused by
 fail to get _text address
To: Chen Wandun <chenwandun1@gmail.com>
Cc: kexec@lists.infradead.org, zhaomeijing@lixiang.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _ZjEYPCYx5qpidWZxdVIuW7TdNcaJPqAyrM4bcXALXg_1758515927
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_213859_865822_2AA26E75 
X-CRM114-Status: GOOD (  23.66  )
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

Hi Chen,

On Fri, Sep 19, 2025 at 3:35=E2=80=AFPM Chen Wandun <chenwandun1@gmail.com>=
 wrote:
>
> I encountered the following error while makedumpfile without enableing
> kernel CONFIG_PROC_KCORE and CONFIG_KALLSYMS_ALL, this error only exists
> before commit 29fe506 (kexec: make -a the default), this commit change
> from kexec_load to kexec_file_load.
>
> read_from_vmcore: Can't seek the dump memory(/proc/vmcore). (offset: ffff=
800084f4c000) Invalid argument
> readpage_elf: Can't read the dump memory(/proc/vmcore).
> readmem: type_addr: 1, addr:41f29800, size:8
> vaddr_to_paddr_arm64: Can't read pgd
> readmem: Can't convert a virtual address(ffff800082edf8a0) to physical ad=
dress.
> readmem: type_addr: 0, addr:ffff800082edf8a0, size:390
> check_release: Can't get the address of system_utsname.
>
> Although several error messages appear when loading second kernel using k=
exec without
> kernel CONFIG_PROC_KCORE and CONFIG_KALLSYMS_ALL, but kexec return 0.
>
> Can't open (/proc/kcore).
> Can't get the symbol of _text to calculate page_offset.
> Can't get the symbol of _text to calculate page_offset.
>
> If kexec unable to get the _text address, it will result in elf_info.kern=
_paddr_start
> to be a large value, and also phdr->p_filesz/phdr->p_offset to be a large=
 value, such as:
>
> readelf -l /proc/vmcore
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   NOTE           0x0000000000001000 0x0000000000000000 0x0000000000000000
>                  0x0000000000001a44 0x0000000000001a44         0x4
>   LOAD           0x0000000000003000 0xffffffffffffffff 0x00007fffc0200000
>                  0xffff800083020000 0xffff800083020000  RWE    0x0
>   LOAD           0xffff800083023000 0x0000000000000000 0x0000000040000000
>                  0x00000001e6e00000 0x00000001e6e00000  RWE    0x0
>   LOAD           0xffff800269e23000 0x00000001f6e00000 0x0000000236e00000
>                  0x0000000009200000 0x0000000009200000  RWE    0x0
>
> This patch avoiding makedumpfile failure by ending the kexec process and =
explicitly
> notifying error.
>

I'm afraid I cannot agree with your proposed fix. The makedumpfile
works on /proc/vmcore. In my opinion, if there isn't enough
information for makedumpfile to work properly, you should try to fix
and supplement it in the first kernel.

Thanks,

Pingfan

> Reported-by: Zhao Meijing <zhaomeijing@lixiang.com>
> Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
> ---
>  kexec/arch/arm64/crashdump-arm64.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashd=
ump-arm64.c
> index 73cb611..8629610 100644
> --- a/kexec/arch/arm64/crashdump-arm64.c
> +++ b/kexec/arch/arm64/crashdump-arm64.c
> @@ -94,9 +94,11 @@ static int iomem_range_callback(void *UNUSED(data), in=
t UNUSED(nr),
>                  * For compatibility, deduce by comparing the gap "__init=
_begin - _stext"
>                  * and the res size of "Kernel code" in /proc/iomem
>                  */
> -               if (kva_text_end - kva_stext =3D=3D length)
> +               if (kva_text_end - kva_stext =3D=3D length) {
> +                       if (!kva_text)
> +                               die("Cannot get kernel _text symbol addre=
ss\n");
>                         elf_info.kern_paddr_start =3D base - (kva_stext -=
 kva_text);
> -               else
> +               } else
>                         elf_info.kern_paddr_start =3D base;
>         }
>         else if (strncmp(str, KERNEL_DATA, strlen(KERNEL_DATA)) =3D=3D 0)
> --
> 2.25.1
>


