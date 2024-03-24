Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9A3C54E58
	for <kexec@archiver.kernel.org>; Sun, 24 Mar 2024 04:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JSkudFGTTpbY0PeoFLV6VuWnqn2L0m1RmYb7bDExOzo=; b=JCucGJg2pS+ovh
	UJyZZbcD4Bd8CcLuchYfJT0SkUEMod4o8+UOjUK6gkyo47tTLz+B4EzXA3Rj1Fbb+5dsYV4EGieeZ
	J7hxmrb9ZjVs/IyVHb/L17+32OZK/hcH0CzSB8d5Yx29VEYbjFgXmfA5Xzb+sv0m+ZgshnxyX4Vtj
	wwuGOBrbUAPimwNQcaslmOeXjCzutf4WNplYVcRCx3c8DCiMJGtElO38lnC8XB4JpT6TXLlIL+Kpp
	NKtEJvmS3ftIoyV9OGorkm5WjsN6mtAjx4Tv/jg8C0I0mCF1mvWRH9MZ+2Vai2qjrOsndPpP+ZDOF
	FEAZiShmr0R92qZYlpMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roF8U-0000000Bnxv-0srT;
	Sun, 24 Mar 2024 04:07:06 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roF8Q-0000000Bnwx-3bDE
	for kexec@lists.infradead.org;
	Sun, 24 Mar 2024 04:07:04 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-33edbc5932bso2165526f8f.3
        for <kexec@lists.infradead.org>; Sat, 23 Mar 2024 21:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711253221; x=1711858021; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoEoEfVFuz6mK2rsSHpUkc2k4VLzktd6pNRYNSI33vg=;
        b=cpUVZWtO1rPO/68ikyoiir4MtNN8cObqsBEi7bUclPrcH6+2q1AVmwXM/IAxS9Z/jd
         zT3JVYbcVeajmaztEm0utEtANuO1n+3kFJX0VWfMDd2rgLSzIZIiogk8xtnBzcBCeBUB
         pYBwLZhQSKGtAdtmYdSKYxLewZbhl9KENqBQYYR3k8d4VnjhbH5+hPOEJwyJppYX5o8I
         oZgtWdYqx9tXqJ10zxfAkMXGDHlO4SPQGReOCb1XscBCXe+Ul3Xdykrp9OxLMe0iCEkR
         0rZpoGDIIV5A11Tt1qiTzK8JYZqi82EOGvtBkADi7d7tbZqvY+t8VfYbd+MFQQM2PiRh
         Ng9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711253221; x=1711858021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoEoEfVFuz6mK2rsSHpUkc2k4VLzktd6pNRYNSI33vg=;
        b=o8I4KPTQI9R8j+ee+lTym3OviwHJmmgOTa0508r/1OFjj5JSt+vI2Exsqsia1DDZS9
         8ZblXaFRTRcucLR8Y4rxVIkRTD8v+324UPdf8E7gGk3phLYSaoyDJbtcpExkMZW0j3Aj
         1Z8CY/nHmgFcGpUiAgm9Ww0+zX5NnjkPzJLwqA+phruQr7fcyxDdfyvBQHM8eywoFdfn
         nXi8HEICU0zGTRKUkXOOQdJdPsOiJbgpQoaHUS5rp0qcPL1bABaaWEwel5mTXR22uC5Z
         db4dLSpUPbzb7zUNXYedGQYB1SnufftxY/wOQvNb2rcDfSIl5Md9Pq+TO89XkD//SwlN
         fIOQ==
X-Gm-Message-State: AOJu0YxloNoo2CJgtcTOwPjxr6tp+uXBtbNlJqEVNe63odl4IHNz5ne4
	rHNwaD2lQrAzpqvgjsEn2TyAfY3hh8LK2eVVyDPWDVpCSaGPc2hR
X-Google-Smtp-Source: AGHT+IEveqr8Ikeunb9ZMOPuR2Y8bK0WNDTQp9eMtP2gcjqHfA+X7uAYuBF26KK1Brd/v1Sz6y6mXA==
X-Received: by 2002:a5d:6382:0:b0:33e:7aff:a3a0 with SMTP id p2-20020a5d6382000000b0033e7affa3a0mr2140376wru.71.1711253220432;
        Sat, 23 Mar 2024 21:07:00 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d5042000000b00341c162a6d4sm2770501wrt.107.2024.03.23.21.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 21:06:59 -0700 (PDT)
Date: Sun, 24 Mar 2024 05:06:57 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, chenhuacai@loongson.cn,
	dyoung@redhat.com, jbohac@suse.cz, lihuafei1@huawei.com,
	chenhaixiang3@huawei.com
Subject: Re: [PATCH] crash: use macro to add crashk_res into iomem early for
 specific arch
Message-ID: <Zf+m4YtKtmdrjw4Q@gmail.com>
References: <20240324033513.1027427-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240324033513.1027427-1-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240323_210703_022350_E8DCA4A4 
X-CRM114-Status: GOOD (  20.87  )
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


* Baoquan He <bhe@redhat.com> wrote:

> There are regression reports[1][2] that crashkernel region on x86_64 can't
> be added into iomem tree sometime. This causes the later failure of kdump
> loading.
> 
> This happened after commit 4a693ce65b18 ("kdump: defer the insertion of
> crashkernel resources") was merged.
> 
> Even though, these reported issues are proved to be related to other
> component, they are just exposed after above commmit applied, I still
> would like to keep crashk_res and crashk_low_res being added into iomem
> early as before because the early adding has been always there on x86_64
> and working very well. For safety of kdump, Let's change it back.
> 
> Here, add a macro HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY to limit that
> only ARCH defining the macro can have the early adding
> crashk_res/_low_res into iomem. Then define
> HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY on x86 to enable it.
> 
> Note: In reserve_crashkernel_low(), there's a remnant of crashk_low_res
> hanlding which was mistakenly added back in commit 85fcde402db1 ("kexec:
> split crashkernel reservation code out from crash_core.c").
> 
> [1]
> [PATCH V2] x86/kexec: do not update E820 kexec table for setup_data
> https://lore.kernel.org/all/Zfv8iCL6CT2JqLIC@darkstar.users.ipa.redhat.com/T/#u
> 
> [2]
> Question about Address Range Validation in Crash Kernel Allocation
> https://lore.kernel.org/all/4eeac1f733584855965a2ea62fa4da58@huawei.com/T/#u
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/include/asm/crash_reserve.h | 2 ++
>  kernel/crash_reserve.c               | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
> index 152239f95541..4681a543eba3 100644
> --- a/arch/x86/include/asm/crash_reserve.h
> +++ b/arch/x86/include/asm/crash_reserve.h
> @@ -39,4 +39,6 @@ static inline unsigned long crash_low_size_default(void)
>  #endif
>  }
>  
> +# define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
> +

Any reason for that stray space?

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
