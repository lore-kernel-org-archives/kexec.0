Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B084C25B75
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 00:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rbW/yeXihNlg0vf79aQFW14jaNTCqP8Bh3Kql8K+CTU=; b=3jopb/G/o7dHes
	mIAT/wxldgMRDGgh6GoVQwyIJgrSNE05iJ8IZReM3oFJ6WvSVaelrjpyzR2UVP7WenNFizxT5MVMg
	B0rGzIkDruh2Z/HGZH4aTHx6/AJZS0hnG40qQKFLB2EpOd1pyYrfpHNmcpNAvEE8t9Wb2jdIxYl/h
	s+RvPLvY9+7arcUCFXlbfmepEDAixOFNGTjFEVAyMoR6d50ptbJ8xI/XbDOQHLA/lwzp+JAu3PEkO
	RLNCAXsfTwB60h9BZq0F8CFvxIylpqC6NUVDcdt8iy9eEPODlounxWRlEnpTVR+ZEH25hBQCpB54g
	qsYzCsjjr059sgDzY7PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEIIS-00000000kvs-0d6s;
	Tue, 04 Jun 2024 00:45:04 +0000
Received: from terminus.zytor.com ([198.137.202.136])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEIIN-00000000kvD-3lUp
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 00:45:01 +0000
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4540O6GP697624
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 3 Jun 2024 17:24:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4540O6GP697624
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1717460652;
	bh=hPNX3NSLHYNb2TcI1l7fuFsWwNCcNc5ytF4+K+xW86o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IcBtkMGIO/Y/xzeu3xUgo0V2bIRkGJWdFYBCuvM7FvQFv4DD5SqW52rOMi1M1NXq0
	 UbpxLqPThJOMWS5OGoH5JDJTneX9Fz4WB6HCAlD3DdwNRoR6DOySE7liMPJ2OoJXwk
	 kN0YOjNf4IHAm/j/fRONallpudtEaMW7a9guw+zMWdMJsw0v5yTE4w+UjP4qPSHwDW
	 +lzLAyxf6BQR+J+gKWA9WL4tVNflr3bNAQgvUQ8ZJY3ET9y22IPwofcNUeVC+3avqJ
	 UFYXxzGbHKtq+nJW3AUi/L4zQrxGWhTvCCXwlR00kYfSxD0xpWVzLtMVCBflrX/zBr
	 fTdcJY72jn6bw==
Message-ID: <748d3b70-60b4-44e0-bd81-9117f1ab699d@zytor.com>
Date: Mon, 3 Jun 2024 17:24:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
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
        "Kalra, Ashish"
 <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
        Baoquan He <bhe@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
        linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_174459_949390_F8CA5752 
X-CRM114-Status: UNSURE (   5.06  )
X-CRM114-Notice: Please train this message.
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Trying one more time; sorry (again) if someone receives this in duplicate.

>>>
>>> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
>>> index 56cab1bb25f5..085eef5c3904 100644
>>> --- a/arch/x86/kernel/relocate_kernel_64.S
>>> +++ b/arch/x86/kernel/relocate_kernel_64.S
>>> @@ -148,9 +148,10 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>>>    	 */
>>>    	movl	$X86_CR4_PAE, %eax
>>>    	testq	$X86_CR4_LA57, %r13
>>> -	jz	1f
>>> +	jz	.Lno_la57
>>>    	orl	$X86_CR4_LA57, %eax
>>> -1:
>>> +.Lno_la57:
>>> +
>>>    	movq	%rax, %cr4

If we are cleaning up this code... the above can simply be:

	andl $(X86_CR4_PAE | X86_CR4_LA54), %r13
	movq %r13, %cr4

%r13 is dead afterwards, and the PAE bit *will* be set in %r13 anyway.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
