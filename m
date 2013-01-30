Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0ahd-0005C4-8i
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 16:40:02 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
Date: Wed, 30 Jan 2013 17:39:51 +0100
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <201301301713.43946.trenn@suse.de>
 <4dc77552-977d-4761-860e-afdec61c4317@email.android.com>
In-Reply-To: <4dc77552-977d-4761-860e-afdec61c4317@email.android.com>
MIME-Version: 1.0
Message-Id: <201301301739.52358.trenn@suse.de>
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
Cc: yinghai@kernel.org, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, x86@kernel.org, vgoyal@redhat.com

On Wednesday, January 30, 2013 05:16:22 PM H. Peter Anvin wrote:
> I am NAKing 1/3 and think you seriously need to explain your design
> choice for the rest.  "Unnecessarily complex" is not an explanation, it
> is a cop-out.

Ok, 1/3 should not go in because it changes boot param processing
which works like that for years. No problem.

For the rest I explain the advantages here:

> >This:
> > - heavily cleans up the unnecesary reserved memory passing via memmap=
> > - still provides a clean way of passing a valid e820 table through
> >   boot structures (no Linux kernel made up e820 type passing)
> > - Keeps complexity as low as possible and at one place and does not
> >   involve kexec-tools as another error source (passing a badly
> >   mangled e820 table or not being able to consider stuff the kernel
> >   can when mangeling).

If for some reason the e820 table in kdump case needs to be
touched again, I am pretty sure you do not want to look up
kexec-tools code.
Also you won't be able to fix/workaround things in kexec-tools
the way you can in the kernel.

I also do not think it's a good idea to pass an unspecified,
Linux kernel made up e820 type through the public boot interface.

So looking from the other side, passing a modified e820 table
only has disadvantages. The only advantage I can see that
memmap=..,X@Y,W@Z needs not to be passed. But this is rather
short and static now and not huge depending on the e820 reserved
entries from the BIOS (and still obvious where it comes from and why
it gets passed. Passing things hidden in a modified e820 boot structure
is not a good idea).

Again, please consider to take these (after rebasing without 1/3).
If not I guess you have to explain me the advantages of passing
a mangled e820 table which I do oversee. If they do not convince me
I suggest we still take this or someone else has to touch the
kexec-tools parts.

   Thomas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
