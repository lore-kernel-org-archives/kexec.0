Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F469E677EE
	for <kexec@archiver.kernel.org>; Sat,  2 Nov 2024 06:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GjULip4XdGf2d9O7St+97X1y63W3wjFc53Lf0w8b1FQ=; b=CgNgcK4F79wBnc
	1MpFrvuGfVPX9GzRbBhVxyfh8VqUYPMjZiBgejZhyDjwYa+EIx1O5IFaAzBqjOsmUrbx9T2Jd+3rK
	t6hITZOSy13SnEBnERIRbIhjfBvkkB9Qph2toxZyp6BpAIRaMi9StP4YRjSu2tMl2c6DcA5JNkxe/
	oo9UumWiTMpLPwfTUHkvOO9tCmEwLUWzgwbZn5agMCL8aA9QRM3PxemDRbHnE9maDqzx5goigCX6h
	hdhqkRO+ZsZ2wkH0zQMWVr9budQhWkfmlcNw7SjkmshKdiidRvJzfhjDlLjAHbyYaJ6qTc/SLUNfG
	/bhJ6cNULUe8BajMMs4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t77e6-000000098hy-3H26;
	Sat, 02 Nov 2024 06:30:02 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t77e2-000000098gQ-3Avd
	for kexec@lists.infradead.org;
	Sat, 02 Nov 2024 06:30:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D9C56A40286;
	Sat,  2 Nov 2024 06:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01092C4CEC3;
	Sat,  2 Nov 2024 06:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730528996;
	bh=AejcdqpcwMWOPEQZmVB9jxMS0zZ7y/2eLXzF4TJa3MQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ALPVFF+hrO9HeqxEgbkfMmsoELwZFdlNAjWivqSYXgwASxpMajXOVTUj9JqmiafsB
	 KcSwhiT9gnGtHYRSDYUBTrKjpzZacYR/g+FbsdwVdavBVsC6skwMbPHj9/C/79OsHs
	 YR44bWFtGZkXZ0glq5nvxEbhQApXhNTqqCoj4m8XUBG5YJc4II9yARjvrUFsaJQHcB
	 gwDfAha47/nHVv9kn2KWpG1oWd0d+1chHquFe2WgrtMBlrPdFjrQ9oDhvubNMEWXpU
	 MXsIVBtYgsVhM+1ZgxyVI3VFkF+cvvOe1PKo45cdDFKyJXT0p7qrdAKffcQAtQvr4d
	 huhhNFM4A3ppA==
Mime-Version: 1.0
Date: Sat, 02 Nov 2024 08:29:52 +0200
Message-Id: <D5BHBW3NUS5C.293GUI03HMTCF@kernel.org>
Subject: Re: [RFC PATCH v2 1/2] tpm, tpm_tis: Introduce TPM_IOC_SET_LOCALITY
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe"
 <jgg@ziepe.ca>
Cc: <James.Bottomley@hansenpartnership.com>, <andrew.cooper3@citrix.com>,
 <ardb@kernel.org>, <baolu.lu@linux.intel.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <davem@davemloft.net>,
 <dpsmith@apertussolutions.com>, <dwmw2@infradead.org>,
 <ebiederm@xmission.com>, <herbert@gondor.apana.org.au>, <hpa@zytor.com>,
 <iommu@lists.linux-foundation.org>, <kanth.ghatraju@oracle.com>,
 <kexec@lists.infradead.org>, <linux-crypto@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-efi@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <luto@amacapital.net>, <mingo@redhat.com>, <mjg59@srcf.ucam.org>,
 <nivedita@alum.mit.edu>, <ross.philipson@oracle.com>, <tglx@linutronix.de>,
 <trenchboot-devel@googlegroups.com>, <x86@kernel.org>
X-Mailer: aerc 0.18.2
References: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org>
 <20241102062259.2521361-1-jarkko@kernel.org>
In-Reply-To: <20241102062259.2521361-1-jarkko@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_232958_878004_99754442 
X-CRM114-Status: GOOD (  14.85  )
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

On Sat Nov 2, 2024 at 8:22 AM EET, Jarkko Sakkinen wrote:
> DRTM needs to be able to set the locality used by kernel. Provide
> TPM_IOC_SET_LOCALITY operation for this purpose. It is enabled only if
> the kernel command-line has 'tpm.set_locality_enabled=1'. The operation
> is one-shot allowed only for tpm_tis for the moment.
>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> - Do not ignore the return value of tpm_ioc_set_locality().
> - if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED))
> - Refined kernel-parameters.txt description.
> - Use __u8 instead of u8 in the uapi.
> - Tested with https://codeberg.org/jarkko/tpm-set-locality-test/src/branch/main/src/main.rs

This version has been also tested (and encountered bugs fixed). I wrote
a small test program to verify that it works linked above.

After the boot, the new ioctl can reset exactly once the locality. Other
benefit is that the feature can be selected per driver (at this point
tpm_tis drivers) and protection of the access with DAC, SELinux etc.

And thanks to the kernel command-line parameter, it is an opt-in
feature like it should because vast majority of users will probably
never use trenchboot. I.e. set 'tpm.set_locality_enable=1' to have
the ioctl available.

I think this is a solution that at least I could live with. It has
somewhat rigid commmon-sense constraints.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
