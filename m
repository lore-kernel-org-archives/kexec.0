Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A60ACD3423
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 22:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZngdolWCwMllVgRY4Z72RBKMe/hCThaUf6aiHf3a+Hc=; b=VNkt6vy7p2DyBHuYW8/Zia9Ynx
	cXARN/BDoO+5it8mm/CkSBB90CFTf+xiV5RkQkanLNWF/v1Tv5jS6I81HI8vDMzQTsIC3Z/44b5Iu
	FdIGsYFUspZUzOIc7Bpj/V82zaiiikmJDpmEYuymjI8NhsZkNXXrGkH5qrVMDlf0eHQTfeYm6WlsN
	5BLkU1DRCKIsyHj+EixP8P6bUKjgHaf7g7QLqbOqqWzU6166B/2KIuj1Je96MddcTZkJ5aBTyVmEH
	h8ImqNndVjHTdh+eRQJvlvE6tGyf9uhfleoc5VogjpVnCQ3beJ01ai5X+3ZmCPt6hj59ixgYCul0L
	dR39DeLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIw18-00000007kAN-3MDS;
	Fri, 01 May 2026 22:07:26 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIw16-00000007k9u-2gqr
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 22:07:25 +0000
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-8ef45a6d9dfso258930485a.0
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777673243; x=1778278043; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZngdolWCwMllVgRY4Z72RBKMe/hCThaUf6aiHf3a+Hc=;
        b=W1v7eKjRNolcvPMmtP8zH+Oz/XXA+Fu7cg7ClN0FGh0txk9t4Mzh1lV4+Qe2dPE4Wq
         ohiA08yaPqfLJRRZB9dWE8rP4BHYQWAzlGYJ2b7Rzjuy7sTI8XK05weFd1QVCB9TzstK
         VBhiJoM+ZRn6SXlwaFM1ajAt8WLIXuey2E1UViYP66HnSoKccuTjQiOzBo0UZjNF0BUM
         siveZb3ixkLAZWrX+PTyXn/GwdnLLr+MZZPgiIpJR9JbFXE7gv7TRXK/RelG7rXN1KT1
         4Y95hav8KaLHMHZIOv1jno1RK0YDosV8Hq5BWdj3+GpPgdIgrb2egGQA1yOxxbMDcSQf
         h2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777673243; x=1778278043;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZngdolWCwMllVgRY4Z72RBKMe/hCThaUf6aiHf3a+Hc=;
        b=hJwNG/sYcF5LIgUaknRuEdPh9Zda1jYHg83aaX4QhkzYPLSLzkJi23CH6nkbyCgoYW
         z0FxvPyAoSttFq21Nhs3xYJMfNpe7vQCjeFe9cPEdGpVD85H0ZUPZds5gTo+WZvbfXwk
         QeB3/5e6cC0+G0kEzmpBUYnE5bKROZwiqNP1MtyoHwCAzOU2rmzLPPONX0UTc8KiR7nF
         jGt3ghB+XrbHTbV8jPPkPrutuKzddrireZ3pSN+RTMngnKYysoBOaarhvUzULZzc4x6D
         jkpHliwVyDfLK52zMEr6lsGrLmeaSg4KOx+P00Om6nHixEnmB7tyysOYDX3tb6RsRiGC
         wTHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/FAoo5zruql9hyc2azITaZpcS6GLPFMzEkfbaKKHle9hSIs8F075arf5pBK7OtpMy3KnLVMA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyql8W118YIADWdixuGKq/TJgm8fatRxLkbiSgoUMJIftu2twVW
	UMPKTxcrYPEZS+2jk5tkWfLWjkPo5HvnXsVaGymi5fPf9338eHxO2zKs7CjFRjxKz/Y=
