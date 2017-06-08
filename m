Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2nam03on0079.outbound.protection.outlook.com
 ([104.47.42.79] helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dJ4gz-0003mp-UH
 for kexec@lists.infradead.org; Thu, 08 Jun 2017 21:10:14 +0000
Subject: Re: [PATCH v6 25/34] swiotlb: Add warnings for use of bounce buffers
 with SME
References: <201706081348.u0hG73ce%fengguang.wu@intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <56d5d7bf-45f9-6d66-d71a-166ecb60296c@amd.com>
Date: Thu, 8 Jun 2017 16:09:36 -0500
MIME-Version: 1.0
In-Reply-To: <201706081348.u0hG73ce%fengguang.wu@intel.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kbuild test robot <lkp@intel.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, kbuild-all@01.org, Paolo Bonzini <pbonzini@redhat.com>

On 6/8/2017 12:53 AM, kbuild test robot wrote:
> Hi Tom,
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.12-rc4 next-20170607]
> [cannot apply to tip/x86/core]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Tom-Lendacky/x86-Secure-Memory-Encryption-AMD/20170608-104147
> config: sparc-defconfig (attached as .config)
> compiler: sparc-linux-gcc (GCC) 6.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=sparc
> 
> All errors (new ones prefixed by >>):
> 
>     In file included from include/linux/dma-mapping.h:13:0,
>                      from include/linux/skbuff.h:34,
>                      from include/linux/filter.h:12,
>                      from kernel//bpf/core.c:24:
>>> include/linux/mem_encrypt.h:16:29: fatal error: asm/mem_encrypt.h: No such file or directory
>      #include <asm/mem_encrypt.h>
>                                  ^
>     compilation terminated.

Okay, I had the wrong understanding of the asm-generic directory. The
next series will fix this so it is not an issue for other arches.

Thanks,
Tom

> 
> vim +16 include/linux/mem_encrypt.h
> 
> 2d7c2ec4 Tom Lendacky 2017-06-07  10   * published by the Free Software Foundation.
> 2d7c2ec4 Tom Lendacky 2017-06-07  11   */
> 2d7c2ec4 Tom Lendacky 2017-06-07  12
> 2d7c2ec4 Tom Lendacky 2017-06-07  13  #ifndef __MEM_ENCRYPT_H__
> 2d7c2ec4 Tom Lendacky 2017-06-07  14  #define __MEM_ENCRYPT_H__
> 2d7c2ec4 Tom Lendacky 2017-06-07  15
> 2d7c2ec4 Tom Lendacky 2017-06-07 @16  #include <asm/mem_encrypt.h>
> 2d7c2ec4 Tom Lendacky 2017-06-07  17
> 2d7c2ec4 Tom Lendacky 2017-06-07  18  #endif	/* __MEM_ENCRYPT_H__ */
> 
> :::::: The code at line 16 was first introduced by commit
> :::::: 2d7c2ec4c60e83432b27bfb32042706f404d4158 x86/mm: Add Secure Memory Encryption (SME) support
> 
> :::::: TO: Tom Lendacky <thomas.lendacky@amd.com>
> :::::: CC: 0day robot <fengguang.wu@intel.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
