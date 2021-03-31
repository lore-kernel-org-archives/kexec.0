Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRbU7-006k4m-A4
 for kexec@lists.infradead.org; Wed, 31 Mar 2021 14:06:17 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <YGQujxhxgOvtwb7n@kroah.com> (Greg KH's message of "Wed, 31 Mar
 2021 10:10:55 +0200")
References: <CAK5_k=Lao5dYtAWrBMXViM0iEdT0QOj-fPiEsuvkfTogfF=6dA@mail.gmail.com>
 <20210331024745.GB29970@MiWiFi-R3L-srv>
 <CAK5_k=LeBQnmr7HfBZT9HismdfN65oJvrNU8KH1QgP=uYZaezg@mail.gmail.com>
 <20210331034851.GH13786@MiWiFi-R3L-srv>
 <20210331080324.GC29970@MiWiFi-R3L-srv> <YGQujxhxgOvtwb7n@kroah.com>
Date: Wed, 31 Mar 2021 09:05:48 -0500
Message-ID: <m1pmzfquyr.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: kexec does not work for kernel version with patch level >= 256
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
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Baoquan He <bhe@redhat.com>, Patrick Sung <patricksung@gmail.com>, sashal@kernel.org, kexec@lists.infradead.org, dyoung@redhat.com, horms@verge.net.au

Greg KH <gregkh@linuxfoundation.org> writes:

> On Wed, Mar 31, 2021 at 04:03:24PM +0800, Baoquan He wrote:
>> Add Sasha and Greg to the CC list.
>> 
>> On 03/31/21 at 11:48am, Baoquan He wrote:
>> > On 03/31/21 at 11:04am, Patrick Sung wrote:
>> > > On Wed, Mar 31, 2021 at 10:47 AM Baoquan He <bhe@redhat.com> wrote:
>> > > >
>> > > > On 03/24/21 at 12:28pm, Patrick Sung wrote:
>> > > > > Hello all,
>> > > > >
>> > > > > I am using the 4.9 long term kernel which is currently at 4.9.262.
>> > > > > When using this kernel with kexec-tools it prints out this error
>> > > > >
>> > > > >   Unsupported utsname.release: 4.9.262
>> > > > >   Cannot load <kdump images path>
>> > > > >
>> > > > > A quick search in the code shows that kexec/kernel_version.c doing this check:
>> > > > >
>> > > > >   if (major >= 256 || minor >= 256 || patch >= 256) {
>> > > > >
>> > > > > and also in kexec/kexec.h
>> > > > >   #define KERNEL_VERSION(major, minor, patch) \
>> > > > >     (((major) << 16) | ((minor) << 8) | patch)
>> > > >
>> > > > Yeah, this seems to be a good catch. The existing longterm kenrel 4.9.262
>> > > > does cause the problem. I am not very sure about the longterm kernel
>> > > > version numbering, maybe we can leave 16 bits for for patch number to
>> > > > avoid the longterm kernel issue?
>> > > >
>> > > > Is there document telling the longterm kernel version numbering, or any
>> > > > pointer?
>> > > >
>> > > Actually I found that the mainline kernel clamp the "patch" version to 255
>> > > 
>> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/Makefile?id=9b82f13e7ef316cdc0a8858f1349f4defce3f9e0
>> > 
>> > Yeah, mainline kernel use below formula to construct kernel version.
>> > Seems longterm kernel takes a different way. While it's understandable
>> > that Longterm kernel using a larger patch number since it will evolve
>> > evolve for a longer time to get in bug fixes. Maybe we should enlarge
>> > patch number to 16 bits?
>> > 
>> > echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) +  \                                                                        
>> >         ((c) > 255 ? 255 : (c)))';
>> 
>> Should we also need to do the the same thing in kexec-tools utility, to
>> clamp the sub-level to 255? And the sub-level number is not so important
>> that we can do the clamping and won't cause any issue?
>
> If you can enlarge your "c" number to be 16bits, please do so.  We
> couldn't do that in the kernel source as it would break an existing
> user/kernel api :(

The code in kexec certainly can.  The function kernel_version() returns
a long.

However.  I think the code in kexec can do better.

There are only 4 uses of KERNEL_VERSION in the tree and only one of them
is testing for a case that would apply to kernel versions that are being
maintained.

AKA  I think checks for 3.15 and 2.6.27 we can just delete.

The checks for 3.15 are about command line size and are actively wrong.
As checking the running kernel to find the version of the kernel that
is being loaded is not reliable.

Which leaves only one check and I think the information needed is
X86_64_PAGE_OFFSET.  I think that can be obtained directly by
reading /proc/kcore instead of guessing it from the kernel version.

Does anyone want to try that?  I admit it is a bit more work than
changing the macro to just add more bits to the patch level
but it is would be more robust long term.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
