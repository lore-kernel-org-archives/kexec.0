Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23070C4332F
	for <kexec@archiver.kernel.org>; Wed,  2 Nov 2022 18:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zxickAcBnTuIoihRmyaEZxNWsPJYWEk6YA8eA7nRyos=; b=vWiX9G9KhwmiO4
	iNjyn1ApZBLE63ywVRx2xrleE7iXiLHQI0fwkaj3BgMIbxIX911Nsz8J9lix5eub1rbpYZPDUeeGS
	CS2WLfd+Y93Q7xO8IGFqQ8Hd/RhZbtWNdO7Sq87ETbeGYnILTBW/mRah9sFNxWoIYC/rUfedzp/Tw
	NF7KUNsnLgJJ3U7cOy9aC/0EWGhysZ96v+bx1zquH8xwktnm6iSolrsYsh5LnFoDfwjeAbklytEbl
	h9g6DxPL7S+jU9vSu6lJkzjB87UWAwsMIGJ75xLIxl3afiho3qBi/1xmYp1N8WXWcQvw3euvrcM+p
	N/pp3UzQyHO9VKk9bfhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqIrC-00DJlj-Jy; Wed, 02 Nov 2022 18:52:58 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqInt-00DH8f-6i
	for kexec@lists.infradead.org; Wed, 02 Nov 2022 18:49:34 +0000
Received: from zn.tnic (p200300ea9733e741329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e741:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 683951EC0426;
	Wed,  2 Nov 2022 19:49:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1667414971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=mxQPFn4VApQbB8DR3S7WCXnD5Fw6PWq0YrvohTIv6T0=;
	b=DGCSacQnm9py2kWOxRnUFJJBaB/7uju6cLCKCJfO/Z57vhznDBC3OG6XXP6RT0NlNnhWVC
	sOBJYulAsrSlJOTdxxbR4jgCUWyH081sWheuRMz2bCZyyecu4b7HdEeP3W2jnO9JCty8bM
	B5fnXC7IU/UeoHh/BGRnJds8maQIOnc=
Date: Wed, 2 Nov 2022 19:49:31 +0100
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
Message-ID: <Y2K7u+KfkdBxJ01h@zn.tnic>
References: <20221031193604.28779-1-eric.devolder@oracle.com>
 <20221031193604.28779-8-eric.devolder@oracle.com>
 <Y2A4TqyOaPYBu4Hk@zn.tnic>
 <1c11a429-b5a9-fb55-fbef-b49e760e2d1e@oracle.com>
 <Y2I3zQ9ZU+C9Kgf7@zn.tnic>
 <06ef6e4b-1f42-d50f-1328-4f82fb34dd4d@oracle.com>
 <Y2KYls/Ji5E+4kPP@zn.tnic>
 <c08bb557-846c-0f82-391a-3eeda7e6ea67@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c08bb557-846c-0f82-391a-3eeda7e6ea67@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_114933_442264_10DCD79C 
X-CRM114-Status: UNSURE (   9.85  )
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

On Wed, Nov 02, 2022 at 11:54:08AM -0500, Eric DeVolder wrote:
> Technically the answer is no; cpu hotplug events are independent of memory
> hotplug events, but both are written into the elfcorehdr, so in reality
> yes... The elfcorehdr contains a single list of Phdrs describing CPUs and
> crash memory ranges; the entire list is re-written on a hotplug change.

Then technically also yes. Otherwise your crash information will contain
wrong CPU numbers.

How has that not been a problem until now...?

I.e., offline a bunch of CPUs and then cause a crash dump.

Hmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
