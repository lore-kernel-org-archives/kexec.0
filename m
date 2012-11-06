Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TVswX-0007YY-Cj
 for kexec@lists.infradead.org; Tue, 06 Nov 2012 23:52:31 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1351276649.18115.217.camel@falcor>
 <20121101131003.GA14573@redhat.com>
 <20121101135356.GA15659@redhat.com> <1351780159.15708.17.camel@falcor>
 <20121101144304.GA15821@redhat.com>
 <20121101145225.GB10269@srcf.ucam.org>
 <20121102132318.GA3300@redhat.com> <87boffd727.fsf@xmission.com>
 <20121105180353.GC28720@redhat.com> <87mwyv96mn.fsf@xmission.com>
 <20121106193419.GH4548@redhat.com>
Date: Tue, 06 Nov 2012 15:51:59 -0800
In-Reply-To: <20121106193419.GH4548@redhat.com> (Vivek Goyal's message of
 "Tue, 6 Nov 2012 14:34:19 -0500")
Message-ID: <87k3tynvc0.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: Kdump with signed images
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
Cc: Roberto Sassu <roberto.sassu@polito.it>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>, Kees Cook <keescook@chromium.org>, Peter Jones <pjones@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux kernel mailing list <linux-kernel@vger.kernel.org>, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Matthew Garrett <mjg@redhat.com>, Dave Young <dyoung@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

Vivek Goyal <vgoyal@redhat.com> writes:

> On Mon, Nov 05, 2012 at 11:44:48AM -0800, Eric W. Biederman wrote:
>> Vivek Goyal <vgoyal@redhat.com> writes:
>> 
>> > On Fri, Nov 02, 2012 at 02:32:48PM -0700, Eric W. Biederman wrote:
>> >> 
>> >> It needs to be checked but /sbin/kexec should not use any functions that
>> >> trigger nss switch.  No user or password or host name lookup should be
>> >> happening.
>> >
>> > I also think that we don't call routines which trigger nss switch but
>> > be probably can't rely on that as somebody might introduce it in
>> > future. So we need more robust mechanism to prevent it than just code
>> > inspection.
>> 
>> The fact that we shouldn't use those routines is enough to let us
>> walk down a path where they are not used.  Either with a static glibc
>> linked told to use no nss modules (--enable-static-nss ?), or with
>> another more restricted libc.
>
> I installed glibc-static and built kexec-tools using gcc "-static" option.
> It built just fine and infact kdump is working with it.
>
> Size of new kexec binary is around 1.4MB.
>
> Did not get any warning w.r.t nss, so I am assuming we are not calling
> any relevant functions.
>
> I did try building my own libc using --enable-static-nss but it does not
> seem to have built static versions of libnss*. Will look more into it
> and try linking kexec with this new glibc and see if that works.
>
> Also tried playing with klibc and uclibc a bit but can't get anything
> going quickly.

Sounds good.  It has been about a year since I looked but kexec built
uclibc just fine last time I tried it.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
