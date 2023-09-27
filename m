Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7C8E80A9A
	for <kexec@archiver.kernel.org>; Wed, 27 Sep 2023 06:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+EEt8L7nprFk5CiPgs6IYgcyNO9cA1Lk7Nz5KyZKI6M=; b=tIcFyPDQ+v12R7
	kVqZKPPy8u0Q4VmxwnvCvY5xMyX4aDS8yPGKPMu3TFFJYLar94c+/jkDAzy8Joq/9NIFaamEVTMPo
	sjWYknSWhE6rTK+u5KAqZumPU0EjH6MwBc27THaZ9vLhrzjtDngb04QEO4kMnvlP56dcZMYyzlDRE
	tQe8lhoZuYWMZs2bvQd3MQduMeIGgRAedzjWZHiQdjWc4HtNHjDxCoGDt8yzEdK4wgI/fofmpW7zZ
	zJW2Q/+HZ5iwPuFBv/kgb8eVZ6/hqieCPmvzqo7kNoHzl2swu6wLjV6WV2GbG/wvj48K/zaoVTh27
	7MNmKLdmudZPTlsMi07Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlOIs-0007S9-1Z;
	Wed, 27 Sep 2023 06:45:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlOIq-0007RF-1C
	for kexec@lists.infradead.org;
	Wed, 27 Sep 2023 06:45:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695797141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tkBKodVPNXKFy/eHhvRT/7T8c55Racnx6iJvE+aYKdc=;
	b=ZsCU+yI0+SXvGLC4b0dmJAc46hOvmKl2VnwJUJyhw1NJ+VlIoavwFwNtT7eZ0xyFO/kqze
	rO3+xelAr7GEAP43V/0sqeTiFo4u9ZWmnO/6tmeketCKl128jYpZmgHlcLRErkPzQOuseK
	YdMtlb7IohZ7E7+DlSB96St7bJfr4Ts=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-M4LYmjM-OxGoiTO4p7gneQ-1; Wed, 27 Sep 2023 02:45:40 -0400
X-MC-Unique: M4LYmjM-OxGoiTO4p7gneQ-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-348c5e468faso24715845ab.0
        for <kexec@lists.infradead.org>; Tue, 26 Sep 2023 23:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695797139; x=1696401939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkBKodVPNXKFy/eHhvRT/7T8c55Racnx6iJvE+aYKdc=;
        b=dSj5TA6yIJnpNXTvkfPH3Xghptia9WfvA6K6hV0rMuIJkP18PhTlwbXxmUh0Bzd8WO
         1h29e2CieVHwfEZrvT7RCXDOlJ/ctPqKC4gyxpJ2ol/UW0Rc9RY4hzbHeu/0c6YGcSdR
         lZ2/iJP6xZvMaF4S4kkHo/Pzk/Z6BQ/6XhDb9nNntLpffbvTDCL/+/D+OR86JIJlKvLZ
         frXqIm3zBxJ7OIPOV4jZSHzGVCXd692UPtm/sy65wWetXPfRPcUSS7EvtLw4cUbVnLcm
         CYIE29h0dCcZqdGqCJcst/akQeDoKeV43zJ4yr3aJ3kfFpFdJEaKx++bSi8i8mqWWGCP
         wokQ==
X-Gm-Message-State: AOJu0Yy/HLOC6rYCKUIJG1e+FenQxyw8wf8g7uV478lPd2mi62MDyjSq
	dVQIelT9lOXC1/68n27SgsBzygRzrlxzt1VKH9vRqTG7PlPC5fApj3bFbxOkNqmTcTIMxNp90sW
	c1nzjySj0/g6/5+mKDYF+oegTqPO7r5FkNhsz
