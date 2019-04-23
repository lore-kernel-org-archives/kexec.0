Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hIszV-0001Rd-DB
 for kexec@lists.infradead.org; Tue, 23 Apr 2019 10:49:54 +0000
Date: Tue, 23 Apr 2019 18:49:24 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86/kexec: always ensure EFI systab region is mapped
Message-ID: <20190423104924.GA1730@dhcp-128-65.nay.redhat.com>
References: <20190422092804.15534-1-kasong@redhat.com>
 <965f770a-b103-72fb-eaef-cb337ebe8290@ce.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <965f770a-b103-72fb-eaef-cb337ebe8290@ce.jp.nec.com>
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: "x86@kernel.org" <x86@kernel.org>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>

On 04/23/19 at 06:20am, Junichi Nomura wrote:
> On 4/22/19 6:28 PM, Kairui Song wrote:
> > The reason is the systab region is not mapped by the identity mapping
> > provided by kexec. Currently kexec only create identity mapping for
> > mem regions, wihch won't cover the systab. So second kernel will be
> > accessing a not mapped memory region and cause fault.
> > But as kexec tend to pad the map region up to PUD size, the
> > systab could be included in the map by accident, so it worked on
> > some machines, but that will be broken easily and unstable.
> 
> Is the mapping of ACPI tables just by luck, too?

Hmm, guess it should be mapped by luck, here is the range on the T420: 
da99f000 - dae9efff Reserved (efi systab fall in this region)
daf9f000 - daffefff ACPI tables

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
