Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350E4E67498
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 03:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jr6CbzKDjqjgsjzBK79n5vqBPqE0O+lVwctkk61vqbo=; b=GfdAr6L4aGP4Bv
	FseMM4B9U1m3SMkjEahbtHtmj+6ORgqj3TqckVjdE1Mb43yQ8mNjD2M3xfs2MaK4i1IFXgGWpfiYV
	cNiO4WogLogJnTrzmWsdjf8alXivr2RuQnw9sCZQQ2iK5E5xiRz5g+xsWwhUV6jKiV+IOL/bhM/Ii
	e65es7H7a7qwNmISB6NE6LrFL5maV6F3NUif2TLhRmDGvSiLeY4oGLw0MCcr8uzDwFE5a7N7JdD3F
	MaRGd4fVcqfPyv/eCNeGwW/kdB0/DABA6ZbpbeZFe7PuJe2OPH7Vo0oOh2yA+yvXWhbGXfkp/oYoJ
	iE5uvwwYXCiI1Ij2Puww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6iAZ-00000005diZ-1jOu;
	Fri, 01 Nov 2024 03:17:51 +0000
Received: from bedivere.hansenpartnership.com ([2607:fcd0:100:8a00::2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6iAW-00000005dh6-3ZYW
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 03:17:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730431066;
	bh=nxjll38E6fkaKQQHuECcDsC3eYGfdaj9xNUPAl8lBo0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=efDuU9/Zbc3f0lTndGZZEaRkDrG0Vz4pkv0GarqSEP+mPgMbWQESJXtyMSMYAXr0k
	 vvqCMaZ8nOjlI3hHuiTAhY+9FWTrrmCu0qw6UeP3/JoojaiyoVeoTQjmgTZTiiWhl1
	 v80oxR3ctZUE3xhMRwCkCnopo24wBKz6RgVUs1AY=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9E01512819B1;
	Thu, 31 Oct 2024 23:17:46 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id OblsZ3dP4NMJ; Thu, 31 Oct 2024 23:17:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730431066;
	bh=nxjll38E6fkaKQQHuECcDsC3eYGfdaj9xNUPAl8lBo0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=efDuU9/Zbc3f0lTndGZZEaRkDrG0Vz4pkv0GarqSEP+mPgMbWQESJXtyMSMYAXr0k
	 vvqCMaZ8nOjlI3hHuiTAhY+9FWTrrmCu0qw6UeP3/JoojaiyoVeoTQjmgTZTiiWhl1
	 v80oxR3ctZUE3xhMRwCkCnopo24wBKz6RgVUs1AY=
Received: from [10.250.250.46] (122x212x32x58.ap122.ftth.ucom.ne.jp [122.212.32.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BDC0E12817AD;
	Thu, 31 Oct 2024 23:17:41 -0400 (EDT)
Message-ID: <685f3f00ddf88e961e2d861b7c783010774fe19d.camel@HansenPartnership.com>
Subject: Re: [PATCH v11 18/20] tpm: Add sysfs interface to allow setting and
 querying the default locality
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ross Philipson <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org,  x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
 mjg59@srcf.ucam.org, peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
 luto@amacapital.net, nivedita@alum.mit.edu, herbert@gondor.apana.org.au, 
 davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
 dwmw2@infradead.org,  baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com,  trenchboot-devel@googlegroups.com
Date: Fri, 01 Nov 2024 12:17:24 +0900
In-Reply-To: <20240913200517.3085794-19-ross.philipson@oracle.com>
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
	 <20240913200517.3085794-19-ross.philipson@oracle.com>
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_201748_932526_1E46BB8B 
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

On Fri, 2024-09-13 at 13:05 -0700, Ross Philipson wrote:
> Expose a sysfs interface to allow user mode to set and query the
> default locality set for the TPM chip.

What does a user need this for?  It somewhat conflicts with the idea of
running the kernel and user space TPM access in separate localities for
the purposes of key release, so we can seal keys to only release in the
kernel by policy.  When I last talked about this I thought we'd
probably use 0 for user and, say 2, for the kernel (mainly because
prior incarnations of this patch set seemed to access the TPM in
locality 2 from the kernel).  It really doesn't matter *what* locality
we use for the kernel and the user as long as it's known ahead of time
and the user can't gain access to the kernel locality.

Regards,

James


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
