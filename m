Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8FBE77371
	for <kexec@archiver.kernel.org>; Sat, 30 Sep 2023 11:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:Subject:Cc:To:From
	:Date:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xipyE/1ac9Glz1ZAb8n/Ku6xmvrizfThgRMRsgZmQLw=; b=EqTQj7n5o0NbRzbK1grsJMAieZ
	vhrOSstuCXwETl9oRbKyes00g4guy6+fmqYXzvpuf06SV5D5DxgnSZDeBQhDDttd08AqTVa67+sxC
	Gu35DK2Tnvj1GYFqcfR8Wu5xQLyFOTDUk2c0TzJw3iup+sC/zkO4mqeVdV1QJeHqCEh1etXab7Hl7
	KrtlvlFOdU76FqjVq7XQ7nK6bvWXGqBJaG/lp8JN3G0Hl071/gXDCuW2x8Sb3ySJqFb08b3bfORuA
	8KCqnX9f7CpJhIVXzelP0F3rQVQimg37P1rtNdTUKiWN2MQQ9WiVmmezv6wxWfAoqJ/t/6c2+port
	LGPbpbCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmYRJ-009To2-1Q;
	Sat, 30 Sep 2023 11:47:17 +0000
Received: from smtp2-g21.free.fr ([212.27.42.2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qmYRC-009Tn8-0i
	for kexec@lists.infradead.org;
	Sat, 30 Sep 2023 11:47:14 +0000
Received: from webmail.free.fr (unknown [172.20.246.2])
	(Authenticated sender: ju.o@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPA id C60582003AE;
	Sat, 30 Sep 2023 13:46:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1696074416;
	bh=oO6VvdZgndBCbZZcm5nOc6eoKX42G19oM38bo4s5x/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h3cPiv4YMVdi0lOYDVZSIyo8ibSHvp63etIaMLZQXXkaYOTCoOBfTj448eaWx+prU
	 gyMEd68Fj+IFdEs8Lqi8ScwCqNuCfkVBNiBo/C2RFOyAeq7Mc+UP8GQCFtV0mMlake
	 dKj7TtleYEnBYwfKzbxjVRxSfRhE4ubD41pux7KoMMnu6VGHEPymgNzrdGkBug6jxt
	 wngawVHUqrTpYVNBE2tmHJFoIiCaii1YDgoKAtJ+t3knfyujT3xKhZpkuTheWx8QHz
	 LMrUPWwleNl7DcQ75MBBsoU1a6Rn36aY+3duhclK1OImNGAKz33uWSYVofv1Bzv34c
	 hVLv8kUwtvSQA==
Received: from 82-64-214-120.subs.proxad.net ([82.64.214.120:36076])
 via 82-64-214-120.subs.proxad.net ([82.64.214.120])
 by webmail.free.fr
 with HTTP (HTTP/1.0 POST); Sat, 30 Sep 2023 13:46:55 +0200
MIME-Version: 1.0
Date: Sat, 30 Sep 2023 13:46:55 +0200
From: Julien Olivain <ju.o@free.fr>
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH 1/1] kexec: provide a memfd_create() wrapper if not
 present in libc
In-Reply-To: <CALu+AoQw_kwWi97ntkmQ+VCrkQdPSFhjwCuc-9BZso=op11PWw@mail.gmail.com>
References: <20230923164606.58424-1-ju.o@free.fr>
 <CALu+AoQw_kwWi97ntkmQ+VCrkQdPSFhjwCuc-9BZso=op11PWw@mail.gmail.com>
User-Agent: Webmail Free/1.6.3
Message-ID: <4e1afe7fc304c2582a91afa2c1b32f24@free.fr>
X-Sender: ju.o@free.fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230930_044710_704460_09BD1C04 
X-CRM114-Status: GOOD (  20.41  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Dave,

On 27/09/2023 08:45, Dave Young wrote:
> On Sun, 24 Sept 2023 at 00:47, Julien Olivain <ju.o@free.fr> wrote:
>> 
>> Commit 714fa115 "kexec/arm64: Simplify the code for zImage" introduced
>> a use of the memfd_create() system call, included in version
>> kexec-tools v2.0.27.
>> 
>> This system call was introduced in kernel commit [1], first included
>> in kernel v3.17 (released on 2014-10-05).
>> 
>> The memfd_create() glibc wrapper function was added much later in
>> commit [2], first included in glibc version 2.27 (released on
>> 2018-02-01).
>> 
>> This direct use memfd_create() introduced a requirement on
>> Kernel >= 3.17 and glibc >= 2.27.
>> 
>> There is old toolchains like [3] for example (which ships gcc 7.3.1,
>> glibc 2.25 and includes kernel v4.10 headers), that can still be used
>> to build newer kernels. Even if such toolchains can be seen as
>> outdated, they are is still claimed as supported by recent kernel.
>> For example, Kernel v6.5.5 has a requirement on gcc version 5.1 and
>> greater. See [4].
>> 
>> Moreover, kexec-tools <= 2.0.26 could be compiled using recent
>> toolchains with alternative libc (e.g. uclibc-ng, musl) which are not
>> providing the memfd_create() wrapper.
>> 
>> When compiling kexec-tools v2.0.27 with a toolchain not providing the
>> memfd_create() syscall wrapper, the compilation fail with message:
>> 
>>     kexec/kexec.c: In function 'copybuf_memfd':
>>     kexec/kexec.c:645:7: warning: implicit declaration of function 
>> 'memfd_create'; did you mean 'SYS_memfd_create'? 
>> [-Wimplicit-function-declaration]
>>       fd = memfd_create("kernel", MFD_ALLOW_SEALING);
>>            ^~~~~~~~~~~~
>>            SYS_memfd_create
>>     kexec/kexec.c:645:30: error: 'MFD_ALLOW_SEALING' undeclared (first 
>> use in this function); did you mean '_PC_ALLOC_SIZE_MIN'?
>>       fd = memfd_create("kernel", MFD_ALLOW_SEALING);
>>                                   ^~~~~~~~~~~~~~~~~
>>                                   _PC_ALLOC_SIZE_MIN
>> 
>> In order to let kexec-tools compile in a wider range of 
>> configurations,
>> this commit adds a memfd_create() function check in autoconf configure
>> script, and adds a system call wrapper which will be used if the
>> function is not available. With this commit, the environment
>> requirement is relaxed to only kernel >= v3.17.
>> 
>> Note: this issue was found in kexec-tools integration in Buildroot [5]
>> using the command "utils/test-pkg -a -p kexec", which tests many
>> toolchain/arch combinations.
> 
> I guess maybe the test was done on non x86 arch,  when I tried to
> build on old versions
> I got another failure of lacking "getrandom".    Only quickly did a
> build test with commenting out
> the getrandom code, the build passed with your patch.

Thanks for testing!

Regarding the getrandom() issue: according to [1], it requires
Kernel 3.17 and glibc 2.25. It is also implemented in uclibc-ng
and musl which is why I didn't see the issue.

getrandom() being a GNU extension, it needs '_GNU_SOURCE' to be
defined in uclibc-ng. Patch [2] was proposed a while back to fix
builds on m68k and uclibc-ng.

> Thanks
> Dave

Best regards,

Julien.

[1] https://man7.org/linux/man-pages/man2/getrandom.2.html#HISTORY
[2] 
https://lore.kernel.org/kexec/20230422095904.1303434-1-laurent@vivier.eu/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
