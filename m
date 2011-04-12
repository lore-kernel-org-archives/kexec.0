Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20110412144330.GB20815@atrey.karlin.mff.cuni.cz>
References: <20110317064523.GA1995@ucw.cz>
	<AANLkTik1CdT4k8SJop7b-MjR27RzF7a=i7WuodNKJi+J@mail.gmail.com>
	<20110322133034.GA15475@atrey.karlin.mff.cuni.cz>
	<m1bp0zylgg.fsf@fess.ebiederm.org>
	<20110412144330.GB20815@atrey.karlin.mff.cuni.cz>
From: Eric Miao <eric.y.miao@gmail.com>
Date: Tue, 12 Apr 2011 22:46:25 +0800
Message-ID: <BANLkTikZXjfD82DxoahkvUo+26cjvOKZmw@mail.gmail.com>
Subject: Re: reboot/kexec in 2.6.38
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
To: Cyril Hrubis <metan@ucw.cz>
Cc: zaurus-devel@www.linuxtogo.org, thommycheck@gmail.com, Marek Vasut <marek.vasut@gmail.com>, dbaryshkov@gmail.com, arminlitzel@web.de, Kexec Mailing List <kexec@lists.infradead.org>, kernel list <linux-kernel@vger.kernel.org>, utx@penguin.cz, lenz@cs.wisc.edu, rpurdie@rpsys.net, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, omegamoon@gmail.com

On Tue, Apr 12, 2011 at 10:43 PM, Cyril Hrubis <metan@ucw.cz> wrote:
> Hi!
>> >> I think it's config issue. Never heard of this.
>> >
>> > I've just compiled and booted 2.6.38. The kernel boots without problems when
>> > flashed in. But I've had no success with kexec, the last lines I see are:
>> >
>> > Starting new kernel
>>
>> Enable early_printk to a serial port if you can.
>>
>> There is definitely an issue in 2.6.38 where kdump doesn't work, that
>> right now looks like a memblock issue.
>
> Finaly got time to solder serial adapter...
>
> And now, after I configured kernel to print to both ttyS0 serial console and
> tty0 the kexec started to work.

Cool. Please help check why it didn't work, and see if we have something
broken.

>
> --
> metan
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
