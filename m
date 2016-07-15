Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp2.provo.novell.com ([137.65.250.81])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bO50p-0008PX-Ao
 for kexec@lists.infradead.org; Fri, 15 Jul 2016 15:26:48 +0000
Date: Fri, 15 Jul 2016 17:26:14 +0200
From: Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH] kexec: Add option to fallback to old kexec syscall when
 kexec file based syscall failed
Message-ID: <20160715172614.45ff7975@hananiah.suse.cz>
In-Reply-To: <20160715151346.GA29818@redhat.com>
References: <1468485911-21427-1-git-send-email-jlee@suse.com>
 <20160714145328.GD6789@redhat.com>
 <20160714235722.GA27155@linux-rxt1.site>
 <20160715095822.5caaaa16@hananiah.suse.cz>
 <20160715125114.GA23514@redhat.com>
 <20160715164240.6a4741bc@hananiah.suse.cz>
 <20160715151346.GA29818@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: joeyli <jlee@suse.com>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>

On Fri, 15 Jul 2016 11:13:46 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Fri, Jul 15, 2016 at 04:42:40PM +0200, Petr Tesarik wrote:
> > On Fri, 15 Jul 2016 08:51:14 -0400
> > Vivek Goyal <vgoyal@redhat.com> wrote:
> > 
> > > On Fri, Jul 15, 2016 at 09:58:22AM +0200, Petr Tesarik wrote:
> > > > On Fri, 15 Jul 2016 07:57:22 +0800
> > > > joeyli <jlee@suse.com> wrote:
> > > > 
> > > > > Hi Vivek
> > > > > 
> > > > > On Thu, Jul 14, 2016 at 10:53:28AM -0400, Vivek Goyal wrote:
> > > > > > On Thu, Jul 14, 2016 at 04:45:11PM +0800, Lee, Chun-Yi wrote:
> > > > > > > This patch adds a new "--fallback-kexec" option to give a chance to
> > > > > > > fallback to old kexec syscall when file based kexec syscall operation
> > > > > > > failed.
> > > > > > 
> > > > > > I think caller should switch to using different interface if need be. But
> > > > > > I don't see much point in providing an option for this in kexec-tools.
> > > > > > 
> > > > > > Vivek
> > > > > >
> > > > > 
> > > > > OK~ Understood!
> > > > > 
> > > > > Thanks for Baoquan's and your opinion for this patch.
> > > > 
> > > > Is there some sort of diagnostics, so a calling script can determine
> > > > whether kexec failed, because there's no suppor for kexec_file_load(2)
> > > > or for a different reason? 
> > > 
> > > Will we not get -ENOSYS if kexec_file_load() is not implemented?
> > 
> > Sure, the kexec code will see a beautiful ENOSYS in errno, but it
> > merely prints this message on stderr (possibly with a different error
> > string if not linked against glibc):
> > 
> > kexec_file_load failed: Function not implemented
> > 
> > ...and exits with status 255 (same for any other error). Which is, um,
> > not very friendly to automated error handling...
> 
> So what are the options? One should return different error codes as
> returned by glibc? But bash or other script will not have a library
> to translate it. I guess scripts will have to hard code the meaning
> of a particular return code.
> 
> BTW, user can always try kexec_file_load() and if it fails, try older
> version of syscall and that should work for lot of use cases?

Yes, I can blindly retry. Thanks for considering other options.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
