Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FB6C4345F
	for <kexec@archiver.kernel.org>; Thu,  2 May 2024 12:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JyLW7D9/QLa1FLJL8vNKfj2mN7o561VGOpYvm4Y5XVw=; b=MLY16NCZC/3UxA
	YVRbmRY/S8k1COhcSQL4kwEwhZpvJ4j+6XLavPbKYye00fNFeC8wRfHGSydUGIXE3bFjesg0acN7v
	5EilSFMgEpQb9qClXeQCZM1hARK8DBE+cjiagRFvsYCgM+wnsq4R1B27L9DR01LwREILFt8muSS66
	fsLOWAdXFJGAeFjPPuvFd3f7MOanaJQGW5dg1SgcvRMo9lPdsQsTkCK5tfcb2+IvK+hmlId5DhEuS
	fOaC3lrQzeL1LprB+9Z0JuPeOHIA9LHJOFGFSNQBO6+5WpK1KOR30FZz77CVUp22Gxy8cbz3HubrY
	49pCf/FI6AP/oYx4QY+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2V7w-0000000Caav-2oAB;
	Thu, 02 May 2024 12:01:28 +0000
Received: from smtp-fw-80006.amazon.com ([99.78.197.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2V7t-0000000CaZn-0EWX
	for kexec@lists.infradead.org;
	Thu, 02 May 2024 12:01:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714651285; x=1746187285;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e7tDSC9p8oy5ChHErHE1oCbmu4OKOhTaSgDmPzR2GlY=;
  b=iIvl2MO8TlO9Bf6rfMl1PnBtmqwZJoDf6p3aCix+APLWo47/l5yPv1kb
   Cz//2EYoRILnIlSxHB4qODTa6A4nENvkAXnoj2C46dEcTR9/Ta5V3Fkqu
   Nljht7IyA1bcRCuF96MNpOuL7TCXGULN8+NEXqJPQe3J2TsRlmo9Hn+l5
   A=;
X-IronPort-AV: E=Sophos;i="6.07,247,1708387200"; 
   d="scan'208";a="292197737"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 12:01:18 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:1724]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.7:2525] with esmtp (Farcaster)
 id 74eaa98e-3cdf-42c3-987a-590178113d5b; Thu, 2 May 2024 12:01:17 +0000 (UTC)
X-Farcaster-Flow-ID: 74eaa98e-3cdf-42c3-987a-590178113d5b
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 2 May 2024 12:01:16 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 2 May
 2024 12:01:11 +0000
Message-ID: <26b3b3b5-548d-4ebd-9d21-19580a41e799@amazon.com>
Date: Thu, 2 May 2024 14:01:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] x86/snp: Add kexec support
To: Ashish Kalra <Ashish.Kalra@amd.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <seanjc@google.com>, <kai.huang@intel.com>,
	<bhe@redhat.com>, <kirill.shutemov@linux.intel.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <anisinha@redhat.com>,
	<jroedel@suse.de>, <ardb@kernel.org>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <cover.1712694667.git.ashish.kalra@amd.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <cover.1712694667.git.ashish.kalra@amd.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_050125_192574_3D33666D 
X-CRM114-Status: GOOD (  13.61  )
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

Hey Ashish,

On 09.04.24 22:42, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> The patchset adds bits and pieces to get kexec (and crashkernel) work on
> SNP guest.


With this patch set (and similar for the TDX one), you enable the 
typical kdump case, which is great!

However, if a user is running with direct kernel boot - which is very 
typical in SEV-SNP setup, especially for Kata Containers and similar - 
the initial launch measurement is a natural indicator of the target 
environment. Kexec basically allows them to completely bypass that: You 
would be able to run a completely different environment than the one you 
measure through the launch digest. I'm not sure it's a good idea to even 
allow that by default in CoCo environments - at least not if the kernel 
is locked down.

Do you have any plans to build a CoCo native kexec where you allow a VM 
to create a new VM context with a guest provided seed? The new context 
could rerun all of the attestation and so enable users to generate a new 
launch digest. If you then atomically swap into the new context, it 
would in turn enable them to natively "kexec" into a completely new VM 
context including measurements.

I understand that an SVSM + TPM implementation may help to some extent 
here by integrating with IMA and adding the new kernel into the IMA log. 
But that quickly becomes very convoluted (hence difficult to assess 
correctness for) and the same measurement question arises just one level 
up then: How do you update your SVSM while maintaining a full 
measurement and trust chain?


Thanks,

Alex


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
