Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KuTeE-00047J-1l
	for kexec@lists.infradead.org; Mon, 27 Oct 2008 15:04:50 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20081022232824.GD5247@verge.net.au>
	<20081023194129.GD27959@blackpad>
	<20081023222906.GB10753@verge.net.au>
	<m1tzb2hkny.fsf@frodo.ebiederm.org> <4904676F.3020706@redhat.com>
	<m1mygre7nk.fsf@frodo.ebiederm.org> <490487C1.1010707@redhat.com>
	<m1k5bvc9ku.fsf@frodo.ebiederm.org> <490582D4.9000601@redhat.com>
Date: Mon, 27 Oct 2008 08:02:31 -0700
In-Reply-To: <490582D4.9000601@redhat.com> (Avi Kivity's message of "Mon, 27
	Oct 2008 10:59:00 +0200")
Message-ID: <m163neaxo8.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
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
To: Avi Kivity <avi@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Vivek Goyal <vgoyal@redhat.com>

Avi Kivity <avi@redhat.com> writes:

> Eric W. Biederman wrote:
>
> We've observed on some machines that keyboard controller reset didn't work, and
> that the fallback to triple-fault asserted INIT and not RESET (and that this
> INIT was blocked, hanging the machine).  Switching to acpi reset worked on some
> machines, but not all.  Either acpi reset was not implemented on the failing
> machines, or it was wired to INIT and not RESET.

Right.  INIT does not reset things like the MTRRs, I had forgotten
that distinction.

Frequently the firmware when it regains control at 0xffffffff0
asserts reset, but if we can't get there.  Ouch!


> Since we already have NMI IPIs, we could disable vmx there.  If it is done
> unconditionally and without notifiers, there is no chance of having unreviewed
> surprises sneaking in.

Sounds good to me.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
