Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62EEECE57A
	for <kexec@archiver.kernel.org>; Mon,  9 Sep 2024 14:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VECvvrawP37PFWwwJpN63c9MLgxxgh5VWxqhTIejNoU=; b=ja/D8lynOQJExD
	yG474afM7Dd2q5I6yUUdoF7vHJGsrvMkmWGe6QMXlw9kd7CywWamvSbkXPPHtSfKY9gkLf3zEfbhg
	QQNe/D9KMFn/XriIK3DTFzEfEGK/fw1SFu4EHaa9ryGSgIVJXzLvTcs0R3oGrSk55jxG1aX0VtR3d
	aY+jaw3p0J1mZvWwMl6q9M0JtLkTs1Yl3boKhu3enkJhlY+Etcv9gaB2GOtQz3Gk2bcXCT2jcUki2
	pQ84NvQgmV5k02MMm5rLGH032qSO/etcpXccEzfD/ZVLRKuUAUm2lUkDY1eFBIBvuusq9YMst1HJj
	UNAgx5G5REX6fs0h5gdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snf8f-00000002E4Q-2hjf;
	Mon, 09 Sep 2024 14:13:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snesE-000000029uZ-2NK3
	for kexec@lists.infradead.org;
	Mon, 09 Sep 2024 13:56:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725890169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYhtjmyZJWBN50A78LZx2Nv8438j+9S4h7dYlc79Xpg=;
	b=ROiEEQqPoCI5ovoJZcVSgW9RLVyfFWf7DcrKkLtO3yo5eYrzUqUybXDg6+xPsjuE0zOEoW
	zhM/SqLG8YUgr9SE6xiLiq2Y7HuWs8F/KzoJIk1L9Wlhv3s9Ra4Ad7di3qEdCnBwWZPchs
	5BbR7Lf/oHx/m1hA8uNr6HbBBBThhcM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-XmCTAre3OZqQxY8bSgQ_yQ-1; Mon,
 09 Sep 2024 09:56:06 -0400
X-MC-Unique: XmCTAre3OZqQxY8bSgQ_yQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6B8F1955D45;
	Mon,  9 Sep 2024 13:56:03 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.107])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 590FB30001A1;
	Mon,  9 Sep 2024 13:55:58 +0000 (UTC)
Date: Mon, 9 Sep 2024 15:55:55 +0200
From: Philipp Rudo <prudo@redhat.com>
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "Ard Biesheuvel" <ardb@kernel.org>, "Pingfan Liu" <piliu@redhat.com>,
 "Jan Hendrik Farr" <kernel@jfarr.cc>, "Lennart Poettering"
 <mzxreary@0pointer.de>, "Eric Biederman" <ebiederm@xmission.com>, "Baoquan
 He" <bhe@redhat.com>, "Dave Young" <dyoung@redhat.com>, "Mark Rutland"
 <mark.rutland@arm.com>, "Will Deacon" <will@kernel.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <20240909155555.257e13eb@rotkaeppchen>
In-Reply-To: <D400W37FR01S.CLFIKA98YWX7@kernel.org>
References: <20240819145417.23367-1-piliu@redhat.com>
	<CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
	<20240906125438.1e54c5f6@rotkaeppchen>
	<D400L4YN4K7K.264IDL4O8374F@kernel.org>
	<D400OHF2ODNK.3JF7DJ87Q4BYI@kernel.org>
	<D400W37FR01S.CLFIKA98YWX7@kernel.org>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_065610_714198_C468EB43 
X-CRM114-Status: GOOD (  27.46  )
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

Hi Jarkko,

On Sat, 07 Sep 2024 14:41:38 +0300
"Jarkko Sakkinen" <jarkko@kernel.org> wrote:

> On Sat Sep 7, 2024 at 2:31 PM EEST, Jarkko Sakkinen wrote:
> > On Sat Sep 7, 2024 at 2:27 PM EEST, Jarkko Sakkinen wrote:  
> > > On Fri Sep 6, 2024 at 1:54 PM EEST, Philipp Rudo wrote:  
> > > > Let me throw an other wild idea in the ring. Instead of implementing
> > > > a EFI runtime we could also include a eBPF version of the stub into the
> > > > images. kexec could then extract the eBPF program and let it run just
> > > > like any other eBPF program with all the pros (and cons) that come with
> > > > it. That won't be as generic as the EFI runtime, e.g. you couldn't
> > > > simply kexec any OS installer. On the other hand it would make it
> > > > easier to port UKIs et al. to non-EFI systems. What do you think?  
> > >
> > > BPF would have some guarantees that are favorable such as programs
> > > always end, even faulty ones. It always has implicit "ExitBootServices".
> > >
> > > Just a remark.  
> >
> > Some days ago I was thinking could some of the kernel functionality be
> > eBPF at least like in formal theory because most of it is amortized,
> > i.e. does a fixed chunk of work. Not going into that rabbit hole but
> > I really like this idea and could be good experimentation ground for
> > such innovation.  
> 
> E.g. let's imagine there would imaginary eBPF-TPM driver framework.
> 
> How I would go doing that would be to take the existing TPM driver
> functionality and provide extra functions and resources available for
> subsystem specific BPF environment, and have the orhestration code as
> eBPF. I pretty much concluded that there is a chance that such could
> work out.
> 
> Not something in my immediate table but it is still really interesting
> idea, as instead of using language to separate "safe" and unsafe"
> regions you would use "VM" environments to create the walls. In the
> end of the day that would also great venture for Rust in kernel, i.e.
> compile that BPF from Rust.
> 
> Sorry going of the hook the comment triggered me ;-)

I'm glad you like the idea :-)

Sounds like an interesting idea you are having there!

Thanks
Philipp


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
