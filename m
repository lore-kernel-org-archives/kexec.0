Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A67C77B73
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 10:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9XsJekjUkvE+GisAcXKZnoDx32/kKBv3C9ZeN/n3FpY=; b=S0ALlkYcxXPt0/
	A65q0wJP+6lGRuP5OdmobUE2d8/Ko0dpgWvogCkcV1GRMbAQFzkZv/DInR2qfqYPFN1zCaYgjXXAt
	CNG7fiEOcoEapGB86scBJz5cnidJDjhA7ffv2KeLTNonHduXKiXkbOPztwhgsU+cPaDws2CW7BiJQ
	BRwW4GME2qwhQMTDIancNOsNJx0EGUmZxcqgDe7/CYmgDEHXevX3ZzgBCfzSXhf4gyIky26a1kS3R
	pKcz5RqOwCs5MR9YttIPqrm+DhstXn7YfTz/p+5mwvrPUEH21PpoWy2RSoOH81QGlfkxqH2de3vsX
	dx3a1osx/Y6K5yNqIR7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prybb-0067CI-13;
	Thu, 27 Apr 2023 10:12:03 +0000
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prybX-00678l-1f
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 10:12:02 +0000
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="102761962"
X-IronPort-AV: E=Sophos;i="5.99,230,1677510000"; 
   d="scan'208";a="102761962"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 19:11:52 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4CCBDD4329
	for <kexec@lists.infradead.org>; Thu, 27 Apr 2023 19:11:50 +0900 (JST)
Received: from aks-ab1.gw.nic.fujitsu.com (aks-ab1.gw.nic.fujitsu.com [192.51.207.11])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7479AD88A3
	for <kexec@lists.infradead.org>; Thu, 27 Apr 2023 19:11:49 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
	by aks-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3B2EC2FC804A;
	Thu, 27 Apr 2023 19:11:48 +0900 (JST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: nvdimm@lists.linux.dev,
	kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	y-goto@fujitsu.com,
	yangx.jy@fujitsu.com,
	ruansy.fnst@fujitsu.com
Subject: [RFC PATCH v2 0/3] pmem memmap dump support
Date: Thu, 27 Apr 2023 18:11:40 +0800
Message-Id: <20230427101147.10477-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27590.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27590.006
X-TMASE-Result: 10--27.356600-10.000000
X-TMASE-MatchedRID: BMQxCkCavJY/erZuALh5hxxQCXaqsX3JeLLCA0PD7agXfsbcR/BbMebC
	+mIBPEBflnyhwSQkWk1BQyHqW4xlnWZ3IJrmJ3tqlTsGW3DmpUv1+9bO3CCbk8gVyTd/p+/ILXk
	gVQ0v4RMFw308tAFb1Dr61sLjnpY0o05cjFUN5oTX3j/lf1V8LIOeZuUUsCzCuBsk5njfgGzrVs
	ptJtPUH2+74QBQ4LHTdlwnBvQITCwaPxeMMHjQbvSG/+sPtZVk0bdjqKOoG3cb2DY1LGw+8KRGw
	X+NnBzgODYCThDek8ORloiW1KgftdSnuEf3mhWIHWRJEfGP5nn6xaEr/b4wE99zZd3pUn7KwWah
	HScmYz36vMFE52vcH0BArakVwkHtBXdkbv140jXl2CNM+DA49HMak2rr0Vj+PCZpicYzmkEl47Z
	7tpcJixBIrvkNJsHOruc+49GPC8Rav8PkKeeaZMYv//yaWh0DRE2jSGHIzVuXLvthk3Zj8oA3fc
	x3+CyKZRUjkVFROF7gxbc0qkj4UR/HXj0hXLdJQfSOYOlxKYvRW9GSMIeErt9RjZujPiSk4rl+F
	HG3VoDwtUelt8q+Ql/NnaI9HF5eEEBjOlnEA/zN+qWlu2ZxaKn/3nyhTdZwggSG3lCXB9d5MXRK
	uSnHcF/qt5Y2tZKiREA0r6pepUpO8fMZwaqIgnaNJ/iTxXCafS0Ip2eEHnz3IzXlXlpamPoLR4+
	zsDTtAqYBE3k9Mpw=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_031159_849417_B8B1A4B5 
X-CRM114-Status: GOOD (  11.48  )
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

Hello folks,

About 2 months ago, we posted our first RFC[3] and received your kindly feedback. Thank you :)
Now, I'm back with the code.

Currently, this RFC has already implemented to supported case D*. And the case A&B is disabled
deliberately in makedumpfile. It includes changes in 3 source code as below:
-----------+-------------------------------------------------------------------+
Source     |                      changes                                      |
-----------+-------------------------------------------------------------------+
I.         | 1. export a linked list(devm_memmap_vmcore) to vmcoreinfo         |
kernel     | 2. link metatada region to the linked list                        |
           | 3. mark the whole pmem's PT_LOAD for kexec_file_load(2) syscall   |
