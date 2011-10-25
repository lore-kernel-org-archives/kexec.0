Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RIcSD-0003MZ-PF
	for kexec@lists.infradead.org; Tue, 25 Oct 2011 08:33:50 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9P8Xikc009915
	for <kexec@lists.infradead.org>; Tue, 25 Oct 2011 08:33:44 GMT
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
	[9.149.37.229])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p9P8XiZe2453624
	for <kexec@lists.infradead.org>; Tue, 25 Oct 2011 09:33:44 +0100
Received: from d06av05.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p9P8XgXD012086
	for <kexec@lists.infradead.org>; Tue, 25 Oct 2011 02:33:43 -0600
Message-ID: <1319531622.3056.1.camel@br98xy6r>
Subject: RE: kdump: crash_kexec()-smp_send_stop() race in panic
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Tue, 25 Oct 2011 10:33:42 +0200
In-Reply-To: <5C4C569E8A4B9B42A84A977CF070A35B2C57612A37@USINDEVS01.corp.hds.com>
References: <1319468137.3615.16.camel@br98xy6r>
	<m1ipneifqv.fsf@fess.ebiederm.org>
	<CAM_iQpVktWsgOFCWoT47dQ1YdSTnnbTZAAKNYEEX=5wWzhHMzg@mail.gmail.com>
	<m1aa8qfhdk.fsf@fess.ebiederm.org> <20111024173336.GB8044@redhat.com>
	<5C4C569E8A4B9B42A84A977CF070A35B2C57612A37@USINDEVS01.corp.hds.com>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
To: Seiji Aguchi <seiji.aguchi@hds.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, =?ISO-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Hello Seiji,

On Mon, 2011-10-24 at 18:24 -0400, Seiji Aguchi wrote:
> Hi,
> 
> >> >>> 1st CPU:
> >> >>> panic()->crash_kexec()->mutex_trylock(&kexec_mutex)-> do kdump
> >> >>>
> >> >>> 2nd CPU:
> >> >>> panic()->crash_kexec()->kexec_mutex already held by 1st CPU
> >> >>>        ->smp_send_stop()-> stop CPU 1 (stop kdump)
> >> >>>
> >> >>> How should we fix this problem? One possibility could be to do
> >> >>> smp_send_stop() before we call crash_kexec().
> 
> http://lkml.org/lkml/2010/9/16/353
> 
> I developed a patch solving this issue one year ago.
> (Just adding local_irq_disable in kexec path.)

This won't work (at least on s390) because smp_send_stop() will also
stop CPUs that have interrupts disabled.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
