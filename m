Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJCbR-0000nY-9W
 for kexec@lists.infradead.org; Wed, 24 Apr 2019 07:46:03 +0000
Date: Wed, 24 Apr 2019 15:45:53 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] x86/kexec: always ensure EFI systab region is mapped
Message-ID: <20190424074553.GH3584@localhost.localdomain>
References: <20190422092804.15534-1-kasong@redhat.com>
 <965f770a-b103-72fb-eaef-cb337ebe8290@ce.jp.nec.com>
 <CACPcB9d-oNvp1Kag1J8X+QBdgqfU0ps1OztjOk8n=Pw2G6ONWA@mail.gmail.com>
 <24f1dc7c-1dea-79b0-d364-0dc7d605ce01@ce.jp.nec.com>
 <20190424054135.GG3584@localhost.localdomain>
 <20190424061831.GA9059@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190424061831.GA9059@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>, Kairui Song <kasong@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>

On 04/24/19 at 02:18pm, Dave Young wrote:
> On 04/24/19 at 01:41pm, Baoquan He wrote:
> > On 04/24/19 at 02:47am, Junichi Nomura wrote:
> > > On 4/24/19 2:15 AM, Kairui Song wrote:
> > > > On Mon, Apr 22, 2019 at 11:21 PM Junichi Nomura <j-nomura@ce.jp.nec.com> wrote:
> > > >> Is the mapping of ACPI tables just by luck, too?
> > > > 
> > > > Good question, they should have same issue with systab, I ignored this one.
> > > > Then in first kernel when doing kexec it should ensure both ACPI
> > > > tables and the EFI systab are mapped, that should cover everything and
> > > > make it work.
> > > 
> > > Right.
> > > 
> > > > Is there anything else missing?
> > > No, as far as I looked around get_rsdp_addr().
> > 
> > Have made a draft patch to build ident mapping for ACPI tables too, it's
> > based on Kairui's patch. Dave has tested on his t400s laptop, and
> > passed. Please check if this adding is OK.
> > 
> > Kairui, you can add this into your patch to make a new one and resend.
> > Or I can combine them and send for you today.
 
> 
> Since I can not reproduce the acpi table accessing fault with Kairui's patch,
> the test is just sanity testing on same hardware. But the patch looks
> good.

Yes, usually vendor will put these efi systab, ACPI tables together. See
the regions you listed on your t420 laptop in another mail:
da99f000 - dae9efff Reserved (efi systab fall in this region)
daf9f000 - daffefff ACPI tables

We build 1:1 mapping for kexec kernel down to PMD level. Means for a
region, it will align starting address down to PMD size, and align end
address up to PMD size. So the end of efi systab, 0xdae9efff, will cause
mapping built for the 2MB area, 0xdae00000-0xdaf00000. Clearly ACPI
tables are covered by that PMD entry. That's why only efi systab
mapping is built, accessing ACPI tables doesn't cause error.

But we can't assume they will be put together always, so need map ACPI
tables too.

> 
> With Kairui's fix+ this acpi fix and Junichi's patch everything works.
> Can anyone send them for example patch 1/2: kexec early mapping for
> efi/acpi,  patch 2/2: Junichi's previous patch.

Kairui is having a workshop in the US, I can make a patchset to
include these two patches.

For patch 1/2, I will combine the patch Kairui posted and my draft patch,
Kairui is the author certainly, since he debugged and found out the root
cause, and posted v1 when I was on vacation last week.

For patch 2/2, I think the version Boris organized is good. 
http://lkml.kernel.org/r/20190416095209.GG27892@zn.tnic

> 
> With these fixes I think kexec will just work.  Maybe we can go with
> these fixes and leave other issues like the loader type flag etc as 
> future issue.

Yes, agree.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
