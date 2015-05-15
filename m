Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YtKAO-0002ds-R9
 for kexec@lists.infradead.org; Fri, 15 May 2015 18:17:01 +0000
Message-ID: <55563803.8080202@redhat.com>
Date: Fri, 15 May 2015 23:46:35 +0530
From: Pratyush Anand <panand@redhat.com>
MIME-Version: 1.0
Subject: Re: makedumpfile: Issue with aarch64 support
References: <55555117.4080708@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DB45FE@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701DB45FE@BPXM01GP.gisp.nec.co.jp>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>



On Friday 15 May 2015 12:30 PM, Atsushi Kumagai wrote:
>>   But, crash does not like the vmcore
>> >  # crash/lib/modules/.../build/vmlinux vmcore -d 31
>> >
>> ><readmem: fffffe01ffde2000, KVADDR, "memory section", 32, (FOE),
>> >a2c4eb0>
>> ><read_diskdump: addr: fffffe01ffde2000 paddr: 41fffe2000 cnt: 32>
>> >read_diskdump: SEEK_ERROR: paddr/pfn: 41fffe2000/41fffe max_mapnr:
>> >414000
> According to this message, it seems that the max_mapnr in disk_dump_header
> was calculated wrongly by makedumpfile. pfn:41fffe must be exist since
> crash requires it, so max_mapnr must be shortened.
> What is the actual maximum pfn of the original vmcore ? If the number is
> correct, I have no ideas for now...


Thanks a lot for the pointer. I was able to find error in my aarch64 
code after following your pointer.

Will send the patch for review.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
