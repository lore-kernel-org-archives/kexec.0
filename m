Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB16DECE57E
	for <kexec@archiver.kernel.org>; Mon,  9 Sep 2024 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MXeDBktVheJ8VftbpJVUYOSSRkdXcc6Gyp7JoP/EIRI=; b=bpvCAJ990PmvV4
	hXKWnXZ7Vq+qJj9JToEyEFyxuXjRntzctUIg4C9yggYADtqL8RlBIoPcmTqg1XhbqLbbT4Q1/uB/I
	trk4a2jP6cN5jiwFt9lhUB9O6pLa72og/9C+myO/Xw1ASSArJY1URFu9uRa1YRvfPZAcKNyE41sCu
	4M7B6uBHReI384KSDxsvc0kahtrMoYf2u8cCC+QFAZIlMSBaQqj6MsvaxaqrDsczo7UxhO6hocMkm
	nYIiyL0wYRCslZgk+cnpFnOYPFK84sWz12MX+C9dkH1SFlHR9iln+F3XaqwBrosG74rxcu2M8N8RE
	Si4+OL/OCLoCj8CLpG3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snfVu-00000002JU6-0Io8;
	Mon, 09 Sep 2024 14:37:10 +0000
Received: from fout8-smtp.messagingengine.com ([103.168.172.151])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snfVq-00000002JS4-3LSS
	for kexec@lists.infradead.org;
	Mon, 09 Sep 2024 14:37:08 +0000
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E7B021380225;
	Mon,  9 Sep 2024 10:37:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 09 Sep 2024 10:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1725892624; x=1725979024; bh=PGrDzIuNXk
	woLQBLlTew5GzRcdRT4GoGBHO02S2JrMQ=; b=T9Hx3nvMWNPCQfObLPaWaI38HZ
	+aP3Q4zf4fbDUxTz6uTG6Qe/57tEB2PTVRDdG1nKgmpCsEqqZwHOBNifN4t77ILU
	Q2ILBmbeQC3NFF/SzHj9ysDFoHvAGfJP6haI4tYfdGE2M9rf9k+7oUJpywgbXZ6c
	QxA8qZ3RuMMGtpasZtsrQn87Wrfhb67CvDPfy0VTel1/7SbHa16byIxcDz89M5nV
	ElayrfOXBupJdqPumfmk1BjOunJAKLgouNTzCwY0bNuhO/kw3Ew7QQB+jH0G1oo9
	GRzx1dVl/oI4lPar5TMsWoH1Sbjqnqah4Ppl864J6VdZF5ETa9hYlPmYUTYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725892624; x=1725979024; bh=PGrDzIuNXkwoLQBLlTew5GzRcdRT
	4GoGBHO02S2JrMQ=; b=RW8vWb3ZaHIA3fiGtT7ZQlN9G7OiV088/vl2GUrX6iQ/
	+Yt9FrgjqxVnzpL1Bqjq1MpLl6PoZVkggAVeSGEH+ls8WEo9xqEUE7C97KH51cpm
	txsiD1OZWq9mgo8SN40QDeTgJyweJTlIVr4G89GzUGxaRfGjoSYhDNhDv7NKx63/
	fDI/++cD1vVPL2a+WbEYL97lMTSRtOFBn7KkgvMCvYBuWOVofd5SgSV+zqtiLWc/
	bb8jXgxiSTLg4b7UKnYSsMRXvO8pKLn89dbIztyVfSTtRzxEznXcN7cKEzbfg+Mx
	6y63U9QZUj4t/xn+8FCuUjyVkv4l2ATo8rURgio++w==
X-ME-Sender: <xms:EAjfZrCCl4_WhXRdrgldCI1wLMnSX4tjrhdmuNJG8q0YpYwopK2rBw>
    <xme:EAjfZhjhIqX3l7xY4XXMlnUYO2CdKLlYEnJfKtXdhOvjIXzona-LMGzpBnOBvdzut
    v-gydIuOuZXuZapZVU>
X-ME-Received: <xmr:EAjfZmm_le99CTZgubDZnLb78-aocXsV8Y1hzMtGOqo37RVjGA-AEnhBjvtUpnmdxn6077V-2LK0RIyjd04520ynE0D3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdludehmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrghrrh
    cuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeehgeefffej
    veeuleekueeguefftdefhefgtedtieeghefhtefgiefhiefhtdetheenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepkhgvrhhnvghlsehjfhgrrhhrrdgttgdpnhgspghrtghpthhtohepud
    egpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrrhgusgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhruhguohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmh
    iigihrvggrrhihsedtphhoihhnthgvrhdruggvpdhrtghpthhtohepphhilhhiuhesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtohepjhgrrhhkkhhosehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghpthhtohep
    sghhvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepugihohhunhhgsehrvgguhhgrth
    drtghomhdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomh
