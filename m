Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED03C352A1
	for <kexec@archiver.kernel.org>; Wed,  7 Dec 2022 10:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gqHAlntd3bP2C/ss3PY1H8kID1Rjp0DeLWpYHIi24iw=; b=kCmWdAhchi4XQB
	hLQmRJ0YZN+1lEWFEbPU903XRiAWfvo1zf43Hu3ON6dOJ18y04vBn1fwA3Rbg3zhk/ozs5NthgsaM
	/Xh177k+WMIrDtsVbJ0vc8edL1I/Jt3rIkbsDIBtvlcFMavvGXruKKmYYf/d+wL4keS0qee9jpHmF
	D5PhuHcT9gYJktUop4sa2dacpuokCUrVkmfrclUDqHYU3gR1Hv0jr8+Yfc2ec97E4DPvvMSk5AVmI
	5X5XYtvk2qc8upwusaLUilFozTnJvv642OEnKS0tZmdrWUUWPH3P0OttNl3Q1R4chXrKYSmne7BY3
	hlHX5kfPrpkFOUSYYCRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2rE6-00GljB-HY; Wed, 07 Dec 2022 10:00:30 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2rE0-00GlVY-O2
	for kexec@lists.infradead.org; Wed, 07 Dec 2022 10:00:28 +0000
Received: from zn.tnic (p200300ea9733e711329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e711:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4966B1EC01E0;
	Wed,  7 Dec 2022 11:00:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1670407220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=DUM/83tRGUaZB9h8GVcioVC3NCH3y4zcvw9qQu3kuzk=;
	b=c9hmfDTUS5RhxyhcO0NCI4lffI1Vx2yxKDHDFl2Pr4X1pKPcJPBBYGnjbN5sGfak7xCkyu
	XsjS2lTFIOVJbaAwdznZjkavWcU5OCilrzz9yRYr3Z2PuEhh6a1HksUjuNcP//Fx97tgTe
	Lwdb6NVe40h+rOqeioLaRqdedoy3hvo=
Date: Wed, 7 Dec 2022 11:00:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
	dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v14 3/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <Y5BkL8x01KWoF502@zn.tnic>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
 <20221116214643.6384-4-eric.devolder@oracle.com>
 <Y4A1/cSekXUTFriC@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y4A1/cSekXUTFriC@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_020024_961302_606F0873 
X-CRM114-Status: UNSURE (   8.19  )
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

On Fri, Nov 25, 2022 at 11:26:53AM +0800, Baoquan He wrote:
> This kernel config CRASH_HOTPLUG is added in patch 7, but we have used
> it in the previous patch, not sure if this is acceptable.

Why would it not be acceptable?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
