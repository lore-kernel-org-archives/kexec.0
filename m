Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C494CD0E6E1
	for <kexec@archiver.kernel.org>; Mon, 21 Oct 2024 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y+S9Wwp63RD9mcfGEg+tBhqhjWQwUuLJZbuSjxSz8zw=; b=i4TugrbMsVf+Xb
	4udo7D77V9oc2lbB0UBCQak24EdC4tvPOqcvhpFt00shxvhcRmdYzp/Vnpx+SilKH/13ByT4JsgQM
	BFu/bFeeHX2nUJXMQgQPWN5+oZ3T8q/Nn0a6wUBU5ehZe90+GqOenDwhOWmo1wNR0x1zzwR0Gf+w8
	B5HaZwCJ729D6dBw/SnbFYB/XjoB1fvdQM1OliL2gAQUDot9G9LHLaPi2vAGDdupqtSR+m/udKbkL
	OpaHQC4jbe90f95iNr9zuIQMiSlbrDdcTiyBnYVw22fz2iLC4lzyr6abNFaAu05FxetrsLMrOV+12
	Zj8TibRT/tOdHF4AdCDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2pb8-00000006sXh-1cva;
	Mon, 21 Oct 2024 10:25:14 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2pb5-00000006sWx-2b4S
	for kexec@lists.infradead.org;
	Mon, 21 Oct 2024 10:25:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 969B65C4A66;
	Mon, 21 Oct 2024 10:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53877C4CEC7;
	Mon, 21 Oct 2024 10:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729506310;
	bh=5CAukGr/Oh38wxD5FuigV09YajMKZeAVk/sYGa++E6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gK3U/mNEIzH2iSXTegV2bu36pWGRDBQtbBsXTzxPIg2+tGPN1CrvUL9K9Q/EL0O0I
	 r+lA3IyacZTJJDU+sKzNBVR+CrkhRxVbdSG9+RDExI4FyQ2Sl/WOFq4PriGcpTNw90
	 EM8NCQhzyzU036xVom3EgWni/+X6Dmc6ni2BOBW8hQOt+E2avyQD2WLE6Cb0Ta5tPg
	 aUdNbYE4s5UgOGI+g7Q1dB1U2F/43ov0zX3f23pioeg3vkSCL1OB+0lUXIXaB42XMK
	 Ml/uy6xrUD/oOcbUUaIBFLzNYsh7U3t282C04eiJ9kY5UtSayeT2sN5tB6r/6BnXTQ
	 aPZLjYo6YbcsA==
Date: Mon, 21 Oct 2024 11:25:06 +0100
From: Simon Horman <horms@kernel.org>
To: Chen Haixiang <chenhaixiang3@huawei.com>
Cc: kexec@lists.infradead.org, louhongxiang@huawei.com,
	wangbin224@huawei.com, yangyanchao6@huawei.com
Subject: Re: [PATCH] Before adding to usablemem_rgns, check if the memory
 range is already included.
Message-ID: <20241021102506.GC402847@kernel.org>
References: <20241017123859.1377-1-chenhaixiang3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241017123859.1377-1-chenhaixiang3@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_032511_729860_75E07256 
X-CRM114-Status: UNSURE (   7.74  )
X-CRM114-Notice: Please train this message.
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

On Thu, Oct 17, 2024 at 08:38:59PM +0800, Chen Haixiang wrote:
> When kexec_iomem_for_each_line() reads from /proc/iomem,
> concurrent modifications to /proc/iomem may lead to
> usablemem_rgns recording duplicate Crash kernel segments.
> This can result in the number of retrieved Crash kernel
> segments exceeding CRASH_MAX_RESERVED_RANGES, triggering
> a realloc of the crash_reserved_mem in usablemem_rgns,
> which could crash the process. We should ensure that each
> range added to usablemem_rgns is unique to prevent these issues.

Thanks Chen Haixiang,

This looks reasonable to me, but, as per Kernel submissions,
I will need an Signed-off-by line [1] in order to apply this patch.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
