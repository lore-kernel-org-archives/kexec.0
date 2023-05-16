Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBB6C77B7D
	for <kexec@archiver.kernel.org>; Tue, 16 May 2023 02:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9nNIuZUKNtlCP9NuD+GUPXMNkBong0USVbqYRzzKfpY=; b=SNW529i+VE/jvN
	zxLAuJBZdDkob/hnvy24mxAxfd43NAAHfqxCAXZbOf4VtI/h7caMj1pz7LOHE7xKHJms0+ZNhnW65
	C3/+CwL17VXyN155vkPqBLMvfLej/9XkQsXGhaCHhTG7dlu+PJ3mi4nyp/QqP2z16dwHzzyoPd/vi
	RgDVYzHwpgCD0DDYrywfz9b6P8o6xF8xxfc3yohj4QmxTB3N10jZsQZTTMUJsswAToqxM0W647883
	c66LoTvKlZZIqM8uh05kHGVWJ5/DlzbG2AI+H8uCsPjZBsnIWQPOhF88cX2wo+frcvKSWiASeZo2A
	hwSJzM2nn5joR3Wma2QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pykgj-004Ab2-1C;
	Tue, 16 May 2023 02:45:21 +0000
Received: from cavan.codon.org.uk ([176.126.240.207])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyjic-0044Dc-2R
	for kexec@lists.infradead.org;
	Tue, 16 May 2023 01:43:16 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 801BD42529; Tue, 16 May 2023 02:43:10 +0100 (BST)
Date: Tue, 16 May 2023 02:43:10 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc: Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	ardb@kernel.org, James.Bottomley@hansenpartnership.com,
	luto@amacapital.net, nivedita@alum.mit.edu,
	kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 04/14] x86: Secure Launch Resource Table header file
Message-ID: <20230516014310.GA5403@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-5-ross.philipson@oracle.com>
 <20230512105554.GB14461@srcf.ucam.org>
 <30d5891d-4747-8d67-2667-ff07628740bd@apertussolutions.com>
 <20230515212206.GA2162@srcf.ucam.org>
 <df9d1260-41dd-034b-9dc6-14173c6c0d25@apertussolutions.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <df9d1260-41dd-034b-9dc6-14173c6c0d25@apertussolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_184314_920208_184F5E55 
X-CRM114-Status: GOOD (  16.51  )
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

On Mon, May 15, 2023 at 08:41:00PM -0400, Daniel P. Smith wrote:
> On 5/15/23 17:22, Matthew Garrett wrote:
> > What if I don't use grub, but use something that behaves equivalently?
> > Which value should be used here?
> 
> Generally we would request that the bootloader submit a request to register
> for a value to be reserved in the spec. That aside, the intent here is to
> allow for the possibility for the DLE handler to be independent from the
> bootloader, but this does not have to be this way. If a non-open entity
> decides to produce their own implementation, they can freely use a
> unallocated value at their own risk that it could be allocated to another
> bootloader in the future. Though in this scenario it likely would not matter
> as the non-open DLE handler would only be present when the non-open
> bootloader was present.

Is the expectation that the DLE will always be shipped with the 
bootloader? I think I'm not entirely clear on what's consuming this and 
why.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
