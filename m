Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22283CD3424
	for <kexec@archiver.kernel.org>; Sun,  3 May 2026 16:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wZAX/3Dxul6ab0aa4nY+5/E1aKies+ngH//pLM2CQH8=; b=nK2Kehh6A8x2D9n3JClehPWWwt
	U3Pt7jDLvMsi2AsJkeYI1NZkXtMPaaJBWtAPycEQpFVjJODFsFuVtuQMpzWenRJ0photB8FQSB93O
	aOKcJb30hlyH+4wo6esRf35yrLQ+n2QBh6iJiZfFFQ1YEcjU8RL4j/+IuJTOT5T6Q97GJ89SVAH9G
	HxmYFFGpuYKUJnEmJH6PSlqdmmlr4Yw71HeTcVTciDWVjyI8GLnzeKtvNCfkmrmk6D7q2hghkLpQS
	hTyToFPD3+Y6kAX1e52739Usyr91X9kQXgsYN3fPClNSi4hMWsZ6WFHojjtR895BxsOtPf0GR9mHf
	5oiVXtqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJa8H-0000000BLqf-3YNH;
	Sun, 03 May 2026 16:57:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJa8E-0000000BLpv-3hn9
	for kexec@lists.infradead.org;
	Sun, 03 May 2026 16:57:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777827444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZAX/3Dxul6ab0aa4nY+5/E1aKies+ngH//pLM2CQH8=;
	b=HrOOxq8tF3LrU5aGvNUK9dKf9ad3dP3gSZ7Q99zWieaLpHGNG06UIh+La/MiawEi2iAabb
	XrtCvgTfLR4UJUGdJgBQ58Cy9EgIV9lgzolECw6zsmIPlGi0GYlUhq/8l8/jJQVRAhmZCX
	6kM5vEBRGvo9GWLtiJXznuFaaCXxuHE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-ymo_nBH4P_Sbi26PpUhcyA-1; Sun, 03 May 2026 12:57:20 -0400
X-MC-Unique: ymo_nBH4P_Sbi26PpUhcyA-1
X-Mimecast-MFC-AGG-ID: ymo_nBH4P_Sbi26PpUhcyA_1777827439
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso38442165e9.1
        for <kexec@lists.infradead.org>; Sun, 03 May 2026 09:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777827439; x=1778432239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wZAX/3Dxul6ab0aa4nY+5/E1aKies+ngH//pLM2CQH8=;
        b=P+F5plRduttXSnvFVoqWb15NzmMfFNNG3Eo4UNEhlHRqYNWj3/cnhi0ASkPHKcA5QD
         0tuY3olkuh2tDw4Jph6X1uQeFYlUxU4aYc/7/7MLajfcMVanWZHVMKr52hfw+MbFDQDV
         4k6qQINZuWHqgoHUWYqs2yDGOTUDbSIVtB8asTlfDuNDuJD/HA5dfRTLb1dAuXCalFBm
         D0WZHta4H9ratS4ucb32JrClQKqOrHloXqltd0C1sigX/IiYP/xKcYu7RlOsJMXQZDsg
         BSoK+UtzmsGnq1dpe2B5E3a8FQwmw+Caloeu8Oum2kEPNdV/fiYSU3VEgbT5jNCZOQeK
         97Qw==
X-Forwarded-Encrypted: i=1; AFNElJ/GeovDAFxkcEizm0ruIDg5bK+p1c6zBc8epSQhxv4o+ONV3FxovntWUkDx4R5SaC9NlPR02g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxtzizLUPJj5if6Ou/7/dKJgu3ikQLS3taopaCvPIP+JeayLhF+
	MQtvo+t4wXwgVzO76jYnQeFqJW8CLrggAJ1vR2BMNPcfOYz8hGsfWx2KhJRh3n9ymSbTg0477em
	TVQHB3Ag0IbOqYrtJRXbX150sKE7oMfbOrwg60kXUR+m93g+DYsZBST7OFyoFY69aByOpuZ5Eyt
	LqRzCwGBb9PdA48IKzCBnF1cfNsJOy0KgE2qSp
X-Gm-Gg: AeBDieubRzkkd5G5q/TCHPCb+ZlmtvZIOL7dVMddl3Z6mZ6sD7fksy61+macLboPm9o
	/2lYkQUTd+Mcj36MJVz4lyTlw5hrx9zn+iiUpA16IV0i/OmN7NC2SFfa3mKWJlGMRuKX8YUW/ea
	dFTYAvCNCmZLfuL/TLDKMXd9AHmlbDQzHL9aEMFsjwXZKjnjIGmZVtksXY8/1lfkTY1nGukpnql
	M6+4tRZuYhunsJmgmGGXI7sYLttymqlAf7SpPHETmbJ36G+opPxGBbnVaeQX3A22vEukQyjAljo
	ahKEnRo2mO3E+Rs=
X-Received: by 2002:a05:600c:c0c5:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48a98662e71mr84651795e9.21.1777827438750;
        Sun, 03 May 2026 09:57:18 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c5:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-48a98662e71mr84651295e9.21.1777827438361; Sun, 03 May 2026
 09:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <afEwWZksU0Fw61oT@plex> <0a71472c-b397-4699-a518-61faffcf4ab2@redhat.com>
 <afUNlL_lRDP6olHE@plex>
