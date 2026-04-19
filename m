Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77662EA7194
	for <kexec@archiver.kernel.org>; Sun, 19 Apr 2026 09:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2SPw7oDGT01M+iv1kpdNVMewY3nQAxo5Ti8SNjIVQEo=; b=1J6lzle56bGxk70gEB5D0i+JsZ
	FNTpXDlvthZQ4NM1Nl3v2zEfg1JPWy/qbDnk+avpgdvUaIIK3+XE1FXOacKrEkxpOGrCVRqic1XRs
	cmKpri5sA8uZjk+zrshUIBKS9KodNYQ265kKFk6IpNfU63NpNijdC/QhDAFgA6f//DrInhNt4Vz4/
	5YTxAM1TJ9kstvxSqmpviEI1Ue5ORb2IQ7xux1xrkiXC7pVhCpoSB/330qEiUiHC5YPoeK3yUiDz5
	BG3VfVE7UiwfKvcni7+Sh+0lffZiWuAc9QdXrPvLJHMn0AXqeVsTkMb/07EZ8fPXKnlAnLSZoDz5r
	y9b0DZeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEOC7-00000005fbA-24uN;
	Sun, 19 Apr 2026 09:11:59 +0000
Received: from out-189.mta1.migadu.com ([95.215.58.189])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEOC4-00000005fal-3hc7
	for kexec@lists.infradead.org;
	Sun, 19 Apr 2026 09:11:58 +0000
Date: Sun, 19 Apr 2026 17:11:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776589913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2SPw7oDGT01M+iv1kpdNVMewY3nQAxo5Ti8SNjIVQEo=;
	b=dGdVDGLDBne94Ay6djZKquTevZGyw5xQWl/R1ZFs8gSFqnE0UtmOSePATlxKLHosJTCmSD
	hvIuuZSMRWMX4clZx8VTEuEQWtXvjjqTsG2c4elYyHJHucUkQvinwkhHcoFr6B/gNGGB6V
	9aOE+OhTxK39mC3YeO9FGI2IJehS928=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: rppt@kernel.org, tglx@kernel.org, kuba@kernel.org,
	enelsonmoore@gmail.com, martink@posteo.de,
	magnus.karlsson@intel.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, pratyush@kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com, diego.viola@gmail.com,
	broonie@kernel.org, cl@gentwo.org, masahiroy@kernel.org,
	kexec mailing list <kexec@lists.infradead.org>,
	Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: update kexec/kdump maintainers entries
Message-ID: <aeScTZjN3UNT6QrS@MiWiFi-R3L-srv>
References: <20260413121146.49215-1-pasha.tatashin@soleen.com>
 <CA+CK2bDwcGLasN56NXJdwq_AvFWrz+WMv9L9uxK8MkChXw29rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDwcGLasN56NXJdwq_AvFWrz+WMv9L9uxK8MkChXw29rg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260419_021157_119949_46C4D143 
X-CRM114-Status: GOOD (  16.35  )
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

This is fine to me since KHO people will create a git tree to hold all
kexec related codes.

Acked-by: Baoquan He <bhe@redhat.com>

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

