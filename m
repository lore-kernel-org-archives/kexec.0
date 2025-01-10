Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B86DE7719D
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 06:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UYJ4942cgedadOicBJjPe3wK9RTEhp+LG07IpXAWiMY=; b=uHzz6ccGf3923cM8zw2Mxa9jFu
	g30tGO6RpUpeVa0eDEj7p3lKtwiLUXg9ofwnWK1QuNjCw0DhBV+mNWMp4JszGtzURIefI9dvKS1n1
	rNLDUdLnzzRCATMJKjOeeH8q981l6IFGcR8sg2OjvWqYbKeFtrZcrJaJwhPlTWjQ3rthqW4IMh//b
	OPDPyVNdsZ+4wkOqsSm9Y/FRY9j1JAoFLAAVBkXpLDUtz61rhzxWWPvGEvMacWVgTG2DElGAY4poa
	XkB391WvR/9fJmvl3nr2Q3DNI5fub6VXB9G10OfKxtUDtJ7VAMuFbwIFMXPxvbz/MI/PgrnXYMcMh
	89IlrtKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tW8mD-0000000EIJo-3GtR;
	Fri, 10 Jan 2025 06:45:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tW8bG-0000000EGc2-2jD8
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 06:34:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736490869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYJ4942cgedadOicBJjPe3wK9RTEhp+LG07IpXAWiMY=;
	b=Mjh2Hp1hXzxyL3HfiBSvi8XDGRRfk3C6fkSn+dxYPfx/SAPFN7SAILI/WdQCj0/DGjQk2N
	jS0dVKzSOmG4W/Sw3yOmD1LAwLzJjnSX9vg80p8zeRzx3ipzoyC5aOU6n8FD8F3pidjSrd
	PV7urs4v5c4SO3vD12UfmBaY7d0cRnY=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-hHb-IA0qPkWvhoqq52PxqA-1; Fri, 10 Jan 2025 01:34:28 -0500
X-MC-Unique: hHb-IA0qPkWvhoqq52PxqA-1
X-Mimecast-MFC-AGG-ID: hHb-IA0qPkWvhoqq52PxqA
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9d3e48637so13675095ab.1
        for <kexec@lists.infradead.org>; Thu, 09 Jan 2025 22:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736490868; x=1737095668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYJ4942cgedadOicBJjPe3wK9RTEhp+LG07IpXAWiMY=;
        b=WSK3YDCSmxvRpD7rcnNze0LJLDGQAAmSMigMU0vwb86VVzwTQBK+YDjuykDdRtAAYp
         c32W/qszL21EOQw7wMo5ZYc+X6EeZXP6oSnjqzpTw124dHDpaSukGtoLLHqxOSl+/xr0
         iQ9gZuZFdvWf48suhiMTGODNh7IjVeHAP/2CSjc7uKgdE1dM7XhhfbsaxGgedH7ck3il
         dpOK/ZgmNtiCgOHFXH1IgXyc9XrXjUuXI9tursMO7xHqLG1RUEcccUMPOdrT3MUmsOPN
         aaWQ9Hg1gfVHcbCZWAmC7fFrbLbXuRqJI3DSBjBXGqyob+6Qv7F+vPldZn2hvH5gaivM
         wYKg==
X-Forwarded-Encrypted: i=1; AJvYcCUWV3WZonnHd+duwQTuLmg1swFzP6UT5nNhRsXMYZWthLx7r4EGx4+kufZLMaTRvb5MrNqewA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz34c46Z4xPWFlNxOwS9q7fbxcoGoDBD/0Pj6jyMxyUCdkT5TTt
	zTs8cYw2zqwOVYwTloWjWWO7ka9/kGV5DqHYIOPwhILwOrPdC0SMav4lamAI8l18Vgsy+fwVljL
	f7xi+oNoCa6R2Wxe0/2FSVfx0IlAvB17E9UrWryQ+HNQIprG1jLwf9MhviqKnEDulRKGMy01ZNk
	u2DIS2wTTN+vEFOC9ubT3mJ3ubnf/VKbYo
X-Gm-Gg: ASbGncsmDxaCkTU0iFQl20Og9BPWybCnu3q87bY8/6ycPYHgWEzuY80vG4rnqwK65sh
	vWnQm+Rj5sBXeZpzJaQrB864XyrSkTG1y6XRb9Ow=
