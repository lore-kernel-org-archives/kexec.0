Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BCCCD98CE
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iBl9dYFaXSXhLmN7gFb0lJdWFnhcbPV5sg9JKMOIpsw=; b=HU83w5vXWDS/Ixdb/ytyICZ0eQ
	Z3O3UtguF2D548xGHcVTOLu9+J/lwhFxIZTGAbluhmQDQlXEb0qjongAImrvdhQaKwJYko3LJ2p6o
	if8IMfAH/kSqPx8rYZydBWPvmS1/4iw4VoJ4XA9qmNQiYvHqfbziS85oLo9wHE9xrri2TOrC0/+cC
	b6ZmPk1jvtyczI/geoTfcbz/4U0pbW9V26/St6mBolUdikCoMNfEkza7rh3wbGkTWT8M2cq/LVUgz
	Nfky/FjxpZRkHqlFnEeeZ8JH1he5nPFO9yiv3ga34E4FiGDyC5JSyNK8n0SmDZCwevJ5AofsG4l06
	n6afDpXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY5ZO-0000000BL8o-0xuZ;
	Fri, 12 Jun 2026 17:21:26 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY5ZL-0000000BL8F-2nUN
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 17:21:24 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-516d0db9372so9723081cf.2
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 10:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781284882; x=1781889682; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iBl9dYFaXSXhLmN7gFb0lJdWFnhcbPV5sg9JKMOIpsw=;
        b=fT5CLaNdX6zlfb0h4XYJn5RBuLdQ2aWpbrtiXFP6UHsio0F0ZTNXkvIFuWyXdIGvsv
         mYgbhV+pyt48nWzrEOYGXQmnqe+hBrxabT73r3dR0/7PvT311vtTZ0bgNcG5bpzwoobj
         lDSeplT5vbG4vnJYtMXHdpAFYeOSlPaUVyCP79/wWYNeEDattptpLXvLlC+ut/DSrsuw
         Qsq+OqYkOV9k1+By4+YIDfPxrRfnbVkFyMjiMlDE4DjcRoojc2hfkWSmWSlPlXlCK8KY
         UuBZJrSv1u/Gxq83rkT3Tu46fkqr1Lx8V+KaPlz6Pq0wdi78lPqVOAHWS8HwjtxUvNw8
         c4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781284882; x=1781889682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBl9dYFaXSXhLmN7gFb0lJdWFnhcbPV5sg9JKMOIpsw=;
        b=NqGwODhsm/iAUppOpieKdoVnwDP4CWgWRvImcOXWruCPr0ESp4OpSeGOgo3JBS/bat
         VHVnicpxQtMLdcuxIVto6nwmDWcg7nCDzjbEypjsNnRHhrMREJVKS7WVKCoDD33JUD/o
         ShaDjmbBTKpZfY4jetx8XmVjNh68QMkH6LL+aH/k7nf0HDvgmJR+UL88lZ20e/Eh0brO
         2rOsslzt3WnhhVV/YiVCdRXdSV43rg5BbNiGLRotoQTk2hTneUkF2RuEgpb2Np57TMLU
         hlk3APPu94TcL11GRnSg4mbKHKPuiH9XIZYeSR949oww4VITcevqwZJnLR8U5Za22hpe
         YpJA==
X-Forwarded-Encrypted: i=1; AFNElJ8HiUO11NPn5lrZNm47Is6o/Cc8tMkpi2lE8ngYO0ZbHpHFjDK1hQ0/KPsk7otLXcuAx19fkg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyX62RsmPpvf7rHNpvy32j5pqZnQ0HSutG6z4DPd/Rnxq4Q7bEf
	lK7yDBbM16gAzROTjEaeN/vYqVyTrTJtvpIrEun9EWuyG+/Yu30rrnu2fx7ofkn0BzMXt2k+0EL
	y1t/E
X-Gm-Gg: Acq92OECebMLrd57oRfOlvwP9HQkwHK6SlG/9DoN4HivyVHQq5O9kBRe9+SR5myePAT
	cpWTCbATIsaSsMO/rf97qyE9nhkx7TcIoo2LfqU0CXox2ybEpHGLxvZCm2LTU15Y2cZGVyjyD4i
	MF+zM/EX5B7MEemQrNZ38uj1rMi7vLBiXmulyDdiPRbJbbaGCioIGdFco505dNk/x6nlHRMwKrn
	ySf7jDjePcI/ZXx4UpERxd7YU3bFdZXRsS31tovHSJeQ5zIOXDI+DklWfUXOqzs4XyJwzt04HZ+
	iK4Aw9n4oSpNfa22/qh7q/6QAqJNz1usWHQygOJhwiYKI1ctRRvC8GIMWBffL8iYuMxWpzSfkGD
	outiCEOIugPLgMf9j8xd0HWj3+De1AB4m3y4ZofbkVl1JW416i4hw8wuQzbWcTS4daxvA9oaUBF
	iXAL4u0pBQiDFSV779Y+JKFO7yP922RuL+BpETEmffcbo9YjGuOHQ=
X-Received: by 2002:a05:622a:9004:b0:516:e10f:b1fa with SMTP id d75a77b69052e-517fe4df40dmr47158011cf.2.1781284882296;
        Fri, 12 Jun 2026 10:21:22 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb61eaf4sm26851211cf.4.2026.06.12.10.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:21:21 -0700 (PDT)
Date: Fri, 12 Jun 2026 17:21:20 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2] pstore: add a KHO backend
Message-ID: <aiwbUfeaF9RdCGR-@plex>
References: <20260605121040.1177072-1-mclapinski@google.com>
 <aiwa4jIWEMsvfnVg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiwa4jIWEMsvfnVg@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_102123_711240_6A4385D4 
X-CRM114-Status: GOOD (  17.96  )
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
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Michal Clapinski <mclapinski@google.com>, Kees Cook <kees@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 06-12 17:42, Mike Rapoport wrote:
> Hi,
> 
> On Fri, Jun 05, 2026 at 02:10:40PM +0200, Michal Clapinski wrote:
> > Up to this point to preserve late shutdown logs in memory, users had to
> > predefine a memory region using ramoops. This commit changes this by
> > preserving a buffer using kexec-handover.
> > 
> > pstore_kho supports preserving only 1 dmesg buffer.
> > It gets replaced with the new buffer on every kexec, so the user has to
> > copy the file out of pstore after every kexec.
> > There is no erase() support.
> 
> Sorry I didn't jump at v1.
> 
> pstore does not really need a KHO backend. It can use ram backend with
> reserve_mem and reserve_mem can be preserved with KHO already.

I just tested it, and it works well, I think it would be fine for 
Google's requirements:

CONFIG_PSTORE=y
CONFIG_PSTORE_RAM=y
CONFIG_PSTORE_CONSOLE=y

With the following parameters:
'reserve_mem=2M:2M:dmesg_buffer ramoops.mem_name=dmesg_buffer ramoops.max_reason=5 ramoops.console_size=2097152 ramoops.record_size=0 ramoops.ftrace_size=0 ramoops.pmsg_size=0'

KHO preserves pstore properly. However, we need one patch that would 
allow for ramoops console to capture the output even when quiet is 
provided.

Pasha

