Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-outbound-2.vmware.com ([65.115.85.73])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Klst8-0001jI-Bu
	for kexec@lists.infradead.org; Fri, 03 Oct 2008 22:12:42 +0000
Subject: Re: kexec with vmware esx 3.0.2
From: Zachary Amsden <zach@vmware.com>
In-Reply-To: <86802c440810031458s1ce79589s2448aa0869a74e21@mail.gmail.com>
References: <86802c440810031408i60e2036ax805bfd997092cd86@mail.gmail.com>
	<1223068893.7330.117.camel@bodhitayantram.eng.vmware.com>
	<86802c440810031440o59359f30ka72230b4b0ff73e@mail.gmail.com>
	<1223070521.7330.122.camel@bodhitayantram.eng.vmware.com>
	<86802c440810031458s1ce79589s2448aa0869a74e21@mail.gmail.com>
Date: Fri, 03 Oct 2008 15:08:51 -0700
Message-Id: <1223071731.7330.127.camel@bodhitayantram.eng.vmware.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Alok Kataria <akataria@vmware.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 2008-10-03 at 14:58 -0700, Yinghai Lu wrote:
> On Fri, Oct 3, 2008 at 2:48 PM, Zachary Amsden <zach@vmware.com> wrote:
> > On Fri, 2008-10-03 at 14:40 -0700, Yinghai Lu wrote:
> >> On Fri, Oct 3, 2008 at 2:21 PM, Zachary Amsden <zach@vmware.com> wrote:
> >> > On Fri, 2008-10-03 at 14:08 -0700, Yinghai Lu wrote:
> >> >> anyone tried to use linux kernel to kexec vmware esx?
> >> >
> >> > That would not be a recommended practice.  It might work.  It should not
> >> > be very useful.
> >> >
> >>
> >> esx 3.0.2 relys on correct mps table,
> >> could boot linux with update_mptable or alloc_mptable, and then load
> >> vmware with kexec.
> >
> > And end up running ESX on hardware where it is not supported and you
> > already have a buggy BIOS?
> BIOS is not buggy... vmware seems not to be smart enough to correct pic mode.
> because current linux kernel could works well with acpi=off

BIOS is missing correct MP table.  Thus buggy.  You should not be trying
to run ESX on buggy hardware.

Zach


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
