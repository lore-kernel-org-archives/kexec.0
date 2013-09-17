Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ocelot.phlegethon.org ([81.29.64.94] helo=mail.phlegethon.org)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLqTY-0006ls-Ly
 for kexec@lists.infradead.org; Tue, 17 Sep 2013 08:17:37 +0000
Date: Tue, 17 Sep 2013 09:17:04 +0100
From: Tim Deegan <tim@xen.org>
Subject: Re: [Xen-devel] [PATCH 1/5] purgatory: put variables altered by kexec
 in .data not .bss
Message-ID: <20130917081704.GA25707@ocelot.phlegethon.org>
References: <1379016042-22510-1-git-send-email-david.vrabel@citrix.com>
 <1379016042-22510-2-git-send-email-david.vrabel@citrix.com>
 <20130916124302.GC14630@debian70-amd64.local.net-space.pl>
 <5236FE07.2010405@citrix.com>
 <20130917013309.GA301@debian70-amd64.local.net-space.pl>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130917013309.GA301@debian70-amd64.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xen.org

At 03:33 +0200 on 17 Sep (1379388789), Daniel Kiper wrote:
> On Mon, Sep 16, 2013 at 01:48:07PM +0100, David Vrabel wrote:
> > On 16/09/13 13:43, Daniel Kiper wrote:
> > > On Thu, Sep 12, 2013 at 09:00:38PM +0100, David Vrabel wrote:
> > >> From: David Vrabel <david.vrabel@citrix.com>
> > >>
> > >> elf_rel_set_symbol() fails if the symbol is in the .bss section.
> > >>
> > >> Signed-off-by: David Vrabel <david.vrabel@citrix.com>
> > >> ---
> > >>  purgatory/arch/i386/console-x86.c        |    6 +++---
> > >>  purgatory/arch/i386/crashdump_backup.c   |    8 +++++---
> > >>  purgatory/arch/x86_64/purgatory-x86_64.c |    6 +++---
> > >>  purgatory/include/purgatory.h            |    4 ++++
> > >>  purgatory/purgatory.c                    |    4 ++--
> > >>  5 files changed, 17 insertions(+), 11 deletions(-)
> > >>
> > >> diff --git a/purgatory/arch/i386/console-x86.c b/purgatory/arch/i386/console-x86.c
> > >> index 9773573..40a734b 100644
> > >> --- a/purgatory/arch/i386/console-x86.c
> > >> +++ b/purgatory/arch/i386/console-x86.c
> > >> @@ -55,9 +55,9 @@ static void putchar_vga(int ch)
> > >>   */
> > >>
> > >>  /* Base Address */
> > >> -uint8_t console_serial = 0;
> > >> -uint16_t serial_base = 0x3f8; /* TTYS0 */
> > >> -uint32_t serial_baud = 0;
> > >> +uint8_t console_serial __data = 0;
> > >> +uint16_t serial_base __data = 0x3f8; /* TTYS0 */
> > >> +uint32_t serial_baud __data = 0;
> > >
> > > Hmmm... I do not know why we need this patch. I can build kexec-tools
> > > in my env without it. I suppose that most of people can too.
> > > Could you check what is wrong with your build system?
> >
> > Regardless of whether it works with some tools, it doesn't make a whole
> > lot of sense to try and set the value of symbols in the .bss section.
> > .bss is only for symbols with a value of zero.
> 
> To be precise .bss is only for uninitialized symbols. Anyway, probably
> your compiler is screwed. In my case it sees that a given symbol is
> initialized and places it in .data section itself.

David, are you using a compiler that doesn't support
-fno-zero-initialized-in-bss?  If that's a supported optoin, then the
__data markers are indeed necessary.

Tim.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
