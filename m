Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F6ACAC592
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 20:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gxtZUSssqP8QQ4xDjcwfBCGzgO78XtwgCRIXLf8n188=; b=E4W7CcDHUIYCqg0li75Q8Nt4PM
	3SuQKjqRKoH3jgtQlDL/x0tNLgZ/F3DXjjrfDsLha/GMTH2MTmmAwbq2yhVXPSkAywyBjpF7BrpRK
	SUZ/TGxSrRseTQTIb/0NRhKCKEonwkhJh4Fn3OOPeHYasqUQUqT1hVn3gS2NfnNFbjM4Mn/sbLCQu
	cXSqexqcgjgTNQLv3HolYWqtmeIiTl4zfcI8LQZFaW1lUQDpKMhRF8XKeid+WNUzMpV+4vEjxBJ/n
	9/c55QvmCjMuhY0wVPYy3s8mbHWvl3BfVuZu+jX3i9V/9Uf44L2xRNJBHJxV/hCF+jWrcLH9nvrAH
	bYJVKxuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uybyk-00000008xhZ-0jLR;
	Tue, 16 Sep 2025 20:08:42 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyTmX-00000007evs-0wWG
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 11:23:34 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-b0473327e70so274558766b.3
        for <kexec@lists.infradead.org>; Tue, 16 Sep 2025 04:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758021811; x=1758626611; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxtZUSssqP8QQ4xDjcwfBCGzgO78XtwgCRIXLf8n188=;
        b=YtB1iOi0VEqi7mOGxL/d7IwxHJ7yKQ3Ru/a/dHysF0ww8WiB9mSgujf8YrLJ9vuftO
         pxHwRr4gr/Nt9+A9vPMwI81mTxBeramExHuU22ryM1qAD6aCdyXWLW0YeKTwkaIp+3k/
         fz50ZEjTeXsXNUKR8XlqupPiUU7Td3ICyznyyGEH9wMsz3y2S9n5yCbEHMb+MmVT2ML+
         ScaG/4g7kEo/2Di+Yjw0O0RrkjMGpFP2TPsIqf0EKLd+ZDi2ZKKhId5mGMTcxUZWLfl8
         kIeH0iRtTnwGfiHwjZJdghv1DItk+NEbnfQFAxTvZ0t2FKJxMnxM0SQOYwD60wEYQ5GP
         RN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758021811; x=1758626611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxtZUSssqP8QQ4xDjcwfBCGzgO78XtwgCRIXLf8n188=;
        b=Myg5vnaID8FV13tBqatlX4YaULoRgKbEEUlRKxG8PIZcnkRwL0ybmfSm36+FmWvMgZ
         v0LwGR8/FjUcs+vFYLWxdcNlLyOB7JzVR5MTmY/5nbm+6RoMIzxzFitdS4VxuvyD1xqa
         Fl9HFUXMUw2PJzI6zrxVUyrkb0I8lf96NSvgQEF4s1rrbriR8XCVcrSOHQ0aP1i/Gnap
         2jnhaKK9kvnEjZBUScMpXxm5QjoXlk+1VSchVEYogmHeZS3h1SNm89lRt8ESMlpDPtFY
         1A8nXYBflx6+jPoGSpJe78UFygTPpza/lJu9fPMiS90kxjfNslwnuj/LJ6kZPArblFYQ
         5DmA==
X-Forwarded-Encrypted: i=1; AJvYcCW1iPbmuWtZhBCJECtqBRo/6700Nmao8ev4EaZo/v22OTopjK/LbS1sEKcVg7FroBAcgluG+w==@lists.infradead.org
X-Gm-Message-State: AOJu0YxSwhV73XjJsZeh/FbAYBdmMb47hh2EXI3dGsAsnQVMwXS/EwAG
	h2CKXKN+yD+B/kyGOwnXPVsYypuEQR7Uj1+WENqhRJI91H718sC3V3WnbZiloYMxGq8=
X-Gm-Gg: ASbGncttxVxAS9Rh7/0Bp6AWTQdYRxetrtXv6osbgQFxZmKE84fPeOqN2wK+nX2ZZNA
	FP4JwHHlXpWCfJd+WjGiQjUIOAu4hgXkeLrGcLyzIppSO0VXnStOw2bujjJScR2mPlalw8Yk9zP
	Bh5vxpWUgjAO4VRbqo/dJKDMegb4ZWJjpmlUWeNULTzb3pv1PhdoPNCSiHhJ4ZgJxonCNYZX1jf
	17Be9Uy2MoCqfCpAtmN3MlxMCfXytwzSCF9GUJjm+LBamQoM0z2mUAtAy7w63xSCLBP1JP4Y0sF
	yC7IsaeV6d03ZKYSjcFCdO8ul7BbvIi5LPT5XBp1rVdlxM4kBk0uumpSEibSHJ4pFi237J+h6de
	ln2j/+pQxAJ1VhMTweMRM1wGDAmvaSiRl6KgM7TV6
X-Google-Smtp-Source: AGHT+IHpyTR/3eF3SMuNwTyjqfOeFBdU6maF0JBSLHjxTUYrHkZ3Z43YeF6fl1FdRdLJxJTI3BmjLQ==
X-Received: by 2002:a17:907:7e83:b0:ad5:d597:561e with SMTP id a640c23a62f3a-b07c3a7bd75mr1672253566b.56.1758021811303;
        Tue, 16 Sep 2025 04:23:31 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd5a9sm1125541966b.57.2025.09.16.04.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:23:30 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:23:28 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Subject: Re: [PATCH v2 8/9] panic/printk: replace other_cpu_in_panic() with
 panic_on_other_cpu()
Message-ID: <aMlIsOH1dirXjrE1@pathway.suse.cz>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-9-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022947.1596226-9-wangjinchao600@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_042333_277265_3E572865 
X-CRM114-Status: UNSURE (   9.17  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 16 Sep 2025 13:07:58 -0700
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
Cc: Sravan Kumar Gundu <sravankumarlpu@gmail.com>, linux-fbdev@vger.kernel.org, Kees Cook <kees@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, Yicong Yang <yangyicong@hisilicon.com>, Zsolt Kajtar <soci@c64.rulez.org>, linux-hardening@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Simona Vetter <simona@ffwll.ch>, Max Kellermann <max.kellermann@ionos.com>, John Ogness <john.ogness@linutronix.de>, Baoquan He <bhe@redhat.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Helge Deller <deller@gmx.de>, Joel Granados <joel.granados@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Nam Cao <namcao@linutronix.de>, Qianqiang Liu <qianqiang.liu@163.com>, Yury Norov <yury.norov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, dri-devel@lists.freedesktop.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sohil Mehta <sohil.mehta@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Luo Gengkun <luogengkun@huaweicloud.com>, Feng Tang <feng.tang@linux.alibaba.com>, Shixiong Ou <oushixiong@kylinos.cn>, Anna Schumaker <anna.schumaker@oracle.com>, Tony Luck <tony.luck@intel.com>, Joel Fernandes <joelagnelf@nvidia.com>, kexec@lists.infradead.org, Douglas Anderson <dianders@chromium.org>, Li Huafei <lihuafei1@huawei.com>, linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon 2025-08-25 10:29:36, Jinchao Wang wrote:
> The helper other_cpu_in_panic() duplicated logic already provided by
> panic_on_other_cpu().
> 
> Remove other_cpu_in_panic() and update all users to call
> panic_on_other_cpu() instead.
> 
> This removes redundant code and makes panic handling consistent.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Looks good:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

