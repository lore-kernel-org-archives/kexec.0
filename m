Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F22C28B30
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XG0wqFmwsxrmne3nL6ZkYnlCZrYNfChfarzF2/Lhc48=; b=h3R+MTBwLXOGTqRsU0zn//TCKt
	qBeeYZEXO2a4yG0yXoqMOBBBlNjzxfv1/RFWJxfPb9iGI489TyjHlPn3j8yH8se/Ky5aL9peOAvTw
	S/lKlst/tp3xuEbttko6FcDBZmdjXWr/VQxAmH0xypaPOa4+fsT0Iti8tLguqh2tcXHkXGu+pvruU
	cGqKVRNZ2V5LSszD4DyV4AoHqyNETQByeEnVsXqVIFQMVNvyhGrBDrH3NuJ94KCiP/Ieu+xcuqDqB
	DnX5Zn27fJY1DcioEgepPLebJT0h8VauwZqStwbKmYVm7/Zg3Re8a3AX7+CADuj1P8VNV7RCtWm8r
	SvKACUPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHRy-0000000CU0E-1tDK;
	Thu, 20 Mar 2025 15:04:50 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmGBV-0000000BXlF-0rjc;
	Sun, 23 Feb 2025 17:54:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5A9BF6114A;
	Sun, 23 Feb 2025 17:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009D7C4CEDD;
	Sun, 23 Feb 2025 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740333271;
	bh=9iFdhdTQZ2gneruKLG7YkE93h9YE3aeXMlyNM4pD9u8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhMQcmO5owvm412qh9aUibQCAE5R3H0Y3labMbi96L/jt2+CCd3WvH8UF16mZ5MQB
	 Op9z/uv4OxpBHVLnUkOdjvePsC4VrM+yzCROUe68AVgBUrv7w2DmJHs4xbHfzB8QpG
	 Ozv4nty8IY+SrpRbBFPQHCs0ru5G1hevXj0yQo/cLPvQgyoOxJf1iid9sarJrcIcRd
	 eCJ2zlHemard7aIoWHBWDMYtSOYnbGfGHmDHpa7KlLg3WtovNvwgZK8HmKTQRBnOID
	 k675DyqrTrGHvR6fyQY78uyW/dVn8TdfgorHiV6DURp3ebpe+dlJCScpuL1M0bgk3c
	 jWSaiEQEmv7uA==
Date: Sun, 23 Feb 2025 19:54:07 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Dave Young <dyoung@redhat.com>, Alexander Graf <graf@amazon.com>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	Philipp Rudo <prudo@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
Message-ID: <Z7tgvwRkV-GAtBL_@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <CALu+AoRMQyRDFS_4L0KQkmrFT_S+yk=uZ-Mqt86JQYKKnj-5Ug@mail.gmail.com>
 <Z7WJD6eBLuIRnLwk@kernel.org>
 <CALu+AoSaEthfed1NOYPiQgm_g-dhibVMRAp0+=_+9qTT4_x=tg@mail.gmail.com>
 <d8c43707-65a2-4176-85e2-acdb4c9d16ad@amazon.com>
 <CALu+AoR0BbmbZeOkLU55OpD8kxGsVnFs+pXgEC9Y_MpB4=GMvQ@mail.gmail.com>
 <Z7dbxJNxlW2EA_aa@tuxmaker.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dbxJNxlW2EA_aa@tuxmaker.boeblingen.de.ibm.com>
X-Mailman-Approved-At: Thu, 20 Mar 2025 08:04:44 -0700
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

On Thu, Feb 20, 2025 at 05:43:48PM +0100, Alexander Gordeev wrote:
> On Thu, Feb 20, 2025 at 09:49:52AM +0800, Dave Young wrote:
> > On Wed, 19 Feb 2025 at 21:55, Alexander Graf <graf@amazon.com> wrote:
> > > >>> What architecture exactly does this KHO work fine?   Device Tree
> > > >>> should be ok on arm*, x86 and power*, but how about s390?
> > > >> KHO does not use device tree as the boot protocol, it uses FDT as a data
> > > >> structure and adds architecture specific bits to the boot structures to
> > > >> point to that data, very similar to how IMA_KEXEC works.
> > > >>
> > > >> Currently KHO is implemented on arm64 and x86, but there is no fundamental
> > > >> reason why it wouldn't work on any architecture that supports kexec.
> > > > Well,  the problem is whether there is a way to  add dtb in the early
> > > > boot path,  for X86 it is added via setup_data,  if there is no such
> > > > way I'm not sure if it is doable especially for passing some info for
> > > > early boot use.  Then the KHO will be only for limited use cases.
> > >
> > >
> > > Every architecture has a platform specific way of passing data into the
> > > kernel so it can find its command line and initrd. S390x for example has
> > > struct parmarea. To enable s390x, you would remove some of its padding
> > > and replace it with a KHO base addr + size, so that the new kernel can
> > > find the KHO state tree.
> > 
> > Ok, thanks for the info,  I cced s390 people maybe they can provide inputs.
> 
> If I understand correctly, the parmarea would be used for passing the
> FDT address - which appears to be fine. However, s390 does not implement
> early_memremap()/early_memunmap(), which KHO needs.

KHO uses early_memremap()/early_memunmap() because it parses FDT before
phys_to_virt() is available on arm64 and x86. AFAIU on s390 phys_to_virt()
can be used at setup_arch() time, so it shouldn't be a problem to add
appropriate wrappers.
 
-- 
Sincerely yours,
Mike.

