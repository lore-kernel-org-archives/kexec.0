Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRVwK-005u39-5V
 for kexec@lists.infradead.org; Wed, 31 Mar 2021 08:11:03 +0000
Date: Wed, 31 Mar 2021 10:10:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: kexec does not work for kernel version with patch level >= 256
Message-ID: <YGQujxhxgOvtwb7n@kroah.com>
References: <CAK5_k=Lao5dYtAWrBMXViM0iEdT0QOj-fPiEsuvkfTogfF=6dA@mail.gmail.com>
 <20210331024745.GB29970@MiWiFi-R3L-srv>
 <CAK5_k=LeBQnmr7HfBZT9HismdfN65oJvrNU8KH1QgP=uYZaezg@mail.gmail.com>
 <20210331034851.GH13786@MiWiFi-R3L-srv>
 <20210331080324.GC29970@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210331080324.GC29970@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: Patrick Sung <patricksung@gmail.com>, sashal@kernel.org, kexec@lists.infradead.org, dyoung@redhat.com, ebiederm@xmission.com, horms@verge.net.au

On Wed, Mar 31, 2021 at 04:03:24PM +0800, Baoquan He wrote:
> Add Sasha and Greg to the CC list.
> 
> On 03/31/21 at 11:48am, Baoquan He wrote:
> > On 03/31/21 at 11:04am, Patrick Sung wrote:
> > > On Wed, Mar 31, 2021 at 10:47 AM Baoquan He <bhe@redhat.com> wrote:
> > > >
> > > > On 03/24/21 at 12:28pm, Patrick Sung wrote:
> > > > > Hello all,
> > > > >
> > > > > I am using the 4.9 long term kernel which is currently at 4.9.262.
> > > > > When using this kernel with kexec-tools it prints out this error
> > > > >
> > > > >   Unsupported utsname.release: 4.9.262
> > > > >   Cannot load <kdump images path>
> > > > >
> > > > > A quick search in the code shows that kexec/kernel_version.c doing this check:
> > > > >
> > > > >   if (major >= 256 || minor >= 256 || patch >= 256) {
> > > > >
> > > > > and also in kexec/kexec.h
> > > > >   #define KERNEL_VERSION(major, minor, patch) \
> > > > >     (((major) << 16) | ((minor) << 8) | patch)
> > > >
> > > > Yeah, this seems to be a good catch. The existing longterm kenrel 4.9.262
> > > > does cause the problem. I am not very sure about the longterm kernel
> > > > version numbering, maybe we can leave 16 bits for for patch number to
> > > > avoid the longterm kernel issue?
> > > >
> > > > Is there document telling the longterm kernel version numbering, or any
> > > > pointer?
> > > >
> > > Actually I found that the mainline kernel clamp the "patch" version to 255
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/Makefile?id=9b82f13e7ef316cdc0a8858f1349f4defce3f9e0
> > 
> > Yeah, mainline kernel use below formula to construct kernel version.
> > Seems longterm kernel takes a different way. While it's understandable
> > that Longterm kernel using a larger patch number since it will evolve
> > evolve for a longer time to get in bug fixes. Maybe we should enlarge
> > patch number to 16 bits?
> > 
> > echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) +  \                                                                        
> >         ((c) > 255 ? 255 : (c)))';
> 
> Should we also need to do the the same thing in kexec-tools utility, to
> clamp the sub-level to 255? And the sub-level number is not so important
> that we can do the clamping and won't cause any issue?

If you can enlarge your "c" number to be 16bits, please do so.  We
couldn't do that in the kernel source as it would break an existing
user/kernel api :(

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
