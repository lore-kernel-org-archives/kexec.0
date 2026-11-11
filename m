Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E488606A324
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=l7T/F+y2;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=fYLQkeuX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DVdMMVnHovVouauLZSJMD6AHtT5aNNb/DqiljF977ik=; b=l7T/F+y2n1oS9y
	XMPveBwyGZiCCAR9qG3EDdCKyXFSsbtDCEF+FdexTWDCSc1AjfT63IVyoDyYvyP85ToKv22In5gfQ
	4982VYhfBm8lnG3Z4CfbQCGVg53mmMk5g5GvkX52lUIVuWlpkaBCA52ZxhUiKQ7iGLDElQBwq+Eos
	NDJiwG3alscz6jjHhOFsVMkISyMQMWHyuIhwoFJxmjdz6q9NC/1Qqt9DORTpbhz+1sot0/ng8g7br
	aZ8ARaa2Ywty52mt9oGrxLeT5VWaKeXY/JXvNNGbFB/wQjFNdNujE8PZ891TuZ6C6En73KU9KG8dy
	xa3d7k8AkGIgxzP/UejA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRHWS-000000086pT-3O8o;
	Wed, 11 Nov 2026 23:14:32 +0000
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRHWN-000000086os-27B3
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 23:14:28 +0000
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso1319308137.3
        for <kexec@lists.infradead.org>; Wed, 11 Nov 2026 15:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794438866; x=1795043666; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DVdMMVnHovVouauLZSJMD6AHtT5aNNb/DqiljF977ik=;
        b=fYLQkeuX3B5u401FIizVe0zBImjQg06hnqAkkmKEMmLt1yK8DcL+jDBQdos+y+maNW
         T9wOr2A+BFKku78zfR5+iCDWQnvuuqwIXg0mlqPZMJpQmKu75F0QuyhUJ9IBIaTg1i3e
         CXKXcS4LktogOkL0J6Fvi4/NkJGEdxmO6bnl5vUEH1rwvoTmeyqvQ+NNuzNaWIDBCm2X
         k0VJCHQNouiKEd8k740hPXDR+Lvbeww73cjllGT5tawCRhKP7DFOyHE38Oe+fw6/+wJl
         oSNaAmz/ZSkDqW6AOyAvwj48k75GO1WAGipowOC3bDpqFzEWfVFA4WtUl7HRARJN84G4
         b6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794438866; x=1795043666;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DVdMMVnHovVouauLZSJMD6AHtT5aNNb/DqiljF977ik=;
        b=TAuubmM970Pd17ZMBmTf5oY/zvyDO5AvMV0EElGEQhweeSbyAIeedlOQFcOClSXTJ8
         xq7AcxuDBTTx9jrVsLopgriyphx9/cCi0owSkL64RZvtFVzzXt/pauQfXHE7vtSnAxGn
         uRp1ctclHUh/IiMbpFfcd65uVHs2d4J2xkMk8RLYhCn/rWM4Ad4Px5OQrc8IBXnFnYoe
         E86cpnIYmbyyuRGgYpYKK+QJz3CiqOgb7D3Q1nVyXFeWrxgGTfNE5+YhXXQsev0hRdMv
         3BCONRVNotLXxW0pnAQ1UCCmgEi73Qqee9906nOYhbwyzAi/UBX/htTVPafF4XmEcvwr
         KV8g==
X-Forwarded-Encrypted: i=1; AL+hErHsrvCncYHIkCMvSItxRTca8gXL5SlGlcqol4DhHKugW45mlu4+/h5DOxIhg92XvmxRccr77A==@lists.infradead.org
X-Gm-Message-State: APuU4Z+c4fw1PtVIU9mqgUgiuQOcVbigdOFUCRC7hcO+mUGbgnMF/jgA
	fBwadPl7dMdlu0Vwp+jAtb03WAv368dnJ9IUiO5pTIoWfZOW8CYQTwz9oTAkJfeZD74=
