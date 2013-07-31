Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.usask.ca ([128.233.192.40])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V4ZRx-0004Lf-Mg
 for kexec@lists.infradead.org; Wed, 31 Jul 2013 16:40:34 +0000
Received: from conversion-daemon.usask.ca by usask.ca
 (Sun Java(tm) System Messaging Server 7.3-11.01 64bit (built Sep  1 2009))
 id <0MQT000007HJ6I00@usask.ca> for kexec@lists.infradead.org; Wed,
 31 Jul 2013 10:40:05 -0600 (CST)
Date: Wed, 31 Jul 2013 16:40:05 +0000
From: "Friesen, Christopher" <cbf123@mail.usask.ca>
Subject: RE: visible memory seems wrong in kexec crash dump kernel
In-reply-to: <1375139436.30721.63@snotra>
Message-id: <CFBB0F4944BCD94BAC0398D7DB81D705EAF91D@CAMPUSMB5.usask.ca>
MIME-version: 1.0
Content-language: en-US
References: <51E0F41A.20904@mail.usask.ca> <1375139436.30721.63@snotra>
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
To: Scott Wood <scottwood@freescale.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>


From: Scott Wood [scottwood@freescale.com]
Sent: Monday, July 29, 2013 5:10 PM
To: Friesen, Christopher
Cc: Michael Ellerman; kexec@lists.infradead.org; Paul Mackerras; linuxppc-dev@lists.ozlabs.org; Vivek Goyal
Subject: Re: visible memory seems wrong in kexec crash dump kernel

On 07/13/2013 01:30:50 AM, Chris Friesen wrote:
> The upshot is that there seems to be a number of things that could be
> improved:
>
> 1) kexec should accept "/memory" and not just "/memory@"
> 2) lmb_reserve() should really respect the crashkernel memory limit
> 3) the freescale stuff really shouldn't assume it can map things
> wherever it feels like

What "board-specific freescale code" are you referring to?

-Scott


Sorry for the crappy quoting, I'm using a web outlook portal.

I've switched employers so I don't have access to the exact details any more.  The system in question was a Kontron AM4150 which uses the P5020.  As I recall, one of the Freescale drivers (I think it was the buffer or queue manager that the network driver makes use of) was attempting to call lmb_reserve() with a base address in the 4GB range even though the recovery kernel was limited to 224MB of memory.

While I've got your attention, the other thing that I found was that the "dpa" network driver didn't properly work in a kexec'd kernel even when given lots of memory.  It would work for a little bit and then hang.

This was all on a Wind River Linux 4.3 system, which is based on 2.6.34.  It's possible it's been fixed in more recent kernels.  The testcase to see if current kernels are still affected should be fairly simple:

1) Take a P5020 board and boot it with NFS rootfs, reserving 224MB for crashkernel.
2) Load a crashkernel into it, configured to use NFS rootfs.
3) Trigger a panic on the main kernel.
4) Ensure it loads the recovery kernel properly, that it is limited to the correct amount of memory, that it has visibility of the original kernel's memory,  that it has network connectivity and is stable when copying a few gigs of data over the network.

Chris

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
