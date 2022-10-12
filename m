Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31106C433FE
	for <kexec@archiver.kernel.org>; Wed, 12 Oct 2022 20:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QRHQ6XaQnqhYrxh3CiOgLQZBVeWTOVr8PqBnZ7YEADY=; b=xN7klklDTi/8s6
	r3mZpla507ZWBYls0dUWcBqsSq7+yta3e5D7a+jrIH7Y0ifWkN/9DqcQJs4CeYfzvne03EAqBRfjT
	2TPWUAmI0nx09VmrwAZiDMBRAGDxaLnNMRXXln9FY7hdT7zggpb13ZxLK1I/pDqjwjS5LO8QlZfeS
	AtijaIpLnZT4AvmYbIT8FlzLO9XBMmOQRZeWjxe4oBT4apWFdKeCM1PUTQhmHjXlkey3VW4N8iz6U
	BygOqNRLycAad99QQadGm9t8JNTBD2sQ6ik1aa4zPrJHZSUzSFd2fowPvIkCRlr7mSzPYEAvPucYz
	RqTO2Mdl2lC1h5DgIuWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiiXZ-009IwY-AZ; Wed, 12 Oct 2022 20:41:21 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiiXW-009Ivd-Nf
	for kexec@lists.infradead.org; Wed, 12 Oct 2022 20:41:20 +0000
Received: from zn.tnic (p200300ea9733e705329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e705:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A9D91EC064C;
	Wed, 12 Oct 2022 22:41:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1665607273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=rE+ld/p5MuyBsBdPS4nma7ByO8JmhPHSjwCTmH8KlTA=;
	b=lqWl4BuLduJ3cJte9Z55R4LFYPgBq/itUyfWHhlFRRavXHfLWW+asqhSGbSdLQ0Symthgj
	EuIYudNyFi6l+MMLTCXGPYbncicbFioO5jcLU8vzlbYGr6ZQ6sUErm4kW3dHai2kYy8kGo
	1yQ0Hn1VZj7rK32aWyV9Yyuvy/O+BPo=
Date: Wed, 12 Oct 2022 22:41:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: Baoquan He <bhe@redhat.com>, Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org,
	sourabhjain@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Y0cmaPTKQuWtwIRh@zn.tnic>
References: <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
 <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <Yzceb/y3SSFMuALR@zn.tnic>
 <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic>
 <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
 <Y0b9apyIs+RpSo1e@zn.tnic>
 <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_134118_970564_39C857E2 
X-CRM114-Status: UNSURE (   8.41  )
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

On Wed, Oct 12, 2022 at 03:19:19PM -0500, Eric DeVolder wrote:
> We run here QEMU with the ability for 1024 DIMM slots.

QEMU, haha.

What is the highest count of DIMM slots which are hotpluggable on a
real, *physical* system today? Are you saying you can have 1K DIMM slots
on a board?

I hardly doubt that.

> So, for example, 1TiB requires 1024 DIMMs of 1GiB each with 128MiB
> memblocks, that results in 8K possible memory regions. So just going
> to 4TiB reaches 32K memory regions.

Lemme see if I understand this correctly: when a system like that
crashes, you want to kdump *all* those 4TiB in a vmcore? How long would
that dump take to complete? A day?

IOW, how does a realistic use case of this look like - not a QEMU one?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
