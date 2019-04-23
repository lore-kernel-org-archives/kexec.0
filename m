Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-f196.google.com ([209.85.166.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hIz0r-0003VU-S5
 for kexec@lists.infradead.org; Tue, 23 Apr 2019 17:15:24 +0000
Received: by mail-it1-f196.google.com with SMTP id y204so1438547itf.3
 for <kexec@lists.infradead.org>; Tue, 23 Apr 2019 10:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190422092804.15534-1-kasong@redhat.com>
 <965f770a-b103-72fb-eaef-cb337ebe8290@ce.jp.nec.com>
In-Reply-To: <965f770a-b103-72fb-eaef-cb337ebe8290@ce.jp.nec.com>
From: Kairui Song <kasong@redhat.com>
Date: Tue, 23 Apr 2019 10:15:09 -0700
Message-ID: <CACPcB9d-oNvp1Kag1J8X+QBdgqfU0ps1OztjOk8n=Pw2G6ONWA@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: always ensure EFI systab region is mapped
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
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>

On Mon, Apr 22, 2019 at 11:21 PM Junichi Nomura <j-nomura@ce.jp.nec.com> wrote:
>
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
>

Good question, they should have same issue with systab, I ignored this one.
Then in first kernel when doing kexec it should ensure both ACPI
tables and the EFI systab are mapped, that should cover everything and
make it work.
Is there anything else missing?

-- 
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
