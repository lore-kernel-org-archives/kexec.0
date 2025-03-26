Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B58C3600B
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nDjBICGKa43kYHEOCFvDUYcy1IhXoeMUQwDGcLiaSWE=; b=F3mu7HzFeroXJ6H8rYxA5tb3Fi
	QKU3wOPTcFI/pWnVZQ6yEoFHwOxNQwibQci1m2BJDTiPEd2/2rAmKQ2jmmPyq210x1bV80VLTmPVn
	XI/vk7upSOXlJIFH5G8SB2duhWBRcNwSQvry5zFOf25dkTVhdjU3DsBN2VQgzyiex9Lth9oUiMRJo
	aCfTBhEYQ2ewiiz+adbX082NewaYoqklTpT6zHm2jycVuluMDkzvHX762bVPf3GNgxHVlYAhdhSgh
	KTYH0uMQFpIA+19oBPdgx9gn7xmpq6mGHGwL7//+/zQRPJHHJ82l0NJOfyV1Yp4qK3VDlHPvJBJVB
	/RALlBBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnU0-0000000B6GD-3ns4;
	Thu, 27 Mar 2025 13:41:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txPZi-00000008QYn-1u9k
	for kexec@lists.infradead.org;
	Wed, 26 Mar 2025 12:09:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742990977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDjBICGKa43kYHEOCFvDUYcy1IhXoeMUQwDGcLiaSWE=;
	b=GOn4KtUItv62qh4FcdWTg+JkdpxJZBj/dqrP/oGX5Ff6FF8vU7Lnd7CivG54iREUow8vZY
	WbLEA9p/MIettlYoPLSjH2+Q0cACqkTZnzE5JM0wKZcDRNOuXPgtgv+OWee9xJqaf9by8H
	8WkmyxbQohswA2VuNXaxeaVglXm2Qag=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-P4WFKd4QP7C7-zTqA3R0AA-1; Wed, 26 Mar 2025 08:09:35 -0400
X-MC-Unique: P4WFKd4QP7C7-zTqA3R0AA-1
X-Mimecast-MFC-AGG-ID: P4WFKd4QP7C7-zTqA3R0AA_1742990975
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85b3827969dso676701139f.1
        for <kexec@lists.infradead.org>; Wed, 26 Mar 2025 05:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742990975; x=1743595775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nDjBICGKa43kYHEOCFvDUYcy1IhXoeMUQwDGcLiaSWE=;
        b=DvI4SC7jEuGBy0vE1IUGDD3RnIiBOMlPwMOCED4e47uTGLxuyagA4sjmvZGAFTiYBa
         UZD5CfmAV9V3MwWGWzxIzPj0mkgio6o9wYdeLptMfh8JesWx7f8zJtSi6k98DZtTzYXv
         qF/L3kLi2EPLaYAVXpmlQ65Pt9fVCkNEBvWYg6ZZN2rXj3ZjCDw9Vt1i64lAArN38obV
         Zurz7rQbVu7515d9wcLYpBClbRNr6NOC3mZnl7sv3jNos2EzY5aAhowDN2TEz35OsVmz
         /IH5nIfyydoql+fE1w9bCeeYir6yhU+V/+J+4Ya8/BzjtsmVe1N19pDUuxjzbJPr+6Nz
         mCtA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ7YmHBwyU5W+VJxepNcJfK7sTdEoZqGIgsXSnngWjlJoyf8sVvtoeFXi1VozHWtJwogdQEw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwDE5M6yYS5Ec3gFBg4Izx8QWPTcaVhcKLlHG0PbRfjnDOEizap
	9OCkoycw6d+haIE4N8LrQ3wdC2rHgYC0WZtIUlsKT1HkJd4Z02iKRZ0xccBjGhuH+BiecvI2wRl
	iPjKxYOFWfgxNDITu5GPLSXGhkfLOT31kdI9MucScL8udVPLuyCB+ihaywp5oXoEEF1R/ELw+Rv
	Hdw6EbHRGfgqhgkyNpuT8lzDxkvg1v28dT
X-Gm-Gg: ASbGncv32HMTbJRKxtfDZQ3V7/y1IPx21XW4zjZ1NhrSb8Y81wGsCbARmPwWddeWEfU
	s2Jjw4YoDTOzF2yKxfgmAX26NVWskoWC2vwTjn0NQb3P58H6oTAZdd+kXRkyydxQ1EqlhIELwyg
	==
