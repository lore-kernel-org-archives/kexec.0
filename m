Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D0AC4332F
	for <kexec@archiver.kernel.org>; Wed,  2 Nov 2022 16:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XKp4FaYKsZ5rSEnV9luBfc5U6Qv5zjDF5VcvwrLUOqM=; b=cIcPoPaLpUi1Ck
	BV1pWDgH8fwVV+gFVDo3Z07j5connJJM4ktjG1AdIxDy0T8/6jjuvA5uqHCdawOGwt4CibVbWhGXY
	r2h+TTLGziomKR5zp/9F36kEZ61Zz59mrZhvCWh1MRpONuCmuLhvBHiqgfy0njUD7XpmkKDiBdp+d
	GzM89etCUt38z5aKzRmNg+Fg/Uksm7BMsFftjtx77oWR45ITEJ1ABgKAqH5MFb/iD3kLiK7Pdoin/
	joBNONs+LOpKXdl9pivAg+TOWL3e2waYu7+bovY9Sut0NpPi9I1wVQWtIMwRGYfTRh3p1IveCFn0M
	ebHLxC/U6qU6hlzjRI1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqGSw-00C56k-KZ; Wed, 02 Nov 2022 16:19:46 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqGSq-00C53Z-P9
	for kexec@lists.infradead.org; Wed, 02 Nov 2022 16:19:42 +0000
Received: from zn.tnic (p200300ea9733e741329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e741:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD8E31EC0430;
	Wed,  2 Nov 2022 17:19:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1667405974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=ctUPJdjla8y29oW3B4+64W0bgt4QgTUA8v3ryUYFh58=;
	b=raQPPbXwbL++XjPLIB8DJMN+f7mS8nnBI85D0ffQI+JnDLoc3LhNFhusdnLQtLteURbh4q
	L2AUcwrA4NOKA4drUUX6sy6gz9Uz/ix/h/NZbOLz6Ta9QDs7eDECN+oYcILOXu86Pjy3lI
	FfQWy+jf3LQ+qDBUpdP4y1zRasvoyVQ=
Date: Wed, 2 Nov 2022 17:19:34 +0100
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
Message-ID: <Y2KYls/Ji5E+4kPP@zn.tnic>
References: <20221031193604.28779-1-eric.devolder@oracle.com>
 <20221031193604.28779-8-eric.devolder@oracle.com>
 <Y2A4TqyOaPYBu4Hk@zn.tnic>
 <1c11a429-b5a9-fb55-fbef-b49e760e2d1e@oracle.com>
 <Y2I3zQ9ZU+C9Kgf7@zn.tnic>
 <06ef6e4b-1f42-d50f-1328-4f82fb34dd4d@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <06ef6e4b-1f42-d50f-1328-4f82fb34dd4d@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_091941_043584_867EC9F6 
X-CRM114-Status: UNSURE (   9.64  )
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

On Wed, Nov 02, 2022 at 09:55:06AM -0500, Eric DeVolder wrote:
> > "But on a plain simple laptop or workstation which has CPU hotplug,
> > would it make sense for the crash ranges to get updated too when CPUs
> > are offlined?
> 
> Yes, it does.

Why?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
