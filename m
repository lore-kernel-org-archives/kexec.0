Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tuuny-0007RT-IK
 for kexec@lists.infradead.org; Tue, 15 Jan 2013 00:55:08 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] x86 e820: only void usable memory areas in
 memmap=exactmap case
Date: Tue, 15 Jan 2013 01:54:55 +0100
Message-ID: <1824463.EWDqkMLC4N@hammer82.arch.suse.de>
In-Reply-To: <CAE9FiQVQvj1TPokoCgx_jbp0VACC8cgtFibH4KoqOssEc6JSPw@mail.gmail.com>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
 <201301141605.43428.trenn@suse.de>
 <CAE9FiQVQvj1TPokoCgx_jbp0VACC8cgtFibH4KoqOssEc6JSPw@mail.gmail.com>
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
Cc: horms@verge.net.au, Takao Indoh <indou.takao@jp.fujitsu.com>, MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, "H. Peter Anvin" <hpa@zytor.com>, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

On Monday, January 14, 2013 11:04:36 AM Yinghai Lu wrote:
> On Mon, Jan 14, 2013 at 7:05 AM, Thomas Renninger <trenn@suse.de> wrote:
> > What is this for?:
> > @@ -871,6 +879,11 @@ static int __init parse_memmap_one(char
> > 
> >         userdef = 1;
> >         if (*p == '@') {
> >         
> >                 start_at = memparse(p+1, &p);
> > 
> > +               if (exactusablemap_parsed) {
> > +                       /* remove all range with other types */
> > +                       e820_remove_range(start_at, mem_size,
> > +                                                E820_RAM, 0);
> > +               }
> > 
> >                 e820_add_region(start_at, mem_size, E820_RAM);
> >         
> >         } else if (*p == '#') {
> >         
> >                 start_at = memparse(p+1, &p);
> 
> remove all old renges before add E820_RAM, otherwise new add E820
> ranges could be ignored.
But this is intended?
kexec must never request reserved memory to be used as ordinary E820_RAM
by the kdump kernel.
This also reverts what exactusablemap is all about:
Keep all reserved memory ranges of the original BIOS map.

Above would again wrongly remove the mmconf and other reserved regions
if kexec passes memmap=exactuseablemap,x@y

From what I can see the patch looks fine, but above part should
simply be left out.

   Thomas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
