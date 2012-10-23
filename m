Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TQeSu-00057H-Lv
 for kexec@lists.infradead.org; Tue, 23 Oct 2012 13:24:17 +0000
Date: Tue, 23 Oct 2012 09:24:13 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC] Kdump with UEFI secure boot (Re: [PATCH v2] kdump: pass
 acpi_rsdp= to 2nd kernel for efi booting)
Message-ID: <20121023132413.GB16496@redhat.com>
References: <1350572194.3894.14.camel@rhapsody>
 <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com>
 <20121022204339.GG3401@redhat.com>
 <20121023020429.GA20493@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20121023020429.GA20493@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Khalid Aziz <khalid@gonehiking.org>, Dave Young <dyoung@redhat.com>, Matthew Garrett <mjg@redhat.com>

On Tue, Oct 23, 2012 at 11:04:29AM +0900, Simon Horman wrote:
> On Mon, Oct 22, 2012 at 04:43:39PM -0400, Vivek Goyal wrote:
> > On Fri, Oct 19, 2012 at 10:31:12AM -0400, Vivek Goyal wrote:
> > 
> > [..]
> > > - What happens to purgatory code. It is unsigned piece of code which
> > >   runs in kernel?
> > 
> > Thinking more about it, another not so clean proposal.
> 
> I have always assumed that purgatory can't be removed
> as doing so would break backwards compatibility.

Hi Simon,

I think this will be a new parallel path and this new path should be taken
only on kernel booted with secure boot enabled. (Either automatically or
by using some kexec command line option). So nothing should be broken
because we never supported anything on secure boot enabled system.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
