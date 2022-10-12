Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C900EC433FE
	for <kexec@archiver.kernel.org>; Wed, 12 Oct 2022 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nb75LE9L6t8c7Myw3XKKTtrMmwbpfUW6lsAieCvx1FQ=; b=BUTku/eqvWpAkp
	woUjIwT6/+/hBMFcjy7aM5O/1SR5Y81h1I5kFw8f/0OLjrwZuPhyhhNVDZxBZSDdWeJGA/tIW5QL4
	0kQCqxL/EcQR92U/cpgmZWW/ULIQRume0BHjL3cg/Pqsv+4+7H+/yxShAlHMu18Sx3NXTJZhxRCwg
	3mBoaNjT4BsNLtZ+YiUKiPfBQARDEFe8Je27LXvzeDywIgGI9VX1L8h/KQc3bw2fqO5FFgNhyvYuC
	qOuUDmoqws+p1pRs7M6xdWgEj+5Jk5Cyh7agJ8sHjGOVI3CrDgLEoBCUBEDG9LVAEwpt2plW5A2S4
	LWNePMWDUhkFiPNGE0Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oifoM-008tZd-Ps; Wed, 12 Oct 2022 17:46:30 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oifoJ-008tZA-MG
	for kexec@lists.infradead.org; Wed, 12 Oct 2022 17:46:29 +0000
Received: from zn.tnic (p200300ea9733e705329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e705:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E58A01EC0230;
	Wed, 12 Oct 2022 19:46:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1665596782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=Meljy89lAYExQlzfDo2HCH7IawAQ8LDvQAy651p5TKE=;
	b=eZymPjEFV/FwQ8Rxc+xKEUGadAuWqwhaK1hnhI9q3UT0JUCatTADf74Y4LJuMtCmnplwLu
	WT5stDquCviENtkSPoBEDcHALazjwMlGx+sYEsBNZc2KpzhrIxBA6tBl91O1i1n1GT0EKD
	9PU6VGgv4181HTIajDnoQoTkcA1qhXo=
Date: Wed, 12 Oct 2022 19:46:18 +0200
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
Message-ID: <Y0b9apyIs+RpSo1e@zn.tnic>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
 <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <Yzceb/y3SSFMuALR@zn.tnic>
 <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic>
 <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_104627_896679_FAD23164 
X-CRM114-Status: GOOD (  11.72  )
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

On Sat, Oct 08, 2022 at 10:35:14AM +0800, Baoquan He wrote:
> Memory hptlug is not limited by a certin or a max number of memory
> regions, but limited by how large of the linear mapping range which
> physical can be mapped into.

Memory hotplug is not limited by some abstract range but by the *actual*
possibility of how many DIMM slots on any motherboard can hotplug
memory. Certainly not 32K.

So you can choose a sane default which covers *all* actual systems out
there.

> For the Kconfig CRASH_MAX_MEMORY_RANGES Eric added, it's meaningful to
> me to set a fixed value which is enough in reality.

Yes, exactly.

> For extreme testing with special purpose, it could be broken easily,
> people need decide by self whether the CONFIG_CRASH_MAX_MEMORY_RANGES
> is enlarged or not.

I don't want for people to decide on one more thing where they have to
go and read a bunch of specs just to know what is a good value. So we
should set a sane, *practical* upper limit and simply go with it.

Everything else is testing stuff and if you test the kernel, then you
can change limits and values and so on as you want to.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
