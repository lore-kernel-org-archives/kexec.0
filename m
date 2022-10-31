Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5704BECAAA1
	for <kexec@archiver.kernel.org>; Mon, 31 Oct 2022 21:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ktEPLOgddL/flTC563klvk/F4taZB36O4o3HHfdl3P8=; b=dW5ZkaveZs1NWS
	F9MvPs1nmsBtQvZo4PevOAtdJZJ9L4++rAEOWUkr9mT5m/doWEGGraxKFB9G5Y87CGxcPEcli8XUo
	dVRaH7OtajZPEs5Ujfe6OyW8u1E6ksYRD0xGR6q55IVPHwNe2YNnqvPmKC+bt1BGmgR13AYDdj6T7
	na2BhV/NXjwxUYlkZeOtWtK0k2HESa985BbPqXCk2wL2Rv6yAaoKcgePrOburqIpMTp1SGhFxqEKc
	Jp+Of7EqhsdFpI0rkuBXZTaTHMulWtvp7NIkQhlBlShJpvDvQMzfUoL4Lu3gfHiZ34ZpeYT3gw/Lm
	45JFOK/d+bETmJVMIwLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opbxI-00FOFi-0I; Mon, 31 Oct 2022 21:04:24 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opbxF-00FOF9-1b
	for kexec@lists.infradead.org; Mon, 31 Oct 2022 21:04:22 +0000
Received: from zn.tnic (p200300ea9733e7f5329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7f5:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3EEE91EC0430;
	Mon, 31 Oct 2022 22:04:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1667250258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=uPGnvbAxZ8ttUEBvRdjxQMieA3rH/twSWSHVHAlFWO8=;
	b=cPilKLtM5iJ3R30dhSQYOsVLTiNFDv4YG4rAGrzlC4BfbL6ri7kxV9L0toYDlnmxjHB4tL
	2IaDV8c1DhQoa1eudA2uVPiIxSzBL/69teRAq6qJRPmLDKjg+6qwJ8VP9D6bWVNEWb1Ts2
	YDjhnSYbNE71PxwK/F/Lcy0WLZ9maOA=
Date: Mon, 31 Oct 2022 22:04:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v13 7/7] x86/crash: add x86 crash hotplug support
Message-ID: <Y2A4TqyOaPYBu4Hk@zn.tnic>
References: <20221031193604.28779-1-eric.devolder@oracle.com>
 <20221031193604.28779-8-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221031193604.28779-8-eric.devolder@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_140421_250855_BDF5578D 
X-CRM114-Status: UNSURE (   6.13  )
X-CRM114-Notice: Please train this message.
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

On Mon, Oct 31, 2022 at 03:36:04PM -0400, Eric DeVolder wrote:
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)

What happened to that here:

https://lore.kernel.org/r/Y1e85gqB3kzlx7qL@zn.tnic

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
