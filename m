Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48861C5B543
	for <kexec@archiver.kernel.org>; Wed,  4 Jun 2025 04:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PO4T1rnPlmKykDehCYP0m1kIchCQnr8l4c6LLtP6l80=; b=cWU7XIsLfygN4RKhrQbZcNrEVS
	0/HEA4aA/7DujpC8MPACsHd8mUaMBE9n+lpzKCkGfq1D8MXr7pHaztA5n9WZVrqxFTgRayOMphOGY
	a6fABipXUpzD3Gydlk5ljxNX+YuTMaogOYsiUTvyBv8+qIDhNmHykhY6EyUcFoQqCEjY7zaEqgoQ6
	ZWv5k/Nk9YoSoR6INofdm0VFPLax0cpuATI0DOrDw/XWD9fFpt/M1dHohmg/VUPDkT3bXP3/7bDVM
	cSFUNd01jMNzVLm6HzX5CJM7omv27sHRFg7F5BeXsuefoH1HfNtkgiKiQEgeRM9nzSgDHJcG3E5w+
	p4kvWTFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMfhT-0000000CYXU-1H41;
	Wed, 04 Jun 2025 04:26:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMeuV-0000000CSSO-1nHl
	for kexec@lists.infradead.org;
	Wed, 04 Jun 2025 03:35:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749008124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PO4T1rnPlmKykDehCYP0m1kIchCQnr8l4c6LLtP6l80=;
	b=fxg71/Rk1ou5SUMA+ubzGEPYfxhlIpv6Cb2DqYKQuKiVZWhJ01MxXu3ISxjFn0ZVi3Vu6+
	iV+CFIVUTHMIyoDSLDDCraQDJFu+Bn2K9AiGTQs1jOHV40t6VvP7czXn+95/KBggm4RS5h
	WXb+y/YI0OgE69/HuhKsDSPijd095pM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-t-qK7SloPLKBohUHITsjSA-1; Tue, 03 Jun 2025 23:35:21 -0400
X-MC-Unique: t-qK7SloPLKBohUHITsjSA-1
X-Mimecast-MFC-AGG-ID: t-qK7SloPLKBohUHITsjSA_1749008121
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2350804a43eso89462635ad.0
        for <kexec@lists.infradead.org>; Tue, 03 Jun 2025 20:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749008120; x=1749612920;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PO4T1rnPlmKykDehCYP0m1kIchCQnr8l4c6LLtP6l80=;
        b=hyOdyJ+KzuvHhU4mygTOlMY3kEAlRS3rkwqCqImZpqiDhwjYEW0TnIbCjRl9+BAXpd
         HPgawoUFyiYxpd6ZfCEx8OkKOhlERDwSYrpwQHFmYMVPWwVSx65weJmE/mlvEPs45Zvp
         X/XyNMA9cflzpdr2p6wwPCRE9BMgrBkb4SE+/U4WCpVgMHoDMx9fUT9l23bbdLY/zeb+
         JB2t/dnqVO/yOfxn2n71kL0TZVBq8+QwbBQXqRTVV88dVuiQcOCJaw26SXCG9duEE3Je
         PRSerZQRSgKrhSmwt06R1rU6H7QFl2ZrgLstlaA1cY9RSYFYinU4ChV9VFcGSmWgURly
         53tw==
X-Forwarded-Encrypted: i=1; AJvYcCXN4QpftoX5a++w6orKUW+5AF8rWllUsGpOAWDeWAQmFunAUT+RV4gMPzxvQrktt3wtveRlOA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyCh42r6PGdZ11o9dPuJGM3QMT2PLTnLsU7gDmp3LbjWlSy3DMR
	o1E9P2jPs9xQVrELO9isP0lS4Efxg92g2UlZQKVsmp/p+8ZLk9Fa71NWCeTsNWi3L13TOZhhV/j
	eQW9e64H/IVlshdV9yJgz+osiMj3MtCfKK/pWaADY3r39pns+L84m9eZNDJT7Mg==
