Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8F8CCFA13
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JQwXlv6d4SrpAwunOCAy3T3SkF7dwQSFYcS5dAIRLRw=; b=EPff8WzXx6QoHvvq8ZMG3ZxTgv
	Il6c8bpe/AvLyUR8XR5zvVmoHztEI8IFHCzXHCILZ/azd3lokLufxH8DbIEdC/hLDICy0t+voczXI
	hUZ+rHJIwldxm7R8EubMRDKiSE1VdiuVgfkmYjRqcF/8faIuJNBSiffYeF/QwOGUmwpek1+K2pC+n
	6+VqSJ81tOUkvIpEHcvIDsChF1TjKloiSu9fJQL6oeWTgpT6g4hwCEHpqsY0vj2XNyFlUtQih49iq
	9Ht0n2Ycplh+rdo0NjCltC8vc8FwQWXuCeXvMyH98blkYaDTBZEpvXoAhDLm/ZlqA0ExSpq19genF
	wg26WeVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI7Y2-00000003tnv-3kK1;
	Wed, 29 Apr 2026 16:14:02 +0000
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI7Y0-00000003tna-05Q0
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 16:14:01 +0000
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-8ef0ba61d46so1009796385a.2
        for <kexec@lists.infradead.org>; Wed, 29 Apr 2026 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777479238; x=1778084038; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JQwXlv6d4SrpAwunOCAy3T3SkF7dwQSFYcS5dAIRLRw=;
        b=M92nvb9LYx53BC9ntMDhQ4WcNe17RlCxcyhH/vupPHRyjRCgDpvv+cwRARUr0V4Z6R
         xITqOM6HAay5vcoSATiu47JP+Lx22AYj8nzediDGAmXYlB4jbAd8t1vpg6gTzPcBR8dt
         w16WPuqleHPdg2GlmV8AeF7PjPsQZ3RRtjzKGWtJEDULMI78dIsPdzJsCSTFt6ujtut1
         O2F8I6EEcrjydd2T2D5Z0atzVWLs2kIHC1eHjUC9gwGcWJnvvjupgg77pZoukAasQdAT
         9dnfPhPU39xCP2enoohpXXpHdeLahig7855jrM6MT2sHust8NkPuV20syYSgzRIqnwKg
         M2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479238; x=1778084038;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQwXlv6d4SrpAwunOCAy3T3SkF7dwQSFYcS5dAIRLRw=;
        b=BrwPYbvbwdY7lmx43nkVmmwyi/Yp+5oD7XBUgqsdOKCJcK0WDeJfdY8Yx0IOU7MGiq
         zu5/zwXAFZXAnzSKdmhUo1okIPIX3U5YGn2iKOa+KO2pWgFU6e/iJdKLDSHmi90DQ5qa
         BdQ3tQ7itjrTQKVM/u+kRtyFNBkHophe8S9Rk63nfIE0TwCx4g50VoqnhrbiB78mcyej
         4IsKqzogJ7bJ6sLB+Usq7B/7Cn5JBOdDKqwkBz7mc6lmZeCx7nlSMxHNVrM2BMdvMIkV
         QdnVGtKgU8MTCUK4xCNfFeMGYMFeoa2u9uXMmM97dsxWlas2LmT+FQUUdEBHzVeTBa5K
         KQxA==
X-Forwarded-Encrypted: i=1; AFNElJ/blyTWMr4kbedewnBW+hu2EpkRW+IhE6Mnt2Ze51wacHwx+zlEgMontLAdoSQV7DM1NrA+yg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzl5mvjZCNVyu99MFSCWISusMFvH3gQ3Uu7YMvOjv1IQAgOGoxE
	w0D0tR9ptUyQ9fb9YAbJ48hOd/42bwXILV8bYac3UCzM/JQxw6UjkNPtZec0yYgPkQg=
