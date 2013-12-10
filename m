Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqSlm-0002CX-Rm
 for kexec@lists.infradead.org; Tue, 10 Dec 2013 19:14:59 +0000
Date: Tue, 10 Dec 2013 14:14:09 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] kexec: add sysctl to disable kexec
Message-ID: <20131210191409.GE13909@redhat.com>
References: <20131210001620.GA7938@www.outflux.net>
 <52A66190.9060907@zytor.com>
 <CAGXu5jKkCNWQKH-Ozm72C3aY_NBzRdNo2GmqKbVVJds5xs=SXg@mail.gmail.com>
 <20131210143540.GA13909@redhat.com>
 <f4fbae55-7d7b-400d-b50f-258002371368@email.android.com>
 <20131210183352.GD13909@redhat.com> <52A76348.5080803@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52A76348.5080803@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Rik van Riel <riel@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, Rob Landley <rob@landley.net>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>

On Tue, Dec 10, 2013 at 10:54:00AM -0800, H. Peter Anvin wrote:
> On 12/10/2013 10:33 AM, Vivek Goyal wrote:
> > On Tue, Dec 10, 2013 at 08:32:38AM -0800, H. Peter Anvin wrote:
> >> Of course it isn't.
> > 
> > I am not sure what are you trying to say. This is too brief.
> > 
> > Thanks
> > Vivek
> > 
> 
> Of course it is not sufficient.  Once you can get arbitrary code into
> kernel space (CPL 0) you can do anything, and "disabling jump back" is
> just a speed bump.

Agreed that disabling jump back is only a speed bump.

Kees, so how would be use this knob?

- If I put it in some init script, then root will permission to modify
  and remove it.

- Can one specify sysctl parameters on command line? If yes, then one
  can disable this using kernel command line and in that case kdump will
  be disabled too.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
