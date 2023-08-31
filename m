Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF57C83F2B
	for <kexec@archiver.kernel.org>; Thu, 31 Aug 2023 03:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=JXmsyRKHKyRFaPcsI4yAZ5H+nbW6SqKWVbyIC2JJSaM=; b=PeKjDXFPnhcgfG9ZRQVZ4Qm9OE
	KKQCNP8Yv89vkrdDTjTNaA4iLiRWdja/uNQpXWBhtX5yUW7K4T3iSK4d+EsrQxp69A0BI2ZQ8HD2n
	MO04NDtACXguprfyJ13IKQSTPX+QYJER8UIub8+vsK/0vB9lL1XuMjATVkxl5yeshbP0D+FqoGveo
	khsjUdl5mMb12FK2iBw1IUGxiXGqMPZG+b0HdSsBNMOmLSvHmKpISOKq5iO6T2mSyBY/c1PeqqfaT
	7vfZvZHmKRp2sq+mquZezegtfxOVfvqI3p6f3o3GMpCYvpHNYz4sjif0FrFDqi//mMwqUxwUwfMtd
	cuKXaYCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbYik-00Eac5-2e;
	Thu, 31 Aug 2023 03:51:50 +0000
Received: from [45.249.212.56] (helo=dggsgout12.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbYii-00EabI-0J;
	Thu, 31 Aug 2023 03:51:49 +0000
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RbnK958RSz4f3kjP;
	Thu, 31 Aug 2023 11:51:41 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP4 (Coremail) with SMTP id gCh0CgCXc6ZQDvBk0ZX8Bw--.8808S3;
	Thu, 31 Aug 2023 11:51:45 +0800 (CST)
Subject: Re: [PATCH v2 8/8] crash_core.c: remove unneeded functions
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com,
 thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
 samuel.holland@sifive.com, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-9-bhe@redhat.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <720d11fc-aad9-41de-54db-8ebc1a06e336@huaweicloud.com>
Date: Thu, 31 Aug 2023 11:51:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230829121610.138107-9-bhe@redhat.com>
Content-Language: en-US
X-CM-TRANSID: gCh0CgCXc6ZQDvBk0ZX8Bw--.8808S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1rKw45ZryxZFWxtr13urg_yoW8tFWrpF
	1rCa18KrW7tF1vkry7Ar9xArW8Aw45Aa42yFW2kryrXasrA3Z8Kr43u342gw4UtrWY9F1a
	ya4SqF9rC3W0v3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUrcTmDUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_205148_461899_65AEAE38 
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



On 2023/8/29 20:16, Baoquan He wrote:
> So far, nobody calls functions parse_crashkernel_high() and
> parse_crashkernel_low(), remove both of them.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/crash_core.h |  4 ----
>  kernel/crash_core.c        | 18 ------------------
>  2 files changed, 22 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 86e22e6a039f..d64006c4bd43 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -83,10 +83,6 @@ void final_note(Elf_Word *buf);
>  int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base,
>  		unsigned long long *low_size, bool *high);
> -int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
> -		unsigned long long *crash_size, unsigned long long *crash_base);
> -int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
> -		unsigned long long *crash_size, unsigned long long *crash_base);
>  
>  #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>  #ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 6bc00cc390b5..61a8ea3b23a2 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -323,24 +323,6 @@ int __init parse_crashkernel(char *cmdline,
>  	return 0;
>  }
>  
> -int __init parse_crashkernel_high(char *cmdline,
> -			     unsigned long long system_ram,
> -			     unsigned long long *crash_size,
> -			     unsigned long long *crash_base)
> -{
> -	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> -				suffix_tbl[SUFFIX_HIGH]);
> -}
> -
> -int __init parse_crashkernel_low(char *cmdline,
> -			     unsigned long long system_ram,
> -			     unsigned long long *crash_size,
> -			     unsigned long long *crash_base)
> -{
> -	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> -				suffix_tbl[SUFFIX_LOW]);
> -}
> -
>  /*
>   * Add a dummy early_param handler to mark crashkernel= as a known command line
>   * parameter and suppress incorrect warnings in init/main.c.
> 

-- 
Regards,
  Zhen Lei


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
