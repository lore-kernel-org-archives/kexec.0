Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E3BC54E58
	for <kexec@archiver.kernel.org>; Tue, 19 Mar 2024 01:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=esH83bJYv/+1Vvm/Yupr8n/406LPAtnZjUK7Kw4xpAY=; b=pVGdfyByG42XII
	u1ahBFkGB1gbjY7eozvwiIapvEJjB0iQzGKU+L8CQ955vNe4MzfXTxFAaWP5qewy0YczqXHx1HmeY
	57Kv6jytMXshEYRjJO+gDak+Y5usnI0/1GxU6SGYboxdujI1/rhZl2l90v3woqDDVIjbckiGChrL2
	4IG83/HhHq1WtqrMMdUTjMTTTP+3yvlpXDlTNZhucVQPzxV0A/rg+v06hHO4rzplUh6Pxco5jW/65
	UDb4PE31jz4pDgU6yRQ9yVGb0WXpw3lCFAa78PKRD7+R5W9V+NWjeR5RPk5coyMY+SggcvW1r1Nrl
	c6GNMuJx41m5Qan+J/3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmOQy-0000000Ap3B-3030;
	Tue, 19 Mar 2024 01:38:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmOQw-0000000Ap2N-0Vkq
	for kexec@lists.infradead.org;
	Tue, 19 Mar 2024 01:38:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710812307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BKYWZD3ZKBHI70bqBojEC4VRPabr3cre9/djQeSrwNg=;
	b=aFV3kSM6+rFlztgDG5JpvIW2nFTbXBbgBrgKsfEE49dosWAshlfHh+mDGdMCXek5gdcryS
	nEusqs8HlujnSGiX2LP41jrQVeVWoDnbCw88Ynr0CSJj0WnNeU3uNslvleyFuSgY2O/3UM
	I94vgp+0bukN8RbVI0dlBfC2TfnJx2A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-Xl70_6CmM7CmeX9Q8x3t1g-1; Mon, 18 Mar 2024 21:38:21 -0400
X-MC-Unique: Xl70_6CmM7CmeX9Q8x3t1g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B244811E81;
	Tue, 19 Mar 2024 01:38:21 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DCA28492BC4;
	Tue, 19 Mar 2024 01:38:20 +0000 (UTC)
Date: Tue, 19 Mar 2024 09:38:12 +0800
From: Baoquan He <bhe@redhat.com>
To: "chenhaixiang (A)" <chenhaixiang3@huawei.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	Louhongxiang <louhongxiang@huawei.com>,
	"wangbin (A)" <wangbin224@huawei.com>,
	"Fangchuangchuang(Fcc,Euler)" <fangchuangchuang@huawei.com>
Subject: Re: Question about Address Range Validation in Crash Kernel
 Allocation
Message-ID: <ZfjshNK7Nbdz1de3@MiWiFi-R3L-srv>
References: <8606fd02d6de4eb3b7c80e4ce3449458@huawei.com>
MIME-Version: 1.0
In-Reply-To: <8606fd02d6de4eb3b7c80e4ce3449458@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_183830_252215_9A3DD1C8 
X-CRM114-Status: GOOD (  21.41  )
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

Hi,

On 03/18/24 at 12:00pm, chenhaixiang (A) wrote:
> Dear kexec Community Members,
> 
> I encountered an issue while using kexec-tools on my x86_64 machine.
> When there is a segment marked as 'reserved' within the memory range allocated for the crash kernel in /proc/iomem,the output appears as follows:
> 2d4fd058-60efefff : System RAM
>   2d4fd058-58ffffff : System RAM
>     49000000-58ffffff : Crash kernel
>       53cbd000-53ccffff : Reserved

What kernel are you using? the version of kernel, and kexec-tools?

If you are testing on the latest mainline kernel, you could meet the
issue Dave have met and fixed in below patch:

[PATCH] x86/kexec: do not update E820 kexec table for setup_data
https://lore.kernel.org/all/ZeZ2Kos-OOZNSrmO@darkstar.users.ipa.redhat.com/T/#u

Thanks
Baoquan

> 
> The crash_memory_range array will encounter incorrect address ranges:
> CRASH MEMORY RANGES
> 000000002d4fd058-0000000048ffffff (0)
> 0000000053cbd000-0000000048ffffff (1)
> 0000000059000000-0000000053ccffff (0)
> 
> Read the code, I noticed that the get_crash_memory_ranges() function invokes exclude_region() to handle the splitting of memory regions, but it seems unable to properly handle the scenario described above.
> The code logic is as follows:
> ...
> 	if (start < mend && end > mstart) {
> 		if (start != mstart && end != mend) {
> 			/* Split memory region */
> 			crash_memory_range[i].end = start - 1;
> 			temp_region.start = end + 1;
> 			temp_region.end = mend;
> 			temp_region.type = RANGE_RAM;
> 			tidx = i+1;
> 		} else if (start != mstart)
> 			crash_memory_range[i].end = start - 1;
> 		else
> 			crash_memory_range[i].start = end + 1;
> 	}
> ...
> If start < mstart < mend < end, resulting in crash_memory_range[i].end becoming less than crash_memory_range[i].start, leading to incorrect address ranges.
> I would like to know if this behavior is reasonable and whether it is necessary to validate the address ranges for compliance at the end.
> 
> Thank you for your time and assistance.
> 
> Chen Haixiang
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
