Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U0Xyj-0006ns-DO
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 13:45:30 +0000
Message-ID: <510923EE.5000202@canonical.com>
Date: Wed, 30 Jan 2013 14:45:18 +0100
From: Bouchard Louis <louis.bouchard@canonical.com>
MIME-Version: 1.0
Subject: Re: makedumpfile --dump-dmesg option broken on 3.5 kernels and later
References: <50FE9989.5070601@canonical.com>
 <20130123101952.79072daf31bb30e217d38adf@mxc.nes.nec.co.jp>
In-Reply-To: <20130123101952.79072daf31bb30e217d38adf@mxc.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org

Hello,

Le 23/01/2013 02:19, Atsushi Kumagai a =E9crit :
> Hello Louis,
> =

> On Tue, 22 Jan 2013 14:52:09 +0100
> Bouchard Louis <louis.bouchard@canonical.com> wrote:
> =

>> Hello Kumagai-san,
>>
>> Following a suggestion from Dave Anderson, I have tested the
>> makedumpfile --dump-dmesg option. After some research, I realized that
>> the option was no longer working on 3.5 kernel and later. Here is an
>> example of the result (on Ubuntu Quantal) :
>>
>> # makedumpfile --dump-dmesg /proc/vmcore /tmp/dmesg
>> dump_dmesg: Can't find some symbols for log_buf.
>>
>> makedumpfile Failed.
>>
>> On 3.5 kernel and later, the log_end symbol no longer exists.
>>
>> This is caused by the change from byte-buffer structure to
>> variable-length record buffer of the kernel log buffer introduced by
>> this commit :
>> 	http://goo.gl/NCgLI
>>
>> I am curious to know if you were aware of this change and if you had
>> done some work on modifying dump_dmesg() accordingly ? Just so I don't
>> go off and try to work on something that you have already solved.
> =

> Thanks for your report.
> I haven't been aware of this, so could I ask you to help me ?
> =

> =

> Thanks
> Atsushi Kumagai

I now have what looks like a working patch for this issue. Thank to Dave
Anderson (crash) and Eric Biederman (vmcore-dmesg) for having chewed
most of the work for me.

My only remaining problem is to be able to print the syslog level as is
provided in the previous version.  Currently, the kernel doesn't export
the 'level:3' offset of the log structure in the vmcoreinfo information
provided in the vmcore.

Vivek who authored the original kernel/printk.c patch might be able to
suggest a better way to expose log.level:3 (I did try to patch the
kernel but got thrown away because of the nature of .level:3 that didn't
fit the VMCOREINFO_OFFSET macro)

In the meantime, I only found this kinda ugly hack to work around the
absence of the structure element :

>                 /*
>                  * Ugly hack around absence of log.level:3
>                  * Hard code log.level offset =3D log.dict_len + 3
>                  */
>                 level =3D (UCHAR(logptr + OFFSET(log.dict_len)+3)&level_m=
ask);
> =

>         sprintf(buf,"<%d>[%5lld.%06ld] ",level,nanos,rem/1000);

Aside from that, I get an identical dmesg output on kernel 3.5 and after.

I would appreciate comments on the following before I send the patch to
the list.

Kind regards,

...Louis
-- =

Louis Bouchard
Backline Support Analyst
Canonical Ltd
Ubuntu support: http://landscape.canonical.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
