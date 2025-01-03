Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993D9E77188
	for <kexec@archiver.kernel.org>; Fri,  3 Jan 2025 02:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kn5DzVb9ehPugThgKr2jT8Qb/tPcCCuA2DPn5pnofI4=; b=3r7LjXTOP6puG3G+gNMcqATC9B
	X6I/9GdE2Sr6AviDTSBiAgduT7eesifpnAq/fP/LionloKrpIbto5N7P0hb2RPuJ0yVQePfMvZBMu
	GNtF2naUqs1VDkD6pBs9hBShTJ36/GwmfSu2MHvACggakaKzXiVEI8bHFdZCkoivNKaWOdMv9hKhh
	n8A5/wjlbnL8XVZPjeaAXyv07BIf2f6x64mr9kQ6BTHQi1oivqWs3JqWvOqULFzg2DqUEShy21l/D
	o+Yl0Lz70mLv1OiNjrPBxoaqBj5tRX29QmoxTKU2hD3r9NUI0BNE/tMHi+DSj+YmHzFnbMNH1UrI+
	7at10tlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTXNO-0000000BvGo-0SDO;
	Fri, 03 Jan 2025 02:25:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTXNI-0000000BvFo-1T0p
	for kexec@lists.infradead.org;
	Fri, 03 Jan 2025 02:25:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735871117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kn5DzVb9ehPugThgKr2jT8Qb/tPcCCuA2DPn5pnofI4=;
	b=D5wOMYX31d9P9BzyGw1rvXmnptY6HLoZbwx4d9ZL+DqLNMZ90BA128S3wkUNM8ADOG1knu
	Nx8hcM813jnSgD25zfoXxJZNBCuTjpgoLWnUsoov70vpdZl9M3Nk3Ym4dM0/kJ+L+MnmOw
	4lp9uunFw8y4EjBXennw/ixapPbfFGE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-xTK-nODnN6GA2J-v-y0rWQ-1; Thu, 02 Jan 2025 21:25:16 -0500
X-MC-Unique: xTK-nODnN6GA2J-v-y0rWQ-1
X-Mimecast-MFC-AGG-ID: xTK-nODnN6GA2J-v-y0rWQ
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2166855029eso153072835ad.0
        for <kexec@lists.infradead.org>; Thu, 02 Jan 2025 18:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735871116; x=1736475916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kn5DzVb9ehPugThgKr2jT8Qb/tPcCCuA2DPn5pnofI4=;
        b=ZZLPE/sI+sleX35whjPyVR4r+UCbrFkHgnE0YxT4ruFAmCieldNFIUrZbXh+4abXcZ
         2An27ltTxIdBu13QdArfED+WfurVEuFypacLxz46XX2UOwiR0Oe0jw26ZOZaJXAxXYGf
         01ZIGXVeOyg5U3/2998ML/fGi/BolFqhBwTVQFBoFaQWgWXRL/39/yGaJcvInkIjOtlD
         +xpS1PmHIZtfl4R6nRC8Xaj55ilT0vpuqL1KHdaTCykbU4b9ES4KrAYbCOGg+eWeFCOK
         Ux1tPd/MQUS9qE5EmUL6KTIHzgk5byaT1kEDjTRjyhz+ta0vljQv3pKr2Vc4qtIVZS6J
         e6jg==
X-Gm-Message-State: AOJu0YxZoanj8xMpigqMw07kY0bLfVkTGgyS4uCCySVBt1mlcBoU6J0O
	Fr/Cl3fpPJb0wYsPDjPOX74W+i8s+/0H+mzwSYdTwEmaZwdvAs0O7WsQnDXYQED7ir3sArDCG7e
	GvHmeNWnTR6hWgYU4IlejTYbmgEYxMrDDz3fCns74hcqrq/aFv9tdnYr8Vg==
X-Gm-Gg: ASbGnctlOKIncPSPOk3LK+4tIOUxr+Ka4as+/vbS/a0zV81CIkpAMpe0vjQsx4A3WVr
	N+uov6CE43HlpfR5ac4HhATrBAsRwlo3wccbm5I9epbiF+1JRDafeGbaLFVYTSHIN1yTZaGkBhx
	ThDuLplHaKsFPAXPgvj+3q82WNCL3atd8Dk4i9L84i1LpdWzPVC2Vsw+5Z8bHEsVk+bIZr7oVjn
	cJWN30x2k4HZCZt45V/AZiWhhMpuZoETrUzHqAvrTZRXlEK
