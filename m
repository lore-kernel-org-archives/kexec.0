Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F227ECAAA1
	for <kexec@archiver.kernel.org>; Fri, 28 Oct 2022 20:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZDOUpOxA1uJX2kW/Zl5pCq8PW3dZOnSoWJ+hSl+Razs=; b=G032btRVCZKKmT
	UAeh4/kCx3ntIvzcKtg8HV7twytAZ/VMVWBHkmMSvHiMNLdRfhMt9wfd/H4L/98kcndICjARdD6Gc
	BgjLLhzwIap0rEB2Fe9DXWTdo8H8pdWb5uM3E3g1ecVexEgz2tXodHLqqOHzcmcOQjBXOzIpfZd2e
	szwDGXQ10OBswx8zHgXTMRt98AUSsF9GVWQjOZwUv/miBDEnPR44c8WPdqjZDj/4ayPkAlx9Xu51J
	t/ihVHw9mejJz9cUv/Y7Ef2gqs+hiJWPnYLz8LXZMv6mhFKFoAZHwQGQ9r8mk8iX/75XvjZMOPnza
	x8Sd7Os7OZCm9ANzeuOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooW0J-002Bl8-8D; Fri, 28 Oct 2022 20:30:59 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooW0G-002BjR-Pn
	for kexec@lists.infradead.org; Fri, 28 Oct 2022 20:30:58 +0000
Received: from zn.tnic (p200300ea9733e7ce329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ce:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 758D11EC06D8;
	Fri, 28 Oct 2022 22:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1666989047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=wV+E+/SMNeV699Rje9XOtWwOh+RoW8MB13Rtk2kIH54=;
	b=Zgd42Z5SFTE8Xc3j3xc1VSLfYMBJFZVxHZyh6fjY141Qi+2badS1kc1kDjx2+dxSbyqIRK
	dcu+8tgMur56gLjZL1CFgFjliSpNQn6T0MLV2JsrpxAhn/1OVcXtElWXfTcn+cHOFE2mFr
	X7eDXclf2JgXUf9AC3BZRYyu1Kw+mig=
Date: Fri, 28 Oct 2022 22:30:33 +0200
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
Message-ID: <Y1w76RwZUKUvsS7A@zn.tnic>
References: <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic>
 <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic>
 <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
 <35c98ca6-10f8-b248-78c5-99fce7e66c65@oracle.com>
 <Y1uspLb7fLdtnQq+@zn.tnic>
 <d91f8728-6a63-415d-577c-bd76e69ec7f6@oracle.com>
 <Y1wL+ZrvD5gTZaKN@zn.tnic>
 <ca43bd5f-8a74-9412-3d4b-52c7d5e54978@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ca43bd5f-8a74-9412-3d4b-52c7d5e54978@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_133057_015674_7F099112 
X-CRM114-Status: UNSURE (   9.02  )
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

On Fri, Oct 28, 2022 at 02:26:58PM -0500, Eric DeVolder wrote:
> config CRASH_MAX_MEMORY_RANGES
>     depends on CRASH_DUMP && KEXEC_FILE && MEMORY_HOTPLUG
>     int
>     default 8192
>     help
>       For the kexec_file_load path, specify the maximum number of
>       memory regions, eg. as represented by the 'System RAM' entries
>       in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
>       This value is combined with NR_CPUS and multiplied by Elf64_Phdr
>       size to determine the final buffer size.

No, do this:

config CRASH_MEMORY_HOTPLUG_SUPPORT
    depends on CRASH_DUMP && KEXEC_FILE && MEMORY_HOTPLUG
    help
      Help text explaining what this feature is

this thing will simply get enabled when the user enables MEMORY_HOTPLUG
and CRASH_DUMP.

and then you do in the code:

/*
 * A comment explaining how the 8192 value has been selected.
 */
#define CRASH_MAX_MEMORY_RANGES	8192

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
