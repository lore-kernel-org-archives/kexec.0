Return-path: <kexec-bounces@lists.infradead.org>
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IcF2q-0002cn-5M
	for kexec@lists.infradead.org; Mon, 01 Oct 2007 07:46:24 +0100
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l916gvuV029015
	for <kexec@lists.infradead.org>; Mon, 1 Oct 2007 02:42:57 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l916guJe391068
	for <kexec@lists.infradead.org>; Mon, 1 Oct 2007 00:42:56 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l916guej004932
	for <kexec@lists.infradead.org>; Mon, 1 Oct 2007 00:42:56 -0600
Date: Mon, 1 Oct 2007 12:13:09 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: using bios after linux
Message-ID: <20071001064309.GC4933@in.ibm.com>
References: <5bf40e35adf3a20c89b5976850af992a@sundius.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5bf40e35adf3a20c89b5976850af992a@sundius.com>
Reply-To: vgoyal@in.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: C Michael Sundius <msundius@sundius.com>
Cc: kexec@lists.infradead.org

On Thu, Sep 27, 2007 at 06:57:30AM -0700, C Michael Sundius wrote:
> =

> Hi,
> =

>   I've been working on a project where we are using linux as an =

> operating environment for some
>   setup work prior to booting windows. our control flow looks like this
> =

>   reset =3D> (1)linux & linux aplication=A0 =3D>
>   (2)kexec =3D> (3)proprietery 16bit real code (uses bios) =3D>
>   (4)ntloader =3D> (5)Windows
> =


Interesting. Just curious to know that how above setup is useful?

>   I have come into this project in the middle, however I've seen enough =

> to understand that its not an easy
>   task to run bios calls after linux, especially int13 and power =

> management stuff. The contractor that
>   has been working on this prior to me, used Grub-for-DOS as glue code =

> to get most machines to boot correctly.
>   i.e. kexec-tools loads Grub-for-DOS (GFD) and our proprietery =

> pre-windows real mode code (I'll call that the
>   real mode "stuff" from here on); kexec starts GFD, which then starts =

> the RM "stuff" that does some thing
>   and then finally kicks off ntloader and Windows.
> =

>   It seems as though Grub-for-DOS does some magic since if we simply =

> load our RM STUFF using some simple
>   pergetory code to switch us into real mode the processor goes off into =

> the weeds when we call BIOS
>   int13; not on all machines of course, but many more than with GFD.
> =


I have never done that but Eric Biederman in the past had mentioned that
it is not reliable to call BIOS routines once linux as taken control and
we are out of real mode.

>   I'll also say that we are working off of an older version of =

> kexec-tools, say 6mo to 1year ago.
> =

>   QUESTIONS:
>   1) Is GFD the defacto way of running BIOS calls after linux (chain =

> booting DOS or windows) or has
>   the kexec team or anyone else gotten some a simpler program to go from =

> linux to realmode (and BIOS)?
>   Any pointers to previous work or helpful hints would be greatly =

> appreciated.
> =


Kexec does provide option for real mode entry. It will drop to real mode
and then new kernel will execute real mode code (including bios calls). Not
sure how reliable is that.

I had tried something similar in the past. Drop to real mode and then try
to invoke BIOS calls to rest the display. I think I had partial success.
 =

> =

>   2) It would be best if our linux application that runs before kexec =

> call kexec directly*. Thus has anyone
>   thought to provide a kexec-tools-lib and an api such that programs can =

> acess the same high level utility of
>   the kexec program just as easily as from the shell? This would be a =

> great help.=A0 Are the
>   "kexec-tools-powers-that-be" interested in that being integrated into =

> your project? (if we contributed it or
>   part of it)
> =

>   * I'll just add that we would like to pass pointers to the buffer (of =

> code that is loaded) directly to
>   the kexec user program instead of having to store them somewhere (in a =

> file) and then let the kexec
>   program retrieve them (i'm talking about our Real Mode STUFF that runs =

> before windows and after linux).
> =


So you want library just because you don't want to put real mode code in =

a file and then pass it to kexec? You want these to be dynamic options =

and pass the buffers. I would say, easier way is to put everything into
a file and then let kexec read/parse it.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
