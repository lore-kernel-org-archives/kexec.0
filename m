Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AC6C5B56A
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 10:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yOuo0kLBfTaW0LoLZDyKlhu1xxxUaNKKmsbb4h1Z+40=; b=kamtlKN3gI28sZbi62lhiYpJJu
	FOCBPXWia8lcyQXbLsvtIKVU20ro7Hs4s8eRFtLf2QxiRO5f0iUke/clNoUsSwHCCCdtRqDyEkSzt
	UBuLoEOUnjt8f1DgpQkWTIExz1dpu6Ja6EWjCODKECZcRCvIpQ4mhA75G269FEajGf6qmPuIcLyVe
	Z7va42DfGsALHNiYjgBiey0uwSTbgW8Nvir/xhNeuNCJMyIr9naAHx8MuWVwOXe0YvNXRYO6cdcLw
	Ye4gkQ73XV5NLlmnqAwg56oOayiH2VsW5D6G8lIzEF3q15VsAvZzLQMP9SHnIx4gz7AMsW59cYxkb
	InrBUj9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu69g-0000000FtDG-25Km;
	Wed, 12 Aug 2026 10:25:52 +0000
Received: from out-130.mta1.migadu.com ([2001:41d0:203:375::82] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu69d-0000000FtBj-1cnK
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 10:25:51 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=q5MYyeCMd7o+EpTB61t9PlYNh3ovoXInblTdWVqkpxw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786530344; v=1; x=1787135144;
 b=aegPKZyQC3yD3GZxw+b0myQk6Io7ghNqSOkWfkMn54+5yDFtxrH1J9lFWIqSSknnKlUQe/ZP
 lKNrVW1u2YhfDDbJ4mWtFWqvOubD7pELATkTOBYi0OInJFnEHXXF961jmSvhMf+i17O0Xt3EdF3
 /IR44tVNmdMzcz0b8GnF1d4Q=
X-Envelope-To: kexec@lists.infradead.org
Received: from localhost (223.70.160.239)
	by smtp.migadu.com with ESMTPS id 1b4a02814f740c27;
	Wed, 12 Aug 2026 10:25:44 +0000
X-Migadu-Scanner: mta11.migadu.com
Authentication-Results: mta11.migadu.com;
	none
From: George Guo <dongtai.guo@linux.dev>
To: pratyush@kernel.org
Cc: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	shuah@kernel.org,
	ardb@kernel.org,
	chenhuacai@kernel.org,
	guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 3/4] liveupdate: luo_session: include linux/mm.h for virt/phys translation
Date: Wed, 12 Aug 2026 18:25:32 +0800
Message-ID: <20260812102532.32673-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2vxzfr0l6fam.fsf@kernel.org>
References: <2vxzfr0l6fam.fsf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_032549_569116_241C2F14 
X-CRM114-Status: UNSURE (   9.12  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Pratyush,

You are right: the current luo_session.c does not call virt_to_phys() or
phys_to_virt(). I failed to update the target of this fix when rebasing the
patch. The calls that trigger the current failure are in
kernel/liveupdate/kho_block.c. Sorry about that.

I also checked the include chain. asm/kfence.h is not included by this
translation unit. include/linux/slab.h does not include linux/kfence.h; that
inclusion is in the MM-private mm/slab.h. Moreover, asm/kfence.h itself
includes linux/kfence.h, which includes linux/mm.h, so
arch_kfence_init_pool() already has the required declarations.

The actual failure is:

  kernel/liveupdate/kho_block.c: In function 'kho_block_set_is_cyclic':
  ./arch/loongarch/include/asm/io.h:81:9: error: implicit declaration of function 'page_address'
  kernel/liveupdate/kho_block.c:210:16: note: in expansion of macro 'phys_to_virt'

The underlying issue is that LoongArch's CONFIG_KFENCE version of
phys_to_virt() uses page_address(), which is provided by linux/mm.h.

Your broader point about fixing this at the architecture level is valid. I
previously tried including linux/mm.h from asm/io.h [1], but that introduces a
circular include through:

  linux/slab.h -> linux/kasan.h -> asm/kasan.h -> asm/io.h
  -> linux/mm.h -> linux/slab.h

As reported by the kernel test robot [2], this leaves kfree() undeclared while
linux/mm.h is being parsed. A proper architecture-wide fix therefore requires
refactoring the address conversion helpers rather than adding that include to
asm/io.h.

For this series I will move the linux/mm.h include from luo_session.c to the
actual user, kho_block.c, and consider the architecture-wide cleanup
separately.

[1] https://lore.kernel.org/r/20260521063310.52926-1-dongtai.guo@linux.dev/
[2] https://lore.kernel.org/r/202605211925.DbDvQ6ii-lkp@intel.com/

Thanks,
George

