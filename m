Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C37FF8864
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 03:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AGHQZIIr7JtLFpAcwzlVPtO345HWtqACErkZP29Clnw=; b=TE8c1/RDXZYTl9Yf0G1R//HDYv
	2xIpLZwclomvmWzlmqEKspozRAEaeDtnAe/5D/gbpsBUuPNxf4kNGhmwKvR0niWRWFS6jpNM2N/Nc
	mAK2Km3DEo8R4e5RsH/kS2PNmou2RqFgBWJNBdjSJqgBTnyGBKOcnT6Etg0VgiJyz3giYlcsVkXwb
	Z45Lwf41YgcN7SZ/G/9SOey9R0tHZLVzQEZvQGFmZPEaY+W0OhfdX6FBLMj1qLuUcKzYOGObLLLfp
	ivtaGll4BFRP4FCJHfN0oj7Mnzbui61Nze8C0fc/NSdNjXbmwaRf+9ikFhG/SQ134xMplPdIM63EQ
	ah8DggSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIecN-00000006IFz-3jZi;
	Fri, 01 May 2026 03:32:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIecL-00000006IFV-1HY3
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 03:32:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777606359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AGHQZIIr7JtLFpAcwzlVPtO345HWtqACErkZP29Clnw=;
	b=JvJPH3kdkPKez+CRJP4i3GuqlAaObgcdJGR713NuOyKrOY6XDWgjzurQ8pwRiP/4oviKSh
	2L2fY09+v/XGgEJXzvdP76zvChhV/Bfd6S45oC1u5pXJidvABO5WsFK48ZENTGnGiB3X41
	WOHRqi1LDSam3c2DJ0o2SvjlRj1YeTY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-JLdQnSEhO5WXLV2G9iAbOQ-1; Thu,
 30 Apr 2026 23:32:33 -0400
X-MC-Unique: JLdQnSEhO5WXLV2G9iAbOQ-1
X-Mimecast-MFC-AGG-ID: JLdQnSEhO5WXLV2G9iAbOQ_1777606348
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C9CA1800347;
	Fri,  1 May 2026 03:32:26 +0000 (UTC)
Received: from [10.44.48.3] (unknown [10.44.48.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 06CE71955D84;
	Fri,  1 May 2026 03:32:13 +0000 (UTC)
Message-ID: <3ff53353-3842-4a63-80a1-90a60d09fe02@redhat.com>
Date: Fri, 1 May 2026 05:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] proposal: KVM: Orphaned VMs: The Caretaker approach for
 Live Update
To: David Woodhouse <dwmw2@infradead.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 kvmarm@lists.linux.dev
Cc: rppt@kernel.org, graf@amazon.com, pratyush@kernel.org, seanjc@google.com,
 maz@kernel.org, oupton@kernel.org, alex.williamson@redhat.com,
 kevin.tian@intel.com, rientjes@google.com, Tycho.Andersen@amd.com,
 anthony.yznaga@oracle.com, baolu.lu@linux.intel.com, david@kernel.org,
 dmatlack@google.com, mheyne@amazon.de, jgowans@amazon.com, jgg@nvidia.com,
 pankaj.gupta.linux@gmail.com, kpraveen.lkml@gmail.com, vipinsh@google.com,
 vannapurve@google.com, corbet@lwn.net, loeser@linux.microsoft.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 roman.gushchin@linux.dev, akpm@linux-foundation.org, pjt@google.com
References: <afEwWZksU0Fw61oT@plex>
 <0a71472c-b397-4699-a518-61faffcf4ab2@redhat.com>
 <c004f333ed4f7dedae1383f22d43b009cd83837e.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <c004f333ed4f7dedae1383f22d43b009cd83837e.camel@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: lAUQZFxz_5zGHrouuMl_XHIv7WsKvTG0lgGL0ucVj-g_1777606348
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_203241_447823_E974978F 
X-CRM114-Status: GOOD (  22.18  )
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

On 4/30/26 17:27, David Woodhouse wrote:
> On Thu, 2026-04-30 at 15:28 +0200, Paolo Bonzini wrote:
>> I even wonder if, for long term simplicity, the interface for
>> host->caretaker should be just for the caretaker to swallow the host
>> into non-root mode, again as in Arm nVHE.
> 
> There's a lot of merit in that approach.
> 
> I talked about wanting to use this 'caretaker' for secret hiding.  But
> why have *voluntary* secret hiding with the kernel hiding things from
> its own address space, when you have have *mandatory* secret hiding
> with something running in EL2, like pKVM.

Well, other than because it's a lot of work? :)

> Honestly, I don't see the *caretaker* being much of an ABI at all,
> except from one kernel to the next.

I agree.

> The *userspace* ABI considerations are all about how you make a vCPU
> that runs asynchronously (should it conceptually just be an async
> KVM_RUN call, which allows the vCPU to run in a kernel thread up to the
> point of kexec? Why is it fundamentally tied to kexec at all?).

It's not tied to kexec.  kexec is just forcing a handoff + forcing an 
update.

The big difference is that:

1) if you don't tie it to kexec, a detached vCPU thread is a struct 
vhost_task and a blocking vmexit schedules out the thread; while during 
kexec you have s/kthread/pCPU/ and halting the CPU instead of scheduling 
it out.

2) if you don't tie it to kexec, address space isolation is the only 
real reason for the complication of treating the caretaker as a separate 
bare metal program.  OTOH maybe that's a feature - you could do:

- ioctl(KVM_RUN_ASYNC)

- then vmfd/vcpufd handoff to a new mm on top

- then address space isolation on top

- then kexec (de)serialization on top

> I'd love to start without kexec in the picture at all. Just show me the
> KVM API for starting a *confidential* guest (pKVM, SEV-SNP, whatever),
> leaving it running, completely stopping the VMM and then starting a new
> VMM to pick up from where it left off.

Why confidential?

Paolo


