Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4BBC001DE
	for <kexec@archiver.kernel.org>; Mon, 24 Jul 2023 13:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=cY/XMeKAfZFwIt3OWcjFuuqN5tK7/cy6k/l95bndoWE=; b=p/I41Bts0F7FkEQH9p9nVJBf6F
	kC2nDn94jHUFqI/gWZvSRJ+SQZWomCLJuhh0fJebS0zNvzYXWmrEfHYJzs0NAURbvKjam9WOLN3Ig
	eVvaCYF9TX7LXhjUZAkKuJei2Xd5b9UMpnRkulkvo9VY8/2sIDNm8HEvZ+jMhfopwcWkHuovvzK/P
	4XCToGNNoNILbK8QXZPs2aHcYMeBFxlnEaoE2SiaGtDywvvTrhJ/CejvLqHxmpJx3Up1JivT/CoXn
	P9j9VrIyy16YKBSKydKO7ENB5g6+PEYYVsSW6+GaWwBILwLD5mDt2c2gYHn15EUGpR1TkUymssW4D
	/I82uEiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNvwJ-004WB6-0R;
	Mon, 24 Jul 2023 13:49:31 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNvwD-004W7l-1m;
	Mon, 24 Jul 2023 13:49:29 +0000
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R8hN01Gbdz4f3jYX;
	Mon, 24 Jul 2023 21:49:04 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP4 (Coremail) with SMTP id gCh0CgCHK59Ngb5kXQPVOg--.36407S3;
	Mon, 24 Jul 2023 21:49:02 +0800 (CST)
Subject: Re: [PATCH 1/3] arm64: kdump: Allocate crash low memory in the
 bottom-up direction
To: kernel test robot <lkp@intel.com>, Dave Young <dyoung@redhat.com>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Zhen Lei <thunder.leizhen@huawei.com>
References: <20230721081726.882-2-thunder.leizhen@huaweicloud.com>
 <202307220500.1I73fZ5Z-lkp@intel.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <ea4b5f96-617a-96ff-094e-7f21d4ddc176@huaweicloud.com>
Date: Mon, 24 Jul 2023 21:49:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <202307220500.1I73fZ5Z-lkp@intel.com>
Content-Language: en-US
X-CM-TRANSID: gCh0CgCHK59Ngb5kXQPVOg--.36407S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWDCr48ZrWkXr17XFyfCrg_yoWrCF48pa
	1Uua1xKw18XFWrCa97t3y3uw4rWasFqFyfWrW8Jr10gF9Fkr93JasagFWfXryDGr1vgay8
	Cw1jqFZ8X34UAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_064926_461995_0992B55F 
X-CRM114-Status: GOOD (  17.91  )
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



On 2023/7/22 5:22, kernel test robot wrote:
> Hi,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on linus/master v6.5-rc2 next-20230721]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/thunder-leizhen-huaweicloud-com/arm64-kdump-Allocate-crash-low-memory-in-the-bottom-up-direction/20230721-162312
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> patch link:    https://lore.kernel.org/r/20230721081726.882-2-thunder.leizhen%40huaweicloud.com
> patch subject: [PATCH 1/3] arm64: kdump: Allocate crash low memory in the bottom-up direction
> config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20230722/202307220500.1I73fZ5Z-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230722/202307220500.1I73fZ5Z-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307220500.1I73fZ5Z-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

Oh, thanks. I got it. The CONFIG_KEXEC_CORE build control is move into reserve_crashkernel().
Function late_reserve_crashkernel() needs to do the same. I forgot to test turning off options
like CONFIG_KEXEC_CORE. I will do it tomorrow. Sorry.

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index b544ed0ab04193d..d444721011d0b2f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -122,6 +122,9 @@ static void __init late_reserve_crashkernel(void)
        unsigned long long low_base, low_size;
        unsigned long long crash_base, crash_size;

+       if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+               return;


> 
>    aarch64-linux-ld: arch/arm64/mm/init.o: in function `late_reserve_crashkernel':
>>> init.c:(.init.text+0x58): undefined reference to `crashk_res'
>    aarch64-linux-ld: arch/arm64/mm/init.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `crashk_res' which may bind externally can not be used when making a shared object; recompile with -fPIC
>    init.c:(.init.text+0x58): dangerous relocation: unsupported relocation
>>> aarch64-linux-ld: init.c:(.init.text+0x5c): undefined reference to `crashk_res'
>>> aarch64-linux-ld: init.c:(.init.text+0x88): undefined reference to `crashk_low_res'
>    aarch64-linux-ld: arch/arm64/mm/init.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `crashk_low_res' which may bind externally can not be used when making a shared object; recompile with -fPIC
>    init.c:(.init.text+0x88): dangerous relocation: unsupported relocation
>    aarch64-linux-ld: init.c:(.init.text+0x90): undefined reference to `crashk_res'
>    aarch64-linux-ld: init.c:(.init.text+0x9c): undefined reference to `crashk_low_res'
>    aarch64-linux-ld: init.c:(.init.text+0xd0): undefined reference to `crashk_res'
>    aarch64-linux-ld: init.c:(.init.text+0x13c): undefined reference to `crashk_res'
>    aarch64-linux-ld: init.c:(.init.text+0x150): undefined reference to `crashk_res'
>    aarch64-linux-ld: init.c:(.init.text+0x18c): undefined reference to `crashk_low_res'
>    aarch64-linux-ld: init.c:(.init.text+0x1b0): undefined reference to `crashk_low_res'
>    aarch64-linux-ld: init.c:(.init.text+0x204): undefined reference to `crashk_low_res'
>    aarch64-linux-ld: init.c:(.init.text+0x234): undefined reference to `crashk_low_res'
>    aarch64-linux-ld: init.c:(.init.text+0x248): undefined reference to `crashk_low_res'
>    aarch64-linux-ld: arch/arm64/mm/init.o:init.c:(.init.text+0x25c): more undefined references to `crashk_low_res' follow
> 

-- 
Regards,
  Zhen Lei


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