X-Gm-Gg: AYBFou1I6gD9HxGvb6aiQNmBzqQSPpJLBsSsPlDK7v55fyzON6H7VJcWAN4SVhlkoaL
	Tu8ZjnOypNbtw4CmKifaUTdvgnpriLtHft6xYPrzRjvNw4UJG9vr+tOAGsdz9xrrnutcouGqZAw
	OPXF4VvHjOpTbQzobW84TxZ8M+txnQ29pArdkblHWBRrG567wzPy3lDnJgHLzOCBN4oY+JupdkI
	N3cVnibSDcIXkmm8PS5HLiRw1f/b84mFcxk+Ohvn13ABKg0DVNJiYmwsmil/adcnFodgMqQBUgn
	BLEq2nxqzadStaVvxKSZsQItLNHm1FoQZKjUxO2QUlPyAtOFaCZcqlj1FlRhMUMtSffKWj56kRN
	tPzViOTylOxdNLJpuJlfKA37GNT/jkI10dtXOmeh5EFKp7HI05TLQxhxCGgng6LFZVCpuGMtw1x
	mU4OD8UrmKAFAgRWielE0hKv5tiG6hiPm7Szt7gZ3JR84uTmpdBwJ7sY8ielmFIE2PqlnnJGoJE
	4SKHFO8unn07kp36A6c7V5E/NES0BDBX5Gpf6/tu8EyO2ILyT/2xXqCrKFa7U12zmJpAsGza/zf
	tX/0P/k1G4xzinbB/ePpef+rEZKzg4mQsGHIPR8jp7+bYrpNxtilg3jHU71TfaT4XLwIpnJyeuG
	6eoz/IlXOc+2i6ExhlzRCQsJmf7PW651pg3V4QzFwTsCp
X-Received: by 2002:a05:6102:5126:b0:7d2:7377:32db with SMTP id ada2fe7eead31-7d5060a7703mr1403477137.24.1794438865829;
        Wed, 11 Nov 2026 15:14:25 -0800 (PST)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c22302403sm4344200241.10.2026.11.11.15.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 15:14:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/9] kho: Make bootmem reservations visible to fleet
 monitoring
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Chris Down <chris@chrisdown.name>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
 Alexander Graf <graf@amazon.com>, Baoquan He <baoquan.he@linux.dev>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kernel-team@meta.com
In-Reply-To: <c41c639fc5f453d60a265ba42a233f2ea5b48319.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
 <c41c639fc5f453d60a265ba42a233f2ea5b48319.1794383544.git.chris@chrisdown.name>
Date: Wed, 11 Nov 2026 18:14:22 -0500
Message-Id: <179443886218.2329176.10742245280418377061.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5034;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=9scWIMT8bcH1hJE5tzuaZbvTMzuuUTRWsydhjCoHQQ8=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq9PbPj7WdaeKNG/W4QNGLva9/0FB58zcLhfiDz
 D1uxgEKxc2JAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavT2zwAKCRC7dyhM23N6
 3lFzEACWzSLOLHD1CYufzDO7hpK/ihqAdc830DtEx9ApghbfTfc1chnrI57/Wp2D9h7buNVVH45
 vnopS5ouz/fz6MCr1CLzZSlDrGgLZR5dCamAyBUTezBztIbRa8TcuC96hhwyPFxjLEdLW+NKjkp
 /qgGjQVOh7kd1VSE0obnNl+tVRoNL6cznEf+LKlobs40aMr6EqkNL654Zl9rdx1w9jor1+dj6nU
 SVEH/8uk2nvb6CFV70dA+aWyqVVWOJ2J6KtdOpTZPFofGAdDfeAhj7vyOPmcRUjvLjs/0rjq6yL
 B1PRB/UrzDRXrEwBO3Tx1t/T2M+v1u5MME0yEVugXvjpvWPFMLdZoGZmv0M42/e9uS6gjD3/9kp
 qwKDfUjqZpnelcj92WBqr5oycg1c9RqKoc+fqMyXJUcrZI1UAvnwEPzku4mXigZPnlq1RVnH66u
 /hCOahaJCjJObbeQzwGGNF/jlZMU1LPHOn8hryQG2VdTv0LdwyGH3wAoFY7dwMotlsBN3fiiaq5
 gLTvD+Ylxp9lmXxm7K1sivMmR5vGkUcohFKJ+kmiBYDPvL5R04L8owhQQiJuZe4i012L1tGFk99
 06tbJ14sWZItiw1bysAP3Gh/qrXB6ycrzrN45vbpceX0VcALyQPyEsYouSwcnWC/IZqDo6Cakcz
 8R+Ei1KWFz4evKA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_151427_605144_E59B8B16 
