Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dDP5n-0005Q7-76
 for kexec@lists.infradead.org; Wed, 24 May 2017 05:44:22 +0000
Received: by mail-pf0-f173.google.com with SMTP id n23so133709901pfb.2
 for <kexec@lists.infradead.org>; Tue, 23 May 2017 22:43:58 -0700 (PDT)
Subject: Re: [PATCH 2/2] Revert "[PATCH V2 1/4] x86_64: Calculate page_offset
 from pt_load"
References: <33710E6CAA200E4583255F4FB666C4E20D205C05@G01JPEXMBYT03>
 <681cf021-74c0-25d2-a173-23ba50c38cab@redhat.com>
 <449aaa2b-0058-8b4d-227b-df97256b5674@redhat.com>
 <33710E6CAA200E4583255F4FB666C4E20D2060C9@G01JPEXMBYT03>
 <c3807eca-ff7e-73b9-1382-7a92dbed04bb@redhat.com>
 <33710E6CAA200E4583255F4FB666C4E20D21B9BC@G01JPEXMBYT03>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <7e95a840-2982-90bd-69fc-fe6f55caa0a0@redhat.com>
Date: Wed, 24 May 2017 11:13:53 +0530
MIME-Version: 1.0
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E20D21B9BC@G01JPEXMBYT03>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Cc: "'ats-kumagai@wm.jp.nec.com'" <ats-kumagai@wm.jp.nec.com>, "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>, "'bhe@redhat.com'" <bhe@redhat.com>

Hi Hatayama,


On Wednesday 24 May 2017 07:39 AM, Hatayama, Daisuke wrote:
> How about this?
> - return immediately in case of kaslr because there's no need to refer to PT_LOAD entries,
> - refer to PT_LOAD entries only if they exist, and
> - finally try to get page offset according to kernel versions.

It looks fine to me.
So if you agree then I can send next revision with your "Suggested-by" tag.

https://github.com/pratyushanand/makedumpfile/commit/16655ce1f4c2da8d4066072db2a03c84bf2553fe

>
>     static int
>     get_page_offset_x86_64(void)
>     {
>             if (info->kaslr_offset) {
>                     unsigned long page_offset_base;
>
>                     page_offset_base = get_symbol_addr("page_offset_base");
>                     page_offset_base += info->kaslr_offset;
>                     if (!readmem(VADDR, page_offset_base, &info->page_offset,
>                                  sizeof(info->page_offset))) {
>                              ERRMSG("Can't read page_offset_base.\n");
>                              return FALSE;
>                     }
>                     return TRUE;
>             }
>
>             if (get_num_pt_loads()) {
>                     int i;
>                     unsigned long long phys_start;
>                     unsigned long long virt_start;
>
>                     for (i = 0;
>                          get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
>                          i++) {
>                             if (virt_start != NOT_KV_ADDR
>                                 && virt_start < __START_KERNEL_map
>                                 && phys_start != NOT_PADDR) {
>                                     info->page_offset = virt_start - phys_start;
>                                     return TRUE;
>                             }
>                     }
>             }
>
>             if (info->kernel_version < KERNEL_VERSION(2, 6, 27)) {
>                     info->page_offset = __PAGE_OFFSET_ORIG;
>             } else {
>                     info->page_offset = __PAGE_OFFSET_2_6_27;
>             }
>
>             return TRUE;
>     }

Thanks

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
