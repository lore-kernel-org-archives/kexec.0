Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ctY95-0003W2-M0
 for kexec@lists.infradead.org; Thu, 30 Mar 2017 11:21:41 +0000
Subject: Re: [RFC PATCH] x86_64/mm/boot: Fix kernel_ident_mapping_init()
 failure for kexec
References: <1489990291-2252-1-git-send-email-xlpang@redhat.com>
 <20170324120458.nw3fwpmdptjtj5qb@node.shutemov.name>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <58DCEA40.7040102@redhat.com>
Date: Thu, 30 Mar 2017 19:21:36 +0800
MIME-Version: 1.0
In-Reply-To: <20170324120458.nw3fwpmdptjtj5qb@node.shutemov.name>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>, Xunlei Pang <xlpang@redhat.com>, Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

On 03/24/2017 at 08:04 PM, Kirill A. Shutemov wrote:
> On Mon, Mar 20, 2017 at 02:11:31PM +0800, Xunlei Pang wrote:
>> I found that the kdump is broken on linux-4.11.0-rc2+
> That's actually tip tree or linux-next. The problematic change is not in
> Linus' tree.
>
>> , probably
>> due to the 5level-paging feature that "#define p4d_present(p4d) 1",
>> as a result in ident_p4d_init(), it will go into ident_pud_init()
>> directly without allocating the new pud.
>>
>> Looks like this patch can make it work again.
> Okay, that's bisectability issue. Uncovered by splitting my patchset into
> parts.
>
> Could you check if applying "Part 2" of 5-level paging changes[1] would
> help you?

I confirmed that it works after applying your following patches:
  x86: Convert the rest of the code to support p4d_t
  x86/xen: Change __xen_pgd_walk() and xen_cleanmfnmap() to support p4d
  x86/kasan: Prepare clear_pgds() to switch to <asm-generic/pgtable-nop4d.h>
  x86/mm/pat: Add 5-level paging support
  x86/efi: Add 5-level paging support
  x86/kexec: Add 5-level paging support

Regards,
Xunlei

>
> Making the code work with both <asm-generic/5level-fixup.h> and
> <asm-generic/pgtable-nop4d.h> would make it even uglier. Not sure if it
> makes sense to address it on its own if second part fixes the situation.
>
> [1] http://lkml.kernel.org/r/20170317185515.8636-1-kirill.shutemov@linux.intel.com
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