-----------+-------------------------------------------------------------------+
II. kexec- | 1. mark the whole pmem's PT_LOAD for kexe_load(2) syscall         |
tool       |                                                                   |
-----------+-------------------------------------------------------------------+
III.       | 1. restore the linked list from devm_memmap_vmcore in vmcoreinfo  |
makedump-  | 2. skip pmem userdata region(relies on I.3 and II.2)              |
file       | 3. exclude pmem metadata region if needed                         |
-----------+-------------------------------------------------------------------+
* Refer to the following section for the cases description.

In RFC stage, I folded these 3 projects in this same cover letter for reviewing convenience.
kernel:
  crash: export dev memmap header to vmcoreinfo
  drivers/nvdimm: export memmap of namespace to vmcoreinfo
  resource, crash: Make kexec_file_load support pmem
kexec-tools:
  kexec: Add and mark pmem region into PT_LOADs
makedumpfile:
  elf_info.c: Introduce is_pmem_pt_load_range
  makedumpfile.c: Exclude all pmem pages
  makedumpfile.c: Allow excluding metadata of pmem region
---

pmem memmap can also be called pmem metadata here.

### Background and motivate overview ###
---
Crash dump is an important feature for trouble shooting of kernel. It is the final way to chase what
happened at the kernel panic, slowdown, and so on. It is the most important tool for customer support.
However, a part of data on pmem is not included in crash dump, it may cause difficulty to analyze
trouble around pmem (especially Filesystem-DAX).

A pmem namespace in "fsdax" or "devdax" mode requires allocation of per-page metadata[1]. The allocation
can be drawn from either mem(system memory) or dev(pmem device), see `ndctl help create-namespace` for
more details. In fsdax, struct page array becomes very important, it is one of the key data to find
status of reverse map.

So, when metadata was stored in pmem, even pmem's per-page metadata will not be dumped. That means
troubleshooters are unable to check more details about pmem from the dumpfile.

### Make pmem memmap dump support ###
---
Our goal is that whether metadata is stored on mem or pmem, its metadata can be dumped and then the
crash-utilities can read more details about the pmem. Of course, this feature can be enabled/disabled.

First, based on our previous investigation, according to the location of metadata and the scope of
dump, we can divide it into the following four cases: A, B, C, D.
It should be noted that although we mentioned case A&B below, we do not want these two cases to be
part of this feature, because dumping the entire pmem will consume a lot of space, and more importantly,
it may contain user sensitive data.

+-------------+----------+------------+
|\+--------+\     metadata location   |
|            ++-----------------------+
| dump scope  |  mem     |   PMEM     |
+-------------+----------+------------+
| entire pmem |     A    |     B      |
+-------------+----------+------------+
| metadata    |     C    |     D      |
+-------------+----------+------------+

### Testing ###
Only x86_64 are tested. Please note that we have to disable the 2nd kernel's libnvdimm to ensure the
metadata in 2nd kernel will not be touched again.

below 2 commits use sha256 to check the metadata in 1st kernel during panic and makedumpfile in 2nd kernel.
https://github.com/zhijianli88/makedumpfile/commit/91a135be6980e6e87b9e00b909aaaf8ef9566ec0
https://github.com/zhijianli88/linux/commit/55bef07f8f0b2e587737b796e73b92f242947e5a

### TODO ###
Only x86 are fully supported for both kexec_load(2) and kexec_file_load(2)
kexec_file_load(2) on other architectures are TODOs.
---
[1] Pmem region layout:
   ^<--namespace0.0---->^<--namespace0.1------>^
   |                    |                      |
   +--+m----------------+--+m------------------+---------------------+-+a
   |++|e                |++|e                  |                     |+|l
   |++|t                |++|t                  |                     |+|i
   |++|a                |++|a                  |                     |+|g
   |++|d  namespace0.0  |++|d  namespace0.1    |     un-allocated    |+|n
   |++|a    fsdax       |++|a     devdax       |                     |+|m
   |++|t                |++|t                  |                     |+|e
   +--+a----------------+--+a------------------+---------------------+-+n
   |                                                                   |t
   v<-----------------------pmem region------------------------------->v

[2] https://lore.kernel.org/linux-mm/70F971CF-1A96-4D87-B70C-B971C2A1747C@roc.cs.umass.edu/T/
[3] https://lore.kernel.org/linux-mm/3c752fc2-b6a0-2975-ffec-dba3edcf4155@fujitsu.com/

