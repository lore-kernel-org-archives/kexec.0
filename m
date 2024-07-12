Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F4BC2BD09
	for <kexec@archiver.kernel.org>; Fri, 12 Jul 2024 06:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pc6toKMjWfjyHL/TZGuDsxIo4VtayjVNRW9My8ivmSY=; b=OCNOIwba6gAufS
	3T0opSFDOMqSQCIwTzAYBuGTzM+Bjk5reu643GFm9jBa1ELpbk6hu/NlhdjroAFxYWywgwQ4ccNcd
	s1dtLcsNRkGRDFXEjx8uefFhCHeA2lNMqtKNRdoU9LaX7cTTiTUTX61DpR1Od2nXwazWh5aFXttTj
	HAI8Qby2rk1so5kHncNkZNLvDDS+fph4QUKPzQEh0KXEwyUXo6tGLgsfKY4x5bJGwaGf4KfOuPBOe
	p+blcacA+iYraaEzb+aQIon7JZl+4h9i2y2R8SDXSXBYnb6FaFccZZ9D+xcS+kT96r9kLPuVdJujG
	rQWzUrslWLKgDxUtOKpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS9et-0000000Gbb4-1wtC;
	Fri, 12 Jul 2024 06:21:31 +0000
Received: from bee.tesarici.cz ([2a03:3b40:fe:2d4::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS9ep-0000000GbaP-3yuS
	for kexec@lists.infradead.org;
	Fri, 12 Jul 2024 06:21:30 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 387C01E26F4;
	Fri, 12 Jul 2024 08:21:25 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1720765285; bh=DgpmFySixGr7lDzA9N2iWV+kFeyL/lu8IgeDM3NaEMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TZpNPtnyuY7O0L5P4z38T+jj4SJt/80D7JNFmou983gl3PHQ3B4OkCwRAHkF2nLT1
	 a6kUHehAZtihhma31k28QT8BgMvfIYkmgkJ0GZWtyKL/UaCfxLlI4I3sDWfuiOTgHF
	 Aujh+qx4HW7a0sRD7SzPxt6N4zHsAYLUJdI92lxjrZnmugfgbFwi8Mnj89oUF2N3L6
	 VoVH73mLXzYhtJ1BOMf46qTv7XYeolE+6LDjBZm3WOqqJALXQC9enlszJ8zy1VtAa3
	 wPclulW5q1myW/TgnY+YmjImxDztYNX5aU2Tq750ajm8w7VyT37tdTWxrLN31J/6wS
	 lcD1LwwnCT+sg==
Date: Fri, 12 Jul 2024 08:21:24 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Petr Tesarik
 <ptesarik@suse.com>
Subject: Re: [PATCH] sysfs/cpu: Make crash_hotplug attribute world-readable
Message-ID: <20240712082124.272e079f@meshulam.tesarici.cz>
In-Reply-To: <59d88de7-369a-44e8-a965-109c8690869e@linux.ibm.com>
References: <20240711103409.319673-1-petr.tesarik@suse.com>
	<59d88de7-369a-44e8-a965-109c8690869e@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_232128_617243_7E0EFA3E 
X-CRM114-Status: GOOD (  25.22  )
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

On Fri, 12 Jul 2024 10:00:09 +0530
Sourabh Jain <sourabhjain@linux.ibm.com> wrote:

> Hello Petr,
> 
> Just want to mentioned few points about the commit message. No strong
> opinion on changing the commit message.
> 
> On 11/07/24 16:04, Petr Tesarik wrote:
> > From: Petr Tesarik <ptesarik@suse.com>
> >
> > There is no reason to restrict access to this attribute, as it merely
> > reports whether crash elfcorehdr is automatically updated on CPU hot
> > plug/unplug and/or online/offline events.  
> 
> Now, it is not just elfcorehdr; there could be multiple kexec segments 
> based on the architecture's needs.
> For example, on PowerPC, it is elfcorehdr and FDT.

Right. I am even working with a PowerVM LPAR on an L922 system now. ;-)

OTOH I was just too lazy to invent my own description, so I took it
from Documentation/ABI/testing/sysfs-devices-system-cpu. That one
could be improved. And a couple of other places... Expect a patch.

> >
> > Note that since commit 79365026f8694 ("crash: add a new kexec flag
> > for hotplug support"), this maps to the same flag which is
> > world-accessible through /sys/devices/system/memory/crash_hotplug.  
> 
> The previous comment is more relevant for the kexec_load system call.
> 
> For the kexec_file_load system call, the kexec flag introduced in the 
> commit message
> mentioned above is irrelevant. Building kernel with
> CONFIG_CRASH_HOTPLUG is enough.

Yes, but then this sysfs attribute always reads "1".

> > Signedoff-by: Petr Tesarik <ptesarik@suse.com>
> > ---
> >   drivers/base/cpu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > index c61ecb0c2ae2..73d69791d0d3 100644
> > --- a/drivers/base/cpu.c
> > +++ b/drivers/base/cpu.c
> > @@ -308,7 +308,7 @@ static ssize_t crash_hotplug_show(struct device
> > *dev, {
> >   	return sysfs_emit(buf, "%d\n",
> > crash_check_hotplug_support()); }
> > -static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
> > +static DEVICE_ATTR_RO(crash_hotplug);  
> 
> I agree, it doesn't have to be readable by admin only.
> 
> Acked-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thank you!

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
