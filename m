Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from usindpps04.hds.com ([207.126.252.17])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RIT1l-0006wl-00
	for kexec@lists.infradead.org; Mon, 24 Oct 2011 22:29:54 +0000
From: Seiji Aguchi <seiji.aguchi@hds.com>
Date: Mon, 24 Oct 2011 18:24:14 -0400
Subject: RE: kdump: crash_kexec()-smp_send_stop() race in panic
Message-ID: <5C4C569E8A4B9B42A84A977CF070A35B2C57612A37@USINDEVS01.corp.hds.com>
References: <1319468137.3615.16.camel@br98xy6r>
	<m1ipneifqv.fsf@fess.ebiederm.org>
	<CAM_iQpVktWsgOFCWoT47dQ1YdSTnnbTZAAKNYEEX=5wWzhHMzg@mail.gmail.com>
	<m1aa8qfhdk.fsf@fess.ebiederm.org> <20111024173336.GB8044@redhat.com>
In-Reply-To: <20111024173336.GB8044@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, =?iso-8859-1?Q?Am=E9rico_Wang?= <xiyou.wangcong@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "holzheu@linux.vnet.ibm.com" <holzheu@linux.vnet.ibm.com>

Hi,

>> >>> 1st CPU:
>> >>> panic()->crash_kexec()->mutex_trylock(&kexec_mutex)-> do kdump
>> >>>
>> >>> 2nd CPU:
>> >>> panic()->crash_kexec()->kexec_mutex already held by 1st CPU
>> >>>        ->smp_send_stop()-> stop CPU 1 (stop kdump)
>> >>>
>> >>> How should we fix this problem? One possibility could be to do
>> >>> smp_send_stop() before we call crash_kexec().

http://lkml.org/lkml/2010/9/16/353

I developed a patch solving this issue one year ago.
(Just adding local_irq_disable in kexec path.)

I hope this helps.

Seiji


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
