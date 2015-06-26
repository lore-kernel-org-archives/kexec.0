Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z8O6r-0005hR-25
 for kexec@lists.infradead.org; Fri, 26 Jun 2015 07:31:38 +0000
Message-ID: <558CFEED.1040501@cn.fujitsu.com>
Date: Fri, 26 Jun 2015 15:27:41 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/10] makedumpfile: parallel processing
References: <1434704204-2634-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <558B6696.4020906@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DC9C14@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701DC9C14@BPXM01GP.gisp.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 06/26/2015 03:07 PM, Atsushi Kumagai wrote:
> Hello Zhou,
>
>> >Hello Atsushi Kumagai,
>> >
>> >I test this patch set in several machines and the following is the benchmark.
> Thanks for your report, it looks good as before.
> I also did simple test on kernel 3.19 on a 5GB Virtual Machine,
> but I can't get such good result as below:
>
> / # time makedumpfile -c --num-threads 0 /proc/vmcore /mnt/dumpfile
> Copying data                       : [100.0 %] /
>
> The dumpfile is saved to /mnt/dumpfile.
>
> makedumpfile Completed.
> real    0m 44.40s
> user    0m 43.62s
> sys     0m 0.69s
> / #
>
> / # time makedumpfile -c --num-threads 4 /proc/vmcore /mnt/dumpfile
> Copying data                       : [100.0 %] -
> Copying data                       : [100.0 %] /
>
> The dumpfile is saved to /mnt/dumpfile.
>
> makedumpfile Completed.
> real    5m 29.54s
> user    6m 8.18s
> sys     16m 33.25s
> / #
>
>
> There is a big performance degradation.
> Do you have any ideas why this happens ?

Does your Virtual Machine have more than 2 processors?
If so, check the value:nr_cpus in KDUMP_COMMANDLINE_APPEND of /etc/sysconfig/kdump.
It should be also set to the number larger than 2.

To "--num-threads 4", the most suitable number of processors is 5.

-- 
Thanks
Zhou Wenjian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
