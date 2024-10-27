Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2668DD13585
	for <kexec@archiver.kernel.org>; Sun, 27 Oct 2024 20:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aNa0g//qacq8f5uwihmM4osTyIXCJ9Rw/wUSzALhPRo=; b=zFAETnB2j6fccT
	YhDu1YwHy/sUh8tdFrnbUU4w9e06TFs+ua96/hgG1BjH61TG2rfJx9ZT0Aj7LytBW0n7E0jsmicRI
	Lwb4ZANX6hEFPVHPfcMla4yC6tbPCvIsrej336NMbefZNn4x8fKk43yCw55liPsOAjtJzvprCpyQU
	3qK0vuH4gHfu8v91l8CFcEF0iIDcJWjWz4WcIa9GcglRwsMwGFQC2bC5IKh7KC6ZHTFJjeCctFSB0
	+rXBbRdnLL781BabfTHsHfWOY8f+O6f94BScMYnIFIfXgIhlsiabUKeuGb1ETjvfdCUcezNfROSra
	Nn2sG8nKuhtMD6jQErkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5A91-00000008sLj-3Yop;
	Sun, 27 Oct 2024 20:45:51 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5A6n-00000008s1u-2qdk
	for kexec@lists.infradead.org;
	Sun, 27 Oct 2024 20:43:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1T8ILKm4ovamc8emWS1f1es99V1XULDZVRfssxb0X7s=; b=KVAL0ILpywa5Lo2ngSEr1c3Swm
	DDpKcW8zyC70vjJ9/IhyRe9C+5ZDWik1SQrbU1WtGwl/atuqIgj5PYCHAUslmNQ4Znm/JmHYUrDaX
	P/vq2n/ofMGyollaUkkuHe/Ur5VKw9q3M7QUX8FXbYCXSTM8ydjN4mBKuSXo+7gggGv55YTNpuu8n
	G1T1KtmnyqTyYofhsFJ2tLh5k8I+0Awt3f1LiqQnzUzxL/uoqKg3BvWH5htOfMfGRo3QEzbTJP/gz
	ornnrreC2W7RvNiM27PJ02HbGeImEDRORIOX3XRXVUImFLFEvWur7HImNV/FvZ4Z8z8xfsyS9cjDX
	8/k5UzYw==;
Received: from [189.79.117.125] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t5A6j-00FpyE-3s; Sun, 27 Oct 2024 21:43:29 +0100
Message-ID: <a07bc9f1-e3c6-04b4-b9b0-63d33373ee31@igalia.com>
Date: Sun, 27 Oct 2024 17:43:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3] Documentation: Improve crash_kexec_post_notifiers
 description
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "vgoyal@redhat.com" <vgoyal@redhat.com>,
 "dyoung@redhat.com" <dyoung@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-debuggers@vger.kernel.org" <linux-debuggers@vger.kernel.org>,
 "stephen.s.brennan@oracle.com" <stephen.s.brennan@oracle.com>,
 "horms@kernel.org" <horms@kernel.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>
References: <20241025162042.905104-1-gpiccoli@igalia.com>
 <SN6PR02MB41577D176FD038A3D630296DD4492@SN6PR02MB4157.namprd02.prod.outlook.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <SN6PR02MB41577D176FD038A3D630296DD4492@SN6PR02MB4157.namprd02.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_134333_757337_C9FC8107 
X-CRM114-Status: GOOD (  16.78  )
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

On 27/10/2024 15:16, Michael Kelley wrote:
> [...]
>>  	crash_kexec_post_notifiers
>> -			Run kdump after running panic-notifiers and dumping
>> -			kmsg. This only for the users who doubt kdump always
>> -			succeeds in any situation.
>> -			Note that this also increases risks of kdump failure,
>> -			because some panic notifiers can make the crashed
>> -			kernel more unstable.
>> +			Only jump to kdump kernel after running the panic
>> +			notifiers and dumping kmsg. This option increases
>> +			the risks of a kdump failure, since some panic
>> +			notifiers can make the crashed kernel more unstable.
>> +			In configurations where kdump may not be reliable,
>> +			running the panic notifiers could allow collecting
>> +			more data on dmesg, like stack traces from other CPUS
>> +			or extra data dumped by panic_print. Note that some
>> +			configurations enable this option unconditionally,
>> +			like Hyper-V, PowerPC (fadump) and AMD SEV.
> 
> This last line should be more specific and use "AMD SEV-SNP" instead of
> just "AMD SEV". Commit 8ef979584ea8 that you mentioned above is
> specific to SEV-SNP.
> 
> There have been three versions of SEV functionality in AMD processors:
> * SEV:  the original guest VM encryption
> * SEV-ES:  SEV enhanced to cover register state as well
> * SEV-SNP:  SEV-ES plus Secure Nested Paging, which provides
> functionality to address the Confidential Computing VM threat model
> described in the Linux CoCo VM documentation. SEV-SNP processors are
> AMD's product that is widely deployed for CoCo VMs in large public clouds.
> 
> Just using "SEV" is somewhat ambiguous because it's not clear whether
> it refers to the family of three SEV levels, or just the original guest VM
> encryption. Since this case is clearly SEV-SNP only, being specific removes
> the ambiguity.
> 
> Michael

Thanks a lot Michael, for the clarification. I've just sent a V4
updating that.
Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
