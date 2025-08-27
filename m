Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA44DCA0EFF
	for <kexec@archiver.kernel.org>; Wed, 27 Aug 2025 15:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=co19M5oAe+ecTOIHIeJsLscsP51650xD3EtXlcmFl74=; b=FWOgBpCwanNf5CWarQdjjPum+9
	+Bqq+Hek2S3fJshUyZPtE5tgYG/fTXxrjn77PfLQ5/pSdocqw88DnXZunnr+jufpslZtYe7Rt2d6W
	/aeID0HsGyJvgbubGAMGMZNe27T0zGZIaVZUHqNBJOxupdIYgk5BkhLhxM1U+D0HSRgweBmz+JXEL
	XUpAPPf2Ofr+qYAUmChskjDKayRO/39e1PAht9PiC5j3nfA4Ichgy/FN3m5eeRQqp5hbiRPcr++la
	AoDb2fXAD+oiVDCsTLnS/EEIb79qMpgMrQWS5uOs9F0AjRDYjKZqUeyEBt6ZaBgIs9cPxH4HadGx9
	aJJC9Q2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urIUB-0000000G4YK-159f;
	Wed, 27 Aug 2025 15:54:55 +0000
Received: from mail-ed1-f52.google.com ([209.85.208.52])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urGMK-0000000FbMD-1sWd;
	Wed, 27 Aug 2025 13:38:41 +0000
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61c638ab6c9so5009832a12.1;
        Wed, 27 Aug 2025 06:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756301918; x=1756906718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=co19M5oAe+ecTOIHIeJsLscsP51650xD3EtXlcmFl74=;
        b=ME7WUg+Rhqki/Y1SZuckyRBMhowKM5LoFbA404oz1fga5ABo4pYVRgFPrWVJQ6XiSC
         PgP/T2em22lR76FBXSu6GYrkLAZqOglNa46yLu7N+WYD/82Wt4vZ7P75K9iHupHsTiCg
         kObcWxdeDOa2u1BfOdOXU0CS2V1+HZaup8kdkzlvHMexi74+7u2BOBIjEWV4ziKvOseT
         jc5o3mgUh8f0hA6uvWKFldc2P8ylnvjJLmWun9O6Ntp+vQPieoVvilrk4eTLlvKF9h/n
         DOeBOmDtNVmqGOdALv0HXBR04ZGPmpDmBH4PnfLVMZqZXRyNZXsFW1FHkDHHMHXtNaA2
         Iffw==
X-Forwarded-Encrypted: i=1; AJvYcCXMAnMimu5+Q2IJfBq/fys+rswN/Xtz4KATf/da2Tg/J2M5sycL+KcP/5Oojqg4tiJXWlF6Uw==@lists.infradead.org, AJvYcCXMa022BzZL/fwEoFTPqiZAIjup4KUh3M6JQeQXEtWViQNibmhv3yvbFve8YHHHM92FA5ECGlzAzO8dWc9Pli1Wbw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6bXE92/9rqlMZqCGAnvi9RMA9b1l2V5bYzzBBSakC6pKzMW0X
	ouUQ5godGsGS0CzYDyskFxEpGmtVd2PX7jXDU62qaBTMvhQF2bFPrGX9
X-Gm-Gg: ASbGncvTNG4ZiJGL5MdDtlAFqnMgUvZol6BUZaOYOoZLmgD915pfyv1ugoHWGYHTPxc
	fQ6dHDGWi+vAyFpYFsnyq1Y0Xv8R1ehY1H5x7dBAVnYnNXdpPAgT32e8flWC/i9SrWxYTXTQ1mi
	7EGdG1jVjmxN3RlHhA0t2C1FSOyhs9ot/mYUtP8Os726uhR+DW0uyYIpP2jh75ThIqW9fVUVyVo
	elzJK6My/rGhGs3ZEOlOCoUjtjC0Z+X85tGp/CpFlg5Jzzj8AQbTG6SnqzcpORj6JqmStv72eaE
	wjTaLEZzR5cG80AMhBhqIWo/liMN0k6Y+B6WilzQUUrPOIFc0nwPeL2pL4TmC1qf9iUAo6J+zkg
	Q9eMHyNOAt0vd/Q==
X-Google-Smtp-Source: AGHT+IHtmXT0w3FPBkdO/ZHOIor+CkRnHyq8bQw6ohQR+7/AOkbO+b8BfyBX59eSb+JDIjRQ4lG5ZQ==
X-Received: by 2002:a05:6402:34d6:b0:61c:6ca1:1a8c with SMTP id 4fb4d7f45d1cf-61c6ca1237fmr8654931a12.20.1756301918201;
        Wed, 27 Aug 2025 06:38:38 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c45040d6fsm7905276a12.41.2025.08.27.06.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 06:38:37 -0700 (PDT)
Date: Wed, 27 Aug 2025 06:38:35 -0700
From: Breno Leitao <leitao@debian.org>
To: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Coiby Xu <coxu@redhat.com>, 
	kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/8] kexec_file: allow to place kexec_buf randomly
Message-ID: <enzwdtceeqzkb5twhp3lcslzwbfz2xvam2cxo76gnsljlh6cx3@2nzp7lm2hoo4>
References: <20250502011246.99238-1-coxu@redhat.com>
 <20250502011246.99238-2-coxu@redhat.com>
 <oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3>
 <yng55a2z25m5upehczerzhi6zawe3j4ka7amfu4vw4cu27bbg2@x2lgbuk3iqyf>
 <20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org>
 <aK7uNf8n67HQW+hh@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK7uNf8n67HQW+hh@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_063840_486385_69795B50 
X-CRM114-Status: GOOD (  18.42  )
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

On Wed, Aug 27, 2025 at 07:38:29PM +0800, Baoquan He wrote:
> On 08/25/25 at 06:05pm, Andrew Morton wrote:
> > On Mon, 25 Aug 2025 09:18:53 +0800 Coiby Xu <coxu@redhat.com> wrote:
> > 
> > > >diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> > > >index 532d72ea42ee8..287b25e674d76 100644
> > > >--- a/arch/arm64/kernel/kexec_image.c
> > > >+++ b/arch/arm64/kernel/kexec_image.c
> > > >@@ -76,6 +76,7 @@ static void *image_load(struct kimage *image,
> > > > 	kbuf.buf_min = 0;
> > > > 	kbuf.buf_max = ULONG_MAX;
> > > > 	kbuf.top_down = false;
> > > >+	kbuf.random = 0;
> > > >
> > > > 	kbuf.buffer = kernel;
> > > > 	kbuf.bufsz = kernel_len;
> > > >
> > > 
> > > And also thanks for posing a fix! The patch LGTM. Can you add a Fixes
> > > tag 'Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf
> > > randomly")' and then send it to kexec@lists.infradead.org? Thanks!
> > 
> > I turned all this into a regular patch and queued it (see below),
> > thanks.  No additional actions are needed.
> > 
> > I'm really not liking that code.  I laboriously verified that all
> > fields of kexec_buf are now initialized, except for `cma'.  Is that a
> > bug?
> > 
> > This function has a call frequency of about 3x per week.  Can we please
> > just memset the whole thing so people don't have to worry about this
> > any more?
> 
> Yeah, adding these trivial patches to mute XXSAN warning is annoying.

The patchset is quite simple, tho:

https://lore.kernel.org/all/20250827-kbuf_all-v1-0-1df9882bb01a@debian.org/

