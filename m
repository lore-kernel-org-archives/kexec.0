From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 09 May 2022 12:57:59 +0200
Subject: [PATCHv3 1/2] cpu/hotplug: Keep cpu hotplug disabled until the
 rebooting cpu is stable
In-Reply-To: <87ee13rn52.ffs@tglx>
References: <20220509041305.15056-1-kernelfans@gmail.com>
 <20220509041305.15056-2-kernelfans@gmail.com> <87ee13rn52.ffs@tglx>
Message-ID: <87bkw7rn0o.ffs@tglx>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, May 09 2022 at 12:55, Thomas Gleixner wrote:
> On Mon, May 09 2022 at 12:13, Pingfan Liu wrote:
>> -		cpu_hotplug_enable();
>
> This is tinkering at best. Can we please sit down and rethink this whole
> machinery instead of applying random duct tape to it?

That said, I still have not figured out which real world problem you are
actually trying to solve.

Thanks,

        tglx