X-Gm-Gg: AeBDiet1fJbDHPkXp87OE3BL+OUtMM5d98hymo6N+h9njfplkwuEhoCS0vury7PUVkt
	XgZ/AaiTepQqSGS56wd0ORDglWpnZFSBzzRetfxMv7rSG7ywCqersd9WMb9AadSXcUyQKouxn+s
	1yULmbCa2uKm2kU9bJ1oTNsKYmSpY6pJNTe8ra01DxZuMtIVhstORMHi2n47tygGlkk5badzXUq
	NbLXWCFdeySzaySnpTGOZAVqagjC4aHquyfs64urbWrFdNq0Rlf7V8xImUzMcWB7hmjYhn6HKCY
	+KWRThFWHrKGtWhuzYRFFnegSV+3/VsHasdjJSpx98LeMV/mqDQWeUKjpjoZBW1uVwp5T/zQLdH
	bGdZKbRRGVMt0Rfc6poI65o+hD2HgHGaVfr0y/6kNpW/lmYJZrzNVh2W8IgwlSMfKK8/ndFDRIl
	opp+KZf9hmZdFpE1ZzEExJsABtRf5JZHG+noVVsWkyHaC6OkvhnG1WjOqBoDBhCA==
X-Received: by 2002:a05:620a:454a:b0:8ee:18e7:9406 with SMTP id af79cd13be357-8fd17867649mr205532585a.29.1777673243076;
        Fri, 01 May 2026 15:07:23 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29a80784sm280411885a.12.2026.05.01.15.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 15:07:22 -0700 (PDT)
Date: Fri, 1 May 2026 22:07:20 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org, kvmarm@lists.linux.dev, rppt@kernel.org, 
	graf@amazon.com, pratyush@kernel.org, seanjc@google.com, maz@kernel.org, 
	oupton@kernel.org, alex.williamson@redhat.com, kevin.tian@intel.com, 
	rientjes@google.com, Tycho.Andersen@amd.com, anthony.yznaga@oracle.com, 
	baolu.lu@linux.intel.com, david@kernel.org, dmatlack@google.com, mheyne@amazon.de, 
	jgowans@amazon.com, jgg@nvidia.com, pankaj.gupta.linux@gmail.com, 
	kpraveen.lkml@gmail.com, vipinsh@google.com, vannapurve@google.com, corbet@lwn.net, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, roman.gushchin@linux.dev, 
	akpm@linux-foundation.org, pjt@google.com
Subject: Re: [RFC] proposal: KVM: Orphaned VMs: The Caretaker approach for
 Live Update
Message-ID: <afUf7d3Zg2pBCfxs@plex>
References: <afEwWZksU0Fw61oT@plex>
 <0a71472c-b397-4699-a518-61faffcf4ab2@redhat.com>
 <c004f333ed4f7dedae1383f22d43b009cd83837e.camel@infradead.org>
 <3ff53353-3842-4a63-80a1-90a60d09fe02@redhat.com>
 <718a82870c8f3c913791f12a993e11b2d26d08d9.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <718a82870c8f3c913791f12a993e11b2d26d08d9.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_150724_727828_9847FDD9 
X-CRM114-Status: GOOD (  51.50  )
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

On 05-01 09:56, David Woodhouse wrote:
> On Fri, 2026-05-01 at 05:32 +0200, Paolo Bonzini wrote:
> > On 4/30/26 17:27, David Woodhouse wrote:
> > > On Thu, 2026-04-30 at 15:28 +0200, Paolo Bonzini wrote:
> > > > I even wonder if, for long term simplicity, the interface for
> > > > host->caretaker should be just for the caretaker to swallow the host
> > > > into non-root mode, again as in Arm nVHE.
> > > 
> > > There's a lot of merit in that approach.
> > > 
> > > I talked about wanting to use this 'caretaker' for secret hiding.  But
> > > why have *voluntary* secret hiding with the kernel hiding things from
> > > its own address space, when you have have *mandatory* secret hiding
> > > with something running in EL2, like pKVM.
> > 
> > Well, other than because it's a lot of work? :)
> 
> If we avoided those things then we've never have any fun!
> 
> And in a week where there seems to be a new user-to-root exploit posted
> every day, the 'deprivilege the VMM and assume the guest has owned it'
> security model is looking rather scary. So the additional defence in
> depth of knowing that even *root* can't get the kernel to access other
> guests' memory might be the only thing that lets you sleep at night :)
> 
> Yes, it's a lot of work. But I think we've reached the point where
> mandatory secret hiding is... well... mandatory.
> 
> > > The *userspace* ABI considerations are all about how you make a vCPU
> > > that runs asynchronously (should it conceptually just be an async
> > > KVM_RUN call, which allows the vCPU to run in a kernel thread up to the
> > > point of kexec? Why is it fundamentally tied to kexec at all?).
> > 
> > It's not tied to kexec.  kexec is just forcing a handoff + forcing an
> > update.
> > 
> > The big difference is that:
> > 
> > 1) if you don't tie it to kexec, a detached vCPU thread is a struct 
> > vhost_task and a blocking vmexit schedules out the thread; while during 
> > kexec you have s/kthread/pCPU/ and halting the CPU instead of scheduling 
> > it out.
> 
> For now maybe. But "how does the caretaker do scheduling" is on
> definitely the list of future problems, for any environment where a
> physical host with N pCPUs is hosting >= N vCPUs.
> 
> (In the case of a true mandatory-secret-hiding caretaker at EL2, the
> scheduling part *could* be done by the residual purgatory-caretaker-
> thing at EL1 that all the secondary CPUs go to instead of being turned
> off. It would just be calling into EL2 to run the actual vCPUs. Thus
> leaving the EL2 code just to do its *one* job, which has the added
> benefit that the automated reasoning people put the knives down and no
> longer have that look in their eyes that they got when they thought you
> wanted to put a scheduler in their formally-proven EL2 code...)

