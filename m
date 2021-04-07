Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU7hS-004zsE-Fe
 for kexec@lists.infradead.org; Wed, 07 Apr 2021 12:54:28 +0000
Received: by mail-wr1-x433.google.com with SMTP id a6so11858421wrw.8
 for <kexec@lists.infradead.org>; Wed, 07 Apr 2021 05:54:25 -0700 (PDT)
Date: Wed, 7 Apr 2021 14:54:23 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: crashkernel reservation failed - No suitable area found on a
 cortina/gemini SoC
Message-ID: <YG2rfzRvHIZKXkf/@Red>
MIME-Version: 1.0
Content-Disposition: inline
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
To: ebiederm@xmission.com, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Hello

I try to do kexec on a cortina/gemini SoC.
On a "normal" boot, kexec fail to find memory so I added crashkernel=8M to cmdline. (kernel size is ~6M).
But now, kernel fail to reserve memory:
Load Kern image from 0x30020000 to 0x800000 size 7340032                                            
Booting Linux on physical CPU 0x0                                                                   
Linux version 5.12.0-rc5-next-20210401+ (compile@Red) (armv7a-unknown-linux-gnueabihf-gcc (Gentoo 9.3.0-r2 p4) 9.3.0, GNU ld (Gentoo 2.34 p6) 2.34.0) #98 PREEMPT Wed Apr 7 14:14:08 CEST 2021
CPU: FA526 [66015261] revision 1 (ARMv4), cr=0000397f                                               
CPU: VIVT data cache, VIVT instruction cache                                                        
OF: fdt: Machine model: Edimax NS-2502                                                              
Memory policy: Data cache writeback                                                                 
Zone ranges:                                                                                        
  Normal   [mem 0x0000000000000000-0x0000000007ffffff]                                              
  HighMem  empty                                                                                    
Movable zone start for each node                                                                    
Early memory node ranges                                                                            
  node   0: [mem 0x0000000000000000-0x0000000007ffffff]                                             
Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]                                    
crashkernel reservation failed - No suitable area found.                                            
Built 1 zonelists, mobility grouping on.  Total pages: 32512                                        
Kernel command line: console=ttyS0,19200n8 ip=dhcp crashkernel=8M                                   
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)                              
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)                                
mem auto-init: stack:off, heap alloc:off, heap free:off                                             
Memory: 119476K/131072K available (5034K kernel code, 579K rwdata, 1372K rodata, 3020K init, 210K bss, 11596K reserved, 0K cma-reserved, 0K highmem)
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1                                          

What can I do ?

Thanks
Regards

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
