Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBBFC05027
	for <kexec@archiver.kernel.org>; Mon,  6 Feb 2023 13:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=82ZztGUdW0NiMTUjjxiNxya7ajUeo3zlZgNfJu29KK4=; b=vsubuY85oZALj8
	KrTcljLS/GbMYPnLB4zx0oaietNddWJIov2gA7a08I8KbVAMjw3cSJtAtoVluddpIToTRX+5SSNTx
	Gbyt6oeVv2jTdA95doN+JYaJQlaz7yMjO1zhjgX0bXGrhX5jmqyqWSY7+TK83SmPsgdKM74Jc2C3f
	bbWEZJVT4iLqGCXBRTyLehC92cEIXn3/ThlZrIX9HP2XOEFtxzN2WcI+/SVrTfnXSr2YCMY+LeEIg
	NC5IM+G3v6D8JoYm2zLYPSBb1L9UcmunMDKYxE8LAJxS3LB6kmZCrHNjaFV8SiOJYwZWEO3LSEEfN
	XoLzd1PI82tB5WfSaThw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP19o-008Znx-0H; Mon, 06 Feb 2023 13:03:40 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP19h-008Zki-UK
	for kexec@lists.infradead.org; Mon, 06 Feb 2023 13:03:35 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1675688609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oYHI1jbFdGXhe6qIvHJHxe9o/y0Q9Zxojj50+J8Zwk4=;
	b=NWYFuyYE7b0tuBHTJOxcYCgAnoSp3h1UbUe9ccgOe4tFZZQB06KAjQgK3DZ7/gAwURYn41
	LHy6oLaOwyMlKSK5sownXg8CY6Oos2cU2yQ1ODCrjg8QGXK+Y/uh2nt96TAZe2eZNzbrRn
	rOXJ7aj1CazZ6Eeauycoe1lxdsaF4WO8cdY0YoPoNg17LgD5FUtZHdaliUBznpOV6N8dR5
	lZNrW/ZyXRlBqWdhhYllwWaGMTAbmy9Q3BBOtqpBz0ZJ+yoPClSa+V0zHpfV0/cCY4lwvj
	C1KUd9QzDVq+smXS1d6xUmkJsa2dJqS2hGvvTZ/EVlBrepHIDS7K3Cnc4q6r6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1675688609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oYHI1jbFdGXhe6qIvHJHxe9o/y0Q9Zxojj50+J8Zwk4=;
	b=qLrSgtbmRVYWO5RluyJBrdjMcgRG8fhCYnHwWU9fTeoIbhgHPzZH5LJAmIl/uc3iJwHsm6
	9ccGBaH+Cp4FoTAA==
To: Sourabh Jain <sourabhjain@linux.ibm.com>, Eric DeVolder
 <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com,
 bhe@redhat.com, vgoyal@redhat.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
 robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
In-Reply-To: <8308e930-6b55-5756-d653-5c623a8ea758@linux.ibm.com>
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <8308e930-6b55-5756-d653-5c623a8ea758@linux.ibm.com>
Date: Mon, 06 Feb 2023 14:03:28 +0100
Message-ID: <87357jymhr.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230206_050334_155503_65C8044B 
X-CRM114-Status: GOOD (  12.90  )
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

On Mon, Feb 06 2023 at 13:42, Sourabh Jain wrote:
> On 01/02/23 17:03, Thomas Gleixner wrote:
>> Also in case of loading the crash kernel in the situation where not all
>> present CPUs are online (think boot time SMT disable) then your
>> resulting crash image will contain all present CPUs and none of the
>> offline CPUs are excluded.
>>
>> How does that make any sense at all?
>>
>> This image->hp_action and image->offlinecpu dance is engineering
>> voodoo. You just can do:
>>
>>          for_each_present_cpu(cpu) {
>>              if (!cpu_online(cpu))
>>              	continue;
>>              do_stuff(cpu);
>>
>> which does the right thing in all situations and can be further
>> simplified to:
>>
>>          for_each_online_cpu(cpu) {
>>              do_stuff(cpu);
>
> What will be the implication on x86 if we pack PT_NOTE for possible
> CPUs?

I don't know.

> IIUC, on boot the crash notes are create for possible CPUs using pcpu_alloc
> and when the system is on crash path the crash notes for online CPUs is
> populated with the required data and rest crash notes are untouched.

Which should be fine. That's a problem of postprocessing and it's
unclear to me from the changelogs what the actual problem is which is
trying to be solved here.

Thanks,

        tglx



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
