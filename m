Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5920C04A95
	for <kexec@archiver.kernel.org>; Tue, 25 Oct 2022 10:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ko8n7K6A83JHPgVjT3H/BMcNDax7CcUTCRNwtWWQNWw=; b=Tv3KzSqwkAAtfj
	EjIlGfH1t1Z4+0A9LtXHK4vAAEJsIxu9/4kROi/qH+HTmnDXy2Gt0JRZUneYFarT5gH7w64jWGWOY
	fzqQh+OVppeszuX4cCR9eE0dk1H/kGjN5lHSEDITKyMat1niR0h70mQaniF74QS9Ux+7oBvzH+mMU
	TV+7CRuDZtL1EzHrQDAG2xpIe7j2N0PrWsl+zaFCznAXRz7F6vydClHQU367xuXsscZqMGpXj2UzD
	DPqk5JSaAeR+gp6TWOJW6+Bx/PGQfIO+4BHSOj9EK3J2pyO+ND2A/n6XlCw+bOjlw6IQaopoKgb91
	dnang0Ir5lnav60anyug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onHE6-004nrN-LT; Tue, 25 Oct 2022 10:32:06 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onHE1-004npy-1e
	for kexec@lists.infradead.org; Tue, 25 Oct 2022 10:32:02 +0000
Received: from zn.tnic (p200300ea9733e753329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e753:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 594351EC04CB;
	Tue, 25 Oct 2022 12:31:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1666693919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=ai++jgLmenhahiBLse1vLJYEB/bd3+G6lQ4acR+CSyY=;
	b=P0z3I0xwj2YyygD/nk8kPmHQz8xOPhwrirQ4FKwWdW+LYy3NzSZiRAcnVsDad4/4TyA+Id
	C+dIkSRTyCBWdW6AUgSdcRLJzREMPfzuSdYMC78Rx5/r6BqAXRtj4u1KDAn+pdlC6xIfU4
	MRXEub1PBMS0Jdrf8LEWllVjz5u5FYg=
Date: Tue, 25 Oct 2022 12:31:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: Eric DeVolder <eric.devolder@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org,
	sourabhjain@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Y1e7Hw0PRDI9NxU9@zn.tnic>
References: <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <Yzceb/y3SSFMuALR@zn.tnic>
 <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic>
 <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
 <Y0b9apyIs+RpSo1e@zn.tnic>
 <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic>
 <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_033201_260520_64C78CA1 
X-CRM114-Status: GOOD (  15.17  )
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

On Thu, Oct 13, 2022 at 10:57:28AM +0800, Baoquan He wrote:
> The concern to range number mainly is on Virt guest systems.

And why would virt emulate 1K hotpluggable DIMM slots and not emulate a
real machine?

> On baremetal system, basically only very high end server support
> memory hotplug. I ever visited customer's lab and saw one server,
> it owns 8 slots, on each slot a box containing about 20 cpus and 2T
> memory at most can be plugged in at one time. So people won't make too
> many slots for hotplugging since it's too expensive.

There you have it - the persuading argument.

> I checked user space kexec code, the maximum memory range number is
> honored to x86_64 because of a HPE SGI system. After that, nobody
> complains about it. Please see below user space kexec-tools commit in
> https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> 
> The memory ranges may be not all made by different DIMM slots, could be
> firmware reservatoin, e.g efi/BIOS diggged out physical memory,
			    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I don't know what that means.

If it is firmware crap, you want to exclude that from kdump anyway.

> Now CONFIG_NR_CPUS has the maximum number as 8192. And user space
> kexec-tools has maximum memory range number as 2048. We can take
> the current 8192 + 2048  = 10K as default value conservatively. Or
> take 8192 + 2048 * 2 = 12K which has two times of maximum memory range
> bumber in kexec-tools. What do you think?

I still think that we should stick to reality and support what is
possible not what is potentially and theoretically there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
