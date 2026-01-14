Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F92D31A06
	for <kexec@archiver.kernel.org>; Wed, 14 Jan 2026 02:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r6VtkOf5dPkBnW5vdgjj+TjeM5tElsvDFyqS2is6PaA=; b=NsrgOjZ9YeQOLuy7cxiVIXip5q
	uJD6PznNBOoyMuxWbxHTvnzX2izQ+9osiZrnoSl4aX/ou42ycNt19PDGrmxgTetEy+OsWHzlTuFZy
	ovcYn2WbNsGAJOA7Vqfu5WO1PDfTlZYynAMQvt/XYtI5En+2XwCgy7xW7GGrXazcZKW2/bQAeBAl/
	8ZaanVHW7Mt353tr0FSLSDgBBCAFEs514TJGpcHzlN3+jSNLes+6qAmF+gXLZ50p1oAHUvBDnT/KQ
	+4emOG/x3PzdfiJUfw5qzKZm4ednIfcAakA0KOMuMCewQLtfkluaPg8IBhLVHppuRNlyEnxx0LuOd
	SODcc9rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfqoh-0000000800i-2EHG;
	Wed, 14 Jan 2026 02:41:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfqoe-0000000800O-27uL
	for kexec@lists.infradead.org;
	Wed, 14 Jan 2026 02:41:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768358459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6VtkOf5dPkBnW5vdgjj+TjeM5tElsvDFyqS2is6PaA=;
	b=KfLgIj26bUT25VNyTKdIYti8LPl40NO0MRWob99Zuu+4S3Z6DXs/T3gxMTluli3dXquZQT
	VMQBQ5BwlZc2Oua2Ez7b6SYCMArwPjZtsT89hTH9tkRshhaRfgU7S3//9cP5lW9YO4MY0o
	k18KF5/9I0ycWx6tE64xwqRJ47Q1GQ0=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-1kzhIM1JPJWDAVFuKIjHHQ-1; Tue, 13 Jan 2026 21:40:55 -0500
X-MC-Unique: 1kzhIM1JPJWDAVFuKIjHHQ-1
X-Mimecast-MFC-AGG-ID: 1kzhIM1JPJWDAVFuKIjHHQ_1768358455
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81c68fef4d4so11266294b3a.2
        for <kexec@lists.infradead.org>; Tue, 13 Jan 2026 18:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768358454; x=1768963254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6VtkOf5dPkBnW5vdgjj+TjeM5tElsvDFyqS2is6PaA=;
        b=WC0kQXq/s626Vyww9fojmVXZJswLooaj+fXci7vv1GbypjC9G0O495UeNL38/O0+Wv
         bKukIoOLIK4l/G4XS/Uq186I+fHDiCmKH73bPl9ZCsv587YA6njUtK/r3bwm+NPenLW9
         wR7mPAFldFYpVNTXri66P+sHeKf9gUsBmJswbtT/DHb25v5N45As57MBY0nNKui5E594
         ZgxG4vNF2KJ3chMuR+9cMy1sgILI1s7O1ds0dSK3dWom/+iaFMfD7DMXBXEjDNKjvDbn
         8pP0qQ2otY4bh4s8iDFdRlU3HzdR9ytYim+L/S+z8BmDCk0jj6RH3vCUwQCQ6aEzdA30
         h9LA==
X-Gm-Message-State: AOJu0YwUJnqLsKSZVxZXVU0CVU/n8uccZQZi08gt+BIvM+/hO2xbeoNf
	Ifm9Bhg6+19n88zAMtVOPBVnN8g93sHkN9S3FJtbNK170mymDfG8rttmA8MKki4FX55yEaiIpVh
	BI4mVh3lmQF2le1BFe8AIzw79QpL2iwqtx95JJr6GC/GzI136jc/Da9ovRiPka6tdSlcQWF/O
X-Gm-Gg: AY/fxX7sEaQZE2MB2AWXLTzdSk6fTr27VNWGjhZ+yLbuId1TjdHKF1vZdiF3ggWlvDS
	yNYeX27EADaZa3oq/jOgMZA4Q/Mb5aKGCuncamUdGdaVjVAhn5g5vzm24h9bofxk4DU+nkL/iyH
	x7bXJO0pcW2bmbc9jWu/lG4duMmhfovGzTXJIqyrw5pzGG6hevCh5hdRGa33PpQdm6dCVhangW/
	Z4oDY3HxkA/UMwugGJrue46cpkxYQio/ixXiPT0WWAzuReRxZuC3RfxF2nyNJeCvaw8ixKM/ivg
	diGlLOKbs0+aquFzdwyEkVY6yHUACUEPMxg9ZN4xXsZd3/aEnbFIZEc/4tcbgQ632QiFfCHagRO
	m
X-Received: by 2002:a05:6a00:4386:b0:81f:3e3e:c1fd with SMTP id d2e1a72fcca58-81f81cdee95mr966142b3a.5.1768358454354;
        Tue, 13 Jan 2026 18:40:54 -0800 (PST)
X-Received: by 2002:a05:6a00:4386:b0:81f:3e3e:c1fd with SMTP id d2e1a72fcca58-81f81cdee95mr966119b3a.5.1768358453860;
        Tue, 13 Jan 2026 18:40:53 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81ce881512asm6066366b3a.19.2026.01.13.18.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 18:40:53 -0800 (PST)
Date: Wed, 14 Jan 2026 10:36:52 +0800
From: Coiby Xu <coxu@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: kexec@lists.infradead.org, x86@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/crash: Use set_memory_p instead of
 __set_memory_prot
Message-ID: <aWcAZbbRQtMn2H2U@Rk>
References: <20260106095100.656292-1-coxu@redhat.com>
 <20260109201142.GFaWFg_kR8eW48CpUp@fat_crate.local>
 <aWYWm4gLwFmvM730@Rk>
 <20260113142733.GKaWZWVR_0Q_awGa80@fat_crate.local>
MIME-Version: 1.0
In-Reply-To: <20260113142733.GKaWZWVR_0Q_awGa80@fat_crate.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DdGBK-32u_44SLYTROZ0Jt1KWCKz61bJp_AqRM78YFM_1768358455
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_184100_641110_07D57D3D 
X-CRM114-Status: GOOD (  15.40  )
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

On Tue, Jan 13, 2026 at 03:27:33PM +0100, Borislav Petkov wrote:
>On Tue, Jan 13, 2026 at 06:14:38PM +0800, Coiby Xu wrote:
>> I thought smaller patches are easier to review. But seems it's unnecessary
>> for this case.
>
>Right, especially if the two patches do one logical thing - removing
>__set_memory_prot(). Then one patch is better.

I see, thanks for the explanation!

>
>> Thanks for squashing the two commits and also updating the commit
>> message! I notice you also added a Link tag. Does it mean there is no
>> need for me to re-send your new patch as v2?
>
>Yap, I can queue it, no need.

Great, thanks for taking care of the patch!

>
>Thx.
>
>-- 
>Regards/Gruss,
>    Boris.
>
>https://people.kernel.org/tglx/notes-about-netiquette
>

-- 
Best regards,
Coiby


