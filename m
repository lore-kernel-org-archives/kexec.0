Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA23C433EF
	for <kexec@archiver.kernel.org>; Tue,  5 Jul 2022 01:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7u1U4+JBBS0G+xqqtAdseqiXfpCTPfGX4IeVl6HFkVo=; b=OETC4ozJgLMa1k
	dbNPY3OWbrs2hweQ+iUo3T00kCVOxq536xg2bvb9cq6EAw39FTKDn4mJ57aPrZB0Leb6/M7fI0xrm
	Ep6kf+dQpv/8eoQAuKhNTP2zjqIk1JjGZg2/i76Mz0gNpkilvRKGPC6Bd9NGXo9g5SSQt/ZT1IwkY
	nZcYuTO0o1yX/u1iBEm552O+C0Ha3zsaIlxdDVSlxO2Grkh1BgSw1kUc6Zf5AyQ+czI8TD8R5ipBd
	CxBecrU6SCllKWEf7fDkmOqXpt2SzIAS34T2oB6/nBi4/LX2ST/QmkHLBTib7dnSbD7tQKVdI0Uvs
	3L3wwlES2m5xgQSUoAtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8XoS-00DuS6-Cw; Tue, 05 Jul 2022 01:57:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8XoM-00DuOG-Bs
	for kexec@lists.infradead.org; Tue, 05 Jul 2022 01:57:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656986225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0NC/eC1lPxFvKCJBfy26CWHeOBX1P9jbiKqcYaXCqrA=;
	b=h1Yz9CT9LtrPapRo6bzgWoZI8gvIBtx5Ot/Jwbh6HlBVoI4OsOIQem4hUdW7cKcKqIWEZ1
	sFcuRW88eY+nXs/lR0JLgVZuI2J/XuqgIJu8KAk/pXPA22H6GbxNiShr4GZwuBJtUscw2z
	ktagqI0zyUMP1C1sTLbduDLb9aIxKqs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-uRHuuSnmMVexQhT7n8YAwA-1; Mon, 04 Jul 2022 21:57:00 -0400
X-MC-Unique: uRHuuSnmMVexQhT7n8YAwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32BFA1C05148;
	Tue,  5 Jul 2022 01:57:00 +0000 (UTC)
Received: from localhost (ovpn-13-74.pek2.redhat.com [10.72.13.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 788822166B26;
	Tue,  5 Jul 2022 01:56:59 +0000 (UTC)
Date: Tue, 5 Jul 2022 09:56:55 +0800
From: Baoquan He <bhe@redhat.com>
To: Kaihao Bai <carlo.bai@linux.alibaba.com>
Cc: ebiederm@xmission.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com
Subject: Re: [PATCH 0/2] kexec: accumulate and release the size of crashkernel
Message-ID: <YsOaZ/IETqnWO2uI@MiWiFi-R3L-srv>
References: <1656934895-12334-1-git-send-email-carlo.bai@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1656934895-12334-1-git-send-email-carlo.bai@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_185710_517741_86F37DE9 
X-CRM114-Status: GOOD (  19.02  )
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

On 07/04/22 at 07:41pm, Kaihao Bai wrote:
> Currently x86 and arm64 support to reserve low memory range for
> crashkernel. When crashkernel=Y,low is defined, the main kernel would
> reserve another memblock (instead of crashkernel=X,high, which stored
> in crashk_res) for crashkernel and store it in crashk_low_res.
> 
> The implementations of get_crash_size and crash_shrink_size do not
> consider the extra reserved memory range if it exists. Thus, firstly
> accumulate this range on the size of crashkernel and export the size 
> by /sys/kernel/kexec_crash_size.
> 
> If getting the input of /sys/kernel/kexec_crash_size, both reserved ranges
> might be released if the new size is smaller than current size. The order
> of release is (crashk_res -> crashk_low_res). Only if the new size defined
> by the user is smaller than the size of low memory range, continue to 
> release the reserved low memory range after completely releasing the high 
> memory range.

Sorry, I don't like this patchset.

I bet you don't encounter a real problem in your product environment.
Regarding crashkernel=,high|low, the ,low memory is for DMA and
requirement from memory under lower range. The ,high meomry is for
kernel/initrd loading, kernel data, user space program running. When
you configure crashkernel= in your system, you need evaluate what
value is suitable. /sys/kernel/kexec_crash_size is an interface you
can make use of to tune the memory usage. People are not suggested to
free all crashkernel reservation via the interface. 

So, please leave this as is, unless you have a real case where this
change is needed.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
