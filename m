Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yt9ga-0001uC-Aj
 for kexec@lists.infradead.org; Fri, 15 May 2015 07:05:33 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: makedumpfile: Issue with aarch64 support
Date: Fri, 15 May 2015 07:00:53 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DB45FE@BPXM01GP.gisp.nec.co.jp>
References: <55555117.4080708@redhat.com>
In-Reply-To: <55555117.4080708@redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "panand@redhat.com" <panand@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>

Hello Pratyush,

>Hi Atsushi,
>
>* I am adding aarch64 support in makedumpfile. Preliminary patch is here
>[1]. I am having some issue with the dumpdisk created by makedumpfile.
>See, if you get any clue with following inputs.
>
>* I used cp option in kdump.conf to have a good elf vmcore in
>/var/crash/..../vmcore.
>
>* If I run crash over this elf vmcore, then everything goes fine.
>
>* Now I use makedumpfile [1] for dumpdisk creation
>
>  and compression just goes fine.
>  # makedumpfile -l --message-level 1 -d 31 /var/crash/..../vmcore vmcore
>  Copying data                       : [100.0 %] |
>
>  But, crash does not like the vmcore
>  # crash /lib/modules/.../build/vmlinux vmcore -d 31
>
><readmem: fffffe01ffde2000, KVADDR, "memory section", 32, (FOE),
>a2c4eb0>
><read_diskdump: addr: fffffe01ffde2000 paddr: 41fffe2000 cnt: 32>
>read_diskdump: SEEK_ERROR: paddr/pfn: 41fffe2000/41fffe max_mapnr:
>414000

According to this message, it seems that the max_mapnr in disk_dump_header
was calculated wrongly by makedumpfile. pfn:41fffe must be exist since
crash requires it, so max_mapnr must be shortened.
What is the actual maximum pfn of the original vmcore ? If the number is
correct, I have no ideas for now...


Thanks
Atsushi Kumagai

>crash: seek error: kernel virtual address: fffffe01ffde2000  type:
>"memory section"
>
>* I tried by removing -d option in makedumpfile , still same issue.
>
>* A print for vaddr in vaddr_to_paddr_arm64 does not show address
>fffffe01ffde2000 being asked for translation by makedumpfile core.
>Infact all the vaddr printed are in the range of directly mapped kernel
>VAs, so I did not consider to add support for other memory section like
>vmalloc, vmemmap etc at this point.
>
>Thanks in advance for your help.
>
>~Pratyush
>
>[1]
>https://github.com/pratyushanand/makedumpfile/commit/073bc204c3422d6cee72eed89edb47281ead1a2e
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
