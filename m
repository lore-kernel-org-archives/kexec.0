Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCA7EB64D9
	for <kexec@archiver.kernel.org>; Sat,  8 Jul 2023 02:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cof8ErfPrBPSo5bXAX/52L58Awc0ej9N3TGgVqbETog=; b=Ee5/S0KPAwFmoK
	9a7yOZ0McjglTcgBEa8/ztGYqlRScuTqsSG1UM/rng7bvk1P5phS10vnItHzHMf2CYSaOao0g/JIi
	VxtnsDjtI6G6W1d36y8wd70WZR6VwfbPZgngDJY5q2k9LVTe9cWbm8+dl2JIqfgULme/PoRMEGd0Y
	HyZvBABioz+tzK6MDAEqC4s1bMvub5R5M3U5EBcoV1HUWAKx7Uk2ROwznKdipKvAnmQ6Q5G8SYEvx
	0M49LYGhT4mAJqwnRRKtcqDqQ20Ot8TthmQ/uGUL8TkYpNlB3KJHCXCBYypwuwVexwsj3IMhLWrjB
	lOH8yahPhDXc+OgjmsUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHxT4-006K2G-0r;
	Sat, 08 Jul 2023 02:14:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHxSx-006K1P-0j
	for kexec@lists.infradead.org;
	Sat, 08 Jul 2023 02:14:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688782470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kpy+PGb5drQmeWGSE0l67Lj4CAUJY3SUrpQEp6bMyqo=;
	b=CRFfKgnxOo1cP3iy2qu8XFSDbNrxurz8Ld0g00Tz5N55MBWTam8Wvtc10EpLq8wj0FwfaE
	HzztyJ057PjJviJwnDikyqpEeBDcMjfWyw+fuFoPFmCPlY92k5krHx1jP33olsBSubSo/7
	YVgMN9V3B2UH23dh8NhFPd9Z+dd5coY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-iTbWNiJGMhGyjVPRPERf0Q-1; Fri, 07 Jul 2023 22:14:27 -0400
X-MC-Unique: iTbWNiJGMhGyjVPRPERf0Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 799CB800962;
	Sat,  8 Jul 2023 02:14:26 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (ovpn-12-59.pek2.redhat.com [10.72.12.59])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B20B1454142;
	Sat,  8 Jul 2023 02:14:20 +0000 (UTC)
Date: Sat, 8 Jul 2023 10:15:53 +0800
From: Dave Young <dyoung@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	horms@kernel.org, chenjiahao16@huawei.com,
	linux-riscv@lists.infradead.org, x86@kernel.org, bp@alien8.de
Subject: Re: [RFC PATCH 0/4] kdump: add generic functions to simplify
 crashkernel crashkernel in architecture
Message-ID: <ZKjG2R8RhWmJex53@darkstar.users.ipa.redhat.com>
References: <20230619055951.45620-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230619055951.45620-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_191431_340374_D4370675 
X-CRM114-Status: GOOD (  29.50  )
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

On 06/19/23 at 01:59pm, Baoquan He wrote:
> In the current arm64, crashkernel=,high support has been finished after
> several rounds of posting and careful reviewing. The code in arm64 which
> parses crashkernel kernel parameters firstly, then reserve memory can be
> a good example for other ARCH to refer to.
> 
> Whereas in x86_64, the code mixing crashkernel parameter parsing and
> memory reserving is twisted, and looks messy. Refactoring the code to
> make it more readable maintainable is necessary.
> 
> Here, try to abstract the crashkernel parameter parsing code into a
> generic function parse_crashkernel_generic(), and the crashkernel memory
> reserving code into a generic function reserve_crashkernel_generic().
> Then, in ARCH which crashkernel=,high support is needed, a simple
> arch_reserve_crashkernel() can be added to call above two generic
> functions. This can remove the duplicated implmentation code in each
> ARCH, like arm64, x86_64.

Hi Baoquan, the parse_crashkernel_common and parse_crashkernel_generic
are confusion to me.  Thanks for the effort though.

I'm not sure if it will be easy or not, but ideally I think the parse
function can be arch independent, something like a general funtion
parse_crashkernel() which can return the whole necessary infomation of
crashkenrel for arch code to use, for example return like
below pseudo stucture(just a concept, may need to think more):

structure crashkernel_range {
	size,
	range,
	struct list_head list;
}

structure crashkernel{
  structure crashkernel_range *range_list;
  union {
  	offset,
  	low_high
  }
}

So the arch code can just get the data of crashkernel and then check
about the details, if it does not support low and high reservation then
it can just ignore the option.

Thoughts?

> 
> I only change the arm64 and x86_64 implementation to make use of the
> generic functions to simplify code. Risc-v can be done very easily refer
> to the steps in arm64 and x86_64. I leave this to Jiahao or other risc-v
> developer since Jiahao have posted a patchset to add crashkernel=,high
> support to risc-v.
> 
> This patchset is based on the latest linus's tree, and on top of below
> patch:
> 
> arm64: kdump: simplify the reservation behaviour of crashkernel=,high
>       https://git.kernel.org/arm64/c/6c4dcaddbd36
> 
> 
> Baoquan He (4):
>   kdump: rename parse_crashkernel() to parse_crashkernel_common()
>   kdump: add generic functions to parse crashkernel and do reservation
>   arm64: kdump: use generic interfaces to simplify crashkernel
>     reservation code
>   x86: kdump: use generic interfaces to simplify crashkernel reservation
>     code
> 
>  arch/arm/kernel/setup.c              |   4 +-
>  arch/arm64/Kconfig                   |   3 +
>  arch/arm64/include/asm/kexec.h       |   8 ++
>  arch/arm64/mm/init.c                 | 141 ++----------------------
>  arch/ia64/kernel/setup.c             |   4 +-
>  arch/loongarch/kernel/setup.c        |   3 +-
>  arch/mips/cavium-octeon/setup.c      |   2 +-
>  arch/mips/kernel/setup.c             |   4 +-
>  arch/powerpc/kernel/fadump.c         |   5 +-
>  arch/powerpc/kexec/core.c            |   4 +-
>  arch/powerpc/mm/nohash/kaslr_booke.c |   4 +-
>  arch/riscv/mm/init.c                 |   5 +-
>  arch/s390/kernel/setup.c             |   4 +-
>  arch/sh/kernel/machine_kexec.c       |   5 +-
>  arch/x86/Kconfig                     |   3 +
>  arch/x86/include/asm/kexec.h         |  32 ++++++
>  arch/x86/kernel/setup.c              | 141 +++---------------------
>  include/linux/crash_core.h           |  33 +++++-
>  kernel/crash_core.c                  | 158 +++++++++++++++++++++++++--
>  19 files changed, 274 insertions(+), 289 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
