Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KvHNE-0003BE-BP
	for kexec@lists.infradead.org; Wed, 29 Oct 2008 20:10:36 +0000
Date: Wed, 29 Oct 2008 18:10:06 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
Message-ID: <20081029201006.GT23893@blackpad>
References: <20081022232824.GD5247@verge.net.au>
	<20081023194129.GD27959@blackpad>
	<20081023222906.GB10753@verge.net.au>
	<m1tzb2hkny.fsf@frodo.ebiederm.org> <4904676F.3020706@redhat.com>
	<m1mygre7nk.fsf@frodo.ebiederm.org>
	<490487C1.1010707@redhat.com> <20081026213927.GF23893@blackpad>
	<490581A9.80108@redhat.com> <20081027130937.GA28226@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081027130937.GA28226@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On Mon, Oct 27, 2008 at 09:09:37AM -0400, Vivek Goyal wrote:
> On Mon, Oct 27, 2008 at 10:54:01AM +0200, Avi Kivity wrote:
<snip>
> >
> > The hang was likely caused by vmx blocking INIT.  Sigh.
> 
> Avi,
> 
> We boot kdump kernel with maxcpus=1. IIUC, in that code path we will not
> be using INIT. So did you try booting kdump kernel with maxcpus=1 and did
> it work for you? If not than problem could be something else.

Just checked it here: I am passing maxcpus=1 to the kdump kernel. My
full kexec commandline is this:

/sbin/kexec --console-serial -p '--command-line=ro root=/dev/vg0/rawhide rhgb  console=ttyS0,115200 ignore_loglevel irqpoll maxcpus=1 reset_devices earlyprintk=ttyS0,115200' --initrd=/boot/initrd-2.6.28-rc2kdump.img /boot/vmlinuz-2.6.28-rc2

Additional info: I don't get the "I'm in purgatory" message on serial
console, when the system hangs. I do get the message if I trigger the
crash dump after unloading the kvm-intel module, so the serial console
is working.

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
