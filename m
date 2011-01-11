Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PcifB-0006rt-S1
	for kexec@lists.infradead.org; Tue, 11 Jan 2011 18:09:46 +0000
Date: Tue, 11 Jan 2011 13:09:40 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: kexec and relocatable kernels
Message-ID: <20110111180940.GE14869@hmsreliant.think-freely.org>
References: <4D2B82E0.80204@zytor.com>
	<20110111120652.GA14869@hmsreliant.think-freely.org>
	<4D2C83B4.8030404@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D2C83B4.8030404@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, Jan 11, 2011 at 08:22:12AM -0800, H. Peter Anvin wrote:
> On 01/11/2011 04:06 AM, Neil Horman wrote:
> >>
> > Not sure I completely follow here.  Clearly kdump uses relocatable kernels, and
> > so can avoid this problem.  But what part of the reboot path affects relocation
> > such that if your not using kdump, you wind up relocating into a memory hole.
> > As I understood it (and I admittedly haven't gone back to look as I write this),
> > the relocation code lives in the header of the kernel image, so it should be the
> > same weather we're booting on panic (via kdump), or just booting a new kernel
> > (via kexec -e).  Is something getting messed up in the header data that kexec
> > doesn't inform the kernel of the presence of a memory hole in some cases?
> > 
> 
> No, the problem is that kexec doesn't check if the placement of the
> kernel will interfere with a memory hole when picking a default load
> location; it always load a replacement (as opposed to kdump) kernel at
> 0x100000.  For at least a >= 2.10 kernel, it can do better: check to see
> if the actual placement will interfere with the memory map and if so,
> place it differently.
> 
> 	-hpa

Gotcha, so this is a kexec utility issue then, rather than a kernel problem, in
that kexec fills out the bzimage header without taking memory holes into account
ok, that makes more sense.  Thanks!
Neil


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
