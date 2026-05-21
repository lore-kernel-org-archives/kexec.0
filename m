Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A863CCD5BAB
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 23:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DnVBY/gIrvG9PTA5e+cvuIrP5NR07Enj/HmhXB9HoTY=; b=4RjpZSDpnRkTDsJIP6h/2AO+xc
	QIkCSmGia1nCTMUgJnWW+FwYlEnrkOmUX26Fo16S+h7pJHqO9Xo2rvKUkDrwnsTpzF90QIGeUBcUC
	e0/aF24uj+6mSvxdH0A20EG5fsr6h23MdTG6JnDdfQB4788GFT7bjCROhBnrfGuTujGHTC2cevroT
	wqD6Zp3j4I40yollT3wlG0jYupexu6waELEtESQtYuuwCz1CglbiRkYR68S7cnz2pT0DKGogVixPI
	BoS/OzCPQU0ZHI79m14GFwzw7wqZKVlV8IjGvg9JBiBleAYz7VhSXnUpGPon0NDGaAME8YkIL4jAd
	9PEfPdAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQCrC-00000009KHs-2saK;
	Thu, 21 May 2026 23:31:14 +0000
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQCrA-00000009KHD-23zb
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 23:31:13 +0000
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-911488599e3so761174485a.3
        for <kexec@lists.infradead.org>; Thu, 21 May 2026 16:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779406271; x=1780011071; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DnVBY/gIrvG9PTA5e+cvuIrP5NR07Enj/HmhXB9HoTY=;
        b=dcVI9WvCL6ZgmU8+6u9P1VXCnKJay/vGI5Z0/bUBOzQVVa1ezkPVm7FI4vwb4Td4ab
         ho5q6Nyl+PCPcGv4stArKZbX1ScXb/iZ11PXx1tRi5Hpc3NmFYVMMmLRORpX0kUxkHXY
         NO7MERep3lUiACk82fRPA3vYHOHRvNkPcEtkJVvXQZtVyzazakKw211IxlcC2YsRem2t
         F+LbK9H1DQGcrE4rTjl1xn5vrlvJjBH0XRhfb9xUrfd/GVCBpQ0dicae4KGjtOlKGr22
         YGb4DiTqzZVFSC33BZq7QwStw58FWzQj7bjZQV1RKtz8Q2ca0jk6NFUyQblyjT4iWIyK
         Dq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779406271; x=1780011071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnVBY/gIrvG9PTA5e+cvuIrP5NR07Enj/HmhXB9HoTY=;
        b=L2ATYoSbf/a6pdSxyrciv2crG2ZeKLn8I7/TEfLWJR9u7w6hXYWee521l2tz8fMsGl
         ZROBW01mb+kYagXedoMWN0MHXi+ADa4RqQoQlflJeM0DZ0DyszErUGSDe2ikYhGsGGOb
         hBLLzGkBs30L6hCvZE6ueKvBrtXKAY8fumjA/sPau/mjEOxUCJfQ7te8KunWX860VcDT
         C+SCGxGGPmYvM65oF4OEnCyArcFIKg/iOMVxOZweIobJyrbOPp1q5KDoMb+L8IVpUDoV
         WbbB1IYwFJtHYCpw4LtiaRY6mVl3ihViLzs9JJu/iczjLNxqr7i4DTRHE8KJDX3QFB24
         Qwqw==
X-Forwarded-Encrypted: i=1; AFNElJ9md6qjsOwX9j/KLP5YWlOqPaHUiCBYdQ55pT65szbWrRMyXJ1xJsunvyIN8PlHyQtqIG+Smg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzQEE1M/2TqPuooEM5xL/ohULTs53nmJD3QpwGPvOecE7KPUuq+
	qAKW5nwPO3JMU60YmPsBvK9HmP5GoH4Tchq44RGquPaCf/ryQCZSrcYt4+eZ/ToPldE=
