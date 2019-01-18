Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkQif-0005dW-7T
 for kexec@lists.infradead.org; Fri, 18 Jan 2019 09:45:46 +0000
Received: by mail-oi1-f196.google.com with SMTP id m6so8490747oig.11
 for <kexec@lists.infradead.org>; Fri, 18 Jan 2019 01:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
 <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic>
 <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
 <20190117085316.GA17940@dhcp-128-65.nay.redhat.com>
 <CAJZ5v0hb6Lz0knzNFTZKNb863bvDx2a1EFjTjOG2NdvyyyhniQ@mail.gmail.com>
 <CACPcB9eomuBPmxCEWEutt1gxO3=nrFFuYtKeANd0+h8DsN7M3A@mail.gmail.com>
In-Reply-To: <CACPcB9eomuBPmxCEWEutt1gxO3=nrFFuYtKeANd0+h8DsN7M3A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 Jan 2019 10:45:31 +0100
Message-ID: <CAJZ5v0jzTz9MK1krWgfHXNhqNCY_ftotbCpupJHOtPMysbNPwQ@mail.gmail.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, Baoquan He <bhe@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Schmauss,
 Erik" <erik.schmauss@intel.com>, the arch/x86 maintainers <x86@kernel.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>, Len Brown <lenb@kernel.org>

On Fri, Jan 18, 2019 at 5:47 AM Kairui Song <kasong@redhat.com> wrote:
>
> On Thu, Jan 17, 2019 at 5:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Jan 17, 2019 at 9:53 AM Dave Young <dyoung@redhat.com> wrote:
> > >
> > > Add linux-acpi list
> >
> > Well, thanks, but please resend the patches with a CC to linux-acpi.
> >
>
> Hi, sure will do.
> Any thought on adding an acpi_os_get_root_pointer_late and store rsdp
> pointer as mentioned?

It is a good idea in general IMO, but all depends on how the code
changes will look like.

> Will updat the patch and post V2, and cc linux-acpi as well later.

Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
