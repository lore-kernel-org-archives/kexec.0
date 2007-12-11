Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0910.google.com ([209.85.198.191])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J2A6J-0001i3-8W
	for kexec@lists.infradead.org; Tue, 11 Dec 2007 18:45:09 +0000
Received: by rv-out-0910.google.com with SMTP id c24so2145320rvf
	for <kexec@lists.infradead.org>; Tue, 11 Dec 2007 10:45:01 -0800 (PST)
Message-ID: <86802c440712111045j1384930ak77f06f4c7336aae7@mail.gmail.com>
Date: Tue, 11 Dec 2007 10:45:01 -0800
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
In-Reply-To: <20071211182951.GC10999@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <86802c440712070050s3c5017a4w8e747a7035d10d3a@mail.gmail.com>
	<20071207142144.GA10389@hmsendeavour.rdu.redhat.com>
	<20071207175832.GA18485@hmsreliant.think-freely.org>
	<m1k5nm2g3w.fsf@ebiederm.dsl.xmission.com>
	<20071211034349.GA3635@localhost.localdomain>
	<m1ejdt25x0.fsf@ebiederm.dsl.xmission.com>
	<20071211143910.GA10999@hmsreliant.think-freely.org>
	<m1ve75z1v3.fsf@ebiederm.dsl.xmission.com>
	<86802c440712111000l39291faaka797bc4ee22f798a@mail.gmail.com>
	<20071211182951.GC10999@hmsreliant.think-freely.org>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Dec 11, 2007 10:29 AM, Neil Horman <nhorman@tuxdriver.com> wrote:
>
> On Tue, Dec 11, 2007 at 10:00:00AM -0800, Yinghai Lu wrote:
> > On Dec 11, 2007 7:29 AM, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > >
> > > I'm actually inclined to remove the return magic and just do something
> > > like:
> > >         static fix_applied;
> > >         if (fix_applied++)
> > >                 return;
> > > In those functions that should be called only once.
> >
> > it seems we need to have two tables. one for northbridge (sweep all
> > the NB_K8) and another for SB ( like Nvidia, ati..., one touch and
> > leave)
> >
> > YH
> >
> I like Erics idea better I think.  My origional patch had two tables, and it
> seems that it made the early quirk detection logic that much more convoluted.
> This way each quirk can determine if it needs to be applied to more than one pci
> device.
>

nvidia or ati chip will come first, and then amd NB ( K8). So you need
to make sure "fix_applied return" is not going to skip your fix to
K8_NB.

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
