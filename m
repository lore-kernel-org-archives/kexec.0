Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629E9CE7B19
	for <kexec@archiver.kernel.org>; Thu, 28 Sep 2023 10:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J+t0w2rpm0h6SWq1wyDHshDdFarwEtG5hb97I2de+Uk=; b=lH717XwaoqBcg2
	MlgvmY9TdH4FBedyJocZH7YN+F441qDWjyzuH8LKvaiHlLM+p88lBzQ16FvJcDPhNXNatA20LOth/
	0TbI2l43ikhYzPy/UOtQt692My5qybCW18wPRfdm3OsxBRfX4s/BdMxvypzadJifhMONDAXwsceRL
	Rx2xeV61fesjkUqZzyQiC/XaCDgEJ3Yfmw4rBqThphcyIMiYlLNtVv1zLYaDRrXVKHMGC1qCgW/6/
	7Dpq9tD7SQX7O3450q1LjO1DA+g9R+tHvUqLrsmfglJH+0oQF7u6Z5RycF0ZtvOOBb5aPRN43aAmj
	ebDYr6BpV2wC3/YFjpPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qloDW-002pAk-2y;
	Thu, 28 Sep 2023 10:25:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qloDT-002p8l-22
	for kexec@lists.infradead.org;
	Thu, 28 Sep 2023 10:25:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695896754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AJu1zUMjVZ+lx0EEl0IqbzumrKDe4gTjJqCGJOtK7tM=;
	b=PxU131Od8bDSN7r/gAP9U4rgkrPnhYHdBRniDYZOZKKI2iHvVUDmuexYz359dAGxnKDms3
	nyucYusAXJzig61lG0KeAYTZZenLvQQJfVfoM92e0OOL7+ia5blPDlV6vLJt2JIJTK0Bf0
	o1rlxGNydEFJQLFaQIXg/SLhDAgHZ20=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-NZW55hpLN0K6FJOvmhO7Rg-1; Thu, 28 Sep 2023 06:25:50 -0400
X-MC-Unique: NZW55hpLN0K6FJOvmhO7Rg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 600CB18811FB;
	Thu, 28 Sep 2023 10:25:49 +0000 (UTC)
Received: from localhost (unknown [10.72.112.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C4770492B16;
	Thu, 28 Sep 2023 10:25:47 +0000 (UTC)
Date: Thu, 28 Sep 2023 18:25:44 +0800
From: Baoquan He <bhe@redhat.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	ebiederm@xmission.com, akpm@linux-foundation.org,
	stanislav.kinsburskii@gmail.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, kys@microsoft.com, jgowans@amazon.com,
	wei.liu@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	graf@amazon.de, pbonzini@redhat.com, david@redhat.com
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Message-ID: <ZRVUqLSH7HfVLy+G@MiWiFi-R3L-srv>
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv>
 <58146.123092712145601339@us-mta-73.us.mimecast.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58146.123092712145601339@us-mta-73.us.mimecast.lan>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_032555_758226_0F545AB7 
X-CRM114-Status: GOOD (  20.58  )
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

On 09/27/23 at 09:13am, Stanislav Kinsburskii wrote:
> On Wed, Sep 27, 2023 at 01:44:38PM +0800, Baoquan He wrote:
> > Hi Stanislav,
> > 
> > On 09/25/23 at 02:27pm, Stanislav Kinsburskii wrote:
> > > This patch introduces a memory allocator specifically tailored for
> > > persistent memory within the kernel. The allocator maintains
> > > kernel-specific states like DMA passthrough device states, IOMMU state, and
> > > more across kexec.
> > 
> > Can you give more details about how this persistent memory pool will be
> > utilized in a actual scenario? I mean, what problem have you met so that
> > you have to introduce persistent memory pool to solve it?
> > 
> 
> The major reason we have at the moment, is that Linux root partition
> running on top of the Microsoft hypervisor needs to deposit pages to
> hypervisor in runtime, when hypervisor runs out of memory.
> "Depositing" here means, that Linux passes a set of its PFNs to the
> hypervisor via hypercall, and hypervisor then uses these pages for its
> own needs.
> 
> Once deposited, these pages can't be accessed by Linux anymore and thus
> must be preserved in "used" state across kexec, as hypervisor state is
> unware of kexec. In the same time, these pages can we withdrawn when
> usused. Thus, an allocator persistent across kexec looks reasonable for
> this particular matter.

Thanks for these details.
 
The deposit and withdraw remind me the Balloon driver, David's virtio-mem,
DLPAR on ppc which can hot increasing or shrinking phisical memory on guest
OS. Can't microsoft hypervisor do the similar thing to reclaim or give
back the memory from or to the 'Linux root partition' running on top of
the hypervisor?

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
