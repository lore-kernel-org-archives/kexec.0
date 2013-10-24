Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VZQZy-00038h-7L
 for kexec@lists.infradead.org; Thu, 24 Oct 2013 19:28:22 +0000
Date: Thu, 24 Oct 2013 15:27:52 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] x86, kdump: crashkernel=X try to reserve below 896M
 first, then try below 4G, then MAXMEM
Message-ID: <20131024192752.GG2322@redhat.com>
References: <20131015144810.GI31215@redhat.com>
 <CAE9FiQXVCx__SuhAdO9_CNaRncW2HB2tv3UjZrQcbsTV35QWow@mail.gmail.com>
 <20131018123837.GB2277@redhat.com>
 <CAE9FiQWdMmSseDk6J=TOXT9ZahJUBf2BOU+VHJRXeeMofgH=EQ@mail.gmail.com>
 <20131021151643.GA20669@redhat.com>
 <CAE9FiQVfeUdugFRMt1DGjtqW2FAb2gfnGjXENHjoJ=JVAYbYgw@mail.gmail.com>
 <20131024140241.GA2322@redhat.com>
 <CAE9FiQUu0WwMgNpog4TKch+MT2i7_DsNvqZxbyQusS4AFxdhQQ@mail.gmail.com>
 <20131024191821.GE2322@redhat.com>
 <CAE9FiQU7+FRY=3ETdGZJJfcS0vjRht4ZT8MHTQ66kpjD2MmrcA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE9FiQU7+FRY=3ETdGZJJfcS0vjRht4ZT8MHTQ66kpjD2MmrcA@mail.gmail.com>
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

On Thu, Oct 24, 2013 at 12:24:57PM -0700, Yinghai Lu wrote:
> On Thu, Oct 24, 2013 at 12:18 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
> > On Thu, Oct 24, 2013 at 12:15:25PM -0700, Yinghai Lu wrote:
> >
> > Also keeping things simple by not trying to *impose* a new crashkernel=
> > syntax on existing crashkernel=xM users.
> 
> Existing user that have crashkernel=xM working with their old kernel
> and old kexec-tools, they still could keep their old command line and
> old kexec-tools
> with new updated kernel.
> We should not change semantics to surprise them.

Old users will get reservation still below 896MB.

It will go above 896MB only if memory could not be allocated below 896MB.

In the past reservation will fail and kexec-tools will fail.
Now reservation will succeed but kexec-tools will fail.

So end result a user sees is that kexec-tools fails. So I don't see how
we are breaking existing installations or user setups.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