X-Gm-Gg: Acq92OHahDEvglt1jBFCacyofdQs1R++hANmIw8GdaCmqYH5jGXt5KWK606rB2W3U8z
	uXvgMH1YvztgJM/OZPDTmCj5pdQYtekmm4LubNwHVWqKggd+l8d4aR8mulX/WzeRmV01DZ0QtmJ
	sBUYK4n8OPKpnZIATOI/dl87XfyoTQ5VV7/i03huYoEyGpAkSHX2HinP5bm4c16z5ec7RxZaE+m
	yswDWIO+upO5nHjYaxgmjbF5T17SSfZcUVs0G2nuZ8+3mz13hEJ5lyg/W1WPKwct2in7dAO8+s2
	SManJ5uIsEK9KFHBjKDrI9CIZ+nwuHEHScWM3fn1iMMYoVS4oCA9Scoak64d5LSDABjQMcCA433
	Nv5tWVMlb4jnKFvTJ7GRSdeWleeII7DQXBz3lpYFH31FNIVmMX+sBkR/z4HatAWBKDho9Mfc3Mq
	PZEUcqsI6aXs+I2jZ/I7PJOJpkAnsNm6E2X/n/tWDSMmEgX1+Q7RIMvnvZvfTxhA==
X-Received: by 2002:a05:620a:8393:b0:8cf:c0c9:bca with SMTP id af79cd13be357-914b492cebemr215182885a.17.1779406270986;
        Thu, 21 May 2026 16:31:10 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914b604e040sm34931385a.45.2026.05.21.16.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 16:31:10 -0700 (PDT)
Date: Thu, 21 May 2026 23:31:09 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] kho: add a struct for radix callbacks
Message-ID: <ag-VfUr_XuxDuHS8@plex>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-4-pratyush@kernel.org>
 <agHB7HB-p_vkLS7R@kernel.org>
 <2vxzzf25c39x.fsf@kernel.org>
 <agLNUKE5LZqcoUex@kernel.org>
 <2vxz5x4tat6w.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz5x4tat6w.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_163112_541989_D2940E76 
X-CRM114-Status: GOOD (  19.62  )
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

On 05-12 11:11, Pratyush Yadav wrote:
> On Tue, May 12 2026, Mike Rapoport wrote:
> 
> > On Mon, May 11, 2026 at 06:35:54PM +0200, Pratyush Yadav wrote:
> >> On Mon, May 11 2026, Mike Rapoport wrote:
> >> 
> >> > On Wed, Apr 29, 2026 at 03:39:05PM +0200, Pratyush Yadav wrote:
> >> >> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> >> >> 
> >> >> A future commit will add more callbacks for the KHO radix tree. Add a
> >> >> struct for collecting the callbacks.
> >> >> 
> >> >> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> >> >> ---
> >> [...]
> >> >> --- a/kernel/liveupdate/kexec_handover.c
> >> >> +++ b/kernel/liveupdate/kexec_handover.c
> >> >> @@ -266,16 +266,18 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
> >> >>  }
> >> >>  EXPORT_SYMBOL_GPL(kho_radix_del_key);
> >> >>  
> >> >> -static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf,
> >> >> -			       unsigned long key,
> >> >> -			       kho_radix_tree_walk_callback_t cb)
> >> >> +static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
> >> >> +			       const struct kho_radix_walk_cb *cb)
> >> >>  {
> >> >>  	unsigned long *bitmap = (unsigned long *)leaf;
> >> >>  	unsigned int i;
> >> >>  	int err;
> >> >>  
> >> >> +	if (!cb->key)
> >> >> +		return 0;
> >> >> +
> >> >>  	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
> >> >> -		err = cb(key | i);
> >> >> +		err = cb->key(key | i);
> >> >
> >> > key(key) reads weird :)
> >> > Can't say I have a good name, maybe key_action()?
> >> 
> >> I thought the context of it being under a callback struct would make it
> >> more obvious. I don't like key_action() much better TBH, but I don't
> >> have a strong opinion. Perhaps Pasha can suggest a 3rd option and we
> >> pick on randomly ;-)
> >
> > Another option I thought is to call them ->leaf() and ->node().
> 
> This one sounds nice. Will use it in v2.

Thank you. I also prefer ->leaf() and ->node(); they are simple and 
applicable to any tree.

> 
> -- 
> Regards,
> Pratyush Yadav

