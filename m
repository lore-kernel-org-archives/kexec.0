Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLZj7-0006o4-5o
 for kexec@lists.infradead.org; Mon, 16 Sep 2013 14:24:34 +0000
Date: Mon, 16 Sep 2013 10:24:05 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 00/16] [RFC PATCH] Signed kexec support
Message-ID: <20130916142405.GA20753@redhat.com>
References: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
 <20130912034023.GA10877@kroah.com>
 <20130912114336.GA28500@redhat.com>
 <20130912161705.GA2650@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130912161705.GA2650@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: matthew.garrett@nebula.com, d.kasatkin@samsung.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, zohar@linux.vnet.ibm.com

On Thu, Sep 12, 2013 at 09:17:05AM -0700, Greg KH wrote:

[..]
> Your paranoia is admirable in these patches.  If they are accepted, that
> is a good first step, but what about the other kexec variants out there?

Any other kexec variant out there which are not statically compiled
will not work on secureboot enabled machines. They will continue to
work fine on machines they have been working on in the past.

[..]
> > - Currently a shared library can be written on disk (unlike executables)
> >   while it is mapped. That means after signature verification a root just
> >   has to open and write to shared library and modify code and defeat the
> >   purpose of signature verfication.
> 
> Then the existing signature verification logic is broken if this is
> possible.

I found following thread regarding being able to overwrite shared
libraries.

http://lkml.indiana.edu/hypermail/linux/kernel/0110.0/0476.html

I have not tested, but I think it is still the case that one can overwrite
mapped libraries.


[..]
> > - IMA does not lock down signed binaries in memory. That means after
> >   signature verification files can potentially be swapped out and be
> >   attacked there and modified code then can be swapped back in.
> 
> How can you do that?  If this is the case, then IMA is pointless and
> should be fixed.

Once things are swapped out to a disk, technically now root can do raw
writes to disk and modify process address space. That's a different
thing that it might be littler harder to do.

I am not sure what threat model IMA is exactly addressing. I will let
IMA developers help us understand that use case better.

[..]
> > So existing IMA does not seem to have been written for an environment
> > where all the user space is not signed we don't trust root and root can
> > attack a signed binary. And my patches try to fill that gap. 
> 
> It sounds like your changes should go into the IMA core code to resolve
> the issues there, as I'm sure they want to also protect from the issues
> you have pointed out here.  Have you talked to those developers about
> this?

I have talked to IMA developers in the past. We are meeting at LPC also
this week and have more discussions about this. But looks like IMA is
serving some other thread model (I don't understand it though).

So key question is whether this is generic enough that IMA should
be fixed to take care of all the above issues, or this is niche enough
that elf loader can be modified to take care  of it.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
