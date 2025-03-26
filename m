Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A3CC36013
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ow6AGnrr84AMQ0ah/Xi6PJkaHmTpZO5eKBmQQUtOVkg=; b=izejp2f8+8jeJV8rSmsS8Cb6r0
	fTrsM2UGcIA5ETU4jf03V9YDUhTNl1Db6uP4VlVtwHjZ46KRZQ9c3Dz5BGXmKlrcV78NcOjywYQ29
	u+HR7xIjgIxwp2lD7bZ4WRAugOGBdmt7F8pwotIiRpPhYtDb92dbcjOR0rteGesOyEayqLnAOUIa2
	dnGNIf5x+7kDL8CnDBOdBz9jybw0eomI2WrGsm9GBAoEr4k90gyivTJ1C5pSCow06RCz4LjBLx0vf
	Rp2f5Z9bw9r1AMHMcUJGuvztqaPWrmhNFhDkj2zs5PP/rWCm5Cpe2KllCimzZEiq0B2d7gFs4q4r8
	HWLCMGiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnTy-0000000B6Az-1vWz;
	Thu, 27 Mar 2025 13:41:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txMsd-000000080Np-24sG
	for kexec@lists.infradead.org;
	Wed, 26 Mar 2025 09:17:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742980617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ow6AGnrr84AMQ0ah/Xi6PJkaHmTpZO5eKBmQQUtOVkg=;
	b=aXXGggezF1ezh1XJYmGlQHRi6ALyjONB/kYJclvM0jGnTfYcGc8hvzkxYVZrTCyBsIVYd8
	/waOH0SPjr0KnaRz9Sc10rQrXWsrx+VLu3Xp4JjrT4dq58x6MMsQKJB0uYJ6lC+dbnagOf
	tWBc9XFIK/E3SRQxwU6+1JmiglbSbDo=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-UsHq3eXGOVOWx9P97bROKQ-1; Wed, 26 Mar 2025 05:16:56 -0400
X-MC-Unique: UsHq3eXGOVOWx9P97bROKQ-1
X-Mimecast-MFC-AGG-ID: UsHq3eXGOVOWx9P97bROKQ_1742980615
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d586b968cfso126313015ab.1
        for <kexec@lists.infradead.org>; Wed, 26 Mar 2025 02:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742980615; x=1743585415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ow6AGnrr84AMQ0ah/Xi6PJkaHmTpZO5eKBmQQUtOVkg=;
        b=gmxflRcQfKTlVmJfhFMKbDTp0FEV2B3l+jPo2qx5vLPDl77S0mifHnWF5NTExB56dP
         1QPgChiigQB9RlfgxAeLHSkTVc1loNVYoddJBlM10g3ds4bnXcpXLs+zaK8CuW8HR9c2
         dfq4T5igW9itcCyOtpb7Q46awfDqufpv5brBNBUW3OgONASrTuutVS7RFWtY6fssX1od
         +tAxiVg7/TmaI14JgROeL/8sIkaa2/dhW/oSKr/OrL9Z4f/5c4M6ChCcigQWRjkPxl9M
         Xt/ZXIE+1PEehVrCoE5blbSxZoF1hp1ZiFe3TYVTyl/5AonqNBMSoUic+tMKtz33ZCRF
         fklA==
X-Forwarded-Encrypted: i=1; AJvYcCUf+4azw+S5W/L27fyJscp3wtt0r00xrCsu8FscegOm4f/r2VXBSxmGfPvCIknqYi6PzQhkuA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzepjiD5pBQ8rEUimlgbpv6NGPPATVA2N5uo1RgQVuE5L/P73vL
	Gn/Us0/R0J1MvA5VAnmgUgTiM42VUyclUEc6f2nNDcvUcc4vpFoY4anEHMlb9/h8m95NAySHGjH
	DWrsLF7M+G7vHVCnsdiCLm8Sf/BnZCuVQyotXuvnviv4xyG7czejo7M0qyfyMUXpCm0mF7Ls+fR
	tx0hz8PUQUg89fPX1TdTLTHrv2c194KriE