In-Reply-To: <afUNlL_lRDP6olHE@plex>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 3 May 2026 18:57:06 +0200
X-Gm-Features: AVHnY4LZ9SLOVvMSSNVqrWN2ReqSfwRcQuKsaciqQRZIlDN_XSMAX0q55GthIJg
Message-ID: <CABgObfaqZ8GGaLV_gp8o+nQSe+JfnBbZP0X9cDxdvEpyUZQRnQ@mail.gmail.com>
Subject: Re: [RFC] proposal: KVM: Orphaned VMs: The Caretaker approach for
 Live Update
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	rppt@kernel.org, graf@amazon.com, pratyush@kernel.org, seanjc@google.com, 
	maz@kernel.org, oupton@kernel.org, dwmw2@infradead.org, 
	alex.williamson@redhat.com, kevin.tian@intel.com, rientjes@google.com, 
	Tycho.Andersen@amd.com, anthony.yznaga@oracle.com, baolu.lu@linux.intel.com, 
	david@kernel.org, dmatlack@google.com, mheyne@amazon.de, jgowans@amazon.com, 
	jgg@nvidia.com, pankaj.gupta.linux@gmail.com, kpraveen.lkml@gmail.com, 
	vipinsh@google.com, vannapurve@google.com, corbet@lwn.net, 
	loeser@linux.microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	roman.gushchin@linux.dev, akpm@linux-foundation.org, pjt@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MfSpjlJn57ivepMrTNIZAKzcGkkBci3_vyFbD4UDyBo_1777827439
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260503_095727_015983_6310D75C 
X-CRM114-Status: GOOD (  30.57  )
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

On Fri, May 1, 2026 at 11:48=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
> The way I see it, vmfd and vcpufd need to support LUO preservation by
> implementing the liveupdate_file_ops callbacks (.preserve, .restore).
>
> When userspace preserves the vcpufd, the kernel isolates the assigned
> pCPU (probably requiring the vCPU to be pinned to the CPU, and the CPU
> to be in an isolated cpuset),

Generally speaking vCPUs do not care if they are pinned. Do we need a
preparatory ioctl for this on the vcpufd side, even just a
KVM_ENABLE_CAP or a new bit for
KVM_ENABLE_CAP(KVM_CAP_X86_DISABLE_EXITS)?  If
LIVEUPDATE_SESSION_PRESERVE_FD suddenly can start offlining pCPUs,
that would require a capability check.

> Even for this simplest form, we still need a defined ABI between the
> host kernel and the Caretaker. The host must send an IPI to
> synchronously notify the Caretaker of attach and detach transitions.

Yes, but it's unlikely to need stability unlike the KHO serialization.

> This ABI must also handle Caretaker replacement during the adoption
> phase: when the new kernel retrieves the vCPU, it requires a protocol to
> notify the running Caretaker that the pCPU is being onlined. The
> Caretaker must reach a known, state at that moment so the kernel can
> seamlessly replace the previous kernel's Caretaker version with the
> current one. Finally, the Caretaker still relies on the CCB to access
> KVM routing pointers for forwarding VM exits back to the host during
> normal operation.

I'm not sure if routing pointers are needed, as opposed to just a
call/ret (ignoring detachment and reattachment which are different
anyway). In the end, the x86 caretaker is basically the
non-preemptable part of vcpu_enter_guest(). Even once you add
attach/detach, the body of code that runs in the caretaker is roughly
the same and what changes is setting up the address space, the IDT,
etc.

> > This must be done atomically at the time Linux offlines/onlines a pCPU.=
 The
> > interface from Linux to the caretaker must use some kind of IPI so that=
 the
> > new kernel can force a VMEXIT (if needed) in the caretaker, ask it to
> > serialize the vm state, and pass it down to the new kernel's caretaker.
>
> Yes, agree.

BTW, the same IPI is needed to force a VMEXIT even before kexec, if
the old kernel does anything that breaks the running VM such as
madvise(MADV_FREE).  Should not happen with properly behaving
userspace, but it must be accounted for.

> During the kexec gap (when the host kernel is completely offline), the
> Caretaker acts purely as a producer, writing trace events directly to
> this physical memory block and advancing the ring buffer pointers.
>
> When the new kernel boots and re-adopts the orphaned vCPU, it retrieves
> this memory from KHO and attaches it back to the tracing subsystem.

Yes, this should work with remote trace buffers.

> I agree regarding HLT: during the gap, the simplest approach is to just
> skip the exit and return directly to the VM without attempting to handle
> it.

Or even disable intercepts for HLT/PAUSE/MONITOR/MWAIT.

> I completely agree that the transition into and out of the gap must be
> synchronous. As discussed above, using an IPI is the right approach. For
> entry, the host kernel signals the Caretaker via IPI to ensure it
> reaches a known state before the pCPU is offlined.

And then does INIT/SIPI on the offlined pCPU to re-enter the caretaker
in detached mode.

> For exit, the new
> kernel sends an IPI to the orphaned pCPU to force a VM exit, allowing
> the new kernel to take control, update the Caretaker environment,
> and complete the reattachment.

> > Yeah, I think APIC emulation to some extent must be moved into the VMX/=
SVM
> > fastpaths.  The good news is that this can be done already as a PoC wit=
hout
> > needing the whole caretaker and LUO infrastructure.
>
> Moving APIC emulation into the VMX/SVM fastpaths makes sense as a
> standalone effort.

Yup, that's nice to have.

Thanks for the detailed reply, I limited mine to where I wanted your
input as the author of LUO - especially with respect to privilege
separation.

Paolo