### makedumpfile output in case B ####
kdump.sh[224]: makedumpfile: version 1.7.2++ (released on 20 Oct 2022)
kdump.sh[224]: command line: makedumpfile -l --message-level 31 -d 31 /proc/vmcore /sysroot/var/crash/127.0.0.1-2023-04-21-02:50:57//vmcore-incomplete
kdump.sh[224]: sadump: does not have partition header
kdump.sh[224]: sadump: read dump device as unknown format
kdump.sh[224]: sadump: unknown format
kdump.sh[224]:                phys_start         phys_end       virt_start         virt_end  is_pmem
kdump.sh[224]: LOAD[ 0]          1000000          3c26000 ffffffff81000000 ffffffff83c26000    false
kdump.sh[224]: LOAD[ 1]           100000         7f000000 ffff888000100000 ffff88807f000000    false
kdump.sh[224]: LOAD[ 2]         bf000000         bffd7000 ffff8880bf000000 ffff8880bffd7000    false
kdump.sh[224]: LOAD[ 3]        100000000        140000000 ffff888100000000 ffff888140000000    false
kdump.sh[224]: LOAD[ 4]        140000000        23e200000 ffff888140000000 ffff88823e200000     true
kdump.sh[224]: Linux kdump
kdump.sh[224]: VMCOREINFO   :
kdump.sh[224]:   OSRELEASE=6.3.0-rc3-pmem-bad+
kdump.sh[224]:   BUILD-ID=0546bd82db93706799d3eea38194ac648790aa85
kdump.sh[224]:   PAGESIZE=4096
kdump.sh[224]: page_size    : 4096
kdump.sh[224]:   SYMBOL(init_uts_ns)=ffffffff82671300
kdump.sh[224]:   OFFSET(uts_namespace.name)=0
kdump.sh[224]:   SYMBOL(node_online_map)=ffffffff826bbe08
kdump.sh[224]:   SYMBOL(swapper_pg_dir)=ffffffff82446000
kdump.sh[224]:   SYMBOL(_stext)=ffffffff81000000
kdump.sh[224]:   SYMBOL(vmap_area_list)=ffffffff82585fb0
kdump.sh[224]:   SYMBOL(devm_memmap_vmcore_head)=ffffffff825603c0
kdump.sh[224]:   SIZE(devm_memmap_vmcore)=40
kdump.sh[224]:   OFFSET(devm_memmap_vmcore.entry)=0
kdump.sh[224]:   OFFSET(devm_memmap_vmcore.start)=16
kdump.sh[224]:   OFFSET(devm_memmap_vmcore.end)=24
kdump.sh[224]:   SYMBOL(mem_section)=ffff88813fff4000
kdump.sh[224]:   LENGTH(mem_section)=2048
kdump.sh[224]:   SIZE(mem_section)=16
kdump.sh[224]:   OFFSET(mem_section.section_mem_map)=0
...
kdump.sh[224]: STEP [Checking for memory holes  ] : 0.012699 seconds
kdump.sh[224]: STEP [Excluding unnecessary pages] : 0.538059 seconds
kdump.sh[224]: STEP [Copying data               ] : 0.995418 seconds
kdump.sh[224]: STEP [Copying data               ] : 0.000067 seconds
kdump.sh[224]: Writing erase info...
kdump.sh[224]: offset_eraseinfo: 5d02266, size_eraseinfo: 0
kdump.sh[224]: Original pages  : 0x00000000001c0cfd
kdump.sh[224]:   Excluded pages   : 0x00000000001a58d2
kdump.sh[224]:     Pages filled with zero  : 0x0000000000006805
kdump.sh[224]:     Non-private cache pages : 0x0000000000019e93
kdump.sh[224]:     Private cache pages     : 0x0000000000077572
kdump.sh[224]:     User process data pages : 0x0000000000002c3b
kdump.sh[224]:     Free pages              : 0x0000000000010e8d
kdump.sh[224]:     Hwpoison pages          : 0x0000000000000000
kdump.sh[224]:     Offline pages           : 0x0000000000000000
kdump.sh[224]:     pmem metadata pages     : 0x0000000000000000
kdump.sh[224]:     pmem userdata pages     : 0x00000000000fa200
kdump.sh[224]:   Remaining pages  : 0x000000000001b42b
kdump.sh[224]:   (The number of pages is reduced to 6%.)
kdump.sh[224]: Memory Hole     : 0x000000000007d503
kdump.sh[224]: --------------------------------------------------
kdump.sh[224]: Total pages     : 0x000000000023e200
kdump.sh[224]: Write bytes     : 97522590
kdump.sh[224]: Cache hit: 191669, miss: 292, hit rate: 99.8%
kdump.sh[224]: The dumpfile is saved to /sysroot/var/crash/127.0.0.1-2023-04-21-02:50:57//vmcore-incomplete.
kdump.sh[224]: makedumpfile Completed.

-- 
2.29.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
