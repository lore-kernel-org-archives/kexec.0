Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA3ACD8C9D
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 01:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sgWc+GbcdT1TE4KoGHerpUiSmy6CQo1tAeSFDOuPHPo=; b=BkyOsUQMzg7kWvcyX9gz8s1Ddl
	bfA5kpOBhy0oMbXoVg1til1nex96cIuR6H8SLSRdfnMq6jbDXL8QRkOKOg8oGz549Y1qWT9t9EF8N
	j6xS0Xw2fP1FtYGUMyni1qa3y/McuCvqSRl+ZW5d6dQGncVddnDqCCuEcbBkxK0re9v7sV9rSQyza
	CXswqTuhXQoANk1WSs5qf1czdWS+zAneqZiJsyc6IS7cz3qFIor31WDbRf1dXWqc5MA6VSsvTLUfV
	STaUbbxcfg+1qmqdhi2jb4gAMrnjcoTAZaZvwEBfe/FH3nz4FT0cQnW/1mJX74BSHjfRwshGTOd6S
	UIkuDeGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWl3X-00000004aJf-0VdQ;
	Tue, 09 Jun 2026 01:15:03 +0000
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWl3R-00000004aIv-05If
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 01:15:02 +0000
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-915c36e32abso192460085a.2
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 18:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780967695; x=1781572495; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sgWc+GbcdT1TE4KoGHerpUiSmy6CQo1tAeSFDOuPHPo=;
        b=kbQLkbnbGnKRQhVyknCEztoByOy4WUrxq/g/gpA76Z1WK4xPYcN2a7cCxSEovDhxu7
         mg4PEJKKrhkkhsUX4v4VPhCENWWp/cUPNxtEpJ15zgPqnC4PTQqBtfi7CAg1bM0HJHVQ
         wKqHSlJteWi+ALClGH+NPKAe2j2xbBlvFFiinYAZOBYpSySb3/etzskaj7juigDIzNyp
         qp/jW96Wtm/4GDGH53BAmujyzJsaGZq2sGMIdrS9zETiisHRDmc3Az++G/GfGNTLcYi3
         sHI78Ls/h7PGWZRHxUx0qK3Jfxtk3Wd0tqdNltUzGjo3KHAPyOz0yunH6VTj82P4uEnn
         PURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780967695; x=1781572495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgWc+GbcdT1TE4KoGHerpUiSmy6CQo1tAeSFDOuPHPo=;
        b=NqQ6zPk9EaYfXJiC7nXyBWQRaVCPZBgoRepwD2xq0Bw9/yWbqypLatpbrRgMygEfbb
         N19WHUC7aMXwYW8APaEwdfWhqxDfY2oyyDFRNc0/JylzcLiEUnmf/TGcOwxrORJ7HWeG
         Yfqpd6cQu9prUTx55D3vEfOsGTkZCWDGlG1j6iIOCXxZAsxQGIow2zyUi2zazuh3d60P
         yhIAFDVf5KRJK2ppvsBdHiH9XVHoNr33SaLGWIgplh3xGuxtxIONdVoK6mxcw4eWv+e2
         eV3qtjZDjktTc/I5lWRE+S832Ga0Dxy7CMORKAlYGIML523yKb1qnmF3swizJQTTKfxp
         IFEg==
X-Forwarded-Encrypted: i=1; AFNElJ/G6F9xou/uQXJE+ED6n8bCFVshliB/F5bfozzq8FRKdvTh93Xi3HGYdRNBGcixAFpinqlLtw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6p8a6SGYHMnuBqMszFuJACN1iYL2HfwuD7bCXNRYjF3YvfhGb
	OrrHM3cDtpbVyrFYp6yi2D4grz3Nu/6dxTOTAO9tIGEbiXu9O65AbFn3BPNYmO4GHXI=
