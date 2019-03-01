Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gzYTS-0001Ia-Vj
 for kexec@lists.infradead.org; Fri, 01 Mar 2019 03:04:37 +0000
Received: by mail-it1-x144.google.com with SMTP id z131so18046509itf.5
 for <kexec@lists.infradead.org>; Thu, 28 Feb 2019 19:04:31 -0800 (PST)
MIME-Version: 1.0
References: <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
 <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
 <20190222084241.GC8380@suse.de> <20190222130026.GA30766@zn.tnic>
 <20190225110043.GA5884@suse.de>
 <20190225111216.GA9276@dhcp-128-65.nay.redhat.com>
 <20190225113003.GE26145@zn.tnic>
In-Reply-To: <20190225113003.GE26145@zn.tnic>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Fri, 1 Mar 2019 11:04:19 +0800
Message-ID: <CAFgQCTvP-YDUEcHTgupr+ar+qeoj5rw1y8k+6kzrzHPzTqBkaw@mail.gmail.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
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
To: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <jroedel@suse.de>, Baoquan He <bhe@redhat.com>, konrad.wilk@oracle.com, Yinghai Lu <yinghai@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, Jerry Hoemann <jerry.hoemann@hpe.com>, LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

Hi Borislav,

Do you think the following patch is good at present?
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 81f9d23..9213073 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -460,7 +460,7 @@ static void __init
memblock_x86_reserve_range_setup_data(void)
 # define CRASH_ADDR_LOW_MAX    (512 << 20)
 # define CRASH_ADDR_HIGH_MAX   (512 << 20)
 #else
-# define CRASH_ADDR_LOW_MAX    (896UL << 20)
+# define CRASH_ADDR_LOW_MAX    (1 << 32)
 # define CRASH_ADDR_HIGH_MAX   MAXMEM
 #endif

For documentation, I will send another patch to improve the description.

Thanks,
Pingfan

On Mon, Feb 25, 2019 at 7:30 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Feb 25, 2019 at 07:12:16PM +0800, Dave Young wrote:
> > If we move to high as default, it will allocate 160M high + 256M low. It
>
> We won't move to high by default - we will *fall* back to high if the
> default allocation fails.
>
> > To make the process less fragile maybe we can remove the 896M limitation
> > and only try <4G then go to high.
>
> Sure, the more robust for the user, the better.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
