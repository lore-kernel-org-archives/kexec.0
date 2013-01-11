Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TtjHj-0003Ah-9Z
 for kexec@lists.infradead.org; Fri, 11 Jan 2013 18:24:56 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] x86 e820: only void usable memory areas in
 memmap=exactmap case
Date: Fri, 11 Jan 2013 19:24:41 +0100
Message-ID: <1603289.LXteBtkifD@hammer82.arch.suse.de>
In-Reply-To: <CAE9FiQWPJdER++ZrkKx7cQpF0QvwBeghNjpFqK18pMNC0w20tw@mail.gmail.com>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
 <201301111333.49238.trenn@suse.de>
 <CAE9FiQWPJdER++ZrkKx7cQpF0QvwBeghNjpFqK18pMNC0w20tw@mail.gmail.com>
MIME-Version: 1.0
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: horms@verge.net.au, Takao Indoh <indou.takao@jp.fujitsu.com>, MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

On Friday, January 11, 2013 08:16:52 AM Yinghai Lu wrote:
> On Fri, Jan 11, 2013 at 4:33 AM, Thomas Renninger <trenn@suse.de> wrote:
...
> > -               e820.nr_map = 0;
> > +               /*
> > +                * Remove all usable memory (this is for kdump), usable
> > +                * memory will be passed via memmap=X@Y parameter
> > +                */
> > +               e820_remove_range_type(E820_RAM);
> 
> We may need to keep exactmap intact.
Why?
Kexec/kdump should have been the only user?
If older/current kexec calls still add ACPI maps via memmap=X#Y,
they should already exist in the original e820 map and fall off or
get glued to one region if (wrongly) overlapping via sanitize_map.
 
> but could add another one like exact_ram_map
> or extend to have memmap=exactmap=ram or etc.

I would avoid that if anyhow possible because then you run into
kexec vs kernel version problems.

Maybe I should explicitly post (out of this thread) the patch to the
kexec list.
If nobody can come up with a strong reason, it should be ok?

   Thomas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
