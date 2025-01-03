Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D866E77198
	for <kexec@archiver.kernel.org>; Fri,  3 Jan 2025 09:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YjKQid9S2GlsX6+cy6IeH/REUurpeRuaXtUYrHpX3bo=; b=nMBavst7pZizWG1emA07HmeDrL
	m83MtM/JtD+LHieSrc/nOFGKqgV4RTsWsxiiyJC2UgNYnhRt986FjwBLgjfkxWuiYdbyD7xWMGu/d
	CNZrwtUgixrwiVcEO4Zr3444l+hB/3ZiEMkPukUCbLuYJBsRhBI7DnCn9+k3LX7CKGju5fgF86pHs
	0Fdtwh9fky/mMF9BArxacFkkdlc6JU1iLNpT/EcB6iVnt1zFkZQrDfN7FCzaOF2c68CvnUYx1LTT9
	NBc4CKyuVkugdFJ/k5LJ1OgXTgCVqZVJ/2cfS3CSF4KSh1NMlZQJD5kq0nBlwAe3QLFiHBFViTBL9
	LuPmpNOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTdxJ-0000000Cbds-1QRM;
	Fri, 03 Jan 2025 09:26:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTdvp-0000000CbLY-3mMl
	for kexec@lists.infradead.org;
	Fri, 03 Jan 2025 09:25:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735896324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YjKQid9S2GlsX6+cy6IeH/REUurpeRuaXtUYrHpX3bo=;
	b=ZeQvV6liuLEazG0NEC0gdqYLU3mIpkSk7EtruQVx1dEItnxDZ4Vio2Lp3ZGxsINBWdkTl5
	dDAbcGDQIBjXod5sUcW9wVSyTd4ivkCnt66IBG2mWsMb3F0ipWNCBDEoUmWEKg2Aa14cv8
	AW9taifFFzMcXNVghnsajBDrw3zrBAQ=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-dgj9-Zv5OWWeJhLxulkoyw-1; Fri, 03 Jan 2025 04:23:58 -0500
X-MC-Unique: dgj9-Zv5OWWeJhLxulkoyw-1
X-Mimecast-MFC-AGG-ID: dgj9-Zv5OWWeJhLxulkoyw
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so102879135ab.0
        for <kexec@lists.infradead.org>; Fri, 03 Jan 2025 01:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735896238; x=1736501038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjKQid9S2GlsX6+cy6IeH/REUurpeRuaXtUYrHpX3bo=;
        b=YYOPaGo5+qbc5VCxQKhHe79hRqZ3ZMFEG8hpS0v2bVjivbFWcfi0dzQqOm42OaR3bR
         LC/3mKZMQTacVYEuJSg6ohEZ1P8iOKOzIKVsUIBjE/G4tuWXt5xD4u4X1pedo+CD3qes
         KfY1EvZsKAFJTLrwTkIWTYCHIItIcBP0rgiXDtwh6UIaLV2mxMnB4spiRRDSbZLpomA9
         XR/+KypjkvvnkyecsQF4VT8q9Y6UPGP3szvPLfcJ5+ohZtTKrN2UtUFBFTIMY6z9rKOA
         2qzqV8MePJTmN5rdjsfTWuTe1idfEi78EbsE7l5cNP3aHHMe9w7WbM+yoLP0X5FUspYW
         554g==
X-Forwarded-Encrypted: i=1; AJvYcCU+xraifIwvUlBqhoiZ6MvT7GA4Y4gm1k0ZfHXyGWnIMUVVQNd2JM4giqiHAVHSQdW+9YeLDg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxIsXgIgVjf+pwYZjOJeSp3nK2ehSDAbJ//fYa07iDbQXs8cIHM
	6KCrF8a76Kjkp6IkLJfNcVx+sjuOv4jRmbt25vNpirQTh1pnVvrYPtJLErGVzS8lGB+72YDHNSn
	VzmGR9/zZ+sqdtT0UuOgZwiMCM/2NquwosKLQhRjnvbxKKYRQ/xuriPFWw8RfTid8YRRwr+y33b
	0GHMs3CHHD/AMUuteQWthOmuN2D8rDYt1k
X-Gm-Gg: ASbGncv6TdZYIF6V4p0Hak3TqB/dBw2w4NqOdqWA914HrZCWz1xgjkbZ0kqNXSrCx5u
	l5CaqA7g4NVCJ2TtXL2tb86O7S0IkXRsAHdGP7hU=
X-Received: by 2002:a05:6e02:220d:b0:3a7:8720:9e9e with SMTP id e9e14a558f8ab-3c2d1aa2824mr381603755ab.2.1735896237964;
        Fri, 03 Jan 2025 01:23:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAOPYxVEWKrnXrqPlbxbd/zvcLKYJSgGMQbzxaXP1yyRMRE3IVo+cbPwn4W2PcVBhfB5FBfTRVKoLncfQGd5k=
X-Received: by 2002:a05:6e02:220d:b0:3a7:8720:9e9e with SMTP id
 e9e14a558f8ab-3c2d1aa2824mr381603545ab.2.1735896237677; Fri, 03 Jan 2025
 01:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-8-dwmw2@infradead.org>
In-Reply-To: <20241216233704.3208607-8-dwmw2@infradead.org>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 3 Jan 2025 17:24:00 +0800
Message-ID: <CALu+AoS-yTDSOyGcMJ8cG=UujB_N4-neQztxGGv7os6yPqcZrQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] kexec_core: Add and update comments regarding the
 KEXEC_JUMP flow
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
	Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>, David Kaplan <david.kaplan@amd.com>, 
	Tao Liu <ltao@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Rong Xu <xur@google.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Simon Horman <horms@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de, 
	nathan@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w1eaa8V2uPjo2D5KXk8t4VaDoE5JpwxKTXrRysAxnlU_1735896238
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_012526_008951_F020AAEE 
X-CRM114-Status: GOOD (  14.96  )
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

> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index c0caa14880c3..7cf8437e0f38 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1001,6 +1001,12 @@ int kernel_kexec(void)
>
>  #ifdef CONFIG_KEXEC_JUMP
>         if (kexec_image->preserve_context) {
> +               /*
> +                * This flow is analogous to hibernation flows that occur before
> +                * creating an image and before jumping from the restore kernel
> +                * to the image one, so it uses the same device device callbacks

nitpick: s/device device/device

> +                * as those two flows.
> +                */
>                 pm_prepare_console();
>                 error = freeze_processes();
>                 if (error) {


