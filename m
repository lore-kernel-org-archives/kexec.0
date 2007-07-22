Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from qb-out-0506.google.com ([72.14.204.230])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1ICTfK-0002yJ-Ch
	for kexec@lists.infradead.org; Sun, 22 Jul 2007 01:07:36 -0400
Received: by qb-out-0506.google.com with SMTP id e6so1197649qbe
	for <kexec@lists.infradead.org>; Sat, 21 Jul 2007 22:07:33 -0700 (PDT)
Message-ID: <9a8748490707212207h63abdb94o3d27a24d67a0ca12@mail.gmail.com>
Date: Sun, 22 Jul 2007 07:07:32 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: [PATCH][24/37] Clean up duplicate includes in kernel/
In-Reply-To: <a781481a0707211844s40e203c4t51250ff421d8781d@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <200707211703.30346.jesper.juhl@gmail.com>
	<a781481a0707211844s40e203c4t51250ff421d8781d@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Satyam Sharma <satyam.sharma@gmail.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Manfred Spraul <manfred@colorfullife.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Tweedie <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Lameter <clameter@engr.sgi.com>, Paul McKenney <paulmck@us.ibm.com>, linux-audit@redhat.com, john stultz <johnstul@us.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, Rickard Faith <faith@redhat.com>, Josh Triplett <josh@freedesktop.org>

On 22/07/07, Satyam Sharma <satyam.sharma@gmail.com> wrote:
> On 7/21/07, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > Hi,
> >
> > This patch cleans up duplicate includes in
> >         kernel/
> >
> >
> > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
>
> Reviewed-by: Satyam Sharma <ssatyam@cse.iitk.ac.in>
>
> [ Jesper, I hope you re-built with all these changes? Some
> of these duplicate #include's could have been hiding deeper
> header-include-ordering problems, and we'd want to know
> about that too. Otherwise looks fairly obvious, thanks. ]
>
I build an allmodconfig kernel, an allnoconfig one as well as one with
my regular config for my home machine.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
