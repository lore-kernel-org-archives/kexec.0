Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqOQL-0000os-Jd
 for kexec@lists.infradead.org; Tue, 10 Dec 2013 14:36:34 +0000
Date: Tue, 10 Dec 2013 09:35:40 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] kexec: add sysctl to disable kexec
Message-ID: <20131210143540.GA13909@redhat.com>
References: <20131210001620.GA7938@www.outflux.net>
 <52A66190.9060907@zytor.com>
 <CAGXu5jKkCNWQKH-Ozm72C3aY_NBzRdNo2GmqKbVVJds5xs=SXg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGXu5jKkCNWQKH-Ozm72C3aY_NBzRdNo2GmqKbVVJds5xs=SXg@mail.gmail.com>
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
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Rik van Riel <riel@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, Rob Landley <rob@landley.net>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>

On Mon, Dec 09, 2013 at 05:06:10PM -0800, Kees Cook wrote:
> On Mon, Dec 9, 2013 at 4:34 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> > On 12/09/2013 04:16 PM, Kees Cook wrote:
> >> For general-purpose (i.e. distro) kernel builds it makes sense to build with
> >> CONFIG_KEXEC to allow end users to choose what kind of things they want to do
> >> with kexec. However, in the face of trying to lock down a system with such
> >> a kernel, there needs to be a way to disable kexec (much like module loading
> >> can be disabled). Without this, it is too easy for the root user to modify
> >> kernel memory even when CONFIG_STRICT_DEVMEM and modules_disabled are set.
> >>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >> Acked-by: Rik van Riel <riel@redhat.com>
> >
> > So the logic is to load a crashkernel and then lock down the machine
> > before services, networking etc. are enabled?
> 
> Right, or to just turn it off at boot time if kexec will not be used at all.

kdump kernel is loaded with the help of kdump service. Different distro's
might have different dependencies for that serivce. But recently in fedora
we wait network to come up before starting that service. (So that nfs
targets can be mounted and checked for valid dump destinations).

IOW, crash kernel is loaded quite late in the game (quite a few services
have run and possibly networking is up too). To me, practically one will
disable kdump also if you change state of this knob early.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
