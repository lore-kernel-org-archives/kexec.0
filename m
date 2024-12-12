Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3346E7717D
	for <kexec@archiver.kernel.org>; Thu, 12 Dec 2024 03:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N6E3IyIU7BB8nI8dLsUO7tmTfsJXF8TuiliqLS1zmxQ=; b=zKK/o5JrofsuocNMdcCHDymwx5
	tqYICN5HH+CtJi2nvTM7SQ8/cvVAmSMM3G45sw+i+lnXLHmfQhctogoDBV3E9bsL8xvVHeoW5jg6N
	LpBNymtLrMd2RQyuoYSSm9AcN07soq9+ZeErT0m67DVCrhc25PVvXazyxb+eh3sbZYVs4OUPtK0Bp
	gK5r798VEPAv/P0QqlgZiw5KKMjtv3+008NBGhowmYlvCTtikFhWr4K5b/Ro8PMcFsouLCL0BHEZM
	B8Ls47gtzVLGxj7vle3uuXc7gTpb2QoFNpCjbnOBMr3famF5FI0q2VNADf9nK2w5D87jrqjMlWLVw
	62UIE4/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLZT1-0000000GmeK-26lZ;
	Thu, 12 Dec 2024 03:02:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLZSy-0000000Gmdi-3kqk
	for kexec@lists.infradead.org;
	Thu, 12 Dec 2024 03:02:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733972535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N6E3IyIU7BB8nI8dLsUO7tmTfsJXF8TuiliqLS1zmxQ=;
	b=HXFh9L5GcSwtO2SA+PFHaORnl/OylyBVRmRQhzjanbCydCUnokKKSjSLGrA0qzTbQzEjfn
	ACN6i3R2X2V3JFsKkgdCAhz2sSwqHjCQv4QPVt8XSkDw8I6kPY8vPcNcvUebAs7b1dS/Wc
	EbKmu6gnSbpJU1t9GKcy3yNj+JQ6rtY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-hHk3rGRyPE-IKWao27364A-1; Wed,
 11 Dec 2024 22:02:14 -0500
X-MC-Unique: hHk3rGRyPE-IKWao27364A-1
X-Mimecast-MFC-AGG-ID: hHk3rGRyPE-IKWao27364A
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F309D195608C;
	Thu, 12 Dec 2024 03:02:12 +0000 (UTC)
Received: from localhost (unknown [10.72.112.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02ABC19560AA;
	Thu, 12 Dec 2024 03:02:10 +0000 (UTC)
Date: Thu, 12 Dec 2024 11:02:06 +0800
From: Baoquan He <bhe@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec <kexec@lists.infradead.org>
Subject: Re: Can't use kexec-tools for preserve-context kexec 'call'?
Message-ID: <Z1pSLg3H6Sz0HOU2@MiWiFi-R3L-srv>
References: <f6f1395fafb6ea927ad71d7b041c3f0efe0678e7.camel@infradead.org>
MIME-Version: 1.0
In-Reply-To: <f6f1395fafb6ea927ad71d7b041c3f0efe0678e7.camel@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v2Bl4sLDN_xaKFfMOl8RRtMDFIFpu9AuKqLFJhicM10_1733972533
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_190217_005616_6403F2E5 
X-CRM114-Status: GOOD (  21.66  )
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

Hi David,

On 12/09/24 at 02:07pm, David Woodhouse wrote:
> In https://git.kernel.org/torvalds/c/07fa619f2a40c there is a test
> program which uses kexec to invoke a 4-instruction 'executable' which
> merely writes a byte to a serial port and returns.
> 
> It just loads a single kexec segment containing those four
> instructions.
> 
> Should I have been able to do that using kexec-tools? I couldn't work
> out how.
> 
> And even once it's loaded, 'kexec -f -e' does manage to invoke it, but
> then reports 'No such file or directory' after the reboot() system call
> returns success. Strace shows:

May I know why you are testing preserve-context feature recently? I
noticed you have raised an issue inside kernel and worked out a draft
patch, while you did't tell what use case or scenario preserve-context
is used in. Asking this because you could be the 1st one to test it and
report issues on preserve-context as far as I know these years.

If there's newly found scenario preserve-context is needed, that's a
good thing. Otherwise we may consider to put it in DEPRECATED list in
kernel config so that we can finally take it off from kernel in several
years, like this people won't meet it and need take time to study what
it is and why it doesn't work as it was declared. What do you think?

Thanks
Baoquan

> 
> reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_KEXEC[  143.979879] Freezing user space processes
> [  143.981493] Freezing user space processes completed (elapsed 0.000 seconds)
> [  143.982148] OOM killer disabled.
> [  143.999573] Disabling non-boot CPUs ...
> [  144.017504] smpboot: CPU 1 is now offline
> [  144.018298] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> B[  144.034246] Enabling non-boot CPUs ...
> [  144.034666] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> [  144.035396] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  144.037406] CPU1 is up
> [  144.042020] virtio_blk virtio1: 2/0/0 default/read/poll queues
> [  144.046702] OOM killer enabled.
> [  144.047368] Restarting tasks ... done.
> ) = 0
> write(2, "kexec failed: No such file or di"..., 40kexec failed: No such file or directory
> ) = 40
> exit_group(-1)                          = ?
> +++ exited with 255 +++
> 
> 
> 
> 
> 



