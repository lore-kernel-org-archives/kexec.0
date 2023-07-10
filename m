Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1864C001B0
	for <kexec@archiver.kernel.org>; Mon, 10 Jul 2023 16:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b5g+uyD00HXFc1A4OWhFZKN6W2+D2vxy+7u5L/0/87k=; b=OgGKsAguO8O9aR
	HfOwMx/W7CRch1w+4HI/R5jvD0b9LZ51jR+sa2ITSDWxgGUDchI3j0P8SVPkeN99uN/Z1rhb6gMxJ
	+wLay3FBub0k6JtyqvW3pd9T6viGgyA1ZmaYjAVnzLE5M5hXEw6eolq4aAsEEco2xfeVEORMVCr2I
	RftQJ5sfYN3FKXWe9F9oO7LziHZ92km4Sc5MEWg8oivFQnk2isS+z5hCKTwBEIKkwobXcj99etkKi
	g+/mfSrkniwyglaohbKUuR0bVzt041el3Rb4G6u6Qp9VTvTIU1CZDf/2cQh94Mj1PCgYicEc8l8n6
	V5S7jUJ2rZoWJoaHP7WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIu74-00CEcY-0J;
	Mon, 10 Jul 2023 16:51:50 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIu71-00CEc3-2O;
	Mon, 10 Jul 2023 16:51:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AFF196101E;
	Mon, 10 Jul 2023 16:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463C9C433C8;
	Mon, 10 Jul 2023 16:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689007906;
	bh=5z3WsJxJGTtWjrX2KHLkkdeETGptB61J+3QAspj8jBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mnFzUs11tjzs+9ReI3FmujHvobKv5/wZaFYYlv72apTaj5q+5nJjG3Xvck7oyN0Bb
	 3r44Ru3KtKzPCZgCsOL43nG19l61vH11QqTchheHpnKzoOF/dVEenhPlN7QrlfjL2c
	 FeX3O0mEnPMK13b8PlAUX6IiOnBOVP4/wLoDDuUj4ZMDIksPVrHBzd1QOTy9kmahwx
	 eobFZLlT4bSmSj1mrHmB1i/EikuL3cWQ95AmcH8Dqn1YdcXFE0GbnrJEJjvnJhy8yW
	 ZKEcOl6J/0mSWQsL0oTMC9iBItuU/lUz+vZp71BaggN8U1ScOprjLHgJij04ThusAj
	 TUT5ije+zaq+w==
Date: Mon, 10 Jul 2023 10:51:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate
 io queues
Message-ID: <ZKw3H2cJzRPZa29N@kbusch-mbp.dhcp.thefacebook.com>
References: <20230708020259.1343736-1-ming.lei@redhat.com>
 <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de>
 <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_095147_827569_D837C7D3 
X-CRM114-Status: GOOD (  19.06  )
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

On Mon, Jul 10, 2023 at 05:14:15PM +0800, Ming Lei wrote:
> On Mon, Jul 10, 2023 at 08:41:09AM +0200, Christoph Hellwig wrote:
> > On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> > > Take blk-mq's knowledge into account for calculating io queues.
> > > 
> > > Fix wrong queue mapping in case of kdump kernel.
> > > 
> > > On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
> > > `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> > > still returns all CPUs.
> > 
> > That's simply broken.  Please fix the arch code to make sure
> > it does not return a bogus num_possible_cpus value for these
> 
> That is documented in Documentation/admin-guide/kdump/kdump.rst.
> 
> On arm and ppc64, 'maxcpus=1' is passed for kdump kernel, and "maxcpu=1"
> simply keep one of CPU cores as online, and others as offline.
> 
> So Cc our arch(arm & ppc64) & kdump guys wrt. passing 'maxcpus=1' for
> kdump kernel.
> 
> > setups, otherwise you'll have to paper over it in all kind of
> > drivers.
> 
> The issue is only triggered for drivers which use managed irq &
> multiple hw queues.

Is the problem that the managed interrupt sets the effective irq
affinity to an offline CPU? You mentioned observed timeouts; are you
seeing the "completion polled" nvme message?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
