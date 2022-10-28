Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62BDC38A02
	for <kexec@archiver.kernel.org>; Fri, 28 Oct 2022 22:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DmgskkIq040NLm+cBmup1yi3dxrN/fsdAJgTzPSnae4=; b=4UUChQ1fZL74k7
	Cz7haOXx1bOS2X+ngrJRnBIXosjL8nLmomkTtLDo3xkvLutQgoa9PaDGUkYJeJK/EVDBaSINNmYo7
	7WGvQkvggmwLDwZvv/nXujetodtbeF3gUcmrwRdN+Xr1DHAzaheK2h1aDDvnc2C56IhlVorYnKgqO
	UjJY3YO/xNGnFdZ4nT78219pPpCpEhI7xoyvdP8aSaVdiAZPzkGdWo23N2MMXJ+AMCihxuLY2Gc66
	YZh1pBH5Gwhd3dGZOO/zHW5C3ANIMxkYf7g42INbOTQTQJ+7vWfLHuBjMPO86c8G3udLFe1rXVIlk
	MXMEYhC8CmkS/6zv3Ipg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooXhh-0038Es-Q7; Fri, 28 Oct 2022 22:19:53 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooXhe-0038CT-K8
	for kexec@lists.infradead.org; Fri, 28 Oct 2022 22:19:52 +0000
Received: from zn.tnic (p200300ea9733e788329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e788:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80CE61EC0528;
	Sat, 29 Oct 2022 00:19:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1666995581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=TfhnsJUpPMTXVXSAObYcxWoYzhndg9xgfrbCtO8qJg8=;
	b=biUeAUKviqathMxYm+Bwp2HnXAPF3Q0cZ9xpG1gNXK2n1zQAT9gAJrA9ecY15dFOwNJx72
	BU9WupVYS4qRsVX/NFtxogp54qzVsLcpqjfMgYq/IgphWfOW+vlZEeyWrDj9T5skvB3j4c
	k6GBeC0u8oqcEm6ue0er+Ip0x7VnrnU=
Date: Sat, 29 Oct 2022 00:19:36 +0200
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
Message-ID: <Y1xVeP/RtG37zLYm@zn.tnic>
References: <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic>
 <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
 <35c98ca6-10f8-b248-78c5-99fce7e66c65@oracle.com>
 <Y1uspLb7fLdtnQq+@zn.tnic>
 <d91f8728-6a63-415d-577c-bd76e69ec7f6@oracle.com>
 <Y1wL+ZrvD5gTZaKN@zn.tnic>
 <ca43bd5f-8a74-9412-3d4b-52c7d5e54978@oracle.com>
 <Y1w76RwZUKUvsS7A@zn.tnic>
 <43f16833-add1-80c3-3bf8-5a6a05e75be6@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <43f16833-add1-80c3-3bf8-5a6a05e75be6@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_151950_846221_5A2F394D 
X-CRM114-Status: UNSURE (   8.87  )
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

On Fri, Oct 28, 2022 at 04:22:54PM -0500, Eric DeVolder wrote:
> /*
>  * For the kexec_file_load() syscall path, specify the maximum number of
>  * memory regions that the elfcorehdr buffer/segment can accommodate.
>  * These regions are obtained via walk_system_ram_res(); eg. the
>  * 'System RAM' entries in /proc/iomem.
>  * This value is combined with NR_CPUS and multiplied by sizeof(Elf64_Phdr)

NR_CPUS_DEFAULT

>  * to determine the final elfcorehdr memory buffer/segment size.
>  * The value 8192, for example, covers a (sparsely populated) 1TiB system
>  * consisting of 128MiB memblock size, while resulting in an elfcorehdr
>  * memory buffer/segment size under 1MiB.

... and it is a sane choice trying to accomodate both actual baremetal
and VM configurations."

Yeah, it's a good start.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