X-Received: by 2002:a92:db4b:0:b0:349:983c:4940 with SMTP id w11-20020a92db4b000000b00349983c4940mr1151820ilq.1.1695797139687;
        Tue, 26 Sep 2023 23:45:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3MTpH8W98ld51vdBMRjHcfXcBjVD09WloG24ewq9itnVSXfuRagE1xr77rRu4vwF3gpWiCwruJ9dZhreDy/0=
X-Received: by 2002:a92:db4b:0:b0:349:983c:4940 with SMTP id
 w11-20020a92db4b000000b00349983c4940mr1151815ilq.1.1695797139439; Tue, 26 Sep
 2023 23:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230923164606.58424-1-ju.o@free.fr>
In-Reply-To: <20230923164606.58424-1-ju.o@free.fr>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 27 Sep 2023 14:45:19 +0800
Message-ID: <CALu+AoQw_kwWi97ntkmQ+VCrkQdPSFhjwCuc-9BZso=op11PWw@mail.gmail.com>
Subject: Re: [PATCH 1/1] kexec: provide a memfd_create() wrapper if not
 present in libc
To: Julien Olivain <ju.o@free.fr>
Cc: kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230926_234544_483218_A59431DE 
X-CRM114-Status: GOOD (  22.82  )
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

On Sun, 24 Sept 2023 at 00:47, Julien Olivain <ju.o@free.fr> wrote:
>
> Commit 714fa115 "kexec/arm64: Simplify the code for zImage" introduced
> a use of the memfd_create() system call, included in version
> kexec-tools v2.0.27.
>
> This system call was introduced in kernel commit [1], first included
> in kernel v3.17 (released on 2014-10-05).
>
> The memfd_create() glibc wrapper function was added much later in
> commit [2], first included in glibc version 2.27 (released on
> 2018-02-01).
>
> This direct use memfd_create() introduced a requirement on
> Kernel >= 3.17 and glibc >= 2.27.
>
> There is old toolchains like [3] for example (which ships gcc 7.3.1,
> glibc 2.25 and includes kernel v4.10 headers), that can still be used
> to build newer kernels. Even if such toolchains can be seen as
> outdated, they are is still claimed as supported by recent kernel.
> For example, Kernel v6.5.5 has a requirement on gcc version 5.1 and
> greater. See [4].
>
> Moreover, kexec-tools <= 2.0.26 could be compiled using recent
> toolchains with alternative libc (e.g. uclibc-ng, musl) which are not
> providing the memfd_create() wrapper.
>
> When compiling kexec-tools v2.0.27 with a toolchain not providing the
> memfd_create() syscall wrapper, the compilation fail with message:
>
>     kexec/kexec.c: In function 'copybuf_memfd':
>     kexec/kexec.c:645:7: warning: implicit declaration of function 'memfd_create'; did you mean 'SYS_memfd_create'? [-Wimplicit-function-declaration]
>       fd = memfd_create("kernel", MFD_ALLOW_SEALING);
>            ^~~~~~~~~~~~
>            SYS_memfd_create
>     kexec/kexec.c:645:30: error: 'MFD_ALLOW_SEALING' undeclared (first use in this function); did you mean '_PC_ALLOC_SIZE_MIN'?
>       fd = memfd_create("kernel", MFD_ALLOW_SEALING);
>                                   ^~~~~~~~~~~~~~~~~
>                                   _PC_ALLOC_SIZE_MIN
>
> In order to let kexec-tools compile in a wider range of configurations,
> this commit adds a memfd_create() function check in autoconf configure
> script, and adds a system call wrapper which will be used if the
> function is not available. With this commit, the environment
> requirement is relaxed to only kernel >= v3.17.
>
> Note: this issue was found in kexec-tools integration in Buildroot [5]
> using the command "utils/test-pkg -a -p kexec", which tests many
> toolchain/arch combinations.

I guess maybe the test was done on non x86 arch,  when I tried to
build on old versions
I got another failure of lacking "getrandom".    Only quickly did a
build test with commenting out
the getrandom code, the build passed with your patch.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
