Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfRTY-00029V-7G
 for kexec@lists.infradead.org; Fri, 04 Jan 2019 15:33:38 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH 1/2 v4] kdump: add the vmcoreinfo documentation
Date: Fri, 4 Jan 2019 15:31:28 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035657CA@BPXM09GP.gisp.nec.co.jp>
References: <20181220054044.30738-1-lijiang@redhat.com>
 <20181220054044.30738-2-lijiang@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035656E1@BPXM09GP.gisp.nec.co.jp>
 <bf26e868-9dfd-5344-df56-df8ff0442df0@redhat.com>
In-Reply-To: <bf26e868-9dfd-5344-df56-df8ff0442df0@redhat.com>
Content-Language: en-US
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
To: lijiang <lijiang@redhat.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

-----Original Message-----
> >> +=======================
> >> +What is the VMCOREINFO?
> >> +=======================
> >> +
> >> +VMCOREINFO is a special ELF note section. It contains various
> >> +information from the kernel like structure size, page size, symbol
> >> +values, field offsets, etc. These data are packed into an ELF note
> >> +section and used by user-space tools like crash and makedumpfile to
> >> +analyze a kernel's memory layout.
> >> +
> >> +To dump the VMCOREINFO contents, one can do:
> >> +
> >> +# makedumpfile -g VMCOREINFO -x vmlinux
> >
> > again, this command does not dump the VMCOREINFO in ELF note section.
> > It converts the vmlinux's debug infomation into a VMCOREINFO-like data.
> > So I don't think this command is suitable to introduce here.
> >
> 
> Thank you, Kazu.
> 
> As you mentioned, makedumpfile in 'devel' branch can print VMCOREINFO in /proc/kcore,
> can i add the following command to this document?
> 
> #makedumpfile --mem-usage /proc/kcore -D

I don't know whether we can add unreleased softwares to the document.
Any comments on this?

If it's OK, crash also can dump it, so
---
To dump the VMCOREINFO contents, one can do:

  # crash vmlinux /proc/kcore
  ...
  > help -n
or
  # makedumpfile -D --mem-usage /proc/kcore
---

or remove that for now and update later?

> 
> >> +PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|
> >> +PG_hwpoision|PG_head_mask
> >> +-----------------------------------------------------
> >> +
> >> +Page attributes. These flags are used to filter free pages.
> >
> > Some of these are not used to filter *free* pages, so
> >
> > ... used to filter various unnecessary pages.
> >
> 
> Great. I will modify it in next post.
> 
> And also merge the 'PG_buddy' and 'PG_offline'  into the PG_* flag here.

Thanks, I think your "PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)" style is good.

Kazu

> 
> Many thanks.
> 
> Lianbo
> 
> >> +PAGE_BUDDY_MAPCOUNT_VALUE or ~PG_buddy
> >> +--------------------------------------
> >
> > then, this can be merged into the one above?
> >
> >> +======
> >> +x86_64
> >> +======
> > ...
> >> +PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)
> >> +----------------------------------------
> >
> > This looks not only for x86_64, and also can be merged into
> > the PG_* flags?
> >
> > Thank you for your effort!
> > Kazu
> >
> >



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
