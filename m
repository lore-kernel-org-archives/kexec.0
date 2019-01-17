Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-f193.google.com ([209.85.166.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk2uK-0000mK-3k
 for kexec@lists.infradead.org; Thu, 17 Jan 2019 08:20:13 +0000
Received: by mail-it1-f193.google.com with SMTP id c9so66134itj.1
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2019 00:20:11 -0800 (PST)
MIME-Version: 1.0
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
 <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic>
 <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
 <20190117074959.GB31097@localhost.localdomain>
In-Reply-To: <20190117074959.GB31097@localhost.localdomain>
From: Kairui Song <kasong@redhat.com>
Date: Thu, 17 Jan 2019 16:20:00 +0800
Message-ID: <CACPcB9eXumk33=7ukrghYLwHbKyfbiQW4ZA7BhpX3hLewrdu-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
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
To: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: rafael.j.wysocki@intel.com, Baoquan He <bhe@redhat.com>, erik.schmauss@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robert.moore@intel.com, mingo@redhat.com, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, tglx@linutronix.de, Dave Young <dyoung@redhat.com>, akpm@linux-foundation.org, Len Brown <lenb@kernel.org>

On Thu, Jan 17, 2019 at 3:51 PM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> On Thu, Jan 17, 2019 at 03:41:13PM +0800, Kairui Song wrote:
> >On Wed, Jan 16, 2019 at 5:46 PM Borislav Petkov <bp@alien8.de> wrote:
> >>
> >> On Wed, Jan 16, 2019 at 03:08:42PM +0800, Kairui Song wrote:
> >> > I didn't see a way to reuse things in that patch series, situation is
> >> > different, in that patch it needs to get RSDP in very early boot stage
> >> > so it did everything from scratch, in this patch kexec_file_load need
> >> > to get RSDP too, but everything is well setup so things are a lot
> >> > easier, just read from current boot_prams, efi and fallback to
> >> > acpi_find_root_pointer should be good.
> >>
> >> No no. Early code should find out that venerable RSDP thing once and
> >> will save it somewhere for further use. No gazillion parsings of it.
> >> Just once and share it with the rest of the code that needs it.
> >>
> >
> >How about we refill the boot_params.acpi_rsdp_addr if it is not valid
> >in early code, so it could be used as a reliable RSDP address source?
> >That should make things easier.
>
> I think it's OK.
> Try to read it, if get RSDP, use it.
> If not, search in EFI/BIOS/... and refill the RSDP to
> boot_params.acpi_rsdp_addr.
> By the way, I search kernel code, I didn't find other code fill and
> use it, only you(KEXEC) are trying to fill it.
> If I miss something, please let me know.

Yes, kexec would read RSDP again to pass it to second kernel, and only
if EFI is disabled (efi=noruntime/old_map, else second kernel will get
rsdp just fine). Not sure if any other component would use it.

>
> Thanks,
> Chao Fan

>

--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
