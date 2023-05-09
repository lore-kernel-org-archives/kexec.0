Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7842C77B7C
	for <kexec@archiver.kernel.org>; Tue,  9 May 2023 22:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LoVaTQ34kEsk/+STMDOWryfNgHZrJM787sW1X7kDcrI=; b=3fg7hpgvjWLWv/
	JlcqC7m2jnhv8huiRbGR0fnOx4iIiKOiLTiKnP0IpEFO5AirWCPyUwBBWUbAI89+x9/qR49NhPUtM
	A3bUOQMxj8dMce3wNpt3HBA09DyN0YE+rCN7MH7I2LL3li7ZAgR0ImBF4K4uZQmVVllIHCSM+vK54
	BSGoGKrKZsGmhz1IQurYTYHshv/0kPvMQuEa9g1uYTG/LYZZqct/36rQnpRvDITfWASDc9EvIBQ1D
	ka+IMiDvXWBtqQL3p9Q/v+8WXvioXiqhRV8GGRIhAABFJcmGc2N3Pb1V44g1NaAetCq3QLslzI+SM
	u2vQt7L5dLjVwSvTTZXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwVzV-004QA9-19;
	Tue, 09 May 2023 22:39:29 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwVzS-004Q9F-1n
	for kexec@lists.infradead.org;
	Tue, 09 May 2023 22:39:28 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1683671961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AoRCeiEC0lX60QQr/ng9hp/BAQI3tAneYjaagExOpuo=;
	b=zE9uM3dLPDwDBs367lvwADX3YqIi3wh3xU9QqFUl4Mdp5d/uSUj4rJaJ/5onfMMIf5BWol
	dSkIRm8ENR0c31MJMoFPcQlod5GYS1R88BIxgEYn1Jla7XlJnxnOnSy9Gz337y6U25WEYv
	ShtmtOzIATBHnwtPQ/+U35eCUOHTCEpEClXFLWDSdhWH5Z/7+AqqQKKffRbhuN8/D18S3n
	O51FTuqVP76MhJFeauJ6sXe6vhRB62aGqDOejrb+vRbK0bZ/ELCiCsXfSGIgq5CWPTqvfB
	6kSo5AW9fPwAU8hXoFyL1/nysAZTeNAg3as6XrhpH/EX/ZYY7QfrYypOpWOpIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1683671961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AoRCeiEC0lX60QQr/ng9hp/BAQI3tAneYjaagExOpuo=;
	b=gU9oq56VoY75zw94GPzkKBv7I34l/YxX/4AtZSYh+y3pluRCwa6miBwsTIuMJHCWUdcu2A
	Vjsyc0b8D/dlboAA==
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
 dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
 robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
 sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: Re: [PATCH v22 8/8] x86/crash: optimize CPU changes
In-Reply-To: <20230503224145.7405-9-eric.devolder@oracle.com>
References: <20230503224145.7405-1-eric.devolder@oracle.com>
 <20230503224145.7405-9-eric.devolder@oracle.com>
Date: Wed, 10 May 2023 00:39:20 +0200
Message-ID: <878rdxyvs7.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_153926_760851_F73C3AC7 
X-CRM114-Status: GOOD (  21.49  )
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

On Wed, May 03 2023 at 18:41, Eric DeVolder wrote:
> This patch is dependent upon the patch 'crash: change

Seriously? You send a patch series which is ordered in itself and then
tell in the changelog of patch 8/8 that it depends on patch 7/8?

This information is complete garbage once the patches are applied and
ends up in the git logs and even for the submission it's useless
information.

Patch series are usually ordered by dependecy, no?

Aside of that please do:

# git grep 'This patch' Documentation/process/

> crash_prepare_elf64_headers() to for_each_possible_cpu()'. With that
> patch, crash_prepare_elf64_headers() writes out an ELF CPU PT_NOTE
> for all possible CPUs, thus further CPU changes to the elfcorehdr
> are not needed.

I'm having a hard time to decode this word salad.

  crash_prepare_elf64_headers() is writing out an ELF CPU PT_NOTE for
  all possible CPUs, thus further changes to the ELF core header are
  not required.

Makes some sense to me.

> This change works for kexec_file_load() and kexec_load() syscalls.
> For kexec_file_load(), crash_prepare_elf64_headers() is utilized
> directly and thus all ELF CPU PT_NOTEs are in the elfcorehdr already.
> This is the kimage->file_mode term.
> For kexec_load() syscall, one CPU or memory change will cause the
> elfcorehdr to be updated via crash_prepare_elf64_headers() and at
> that point all ELF CPU PT_NOTEs are in the elfcorehdr. This is the
> kimage->elfcorehdr_updated term.

Sorry. I tried hard, but this is completely incomprehensible.

> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 8064e65de6c0..3157e6068747 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -483,6 +483,16 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
>  	unsigned long mem, memsz;
>  	unsigned long elfsz = 0;
>  
> +	/* As crash_prepare_elf64_headers() has already described all

This is not a proper multiline comment. Please read and follow the tip
tree documentation along with all other things which are documented
there:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

This documentation is not there for entertainment value or exists just
because we are bored to death.

> +	 * possible CPUs, there is no need to update the elfcorehdr
> +	 * for additional CPU changes. This works for both kexec_load()
> +	 * and kexec_file_load() syscalls.

And it does not work for what?

You cannot expect that anyone who reads this code is an kexec/crash*
wizard who might be able to deduce the meaning of this.

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