X-ME-Proxy: <xmx:EAjfZtxBalTnTYZ2K8z8QH2obb7nzUdaxyh7XrIFgFqL2Vxub8_NMg>
    <xmx:EAjfZgR3fSN9YiZSvXsdumgu2vrENc2sy48uBo7apyxAfkRalXUVVA>
    <xmx:EAjfZgbh74UmtvdNxqEpORIHgOBChrPowf3QAhWs0bwrkhIIdFFG_g>
    <xmx:EAjfZhTFc6PRJ2L_2MHK-7W5UK_lbS5MpwgjAop9CpHZUYXhCzvLQQ>
    <xmx:EAjfZsoIVMkwy5q97bklK5eN1eQMHyFpPLJmFhsLcVLGALNhex6XCndc>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 10:37:02 -0400 (EDT)
Date: Mon, 9 Sep 2024 16:37:01 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Pingfan Liu <piliu@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <Zt8IDVMhUw7aAejR@archlinux>
References: <20240819145417.23367-1-piliu@redhat.com>
 <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen>
 <Zt7EbvWjF9WPCYfn@gardel-login>
 <Zt7RJepoCiCMRZSu@archlinux>
 <20240909154940.7ab93782@rotkaeppchen>
 <CAMj1kXHN5NgUJ+wwaZxsKeT4bDHqO6C2CHaALAi7JV5hWVmR2A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXHN5NgUJ+wwaZxsKeT4bDHqO6C2CHaALAi7JV5hWVmR2A@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_073707_079588_192FB0F3 
X-CRM114-Status: GOOD (  29.61  )
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

On 09 16:04:50, Ard Biesheuvel wrote:
> 
> [...]
>
> kdump has a kexec kernel 'standby' to launch when the kernel panics.
> So for the UKI/EFI payload case, this would imply that the load
> involves running the payload until EBS() and freezing the state.
> 
> Whether execution occurs in true user space or in a deprivileged
> kernel context is an implementation detail, imho. We don't want to run
> external code in privileged mode inside the kernel in any case, as
> this would violate lockdown already. But it should be feasible to have
> a EFI compatible layer in the kernel that invokes the EFI entrypoint
> of an image in a way that protects the host kernel. This could be user
> mode on the CPU or perhaps a minimal KVM virtual machine.

This solution is what I'm currently in favor of (besides my original
approach), see: https://lore.kernel.org/kexec/Zt7EbvWjF9WPCYfn@gardel-login/T/#md4f02b7cb6c694cb28aa8d36fe47a02bd4dc17a4

From the perspective of supporting UKIs the EFI compatibility layer
definetly has to be run in the kernel not in regular userspace so that
the chain of trust is maintained.

Why do you say that it would have to be a deprivileged kernel context
though? In lockdown mode we would enforce a signature check on the PE
file, so it shouldn't be any different from loading a signed kernel
module from a kernel lockdown perspective, right?

Using KVM is actually something I didn't consider yet, however it would
not work in VMs without nested virtualization.

> The advantage of this approach is that the whole concept of purgatory
> can be avoided - the EFI boot phase runs in parallel with the previous
> kernel, which has full control over authentication and [emulated] PCR
> externsion, and has ultimate control over whether the kexec reboot is
> permitted.

I'm under the impression that we still need some code to run between the
kernels to do two things:

1. Clean up the address space, so that it's what the EFI binary expects
2. Verify a checksum on the saved state in case a kernel panic is the
result of memory corruption

Sure, the majority of the work (running the EFI binary until EBS()) is
done while the old kernel is still running.

>
> [...]
> 
> I don't think intermediate kernels are the solution here. We need to
> run as much as possible under the control of the preceding kernel, and
> minimize the bare metal handover that occurs after EBS(). Adding more
> code to the purgatory (as this series does) is not acceptable to me,
> as it is extremely difficult to debug, and duplicates drivers and
> other logic (making it an 'intermediate kernel' of sorts already)

I agree

> 
> Today, UKI functionality is implemented in terms of EFI API calls. Any
> solution that needs either a parallel implementation (eBPF vs EFI) or
> needs to unpack the UKI in order to perform the steps that the UKI
> would perform itself if it were executed in an EFI environment is a
> no-go in my opinion.
> 
> So either we provide some EFI compatible runtime sufficient to run a
> UKI, or we re-engineer UKI to be built on top of an abstraction that
> can be implemented straight-forwardly both on system firmware and in
> the EFI context.

A solution that can boot UKIs as they exist today is definetly the right
choice. Rewriting them for eBPF and maintaining two implementations is
way less than ideal.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
