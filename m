Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1anN3s-00031w-OW
 for kexec@lists.infradead.org; Tue, 05 Apr 2016 09:14:13 +0000
Date: Tue, 5 Apr 2016 17:18:28 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH v4] Improve the performance of --num-threads -d 31
Message-ID: <20160405091828.GA25769@dhcp-128-25.nay.redhat.com>
References: <20160315063430.GA12981@dhcp-128-25.nay.redhat.com>
 <56EB6C06.30205@cn.fujitsu.com>
 <20160318041622.GB29025@dhcp-128-25.nay.redhat.com>
 <56EB96B8.7010103@cn.fujitsu.com>
 <20160331083854.GA7343@dhcp-128-25.nay.redhat.com>
 <56FCE93C.2020401@cn.fujitsu.com>
 <20160401062714.GA23403@dhcp-128-25.nay.redhat.com>
 <56FE59C9.6060307@cn.fujitsu.com>
 <20160401131512.GA28817@dhcp-128-25.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E37518@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E37518@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: =?utf-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?= <zhouwj-fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 04/04/16 at 05:46am, Atsushi Kumagai wrote:
> Hello,
> 
> Let me get this straight.
> >> >The major memory is consumed by makedumpfile from the test result.
> >> >crashkernel=auto doesn't work any more, if option --num-threads is
> >> >set. Even more, there is no warning to let user enlarge the reserved
> >> >memory.
> >> >
> >>
> >> Yes, we should remind user if they want to use too much threads.
> 
> After all, the ENOMEM issue isn't peculiar to a specific patch but
> just a matter of course "more threads consume more memory" ?
> (At least I expect so.)

Hi, Atsushi.

Yes, it is, because ENOMEM never happen once the reserved memory is
enlarged manually from my testing.

Maybe there should be a generic formular to estimate how
much memory will be consumed by specific makedumpfile config.

> 
> >This new feature multi-threads will consume more memory during dumping
> >vmcore in 2nd kernel. Is it possible to improve it?
> 
> makedumpfile is designed to work in limited memory space, but the extra
> memory consumption for each thread isn't considered.
> I think it can be estimated by checking code and measured by actual test.
> 
> e.g. If we find that each thread requires 100KB more memory, 100KB * num-thread
> should be reserved before filtering processing.
> As I said to Zhou, the logic should be inserted into the cyclic buffer
> allocation method (calculate_cyclic_buffer_size()).

Agree.

> 
> >> >>And I think it will also work if the reserved memory is set to 1G.
> >> >
> >> >Yes, makedumpfile can work well under 1GB reserved memory.
> >> >
> >> >>
> >> >>>The cache should be dropped before testing, otherwise makedumpfile will
> >> >>>fail to dump vmcore.
> >> >>>echo 3 > /proc/sys/vm/drop_caches
> >> >>>Maybe there is something cleanup we can do to avoid this.
> >> >>>
> >> >>>Following is the result with different parameter for option
> >> >>>--num-threads.
> >> >>>
> >> >>>makedumpfile -l --num-threads 128 --message-level 1 -d 31 /proc/vmcore a.128
> >> >>>real    5m34.116s
> >> >>>user    103m42.531s
> >> >>>sys 86m12.586s
> >> >[ snip ]
> >> >>>makedumpfile -l --num-threads 0 --message-level 1 -d 31 /proc/vmcore a.0
> >> >>>real    3m46.531s
> >> >>>user    3m29.371s
> >> >>>sys 0m16.909s
> >> >>>
> >> >>>makedumpfile.back -l --message-level 1 -d 31 /proc/vmcore a
> >> >>>real    3m55.712s
> >> >>>user    3m39.254s
> >> >>>sys 0m16.287s
> >> >>>
> >> >>>Once the reserved memory is enlarged, makedumpfile works well with or
> >> >>>without this increaseing patch.
> >> >>>
> >> >>>But there is an another issue I found during testing. makedumpfile may
> >> >>>hang in about 24%. And with option --num-threads 64, this issue is also
> >> >>>occured.
> >> >>>
> >> >>
> >> >>Will it occur with patch v3?
> >> >>If it not occurs, then neither of the previous two increasing patches will work?
> >> >>
> >> >>And did you test it with or without the increasing patch?
> >> >
> >> >without this increasing patch, v4 works well.
> >> >
> >>
> >> Do you mean makedumpfile won't hang without the increasing patch?
> >
> >Seem that, but I cann't confirm it, since this issue occurs very
> >occasionally.
> 
> I want to know how many times were the two cases (v4 and v4+inc) tested
> and how often did them hang.

I have test it more than twenty times with patch v4, and there is no
hang during testing.

Appending option --num-threads 32 or bigger thread number, makedumpfile
will hang in about every five times with increasing patch based on patch
v4.

Thanks
Minfei

> 
> 
> Thanks,
> Atsushi Kumagai
> 
> >Thanks
> >Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
