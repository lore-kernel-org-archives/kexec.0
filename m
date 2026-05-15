Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09D1CD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 23:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lkbmWFMshrjtM3WVKpbOscrQ8Om+ruf7Nj5uMZZ00nI=; b=mEXlIfVkbZSJoHuev5iWr45LiL
	URRvAM8HiEeIdNtF9aI/rp7lXEWweBG3Z6ncYh0Lvx/IwhUR2dPWyGh69vgjnxt+ei5sHRAplLE4C
	Uh6EVL2guKNZvHvqJdTLXrqKNu/Mb7RE3hL8eyd2dMwjvrz+KiyDmwZG2OHbB4omTqru+qDpuZROX
	7xMlRIaPepSXuaNu4tGn9uaG7ngUzg6eACTN4eiVOSTOTUGrNZi2ijn/ga7I4C/IasFKTU4ycdCEF
	fDIYSOUFY3NuuYOfnQajIvbiaLFcxbo9QKfQhAY2KEo5BM4K3cQeJYbZIc2IspQf8pwbGrlXkX+IE
	kMRjX39g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO1gh-00000009hI5-0dxO;
	Fri, 15 May 2026 23:11:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO1gg-00000009hHq-11Zm
	for kexec@bombadil.infradead.org;
	Fri, 15 May 2026 23:11:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=lkbmWFMshrjtM3WVKpbOscrQ8Om+ruf7Nj5uMZZ00nI=; b=gAEeAKYG2M5IuaHyAa5C6LmQ5i
	+AKPStMmy0gcH0spDLcjYcwrMm1z0kLHl1a9k0LI7DbX/I/51/+GM3hxPGzto2dV21csgNFBmZL93
	9n+bWY2KZqLBTfGaci5UB7k/GCY3WiarYchbRIR1kknKwGW4zabU4iBNCn1gk7JmCCOSbKVnXTqT6
	YDCD4yXDinXIf0HpBWv3m0G6asaK1k32qD1GW1+dgU1xL+1fZpZnvNlIHb6tLFjhI9ye9fkJ5rLVK
	0/Llt/9sqBb8JzilxOwE5ADkCMw4XtSLjvg0R6TwkTXPIyWwjf4WwaETf0guOa6/Zkfz5Ha9OZHVZ
	7QZOvj5Q==;
Received: from mgamail.intel.com ([198.175.65.17])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO1g4-00000006SIv-3Xoh
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 23:11:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778886645; x=1810422645;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lkbmWFMshrjtM3WVKpbOscrQ8Om+ruf7Nj5uMZZ00nI=;
  b=YpUWMl/LjSnMCjhtNb0133K7h0IflKT1WoYOCu8t6rpI2vCk/3fPBldB
   KIowQ/y/ZSSewNKfau8aSisZUxv65PvlOpPLYsnrSukq5L8dHo2uco78/
   o4fj2iYBmQliWU5F1cikWIvAUzuAibxE/nw21gBrpCXjzDyln0fnRxN9M
   fSf7jMy8+Vp/y+KBy+fV6kej1WipZNppdnmWy1GcC0bP+E2+sVkdTznYJ
   1HrVbVTRG8SQFCEavyZCNDP3r17WDkgSRXzxyyUH8I/3wf1921iRYRXbZ
   sp/BlKmRfes9jitVo6KUe16SoKg/5fqvzb4Z23L8VAqghfxmMGRPs16sN
   w==;
X-CSE-ConnectionGUID: Eug2SoCiTe2CFD3Ib5zgeg==
X-CSE-MsgGUID: AddD4VClQuGuJilIdMSXuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79825220"
X-IronPort-AV: E=Sophos;i="6.23,237,1770624000"; 
   d="scan'208";a="79825220"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 16:10:41 -0700
X-CSE-ConnectionGUID: pXeBDpP9QR+ue2lywqQLfQ==
X-CSE-MsgGUID: cxBj73NiSpq3qBMIJOzKGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,237,1770624000"; 
   d="scan'208";a="236180873"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.201]) ([10.125.108.201])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 16:10:40 -0700
Message-ID: <8f8328d3-a7db-4a64-82f8-1e0e3eff93cf@intel.com>
Date: Fri, 15 May 2026 16:10:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/38] tpm: Initial step to reorganize TPM public
 headers
To: Jason Gunthorpe <jgg@ziepe.ca>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: Ross Philipson <ross.philipson@gmail.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev,
 dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, luto@amacapital.net, nivedita@alum.mit.edu,
 herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
 ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, daniel.kiper@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20260515211410.31440-1-ross.philipson@gmail.com>
 <20260515211410.31440-2-ross.philipson@gmail.com>
 <agemXwxVb9jvAbYM@kernel.org> <20260515230553.GO7702@ziepe.ca>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260515230553.GO7702@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_001112_088686_53D99F8F 
X-CRM114-Status: UNSURE (   3.89  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 5/15/26 16:05, Jason Gunthorpe wrote:
> Can we please split out and progress the TPM reorg mini-series at the
> front?

Yes, please.

Any way to break this down and merge in more bite-size pieces would be
better for everyone involved.

