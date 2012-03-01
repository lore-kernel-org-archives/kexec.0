Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S3BB0-00014X-R9
 for kexec@lists.infradead.org; Thu, 01 Mar 2012 18:56:32 +0000
Date: Thu, 1 Mar 2012 13:31:15 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump: force page alignment for per-CPU crash notes.
Message-ID: <20120301183115.GE13533@redhat.com>
References: <1330536083-13098-1-git-send-email-surovegin@google.com>
 <20120301150957.GA13533@redhat.com>
 <CANrfoUVMP5hPfm2R=C9eszS728YccKyWokUAa5Q5KN36+W83bg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANrfoUVMP5hPfm2R=C9eszS728YccKyWokUAa5Q5KN36+W83bg@mail.gmail.com>
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
To: Eugene Surovegin <surovegin@google.com>
Cc: kexec-list <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

On Thu, Mar 01, 2012 at 09:04:32AM -0800, Eugene Surovegin wrote:
> On Thu, Mar 1, 2012 at 7:09 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> > On Wed, Feb 29, 2012 at 09:21:23AM -0800, Eugene Surovegin wrote:
> >> Per-CPU allocations are not guaranteed to be physically contiguous.
> >> However, kdump kernel and user-space code assumes that per-CPU
> >> memory, used for saving CPU registers on crash, is.
> >> This can cause corrupted /proc/vmcore in some cases - the main
> >> symptom being huge ELF note section.
> >>
> >> Force page alignment for note_buf_t to ensure that this assumption holds.
> >>
> >
> > Hi Eugene,
> >
> > Where do we make assumption that crash_notes address is page aligned?
> 
> I never said that. I said that assumption was that note chunks were
> physically contiguous.
> 
> [snip]
> 
> > Are you referring to the fact that note could be stored on two different
> > physical pages and then kexec-tools does not know about the physical
> > address of second page, hence second kernel does not know about it
> > and we never read that data. That sounds like a problem.
> 
> Yes. This is exactly what happens in some cases.

Ok. Thanks for clarifying. Patch looks good to me.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
