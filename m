Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55200C4332F
	for <kexec@archiver.kernel.org>; Wed,  2 Nov 2022 09:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YZbQZYAFv+bknIkz5io5OCi4PU8w6dlCRAqbVwQtlvg=; b=vurMmCWKO+xSw/
	katKUM+jhvhpzdDwKnVdGzRPxxmMC/WFi0Gu31HmTOmpYWSKv9LaGGCnKTVU86QWHwaierxHE6Bnq
	irEFuFBk3Mek8MESi1VO5SjkjdWg0FWsKJl5reWhsnsbFSur9J4+EPyD+XMFDFOa6yFYAEOB64EZn
	kyt4b4GD1GepzPnPW81Xw50avgo2XMV1yKb89tpY8SITYiClN0SoegiOPyUwcNSTJf5Ut0cKKA5k9
	TiMiKBSqIWOyaIG1MPQsAvsYdQ3mAWK0KSthIeEkGimxkKYiRD9pHXgsWnvPF/wfAOGjvB+wbVk7j
	jlN9AwFhMVr1NAhyNMvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqA1d-00AEQf-3U; Wed, 02 Nov 2022 09:27:09 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqA1S-00AE3B-8R
	for kexec@lists.infradead.org; Wed, 02 Nov 2022 09:27:04 +0000
Received: from zn.tnic (p200300ea9733e741329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e741:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80EAB1EC0430;
	Wed,  2 Nov 2022 10:26:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1667381202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=A0v1SSP7U6jTvUstX50tbbFbb8CtyALOrKeuLWDyfEk=;
	b=OgAQ+L5YcVvR26mLMQSB4Vcad5uowOGgWp/UNQ0HImLvIre2uKl0eXFxvSvywZ2W1caklz
	LO9POthkj+T57/rFr46sZZxJjuOxwCFVgAxpGqIeGee5nEHhD1qcL4NgCUrXqCgku+lOcj
	GfpqEzWHSBq7wX6xJQwNuxRX+X1K0V8=
Date: Wed, 2 Nov 2022 10:26:37 +0100
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
Message-ID: <Y2I3zQ9ZU+C9Kgf7@zn.tnic>
References: <20221031193604.28779-1-eric.devolder@oracle.com>
 <20221031193604.28779-8-eric.devolder@oracle.com>
 <Y2A4TqyOaPYBu4Hk@zn.tnic>
 <1c11a429-b5a9-fb55-fbef-b49e760e2d1e@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1c11a429-b5a9-fb55-fbef-b49e760e2d1e@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_022658_471898_46176849 
X-CRM114-Status: GOOD (  14.63  )
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

On Tue, Nov 01, 2022 at 10:45:00AM -0500, Eric DeVolder wrote:
> As I'm re-reading that message, I suspect now the preference is to just to
> strike this ifdiffery line in this file and have the code always present?
> 
> If the preference is actually for CRASH_HOTPLUG, then let me know.

Well, it is this part:

"But on a plain simple laptop or workstation which has CPU hotplug,
would it make sense for the crash ranges to get updated too when CPUs
are offlined?

If so, I think you want this code present there too, without a Kconfig
item."

IOW, if this thing doesn't make sense to have on the majority of
machines out there - and memory hotplug machines are not the majority -
then it should be behind a Kconfig item which is default off and gets
enabled only when the user selects crash and memory hotplug...

I'd say.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
