Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7B5EB64D8
	for <kexec@archiver.kernel.org>; Fri, 16 Jun 2023 16:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CkkYfB2dRSrkMYM/0bJ3dHKyI3mQAfWL8Tm0Bob/CxU=; b=O6RYdlFZ3GVYPD
	mTgis57nDSk3des6j9mqWCLs2ryor5OOIX4wGuG5E8/pyXjXNmHCAZE5AEnkMqmXdtMCxCaaRgYlt
	MyRGrf3Eow3TgtXD5pIwPGXligHp0KAGueUB0Wt4ja5xwGXqaJsrWzQ69hjZyvcTW8b1s6Xi6jgrv
	Gm7mAwoAkJpUFTTsRxgXQ7inhUUPUqBSWyVEgR9K0PKVLMpcbfTMVhWwNX3Olx7koodWQK5/DPn1o
	8kwux/ozH4SJ58ZOVkhsBsvZqmOUW85tDTIOYQ+lIYZYrdgkFEJsaDTkqYiohFJQYyP6Ix2aRk2N6
	37y6k+Nqqfqa9OW1QmEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qACZG-001A1W-0R;
	Fri, 16 Jun 2023 16:44:58 +0000
Received: from sender3-of-o59.zoho.com ([136.143.184.59])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qACZD-0019zz-2G
	for kexec@lists.infradead.org;
	Fri, 16 Jun 2023 16:44:57 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1686933873; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K2OqRJfe2GJeQkgK+NEfGjq73mCcLWdnFodkO4sXrmbaizIXLgu/HsyvpE4MNNgewC3PfqZc9YurYjtjUtpFwePrVKK/iuvjr6v+Juj5UNR0kZ+OyQzlYBclaXTR02bROnRL5QOsjEc3rULeLFL4rcL14f35RIjIQC0oQz/H5xg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1686933873; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=YFf4KgEPbWL7mvIIGoCh2dt81HyAXm/q6dL8q62QUqM=; 
	b=kb9ONZdR3/WmMIh5NKTpkxb+0Jep9fQsD3Bvuhu7PXPgr+bmFTj7c0BpiAI8u0q+/CqrM9xchX3nosSThjR4vxl6hK+jOAMdlblqBaxbEl5VXL7ZtKqLvI/hV4K5g/KJfyApi2Qc6j+gtX9i9BG2priSe99Pqii8Iz34p0k8YEw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686933873;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YFf4KgEPbWL7mvIIGoCh2dt81HyAXm/q6dL8q62QUqM=;
	b=Zmm4hQ+1IB3Tmr3ET8PdXzI6pVC5ayUXdkDP6CGRW1kSJ6DFF7YlFkZ79uWonUGq
	TAW8ZH1SzLEIAN52IyqhxVDi7IKcNCnpgsJYk+ciL7/T37ppygDLq0bCbIGxIQYa8FL
	9koCYVDg8mzvMx2f1pm8JHdr/FiOBV9ex0qFx/YM=
Received: from [10.10.1.133] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1686933870911516.0622407770464; Fri, 16 Jun 2023 09:44:30 -0700 (PDT)
Message-ID: <e7dcb85b-25bb-8d5a-3758-e4243bc6ffec@apertussolutions.com>
Date: Fri, 16 Jun 2023 12:44:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 02/14] Documentation/x86: Secure Launch kernel
 documentation
Content-Language: en-US
To: Matthew Garrett <mjg59@srcf.ucam.org>,
 Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
 James.Bottomley@hansenpartnership.com, luto@amacapital.net,
 nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-3-ross.philipson@oracle.com>
 <20230512104753.GA14461@srcf.ucam.org>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <20230512104753.GA14461@srcf.ucam.org>
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230616_094455_829036_DF1E0BFD 
X-CRM114-Status: GOOD (  14.41  )
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


On 5/12/23 06:47, Matthew Garrett wrote:
> On Thu, May 04, 2023 at 02:50:11PM +0000, Ross Philipson wrote:
>> +Secure Launch does not interoperate with KASLR. If possible, the MLE should be
>> +built with KASLR disabled::
> 
> Why does Secure Launch not interoperate with KASLR?
> 
> Re: IOMMUs

Until the IOMMU driver comes online, memory is protected by the PMRs 
regions requested by the Preamble (pre-launch code) in accordance with 
Intel TXT specifications and configured by the ACM. The KASLR randomizer 
will run before the IOMMU driver is able to come online and ensure 
frames used by the kernel are protected as well as frames that a driver 
may registered in a BAR are not blocked.

>> +It is recommended that no other command line options should be set to override
>> +the defaults above.
> 
> What happens if they are? Does doing so change the security posture of
> the system? If so, will the measurements be different in a way that
> demonstrates the system is in an insecure state?
> 

In an early version of the patch series this was enforced when turning 
on Secure Launch, but concerns were raised over this approach and was 
asked to allow the user to be able to shoot themselves in the foot. 
Overriding these values could render either an insecure state and/or an 
unstable system.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
