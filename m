Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7A8D3000D
	for <kexec@archiver.kernel.org>; Fri, 18 Oct 2024 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oP1vLIwq2LuQePQpAnJdQkgaBFgqriqEy01bSXRd7AM=; b=IDKT5XwcDskmrT
	yVkO0uAeNLOFheQL2FPsSn8/CkRhJSzbSmVqrq0TI5fBKCLthkKiBKfM1GOK9lkSpZ6Cm2txoo23U
	URVxtxeLQACWvI/s0t2NBwtwr5oumJ+1I1uvHDljcFWFhSqstwO+Rc2cIUa1FAMBdsOLCczcehhnm
	tGrLpLhXLI6O6pqOvyMskwgvzYrVpkfhDwiY/v0No9erXXX6E/5dO3WnhzscT/0MMozmMQqFRwcA/
	5hrGuOJWEOS9otFvYqkoUR3mWQ+obBkdv4manHj6TWyFJiCkiu8ZuMOpgmPwgvMXu+Bvjxn3f/ynN
	aYZSHnNAS0aSjhTmCRcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1nPn-00000000xyr-2Qjg;
	Fri, 18 Oct 2024 13:53:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1nPa-00000000xwq-31Y3
	for kexec@lists.infradead.org;
	Fri, 18 Oct 2024 13:53:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729259581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3MdTWV2aPXX7qYLVHT7xAeOS8FRxLhj6WL39+1SSrXE=;
	b=R5x351ICFvFrYVAR0CBL300yNfC3uNq2XPTHGQPiIuhUl3sYegHlTm6ZvvytKXfUbOWNRa
	iAmRcPZmQvJU4Ua0LMS6BSPezxILYRgVhhVZ5EhtuAxKeuGcJ0WQN/vQKWzPIliYEubiq4
	EQw7BHqfZ9+HxZrD1cssj52vXr0ofb4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-vkadPesGPGSnk3vtBPuUeg-1; Fri,
 18 Oct 2024 09:52:58 -0400
X-MC-Unique: vkadPesGPGSnk3vtBPuUeg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E918319560B8;
	Fri, 18 Oct 2024 13:52:54 +0000 (UTC)
Received: from localhost (unknown [10.72.112.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7518A1955E94;
	Fri, 18 Oct 2024 13:52:51 +0000 (UTC)
Date: Fri, 18 Oct 2024 21:52:47 +0800
From: Baoquan He <bhe@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Gregory Price <gourry@gourry.net>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	mika.westerberg@linux.intel.com, ying.huang@intel.com,
	tglx@linutronix.de, takahiro.akashi@linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] resource,kexec: walk_system_ram_res_rev must retain
 resource flags
Message-ID: <ZxJoLxyfAHxd18UM@MiWiFi-R3L-srv>
References: <20241017190347.5578-1-gourry@gourry.net>
 <ZxHFgmHPe3Cow2n8@MiWiFi-R3L-srv>
 <ZxJTDq-PxxxIgzfv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZxJTDq-PxxxIgzfv@smile.fi.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241018_065302_856535_6EBEF728 
X-CRM114-Status: GOOD (  16.36  )
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

On 10/18/24 at 03:22pm, Andy Shevchenko wrote:
> On Fri, Oct 18, 2024 at 10:18:42AM +0800, Baoquan He wrote:
> > HI Gregory,
> > 
> > On 10/17/24 at 03:03pm, Gregory Price wrote:
> > > walk_system_ram_res_rev() erroneously discards resource flags when
> > > passing the information to the callback.
> > > 
> > > This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
> > > have these resources selected during kexec to store kexec buffers
> > > if that memory happens to be at placed above normal system ram.
> > 
> > Sorry about that. I haven't checked IORESOURCE_SYSRAM_DRIVER_MANAGED
> > memory carefully, wondering if res could be set as
> > 'IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY' plus
> > IORESOURCE_SYSRAM_DRIVER_MANAGED in iomem_resource tree.
> > 
> > Anyway, the change in this patch is certainly better. Thanks.
> 
> Can we get more test cases in the respective module, please?

Do you mean testing CXL memory in kexec/kdump? No, we can't. Kexec/kdump
test cases basically is system testing, not unit test or module test. It
needs run system and then jump to 2nd kernel, vm can be used but it
can't cover many cases existing only on baremetal. Currenly, Redhat's
CKI is heavily relied on to test them, however I am not sure if system
with CXL support is available in our LAB.

Not sure if I got you right.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
