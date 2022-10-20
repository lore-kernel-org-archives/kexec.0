Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6437CC4332F
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 01:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=95E1jyouJeSMZI28BZl1ShGQAjHc5WeZFSUDn9+7HGk=; b=dav+VdSJJB0/By
	Bo8lu0tKYRoaHhn3WjfgAh9EoBPOE7mlWqEjllUhK1npm2k3uXhJRC4mPJc+bK56EPMTcK+sajG+c
	3R6KRLvIVEmtcwfyvOXl1+uSHV/Vc48DEZeib358CHWZPM42qN9HBqViyMs5JNcGfp8AuRCCbJslI
	6co1XdvYSVOUI5IL6w/vzFMD+e9b0undzrgBTxGQXR2BiEbeWeT6G3xGsEz/BGK5ylkoFyMqJIYio
	jOXbMEVf8EVhYnucnRSAb+2K1K0oHuvoOqiECEtiByV0saOaHZ2WnNst5c9kdLUw5K417nBG9PGOA
	gRkG+kIZ/OLcR6knF93A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olKnd-009HXd-5m; Thu, 20 Oct 2022 01:56:45 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olKna-009HHe-FT; Thu, 20 Oct 2022 01:56:43 +0000
Received: by mail-pg1-x531.google.com with SMTP id 128so17921727pga.1;
        Wed, 19 Oct 2022 18:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mjHLcYUUjhD+PtF02a4WQB8SZ/341O9Yc/tHe2HDPA4=;
        b=F5RH8irn44aJjAZHV3wVq491Nl7s92REmThxweLm4GWBtRUzg4v9r+EoEy9pAru0P7
         K7VvXdWGEDeLvfxiTzkCintYU7h5P2mai4DDSLjIp+T5AyHBHOWjosP24juf1HF8Rk4t
         UM+yTHQzwYjyftCF06T5ggtczDcXdp2FVWjqzKj5GJIgrh7LhA5JavNXMEn0pftwFoRb
         OHvkJZ6Mbjp00tf9ITgPgMLYkLes3k6viq/jMOnPC4HVAEMwkJ/ccdwLMkvFKwEBfj6S
         e8SEizAh+V6sGyQAeUOtduJNkqy+QqQfJcUV8AU0DuFpS+N5TO5v+qRRJ3hdVZx5vi37
         4smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjHLcYUUjhD+PtF02a4WQB8SZ/341O9Yc/tHe2HDPA4=;
        b=qPSaMyHlBcYskNAHIcLXQ5aXBZf0reW4XU0jjzDklGquaOrgrEKk7/F+BuJ0ty58WU
         JUjsaWtRLpq8Q8sh6s0TYRNiBlzB+eiDvIuvjfeLxoO9ykSpyESTbG7/ybrv7mVuiq8a
         oX1Mxc3JVCdQw9hThJfhU62aWxS2MMFnEZhgW/V3mGJU24mvt4zVT2w6TKctChoN2wKg
         R8StEk+yuoXAErhRQV+AHgehEH5BAdN1d+B8OEZBhVmzs8T3gLP2M7K7ehDjKkmXGxX+
         PsJlJ/JdwA9DUCvid8QeBw93prbG5om09M/2MSCMzdmxFI5JGMJ15OQqHRuOERQ5QFQf
         QrjA==
X-Gm-Message-State: ACrzQf3FokSFjW5KsqZxWWZHTUYzwh78N+0pjTxsnzfqXlDJyRkV0AU2
	IA9BIJdHx1+ph0mkFfo3RLM=
X-Google-Smtp-Source: AMsMyM4B1uBb8ajk8x/Mn2+V3BSzPBcPMUsMeSaNFcXAAvNysaiNa7XcKIpUbv3aBeb3PaFJ96acJA==
X-Received: by 2002:a05:6a00:805:b0:563:6e88:896 with SMTP id m5-20020a056a00080500b005636e880896mr11466728pfk.57.1666231000780;
        Wed, 19 Oct 2022 18:56:40 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-16.three.co.id. [180.214.232.16])
        by smtp.gmail.com with ESMTPSA id y16-20020a63e250000000b0046aff3ce339sm10455823pgj.23.2022.10.19.18.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 18:56:40 -0700 (PDT)
Message-ID: <26810115-1325-faf2-0f6e-0d7ff164982d@gmail.com>
Date: Thu, 20 Oct 2022 08:56:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH V4 2/2] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
Content-Language: en-US
To: Xianting Tian <xianting.tian@linux.alibaba.com>,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 anup@brainfault.org, heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
 alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
 k-hagio-ab@nec.com, lijiang@redhat.com
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
 hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20221019103623.7008-1-xianting.tian@linux.alibaba.com>
 <20221019103623.7008-3-xianting.tian@linux.alibaba.com>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221019103623.7008-3-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_185642_587830_6F87F1C2 
X-CRM114-Status: UNSURE (   7.37  )
X-CRM114-Notice: Please train this message.
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

On 10/19/22 17:36, Xianting Tian wrote:
> The following interrelated definitions and ranges are needed by the kdump
> crash tool, which are exported by "arch/riscv/kernel/crash_core.c":
>     VA_BITS,
>     PAGE_OFFSET,
>     phys_ram_base,
>     KERNEL_LINK_ADDR,
>     MODULES_VADDR ~ MODULES_END,
>     VMALLOC_START ~ VMALLOC_END,
>     VMEMMAP_START ~ VMEMMAP_END,
> 
> Document these RISCV64 exports above.
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>

Hi Xianting,

Seems like you forgot to keep carrying my Reviewed-by from v3 [1].
Anyway, here it goes...

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks.

[1]: https://lore.kernel.org/linux-doc/20221018081755.6214-3-xianting.tian@linux.alibaba.com/

-- 
An old man doll... just what I always wanted! - Clara


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
