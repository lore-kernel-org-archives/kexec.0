Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C95C7EE22
	for <kexec@archiver.kernel.org>; Wed, 10 May 2023 04:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fpySfjcv3ePUJoqwCf9dRmP3YCwzcmG+IocaJ1cNfOM=; b=aYXurzgI2kqspv
	/noTRTQxqLV+e7krUmv2H5LcrHCtdcz7HfGIPadM3HWgKCIbPHWI7C2+51SAadAtFbNluJzy3tRO+
	Zqv/ESGERLV9io6CrauvoG1AhEmmC5ilmZAMwnyTQMFueyRjUMpsQqDdJsZfKW0hStRQXt1Ca12nl
	19Qf/rMyJdYqA98Q1cSWqqmz2zI0GpELqkXmx595YC7hfMmayeNxxQdEBh6cWo2pSK7EV485Mwd+C
	cbyeCLZccg5TzpMGh6UIPRYYqSjQJHRKZB9esnPogQuwFwRvYxLqf1hajlx2HJK+Psj2UJYW0lFQN
	2Kr4STfR97P6h8UXX8IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwbBS-004zrC-1y;
	Wed, 10 May 2023 04:12:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwbBP-004zp8-3D
	for kexec@lists.infradead.org;
	Wed, 10 May 2023 04:12:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683691916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhMhj5d/G7n1EDqnhcO4ODQXL3YvB1dKGcoGs91Uegg=;
	b=hkQbRlwmbAvR/airf0rscuULotjEE7MqNep4ep4EeaTS9SbNKuivs2BHoj7EPXyPCRX8/6
	9S2fXRL1QxeXWSgx3Gu0N9aAbEE4xZHcqWp2r/0BKZS2KoYyMnTtr/iTDBnOvI9uETMzwN
	gM7a5O20cqVTtwljbHe6qEBbY02bJYM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-b1P_QNRuOCqoEZ1_-JsbBw-1; Wed, 10 May 2023 00:11:52 -0400
X-MC-Unique: b1P_QNRuOCqoEZ1_-JsbBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB3F529DD990;
	Wed, 10 May 2023 04:11:51 +0000 (UTC)
Received: from localhost (ovpn-12-62.pek2.redhat.com [10.72.12.62])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B37A61121314;
	Wed, 10 May 2023 04:11:50 +0000 (UTC)
Date: Wed, 10 May 2023 12:11:47 +0800
From: Baoquan He <bhe@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	"Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
	kexec@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: kexec: include reboot.h
Message-ID: <ZFsZg0fvPA2/eysa@MiWiFi-R3L-srv>
References: <20230508-parisc-kexec-include-reboot-v1-1-78a155a8a0a4@kernel.org>
 <ZFoL9ntYCCfZFCNs@bhe.users.ipa.redhat.com>
 <ZFo0Gd/Eucw/0gtC@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZFo0Gd/Eucw/0gtC@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_211208_214198_462B7D22 
X-CRM114-Status: GOOD (  16.15  )
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

On 05/09/23 at 01:52pm, Simon Horman wrote:
> On Tue, May 09, 2023 at 05:01:42PM +0800, Baoquan He wrote:
> > On 05/09/23 at 09:01am, Simon Horman wrote:
> > > Include reboot.h in machine_kexec.c for declaration of
> > > machine_crash_shutdown and machine_shutdown.
> > > 
> > > gcc-12 with W=1 reports:
> > > 
> > >  arch/parisc/kernel/kexec.c:57:6: warning: no previous prototype for 'machine_crash_shutdown' [-Wmissing-prototypes]
> > >     57 | void machine_crash_shutdown(struct pt_regs *regs)
> > >        |      ^~~~~~~~~~~~~~~~~~~~~~
> > >  arch/parisc/kernel/kexec.c:61:6: warning: no previous prototype for 'machine_shutdown' [-Wmissing-prototypes]
> > >     61 | void machine_shutdown(void)
> > >        |      ^~~~~~~~~~~~~~~~
> > > 
> > > No functional changes intended.
> > > Compile tested only.
> > > 
> > > Signed-off-by: Simon Horman <horms@kernel.org>
> > 
> > Acked-by: Baoquan He <bhe@redhat.com>
> > 
> > We may need to find out the places in all architectures and fix all of
> > them.
> 
> I did check. It seemed to be needed for riscv, m68k and parisc.
> I've sent out patches for all three. But I may have missed something.

That's great, thanks. I didn't notice the other two.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
