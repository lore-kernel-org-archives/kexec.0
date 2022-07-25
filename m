Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED0CC43334
	for <kexec@archiver.kernel.org>; Mon, 25 Jul 2022 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hwkt9PaoOQ3mL2wA6KvIgz+jin76UNo5ozhJm+c84+E=; b=Nafsum31sE/+gB
	Wh9H/aP3qkenF//xF4nr5rnf3c4LY3vry29PQJhawlzdW8s/OAwyXJzYQbbEtRONOYNhXzK27rgwe
	F8W7kPJPyyR0+JxBD7XZupAgsTyOkGG1XoCZeIclWVLeiPY2PLCT5YYtZCo2d6o+bNxOZhwf6si9H
	gXewdy9VeXr0H99t/WOopbK9wFXDGxMwxpWCljgayjF4zoUQs1sIwsVodPeQZVmkAkUgoan82imDc
	JnbpBSt02MxrQeNhzun1CmQ812+TObs5cPo8kTvxmD593PJ1KoPXKeTx13HWluqiKQKJUp+1PbWS3
	W5ImsJoguDd88DlJc+YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFwmv-009DDs-P9; Mon, 25 Jul 2022 12:02:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFwmt-009DBj-Ko
	for kexec@lists.infradead.org; Mon, 25 Jul 2022 12:02:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0E09D60FBF;
	Mon, 25 Jul 2022 12:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEE3C341C6;
	Mon, 25 Jul 2022 12:02:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kmNdDbqB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1658750530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PPvyHjMLA4A9n1tAA4Jqif7EHSTbfVf0ytv4zVQMZbw=;
	b=kmNdDbqBKJxYqauSDh1rz4znS2xhBeIz0oPEysy02qDxKObWVO5vZ65qozv6zyiHldHrog
	45t4+DpAbXG7dH4D6QPnLSDJu2kqTtJvgH3Ub4Z9csu/8tdoLdMmnCQLo9qGigzZqoLHto
	MOyUZst7DdmYxSlppN8375YQDlqhFlI=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ffac6d22 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
	Mon, 25 Jul 2022 12:02:10 +0000 (UTC)
Date: Mon, 25 Jul 2022 14:02:06 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Albert Huang <huangjie.albert@bytedance.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Michal Marek <michal.lkml@markovi.net>,
	Nick Desaulniers <ndesaulniers@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, Joerg Roedel <jroedel@suse.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 1/4] kexec: reuse crash kernel reserved memory for normal
 kexec
Message-ID: <Yt6GPsWcG9iWHBUg@zx2c4.com>
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
 <20220725083904.56552-2-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220725083904.56552-2-huangjie.albert@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_050215_741922_12DE367E 
X-CRM114-Status: GOOD (  21.03  )
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

Hi Albert,

On Mon, Jul 25, 2022 at 04:38:53PM +0800, Albert Huang wrote:
> The kexec userspace tool also needs to add parameter options(-r) that
> support the use of reserved memory (see another patch for kexec)
>
> [...]
>
> -	if (kexec_on_panic) {
> +	if (kexec_on_panic && kexec_on_reserved) {

Two small questions related to this:

- Why does kexec-tools need an option, or more specifically, why does
  userspace need to communicate about this at all? Can't the kernel just
  automatically use the available reserved memory in the case that's not
  already being used by the panic handler kernel? I'm curious about
  whether there are caveats that would make this occasionally
  undesirable, hence suggesting an option.

- I don't totally understand how this works, so I might be a bit off
  here, but is there any chance that this could be made to co-exist with
  kexec_on_panic? Can a larger region just be reserved, specifically for
  this, rather than piggy backing on the panic handler region?

> +static struct page *kimage_alloc_reserverd_control_pages(struct kimage *image,
> +	case KEXEC_TYPE_RESERVED_MEM:
> +		pages = kimage_alloc_reserverd_control_pages(image, order);

Nit:
  reserverd -> reserved

Jason

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
