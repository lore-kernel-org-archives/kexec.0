Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAFAC61DE2
	for <kexec@archiver.kernel.org>; Mon, 31 Aug 2026 09:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BkAxgUkrcHwMwW9an6Un5GRrv/l/IMRdgFW+dNU5WGU=; b=aEaT3+zVIKqvW/k1n19gwLyzDW
	17A7e8GCLT7r99peM2iQkm4ZxWm/Ijvv9DLqtzuHXFQpn8SJp5+0EjRF8cRLxl6eweSmYZkx8yRBN
	qXV/GU7gzqymbY7+bKMUQ5j3qFTduEdQWAYEg+uQtBL4hBYcdh6WNFCutpxe5SFGMngKMtZQMt7VN
	tkxTmrEMoK2H1iQKtO/X4QytQZfpl1RGPkVODx4wTBENHzXb1/ucruoctEA5W17BZX2fqeHky1OE3
	4FPut+TlyOk9eayJGgECG5jxl+BhN1GMDc5ss1jujygg11HrzZJhM+ppxPBtD430vsSQabfRRlbZt
	BgKcafrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0ynn-000000094Zg-15lo;
	Mon, 31 Aug 2026 09:59:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0ynk-000000094Yg-2YDk
	for kexec@lists.infradead.org;
	Mon, 31 Aug 2026 09:59:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788170377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkAxgUkrcHwMwW9an6Un5GRrv/l/IMRdgFW+dNU5WGU=;
	b=C3clvtwfdboUzQsERAYhEkg4LPk2KzTtu1It1S4TvrUDy5gk/3BYFUBTdrMICnaV0AV/rh
	Rw8xt3nEek3NuhYxgk0PEb0bkmfd4bmC20Gv1VF9g7DMUt93buqjUKVos31S6FgtbuxU/G
	Y/+kAdai2rAG0AE/POEzapPmb/sUq+g=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-frkt-YNKNXOw5yrzN1z-sw-1; Mon, 31 Aug 2026 05:59:36 -0400
X-MC-Unique: frkt-YNKNXOw5yrzN1z-sw-1
X-Mimecast-MFC-AGG-ID: frkt-YNKNXOw5yrzN1z-sw_1788170375
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso2780981a12.0
        for <kexec@lists.infradead.org>; Mon, 31 Aug 2026 02:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788170375; x=1788775175;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BkAxgUkrcHwMwW9an6Un5GRrv/l/IMRdgFW+dNU5WGU=;
        b=hkTCZJiLeXYNL0YGN86cSp5DzN7baF0X9eHACXf4pxmbaivJcw7+hdy+lOzfRk9837
         e5Ykqv8pjy1u0oZUSO3XzexZAVqxGcViUkLAwfPatnkxStqjGlFrh0WswhCqUK3vGfko
         XBm+UaM4WmY1+6OLV/KGHJNJ0Z6SA5eGOYTi0bJJDiToFiNa+ud8/gvfiG/oXwAWVnGj
         BgivSl6wOSmqzZEzKVX9N3rIhtsWDkOMQ3YhIW6TEXV/5iCsKEaiqp+v3pFe31Bn4L3H
         bs0DFE0oeBsGeY68amFu3cQA8zg6ZClrE0yLNxeAnwfEU4sLsYwiWQ85GyUAL7qGelLl
         TBpA==
X-Forwarded-Encrypted: i=1; AHgh+Royrva3/2340FNTxDw+YbcL1UZS3S2w8rb6+RnJwNQAW9xHO4FJbP3Z8irD8KKxo6p8ksv6bQ==@lists.infradead.org
X-Gm-Message-State: AFuF++mPsV74uZYYIDxEKuqbni058a09qupfISTc6Gna1ibMjmkR+NB2
	dN/dYPK8k4TvAJ1wM9RgwK7gSJgrQeA1gkDxD8g1L8xx/JACq5ELK9RXZgh6nSiP/IFYAs4/I6i
	M+DiSCL/kvAu2Ek04iBP3LvCW6zhijWHKkfPX1YYDQSVYMXTUTooYRDDcftARVg==
