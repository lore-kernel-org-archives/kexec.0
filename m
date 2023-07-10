Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5F5EB64D9
	for <kexec@archiver.kernel.org>; Mon, 10 Jul 2023 09:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZYtq0W7DE723uLJ9Byw78F13Ndd+9dlcogaYkrmujog=; b=obOYCd8+ePBCnA
	IlO2Rll/d969Z3gPodbdDMbbmhEElSmopE07+WtbqDiQQRG27Ygkr/BACZdAQd8sCuDF43Yvpdlor
	jhl4b+MmEHLMyyoFVkatBpWJSjuNuVfXsjhzKIusuuEfq61jyH95xXlAJ3s6ClqhuX0zAWDx5R09N
	6R/+q94qlIofdDpE+22TBqM+ftHA3EQjwgLk+ZAGPO+lTyXdIUkzyPAkasJXOwWx1PX7rns2qX5Tx
	d7nzuaqoXLt6jqE1OoQDLAoho6RDotPi68E5bTmer8X6NYh75oTOx0UqDzy5+p7DBC1sx7vewuFIh
	1CAV93RW34MoMNwKn8lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qImyd-00AyOk-1h;
	Mon, 10 Jul 2023 09:14:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qImyX-00AyNA-2u
	for kexec@lists.infradead.org;
	Mon, 10 Jul 2023 09:14:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688980473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZxZGq4D+R9v/uHRHPVTjCJO+HqCh9drWSD3QE0wPss=;
	b=X7L7x/IpgdmYo6AmphjHLOIq/8RQvL0RLeLXVBSJljiPotimNtxNuwiEqpp8M9NGgmdv8A
	r7/TQFNd3Xlj6IBmQFSfIpHTy+Bqi2l5To7I+x+NJl2WoEt9Co8Wkz1nt44k24b2xrerE+
	txEWXCxva78KFx8bw8sl1k4gn4wywPs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-dq1Pi2d5OE2_NXrRq89yKg-1; Mon, 10 Jul 2023 05:14:28 -0400
X-MC-Unique: dq1Pi2d5OE2_NXrRq89yKg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 358492A59568;
	Mon, 10 Jul 2023 09:14:28 +0000 (UTC)
Received: from ovpn-8-31.pek2.redhat.com (ovpn-8-33.pek2.redhat.com [10.72.8.33])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 427E32017DCB;
	Mon, 10 Jul 2023 09:14:19 +0000 (UTC)
Date: Mon, 10 Jul 2023 17:14:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Wen Xiong <wenxiong@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate
 io queues
Message-ID: <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
References: <20230708020259.1343736-1-ming.lei@redhat.com>
 <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230710064109.GB24519@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_021434_010889_D5136C8B 
X-CRM114-Status: GOOD (  15.98  )
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

On Mon, Jul 10, 2023 at 08:41:09AM +0200, Christoph Hellwig wrote:
> On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> > Take blk-mq's knowledge into account for calculating io queues.
> > 
> > Fix wrong queue mapping in case of kdump kernel.
> > 
> > On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
> > `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> > still returns all CPUs.
> 
> That's simply broken.  Please fix the arch code to make sure
> it does not return a bogus num_possible_cpus value for these

That is documented in Documentation/admin-guide/kdump/kdump.rst.

On arm and ppc64, 'maxcpus=1' is passed for kdump kernel, and "maxcpu=1"
simply keep one of CPU cores as online, and others as offline.

So Cc our arch(arm & ppc64) & kdump guys wrt. passing 'maxcpus=1' for
kdump kernel.

> setups, otherwise you'll have to paper over it in all kind of
> drivers.

The issue is only triggered for drivers which use managed irq &
multiple hw queues.


Thanks,
Ming


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
