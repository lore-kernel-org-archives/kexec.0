Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X050e-0004LL-6K
 for kexec@lists.infradead.org; Thu, 26 Jun 2014 08:26:21 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] Makedumpfile: vmcore size estimate
Date: Thu, 26 Jun 2014 08:21:58 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9723992E@BPXM01GP.gisp.nec.co.jp>
References: <1402490345-18656-1-git-send-email-bhe@redhat.com>
 <20140611135701.GA1592@dhcp-17-102.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9722440E@BPXM01GP.gisp.nec.co.jp>
 <20140623125723.GB29112@redhat.com>
In-Reply-To: <20140623125723.GB29112@redhat.com>
Content-Language: ja-JP
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "vgoyal@redhat.com" <vgoyal@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>

>On Fri, Jun 20, 2014 at 01:07:52AM +0000, Atsushi Kumagai wrote:
>> Hello Baoquan,
>>
>> >Forget to mention only x86-64 is processed in this patch.
>> >
>> >On 06/11/14 at 08:39pm, Baoquan He wrote:
>> >> User want to get a rough estimate of vmcore size, then they can decide
>> >> how much storage space is reserved for vmcore dumping. This can help them
>> >> to deploy their machines better, possibly hundreds of machines.
>>
>> You suggested this feature before, but I don't still agree with this.
>>
>> No one can guarantee that the vmcore size will be below the estimated
>> size every time. However, if makedumpfile provides "--vmcore-estimate",
>> some users may trust it completely and disk overflow might happen.
>> Ideally, users should prepare the disk which can store the possible
>> maximum size of vmcore. Of course they can reduce the disk size on their
>> responsibility, but makedumpfile can't help it as official feature.
>
>Hi Atsushi,
>
>Recently quite a few people have asked us for this feature. They manage
>lots of system and have attached local disk or partition for saving
>dump. Now say a system has few Tera bytes of memory and dedicating one
>partition of size of few tera bytes per machine just for saving dump might
>not be very practical.
>
>I was given the example that AIX supports this kind of estimates too and
>in fact looks like they leave a message if they find that current dump
>partition size will not be sufficient to save dump.
>
>I think it is a good idea to try to solve this problem. We might not be
>accurate but it will be better than user guessing that by how much to
>reduce the partition size.
>
>I am wondering what are the technical concerns. IIUC, biggest problem is that
>number of pages dumped will vary as system continues to run. So
>immediately after boot number of pages to be dumped might be small but
>as more applications are launched, number of pages to be dumped will
>incresae, most likely.

Yes, the actual dump size will be different from the estimated size, so 
this feature sounds incomplete and irresponsible to me.
The gap of size may be small in some cases especially when the dump level
is 31, but it will be variable basically, therefore I don't want to show
such an inaccurate value by makedumpfile.

>We can try to mitigate above problem by creating a new service which can
>run at configured interval and check the size of memory required for
>dump and size of dump partition configured. And user can either disable
>this service or configure it to run every hour or every day or every week
>or any interval they like to.

I think it's too much work, why do you want to check the required disk
size so frequently? To get the order of magnitude once will be enough to
prepare the disk for dump since we should include some space in the disk size
to absorb the fluctuation of the vmcore size. However, it depends on the
machine's work, makedumpfile can't provide the index for estimation which
can be applied to everyone.


Thanks
Atsushi Kumagai

>So as long as we can come up with a tool which can guess number of pages
>to be dumped fairly accurately, we should have a reasonably good system.
>It will atleast be much better than user guessing the size of dump parition.
>
>Thanks
>Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