X-Received: by 2002:a05:6e02:3a0c:b0:3d4:6f37:372c with SMTP id e9e14a558f8ab-3d5960e2419mr225832905ab.7.1742990974580;
        Wed, 26 Mar 2025 05:09:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOuyfQGVOhYyFSi3hsb9kc2zJRzczpD7XPzwNdnwVuHyYQPBafKpH087OtVwDsIyzVWltmG166ADE4aJfipJU=
X-Received: by 2002:a05:6e02:3a0c:b0:3d4:6f37:372c with SMTP id
 e9e14a558f8ab-3d5960e2419mr225831915ab.7.1742990973998; Wed, 26 Mar 2025
 05:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-12-changyuanl@google.com> <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
 <Z+JT7kx+sfPqfWFA@MiWiFi-R3L-srv> <CALu+AoQj+mHECTvbuK8CpUTmOYgx6n2oMFm5kQXtSigL+5Ks2w@mail.gmail.com>
 <CALu+AoRdfjNcjweq_ipxCC6UGBzM-a5ma417RBr-C3EQ=Em9OQ@mail.gmail.com> <Z-Pk9Bnr0lDVopKj@kernel.org>
In-Reply-To: <Z-Pk9Bnr0lDVopKj@kernel.org>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 26 Mar 2025 20:09:55 +0800
X-Gm-Features: AQ5f1JrnxWyTc7ruwIDaX1fnmt0FdUmOV-OtIvcwHa3Skex-wO_kM_31tXed_lg
Message-ID: <CALu+AoS9=KttzqgR+xi11jur5eX7dBwUfOoueHoOss3eFn+Hkw@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] kexec: add config option for KHO
To: Mike Rapoport <rppt@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org, 
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	mark.rutland@arm.com, pbonzini@redhat.com, pasha.tatashin@soleen.com, 
	hpa@zytor.com, peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org, 
	robh@kernel.org, saravanak@google.com, skinsburskii@linux.microsoft.com, 
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, will@kernel.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1o-GdxV3n3wdN5xHVNjowMTPmEn8eEGZ3XqK0nYfQKI_1742990975
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250326_050938_565662_1EC8F681 
X-CRM114-Status: GOOD (  23.46  )
X-Mailman-Approved-At: Thu, 27 Mar 2025 06:41:08 -0700
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

On Wed, 26 Mar 2025 at 19:34, Mike Rapoport <rppt@kernel.org> wrote:
>
> Hi Dave,
>
> On Wed, Mar 26, 2025 at 05:17:16PM +0800, Dave Young wrote:
> > On Tue, 25 Mar 2025 at 16:36, Dave Young <dyoung@redhat.com> wrote:
> > >
> > > > >
> > > > > Have you tested kdump?  In my mind there are two issues,  one is with
> > > > > CMA enabled, it could cause kdump crashkernel memory reservation
> > > > > failures more often due to the fragmented low memory.  Secondly,  in
> > > >
> > > > kho scracth memorys are reserved much later than crashkernel, we may not
> > > > need to worry about it.
> > > > ====================
> > > > start_kernel()
> > > >   ......
> > > >   -->setup_arch(&command_line);
> > > >      -->arch_reserve_crashkernel();
> > > >   ......
> > > >   -->mm_core_init();
> > > >      -->kho_memory_init();
> > > >
> > > > > kdump kernel dump the crazy scratch memory in vmcore is not very
> > > > > meaningful.  Otherwise I suspect this is not tested under kdump.  If
> > > > > so please disable this option for kdump.
> > >
> > > Ok,  it is fine if this is the case, thanks Baoquan for clearing this worry.
> > >
> > > But the other concerns are still need to address, eg. KHO use cases
> > > are not good for kdump.
> > > There could be more to think about.
> > > eg. the issues talked in thread:
> > > https://lore.kernel.org/lkml/Z7dc9Cd8KX3b_brB@dwarf.suse.cz/T/
> >
> > Rethink about this,  other than previous concerns.  Transferring the
> > old kernel state to kdump kernel makes no sense since the old state is
> > not stable as the kernel has crashed.
>
> KHO won't be active for kdump case. The KHO segments are only added to
> kexec_image and never to kexec_crash_image.

Good to know, thanks!

>
> --
> Sincerely yours,
> Mike.
>


