Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W1NPF-0001fq-UO
 for kexec@lists.infradead.org; Thu, 09 Jan 2014 21:44:51 +0000
Date: Thu, 9 Jan 2014 16:44:25 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] acpi memory hotplug, add parameter to disable memory
 hotplug for kexec
Message-ID: <20140109214425.GD12111@redhat.com>
References: <1389220181-14474-1-git-send-email-prarit@redhat.com>
 <3476878.EqQiEtA2Ag@vostro.rjw.lan>
 <20140109150053.GD25897@redhat.com>
 <CAHGf_=oaPZNE8tVsZ1C1z3mHee8MK6CkuZ0YBTcJpRrTWgVn6g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHGf_=oaPZNE8tVsZ1C1z3mHee8MK6CkuZ0YBTcJpRrTWgVn6g@mail.gmail.com>
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
To: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Dave Young <dyoung@redhat.com>, Len Brown <lenb@kernel.org>

On Thu, Jan 09, 2014 at 04:34:16PM -0500, KOSAKI Motohiro wrote:
> On Thu, Jan 9, 2014 at 10:00 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> > On Thu, Jan 09, 2014 at 12:00:29AM +0100, Rafael J. Wysocki wrote:
> >
> > [..]
> >> > The system then panics and the kdump/kexec kernel boots.  During this boot
> >> > ACPi is initialized and the kernel (as can be seen above)
> >>
> >> Which is a bug.  You're not supposed to initialize ACPI twice in a row.
> >
> > [CC lkml, kexec mailing list, dave young]
> >
> > It is a fresh instance of kernel booting and it is initializing its data
> > structures fresh. It is *not* re-initializing ACPI in same kernel.
> >
> >> > This patchset resolves the problem by adding a kernel parameter,
> >> > no_memory_hotplug, to disable ACPI memory hotplug.  It can be added by default
> >> > as a parameter to the kexec/kdump kernel so the kernel boots correctly.
> >>
> >> This problem is specific to kexec/kdump, so please don't add *generic* command
> >> line parameters to address this.
> >>
> >
> > There are other command line options to solve kdump problems. In general
> > one might want to disable memory hogplug on the fly even if it is compiled
> > in the kernel. So it can act as a good debugging aid.
> >
> > Secondly, it can be specified with memmap=exactmap and mem=X paramters to
> > make sure no memory is hot added in the system.
> >
> > So I can see other usages of this parameter. To me it makes sense to have
> > a separate command line option to disable memory hotplug feature on the
> > fly.
> 
> I'm ok this option. But note, even if this option is specified, SH,
> Power and S390 still
> be able to use memory hotplug because their firmware are totally
> different from ACPI.
> 
> Maybe, adding acpi prefix provides good clarification.

Makes sense. Something like "acpi_no_memhotplug" or "acpi_disable_memhotplug"
or something else.

Thanks
Vivek


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
