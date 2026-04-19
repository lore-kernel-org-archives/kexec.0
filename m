Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34634EA7193
	for <kexec@archiver.kernel.org>; Sun, 19 Apr 2026 09:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6J8ehCkrmP/V19GUsfdL2G29gjzTaGv6leFxhWhWang=; b=1jspi2K1zfDRqDlj7i1zWM/+6C
	LOeA21v0XqcxSeHemzbnoonHgSQJgCq4xPZJihqAyQqFAw7/D3GQ5NIqdqasPJumHgRz0f5k6NONQ
	+owhhVxd7rhPsnj7c2OzwYH1VNwEoaaIEw9gedrkWQRnJKophfEAXgRYCzxiIXSKIin0jQjDVAH5n
	avLX19JxDoyPTrlSQ/onuxLRwgMcTJ+Fnhm9FSglEcIkCcDHO1JLMwCIwrSKQesDAlUy5rnuAssYR
	01EUHZvEbiPCRZuJHlBabBuxFWGk4fBykPo4qK9qBnsI8kBF70/1o+o5v9ApDAAyK4veXjUv4enwS
	5J/gt4Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEOAs-00000005fWt-0Q5F;
	Sun, 19 Apr 2026 09:10:42 +0000
Received: from out-174.mta0.migadu.com ([91.218.175.174])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEOAl-00000005fWV-3Bva
	for kexec@lists.infradead.org;
	Sun, 19 Apr 2026 09:10:37 +0000
Date: Sun, 19 Apr 2026 17:10:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776589830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6J8ehCkrmP/V19GUsfdL2G29gjzTaGv6leFxhWhWang=;
	b=Q5h5B38i847Ynd7aWT65awEod7gzuzVpJSxSBNOBeT13hXKgHXEUOQKaFmdB6GhKdmm2n1
	JSRRgAnag8Csn+8dVfqTmktEA59lk8hjKnuHQjxXs3gIHudhGUB1NsjoDqBuQNyp+G7iez
	L7iUyiinuG/o/LQB0yMsyIeuVZCcl6k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, vgoyal@redhat.com,
	ruirui.yang@linux.dev, dyoung@redhat.com
Cc: rppt@kernel.org, tglx@kernel.org, kuba@kernel.org,
	enelsonmoore@gmail.com, martink@posteo.de,
	magnus.karlsson@intel.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, pratyush@kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com, diego.viola@gmail.com,
	broonie@kernel.org, cl@gentwo.org, masahiroy@kernel.org,
	kexec mailing list <kexec@lists.infradead.org>,
	Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: update kexec/kdump maintainers entries
Message-ID: <aeSb_xv9gzPS0Vv5@MiWiFi-R3L-srv>
References: <20260413121146.49215-1-pasha.tatashin@soleen.com>
 <CA+CK2bDwcGLasN56NXJdwq_AvFWrz+WMv9L9uxK8MkChXw29rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDwcGLasN56NXJdwq_AvFWrz+WMv9L9uxK8MkChXw29rg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260419_021036_023549_4697B6E7 
X-CRM114-Status: GOOD (  16.40  )
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

On 04/17/26 at 05:57pm, Pasha Tatashin wrote:
> CC: kexec mailing list.

CC more people in reivewers' list.

> 
> On Mon, Apr 13, 2026 at 8:11 AM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > Update KEXEC and KDUMP maintainer entries by adding the live
> > update group maintainers. Remove Vivek Goyal due to inactivity
> > to keep the MAINTAINERS file up-to-date, and add Vivek to the
> > CREDITS file to recognize their contributions.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  CREDITS     | 4 ++++
> >  MAINTAINERS | 7 ++++++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/CREDITS b/CREDITS
> > index 9091bac3d2da..035f70bae0cc 100644
> > --- a/CREDITS
> > +++ b/CREDITS
> > @@ -1456,6 +1456,10 @@ N: Andy Gospodarek
> >  E: andy@greyhouse.net
> >  D: Maintenance and contributions to the network interface bonding driver.
> >
> > +N: Vivek Goyal
> > +E: vgoyal@redhat.com
> > +D: KDUMP, KEXEC, and VIRTIO FILE SYSTEM
> > +
> >  N: Wolfgang Grandegger
> >  E: wg@grandegger.com
> >  D: Controller Area Network (device drivers)
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d238590a31f2..e5b4db2d8f88 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13796,7 +13796,9 @@ F:      scripts/Makefile.kcsan
> >  KDUMP
> >  M:     Andrew Morton <akpm@linux-foundation.org>
> >  M:     Baoquan He <bhe@redhat.com>
> > -R:     Vivek Goyal <vgoyal@redhat.com>
> > +M:     Mike Rapoport <rppt@kernel.org>
> > +M:     Pasha Tatashin <pasha.tatashin@soleen.com>
> > +M:     Pratyush Yadav <pratyush@kernel.org>
> >  R:     Dave Young <dyoung@redhat.com>
> >  L:     kexec@lists.infradead.org
> >  S:     Maintained
> > @@ -14112,6 +14114,9 @@ F:      include/linux/kernfs.h
> >  KEXEC
> >  M:     Andrew Morton <akpm@linux-foundation.org>
> >  M:     Baoquan He <bhe@redhat.com>
> > +M:     Mike Rapoport <rppt@kernel.org>
> > +M:     Pasha Tatashin <pasha.tatashin@soleen.com>
> > +M:     Pratyush Yadav <pratyush@kernel.org>
> >  L:     kexec@lists.infradead.org
> >  W:     http://kernel.org/pub/linux/utils/kernel/kexec/
> >  F:     include/linux/kexec.h
> > --
> > 2.43.0
> >

