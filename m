Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KvIEj-0001Ec-Fz
	for kexec@lists.infradead.org; Wed, 29 Oct 2008 21:05:53 +0000
Date: Wed, 29 Oct 2008 17:05:50 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
Message-ID: <20081029210550.GA13316@redhat.com>
References: <20081023194129.GD27959@blackpad>
	<20081023222906.GB10753@verge.net.au>
	<m1tzb2hkny.fsf@frodo.ebiederm.org> <4904676F.3020706@redhat.com>
	<m1mygre7nk.fsf@frodo.ebiederm.org>
	<490487C1.1010707@redhat.com> <20081026213927.GF23893@blackpad>
	<490581A9.80108@redhat.com> <20081027130937.GA28226@redhat.com>
	<20081029201006.GT23893@blackpad>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081029201006.GT23893@blackpad>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On Wed, Oct 29, 2008 at 06:10:06PM -0200, Eduardo Habkost wrote:
> On Mon, Oct 27, 2008 at 09:09:37AM -0400, Vivek Goyal wrote:
> > On Mon, Oct 27, 2008 at 10:54:01AM +0200, Avi Kivity wrote:
> <snip>
> > >
> > > The hang was likely caused by vmx blocking INIT.  Sigh.
> > 
> > Avi,
> > 
> > We boot kdump kernel with maxcpus=1. IIUC, in that code path we will not
> > be using INIT. So did you try booting kdump kernel with maxcpus=1 and did
> > it work for you? If not than problem could be something else.
> 
> Just checked it here: I am passing maxcpus=1 to the kdump kernel. My
> full kexec commandline is this:
> 
> /sbin/kexec --console-serial -p '--command-line=ro root=/dev/vg0/rawhide rhgb  console=ttyS0,115200 ignore_loglevel irqpoll maxcpus=1 reset_devices earlyprintk=ttyS0,115200' --initrd=/boot/initrd-2.6.28-rc2kdump.img /boot/vmlinuz-2.6.28-rc2
> 
> Additional info: I don't get the "I'm in purgatory" message on serial
> console, when the system hangs. I do get the message if I trigger the
> crash dump after unloading the kvm-intel module, so the serial console
> is working.
> 

That means we are not even beginning to boot second kernel and are getting
lost somewhere in the first kernel itself (most likely relocate_kernel_32/64.S).

And it could be because of any of the interesting restrictions put when
vmx is enabled (As Avi mentioned in another mail.).

To debug that code, I used to put some "outb" messages to output a
character to serial console and find out which instructions is creating
trouble. You can debug to find out exactly what operation is not allowed
when vmx is enabled or simply write the patches to disable vmx and it
should automatically lead to problem resolution.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
