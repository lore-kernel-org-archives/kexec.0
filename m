Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731AEC25B76
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 07:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BI2/7wKuZX894wxVf5V4MyUwsE7eQ9MNJHYo4xUmqys=; b=rpxHhKO7UDnI8p
	hwH4lxNAM4cqGfv1sFKIMVdTI9jU3ZS6qo+3d/Ycv+/mFjqGcEbLFxrK1x1vMn+GVXyORTtK6/tcK
	+byf88gmNwNwNPjsCAzOiNVueabW+FYhgth93YxMA7xRnQ0sxlwprgKAgdOFKJhw+PHpmTfOSddfD
	b8M/CHgKDtkNFsxhENT+jLdvtTt2mvf8Tn4+ljUvmsx67H7b9DEa3azpZZQ6YkdLqgqZJd4XGJlEb
	M956EN+TSOcl03WwJk7/48Bxd8B2p8BmBx/ROdI5YROVzQh3VfaGhaomVYgR0hhu9q9pcVdazR/99
	9Nl67RTl2ehHgNjQSlRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sElJD-000000052Vs-1S2T;
	Wed, 05 Jun 2024 07:43:47 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sElJ8-000000052QU-2iYd
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 07:43:45 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 06FDC40E016A;
	Wed,  5 Jun 2024 07:43:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XbvGV92rLO8V; Wed,  5 Jun 2024 07:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717573414; bh=Y4I52v2EdsdONC4N7gjTDK8D0wPbQuWZeLOqmwGhn9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FM0WGn322/ny214BmEwVjVnMOYmHgCEwiKQQuKobottnnNKZk07U2UJj/i+xiY30H
	 vP4RFQsF2bqDxyM/LcFfl1yVDhgMXASLvfRwJS3AJwi32vS0aSv756doMNTezzjHiq
	 UlAXEd8tmlWM27uVBNSkeG/6FcS2H1Gi0/bLgKqE12dgT2B+2PqNeAgong+xjL4O+p
	 6zRuUGvTmtt1f3IU3Xpo8CYIavgEiTBN2Wxdd5GrdiBZRp/TkMONV7teJ+gwmaSok3
	 gHoPkeKd18aMk0rpK5Y/4+oqkqvfgYSAyLTp3l2C0fTtNZFptbKRSQtJYuz+FScFPn
	 TTM580/Ns5aqPRGZfVWMyok5n2JD/SYR6b4xdkKJ8K+e2G8YNp0M2qnv0I2O3ztNok
	 7Fc5nLwBdrs7QBbwMu1xSjgVpungA3fv2rlLK4YuBaMz2beGerAPeWVqUueLbnLfPB
	 POW+X+0M5Qv5Wgz4Mw5zaMoEqmknbhmxs0crNfiy3YMZRBciIqI8NpKiOsxozQemvE
	 3Qy7Jn3AklIAHFCQYU8rfgKzgo6SsHIi4Nb+NTPptGvzJuXZ5SeoiacS2/upGki754
	 LP13oUm9t5yaGRaiZt35SKALvA+cs86cFNjtH4HmRY+hnrKJuyZF5S4dvDLR04VJ1O
	 Tbz9jmdl7GAVCUV8FcBE3FMc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 12F0340E016C;
	Wed,  5 Jun 2024 07:43:05 +0000 (UTC)
Date: Wed, 5 Jun 2024 09:42:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Young <dyoung@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>, "Kalra, Ashish" <ashish.kalra@amd.com>,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, hpa@zytor.com,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240605074257.GAZmAXAbkc5TGVds5u@fat_crate.local>
References: <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org>
 <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com>
 <20240604094358.GBZl7h3otTCYJ5rkkt@fat_crate.local>
 <CALu+AoS=-=PbMRxC-1rpfSTPpMOmM5BGRBjLhDwgOC3=4C71ng@mail.gmail.com>
 <20240604180212.GHZl9WpAfNVERTjMqw@fat_crate.local>
 <CALu+AoRqNmsWXi+HXYNYTY=pXJ3sLTLKyXNeJz9EoxEsHzFdQA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALu+AoRqNmsWXi+HXYNYTY=pXJ3sLTLKyXNeJz9EoxEsHzFdQA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_004342_912974_97EB4DA6 
X-CRM114-Status: GOOD (  10.15  )
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

On Wed, Jun 05, 2024 at 10:53:44AM +0800, Dave Young wrote:
> It's something good to have but not must for the time being,  also no
> idea how to save the status across boot, for EFI boot case probably a
> EFI var can be used;

Yes.

> but how can it be cleared in case of physical boot.  Otherwise
> probably injecting some kernel parameters, anyway this needs more
> thinking.

Yeah, this'll need proper analysis whether we can even do that reliably.

We need to increment it only on the kexec reboot paths and clear it on
the normal reboot paths.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
