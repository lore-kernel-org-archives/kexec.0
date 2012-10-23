Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TQiSA-0003It-ES
 for kexec@lists.infradead.org; Tue, 23 Oct 2012 17:39:47 +0000
Date: Tue, 23 Oct 2012 13:39:42 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC] Kdump with signed images.
Message-ID: <20121023173941.GF16496@redhat.com>
References: <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com>
 <20121022204339.GG3401@redhat.com>
 <20121023020429.GA20493@verge.net.au>
 <20121023132413.GB16496@redhat.com>
 <87391517ev.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87391517ev.fsf_-_@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Khalid Aziz <khalid@gonehiking.org>, Dave Young <dyoung@redhat.com>, Matthew Garrett <mjg@redhat.com>

On Tue, Oct 23, 2012 at 09:26:32AM -0700, Eric W. Biederman wrote:

[..]
> > I think this will be a new parallel path and this new path should be taken
> > only on kernel booted with secure boot enabled. (Either automatically or
> > by using some kexec command line option). So nothing should be broken
> > because we never supported anything on secure boot enabled system.
> 
> Rubbish.  Kexec works just fine today on a secure boot enabled system.
> Ignoring the nonsense that there is no such thing as a secure boot
> enabled linux system.

I think it is a security hole for the systems where we don't want to run
unsigned priviliged code. So yes, it works as of today, but at some point
of time we shall have to close this hole.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