X-Received: by 2002:a17:902:f705:b0:216:6fbc:3904 with SMTP id d9443c01a7336-219e6e9d91emr745619675ad.13.1735871115674;
        Thu, 02 Jan 2025 18:25:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECBRnf/eumZRearQ21YGvtpbbGe5BLs4VNsG/D+0iLN/2DNwklyTXiUyF67NbpzkpzGu4xSw==
X-Received: by 2002:a17:902:f705:b0:216:6fbc:3904 with SMTP id d9443c01a7336-219e6e9d91emr745619295ad.13.1735871115369;
        Thu, 02 Jan 2025 18:25:15 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f50dasm233320655ad.182.2025.01.02.18.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 18:25:14 -0800 (PST)
Date: Fri, 3 Jan 2025 10:24:56 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 6/7] x86/crash: pass dm crypt keys to kdump kernel
Message-ID: <vxjp7fbnk4gx2dtkeibzfg7firvucy2jvs6kjjeizp7p3msf5h@pkrpbajeswsm>
References: <20241029055223.210039-1-coxu@redhat.com>
 <20241029055223.210039-7-coxu@redhat.com>
 <Z1mL2KBcRskFlffk@MiWiFi-R3L-srv>
 <pe6aibukdppy2p762d2qakuvxafg3ra4n7geind7w6kohaf4t6@kuzkekrbyhcn>
 <Z2zR9ND4u9j5QMBU@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <Z2zR9ND4u9j5QMBU@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vIEshk1rdf1uPyvPAZpinTNKK936l4ahoGyV6FY2n8A_1735871116
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_182520_463895_FB72C8ED 
X-CRM114-Status: GOOD (  23.58  )
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

On Thu, Dec 26, 2024 at 11:48:04AM +0800, Baoquan He wrote:
>On 12/23/24 at 09:16am, Coiby Xu wrote:
>> On Wed, Dec 11, 2024 at 08:55:52PM +0800, Baoquan He wrote:
>> > On 10/29/24 at 01:52pm, Coiby Xu wrote:
>......
>> > > diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>> > > index 68530fad05f7..9c94428927bd 100644
>> > > --- a/arch/x86/kernel/kexec-bzimage64.c
>> > > +++ b/arch/x86/kernel/kexec-bzimage64.c
>> > > @@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
>> > >  	if (image->type == KEXEC_TYPE_CRASH) {
>> > >  		len = sprintf(cmdline_ptr,
>> > >  			"elfcorehdr=0x%lx ", image->elf_load_addr);
>> > > +
>> > > +		if (image->dm_crypt_keys_addr != 0)
>> > > +			len += sprintf(cmdline_ptr + len,
>> > > +					"dmcryptkeys=0x%lx ", image->dm_crypt_keys_addr);
>> > >  	}
>> > >  	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
>> > >  	cmdline_len += len;
>> > > @@ -441,6 +445,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>> > >  		ret = crash_load_segments(image);
>> > >  		if (ret)
>> > >  			return ERR_PTR(ret);
>> > > +		ret = crash_load_dm_crypt_keys(image);
>> > > +		if (ret)
>> > > +			pr_debug("Either no dm crypt key or error to retrieve the dm crypt key\n");
>> >
>> > If it's error, do we need change ti to pr_debug?
>>
>> Thanks for raising the concern! I think it's OK to let
>> crash_load_dm_crypt_keys fail since disk encryption may not be used for
>> kdump, thus pr_debug is sufficient. Or have I misunderstood your comment?
>
>If crash_load_dm_crypt_keys() returned error, shouldn't we handle them
>separately? If disk encryption is not used, we return a specific value
>to indicate that, surely no need to pr_err(). However, if disk
>encryption is used for kdump but error is caused and failed
>crash_load_dm_crypt_keys(), why don't we error out for the case?
>
>Maybe below change can be made to differentiate them?
>
>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>index f72a88b7d106..327f84ea57c5 100644
>--- a/kernel/crash_dump_dm_crypt.c
>+++ b/kernel/crash_dump_dm_crypt.c
>@@ -400,7 +400,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>
>        if (key_count <= 0) {
>                kexec_dprintk("No dm-crypt keys\n");
>-               return -EINVAL;
>+               return -ENOENT;
>        }

Now I see your point! Thanks for the explanation and suggestion! Yes,
it's better to fail early if crash_load_dm_crypt_keys failed when
encrypted disk is used for kdump . I'll apply the change to next
version.

-- 
Best regards,
Coiby


