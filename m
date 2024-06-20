Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0268CC27C53
	for <kexec@archiver.kernel.org>; Thu, 20 Jun 2024 00:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QH7pUFdCABYS0PQCObkqGAbYv/1B/Q9tJ3ip8hPgYyM=; b=a1EkiE2w73Xgzk
	UIrMx6fgiI7DfxocWNbWJw/iSzHeLLZgrshshagRIWnR+QTO7dLF4rLgjC6q55w+M6JSyMVGiaXU8
	6RayZxCuRbYEmH12x+AjDaBO/PBNdt7EmtDOmXsGsJNvMkeHiu6echQd+UR/eU3Ty8FlRoeWnNO03
	wXG4mylb5hZyFpF85IIGdl11MZSugjlzYu3ef7Btip3vhefl/bnhPCWragG2fsooGZPKvAGIQ53bb
	E+qlVDtJSZkP5rD/Ig9FAe8CiEdBDLXmmaZOvAxheAfIeMpAXYmP4iJH4/iVAjSpLixnzWUPILnwi
	1frgborPj2VqdYDlWP2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sK5VS-000000037HL-47qM;
	Thu, 20 Jun 2024 00:18:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sK5VP-000000037GI-220L
	for kexec@lists.infradead.org;
	Thu, 20 Jun 2024 00:18:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D779761B20;
	Thu, 20 Jun 2024 00:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9158FC2BBFC;
	Thu, 20 Jun 2024 00:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718842701;
	bh=AjGTuPtk95NLEx+Fq4Qq+oorb0yiuLhFVoBTD7HosbQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UogrS+kY7AH+DCLQ2wu6155VpA9xgKIzKNs1kx36Stt7xUroWQHkFKlsg7gLvh04C
	 WmHYDyOFcZMT+C7jB9qW/cwh6GvuDZ0CHnWikBphf5WzbbjTEYvgIcezIVstgcxpGz
	 g55DDyXE8tISgnVjX6fsOhEDASTPuRJOJLd/1CLuINQscuxncHUPHapZQF/2x1ogPy
	 pP+eK0/dLHoE1IOgvxEWxJx1cr3ErS5E+oQU9/qTm7EScqv8rHl1eD7wfppOXyvl4Z
	 PiIDDwqP3Q+qbBZoPySZ8JhqIZ0jj+ObaVp+Y/iZSIA5WPh1I3R0HG/CB6VsVEfJho
	 jXU8QWoU/wyLA==
Mime-Version: 1.0
Date: Thu, 20 Jun 2024 03:18:13 +0300
Message-Id: <D24EVSK6GUPH.1P44T5NNBWORU@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 04/19] x86: Secure Launch Resource Table header file
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-5-ross.philipson@oracle.com>
 <D1RFWFIJEYWL.2FC7V79321264@kernel.org>
 <1eca8cb1-4b3b-402b-993b-53de7c810016@oracle.com>
 <D1RLBMTUKRFN.34KQXEFZTBA08@kernel.org>
 <249a9b27-c18d-4377-8b51-9bc610b53a8b@oracle.com>
 <D1RNKV4JIE5L.1LNG82UAC916M@kernel.org>
 <f66de08f-4905-48d6-8bcf-5b1ab847492f@oracle.com>
 <D1RSB1PB5XGS.2X032M0E1VMJW@kernel.org>
 <a865a25c-336e-47de-9718-de4cb957e6c2@oracle.com>
 <D1SPFVXS6FOG.IQQB3INFYEF2@kernel.org>
 <23961b5b-a52a-483c-876e-e5e39d9e6c01@oracle.com>
In-Reply-To: <23961b5b-a52a-483c-876e-e5e39d9e6c01@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_171823_588718_8F7903A1 
X-CRM114-Status: GOOD (  12.27  )
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

On Thu Jun 6, 2024 at 7:49 PM EEST,  wrote:
> > For any architectures dig a similar fact:
> > 
> > 1. Is not dead.
> > 2. Will be there also in future.
> > 
> > Make any architecture existentially relevant for and not too much
> > coloring in the text that is easy to check.
> > 
> > It is nearing 5k lines so you should be really good with measured
> > facts too (not just launch) :-)
>
> ... but overall I get your meaning. We will spend time on this sort of 
> documentation for the v10 release.

Yeah, I mean we live in the universe of 3 letter acronyms so
it is better to summarize the existential part, especially
in a ~5 KSLOC patch set ;-)

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
