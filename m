Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277FCCD37BB
	for <kexec@archiver.kernel.org>; Sat, 16 Sep 2023 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3nmJUSggXojquO39OtDiM3KrFwxOrMDZcavN9sw5oNM=; b=SEp2dQQeb0kVTs
	XV5Fjv/tj41QkfnUoxqP0Gwy7c7PL74cvXNZAdIXQizOToXghk3jc4rdKKM3At7JtBLECXvKFZeS9
	ew+VTQ8z3YT5kMnJ12pWu2DQ9GOE5JopByzuxCna7XqbgrR7VZJMMMPwLMHk90zok4e3QJqp3s+1k
	IL0sMtRaci+NaP15lK31szVPQnbyRdjAo40DDApPWGPWiz4KkJh2DX61IC629dJSyer/I7wUI4J7V
	CK68kSeDkH5Z+SDNzbx3t0LZz1XNLSW0w+BU+88S45ImGlbO/GGQv9NrUBQuBT/8kNnoYyum/SLb9
	Um/Zn3dqI7gqkxjr9FTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qhWLs-00CZjD-0B;
	Sat, 16 Sep 2023 14:32:52 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qhWLp-00CZiu-0H
	for kexec@lists.infradead.org;
	Sat, 16 Sep 2023 14:32:50 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c93d2a24fso2855820f8f.2
        for <kexec@lists.infradead.org>; Sat, 16 Sep 2023 07:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694874766; x=1695479566; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RuCMRYRUI5pE2pACmrLEmespxY+dxj38Ol7yGsVBHSU=;
        b=Uea9TfWZzfJ0ECmYF0A3ClELJrHCt3p0VW8YXhdcui6HskcBaKKFZns+SpjSpVy6Ov
         lHB6L1hmLSkB96wEzwFUh9wbMub3MAMhU1WUcAZlp5LIllF/IxkUKui0At3kVdho+cSB
         HM3+mGOX0Z/Hb5IuomZmhQIh6e9YcER3vjtGx14CSQgMwb7X50yUnO4kzIGVbCvEZTql
         fcEWEcxKRwzySiIjyJPNBjiPLi+rGHTdPeEO3bm/tj7e+qT/6H9Z4Nd/KQBi1Clw3ug2
         6Y1Lckd9cBQCeBeF2S7CQx610S++gvHYK+l9hjLiHPJJ+LMS6orO9K9KIWWPd7qvLFL1
         VzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694874766; x=1695479566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuCMRYRUI5pE2pACmrLEmespxY+dxj38Ol7yGsVBHSU=;
        b=l4+mOcFjfpyLdebkkXkV3Imx/i7M5Bvc3V4nYkFdrb4LMazMdL+6y8s4JhGc3WKWNY
         ucB8jHXhjd18hSjLE+yTy09/L7GrOuHoYumuC2YvS7wk39ALEC73d8UD86IBZlCQWYKG
         L+lxNZH419b62rGnOpeYwZI2qsjAvEV1eLvIdsaAvUco5Th7zA2NQiZX9Q/4N1YxjV9x
         /yQo68FeszfMyl2c5j5VKw5GS4p8+hzubetFuc7sXWebkOxbi4J29OoiGY6dN6KnMChc
         00upxlcVCvXGQWaN++6NnY1VAAtdeepYP7z3y7EivyQ2cwAzVlh8tTV+Z8pJqJEssBoG
         hfTQ==
X-Gm-Message-State: AOJu0YxDAk6mKqhxdP8kv+IoD2jlpVAqFBNARz3QJeRjNNg+aRFmGCt+
	KtfZy9eNX7t+51BoSMotIEIxIg==
X-Google-Smtp-Source: AGHT+IFo2cGGQRjJb8BtVCZ+zzLXMvuJine6w6l4fG9U93EB+rQqIuIbo58+ykYvKJeUmr2pjBhAfA==
X-Received: by 2002:a05:6000:a1a:b0:31f:facb:e1ba with SMTP id co26-20020a0560000a1a00b0031ffacbe1bamr2807958wrb.70.1694874765714;
        Sat, 16 Sep 2023 07:32:45 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d604f000000b0031779a6b451sm7270032wrt.83.2023.09.16.07.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 07:32:45 -0700 (PDT)
Date: Sat, 16 Sep 2023 17:32:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Siddh Raman Pant <code@siddh.me>,
	Nick Alcock <nick.alcock@oracle.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Zack Rusin <zackr@vmware.com>,
	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
	David Airlie <airlied@redhat.com>
Subject: Re: [PATCH v2 1/5] string.h: add array-wrappers for (v)memdup_user()
Message-ID: <b219788a-69e6-44cf-a609-91f9640967f5@moroto.mountain>
References: <cover.1694202430.git.pstanner@redhat.com>
 <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230916_073249_131456_D1FA8B68 
X-CRM114-Status: UNSURE (   9.39  )
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

On Fri, Sep 08, 2023 at 09:59:40PM +0200, Philipp Stanner wrote:
> +static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
> +{
> +	size_t nbytes;
> +
> +	if (unlikely(check_mul_overflow(n, size, &nbytes)))
> +		return ERR_PTR(-EOVERFLOW);

No need for an unlikely() because check_mul_overflow() already has one
inside.  I feel like -ENOMEM is more traditional but I doubt anyone/userspace
cares.

> +
> +	return memdup_user(src, nbytes);
> +}

regards,
dan carpenter

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
