Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WOI9h-0006QN-Sg
 for kexec@lists.infradead.org; Fri, 14 Mar 2014 02:47:31 +0000
Date: Fri, 14 Mar 2014 10:47:26 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 4/4] x86: Pass memory range via E820 for kdump
Message-ID: <20140314024726.GA2245@dhcp-16-126.nay.redhat.com>
References: <1394464149-30384-1-git-send-email-chaowang@redhat.com>
 <1394464149-30384-5-git-send-email-chaowang@redhat.com>
 <20140313222428.GW7672@oranje.fc.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140313222428.GW7672@oranje.fc.hp.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Linn Crosetto <linn@hp.com>
Cc: matt@console-pimps.org, toshi.kani@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de, WANG Chao <chaowang@redhat.com>

> [..]
> 
> I tested on a prototype system with 231 entries in the map with good results.
> Everything succeeds when using kexec to initiate a fast reboot. For crash, it
> works with and without --pass-memmap-cmdline when using noefi. I hit the
> following panic when initiating a crash leaving EFI enabled in the crash kernel:
> 
>  ? __unmap_pmd_range+0x77/0x190
>  unmap_pmd_range+0xcf/0x1c0
>  populate_pgd+0x16d/0x250
>  __cpa_process_fault+0x15/0xb0
>  __change_page_attr+0x15e/0x2a0
>  __change_page_attr_set_clr+0x59/0xc0
>  kernel_map_pages_in_pgd+0x7a/0xb0
>  __map_region+0x46/0x64
>  ? early_idt_handlers+0x117/0x120
>  efi_map_region_fixed+0xd/0xf
>  efi_enter_virtual_mode+0x4c/0x476
>  ? early_idt_handlers+0x117/0x120
>  ? early_idt_handlers+0x117/0x120
>  start_kernel+0x2e5/0x376
>  ? repair_env_string+0x5b/0x5b
>  ? memblock_reserve+0x49/0x4e
>  x86_64_start_reservations+0x2a/0x2c
>  x86_64_start_kernel+0x19f/0x1ae
> 
> However, I was able to reproduce this panic using an earlier version of
> kexec-tools, so I believe it is unrelated to this patch.

Can you test with matt's tree to see if it works?
If it still happens please post the full log.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
