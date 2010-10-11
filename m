Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1P5QZY-0000ne-Oa
	for kexec@lists.infradead.org; Mon, 11 Oct 2010 22:10:24 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1286570087.8769.27.camel@ank32.eng.vmware.com>
	<1286816964.1372.2.camel@ank32.eng.vmware.com>
	<m1lj64ppri.fsf@fess.ebiederm.org>
	<1286826083.1372.15.camel@ank32.eng.vmware.com>
	<20101011213901.GR12743@redhat.com>
Date: Mon, 11 Oct 2010 15:10:11 -0700
In-Reply-To: <20101011213901.GR12743@redhat.com> (Vivek Goyal's message of
	"Mon, 11 Oct 2010 17:39:01 -0400")
Message-ID: <m1hbgs5qkc.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] Bug during kexec...not all cpus are stopped
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: jeremy@xensource.com, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>, Alok Kataria <akataria@vmware.com>

Vivek Goyal <vgoyal@redhat.com> writes:

> On Mon, Oct 11, 2010 at 12:41:23PM -0700, Alok Kataria wrote:

> I don't think that kdump path uses smp_send_stop().

It doesn't.

> IIUC, on x86, we directly send NMI to other cpus.
>
> native_machine_crash_shutdown()
>   kdump_nmi_shootdown_cpus()
>         nmi_shootdown_cpus()
>            smp_send_nmi_allbutself
>                 apic->send_IPI_allbutself(NMI_VECTOR);
>
> So above description should be limited to only panic() path.

Is it actually confusing?  With respect to documenting the line
of thinking it seems reasonable.

> On a side note, I am wondering why panic() and kdump path can't share the
> shutdown routine.

Hysterical raisins.  Andi's change to smp_send_stop says that NMIs not
working on some boxes.  When someone wants to weed through all of the
insanity it would probably be good to get the panic and the kdump paths
sharing code.  For now simply separating panic and reboot should be
enough, and it lets the code evolve where it needs to.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
