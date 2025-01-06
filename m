Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330ACE77188
	for <kexec@archiver.kernel.org>; Mon,  6 Jan 2025 15:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L0cWKwesGUWu0kJbylqFSkdZr5QpTpSeBpe/e0xZI0Y=; b=izSEtPP/vj/ZWyYrwCM7S7ARSE
	aW9rpHfnqjkzQfEdn0G6pvh8i5jYEldPL+OpQ2LvX8a7XZGDNe+RkvqMzCE2sAc79JTkYRxk9NopM
	vY5h5zXZ1P30dhHS/eDR9o0FCqmCrgDJ+Rx1e5GVRJdpox95B6/s+BQK9HcZGi0U5kxivL4wJjYNF
	zaC/rFZgszs/sKoD2ml3yhzy5T0zsK+dO50N6oeF/NyfF7GBuu+nvmuMyAMMz99MWKxUQ2ZPR8Nvn
	vxQMgp035y2DnRUk45QjgwWBiXcULSOyXutnb/oIhNuvaRFdMAC19V1Ec3sM3uUGEiyhQ8sdbM8bP
	5c5sy3dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUoyK-00000001kmI-2Vgw;
	Mon, 06 Jan 2025 15:24:52 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUox6-00000001kMH-2nUw
	for kexec@lists.infradead.org;
	Mon, 06 Jan 2025 15:23:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99914143D;
	Mon,  6 Jan 2025 07:24:03 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16DE23F59E;
	Mon,  6 Jan 2025 07:23:32 -0800 (PST)
Date: Mon, 6 Jan 2025 15:23:30 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, devel@daynix.com
Subject: Re: [PATCH v2 0/5] elf: Define note name macros
Message-ID: <Z3v1clew2t+XH5F5@e133380.arm.com>
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_072336_745875_38C5AEA9 
X-CRM114-Status: GOOD (  13.75  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,

On Sat, Jan 04, 2025 at 11:38:33PM +0900, Akihiko Odaki wrote:
> elf.h had a comment saying:
> > Notes used in ET_CORE. Architectures export some of the arch register
> > sets using the corresponding note types via the PTRACE_GETREGSET and
> > PTRACE_SETREGSET requests.
> > The note name for these types is "LINUX", except NT_PRFPREG that is
> > named "CORE".
> 
> However, NT_PRSTATUS is also named "CORE". It is also unclear what
> "these types" refers to.
> 
> To fix these problems, define a name for each note type. The added
> definitions are macros so the kernel and userspace can directly refer to
> them.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Should this be Cc'd at least to the GNU binutils or gdb folks?
Also the glibc and elfutils projects, both of which maintain a version
of elf.h.  They may have their own view on the best way to approach
this issue.

If cross-posting to other project mailing lists, it might make sense to
add a bit more background explaining the motivation for the change.

[...]

Cheers
---Dave