For the initial PoC, however, we will bypass the scheduling problem 
entirely by enforcing a 1:1 mapping of active vCPUs to isolated pCPUs. 
If a system is overcommitted, we can either pin some vCPUs, or simply be 
suspend the across the kexec gap and wait for the new kernel's scheduler 
to resume them, i.e. the same as what we have now without Orphaned VM 
support.

> > 2) if you don't tie it to kexec, address space isolation is the only 
> > real reason for the complication of treating the caretaker as a separate 
> > bare metal program.  OTOH maybe that's a feature - you could do:
> > 
> > - ioctl(KVM_RUN_ASYNC)
> > 
> > - then vmfd/vcpufd handoff to a new mm on top
> 
> This much gives you a seamless upgrade of the userspace VMM without
> having to play fd-handover tricks. The old VMM detaches, the new one
> attaches. If you're quick, and the guests aren't doing much "admin"
> work but only passing traffic through passthrough PCI devices, the
> guests might not experience any non-negligible steal time at all.

I agree. During development, we should maintain a workflow that is 
functionally identical to the kexec transition. Even without a kernel 
reboot, the process should be: preserve resources via LUO, isolate and 
offline the pCPU, launch the new VMM, and then retrieve the resources to 
online the pCPU and re-adopt the vCPU.

> 
> > - then address space isolation on top
> 
> Even voluntary secret hiding lets you sleep at night when the next
> Retbleed happens.
> 
> > - then kexec (de)serialization on top
> 
> ... and this one is the holy grail.
> 
> So yes, that's exactly the kind of thing I was thinking, rather than
> trying to boil the ocean. There are sensible milestones along the way
> which give practical benefits.
> 
> But my point was *also* about understanding the actual userspace
> interface for this, even if we were to just focus on the live update
> and do it all in one amphetamine-and-tokens-fueled epic. What does it
> even look like, from the VMM point of view? How does the new VMM under
> the new kernel 'reattach' to the existing vCPUs?
> 
> I think we need the userspace API concepts for 'detach' and 'attach',
> including the permissions model for reattach, and we might as well
> implement and test them without the kexec in the middle to start with.

From the VMM point of view, the interface would follow the standard Live 
Update Orchestrator flow for file descriptor preservation. This is 
the same mechanism used to preserve and restore resources like vfiofd, 
iommufd, and memfd across a transition.

> 
> > > I'd love to start without kexec in the picture at all. Just show me the
> > > KVM API for starting a *confidential* guest (pKVM, SEV-SNP, whatever),
> > > leaving it running, completely stopping the VMM and then starting a new
> > > VMM to pick up from where it left off.
> > 
> > Why confidential?
> 
> Mostly so that confidential VMs aren't an *afterthought*, and the
> design of the detach/attach userspace ABI gets them right from the
> start.



