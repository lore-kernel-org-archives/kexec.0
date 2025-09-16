Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737D1CAC592
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 20:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uea5mfPfz6gsP2PTuhVLwd3VedG7XAMEGNBdCWZOsHw=; b=0yAbVnVZDOn02q6CEn/L/nk5Z3
	dCRhV+peF3jDCgfYuf4VdiPeDly0tD9xk6pQsFp/EaRp/lSfwzN+zDAmzi5TBr7N9Fjp2jKXuXUZW
	tqEwBPXRro8w4/6bBC2GgTZdoFIdKMU1HcyCovshBWZwLyNw98nhRQjGT3P0kD0KTybRpGiwNHSMt
	JN5VqfTcp3eLjPCIBQS/Ts0GvQlMS+Xdc70iNDsrf15TCq0zoEi63OA6qHcLzoAxDlCKUVDVJiIww
	WCvN0CPsEWDfxhvYeDB9U9LH7jPSDEH3a2K3kqUUfPS93ooJwd1Cv7c/gWKmnlssz6+tPksLFla9p
	ZgnDvfOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uybyi-00000008xeh-313J;
	Tue, 16 Sep 2025 20:08:40 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyTkc-00000007eh7-2GtM
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 11:21:35 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so6301405a12.1
        for <kexec@lists.infradead.org>; Tue, 16 Sep 2025 04:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758021693; x=1758626493; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uea5mfPfz6gsP2PTuhVLwd3VedG7XAMEGNBdCWZOsHw=;
        b=UA4nu9qOruySP7Me/jc/2uaOrZg/GdBPfGBZUwwsjnY1cdOlpMErAPhYUqLTZCF+I4
         dEL3zvrTHIzPG9cUyupNymjerADZSgAgk0cx+lc+pN/hZwe6mNwOzBrO0tXvUN7Qjw8t
         WtTxCrZ0YFZY39XOrPBWWXvXYqQsg8xUjxx3Dl1o9Ts6cN+8F9GwzoCvH7u1cxi1M2rJ
         3Def04SdEgJ1Kjtx3Jiv/QudMwSI+UMK6HDqlUYoxEHbGUJ9m/0dbOop7Q5f3Oe8pb4G
         QEkKPh09lAi9TkAUskYmyCksfs6jIg5LXJxbY6rNQotHk5ILcoqKrsnQdyyXDpUAIdYN
         iDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758021693; x=1758626493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uea5mfPfz6gsP2PTuhVLwd3VedG7XAMEGNBdCWZOsHw=;
        b=b2Jm4i+fiV/RWXSHja6d6wXIPQ4hwfywM1j6CqZY/9GP5dHZ69MyqqR2AGp6JojguY
         BOqNAq5cvguYNgVjO4MkwgVnPm86JkuiwtPp2eI4WlyRxMJETI6hoH+9KmBiM7rK2Mbp
         nvPdjVGtxuOZKoSQzLhwgSXrHbCBCtLxhsdW+UnkWQPzfdDqQK84vn3pKvFnynsyoMy0
         BPo1YBYabHmVqefvHipfvPFbDDDFqDrjEB0i0vQLCoBvYletP9gB3NU97su42uhsXzyo
         a1EI/hg8frQSxwQ4hhlbQm6JXg5XwjjC/kXHKHuQflK2+0YT5wVJasApQO7bsVh73nNS
         FU4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBGoP6RvpXnk4dvRAc391HbuenN800F9q5BZhGm+ODZ8cUhieC+MlIpE/0tEZREb/fWPqN0w==@lists.infradead.org
X-Gm-Message-State: AOJu0YzO9Qii68OjhJW7/5W0ZSNvffMoa2qH+hdUib5s8iGmWwN5W2kw
	Xiws7tDdFBBQubpGFycAq/9llKPAJGiBNeOptqhDEjJ/KAqpok4W2LQ0wFftCapr5uc=
X-Gm-Gg: ASbGncs2TVLSvZoRiUgJ9cKd7/+L1JE0lNm2vubcanrVX2S5T/y4s3TZKyvY+0sz2MC
	BQqBqNBVxWr4Esu1BIWRACOxiV07p8EbngUamh17g7nyl/PT+WlNO82PGJ3qYe+bgnqU/Kdm30X
	1OFy6jb6VXJk0njKNG/dPlH6j8FFEjRY9tYuc5DV9yDs3s6+ecVZ6Fkt6w1xh8CkocGt/O0m67N
	NJUmiIMLES7zIlf2H5qBLfazv3RCyLxndQnHnThfwqvHqDU8Y5115weBrljts3Rxa0JxUzwzkWk
	i7joXkacIeNNzbDLi109yiXfdnhm7vH0jrUl22c3A8ik/tf8TQ5K9y5h1MGw0q8gjINY5afeTtM
	MQPfXCu3raJddD2LbDWxgxvX/T15svv3ctevFEa7+
X-Google-Smtp-Source: AGHT+IGdaApH84qgSh4FpIAmIv68lRlYszt1DGU1HPMtQq+Jg7ayFfDUxA0h2cZACJ5agdILmluAcw==
X-Received: by 2002:a17:907:6d22:b0:b0c:5929:4cff with SMTP id a640c23a62f3a-b0c59295025mr1006070266b.26.1758021692577;
        Tue, 16 Sep 2025 04:21:32 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f21a2sm1156991066b.83.2025.09.16.04.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:21:32 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:21:30 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Subject: Re: [PATCH v2 6/9] printk/nbcon: use panic_on_this_cpu() helper
Message-ID: <aMlIOt52xnLIvOpK@pathway.suse.cz>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-7-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022947.1596226-7-wangjinchao600@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_042134_593328_4F244B27 
X-CRM114-Status: UNSURE (   9.93  )
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

On Mon 2025-08-25 10:29:34, Jinchao Wang wrote:
> nbcon_context_try_acquire() compared panic_cpu directly with
> smp_processor_id().  This open-coded check is now provided by
> panic_on_this_cpu().
> 
> Switch to panic_on_this_cpu() to simplify the code and improve readability.
> 

> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

It looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

