Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24BFE6F08E
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 22:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CntBsUc61TMb92S8Z1E7nZ/4W1liTxOaayMMXBLn8Co=; b=37nrAsz3kWxH+e
	FUbSifq2GzxE+X51I3DzgJfaqQ99Vnkd+6K+tiaAg5g/LtKHTnXMZGkEWh2OLLzo/L9mTp7SQy6lR
	jQ599P2g30vjgZtY1tfsHHa8mfXCe6nPd39TxVZQeB8jyS8cHjbY7ZcXVWm7PNoMJFlnPIqSuNcDg
	BydJnVspTOMFC+x5QVFkBb+kofBfArR7ouyfwrn50jLbLN+0Xx1TMGv7ucyG8PKLeajykNgqOPzEQ
	bEHPQcRbFbW9zcWVKrRqRqTLTsIZUWrNTDuDri+Rm0GWPgpdbRQ9tbaPdQ9bHbt113Xe9ho+A0A3H
	/IuAplX+mcU3nf61/Fmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6zlN-00000008QfV-36qz;
	Fri, 01 Nov 2024 22:05:02 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6zlG-00000008Qdu-2tNc
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 22:04:59 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730498692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lCede5LVGfjUHXIUEvO/z1zpCc7zqLUZ75s6lun7nCY=;
	b=Rs3kktdWk1lN32PUJ7bpKRqaI11W6TOARxQ7M8IZg85h0hLj8BpU2d8RkiS45aZMUyj1SP
	g7D8XYE7FQdz0rBPLhapHRw7jAYH329IqfssC+tl5X+UAwMpLdcZ8mtwDBdWImq7YWeCHV
	E69hG/E7sMUbLpd0OwnHa/lKJMzyj29gylBqqr8mFQwSUd83ijMkNhIFqIsxXzXtHeIEeY
	WxzwNQP3iECYYKDGS9YRD5NqFBn0PXekZn98GCVyQpl/aLmgtc30iQWryd5Zr9med2khgR
	/QSNouVebLs8VzjX1uu0X7pddyTzpIsuugIxW2Ac4HVRRutyjeVneaZnhAT3cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730498692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lCede5LVGfjUHXIUEvO/z1zpCc7zqLUZ75s6lun7nCY=;
	b=oF1urBdtwwN3U5Xd6xbkDqyj0L2KGcSI0vNXOshMgQsBWuRvFH9dDh2NfemcPFvzI2hSoY
	KbIRqufKcA+Se/CA==
To: Jarkko Sakkinen <jarkko@kernel.org>, Jarkko Sakkinen
 <jarkko@kernel.org>, Ross Philipson <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: dpsmith@apertussolutions.com, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
In-Reply-To: <D5B5MLX1C8TS.2U6YPCYBWBTYT@kernel.org>
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <D5ARS5Y7EATS.2GVNSARKXKIDI@kernel.org> <87a5eivgku.ffs@tglx>
 <D5B5I0WUU8F0.30JMZ6QHPOFRK@kernel.org>
 <D5B5MLX1C8TS.2U6YPCYBWBTYT@kernel.org>
Date: Fri, 01 Nov 2024 23:04:51 +0100
Message-ID: <87msiitxto.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_150454_890385_96316D59 
X-CRM114-Status: GOOD (  10.02  )
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

On Fri, Nov 01 2024 at 23:19, Jarkko Sakkinen wrote:
> On Fri Nov 1, 2024 at 11:13 PM EET, Jarkko Sakkinen wrote:
>> I think we can sort them out independently as long as we find a
>> conclusion how to address locality change.
>
> And to be fair: there was no reaction from anyone. It is mostly x86
> patch set, meaning that I was waiting for some reaction first from that
> side.  And I did respond to that when it came.

The x86 side is mostly self contained, so the damage there is minimal,
but the TPM parts are changing the generic operations and the x86 parts
depend on them.

So let's not create a chicken and egg problem and solve the TPM parts,
which at my cursory glance are partially legitimate fixes, independent
of the actual trenchboot x86 functionality.

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
