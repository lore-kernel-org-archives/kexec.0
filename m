Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RIMEA-0003EA-LB
	for kexec@lists.infradead.org; Mon, 24 Oct 2011 15:14:15 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1319468137.3615.16.camel@br98xy6r>
Date: Mon, 24 Oct 2011 08:14:16 -0700
In-Reply-To: <1319468137.3615.16.camel@br98xy6r> (Michael Holzheu's message of
	"Mon, 24 Oct 2011 16:55:37 +0200")
Message-ID: <m1ipneifqv.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: kdump: crash_kexec()-smp_send_stop() race in panic
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: holzheu@linux.vnet.ibm.com
Cc: heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Michael Holzheu <holzheu@linux.vnet.ibm.com> writes:

> Hello Vivek,
>
> In our tests we ran into the following scenario:
>
> Two CPUs have called panic at the same time. The first CPU called
> crash_kexec() and the second CPU called smp_send_stop() in panic()
> before crash_kexec() finished on the first CPU. So the second CPU
> stopped the first CPU and therefore kdump failed.
>
> 1st CPU:
> panic()->crash_kexec()->mutex_trylock(&kexec_mutex)-> do kdump
>
> 2nd CPU:
> panic()->crash_kexec()->kexec_mutex already held by 1st CPU
>        ->smp_send_stop()-> stop CPU 1 (stop kdump)
>
> How should we fix this problem? One possibility could be to do
> smp_send_stop() before we call crash_kexec().
>
> What do you think?

smp_send_stop is insufficiently reliable to be used before crash_kexec.

My first reaction would be to test oops_in_progress and wait until
oops_in_progress == 1 before calling smp_send_stop.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
