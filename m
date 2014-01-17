Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W41Qm-00079C-L5
 for kexec@lists.infradead.org; Fri, 17 Jan 2014 04:53:21 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1389929988.7406.18.camel@pasglop>
Date: Thu, 16 Jan 2014 20:52:46 -0800
In-Reply-To: <1389929988.7406.18.camel@pasglop> (Benjamin Herrenschmidt's
 message of "Fri, 17 Jan 2014 14:39:48 +1100")
Message-ID: <871u07fbvl.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [Q] Why does kexec use device_shutdown rather than ubind them
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Hi Folks !
>
> Sorry for the semi-random CC list, not sure who owns kexec nowadays. So
> we are working on a new crop of power servers for which the bootloader
> is going to be using kexec.
>
> As expected, we've been chasing a number of reliability issues mostly
> due to drivers not behaving properly, such as leaving devices DMA'ing or
> in a state that upsets the new kernel etc...
>
> So far our approach has been to fix the drivers one by one, adding the
> shutdown() method when it's missing, etc...
>
> But that lead me to wonder ... why shutdown() in the first place ? The
> semantic of shutdown() is that we are going to power the machine off. In
> some cases, that method will actively participate in the shutdown,
> powering things off, spinning disk down, etc....
>
> It doesn't have the semantic of "put the device into a clean state for a
> new driver to pick up". It's also rarely implemented.
>
> On the other hand, the remove() routine is almost everywhere, and is
> already well understood as needing to leave the device in a clean state,
> as it's often used for rmmod (often by the driver developer
> him/herself), more likely to be tested in a condition that doesn't
> involve having the machine off immediately afterward but on the contrare
> in a condition where a new driver can come and try to pick the device
> up.
>
> Additionally, remove() is also what KVM does when assigning devices to
> guest, ie, the original driver is unbound from the host, and VFIO is
> bound in its place.
>
> So we have common purpose with kexec (somewhat) and possibly common (and
> better) testing coverage with remove() than with shutdown().
>
> I plan to experiment a bit in our bootloader see if that makes a
> difference, maybe doing a first pass of unbind for anything that can be
> unbound, and shutdown for the rest.
>
> (I'll probably also sneak it a PCIe hot reset at the end but that's more
> platform specific).
>
> Any opinion ?

When I was young and kexec was a new idea and the device model was just
getting methods.  An argument was made that using remove in the reboot
path was a bad idea because it does more than is necessary so we needed
shutdown.

I wanted to use remove at the time.

There is a lot of silliness now, but my inclination is to remove
shutdown entirely and replace it with remove.  I certainly would not
have heart burn with doing so just for kexec but getting the whole
reboot path at this point would make me very happy and then we could
kill a little used rarely implemented method from the kernel.

Given that we have found emperically that flipping the bus master enable
bit to off helps enormously for stability, but doing so generically
occassionally has unfortunate consequences why not.

I think we have largely survied until now because kdump is so popular
and kdump winds up having to reinitialize devices from any random state.

But like I said I am all for reducing the burden on device driver developers.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
