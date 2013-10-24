Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VZLVP-0001UT-Op
 for kexec@lists.infradead.org; Thu, 24 Oct 2013 14:03:20 +0000
Date: Thu, 24 Oct 2013 10:02:41 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] x86, kdump: crashkernel=X try to reserve below 896M
 first, then try below 4G, then MAXMEM
Message-ID: <20131024140241.GA2322@redhat.com>
References: <1381751200-27376-1-git-send-email-chaowang@redhat.com>
 <CAE9FiQUNMDuVZtqud3LBbAmE0SL8ZWLFnc+CSYZm4UfTvNUaOA@mail.gmail.com>
 <20131015144810.GI31215@redhat.com>
 <CAE9FiQXVCx__SuhAdO9_CNaRncW2HB2tv3UjZrQcbsTV35QWow@mail.gmail.com>
 <20131018123837.GB2277@redhat.com>
 <CAE9FiQWdMmSseDk6J=TOXT9ZahJUBf2BOU+VHJRXeeMofgH=EQ@mail.gmail.com>
 <20131021151643.GA20669@redhat.com>
 <CAE9FiQVfeUdugFRMt1DGjtqW2FAb2gfnGjXENHjoJ=JVAYbYgw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE9FiQVfeUdugFRMt1DGjtqW2FAb2gfnGjXENHjoJ=JVAYbYgw@mail.gmail.com>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Jacob Shin <jacob.shin@amd.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, WANG Chao <chaowang@redhat.com>

On Wed, Oct 23, 2013 at 11:11:51PM -0700, Yinghai Lu wrote:
> On Mon, Oct 21, 2013 at 8:16 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> > On Fri, Oct 18, 2013 at 10:45:43PM -0700, Yinghai Lu wrote:
> >
> >
> > IIUC, you are trying to say that with new kernel old kexec-tools will fail
> > at a different failure point. I don't see why that is a problem. It still
> > fails.
> 
> Yes, that could cause confusion.
> 
> We already knew it would fail possible at most later, we should make
> it skip allocation during first kernel booting.

One could upgrade kexec-tools later. So Kernel does not know whether
user space is able to handle higher memory regions or not. So forcing
kernel to skip memory allocation does not sound right to me.

Also even with memory reserved high, old kexec-tools which can't deal
with it will fail anyway. So I don't agree that it is a problem.

[..]
> > No, it is not that simple. Think from a distribution's perspective also.
> > We have the logic to scale reserved memory based on physical memory
> > present in the system. Now we are seeing bigger memory systems (which
> > would not have worked in the past). We still want to retain the existing
> > logic and not switch to crashkernel=x,high. One does not have to. It
> > makes life simpler.
> 
> distribution should go with ",high" for 64 bit kernel and new kexec-tools.
> for 32bit kernel, you still can have ",high" or not, as ",high" is ignored.

Just because we have the facility to allocate memory starting from top, does
not mean that we should kill other options and force user to use this
option.

With crashkernel=X,high, a low memory will be reserved for swiotlb. And
I don't want that extra memory reservation. I am more than happy to
reserve memory below 4G and not do low memory reservation.


[..]
> Even we want to extend crashkernel=XM, then i would like to have
> it identical to crashkernel=XM,high instead.

You are assuming that crashkernel=xM,high is always good. I am arguing
that because it requires low memory reservation for swiotlb, when IOMMU
is not around, it will end up reserving more memory. So it is not
necessarily better than reserving memory below 4G.

Hence both crashkernel=xM and crashkernel=XM,high have their own usage.
We have been using crashkernel=xM and we know it works. So extending it
to be able to allocate memory from higher regions, if sufficient memory
is not available in lower regions makes sense. Memory reservation below
4G is more efficient due to not requiring swiotlb. And crashkernel=xM
has been working for us and users are familiar with it.

So I don't see a point that why would you try to block any move to
extend crashkernel=xM semantics.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