X-Gm-Gg: ASbGncuOjAj4HRJKCOE6KAmeh+J2yCMoogHKT1b/D4xy6FZfZA0nY3uxkUYzGuXpguk
	0FWBL57Cd86QPq/eA8BOJY/1eC/ckZoOXza7RE6/Q0nvQKUmdlQqIYFYMVQ803lVKlkiYDBX6jQ
	==
X-Received: by 2002:a05:6e02:3e03:b0:3d4:2409:ce6 with SMTP id e9e14a558f8ab-3d59612bc91mr234170285ab.5.1742980615149;
        Wed, 26 Mar 2025 02:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ1vGph9A3VJepHAKEDwhyEi3HEUoYZg9GSD20aZ5PWU5QdCBZemC86Ee43E1W8Lw5ALFAPfq+RTfo03e4kyA=
X-Received: by 2002:a05:6e02:3e03:b0:3d4:2409:ce6 with SMTP id
 e9e14a558f8ab-3d59612bc91mr234169465ab.5.1742980614659; Wed, 26 Mar 2025
 02:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-12-changyuanl@google.com> <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
 <Z+JT7kx+sfPqfWFA@MiWiFi-R3L-srv> <CALu+AoQj+mHECTvbuK8CpUTmOYgx6n2oMFm5kQXtSigL+5Ks2w@mail.gmail.com>
In-Reply-To: <CALu+AoQj+mHECTvbuK8CpUTmOYgx6n2oMFm5kQXtSigL+5Ks2w@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 26 Mar 2025 17:17:16 +0800
X-Gm-Features: AQ5f1Jpq9GZncvPHkaxZJh8I7FiGahHb1rvcGNvIVWbnRM_2M_RRWQiPj2LtDHg
Message-ID: <CALu+AoRdfjNcjweq_ipxCC6UGBzM-a5ma417RBr-C3EQ=Em9OQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] kexec: add config option for KHO
To: Baoquan He <bhe@redhat.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org, graf@amazon.com, 
	akpm@linux-foundation.org, luto@kernel.org, anthony.yznaga@oracle.com, 
	arnd@arndb.de, ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, dave.hansen@linux.intel.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, 
	krzk@kernel.org, rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yS7bu-NHRmqBDdB0gex-qWhmRoJxKm8chHhP1KdVAmk_1742980615
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250326_021659_606561_7B407650 
X-CRM114-Status: GOOD (  17.11  )
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

On Tue, 25 Mar 2025 at 16:36, Dave Young <dyoung@redhat.com> wrote:
>
> > >
> > > Have you tested kdump?  In my mind there are two issues,  one is with
> > > CMA enabled, it could cause kdump crashkernel memory reservation
> > > failures more often due to the fragmented low memory.  Secondly,  in
> >
> > kho scracth memorys are reserved much later than crashkernel, we may not
> > need to worry about it.
> > ====================
> > start_kernel()
> >   ......
> >   -->setup_arch(&command_line);
> >      -->arch_reserve_crashkernel();
> >   ......
> >   -->mm_core_init();
> >      -->kho_memory_init();
> >
> > > kdump kernel dump the crazy scratch memory in vmcore is not very
> > > meaningful.  Otherwise I suspect this is not tested under kdump.  If
> > > so please disable this option for kdump.
>
> Ok,  it is fine if this is the case, thanks Baoquan for clearing this worry.
>
> But the other concerns are still need to address, eg. KHO use cases
> are not good for kdump.
> There could be more to think about.
> eg. the issues talked in thread:
> https://lore.kernel.org/lkml/Z7dc9Cd8KX3b_brB@dwarf.suse.cz/T/

Rethink about this,  other than previous concerns.  Transferring the
old kernel state to kdump kernel makes no sense since the old state is
not stable as the kernel has crashed.


