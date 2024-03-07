Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED968C54E49
	for <kexec@archiver.kernel.org>; Thu,  7 Mar 2024 07:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jvICNBAPcxSSbOJmN+rwjY2J6CYlHZ0L0VqUUep7wew=; b=pWEUfhnz+2Sqk1
	HXoyIGxay9KvrOxTCH52++2Vu9ekdDm6DNAJImpjF/eIwf4bqypQlDaMPKPcH95SJeW7bMQ85tu4k
	Oz5wKX+52+pOFgyX3BuXmAtuVogdqupURxlIdVPiHHuRNcxrVwqOCDImTxZGmSLAbNuw2zc9iB740
	xAythTRPv5L+CODgWn3EVL6iR4MkGVVjHAm4MdrGTKD32MasiAI76NDWnqs3976VCvsmymt1TplNO
	386uTPh5FA6v67fBvfV/yJNXsCtXSb3dKxsEdx1Yu/gBNw1LHZCh/vTXi8EnjKsx2a3p8yny5lsao
	QA8qNFy+r5oaEx9GdK3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri7ja-00000003Lbp-1HXF;
	Thu, 07 Mar 2024 07:00:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri7jX-00000003LaI-3gG2
	for kexec@lists.infradead.org;
	Thu, 07 Mar 2024 07:00:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709794801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WahUM+zqL3/MV81SCT1ET9pBkiIjcOfSRMGsDbdTxr8=;
	b=JYPImS6RwfZKsJbzv/+3DP4/Jd9WrgngnjLYRGhJQpmk/pMkrE9vz14/yQz5g7WQ74AzGs
	kXfrNKrfEaZ8xfjdJ27IkPNBy9FKYfFRTA2mhxTSUROp10W3VAzgg674f4oM00uAPOlcoz
	Ahq2AWxzGxw2xnhv8KlgYl9Fz/FJ95I=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-4Q_QNrjxO6KvTdwdCWiPgw-1; Thu, 07 Mar 2024 01:57:38 -0500
X-MC-Unique: 4Q_QNrjxO6KvTdwdCWiPgw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e5a145ab89so565450b3a.0
        for <kexec@lists.infradead.org>; Wed, 06 Mar 2024 22:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709794657; x=1710399457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WahUM+zqL3/MV81SCT1ET9pBkiIjcOfSRMGsDbdTxr8=;
        b=m+f4el3HAK1oWRUzYwBe1pg2pXkvGDBhnvI4lGumb9/+958YKYgTHZ9iNJYm1nhzD/
         Tc/44LvEAYKwMmEYnkqsCl8ydYuNh+ILwBkjoeXlO857pgAqXwVTwSS0WlpvlGtx+O4l
         SV7XttQ6s8PkWdg+/Lq0QXhkU7G2BGuvC3rbD+uq5gD44iTnAGSUKJyodMLqXFf0ZLuI
         zn1v1XHyu8KHkKmDEGSEIyEcABu8W7q3+DbuMXfrvk2DBSihlWdHkdEBJT4ARkF0P553
         nRU0oJe1UwqK0ZeJ+PmZPmZJ3VPH3gjIDlsFWacsYrcjGaR9/lLpt0PlSaB0G1V6OwFI
         Cgsw==
X-Forwarded-Encrypted: i=1; AJvYcCWUOuv13a0y0wfyI91kwKKujNgeLzpSk1mIZXk7WJseqj1ZomNFe3Rfsl6IYFNS8besD7khqE+SqPDMS/K4zYsgZWxiAKZExdU5
X-Gm-Message-State: AOJu0Yy1nwMJWHXWFPhODgKaVHRixDs53iR8ZCYk/E1PrVB+lEoo/Lc/
	C92RWEC5hT6boOuzoWibSXNqgRwi2vbxidRkepcVNOu2cl/gTMtuvgWipCbdnWRpMoL1ZVoFRWl
	UNCAq4o35iYzZtPCXKmIVAY2h3+hR/eWVTRC9Mwv5qMd++PPQk7G1Xhbjyg==
X-Received: by 2002:a05:6a00:4f8f:b0:6e6:5370:3195 with SMTP id ld15-20020a056a004f8f00b006e653703195mr3240567pfb.33.1709794657469;
        Wed, 06 Mar 2024 22:57:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE70QkKb4MS4CFQ6y/fKKac0Ls4UH2IM2U09gwVVV4yDxTwO+I27Y1R/Dw4n/JTb1WZMwcj8w==
X-Received: by 2002:a05:6a00:4f8f:b0:6e6:5370:3195 with SMTP id ld15-20020a056a004f8f00b006e653703195mr3240548pfb.33.1709794657163;
        Wed, 06 Mar 2024 22:57:37 -0800 (PST)
Received: from localhost.localdomain ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o26-20020a056a001b5a00b006e4766d31bcsm11864528pfv.184.2024.03.06.22.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 22:57:36 -0800 (PST)
Date: Thu, 7 Mar 2024 14:57:27 +0800
From: Tao Liu <ltao@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 00/17, CORRECTED] x86/tdx: Add kexec support
Message-ID: <ZellV+unyyx6C+et@localhost.localdomain>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
 <4iospuc5oxs7vbgm3driasjeyixvgz6yrmym3kzguzngngo7zm@c6ymrw52fn5v>
MIME-Version: 1.0
In-Reply-To: <4iospuc5oxs7vbgm3driasjeyixvgz6yrmym3kzguzngngo7zm@c6ymrw52fn5v>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_230004_008555_A5D6F830 
X-CRM114-Status: GOOD (  17.45  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Kirill,

On Wed, Mar 06, 2024 at 05:02:45PM +0200, Kirill A. Shutemov wrote:
> On Tue, Feb 27, 2024 at 11:24:35PM +0200, Kirill A. Shutemov wrote:
> > The patchset adds bits and pieces to get kexec (and crashkernel) work on
> > TDX guest.
> > 
> > The last patch implements CPU offlining according to the approved ACPI
> > spec change poposal[1]. It unlocks kexec with all CPUs visible in the target
> > kernel. It requires BIOS-side enabling. If it missing we fallback to booting
> > 2nd kernel with single CPU.
> > 
> > Please review. I would be glad for any feedback.
> 
> Thomas, Ingo, Borislav, Dave,
> 
> Any feedback?
> 
> Is there anything else I can do to get the patchset moving?
> 
I tested the patchset with Linux 6.8-rc6, no problem found. With the
patchset, a vmcore can be generated successfully in tdx VM and can be
analyzed by crash utility.

Tested-by: Tao Liu <ltao@redhat.com>

Thanks,
Tao Liu

> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
