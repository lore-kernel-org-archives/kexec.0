Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE8AC77B7C
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 16:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+ytjYEz75YKgD9pwno9jl192wZdrbq08EyIvbJw4OQM=; b=v1cE6f6j3pFoSa
	NCQ1n8cNwg1aL8bWDD+4nberDUh3weuKFQJ0Hrix8R0SmDyy2AydbNF3ScbI+FcdD9mX36YypbqQ3
	j8+r/eW7mwCeuBq+q4EBj4mbxIYJPCH1Neqp/blhTjX7DNbFYrfYZbUOy+IDKP3yOr20DzV/ClayB
	l+Q1/xZ+KZHfVDk11l1oX7TVFSUfZURrfxo4sOwCgCKXxy+0G5CyTAVt/fykPsUQg4DKLPBoBFQfZ
	toYphs6OMiEkl4tD/E1Uqvp5NA3Mm8lRPw9F1iiTMa2zl7bGEpYv7qK8117pd91rplCRLBGvI8mdz
	NTL6w2MtQQSMXdV0y7zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puyCX-00BI59-0H;
	Fri, 05 May 2023 16:22:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puyCS-00BI3l-29
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 16:22:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 02AE963F0A;
	Fri,  5 May 2023 16:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6C2C433EF;
	Fri,  5 May 2023 16:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683303747;
	bh=2K2sG1iqgAgCjF6w7LO1DpRP8tMIRvNOwwZ3Bg4XUBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZEwRFBu3OZwQgVrSyO4Ynl8ZobRrx7IJaO2Ag95MO9QXmRVqWD4FI+or+I91IfV8
	 RJGPzYzK6nSrGitFu88EAj3lGYv+fFDD3wfltYOjqhppvwFmI06OI4DqgzgN+OxuzC
	 ephmYdlUjJc48hQ7NEGyiDNgTaYJLvpBMW57huB3RYYhwaAUW8fwSn23THU9dAYkDw
	 PqaObywOHOQfeGhuXy4GCnJKCxnBgMTs/DAQtM7YRj7ouzp9qR3VMboqANSLpH9fnM
	 m++qETHrN5sEWH6zmRDzXt+mWb/EDniTdmX54yj3+wuskkZJf8BeNqK8gPLx+4MbIc
	 86Q9Zw5nvY0hg==
Date: Fri, 5 May 2023 18:22:21 +0200
From: Simon Horman <horms@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, luto@amacapital.net,
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 04/14] x86: Secure Launch Resource Table header file
Message-ID: <ZFUtPbgvG0qifhnV@kernel.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-5-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-5-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_092228_965776_0F1FB6DC 
X-CRM114-Status: GOOD (  14.24  )
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

On Thu, May 04, 2023 at 02:50:13PM +0000, Ross Philipson wrote:
> Introduce the Secure Launch Resource Table which forms the formal
> interface between the pre and post launch code.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  include/linux/slr_table.h | 270 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 270 insertions(+)
>  create mode 100644 include/linux/slr_table.h
> 
> diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h

...

> +static inline void *slr_end_of_entrys(struct slr_table *table)
> +{
> +	return (((void *)table) + table->size);
> +}
> +
> +static inline struct slr_entry_hdr *
> +slr_next_entry(struct slr_table *table,
> +		struct slr_entry_hdr *curr)

nit: The indentation of the line above doesn't align with the '(' on
     the line before it.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