X-CRM114-Status: GOOD (  29.08  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> We want to use live update at Meta to upgrade hypervisors whose VMs
> can't be migrated away first. But this poses a problem: whether we can

Awesome.

> enable KHO on a class of host depends on how much memory it leaves
> available for unmovable allocations. In an early test, a 64 GiB host
> with hugetlb_cma=6G set aside about 30 GiB of bootmem, which the running
> kernel can only use for movable allocations.
> 
> The reservation varies with the kernel, memory size, NUMA layout and
> command line. Our fleet collector needs the actual size from each host
> so we can decide where to enable KHO and catch a kernel release that
> takes those hosts over their bootmem budget.

HM, that works for cold boot not for live update :-)

> 
> Today the collector would have to sum kho/out/bootmem_len in debugfs,
> which isn't a userspace ABI. In /proc/meminfo, free bootmem contributes
> to CmaFree, but the reservation doesn't contribute to CmaTotal. The cma

Is this a different bug?

> count in /proc/zoneinfo includes bootmem after a cold boot but not after
> a KHO kexec. On an 8 GiB QEMU guest booted with
> kho_bootmem=32M,1536M,512M:
> 
>                 CmaTotal  CmaFree     zoneinfo cma (all zones)
>     cold boot   0 kB      2127872 kB  2129920 kB
>     KHO kexec   0 kB       881336 kB  0 kB
> 
> Even if bootmem becomes a CMA area, CmaTotal will still include other
> areas such as hugetlb CMA, so inferring the bootmem size is still
> error-prone.
> 
> Let's report the total bootmem reservation in bytes at
> /sys/kernel/kexec/kho_bootmem_size.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> index f59051b5d96d..80941a7d8a7c 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> +++ b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> @@ -59,3 +59,11 @@ Description:	read only
>  		to the crash (kdump) kernel. It lists the start and end physical
>  		addresses of CMA regions assigned for crashkernel use.
>  User:		kdump service
> +
> +What:		/sys/kernel/kexec/kho_bootmem_size

I have some concerns about exposing this as a stable API. What if we get 
rid of bootmem or make it resizable? We only recently renamed it from 
scratch to bootmem, and we have been exploring for way to optimize it.

I would keep this exposed under /sys/kernel/debug/kho/bootmem_size for 
now, and not worry about it being stable.

> +Date:		Nov 2026
> +Contact:	kexec@lists.infradead.org
> +Description:	read only
> +		Total size of the KHO bootmem regions in bytes. Returns 0
> +		when KHO is disabled.
> +User:		system monitoring
> diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
> index f9d2cc5999ee..c329d720bf25 100644
> --- a/Documentation/admin-guide/mm/kho.rst
> +++ b/Documentation/admin-guide/mm/kho.rst
> @@ -81,6 +81,15 @@ At scale, correlating crashes to the previous kernel version enables
>  faster root cause analysis when issues only occur in specific kernel
>  transition scenarios.
>  
> +sysfs Interfaces
> +================
> +
> +``/sys/kernel/kexec/kho_bootmem_size``
> +    Total size of the KHO bootmem regions in bytes, or 0 when KHO is
> +    disabled.
> +
> +See Documentation/ABI/testing/sysfs-kernel-kexec-kdump for the sysfs ABI.
> +
>  debugfs Interfaces
>  ==================
>  
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index ef2b188c8ed0..736d51e79fd2 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -40,6 +40,7 @@ void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t bootmem_phys,
>  		  u64 bootmem_len);
>  
>  bool kho_bootmem_overlap(phys_addr_t phys, size_t size);
> +phys_addr_t kho_bootmem_size(void);
>  
>  static inline enum migratetype kho_bootmem_migratetype(unsigned long pfn,
>  						       enum migratetype mt)
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index f4a31565c447..ed105e6351eb 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -13,6 +13,7 @@
>  #include <linux/slab.h>
>  #include <linux/fs.h>
>  #include <linux/kexec.h>
> +#include <linux/kexec_handover.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
>  #include <linux/liveupdate.h>
> @@ -1324,6 +1325,15 @@ static struct kobj_attribute crash_elfcorehdr_size_attr = __ATTR_RO(crash_elfcor
>  #endif /* CONFIG_CRASH_HOTPLUG */
>  #endif /* CONFIG_CRASH_DUMP */
>  
> +#ifdef CONFIG_KEXEC_HANDOVER
> +static ssize_t kho_bootmem_size_show(struct kobject *kobj,
> +				     struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%llu\n", (unsigned long long)kho_bootmem_size());
> +}
> +static struct kobj_attribute kho_bootmem_size_attr = __ATTR_RO(kho_bootmem_size);
> +#endif

Keeping it together with the rest of KHO code would be better.

-- 
Pasha


