Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1263D3941F
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bDy1WqzyWZ4QXi9V76+nhfaX5tyIvisESl1ex2cgViU=; b=RhrMzUyN+Bqz89zCZIG0H6neRV
	e0NZk7wey1UP5KKIR+WG86KQcCkLYYIfBc09V59fcYIR2Bc/tIARqJ9j496CfjECFedmKy+LIgqVH
	A3YwqxgAEDHAVI4SL2L22woFrLkXyBVXHrIo9tnK08U2sMHtX9QdJWBMNCtHGI1Fwr9uTVDNQVYrX
	SzLG65ahThnf+qwE7H3CMowuFps+CvUGl8HO5mEORq7VxT7cS4fz7nbmo4WBZZLbYTMbhctRTJsQI
	+oc7Pie42x2VcGoLkQL+tzHjjBa1M3uWzJnxRPDOIyfxwE96ACRLVK3fOU7GVCnJ/+TN36Wi71Izd
	lwO8FOzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HFo-000000003xN-0I7E;
	Thu, 02 Apr 2026 12:34:32 +0000
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4syw-00000000WYQ-0b24;
	Tue, 24 Mar 2026 04:03:08 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bDy1WqzyWZ4QXi9V76+nhfaX5tyIvisESl1ex2cgViU=;
	b=ZdiH1pglApVl4a6IeiYB/RNIPfMQalqh1J1N6H54h+m4wVAkBIL12akP2v0PgO4JxJv57h8AL
	Sz/Bww8R1NtzLrMTjBlHDOVrLDCImsP+6ecp+QIQd2fWrygKLGWJO1InyvsolTRvUDIfiWTeLx6
	ALNTxdX6ngOuZZaJRk7Pqc4=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4ffx7B5xTXzRhRB;
	Tue, 24 Mar 2026 11:56:54 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id A0A44404AD;
	Tue, 24 Mar 2026 12:02:59 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Mar 2026 12:02:57 +0800
Message-ID: <4cfde40c-673a-12b0-dfc5-703d582d6ea9@huawei.com>
Date: Tue, 24 Mar 2026 12:02:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9 0/5] arm64/riscv: Add support for crashkernel CMA
 reservation
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <rdunlap@infradead.org>,
	<peterz@infradead.org>, <feng.tang@linux.alibaba.com>,
	<pawan.kumar.gupta@linux.intel.com>, <dapeng1.mi@linux.intel.com>,
	<kees@kernel.org>, <elver@google.com>, <paulmck@kernel.org>,
	<lirongqing@baidu.com>, <safinaskar@gmail.com>, <rppt@kernel.org>,
	<ardb@kernel.org>, <leitao@debian.org>, <jbohac@suse.cz>,
	<cfsworks@gmail.com>, <osandov@fb.com>, <tangyouling@kylinos.cn>,
	<sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
	<eajames@linux.ibm.com>, <songshuaishuai@tinylab.org>,
	<kevin.brodsky@arm.com>, <samuel.holland@sifive.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
	<liaoyuanhong@vivo.com>, <fuqiang.wang@easystack.cn>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
References: <20260323072745.2481719-1-ruanjinjie@huawei.com>
 <20260323095548.fa4e13d6e8ae5005ae585e13@linux-foundation.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260323095548.fa4e13d6e8ae5005ae585e13@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_210306_854967_59797CDB 
X-CRM114-Status: UNSURE (   9.70  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Thu, 02 Apr 2026 05:34:23 -0700
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



On 2026/3/24 0:55, Andrew Morton wrote:
> On Mon, 23 Mar 2026 15:27:40 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
>> and crashk_cma memory are almost identical across different architectures,
>> This patch set handle them in crash core in a general way, which eliminate
>> a lot of duplication code.
>>
>> And add support for crashkernel CMA reservation for arm64 and riscv.
> 
> Thanks.  AI review has completed and it asks questions:
> 	https://sashiko.dev/#/patchset/20260323072745.2481719-1-ruanjinjie@huawei.com

I believe it identified 4 valid issues:

- The already discovered crashk_low_res not excluded bug in the existing
RISC-V code.

- An existing memory leak issue in the existing PowerPC code.

- The ordering issue of adding CMA ranges to "linux,usable-memory-range".

- An existing concurrency issue. A Concurrent memory hotplug may occur
between reading memblock and attempting to fill cmem during kexec_load()
for almost all existing architectures，I'm not sure if this is a
practical issue in reality..

 Race Condition Scenario

  Timeline:
  ---------------------------------------------------------------------
  T1: kexec_load() syscall starts
  T2: kexec_trylock() acquires kexec_lock
  T3: crash_prepare_headers() is called
  T4: arch_get_system_nr_ranges() queries memblock → finds 100 memory ranges
  T5: cmem = alloc_cmem(100) allocates buffer for 100 ranges
  T6: [RACE WINDOW] Another process triggers memory hotplug
  T7: add_memory() → lock_device_hotplug() → memblock_add_node()
  T8: New memory region added to memblock
  T9: arch_crash_populate_cmem() iterates: now finds 102 ranges
  T10: cmem->ranges[100] → OUT OF BOUNDS WRITE!
  T11: cmem->ranges[101] → OUT OF BOUNDS WRITE!
  T12: Kernel crash or memory corruption

  Why This Happens

  1. Different locks used:
    - kexec_load() uses kexec_trylock (atomic_t)
    - Memory hotplug uses device_hotplug_lock (mutex)
  2. No synchronization between these two operations
  3. Time-of-check to time-of-use (TOCTOU) issue:
    - Step T4-T5: We query the number of ranges and allocate buffer
    - Step T6-T9: Memory hotplug adds new ranges between query and
population



Any comments or suggestions on the following approach?


int crash_prepare_headers(...)
  {
      unsigned int max_nr_ranges;
      struct crash_mem *cmem;
      int ret;

      lock_device_hotplug();

      max_nr_ranges = arch_get_system_nr_ranges();
      // ...
      ret = arch_crash_populate_cmem(cmem);
      // ...

      unlock_device_hotplug();
      return ret;
  }


> 

