Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395B3E732E7
	for <kexec@archiver.kernel.org>; Thu, 28 Sep 2023 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QaEP83MT5ed53IhcFVtUAsgVY3m6AzWI40N53m9VuxA=; b=uH29Kht4M8PzQt
	ORckFdvRaiYNqxT/2gYRfLv/r2aGg//OQql16wKAYb+7x6LQo9Ap8DDbh5o7jc/vOPWZKpPOumYFn
	4UPb+XvhWPTWadxDqDaykbRE579NB27+bNaDBSFcsY9bXdOint24JHFO95UzsGLQwBPdBqMd5MRQs
	pkBqKtK92Mz6ebHmz3U0aOxearp9M7v6vq3cf0TXOWsjlVH/sfTY5t8yyLbqYhoz0bwXnf/9x29P7
	OCSXK5jGqt2GunHWSjvZ34/+ojbTdQnJsU3dZs5j3cVaIT3YABIBKWvZ2XU3wWgOU1lX70m0IbLpX
	JV71hTzLk9tLlaG49hCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qltyv-0064Sx-10;
	Thu, 28 Sep 2023 16:35:17 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qltyq-0064Lw-0B
	for kexec@lists.infradead.org;
	Thu, 28 Sep 2023 16:35:15 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8A59F20B74C0;
	Thu, 28 Sep 2023 09:35:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A59F20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695918908;
	bh=20rY7wCfQkNIai47fHlCR2wiN/P/+IE4P5kF7PJk2Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cm2G3VB74wif6uU/gwtXWT1K2ZNlYLauxazS8xqu+ch2bgGeRNMojVmIISOmrFVfD
	 HMKW9vSG9S/9Xr9CRzDlGb2gFLMIjUnDnwqnCxviIozFMyfKNhJlvsxBxXF/l2Tf5w
	 JfmJkA3d67Lx65PqBMYNUD4rNQ7mG9RW/4TtqD/E=
Date: Wed, 27 Sep 2023 15:44:45 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Baoquan He <bhe@redhat.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	ebiederm@xmission.com, akpm@linux-foundation.org,
	stanislav.kinsburskii@gmail.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, kys@microsoft.com, jgowans@amazon.com,
	wei.liu@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	graf@amazon.de, pbonzini@redhat.com, david@redhat.com
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Message-ID: <20230927224445.GA20200@skinsburskii.>
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv>
 <58146.123092712145601339@us-mta-73.us.mimecast.lan>
 <ZRVUqLSH7HfVLy+G@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZRVUqLSH7HfVLy+G@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_093512_147804_8D38B801 
X-CRM114-Status: GOOD (  25.17  )
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

On Thu, Sep 28, 2023 at 06:25:44PM +0800, Baoquan He wrote:
> On 09/27/23 at 09:13am, Stanislav Kinsburskii wrote:
> > On Wed, Sep 27, 2023 at 01:44:38PM +0800, Baoquan He wrote:
> > > Hi Stanislav,
> > > 
> > > On 09/25/23 at 02:27pm, Stanislav Kinsburskii wrote:
> > > > This patch introduces a memory allocator specifically tailored for
> > > > persistent memory within the kernel. The allocator maintains
> > > > kernel-specific states like DMA passthrough device states, IOMMU state, and
> > > > more across kexec.
> > > 
> > > Can you give more details about how this persistent memory pool will be
> > > utilized in a actual scenario? I mean, what problem have you met so that
> > > you have to introduce persistent memory pool to solve it?
> > > 
> > 
> > The major reason we have at the moment, is that Linux root partition
> > running on top of the Microsoft hypervisor needs to deposit pages to
> > hypervisor in runtime, when hypervisor runs out of memory.
> > "Depositing" here means, that Linux passes a set of its PFNs to the
> > hypervisor via hypercall, and hypervisor then uses these pages for its
> > own needs.
> > 
> > Once deposited, these pages can't be accessed by Linux anymore and thus
> > must be preserved in "used" state across kexec, as hypervisor state is
> > unware of kexec. In the same time, these pages can we withdrawn when
> > usused. Thus, an allocator persistent across kexec looks reasonable for
> > this particular matter.
> 
> Thanks for these details.
>  
> The deposit and withdraw remind me the Balloon driver, David's virtio-mem,
> DLPAR on ppc which can hot increasing or shrinking phisical memory on guest
> OS. Can't microsoft hypervisor do the similar thing to reclaim or give
> back the memory from or to the 'Linux root partition' running on top of
> the hypervisor?
> 

Although Microsoft hypervisor is a type 1 hypervisor and runs on the
physical hardware, like Xen, it doens't control all the memory, but is
rather granted with memory by either boot loader or by Linux root
partition (similar priveleged VM is called "Dom0" in Xen world). IOW,
this works in the oposite direction: Linux gives memory to hypervisor,
and can reclaim it back. However, doing so on kexec increases downtime
as withdrawn pages must be deposited back again after booting to restore
the guests ("DomU" in Xen terminology).

It worth mentionining, that the "deposited pages" in this context don't
mean guest pages, but the pages required by the hypevisor to store Linux
root partition state user to control guest partitions.

Also, pages reclaim is not possible, if guests are left running during
kexec, as hypervisor requires to keep the Linux root partition-related
state intact to keep the guest state consistent.

> Thanks
> Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
