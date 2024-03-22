Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B394EC54E71
	for <kexec@archiver.kernel.org>; Fri, 22 Mar 2024 14:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AO4XpQC6GKK8/WqSyfiKkisho4it8W6i3DAvxnNTlfY=; b=HczXBz3UmNjnAA
	Veze+cvVrEoy0XyxPsMVFsetuJ/8E+d5CRL6T0OlUG4jry7QSBagXkYMs8Su/akJOmCA+4nzCda4P
	5F7QA4AB6uZNwVdhEKenPU0L7GrPZOvAEwWpwBuaSSbK2np8JZGyLZiKgQGGpDBWANTYeOxFzdzN5
	6hldThjLIMSRBF4V2+ikk4gqDv05cxdtjUzx88qkGsLufEOMPXq+Y1NsQMVSz35lGkmSeexP2wFfs
	s/i5btOdDB7PS7mG3MNV3iU5Ar4B4WmNoEHCcoV4App5oe4okRQ6ACX3ct83SR7U4/VSFkn7SWx1D
	IiWuux5EWnzvu8h/mDew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnfkY-00000007W2y-1dQ1;
	Fri, 22 Mar 2024 14:20:02 +0000
Received: from [2607:7c80:54:3::138] (helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnfkU-00000007W1y-3fZA
	for kexec@lists.infradead.org;
	Fri, 22 Mar 2024 14:20:00 +0000
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42MEJ2ZV3496390
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 22 Mar 2024 07:19:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42MEJ2ZV3496390
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024031401; t=1711117149;
	bh=aB18poa/nAuHxUYgK7CDuG4N2UPsaq85ox+8DKB04kM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ZETGE8z3u9I9yJvR5e/CQUJ9GmkJb4wq8snvbhDmH/87Lzwf+k/ZGo1AYaXFYl9nd
	 uETOnzCevSP6x3/Jys4AjBwWIYxjN9AYiGaZOvlyuMh07rolz2MUbUQq4v4IpcmfbH
	 XaZ2kjkRbA92EYSzRvO14ZBO4HfRYvjEeGadQEOmjwCnKNtbWI9V4I8BadIyN7/QVt
	 DeVXQnWkfk815Zq/7e7UNEjKO+YrQ5XnPO0G5EbeTFGaD7lwA438bf/x93wt39mE9f
	 IPdJFoxWZE023tvibiGtBG/M2k5vMMP30t9IEatLMPA/6G+NKk1Qm1CeXy3mgZtMya
	 5XnVwvHOIMJMQ==
Date: Fri, 22 Mar 2024 07:18:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ross Philipson <ross.philipson@oracle.com>
CC: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v8 01/15] x86/boot: Place kernel_info at a fixed offset
User-Agent: K-9 Mail for Android
In-Reply-To: <9d01a6d2-4dd9-4331-8fc9-b01c07cfdbb5@apertussolutions.com>
References: <20240214221847.2066632-1-ross.philipson@oracle.com> <20240214221847.2066632-2-ross.philipson@oracle.com> <CAMj1kXH3Gvr3vDRLDdXuc0s7ZAQYE6+D7tmCRBjJWwWt2fn4-w@mail.gmail.com> <9d01a6d2-4dd9-4331-8fc9-b01c07cfdbb5@apertussolutions.com>
Message-ID: <32FDA47A-C87F-406F-A0B9-3AA1BB2EBAFB@zytor.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_071958_928710_35B30E7B 
X-CRM114-Status: GOOD (  16.78  )
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

On March 21, 2024 6:45:48 AM PDT, "Daniel P. Smith" <dpsmith@apertussolutions.com> wrote:
>Hi Ard!
>
>On 2/15/24 02:56, Ard Biesheuvel wrote:
>> On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>>> 
>>> From: Arvind Sankar <nivedita@alum.mit.edu>
>>> 
>>> There are use cases for storing the offset of a symbol in kernel_info.
>>> For example, the trenchboot series [0] needs to store the offset of the
>>> Measured Launch Environment header in kernel_info.
>>> 
>> 
>> Why? Is this information consumed by the bootloader?
>
>Yes, the bootloader needs a standardized means to find the offset of the MLE header, which communicates a set of meta-data needed by the DCE in order to set up for and start the loaded kernel. Arm will also need to provide a similar metadata structure and alternative entry point (or a complete rewrite of the existing entry point), as the current Arm entry point is in direct conflict with Arm DRTM specification.
>
>> I'd like to get away from x86 specific hacks for boot code and boot
>> images, so I would like to explore if we can avoid kernel_info, or at
>> least expose it in a generic way. We might just add a 32-bit offset
>> somewhere in the first 64 bytes of the bootable image: this could
>> co-exist with EFI bootable images, and can be implemented on arm64,
>> RISC-V and LoongArch as well.
>
>With all due respect, I would not refer to boot params and the kern_info extension designed by the x86 maintainers as a hack. It is the well-defined boot protocol for x86, just as Arm has its own boot protocol around Device Tree.
>
>We would gladly adopt a cross arch/cross image type, zImage and bzImage, means to embedded meta-data about the kernel that can be discovered by a bootloader. Otherwise, we are relegated to doing a per arch/per image type discovery mechanism. If you have any suggestions that are cross arch/cross image type that we could explore, we would be grateful and willing to investigate how to adopt such a method.
>
>V/r,
>Daniel

To be fair, the way things are going UEFI, i.e. PE/COFF, is becoming the new standard format. Yes, ELF would have been better, but...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
