Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EEDC38A02
	for <kexec@archiver.kernel.org>; Fri, 28 Oct 2022 10:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZmjI8DP1AkxF5bEW/L+mYPBLEm1EpgEyk8DOmJZH+3Q=; b=tOcDneflPFUiZs
	XdQrwUrUhdq9wLi3CvvopOVUmTrydBnw9z8sC2B5XVlWcOmfaOH9wg1E4wa0qZMPSgadT80VsgAHf
	QMK0ZsRNIfmcZr+sAeJQaItN8NUIwSqCitf11ZSrakXHuOo3P/tfU9se4Sih67M9a1WQjHpZJAbK1
	HaD5ef/fXYvRrDvd2yFaJm5kAFvWnHbvmLz95b0Cgif4JVYmS+nAtowbnpoBp4O154JK9/CLZ0SgZ
	n/GndWUUxkPCuGzfmTNzjqVRghnb5fUA308Tx8DgajMv2R2gqDDFWWIQHpTGp/dm1ox1T3UiGQWjs
	TztwYdm46B6fSrflsmBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooMSf-00Gcmm-OD; Fri, 28 Oct 2022 10:19:37 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooMSc-00GciV-Bx
	for kexec@lists.infradead.org; Fri, 28 Oct 2022 10:19:36 +0000
Received: from zn.tnic (p200300ea9733e7ce329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ce:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 369E51EC0523;
	Fri, 28 Oct 2022 12:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1666952361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=pnKOGkzAqYTHQEPw8aoAjfmGZ1+iB9PnhYVRmuE0Q+s=;
	b=UNvJ7Vp2kgarN+/wDOtP8BOPFsBNaaHPA1NI5oCgjBJ9RAFITLDoZSaTh1oTF8EC14K3cw
	rlE1QqX50TPrcfya1eMFzgk9/FDndlTUXLGAot114Ul/iuwJJbMnNePqwCKt9K0d9IJ8ck
	T93Fq3KVC9ezYRr1EIvrHobwC7hAcnA=
Date: Fri, 28 Oct 2022 12:19:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: Baoquan He <bhe@redhat.com>, david@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org,
	sourabhjain@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Y1uspLb7fLdtnQq+@zn.tnic>
References: <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic>
 <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
 <Y0b9apyIs+RpSo1e@zn.tnic>
 <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic>
 <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic>
 <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
 <35c98ca6-10f8-b248-78c5-99fce7e66c65@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <35c98ca6-10f8-b248-78c5-99fce7e66c65@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_031934_630142_9FE8F744 
X-CRM114-Status: GOOD (  12.83  )
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

On Thu, Oct 27, 2022 at 02:24:11PM -0500, Eric DeVolder wrote:
> Be aware, in reality, that if the system was fully populated, it would not
> actually consume all 8192 phdrs. Rather /proc/iomem would essentially show a
> large contiguous address space which would require just a single phdr.

Then that from below:

	pnum += CONFIG_CRASH_MAX_MEMORY_RANGES;

which then would end up allocating 8192 would be a total waste.

So why don't you make that number dynamic then?

You start with something sensible:

	total_num_pheaders = num_online_cpus() + "some number of regions" + "some few others"

I.e., a number which is a good compromise on the majority of machines.

Then, on hotplug events you count how many new regions are coming in
and when you reach the total_num_pheaders number, you double it (or some
other increase stragegy), reallocate the ELF header buffers etc needed
for kdump and you're good.

This way, you don't waste memory unnecessarily on the majority of
systems and those who need more, get to allocate more.

> I'd prefer keeping CRASH_MAX_MEMORY_RANGES as that allow the maximum phdr
> number value to be reflective of CPUs and/or memory; not all systems support
> both CPU and memory hotplug. For example, I have queued up this change to
> reflect this:
> 
>     if (IS_ENABLED(CONFIG_HOTPLUG_CPU) || IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {

If you're going to keep CRASH_MAX_MEMORY_RANGES, then you can test only
that thing as it expresses the dependency on CONFIG_HOTPLUG_CPU and
CONFIG_MEMORY_HOTPLUG already.

If you end up making the number dynamic, then you could make that a
different Kconfig item which contains all that crash code as most of the
people won't need it anyway.

Hmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
