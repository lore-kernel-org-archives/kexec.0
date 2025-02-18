Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA0CC021AA
	for <kexec@archiver.kernel.org>; Tue, 18 Feb 2025 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VSEg3Y4i5j62GBuWJlLVAxhF31nxTfKQ6QtAYtI7m5Y=; b=CtTQ8ycApSEVahA6VvS59W4B6u
	PH8l74/bMENpcwUot8kyqPEKBr+r7GX9N1++poLCY6yTaXZpWx1mlrk69WJME5mX7C3oDiNp2vCQN
	dN2YRUNfS+9qYFKv4NRDSnI20Z/Q26U9BI5LZ7P+fpVerJA7DK3kb1gwaTc9qKtHd6AM/p8T0INLx
	Q4AlYo0DhuBuX+S9qgLNRHhPwvTtDqxq8f9Pm0Itxk+y/Yt9Knytgx2W1Qb1FnEtyIj8bsJBOkKom
	Twd8A9CLpEgK0aEfU34FsMHLUBpGaY5dtNe92s0/d2Y1CMLT+HZ2/35PFWxdDApCYZSMwGEiGh8+b
	g5jfLSXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkQB2-00000008trp-125A;
	Tue, 18 Feb 2025 16:10:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkQ6G-00000008sYb-0wSA
	for kexec@lists.infradead.org;
	Tue, 18 Feb 2025 16:05:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739894730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSEg3Y4i5j62GBuWJlLVAxhF31nxTfKQ6QtAYtI7m5Y=;
	b=Ilva2k2hf8wRJLe73ZvJ/CrHnGug0gN0zBlTypd/1z9IPsl18QxUhk7QtcdRyMntOn+e+5
	0fWoI2huwj+okV5anFJEMbVaiGB/6iTm9SuKDQzDqfFUS5MOFguQRoqkvbkWH9NKoTDaK2
	QlMZwKHOOcerVPKSPFeBw5PTag276ZM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-cGrgj5P3MAiTPUxFNtVITg-1; Tue,
 18 Feb 2025 11:05:28 -0500
X-MC-Unique: cGrgj5P3MAiTPUxFNtVITg-1
X-Mimecast-MFC-AGG-ID: cGrgj5P3MAiTPUxFNtVITg_1739894728
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDBE81800874;
	Tue, 18 Feb 2025 16:05:27 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.44.32.80])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 475E91800352;
	Tue, 18 Feb 2025 16:05:25 +0000 (UTC)
Date: Tue, 18 Feb 2025 17:05:22 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: Gokul Praveen <g-praveen@ti.com>, kexec@lists.infradead.org
Subject: Re: VMCORE and kdump.conf file not found LINUX 6.12 KERNEL
Message-ID: <20250218170522.0861f62f@rotkaeppchen>
In-Reply-To: <CALu+AoRDtPRgZS6t57xXpQvQ9bXv7hTyebAVfPLXH69Op2qRzA@mail.gmail.com>
References: <4ccd4d81-2efd-4369-a759-552dbb9a007f@ti.com>
	<a69a8eaf-9fc0-468b-b39a-1486e6054878@ti.com>
	<CALu+AoRDtPRgZS6t57xXpQvQ9bXv7hTyebAVfPLXH69Op2qRzA@mail.gmail.com>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: slenbFOuKKA8tXgf6415iPguqfKnzlfZKgLq7VZN0K8_1739894728
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_080532_344875_A9338813 
X-CRM114-Status: GOOD (  20.05  )
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

Hi,

On Tue, 18 Feb 2025 16:48:26 +0800
Dave Young <dyoung@redhat.com> wrote:

> On Tue, 18 Feb 2025 at 14:07, Gokul Praveen <g-praveen@ti.com> wrote:
> >
> > Hi Team,
> >
> > Just a reminder.
> > It would be really great if you could help me with the following.
> >
> > Regards
> > Gokul
> >
> > On 05/02/25 17:50, Gokul Praveen wrote:  
> > > Hi Team,
> > >
> > > It would be really great,if you could help me with a couple of questions
> > > regarding kexec and kdump.
> > >
> > > I tried kdump on my SOC and it is rebooting fine . However,the VMCORE
> > > file and /etc/kdump.conf file is not found.
> > >
> > > VERSION:
> > > kexec-tools 2.0.30.
> > > kernel 6.12v
> > >
> > > STEPS FOLLOWED:
> > >
> > > 1)git clone git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> > >
> > > 2)
> > >     HOST PC:  
> > >      >cd $KEXEC_TOOLS_DIR
> > >      >./bootstrap LDFLAGS=-static ./configure --prefix=/usr/local  
> > > --host=aarch64-linux-gnu --target=aarch64-linux-gnu  
> > >      >make
> > >      >cp $KEXEC_TOOLS_DIR/build/sbin/kexec /media/$USER/rootfs/usr/sbin  
> > > (To copy the kexec binary to the rootfs filesystem of the target board)
> > >
> > >     TARGET BOARD:  
> > >      >Booted upto linux
> > >      >cmdline="crashkernel=128M console=ttyS2,115200n8  
> > > root=/dev/mmcblk0p2 rw rootfste=ext4 rootwait" (/dev/mmcblk0p2 refers to
> > > EMMC)  
> > >      > /kexec -p /Image --command-line="$cmdline"  
> > > --dtb=/k3-j721e-common-proc-board.dtb

The kdump kernel only presents the dump via /proc/vmcore but doesn't
write it to disk. That is done by user space contained in the initrd.
So for it to work you also have to provide an initrd that mounts the
target disk and writes the dump to it. But, as Dave already pointed
out, the creation of initrds is highly distro specific.

Thanks
Philipp

> > >      > echo c > /proc/sysrq-trigger  
> 
> Hi,
> 
> This looks more like a distribution related issue, I suggest you ask
> distribution developers to help.
> 
> Thanks
> Dave
> 
> 


