Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Txgma-0008Aq-Ht
 for kexec@lists.infradead.org; Tue, 22 Jan 2013 16:33:08 +0000
Message-ID: <50FEBF35.6010502@zytor.com>
Date: Tue, 22 Jan 2013 10:32:53 -0600
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] x86 e820: Introduce memmap=resetusablemap for kdump
 usage
References: <1358868049-19884-1-git-send-email-trenn@suse.de>
 <1358868049-19884-3-git-send-email-trenn@suse.de>
 <50FEB620.3020805@zytor.com> <201301221723.03863.trenn@suse.de>
In-Reply-To: <201301221723.03863.trenn@suse.de>
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
To: Thomas Renninger <trenn@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, yinghai@kernel.org, vgoyal@redhat.com

On 01/22/2013 10:23 AM, Thomas Renninger wrote:
> This would be wrong. If kexec tries to declare usable memory via memmap=
> which is set to reserved by the BIOS, a WARN_ON() or even better BUG_ON()
> can/should be issued. This is then not possible anymore.

You can't do that anyway, because memmap= is not kexec-specific.

> Your suggestion would again make the e820 data useless. One would again 
> not know whether an area which is reserved really is meant for BIOS/HW
> communication. And for example broken mmconf platforms for which
> the check "is mmconf area is in reserved space" returns false, would now
> try to setup mmconf in kdump case. Do you want to introduce another
> e820 type: KDUMP_RESERVED which formerly was usable? This would preserve
> e820 info, but I cannot see for what this should be good for.

You just answered your own question.  Yes, we already have such "kernel
reserved" types, and we could make a "memmap reserved"

>> Even more sense would be to pass the modified memmap to kexec...
> Not sure what you mean with this. When kexec is called, you are in a 
> kernel which does not have a modified memmap. How can a modified map
> get passed to kexec?

The memory map is simply a data structure which is passed by kexec.  It
can be modified at will by the kexec tools.  This is the Right Way to do
any of this; using the command line is just a horribly fscked up hack in
the first place.

> Again: Please explain what is bad with this solution.
> I cannot see a better and more robust way for kdump other than
> reserving the original reserved memory areas as declared by the BIOS.

It is bad because it creates more complexity than is needed.

The whole point is that what we want is simply to switch type 1 to type
X, with the sole exceptions being the areas explicitly reserved for the
kdump kernel.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