X-Received: by 2002:a05:6e02:1a6f:b0:3a7:8270:4050 with SMTP id e9e14a558f8ab-3ce3aa5b242mr75441415ab.18.1736490867762;
        Thu, 09 Jan 2025 22:34:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAOOfYpVK4oLuZjwDprBURSlCGVs9zkFLjBkXoClVdQ8tDvKTOGcD0Es9gDK7iOspy+pWQdXQ2y0tsrLHsDVA=
X-Received: by 2002:a05:6e02:1a6f:b0:3a7:8270:4050 with SMTP id
 e9e14a558f8ab-3ce3aa5b242mr75441275ab.18.1736490867496; Thu, 09 Jan 2025
 22:34:27 -0800 (PST)
MIME-Version: 1.0
References: <ZuVxlJ77V2_U0HPM@darkstar.users.ipa.redhat.com>
 <CALu+AoQyGN2m1ss7GSPCn5UqiEWb+M5BK9MStzMn64k83egtQg@mail.gmail.com> <CALu+AoSKCtU4iGRM8LH6qYbgKvZ79=zfC8kXXb_GJqp=mpEdFg@mail.gmail.com>
In-Reply-To: <CALu+AoSKCtU4iGRM8LH6qYbgKvZ79=zfC8kXXb_GJqp=mpEdFg@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 10 Jan 2025 14:34:33 +0800
X-Gm-Features: AbW1kvZIfX_Pl-NtrzhGqypmPjk7iNKZDQyGvVhT6xXuoLhC-E1Q9bXAnzIADSk
Message-ID: <CALu+AoS-nk4u=9UYP7BLS=diOxjJRf+vfv7KHXG=uXozoYazsw@mail.gmail.com>
Subject: Re: [PATCH] x86/e820: update code comment about e820_table_kexec
To: Chen Yu <yu.c.chen@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RZfRKiqlK476M2T-EYmtEM5Rimw5O77Cgml_tTmDC6c_1736490868
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_223430_764976_DBF020F7 
X-CRM114-Status: GOOD (  33.99  )
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

Add hibernation maintainers in to: list
[sent with gmail web ui, sorry for the format issues]

On Fri, 10 Jan 2025 at 14:29, Dave Young <dyoung@redhat.com> wrote:
>
> > BTW,  the conversation below drived me to read the e820 code:
> > https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
> >
> > It could be better to clean up the e820 tables, anyway the comment fix
> > in this patch itself is good for now.
> >
> > Basically e820_table_firmware is used by kexec-tools kexec_load
> > implementation,  e820_table_kexec is used by kexec_file_load code to
> > pass to the 2nd kernel in boot params.
> >
> > The e820_table_firmware is said to not be modified by the kernel in
> > the code comment, but this is not true, at least the sev code updates
> > the table.    The hibernate code generates crc32 checksum and verifies
> > it, but since AFAIK e820 table update only happens in boot phase, it
> > will be stable on runtime.  So we can just use e820_table_firmware for
> > kexec use and drop the e820_table_kexec. With the change the
> > kexec_file_load and kexec_load see the same memory ranges.
> >
> > Otherwise I thought we can use just one e820 table, dropping
> > e820_table_firmware and e820_table_kexec, but then there will be
> > fragments and memory waste  due to the setup_data ranges are reserved
> > and updated in e820_table, so the e820_table_firmware being still be
> > used for kexec makes sense.
> >
> > Anyway I need to think more about it,  please let me know if you have
> > any concerns.
>
> Reread the old commit 12df216c61c89e31e27e74146115a9728880ca6f
>     x86/boot/e820: Introduce the bootloader provided e820_table_firmware[] table
>
> It seems the e820_table_firmware was changed to be exported in sysfs
> instead of e820_table_kexec,   but I suspect this is wrong.
> kexec-tools (kexec_load) use the exported sysfs memmap info,  but
> e820_table_firmware was created by above commit to be used by
> hibernation and the table should not be changed,  the fact is there
> are changes happen from time to time.
>
> Question is does hibernation use the sysfs entries from its userspace
> tools?  If yes, then we should have both kexec table and firmware
> table exported because they are for different purposes and one may
> change, another not.
>
> If hibernation only uses the table within the kernel then it makes no
> sense to export it to sysfs, we should only export the kexec table for
> kexec-tools use.  In this way  both kexec_load (userspace) and
> kexec_file_load (kernel load) can use same e820 table, it will reduce
> the bugs and be easier to maintain.
>
> Thanks
> Dave