X-Gm-Gg: ASbGncuNedYYiXYJZvVbjnMt4s2UvogE/ePiB17Gf5Q0YqP+YgMXmHFQHv4Io3DqWRp
	rSPwJFRInhdBUyqYPOQJno6UKSuFneD/UC9C9HRrv7PdQKQm6V9KYPRbifmZVxIQ2QAVycrJIG1
	EL0Qup6DVYI42sEODaBnH/xreUFNtxHXb4jkghsFE3Jzv511VcI5cNsLMojdv4IYQVyu6dXgx3e
	nJAjwT/l99oV7NWdtq5opfHDDTLCSm8t9sv8e8/YGqtPzyp/OuXoUqx43nmY4u45WNOQK2+zS2p
	0lDrCe2s3JiuUQ==
X-Received: by 2002:a17:902:c944:b0:234:ade3:dde7 with SMTP id d9443c01a7336-235e1129185mr15703615ad.13.1749008120630;
        Tue, 03 Jun 2025 20:35:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR2MuyzmZwUzZOpzOGpfnKsGH/Q7AqQUA7K47C8uCXumRKpRcoVETmeg7zWutgFqvbeD0vDw==
X-Received: by 2002:a17:902:c944:b0:234:ade3:dde7 with SMTP id d9443c01a7336-235e1129185mr15703375ad.13.1749008120217;
        Tue, 03 Jun 2025 20:35:20 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3130690562fsm743828a91.17.2025.06.03.20.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 20:35:19 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:34:34 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, 
	ruyang@redhat.com, chenste@linux.microsoft.com
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
Message-ID: <hn455nyrp65bb23ltub4tet6ixfcggshgerxm2bhun4ubv2iau@eanh3ka67irf>
References: <20250515233953.14685-1-bhe@redhat.com>
 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
 <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv>
 <c0f1df02160138d0782cb897eda844287b3d7792.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <c0f1df02160138d0782cb897eda844287b3d7792.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w9PqnQCnZf0FEBAT6oxfvBBDfYP-ZxNrOP57Fw6PXzo_1749008121
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250603_203527_543840_0CC9D881 
X-CRM114-Status: GOOD (  26.58  )
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

On Thu, May 22, 2025 at 07:08:04AM -0400, Mimi Zohar wrote:
>On Thu, 2025-05-22 at 11:24 +0800, Baoquan He wrote:
>> On 05/21/25 at 08:54am, Mimi Zohar wrote:
>> > On Fri, 2025-05-16 at 08:22 +0800, Baoquan He wrote:
>> > > CC kexec list.
>> > >
>> > > On 05/16/25 at 07:39am, Baoquan He wrote:
>> > > > Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
>> > > > extra memory. It would be very helpful to allow IMA to be disabled for
>> > > > kdump kernel.
>>
>> Thanks a lot for careufl reviewing and great suggestions.
>>
>> >
>> > The real question is not whether kdump needs "IMA", but whether not enabling
>> > IMA in the kdump kernel could be abused.  The comments below don't address
>> > that question but limit/emphasize, as much as possible, turning IMA off is
>> > limited to the kdump kernel.
>>
>> Are you suggesting removing below paragraph from patch log because they
>> are redundant? I can remove it in v2 if yes.
>
>"The comments below" was referring to my comments on the patch, not the next
>paragraph.  "don't address that question" refers to whether the kdump kernel
>could be abused.
>
>We're trying to close integrity gaps, not add new ones.  Verifying the UKI's
>signature addresses the integrity of the initramfs.  What about the integrity of
>the kdump initramfs (or for that matter the kexec initramfs)?  If the kdump
>initramfs was signed, IMA would be able to verify it before the kexec.

Hi Mimi,

I thought you were asking that the commit message should address the
question why disabling IMA should be limited to the kdump kernel. It
turns out I misunderstood your concern.

Currently there is no way provided to verify the kdump initramfs as a
whole file or to verify individual files in the kdump initramfs.

As you have already known, the kdump initramfs is always generated on
the fly and will be re-generated when the dumping target changes or
some important files change. We try to generate a minimal initramfs in
order to save memory. So yes, it's impossible to sign it as a whole file
beforehand. 

And since xattrs like security.ima are not supported in the kdump
initramfs, we have no way to use IMA to verify individual file's
integrity.  In fact, we have to stop IMA from working otherwise it's
very likely kdump will break.

So far, I'm not aware of any bug report that complains kdump stops
working because of IMA. So it indicates very few users are trying to use
IMA in kdump.

If users do have concerns on the integrity of kdump initramfs, I think
we can advice users to make sure the deployed IMA policy will verify the
integrity of the files while they are being collected and copied into
the kdump initramfs by tools like dracut.

-- 
Best regards,
Coiby


