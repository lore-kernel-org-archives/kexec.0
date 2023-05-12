Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807FDC7EE2A
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 11:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mR9YLChhvS3eAyrGK1qwhZnLWiHEsZFZlaT9AW2Oh1A=; b=mpKYDTkc30doDA
	wsh/K+jKUh/c9Y8JFtWMb4nd4tOiGlmtS6gYMSADQ/IqKHdywYN7p9KTdhLZnrJIg929Sz96fyff0
	HUejChFtCeTTigzxzJXCKwYvZE3S9xEWPBD4GIiJurVAs5hHZcZTr7nxc6r6PbFKDVXXxtzRPs9sz
	JxYvtw6sbzESpZwOMyef5F8VyqsdoRKxmIX9PeK3NsjEvOZMlqO6O+QF6bnZ03YU3YlIKseyeQrjx
	Ibyj4RQnmiCJW+TvYSHVB1y/ZGxYxV466+IPCvCBE4tri8eeznN9kUm39kNGVzjkUG1I2SskW1SuT
	YjEQq+FpKzQYs4UJIfFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxRBh-00Bqmt-1J;
	Fri, 12 May 2023 11:43:53 +0000
Received: from irc.codon.org.uk ([2a00:1098:84:22e::2] helo=cavan.codon.org.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxRBe-00BqmG-3A
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 11:43:52 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 77AB940A6F; Fri, 12 May 2023 12:43:49 +0100 (BST)
Date: Fri, 12 May 2023 12:43:49 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
	James.Bottomley@hansenpartnership.com, luto@amacapital.net,
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 13/14] tpm: Allow locality 2 to be set when
 initializing the TPM for Secure Launch
Message-ID: <20230512114349.GH14461@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-14-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-14-ross.philipson@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_044351_170912_9CF66085 
X-CRM114-Status: UNSURE (   9.33  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, May 04, 2023 at 02:50:22PM +0000, Ross Philipson wrote:
> The Secure Launch MLE environment uses PCRs that are only accessible from
> the DRTM locality 2. By default the TPM drivers always initialize the
> locality to 0. When a Secure Launch is in progress, initialize the
> locality to 2.

This looks correct in itself, but looking at the CRB driver code I don't 
think locality support is actually implemented. Are there any SL systems 
using CRB?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