X-Gm-Gg: AR+sD10Ub6eFe0pF3KVH/1I/gbE5AWiIQFgBvyfBV7nlS7f8yHgQ7bqK4aQFNQnbJrU
	dyZQO+xXbio1LiXq7LnZacN4eIa2z9vt7dmZOHDgDHMMLQa9dhkwI2LHcnRmUYca/pKvARbhm6N
	77aWhqckuwWiMUgpCZuDHGn4N24jj00xViE1c7WIOyOQaSr/Gi/R+vn+8G/ZZ5XY/iFiZZNUvvf
	kOJFbnVrSk6gqkx9S9/KXTGKAjLLNrqEI0vqKb2ArGH1mN5K2qkNjFNC4Xs0G0jXoG9BxdE3I5V
	kUJ7SHfKUuK509tFtfLOHZqCZEVYtjKaEB7ZS9QYdC9U34ActAshdV7bf+9H09GXLbaF+gn3Io8
	56GmyHwi0Ms67ZjgjcneJ
X-Received: by 2002:a05:6a20:9f8f:b0:3d0:8cbb:8c2d with SMTP id adf61e73a8af0-3d72f95c925mr3484214637.4.1788170374954;
        Mon, 31 Aug 2026 02:59:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f8f:b0:3d0:8cbb:8c2d with SMTP id adf61e73a8af0-3d72f95c925mr3484155637.4.1788170374513;
        Mon, 31 Aug 2026 02:59:34 -0700 (PDT)
Received: from [10.76.99.122] ([115.110.236.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f36aff95sm3900855a12.20.2026.08.31.02.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 02:59:33 -0700 (PDT)
Message-ID: <ac2029c5-1069-4e8b-9b09-29150f133055@redhat.com>
Date: Mon, 31 Aug 2026 15:29:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kexec-tools] arm-zImage: prepare for more malloc
 requirements of zstd
To: Andreas Kemnade <andreas@kemnade.info>, kexec@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He
 <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, j.neuschaefer@gmx.net
References: <20260829094607.689485-1-andreas@kemnade.info>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20260829094607.689485-1-andreas@kemnade.info>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8023iS6ecTNtZ-JbOaxZXg1yLPXt2TkLP8ciI1q3JEg_1788170375
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_025940_719835_59140881 
X-CRM114-Status: GOOD (  13.39  )
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

Hi Andreas,

On 29/08/26 3:16 pm, Andreas Kemnade wrote:
> As there are plans for zstd in zImage for ARM, which requires more malloc
> size fo, decompression, increase the space.
> 
_size fo_ looks like a truncated _size for_ .

The high-level changes look good to me. Feel free to add:
Acked-by: Mukesh Pilaniya <mpilaniy@redhat.com>

> References:
> https://lore.kernel.org/lkml/ZFDMRst2O+RJUYuu@shell.armlinux.org.uk/#t
> https://lore.kernel.org/lkml/20260828-zstd2-v2-0-4d9ce7150877@kemnade.info/
> 
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  kexec/arch/arm/kexec-zImage-arm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
> index 8b474dd..97db7f3 100644
> --- a/kexec/arch/arm/kexec-zImage-arm.c
> +++ b/kexec/arch/arm/kexec-zImage-arm.c
> @@ -663,9 +663,9 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  
>  	/*
>  	 * The zImage length does not include its stack (4k) or its
> -	 * malloc space (64k).  Include this.
> +	 * malloc space (128k).  Include this.
>  	 */
> -	len += 0x11000;
> +	len += 0x21000;
>  
>  	dbgprintf("zImage requires 0x%08llx bytes\n", (unsigned long long)len);
>  

-- 
Regards,
Mukesh Pilaniya


