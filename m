Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqSSO-0001kK-Sv
 for kexec@lists.infradead.org; Tue, 10 Dec 2013 18:54:57 +0000
Message-ID: <52A76348.5080803@zytor.com>
Date: Tue, 10 Dec 2013 10:54:00 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] kexec: add sysctl to disable kexec
References: <20131210001620.GA7938@www.outflux.net>
 <52A66190.9060907@zytor.com>
 <CAGXu5jKkCNWQKH-Ozm72C3aY_NBzRdNo2GmqKbVVJds5xs=SXg@mail.gmail.com>
 <20131210143540.GA13909@redhat.com>
 <f4fbae55-7d7b-400d-b50f-258002371368@email.android.com>
 <20131210183352.GD13909@redhat.com>
In-Reply-To: <20131210183352.GD13909@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Rik van Riel <riel@redhat.com>, Kees Cook <keescook@chromium.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, Rob Landley <rob@landley.net>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>

On 12/10/2013 10:33 AM, Vivek Goyal wrote:
> On Tue, Dec 10, 2013 at 08:32:38AM -0800, H. Peter Anvin wrote:
>> Of course it isn't.
> 
> I am not sure what are you trying to say. This is too brief.
> 
> Thanks
> Vivek
> 

Of course it is not sufficient.  Once you can get arbitrary code into
kernel space (CPL 0) you can do anything, and "disabling jump back" is
just a speed bump.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
