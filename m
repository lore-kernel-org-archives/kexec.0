Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF0CFA3748
	for <kexec@archiver.kernel.org>; Fri, 13 Sep 2024 11:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FZHLqI40t1mE+MQ9tI64NkNvcnsWJtEv5dXs26rrCQk=; b=pWyb0wLJPWRc3C
	nw4RorZRjexaphdZTYkt8GEFbnDhAwtCVKMBtilf+v2Wlw0MM0wkAuzjNtkuitpr2JJviFjeWESNW
	lzyy/NTmX0ffGp2ztkt/Wdd8FrkjJPlszIBgkvxKkkbJ3Pl5+hGAnCGu9UcUuFG08uRpYhIWsfHF/
	K2QvyIY1IpRvNJvejvWNQq+5XpIPUTRJuhlUygEcPyCPyNdBgnhTTICiDtuG5Am+fHTbs6xEj6x+U
	8dmKnrSTJgDDgD25J83MKq1mZnWMevkRfioHDB39QBfqyK3nbLjMPN2JX6YhHyAWlmnih0j5p770O
	6j4OfoGUDIn6DNwkajNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp4w3-0000000FoFB-1uy9;
	Fri, 13 Sep 2024 11:57:59 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp4w0-0000000FoDq-28w1
	for kexec@lists.infradead.org;
	Fri, 13 Sep 2024 11:57:58 +0000
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7b28so2516875a12.2
        for <kexec@lists.infradead.org>; Fri, 13 Sep 2024 04:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228675; x=1726833475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI+zHtk2NVADatDuI+y5aY9OMDmt/UoADnsxa7QwLCs=;
        b=DU0wV0ugJfLhA4zO9IdM5Xmx6bORu8FylIKcirjVSwwdkwM1JrilLAuKfE7H5IV7SX
         5GviVv19ec/s/JHDeDbYlhMa/Y3kgUULVsiuMYba4TAErnPmoH957b/8m+pJIpsf7rf6
         4fea+ZcOr3/XhiwAptOshL3/U9tt45tTZAr3nanuTB862ImhXQ58S1Z5RHtOgU6ZuEzB
         mwXMrci2t3+dl1qssMi27jwPK2quXSL6TzmNs7tld9JkW76S/JYtay6p9QnNjMVUQB5h
         NaztikEOhU3UW81Khq+fOL8CXGAWMugnzZVk92g9nhix/KCIrKQxb/j3hwmGShytVg6c
         ZZww==
X-Forwarded-Encrypted: i=1; AJvYcCW0AYO8Kc+e8xDo9Mx+DoOnOgfIW9q4931k0gDfMndS7ckGZRTIskrAG81GlRAwpMi1V8I/Eg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzWZ5k7ScsbAj9paW5IehJAXNxV3M6vV1speGVxIq/4h+q81SXX
	1FDyLoN0zGE//VT5eVUQvnHDIQUs9yDtwi71Iy6IMdHdfXvkbhS4
X-Google-Smtp-Source: AGHT+IFcfcf4C/OELpfH9TlUaARgUApLjqP4fVLpMOOD5SV7QEG5XU93VRdxoBgDgJgZt/M1wJCrxQ==
X-Received: by 2002:a17:906:730d:b0:a86:ab84:7fc1 with SMTP id a640c23a62f3a-a9029620359mr724581466b.50.1726228674122;
        Fri, 13 Sep 2024 04:57:54 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25831827sm857132766b.20.2024.09.13.04.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 04:57:53 -0700 (PDT)
Date: Fri, 13 Sep 2024 04:57:51 -0700
From: Breno Leitao <leitao@debian.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
	linux-efi@vger.kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, rmikey@meta.com, gourry@gourry.net
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
Message-ID: <20240913-careful-maroon-crab-8a0541@leitao>
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
 <d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_045756_575267_D3ACEF6D 
X-CRM114-Status: GOOD (  24.34  )
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

Hello James,

On Thu, Sep 12, 2024 at 12:22:01PM -0400, James Bottomley wrote:
> On Thu, 2024-09-12 at 06:03 -0700, Breno Leitao wrote:
> > Hello Ard,
> > 
> > On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
> > > I don't see how this could be an EFI bug, given that it does not
> > > deal with E820 tables at all.
> > 
> > I want to back up a little bit and make sure I am following the
> > discussion.
> > 
> > From what I understand from previous discussion, we have an EFI bug
> > as the root cause of this issue.
> > 
> > This happens because the EFI does NOT mark the EFI TPM event log
> > memory region as reserved (EFI_RESERVED_TYPE). Not having an entry
> > for the event table memory in EFI memory mapped, then libstub will
> > ignore it completely (the TPM event log memory range) and not
> > populate e820 table with it.
> 
> Wait, that's not correct.  The TPM log is in memory that doesn't
> survive ExitBootServices (by design in case the OS doesn't care about
> it).  So the EFI stub actually copies it over to a new configuration
> table that is in reserved memory before it calls ExitBootServices. 
> This new copy should be in kernel reserved memory regardless of its
> e820 map status.

First of all, thanks for clarifying some points here.

How should the TPM log table be passed to the next kernel when
kexecing() since it didn't surive ExitBootServices?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
