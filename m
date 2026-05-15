Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FFBCD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 22:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0GGVXnEvwyvUGTIvy68sh7LB/BlAa3dzEnbAfye67mM=; b=1+CK2buQBawmq99rm1CI+XlXGn
	IiEbN5Dp3Py7FeHL8IyJnJTGEH+eWBN7OkWfmiR0OZAZm1tk5iKLAhNmW+6qlVd4cex0LQGPjkKFR
	cy0n+DgFvuVD2io6Lloj5dwoTVw7odKYSl3nVwtp8hxqPnXyjEh6lGwbHNY2Y1alw+iNWtP6hx2Fx
	izRYbTnELyUBPNSdAk5l2BmA94tYy9Ee9EVUqa/llQMilKLor4moNMH0ryVp8/fp56dWDYXqzodz+
	+elnWufUrW5O8XTDtNNqOB4Ix9geQ4g5N3e/XajbrrEHaiLr4CB5AJScP62uf8FU7TBuc+CB1eqRQ
	T8QAy0oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO0bv-00000009afu-1wAH;
	Fri, 15 May 2026 22:02:23 +0000
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO0bp-00000009af0-2lX8;
	Fri, 15 May 2026 22:02:17 +0000
Message-ID: <130c4cfa-7388-462f-9b0f-7939680a90ed@infradead.org>
Date: Fri, 15 May 2026 15:02:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 15/38] Documentation/security: Secure Launch kernel
 documentation
To: Ross Philipson <ross.philipson@gmail.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 daniel.kiper@oracle.com, andrew.cooper3@citrix.com,
 trenchboot-devel@googlegroups.com
References: <20260515211410.31440-1-ross.philipson@gmail.com>
 <20260515211410.31440-16-ross.philipson@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260515211410.31440-16-ross.philipson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 5/15/26 2:13 PM, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> Introduce documentation for the Linux Secure Launch feature.
> 
> Co-developed-by: Ross Philipson <ross.philipson@gmail.com>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
> ---
>  Documentation/arch/x86/boot.rst               |   8 +
>  Documentation/security/index.rst              |   1 +
>  .../security/launch-integrity/index.rst       |   9 +
>  .../launch-integrity/secure_launch.rst        | 681 ++++++++++++++++++
>  4 files changed, 699 insertions(+)
>  create mode 100644 Documentation/security/launch-integrity/index.rst
>  create mode 100644 Documentation/security/launch-integrity/secure_launch.rst
> 


> diff --git a/Documentation/security/launch-integrity/secure_launch.rst b/Documentation/security/launch-integrity/secure_launch.rst
> new file mode 100644
> index 000000000000..b4c61fdceaf0
> --- /dev/null
> +++ b/Documentation/security/launch-integrity/secure_launch.rst
> @@ -0,0 +1,681 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. Copyright (c) 2019-2026 Daniel P. Smith <dpsmith@apertussolutions.com>
> +
> +======================
> +Secure Launch Overview
> +======================
> +
> +:Author: Daniel P. Smith
> +:Date: February 2026

maybe update?

> +
> +Overview
> +========

[snip]

> +Error Codes
> +===========
> +
> +The TXT specification defines the layout for TXT 32 bit error code values.

                                                    32-bit

> +The bit encodings indicate where the error originated (e.g. with the CPU,
> +in the SINIT ACM, in software). The error is written to a sticky TXT
> +register that persists across resets called TXT.ERRORCODE (see the TXT
> +MLE Development Guide). The errors defined by the Secure Launch feature are
> +those generated in the MLE software. They have the format::
> +
> +  0xc0008XXX
> +
> +The low 12 bits are free for defining the following Secure Launch specific
> +error codes.

[snip]

> +Resources
> +=========
> +
> +The TrenchBoot project:
> +
> +https://trenchboot.org
> +
> +Secure Launch Specification:
> +
> +https://trenchboot.org/specifications/Secure_Launch/
> +
> +Trusted Computing Group's D-RTM Architecture:
> +
> +https://trustedcomputinggroup.org/wp-content/uploads/TCG_D-RTM_Architecture_v1-0_Published_06172013.pdf
> +
> +TXT documentation in the Intel TXT MLE Development Guide:
> +
> +https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
> +
> +TXT instructions documentation in the Intel SDM Instruction Set volume:
> +
> +https://software.intel.com/en-us/articles/intel-sdm
> +
> +AMD SKINIT documentation in the System Programming manual:
> +
> +https://www.amd.com/system/files/TechDocs/24593.pdf
> +
> +GRUB Secure Launch support:
> +
> +https://github.com/TrenchBoot/grub/tree/grub-sl-fc-38-dlstub
> +
> +FOSDEM 2021: Secure Upgrades with DRTM
> +
> +https://archive.fosdem.org/2021/schedule/event/firmware_suwd/
> +
> +.. [1]
> +    MLE: Measured Launch Environment is the binary runtime that is measured and
> +    then run by the TXT SINIT ACM. The TXT MLE Development Guide describes the
> +    requirements for the MLE in detail.
> +
> +.. [2]
> +    PMR: Intel VTd has a feature in the IOMMU called Protected Memory Registers.
> +    There are two of these registers and they allow all DMA to be blocked
> +    to large areas of memory. The low PMR can cover all memory below 4Gb on 2Mb
> +    boundaries. The high PMR can cover all RAM on the system, again on 2Mb
> +    boundaries. This feature is used during a Secure Launch by TXT.
> +
> +.. [3]
> +    Secure Launch Specification: https://trenchboot.org/specifications/Secure_Launch/
> +
> +.. [4]
> +    ACM: Intel's Authenticated Code Module. This is the 32b bit binary blob that

Does "32b" mean something or should that be 32-bit?

> +    is run securely by the GETSEC[SENTER] during a measured launch. It is described
> +    in the Intel documentation on TXT and versions for various chipsets are
> +    signed and distributed by Intel.

-- 
~Randy


