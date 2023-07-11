Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E76EB64DC
	for <kexec@archiver.kernel.org>; Tue, 11 Jul 2023 07:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5CNmWoczEc6vgtyeIzxSHRtPqzg78kulEnAWNQYbhgU=; b=dB1u3c1IBnA3YN
	EtZP2cag2eldynhxAejk9yvwQfN+H5COTZPz6nk3uNlgGQpo2dzziqUKQKh8LHb6I8LmJXhGkVbrp
	SvmEndlfUt73L8dbiN+RpR3lR21AcDHwsEREHX6PtrMzffK4WMFyFLVd4ciNkPWnXm1OU8JIraFSI
	cr/CnJYCdwuBpE2FES8TSlGLyiam1Auiu63tFNghK2u8KCb9x0oMbRDlUuVDf7m0wWqpkNG/Cy6ui
	zpOTA4Bn/1500Orl2NYjQl7/Em/q0epWM/h+1UU6TlXCOVnakFwEndIG0wzc4bClArb7nW7Uc09XA
	C2szK4LaXWkkMSb80w2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ7Mo-00DwJ8-35;
	Tue, 11 Jul 2023 07:00:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ7Mj-00DwGN-07
	for kexec@lists.infradead.org;
	Tue, 11 Jul 2023 07:00:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689058851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v7BjYj/I+4PNhxODpnsSg7iMK5tRoeIrCo2+55CRjhI=;
	b=IZSdxgbGu/FOx0dGni/61HoPcxWYBR1/DDQG3xAzuIilyQbYHAC4h8SAs6X8txWqY37RGh
	9RBetHoegFQy5ixBE/SCfANV2zN1uYXQdPgCtIfQPliRGAl++oXPqHhGeFfrcPXQPiR6KB
	5+1tVEztsVPdlAqViHJ9jSNJa71/saY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-PfcYMSaXMaKpVE0zvE3fRA-1; Tue, 11 Jul 2023 03:00:45 -0400
X-MC-Unique: PfcYMSaXMaKpVE0zvE3fRA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F6FA856506;
	Tue, 11 Jul 2023 07:00:44 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B333A492B01;
	Tue, 11 Jul 2023 07:00:05 +0000 (UTC)
Date: Tue, 11 Jul 2023 14:59:35 +0800
From: Baoquan He <bhe@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate
 io queues
Message-ID: <ZKz912KyFQ7q9qwL@MiWiFi-R3L-srv>
References: <20230708020259.1343736-1-ming.lei@redhat.com>
 <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de>
 <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
 <ZKzOFkokjTVwd4Ry@MiWiFi-R3L-srv>
 <ZKzSHDPR7Jfoz/G8@ovpn-8-26.pek2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZKzSHDPR7Jfoz/G8@ovpn-8-26.pek2.redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_000053_379554_6D7AC54D 
X-CRM114-Status: GOOD (  30.95  )
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

On 07/11/23 at 11:53am, Ming Lei wrote:
> Hi Baoquan,
> 
> On Tue, Jul 11, 2023 at 11:35:50AM +0800, Baoquan He wrote:
> > On 07/10/23 at 05:14pm, Ming Lei wrote:
> > > On Mon, Jul 10, 2023 at 08:41:09AM +0200, Christoph Hellwig wrote:
> > > > On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> > > > > Take blk-mq's knowledge into account for calculating io queues.
> > > > > 
> > > > > Fix wrong queue mapping in case of kdump kernel.
> > > > > 
> > > > > On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
> > > > > `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> > > > > still returns all CPUs.
> > > > 
> > > > That's simply broken.  Please fix the arch code to make sure
> > > > it does not return a bogus num_possible_cpus value for these
> > > 
> > > That is documented in Documentation/admin-guide/kdump/kdump.rst.
> > > 
> > > On arm and ppc64, 'maxcpus=1' is passed for kdump kernel, and "maxcpu=1"
> > > simply keep one of CPU cores as online, and others as offline.
> > 
> > I don't know maxcpus on arm and ppc64 well. But maxcpus=1 or nr_cpus=1
> > are suggested parameter. Because usually nr_cpus=1 is enough to make
> > kdump kernel work well to capture vmcore. However, user is allowed to
> > specify nr_cpus=n (n>1) if they think multiple cpus are needed in kdump
> > kernel. Your hard coding of cpu number in kdump kernel may be not so
> > reasonable.
> 
> As I mentioned, for arm/ppc64, passing 'maxcpus=1' actually follows
> Documentation/admin-guide/kdump/kdump.rst.
> 
> 'nr_cpus=N' just works fine, so not related with this topic.
> 
> After 'maxcpus=1' is passed, kernel only brings up one of cpu cores as
> online during booting, and others still can be put into online by
> userspace. Now this way causes IO timeout on some storage device which
> uses managed irq and supports multiple io queues.
> 
> Here the focus is if passing 'maxcpus=1' is valid for kdump
> kernel, that is we want to hear from our arch/kdump guys.

Yes, 'maxcpus=1' is valid and suggested on ppc64 for kdump kernel
if needed, because there's no 'nr_cpus=' support on ppc64 yet.

> 
> If yes, something needs to be fixed, such as, what this patchset is
> doing.
> 
> > 
> > Please cc kexec mailing list when posting so that people can view the
> > whole thread of discussion.
> 
> Already Cc kexe & arm/powerpc & irq list.
> 
> 
> Thanks,
> Ming
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