X-Gm-Gg: Acq92OH+RFIdlSZ4LOAeYboI3lQgV1EIFkDBatfT3tUhsD4H82IbpEBAlyRcvi9YXf/
	MvlJDjyMHlLb7zXpzY8u+nb4TgDdenCIOSDhuYYBpRzZkLNkleAWZldow/XxnZSKvTp477tynR4
	BJF6D6EkYWWIFjfjNZSBJM3xWE6PfLyfbZyLMx3pERWXK3sRSVdgFxi91Z/pjYmDQIASJjIPojM
	+EcYAxB4CU7CmLNs91wTmlSaDABAbhm+mnLwUYsg7wEEawg36AxZwqCEaE9QOSvh2DzdgOBsDnC
	NNafwfmP6OiqBLVdvtHe3f55H1rmKXGShV+q+q7wPlP6D9iP92bn7wMMVwV1S83eeeqz1hYcwl/
	JAntFIOW9GcIvlUn1J/Cj9fWPcfGMzL1TRxNGoS1gcsTor1yn0X8CNS7gKNgave1vU3KNt7sFZ8
	8UQYw7F1FIiQLGko3hQvO5m4DoLPGz1OO07qxDxqqLChORvCC24W6ecj3LB8ebsg==
X-Received: by 2002:a05:620a:1b8d:b0:914:c0ab:f1ee with SMTP id af79cd13be357-915a9d93f2fmr2862027885a.44.1780967695361;
        Mon, 08 Jun 2026 18:14:55 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a009fe7sm1902384885a.8.2026.06.08.18.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 18:14:54 -0700 (PDT)
Date: Tue, 9 Jun 2026 01:14:53 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, jasonmiu@google.com, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, ran.xiaokai@zte.com.cn, 
	kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
Subject: Re: [RFC v1 0/9] kho: granular compatibility and header decoupling
Message-ID: <aidnjw5pH_z45gJT@plex>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
 <178083348872.1648214.17778188633648887952.b4-review@b4>
 <aiVp5RlbWRz5VnPB@plex>
 <178091437240.1648214.10761111570005003901.b4-reply@b4>
 <aibYJvzQQnpoN6YW@plex>
 <aicF5Sa11B4ujfSa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aicF5Sa11B4ujfSa@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_181457_110581_DE9DE8F1 
X-CRM114-Status: GOOD (  20.86  )
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

On 06-08 21:11, Mike Rapoport wrote:
> On Mon, Jun 08, 2026 at 04:12:56PM +0000, Pasha Tatashin wrote:
> > On 06-08 13:26, Mike Rapoport wrote:
> > > On 2026-06-07 13:43:09+00:00, Pasha Tatashin wrote:
> >
> > Keeping all of that in a single KHO file is the wrong approach and goes 
> > against how other logically separated subsystems in Linux are organized 
> > (e.g., mm/vmap.c, mm/vmalloc.c, etc.). Yes, there are some messier 
> > places in the kernel as well, but keeping this in its own dedicated 
> > kho_vmalloc.c file makes complete sense to me.
> 
> Either I hallucinated or b4 ate a paragraph from my reply ;)
> 
> Regarding the code movement
> - splitting radix tree makes perfect sense to me, just the documentation
>   part needs more care than mechanical move

Agreed. I'll also pay closer attention to the documentation.

> - I'm fine with abi/vmalloc.h, presuming KHOSER_PTR() is not part of it

Yes, I will move KHOSER_PTR() to the shared compat.h in v2 so it's not 
tied to vmalloc.

> - I can live with kho_vmalloc.c although I still consider it unnecessary
>   churn

Appreciate it.

> - I'm against moving vmalloc APIs from kexec_handover.h because they are
>   very close in nature to folio and pages. I don't see core KHO as
>   responsible for preserving physically contiguous ranges but rather as
>   preserving allocations. Not sure we'll ever support kmalloc(), but still.

That is a very reasonable compromise. I am fine with keeping the 
consumer-facing function declarations in kexec_handover.h so they remain 
grouped  with folios and pages.

> > However, overall enforcing the use of KHOSER is unrelated to this work. 
> > I have my own thoughts on this, and perhaps with proper versioning, 
> > using KHOSER_PTR everywhere would be appropriate, but let's keep that as 
> > a separate work.
> 
> This is a separate work, indeed. But regardless of the versioning it's
> already better than plain u64 because it provides type safety.

Agreed.

Thanks!
Pasha

