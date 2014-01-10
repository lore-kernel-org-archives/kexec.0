Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from v094114.home.net.pl ([79.96.170.134])
 by merlin.infradead.org with smtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W1Qnb-0005Y9-Qf
 for kexec@lists.infradead.org; Fri, 10 Jan 2014 01:22:12 +0000
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi memory hotplug,
 add parameter to disable memory hotplug for kexec
Date: Fri, 10 Jan 2014 02:35:42 +0100
Message-ID: <1954341.oEieD4sfT5@vostro.rjw.lan>
In-Reply-To: <20140109214425.GD12111@redhat.com>
References: <1389220181-14474-1-git-send-email-prarit@redhat.com>
 <CAHGf_=oaPZNE8tVsZ1C1z3mHee8MK6CkuZ0YBTcJpRrTWgVn6g@mail.gmail.com>
 <20140109214425.GD12111@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, KOSAKI Motohiro <kosaki.motohiro@gmail.com>, Dave Young <dyoung@redhat.com>, Len Brown <lenb@kernel.org>

On Thursday, January 09, 2014 04:44:25 PM Vivek Goyal wrote:
> On Thu, Jan 09, 2014 at 04:34:16PM -0500, KOSAKI Motohiro wrote:
> > On Thu, Jan 9, 2014 at 10:00 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> > > On Thu, Jan 09, 2014 at 12:00:29AM +0100, Rafael J. Wysocki wrote:
> > >
> > > [..]
> > >> > The system then panics and the kdump/kexec kernel boots.  During this boot
> > >> > ACPi is initialized and the kernel (as can be seen above)
> > >>
> > >> Which is a bug.  You're not supposed to initialize ACPI twice in a row.
> > >
> > > [CC lkml, kexec mailing list, dave young]
> > >
> > > It is a fresh instance of kernel booting and it is initializing its data
> > > structures fresh. It is *not* re-initializing ACPI in same kernel.
> > >
> > >> > This patchset resolves the problem by adding a kernel parameter,
> > >> > no_memory_hotplug, to disable ACPI memory hotplug.  It can be added by default
> > >> > as a parameter to the kexec/kdump kernel so the kernel boots correctly.
> > >>
> > >> This problem is specific to kexec/kdump, so please don't add *generic* command
> > >> line parameters to address this.
> > >>
> > >
> > > There are other command line options to solve kdump problems. In general
> > > one might want to disable memory hogplug on the fly even if it is compiled
> > > in the kernel. So it can act as a good debugging aid.
> > >
> > > Secondly, it can be specified with memmap=exactmap and mem=X paramters to
> > > make sure no memory is hot added in the system.
> > >
> > > So I can see other usages of this parameter. To me it makes sense to have
> > > a separate command line option to disable memory hotplug feature on the
> > > fly.
> > 
> > I'm ok this option. But note, even if this option is specified, SH,
> > Power and S390 still
> > be able to use memory hotplug because their firmware are totally
> > different from ACPI.
> > 
> > Maybe, adding acpi prefix provides good clarification.
> 
> Makes sense. Something like "acpi_no_memhotplug" or "acpi_disable_memhotplug"
> or something else.

acpi_no_memhotplug would make more sense.

That said if you make memmap=exactmap disable the memhotplug driver, the
existing kexec/kdump users won't need to be updated.

Thanks,
Rafael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
