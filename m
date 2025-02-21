Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FCAC021B3
	for <kexec@archiver.kernel.org>; Fri, 21 Feb 2025 21:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q7qimWw3fn4gbEHfpk5d5zJg4X5BJznDEs8fnMd9NWU=; b=Ywv4iBAamELm+KQsnvwtbZqNXL
	Q6OjyTlWgo5u0thjpWMY66LHN32Q53TUXNcevDoUixW9y+bRRxEKNCHGY6ZUBxrDT/qYS+8ycE4VU
	TIE75PyOx0o1EdolABXAqfB1k0jJI5GE2arC4CQw214p+rL14q2CzITcZlJawhjoc6Q5hIAw3KXIE
	cLyp/FJFP/6gsdmt82+OMRQ4vIfd0pCnXtcteRZlsuzzYxFKkrgw5dkuDl8D3uDLfNO6QlljFjY7w
	EBprLMwvdOBELMvYrEUHtiwtTKkL+aiT7UUzzdzeZSP/4QH/b+3ctAHTAkdjkysHT3CsluINKRs0+
	DNYg44RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlaAq-00000006rdp-1hkB;
	Fri, 21 Feb 2025 21:03:04 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlaAn-00000006rcj-2r2j
	for kexec@lists.infradead.org;
	Fri, 21 Feb 2025 21:03:03 +0000
Received: from [10.17.64.59] (unknown [131.107.8.59])
	by linux.microsoft.com (Postfix) with ESMTPSA id C3AD82053679;
	Fri, 21 Feb 2025 13:02:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C3AD82053679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740171780;
	bh=q7qimWw3fn4gbEHfpk5d5zJg4X5BJznDEs8fnMd9NWU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QrZAWW+WlDUN2t1FYwRI+vhXC2SlIyYK0t/b7MF+3kKSdrBoY839/T9e5D3+y+wt+
	 Auc5gw+nuGbrsM87S9flV4lof9nA4Jb12ZAXHw4GPNRL6ojr1RWSxkWnR+F6RF42Sg
	 fnKvsKqbpJxDGL+KAz1FClIfYEGipGIyQGoWAXmI=
Message-ID: <0e82335b-ef66-46bf-a0b8-211e20fff77a@linux.microsoft.com>
Date: Fri, 21 Feb 2025 13:02:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] ima: define and call ima_alloc_kexec_file_buf
To: Mimi Zohar <zohar@linux.ibm.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, ebiederm@xmission.com,
 paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com, bhe@redhat.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-2-chenste@linux.microsoft.com>
 <8023fa50a84817cc911a117db9bd3757c34fddfb.camel@linux.ibm.com>
 <58e70121aaee33679ac295847197c1e5511b2a81.camel@HansenPartnership.com>
 <241e6b5336d1dcee751cb35554e507e552563a16.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <241e6b5336d1dcee751cb35554e507e552563a16.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_130301_746157_26F89CB0 
X-CRM114-Status: GOOD (  14.66  )
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

On 2/20/2025 8:23 AM, Mimi Zohar wrote:
> On Thu, 2025-02-20 at 10:04 -0500, James Bottomley wrote:
>> On Thu, 2025-02-20 at 09:53 -0500, Mimi Zohar wrote:
>>> On Tue, 2025-02-18 at 14:54 -0800, steven chen wrote:
>> [...
>>>> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>> Steven, thank you again for picking up this patch set.
>>>
>>> As previously explained, there is no tag named "Author" in
>>> https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
>>> .  To give credit to the original author use "Co-developed-by".
>> Just on this, only use the co-developed-by if you actually *modified*
>> the patch.  If you're just transmitting the patch unmodified you can
>> give original author credit by including a
>>
>> From: original author <email>
>>
>> Followed by a blank line at the beginning of the email.  That makes the
>> git author field contan whatever the From: line says.  You still need a
>> signoff from yourself in the original patch because you transmitted it.
>>
>> Some people also consider minor modifications to be insufficient to
>> disturb the original copyright ownership and simply document what they
>> did in square brackets under their signoff, like this:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b5d1e6ee761a109400e97ac6a1b91c57d0f6a43a
> Originally I had said:
>
>     > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>     > Signed-off-by: steven chen <chenste@linux.microsoft.com>
>
>     Before the "Co-developed-by" tag was defined, it was implied simply by this ordering
>     of the "Signed-off-by" tags.
>     
>     For those patches you didn't modify, simply import Tushar's patch with him as the
>     author and add your Signed-off-by tag after his.
>
> Thanks, James, for the explanation of using "From: original author <email>" to force the
> author to be Tushar.
>
> Mimi

Thanks, I will update in next version.


