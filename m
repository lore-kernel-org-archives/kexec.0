Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QcHUC-0002XP-NX
	for kexec@lists.infradead.org; Thu, 30 Jun 2011 13:40:53 +0000
Date: Thu, 30 Jun 2011 09:40:49 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1238053244.265377.1309441249859.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20110630.173820.246507825.d.hatayama@jp.fujitsu.com>
Subject: Re: [Crash-utility] [RFI] Support Fujitsu's sadump dump format
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>
Cc: tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org



----- Original Message -----

Now I am confused...

You stated this earlier:

> What I meant when I used ``similar'' is both literally and
> logically. The format consists of diskdump header-like header, two
> kinds of bitmaps used for the same purpose as those in diskump format,
> and memory data. They can be handled in common with the existing data
> structure, diskdump_data, non-intrusively, so I hope they are placed
> in diskdump.c.

which made it sound like the sadump dumpfile format is already similar
to the compressed kdump format.

But this makes it sound like the sadump native-format is unique:

> >> The first is to translate sadump format into the one crash utility can
> >> recognize. makedumpfile is the standard tool to do it, and if
> >> makdumpfile can support sadump format, I think it is the best.
> >>
> >> > - It isn't possible to support the same form as kdump-compressed format
> >> >   now, is it?
> >>
> >> I think it's technically possible but practically impossible.  sadump is
> >> a firmware and it is maintained by firmware team.

Is this how it would work?:

 (1) kernel crashes
 (2) sadump creates a native-format dumpfile 
 (3) (patched) makedumpfile takes the native-format sadump dumpfile and
     translates into a format that is similar to a compressed kdump
 (4) (patched) crash utility reads the translated sadump dumpfile

Or will the (patched) crash utility be able to read the sadump dumpfile
in its native form if it is not pre-processed by makedumpfile?

Dave
     

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
