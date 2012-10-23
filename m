Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TQhJT-0001sO-PJ
 for kexec@lists.infradead.org; Tue, 23 Oct 2012 16:26:45 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1350572194.3894.14.camel@rhapsody>
 <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com> <20121022204339.GG3401@redhat.com>
 <20121023020429.GA20493@verge.net.au>
 <20121023132413.GB16496@redhat.com>
Date: Tue, 23 Oct 2012 09:26:32 -0700
In-Reply-To: <20121023132413.GB16496@redhat.com> (Vivek Goyal's message of
 "Tue, 23 Oct 2012 09:24:13 -0400")
Message-ID: <87391517ev.fsf_-_@xmission.com>
MIME-Version: 1.0
Subject: Re: [RFC] Kdump with signed images.
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Khalid Aziz <khalid@gonehiking.org>, Dave Young <dyoung@redhat.com>, Matthew Garrett <mjg@redhat.com>

Vivek Goyal <vgoyal@redhat.com> writes:

> On Tue, Oct 23, 2012 at 11:04:29AM +0900, Simon Horman wrote:
>> On Mon, Oct 22, 2012 at 04:43:39PM -0400, Vivek Goyal wrote:
>> > On Fri, Oct 19, 2012 at 10:31:12AM -0400, Vivek Goyal wrote:
>> > 
>> > [..]
>> > > - What happens to purgatory code. It is unsigned piece of code which
>> > >   runs in kernel?
>> > 
>> > Thinking more about it, another not so clean proposal.
>> 
>> I have always assumed that purgatory can't be removed
>> as doing so would break backwards compatibility.
>
> Hi Simon,
>
> I think this will be a new parallel path and this new path should be taken
> only on kernel booted with secure boot enabled. (Either automatically or
> by using some kexec command line option). So nothing should be broken
> because we never supported anything on secure boot enabled system.

Rubbish.  Kexec works just fine today on a secure boot enabled system.
Ignoring the nonsense that there is no such thing as a secure boot
enabled linux system.

Whatever we implement must work on all linux systems.

If we implement an extension we also must write the code in /sbin/kexec
so that it works on older systems that do not implement that extension.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
