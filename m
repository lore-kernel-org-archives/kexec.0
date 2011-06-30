Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QcAIa-0002Ko-Iq
	for kexec@lists.infradead.org; Thu, 30 Jun 2011 06:00:26 +0000
Subject: Re: [Crash-utility] [RFI] Support Fujitsu's sadump dump format
Message-Id: <20110630145846tachibana@mail.jp.nec.com>
Mime-Version: 1.0
From: tachibana@mxm.nes.nec.co.jp
Date: Thu, 30 Jun 2011 14:58:46 +0900
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

Hi Hatayama-san,

On 2011/06/29 12:12:18 +0900, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> From: Dave Anderson <anderson@redhat.com>
> Subject: Re: [Crash-utility] [RFI] Support Fujitsu's sadump dump format
> Date: Tue, 28 Jun 2011 08:57:42 -0400 (EDT)
> 
> > 
> > 
> > ----- Original Message -----
> >> Fujitsu has stand-alone dump mechanism based on firmware level
> >> functionality, which we call SADUMP, in short.
> >> 
> >> We've maintained utility tools internally but now we're thinking that
> >> the best is crash utility and makedumpfile supports the sadump format
> >> for the viewpoint of both portability and maintainability.
> >> 
> >> We'll be of course responsible for its maintainance in a continuous
> >> manner. The sadump dump format is very similar to diskdump format and
> >> so kdump (compressed) format, so we estimate patch set would be a
> >> relatively small size.
> >> 
> >> Could you tell me whether crash utility and makedumpfile can support
> >> the sadump format? If OK, we'll start to make patchset.

I think it's not bad to support sadump by makedumpfile. However I have 
several questions.
- Do you want to use makedumpfile to make an existing file that sadump has 
  dumped small?
- It isn't possible to support the same form as kdump-compressed format 
  now, is it?
- When the information that makedumpfile reads from a note of /proc/vmcore 
  (or a header of kdump-compressed format) is added by an extension of 
  makedumpfile, do you need to modify sadump?

Thanks
tachibana


> > 
> > Sure, yes, the crash utility can always support another dumpfile format.
> > 
> 
> Thanks. It helps a lot.
> 
> > It's unclear to me how similar SADUMP is to diskdump/compressed-kdump.
> > Does your internal version patch diskdump.c, or do you maintain your
> > own "sadump.c"?  I ask because if your patchset is at all intrusive,
> > I'd prefer it be kept in its own file, primarily for maintainability,
> > but also because SADUMP is essentially a black-box to anybody outside
> > Fujitsu.
> 
> What I meant when I used ``similar'' is both literally and
> logically. The format consists of diskdump header-like header, two
> kinds of bitmaps used for the same purpose as those in diskump format,
> and memory data. They can be handled in common with the existing data
> structure, diskdump_data, non-intrusively, so I hope they are placed
> in diskdump.c.
> 
> On the other hand, there's a code to be placed at such specific
> area. sadump is triggered depending on kdump's progress and so
> register values to be contained in vmcore varies according to the
> progress: If crash_notes has been initialized when sadump is
> triggered, sadump packs the register values in crash_notes; if not
> yet, packs registers gathered by firmware. This is sadump specific
> processing, so I think putting it in specific sadump.c file is a
> natural and reasonable choise.
> 
> Anyway, I have not made any patch set for this. I'll post a patch set
> when I complete.
> 
> Again, thanks a lot for the positive answer.
> 
> Thanks.
> HATAYAMA, Daisuke
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
