Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0910.google.com ([209.85.198.185])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J0ZPL-0001Ks-16
	for kexec@lists.infradead.org; Fri, 07 Dec 2007 09:22:13 +0000
Received: by rv-out-0910.google.com with SMTP id c24so622058rvf
	for <kexec@lists.infradead.org>; Fri, 07 Dec 2007 01:22:06 -0800 (PST)
Message-ID: <86802c440712070122q6e5824bcp12e1c3f560e2ab53@mail.gmail.com>
Date: Fri, 7 Dec 2007 01:22:04 -0800
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
In-Reply-To: <86802c440712070050s3c5017a4w8e747a7035d10d3a@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <20071127200011.GA3703@redhat.com>
	<20071128160206.GA21286@hmsendeavour.rdu.redhat.com>
	<20071128190525.GD3192@redhat.com> <474F7177.7050306@redhat.com>
	<20071130144250.GC23810@redhat.com>
	<20071130145131.GB5822@hmsendeavour.rdu.redhat.com>
	<20071206213951.GB28898@hmsreliant.think-freely.org>
	<20071206221143.GC2863@redhat.com>
	<m1bq93s5r8.fsf@ebiederm.dsl.xmission.com>
	<86802c440712070050s3c5017a4w8e747a7035d10d3a@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, Vivek Goyal <vgoyal@redhat.com>

On Dec 7, 2007 12:50 AM, Yinghai Lu <yhlu.kernel@gmail.com> wrote:
>
> On Dec 6, 2007 4:33 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
...
> >
> > My feel is that if it is for legacy interrupts only it should not be a problem.
> > Let's investigate and see if we can unconditionally enable this quirk
> > for all opteron systems.
>
> i checked that bit
>
> http://www.openbios.org/viewvc/trunk/LinuxBIOSv2/src/northbridge/amd/amdk8/coherent_ht.c?revision=2596&view=markup
>
> static void enable_apic_ext_id(u8 node)
> {
> #if ENABLE_APIC_EXT_ID==1
> #warning "FIXME Is the right place to enable apic ext id here?"
>
>       u32 val;
>
>         val = pci_read_config32(NODE_HT(node), 0x68);
>         val |= (HTTC_APIC_EXT_SPUR | HTTC_APIC_EXT_ID | HTTC_APIC_EXT_BRD_CST);
>         pci_write_config32(NODE_HT(node), 0x68, val);
> #endif
> }
>
> that bit only be should be set when apic id is lifted and cpu apid is
> using 8 bits and that mean broadcast is 0xff instead 0x0f.
> for example 8 socket dual core system or 4 socket quad core
> system,that you should make BSP start from 0x04, so cpus apic id will
> be [0x04, 0x13)
>
>
> So if you want to enable that in early_quirk, you need to
> make sure apic id is using 8 bits by check if the bit 16 (HTTC_APIC_ID) is set.

it should be bit 18 (HTTC_APIC_EXT_ID)


YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