X-Gm-Gg: AeBDietln/wQ7YDMUD0u6gbZcVaIdo6v/TVD62wmu2Bjz/1uSqAke/Whe6WVgh9bsiP
	OJK3CBKBAH0H38mThSDGspC+IeUcAdHfQIlZXvNiISE9lyEI5rmEyUrC+mtvsyBV4PbH55ugj21
	5h4yj23Jtj/iErfuE88TdN+eMg1BRETWfXe57TzIdhPaY5qxDR9N7uA4KE416621rrKPVSmc7Gj
	gmSuqPeXPCIkLo14JKJxP8QJ5rVLZWZq5SdMRYVtCSR9HBJpfXNUFeoags0hc2i+lXVng3n1GRI
	pJwhuhRTIN4v+zMtIlVeoGOtDv2rg0UL+vIz4tVVhIbc7U8giVDaDITQty7GnMnWSCPiUsQLhlT
	BB0UOmRh/SbportjAMkH7uXVl9FzJfVbUcR4ZYf1/nclqlx7CNpR7hjD30a5o0HzhZEGXhxZJSY
	WD/DgBCQw7+rAIOtiFZollgbHW9/9ZMhx4ZLRHiGstseE48bJY1PntuQ6uD3kRYhcbk8c0a0Wf
X-Received: by 2002:a05:620a:472b:b0:8cd:9033:172a with SMTP id af79cd13be357-8f8f3a204a5mr643580085a.3.1777479238360;
        Wed, 29 Apr 2026 09:13:58 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93f5826f7sm235640585a.30.2026.04.29.09.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:13:57 -0700 (PDT)
Date: Wed, 29 Apr 2026 16:13:55 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alexander Graf <graf@amazon.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org, kvmarm@lists.linux.dev, rppt@kernel.org, 
	pratyush@kernel.org, pbonzini@redhat.com, seanjc@google.com, maz@kernel.org, 
	oupton@kernel.org, alex.williamson@redhat.com, kevin.tian@intel.com, 
	rientjes@google.com, Tycho.Andersen@amd.com, anthony.yznaga@oracle.com, 
	baolu.lu@linux.intel.com, david@kernel.org, dmatlack@google.com, mheyne@amazon.de, 
	jgowans@amazon.com, jgg@nvidia.com, pankaj.gupta.linux@gmail.com, 
	kpraveen.lkml@gmail.com, vipinsh@google.com, vannapurve@google.com, corbet@lwn.net, 
	loeser@linux.microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, roman.gushchin@linux.dev, 
	akpm@linux-foundation.org, pjt@google.com, "Petrongonas, Evangelos" <epetron@amazon.de>, 
	kpsingh@kernel.org, jackmanb@google.com
Subject: Re: [RFC] proposal: KVM: Orphaned VMs: The Caretaker approach for
 Live Update
Message-ID: <afIru_PE3W0hIsu7@plex>
References: <afEwWZksU0Fw61oT@plex>
 <b52e7d0a-4275-48a0-850f-6ceccfd5204e@amazon.com>
 <cd0ae5795cf14a7b20c90840b0a3eba7db160e72.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd0ae5795cf14a7b20c90840b0a3eba7db160e72.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_091400_071322_929AA261 
X-CRM114-Status: GOOD (  20.09  )
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

On 04-29 09:40, David Woodhouse wrote:
> On Wed, 2026-04-29 at 10:13 +0200, Alexander Graf wrote:
> > I would prefer we only attach the whole caretaker and all of its 
> > specialties right around the point when live update happens. Why keep it 
> > dangling and active forever? That way you can also late load the kernel 
> > module that contains it, so you can be sure it's an up to date version.
> 
> "Why keep it dangling and active forever?"
> 
> I've always wanted to tie this to address space isolation.
> 
> The only way to truly stay in front of the constant stream of new
> speculation vulnerabilities has been to just make sure there's nothing
> sensitive accessible in the address space at all. Hence all the work on
> secret hiding, XPFO, proclocal, etc. — and hence the occasional
> researcher finding their shiny new (5-year-old) vulnerability and being
> confused when it doesn't leak anything *interesting* in certain
> environments.
> 
> I'd like to see the inner KVM_RUN loop switch to a completely separate
> address space, in which there's a kind of caretaker which can handle
> the bare minimum of interrupts and timers and the most common exits,
> and which *relatively* rarely has to come back into the real Linux
> address space.
> 
> And once you have that caretaker running in its own address space...
> why not just let it keep going while Linux does its kexec?

Yep, this captures one of the benefits of having a permanently attached
Caretaker.

By establishing that isolated execution environment for the inner
KVM_RUN loop to mitigate speculation vulnerabilities, we naturally get
the hardware-enforced boundary required to survive the kexec gap. The
Live Update capability is effectively a byproduct of achieving true
Address Space Isolation.

+CC KP and Brendan

