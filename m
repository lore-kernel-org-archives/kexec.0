Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7023BC021A4
	for <kexec@archiver.kernel.org>; Mon, 24 Feb 2025 23:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9MyoYHOlezsCiyRipc+Ai3jbgANrCAW1Nz/SR6iLSG0=; b=TNqbejGeI/VMuUvg5PGJKFcx2H
	g9qmHe7d41j9z2Sv2pv1FcwY8KhVBj1JnOcSCJAVjIXZsYl3iVO7Xx7daznA5980tcFxa8MSFVL8Y
	y8NasuXF1aPV+TNsJEdEE1vpRTx8qjo+H3Wnrep/EFU9tq22NqTo/2X03g2mIh85njoU46AXWVf4W
	+LFszP8dDk5RseDCCDXEBiZGKmxrHSC99bjxIK4L3XSCh4v8XIyD33q6vnYsbJ+tXnJD453VNrQto
	3O6L9yibXKRg8LyKDCAln01W3lJTrK+tnh4OM4t8fwX7vry09zk1BZ9qt65GtuWB2VZlGZ1o+u1O5
	vmFsrAAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmhWA-0000000FRQo-0r0t;
	Mon, 24 Feb 2025 23:05:42 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmhW7-0000000FRQQ-2s8C
	for kexec@lists.infradead.org;
	Mon, 24 Feb 2025 23:05:40 +0000
Received: from [10.17.64.108] (unknown [131.107.147.236])
	by linux.microsoft.com (Postfix) with ESMTPSA id BFBC0203CDE5;
	Mon, 24 Feb 2025 15:05:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BFBC0203CDE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740438338;
	bh=9MyoYHOlezsCiyRipc+Ai3jbgANrCAW1Nz/SR6iLSG0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BewR2QQbanLDaGC2OZXUdPzQXUx3togJgoyfFUuDpnJwJqJJ2repwj7aieQhfPKSG
	 J1bvIr72exvJ1CEo3AAcEbFCl8ZtZPlrF1tzM1ZoTby97pRhA5epMNkg4Fkco6kYG+
	 xBKe8llQLbWED05MRZi3Bt/Zs2JAeaU0RiKFNZT0=
Message-ID: <658b52e4-a4bb-40fc-a00b-bfdb3bf15b52@linux.microsoft.com>
Date: Mon, 24 Feb 2025 15:05:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-3-chenste@linux.microsoft.com>
 <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_150539_758360_0755CA6F 
X-CRM114-Status: GOOD (  14.51  )
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

On 2/23/2025 10:14 PM, Baoquan He wrote:
> Hi Steve, Mimi,
>
> On 02/18/25 at 02:54pm, steven chen wrote:
>> Currently, the mechanism to map and unmap segments to the kimage
>> structure is not available to the subsystems outside of kexec.  This
>> functionality is needed when IMA is allocating the memory segments
>> during kexec 'load' operation.  Implement functions to map and unmap
>> segments to kimage.
> I am done with the whole patchset understanding. My concern is if this
> TPM PCRs content can be carried over through newly introduced KHO. I can
> see that these patchset doesn't introduce too much new code changes,
> while if many conponents need do this, kexec reboot will be patched all
> over its body and become ugly and hard to maintain.
>
> Please check Mike Rapoport's v4 patchset to see if IMA can register
> itself to KHO and do somthing during 2nd kernel init to restore those
> TPM PCRs content to make sure all measurement logs are read correctly.
> [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
>
> Thanks
> Baoquan

Hi Baoquan,

For IMA, it appears that there are no current issues with TPM PCRs after 
a kernel soft reboot.

This patches is used to get currently missed IMA measurements during the 
kexec process copied to new kernel after the kernel soft reboot. I think 
it's ok to leave it at current location: it will be easy to maintain for 
IMA.

Overall, for these patches, do you see any major blockers for kexec?

If you have any specific concerns or need further details, please let me 
know.

Thanks,

Steven

