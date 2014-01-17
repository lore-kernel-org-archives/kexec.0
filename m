Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from gate.crashing.org ([63.228.1.57])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W40II-0006T7-E6
 for kexec@lists.infradead.org; Fri, 17 Jan 2014 03:40:31 +0000
Message-ID: <1389929988.7406.18.camel@pasglop>
Subject: [Q] Why does kexec use device_shutdown rather than ubind them
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 17 Jan 2014 14:39:48 +1100
Mime-Version: 1.0
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
To: linux-kernel@vger.kernel.org
Cc: Matthew Garrett <matthew.garrett@nebula.com>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Hi Folks !

Sorry for the semi-random CC list, not sure who owns kexec nowadays. So
we are working on a new crop of power servers for which the bootloader
is going to be using kexec.

As expected, we've been chasing a number of reliability issues mostly
due to drivers not behaving properly, such as leaving devices DMA'ing or
in a state that upsets the new kernel etc...

So far our approach has been to fix the drivers one by one, adding the
shutdown() method when it's missing, etc...

But that lead me to wonder ... why shutdown() in the first place ? The
semantic of shutdown() is that we are going to power the machine off. In
some cases, that method will actively participate in the shutdown,
powering things off, spinning disk down, etc....

It doesn't have the semantic of "put the device into a clean state for a
new driver to pick up". It's also rarely implemented.

On the other hand, the remove() routine is almost everywhere, and is
already well understood as needing to leave the device in a clean state,
as it's often used for rmmod (often by the driver developer
him/herself), more likely to be tested in a condition that doesn't
involve having the machine off immediately afterward but on the contrare
in a condition where a new driver can come and try to pick the device
up.

Additionally, remove() is also what KVM does when assigning devices to
guest, ie, the original driver is unbound from the host, and VFIO is
bound in its place.

So we have common purpose with kexec (somewhat) and possibly common (and
better) testing coverage with remove() than with shutdown().

I plan to experiment a bit in our bootloader see if that makes a
difference, maybe doing a first pass of unbind for anything that can be
unbound, and shutdown for the rest.

(I'll probably also sneak it a PCIe hot reset at the end but that's more
platform specific).

Any opinion ?

Cheers,
Ben.
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
