Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dDLkZ-0006Fq-JU
 for kexec@lists.infradead.org; Wed, 24 May 2017 02:10:13 +0000
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local
 (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
 by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 00EBBAC00FA
 for <kexec@lists.infradead.org>; Wed, 24 May 2017 11:09:42 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH 2/2] Revert "[PATCH V2 1/4] x86_64: Calculate
 page_offset from pt_load"
Date: Wed, 24 May 2017 02:09:39 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20D21B9BC@G01JPEXMBYT03>
References: <33710E6CAA200E4583255F4FB666C4E20D205C05@G01JPEXMBYT03>
 <681cf021-74c0-25d2-a173-23ba50c38cab@redhat.com>
 <449aaa2b-0058-8b4d-227b-df97256b5674@redhat.com>
 <33710E6CAA200E4583255F4FB666C4E20D2060C9@G01JPEXMBYT03>
 <c3807eca-ff7e-73b9-1382-7a92dbed04bb@redhat.com>
In-Reply-To: <c3807eca-ff7e-73b9-1382-7a92dbed04bb@redhat.com>
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
To: 'Pratyush Anand' <panand@redhat.com>
Cc: "'ats-kumagai@wm.jp.nec.com'" <ats-kumagai@wm.jp.nec.com>, "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>, "'bhe@redhat.com'" <bhe@redhat.com>


> https://github.com/pratyushanand/makedumpfile/commit/241ecc6d96afbf7be6e02
> >> f51e882ce5e1e2eb9d0
> >
> > This patch works fine on sadump vmcores, but doesn't look good on virsh dump
> --memory-only.
> > The vmcore created by virsh dump --memory-only command is written in ELF
> format.
> > Virtual addresses assigned into it differs from the kdump one, not reflecting
> > kernel runtime virtual addresses.
> >
> > Here is a sample readelf output:
> >
> > # LANG=C readelf -l /root/vmcore-by-virsh-dump
> >
> > Elf file type is CORE (Core file)
> > Entry point 0x0
> > There are 7 program headers, starting at offset 64
> >
> > Program Headers:
> >   Type           Offset             VirtAddr           PhysAddr
> >                  FileSiz            MemSiz              Flags  Align
> >   NOTE           0x00000000000001c8 0x0000000000000000 0x0000000000000000
> >                  0x0000000000000650 0x0000000000000650         0
> >   LOAD           0x0000000000000818 0x0000000000000000 0x0000000000000000
> >                  0x00000000000a0000 0x00000000000a0000         0
> >   LOAD           0x00000000000a0818 0x0000000000000000 0x00000000000a0000
> >                  0x0000000000010000 0x0000000000010000         0
> >   LOAD           0x00000000000b0818 0x0000000000000000 0x00000000000c0000
> >                  0x0000000000020000 0x0000000000020000         0
> >   LOAD           0x00000000000d0818 0x0000000000000000 0x00000000000e0000
> >                  0x0000000000020000 0x0000000000020000         0
> >   LOAD           0x00000000000f0818 0x0000000000000000 0x0000000000100000
> >                  0x000000003ff00000 0x000000003ff00000         0
> >   LOAD           0x000000003fff0818 0x0000000000000000 0x00000000f0000000
> >                  0x0000000001000000 0x0000000001000000         0
> >
> > How about using QEMU or VMCOREINFO to distinguish QEMU ELF vmcore from
> > kdump ELF vmcore?
> 
> Thanks for investigating it.
> 
> I am not sure why all the virtual address in above PT_LOAD is 0 (which is
> invalid). However, this information can be used similar to how we use

Because virsh dump command works outside of guest system. They don't
know whether or not CR4 refers to kernel's page table. The page table
could be broken due to the cause of guest crash.

> NOT_PADDR (if virt addresses are always invalid in case of virsh dump).
> 
> So what about following updated patch:
> https://github.com/pratyushanand/makedumpfile/commit/52387707bb8a8c0c06452
> 15fcbf4eef60c7e4aaf

Failed as follows.

    # LANG=C ./makedumpfile -f --message-level 31 -c -d 31 -x /root/vmlinux /root/vmcore /root/vmcore-cd31
    sadump: does not have partition header
    sadump: read dump device as unknown format
    sadump: unknown format
    LOAD (0)
      phys_start : 0
      phys_end   : a0000
      virt_start : 0
      virt_end   : a0000
    LOAD (1)
      phys_start : a0000
      phys_end   : b0000
      virt_start : 0
      virt_end   : 10000
    LOAD (2)
      phys_start : c0000
      phys_end   : e0000
      virt_start : 0
      virt_end   : 20000
    LOAD (3)
      phys_start : e0000
      phys_end   : 100000
      virt_start : 0
      virt_end   : 20000
    LOAD (4)
      phys_start : 100000
      phys_end   : 40000000
      virt_start : 0
      virt_end   : 3ff00000
    LOAD (5)
      phys_start : f0000000
      phys_end   : f1000000
      virt_start : 0
      virt_end   : 1000000
    Linux kdump
    page_size    : 4096
    WARNING: Cannot determine page size (no vmcoreinfo).
    Using the dump kernel page size: 4096
    
    max_mapnr    : f1000
    There is enough free memory to be done in one cycle.
    
    Buffer size for the cyclic mode: 246784
    get_page_offset_x86_64: Can't get any pt_load to calculate page offset.
    
    makedumpfile Failed.

How about this?
- return immediately in case of kaslr because there's no need to refer to PT_LOAD entries,
- refer to PT_LOAD entries only if they exist, and
- finally try to get page offset according to kernel versions.

    static int
    get_page_offset_x86_64(void)
    {
            if (info->kaslr_offset) {
                    unsigned long page_offset_base;
    
                    page_offset_base = get_symbol_addr("page_offset_base");
                    page_offset_base += info->kaslr_offset;
                    if (!readmem(VADDR, page_offset_base, &info->page_offset,
                                 sizeof(info->page_offset))) {
                             ERRMSG("Can't read page_offset_base.\n");
                             return FALSE;
                    }
                    return TRUE;
            }
    
            if (get_num_pt_loads()) {
                    int i;
                    unsigned long long phys_start;
                    unsigned long long virt_start;
    
                    for (i = 0;
                         get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
                         i++) {
                            if (virt_start != NOT_KV_ADDR
                                && virt_start < __START_KERNEL_map
                                && phys_start != NOT_PADDR) {
                                    info->page_offset = virt_start - phys_start;
                                    return TRUE;
                            }
                    }
            }
    
            if (info->kernel_version < KERNEL_VERSION(2, 6, 27)) {
                    info->page_offset = __PAGE_OFFSET_ORIG;
            } else {
                    info->page_offset = __PAGE_OFFSET_2_6_27;
            }
    
            return TRUE;
    }

However, I think distinguishing vmcores by note information is easier
to maintain.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
